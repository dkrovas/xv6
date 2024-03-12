#include "types.h"
#include "wmap.h"
#include "defs.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "param.h"
#include "proc.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"

uint wmap(uint addr, int length, int flags, int fd)
{
  if (length <= 0)
  {
    cprintf("Length less or equal to 0\n");
    return -1;
  }
  struct proc *p = myproc();
  // cprintf("proc parent: %d\n", p->parent->pid);
  // cprintf("curr proc id: %d\n", p->pid);
  // cprintf("addr requested: %x\n", addr);
  if (p->memory_used + length > 0x20000000)
  {
    cprintf("Not enough memory\n");
    return -1;
  }
  if (addr < 0x60000000 || addr + length - 1 >= 0x80000000)
  {
    cprintf("Wrong address");
    return -1;
  }
  if (flags & MAP_FIXED)
  {
    for (int i = 0; i < 16; ++i)
    {
      if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size > addr + length))
      {
        cprintf("Address suggested already in memory\n");
        return -1;
      }
    }
  }
  else
  {
    addr = 0x60000000;
    int valid = 0;
    int num_va = 0;
    for (int k = 0; k < 16; ++k)
    {
      if (p->addr[k].va != 0)
      {
        ++num_va;
      }
    }
    int count = 0;
    while (!valid)
    {
      // cprintf("here p->addr[0] = %x\n", p->addr[0].va);
      int i;
      for (i = 0; i < 16; ++i)
      {
        if (p->addr[i].va == 0)
        {
          continue;
        }
        if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size >= addr + length) || ((addr < p->addr[i].va) && ((addr + length) > p->addr[i].va)))
        { 
          if (p->addr[i].va + p->addr[i].size == 0x80000000)
          {
            addr = 0x60000000;
          }
          else
          {
            addr = PGROUNDUP(p->addr[i].va + p->addr[i].size);
            if (addr + length > 0x80000000)
            {
              addr = 0x60000000;
            }
          }

          cprintf("\t-New addr after if against addr[%d] is 0x%x\n", i, addr);
          break;
        }
      }
      ++count;
      if (i == 16)
      {
        valid = 1;
      }
      else if (count > num_va)
      {
        cprintf("Not enough contiguous memory\n");
        return -1;
      }
    }
    // cprintf("\t-Done. Final addr 0x%x\n", addr);
  }

  // cprintf("pid in wmap: %d\n",p->pid);
  for (int i = 0; i < 16; ++i)
  {

    if (p->addr[i].va == 0)
    {
      // cprintf("\t\t\tadding addr %x to index %d of maps:\n", addr, i);
      p->addr[i].va = addr;
      cprintf("length = %x\n", length);
      p->memory_used += length;
      p->addr[i].size = length;
      p->addr[i].flags = flags;
      p->addr[i].fd = fd;
      // p->addr[i].access += 1;
      break;
    }
  }
  p->n_mmaps += 1;
  // for(int i = 0; i < p->size_addr; ++i) {
  //   cprintf("addr[0]\nva = 0x%x\nlength = %d\nflags = %d\nfd = %d\n", p->addr[i].va, p->addr[i].size, p->addr[i].flags, p->addr[i].fd);
  // }
  // struct address* head = myproc()->head;
  // cprintf("adding addr %x to index of maps:\n", addr);
  return addr;
}

