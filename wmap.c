#include "types.h"
#include "wmap.h"
#include "defs.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "param.h"
#include "proc.h"


uint sys_wmap(void) {
  uint addr;
  int length;
  int flags;
  int fd;
  if(argint(0, (int*)&addr) < 0 || argint(1, &length) < 0 || argint(2, &flags) < 0 || argint(3, &fd) < 0) {
   return -1;
  }
  if (length <= 0) {
    cprintf("Length less or equal to 0\n");
    return -1;
  }
  struct proc* p = myproc();
  if (p->memory_used + length > 0x20000000) {
    cprintf("Not enough memory\n");
    return -1;
  }
  if (addr < 0x60000000 || addr + length - 1 >= 0x80000000){
    cprintf("Wrong address");
    return -1;
  }
  if (flags & MAP_FIXED) {
    for(int i = 0; i < 16; ++i) {
      if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size > addr + length)) {
        cprintf("Address suggested already in memory\n");
        return -1;
      }
    }
  } else {
    int valid = 0;
    while (!valid) {
      for(int i = 0; i < 16; ++i) {
        if(p->addr[i].va == 0) {
          continue;
        }
        if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size > addr + length)) { //checks if boundaries of mem being asked are in any of vas of maps already made
          cprintf("\t-In if addr = 0x%x, checking against addr[%d], interval 0x%x, 0x%x\n", addr, i, p->addr[i].va, p->addr[i].va + p->addr[i].size);
          if (p->addr[i].va + p->addr[i].size == 0x80000000) {
            addr = 0x60000000;
          } else {
            addr = p->addr[i].va + p->addr[i].size;
            if (addr + length > 0x80000000) {
              addr = 0x60000000;
            }
          }
          
          cprintf("\t-New addr after if against addr[%d] is 0x%x\n", i, addr);
          break;
        }
        if (i == 15) {
          valid = 1;
        }
      }
    }
    cprintf("\t-Done. Final addr 0x%x\n", addr);
  }

  //cprintf("pid in wmap: %d\n",p->pid);
  for(int i=0; i<16; ++i){
    if(p->addr[i].va==0) {
      p->addr[i].va = addr;
      p->memory_used += length;
      p->addr[i].size = length;
      p->addr[i].flags = flags;
      p->addr[i].fd = fd;
      break;
    }
  }
  p->n_mmaps += 1;
  // for(int i = 0; i < p->size_addr; ++i) {
  //   cprintf("addr[0]\nva = 0x%x\nlength = %d\nflags = %d\nfd = %d\n", p->addr[i].va, p->addr[i].size, p->addr[i].flags, p->addr[i].fd);
  // }
 // struct address* head = myproc()->head;
  return addr;
}

int sys_wunmap(void) {
  uint addr;
  if (argint(0, (int*)&addr) < 0) {
   return -1;
  }
  struct proc* p = myproc();
  pte_t *pte;
  for(int i = 0; i < 16; ++i) {
    if (p->addr[i].va == addr && p->addr[i].phys_page_used[i]>0) {
      int size = p->addr[i].size;
      int j = 0;
      while(size > 0){
        pte = walkpgdir(p->pgdir, (void*)addr + j*PAGE_SIZE, 0);
        int physical_address = PTE_ADDR(*pte);
        //cprintf("pte = %x", *pte);
        kfree(P2V(physical_address));
        size-=PAGE_SIZE;
        ++j;
      }
      p->addr[i].va = 0;
      p->addr[i].flags = 0;
      p->addr[i].fd = 0;
      p->memory_used -= p->addr[i].size;
      p->addr[i].size = 0;
      break;
    }
  }
  pte = 0;
  // flush TLB
  switchuvm(p);
    for(int i = 0; i < 16; ++i) {
      if (p->addr[i].va == addr) {

        p->addr[i].va = 0;
        p->addr[i].flags = 0;
        p->addr[i].fd = 0;
        p->memory_used -= p->addr[i].size;
        p->addr[i].size = 0;
      }
    }
  return 0;
}

uint sys_wremap(void) {
  uint oldaddr;
  int oldsize;
  int newsize;
  int flags;
  if(argint(0, (int*)&oldaddr) < 0 || argint(1, &oldsize) < 0 || argint(2, &newsize) < 0 || argint(3, &flags) < 0) {
    return -1;
  }
  struct proc *p = myproc();
  int i;
  for(i = 0; i < 16; ++i){
    if(p->addr[i].va == oldaddr && p->addr[i].size == oldsize){
      break;
    }
  }
  if (i == 16) {
    cprintf("Address given is not mapped by wmap\n");
    return -1;
  }
  int valid = 0;
  for (int j = 0; j < 16; ++j) {
    if (p->addr[j].va < oldaddr + newsize && p->addr[j].va + p->addr[j].size > oldaddr + newsize) {
      continue;
    }
    valid = 1;
  }
  if (oldaddr + newsize > 0x80000000) {
    valid = 0;
  }
  if (valid == 1) {
    cprintf("\t-Valid for in place\n");
  } else if ((valid == 0) && !(flags & MREMAP_MAYMOVE)) {
    cprintf("\t-Cannot remap in place and flag specified no move. No remap\n");
  } else {
    cprintf("\t-Valid for moving\n");
    //remap by changing initial address
  }
  
  return 0;
}

int sys_getpgdirinfo(void) {
struct pgdirinfo* pdinfo;
if (argptr(0, (void*)&pdinfo, sizeof(struct pgdirinfo)) < 0) {
   return -1;
}

  return 0;
}

int sys_getwmapinfo(void) {
  struct wmapinfo* wminfo;
  if (argptr(0, (void*)&wminfo, sizeof(struct wmapinfo)) < 0) {
   return -1;
  }
  struct proc *p = myproc();
  if(wminfo == 0 || p == 0){
    return -1;
  }
  wminfo->total_mmaps =p->n_mmaps;
  for(int i = 0; i < MAX_WMMAP_INFO; ++i){
    wminfo->addr[i] = p->addr[i].va;
    wminfo->length[i] = p->addr[i].size;
    wminfo->n_loaded_pages[i] = p->addr[i].phys_page_used[i];
    // cprintf("loaded pages[%d]: %d\n",i, p->addr[i].phys_page_used[i]);
  }
  return 0;
}