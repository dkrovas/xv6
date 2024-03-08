
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
  11:	68 c6 13 00 00       	push   $0x13c6
  16:	6a 01                	push   $0x1
  18:	e8 f3 0b 00 00       	call   c10 <printf>
  //test_2_page_map_unmap();
  //test_mult_map_diff_touches();
  //test_map_fixed();
  //test_out_of_va();
  test_wmapinfo();
  1d:	e8 9e 04 00 00       	call   4c0 <test_wmapinfo>
  //test_remap();
  exit();
  22:	e8 6c 0a 00 00       	call   a93 <exit>
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
  39:	68 38 0f 00 00       	push   $0xf38
  3e:	6a 01                	push   $0x1
  40:	e8 cb 0b 00 00       	call   c10 <printf>
  printf(1, "\t-wmapping 0\n");
  45:	59                   	pop    %ecx
  46:	5b                   	pop    %ebx
  47:	68 77 11 00 00       	push   $0x1177
  4c:	6a 01                	push   $0x1
  4e:	e8 bd 0b 00 00       	call   c10 <printf>
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  53:	6a ff                	push   $0xffffffff
  55:	6a 0e                	push   $0xe
  57:	68 00 20 00 00       	push   $0x2000
  5c:	68 00 00 00 60       	push   $0x60000000
  61:	e8 cd 0a 00 00       	call   b33 <wmap>
  printf(1, "\t-touching 0\n");
  66:	83 c4 18             	add    $0x18,%esp
  69:	68 85 11 00 00       	push   $0x1185
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  6e:	89 c3                	mov    %eax,%ebx
  printf(1, "\t-touching 0\n");
  70:	6a 01                	push   $0x1
  72:	e8 99 0b 00 00       	call   c10 <printf>
  ptr0[0] = 'a';
  77:	c6 03 61             	movb   $0x61,(%ebx)
  printf(1, "\t-wmapping 1\n");
  7a:	5e                   	pop    %esi
  7b:	5f                   	pop    %edi
  7c:	68 93 11 00 00       	push   $0x1193
  81:	6a 01                	push   $0x1
  83:	e8 88 0b 00 00       	call   c10 <printf>
  uint map1 = wmap(0x60003000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  88:	6a ff                	push   $0xffffffff
  8a:	6a 0e                	push   $0xe
  8c:	68 00 10 00 00       	push   $0x1000
  91:	68 00 30 00 60       	push   $0x60003000
  96:	e8 98 0a 00 00       	call   b33 <wmap>
  printf(1, "\t-wmapping 2\n");
  9b:	83 c4 18             	add    $0x18,%esp
  9e:	68 a1 11 00 00       	push   $0x11a1
  uint map1 = wmap(0x60003000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  a3:	89 c6                	mov    %eax,%esi
  printf(1, "\t-wmapping 2\n");
  a5:	6a 01                	push   $0x1
  a7:	e8 64 0b 00 00       	call   c10 <printf>
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  ac:	6a ff                	push   $0xffffffff
  ae:	6a 0e                	push   $0xe
  b0:	68 00 10 00 00       	push   $0x1000
  b5:	68 00 20 00 60       	push   $0x60002000
  ba:	e8 74 0a 00 00       	call   b33 <wmap>
    printf(1, "\t-touching 1\n");
  bf:	83 c4 18             	add    $0x18,%esp
  c2:	68 af 11 00 00       	push   $0x11af
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  c7:	89 c7                	mov    %eax,%edi
    printf(1, "\t-touching 1\n");
  c9:	6a 01                	push   $0x1
  cb:	e8 40 0b 00 00       	call   c10 <printf>
  ptr1[0] = 'b';
  d0:	c6 06 62             	movb   $0x62,(%esi)
  printf(1, "\t-map0 %c map1 %c\n", ptr0[0], ptr1[0]);
  d3:	6a 62                	push   $0x62
  d5:	0f be 03             	movsbl (%ebx),%eax
  d8:	50                   	push   %eax
  d9:	68 bd 11 00 00       	push   $0x11bd
  de:	6a 01                	push   $0x1
  e0:	e8 2b 0b 00 00       	call   c10 <printf>
  printf(1, "\nRESULT: ");
  e5:	83 c4 18             	add    $0x18,%esp
  e8:	68 d0 11 00 00       	push   $0x11d0
  ed:	6a 01                	push   $0x1
  ef:	e8 1c 0b 00 00       	call   c10 <printf>
  if (ptr0[0] == 'a' && ptr1[0] == 'b') {
  f4:	83 c4 10             	add    $0x10,%esp
  f7:	80 3b 61             	cmpb   $0x61,(%ebx)
  fa:	75 05                	jne    101 <test_mult_map_diff_touches+0xd1>
  fc:	80 3e 62             	cmpb   $0x62,(%esi)
  ff:	74 47                	je     148 <test_mult_map_diff_touches+0x118>
    printf(1, "FAILED");
 101:	83 ec 08             	sub    $0x8,%esp
 104:	68 04 13 00 00       	push   $0x1304
 109:	6a 01                	push   $0x1
 10b:	e8 00 0b 00 00       	call   c10 <printf>
 110:	83 c4 10             	add    $0x10,%esp
  wunmap(map0);
 113:	83 ec 0c             	sub    $0xc,%esp
 116:	53                   	push   %ebx
 117:	e8 1f 0a 00 00       	call   b3b <wunmap>
  wunmap(map1);
 11c:	89 34 24             	mov    %esi,(%esp)
 11f:	e8 17 0a 00 00       	call   b3b <wunmap>
  wunmap(map2);
 124:	89 3c 24             	mov    %edi,(%esp)
 127:	e8 0f 0a 00 00       	call   b3b <wunmap>
  printf(1, "\n\n");
 12c:	58                   	pop    %eax
 12d:	5a                   	pop    %edx
 12e:	68 80 12 00 00       	push   $0x1280
 133:	6a 01                	push   $0x1
 135:	e8 d6 0a 00 00       	call   c10 <printf>
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
 14b:	68 31 13 00 00       	push   $0x1331
 150:	6a 01                	push   $0x1
 152:	e8 b9 0a 00 00       	call   c10 <printf>
 157:	83 c4 10             	add    $0x10,%esp
 15a:	eb b7                	jmp    113 <test_mult_map_diff_touches+0xe3>
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000160 <test_out_of_va>:
void test_out_of_va(void) {
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	83 ec 10             	sub    $0x10,%esp
  printf(1, "Testing test_out_of_va\n");
 166:	68 da 11 00 00       	push   $0x11da
 16b:	6a 01                	push   $0x1
 16d:	e8 9e 0a 00 00       	call   c10 <printf>
  printf(1, "\t-wmapping 0 to max size\n");
 172:	58                   	pop    %eax
 173:	5a                   	pop    %edx
 174:	68 f2 11 00 00       	push   $0x11f2
 179:	6a 01                	push   $0x1
 17b:	e8 90 0a 00 00       	call   c10 <printf>
  uint map0 = wmap(0x60000000, 0x20000000, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 180:	6a ff                	push   $0xffffffff
 182:	6a 0e                	push   $0xe
 184:	68 00 00 00 20       	push   $0x20000000
 189:	68 00 00 00 60       	push   $0x60000000
 18e:	e8 a0 09 00 00       	call   b33 <wmap>
  printf(1, "\t-wmapping 1, so we get error message\n");
 193:	83 c4 18             	add    $0x18,%esp
 196:	68 58 0f 00 00       	push   $0xf58
 19b:	6a 01                	push   $0x1
 19d:	e8 6e 0a 00 00       	call   c10 <printf>
  uint map1 = wmap(0x60001000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 1a2:	6a ff                	push   $0xffffffff
 1a4:	6a 0e                	push   $0xe
 1a6:	68 00 10 00 00       	push   $0x1000
 1ab:	68 00 10 00 60       	push   $0x60001000
 1b0:	e8 7e 09 00 00       	call   b33 <wmap>
  printf(1, "\nCheck if got error message above\n");
 1b5:	83 c4 18             	add    $0x18,%esp
 1b8:	68 80 0f 00 00       	push   $0xf80
 1bd:	6a 01                	push   $0x1
 1bf:	e8 4c 0a 00 00       	call   c10 <printf>
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
 1d8:	68 0c 12 00 00       	push   $0x120c
 1dd:	6a 01                	push   $0x1
 1df:	e8 2c 0a 00 00       	call   c10 <printf>
  printf(1, "\t-testing basic functionality\n");
 1e4:	58                   	pop    %eax
 1e5:	5a                   	pop    %edx
 1e6:	68 a4 0f 00 00       	push   $0xfa4
 1eb:	6a 01                	push   $0x1
 1ed:	e8 1e 0a 00 00       	call   c10 <printf>
  printf(1, "\t-wmapping 0 as fixed\n");
 1f2:	59                   	pop    %ecx
 1f3:	5b                   	pop    %ebx
 1f4:	68 24 12 00 00       	push   $0x1224
 1f9:	6a 01                	push   $0x1
 1fb:	e8 10 0a 00 00       	call   c10 <printf>
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 200:	6a ff                	push   $0xffffffff
 202:	6a 0e                	push   $0xe
 204:	68 00 20 00 00       	push   $0x2000
 209:	68 00 00 00 60       	push   $0x60000000
 20e:	e8 20 09 00 00       	call   b33 <wmap>
  printf(1, "\t-wmapping 1 as not fixed, trying to get other addr\n");
 213:	83 c4 18             	add    $0x18,%esp
 216:	68 c4 0f 00 00       	push   $0xfc4
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 21b:	89 c6                	mov    %eax,%esi
  printf(1, "\t-wmapping 1 as not fixed, trying to get other addr\n");
 21d:	6a 01                	push   $0x1
 21f:	e8 ec 09 00 00       	call   c10 <printf>
  uint map1 = wmap(0x60000000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
 224:	6a ff                	push   $0xffffffff
 226:	6a 06                	push   $0x6
 228:	68 00 20 00 00       	push   $0x2000
 22d:	68 00 00 00 60       	push   $0x60000000
 232:	e8 fc 08 00 00       	call   b33 <wmap>
  printf(1, "\nShould be 0x60002000\n\n");
 237:	83 c4 18             	add    $0x18,%esp
 23a:	68 3b 12 00 00       	push   $0x123b
  uint map1 = wmap(0x60000000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
 23f:	89 c3                	mov    %eax,%ebx
  printf(1, "\nShould be 0x60002000\n\n");
 241:	6a 01                	push   $0x1
 243:	e8 c8 09 00 00       	call   c10 <printf>
  printf(1, "\t-testing if doesn't break with endpoints\n");
 248:	58                   	pop    %eax
 249:	5a                   	pop    %edx
 24a:	68 fc 0f 00 00       	push   $0xffc
 24f:	6a 01                	push   $0x1
 251:	e8 ba 09 00 00       	call   c10 <printf>
  wunmap(map0);
 256:	89 34 24             	mov    %esi,(%esp)
 259:	e8 dd 08 00 00       	call   b3b <wunmap>
  printf(1, "\t-wmapping 0 as not fixed, trying to get other addr\n");
 25e:	59                   	pop    %ecx
 25f:	5e                   	pop    %esi
 260:	68 28 10 00 00       	push   $0x1028
 265:	6a 01                	push   $0x1
 267:	e8 a4 09 00 00       	call   c10 <printf>
  map0 = wmap(0x60000000, 4096 * 3, MAP_SHARED | MAP_ANONYMOUS, -1);
 26c:	6a ff                	push   $0xffffffff
 26e:	6a 06                	push   $0x6
 270:	68 00 30 00 00       	push   $0x3000
 275:	68 00 00 00 60       	push   $0x60000000
 27a:	e8 b4 08 00 00       	call   b33 <wmap>
  printf(1, "\nShould be 0x60004000\n\n");
 27f:	83 c4 18             	add    $0x18,%esp
 282:	68 53 12 00 00       	push   $0x1253
  map0 = wmap(0x60000000, 4096 * 3, MAP_SHARED | MAP_ANONYMOUS, -1);
 287:	89 c6                	mov    %eax,%esi
  printf(1, "\nShould be 0x60004000\n\n");
 289:	6a 01                	push   $0x1
 28b:	e8 80 09 00 00       	call   c10 <printf>
  printf(1, "\t-testing if doesn't break if exceding 0x80000000\n");
 290:	58                   	pop    %eax
 291:	5a                   	pop    %edx
 292:	68 60 10 00 00       	push   $0x1060
 297:	6a 01                	push   $0x1
 299:	e8 72 09 00 00       	call   c10 <printf>
  wunmap(map0);
 29e:	89 34 24             	mov    %esi,(%esp)
 2a1:	e8 95 08 00 00       	call   b3b <wunmap>
  wunmap(map1);
 2a6:	89 1c 24             	mov    %ebx,(%esp)
 2a9:	e8 8d 08 00 00       	call   b3b <wunmap>
  printf(1, "\t-wmapping 0 as fixed at 0x7fffe000\n");
 2ae:	59                   	pop    %ecx
 2af:	5b                   	pop    %ebx
 2b0:	68 94 10 00 00       	push   $0x1094
 2b5:	6a 01                	push   $0x1
 2b7:	e8 54 09 00 00       	call   c10 <printf>
  map0 = wmap(0x7fffe000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 2bc:	6a ff                	push   $0xffffffff
 2be:	6a 0e                	push   $0xe
 2c0:	68 00 10 00 00       	push   $0x1000
 2c5:	68 00 e0 ff 7f       	push   $0x7fffe000
 2ca:	e8 64 08 00 00       	call   b33 <wmap>
  printf(1, "\t-wmapping 1 with 8192, needing to loop\n");
 2cf:	83 c4 18             	add    $0x18,%esp
 2d2:	68 bc 10 00 00       	push   $0x10bc
  map0 = wmap(0x7fffe000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 2d7:	89 c6                	mov    %eax,%esi
  printf(1, "\t-wmapping 1 with 8192, needing to loop\n");
 2d9:	6a 01                	push   $0x1
 2db:	e8 30 09 00 00       	call   c10 <printf>
  map1 = wmap(0x7fffe000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
 2e0:	6a ff                	push   $0xffffffff
 2e2:	6a 06                	push   $0x6
 2e4:	68 00 20 00 00       	push   $0x2000
 2e9:	68 00 e0 ff 7f       	push   $0x7fffe000
 2ee:	e8 40 08 00 00       	call   b33 <wmap>
  printf(1, "\nShould be 0x60000000\n\n");
 2f3:	83 c4 18             	add    $0x18,%esp
 2f6:	68 6b 12 00 00       	push   $0x126b
  map1 = wmap(0x7fffe000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
 2fb:	89 c3                	mov    %eax,%ebx
  printf(1, "\nShould be 0x60000000\n\n");
 2fd:	6a 01                	push   $0x1
 2ff:	e8 0c 09 00 00       	call   c10 <printf>
  wunmap(map0);
 304:	89 34 24             	mov    %esi,(%esp)
 307:	e8 2f 08 00 00       	call   b3b <wunmap>
  wunmap(map1);
 30c:	89 1c 24             	mov    %ebx,(%esp)
 30f:	e8 27 08 00 00       	call   b3b <wunmap>
  printf(1, "\n\n");
 314:	5e                   	pop    %esi
 315:	58                   	pop    %eax
 316:	68 80 12 00 00       	push   $0x1280
 31b:	6a 01                	push   $0x1
 31d:	e8 ee 08 00 00       	call   c10 <printf>
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
 336:	68 83 12 00 00       	push   $0x1283
 33b:	6a 01                	push   $0x1
 33d:	e8 ce 08 00 00       	call   c10 <printf>
  printf(1, "\t-testing if ifs are right");
 342:	58                   	pop    %eax
 343:	5a                   	pop    %edx
 344:	68 97 12 00 00       	push   $0x1297
 349:	6a 01                	push   $0x1
 34b:	e8 c0 08 00 00       	call   c10 <printf>
  uint map0 = wmap(0x60000000, 4096,  MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 350:	6a ff                	push   $0xffffffff
 352:	6a 0e                	push   $0xe
 354:	68 00 10 00 00       	push   $0x1000
 359:	68 00 00 00 60       	push   $0x60000000
 35e:	e8 d0 07 00 00       	call   b33 <wmap>
  wremap(0x60000000, 4096, 8192, 0);
 363:	83 c4 20             	add    $0x20,%esp
 366:	6a 00                	push   $0x0
 368:	68 00 20 00 00       	push   $0x2000
 36d:	68 00 10 00 00       	push   $0x1000
 372:	68 00 00 00 60       	push   $0x60000000
 377:	e8 c7 07 00 00       	call   b43 <wremap>
  printf(1, "Should be Valid for in place\n\n");
 37c:	59                   	pop    %ecx
 37d:	58                   	pop    %eax
 37e:	68 e8 10 00 00       	push   $0x10e8
 383:	6a 01                	push   $0x1
 385:	e8 86 08 00 00       	call   c10 <printf>
  wremap(0x60000000, 4096, 8192, MREMAP_MAYMOVE);
 38a:	6a 01                	push   $0x1
 38c:	68 00 20 00 00       	push   $0x2000
 391:	68 00 10 00 00       	push   $0x1000
 396:	68 00 00 00 60       	push   $0x60000000
 39b:	e8 a3 07 00 00       	call   b43 <wremap>
  printf(1, "Should be Valid for in place\n\n");
 3a0:	83 c4 18             	add    $0x18,%esp
 3a3:	68 e8 10 00 00       	push   $0x10e8
 3a8:	6a 01                	push   $0x1
 3aa:	e8 61 08 00 00       	call   c10 <printf>
  uint map1 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 3af:	6a ff                	push   $0xffffffff
 3b1:	6a 0e                	push   $0xe
 3b3:	68 00 10 00 00       	push   $0x1000
 3b8:	68 00 20 00 60       	push   $0x60002000
 3bd:	e8 71 07 00 00       	call   b33 <wmap>
  wremap(0x60000000, 4096, 8192, 0);
 3c2:	83 c4 20             	add    $0x20,%esp
 3c5:	6a 00                	push   $0x0
 3c7:	68 00 20 00 00       	push   $0x2000
 3cc:	68 00 10 00 00       	push   $0x1000
 3d1:	68 00 00 00 60       	push   $0x60000000
 3d6:	e8 68 07 00 00       	call   b43 <wremap>
  printf(1, "Should be Cannot\n\n");
 3db:	58                   	pop    %eax
 3dc:	5a                   	pop    %edx
 3dd:	68 b2 12 00 00       	push   $0x12b2
 3e2:	6a 01                	push   $0x1
 3e4:	e8 27 08 00 00       	call   c10 <printf>
  wremap(0x60000000, 4096, 8192, 0);
 3e9:	6a 00                	push   $0x0
 3eb:	68 00 20 00 00       	push   $0x2000
 3f0:	68 00 10 00 00       	push   $0x1000
 3f5:	68 00 00 00 60       	push   $0x60000000
 3fa:	e8 44 07 00 00       	call   b43 <wremap>
  printf(1, "Should be valid for moving\n\n");
 3ff:	83 c4 18             	add    $0x18,%esp
 402:	68 c5 12 00 00       	push   $0x12c5
 407:	6a 01                	push   $0x1
 409:	e8 02 08 00 00       	call   c10 <printf>
  return;
 40e:	83 c4 10             	add    $0x10,%esp
}
 411:	c9                   	leave  
 412:	c3                   	ret    
 413:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 41a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000420 <test_2_page_map_unmap>:
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	53                   	push   %ebx
 424:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "Testing Mapping and unmapping multipages:\n");
 427:	68 08 11 00 00       	push   $0x1108
 42c:	6a 01                	push   $0x1
 42e:	e8 dd 07 00 00       	call   c10 <printf>
  uint map = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 433:	6a ff                	push   $0xffffffff
 435:	6a 0e                	push   $0xe
 437:	68 00 20 00 00       	push   $0x2000
 43c:	68 00 00 00 60       	push   $0x60000000
 441:	e8 ed 06 00 00       	call   b33 <wmap>
  if (map == 0) {
 446:	83 c4 20             	add    $0x20,%esp
 449:	85 c0                	test   %eax,%eax
 44b:	74 5a                	je     4a7 <test_2_page_map_unmap+0x87>
 44d:	89 c3                	mov    %eax,%ebx
 44f:	8d 88 00 10 00 00    	lea    0x1000(%eax),%ecx
 455:	89 c2                	mov    %eax,%edx
 457:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 45e:	66 90                	xchg   %ax,%ax
    ptr[i] = 'f';
 460:	c6 02 66             	movb   $0x66,(%edx)
  for(int i=0;i<4096;i++){
 463:	83 c2 01             	add    $0x1,%edx
 466:	39 d1                	cmp    %edx,%ecx
 468:	75 f6                	jne    460 <test_2_page_map_unmap+0x40>
  printf(1, "\t-ptr = %c, map = %x mapped\n", ptr[0], map);
 46a:	53                   	push   %ebx
 46b:	0f be 03             	movsbl (%ebx),%eax
 46e:	50                   	push   %eax
 46f:	68 0b 13 00 00       	push   $0x130b
 474:	6a 01                	push   $0x1
 476:	e8 95 07 00 00       	call   c10 <printf>
  wunmap(map);
 47b:	89 1c 24             	mov    %ebx,(%esp)
 47e:	e8 b8 06 00 00       	call   b3b <wunmap>
  printf(1, "\nRESULT: PASSED");
 483:	59                   	pop    %ecx
 484:	5b                   	pop    %ebx
 485:	68 28 13 00 00       	push   $0x1328
 48a:	6a 01                	push   $0x1
 48c:	e8 7f 07 00 00       	call   c10 <printf>
  printf(1, "\n\n");
 491:	58                   	pop    %eax
 492:	5a                   	pop    %edx
 493:	68 80 12 00 00       	push   $0x1280
 498:	6a 01                	push   $0x1
 49a:	e8 71 07 00 00       	call   c10 <printf>
}
 49f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return;
 4a2:	83 c4 10             	add    $0x10,%esp
}
 4a5:	c9                   	leave  
 4a6:	c3                   	ret    
    printf(1, "\t-Error mapping memory.\n");
 4a7:	83 ec 08             	sub    $0x8,%esp
 4aa:	68 e2 12 00 00       	push   $0x12e2
 4af:	6a 01                	push   $0x1
 4b1:	e8 5a 07 00 00       	call   c10 <printf>
    printf(1, "\nRESULT: FAILED");
 4b6:	58                   	pop    %eax
 4b7:	5a                   	pop    %edx
 4b8:	68 fb 12 00 00       	push   $0x12fb
 4bd:	eb cb                	jmp    48a <test_2_page_map_unmap+0x6a>
 4bf:	90                   	nop

000004c0 <test_wmapinfo>:
void test_wmapinfo(void){
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
 4c6:	81 ec f4 00 00 00    	sub    $0xf4,%esp
  printf(1, "Testing wmapinfo\n");
 4cc:	68 38 13 00 00       	push   $0x1338
 4d1:	6a 01                	push   $0x1
 4d3:	e8 38 07 00 00       	call   c10 <printf>
  uint map = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 4d8:	6a ff                	push   $0xffffffff
 4da:	6a 0e                	push   $0xe
 4dc:	68 00 20 00 00       	push   $0x2000
 4e1:	68 00 00 00 60       	push   $0x60000000
 4e6:	e8 48 06 00 00       	call   b33 <wmap>
  if(getwmapinfo(&wminfo) < 0){
 4eb:	83 c4 14             	add    $0x14,%esp
  uint map = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 4ee:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  if(getwmapinfo(&wminfo) < 0){
 4f4:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
 4fa:	50                   	push   %eax
 4fb:	e8 53 06 00 00       	call   b53 <getwmapinfo>
 500:	83 c4 10             	add    $0x10,%esp
 503:	85 c0                	test   %eax,%eax
 505:	0f 88 0d 03 00 00    	js     818 <test_wmapinfo+0x358>
  printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[0]);
 50b:	83 ec 04             	sub    $0x4,%esp
 50e:	ff 75 a8             	push   -0x58(%ebp)
 511:	68 4a 13 00 00       	push   $0x134a
 516:	6a 01                	push   $0x1
 518:	e8 f3 06 00 00       	call   c10 <printf>
  ptr0[0] = 'a';
 51d:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
 523:	c6 00 61             	movb   $0x61,(%eax)
  if(getwmapinfo(&wminfo) < 0){
 526:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
 52c:	89 04 24             	mov    %eax,(%esp)
 52f:	e8 1f 06 00 00       	call   b53 <getwmapinfo>
 534:	83 c4 10             	add    $0x10,%esp
 537:	85 c0                	test   %eax,%eax
 539:	0f 88 d9 02 00 00    	js     818 <test_wmapinfo+0x358>
  printf(1, "\t-Total mmaps: %d\n", wminfo.total_mmaps);
 53f:	83 ec 04             	sub    $0x4,%esp
 542:	ff b5 24 ff ff ff    	push   -0xdc(%ebp)
 548:	8d 9d 28 ff ff ff    	lea    -0xd8(%ebp),%ebx
 54e:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
 554:	68 5e 13 00 00       	push   $0x135e
 559:	89 df                	mov    %ebx,%edi
 55b:	6a 01                	push   $0x1
 55d:	e8 ae 06 00 00       	call   c10 <printf>
  for(int i = 0; i < 16; ++i){
 562:	83 c4 10             	add    $0x10,%esp
 565:	eb 10                	jmp    577 <test_wmapinfo+0xb7>
 567:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56e:	66 90                	xchg   %ax,%ax
 570:	83 c7 04             	add    $0x4,%edi
 573:	39 f7                	cmp    %esi,%edi
 575:	74 57                	je     5ce <test_wmapinfo+0x10e>
    if(wminfo.addr[i]!=0){
 577:	8b 0f                	mov    (%edi),%ecx
 579:	85 c9                	test   %ecx,%ecx
 57b:	74 f3                	je     570 <test_wmapinfo+0xb0>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
 57d:	83 ec 04             	sub    $0x4,%esp
 580:	ff b7 80 00 00 00    	push   0x80(%edi)
  for(int i = 0; i < 16; ++i){
 586:	83 c7 04             	add    $0x4,%edi
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
 589:	68 4a 13 00 00       	push   $0x134a
 58e:	6a 01                	push   $0x1
 590:	e8 7b 06 00 00       	call   c10 <printf>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
 595:	83 c4 0c             	add    $0xc,%esp
 598:	ff 77 fc             	push   -0x4(%edi)
 59b:	68 71 13 00 00       	push   $0x1371
 5a0:	6a 01                	push   $0x1
 5a2:	e8 69 06 00 00       	call   c10 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
 5a7:	83 c4 0c             	add    $0xc,%esp
 5aa:	ff 77 3c             	push   0x3c(%edi)
 5ad:	68 86 13 00 00       	push   $0x1386
 5b2:	6a 01                	push   $0x1
 5b4:	e8 57 06 00 00       	call   c10 <printf>
      printf(1, "\n");
 5b9:	58                   	pop    %eax
 5ba:	5a                   	pop    %edx
 5bb:	68 81 12 00 00       	push   $0x1281
 5c0:	6a 01                	push   $0x1
 5c2:	e8 49 06 00 00       	call   c10 <printf>
 5c7:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
 5ca:	39 f7                	cmp    %esi,%edi
 5cc:	75 a9                	jne    577 <test_wmapinfo+0xb7>
  wunmap(map);
 5ce:	83 ec 0c             	sub    $0xc,%esp
 5d1:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
 5d7:	e8 5f 05 00 00       	call   b3b <wunmap>
  if(getwmapinfo(&wminfo) < 0){
 5dc:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
 5e2:	89 04 24             	mov    %eax,(%esp)
 5e5:	e8 69 05 00 00       	call   b53 <getwmapinfo>
 5ea:	83 c4 10             	add    $0x10,%esp
 5ed:	85 c0                	test   %eax,%eax
 5ef:	0f 88 23 02 00 00    	js     818 <test_wmapinfo+0x358>
  printf(1, "\t-Total mmaps after unmap: %d\n", wminfo.total_mmaps);
 5f5:	83 ec 04             	sub    $0x4,%esp
 5f8:	ff b5 24 ff ff ff    	push   -0xdc(%ebp)
 5fe:	89 df                	mov    %ebx,%edi
 600:	68 34 11 00 00       	push   $0x1134
 605:	6a 01                	push   $0x1
 607:	e8 04 06 00 00       	call   c10 <printf>
 60c:	83 c4 10             	add    $0x10,%esp
 60f:	eb 0e                	jmp    61f <test_wmapinfo+0x15f>
 611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(int i = 0; i < 16; ++i){
 618:	83 c7 04             	add    $0x4,%edi
 61b:	39 f7                	cmp    %esi,%edi
 61d:	74 52                	je     671 <test_wmapinfo+0x1b1>
    if(wminfo.addr[i]!=0){
 61f:	8b 07                	mov    (%edi),%eax
 621:	85 c0                	test   %eax,%eax
 623:	74 f3                	je     618 <test_wmapinfo+0x158>
      printf(1, "\t-Starting addr: %xn", wminfo.addr[i]);
 625:	83 ec 04             	sub    $0x4,%esp
  for(int i = 0; i < 16; ++i){
 628:	83 c7 04             	add    $0x4,%edi
      printf(1, "\t-Starting addr: %xn", wminfo.addr[i]);
 62b:	50                   	push   %eax
 62c:	68 98 13 00 00       	push   $0x1398
 631:	6a 01                	push   $0x1
 633:	e8 d8 05 00 00       	call   c10 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
 638:	83 c4 0c             	add    $0xc,%esp
 63b:	ff 77 3c             	push   0x3c(%edi)
 63e:	68 86 13 00 00       	push   $0x1386
 643:	6a 01                	push   $0x1
 645:	e8 c6 05 00 00       	call   c10 <printf>
       printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
 64a:	83 c4 0c             	add    $0xc,%esp
 64d:	ff 77 7c             	push   0x7c(%edi)
 650:	68 4a 13 00 00       	push   $0x134a
 655:	6a 01                	push   $0x1
 657:	e8 b4 05 00 00       	call   c10 <printf>
       printf(1, "\n");
 65c:	59                   	pop    %ecx
 65d:	58                   	pop    %eax
 65e:	68 81 12 00 00       	push   $0x1281
 663:	6a 01                	push   $0x1
 665:	e8 a6 05 00 00       	call   c10 <printf>
 66a:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
 66d:	39 f7                	cmp    %esi,%edi
 66f:	75 ae                	jne    61f <test_wmapinfo+0x15f>
  printf(1,"\n");
 671:	83 ec 08             	sub    $0x8,%esp
 674:	68 81 12 00 00       	push   $0x1281
 679:	6a 01                	push   $0x1
 67b:	e8 90 05 00 00       	call   c10 <printf>
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 680:	6a ff                	push   $0xffffffff
 682:	6a 0e                	push   $0xe
 684:	68 00 10 00 00       	push   $0x1000
 689:	68 00 20 00 60       	push   $0x60002000
 68e:	e8 a0 04 00 00       	call   b33 <wmap>
  uint map3 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 693:	83 c4 20             	add    $0x20,%esp
 696:	6a ff                	push   $0xffffffff
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 698:	89 c7                	mov    %eax,%edi
  uint map3 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 69a:	6a 0e                	push   $0xe
 69c:	68 00 20 00 00       	push   $0x2000
 6a1:	68 00 00 00 60       	push   $0x60000000
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 6a6:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  uint map3 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 6ac:	e8 82 04 00 00       	call   b33 <wmap>
  ptr2[0] = 'b';
 6b1:	c6 07 62             	movb   $0x62,(%edi)
 6b4:	83 c4 10             	add    $0x10,%esp
  uint map3 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 6b7:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
  for (int i = 0; i < 10; ++i){
 6bd:	8d 48 0a             	lea    0xa(%eax),%ecx
    ptr3[i] = 'a';
 6c0:	c6 00 61             	movb   $0x61,(%eax)
  for (int i = 0; i < 10; ++i){
 6c3:	83 c0 01             	add    $0x1,%eax
 6c6:	39 c8                	cmp    %ecx,%eax
 6c8:	75 f6                	jne    6c0 <test_wmapinfo+0x200>
  if(getwmapinfo(&wminfo) < 0){
 6ca:	83 ec 0c             	sub    $0xc,%esp
 6cd:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
 6d3:	50                   	push   %eax
 6d4:	e8 7a 04 00 00       	call   b53 <getwmapinfo>
 6d9:	83 c4 10             	add    $0x10,%esp
 6dc:	85 c0                	test   %eax,%eax
 6de:	0f 88 34 01 00 00    	js     818 <test_wmapinfo+0x358>
  printf(1, "\t-Total mmaps after more maps: %d\n", wminfo.total_mmaps);
 6e4:	83 ec 04             	sub    $0x4,%esp
 6e7:	ff b5 24 ff ff ff    	push   -0xdc(%ebp)
 6ed:	89 df                	mov    %ebx,%edi
 6ef:	68 54 11 00 00       	push   $0x1154
 6f4:	6a 01                	push   $0x1
 6f6:	e8 15 05 00 00       	call   c10 <printf>
 6fb:	83 c4 10             	add    $0x10,%esp
 6fe:	eb 07                	jmp    707 <test_wmapinfo+0x247>
  for(int i = 0; i < 16; ++i){
 700:	83 c7 04             	add    $0x4,%edi
 703:	39 f7                	cmp    %esi,%edi
 705:	74 52                	je     759 <test_wmapinfo+0x299>
    if(wminfo.addr[i]!=0){
 707:	8b 07                	mov    (%edi),%eax
 709:	85 c0                	test   %eax,%eax
 70b:	74 f3                	je     700 <test_wmapinfo+0x240>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
 70d:	83 ec 04             	sub    $0x4,%esp
  for(int i = 0; i < 16; ++i){
 710:	83 c7 04             	add    $0x4,%edi
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
 713:	50                   	push   %eax
 714:	68 71 13 00 00       	push   $0x1371
 719:	6a 01                	push   $0x1
 71b:	e8 f0 04 00 00       	call   c10 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
 720:	83 c4 0c             	add    $0xc,%esp
 723:	ff 77 3c             	push   0x3c(%edi)
 726:	68 86 13 00 00       	push   $0x1386
 72b:	6a 01                	push   $0x1
 72d:	e8 de 04 00 00       	call   c10 <printf>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
 732:	83 c4 0c             	add    $0xc,%esp
 735:	ff 77 7c             	push   0x7c(%edi)
 738:	68 4a 13 00 00       	push   $0x134a
 73d:	6a 01                	push   $0x1
 73f:	e8 cc 04 00 00       	call   c10 <printf>
      printf(1, "\n");
 744:	58                   	pop    %eax
 745:	5a                   	pop    %edx
 746:	68 81 12 00 00       	push   $0x1281
 74b:	6a 01                	push   $0x1
 74d:	e8 be 04 00 00       	call   c10 <printf>
 752:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
 755:	39 f7                	cmp    %esi,%edi
 757:	75 ae                	jne    707 <test_wmapinfo+0x247>
  wunmap(map2);
 759:	83 ec 0c             	sub    $0xc,%esp
 75c:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
 762:	e8 d4 03 00 00       	call   b3b <wunmap>
  printf(1,"here\n");
 767:	59                   	pop    %ecx
 768:	5f                   	pop    %edi
 769:	68 ad 13 00 00       	push   $0x13ad
 76e:	6a 01                	push   $0x1
 770:	e8 9b 04 00 00       	call   c10 <printf>
  wunmap(map3);
 775:	58                   	pop    %eax
 776:	ff b5 10 ff ff ff    	push   -0xf0(%ebp)
 77c:	e8 ba 03 00 00       	call   b3b <wunmap>
  if(getwmapinfo(&wminfo) < 0){
 781:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
 787:	89 04 24             	mov    %eax,(%esp)
 78a:	e8 c4 03 00 00       	call   b53 <getwmapinfo>
 78f:	83 c4 10             	add    $0x10,%esp
 792:	85 c0                	test   %eax,%eax
 794:	79 11                	jns    7a7 <test_wmapinfo+0x2e7>
 796:	e9 7d 00 00 00       	jmp    818 <test_wmapinfo+0x358>
 79b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 79f:	90                   	nop
  for(int i = 0; i < 16; ++i){
 7a0:	83 c3 04             	add    $0x4,%ebx
 7a3:	39 f3                	cmp    %esi,%ebx
 7a5:	74 52                	je     7f9 <test_wmapinfo+0x339>
    if(wminfo.addr[i]!=0){
 7a7:	8b 03                	mov    (%ebx),%eax
 7a9:	85 c0                	test   %eax,%eax
 7ab:	74 f3                	je     7a0 <test_wmapinfo+0x2e0>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
 7ad:	83 ec 04             	sub    $0x4,%esp
  for(int i = 0; i < 16; ++i){
 7b0:	83 c3 04             	add    $0x4,%ebx
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
 7b3:	50                   	push   %eax
 7b4:	68 71 13 00 00       	push   $0x1371
 7b9:	6a 01                	push   $0x1
 7bb:	e8 50 04 00 00       	call   c10 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
 7c0:	83 c4 0c             	add    $0xc,%esp
 7c3:	ff 73 3c             	push   0x3c(%ebx)
 7c6:	68 86 13 00 00       	push   $0x1386
 7cb:	6a 01                	push   $0x1
 7cd:	e8 3e 04 00 00       	call   c10 <printf>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
 7d2:	83 c4 0c             	add    $0xc,%esp
 7d5:	ff 73 7c             	push   0x7c(%ebx)
 7d8:	68 4a 13 00 00       	push   $0x134a
 7dd:	6a 01                	push   $0x1
 7df:	e8 2c 04 00 00       	call   c10 <printf>
      printf(1, "\n");
 7e4:	58                   	pop    %eax
 7e5:	5a                   	pop    %edx
 7e6:	68 81 12 00 00       	push   $0x1281
 7eb:	6a 01                	push   $0x1
 7ed:	e8 1e 04 00 00       	call   c10 <printf>
 7f2:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
 7f5:	39 f3                	cmp    %esi,%ebx
 7f7:	75 ae                	jne    7a7 <test_wmapinfo+0x2e7>
  printf(1, "\nRESULT: SUCCESS\n\n");
 7f9:	83 ec 08             	sub    $0x8,%esp
 7fc:	68 b3 13 00 00       	push   $0x13b3
 801:	6a 01                	push   $0x1
 803:	e8 08 04 00 00       	call   c10 <printf>
  return;
 808:	83 c4 10             	add    $0x10,%esp
}
 80b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 80e:	5b                   	pop    %ebx
 80f:	5e                   	pop    %esi
 810:	5f                   	pop    %edi
 811:	5d                   	pop    %ebp
 812:	c3                   	ret    
 813:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 817:	90                   	nop
    printf(1, "\nRESULT: FAILED");
 818:	83 ec 08             	sub    $0x8,%esp
 81b:	68 fb 12 00 00       	push   $0x12fb
 820:	6a 01                	push   $0x1
 822:	e8 e9 03 00 00       	call   c10 <printf>
    return;
 827:	83 c4 10             	add    $0x10,%esp
}
 82a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 82d:	5b                   	pop    %ebx
 82e:	5e                   	pop    %esi
 82f:	5f                   	pop    %edi
 830:	5d                   	pop    %ebp
 831:	c3                   	ret    
 832:	66 90                	xchg   %ax,%ax
 834:	66 90                	xchg   %ax,%ax
 836:	66 90                	xchg   %ax,%ax
 838:	66 90                	xchg   %ax,%ax
 83a:	66 90                	xchg   %ax,%ax
 83c:	66 90                	xchg   %ax,%ax
 83e:	66 90                	xchg   %ax,%ax

00000840 <strcpy>:
 840:	55                   	push   %ebp
 841:	31 c0                	xor    %eax,%eax
 843:	89 e5                	mov    %esp,%ebp
 845:	53                   	push   %ebx
 846:	8b 4d 08             	mov    0x8(%ebp),%ecx
 849:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 84c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 850:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 854:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 857:	83 c0 01             	add    $0x1,%eax
 85a:	84 d2                	test   %dl,%dl
 85c:	75 f2                	jne    850 <strcpy+0x10>
 85e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 861:	89 c8                	mov    %ecx,%eax
 863:	c9                   	leave  
 864:	c3                   	ret    
 865:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 86c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000870 <strcmp>:
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	53                   	push   %ebx
 874:	8b 55 08             	mov    0x8(%ebp),%edx
 877:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 87a:	0f b6 02             	movzbl (%edx),%eax
 87d:	84 c0                	test   %al,%al
 87f:	75 17                	jne    898 <strcmp+0x28>
 881:	eb 3a                	jmp    8bd <strcmp+0x4d>
 883:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 887:	90                   	nop
 888:	0f b6 42 01          	movzbl 0x1(%edx),%eax
 88c:	83 c2 01             	add    $0x1,%edx
 88f:	8d 59 01             	lea    0x1(%ecx),%ebx
 892:	84 c0                	test   %al,%al
 894:	74 1a                	je     8b0 <strcmp+0x40>
 896:	89 d9                	mov    %ebx,%ecx
 898:	0f b6 19             	movzbl (%ecx),%ebx
 89b:	38 c3                	cmp    %al,%bl
 89d:	74 e9                	je     888 <strcmp+0x18>
 89f:	29 d8                	sub    %ebx,%eax
 8a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8a4:	c9                   	leave  
 8a5:	c3                   	ret    
 8a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ad:	8d 76 00             	lea    0x0(%esi),%esi
 8b0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 8b4:	31 c0                	xor    %eax,%eax
 8b6:	29 d8                	sub    %ebx,%eax
 8b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8bb:	c9                   	leave  
 8bc:	c3                   	ret    
 8bd:	0f b6 19             	movzbl (%ecx),%ebx
 8c0:	31 c0                	xor    %eax,%eax
 8c2:	eb db                	jmp    89f <strcmp+0x2f>
 8c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8cf:	90                   	nop

000008d0 <strlen>:
 8d0:	55                   	push   %ebp
 8d1:	89 e5                	mov    %esp,%ebp
 8d3:	8b 55 08             	mov    0x8(%ebp),%edx
 8d6:	80 3a 00             	cmpb   $0x0,(%edx)
 8d9:	74 15                	je     8f0 <strlen+0x20>
 8db:	31 c0                	xor    %eax,%eax
 8dd:	8d 76 00             	lea    0x0(%esi),%esi
 8e0:	83 c0 01             	add    $0x1,%eax
 8e3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 8e7:	89 c1                	mov    %eax,%ecx
 8e9:	75 f5                	jne    8e0 <strlen+0x10>
 8eb:	89 c8                	mov    %ecx,%eax
 8ed:	5d                   	pop    %ebp
 8ee:	c3                   	ret    
 8ef:	90                   	nop
 8f0:	31 c9                	xor    %ecx,%ecx
 8f2:	5d                   	pop    %ebp
 8f3:	89 c8                	mov    %ecx,%eax
 8f5:	c3                   	ret    
 8f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8fd:	8d 76 00             	lea    0x0(%esi),%esi

00000900 <memset>:
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	57                   	push   %edi
 904:	8b 55 08             	mov    0x8(%ebp),%edx
 907:	8b 4d 10             	mov    0x10(%ebp),%ecx
 90a:	8b 45 0c             	mov    0xc(%ebp),%eax
 90d:	89 d7                	mov    %edx,%edi
 90f:	fc                   	cld    
 910:	f3 aa                	rep stos %al,%es:(%edi)
 912:	8b 7d fc             	mov    -0x4(%ebp),%edi
 915:	89 d0                	mov    %edx,%eax
 917:	c9                   	leave  
 918:	c3                   	ret    
 919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000920 <strchr>:
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	8b 45 08             	mov    0x8(%ebp),%eax
 926:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 92a:	0f b6 10             	movzbl (%eax),%edx
 92d:	84 d2                	test   %dl,%dl
 92f:	75 12                	jne    943 <strchr+0x23>
 931:	eb 1d                	jmp    950 <strchr+0x30>
 933:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 937:	90                   	nop
 938:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 93c:	83 c0 01             	add    $0x1,%eax
 93f:	84 d2                	test   %dl,%dl
 941:	74 0d                	je     950 <strchr+0x30>
 943:	38 d1                	cmp    %dl,%cl
 945:	75 f1                	jne    938 <strchr+0x18>
 947:	5d                   	pop    %ebp
 948:	c3                   	ret    
 949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 950:	31 c0                	xor    %eax,%eax
 952:	5d                   	pop    %ebp
 953:	c3                   	ret    
 954:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 95b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 95f:	90                   	nop

00000960 <gets>:
 960:	55                   	push   %ebp
 961:	89 e5                	mov    %esp,%ebp
 963:	57                   	push   %edi
 964:	56                   	push   %esi
 965:	8d 7d e7             	lea    -0x19(%ebp),%edi
 968:	53                   	push   %ebx
 969:	31 db                	xor    %ebx,%ebx
 96b:	83 ec 1c             	sub    $0x1c,%esp
 96e:	eb 27                	jmp    997 <gets+0x37>
 970:	83 ec 04             	sub    $0x4,%esp
 973:	6a 01                	push   $0x1
 975:	57                   	push   %edi
 976:	6a 00                	push   $0x0
 978:	e8 2e 01 00 00       	call   aab <read>
 97d:	83 c4 10             	add    $0x10,%esp
 980:	85 c0                	test   %eax,%eax
 982:	7e 1d                	jle    9a1 <gets+0x41>
 984:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 988:	8b 55 08             	mov    0x8(%ebp),%edx
 98b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 98f:	3c 0a                	cmp    $0xa,%al
 991:	74 1d                	je     9b0 <gets+0x50>
 993:	3c 0d                	cmp    $0xd,%al
 995:	74 19                	je     9b0 <gets+0x50>
 997:	89 de                	mov    %ebx,%esi
 999:	83 c3 01             	add    $0x1,%ebx
 99c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 99f:	7c cf                	jl     970 <gets+0x10>
 9a1:	8b 45 08             	mov    0x8(%ebp),%eax
 9a4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 9a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9ab:	5b                   	pop    %ebx
 9ac:	5e                   	pop    %esi
 9ad:	5f                   	pop    %edi
 9ae:	5d                   	pop    %ebp
 9af:	c3                   	ret    
 9b0:	8b 45 08             	mov    0x8(%ebp),%eax
 9b3:	89 de                	mov    %ebx,%esi
 9b5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 9b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9bc:	5b                   	pop    %ebx
 9bd:	5e                   	pop    %esi
 9be:	5f                   	pop    %edi
 9bf:	5d                   	pop    %ebp
 9c0:	c3                   	ret    
 9c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9cf:	90                   	nop

000009d0 <stat>:
 9d0:	55                   	push   %ebp
 9d1:	89 e5                	mov    %esp,%ebp
 9d3:	56                   	push   %esi
 9d4:	53                   	push   %ebx
 9d5:	83 ec 08             	sub    $0x8,%esp
 9d8:	6a 00                	push   $0x0
 9da:	ff 75 08             	push   0x8(%ebp)
 9dd:	e8 f1 00 00 00       	call   ad3 <open>
 9e2:	83 c4 10             	add    $0x10,%esp
 9e5:	85 c0                	test   %eax,%eax
 9e7:	78 27                	js     a10 <stat+0x40>
 9e9:	83 ec 08             	sub    $0x8,%esp
 9ec:	ff 75 0c             	push   0xc(%ebp)
 9ef:	89 c3                	mov    %eax,%ebx
 9f1:	50                   	push   %eax
 9f2:	e8 f4 00 00 00       	call   aeb <fstat>
 9f7:	89 1c 24             	mov    %ebx,(%esp)
 9fa:	89 c6                	mov    %eax,%esi
 9fc:	e8 ba 00 00 00       	call   abb <close>
 a01:	83 c4 10             	add    $0x10,%esp
 a04:	8d 65 f8             	lea    -0x8(%ebp),%esp
 a07:	89 f0                	mov    %esi,%eax
 a09:	5b                   	pop    %ebx
 a0a:	5e                   	pop    %esi
 a0b:	5d                   	pop    %ebp
 a0c:	c3                   	ret    
 a0d:	8d 76 00             	lea    0x0(%esi),%esi
 a10:	be ff ff ff ff       	mov    $0xffffffff,%esi
 a15:	eb ed                	jmp    a04 <stat+0x34>
 a17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a1e:	66 90                	xchg   %ax,%ax

00000a20 <atoi>:
 a20:	55                   	push   %ebp
 a21:	89 e5                	mov    %esp,%ebp
 a23:	53                   	push   %ebx
 a24:	8b 55 08             	mov    0x8(%ebp),%edx
 a27:	0f be 02             	movsbl (%edx),%eax
 a2a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 a2d:	80 f9 09             	cmp    $0x9,%cl
 a30:	b9 00 00 00 00       	mov    $0x0,%ecx
 a35:	77 1e                	ja     a55 <atoi+0x35>
 a37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a3e:	66 90                	xchg   %ax,%ax
 a40:	83 c2 01             	add    $0x1,%edx
 a43:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 a46:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 a4a:	0f be 02             	movsbl (%edx),%eax
 a4d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 a50:	80 fb 09             	cmp    $0x9,%bl
 a53:	76 eb                	jbe    a40 <atoi+0x20>
 a55:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 a58:	89 c8                	mov    %ecx,%eax
 a5a:	c9                   	leave  
 a5b:	c3                   	ret    
 a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a60 <memmove>:
 a60:	55                   	push   %ebp
 a61:	89 e5                	mov    %esp,%ebp
 a63:	57                   	push   %edi
 a64:	8b 45 10             	mov    0x10(%ebp),%eax
 a67:	8b 55 08             	mov    0x8(%ebp),%edx
 a6a:	56                   	push   %esi
 a6b:	8b 75 0c             	mov    0xc(%ebp),%esi
 a6e:	85 c0                	test   %eax,%eax
 a70:	7e 13                	jle    a85 <memmove+0x25>
 a72:	01 d0                	add    %edx,%eax
 a74:	89 d7                	mov    %edx,%edi
 a76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a7d:	8d 76 00             	lea    0x0(%esi),%esi
 a80:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 a81:	39 f8                	cmp    %edi,%eax
 a83:	75 fb                	jne    a80 <memmove+0x20>
 a85:	5e                   	pop    %esi
 a86:	89 d0                	mov    %edx,%eax
 a88:	5f                   	pop    %edi
 a89:	5d                   	pop    %ebp
 a8a:	c3                   	ret    

00000a8b <fork>:
 a8b:	b8 01 00 00 00       	mov    $0x1,%eax
 a90:	cd 40                	int    $0x40
 a92:	c3                   	ret    

00000a93 <exit>:
 a93:	b8 02 00 00 00       	mov    $0x2,%eax
 a98:	cd 40                	int    $0x40
 a9a:	c3                   	ret    

00000a9b <wait>:
 a9b:	b8 03 00 00 00       	mov    $0x3,%eax
 aa0:	cd 40                	int    $0x40
 aa2:	c3                   	ret    

00000aa3 <pipe>:
 aa3:	b8 04 00 00 00       	mov    $0x4,%eax
 aa8:	cd 40                	int    $0x40
 aaa:	c3                   	ret    

00000aab <read>:
 aab:	b8 05 00 00 00       	mov    $0x5,%eax
 ab0:	cd 40                	int    $0x40
 ab2:	c3                   	ret    

00000ab3 <write>:
 ab3:	b8 10 00 00 00       	mov    $0x10,%eax
 ab8:	cd 40                	int    $0x40
 aba:	c3                   	ret    

00000abb <close>:
 abb:	b8 15 00 00 00       	mov    $0x15,%eax
 ac0:	cd 40                	int    $0x40
 ac2:	c3                   	ret    

00000ac3 <kill>:
 ac3:	b8 06 00 00 00       	mov    $0x6,%eax
 ac8:	cd 40                	int    $0x40
 aca:	c3                   	ret    

00000acb <exec>:
 acb:	b8 07 00 00 00       	mov    $0x7,%eax
 ad0:	cd 40                	int    $0x40
 ad2:	c3                   	ret    

00000ad3 <open>:
 ad3:	b8 0f 00 00 00       	mov    $0xf,%eax
 ad8:	cd 40                	int    $0x40
 ada:	c3                   	ret    

00000adb <mknod>:
 adb:	b8 11 00 00 00       	mov    $0x11,%eax
 ae0:	cd 40                	int    $0x40
 ae2:	c3                   	ret    

00000ae3 <unlink>:
 ae3:	b8 12 00 00 00       	mov    $0x12,%eax
 ae8:	cd 40                	int    $0x40
 aea:	c3                   	ret    

00000aeb <fstat>:
 aeb:	b8 08 00 00 00       	mov    $0x8,%eax
 af0:	cd 40                	int    $0x40
 af2:	c3                   	ret    

00000af3 <link>:
 af3:	b8 13 00 00 00       	mov    $0x13,%eax
 af8:	cd 40                	int    $0x40
 afa:	c3                   	ret    

00000afb <mkdir>:
 afb:	b8 14 00 00 00       	mov    $0x14,%eax
 b00:	cd 40                	int    $0x40
 b02:	c3                   	ret    

00000b03 <chdir>:
 b03:	b8 09 00 00 00       	mov    $0x9,%eax
 b08:	cd 40                	int    $0x40
 b0a:	c3                   	ret    

00000b0b <dup>:
 b0b:	b8 0a 00 00 00       	mov    $0xa,%eax
 b10:	cd 40                	int    $0x40
 b12:	c3                   	ret    

00000b13 <getpid>:
 b13:	b8 0b 00 00 00       	mov    $0xb,%eax
 b18:	cd 40                	int    $0x40
 b1a:	c3                   	ret    

00000b1b <sbrk>:
 b1b:	b8 0c 00 00 00       	mov    $0xc,%eax
 b20:	cd 40                	int    $0x40
 b22:	c3                   	ret    

00000b23 <sleep>:
 b23:	b8 0d 00 00 00       	mov    $0xd,%eax
 b28:	cd 40                	int    $0x40
 b2a:	c3                   	ret    

00000b2b <uptime>:
 b2b:	b8 0e 00 00 00       	mov    $0xe,%eax
 b30:	cd 40                	int    $0x40
 b32:	c3                   	ret    

00000b33 <wmap>:
 b33:	b8 16 00 00 00       	mov    $0x16,%eax
 b38:	cd 40                	int    $0x40
 b3a:	c3                   	ret    

00000b3b <wunmap>:
 b3b:	b8 17 00 00 00       	mov    $0x17,%eax
 b40:	cd 40                	int    $0x40
 b42:	c3                   	ret    

00000b43 <wremap>:
 b43:	b8 18 00 00 00       	mov    $0x18,%eax
 b48:	cd 40                	int    $0x40
 b4a:	c3                   	ret    

00000b4b <getpgdirinfo>:
 b4b:	b8 19 00 00 00       	mov    $0x19,%eax
 b50:	cd 40                	int    $0x40
 b52:	c3                   	ret    

00000b53 <getwmapinfo>:
 b53:	b8 1a 00 00 00       	mov    $0x1a,%eax
 b58:	cd 40                	int    $0x40
 b5a:	c3                   	ret    
 b5b:	66 90                	xchg   %ax,%ax
 b5d:	66 90                	xchg   %ax,%ax
 b5f:	90                   	nop

00000b60 <printint>:
 b60:	55                   	push   %ebp
 b61:	89 e5                	mov    %esp,%ebp
 b63:	57                   	push   %edi
 b64:	56                   	push   %esi
 b65:	53                   	push   %ebx
 b66:	83 ec 3c             	sub    $0x3c,%esp
 b69:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 b6c:	89 d1                	mov    %edx,%ecx
 b6e:	89 45 b8             	mov    %eax,-0x48(%ebp)
 b71:	85 d2                	test   %edx,%edx
 b73:	0f 89 7f 00 00 00    	jns    bf8 <printint+0x98>
 b79:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 b7d:	74 79                	je     bf8 <printint+0x98>
 b7f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
 b86:	f7 d9                	neg    %ecx
 b88:	31 db                	xor    %ebx,%ebx
 b8a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 b8d:	8d 76 00             	lea    0x0(%esi),%esi
 b90:	89 c8                	mov    %ecx,%eax
 b92:	31 d2                	xor    %edx,%edx
 b94:	89 cf                	mov    %ecx,%edi
 b96:	f7 75 c4             	divl   -0x3c(%ebp)
 b99:	0f b6 92 38 14 00 00 	movzbl 0x1438(%edx),%edx
 ba0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 ba3:	89 d8                	mov    %ebx,%eax
 ba5:	8d 5b 01             	lea    0x1(%ebx),%ebx
 ba8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 bab:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
 bae:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 bb1:	76 dd                	jbe    b90 <printint+0x30>
 bb3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 bb6:	85 c9                	test   %ecx,%ecx
 bb8:	74 0c                	je     bc6 <printint+0x66>
 bba:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 bbf:	89 d8                	mov    %ebx,%eax
 bc1:	ba 2d 00 00 00       	mov    $0x2d,%edx
 bc6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 bc9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 bcd:	eb 07                	jmp    bd6 <printint+0x76>
 bcf:	90                   	nop
 bd0:	0f b6 13             	movzbl (%ebx),%edx
 bd3:	83 eb 01             	sub    $0x1,%ebx
 bd6:	83 ec 04             	sub    $0x4,%esp
 bd9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 bdc:	6a 01                	push   $0x1
 bde:	56                   	push   %esi
 bdf:	57                   	push   %edi
 be0:	e8 ce fe ff ff       	call   ab3 <write>
 be5:	83 c4 10             	add    $0x10,%esp
 be8:	39 de                	cmp    %ebx,%esi
 bea:	75 e4                	jne    bd0 <printint+0x70>
 bec:	8d 65 f4             	lea    -0xc(%ebp),%esp
 bef:	5b                   	pop    %ebx
 bf0:	5e                   	pop    %esi
 bf1:	5f                   	pop    %edi
 bf2:	5d                   	pop    %ebp
 bf3:	c3                   	ret    
 bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 bf8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 bff:	eb 87                	jmp    b88 <printint+0x28>
 c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c0f:	90                   	nop

00000c10 <printf>:
 c10:	55                   	push   %ebp
 c11:	89 e5                	mov    %esp,%ebp
 c13:	57                   	push   %edi
 c14:	56                   	push   %esi
 c15:	53                   	push   %ebx
 c16:	83 ec 2c             	sub    $0x2c,%esp
 c19:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 c1c:	8b 75 08             	mov    0x8(%ebp),%esi
 c1f:	0f b6 13             	movzbl (%ebx),%edx
 c22:	84 d2                	test   %dl,%dl
 c24:	74 6a                	je     c90 <printf+0x80>
 c26:	8d 45 10             	lea    0x10(%ebp),%eax
 c29:	83 c3 01             	add    $0x1,%ebx
 c2c:	8d 7d e7             	lea    -0x19(%ebp),%edi
 c2f:	31 c9                	xor    %ecx,%ecx
 c31:	89 45 d0             	mov    %eax,-0x30(%ebp)
 c34:	eb 36                	jmp    c6c <printf+0x5c>
 c36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c3d:	8d 76 00             	lea    0x0(%esi),%esi
 c40:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 c43:	b9 25 00 00 00       	mov    $0x25,%ecx
 c48:	83 f8 25             	cmp    $0x25,%eax
 c4b:	74 15                	je     c62 <printf+0x52>
 c4d:	83 ec 04             	sub    $0x4,%esp
 c50:	88 55 e7             	mov    %dl,-0x19(%ebp)
 c53:	6a 01                	push   $0x1
 c55:	57                   	push   %edi
 c56:	56                   	push   %esi
 c57:	e8 57 fe ff ff       	call   ab3 <write>
 c5c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 c5f:	83 c4 10             	add    $0x10,%esp
 c62:	0f b6 13             	movzbl (%ebx),%edx
 c65:	83 c3 01             	add    $0x1,%ebx
 c68:	84 d2                	test   %dl,%dl
 c6a:	74 24                	je     c90 <printf+0x80>
 c6c:	0f b6 c2             	movzbl %dl,%eax
 c6f:	85 c9                	test   %ecx,%ecx
 c71:	74 cd                	je     c40 <printf+0x30>
 c73:	83 f9 25             	cmp    $0x25,%ecx
 c76:	75 ea                	jne    c62 <printf+0x52>
 c78:	83 f8 25             	cmp    $0x25,%eax
 c7b:	0f 84 07 01 00 00    	je     d88 <printf+0x178>
 c81:	83 e8 63             	sub    $0x63,%eax
 c84:	83 f8 15             	cmp    $0x15,%eax
 c87:	77 17                	ja     ca0 <printf+0x90>
 c89:	ff 24 85 e0 13 00 00 	jmp    *0x13e0(,%eax,4)
 c90:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c93:	5b                   	pop    %ebx
 c94:	5e                   	pop    %esi
 c95:	5f                   	pop    %edi
 c96:	5d                   	pop    %ebp
 c97:	c3                   	ret    
 c98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c9f:	90                   	nop
 ca0:	83 ec 04             	sub    $0x4,%esp
 ca3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 ca6:	6a 01                	push   $0x1
 ca8:	57                   	push   %edi
 ca9:	56                   	push   %esi
 caa:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 cae:	e8 00 fe ff ff       	call   ab3 <write>
 cb3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 cb7:	83 c4 0c             	add    $0xc,%esp
 cba:	88 55 e7             	mov    %dl,-0x19(%ebp)
 cbd:	6a 01                	push   $0x1
 cbf:	57                   	push   %edi
 cc0:	56                   	push   %esi
 cc1:	e8 ed fd ff ff       	call   ab3 <write>
 cc6:	83 c4 10             	add    $0x10,%esp
 cc9:	31 c9                	xor    %ecx,%ecx
 ccb:	eb 95                	jmp    c62 <printf+0x52>
 ccd:	8d 76 00             	lea    0x0(%esi),%esi
 cd0:	83 ec 0c             	sub    $0xc,%esp
 cd3:	b9 10 00 00 00       	mov    $0x10,%ecx
 cd8:	6a 00                	push   $0x0
 cda:	8b 45 d0             	mov    -0x30(%ebp),%eax
 cdd:	8b 10                	mov    (%eax),%edx
 cdf:	89 f0                	mov    %esi,%eax
 ce1:	e8 7a fe ff ff       	call   b60 <printint>
 ce6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 cea:	83 c4 10             	add    $0x10,%esp
 ced:	31 c9                	xor    %ecx,%ecx
 cef:	e9 6e ff ff ff       	jmp    c62 <printf+0x52>
 cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 cf8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 cfb:	8b 10                	mov    (%eax),%edx
 cfd:	83 c0 04             	add    $0x4,%eax
 d00:	89 45 d0             	mov    %eax,-0x30(%ebp)
 d03:	85 d2                	test   %edx,%edx
 d05:	0f 84 8d 00 00 00    	je     d98 <printf+0x188>
 d0b:	0f b6 02             	movzbl (%edx),%eax
 d0e:	31 c9                	xor    %ecx,%ecx
 d10:	84 c0                	test   %al,%al
 d12:	0f 84 4a ff ff ff    	je     c62 <printf+0x52>
 d18:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 d1b:	89 d3                	mov    %edx,%ebx
 d1d:	8d 76 00             	lea    0x0(%esi),%esi
 d20:	83 ec 04             	sub    $0x4,%esp
 d23:	83 c3 01             	add    $0x1,%ebx
 d26:	88 45 e7             	mov    %al,-0x19(%ebp)
 d29:	6a 01                	push   $0x1
 d2b:	57                   	push   %edi
 d2c:	56                   	push   %esi
 d2d:	e8 81 fd ff ff       	call   ab3 <write>
 d32:	0f b6 03             	movzbl (%ebx),%eax
 d35:	83 c4 10             	add    $0x10,%esp
 d38:	84 c0                	test   %al,%al
 d3a:	75 e4                	jne    d20 <printf+0x110>
 d3c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 d3f:	31 c9                	xor    %ecx,%ecx
 d41:	e9 1c ff ff ff       	jmp    c62 <printf+0x52>
 d46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 d4d:	8d 76 00             	lea    0x0(%esi),%esi
 d50:	83 ec 0c             	sub    $0xc,%esp
 d53:	b9 0a 00 00 00       	mov    $0xa,%ecx
 d58:	6a 01                	push   $0x1
 d5a:	e9 7b ff ff ff       	jmp    cda <printf+0xca>
 d5f:	90                   	nop
 d60:	8b 45 d0             	mov    -0x30(%ebp),%eax
 d63:	83 ec 04             	sub    $0x4,%esp
 d66:	8b 00                	mov    (%eax),%eax
 d68:	6a 01                	push   $0x1
 d6a:	57                   	push   %edi
 d6b:	56                   	push   %esi
 d6c:	88 45 e7             	mov    %al,-0x19(%ebp)
 d6f:	e8 3f fd ff ff       	call   ab3 <write>
 d74:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 d78:	83 c4 10             	add    $0x10,%esp
 d7b:	31 c9                	xor    %ecx,%ecx
 d7d:	e9 e0 fe ff ff       	jmp    c62 <printf+0x52>
 d82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 d88:	88 55 e7             	mov    %dl,-0x19(%ebp)
 d8b:	83 ec 04             	sub    $0x4,%esp
 d8e:	e9 2a ff ff ff       	jmp    cbd <printf+0xad>
 d93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 d97:	90                   	nop
 d98:	ba d9 13 00 00       	mov    $0x13d9,%edx
 d9d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 da0:	b8 28 00 00 00       	mov    $0x28,%eax
 da5:	89 d3                	mov    %edx,%ebx
 da7:	e9 74 ff ff ff       	jmp    d20 <printf+0x110>
 dac:	66 90                	xchg   %ax,%ax
 dae:	66 90                	xchg   %ax,%ax

00000db0 <free>:
 db0:	55                   	push   %ebp
 db1:	a1 e0 17 00 00       	mov    0x17e0,%eax
 db6:	89 e5                	mov    %esp,%ebp
 db8:	57                   	push   %edi
 db9:	56                   	push   %esi
 dba:	53                   	push   %ebx
 dbb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 dbe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 dc8:	89 c2                	mov    %eax,%edx
 dca:	8b 00                	mov    (%eax),%eax
 dcc:	39 ca                	cmp    %ecx,%edx
 dce:	73 30                	jae    e00 <free+0x50>
 dd0:	39 c1                	cmp    %eax,%ecx
 dd2:	72 04                	jb     dd8 <free+0x28>
 dd4:	39 c2                	cmp    %eax,%edx
 dd6:	72 f0                	jb     dc8 <free+0x18>
 dd8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 ddb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 dde:	39 f8                	cmp    %edi,%eax
 de0:	74 30                	je     e12 <free+0x62>
 de2:	89 43 f8             	mov    %eax,-0x8(%ebx)
 de5:	8b 42 04             	mov    0x4(%edx),%eax
 de8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 deb:	39 f1                	cmp    %esi,%ecx
 ded:	74 3a                	je     e29 <free+0x79>
 def:	89 0a                	mov    %ecx,(%edx)
 df1:	5b                   	pop    %ebx
 df2:	89 15 e0 17 00 00    	mov    %edx,0x17e0
 df8:	5e                   	pop    %esi
 df9:	5f                   	pop    %edi
 dfa:	5d                   	pop    %ebp
 dfb:	c3                   	ret    
 dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 e00:	39 c2                	cmp    %eax,%edx
 e02:	72 c4                	jb     dc8 <free+0x18>
 e04:	39 c1                	cmp    %eax,%ecx
 e06:	73 c0                	jae    dc8 <free+0x18>
 e08:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e0b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e0e:	39 f8                	cmp    %edi,%eax
 e10:	75 d0                	jne    de2 <free+0x32>
 e12:	03 70 04             	add    0x4(%eax),%esi
 e15:	89 73 fc             	mov    %esi,-0x4(%ebx)
 e18:	8b 02                	mov    (%edx),%eax
 e1a:	8b 00                	mov    (%eax),%eax
 e1c:	89 43 f8             	mov    %eax,-0x8(%ebx)
 e1f:	8b 42 04             	mov    0x4(%edx),%eax
 e22:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 e25:	39 f1                	cmp    %esi,%ecx
 e27:	75 c6                	jne    def <free+0x3f>
 e29:	03 43 fc             	add    -0x4(%ebx),%eax
 e2c:	89 15 e0 17 00 00    	mov    %edx,0x17e0
 e32:	89 42 04             	mov    %eax,0x4(%edx)
 e35:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 e38:	89 0a                	mov    %ecx,(%edx)
 e3a:	5b                   	pop    %ebx
 e3b:	5e                   	pop    %esi
 e3c:	5f                   	pop    %edi
 e3d:	5d                   	pop    %ebp
 e3e:	c3                   	ret    
 e3f:	90                   	nop

00000e40 <malloc>:
 e40:	55                   	push   %ebp
 e41:	89 e5                	mov    %esp,%ebp
 e43:	57                   	push   %edi
 e44:	56                   	push   %esi
 e45:	53                   	push   %ebx
 e46:	83 ec 1c             	sub    $0x1c,%esp
 e49:	8b 45 08             	mov    0x8(%ebp),%eax
 e4c:	8b 3d e0 17 00 00    	mov    0x17e0,%edi
 e52:	8d 70 07             	lea    0x7(%eax),%esi
 e55:	c1 ee 03             	shr    $0x3,%esi
 e58:	83 c6 01             	add    $0x1,%esi
 e5b:	85 ff                	test   %edi,%edi
 e5d:	0f 84 9d 00 00 00    	je     f00 <malloc+0xc0>
 e63:	8b 17                	mov    (%edi),%edx
 e65:	8b 4a 04             	mov    0x4(%edx),%ecx
 e68:	39 f1                	cmp    %esi,%ecx
 e6a:	73 6a                	jae    ed6 <malloc+0x96>
 e6c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 e71:	39 de                	cmp    %ebx,%esi
 e73:	0f 43 de             	cmovae %esi,%ebx
 e76:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 e7d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 e80:	eb 17                	jmp    e99 <malloc+0x59>
 e82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 e88:	8b 02                	mov    (%edx),%eax
 e8a:	8b 48 04             	mov    0x4(%eax),%ecx
 e8d:	39 f1                	cmp    %esi,%ecx
 e8f:	73 4f                	jae    ee0 <malloc+0xa0>
 e91:	8b 3d e0 17 00 00    	mov    0x17e0,%edi
 e97:	89 c2                	mov    %eax,%edx
 e99:	39 d7                	cmp    %edx,%edi
 e9b:	75 eb                	jne    e88 <malloc+0x48>
 e9d:	83 ec 0c             	sub    $0xc,%esp
 ea0:	ff 75 e4             	push   -0x1c(%ebp)
 ea3:	e8 73 fc ff ff       	call   b1b <sbrk>
 ea8:	83 c4 10             	add    $0x10,%esp
 eab:	83 f8 ff             	cmp    $0xffffffff,%eax
 eae:	74 1c                	je     ecc <malloc+0x8c>
 eb0:	89 58 04             	mov    %ebx,0x4(%eax)
 eb3:	83 ec 0c             	sub    $0xc,%esp
 eb6:	83 c0 08             	add    $0x8,%eax
 eb9:	50                   	push   %eax
 eba:	e8 f1 fe ff ff       	call   db0 <free>
 ebf:	8b 15 e0 17 00 00    	mov    0x17e0,%edx
 ec5:	83 c4 10             	add    $0x10,%esp
 ec8:	85 d2                	test   %edx,%edx
 eca:	75 bc                	jne    e88 <malloc+0x48>
 ecc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ecf:	31 c0                	xor    %eax,%eax
 ed1:	5b                   	pop    %ebx
 ed2:	5e                   	pop    %esi
 ed3:	5f                   	pop    %edi
 ed4:	5d                   	pop    %ebp
 ed5:	c3                   	ret    
 ed6:	89 d0                	mov    %edx,%eax
 ed8:	89 fa                	mov    %edi,%edx
 eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 ee0:	39 ce                	cmp    %ecx,%esi
 ee2:	74 4c                	je     f30 <malloc+0xf0>
 ee4:	29 f1                	sub    %esi,%ecx
 ee6:	89 48 04             	mov    %ecx,0x4(%eax)
 ee9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 eec:	89 70 04             	mov    %esi,0x4(%eax)
 eef:	89 15 e0 17 00 00    	mov    %edx,0x17e0
 ef5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ef8:	83 c0 08             	add    $0x8,%eax
 efb:	5b                   	pop    %ebx
 efc:	5e                   	pop    %esi
 efd:	5f                   	pop    %edi
 efe:	5d                   	pop    %ebp
 eff:	c3                   	ret    
 f00:	c7 05 e0 17 00 00 e4 	movl   $0x17e4,0x17e0
 f07:	17 00 00 
 f0a:	bf e4 17 00 00       	mov    $0x17e4,%edi
 f0f:	c7 05 e4 17 00 00 e4 	movl   $0x17e4,0x17e4
 f16:	17 00 00 
 f19:	89 fa                	mov    %edi,%edx
 f1b:	c7 05 e8 17 00 00 00 	movl   $0x0,0x17e8
 f22:	00 00 00 
 f25:	e9 42 ff ff ff       	jmp    e6c <malloc+0x2c>
 f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 f30:	8b 08                	mov    (%eax),%ecx
 f32:	89 0a                	mov    %ecx,(%edx)
 f34:	eb b9                	jmp    eef <malloc+0xaf>