int wunmap(uint addr)
{

  struct proc *p = myproc();
  pte_t *pte;
  int boo = 0;
  for (int i = 0; i < 16; ++i) {
    // PTE_P present bit && *pte to check if valid and then kfree and 0 it
    cprintf("p->addr[i].va = %x && p->addr[i].phys_page_used = %d expected > 0\n", p->addr[i].va, p->addr[i].phys_page_used);
    if (p->addr[i].va == addr && p->addr[i].phys_page_used > 0) {
      cprintf("p->addr[i].flags & MAP_SHARED = %d && p->addr[i].flags & MAP_ANONYNOUS = %d\n", p->addr[i].flags & MAP_SHARED, !(p->addr[i].flags & MAP_ANONYMOUS));
      if (p->addr[i].flags & MAP_SHARED && !(p->addr[i].flags & MAP_ANONYMOUS)) {
        cprintf("attempting umap1:\n\n");
        struct file *f = p->ofile[p->addr[i].fd];
        f->off = 0;
        //cprintf("attempting umap2:\n\n");
        int offset = 0;
        cprintf("size = %x\n", p->addr[i].size);
        while(offset < p->addr[i].size){
          cprintf("writing address: %x\n", p->addr[i].va + offset);
          if (f->type == FD_INODE) {
            begin_op();
            ilock(f->ip);
            writei(f->ip, (void *)p->addr[i].va+offset, f->off+offset, PAGE_SIZE);
            iunlock(f->ip);
            end_op();
          }
          offset += PAGE_SIZE;
          if(offset > p->addr[i].size){
            break;
          }
        }     
        if (p->parent->pid == 2) {
          // unmap and write from mmap to file
          int size = p->addr[i].size;
          int j = 0;
          while (size > 0) {
            pte = walkpgdir(p->pgdir, (void *)addr + j * PAGE_SIZE, 0);
            int physical_address = PTE_ADDR(*pte);
            size -= PAGE_SIZE;
            ++j;
            if (PTE_P & *pte) {
              kfree(P2V(physical_address));
              *pte = 0;
            }
          }
          p->addr[i].va = 0;
          p->addr[i].flags = 0;
          p->addr[i].fd = 0;
          p->memory_used -= p->addr[i].size;
          p->addr[i].size = 0;
          p->addr[i].phys_page_used = 0;
          boo = 1;
          cprintf("reached unmap\n");
          break;
        }
        // Don't kfree() pages
        else {
          cprintf("reached child unmap\n");
          break;
        }
      }
      else if(p->addr[i].flags & MAP_SHARED && (p->addr[i].flags & MAP_ANONYMOUS)) {
          if (p->parent->pid == 2) {
          // unmap and write from mmap to file
          int size = p->addr[i].size;
          int j = 0;
          while (size > 0) {
            pte = walkpgdir(p->pgdir, (void *)addr + j * PAGE_SIZE, 0);
            int physical_address = PTE_ADDR(*pte);
            size -= PAGE_SIZE;
            ++j;
            if (PTE_P & *pte) {
              kfree(P2V(physical_address));
              *pte = 0;
            }
          }
          p->addr[i].va = 0;
          p->addr[i].flags = 0;
          p->addr[i].fd = 0;
          p->memory_used -= p->addr[i].size;
          p->addr[i].size = 0;
          p->addr[i].phys_page_used = 0;
          boo = 1;
          //cprintf("reached unmap\n");
          break;
        }
        // Don't kfree() pages
        else {
          //cprintf("reached child unmap\n");
          break;
        }
      }
      else {
        // unmap normal
        int size = p->addr[i].size;
        int j = 0;
        while (size > 0)
        {
          pte = walkpgdir(p->pgdir, (void *)addr + j * PAGE_SIZE, 0);
          int physical_address = PTE_ADDR(*pte);
          size -= PAGE_SIZE;
          ++j;
          if (PTE_P & *pte)
          {
            kfree(P2V(physical_address));
            *pte = 0;
          }
        }
        p->addr[i].va = 0;
        p->addr[i].flags = 0;
        p->addr[i].fd = 0;
        p->memory_used -= p->addr[i].size;
        p->addr[i].size = 0;
        p->addr[i].phys_page_used = 0;
        boo = 1;
        break;
      }
    }
  }
  // flush TLB
  // switchuvm(p);

  if (!boo)
  {
    for (int i = 0; i < 16; ++i)
    {
      if (p->addr[i].va == addr)
      {
        p->addr[i].va = 0;
        p->addr[i].flags = 0;
        p->addr[i].fd = 0;
        p->memory_used -= p->addr[i].size;
        p->addr[i].size = 0;
        p->addr[i].phys_page_used = 0;
      }
    }
  }
  p->n_mmaps -= 1;
  return 0;
}

