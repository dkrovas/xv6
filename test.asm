
_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "\nRESULT: SUCCESS\n\n");
  return;
}

int main(void) 
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "starting tests---\n");
  11:	68 d1 13 00 00       	push   $0x13d1
  16:	6a 01                	push   $0x1
  18:	e8 03 0c 00 00       	call   c20 <printf>
  //test_2_page_map_unmap();
  //test_mult_map_diff_touches();
  //test_map_fixed();
  //test_out_of_va();
  //test_wmapinfo();
  test_remap();
  1d:	e8 0e 03 00 00       	call   330 <test_remap>
  exit();
  22:	e8 7c 0a 00 00       	call   aa3 <exit>
  27:	66 90                	xchg   %ax,%ax
  29:	66 90                	xchg   %ax,%ax
  2b:	66 90                	xchg   %ax,%ax
  2d:	66 90                	xchg   %ax,%ax
  2f:	90                   	nop

00000030 <test_mult_map_diff_touches>:
void test_mult_map_diff_touches () {
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	57                   	push   %edi
  34:	56                   	push   %esi
  35:	53                   	push   %ebx
  36:	83 ec 14             	sub    $0x14,%esp
  printf(1, "Testing mult_map_diff_touches\n");
  39:	68 48 0f 00 00       	push   $0xf48
  3e:	6a 01                	push   $0x1
  40:	e8 db 0b 00 00       	call   c20 <printf>
  printf(1, "\t-wmapping 0\n");
  45:	59                   	pop    %ecx
  46:	5b                   	pop    %ebx
  47:	68 87 11 00 00       	push   $0x1187
  4c:	6a 01                	push   $0x1
  4e:	e8 cd 0b 00 00       	call   c20 <printf>
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  53:	6a ff                	push   $0xffffffff
  55:	6a 0e                	push   $0xe
  57:	68 00 20 00 00       	push   $0x2000
  5c:	68 00 00 00 60       	push   $0x60000000
  61:	e8 dd 0a 00 00       	call   b43 <wmap>
  printf(1, "\t-touching 0\n");
  66:	83 c4 18             	add    $0x18,%esp
  69:	68 95 11 00 00       	push   $0x1195
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  6e:	89 c3                	mov    %eax,%ebx
  printf(1, "\t-touching 0\n");
  70:	6a 01                	push   $0x1
  72:	e8 a9 0b 00 00       	call   c20 <printf>
  ptr0[0] = 'a';
  77:	c6 03 61             	movb   $0x61,(%ebx)
  printf(1, "\t-wmapping 1\n");
  7a:	5e                   	pop    %esi
  7b:	5f                   	pop    %edi
  7c:	68 a3 11 00 00       	push   $0x11a3
  81:	6a 01                	push   $0x1
  83:	e8 98 0b 00 00       	call   c20 <printf>
  uint map1 = wmap(0x60003000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  88:	6a ff                	push   $0xffffffff
  8a:	6a 0e                	push   $0xe
  8c:	68 00 10 00 00       	push   $0x1000
  91:	68 00 30 00 60       	push   $0x60003000
  96:	e8 a8 0a 00 00       	call   b43 <wmap>
  printf(1, "\t-wmapping 2\n");
  9b:	83 c4 18             	add    $0x18,%esp
  9e:	68 b1 11 00 00       	push   $0x11b1
  uint map1 = wmap(0x60003000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  a3:	89 c6                	mov    %eax,%esi
  printf(1, "\t-wmapping 2\n");
  a5:	6a 01                	push   $0x1
  a7:	e8 74 0b 00 00       	call   c20 <printf>
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  ac:	6a ff                	push   $0xffffffff
  ae:	6a 0e                	push   $0xe
  b0:	68 00 10 00 00       	push   $0x1000
  b5:	68 00 20 00 60       	push   $0x60002000
  ba:	e8 84 0a 00 00       	call   b43 <wmap>
    printf(1, "\t-touching 1\n");
  bf:	83 c4 18             	add    $0x18,%esp
  c2:	68 bf 11 00 00       	push   $0x11bf
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  c7:	89 c7                	mov    %eax,%edi
    printf(1, "\t-touching 1\n");
  c9:	6a 01                	push   $0x1
  cb:	e8 50 0b 00 00       	call   c20 <printf>
  ptr1[0] = 'b';
  d0:	c6 06 62             	movb   $0x62,(%esi)
  printf(1, "\t-map0 %c map1 %c\n", ptr0[0], ptr1[0]);
  d3:	6a 62                	push   $0x62
  d5:	0f be 03             	movsbl (%ebx),%eax
  d8:	50                   	push   %eax
  d9:	68 cd 11 00 00       	push   $0x11cd
  de:	6a 01                	push   $0x1
  e0:	e8 3b 0b 00 00       	call   c20 <printf>
  printf(1, "\nRESULT: ");
  e5:	83 c4 18             	add    $0x18,%esp
  e8:	68 e0 11 00 00       	push   $0x11e0
  ed:	6a 01                	push   $0x1
  ef:	e8 2c 0b 00 00       	call   c20 <printf>
  if (ptr0[0] == 'a' && ptr1[0] == 'b') {
  f4:	83 c4 10             	add    $0x10,%esp
  f7:	80 3b 61             	cmpb   $0x61,(%ebx)
  fa:	75 05                	jne    101 <test_mult_map_diff_touches+0xd1>
  fc:	80 3e 62             	cmpb   $0x62,(%esi)
  ff:	74 47                	je     148 <test_mult_map_diff_touches+0x118>
    printf(1, "FAILED");
 101:	83 ec 08             	sub    $0x8,%esp
 104:	68 15 13 00 00       	push   $0x1315
 109:	6a 01                	push   $0x1
 10b:	e8 10 0b 00 00       	call   c20 <printf>
 110:	83 c4 10             	add    $0x10,%esp
  wunmap(map0);
 113:	83 ec 0c             	sub    $0xc,%esp
 116:	53                   	push   %ebx
 117:	e8 2f 0a 00 00       	call   b4b <wunmap>
  wunmap(map1);
 11c:	89 34 24             	mov    %esi,(%esp)
 11f:	e8 27 0a 00 00       	call   b4b <wunmap>
  wunmap(map2);
 124:	89 3c 24             	mov    %edi,(%esp)
 127:	e8 1f 0a 00 00       	call   b4b <wunmap>
  printf(1, "\n\n");
 12c:	58                   	pop    %eax
 12d:	5a                   	pop    %edx
 12e:	68 90 12 00 00       	push   $0x1290
 133:	6a 01                	push   $0x1
 135:	e8 e6 0a 00 00       	call   c20 <printf>
  return;
 13a:	83 c4 10             	add    $0x10,%esp
}
 13d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 140:	5b                   	pop    %ebx
 141:	5e                   	pop    %esi
 142:	5f                   	pop    %edi
 143:	5d                   	pop    %ebp
 144:	c3                   	ret    
 145:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "PASSED");
 148:	83 ec 08             	sub    $0x8,%esp
 14b:	68 42 13 00 00       	push   $0x1342
 150:	6a 01                	push   $0x1
 152:	e8 c9 0a 00 00       	call   c20 <printf>
 157:	83 c4 10             	add    $0x10,%esp
 15a:	eb b7                	jmp    113 <test_mult_map_diff_touches+0xe3>
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000160 <test_out_of_va>:
void test_out_of_va(void) {
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	83 ec 10             	sub    $0x10,%esp
  printf(1, "Testing test_out_of_va\n");
 166:	68 ea 11 00 00       	push   $0x11ea
 16b:	6a 01                	push   $0x1
 16d:	e8 ae 0a 00 00       	call   c20 <printf>
  printf(1, "\t-wmapping 0 to max size\n");
 172:	58                   	pop    %eax
 173:	5a                   	pop    %edx
 174:	68 02 12 00 00       	push   $0x1202
 179:	6a 01                	push   $0x1
 17b:	e8 a0 0a 00 00       	call   c20 <printf>
  uint map0 = wmap(0x60000000, 0x20000000, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 180:	6a ff                	push   $0xffffffff
 182:	6a 0e                	push   $0xe
 184:	68 00 00 00 20       	push   $0x20000000
 189:	68 00 00 00 60       	push   $0x60000000
 18e:	e8 b0 09 00 00       	call   b43 <wmap>
  printf(1, "\t-wmapping 1, so we get error message\n");
 193:	83 c4 18             	add    $0x18,%esp
 196:	68 68 0f 00 00       	push   $0xf68
 19b:	6a 01                	push   $0x1
 19d:	e8 7e 0a 00 00       	call   c20 <printf>
  uint map1 = wmap(0x60001000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 1a2:	6a ff                	push   $0xffffffff
 1a4:	6a 0e                	push   $0xe
 1a6:	68 00 10 00 00       	push   $0x1000
 1ab:	68 00 10 00 60       	push   $0x60001000
 1b0:	e8 8e 09 00 00       	call   b43 <wmap>
  printf(1, "\nCheck if got error message above\n");
 1b5:	83 c4 18             	add    $0x18,%esp
 1b8:	68 90 0f 00 00       	push   $0xf90
 1bd:	6a 01                	push   $0x1
 1bf:	e8 5c 0a 00 00       	call   c20 <printf>
}
 1c4:	83 c4 10             	add    $0x10,%esp
 1c7:	c9                   	leave  
 1c8:	c3                   	ret    
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001d0 <test_map_fixed>:
void test_map_fixed(void) {
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	56                   	push   %esi
 1d4:	53                   	push   %ebx
  printf(1, "Testing test_map_fixed\n");
 1d5:	83 ec 08             	sub    $0x8,%esp
 1d8:	68 1c 12 00 00       	push   $0x121c
 1dd:	6a 01                	push   $0x1
 1df:	e8 3c 0a 00 00       	call   c20 <printf>
  printf(1, "\t-testing basic functionality\n");
 1e4:	58                   	pop    %eax
 1e5:	5a                   	pop    %edx
 1e6:	68 b4 0f 00 00       	push   $0xfb4
 1eb:	6a 01                	push   $0x1
 1ed:	e8 2e 0a 00 00       	call   c20 <printf>
  printf(1, "\t-wmapping 0 as fixed\n");
 1f2:	59                   	pop    %ecx
 1f3:	5b                   	pop    %ebx
 1f4:	68 34 12 00 00       	push   $0x1234
 1f9:	6a 01                	push   $0x1
 1fb:	e8 20 0a 00 00       	call   c20 <printf>
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 200:	6a ff                	push   $0xffffffff
 202:	6a 0e                	push   $0xe
 204:	68 00 20 00 00       	push   $0x2000
 209:	68 00 00 00 60       	push   $0x60000000
 20e:	e8 30 09 00 00       	call   b43 <wmap>
  printf(1, "\t-wmapping 1 as not fixed, trying to get other addr\n");
 213:	83 c4 18             	add    $0x18,%esp
 216:	68 d4 0f 00 00       	push   $0xfd4
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 21b:	89 c6                	mov    %eax,%esi
  printf(1, "\t-wmapping 1 as not fixed, trying to get other addr\n");
 21d:	6a 01                	push   $0x1
 21f:	e8 fc 09 00 00       	call   c20 <printf>
  uint map1 = wmap(0x60000000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
 224:	6a ff                	push   $0xffffffff
 226:	6a 06                	push   $0x6
 228:	68 00 20 00 00       	push   $0x2000
 22d:	68 00 00 00 60       	push   $0x60000000
 232:	e8 0c 09 00 00       	call   b43 <wmap>
  printf(1, "\nShould be 0x60002000\n\n");
 237:	83 c4 18             	add    $0x18,%esp
 23a:	68 4b 12 00 00       	push   $0x124b
  uint map1 = wmap(0x60000000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
 23f:	89 c3                	mov    %eax,%ebx
  printf(1, "\nShould be 0x60002000\n\n");
 241:	6a 01                	push   $0x1
 243:	e8 d8 09 00 00       	call   c20 <printf>
  printf(1, "\t-testing if doesn't break with endpoints\n");
 248:	58                   	pop    %eax
 249:	5a                   	pop    %edx
 24a:	68 0c 10 00 00       	push   $0x100c
 24f:	6a 01                	push   $0x1
 251:	e8 ca 09 00 00       	call   c20 <printf>
  wunmap(map0);
 256:	89 34 24             	mov    %esi,(%esp)
 259:	e8 ed 08 00 00       	call   b4b <wunmap>
  printf(1, "\t-wmapping 0 as not fixed, trying to get other addr\n");
 25e:	59                   	pop    %ecx
 25f:	5e                   	pop    %esi
 260:	68 38 10 00 00       	push   $0x1038
 265:	6a 01                	push   $0x1
 267:	e8 b4 09 00 00       	call   c20 <printf>
  map0 = wmap(0x60000000, 4096 * 3, MAP_SHARED | MAP_ANONYMOUS, -1);
 26c:	6a ff                	push   $0xffffffff
 26e:	6a 06                	push   $0x6
 270:	68 00 30 00 00       	push   $0x3000
 275:	68 00 00 00 60       	push   $0x60000000
 27a:	e8 c4 08 00 00       	call   b43 <wmap>
  printf(1, "\nShould be 0x60004000\n\n");
 27f:	83 c4 18             	add    $0x18,%esp
 282:	68 63 12 00 00       	push   $0x1263
  map0 = wmap(0x60000000, 4096 * 3, MAP_SHARED | MAP_ANONYMOUS, -1);
 287:	89 c6                	mov    %eax,%esi
  printf(1, "\nShould be 0x60004000\n\n");
 289:	6a 01                	push   $0x1
 28b:	e8 90 09 00 00       	call   c20 <printf>
  printf(1, "\t-testing if doesn't break if exceding 0x80000000\n");
 290:	58                   	pop    %eax
 291:	5a                   	pop    %edx
 292:	68 70 10 00 00       	push   $0x1070
 297:	6a 01                	push   $0x1
 299:	e8 82 09 00 00       	call   c20 <printf>
  wunmap(map0);
 29e:	89 34 24             	mov    %esi,(%esp)
 2a1:	e8 a5 08 00 00       	call   b4b <wunmap>
  wunmap(map1);
 2a6:	89 1c 24             	mov    %ebx,(%esp)
 2a9:	e8 9d 08 00 00       	call   b4b <wunmap>
  printf(1, "\t-wmapping 0 as fixed at 0x7fffe000\n");
 2ae:	59                   	pop    %ecx
 2af:	5b                   	pop    %ebx
 2b0:	68 a4 10 00 00       	push   $0x10a4
 2b5:	6a 01                	push   $0x1
 2b7:	e8 64 09 00 00       	call   c20 <printf>
  map0 = wmap(0x7fffe000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 2bc:	6a ff                	push   $0xffffffff
 2be:	6a 0e                	push   $0xe
 2c0:	68 00 10 00 00       	push   $0x1000
 2c5:	68 00 e0 ff 7f       	push   $0x7fffe000
 2ca:	e8 74 08 00 00       	call   b43 <wmap>
  printf(1, "\t-wmapping 1 with 8192, needing to loop\n");
 2cf:	83 c4 18             	add    $0x18,%esp
 2d2:	68 cc 10 00 00       	push   $0x10cc
  map0 = wmap(0x7fffe000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 2d7:	89 c6                	mov    %eax,%esi
  printf(1, "\t-wmapping 1 with 8192, needing to loop\n");
 2d9:	6a 01                	push   $0x1
 2db:	e8 40 09 00 00       	call   c20 <printf>
  map1 = wmap(0x7fffe000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
 2e0:	6a ff                	push   $0xffffffff
 2e2:	6a 06                	push   $0x6
 2e4:	68 00 20 00 00       	push   $0x2000
 2e9:	68 00 e0 ff 7f       	push   $0x7fffe000
 2ee:	e8 50 08 00 00       	call   b43 <wmap>
  printf(1, "\nShould be 0x60000000\n\n");
 2f3:	83 c4 18             	add    $0x18,%esp
 2f6:	68 7b 12 00 00       	push   $0x127b
  map1 = wmap(0x7fffe000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
 2fb:	89 c3                	mov    %eax,%ebx
  printf(1, "\nShould be 0x60000000\n\n");
 2fd:	6a 01                	push   $0x1
 2ff:	e8 1c 09 00 00       	call   c20 <printf>
  wunmap(map0);
 304:	89 34 24             	mov    %esi,(%esp)
 307:	e8 3f 08 00 00       	call   b4b <wunmap>
  wunmap(map1);
 30c:	89 1c 24             	mov    %ebx,(%esp)
 30f:	e8 37 08 00 00       	call   b4b <wunmap>
  printf(1, "\n\n");
 314:	5e                   	pop    %esi
 315:	58                   	pop    %eax
 316:	68 90 12 00 00       	push   $0x1290
 31b:	6a 01                	push   $0x1
 31d:	e8 fe 08 00 00       	call   c20 <printf>
  return;
 322:	83 c4 10             	add    $0x10,%esp
}
 325:	8d 65 f8             	lea    -0x8(%ebp),%esp
 328:	5b                   	pop    %ebx
 329:	5e                   	pop    %esi
 32a:	5d                   	pop    %ebp
 32b:	c3                   	ret    
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000330 <test_remap>:
void test_remap(void) {
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	83 ec 10             	sub    $0x10,%esp
  printf(1, "Testing test_remap\n");
 336:	68 93 12 00 00       	push   $0x1293
 33b:	6a 01                	push   $0x1
 33d:	e8 de 08 00 00       	call   c20 <printf>
  printf(1, "\t-testing if ifs are right\n");
 342:	58                   	pop    %eax
 343:	5a                   	pop    %edx
 344:	68 a7 12 00 00       	push   $0x12a7
 349:	6a 01                	push   $0x1
 34b:	e8 d0 08 00 00       	call   c20 <printf>
  uint map0 = wmap(0x60000000, 4096,  MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 350:	6a ff                	push   $0xffffffff
 352:	6a 0e                	push   $0xe
 354:	68 00 10 00 00       	push   $0x1000
 359:	68 00 00 00 60       	push   $0x60000000
 35e:	e8 e0 07 00 00       	call   b43 <wmap>
  uint map2 = wmap(0x70000000, 4096,  MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 363:	83 c4 20             	add    $0x20,%esp
 366:	6a ff                	push   $0xffffffff
 368:	6a 0e                	push   $0xe
 36a:	68 00 10 00 00       	push   $0x1000
 36f:	68 00 00 00 70       	push   $0x70000000
 374:	e8 ca 07 00 00       	call   b43 <wmap>
  wremap(0x60000000, 4096, 8192, 0);
 379:	6a 00                	push   $0x0
 37b:	68 00 20 00 00       	push   $0x2000
 380:	68 00 10 00 00       	push   $0x1000
 385:	68 00 00 00 60       	push   $0x60000000
 38a:	e8 c4 07 00 00       	call   b53 <wremap>
  printf(1, "Should be Valid for in place\n\n");
 38f:	83 c4 18             	add    $0x18,%esp
 392:	68 f8 10 00 00       	push   $0x10f8
 397:	6a 01                	push   $0x1
 399:	e8 82 08 00 00       	call   c20 <printf>
  wremap(0x60000000, 4096, 8192, MREMAP_MAYMOVE);
 39e:	6a 01                	push   $0x1
 3a0:	68 00 20 00 00       	push   $0x2000
 3a5:	68 00 10 00 00       	push   $0x1000
 3aa:	68 00 00 00 60       	push   $0x60000000
 3af:	e8 9f 07 00 00       	call   b53 <wremap>
  printf(1, "Should be Valid for in place\n\n");
 3b4:	83 c4 18             	add    $0x18,%esp
 3b7:	68 f8 10 00 00       	push   $0x10f8
 3bc:	6a 01                	push   $0x1
 3be:	e8 5d 08 00 00       	call   c20 <printf>
  uint map1 = wmap(0x60001000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 3c3:	6a ff                	push   $0xffffffff
 3c5:	6a 0e                	push   $0xe
 3c7:	68 00 10 00 00       	push   $0x1000
 3cc:	68 00 10 00 60       	push   $0x60001000
 3d1:	e8 6d 07 00 00       	call   b43 <wmap>
  uint map3 = wmap(0x70002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 3d6:	83 c4 20             	add    $0x20,%esp
 3d9:	6a ff                	push   $0xffffffff
 3db:	6a 0e                	push   $0xe
 3dd:	68 00 10 00 00       	push   $0x1000
 3e2:	68 00 20 00 70       	push   $0x70002000
 3e7:	e8 57 07 00 00       	call   b43 <wmap>
  wremap(0x60000000, 4096, 8192, 0);
 3ec:	6a 00                	push   $0x0
 3ee:	68 00 20 00 00       	push   $0x2000
 3f3:	68 00 10 00 00       	push   $0x1000
 3f8:	68 00 00 00 60       	push   $0x60000000
 3fd:	e8 51 07 00 00       	call   b53 <wremap>
  printf(1, "Should be Cannot\n\n");
 402:	83 c4 18             	add    $0x18,%esp
 405:	68 c3 12 00 00       	push   $0x12c3
 40a:	6a 01                	push   $0x1
 40c:	e8 0f 08 00 00       	call   c20 <printf>
  wremap(0x60000000, 4096, 8192, MREMAP_MAYMOVE);
 411:	6a 01                	push   $0x1
 413:	68 00 20 00 00       	push   $0x2000
 418:	68 00 10 00 00       	push   $0x1000
 41d:	68 00 00 00 60       	push   $0x60000000
 422:	e8 2c 07 00 00       	call   b53 <wremap>
  printf(1, "Should be valid for moving\n\n");
 427:	83 c4 18             	add    $0x18,%esp
 42a:	68 d6 12 00 00       	push   $0x12d6
 42f:	6a 01                	push   $0x1
 431:	e8 ea 07 00 00       	call   c20 <printf>
  return;
 436:	83 c4 10             	add    $0x10,%esp
}
 439:	c9                   	leave  
 43a:	c3                   	ret    
 43b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 43f:	90                   	nop

00000440 <test_2_page_map_unmap>:
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	53                   	push   %ebx
 444:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "Testing Mapping and unmapping multipages:\n");
 447:	68 18 11 00 00       	push   $0x1118
 44c:	6a 01                	push   $0x1
 44e:	e8 cd 07 00 00       	call   c20 <printf>
  uint map = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 453:	6a ff                	push   $0xffffffff
 455:	6a 0e                	push   $0xe
 457:	68 00 20 00 00       	push   $0x2000
 45c:	68 00 00 00 60       	push   $0x60000000
 461:	e8 dd 06 00 00       	call   b43 <wmap>
  if (map == 0) {
 466:	83 c4 20             	add    $0x20,%esp
 469:	85 c0                	test   %eax,%eax
 46b:	74 5a                	je     4c7 <test_2_page_map_unmap+0x87>
 46d:	89 c3                	mov    %eax,%ebx
 46f:	8d 88 00 10 00 00    	lea    0x1000(%eax),%ecx
 475:	89 c2                	mov    %eax,%edx
 477:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 47e:	66 90                	xchg   %ax,%ax
    ptr[i] = 'f';
 480:	c6 02 66             	movb   $0x66,(%edx)
  for(int i=0;i<4096;i++){
 483:	83 c2 01             	add    $0x1,%edx
 486:	39 d1                	cmp    %edx,%ecx
 488:	75 f6                	jne    480 <test_2_page_map_unmap+0x40>
  printf(1, "\t-ptr = %c, map = %x mapped\n", ptr[0], map);
 48a:	53                   	push   %ebx
 48b:	0f be 03             	movsbl (%ebx),%eax
 48e:	50                   	push   %eax
 48f:	68 1c 13 00 00       	push   $0x131c
 494:	6a 01                	push   $0x1
 496:	e8 85 07 00 00       	call   c20 <printf>
  wunmap(map);
 49b:	89 1c 24             	mov    %ebx,(%esp)
 49e:	e8 a8 06 00 00       	call   b4b <wunmap>
  printf(1, "\nRESULT: PASSED");
 4a3:	59                   	pop    %ecx
 4a4:	5b                   	pop    %ebx
 4a5:	68 39 13 00 00       	push   $0x1339
 4aa:	6a 01                	push   $0x1
 4ac:	e8 6f 07 00 00       	call   c20 <printf>
  printf(1, "\n\n");
 4b1:	58                   	pop    %eax
 4b2:	5a                   	pop    %edx
 4b3:	68 90 12 00 00       	push   $0x1290
 4b8:	6a 01                	push   $0x1
 4ba:	e8 61 07 00 00       	call   c20 <printf>
}
 4bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return;
 4c2:	83 c4 10             	add    $0x10,%esp
}
 4c5:	c9                   	leave  
 4c6:	c3                   	ret    
    printf(1, "\t-Error mapping memory.\n");
 4c7:	83 ec 08             	sub    $0x8,%esp
 4ca:	68 f3 12 00 00       	push   $0x12f3
 4cf:	6a 01                	push   $0x1
 4d1:	e8 4a 07 00 00       	call   c20 <printf>
    printf(1, "\nRESULT: FAILED");
 4d6:	58                   	pop    %eax
 4d7:	5a                   	pop    %edx
 4d8:	68 0c 13 00 00       	push   $0x130c
 4dd:	eb cb                	jmp    4aa <test_2_page_map_unmap+0x6a>
 4df:	90                   	nop

000004e0 <test_wmapinfo>:
void test_wmapinfo(void){
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	81 ec f4 00 00 00    	sub    $0xf4,%esp
  printf(1, "Testing wmapinfo\n");
 4ec:	68 49 13 00 00       	push   $0x1349
 4f1:	6a 01                	push   $0x1
 4f3:	e8 28 07 00 00       	call   c20 <printf>
  uint map = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 4f8:	6a ff                	push   $0xffffffff
 4fa:	6a 0e                	push   $0xe
 4fc:	68 00 20 00 00       	push   $0x2000
 501:	68 00 00 00 60       	push   $0x60000000
 506:	e8 38 06 00 00       	call   b43 <wmap>
  if(getwmapinfo(&wminfo) < 0){
 50b:	83 c4 14             	add    $0x14,%esp
  uint map = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 50e:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  if(getwmapinfo(&wminfo) < 0){
 514:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
 51a:	50                   	push   %eax
 51b:	e8 43 06 00 00       	call   b63 <getwmapinfo>
 520:	83 c4 10             	add    $0x10,%esp
 523:	85 c0                	test   %eax,%eax
 525:	0f 88 fd 02 00 00    	js     828 <test_wmapinfo+0x348>
  printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[0]);
 52b:	83 ec 04             	sub    $0x4,%esp
 52e:	ff 75 a8             	push   -0x58(%ebp)
 531:	68 5b 13 00 00       	push   $0x135b
 536:	6a 01                	push   $0x1
 538:	e8 e3 06 00 00       	call   c20 <printf>
  ptr0[0] = 'a';
 53d:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
 543:	c6 00 61             	movb   $0x61,(%eax)
  if(getwmapinfo(&wminfo) < 0){
 546:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
 54c:	89 04 24             	mov    %eax,(%esp)
 54f:	e8 0f 06 00 00       	call   b63 <getwmapinfo>
 554:	83 c4 10             	add    $0x10,%esp
 557:	85 c0                	test   %eax,%eax
 559:	0f 88 c9 02 00 00    	js     828 <test_wmapinfo+0x348>
  printf(1, "\t-Total mmaps: %d\n", wminfo.total_mmaps);
 55f:	83 ec 04             	sub    $0x4,%esp
 562:	ff b5 24 ff ff ff    	push   -0xdc(%ebp)
 568:	8d 9d 28 ff ff ff    	lea    -0xd8(%ebp),%ebx
 56e:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
 574:	68 6f 13 00 00       	push   $0x136f
 579:	89 df                	mov    %ebx,%edi
 57b:	6a 01                	push   $0x1
 57d:	e8 9e 06 00 00       	call   c20 <printf>
  for(int i = 0; i < 16; ++i){
 582:	83 c4 10             	add    $0x10,%esp
 585:	eb 10                	jmp    597 <test_wmapinfo+0xb7>
 587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58e:	66 90                	xchg   %ax,%ax
 590:	83 c7 04             	add    $0x4,%edi
 593:	39 f7                	cmp    %esi,%edi
 595:	74 57                	je     5ee <test_wmapinfo+0x10e>
    if(wminfo.addr[i]!=0){
 597:	8b 0f                	mov    (%edi),%ecx
 599:	85 c9                	test   %ecx,%ecx
 59b:	74 f3                	je     590 <test_wmapinfo+0xb0>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
 59d:	83 ec 04             	sub    $0x4,%esp
 5a0:	ff b7 80 00 00 00    	push   0x80(%edi)
  for(int i = 0; i < 16; ++i){
 5a6:	83 c7 04             	add    $0x4,%edi
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
 5a9:	68 5b 13 00 00       	push   $0x135b
 5ae:	6a 01                	push   $0x1
 5b0:	e8 6b 06 00 00       	call   c20 <printf>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
 5b5:	83 c4 0c             	add    $0xc,%esp
 5b8:	ff 77 fc             	push   -0x4(%edi)
 5bb:	68 82 13 00 00       	push   $0x1382
 5c0:	6a 01                	push   $0x1
 5c2:	e8 59 06 00 00       	call   c20 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
 5c7:	83 c4 0c             	add    $0xc,%esp
 5ca:	ff 77 3c             	push   0x3c(%edi)
 5cd:	68 97 13 00 00       	push   $0x1397
 5d2:	6a 01                	push   $0x1
 5d4:	e8 47 06 00 00       	call   c20 <printf>
      printf(1, "\n");
 5d9:	58                   	pop    %eax
 5da:	5a                   	pop    %edx
 5db:	68 91 12 00 00       	push   $0x1291
 5e0:	6a 01                	push   $0x1
 5e2:	e8 39 06 00 00       	call   c20 <printf>
 5e7:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
 5ea:	39 f7                	cmp    %esi,%edi
 5ec:	75 a9                	jne    597 <test_wmapinfo+0xb7>
  wunmap(map);
 5ee:	83 ec 0c             	sub    $0xc,%esp
 5f1:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
 5f7:	e8 4f 05 00 00       	call   b4b <wunmap>
  if(getwmapinfo(&wminfo) < 0){
 5fc:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
 602:	89 04 24             	mov    %eax,(%esp)
 605:	e8 59 05 00 00       	call   b63 <getwmapinfo>
 60a:	83 c4 10             	add    $0x10,%esp
 60d:	85 c0                	test   %eax,%eax
 60f:	0f 88 13 02 00 00    	js     828 <test_wmapinfo+0x348>
  printf(1, "\t-Total mmaps after unmap: %d\n", wminfo.total_mmaps);
 615:	83 ec 04             	sub    $0x4,%esp
 618:	ff b5 24 ff ff ff    	push   -0xdc(%ebp)
 61e:	89 df                	mov    %ebx,%edi
 620:	68 44 11 00 00       	push   $0x1144
 625:	6a 01                	push   $0x1
 627:	e8 f4 05 00 00       	call   c20 <printf>
 62c:	83 c4 10             	add    $0x10,%esp
 62f:	eb 0e                	jmp    63f <test_wmapinfo+0x15f>
 631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(int i = 0; i < 16; ++i){
 638:	83 c7 04             	add    $0x4,%edi
 63b:	39 f7                	cmp    %esi,%edi
 63d:	74 52                	je     691 <test_wmapinfo+0x1b1>
    if(wminfo.addr[i]!=0){
 63f:	8b 07                	mov    (%edi),%eax
 641:	85 c0                	test   %eax,%eax
 643:	74 f3                	je     638 <test_wmapinfo+0x158>
      printf(1, "\t-Starting addr: %xn", wminfo.addr[i]);
 645:	83 ec 04             	sub    $0x4,%esp
  for(int i = 0; i < 16; ++i){
 648:	83 c7 04             	add    $0x4,%edi
      printf(1, "\t-Starting addr: %xn", wminfo.addr[i]);
 64b:	50                   	push   %eax
 64c:	68 a9 13 00 00       	push   $0x13a9
 651:	6a 01                	push   $0x1
 653:	e8 c8 05 00 00       	call   c20 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
 658:	83 c4 0c             	add    $0xc,%esp
 65b:	ff 77 3c             	push   0x3c(%edi)
 65e:	68 97 13 00 00       	push   $0x1397
 663:	6a 01                	push   $0x1
 665:	e8 b6 05 00 00       	call   c20 <printf>
       printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
 66a:	83 c4 0c             	add    $0xc,%esp
 66d:	ff 77 7c             	push   0x7c(%edi)
 670:	68 5b 13 00 00       	push   $0x135b
 675:	6a 01                	push   $0x1
 677:	e8 a4 05 00 00       	call   c20 <printf>
       printf(1, "\n");
 67c:	59                   	pop    %ecx
 67d:	58                   	pop    %eax
 67e:	68 91 12 00 00       	push   $0x1291
 683:	6a 01                	push   $0x1
 685:	e8 96 05 00 00       	call   c20 <printf>
 68a:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
 68d:	39 f7                	cmp    %esi,%edi
 68f:	75 ae                	jne    63f <test_wmapinfo+0x15f>
  printf(1,"\n");
 691:	83 ec 08             	sub    $0x8,%esp
 694:	68 91 12 00 00       	push   $0x1291
 699:	6a 01                	push   $0x1
 69b:	e8 80 05 00 00       	call   c20 <printf>
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 6a0:	6a ff                	push   $0xffffffff
 6a2:	6a 0e                	push   $0xe
 6a4:	68 00 10 00 00       	push   $0x1000
 6a9:	68 00 20 00 60       	push   $0x60002000
 6ae:	e8 90 04 00 00       	call   b43 <wmap>
  uint map3 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 6b3:	83 c4 20             	add    $0x20,%esp
 6b6:	6a ff                	push   $0xffffffff
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 6b8:	89 c7                	mov    %eax,%edi
  uint map3 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 6ba:	6a 0e                	push   $0xe
 6bc:	68 00 20 00 00       	push   $0x2000
 6c1:	68 00 00 00 60       	push   $0x60000000
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 6c6:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  uint map3 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 6cc:	e8 72 04 00 00       	call   b43 <wmap>
  ptr2[0] = 'b';
 6d1:	c6 07 62             	movb   $0x62,(%edi)
 6d4:	83 c4 10             	add    $0x10,%esp
  uint map3 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 6d7:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
  for (int i = 0; i < 10; ++i){
 6dd:	8d 48 0a             	lea    0xa(%eax),%ecx
    ptr3[i] = 'a';
 6e0:	c6 00 61             	movb   $0x61,(%eax)
  for (int i = 0; i < 10; ++i){
 6e3:	83 c0 01             	add    $0x1,%eax
 6e6:	39 c8                	cmp    %ecx,%eax
 6e8:	75 f6                	jne    6e0 <test_wmapinfo+0x200>
  if(getwmapinfo(&wminfo) < 0){
 6ea:	83 ec 0c             	sub    $0xc,%esp
 6ed:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
 6f3:	50                   	push   %eax
 6f4:	e8 6a 04 00 00       	call   b63 <getwmapinfo>
 6f9:	83 c4 10             	add    $0x10,%esp
 6fc:	85 c0                	test   %eax,%eax
 6fe:	0f 88 24 01 00 00    	js     828 <test_wmapinfo+0x348>
  printf(1, "\t-Total mmaps after more maps: %d\n", wminfo.total_mmaps);
 704:	83 ec 04             	sub    $0x4,%esp
 707:	ff b5 24 ff ff ff    	push   -0xdc(%ebp)
 70d:	89 df                	mov    %ebx,%edi
 70f:	68 64 11 00 00       	push   $0x1164
 714:	6a 01                	push   $0x1
 716:	e8 05 05 00 00       	call   c20 <printf>
 71b:	83 c4 10             	add    $0x10,%esp
 71e:	eb 07                	jmp    727 <test_wmapinfo+0x247>
  for(int i = 0; i < 16; ++i){
 720:	83 c7 04             	add    $0x4,%edi
 723:	39 f7                	cmp    %esi,%edi
 725:	74 52                	je     779 <test_wmapinfo+0x299>
    if(wminfo.addr[i]!=0){
 727:	8b 07                	mov    (%edi),%eax
 729:	85 c0                	test   %eax,%eax
 72b:	74 f3                	je     720 <test_wmapinfo+0x240>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
 72d:	83 ec 04             	sub    $0x4,%esp
  for(int i = 0; i < 16; ++i){
 730:	83 c7 04             	add    $0x4,%edi
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
 733:	50                   	push   %eax
 734:	68 82 13 00 00       	push   $0x1382
 739:	6a 01                	push   $0x1
 73b:	e8 e0 04 00 00       	call   c20 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
 740:	83 c4 0c             	add    $0xc,%esp
 743:	ff 77 3c             	push   0x3c(%edi)
 746:	68 97 13 00 00       	push   $0x1397
 74b:	6a 01                	push   $0x1
 74d:	e8 ce 04 00 00       	call   c20 <printf>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
 752:	83 c4 0c             	add    $0xc,%esp
 755:	ff 77 7c             	push   0x7c(%edi)
 758:	68 5b 13 00 00       	push   $0x135b
 75d:	6a 01                	push   $0x1
 75f:	e8 bc 04 00 00       	call   c20 <printf>
      printf(1, "\n");
 764:	58                   	pop    %eax
 765:	5a                   	pop    %edx
 766:	68 91 12 00 00       	push   $0x1291
 76b:	6a 01                	push   $0x1
 76d:	e8 ae 04 00 00       	call   c20 <printf>
 772:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
 775:	39 f7                	cmp    %esi,%edi
 777:	75 ae                	jne    727 <test_wmapinfo+0x247>
  wunmap(map2);
 779:	83 ec 0c             	sub    $0xc,%esp
 77c:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
 782:	e8 c4 03 00 00       	call   b4b <wunmap>
  wunmap(map3);
 787:	59                   	pop    %ecx
 788:	ff b5 10 ff ff ff    	push   -0xf0(%ebp)
 78e:	e8 b8 03 00 00       	call   b4b <wunmap>
  if(getwmapinfo(&wminfo) < 0){
 793:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
 799:	89 04 24             	mov    %eax,(%esp)
 79c:	e8 c2 03 00 00       	call   b63 <getwmapinfo>
 7a1:	83 c4 10             	add    $0x10,%esp
 7a4:	85 c0                	test   %eax,%eax
 7a6:	79 0f                	jns    7b7 <test_wmapinfo+0x2d7>
 7a8:	eb 7e                	jmp    828 <test_wmapinfo+0x348>
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(int i = 0; i < 16; ++i){
 7b0:	83 c3 04             	add    $0x4,%ebx
 7b3:	39 f3                	cmp    %esi,%ebx
 7b5:	74 52                	je     809 <test_wmapinfo+0x329>
    if(wminfo.addr[i]!=0){
 7b7:	8b 03                	mov    (%ebx),%eax
 7b9:	85 c0                	test   %eax,%eax
 7bb:	74 f3                	je     7b0 <test_wmapinfo+0x2d0>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
 7bd:	83 ec 04             	sub    $0x4,%esp
  for(int i = 0; i < 16; ++i){
 7c0:	83 c3 04             	add    $0x4,%ebx
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
 7c3:	50                   	push   %eax
 7c4:	68 82 13 00 00       	push   $0x1382
 7c9:	6a 01                	push   $0x1
 7cb:	e8 50 04 00 00       	call   c20 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
 7d0:	83 c4 0c             	add    $0xc,%esp
 7d3:	ff 73 3c             	push   0x3c(%ebx)
 7d6:	68 97 13 00 00       	push   $0x1397
 7db:	6a 01                	push   $0x1
 7dd:	e8 3e 04 00 00       	call   c20 <printf>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
 7e2:	83 c4 0c             	add    $0xc,%esp
 7e5:	ff 73 7c             	push   0x7c(%ebx)
 7e8:	68 5b 13 00 00       	push   $0x135b
 7ed:	6a 01                	push   $0x1
 7ef:	e8 2c 04 00 00       	call   c20 <printf>
      printf(1, "\n");
 7f4:	58                   	pop    %eax
 7f5:	5a                   	pop    %edx
 7f6:	68 91 12 00 00       	push   $0x1291
 7fb:	6a 01                	push   $0x1
 7fd:	e8 1e 04 00 00       	call   c20 <printf>
 802:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
 805:	39 f3                	cmp    %esi,%ebx
 807:	75 ae                	jne    7b7 <test_wmapinfo+0x2d7>
  printf(1, "\nRESULT: SUCCESS\n\n");
 809:	83 ec 08             	sub    $0x8,%esp
 80c:	68 be 13 00 00       	push   $0x13be
 811:	6a 01                	push   $0x1
 813:	e8 08 04 00 00       	call   c20 <printf>
  return;
 818:	83 c4 10             	add    $0x10,%esp
}
 81b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 81e:	5b                   	pop    %ebx
 81f:	5e                   	pop    %esi
 820:	5f                   	pop    %edi
 821:	5d                   	pop    %ebp
 822:	c3                   	ret    
 823:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 827:	90                   	nop
    printf(1, "\nRESULT: FAILED");
 828:	83 ec 08             	sub    $0x8,%esp
 82b:	68 0c 13 00 00       	push   $0x130c
 830:	6a 01                	push   $0x1
 832:	e8 e9 03 00 00       	call   c20 <printf>
    return;
 837:	83 c4 10             	add    $0x10,%esp
}
 83a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 83d:	5b                   	pop    %ebx
 83e:	5e                   	pop    %esi
 83f:	5f                   	pop    %edi
 840:	5d                   	pop    %ebp
 841:	c3                   	ret    
 842:	66 90                	xchg   %ax,%ax
 844:	66 90                	xchg   %ax,%ax
 846:	66 90                	xchg   %ax,%ax
 848:	66 90                	xchg   %ax,%ax
 84a:	66 90                	xchg   %ax,%ax
 84c:	66 90                	xchg   %ax,%ax
 84e:	66 90                	xchg   %ax,%ax

00000850 <strcpy>:
 850:	55                   	push   %ebp
 851:	31 c0                	xor    %eax,%eax
 853:	89 e5                	mov    %esp,%ebp
 855:	53                   	push   %ebx
 856:	8b 4d 08             	mov    0x8(%ebp),%ecx
 859:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 85c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 860:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 864:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 867:	83 c0 01             	add    $0x1,%eax
 86a:	84 d2                	test   %dl,%dl
 86c:	75 f2                	jne    860 <strcpy+0x10>
 86e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 871:	89 c8                	mov    %ecx,%eax
 873:	c9                   	leave  
 874:	c3                   	ret    
 875:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000880 <strcmp>:
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	53                   	push   %ebx
 884:	8b 55 08             	mov    0x8(%ebp),%edx
 887:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 88a:	0f b6 02             	movzbl (%edx),%eax
 88d:	84 c0                	test   %al,%al
 88f:	75 17                	jne    8a8 <strcmp+0x28>
 891:	eb 3a                	jmp    8cd <strcmp+0x4d>
 893:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 897:	90                   	nop
 898:	0f b6 42 01          	movzbl 0x1(%edx),%eax
 89c:	83 c2 01             	add    $0x1,%edx
 89f:	8d 59 01             	lea    0x1(%ecx),%ebx
 8a2:	84 c0                	test   %al,%al
 8a4:	74 1a                	je     8c0 <strcmp+0x40>
 8a6:	89 d9                	mov    %ebx,%ecx
 8a8:	0f b6 19             	movzbl (%ecx),%ebx
 8ab:	38 c3                	cmp    %al,%bl
 8ad:	74 e9                	je     898 <strcmp+0x18>
 8af:	29 d8                	sub    %ebx,%eax
 8b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8b4:	c9                   	leave  
 8b5:	c3                   	ret    
 8b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8bd:	8d 76 00             	lea    0x0(%esi),%esi
 8c0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 8c4:	31 c0                	xor    %eax,%eax
 8c6:	29 d8                	sub    %ebx,%eax
 8c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8cb:	c9                   	leave  
 8cc:	c3                   	ret    
 8cd:	0f b6 19             	movzbl (%ecx),%ebx
 8d0:	31 c0                	xor    %eax,%eax
 8d2:	eb db                	jmp    8af <strcmp+0x2f>
 8d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8df:	90                   	nop

000008e0 <strlen>:
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	8b 55 08             	mov    0x8(%ebp),%edx
 8e6:	80 3a 00             	cmpb   $0x0,(%edx)
 8e9:	74 15                	je     900 <strlen+0x20>
 8eb:	31 c0                	xor    %eax,%eax
 8ed:	8d 76 00             	lea    0x0(%esi),%esi
 8f0:	83 c0 01             	add    $0x1,%eax
 8f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 8f7:	89 c1                	mov    %eax,%ecx
 8f9:	75 f5                	jne    8f0 <strlen+0x10>
 8fb:	89 c8                	mov    %ecx,%eax
 8fd:	5d                   	pop    %ebp
 8fe:	c3                   	ret    
 8ff:	90                   	nop
 900:	31 c9                	xor    %ecx,%ecx
 902:	5d                   	pop    %ebp
 903:	89 c8                	mov    %ecx,%eax
 905:	c3                   	ret    
 906:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 90d:	8d 76 00             	lea    0x0(%esi),%esi

00000910 <memset>:
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	57                   	push   %edi
 914:	8b 55 08             	mov    0x8(%ebp),%edx
 917:	8b 4d 10             	mov    0x10(%ebp),%ecx
 91a:	8b 45 0c             	mov    0xc(%ebp),%eax
 91d:	89 d7                	mov    %edx,%edi
 91f:	fc                   	cld    
 920:	f3 aa                	rep stos %al,%es:(%edi)
 922:	8b 7d fc             	mov    -0x4(%ebp),%edi
 925:	89 d0                	mov    %edx,%eax
 927:	c9                   	leave  
 928:	c3                   	ret    
 929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000930 <strchr>:
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	8b 45 08             	mov    0x8(%ebp),%eax
 936:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 93a:	0f b6 10             	movzbl (%eax),%edx
 93d:	84 d2                	test   %dl,%dl
 93f:	75 12                	jne    953 <strchr+0x23>
 941:	eb 1d                	jmp    960 <strchr+0x30>
 943:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 947:	90                   	nop
 948:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 94c:	83 c0 01             	add    $0x1,%eax
 94f:	84 d2                	test   %dl,%dl
 951:	74 0d                	je     960 <strchr+0x30>
 953:	38 d1                	cmp    %dl,%cl
 955:	75 f1                	jne    948 <strchr+0x18>
 957:	5d                   	pop    %ebp
 958:	c3                   	ret    
 959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 960:	31 c0                	xor    %eax,%eax
 962:	5d                   	pop    %ebp
 963:	c3                   	ret    
 964:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 96b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 96f:	90                   	nop

00000970 <gets>:
 970:	55                   	push   %ebp
 971:	89 e5                	mov    %esp,%ebp
 973:	57                   	push   %edi
 974:	56                   	push   %esi
 975:	8d 7d e7             	lea    -0x19(%ebp),%edi
 978:	53                   	push   %ebx
 979:	31 db                	xor    %ebx,%ebx
 97b:	83 ec 1c             	sub    $0x1c,%esp
 97e:	eb 27                	jmp    9a7 <gets+0x37>
 980:	83 ec 04             	sub    $0x4,%esp
 983:	6a 01                	push   $0x1
 985:	57                   	push   %edi
 986:	6a 00                	push   $0x0
 988:	e8 2e 01 00 00       	call   abb <read>
 98d:	83 c4 10             	add    $0x10,%esp
 990:	85 c0                	test   %eax,%eax
 992:	7e 1d                	jle    9b1 <gets+0x41>
 994:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 998:	8b 55 08             	mov    0x8(%ebp),%edx
 99b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 99f:	3c 0a                	cmp    $0xa,%al
 9a1:	74 1d                	je     9c0 <gets+0x50>
 9a3:	3c 0d                	cmp    $0xd,%al
 9a5:	74 19                	je     9c0 <gets+0x50>
 9a7:	89 de                	mov    %ebx,%esi
 9a9:	83 c3 01             	add    $0x1,%ebx
 9ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 9af:	7c cf                	jl     980 <gets+0x10>
 9b1:	8b 45 08             	mov    0x8(%ebp),%eax
 9b4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 9b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9bb:	5b                   	pop    %ebx
 9bc:	5e                   	pop    %esi
 9bd:	5f                   	pop    %edi
 9be:	5d                   	pop    %ebp
 9bf:	c3                   	ret    
 9c0:	8b 45 08             	mov    0x8(%ebp),%eax
 9c3:	89 de                	mov    %ebx,%esi
 9c5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 9c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9cc:	5b                   	pop    %ebx
 9cd:	5e                   	pop    %esi
 9ce:	5f                   	pop    %edi
 9cf:	5d                   	pop    %ebp
 9d0:	c3                   	ret    
 9d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9df:	90                   	nop

000009e0 <stat>:
 9e0:	55                   	push   %ebp
 9e1:	89 e5                	mov    %esp,%ebp
 9e3:	56                   	push   %esi
 9e4:	53                   	push   %ebx
 9e5:	83 ec 08             	sub    $0x8,%esp
 9e8:	6a 00                	push   $0x0
 9ea:	ff 75 08             	push   0x8(%ebp)
 9ed:	e8 f1 00 00 00       	call   ae3 <open>
 9f2:	83 c4 10             	add    $0x10,%esp
 9f5:	85 c0                	test   %eax,%eax
 9f7:	78 27                	js     a20 <stat+0x40>
 9f9:	83 ec 08             	sub    $0x8,%esp
 9fc:	ff 75 0c             	push   0xc(%ebp)
 9ff:	89 c3                	mov    %eax,%ebx
 a01:	50                   	push   %eax
 a02:	e8 f4 00 00 00       	call   afb <fstat>
 a07:	89 1c 24             	mov    %ebx,(%esp)
 a0a:	89 c6                	mov    %eax,%esi
 a0c:	e8 ba 00 00 00       	call   acb <close>
 a11:	83 c4 10             	add    $0x10,%esp
 a14:	8d 65 f8             	lea    -0x8(%ebp),%esp
 a17:	89 f0                	mov    %esi,%eax
 a19:	5b                   	pop    %ebx
 a1a:	5e                   	pop    %esi
 a1b:	5d                   	pop    %ebp
 a1c:	c3                   	ret    
 a1d:	8d 76 00             	lea    0x0(%esi),%esi
 a20:	be ff ff ff ff       	mov    $0xffffffff,%esi
 a25:	eb ed                	jmp    a14 <stat+0x34>
 a27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a2e:	66 90                	xchg   %ax,%ax

00000a30 <atoi>:
 a30:	55                   	push   %ebp
 a31:	89 e5                	mov    %esp,%ebp
 a33:	53                   	push   %ebx
 a34:	8b 55 08             	mov    0x8(%ebp),%edx
 a37:	0f be 02             	movsbl (%edx),%eax
 a3a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 a3d:	80 f9 09             	cmp    $0x9,%cl
 a40:	b9 00 00 00 00       	mov    $0x0,%ecx
 a45:	77 1e                	ja     a65 <atoi+0x35>
 a47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a4e:	66 90                	xchg   %ax,%ax
 a50:	83 c2 01             	add    $0x1,%edx
 a53:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 a56:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 a5a:	0f be 02             	movsbl (%edx),%eax
 a5d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 a60:	80 fb 09             	cmp    $0x9,%bl
 a63:	76 eb                	jbe    a50 <atoi+0x20>
 a65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 a68:	89 c8                	mov    %ecx,%eax
 a6a:	c9                   	leave  
 a6b:	c3                   	ret    
 a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a70 <memmove>:
 a70:	55                   	push   %ebp
 a71:	89 e5                	mov    %esp,%ebp
 a73:	57                   	push   %edi
 a74:	8b 45 10             	mov    0x10(%ebp),%eax
 a77:	8b 55 08             	mov    0x8(%ebp),%edx
 a7a:	56                   	push   %esi
 a7b:	8b 75 0c             	mov    0xc(%ebp),%esi
 a7e:	85 c0                	test   %eax,%eax
 a80:	7e 13                	jle    a95 <memmove+0x25>
 a82:	01 d0                	add    %edx,%eax
 a84:	89 d7                	mov    %edx,%edi
 a86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a8d:	8d 76 00             	lea    0x0(%esi),%esi
 a90:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 a91:	39 f8                	cmp    %edi,%eax
 a93:	75 fb                	jne    a90 <memmove+0x20>
 a95:	5e                   	pop    %esi
 a96:	89 d0                	mov    %edx,%eax
 a98:	5f                   	pop    %edi
 a99:	5d                   	pop    %ebp
 a9a:	c3                   	ret    

00000a9b <fork>:
 a9b:	b8 01 00 00 00       	mov    $0x1,%eax
 aa0:	cd 40                	int    $0x40
 aa2:	c3                   	ret    

00000aa3 <exit>:
 aa3:	b8 02 00 00 00       	mov    $0x2,%eax
 aa8:	cd 40                	int    $0x40
 aaa:	c3                   	ret    

00000aab <wait>:
 aab:	b8 03 00 00 00       	mov    $0x3,%eax
 ab0:	cd 40                	int    $0x40
 ab2:	c3                   	ret    

00000ab3 <pipe>:
 ab3:	b8 04 00 00 00       	mov    $0x4,%eax
 ab8:	cd 40                	int    $0x40
 aba:	c3                   	ret    

00000abb <read>:
 abb:	b8 05 00 00 00       	mov    $0x5,%eax
 ac0:	cd 40                	int    $0x40
 ac2:	c3                   	ret    

00000ac3 <write>:
 ac3:	b8 10 00 00 00       	mov    $0x10,%eax
 ac8:	cd 40                	int    $0x40
 aca:	c3                   	ret    

00000acb <close>:
 acb:	b8 15 00 00 00       	mov    $0x15,%eax
 ad0:	cd 40                	int    $0x40
 ad2:	c3                   	ret    

00000ad3 <kill>:
 ad3:	b8 06 00 00 00       	mov    $0x6,%eax
 ad8:	cd 40                	int    $0x40
 ada:	c3                   	ret    

00000adb <exec>:
 adb:	b8 07 00 00 00       	mov    $0x7,%eax
 ae0:	cd 40                	int    $0x40
 ae2:	c3                   	ret    

00000ae3 <open>:
 ae3:	b8 0f 00 00 00       	mov    $0xf,%eax
 ae8:	cd 40                	int    $0x40
 aea:	c3                   	ret    

00000aeb <mknod>:
 aeb:	b8 11 00 00 00       	mov    $0x11,%eax
 af0:	cd 40                	int    $0x40
 af2:	c3                   	ret    

00000af3 <unlink>:
 af3:	b8 12 00 00 00       	mov    $0x12,%eax
 af8:	cd 40                	int    $0x40
 afa:	c3                   	ret    

00000afb <fstat>:
 afb:	b8 08 00 00 00       	mov    $0x8,%eax
 b00:	cd 40                	int    $0x40
 b02:	c3                   	ret    

00000b03 <link>:
 b03:	b8 13 00 00 00       	mov    $0x13,%eax
 b08:	cd 40                	int    $0x40
 b0a:	c3                   	ret    

00000b0b <mkdir>:
 b0b:	b8 14 00 00 00       	mov    $0x14,%eax
 b10:	cd 40                	int    $0x40
 b12:	c3                   	ret    

00000b13 <chdir>:
 b13:	b8 09 00 00 00       	mov    $0x9,%eax
 b18:	cd 40                	int    $0x40
 b1a:	c3                   	ret    

00000b1b <dup>:
 b1b:	b8 0a 00 00 00       	mov    $0xa,%eax
 b20:	cd 40                	int    $0x40
 b22:	c3                   	ret    

00000b23 <getpid>:
 b23:	b8 0b 00 00 00       	mov    $0xb,%eax
 b28:	cd 40                	int    $0x40
 b2a:	c3                   	ret    

00000b2b <sbrk>:
 b2b:	b8 0c 00 00 00       	mov    $0xc,%eax
 b30:	cd 40                	int    $0x40
 b32:	c3                   	ret    

00000b33 <sleep>:
 b33:	b8 0d 00 00 00       	mov    $0xd,%eax
 b38:	cd 40                	int    $0x40
 b3a:	c3                   	ret    

00000b3b <uptime>:
 b3b:	b8 0e 00 00 00       	mov    $0xe,%eax
 b40:	cd 40                	int    $0x40
 b42:	c3                   	ret    

00000b43 <wmap>:
 b43:	b8 16 00 00 00       	mov    $0x16,%eax
 b48:	cd 40                	int    $0x40
 b4a:	c3                   	ret    

00000b4b <wunmap>:
 b4b:	b8 17 00 00 00       	mov    $0x17,%eax
 b50:	cd 40                	int    $0x40
 b52:	c3                   	ret    

00000b53 <wremap>:
 b53:	b8 18 00 00 00       	mov    $0x18,%eax
 b58:	cd 40                	int    $0x40
 b5a:	c3                   	ret    

00000b5b <getpgdirinfo>:
 b5b:	b8 19 00 00 00       	mov    $0x19,%eax
 b60:	cd 40                	int    $0x40
 b62:	c3                   	ret    

00000b63 <getwmapinfo>:
 b63:	b8 1a 00 00 00       	mov    $0x1a,%eax
 b68:	cd 40                	int    $0x40
 b6a:	c3                   	ret    
 b6b:	66 90                	xchg   %ax,%ax
 b6d:	66 90                	xchg   %ax,%ax
 b6f:	90                   	nop

00000b70 <printint>:
 b70:	55                   	push   %ebp
 b71:	89 e5                	mov    %esp,%ebp
 b73:	57                   	push   %edi
 b74:	56                   	push   %esi
 b75:	53                   	push   %ebx
 b76:	83 ec 3c             	sub    $0x3c,%esp
 b79:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 b7c:	89 d1                	mov    %edx,%ecx
 b7e:	89 45 b8             	mov    %eax,-0x48(%ebp)
 b81:	85 d2                	test   %edx,%edx
 b83:	0f 89 7f 00 00 00    	jns    c08 <printint+0x98>
 b89:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 b8d:	74 79                	je     c08 <printint+0x98>
 b8f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
 b96:	f7 d9                	neg    %ecx
 b98:	31 db                	xor    %ebx,%ebx
 b9a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 b9d:	8d 76 00             	lea    0x0(%esi),%esi
 ba0:	89 c8                	mov    %ecx,%eax
 ba2:	31 d2                	xor    %edx,%edx
 ba4:	89 cf                	mov    %ecx,%edi
 ba6:	f7 75 c4             	divl   -0x3c(%ebp)
 ba9:	0f b6 92 44 14 00 00 	movzbl 0x1444(%edx),%edx
 bb0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 bb3:	89 d8                	mov    %ebx,%eax
 bb5:	8d 5b 01             	lea    0x1(%ebx),%ebx
 bb8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 bbb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
 bbe:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 bc1:	76 dd                	jbe    ba0 <printint+0x30>
 bc3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 bc6:	85 c9                	test   %ecx,%ecx
 bc8:	74 0c                	je     bd6 <printint+0x66>
 bca:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 bcf:	89 d8                	mov    %ebx,%eax
 bd1:	ba 2d 00 00 00       	mov    $0x2d,%edx
 bd6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 bd9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 bdd:	eb 07                	jmp    be6 <printint+0x76>
 bdf:	90                   	nop
 be0:	0f b6 13             	movzbl (%ebx),%edx
 be3:	83 eb 01             	sub    $0x1,%ebx
 be6:	83 ec 04             	sub    $0x4,%esp
 be9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 bec:	6a 01                	push   $0x1
 bee:	56                   	push   %esi
 bef:	57                   	push   %edi
 bf0:	e8 ce fe ff ff       	call   ac3 <write>
 bf5:	83 c4 10             	add    $0x10,%esp
 bf8:	39 de                	cmp    %ebx,%esi
 bfa:	75 e4                	jne    be0 <printint+0x70>
 bfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 bff:	5b                   	pop    %ebx
 c00:	5e                   	pop    %esi
 c01:	5f                   	pop    %edi
 c02:	5d                   	pop    %ebp
 c03:	c3                   	ret    
 c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 c08:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 c0f:	eb 87                	jmp    b98 <printint+0x28>
 c11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c1f:	90                   	nop

00000c20 <printf>:
 c20:	55                   	push   %ebp
 c21:	89 e5                	mov    %esp,%ebp
 c23:	57                   	push   %edi
 c24:	56                   	push   %esi
 c25:	53                   	push   %ebx
 c26:	83 ec 2c             	sub    $0x2c,%esp
 c29:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 c2c:	8b 75 08             	mov    0x8(%ebp),%esi
 c2f:	0f b6 13             	movzbl (%ebx),%edx
 c32:	84 d2                	test   %dl,%dl
 c34:	74 6a                	je     ca0 <printf+0x80>
 c36:	8d 45 10             	lea    0x10(%ebp),%eax
 c39:	83 c3 01             	add    $0x1,%ebx
 c3c:	8d 7d e7             	lea    -0x19(%ebp),%edi
 c3f:	31 c9                	xor    %ecx,%ecx
 c41:	89 45 d0             	mov    %eax,-0x30(%ebp)
 c44:	eb 36                	jmp    c7c <printf+0x5c>
 c46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c4d:	8d 76 00             	lea    0x0(%esi),%esi
 c50:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 c53:	b9 25 00 00 00       	mov    $0x25,%ecx
 c58:	83 f8 25             	cmp    $0x25,%eax
 c5b:	74 15                	je     c72 <printf+0x52>
 c5d:	83 ec 04             	sub    $0x4,%esp
 c60:	88 55 e7             	mov    %dl,-0x19(%ebp)
 c63:	6a 01                	push   $0x1
 c65:	57                   	push   %edi
 c66:	56                   	push   %esi
 c67:	e8 57 fe ff ff       	call   ac3 <write>
 c6c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 c6f:	83 c4 10             	add    $0x10,%esp
 c72:	0f b6 13             	movzbl (%ebx),%edx
 c75:	83 c3 01             	add    $0x1,%ebx
 c78:	84 d2                	test   %dl,%dl
 c7a:	74 24                	je     ca0 <printf+0x80>
 c7c:	0f b6 c2             	movzbl %dl,%eax
 c7f:	85 c9                	test   %ecx,%ecx
 c81:	74 cd                	je     c50 <printf+0x30>
 c83:	83 f9 25             	cmp    $0x25,%ecx
 c86:	75 ea                	jne    c72 <printf+0x52>
 c88:	83 f8 25             	cmp    $0x25,%eax
 c8b:	0f 84 07 01 00 00    	je     d98 <printf+0x178>
 c91:	83 e8 63             	sub    $0x63,%eax
 c94:	83 f8 15             	cmp    $0x15,%eax
 c97:	77 17                	ja     cb0 <printf+0x90>
 c99:	ff 24 85 ec 13 00 00 	jmp    *0x13ec(,%eax,4)
 ca0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ca3:	5b                   	pop    %ebx
 ca4:	5e                   	pop    %esi
 ca5:	5f                   	pop    %edi
 ca6:	5d                   	pop    %ebp
 ca7:	c3                   	ret    
 ca8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 caf:	90                   	nop
 cb0:	83 ec 04             	sub    $0x4,%esp
 cb3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 cb6:	6a 01                	push   $0x1
 cb8:	57                   	push   %edi
 cb9:	56                   	push   %esi
 cba:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 cbe:	e8 00 fe ff ff       	call   ac3 <write>
 cc3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 cc7:	83 c4 0c             	add    $0xc,%esp
 cca:	88 55 e7             	mov    %dl,-0x19(%ebp)
 ccd:	6a 01                	push   $0x1
 ccf:	57                   	push   %edi
 cd0:	56                   	push   %esi
 cd1:	e8 ed fd ff ff       	call   ac3 <write>
 cd6:	83 c4 10             	add    $0x10,%esp
 cd9:	31 c9                	xor    %ecx,%ecx
 cdb:	eb 95                	jmp    c72 <printf+0x52>
 cdd:	8d 76 00             	lea    0x0(%esi),%esi
 ce0:	83 ec 0c             	sub    $0xc,%esp
 ce3:	b9 10 00 00 00       	mov    $0x10,%ecx
 ce8:	6a 00                	push   $0x0
 cea:	8b 45 d0             	mov    -0x30(%ebp),%eax
 ced:	8b 10                	mov    (%eax),%edx
 cef:	89 f0                	mov    %esi,%eax
 cf1:	e8 7a fe ff ff       	call   b70 <printint>
 cf6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 cfa:	83 c4 10             	add    $0x10,%esp
 cfd:	31 c9                	xor    %ecx,%ecx
 cff:	e9 6e ff ff ff       	jmp    c72 <printf+0x52>
 d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 d08:	8b 45 d0             	mov    -0x30(%ebp),%eax
 d0b:	8b 10                	mov    (%eax),%edx
 d0d:	83 c0 04             	add    $0x4,%eax
 d10:	89 45 d0             	mov    %eax,-0x30(%ebp)
 d13:	85 d2                	test   %edx,%edx
 d15:	0f 84 8d 00 00 00    	je     da8 <printf+0x188>
 d1b:	0f b6 02             	movzbl (%edx),%eax
 d1e:	31 c9                	xor    %ecx,%ecx
 d20:	84 c0                	test   %al,%al
 d22:	0f 84 4a ff ff ff    	je     c72 <printf+0x52>
 d28:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 d2b:	89 d3                	mov    %edx,%ebx
 d2d:	8d 76 00             	lea    0x0(%esi),%esi
 d30:	83 ec 04             	sub    $0x4,%esp
 d33:	83 c3 01             	add    $0x1,%ebx
 d36:	88 45 e7             	mov    %al,-0x19(%ebp)
 d39:	6a 01                	push   $0x1
 d3b:	57                   	push   %edi
 d3c:	56                   	push   %esi
 d3d:	e8 81 fd ff ff       	call   ac3 <write>
 d42:	0f b6 03             	movzbl (%ebx),%eax
 d45:	83 c4 10             	add    $0x10,%esp
 d48:	84 c0                	test   %al,%al
 d4a:	75 e4                	jne    d30 <printf+0x110>
 d4c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 d4f:	31 c9                	xor    %ecx,%ecx
 d51:	e9 1c ff ff ff       	jmp    c72 <printf+0x52>
 d56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 d5d:	8d 76 00             	lea    0x0(%esi),%esi
 d60:	83 ec 0c             	sub    $0xc,%esp
 d63:	b9 0a 00 00 00       	mov    $0xa,%ecx
 d68:	6a 01                	push   $0x1
 d6a:	e9 7b ff ff ff       	jmp    cea <printf+0xca>
 d6f:	90                   	nop
 d70:	8b 45 d0             	mov    -0x30(%ebp),%eax
 d73:	83 ec 04             	sub    $0x4,%esp
 d76:	8b 00                	mov    (%eax),%eax
 d78:	6a 01                	push   $0x1
 d7a:	57                   	push   %edi
 d7b:	56                   	push   %esi
 d7c:	88 45 e7             	mov    %al,-0x19(%ebp)
 d7f:	e8 3f fd ff ff       	call   ac3 <write>
 d84:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 d88:	83 c4 10             	add    $0x10,%esp
 d8b:	31 c9                	xor    %ecx,%ecx
 d8d:	e9 e0 fe ff ff       	jmp    c72 <printf+0x52>
 d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 d98:	88 55 e7             	mov    %dl,-0x19(%ebp)
 d9b:	83 ec 04             	sub    $0x4,%esp
 d9e:	e9 2a ff ff ff       	jmp    ccd <printf+0xad>
 da3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 da7:	90                   	nop
 da8:	ba e4 13 00 00       	mov    $0x13e4,%edx
 dad:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 db0:	b8 28 00 00 00       	mov    $0x28,%eax
 db5:	89 d3                	mov    %edx,%ebx
 db7:	e9 74 ff ff ff       	jmp    d30 <printf+0x110>
 dbc:	66 90                	xchg   %ax,%ax
 dbe:	66 90                	xchg   %ax,%ax

00000dc0 <free>:
 dc0:	55                   	push   %ebp
 dc1:	a1 ec 17 00 00       	mov    0x17ec,%eax
 dc6:	89 e5                	mov    %esp,%ebp
 dc8:	57                   	push   %edi
 dc9:	56                   	push   %esi
 dca:	53                   	push   %ebx
 dcb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 dce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 dd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 dd8:	89 c2                	mov    %eax,%edx
 dda:	8b 00                	mov    (%eax),%eax
 ddc:	39 ca                	cmp    %ecx,%edx
 dde:	73 30                	jae    e10 <free+0x50>
 de0:	39 c1                	cmp    %eax,%ecx
 de2:	72 04                	jb     de8 <free+0x28>
 de4:	39 c2                	cmp    %eax,%edx
 de6:	72 f0                	jb     dd8 <free+0x18>
 de8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 deb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 dee:	39 f8                	cmp    %edi,%eax
 df0:	74 30                	je     e22 <free+0x62>
 df2:	89 43 f8             	mov    %eax,-0x8(%ebx)
 df5:	8b 42 04             	mov    0x4(%edx),%eax
 df8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 dfb:	39 f1                	cmp    %esi,%ecx
 dfd:	74 3a                	je     e39 <free+0x79>
 dff:	89 0a                	mov    %ecx,(%edx)
 e01:	5b                   	pop    %ebx
 e02:	89 15 ec 17 00 00    	mov    %edx,0x17ec
 e08:	5e                   	pop    %esi
 e09:	5f                   	pop    %edi
 e0a:	5d                   	pop    %ebp
 e0b:	c3                   	ret    
 e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 e10:	39 c2                	cmp    %eax,%edx
 e12:	72 c4                	jb     dd8 <free+0x18>
 e14:	39 c1                	cmp    %eax,%ecx
 e16:	73 c0                	jae    dd8 <free+0x18>
 e18:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e1b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e1e:	39 f8                	cmp    %edi,%eax
 e20:	75 d0                	jne    df2 <free+0x32>
 e22:	03 70 04             	add    0x4(%eax),%esi
 e25:	89 73 fc             	mov    %esi,-0x4(%ebx)
 e28:	8b 02                	mov    (%edx),%eax
 e2a:	8b 00                	mov    (%eax),%eax
 e2c:	89 43 f8             	mov    %eax,-0x8(%ebx)
 e2f:	8b 42 04             	mov    0x4(%edx),%eax
 e32:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 e35:	39 f1                	cmp    %esi,%ecx
 e37:	75 c6                	jne    dff <free+0x3f>
 e39:	03 43 fc             	add    -0x4(%ebx),%eax
 e3c:	89 15 ec 17 00 00    	mov    %edx,0x17ec
 e42:	89 42 04             	mov    %eax,0x4(%edx)
 e45:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 e48:	89 0a                	mov    %ecx,(%edx)
 e4a:	5b                   	pop    %ebx
 e4b:	5e                   	pop    %esi
 e4c:	5f                   	pop    %edi
 e4d:	5d                   	pop    %ebp
 e4e:	c3                   	ret    
 e4f:	90                   	nop

00000e50 <malloc>:
 e50:	55                   	push   %ebp
 e51:	89 e5                	mov    %esp,%ebp
 e53:	57                   	push   %edi
 e54:	56                   	push   %esi
 e55:	53                   	push   %ebx
 e56:	83 ec 1c             	sub    $0x1c,%esp
 e59:	8b 45 08             	mov    0x8(%ebp),%eax
 e5c:	8b 3d ec 17 00 00    	mov    0x17ec,%edi
 e62:	8d 70 07             	lea    0x7(%eax),%esi
 e65:	c1 ee 03             	shr    $0x3,%esi
 e68:	83 c6 01             	add    $0x1,%esi
 e6b:	85 ff                	test   %edi,%edi
 e6d:	0f 84 9d 00 00 00    	je     f10 <malloc+0xc0>
 e73:	8b 17                	mov    (%edi),%edx
 e75:	8b 4a 04             	mov    0x4(%edx),%ecx
 e78:	39 f1                	cmp    %esi,%ecx
 e7a:	73 6a                	jae    ee6 <malloc+0x96>
 e7c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 e81:	39 de                	cmp    %ebx,%esi
 e83:	0f 43 de             	cmovae %esi,%ebx
 e86:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 e8d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 e90:	eb 17                	jmp    ea9 <malloc+0x59>
 e92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 e98:	8b 02                	mov    (%edx),%eax
 e9a:	8b 48 04             	mov    0x4(%eax),%ecx
 e9d:	39 f1                	cmp    %esi,%ecx
 e9f:	73 4f                	jae    ef0 <malloc+0xa0>
 ea1:	8b 3d ec 17 00 00    	mov    0x17ec,%edi
 ea7:	89 c2                	mov    %eax,%edx
 ea9:	39 d7                	cmp    %edx,%edi
 eab:	75 eb                	jne    e98 <malloc+0x48>
 ead:	83 ec 0c             	sub    $0xc,%esp
 eb0:	ff 75 e4             	push   -0x1c(%ebp)
 eb3:	e8 73 fc ff ff       	call   b2b <sbrk>
 eb8:	83 c4 10             	add    $0x10,%esp
 ebb:	83 f8 ff             	cmp    $0xffffffff,%eax
 ebe:	74 1c                	je     edc <malloc+0x8c>
 ec0:	89 58 04             	mov    %ebx,0x4(%eax)
 ec3:	83 ec 0c             	sub    $0xc,%esp
 ec6:	83 c0 08             	add    $0x8,%eax
 ec9:	50                   	push   %eax
 eca:	e8 f1 fe ff ff       	call   dc0 <free>
 ecf:	8b 15 ec 17 00 00    	mov    0x17ec,%edx
 ed5:	83 c4 10             	add    $0x10,%esp
 ed8:	85 d2                	test   %edx,%edx
 eda:	75 bc                	jne    e98 <malloc+0x48>
 edc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 edf:	31 c0                	xor    %eax,%eax
 ee1:	5b                   	pop    %ebx
 ee2:	5e                   	pop    %esi
 ee3:	5f                   	pop    %edi
 ee4:	5d                   	pop    %ebp
 ee5:	c3                   	ret    
 ee6:	89 d0                	mov    %edx,%eax
 ee8:	89 fa                	mov    %edi,%edx
 eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 ef0:	39 ce                	cmp    %ecx,%esi
 ef2:	74 4c                	je     f40 <malloc+0xf0>
 ef4:	29 f1                	sub    %esi,%ecx
 ef6:	89 48 04             	mov    %ecx,0x4(%eax)
 ef9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 efc:	89 70 04             	mov    %esi,0x4(%eax)
 eff:	89 15 ec 17 00 00    	mov    %edx,0x17ec
 f05:	8d 65 f4             	lea    -0xc(%ebp),%esp
 f08:	83 c0 08             	add    $0x8,%eax
 f0b:	5b                   	pop    %ebx
 f0c:	5e                   	pop    %esi
 f0d:	5f                   	pop    %edi
 f0e:	5d                   	pop    %ebp
 f0f:	c3                   	ret    
 f10:	c7 05 ec 17 00 00 f0 	movl   $0x17f0,0x17ec
 f17:	17 00 00 
 f1a:	bf f0 17 00 00       	mov    $0x17f0,%edi
 f1f:	c7 05 f0 17 00 00 f0 	movl   $0x17f0,0x17f0
 f26:	17 00 00 
 f29:	89 fa                	mov    %edi,%edx
 f2b:	c7 05 f4 17 00 00 00 	movl   $0x0,0x17f4
 f32:	00 00 00 
 f35:	e9 42 ff ff ff       	jmp    e7c <malloc+0x2c>
 f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 f40:	8b 08                	mov    (%eax),%ecx
 f42:	89 0a                	mov    %ecx,(%edx)
 f44:	eb b9                	jmp    eff <malloc+0xaf>
