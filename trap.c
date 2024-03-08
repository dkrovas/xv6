#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "traps.h"
#include "spinlock.h"
#define PAGE_SIZE 0x1000

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
    if(p->pgdir==0) {
      cprintf("Invalid page directory\n");
      kill(p->pid);
      break;
    }
    int success = 0;
    for(int i = 0; i < 16; ++i) {

      // between start and end request instead of just rcr2


      if (p->addr[i].va == rcr2()) {
        success = 1;
        // do kalloc
        char* mem;
        int temp_length = p->addr[i].size;
        int j = 0;



        // Allocate one page only at a time. use prounddown(rcr2)


        while(temp_length > 0){
          mem = kalloc();
          if(mem == 0){
            cprintf("kalloc failed\n");
            kill(p->pid);
            break;
          }
          //cprintf("map:\n");
          //cprintf("p->pgdir: %d\nva: %d\nPAGE_SIZE: %d\nmem: %p\n", p->pgdir, (void*)(p->addr[p->size_addr-1].va), PAGE_SIZE, mem);
          if(temp_length >= 4096){
            mappages(p->pgdir, (void*)(p->addr[i].va + j * PAGE_SIZE), PAGE_SIZE, V2P(mem), PTE_W | PTE_U);
          }
          else{
            mappages(p->pgdir, (void*)(p->addr[i].va + j * PAGE_SIZE), temp_length, V2P(mem), PTE_W | PTE_U);
          }
          
          //cprintf("completed mappages for %x\n", p->addr[i].va + j* PAGE_SIZE);
          temp_length -= PAGE_SIZE;
          j++;
        }
        cprintf("j = %d\ti = %d\n",j, i);
        p->addr[i].phys_page_used[i] = j;
        //cprintf("exited while\n");
        break;
      }
    }
    //cprintf("exited for\n");
    if (!success) {
      cprintf("Segmentation Fault\n");
      kill(p->pid);
    }
    //cprintf("got to break\n");
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
