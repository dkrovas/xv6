#include "types.h"
#include "wmap.h"
#include "user.h"
#include "fcntl.h"

void test_mult_map_diff_touches () {
  printf(1, "Testing mult_map_diff_touches\n");
  printf(1, "\t-wmapping 0\n");
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  char* ptr0 = (char*)map0;
  printf(1, "\t-touching 0\n");
  ptr0[0] = 'a';
  printf(1, "\t-wmapping 1\n");
  uint map1 = wmap(0x60003000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  printf(1, "\t-wmapping 2\n");
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  map2 = map2;
  char* ptr1 = (char*)map1;
    printf(1, "\t-touching 1\n");
  ptr1[0] = 'b';
  printf(1, "\t-map0 %c map1 %c\n", ptr0[0], ptr1[0]);
  
  printf(1, "\nRESULT: ");

  if (ptr0[0] == 'a' && ptr1[0] == 'b') {
    printf(1, "PASSED");
  } else {
    printf(1, "FAILED");
  }
 

  wunmap(map0);
  wunmap(map1);
  wunmap(map2);
  printf(1, "\n\n");
  return;
}

void test_out_of_va(void) {
  printf(1, "Testing test_out_of_va\n");
  printf(1, "\t-wmapping 0 to max size\n");
  uint map0 = wmap(0x60000000, 0x20000000, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  map0 = map0;
  printf(1, "\t-wmapping 1, so we get error message\n");
  uint map1 = wmap(0x60001000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  map1 = map1;
  
  printf(1, "\nCheck if got error message above\n");
}

void test_map_fixed(void) {
  printf(1, "Testing test_map_fixed\n");
  printf(1, "\t-testing basic functionality\n");
  printf(1, "\t-wmapping 0 as fixed\n");
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  map0 = map0;
  printf(1, "\t-wmapping 1 as not fixed, trying to get other addr\n");
  uint map1 = wmap(0x60000000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
  map1 = map1;
  printf(1, "\nShould be 0x60002000\n\n");

  printf(1, "\t-testing if doesn't break with endpoints\n");
  wunmap(map0);
  printf(1, "\t-wmapping 0 as not fixed, trying to get other addr\n");
  map0 = wmap(0x60000000, 4096 * 3, MAP_SHARED | MAP_ANONYMOUS, -1);
  printf(1, "\nShould be 0x60004000\n\n");

  printf(1, "\t-testing if doesn't break if exceding 0x80000000\n");
  wunmap(map0);
  wunmap(map1);

  printf(1, "\t-wmapping 0 as fixed at 0x7fffe000\n");
  map0 = wmap(0x7fffe000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  printf(1, "\t-wmapping 1 with 8192, needing to loop\n");
  map1 = wmap(0x7fffe000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);

  printf(1, "\nShould be 0x60000000\n\n");

  wunmap(map0);
  wunmap(map1);

  printf(1, "\t-big wmapping aloc\n");
  map0 = wmap(0x60000000, 0x20000000 - 4 * 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  printf(1, "\t-allocing one page, leaving one page in the middle\n");
  map1 = wmap(0x80000000 - 3 * 4096, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  printf(1, "\t-allocing another page, leaving one in the middle\n");
  uint map2 = wmap(0x80000000 - 4096, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  map2 = map2;
  printf(1, "\t-trying to alloc contiguously 2 pages, but should fail\n");
  uint map3 = wmap(0x60000000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
  map3 = map3;

  printf(1, "\nShould have failed\n\n");
  printf(1, "\n\n");
  wunmap(map0);
  wunmap(map1);
  wunmap(map2);
  wunmap(map3);
  return;
}

void test_remap(void) {
  printf(1, "Testing test_remap\n");
  printf(1, "\t-testing if ifs are right\n");
  struct wmapinfo wminfo;
  uint map0 = wmap(0x60000000, 4096,  MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  map0 = map0;
  printf(1, "mapinfo 1:\n");
  if(getwmapinfo(&wminfo) < 0){
    printf(1, "\nRESULT: FAILED");
    return;
  }
  for(int i = 0; i < 16; ++i){
    if(wminfo.addr[i]!=0){
      printf(1, "\t-i=%d\n", i);
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
      printf(1, "\n");
    }
  }
  uint map2 = wmap(0x70000000, 4096,  MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  map2 = map2;
  if(getwmapinfo(&wminfo) < 0){
    printf(1, "\nRESULT: FAILED");
    return;
  }
  printf(1, "mapinfo 2:\n");
  for(int i = 0; i < 16; ++i){
    if(wminfo.addr[i]!=0){
      printf(1, "\t-i=%d\n", i);
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
      printf(1, "\n");
    }
  }
  map0 = wremap(map0, 4096, 8192, 0);
  printf(1, "Should be Valid for in place\n\n");
  printf(1, "mapinfo 3 after first remap:\n");
  if(getwmapinfo(&wminfo) < 0){
    printf(1, "\nRESULT: FAILED");
    return;
  }
  for(int i = 0; i < 16; ++i){
    if(wminfo.addr[i]!=0){
      printf(1, "\t-i=%d\n", i);
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
      printf(1, "\n");
    }
  }
  
  map0 = wremap(map0, 8192, 4096 * 3, MREMAP_MAYMOVE);
  printf(1, "Should be Valid for in place\n\n");
  printf(1, "mapinfo 4 after second remap:\n");
  if(getwmapinfo(&wminfo) < 0){
    printf(1, "\nRESULT: FAILED");
    return;
  }
  for(int i = 0; i < 16; ++i){
    if(wminfo.addr[i]!=0){
      printf(1, "\t-i=%d\n", i);
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
      printf(1, "\n");
    }
  }
  uint map1 = wmap(0x60003000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  map1=map1;
  uint map3 = wmap(0x70002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  map3 = map3;
  printf(1, "mapinfo 5 after two more maps:\n");
  if(getwmapinfo(&wminfo) < 0){
    printf(1, "\nRESULT: FAILED");
    return;
  }
  for(int i = 0; i < 16; ++i){
    if(wminfo.addr[i]!=0){
      printf(1, "\t-i=%d\n", i);
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
      printf(1, "\n");
    }
  }
  wremap(map0, 4096 * 3, 4096 * 4, 0);
  printf(1, "Should be Cannot\tmap0= %x\n\n",map0);
  printf(1, "mapinfo 6 after attempted remaps:\n");
  if(getwmapinfo(&wminfo) < 0){
    printf(1, "\nRESULT: FAILED");
    return;
  }
  for(int i = 0; i < 16; ++i){
    if(wminfo.addr[i]!=0){
      printf(1, "\t-i=%d\n", i);
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
      printf(1, "\n");
    }
  }
  map0 = wremap(map0, 4096 * 3, 4096 * 4, MREMAP_MAYMOVE);
  printf(1, "map0 = %x\n",map0);
  printf(1, "Should be valid for moving\n\n");
  printf(1, "mapinfo 7 after attempted remaps:\n");
  if(getwmapinfo(&wminfo) < 0){
    printf(1, "\nRESULT: FAILED");
    return;
  }
  for(int i = 0; i < 16; ++i){
    if(wminfo.addr[i]!=0){
      printf(1, "\t-i=%d\n", i);
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
      printf(1, "\n");
    }
  }
  map0 = wremap(map0, 4096 * 4, 4096 * 3, 0);
  printf(1, "map0 = %x\n",map0);
  printf(1, "\t-just remapped removing memory\n");
  printf(1, "mapinfo 8 after attempted shrinking remap:\n");
  if(getwmapinfo(&wminfo) < 0){
    printf(1, "\nRESULT: FAILED");
    return;
  }
  for(int i = 0; i < 16; ++i){
    if(wminfo.addr[i]!=0){
      printf(1, "\t-i=%d\n", i);
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
      printf(1, "\n");
    }
  }
  printf(1, "\t-unmapping 0: %x\n", map0);
  wunmap(map0);
  printf(1, "\t-unmapped 0\n");
  printf(1, "\t-unmapping 1: %x\n", map1);
  wunmap(map1);
  printf(1, "\t-unmapped 1\n");
  printf(1, "\t-unmapping 2: %x\n", map2);
  wunmap(map2);
  printf(1, "\t-unmapped 2\n");
  printf(1, "\t-unmapping 3: %x\n", map3);
  wunmap(map3);
  printf(1, "\t-unmapped 3\n");
  printf(1, "\t-testing if it is actually working\n");
  if(getwmapinfo(&wminfo) < 0){
    printf(1, "\nRESULT: FAILED");
    return;
  }
  for(int i = 0; i < 16; ++i){
    if(wminfo.addr[i]!=0){
      printf(1, "\t-i=%d\n", i);
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
      printf(1, "\n");
    }

  }
  //map0 = wmap(0x60000000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  return;
}
void test_fork(void) {
  printf(1, "Testing fork:\n");
  int pid = 0;
  printf(1, "\t-0x60000000 is shared\n");
  uint map0 = wmap(0x60000000, 4096, MAP_FIXED | MAP_SHARED, -1);
  *(int*)map0 = 1;
  uint map1 = wmap(0x60001000, 4096, MAP_FIXED | MAP_PRIVATE, -1);
  printf(1, "\t-0x60001000 is private\n");
  map1 = map1;
  *(int*)map1 = 2;
  pid = fork();
  if (pid == 0) { //child
    struct pgdirinfo pd;
    getpgdirinfo(&pd);
    for(int i = 0; i < 32; ++i) {
      //printf(1, "CHILD:: va[%d] 0x%x, pa 0x%x\n",i, pd.va[i], pd.pa[i]);
    }
    *(int*)map1 = 3;
    *(int*)map0 = 4;
    printf(1, "CHILD:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    int o = 0;
    for(int k = 0; k < 100000000; ++k) {
      k = k;
      ++o;
    }
    printf(1, "finished\n");
  } else { //parent
    struct pgdirinfo pd;
    getpgdirinfo(&pd);
    for(int i = 0; i < 32; ++i) {
      //printf(1, "PARENT:: va[%d] 0x%x, pa 0x%x\n",i, pd.va[i], pd.pa[i]);
    }
    *(int*)map1 = 5;
    *(int*)map0 = 6;
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);

    wait();
    printf(1, "LAST __ PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
  }
  return;
}
void test_pg() {
  printf(1, "\t-0x60000000 is shared\n");
  uint map0 = wmap(0x60000000, 4096, MAP_FIXED | MAP_SHARED, -1);
  *(char*)map0 = 'a';
  uint map1 = wmap(0x60001000, 4096, MAP_FIXED | MAP_PRIVATE, -1);
  printf(1, "\t-0x60001000 is private\n");
  map1 = map1;
  struct pgdirinfo pd;
    getpgdirinfo(&pd);
    // for(int i = 0; i < 32; ++i) {
    //   printf(1, "PARENT:: va[%d] 0x%x, pa 0x%x\n",i, pd.va[i], pd.pa[i]);
    // }
    exit();
}

// void test_2_page_map_unmap(void) 
// {
//   printf(1, "Testing Mapping and unmapping multipages:\n");
//   uint map = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);

//   if (map == 0) {
//     printf(1, "\t-Error mapping memory.\n");
//     printf(1, "\nRESULT: FAILED");
//     printf(1, "\n\n");
//     return;
//   }

//   char* ptr = (char*)map;  // Assuming it's a char array
//   for(int i=0;i<4096;i++){
//     ptr[i] = 'f';
//   }
   
//   printf(1, "\t-ptr = %c, map = %x mapped\n", ptr[0], map);
//   wunmap(map);
//   //printf(1, "unmap = %c\n", ptr[0]);
//   printf(1, "\nRESULT: PASSED");
//   printf(1, "\n\n");
//   return;
// }
// void test_wmapinfo(void){
//   printf(1, "Testing wmapinfo\n");
//   uint map = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
//   struct wmapinfo wminfo;
  
//   if(getwmapinfo(&wminfo) < 0){
//     printf(1, "\nRESULT: FAILED");
//     return;
//   }
//   printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[0]);
//   char* ptr0 = (char*)map;
//   ptr0[0] = 'a';
//   if(getwmapinfo(&wminfo) < 0){
//     printf(1, "\nRESULT: FAILED");
//     return;
//   }
//   printf(1, "\t-Total mmaps: %d\n", wminfo.total_mmaps);
//   for(int i = 0; i < 16; ++i){
//     if(wminfo.addr[i]!=0){
//       printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
//       printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
//       printf(1, "\t-map length: %x\n", wminfo.length[i]);
//       printf(1, "\n");
//     }

//   }
  
//   wunmap(map);
//   if(getwmapinfo(&wminfo) < 0){
//     printf(1, "\nRESULT: FAILED");
//     return;
//   }
//   printf(1, "\t-Total mmaps after unmap: %d\n", wminfo.total_mmaps);
//   for(int i = 0; i < 16; ++i){
//     if(wminfo.addr[i]!=0){
//       printf(1, "\t-Starting addr: %xn", wminfo.addr[i]);
//       printf(1, "\t-map length: %x\n", wminfo.length[i]);
//        printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
//        printf(1, "\n");
//     }
    
//   }
//   printf(1,"\n");
  
//   uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
//   char* ptr2 = (char*)map2;
//   uint map3 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
//   char* ptr3 = (char*)map3;
//   ptr2[0] = 'b';
//  // printf(1, "ptr2 ptr3\n");
//   for (int i = 0; i < 10; ++i){
//     ptr3[i] = 'a';
//    // printf(1, "ptr3[%d] = %c ", i, ptr3[i]);
//   }
//   if(getwmapinfo(&wminfo) < 0){
//     printf(1, "\nRESULT: FAILED");
//     return;
//   }
//   printf(1, "\t-Total mmaps after more maps: %d\n", wminfo.total_mmaps);
//   for(int i = 0; i < 16; ++i){
//     //printf(1, "wminfo.addr[%d] = %d\n", i, wminfo.addr[i]);
//     if(wminfo.addr[i]!=0){
//       printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
//       printf(1, "\t-map length: %x\n", wminfo.length[i]);
//       printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
//       printf(1, "\n");
//     }
    
//   }
//   wunmap(map2);
//   wunmap(map3);
 
//   if(getwmapinfo(&wminfo) < 0){
//     printf(1, "\nRESULT: FAILED");
//     return;
//   }
//   for(int i = 0; i < 16; ++i){
//     //printf(1, "wminfo.addr[%d] = %d\n", i, wminfo.addr[i]);
//     if(wminfo.addr[i]!=0){
//       printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
//       printf(1, "\t-map length: %x\n", wminfo.length[i]);
//       printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
//       printf(1, "\n");
//     }
    
//   }
//   printf(1, "\nRESULT: SUCCESS\n\n");
//   return;
// }

// void test_single_wremap(void){
//   uint map0 = wmap(0x60000000, 4096,  MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
//   //uint map = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
//   map0 = wremap(0x60000000, 4096, 4096 * 3, 0);
//   printf(1,"map0=%x\tshouldbe:0x60000000\n",map0);
//   uint map1 = wmap(0x60003000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
//   map1=map1;
//   wremap(map0, 4096 * 3, 4096 * 4, 0);
//   printf(1,"map0=%x\tshouldbe:0x60000000\n",map0);
//   map0 = wremap(map0, 4096 * 3, 4096 * 4, MREMAP_MAYMOVE);
//   printf(1,"map0=%x\tshouldbe:0x60004000\n",map0);
//   map0 = wremap(map0, 4096 * 4, 4096 * 3, 0);
//   printf(1,"map0=%x\tshouldbe:0x60004000\n",map0);
  
//   wunmap(map0);
//   wunmap(map1);
// }

// void test_single_remap_shrink() {
//   printf(1, "shrink\n");
//   uint map0 = wmap(0x60000000, 8192,  MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
//   *((char*)map0) = 'a';
//   uint addr = map0 + 4096;
//   *((char*)addr) = 'b';
//   map0 = wremap(map0, 8192, 4096, 0);
//   printf(1, "map0 = %x\n", map0);
//   wunmap(map0);
//   printf(1, "finished shrink\n");
//   return;
// }
// void test_single_remap_move() {
//   printf(1, "move\n");
//   uint map0 = wmap(0x60000000, 8192,  MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
//   *((char*)map0) = 'a';
//   uint addr = map0 + 4096;
//   *((char*)addr) = 'b';
//   uint map1 = wmap(0x60002000, 8192,  MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
//   map1 = map1;
//   map0 = wremap(map0, 8192, 4096 * 3, MREMAP_MAYMOVE);
//   printf(1, "map0 is %x\n", map0);
//   printf(1, "finished move\n");
// }

int main(void) 
{
  printf(1, "starting tests---\n");
  //test_2_page_map_unmap();
  //test_mult_map_diff_touches();
  //test_map_fixed();
  //test_out_of_va();
  //test_wmapinfo();
 // test_remap();
  //test_single_wremap();
  //test_single_remap_shrink();
  //test_single_remap_move();
  test_fork();
  //test_pg();
  printf(1, "test finished\n");
  exit();
}