uint wremap(uint oldaddr, int oldsize, int newsize, int flags)
{
  if (newsize % 4096 != 0) {
    newsize = (newsize / 4096) * 4096 + 4096;
  }
  struct proc *p = myproc();
  int i;
  for (i = 0; i < 16; ++i)
  { // finds where in addr is the address given as argument
    // cprintf("--------va %x, size %d, oldaddr %x, oldsize %d\n", p->addr[i].va, p->addr[i].size, oldaddr, oldsize);
    if (p->addr[i].va == oldaddr && p->addr[i].size == oldsize)
    {
      break;
    }
  }
  int location_array = i;
  if (i == 16)
  { // returns if not found
    cprintf("Address given is not mapped by wmap\n");
    return -1;
  }
  int valid = 1;
  for (int j = 0; j < 16; ++j)
  {
    if (p->addr[j].va == 0)
    {
      continue;
    }
    // cprintf("\t-%x <= %x < %x\n", p->addr[j].va, oldaddr + newsize, p->addr[j].va + p->addr[j].size);
    if ((p->addr[j].va > oldaddr) && (p->addr[j].va < oldaddr + newsize))
    {
      // cprintf("\t-Address %x between %x and %x, making valid 0\n", oldaddr + newsize, p->addr[j].va, p->addr[j].va + p->addr[j].size);
      valid = 0;
      break;
    }
  } // checks if the request can be done in place
  if (oldaddr + newsize > 0x80000000)
  {
    valid = 0;
  }
  // cprintf("\t-flag is %d\n", flags);
  if (valid == 1)
  {
    // cprintf("\t-Valid for in place\n");
    if (newsize < oldsize)
    {                                   // shrinking
      uint address = oldaddr + newsize; // 6000 + 100 addr = 6100
      while (address < oldaddr + oldsize)
      {
        // take address out of page table and free it. Check if is in page table in the first place
        pte_t *pte = walkpgdir(p->pgdir, (void *)address, 0); // CHECK THIS!!!!!!!!!!
        int physical_address = PTE_ADDR(*pte);
        if (PTE_P & *pte)
        {
          kfree(P2V(physical_address));
          *pte = 0;
          switchuvm(p);
        }
        address += PAGE_SIZE;
      }
      p->addr[i].size = newsize;
      p->memory_used -= oldsize - newsize;
      // cprintf("va %x, size %d\n", p->addr[i].va, p->addr[i].size);
      //  flush TLB
      // switchuvm(p);
      return oldaddr;
    }
    else if (oldsize < newsize)
    {
      p->addr[i].size = newsize;
      p->memory_used += newsize - oldsize;
      return oldaddr;
      // cprintf("va %x, size %d\n", p->addr[i].va, p->addr[i].size);
    }
  }
  else if (!(flags & MREMAP_MAYMOVE))
  {
    cprintf("\t-Cannot remap in place and flag specified no move. No remap\n");
    return -1;
  }
  else
  { // VALID FOR MOVING
    // cprintf("\t-Valid for moving\n");
    if (newsize < oldsize)
    {
      uint address = oldaddr + newsize;
      while (address < oldaddr + oldsize)
      {
        // take address out of page table and free it. Check if is in page table in the first place
        pte_t *pte = walkpgdir(p->pgdir, (void *)address, 0); // CHECK THISSSSSS
        int physical_address = PTE_ADDR(*pte);
        if (PTE_P & *pte)
        {
          kfree(P2V(physical_address));
          *pte = 0;
          switchuvm(p);
        }
        address += PAGE_SIZE;
      }

      p->addr[i].size = newsize;
      // flush TLB
      // switchuvm(p);
      p->memory_used -= oldsize - newsize;
      return oldaddr;
    }
    else if (oldsize < newsize)
    {
      // find first free contiguous block in address space
      int addr = oldaddr;
      int valid = 0;
      int num_va = 0;
      for (int k = 0; k < 16; ++k)
      {
        if (p->addr[i].va != 0)
        {
          ++num_va;
        }
      }
      int count = 0;
      while (!valid)
      {
        int i;
        for (i = 0; i < 16; ++i)
        {
          if (p->addr[i].va == 0)
          {
            continue;
          }
          if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + newsize && p->addr[i].va + p->addr[i].size >= addr + newsize))
          { // checks if boundaries of mem being asked are in any of vas of maps already made
            // cprintf("\t-In if addr = 0x%x, checking against addr[%d], interval 0x%x, 0x%x\n", addr, i, p->addr[i].va, p->addr[i].va + p->addr[i].size);
            if (p->addr[i].va + p->addr[i].size == 0x80000000)
            {
              addr = 0x60000000;
            }
            else
            {
              addr = p->addr[i].va + p->addr[i].size;
              if (addr + newsize > 0x80000000)
              {
                addr = 0x60000000;
              }
            }
            // cprintf("\t-New addr after if against addr[%d] is 0x%x\n", i, addr);
            break;
          }
        }
        ++count;
        if (i == 16)
        {
          valid = 1;
        }
        else if (count > num_va)
        {
          cprintf("Not enough contiguous memory\n");
          return -1;
        }
      }
      // cprintf("\t-Done. Final addr 0x%x\n", addr);//FOUND THE NEW ADDRESS
      count = 0;
      while (count < oldsize / 4096)
      { // CHECK THISSSSSSSSSSSS
        pte_t *pte = walkpgdir(p->pgdir, (void *)oldaddr + (count * PAGE_SIZE), 0);
        if (PTE_P & *pte)
        {
          int physical_address = PTE_ADDR(*pte);
          *pte = 0;
          mappages(p->pgdir, (void *)(addr + count * 4096), 4096, physical_address, PTE_W | PTE_U);
        }
        ++count;
      }
      p->addr[location_array].va = addr;
      p->addr[location_array].size = newsize;
      p->memory_used += newsize - oldsize;
      return addr;
      // cprintf("va %x, size %d\n", p->addr[location_array].va, p->addr[location_array].size);
    }
  }
  // cprintf("ADDR---\n\n");
  for (int g = 0; g < 16; ++g)
  {
    // cprintf("va %x, size %d\n", p->addr[g].va, p->addr[g].size);
  }
  cprintf("Shouldn't be here\n");
  return -1;
}

