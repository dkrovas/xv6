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

  printf(1, "\n\n");

  return;
}

void test_remap(void) {
  printf(1, "Testing test_remap\n");
  printf(1, "\t-testing if ifs are right");
  uint map0 = wmap(0x60000000, 4096,  MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  map0 = map0;
  wremap(0x60000000, 4096, 8192, 0);
  printf(1, "Should be Valid for in place\n\n");
  wremap(0x60000000, 4096, 8192, MREMAP_MAYMOVE);
  printf(1, "Should be Valid for in place\n\n");
  uint map1 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  map1=map1;
  wremap(0x60000000, 4096, 8192, 0);
  printf(1, "Should be Cannot\n\n");
  wremap(0x60000000, 4096, 8192, 0);
  printf(1, "Should be valid for moving\n\n");
  return;
}

void test_2_page_map_unmap(void) 
{
  printf(1, "Testing Mapping and unmapping multipages:\n");
  uint map = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);

  if (map == 0) {
    printf(1, "\t-Error mapping memory.\n");
    printf(1, "\nRESULT: FAILED");
    printf(1, "\n\n");
    return;
  }

  char* ptr = (char*)map;  // Assuming it's a char array
  for(int i=0;i<4096;i++){
    ptr[i] = 'f';
  }
   
  printf(1, "\t-ptr = %c, map = %x mapped\n", ptr[0], map);
  wunmap(map);
  //printf(1, "unmap = %c\n", ptr[0]);
  printf(1, "\nRESULT: PASSED");
  printf(1, "\n\n");
  return;
}
void test_wmapinfo(void){
  printf(1, "Testing wmapinfo\n");
  uint map = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  struct wmapinfo wminfo;
  
  if(getwmapinfo(&wminfo) < 0){
    printf(1, "\nRESULT: FAILED");
    return;
  }
  printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[0]);
  char* ptr0 = (char*)map;
  ptr0[0] = 'a';
  if(getwmapinfo(&wminfo) < 0){
    printf(1, "\nRESULT: FAILED");
    return;
  }
  printf(1, "\t-Total mmaps: %d\n", wminfo.total_mmaps);
  for(int i = 0; i < 16; ++i){
    if(wminfo.addr[i]!=0){
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
      printf(1, "\n");
    }

  }
  
  wunmap(map);
  if(getwmapinfo(&wminfo) < 0){
    printf(1, "\nRESULT: FAILED");
    return;
  }
  printf(1, "\t-Total mmaps after unmap: %d\n", wminfo.total_mmaps);
  for(int i = 0; i < 16; ++i){
    if(wminfo.addr[i]!=0){
      printf(1, "\t-Starting addr: %xn", wminfo.addr[i]);
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
       printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
       printf(1, "\n");
    }
    
  }
  printf(1,"\n");
  
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  char* ptr2 = (char*)map2;
  uint map3 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  char* ptr3 = (char*)map3;
  ptr2[0] = 'b';
 // printf(1, "ptr2 ptr3\n");
  for (int i = 0; i < 10; ++i){
    ptr3[i] = 'a';
   // printf(1, "ptr3[%d] = %c ", i, ptr3[i]);
  }
  if(getwmapinfo(&wminfo) < 0){
    printf(1, "\nRESULT: FAILED");
    return;
  }
  printf(1, "\t-Total mmaps after more maps: %d\n", wminfo.total_mmaps);
  for(int i = 0; i < 16; ++i){
    //printf(1, "wminfo.addr[%d] = %d\n", i, wminfo.addr[i]);
    if(wminfo.addr[i]!=0){
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
      printf(1, "\n");
    }
    
  }
  wunmap(map2);
  wunmap(map3);
 
  if(getwmapinfo(&wminfo) < 0){
    printf(1, "\nRESULT: FAILED");
    return;
  }
  for(int i = 0; i < 16; ++i){
    //printf(1, "wminfo.addr[%d] = %d\n", i, wminfo.addr[i]);
    if(wminfo.addr[i]!=0){
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
      printf(1, "\n");
    }
    
  }
  printf(1, "\nRESULT: SUCCESS\n\n");
  return;
}

int main(void) 
{
  printf(1, "starting tests---\n");
  //test_2_page_map_unmap();
  //test_mult_map_diff_touches();
  //test_map_fixed();
  //test_out_of_va();
  test_wmapinfo();
  //test_remap();
  exit();
}

