
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
  11:	68 b0 13 00 00       	push   $0x13b0
  16:	6a 01                	push   $0x1
  18:	e8 e3 0b 00 00       	call   c00 <printf>
  //test_2_page_map_unmap();
  //test_mult_map_diff_touches();
  test_map_fixed();
  1d:	e8 ae 01 00 00       	call   1d0 <test_map_fixed>
  //test_out_of_va();
  //test_wmapinfo();
  //test_remap();
  exit();
  22:	e8 5c 0a 00 00       	call   a83 <exit>
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
  39:	68 28 0f 00 00       	push   $0xf28
  3e:	6a 01                	push   $0x1
  40:	e8 bb 0b 00 00       	call   c00 <printf>
  printf(1, "\t-wmapping 0\n");
  45:	59                   	pop    %ecx
  46:	5b                   	pop    %ebx
  47:	68 67 11 00 00       	push   $0x1167
  4c:	6a 01                	push   $0x1
  4e:	e8 ad 0b 00 00       	call   c00 <printf>
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  53:	6a ff                	push   $0xffffffff
  55:	6a 0e                	push   $0xe
  57:	68 00 20 00 00       	push   $0x2000
  5c:	68 00 00 00 60       	push   $0x60000000
  61:	e8 bd 0a 00 00       	call   b23 <wmap>
  printf(1, "\t-touching 0\n");
  66:	83 c4 18             	add    $0x18,%esp
  69:	68 75 11 00 00       	push   $0x1175
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  6e:	89 c3                	mov    %eax,%ebx
  printf(1, "\t-touching 0\n");
  70:	6a 01                	push   $0x1
  72:	e8 89 0b 00 00       	call   c00 <printf>
  ptr0[0] = 'a';
  77:	c6 03 61             	movb   $0x61,(%ebx)
  printf(1, "\t-wmapping 1\n");
  7a:	5e                   	pop    %esi
  7b:	5f                   	pop    %edi
  7c:	68 83 11 00 00       	push   $0x1183
  81:	6a 01                	push   $0x1
  83:	e8 78 0b 00 00       	call   c00 <printf>
  uint map1 = wmap(0x60003000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  88:	6a ff                	push   $0xffffffff
  8a:	6a 0e                	push   $0xe
  8c:	68 00 10 00 00       	push   $0x1000
  91:	68 00 30 00 60       	push   $0x60003000
  96:	e8 88 0a 00 00       	call   b23 <wmap>
  printf(1, "\t-wmapping 2\n");
  9b:	83 c4 18             	add    $0x18,%esp
  9e:	68 91 11 00 00       	push   $0x1191
  uint map1 = wmap(0x60003000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  a3:	89 c6                	mov    %eax,%esi
  printf(1, "\t-wmapping 2\n");
  a5:	6a 01                	push   $0x1
  a7:	e8 54 0b 00 00       	call   c00 <printf>
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  ac:	6a ff                	push   $0xffffffff
  ae:	6a 0e                	push   $0xe
  b0:	68 00 10 00 00       	push   $0x1000
  b5:	68 00 20 00 60       	push   $0x60002000
  ba:	e8 64 0a 00 00       	call   b23 <wmap>
    printf(1, "\t-touching 1\n");
  bf:	83 c4 18             	add    $0x18,%esp
  c2:	68 9f 11 00 00       	push   $0x119f
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
  c7:	89 c7                	mov    %eax,%edi
    printf(1, "\t-touching 1\n");
  c9:	6a 01                	push   $0x1
  cb:	e8 30 0b 00 00       	call   c00 <printf>
  ptr1[0] = 'b';
  d0:	c6 06 62             	movb   $0x62,(%esi)
  printf(1, "\t-map0 %c map1 %c\n", ptr0[0], ptr1[0]);
  d3:	6a 62                	push   $0x62
  d5:	0f be 03             	movsbl (%ebx),%eax
  d8:	50                   	push   %eax
  d9:	68 ad 11 00 00       	push   $0x11ad
  de:	6a 01                	push   $0x1
  e0:	e8 1b 0b 00 00       	call   c00 <printf>
  printf(1, "\nRESULT: ");
  e5:	83 c4 18             	add    $0x18,%esp
  e8:	68 c0 11 00 00       	push   $0x11c0
  ed:	6a 01                	push   $0x1
  ef:	e8 0c 0b 00 00       	call   c00 <printf>
  if (ptr0[0] == 'a' && ptr1[0] == 'b') {
  f4:	83 c4 10             	add    $0x10,%esp
  f7:	80 3b 61             	cmpb   $0x61,(%ebx)
  fa:	75 05                	jne    101 <test_mult_map_diff_touches+0xd1>
  fc:	80 3e 62             	cmpb   $0x62,(%esi)
  ff:	74 47                	je     148 <test_mult_map_diff_touches+0x118>
    printf(1, "FAILED");
 101:	83 ec 08             	sub    $0x8,%esp
 104:	68 f4 12 00 00       	push   $0x12f4
 109:	6a 01                	push   $0x1
 10b:	e8 f0 0a 00 00       	call   c00 <printf>
 110:	83 c4 10             	add    $0x10,%esp
  wunmap(map0);
 113:	83 ec 0c             	sub    $0xc,%esp
 116:	53                   	push   %ebx
 117:	e8 0f 0a 00 00       	call   b2b <wunmap>
  wunmap(map1);
 11c:	89 34 24             	mov    %esi,(%esp)
 11f:	e8 07 0a 00 00       	call   b2b <wunmap>
  wunmap(map2);
 124:	89 3c 24             	mov    %edi,(%esp)
 127:	e8 ff 09 00 00       	call   b2b <wunmap>
  printf(1, "\n\n");
 12c:	58                   	pop    %eax
 12d:	5a                   	pop    %edx
 12e:	68 70 12 00 00       	push   $0x1270
 133:	6a 01                	push   $0x1
 135:	e8 c6 0a 00 00       	call   c00 <printf>
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
 14b:	68 21 13 00 00       	push   $0x1321
 150:	6a 01                	push   $0x1
 152:	e8 a9 0a 00 00       	call   c00 <printf>
 157:	83 c4 10             	add    $0x10,%esp
 15a:	eb b7                	jmp    113 <test_mult_map_diff_touches+0xe3>
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000160 <test_out_of_va>:
void test_out_of_va(void) {
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	83 ec 10             	sub    $0x10,%esp
  printf(1, "Testing test_out_of_va\n");
 166:	68 ca 11 00 00       	push   $0x11ca
 16b:	6a 01                	push   $0x1
 16d:	e8 8e 0a 00 00       	call   c00 <printf>
  printf(1, "\t-wmapping 0 to max size\n");
 172:	58                   	pop    %eax
 173:	5a                   	pop    %edx
 174:	68 e2 11 00 00       	push   $0x11e2
 179:	6a 01                	push   $0x1
 17b:	e8 80 0a 00 00       	call   c00 <printf>
  uint map0 = wmap(0x60000000, 0x20000000, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 180:	6a ff                	push   $0xffffffff
 182:	6a 0e                	push   $0xe
 184:	68 00 00 00 20       	push   $0x20000000
 189:	68 00 00 00 60       	push   $0x60000000
 18e:	e8 90 09 00 00       	call   b23 <wmap>
  printf(1, "\t-wmapping 1, so we get error message\n");
 193:	83 c4 18             	add    $0x18,%esp
 196:	68 48 0f 00 00       	push   $0xf48
 19b:	6a 01                	push   $0x1
 19d:	e8 5e 0a 00 00       	call   c00 <printf>
  uint map1 = wmap(0x60001000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 1a2:	6a ff                	push   $0xffffffff
 1a4:	6a 0e                	push   $0xe
 1a6:	68 00 10 00 00       	push   $0x1000
 1ab:	68 00 10 00 60       	push   $0x60001000
 1b0:	e8 6e 09 00 00       	call   b23 <wmap>
  printf(1, "\nCheck if got error message above\n");
 1b5:	83 c4 18             	add    $0x18,%esp
 1b8:	68 70 0f 00 00       	push   $0xf70
 1bd:	6a 01                	push   $0x1
 1bf:	e8 3c 0a 00 00       	call   c00 <printf>
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
 1d8:	68 fc 11 00 00       	push   $0x11fc
 1dd:	6a 01                	push   $0x1
 1df:	e8 1c 0a 00 00       	call   c00 <printf>
  printf(1, "\t-testing basic functionality\n");
 1e4:	58                   	pop    %eax
 1e5:	5a                   	pop    %edx
 1e6:	68 94 0f 00 00       	push   $0xf94
 1eb:	6a 01                	push   $0x1
 1ed:	e8 0e 0a 00 00       	call   c00 <printf>
  printf(1, "\t-wmapping 0 as fixed\n");
 1f2:	59                   	pop    %ecx
 1f3:	5b                   	pop    %ebx
 1f4:	68 14 12 00 00       	push   $0x1214
 1f9:	6a 01                	push   $0x1
 1fb:	e8 00 0a 00 00       	call   c00 <printf>
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 200:	6a ff                	push   $0xffffffff
 202:	6a 0e                	push   $0xe
 204:	68 00 20 00 00       	push   $0x2000
 209:	68 00 00 00 60       	push   $0x60000000
 20e:	e8 10 09 00 00       	call   b23 <wmap>
  printf(1, "\t-wmapping 1 as not fixed, trying to get other addr\n");
 213:	83 c4 18             	add    $0x18,%esp
 216:	68 b4 0f 00 00       	push   $0xfb4
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 21b:	89 c6                	mov    %eax,%esi
  printf(1, "\t-wmapping 1 as not fixed, trying to get other addr\n");
 21d:	6a 01                	push   $0x1
 21f:	e8 dc 09 00 00       	call   c00 <printf>
  uint map1 = wmap(0x60000000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
 224:	6a ff                	push   $0xffffffff
 226:	6a 06                	push   $0x6
 228:	68 00 20 00 00       	push   $0x2000
 22d:	68 00 00 00 60       	push   $0x60000000
 232:	e8 ec 08 00 00       	call   b23 <wmap>
  printf(1, "\nShould be 0x60002000\n\n");
 237:	83 c4 18             	add    $0x18,%esp
 23a:	68 2b 12 00 00       	push   $0x122b
  uint map1 = wmap(0x60000000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
 23f:	89 c3                	mov    %eax,%ebx
  printf(1, "\nShould be 0x60002000\n\n");
 241:	6a 01                	push   $0x1
 243:	e8 b8 09 00 00       	call   c00 <printf>
  printf(1, "\t-testing if doesn't break with endpoints\n");
 248:	58                   	pop    %eax
 249:	5a                   	pop    %edx
 24a:	68 ec 0f 00 00       	push   $0xfec
 24f:	6a 01                	push   $0x1
 251:	e8 aa 09 00 00       	call   c00 <printf>
  wunmap(map0);
 256:	89 34 24             	mov    %esi,(%esp)
 259:	e8 cd 08 00 00       	call   b2b <wunmap>
  printf(1, "\t-wmapping 0 as not fixed, trying to get other addr\n");
 25e:	59                   	pop    %ecx
 25f:	5e                   	pop    %esi
 260:	68 18 10 00 00       	push   $0x1018
 265:	6a 01                	push   $0x1
 267:	e8 94 09 00 00       	call   c00 <printf>
  map0 = wmap(0x60000000, 4096 * 3, MAP_SHARED | MAP_ANONYMOUS, -1);
 26c:	6a ff                	push   $0xffffffff
 26e:	6a 06                	push   $0x6
 270:	68 00 30 00 00       	push   $0x3000
 275:	68 00 00 00 60       	push   $0x60000000
 27a:	e8 a4 08 00 00       	call   b23 <wmap>
  printf(1, "\nShould be 0x60004000\n\n");
 27f:	83 c4 18             	add    $0x18,%esp
 282:	68 43 12 00 00       	push   $0x1243
  map0 = wmap(0x60000000, 4096 * 3, MAP_SHARED | MAP_ANONYMOUS, -1);
 287:	89 c6                	mov    %eax,%esi
  printf(1, "\nShould be 0x60004000\n\n");
 289:	6a 01                	push   $0x1
 28b:	e8 70 09 00 00       	call   c00 <printf>
  printf(1, "\t-testing if doesn't break if exceding 0x80000000\n");
 290:	58                   	pop    %eax
 291:	5a                   	pop    %edx
 292:	68 50 10 00 00       	push   $0x1050
 297:	6a 01                	push   $0x1
 299:	e8 62 09 00 00       	call   c00 <printf>
  wunmap(map0);
 29e:	89 34 24             	mov    %esi,(%esp)
 2a1:	e8 85 08 00 00       	call   b2b <wunmap>
  wunmap(map1);
 2a6:	89 1c 24             	mov    %ebx,(%esp)
 2a9:	e8 7d 08 00 00       	call   b2b <wunmap>
  printf(1, "\t-wmapping 0 as fixed at 0x7fffe000\n");
 2ae:	59                   	pop    %ecx
 2af:	5b                   	pop    %ebx
 2b0:	68 84 10 00 00       	push   $0x1084
 2b5:	6a 01                	push   $0x1
 2b7:	e8 44 09 00 00       	call   c00 <printf>
  map0 = wmap(0x7fffe000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 2bc:	6a ff                	push   $0xffffffff
 2be:	6a 0e                	push   $0xe
 2c0:	68 00 10 00 00       	push   $0x1000
 2c5:	68 00 e0 ff 7f       	push   $0x7fffe000
 2ca:	e8 54 08 00 00       	call   b23 <wmap>
  printf(1, "\t-wmapping 1 with 8192, needing to loop\n");
 2cf:	83 c4 18             	add    $0x18,%esp
 2d2:	68 ac 10 00 00       	push   $0x10ac
  map0 = wmap(0x7fffe000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 2d7:	89 c6                	mov    %eax,%esi
  printf(1, "\t-wmapping 1 with 8192, needing to loop\n");
 2d9:	6a 01                	push   $0x1
 2db:	e8 20 09 00 00       	call   c00 <printf>
  map1 = wmap(0x7fffe000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
 2e0:	6a ff                	push   $0xffffffff
 2e2:	6a 06                	push   $0x6
 2e4:	68 00 20 00 00       	push   $0x2000
 2e9:	68 00 e0 ff 7f       	push   $0x7fffe000
 2ee:	e8 30 08 00 00       	call   b23 <wmap>
  printf(1, "\nShould be 0x60000000\n\n");
 2f3:	83 c4 18             	add    $0x18,%esp
 2f6:	68 5b 12 00 00       	push   $0x125b
  map1 = wmap(0x7fffe000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
 2fb:	89 c3                	mov    %eax,%ebx
  printf(1, "\nShould be 0x60000000\n\n");
 2fd:	6a 01                	push   $0x1
 2ff:	e8 fc 08 00 00       	call   c00 <printf>
  wunmap(map0);
 304:	89 34 24             	mov    %esi,(%esp)
 307:	e8 1f 08 00 00       	call   b2b <wunmap>
  wunmap(map1);
 30c:	89 1c 24             	mov    %ebx,(%esp)
 30f:	e8 17 08 00 00       	call   b2b <wunmap>
  printf(1, "\n\n");
 314:	5e                   	pop    %esi
 315:	58                   	pop    %eax
 316:	68 70 12 00 00       	push   $0x1270
 31b:	6a 01                	push   $0x1
 31d:	e8 de 08 00 00       	call   c00 <printf>
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
 336:	68 73 12 00 00       	push   $0x1273
 33b:	6a 01                	push   $0x1
 33d:	e8 be 08 00 00       	call   c00 <printf>
  printf(1, "\t-testing if ifs are right");
 342:	58                   	pop    %eax
 343:	5a                   	pop    %edx
 344:	68 87 12 00 00       	push   $0x1287
 349:	6a 01                	push   $0x1
 34b:	e8 b0 08 00 00       	call   c00 <printf>
  uint map0 = wmap(0x60000000, 4096,  MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 350:	6a ff                	push   $0xffffffff
 352:	6a 0e                	push   $0xe
 354:	68 00 10 00 00       	push   $0x1000
 359:	68 00 00 00 60       	push   $0x60000000
 35e:	e8 c0 07 00 00       	call   b23 <wmap>
  wremap(0x60000000, 4096, 8192, 0);
 363:	83 c4 20             	add    $0x20,%esp
 366:	6a 00                	push   $0x0
 368:	68 00 20 00 00       	push   $0x2000
 36d:	68 00 10 00 00       	push   $0x1000
 372:	68 00 00 00 60       	push   $0x60000000
 377:	e8 b7 07 00 00       	call   b33 <wremap>
  printf(1, "Should be Valid for in place\n\n");
 37c:	59                   	pop    %ecx
 37d:	58                   	pop    %eax
 37e:	68 d8 10 00 00       	push   $0x10d8
 383:	6a 01                	push   $0x1
 385:	e8 76 08 00 00       	call   c00 <printf>
  wremap(0x60000000, 4096, 8192, MREMAP_MAYMOVE);
 38a:	6a 01                	push   $0x1
 38c:	68 00 20 00 00       	push   $0x2000
 391:	68 00 10 00 00       	push   $0x1000
 396:	68 00 00 00 60       	push   $0x60000000
 39b:	e8 93 07 00 00       	call   b33 <wremap>
  printf(1, "Should be Valid for in place\n\n");
 3a0:	83 c4 18             	add    $0x18,%esp
 3a3:	68 d8 10 00 00       	push   $0x10d8
 3a8:	6a 01                	push   $0x1
 3aa:	e8 51 08 00 00       	call   c00 <printf>
  uint map1 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 3af:	6a ff                	push   $0xffffffff
 3b1:	6a 0e                	push   $0xe
 3b3:	68 00 10 00 00       	push   $0x1000
 3b8:	68 00 20 00 60       	push   $0x60002000
 3bd:	e8 61 07 00 00       	call   b23 <wmap>
  wremap(0x60000000, 4096, 8192, 0);
 3c2:	83 c4 20             	add    $0x20,%esp
 3c5:	6a 00                	push   $0x0
 3c7:	68 00 20 00 00       	push   $0x2000
 3cc:	68 00 10 00 00       	push   $0x1000
 3d1:	68 00 00 00 60       	push   $0x60000000
 3d6:	e8 58 07 00 00       	call   b33 <wremap>
  printf(1, "Should be Cannot\n\n");
 3db:	58                   	pop    %eax
 3dc:	5a                   	pop    %edx
 3dd:	68 a2 12 00 00       	push   $0x12a2
 3e2:	6a 01                	push   $0x1
 3e4:	e8 17 08 00 00       	call   c00 <printf>
  wremap(0x60000000, 4096, 8192, 0);
 3e9:	6a 00                	push   $0x0
 3eb:	68 00 20 00 00       	push   $0x2000
 3f0:	68 00 10 00 00       	push   $0x1000
 3f5:	68 00 00 00 60       	push   $0x60000000
 3fa:	e8 34 07 00 00       	call   b33 <wremap>
  printf(1, "Should be valid for moving\n\n");
 3ff:	83 c4 18             	add    $0x18,%esp
 402:	68 b5 12 00 00       	push   $0x12b5
 407:	6a 01                	push   $0x1
 409:	e8 f2 07 00 00       	call   c00 <printf>
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
 427:	68 f8 10 00 00       	push   $0x10f8
 42c:	6a 01                	push   $0x1
 42e:	e8 cd 07 00 00       	call   c00 <printf>
  uint map = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 433:	6a ff                	push   $0xffffffff
 435:	6a 0e                	push   $0xe
 437:	68 00 20 00 00       	push   $0x2000
 43c:	68 00 00 00 60       	push   $0x60000000
 441:	e8 dd 06 00 00       	call   b23 <wmap>
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
 46f:	68 fb 12 00 00       	push   $0x12fb
 474:	6a 01                	push   $0x1
 476:	e8 85 07 00 00       	call   c00 <printf>
  wunmap(map);
 47b:	89 1c 24             	mov    %ebx,(%esp)
 47e:	e8 a8 06 00 00       	call   b2b <wunmap>
  printf(1, "\nRESULT: PASSED");
 483:	59                   	pop    %ecx
 484:	5b                   	pop    %ebx
 485:	68 18 13 00 00       	push   $0x1318
 48a:	6a 01                	push   $0x1
 48c:	e8 6f 07 00 00       	call   c00 <printf>
  printf(1, "\n\n");
 491:	58                   	pop    %eax
 492:	5a                   	pop    %edx
 493:	68 70 12 00 00       	push   $0x1270
 498:	6a 01                	push   $0x1
 49a:	e8 61 07 00 00       	call   c00 <printf>
}
 49f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return;
 4a2:	83 c4 10             	add    $0x10,%esp
}
 4a5:	c9                   	leave  
 4a6:	c3                   	ret    
    printf(1, "\t-Error mapping memory.\n");
 4a7:	83 ec 08             	sub    $0x8,%esp
 4aa:	68 d2 12 00 00       	push   $0x12d2
 4af:	6a 01                	push   $0x1
 4b1:	e8 4a 07 00 00       	call   c00 <printf>
    printf(1, "\nRESULT: FAILED");
 4b6:	58                   	pop    %eax
 4b7:	5a                   	pop    %edx
 4b8:	68 eb 12 00 00       	push   $0x12eb
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
 4cc:	68 28 13 00 00       	push   $0x1328
 4d1:	6a 01                	push   $0x1
 4d3:	e8 28 07 00 00       	call   c00 <printf>
  uint map = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 4d8:	6a ff                	push   $0xffffffff
 4da:	6a 0e                	push   $0xe
 4dc:	68 00 20 00 00       	push   $0x2000
 4e1:	68 00 00 00 60       	push   $0x60000000
 4e6:	e8 38 06 00 00       	call   b23 <wmap>
  if(getwmapinfo(&wminfo) < 0){
 4eb:	83 c4 14             	add    $0x14,%esp
  uint map = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 4ee:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  if(getwmapinfo(&wminfo) < 0){
 4f4:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
 4fa:	50                   	push   %eax
 4fb:	e8 43 06 00 00       	call   b43 <getwmapinfo>
 500:	83 c4 10             	add    $0x10,%esp
 503:	85 c0                	test   %eax,%eax
 505:	0f 88 fd 02 00 00    	js     808 <test_wmapinfo+0x348>
  printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[0]);
 50b:	83 ec 04             	sub    $0x4,%esp
 50e:	ff 75 a8             	push   -0x58(%ebp)
 511:	68 3a 13 00 00       	push   $0x133a
 516:	6a 01                	push   $0x1
 518:	e8 e3 06 00 00       	call   c00 <printf>
  ptr0[0] = 'a';
 51d:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
 523:	c6 00 61             	movb   $0x61,(%eax)
  if(getwmapinfo(&wminfo) < 0){
 526:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
 52c:	89 04 24             	mov    %eax,(%esp)
 52f:	e8 0f 06 00 00       	call   b43 <getwmapinfo>
 534:	83 c4 10             	add    $0x10,%esp
 537:	85 c0                	test   %eax,%eax
 539:	0f 88 c9 02 00 00    	js     808 <test_wmapinfo+0x348>
  printf(1, "\t-Total mmaps: %d\n", wminfo.total_mmaps);
 53f:	83 ec 04             	sub    $0x4,%esp
 542:	ff b5 24 ff ff ff    	push   -0xdc(%ebp)
 548:	8d 9d 28 ff ff ff    	lea    -0xd8(%ebp),%ebx
 54e:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
 554:	68 4e 13 00 00       	push   $0x134e
 559:	89 df                	mov    %ebx,%edi
 55b:	6a 01                	push   $0x1
 55d:	e8 9e 06 00 00       	call   c00 <printf>
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
 589:	68 3a 13 00 00       	push   $0x133a
 58e:	6a 01                	push   $0x1
 590:	e8 6b 06 00 00       	call   c00 <printf>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
 595:	83 c4 0c             	add    $0xc,%esp
 598:	ff 77 fc             	push   -0x4(%edi)
 59b:	68 61 13 00 00       	push   $0x1361
 5a0:	6a 01                	push   $0x1
 5a2:	e8 59 06 00 00       	call   c00 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
 5a7:	83 c4 0c             	add    $0xc,%esp
 5aa:	ff 77 3c             	push   0x3c(%edi)
 5ad:	68 76 13 00 00       	push   $0x1376
 5b2:	6a 01                	push   $0x1
 5b4:	e8 47 06 00 00       	call   c00 <printf>
      printf(1, "\n");
 5b9:	58                   	pop    %eax
 5ba:	5a                   	pop    %edx
 5bb:	68 71 12 00 00       	push   $0x1271
 5c0:	6a 01                	push   $0x1
 5c2:	e8 39 06 00 00       	call   c00 <printf>
 5c7:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
 5ca:	39 f7                	cmp    %esi,%edi
 5cc:	75 a9                	jne    577 <test_wmapinfo+0xb7>
  wunmap(map);
 5ce:	83 ec 0c             	sub    $0xc,%esp
 5d1:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
 5d7:	e8 4f 05 00 00       	call   b2b <wunmap>
  if(getwmapinfo(&wminfo) < 0){
 5dc:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
 5e2:	89 04 24             	mov    %eax,(%esp)
 5e5:	e8 59 05 00 00       	call   b43 <getwmapinfo>
 5ea:	83 c4 10             	add    $0x10,%esp
 5ed:	85 c0                	test   %eax,%eax
 5ef:	0f 88 13 02 00 00    	js     808 <test_wmapinfo+0x348>
  printf(1, "\t-Total mmaps after unmap: %d\n", wminfo.total_mmaps);
 5f5:	83 ec 04             	sub    $0x4,%esp
 5f8:	ff b5 24 ff ff ff    	push   -0xdc(%ebp)
 5fe:	89 df                	mov    %ebx,%edi
 600:	68 24 11 00 00       	push   $0x1124
 605:	6a 01                	push   $0x1
 607:	e8 f4 05 00 00       	call   c00 <printf>
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
 62c:	68 88 13 00 00       	push   $0x1388
 631:	6a 01                	push   $0x1
 633:	e8 c8 05 00 00       	call   c00 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
 638:	83 c4 0c             	add    $0xc,%esp
 63b:	ff 77 3c             	push   0x3c(%edi)
 63e:	68 76 13 00 00       	push   $0x1376
 643:	6a 01                	push   $0x1
 645:	e8 b6 05 00 00       	call   c00 <printf>
       printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
 64a:	83 c4 0c             	add    $0xc,%esp
 64d:	ff 77 7c             	push   0x7c(%edi)
 650:	68 3a 13 00 00       	push   $0x133a
 655:	6a 01                	push   $0x1
 657:	e8 a4 05 00 00       	call   c00 <printf>
       printf(1, "\n");
 65c:	59                   	pop    %ecx
 65d:	58                   	pop    %eax
 65e:	68 71 12 00 00       	push   $0x1271
 663:	6a 01                	push   $0x1
 665:	e8 96 05 00 00       	call   c00 <printf>
 66a:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
 66d:	39 f7                	cmp    %esi,%edi
 66f:	75 ae                	jne    61f <test_wmapinfo+0x15f>
  printf(1,"\n");
 671:	83 ec 08             	sub    $0x8,%esp
 674:	68 71 12 00 00       	push   $0x1271
 679:	6a 01                	push   $0x1
 67b:	e8 80 05 00 00       	call   c00 <printf>
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
 680:	6a ff                	push   $0xffffffff
 682:	6a 0e                	push   $0xe
 684:	68 00 10 00 00       	push   $0x1000
 689:	68 00 20 00 60       	push   $0x60002000
 68e:	e8 90 04 00 00       	call   b23 <wmap>
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
 6ac:	e8 72 04 00 00       	call   b23 <wmap>
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
 6d4:	e8 6a 04 00 00       	call   b43 <getwmapinfo>
 6d9:	83 c4 10             	add    $0x10,%esp
 6dc:	85 c0                	test   %eax,%eax
 6de:	0f 88 24 01 00 00    	js     808 <test_wmapinfo+0x348>
  printf(1, "\t-Total mmaps after more maps: %d\n", wminfo.total_mmaps);
 6e4:	83 ec 04             	sub    $0x4,%esp
 6e7:	ff b5 24 ff ff ff    	push   -0xdc(%ebp)
 6ed:	89 df                	mov    %ebx,%edi
 6ef:	68 44 11 00 00       	push   $0x1144
 6f4:	6a 01                	push   $0x1
 6f6:	e8 05 05 00 00       	call   c00 <printf>
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
 714:	68 61 13 00 00       	push   $0x1361
 719:	6a 01                	push   $0x1
 71b:	e8 e0 04 00 00       	call   c00 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
 720:	83 c4 0c             	add    $0xc,%esp
 723:	ff 77 3c             	push   0x3c(%edi)
 726:	68 76 13 00 00       	push   $0x1376
 72b:	6a 01                	push   $0x1
 72d:	e8 ce 04 00 00       	call   c00 <printf>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
 732:	83 c4 0c             	add    $0xc,%esp
 735:	ff 77 7c             	push   0x7c(%edi)
 738:	68 3a 13 00 00       	push   $0x133a
 73d:	6a 01                	push   $0x1
 73f:	e8 bc 04 00 00       	call   c00 <printf>
      printf(1, "\n");
 744:	58                   	pop    %eax
 745:	5a                   	pop    %edx
 746:	68 71 12 00 00       	push   $0x1271
 74b:	6a 01                	push   $0x1
 74d:	e8 ae 04 00 00       	call   c00 <printf>
 752:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
 755:	39 f7                	cmp    %esi,%edi
 757:	75 ae                	jne    707 <test_wmapinfo+0x247>
  wunmap(map2);
 759:	83 ec 0c             	sub    $0xc,%esp
 75c:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
 762:	e8 c4 03 00 00       	call   b2b <wunmap>
  wunmap(map3);
 767:	59                   	pop    %ecx
 768:	ff b5 10 ff ff ff    	push   -0xf0(%ebp)
 76e:	e8 b8 03 00 00       	call   b2b <wunmap>
  if(getwmapinfo(&wminfo) < 0){
 773:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
 779:	89 04 24             	mov    %eax,(%esp)
 77c:	e8 c2 03 00 00       	call   b43 <getwmapinfo>
 781:	83 c4 10             	add    $0x10,%esp
 784:	85 c0                	test   %eax,%eax
 786:	79 0f                	jns    797 <test_wmapinfo+0x2d7>
 788:	eb 7e                	jmp    808 <test_wmapinfo+0x348>
 78a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(int i = 0; i < 16; ++i){
 790:	83 c3 04             	add    $0x4,%ebx
 793:	39 f3                	cmp    %esi,%ebx
 795:	74 52                	je     7e9 <test_wmapinfo+0x329>
    if(wminfo.addr[i]!=0){
 797:	8b 03                	mov    (%ebx),%eax
 799:	85 c0                	test   %eax,%eax
 79b:	74 f3                	je     790 <test_wmapinfo+0x2d0>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
 79d:	83 ec 04             	sub    $0x4,%esp
  for(int i = 0; i < 16; ++i){
 7a0:	83 c3 04             	add    $0x4,%ebx
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
 7a3:	50                   	push   %eax
 7a4:	68 61 13 00 00       	push   $0x1361
 7a9:	6a 01                	push   $0x1
 7ab:	e8 50 04 00 00       	call   c00 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
 7b0:	83 c4 0c             	add    $0xc,%esp
 7b3:	ff 73 3c             	push   0x3c(%ebx)
 7b6:	68 76 13 00 00       	push   $0x1376
 7bb:	6a 01                	push   $0x1
 7bd:	e8 3e 04 00 00       	call   c00 <printf>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
 7c2:	83 c4 0c             	add    $0xc,%esp
 7c5:	ff 73 7c             	push   0x7c(%ebx)
 7c8:	68 3a 13 00 00       	push   $0x133a
 7cd:	6a 01                	push   $0x1
 7cf:	e8 2c 04 00 00       	call   c00 <printf>
      printf(1, "\n");
 7d4:	58                   	pop    %eax
 7d5:	5a                   	pop    %edx
 7d6:	68 71 12 00 00       	push   $0x1271
 7db:	6a 01                	push   $0x1
 7dd:	e8 1e 04 00 00       	call   c00 <printf>
 7e2:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
 7e5:	39 f3                	cmp    %esi,%ebx
 7e7:	75 ae                	jne    797 <test_wmapinfo+0x2d7>
  printf(1, "\nRESULT: SUCCESS\n\n");
 7e9:	83 ec 08             	sub    $0x8,%esp
 7ec:	68 9d 13 00 00       	push   $0x139d
 7f1:	6a 01                	push   $0x1
 7f3:	e8 08 04 00 00       	call   c00 <printf>
  return;
 7f8:	83 c4 10             	add    $0x10,%esp
}
 7fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7fe:	5b                   	pop    %ebx
 7ff:	5e                   	pop    %esi
 800:	5f                   	pop    %edi
 801:	5d                   	pop    %ebp
 802:	c3                   	ret    
 803:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 807:	90                   	nop
    printf(1, "\nRESULT: FAILED");
 808:	83 ec 08             	sub    $0x8,%esp
 80b:	68 eb 12 00 00       	push   $0x12eb
 810:	6a 01                	push   $0x1
 812:	e8 e9 03 00 00       	call   c00 <printf>
    return;
 817:	83 c4 10             	add    $0x10,%esp
}
 81a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 81d:	5b                   	pop    %ebx
 81e:	5e                   	pop    %esi
 81f:	5f                   	pop    %edi
 820:	5d                   	pop    %ebp
 821:	c3                   	ret    
 822:	66 90                	xchg   %ax,%ax
 824:	66 90                	xchg   %ax,%ax
 826:	66 90                	xchg   %ax,%ax
 828:	66 90                	xchg   %ax,%ax
 82a:	66 90                	xchg   %ax,%ax
 82c:	66 90                	xchg   %ax,%ax
 82e:	66 90                	xchg   %ax,%ax

00000830 <strcpy>:
 830:	55                   	push   %ebp
 831:	31 c0                	xor    %eax,%eax
 833:	89 e5                	mov    %esp,%ebp
 835:	53                   	push   %ebx
 836:	8b 4d 08             	mov    0x8(%ebp),%ecx
 839:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 83c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 840:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 844:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 847:	83 c0 01             	add    $0x1,%eax
 84a:	84 d2                	test   %dl,%dl
 84c:	75 f2                	jne    840 <strcpy+0x10>
 84e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 851:	89 c8                	mov    %ecx,%eax
 853:	c9                   	leave  
 854:	c3                   	ret    
 855:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 85c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000860 <strcmp>:
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	53                   	push   %ebx
 864:	8b 55 08             	mov    0x8(%ebp),%edx
 867:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 86a:	0f b6 02             	movzbl (%edx),%eax
 86d:	84 c0                	test   %al,%al
 86f:	75 17                	jne    888 <strcmp+0x28>
 871:	eb 3a                	jmp    8ad <strcmp+0x4d>
 873:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 877:	90                   	nop
 878:	0f b6 42 01          	movzbl 0x1(%edx),%eax
 87c:	83 c2 01             	add    $0x1,%edx
 87f:	8d 59 01             	lea    0x1(%ecx),%ebx
 882:	84 c0                	test   %al,%al
 884:	74 1a                	je     8a0 <strcmp+0x40>
 886:	89 d9                	mov    %ebx,%ecx
 888:	0f b6 19             	movzbl (%ecx),%ebx
 88b:	38 c3                	cmp    %al,%bl
 88d:	74 e9                	je     878 <strcmp+0x18>
 88f:	29 d8                	sub    %ebx,%eax
 891:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 894:	c9                   	leave  
 895:	c3                   	ret    
 896:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 89d:	8d 76 00             	lea    0x0(%esi),%esi
 8a0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 8a4:	31 c0                	xor    %eax,%eax
 8a6:	29 d8                	sub    %ebx,%eax
 8a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8ab:	c9                   	leave  
 8ac:	c3                   	ret    
 8ad:	0f b6 19             	movzbl (%ecx),%ebx
 8b0:	31 c0                	xor    %eax,%eax
 8b2:	eb db                	jmp    88f <strcmp+0x2f>
 8b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8bf:	90                   	nop

000008c0 <strlen>:
 8c0:	55                   	push   %ebp
 8c1:	89 e5                	mov    %esp,%ebp
 8c3:	8b 55 08             	mov    0x8(%ebp),%edx
 8c6:	80 3a 00             	cmpb   $0x0,(%edx)
 8c9:	74 15                	je     8e0 <strlen+0x20>
 8cb:	31 c0                	xor    %eax,%eax
 8cd:	8d 76 00             	lea    0x0(%esi),%esi
 8d0:	83 c0 01             	add    $0x1,%eax
 8d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 8d7:	89 c1                	mov    %eax,%ecx
 8d9:	75 f5                	jne    8d0 <strlen+0x10>
 8db:	89 c8                	mov    %ecx,%eax
 8dd:	5d                   	pop    %ebp
 8de:	c3                   	ret    
 8df:	90                   	nop
 8e0:	31 c9                	xor    %ecx,%ecx
 8e2:	5d                   	pop    %ebp
 8e3:	89 c8                	mov    %ecx,%eax
 8e5:	c3                   	ret    
 8e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ed:	8d 76 00             	lea    0x0(%esi),%esi

000008f0 <memset>:
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	57                   	push   %edi
 8f4:	8b 55 08             	mov    0x8(%ebp),%edx
 8f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 8fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 8fd:	89 d7                	mov    %edx,%edi
 8ff:	fc                   	cld    
 900:	f3 aa                	rep stos %al,%es:(%edi)
 902:	8b 7d fc             	mov    -0x4(%ebp),%edi
 905:	89 d0                	mov    %edx,%eax
 907:	c9                   	leave  
 908:	c3                   	ret    
 909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000910 <strchr>:
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	8b 45 08             	mov    0x8(%ebp),%eax
 916:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 91a:	0f b6 10             	movzbl (%eax),%edx
 91d:	84 d2                	test   %dl,%dl
 91f:	75 12                	jne    933 <strchr+0x23>
 921:	eb 1d                	jmp    940 <strchr+0x30>
 923:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 927:	90                   	nop
 928:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 92c:	83 c0 01             	add    $0x1,%eax
 92f:	84 d2                	test   %dl,%dl
 931:	74 0d                	je     940 <strchr+0x30>
 933:	38 d1                	cmp    %dl,%cl
 935:	75 f1                	jne    928 <strchr+0x18>
 937:	5d                   	pop    %ebp
 938:	c3                   	ret    
 939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 940:	31 c0                	xor    %eax,%eax
 942:	5d                   	pop    %ebp
 943:	c3                   	ret    
 944:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 94b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 94f:	90                   	nop

00000950 <gets>:
 950:	55                   	push   %ebp
 951:	89 e5                	mov    %esp,%ebp
 953:	57                   	push   %edi
 954:	56                   	push   %esi
 955:	8d 7d e7             	lea    -0x19(%ebp),%edi
 958:	53                   	push   %ebx
 959:	31 db                	xor    %ebx,%ebx
 95b:	83 ec 1c             	sub    $0x1c,%esp
 95e:	eb 27                	jmp    987 <gets+0x37>
 960:	83 ec 04             	sub    $0x4,%esp
 963:	6a 01                	push   $0x1
 965:	57                   	push   %edi
 966:	6a 00                	push   $0x0
 968:	e8 2e 01 00 00       	call   a9b <read>
 96d:	83 c4 10             	add    $0x10,%esp
 970:	85 c0                	test   %eax,%eax
 972:	7e 1d                	jle    991 <gets+0x41>
 974:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 978:	8b 55 08             	mov    0x8(%ebp),%edx
 97b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 97f:	3c 0a                	cmp    $0xa,%al
 981:	74 1d                	je     9a0 <gets+0x50>
 983:	3c 0d                	cmp    $0xd,%al
 985:	74 19                	je     9a0 <gets+0x50>
 987:	89 de                	mov    %ebx,%esi
 989:	83 c3 01             	add    $0x1,%ebx
 98c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 98f:	7c cf                	jl     960 <gets+0x10>
 991:	8b 45 08             	mov    0x8(%ebp),%eax
 994:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 998:	8d 65 f4             	lea    -0xc(%ebp),%esp
 99b:	5b                   	pop    %ebx
 99c:	5e                   	pop    %esi
 99d:	5f                   	pop    %edi
 99e:	5d                   	pop    %ebp
 99f:	c3                   	ret    
 9a0:	8b 45 08             	mov    0x8(%ebp),%eax
 9a3:	89 de                	mov    %ebx,%esi
 9a5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 9a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9ac:	5b                   	pop    %ebx
 9ad:	5e                   	pop    %esi
 9ae:	5f                   	pop    %edi
 9af:	5d                   	pop    %ebp
 9b0:	c3                   	ret    
 9b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9bf:	90                   	nop

000009c0 <stat>:
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	56                   	push   %esi
 9c4:	53                   	push   %ebx
 9c5:	83 ec 08             	sub    $0x8,%esp
 9c8:	6a 00                	push   $0x0
 9ca:	ff 75 08             	push   0x8(%ebp)
 9cd:	e8 f1 00 00 00       	call   ac3 <open>
 9d2:	83 c4 10             	add    $0x10,%esp
 9d5:	85 c0                	test   %eax,%eax
 9d7:	78 27                	js     a00 <stat+0x40>
 9d9:	83 ec 08             	sub    $0x8,%esp
 9dc:	ff 75 0c             	push   0xc(%ebp)
 9df:	89 c3                	mov    %eax,%ebx
 9e1:	50                   	push   %eax
 9e2:	e8 f4 00 00 00       	call   adb <fstat>
 9e7:	89 1c 24             	mov    %ebx,(%esp)
 9ea:	89 c6                	mov    %eax,%esi
 9ec:	e8 ba 00 00 00       	call   aab <close>
 9f1:	83 c4 10             	add    $0x10,%esp
 9f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 9f7:	89 f0                	mov    %esi,%eax
 9f9:	5b                   	pop    %ebx
 9fa:	5e                   	pop    %esi
 9fb:	5d                   	pop    %ebp
 9fc:	c3                   	ret    
 9fd:	8d 76 00             	lea    0x0(%esi),%esi
 a00:	be ff ff ff ff       	mov    $0xffffffff,%esi
 a05:	eb ed                	jmp    9f4 <stat+0x34>
 a07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a0e:	66 90                	xchg   %ax,%ax

00000a10 <atoi>:
 a10:	55                   	push   %ebp
 a11:	89 e5                	mov    %esp,%ebp
 a13:	53                   	push   %ebx
 a14:	8b 55 08             	mov    0x8(%ebp),%edx
 a17:	0f be 02             	movsbl (%edx),%eax
 a1a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 a1d:	80 f9 09             	cmp    $0x9,%cl
 a20:	b9 00 00 00 00       	mov    $0x0,%ecx
 a25:	77 1e                	ja     a45 <atoi+0x35>
 a27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a2e:	66 90                	xchg   %ax,%ax
 a30:	83 c2 01             	add    $0x1,%edx
 a33:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 a36:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 a3a:	0f be 02             	movsbl (%edx),%eax
 a3d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 a40:	80 fb 09             	cmp    $0x9,%bl
 a43:	76 eb                	jbe    a30 <atoi+0x20>
 a45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 a48:	89 c8                	mov    %ecx,%eax
 a4a:	c9                   	leave  
 a4b:	c3                   	ret    
 a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a50 <memmove>:
 a50:	55                   	push   %ebp
 a51:	89 e5                	mov    %esp,%ebp
 a53:	57                   	push   %edi
 a54:	8b 45 10             	mov    0x10(%ebp),%eax
 a57:	8b 55 08             	mov    0x8(%ebp),%edx
 a5a:	56                   	push   %esi
 a5b:	8b 75 0c             	mov    0xc(%ebp),%esi
 a5e:	85 c0                	test   %eax,%eax
 a60:	7e 13                	jle    a75 <memmove+0x25>
 a62:	01 d0                	add    %edx,%eax
 a64:	89 d7                	mov    %edx,%edi
 a66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a6d:	8d 76 00             	lea    0x0(%esi),%esi
 a70:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 a71:	39 f8                	cmp    %edi,%eax
 a73:	75 fb                	jne    a70 <memmove+0x20>
 a75:	5e                   	pop    %esi
 a76:	89 d0                	mov    %edx,%eax
 a78:	5f                   	pop    %edi
 a79:	5d                   	pop    %ebp
 a7a:	c3                   	ret    

00000a7b <fork>:
 a7b:	b8 01 00 00 00       	mov    $0x1,%eax
 a80:	cd 40                	int    $0x40
 a82:	c3                   	ret    

00000a83 <exit>:
 a83:	b8 02 00 00 00       	mov    $0x2,%eax
 a88:	cd 40                	int    $0x40
 a8a:	c3                   	ret    

00000a8b <wait>:
 a8b:	b8 03 00 00 00       	mov    $0x3,%eax
 a90:	cd 40                	int    $0x40
 a92:	c3                   	ret    

00000a93 <pipe>:
 a93:	b8 04 00 00 00       	mov    $0x4,%eax
 a98:	cd 40                	int    $0x40
 a9a:	c3                   	ret    

00000a9b <read>:
 a9b:	b8 05 00 00 00       	mov    $0x5,%eax
 aa0:	cd 40                	int    $0x40
 aa2:	c3                   	ret    

00000aa3 <write>:
 aa3:	b8 10 00 00 00       	mov    $0x10,%eax
 aa8:	cd 40                	int    $0x40
 aaa:	c3                   	ret    

00000aab <close>:
 aab:	b8 15 00 00 00       	mov    $0x15,%eax
 ab0:	cd 40                	int    $0x40
 ab2:	c3                   	ret    

00000ab3 <kill>:
 ab3:	b8 06 00 00 00       	mov    $0x6,%eax
 ab8:	cd 40                	int    $0x40
 aba:	c3                   	ret    

00000abb <exec>:
 abb:	b8 07 00 00 00       	mov    $0x7,%eax
 ac0:	cd 40                	int    $0x40
 ac2:	c3                   	ret    

00000ac3 <open>:
 ac3:	b8 0f 00 00 00       	mov    $0xf,%eax
 ac8:	cd 40                	int    $0x40
 aca:	c3                   	ret    

00000acb <mknod>:
 acb:	b8 11 00 00 00       	mov    $0x11,%eax
 ad0:	cd 40                	int    $0x40
 ad2:	c3                   	ret    

00000ad3 <unlink>:
 ad3:	b8 12 00 00 00       	mov    $0x12,%eax
 ad8:	cd 40                	int    $0x40
 ada:	c3                   	ret    

00000adb <fstat>:
 adb:	b8 08 00 00 00       	mov    $0x8,%eax
 ae0:	cd 40                	int    $0x40
 ae2:	c3                   	ret    

00000ae3 <link>:
 ae3:	b8 13 00 00 00       	mov    $0x13,%eax
 ae8:	cd 40                	int    $0x40
 aea:	c3                   	ret    

00000aeb <mkdir>:
 aeb:	b8 14 00 00 00       	mov    $0x14,%eax
 af0:	cd 40                	int    $0x40
 af2:	c3                   	ret    

00000af3 <chdir>:
 af3:	b8 09 00 00 00       	mov    $0x9,%eax
 af8:	cd 40                	int    $0x40
 afa:	c3                   	ret    

00000afb <dup>:
 afb:	b8 0a 00 00 00       	mov    $0xa,%eax
 b00:	cd 40                	int    $0x40
 b02:	c3                   	ret    

00000b03 <getpid>:
 b03:	b8 0b 00 00 00       	mov    $0xb,%eax
 b08:	cd 40                	int    $0x40
 b0a:	c3                   	ret    

00000b0b <sbrk>:
 b0b:	b8 0c 00 00 00       	mov    $0xc,%eax
 b10:	cd 40                	int    $0x40
 b12:	c3                   	ret    

00000b13 <sleep>:
 b13:	b8 0d 00 00 00       	mov    $0xd,%eax
 b18:	cd 40                	int    $0x40
 b1a:	c3                   	ret    

00000b1b <uptime>:
 b1b:	b8 0e 00 00 00       	mov    $0xe,%eax
 b20:	cd 40                	int    $0x40
 b22:	c3                   	ret    

00000b23 <wmap>:
 b23:	b8 16 00 00 00       	mov    $0x16,%eax
 b28:	cd 40                	int    $0x40
 b2a:	c3                   	ret    

00000b2b <wunmap>:
 b2b:	b8 17 00 00 00       	mov    $0x17,%eax
 b30:	cd 40                	int    $0x40
 b32:	c3                   	ret    

00000b33 <wremap>:
 b33:	b8 18 00 00 00       	mov    $0x18,%eax
 b38:	cd 40                	int    $0x40
 b3a:	c3                   	ret    

00000b3b <getpgdirinfo>:
 b3b:	b8 19 00 00 00       	mov    $0x19,%eax
 b40:	cd 40                	int    $0x40
 b42:	c3                   	ret    

00000b43 <getwmapinfo>:
 b43:	b8 1a 00 00 00       	mov    $0x1a,%eax
 b48:	cd 40                	int    $0x40
 b4a:	c3                   	ret    
 b4b:	66 90                	xchg   %ax,%ax
 b4d:	66 90                	xchg   %ax,%ax
 b4f:	90                   	nop

00000b50 <printint>:
 b50:	55                   	push   %ebp
 b51:	89 e5                	mov    %esp,%ebp
 b53:	57                   	push   %edi
 b54:	56                   	push   %esi
 b55:	53                   	push   %ebx
 b56:	83 ec 3c             	sub    $0x3c,%esp
 b59:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 b5c:	89 d1                	mov    %edx,%ecx
 b5e:	89 45 b8             	mov    %eax,-0x48(%ebp)
 b61:	85 d2                	test   %edx,%edx
 b63:	0f 89 7f 00 00 00    	jns    be8 <printint+0x98>
 b69:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 b6d:	74 79                	je     be8 <printint+0x98>
 b6f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
 b76:	f7 d9                	neg    %ecx
 b78:	31 db                	xor    %ebx,%ebx
 b7a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 b7d:	8d 76 00             	lea    0x0(%esi),%esi
 b80:	89 c8                	mov    %ecx,%eax
 b82:	31 d2                	xor    %edx,%edx
 b84:	89 cf                	mov    %ecx,%edi
 b86:	f7 75 c4             	divl   -0x3c(%ebp)
 b89:	0f b6 92 24 14 00 00 	movzbl 0x1424(%edx),%edx
 b90:	89 45 c0             	mov    %eax,-0x40(%ebp)
 b93:	89 d8                	mov    %ebx,%eax
 b95:	8d 5b 01             	lea    0x1(%ebx),%ebx
 b98:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 b9b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
 b9e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 ba1:	76 dd                	jbe    b80 <printint+0x30>
 ba3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 ba6:	85 c9                	test   %ecx,%ecx
 ba8:	74 0c                	je     bb6 <printint+0x66>
 baa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 baf:	89 d8                	mov    %ebx,%eax
 bb1:	ba 2d 00 00 00       	mov    $0x2d,%edx
 bb6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 bb9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 bbd:	eb 07                	jmp    bc6 <printint+0x76>
 bbf:	90                   	nop
 bc0:	0f b6 13             	movzbl (%ebx),%edx
 bc3:	83 eb 01             	sub    $0x1,%ebx
 bc6:	83 ec 04             	sub    $0x4,%esp
 bc9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 bcc:	6a 01                	push   $0x1
 bce:	56                   	push   %esi
 bcf:	57                   	push   %edi
 bd0:	e8 ce fe ff ff       	call   aa3 <write>
 bd5:	83 c4 10             	add    $0x10,%esp
 bd8:	39 de                	cmp    %ebx,%esi
 bda:	75 e4                	jne    bc0 <printint+0x70>
 bdc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 bdf:	5b                   	pop    %ebx
 be0:	5e                   	pop    %esi
 be1:	5f                   	pop    %edi
 be2:	5d                   	pop    %ebp
 be3:	c3                   	ret    
 be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 be8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 bef:	eb 87                	jmp    b78 <printint+0x28>
 bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 bf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 bff:	90                   	nop

00000c00 <printf>:
 c00:	55                   	push   %ebp
 c01:	89 e5                	mov    %esp,%ebp
 c03:	57                   	push   %edi
 c04:	56                   	push   %esi
 c05:	53                   	push   %ebx
 c06:	83 ec 2c             	sub    $0x2c,%esp
 c09:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 c0c:	8b 75 08             	mov    0x8(%ebp),%esi
 c0f:	0f b6 13             	movzbl (%ebx),%edx
 c12:	84 d2                	test   %dl,%dl
 c14:	74 6a                	je     c80 <printf+0x80>
 c16:	8d 45 10             	lea    0x10(%ebp),%eax
 c19:	83 c3 01             	add    $0x1,%ebx
 c1c:	8d 7d e7             	lea    -0x19(%ebp),%edi
 c1f:	31 c9                	xor    %ecx,%ecx
 c21:	89 45 d0             	mov    %eax,-0x30(%ebp)
 c24:	eb 36                	jmp    c5c <printf+0x5c>
 c26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c2d:	8d 76 00             	lea    0x0(%esi),%esi
 c30:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 c33:	b9 25 00 00 00       	mov    $0x25,%ecx
 c38:	83 f8 25             	cmp    $0x25,%eax
 c3b:	74 15                	je     c52 <printf+0x52>
 c3d:	83 ec 04             	sub    $0x4,%esp
 c40:	88 55 e7             	mov    %dl,-0x19(%ebp)
 c43:	6a 01                	push   $0x1
 c45:	57                   	push   %edi
 c46:	56                   	push   %esi
 c47:	e8 57 fe ff ff       	call   aa3 <write>
 c4c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 c4f:	83 c4 10             	add    $0x10,%esp
 c52:	0f b6 13             	movzbl (%ebx),%edx
 c55:	83 c3 01             	add    $0x1,%ebx
 c58:	84 d2                	test   %dl,%dl
 c5a:	74 24                	je     c80 <printf+0x80>
 c5c:	0f b6 c2             	movzbl %dl,%eax
 c5f:	85 c9                	test   %ecx,%ecx
 c61:	74 cd                	je     c30 <printf+0x30>
 c63:	83 f9 25             	cmp    $0x25,%ecx
 c66:	75 ea                	jne    c52 <printf+0x52>
 c68:	83 f8 25             	cmp    $0x25,%eax
 c6b:	0f 84 07 01 00 00    	je     d78 <printf+0x178>
 c71:	83 e8 63             	sub    $0x63,%eax
 c74:	83 f8 15             	cmp    $0x15,%eax
 c77:	77 17                	ja     c90 <printf+0x90>
 c79:	ff 24 85 cc 13 00 00 	jmp    *0x13cc(,%eax,4)
 c80:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c83:	5b                   	pop    %ebx
 c84:	5e                   	pop    %esi
 c85:	5f                   	pop    %edi
 c86:	5d                   	pop    %ebp
 c87:	c3                   	ret    
 c88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c8f:	90                   	nop
 c90:	83 ec 04             	sub    $0x4,%esp
 c93:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 c96:	6a 01                	push   $0x1
 c98:	57                   	push   %edi
 c99:	56                   	push   %esi
 c9a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 c9e:	e8 00 fe ff ff       	call   aa3 <write>
 ca3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 ca7:	83 c4 0c             	add    $0xc,%esp
 caa:	88 55 e7             	mov    %dl,-0x19(%ebp)
 cad:	6a 01                	push   $0x1
 caf:	57                   	push   %edi
 cb0:	56                   	push   %esi
 cb1:	e8 ed fd ff ff       	call   aa3 <write>
 cb6:	83 c4 10             	add    $0x10,%esp
 cb9:	31 c9                	xor    %ecx,%ecx
 cbb:	eb 95                	jmp    c52 <printf+0x52>
 cbd:	8d 76 00             	lea    0x0(%esi),%esi
 cc0:	83 ec 0c             	sub    $0xc,%esp
 cc3:	b9 10 00 00 00       	mov    $0x10,%ecx
 cc8:	6a 00                	push   $0x0
 cca:	8b 45 d0             	mov    -0x30(%ebp),%eax
 ccd:	8b 10                	mov    (%eax),%edx
 ccf:	89 f0                	mov    %esi,%eax
 cd1:	e8 7a fe ff ff       	call   b50 <printint>
 cd6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 cda:	83 c4 10             	add    $0x10,%esp
 cdd:	31 c9                	xor    %ecx,%ecx
 cdf:	e9 6e ff ff ff       	jmp    c52 <printf+0x52>
 ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 ce8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 ceb:	8b 10                	mov    (%eax),%edx
 ced:	83 c0 04             	add    $0x4,%eax
 cf0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 cf3:	85 d2                	test   %edx,%edx
 cf5:	0f 84 8d 00 00 00    	je     d88 <printf+0x188>
 cfb:	0f b6 02             	movzbl (%edx),%eax
 cfe:	31 c9                	xor    %ecx,%ecx
 d00:	84 c0                	test   %al,%al
 d02:	0f 84 4a ff ff ff    	je     c52 <printf+0x52>
 d08:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 d0b:	89 d3                	mov    %edx,%ebx
 d0d:	8d 76 00             	lea    0x0(%esi),%esi
 d10:	83 ec 04             	sub    $0x4,%esp
 d13:	83 c3 01             	add    $0x1,%ebx
 d16:	88 45 e7             	mov    %al,-0x19(%ebp)
 d19:	6a 01                	push   $0x1
 d1b:	57                   	push   %edi
 d1c:	56                   	push   %esi
 d1d:	e8 81 fd ff ff       	call   aa3 <write>
 d22:	0f b6 03             	movzbl (%ebx),%eax
 d25:	83 c4 10             	add    $0x10,%esp
 d28:	84 c0                	test   %al,%al
 d2a:	75 e4                	jne    d10 <printf+0x110>
 d2c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 d2f:	31 c9                	xor    %ecx,%ecx
 d31:	e9 1c ff ff ff       	jmp    c52 <printf+0x52>
 d36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 d3d:	8d 76 00             	lea    0x0(%esi),%esi
 d40:	83 ec 0c             	sub    $0xc,%esp
 d43:	b9 0a 00 00 00       	mov    $0xa,%ecx
 d48:	6a 01                	push   $0x1
 d4a:	e9 7b ff ff ff       	jmp    cca <printf+0xca>
 d4f:	90                   	nop
 d50:	8b 45 d0             	mov    -0x30(%ebp),%eax
 d53:	83 ec 04             	sub    $0x4,%esp
 d56:	8b 00                	mov    (%eax),%eax
 d58:	6a 01                	push   $0x1
 d5a:	57                   	push   %edi
 d5b:	56                   	push   %esi
 d5c:	88 45 e7             	mov    %al,-0x19(%ebp)
 d5f:	e8 3f fd ff ff       	call   aa3 <write>
 d64:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 d68:	83 c4 10             	add    $0x10,%esp
 d6b:	31 c9                	xor    %ecx,%ecx
 d6d:	e9 e0 fe ff ff       	jmp    c52 <printf+0x52>
 d72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 d78:	88 55 e7             	mov    %dl,-0x19(%ebp)
 d7b:	83 ec 04             	sub    $0x4,%esp
 d7e:	e9 2a ff ff ff       	jmp    cad <printf+0xad>
 d83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 d87:	90                   	nop
 d88:	ba c3 13 00 00       	mov    $0x13c3,%edx
 d8d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 d90:	b8 28 00 00 00       	mov    $0x28,%eax
 d95:	89 d3                	mov    %edx,%ebx
 d97:	e9 74 ff ff ff       	jmp    d10 <printf+0x110>
 d9c:	66 90                	xchg   %ax,%ax
 d9e:	66 90                	xchg   %ax,%ax

00000da0 <free>:
 da0:	55                   	push   %ebp
 da1:	a1 cc 17 00 00       	mov    0x17cc,%eax
 da6:	89 e5                	mov    %esp,%ebp
 da8:	57                   	push   %edi
 da9:	56                   	push   %esi
 daa:	53                   	push   %ebx
 dab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 dae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 db8:	89 c2                	mov    %eax,%edx
 dba:	8b 00                	mov    (%eax),%eax
 dbc:	39 ca                	cmp    %ecx,%edx
 dbe:	73 30                	jae    df0 <free+0x50>
 dc0:	39 c1                	cmp    %eax,%ecx
 dc2:	72 04                	jb     dc8 <free+0x28>
 dc4:	39 c2                	cmp    %eax,%edx
 dc6:	72 f0                	jb     db8 <free+0x18>
 dc8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 dcb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 dce:	39 f8                	cmp    %edi,%eax
 dd0:	74 30                	je     e02 <free+0x62>
 dd2:	89 43 f8             	mov    %eax,-0x8(%ebx)
 dd5:	8b 42 04             	mov    0x4(%edx),%eax
 dd8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 ddb:	39 f1                	cmp    %esi,%ecx
 ddd:	74 3a                	je     e19 <free+0x79>
 ddf:	89 0a                	mov    %ecx,(%edx)
 de1:	5b                   	pop    %ebx
 de2:	89 15 cc 17 00 00    	mov    %edx,0x17cc
 de8:	5e                   	pop    %esi
 de9:	5f                   	pop    %edi
 dea:	5d                   	pop    %ebp
 deb:	c3                   	ret    
 dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 df0:	39 c2                	cmp    %eax,%edx
 df2:	72 c4                	jb     db8 <free+0x18>
 df4:	39 c1                	cmp    %eax,%ecx
 df6:	73 c0                	jae    db8 <free+0x18>
 df8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 dfb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 dfe:	39 f8                	cmp    %edi,%eax
 e00:	75 d0                	jne    dd2 <free+0x32>
 e02:	03 70 04             	add    0x4(%eax),%esi
 e05:	89 73 fc             	mov    %esi,-0x4(%ebx)
 e08:	8b 02                	mov    (%edx),%eax
 e0a:	8b 00                	mov    (%eax),%eax
 e0c:	89 43 f8             	mov    %eax,-0x8(%ebx)
 e0f:	8b 42 04             	mov    0x4(%edx),%eax
 e12:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 e15:	39 f1                	cmp    %esi,%ecx
 e17:	75 c6                	jne    ddf <free+0x3f>
 e19:	03 43 fc             	add    -0x4(%ebx),%eax
 e1c:	89 15 cc 17 00 00    	mov    %edx,0x17cc
 e22:	89 42 04             	mov    %eax,0x4(%edx)
 e25:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 e28:	89 0a                	mov    %ecx,(%edx)
 e2a:	5b                   	pop    %ebx
 e2b:	5e                   	pop    %esi
 e2c:	5f                   	pop    %edi
 e2d:	5d                   	pop    %ebp
 e2e:	c3                   	ret    
 e2f:	90                   	nop

00000e30 <malloc>:
 e30:	55                   	push   %ebp
 e31:	89 e5                	mov    %esp,%ebp
 e33:	57                   	push   %edi
 e34:	56                   	push   %esi
 e35:	53                   	push   %ebx
 e36:	83 ec 1c             	sub    $0x1c,%esp
 e39:	8b 45 08             	mov    0x8(%ebp),%eax
 e3c:	8b 3d cc 17 00 00    	mov    0x17cc,%edi
 e42:	8d 70 07             	lea    0x7(%eax),%esi
 e45:	c1 ee 03             	shr    $0x3,%esi
 e48:	83 c6 01             	add    $0x1,%esi
 e4b:	85 ff                	test   %edi,%edi
 e4d:	0f 84 9d 00 00 00    	je     ef0 <malloc+0xc0>
 e53:	8b 17                	mov    (%edi),%edx
 e55:	8b 4a 04             	mov    0x4(%edx),%ecx
 e58:	39 f1                	cmp    %esi,%ecx
 e5a:	73 6a                	jae    ec6 <malloc+0x96>
 e5c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 e61:	39 de                	cmp    %ebx,%esi
 e63:	0f 43 de             	cmovae %esi,%ebx
 e66:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 e6d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 e70:	eb 17                	jmp    e89 <malloc+0x59>
 e72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 e78:	8b 02                	mov    (%edx),%eax
 e7a:	8b 48 04             	mov    0x4(%eax),%ecx
 e7d:	39 f1                	cmp    %esi,%ecx
 e7f:	73 4f                	jae    ed0 <malloc+0xa0>
 e81:	8b 3d cc 17 00 00    	mov    0x17cc,%edi
 e87:	89 c2                	mov    %eax,%edx
 e89:	39 d7                	cmp    %edx,%edi
 e8b:	75 eb                	jne    e78 <malloc+0x48>
 e8d:	83 ec 0c             	sub    $0xc,%esp
 e90:	ff 75 e4             	push   -0x1c(%ebp)
 e93:	e8 73 fc ff ff       	call   b0b <sbrk>
 e98:	83 c4 10             	add    $0x10,%esp
 e9b:	83 f8 ff             	cmp    $0xffffffff,%eax
 e9e:	74 1c                	je     ebc <malloc+0x8c>
 ea0:	89 58 04             	mov    %ebx,0x4(%eax)
 ea3:	83 ec 0c             	sub    $0xc,%esp
 ea6:	83 c0 08             	add    $0x8,%eax
 ea9:	50                   	push   %eax
 eaa:	e8 f1 fe ff ff       	call   da0 <free>
 eaf:	8b 15 cc 17 00 00    	mov    0x17cc,%edx
 eb5:	83 c4 10             	add    $0x10,%esp
 eb8:	85 d2                	test   %edx,%edx
 eba:	75 bc                	jne    e78 <malloc+0x48>
 ebc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ebf:	31 c0                	xor    %eax,%eax
 ec1:	5b                   	pop    %ebx
 ec2:	5e                   	pop    %esi
 ec3:	5f                   	pop    %edi
 ec4:	5d                   	pop    %ebp
 ec5:	c3                   	ret    
 ec6:	89 d0                	mov    %edx,%eax
 ec8:	89 fa                	mov    %edi,%edx
 eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 ed0:	39 ce                	cmp    %ecx,%esi
 ed2:	74 4c                	je     f20 <malloc+0xf0>
 ed4:	29 f1                	sub    %esi,%ecx
 ed6:	89 48 04             	mov    %ecx,0x4(%eax)
 ed9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 edc:	89 70 04             	mov    %esi,0x4(%eax)
 edf:	89 15 cc 17 00 00    	mov    %edx,0x17cc
 ee5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ee8:	83 c0 08             	add    $0x8,%eax
 eeb:	5b                   	pop    %ebx
 eec:	5e                   	pop    %esi
 eed:	5f                   	pop    %edi
 eee:	5d                   	pop    %ebp
 eef:	c3                   	ret    
 ef0:	c7 05 cc 17 00 00 d0 	movl   $0x17d0,0x17cc
 ef7:	17 00 00 
 efa:	bf d0 17 00 00       	mov    $0x17d0,%edi
 eff:	c7 05 d0 17 00 00 d0 	movl   $0x17d0,0x17d0
 f06:	17 00 00 
 f09:	89 fa                	mov    %edi,%edx
 f0b:	c7 05 d4 17 00 00 00 	movl   $0x0,0x17d4
 f12:	00 00 00 
 f15:	e9 42 ff ff ff       	jmp    e5c <malloc+0x2c>
 f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 f20:	8b 08                	mov    (%eax),%ecx
 f22:	89 0a                	mov    %ecx,(%edx)
 f24:	eb b9                	jmp    edf <malloc+0xaf>