int sys_getpgdirinfo(void)
{
  struct pgdirinfo *pdinfo;
  if (argptr(0, (void *)&pdinfo, sizeof(struct pgdirinfo)) < 0)
  {
    return -1;
  }
  pdinfo->n_upages = 0;
  struct proc *p = myproc();
  for (int i = 0; i < NPDENTRIES; ++i)
  {
    uint va;
    uint pa;
    pde_t *dirent = &(p->pgdir[i]);
    if (!((*dirent) & PTE_P))
    {
      continue;
    }

    pte_t *pageTable = P2V(PTE_ADDR(*dirent));
    for (int j = 0; j < NPTENTRIES; ++j)
    {
      va = PGADDR(i, j, 0);
      pde_t *pte = &pageTable[j];
      // cprintf("pa = %x\n", pa);
      if ((*pte & PTE_P) && (*pte & PTE_U))
      {
        pa = (uint)(PTE_ADDR(*pte));
        if (pdinfo->n_upages < 32)
        {
          pdinfo->va[pdinfo->n_upages] = va;
          pdinfo->pa[pdinfo->n_upages] = pa;
          pdinfo->n_upages++;
        }
      }
    }
  }
  return 0;
}
int sys_getwmapinfo(void)
{
  struct wmapinfo *wminfo;
  if (argptr(0, (void *)&wminfo, sizeof(struct wmapinfo)) < 0)
  {
    return -1;
  }
  struct proc *p = myproc();
  if (wminfo == 0 || p == 0)
  {
    return -1;
  }
  wminfo->total_mmaps = p->n_mmaps;
  for (int i = 0; i < MAX_WMMAP_INFO; ++i)
  {
    wminfo->addr[i] = p->addr[i].va;
    wminfo->length[i] = p->addr[i].size;
    wminfo->n_loaded_pages[i] = p->addr[i].phys_page_used;
    // cprintf("loaded pages[%d]: %d\n",i, p->addr[i].phys_page_used[i]);
  }
  return 0;
}
