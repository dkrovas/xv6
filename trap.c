#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "traps.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"
#define PAGE_SIZE 0x1000
#define MAP_ANONYMOUS 0x0004

// Interrupt descriptor table (shared by all CPUs).
struct gatedesc idt[256];
extern uint vectors[];  // in vectors.S: array of 256 entry pointers
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
}

void
idtinit(void)
{
  lidt(idt, sizeof(idt));
}

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
      wakeup(&ticks);
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
    break;
  case T_PGFLT: // T_PGFLT = 14
    struct proc* p = myproc();
    // cprintf("addr %x, pid %d\t", rcr2(), p->pid, p->killed);
    if(p->pgdir==0) {
      cprintf("Invalid page directory\n");
      kill(p->pid);
      break;
    }
    //cprintf("in trap\n");
    int success = 0;
    for(int i = 0; i < 16; ++i) {
      // between start and end request 
      if (rcr2()>=p->addr[i].va && rcr2() < p->addr[i].va+p->addr[i].size) {
        //cprintf("\t\t\tindex: %d addr: %x \n", i, rcr2());
        // cprintf("in if\n");
        // // Case 1: anonymous:
        //if(p->addr[i].flags & MAP_ANONYMOUS){
        success = 1;
        // do kalloc
        char* mem;
        int temp_length;
        temp_length = PGROUNDDOWN(rcr2());
        // Allocate one page only at a time. use prounddown(rcr2)
        mem = kalloc();
        if(mem == 0){
          cprintf("kalloc failed\n");
          kill(p->pid);
          break;
        }
        mappages(p->pgdir, (void*)temp_length, PAGE_SIZE, V2P(mem), PTE_W | PTE_U);
        p->addr[i].phys_page_used += 1;
        memset(mem, 0, PGSIZE);
        if(p->addr[i].flags & MAP_ANONYMOUS){
          break;
        }
        else if(p->addr[i].fd){
          struct file *f = p->ofile[p->addr[i].fd];
          f->off = temp_length - p->addr[i].va;
          //fileread(of, (void*)temp_length, PAGE_SIZE);
            if(f->type == FD_INODE){
              int r;
              ilock(f->ip);
              if((r = readi(f->ip, (void*)temp_length, f->off, PAGE_SIZE)) > 0)
              iunlock(f->ip);
            }
            break;
        }      
      }
    }
    if (!success) {
      cprintf("addr %x, pid %d, killed: %d\n", rcr2(), p->pid, p->killed);
      cprintf("Segmentation Fault\n");
      kill(p->pid);
    }
    break;


  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
  }


  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
