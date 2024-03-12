
_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
//   printf(1, "map0 is %x\n", map0);
//   printf(1, "finished move\n");
// }

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
      11:	68 67 1c 00 00       	push   $0x1c67
      16:	6a 01                	push   $0x1
      18:	e8 53 12 00 00       	call   1270 <printf>
  //test_wmapinfo();
 // test_remap();
  //test_single_wremap();
  //test_single_remap_shrink();
  //test_single_remap_move();
  test_fork();
      1d:	e8 8e 0b 00 00       	call   bb0 <test_fork>
  //test_pg();
  printf(1, "test finished\n");
      22:	58                   	pop    %eax
      23:	5a                   	pop    %edx
      24:	68 7a 1c 00 00       	push   $0x1c7a
      29:	6a 01                	push   $0x1
      2b:	e8 40 12 00 00       	call   1270 <printf>
  exit();
      30:	e8 be 10 00 00       	call   10f3 <exit>
      35:	66 90                	xchg   %ax,%ax
      37:	66 90                	xchg   %ax,%ax
      39:	66 90                	xchg   %ax,%ax
      3b:	66 90                	xchg   %ax,%ax
      3d:	66 90                	xchg   %ax,%ax
      3f:	90                   	nop

00000040 <test_mult_map_diff_touches>:
void test_mult_map_diff_touches () {
      40:	55                   	push   %ebp
      41:	89 e5                	mov    %esp,%ebp
      43:	57                   	push   %edi
      44:	56                   	push   %esi
      45:	53                   	push   %ebx
      46:	83 ec 14             	sub    $0x14,%esp
  printf(1, "Testing mult_map_diff_touches\n");
      49:	68 98 15 00 00       	push   $0x1598
      4e:	6a 01                	push   $0x1
      50:	e8 1b 12 00 00       	call   1270 <printf>
  printf(1, "\t-wmapping 0\n");
      55:	59                   	pop    %ecx
      56:	5b                   	pop    %ebx
      57:	68 33 19 00 00       	push   $0x1933
      5c:	6a 01                	push   $0x1
      5e:	e8 0d 12 00 00       	call   1270 <printf>
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
      63:	6a ff                	push   $0xffffffff
      65:	6a 0e                	push   $0xe
      67:	68 00 20 00 00       	push   $0x2000
      6c:	68 00 00 00 60       	push   $0x60000000
      71:	e8 1d 11 00 00       	call   1193 <wmap>
  printf(1, "\t-touching 0\n");
      76:	83 c4 18             	add    $0x18,%esp
      79:	68 41 19 00 00       	push   $0x1941
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
      7e:	89 c3                	mov    %eax,%ebx
  printf(1, "\t-touching 0\n");
      80:	6a 01                	push   $0x1
      82:	e8 e9 11 00 00       	call   1270 <printf>
  ptr0[0] = 'a';
      87:	c6 03 61             	movb   $0x61,(%ebx)
  printf(1, "\t-wmapping 1\n");
      8a:	5e                   	pop    %esi
      8b:	5f                   	pop    %edi
      8c:	68 4f 19 00 00       	push   $0x194f
      91:	6a 01                	push   $0x1
      93:	e8 d8 11 00 00       	call   1270 <printf>
  uint map1 = wmap(0x60003000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
      98:	6a ff                	push   $0xffffffff
      9a:	6a 0e                	push   $0xe
      9c:	68 00 10 00 00       	push   $0x1000
      a1:	68 00 30 00 60       	push   $0x60003000
      a6:	e8 e8 10 00 00       	call   1193 <wmap>
  printf(1, "\t-wmapping 2\n");
      ab:	83 c4 18             	add    $0x18,%esp
      ae:	68 5d 19 00 00       	push   $0x195d
  uint map1 = wmap(0x60003000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
      b3:	89 c6                	mov    %eax,%esi
  printf(1, "\t-wmapping 2\n");
      b5:	6a 01                	push   $0x1
      b7:	e8 b4 11 00 00       	call   1270 <printf>
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
      bc:	6a ff                	push   $0xffffffff
      be:	6a 0e                	push   $0xe
      c0:	68 00 10 00 00       	push   $0x1000
      c5:	68 00 20 00 60       	push   $0x60002000
      ca:	e8 c4 10 00 00       	call   1193 <wmap>
    printf(1, "\t-touching 1\n");
      cf:	83 c4 18             	add    $0x18,%esp
      d2:	68 6b 19 00 00       	push   $0x196b
  uint map2 = wmap(0x60002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
      d7:	89 c7                	mov    %eax,%edi
    printf(1, "\t-touching 1\n");
      d9:	6a 01                	push   $0x1
      db:	e8 90 11 00 00       	call   1270 <printf>
  ptr1[0] = 'b';
      e0:	c6 06 62             	movb   $0x62,(%esi)
  printf(1, "\t-map0 %c map1 %c\n", ptr0[0], ptr1[0]);
      e3:	6a 62                	push   $0x62
      e5:	0f be 03             	movsbl (%ebx),%eax
      e8:	50                   	push   %eax
      e9:	68 79 19 00 00       	push   $0x1979
      ee:	6a 01                	push   $0x1
      f0:	e8 7b 11 00 00       	call   1270 <printf>
  printf(1, "\nRESULT: ");
      f5:	83 c4 18             	add    $0x18,%esp
      f8:	68 8c 19 00 00       	push   $0x198c
      fd:	6a 01                	push   $0x1
      ff:	e8 6c 11 00 00       	call   1270 <printf>
  if (ptr0[0] == 'a' && ptr1[0] == 'b') {
     104:	83 c4 10             	add    $0x10,%esp
     107:	80 3b 61             	cmpb   $0x61,(%ebx)
     10a:	75 05                	jne    111 <test_mult_map_diff_touches+0xd1>
     10c:	80 3e 62             	cmpb   $0x62,(%esi)
     10f:	74 47                	je     158 <test_mult_map_diff_touches+0x118>
    printf(1, "FAILED");
     111:	83 ec 08             	sub    $0x8,%esp
     114:	68 b6 1a 00 00       	push   $0x1ab6
     119:	6a 01                	push   $0x1
     11b:	e8 50 11 00 00       	call   1270 <printf>
     120:	83 c4 10             	add    $0x10,%esp
  wunmap(map0);
     123:	83 ec 0c             	sub    $0xc,%esp
     126:	53                   	push   %ebx
     127:	e8 6f 10 00 00       	call   119b <wunmap>
  wunmap(map1);
     12c:	89 34 24             	mov    %esi,(%esp)
     12f:	e8 67 10 00 00       	call   119b <wunmap>
  wunmap(map2);
     134:	89 3c 24             	mov    %edi,(%esp)
     137:	e8 5f 10 00 00       	call   119b <wunmap>
  printf(1, "\n\n");
     13c:	58                   	pop    %eax
     13d:	5a                   	pop    %edx
     13e:	68 43 1a 00 00       	push   $0x1a43
     143:	6a 01                	push   $0x1
     145:	e8 26 11 00 00       	call   1270 <printf>
  return;
     14a:	83 c4 10             	add    $0x10,%esp
}
     14d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     150:	5b                   	pop    %ebx
     151:	5e                   	pop    %esi
     152:	5f                   	pop    %edi
     153:	5d                   	pop    %ebp
     154:	c3                   	ret    
     155:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "PASSED");
     158:	83 ec 08             	sub    $0x8,%esp
     15b:	68 96 19 00 00       	push   $0x1996
     160:	6a 01                	push   $0x1
     162:	e8 09 11 00 00       	call   1270 <printf>
     167:	83 c4 10             	add    $0x10,%esp
     16a:	eb b7                	jmp    123 <test_mult_map_diff_touches+0xe3>
     16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000170 <test_out_of_va>:
void test_out_of_va(void) {
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	83 ec 10             	sub    $0x10,%esp
  printf(1, "Testing test_out_of_va\n");
     176:	68 9d 19 00 00       	push   $0x199d
     17b:	6a 01                	push   $0x1
     17d:	e8 ee 10 00 00       	call   1270 <printf>
  printf(1, "\t-wmapping 0 to max size\n");
     182:	58                   	pop    %eax
     183:	5a                   	pop    %edx
     184:	68 b5 19 00 00       	push   $0x19b5
     189:	6a 01                	push   $0x1
     18b:	e8 e0 10 00 00       	call   1270 <printf>
  uint map0 = wmap(0x60000000, 0x20000000, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     190:	6a ff                	push   $0xffffffff
     192:	6a 0e                	push   $0xe
     194:	68 00 00 00 20       	push   $0x20000000
     199:	68 00 00 00 60       	push   $0x60000000
     19e:	e8 f0 0f 00 00       	call   1193 <wmap>
  printf(1, "\t-wmapping 1, so we get error message\n");
     1a3:	83 c4 18             	add    $0x18,%esp
     1a6:	68 b8 15 00 00       	push   $0x15b8
     1ab:	6a 01                	push   $0x1
     1ad:	e8 be 10 00 00       	call   1270 <printf>
  uint map1 = wmap(0x60001000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     1b2:	6a ff                	push   $0xffffffff
     1b4:	6a 0e                	push   $0xe
     1b6:	68 00 10 00 00       	push   $0x1000
     1bb:	68 00 10 00 60       	push   $0x60001000
     1c0:	e8 ce 0f 00 00       	call   1193 <wmap>
  printf(1, "\nCheck if got error message above\n");
     1c5:	83 c4 18             	add    $0x18,%esp
     1c8:	68 e0 15 00 00       	push   $0x15e0
     1cd:	6a 01                	push   $0x1
     1cf:	e8 9c 10 00 00       	call   1270 <printf>
}
     1d4:	83 c4 10             	add    $0x10,%esp
     1d7:	c9                   	leave  
     1d8:	c3                   	ret    
     1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001e0 <test_map_fixed>:
void test_map_fixed(void) {
     1e0:	55                   	push   %ebp
     1e1:	89 e5                	mov    %esp,%ebp
     1e3:	57                   	push   %edi
     1e4:	56                   	push   %esi
     1e5:	53                   	push   %ebx
     1e6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "Testing test_map_fixed\n");
     1e9:	68 cf 19 00 00       	push   $0x19cf
     1ee:	6a 01                	push   $0x1
     1f0:	e8 7b 10 00 00       	call   1270 <printf>
  printf(1, "\t-testing basic functionality\n");
     1f5:	58                   	pop    %eax
     1f6:	5a                   	pop    %edx
     1f7:	68 04 16 00 00       	push   $0x1604
     1fc:	6a 01                	push   $0x1
     1fe:	e8 6d 10 00 00       	call   1270 <printf>
  printf(1, "\t-wmapping 0 as fixed\n");
     203:	59                   	pop    %ecx
     204:	5b                   	pop    %ebx
     205:	68 e7 19 00 00       	push   $0x19e7
     20a:	6a 01                	push   $0x1
     20c:	e8 5f 10 00 00       	call   1270 <printf>
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     211:	6a ff                	push   $0xffffffff
     213:	6a 0e                	push   $0xe
     215:	68 00 20 00 00       	push   $0x2000
     21a:	68 00 00 00 60       	push   $0x60000000
     21f:	e8 6f 0f 00 00       	call   1193 <wmap>
  printf(1, "\t-wmapping 1 as not fixed, trying to get other addr\n");
     224:	83 c4 18             	add    $0x18,%esp
     227:	68 24 16 00 00       	push   $0x1624
  uint map0 = wmap(0x60000000, 8192, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     22c:	89 c6                	mov    %eax,%esi
  printf(1, "\t-wmapping 1 as not fixed, trying to get other addr\n");
     22e:	6a 01                	push   $0x1
     230:	e8 3b 10 00 00       	call   1270 <printf>
  uint map1 = wmap(0x60000000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
     235:	6a ff                	push   $0xffffffff
     237:	6a 06                	push   $0x6
     239:	68 00 20 00 00       	push   $0x2000
     23e:	68 00 00 00 60       	push   $0x60000000
     243:	e8 4b 0f 00 00       	call   1193 <wmap>
  printf(1, "\nShould be 0x60002000\n\n");
     248:	83 c4 18             	add    $0x18,%esp
     24b:	68 fe 19 00 00       	push   $0x19fe
  uint map1 = wmap(0x60000000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
     250:	89 c3                	mov    %eax,%ebx
  printf(1, "\nShould be 0x60002000\n\n");
     252:	6a 01                	push   $0x1
     254:	e8 17 10 00 00       	call   1270 <printf>
  printf(1, "\t-testing if doesn't break with endpoints\n");
     259:	5f                   	pop    %edi
     25a:	58                   	pop    %eax
     25b:	68 5c 16 00 00       	push   $0x165c
     260:	6a 01                	push   $0x1
     262:	e8 09 10 00 00       	call   1270 <printf>
  wunmap(map0);
     267:	89 34 24             	mov    %esi,(%esp)
     26a:	e8 2c 0f 00 00       	call   119b <wunmap>
  printf(1, "\t-wmapping 0 as not fixed, trying to get other addr\n");
     26f:	58                   	pop    %eax
     270:	5a                   	pop    %edx
     271:	68 88 16 00 00       	push   $0x1688
     276:	6a 01                	push   $0x1
     278:	e8 f3 0f 00 00       	call   1270 <printf>
  map0 = wmap(0x60000000, 4096 * 3, MAP_SHARED | MAP_ANONYMOUS, -1);
     27d:	6a ff                	push   $0xffffffff
     27f:	6a 06                	push   $0x6
     281:	68 00 30 00 00       	push   $0x3000
     286:	68 00 00 00 60       	push   $0x60000000
     28b:	e8 03 0f 00 00       	call   1193 <wmap>
  printf(1, "\nShould be 0x60004000\n\n");
     290:	83 c4 18             	add    $0x18,%esp
     293:	68 16 1a 00 00       	push   $0x1a16
  map0 = wmap(0x60000000, 4096 * 3, MAP_SHARED | MAP_ANONYMOUS, -1);
     298:	89 c6                	mov    %eax,%esi
  printf(1, "\nShould be 0x60004000\n\n");
     29a:	6a 01                	push   $0x1
     29c:	e8 cf 0f 00 00       	call   1270 <printf>
  printf(1, "\t-testing if doesn't break if exceding 0x80000000\n");
     2a1:	59                   	pop    %ecx
     2a2:	5f                   	pop    %edi
     2a3:	68 c0 16 00 00       	push   $0x16c0
     2a8:	6a 01                	push   $0x1
     2aa:	e8 c1 0f 00 00       	call   1270 <printf>
  wunmap(map0);
     2af:	89 34 24             	mov    %esi,(%esp)
     2b2:	e8 e4 0e 00 00       	call   119b <wunmap>
  wunmap(map1);
     2b7:	89 1c 24             	mov    %ebx,(%esp)
     2ba:	e8 dc 0e 00 00       	call   119b <wunmap>
  printf(1, "\t-wmapping 0 as fixed at 0x7fffe000\n");
     2bf:	58                   	pop    %eax
     2c0:	5a                   	pop    %edx
     2c1:	68 f4 16 00 00       	push   $0x16f4
     2c6:	6a 01                	push   $0x1
     2c8:	e8 a3 0f 00 00       	call   1270 <printf>
  map0 = wmap(0x7fffe000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     2cd:	6a ff                	push   $0xffffffff
     2cf:	6a 0e                	push   $0xe
     2d1:	68 00 10 00 00       	push   $0x1000
     2d6:	68 00 e0 ff 7f       	push   $0x7fffe000
     2db:	e8 b3 0e 00 00       	call   1193 <wmap>
  printf(1, "\t-wmapping 1 with 8192, needing to loop\n");
     2e0:	83 c4 18             	add    $0x18,%esp
     2e3:	68 1c 17 00 00       	push   $0x171c
  map0 = wmap(0x7fffe000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     2e8:	89 c6                	mov    %eax,%esi
  printf(1, "\t-wmapping 1 with 8192, needing to loop\n");
     2ea:	6a 01                	push   $0x1
     2ec:	e8 7f 0f 00 00       	call   1270 <printf>
  map1 = wmap(0x7fffe000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
     2f1:	6a ff                	push   $0xffffffff
     2f3:	6a 06                	push   $0x6
     2f5:	68 00 20 00 00       	push   $0x2000
     2fa:	68 00 e0 ff 7f       	push   $0x7fffe000
     2ff:	e8 8f 0e 00 00       	call   1193 <wmap>
  printf(1, "\nShould be 0x60000000\n\n");
     304:	83 c4 18             	add    $0x18,%esp
     307:	68 2e 1a 00 00       	push   $0x1a2e
  map1 = wmap(0x7fffe000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
     30c:	89 c3                	mov    %eax,%ebx
  printf(1, "\nShould be 0x60000000\n\n");
     30e:	6a 01                	push   $0x1
     310:	e8 5b 0f 00 00       	call   1270 <printf>
  wunmap(map0);
     315:	89 34 24             	mov    %esi,(%esp)
     318:	e8 7e 0e 00 00       	call   119b <wunmap>
  wunmap(map1);
     31d:	89 1c 24             	mov    %ebx,(%esp)
     320:	e8 76 0e 00 00       	call   119b <wunmap>
  printf(1, "\t-big wmapping aloc\n");
     325:	59                   	pop    %ecx
     326:	5b                   	pop    %ebx
     327:	68 46 1a 00 00       	push   $0x1a46
     32c:	6a 01                	push   $0x1
     32e:	e8 3d 0f 00 00       	call   1270 <printf>
  map0 = wmap(0x60000000, 0x20000000 - 4 * 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     333:	6a ff                	push   $0xffffffff
     335:	6a 0e                	push   $0xe
     337:	68 00 c0 ff 1f       	push   $0x1fffc000
     33c:	68 00 00 00 60       	push   $0x60000000
     341:	e8 4d 0e 00 00       	call   1193 <wmap>
  printf(1, "\t-allocing one page, leaving one page in the middle\n");
     346:	83 c4 18             	add    $0x18,%esp
     349:	68 48 17 00 00       	push   $0x1748
     34e:	6a 01                	push   $0x1
  map0 = wmap(0x60000000, 0x20000000 - 4 * 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     350:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  printf(1, "\t-allocing one page, leaving one page in the middle\n");
     353:	e8 18 0f 00 00       	call   1270 <printf>
  map1 = wmap(0x80000000 - 3 * 4096, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     358:	6a ff                	push   $0xffffffff
     35a:	6a 0e                	push   $0xe
     35c:	68 00 10 00 00       	push   $0x1000
     361:	68 00 d0 ff 7f       	push   $0x7fffd000
     366:	e8 28 0e 00 00       	call   1193 <wmap>
  printf(1, "\t-allocing another page, leaving one in the middle\n");
     36b:	83 c4 18             	add    $0x18,%esp
     36e:	68 80 17 00 00       	push   $0x1780
  map1 = wmap(0x80000000 - 3 * 4096, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     373:	89 c7                	mov    %eax,%edi
  printf(1, "\t-allocing another page, leaving one in the middle\n");
     375:	6a 01                	push   $0x1
     377:	e8 f4 0e 00 00       	call   1270 <printf>
  uint map2 = wmap(0x80000000 - 4096, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     37c:	6a ff                	push   $0xffffffff
     37e:	6a 0e                	push   $0xe
     380:	68 00 10 00 00       	push   $0x1000
     385:	68 00 f0 ff 7f       	push   $0x7ffff000
     38a:	e8 04 0e 00 00       	call   1193 <wmap>
  printf(1, "\t-trying to alloc contiguously 2 pages, but should fail\n");
     38f:	83 c4 18             	add    $0x18,%esp
     392:	68 b4 17 00 00       	push   $0x17b4
  uint map2 = wmap(0x80000000 - 4096, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     397:	89 c6                	mov    %eax,%esi
  printf(1, "\t-trying to alloc contiguously 2 pages, but should fail\n");
     399:	6a 01                	push   $0x1
     39b:	e8 d0 0e 00 00       	call   1270 <printf>
  uint map3 = wmap(0x60000000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
     3a0:	6a ff                	push   $0xffffffff
     3a2:	6a 06                	push   $0x6
     3a4:	68 00 20 00 00       	push   $0x2000
     3a9:	68 00 00 00 60       	push   $0x60000000
     3ae:	e8 e0 0d 00 00       	call   1193 <wmap>
  printf(1, "\nShould have failed\n\n");
     3b3:	83 c4 18             	add    $0x18,%esp
     3b6:	68 5b 1a 00 00       	push   $0x1a5b
  uint map3 = wmap(0x60000000, 8192, MAP_SHARED | MAP_ANONYMOUS, -1);
     3bb:	89 c3                	mov    %eax,%ebx
  printf(1, "\nShould have failed\n\n");
     3bd:	6a 01                	push   $0x1
     3bf:	e8 ac 0e 00 00       	call   1270 <printf>
  printf(1, "\n\n");
     3c4:	58                   	pop    %eax
     3c5:	5a                   	pop    %edx
     3c6:	68 43 1a 00 00       	push   $0x1a43
     3cb:	6a 01                	push   $0x1
     3cd:	e8 9e 0e 00 00       	call   1270 <printf>
  wunmap(map0);
     3d2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     3d5:	89 14 24             	mov    %edx,(%esp)
     3d8:	e8 be 0d 00 00       	call   119b <wunmap>
  wunmap(map1);
     3dd:	89 3c 24             	mov    %edi,(%esp)
     3e0:	e8 b6 0d 00 00       	call   119b <wunmap>
  wunmap(map2);
     3e5:	89 34 24             	mov    %esi,(%esp)
     3e8:	e8 ae 0d 00 00       	call   119b <wunmap>
  wunmap(map3);
     3ed:	89 1c 24             	mov    %ebx,(%esp)
     3f0:	e8 a6 0d 00 00       	call   119b <wunmap>
  return;
     3f5:	83 c4 10             	add    $0x10,%esp
}
     3f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
     3fb:	5b                   	pop    %ebx
     3fc:	5e                   	pop    %esi
     3fd:	5f                   	pop    %edi
     3fe:	5d                   	pop    %ebp
     3ff:	c3                   	ret    

00000400 <test_remap>:
void test_remap(void) {
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	57                   	push   %edi
     404:	56                   	push   %esi
     405:	53                   	push   %ebx
     406:	81 ec f4 00 00 00    	sub    $0xf4,%esp
  printf(1, "Testing test_remap\n");
     40c:	68 71 1a 00 00       	push   $0x1a71
     411:	6a 01                	push   $0x1
     413:	e8 58 0e 00 00       	call   1270 <printf>
  printf(1, "\t-testing if ifs are right\n");
     418:	5b                   	pop    %ebx
     419:	5e                   	pop    %esi
     41a:	68 85 1a 00 00       	push   $0x1a85
     41f:	6a 01                	push   $0x1
  if(getwmapinfo(&wminfo) < 0){
     421:	8d 9d 24 ff ff ff    	lea    -0xdc(%ebp),%ebx
     427:	31 f6                	xor    %esi,%esi
  printf(1, "\t-testing if ifs are right\n");
     429:	e8 42 0e 00 00       	call   1270 <printf>
  uint map0 = wmap(0x60000000, 4096,  MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     42e:	6a ff                	push   $0xffffffff
     430:	6a 0e                	push   $0xe
     432:	68 00 10 00 00       	push   $0x1000
     437:	68 00 00 00 60       	push   $0x60000000
     43c:	e8 52 0d 00 00       	call   1193 <wmap>
  printf(1, "mapinfo 1:\n");
     441:	83 c4 18             	add    $0x18,%esp
     444:	68 a1 1a 00 00       	push   $0x1aa1
  uint map0 = wmap(0x60000000, 4096,  MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     449:	89 c7                	mov    %eax,%edi
  printf(1, "mapinfo 1:\n");
     44b:	6a 01                	push   $0x1
     44d:	e8 1e 0e 00 00       	call   1270 <printf>
  if(getwmapinfo(&wminfo) < 0){
     452:	89 1c 24             	mov    %ebx,(%esp)
     455:	e8 59 0d 00 00       	call   11b3 <getwmapinfo>
     45a:	83 c4 10             	add    $0x10,%esp
     45d:	85 c0                	test   %eax,%eax
     45f:	79 17                	jns    478 <test_remap+0x78>
     461:	e9 2a 07 00 00       	jmp    b90 <test_remap+0x790>
     466:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     46d:	8d 76 00             	lea    0x0(%esi),%esi
  for(int i = 0; i < 16; ++i){
     470:	83 c6 01             	add    $0x1,%esi
     473:	83 fe 10             	cmp    $0x10,%esi
     476:	74 6d                	je     4e5 <test_remap+0xe5>
    if(wminfo.addr[i]!=0){
     478:	8b 4c b3 04          	mov    0x4(%ebx,%esi,4),%ecx
     47c:	85 c9                	test   %ecx,%ecx
     47e:	74 f0                	je     470 <test_remap+0x70>
      printf(1, "\t-i=%d\n", i);
     480:	83 ec 04             	sub    $0x4,%esp
     483:	56                   	push   %esi
     484:	68 bd 1a 00 00       	push   $0x1abd
     489:	6a 01                	push   $0x1
     48b:	e8 e0 0d 00 00       	call   1270 <printf>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
     490:	83 c4 0c             	add    $0xc,%esp
     493:	ff b4 b3 84 00 00 00 	push   0x84(%ebx,%esi,4)
     49a:	68 c5 1a 00 00       	push   $0x1ac5
     49f:	6a 01                	push   $0x1
     4a1:	e8 ca 0d 00 00       	call   1270 <printf>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
     4a6:	83 c4 0c             	add    $0xc,%esp
     4a9:	ff 74 b3 04          	push   0x4(%ebx,%esi,4)
     4ad:	68 d9 1a 00 00       	push   $0x1ad9
     4b2:	6a 01                	push   $0x1
     4b4:	e8 b7 0d 00 00       	call   1270 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     4b9:	83 c4 0c             	add    $0xc,%esp
     4bc:	ff 74 b3 44          	push   0x44(%ebx,%esi,4)
  for(int i = 0; i < 16; ++i){
     4c0:	83 c6 01             	add    $0x1,%esi
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     4c3:	68 ee 1a 00 00       	push   $0x1aee
     4c8:	6a 01                	push   $0x1
     4ca:	e8 a1 0d 00 00       	call   1270 <printf>
      printf(1, "\n");
     4cf:	58                   	pop    %eax
     4d0:	5a                   	pop    %edx
     4d1:	68 44 1a 00 00       	push   $0x1a44
     4d6:	6a 01                	push   $0x1
     4d8:	e8 93 0d 00 00       	call   1270 <printf>
     4dd:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
     4e0:	83 fe 10             	cmp    $0x10,%esi
     4e3:	75 93                	jne    478 <test_remap+0x78>
  uint map2 = wmap(0x70000000, 4096,  MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     4e5:	6a ff                	push   $0xffffffff
     4e7:	6a 0e                	push   $0xe
     4e9:	68 00 10 00 00       	push   $0x1000
     4ee:	68 00 00 00 70       	push   $0x70000000
     4f3:	e8 9b 0c 00 00       	call   1193 <wmap>
  if(getwmapinfo(&wminfo) < 0){
     4f8:	89 1c 24             	mov    %ebx,(%esp)
  uint map2 = wmap(0x70000000, 4096,  MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     4fb:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  if(getwmapinfo(&wminfo) < 0){
     501:	e8 ad 0c 00 00       	call   11b3 <getwmapinfo>
     506:	83 c4 10             	add    $0x10,%esp
     509:	85 c0                	test   %eax,%eax
     50b:	0f 88 7f 06 00 00    	js     b90 <test_remap+0x790>
  printf(1, "mapinfo 2:\n");
     511:	83 ec 08             	sub    $0x8,%esp
  for(int i = 0; i < 16; ++i){
     514:	31 f6                	xor    %esi,%esi
  printf(1, "mapinfo 2:\n");
     516:	68 00 1b 00 00       	push   $0x1b00
     51b:	6a 01                	push   $0x1
     51d:	e8 4e 0d 00 00       	call   1270 <printf>
     522:	83 c4 10             	add    $0x10,%esp
     525:	eb 11                	jmp    538 <test_remap+0x138>
     527:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     52e:	66 90                	xchg   %ax,%ax
  for(int i = 0; i < 16; ++i){
     530:	83 c6 01             	add    $0x1,%esi
     533:	83 fe 10             	cmp    $0x10,%esi
     536:	74 6d                	je     5a5 <test_remap+0x1a5>
    if(wminfo.addr[i]!=0){
     538:	8b 4c b3 04          	mov    0x4(%ebx,%esi,4),%ecx
     53c:	85 c9                	test   %ecx,%ecx
     53e:	74 f0                	je     530 <test_remap+0x130>
      printf(1, "\t-i=%d\n", i);
     540:	83 ec 04             	sub    $0x4,%esp
     543:	56                   	push   %esi
     544:	68 bd 1a 00 00       	push   $0x1abd
     549:	6a 01                	push   $0x1
     54b:	e8 20 0d 00 00       	call   1270 <printf>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
     550:	83 c4 0c             	add    $0xc,%esp
     553:	ff b4 b3 84 00 00 00 	push   0x84(%ebx,%esi,4)
     55a:	68 c5 1a 00 00       	push   $0x1ac5
     55f:	6a 01                	push   $0x1
     561:	e8 0a 0d 00 00       	call   1270 <printf>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
     566:	83 c4 0c             	add    $0xc,%esp
     569:	ff 74 b3 04          	push   0x4(%ebx,%esi,4)
     56d:	68 d9 1a 00 00       	push   $0x1ad9
     572:	6a 01                	push   $0x1
     574:	e8 f7 0c 00 00       	call   1270 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     579:	83 c4 0c             	add    $0xc,%esp
     57c:	ff 74 b3 44          	push   0x44(%ebx,%esi,4)
  for(int i = 0; i < 16; ++i){
     580:	83 c6 01             	add    $0x1,%esi
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     583:	68 ee 1a 00 00       	push   $0x1aee
     588:	6a 01                	push   $0x1
     58a:	e8 e1 0c 00 00       	call   1270 <printf>
      printf(1, "\n");
     58f:	58                   	pop    %eax
     590:	5a                   	pop    %edx
     591:	68 44 1a 00 00       	push   $0x1a44
     596:	6a 01                	push   $0x1
     598:	e8 d3 0c 00 00       	call   1270 <printf>
     59d:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
     5a0:	83 fe 10             	cmp    $0x10,%esi
     5a3:	75 93                	jne    538 <test_remap+0x138>
  map0 = wremap(map0, 4096, 8192, 0);
     5a5:	6a 00                	push   $0x0
     5a7:	68 00 20 00 00       	push   $0x2000
     5ac:	68 00 10 00 00       	push   $0x1000
     5b1:	57                   	push   %edi
     5b2:	e8 ec 0b 00 00       	call   11a3 <wremap>
     5b7:	89 c7                	mov    %eax,%edi
  printf(1, "Should be Valid for in place\n\n");
     5b9:	58                   	pop    %eax
     5ba:	5a                   	pop    %edx
     5bb:	68 f0 17 00 00       	push   $0x17f0
     5c0:	6a 01                	push   $0x1
     5c2:	e8 a9 0c 00 00       	call   1270 <printf>
  printf(1, "mapinfo 3 after first remap:\n");
     5c7:	59                   	pop    %ecx
     5c8:	5e                   	pop    %esi
     5c9:	68 0c 1b 00 00       	push   $0x1b0c
     5ce:	6a 01                	push   $0x1
     5d0:	e8 9b 0c 00 00       	call   1270 <printf>
  if(getwmapinfo(&wminfo) < 0){
     5d5:	89 1c 24             	mov    %ebx,(%esp)
     5d8:	e8 d6 0b 00 00       	call   11b3 <getwmapinfo>
     5dd:	83 c4 10             	add    $0x10,%esp
     5e0:	85 c0                	test   %eax,%eax
     5e2:	0f 88 a8 05 00 00    	js     b90 <test_remap+0x790>
  for(int i = 0; i < 16; ++i){
     5e8:	31 f6                	xor    %esi,%esi
     5ea:	eb 0c                	jmp    5f8 <test_remap+0x1f8>
     5ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     5f0:	83 c6 01             	add    $0x1,%esi
     5f3:	83 fe 10             	cmp    $0x10,%esi
     5f6:	74 6d                	je     665 <test_remap+0x265>
    if(wminfo.addr[i]!=0){
     5f8:	8b 44 b3 04          	mov    0x4(%ebx,%esi,4),%eax
     5fc:	85 c0                	test   %eax,%eax
     5fe:	74 f0                	je     5f0 <test_remap+0x1f0>
      printf(1, "\t-i=%d\n", i);
     600:	83 ec 04             	sub    $0x4,%esp
     603:	56                   	push   %esi
     604:	68 bd 1a 00 00       	push   $0x1abd
     609:	6a 01                	push   $0x1
     60b:	e8 60 0c 00 00       	call   1270 <printf>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
     610:	83 c4 0c             	add    $0xc,%esp
     613:	ff b4 b3 84 00 00 00 	push   0x84(%ebx,%esi,4)
     61a:	68 c5 1a 00 00       	push   $0x1ac5
     61f:	6a 01                	push   $0x1
     621:	e8 4a 0c 00 00       	call   1270 <printf>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
     626:	83 c4 0c             	add    $0xc,%esp
     629:	ff 74 b3 04          	push   0x4(%ebx,%esi,4)
     62d:	68 d9 1a 00 00       	push   $0x1ad9
     632:	6a 01                	push   $0x1
     634:	e8 37 0c 00 00       	call   1270 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     639:	83 c4 0c             	add    $0xc,%esp
     63c:	ff 74 b3 44          	push   0x44(%ebx,%esi,4)
  for(int i = 0; i < 16; ++i){
     640:	83 c6 01             	add    $0x1,%esi
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     643:	68 ee 1a 00 00       	push   $0x1aee
     648:	6a 01                	push   $0x1
     64a:	e8 21 0c 00 00       	call   1270 <printf>
      printf(1, "\n");
     64f:	59                   	pop    %ecx
     650:	58                   	pop    %eax
     651:	68 44 1a 00 00       	push   $0x1a44
     656:	6a 01                	push   $0x1
     658:	e8 13 0c 00 00       	call   1270 <printf>
     65d:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
     660:	83 fe 10             	cmp    $0x10,%esi
     663:	75 93                	jne    5f8 <test_remap+0x1f8>
  map0 = wremap(map0, 8192, 4096 * 3, MREMAP_MAYMOVE);
     665:	6a 01                	push   $0x1
     667:	68 00 30 00 00       	push   $0x3000
     66c:	68 00 20 00 00       	push   $0x2000
     671:	57                   	push   %edi
     672:	e8 2c 0b 00 00       	call   11a3 <wremap>
  printf(1, "Should be Valid for in place\n\n");
     677:	5e                   	pop    %esi
  map0 = wremap(map0, 8192, 4096 * 3, MREMAP_MAYMOVE);
     678:	89 c7                	mov    %eax,%edi
  printf(1, "Should be Valid for in place\n\n");
     67a:	58                   	pop    %eax
     67b:	68 f0 17 00 00       	push   $0x17f0
     680:	6a 01                	push   $0x1
     682:	e8 e9 0b 00 00       	call   1270 <printf>
  printf(1, "mapinfo 4 after second remap:\n");
     687:	58                   	pop    %eax
     688:	5a                   	pop    %edx
     689:	68 10 18 00 00       	push   $0x1810
     68e:	6a 01                	push   $0x1
     690:	e8 db 0b 00 00       	call   1270 <printf>
  if(getwmapinfo(&wminfo) < 0){
     695:	89 1c 24             	mov    %ebx,(%esp)
     698:	e8 16 0b 00 00       	call   11b3 <getwmapinfo>
     69d:	83 c4 10             	add    $0x10,%esp
     6a0:	85 c0                	test   %eax,%eax
     6a2:	0f 88 e8 04 00 00    	js     b90 <test_remap+0x790>
  for(int i = 0; i < 16; ++i){
     6a8:	31 f6                	xor    %esi,%esi
     6aa:	eb 0c                	jmp    6b8 <test_remap+0x2b8>
     6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     6b0:	83 c6 01             	add    $0x1,%esi
     6b3:	83 fe 10             	cmp    $0x10,%esi
     6b6:	74 6d                	je     725 <test_remap+0x325>
    if(wminfo.addr[i]!=0){
     6b8:	8b 4c b3 04          	mov    0x4(%ebx,%esi,4),%ecx
     6bc:	85 c9                	test   %ecx,%ecx
     6be:	74 f0                	je     6b0 <test_remap+0x2b0>
      printf(1, "\t-i=%d\n", i);
     6c0:	83 ec 04             	sub    $0x4,%esp
     6c3:	56                   	push   %esi
     6c4:	68 bd 1a 00 00       	push   $0x1abd
     6c9:	6a 01                	push   $0x1
     6cb:	e8 a0 0b 00 00       	call   1270 <printf>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
     6d0:	83 c4 0c             	add    $0xc,%esp
     6d3:	ff b4 b3 84 00 00 00 	push   0x84(%ebx,%esi,4)
     6da:	68 c5 1a 00 00       	push   $0x1ac5
     6df:	6a 01                	push   $0x1
     6e1:	e8 8a 0b 00 00       	call   1270 <printf>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
     6e6:	83 c4 0c             	add    $0xc,%esp
     6e9:	ff 74 b3 04          	push   0x4(%ebx,%esi,4)
     6ed:	68 d9 1a 00 00       	push   $0x1ad9
     6f2:	6a 01                	push   $0x1
     6f4:	e8 77 0b 00 00       	call   1270 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     6f9:	83 c4 0c             	add    $0xc,%esp
     6fc:	ff 74 b3 44          	push   0x44(%ebx,%esi,4)
  for(int i = 0; i < 16; ++i){
     700:	83 c6 01             	add    $0x1,%esi
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     703:	68 ee 1a 00 00       	push   $0x1aee
     708:	6a 01                	push   $0x1
     70a:	e8 61 0b 00 00       	call   1270 <printf>
      printf(1, "\n");
     70f:	58                   	pop    %eax
     710:	5a                   	pop    %edx
     711:	68 44 1a 00 00       	push   $0x1a44
     716:	6a 01                	push   $0x1
     718:	e8 53 0b 00 00       	call   1270 <printf>
     71d:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
     720:	83 fe 10             	cmp    $0x10,%esi
     723:	75 93                	jne    6b8 <test_remap+0x2b8>
  uint map1 = wmap(0x60003000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     725:	6a ff                	push   $0xffffffff
     727:	6a 0e                	push   $0xe
     729:	68 00 10 00 00       	push   $0x1000
     72e:	68 00 30 00 60       	push   $0x60003000
     733:	e8 5b 0a 00 00       	call   1193 <wmap>
  uint map3 = wmap(0x70002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     738:	6a ff                	push   $0xffffffff
     73a:	6a 0e                	push   $0xe
     73c:	68 00 10 00 00       	push   $0x1000
     741:	68 00 20 00 70       	push   $0x70002000
  uint map1 = wmap(0x60003000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     746:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
  uint map3 = wmap(0x70002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     74c:	e8 42 0a 00 00       	call   1193 <wmap>
  printf(1, "mapinfo 5 after two more maps:\n");
     751:	83 c4 18             	add    $0x18,%esp
     754:	68 30 18 00 00       	push   $0x1830
     759:	6a 01                	push   $0x1
  uint map3 = wmap(0x70002000, 4096, MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1);
     75b:	89 85 0c ff ff ff    	mov    %eax,-0xf4(%ebp)
  printf(1, "mapinfo 5 after two more maps:\n");
     761:	e8 0a 0b 00 00       	call   1270 <printf>
  if(getwmapinfo(&wminfo) < 0){
     766:	89 1c 24             	mov    %ebx,(%esp)
     769:	e8 45 0a 00 00       	call   11b3 <getwmapinfo>
     76e:	83 c4 10             	add    $0x10,%esp
     771:	85 c0                	test   %eax,%eax
     773:	0f 88 17 04 00 00    	js     b90 <test_remap+0x790>
  for(int i = 0; i < 16; ++i){
     779:	31 f6                	xor    %esi,%esi
     77b:	eb 0b                	jmp    788 <test_remap+0x388>
     77d:	8d 76 00             	lea    0x0(%esi),%esi
     780:	83 c6 01             	add    $0x1,%esi
     783:	83 fe 10             	cmp    $0x10,%esi
     786:	74 6d                	je     7f5 <test_remap+0x3f5>
    if(wminfo.addr[i]!=0){
     788:	8b 44 b3 04          	mov    0x4(%ebx,%esi,4),%eax
     78c:	85 c0                	test   %eax,%eax
     78e:	74 f0                	je     780 <test_remap+0x380>
      printf(1, "\t-i=%d\n", i);
     790:	83 ec 04             	sub    $0x4,%esp
     793:	56                   	push   %esi
     794:	68 bd 1a 00 00       	push   $0x1abd
     799:	6a 01                	push   $0x1
     79b:	e8 d0 0a 00 00       	call   1270 <printf>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
     7a0:	83 c4 0c             	add    $0xc,%esp
     7a3:	ff b4 b3 84 00 00 00 	push   0x84(%ebx,%esi,4)
     7aa:	68 c5 1a 00 00       	push   $0x1ac5
     7af:	6a 01                	push   $0x1
     7b1:	e8 ba 0a 00 00       	call   1270 <printf>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
     7b6:	83 c4 0c             	add    $0xc,%esp
     7b9:	ff 74 b3 04          	push   0x4(%ebx,%esi,4)
     7bd:	68 d9 1a 00 00       	push   $0x1ad9
     7c2:	6a 01                	push   $0x1
     7c4:	e8 a7 0a 00 00       	call   1270 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     7c9:	83 c4 0c             	add    $0xc,%esp
     7cc:	ff 74 b3 44          	push   0x44(%ebx,%esi,4)
  for(int i = 0; i < 16; ++i){
     7d0:	83 c6 01             	add    $0x1,%esi
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     7d3:	68 ee 1a 00 00       	push   $0x1aee
     7d8:	6a 01                	push   $0x1
     7da:	e8 91 0a 00 00       	call   1270 <printf>
      printf(1, "\n");
     7df:	59                   	pop    %ecx
     7e0:	58                   	pop    %eax
     7e1:	68 44 1a 00 00       	push   $0x1a44
     7e6:	6a 01                	push   $0x1
     7e8:	e8 83 0a 00 00       	call   1270 <printf>
     7ed:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
     7f0:	83 fe 10             	cmp    $0x10,%esi
     7f3:	75 93                	jne    788 <test_remap+0x388>
  wremap(map0, 4096 * 3, 4096 * 4, 0);
     7f5:	6a 00                	push   $0x0
     7f7:	68 00 40 00 00       	push   $0x4000
     7fc:	68 00 30 00 00       	push   $0x3000
     801:	57                   	push   %edi
     802:	e8 9c 09 00 00       	call   11a3 <wremap>
  printf(1, "Should be Cannot\tmap0= %x\n\n",map0);
     807:	83 c4 0c             	add    $0xc,%esp
     80a:	57                   	push   %edi
     80b:	68 2a 1b 00 00       	push   $0x1b2a
     810:	6a 01                	push   $0x1
     812:	e8 59 0a 00 00       	call   1270 <printf>
  printf(1, "mapinfo 6 after attempted remaps:\n");
     817:	58                   	pop    %eax
     818:	5a                   	pop    %edx
     819:	68 50 18 00 00       	push   $0x1850
     81e:	6a 01                	push   $0x1
     820:	e8 4b 0a 00 00       	call   1270 <printf>
  if(getwmapinfo(&wminfo) < 0){
     825:	89 1c 24             	mov    %ebx,(%esp)
     828:	e8 86 09 00 00       	call   11b3 <getwmapinfo>
     82d:	83 c4 10             	add    $0x10,%esp
     830:	85 c0                	test   %eax,%eax
     832:	0f 88 58 03 00 00    	js     b90 <test_remap+0x790>
  for(int i = 0; i < 16; ++i){
     838:	31 f6                	xor    %esi,%esi
     83a:	eb 0c                	jmp    848 <test_remap+0x448>
     83c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     840:	83 c6 01             	add    $0x1,%esi
     843:	83 fe 10             	cmp    $0x10,%esi
     846:	74 6d                	je     8b5 <test_remap+0x4b5>
    if(wminfo.addr[i]!=0){
     848:	8b 44 b3 04          	mov    0x4(%ebx,%esi,4),%eax
     84c:	85 c0                	test   %eax,%eax
     84e:	74 f0                	je     840 <test_remap+0x440>
      printf(1, "\t-i=%d\n", i);
     850:	83 ec 04             	sub    $0x4,%esp
     853:	56                   	push   %esi
     854:	68 bd 1a 00 00       	push   $0x1abd
     859:	6a 01                	push   $0x1
     85b:	e8 10 0a 00 00       	call   1270 <printf>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
     860:	83 c4 0c             	add    $0xc,%esp
     863:	ff b4 b3 84 00 00 00 	push   0x84(%ebx,%esi,4)
     86a:	68 c5 1a 00 00       	push   $0x1ac5
     86f:	6a 01                	push   $0x1
     871:	e8 fa 09 00 00       	call   1270 <printf>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
     876:	83 c4 0c             	add    $0xc,%esp
     879:	ff 74 b3 04          	push   0x4(%ebx,%esi,4)
     87d:	68 d9 1a 00 00       	push   $0x1ad9
     882:	6a 01                	push   $0x1
     884:	e8 e7 09 00 00       	call   1270 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     889:	83 c4 0c             	add    $0xc,%esp
     88c:	ff 74 b3 44          	push   0x44(%ebx,%esi,4)
  for(int i = 0; i < 16; ++i){
     890:	83 c6 01             	add    $0x1,%esi
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     893:	68 ee 1a 00 00       	push   $0x1aee
     898:	6a 01                	push   $0x1
     89a:	e8 d1 09 00 00       	call   1270 <printf>
      printf(1, "\n");
     89f:	59                   	pop    %ecx
     8a0:	58                   	pop    %eax
     8a1:	68 44 1a 00 00       	push   $0x1a44
     8a6:	6a 01                	push   $0x1
     8a8:	e8 c3 09 00 00       	call   1270 <printf>
     8ad:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
     8b0:	83 fe 10             	cmp    $0x10,%esi
     8b3:	75 93                	jne    848 <test_remap+0x448>
  map0 = wremap(map0, 4096 * 3, 4096 * 4, MREMAP_MAYMOVE);
     8b5:	6a 01                	push   $0x1
     8b7:	68 00 40 00 00       	push   $0x4000
     8bc:	68 00 30 00 00       	push   $0x3000
     8c1:	57                   	push   %edi
     8c2:	e8 dc 08 00 00       	call   11a3 <wremap>
  printf(1, "map0 = %x\n",map0);
     8c7:	83 c4 0c             	add    $0xc,%esp
     8ca:	50                   	push   %eax
  map0 = wremap(map0, 4096 * 3, 4096 * 4, MREMAP_MAYMOVE);
     8cb:	89 c6                	mov    %eax,%esi
  printf(1, "map0 = %x\n",map0);
     8cd:	68 46 1b 00 00       	push   $0x1b46
     8d2:	6a 01                	push   $0x1
     8d4:	e8 97 09 00 00       	call   1270 <printf>
  printf(1, "Should be valid for moving\n\n");
     8d9:	5f                   	pop    %edi
     8da:	58                   	pop    %eax
     8db:	68 51 1b 00 00       	push   $0x1b51
     8e0:	6a 01                	push   $0x1
     8e2:	e8 89 09 00 00       	call   1270 <printf>
  printf(1, "mapinfo 7 after attempted remaps:\n");
     8e7:	58                   	pop    %eax
     8e8:	5a                   	pop    %edx
     8e9:	68 74 18 00 00       	push   $0x1874
     8ee:	6a 01                	push   $0x1
     8f0:	e8 7b 09 00 00       	call   1270 <printf>
  if(getwmapinfo(&wminfo) < 0){
     8f5:	89 1c 24             	mov    %ebx,(%esp)
     8f8:	e8 b6 08 00 00       	call   11b3 <getwmapinfo>
     8fd:	83 c4 10             	add    $0x10,%esp
     900:	85 c0                	test   %eax,%eax
     902:	0f 88 88 02 00 00    	js     b90 <test_remap+0x790>
  for(int i = 0; i < 16; ++i){
     908:	31 ff                	xor    %edi,%edi
     90a:	eb 0c                	jmp    918 <test_remap+0x518>
     90c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     910:	83 c7 01             	add    $0x1,%edi
     913:	83 ff 10             	cmp    $0x10,%edi
     916:	74 6d                	je     985 <test_remap+0x585>
    if(wminfo.addr[i]!=0){
     918:	8b 4c bb 04          	mov    0x4(%ebx,%edi,4),%ecx
     91c:	85 c9                	test   %ecx,%ecx
     91e:	74 f0                	je     910 <test_remap+0x510>
      printf(1, "\t-i=%d\n", i);
     920:	83 ec 04             	sub    $0x4,%esp
     923:	57                   	push   %edi
     924:	68 bd 1a 00 00       	push   $0x1abd
     929:	6a 01                	push   $0x1
     92b:	e8 40 09 00 00       	call   1270 <printf>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
     930:	83 c4 0c             	add    $0xc,%esp
     933:	ff b4 bb 84 00 00 00 	push   0x84(%ebx,%edi,4)
     93a:	68 c5 1a 00 00       	push   $0x1ac5
     93f:	6a 01                	push   $0x1
     941:	e8 2a 09 00 00       	call   1270 <printf>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
     946:	83 c4 0c             	add    $0xc,%esp
     949:	ff 74 bb 04          	push   0x4(%ebx,%edi,4)
     94d:	68 d9 1a 00 00       	push   $0x1ad9
     952:	6a 01                	push   $0x1
     954:	e8 17 09 00 00       	call   1270 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     959:	83 c4 0c             	add    $0xc,%esp
     95c:	ff 74 bb 44          	push   0x44(%ebx,%edi,4)
  for(int i = 0; i < 16; ++i){
     960:	83 c7 01             	add    $0x1,%edi
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     963:	68 ee 1a 00 00       	push   $0x1aee
     968:	6a 01                	push   $0x1
     96a:	e8 01 09 00 00       	call   1270 <printf>
      printf(1, "\n");
     96f:	58                   	pop    %eax
     970:	5a                   	pop    %edx
     971:	68 44 1a 00 00       	push   $0x1a44
     976:	6a 01                	push   $0x1
     978:	e8 f3 08 00 00       	call   1270 <printf>
     97d:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
     980:	83 ff 10             	cmp    $0x10,%edi
     983:	75 93                	jne    918 <test_remap+0x518>
  map0 = wremap(map0, 4096 * 4, 4096 * 3, 0);
     985:	6a 00                	push   $0x0
     987:	68 00 30 00 00       	push   $0x3000
     98c:	68 00 40 00 00       	push   $0x4000
     991:	56                   	push   %esi
     992:	e8 0c 08 00 00       	call   11a3 <wremap>
  printf(1, "map0 = %x\n",map0);
     997:	83 c4 0c             	add    $0xc,%esp
     99a:	50                   	push   %eax
  map0 = wremap(map0, 4096 * 4, 4096 * 3, 0);
     99b:	89 c6                	mov    %eax,%esi
  printf(1, "map0 = %x\n",map0);
     99d:	68 46 1b 00 00       	push   $0x1b46
     9a2:	6a 01                	push   $0x1
     9a4:	e8 c7 08 00 00       	call   1270 <printf>
  printf(1, "\t-just remapped removing memory\n");
     9a9:	58                   	pop    %eax
     9aa:	5a                   	pop    %edx
     9ab:	68 98 18 00 00       	push   $0x1898
     9b0:	6a 01                	push   $0x1
     9b2:	e8 b9 08 00 00       	call   1270 <printf>
  printf(1, "mapinfo 8 after attempted shrinking remap:\n");
     9b7:	59                   	pop    %ecx
     9b8:	5f                   	pop    %edi
     9b9:	68 bc 18 00 00       	push   $0x18bc
     9be:	6a 01                	push   $0x1
     9c0:	e8 ab 08 00 00       	call   1270 <printf>
  if(getwmapinfo(&wminfo) < 0){
     9c5:	89 1c 24             	mov    %ebx,(%esp)
     9c8:	e8 e6 07 00 00       	call   11b3 <getwmapinfo>
     9cd:	83 c4 10             	add    $0x10,%esp
     9d0:	85 c0                	test   %eax,%eax
     9d2:	0f 88 b8 01 00 00    	js     b90 <test_remap+0x790>
  for(int i = 0; i < 16; ++i){
     9d8:	31 ff                	xor    %edi,%edi
     9da:	eb 0c                	jmp    9e8 <test_remap+0x5e8>
     9dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     9e0:	83 c7 01             	add    $0x1,%edi
     9e3:	83 ff 10             	cmp    $0x10,%edi
     9e6:	74 6d                	je     a55 <test_remap+0x655>
    if(wminfo.addr[i]!=0){
     9e8:	8b 44 bb 04          	mov    0x4(%ebx,%edi,4),%eax
     9ec:	85 c0                	test   %eax,%eax
     9ee:	74 f0                	je     9e0 <test_remap+0x5e0>
      printf(1, "\t-i=%d\n", i);
     9f0:	83 ec 04             	sub    $0x4,%esp
     9f3:	57                   	push   %edi
     9f4:	68 bd 1a 00 00       	push   $0x1abd
     9f9:	6a 01                	push   $0x1
     9fb:	e8 70 08 00 00       	call   1270 <printf>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
     a00:	83 c4 0c             	add    $0xc,%esp
     a03:	ff b4 bb 84 00 00 00 	push   0x84(%ebx,%edi,4)
     a0a:	68 c5 1a 00 00       	push   $0x1ac5
     a0f:	6a 01                	push   $0x1
     a11:	e8 5a 08 00 00       	call   1270 <printf>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
     a16:	83 c4 0c             	add    $0xc,%esp
     a19:	ff 74 bb 04          	push   0x4(%ebx,%edi,4)
     a1d:	68 d9 1a 00 00       	push   $0x1ad9
     a22:	6a 01                	push   $0x1
     a24:	e8 47 08 00 00       	call   1270 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     a29:	83 c4 0c             	add    $0xc,%esp
     a2c:	ff 74 bb 44          	push   0x44(%ebx,%edi,4)
  for(int i = 0; i < 16; ++i){
     a30:	83 c7 01             	add    $0x1,%edi
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     a33:	68 ee 1a 00 00       	push   $0x1aee
     a38:	6a 01                	push   $0x1
     a3a:	e8 31 08 00 00       	call   1270 <printf>
      printf(1, "\n");
     a3f:	59                   	pop    %ecx
     a40:	58                   	pop    %eax
     a41:	68 44 1a 00 00       	push   $0x1a44
     a46:	6a 01                	push   $0x1
     a48:	e8 23 08 00 00       	call   1270 <printf>
     a4d:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 16; ++i){
     a50:	83 ff 10             	cmp    $0x10,%edi
     a53:	75 93                	jne    9e8 <test_remap+0x5e8>
  printf(1, "\t-unmapping 0: %x\n", map0);
     a55:	83 ec 04             	sub    $0x4,%esp
     a58:	56                   	push   %esi
     a59:	68 6e 1b 00 00       	push   $0x1b6e
     a5e:	6a 01                	push   $0x1
     a60:	e8 0b 08 00 00       	call   1270 <printf>
  wunmap(map0);
     a65:	89 34 24             	mov    %esi,(%esp)
     a68:	e8 2e 07 00 00       	call   119b <wunmap>
  printf(1, "\t-unmapped 0\n");
     a6d:	5e                   	pop    %esi
     a6e:	5f                   	pop    %edi
     a6f:	68 81 1b 00 00       	push   $0x1b81
     a74:	6a 01                	push   $0x1
     a76:	e8 f5 07 00 00       	call   1270 <printf>
  printf(1, "\t-unmapping 1: %x\n", map1);
     a7b:	8b bd 10 ff ff ff    	mov    -0xf0(%ebp),%edi
     a81:	83 c4 0c             	add    $0xc,%esp
     a84:	57                   	push   %edi
     a85:	68 8f 1b 00 00       	push   $0x1b8f
     a8a:	6a 01                	push   $0x1
     a8c:	e8 df 07 00 00       	call   1270 <printf>
  wunmap(map1);
     a91:	89 3c 24             	mov    %edi,(%esp)
     a94:	e8 02 07 00 00       	call   119b <wunmap>
  printf(1, "\t-unmapped 1\n");
     a99:	58                   	pop    %eax
     a9a:	5a                   	pop    %edx
     a9b:	68 a2 1b 00 00       	push   $0x1ba2
     aa0:	6a 01                	push   $0x1
     aa2:	e8 c9 07 00 00       	call   1270 <printf>
  printf(1, "\t-unmapping 2: %x\n", map2);
     aa7:	8b bd 14 ff ff ff    	mov    -0xec(%ebp),%edi
     aad:	83 c4 0c             	add    $0xc,%esp
     ab0:	57                   	push   %edi
     ab1:	68 b0 1b 00 00       	push   $0x1bb0
     ab6:	6a 01                	push   $0x1
     ab8:	e8 b3 07 00 00       	call   1270 <printf>
  wunmap(map2);
     abd:	89 3c 24             	mov    %edi,(%esp)
     ac0:	e8 d6 06 00 00       	call   119b <wunmap>
  printf(1, "\t-unmapped 2\n");
     ac5:	59                   	pop    %ecx
     ac6:	5e                   	pop    %esi
     ac7:	68 c3 1b 00 00       	push   $0x1bc3
     acc:	6a 01                	push   $0x1
     ace:	e8 9d 07 00 00       	call   1270 <printf>
  printf(1, "\t-unmapping 3: %x\n", map3);
     ad3:	8b bd 0c ff ff ff    	mov    -0xf4(%ebp),%edi
     ad9:	83 c4 0c             	add    $0xc,%esp
     adc:	57                   	push   %edi
     add:	68 d1 1b 00 00       	push   $0x1bd1
     ae2:	6a 01                	push   $0x1
     ae4:	e8 87 07 00 00       	call   1270 <printf>
  wunmap(map3);
     ae9:	89 3c 24             	mov    %edi,(%esp)
     aec:	e8 aa 06 00 00       	call   119b <wunmap>
  printf(1, "\t-unmapped 3\n");
     af1:	5f                   	pop    %edi
     af2:	58                   	pop    %eax
     af3:	68 e4 1b 00 00       	push   $0x1be4
     af8:	6a 01                	push   $0x1
     afa:	e8 71 07 00 00       	call   1270 <printf>
  printf(1, "\t-testing if it is actually working\n");
     aff:	58                   	pop    %eax
     b00:	5a                   	pop    %edx
     b01:	68 e8 18 00 00       	push   $0x18e8
     b06:	6a 01                	push   $0x1
     b08:	e8 63 07 00 00       	call   1270 <printf>
  if(getwmapinfo(&wminfo) < 0){
     b0d:	89 1c 24             	mov    %ebx,(%esp)
     b10:	e8 9e 06 00 00       	call   11b3 <getwmapinfo>
     b15:	83 c4 10             	add    $0x10,%esp
     b18:	85 c0                	test   %eax,%eax
     b1a:	78 74                	js     b90 <test_remap+0x790>
  for(int i = 0; i < 16; ++i){
     b1c:	31 f6                	xor    %esi,%esi
     b1e:	eb 08                	jmp    b28 <test_remap+0x728>
     b20:	83 c6 01             	add    $0x1,%esi
     b23:	83 fe 10             	cmp    $0x10,%esi
     b26:	74 7a                	je     ba2 <test_remap+0x7a2>
    if(wminfo.addr[i]!=0){
     b28:	8b 4c b3 04          	mov    0x4(%ebx,%esi,4),%ecx
     b2c:	85 c9                	test   %ecx,%ecx
     b2e:	74 f0                	je     b20 <test_remap+0x720>
      printf(1, "\t-i=%d\n", i);
     b30:	83 ec 04             	sub    $0x4,%esp
     b33:	56                   	push   %esi
     b34:	68 bd 1a 00 00       	push   $0x1abd
     b39:	6a 01                	push   $0x1
     b3b:	e8 30 07 00 00       	call   1270 <printf>
      printf(1, "\t-loaded pages: %d\n", wminfo.n_loaded_pages[i]);
     b40:	83 c4 0c             	add    $0xc,%esp
     b43:	ff b4 b3 84 00 00 00 	push   0x84(%ebx,%esi,4)
     b4a:	68 c5 1a 00 00       	push   $0x1ac5
     b4f:	6a 01                	push   $0x1
     b51:	e8 1a 07 00 00       	call   1270 <printf>
      printf(1, "\t-Starting addr: %x\n", wminfo.addr[i]);
     b56:	83 c4 0c             	add    $0xc,%esp
     b59:	ff 74 b3 04          	push   0x4(%ebx,%esi,4)
     b5d:	68 d9 1a 00 00       	push   $0x1ad9
     b62:	6a 01                	push   $0x1
     b64:	e8 07 07 00 00       	call   1270 <printf>
      printf(1, "\t-map length: %x\n", wminfo.length[i]);
     b69:	83 c4 0c             	add    $0xc,%esp
     b6c:	ff 74 b3 44          	push   0x44(%ebx,%esi,4)
     b70:	68 ee 1a 00 00       	push   $0x1aee
     b75:	6a 01                	push   $0x1
     b77:	e8 f4 06 00 00       	call   1270 <printf>
      printf(1, "\n");
     b7c:	58                   	pop    %eax
     b7d:	5a                   	pop    %edx
     b7e:	68 44 1a 00 00       	push   $0x1a44
     b83:	6a 01                	push   $0x1
     b85:	e8 e6 06 00 00       	call   1270 <printf>
     b8a:	83 c4 10             	add    $0x10,%esp
     b8d:	eb 91                	jmp    b20 <test_remap+0x720>
     b8f:	90                   	nop
    printf(1, "\nRESULT: FAILED");
     b90:	83 ec 08             	sub    $0x8,%esp
     b93:	68 ad 1a 00 00       	push   $0x1aad
     b98:	6a 01                	push   $0x1
     b9a:	e8 d1 06 00 00       	call   1270 <printf>
    return;
     b9f:	83 c4 10             	add    $0x10,%esp
}
     ba2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ba5:	5b                   	pop    %ebx
     ba6:	5e                   	pop    %esi
     ba7:	5f                   	pop    %edi
     ba8:	5d                   	pop    %ebp
     ba9:	c3                   	ret    
     baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000bb0 <test_fork>:
void test_fork(void) {
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	56                   	push   %esi
     bb4:	53                   	push   %ebx
     bb5:	81 ec 18 01 00 00    	sub    $0x118,%esp
  printf(1, "Testing fork:\n");
     bbb:	68 f2 1b 00 00       	push   $0x1bf2
     bc0:	6a 01                	push   $0x1
     bc2:	e8 a9 06 00 00       	call   1270 <printf>
  printf(1, "\t-0x60000000 is shared\n");
     bc7:	58                   	pop    %eax
     bc8:	5a                   	pop    %edx
     bc9:	68 01 1c 00 00       	push   $0x1c01
     bce:	6a 01                	push   $0x1
     bd0:	e8 9b 06 00 00       	call   1270 <printf>
  uint map0 = wmap(0x60000000, 4096, MAP_FIXED | MAP_SHARED, -1);
     bd5:	6a ff                	push   $0xffffffff
     bd7:	6a 0a                	push   $0xa
     bd9:	68 00 10 00 00       	push   $0x1000
     bde:	68 00 00 00 60       	push   $0x60000000
     be3:	e8 ab 05 00 00       	call   1193 <wmap>
  uint map1 = wmap(0x60001000, 4096, MAP_FIXED | MAP_PRIVATE, -1);
     be8:	83 c4 20             	add    $0x20,%esp
  *(int*)map0 = 1;
     beb:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  uint map0 = wmap(0x60000000, 4096, MAP_FIXED | MAP_SHARED, -1);
     bf1:	89 c6                	mov    %eax,%esi
  uint map1 = wmap(0x60001000, 4096, MAP_FIXED | MAP_PRIVATE, -1);
     bf3:	6a ff                	push   $0xffffffff
     bf5:	6a 09                	push   $0x9
     bf7:	68 00 10 00 00       	push   $0x1000
     bfc:	68 00 10 00 60       	push   $0x60001000
     c01:	e8 8d 05 00 00       	call   1193 <wmap>
  printf(1, "\t-0x60001000 is private\n");
     c06:	59                   	pop    %ecx
  uint map1 = wmap(0x60001000, 4096, MAP_FIXED | MAP_PRIVATE, -1);
     c07:	89 c3                	mov    %eax,%ebx
  printf(1, "\t-0x60001000 is private\n");
     c09:	58                   	pop    %eax
     c0a:	68 19 1c 00 00       	push   $0x1c19
     c0f:	6a 01                	push   $0x1
     c11:	e8 5a 06 00 00       	call   1270 <printf>
  *(int*)map1 = 2;
     c16:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  pid = fork();
     c1c:	e8 ca 04 00 00       	call   10eb <fork>
  if (pid == 0) { //child
     c21:	83 c4 10             	add    $0x10,%esp
     c24:	85 c0                	test   %eax,%eax
     c26:	75 48                	jne    c70 <test_fork+0xc0>
    getpgdirinfo(&pd);
     c28:	83 ec 0c             	sub    $0xc,%esp
     c2b:	8d 85 f4 fe ff ff    	lea    -0x10c(%ebp),%eax
     c31:	50                   	push   %eax
     c32:	e8 74 05 00 00       	call   11ab <getpgdirinfo>
    *(int*)map1 = 3;
     c37:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
    *(int*)map0 = 4;
     c3d:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
    printf(1, "CHILD:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     c43:	ff 33                	push   (%ebx)
     c45:	6a 04                	push   $0x4
     c47:	68 32 1c 00 00       	push   $0x1c32
     c4c:	6a 01                	push   $0x1
     c4e:	e8 1d 06 00 00       	call   1270 <printf>
    printf(1, "finished\n");
     c53:	83 c4 18             	add    $0x18,%esp
     c56:	68 7f 1c 00 00       	push   $0x1c7f
     c5b:	6a 01                	push   $0x1
     c5d:	e8 0e 06 00 00       	call   1270 <printf>
     c62:	83 c4 10             	add    $0x10,%esp
}
     c65:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c68:	5b                   	pop    %ebx
     c69:	5e                   	pop    %esi
     c6a:	5d                   	pop    %ebp
     c6b:	c3                   	ret    
     c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    getpgdirinfo(&pd);
     c70:	83 ec 0c             	sub    $0xc,%esp
     c73:	8d 85 f4 fe ff ff    	lea    -0x10c(%ebp),%eax
     c79:	50                   	push   %eax
     c7a:	e8 2c 05 00 00       	call   11ab <getpgdirinfo>
    *(int*)map1 = 5;
     c7f:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
    *(int*)map0 = 6;
     c85:	c7 06 06 00 00 00    	movl   $0x6,(%esi)
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     c8b:	ff 33                	push   (%ebx)
     c8d:	6a 06                	push   $0x6
     c8f:	68 4c 1c 00 00       	push   $0x1c4c
     c94:	6a 01                	push   $0x1
     c96:	e8 d5 05 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     c9b:	83 c4 20             	add    $0x20,%esp
     c9e:	ff 33                	push   (%ebx)
     ca0:	ff 36                	push   (%esi)
     ca2:	68 4c 1c 00 00       	push   $0x1c4c
     ca7:	6a 01                	push   $0x1
     ca9:	e8 c2 05 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     cae:	ff 33                	push   (%ebx)
     cb0:	ff 36                	push   (%esi)
     cb2:	68 4c 1c 00 00       	push   $0x1c4c
     cb7:	6a 01                	push   $0x1
     cb9:	e8 b2 05 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     cbe:	83 c4 20             	add    $0x20,%esp
     cc1:	ff 33                	push   (%ebx)
     cc3:	ff 36                	push   (%esi)
     cc5:	68 4c 1c 00 00       	push   $0x1c4c
     cca:	6a 01                	push   $0x1
     ccc:	e8 9f 05 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     cd1:	ff 33                	push   (%ebx)
     cd3:	ff 36                	push   (%esi)
     cd5:	68 4c 1c 00 00       	push   $0x1c4c
     cda:	6a 01                	push   $0x1
     cdc:	e8 8f 05 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     ce1:	83 c4 20             	add    $0x20,%esp
     ce4:	ff 33                	push   (%ebx)
     ce6:	ff 36                	push   (%esi)
     ce8:	68 4c 1c 00 00       	push   $0x1c4c
     ced:	6a 01                	push   $0x1
     cef:	e8 7c 05 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     cf4:	ff 33                	push   (%ebx)
     cf6:	ff 36                	push   (%esi)
     cf8:	68 4c 1c 00 00       	push   $0x1c4c
     cfd:	6a 01                	push   $0x1
     cff:	e8 6c 05 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     d04:	83 c4 20             	add    $0x20,%esp
     d07:	ff 33                	push   (%ebx)
     d09:	ff 36                	push   (%esi)
     d0b:	68 4c 1c 00 00       	push   $0x1c4c
     d10:	6a 01                	push   $0x1
     d12:	e8 59 05 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     d17:	ff 33                	push   (%ebx)
     d19:	ff 36                	push   (%esi)
     d1b:	68 4c 1c 00 00       	push   $0x1c4c
     d20:	6a 01                	push   $0x1
     d22:	e8 49 05 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     d27:	83 c4 20             	add    $0x20,%esp
     d2a:	ff 33                	push   (%ebx)
     d2c:	ff 36                	push   (%esi)
     d2e:	68 4c 1c 00 00       	push   $0x1c4c
     d33:	6a 01                	push   $0x1
     d35:	e8 36 05 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     d3a:	ff 33                	push   (%ebx)
     d3c:	ff 36                	push   (%esi)
     d3e:	68 4c 1c 00 00       	push   $0x1c4c
     d43:	6a 01                	push   $0x1
     d45:	e8 26 05 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     d4a:	83 c4 20             	add    $0x20,%esp
     d4d:	ff 33                	push   (%ebx)
     d4f:	ff 36                	push   (%esi)
     d51:	68 4c 1c 00 00       	push   $0x1c4c
     d56:	6a 01                	push   $0x1
     d58:	e8 13 05 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     d5d:	ff 33                	push   (%ebx)
     d5f:	ff 36                	push   (%esi)
     d61:	68 4c 1c 00 00       	push   $0x1c4c
     d66:	6a 01                	push   $0x1
     d68:	e8 03 05 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     d6d:	83 c4 20             	add    $0x20,%esp
     d70:	ff 33                	push   (%ebx)
     d72:	ff 36                	push   (%esi)
     d74:	68 4c 1c 00 00       	push   $0x1c4c
     d79:	6a 01                	push   $0x1
     d7b:	e8 f0 04 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     d80:	ff 33                	push   (%ebx)
     d82:	ff 36                	push   (%esi)
     d84:	68 4c 1c 00 00       	push   $0x1c4c
     d89:	6a 01                	push   $0x1
     d8b:	e8 e0 04 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     d90:	83 c4 20             	add    $0x20,%esp
     d93:	ff 33                	push   (%ebx)
     d95:	ff 36                	push   (%esi)
     d97:	68 4c 1c 00 00       	push   $0x1c4c
     d9c:	6a 01                	push   $0x1
     d9e:	e8 cd 04 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     da3:	ff 33                	push   (%ebx)
     da5:	ff 36                	push   (%esi)
     da7:	68 4c 1c 00 00       	push   $0x1c4c
     dac:	6a 01                	push   $0x1
     dae:	e8 bd 04 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     db3:	83 c4 20             	add    $0x20,%esp
     db6:	ff 33                	push   (%ebx)
     db8:	ff 36                	push   (%esi)
     dba:	68 4c 1c 00 00       	push   $0x1c4c
     dbf:	6a 01                	push   $0x1
     dc1:	e8 aa 04 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     dc6:	ff 33                	push   (%ebx)
     dc8:	ff 36                	push   (%esi)
     dca:	68 4c 1c 00 00       	push   $0x1c4c
     dcf:	6a 01                	push   $0x1
     dd1:	e8 9a 04 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     dd6:	83 c4 20             	add    $0x20,%esp
     dd9:	ff 33                	push   (%ebx)
     ddb:	ff 36                	push   (%esi)
     ddd:	68 4c 1c 00 00       	push   $0x1c4c
     de2:	6a 01                	push   $0x1
     de4:	e8 87 04 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     de9:	ff 33                	push   (%ebx)
     deb:	ff 36                	push   (%esi)
     ded:	68 4c 1c 00 00       	push   $0x1c4c
     df2:	6a 01                	push   $0x1
     df4:	e8 77 04 00 00       	call   1270 <printf>
    printf(1, "PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     df9:	83 c4 20             	add    $0x20,%esp
     dfc:	ff 33                	push   (%ebx)
     dfe:	ff 36                	push   (%esi)
     e00:	68 4c 1c 00 00       	push   $0x1c4c
     e05:	6a 01                	push   $0x1
     e07:	e8 64 04 00 00       	call   1270 <printf>
    wait();
     e0c:	e8 ea 02 00 00       	call   10fb <wait>
    printf(1, "LAST __ PARENT:: map0 %d, map1 %d\n", *(int*)map0, *(int*)map1);
     e11:	ff 33                	push   (%ebx)
     e13:	ff 36                	push   (%esi)
     e15:	68 10 19 00 00       	push   $0x1910
     e1a:	6a 01                	push   $0x1
     e1c:	e8 4f 04 00 00       	call   1270 <printf>
     e21:	83 c4 20             	add    $0x20,%esp
}
     e24:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e27:	5b                   	pop    %ebx
     e28:	5e                   	pop    %esi
     e29:	5d                   	pop    %ebp
     e2a:	c3                   	ret    
     e2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e2f:	90                   	nop

00000e30 <test_pg>:
void test_pg() {
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	81 ec 20 01 00 00    	sub    $0x120,%esp
  printf(1, "\t-0x60000000 is shared\n");
     e39:	68 01 1c 00 00       	push   $0x1c01
     e3e:	6a 01                	push   $0x1
     e40:	e8 2b 04 00 00       	call   1270 <printf>
  uint map0 = wmap(0x60000000, 4096, MAP_FIXED | MAP_SHARED, -1);
     e45:	6a ff                	push   $0xffffffff
     e47:	6a 0a                	push   $0xa
     e49:	68 00 10 00 00       	push   $0x1000
     e4e:	68 00 00 00 60       	push   $0x60000000
     e53:	e8 3b 03 00 00       	call   1193 <wmap>
  uint map1 = wmap(0x60001000, 4096, MAP_FIXED | MAP_PRIVATE, -1);
     e58:	83 c4 20             	add    $0x20,%esp
  *(char*)map0 = 'a';
     e5b:	c6 00 61             	movb   $0x61,(%eax)
  uint map1 = wmap(0x60001000, 4096, MAP_FIXED | MAP_PRIVATE, -1);
     e5e:	6a ff                	push   $0xffffffff
     e60:	6a 09                	push   $0x9
     e62:	68 00 10 00 00       	push   $0x1000
     e67:	68 00 10 00 60       	push   $0x60001000
     e6c:	e8 22 03 00 00       	call   1193 <wmap>
  printf(1, "\t-0x60001000 is private\n");
     e71:	58                   	pop    %eax
     e72:	5a                   	pop    %edx
     e73:	68 19 1c 00 00       	push   $0x1c19
     e78:	6a 01                	push   $0x1
     e7a:	e8 f1 03 00 00       	call   1270 <printf>
    getpgdirinfo(&pd);
     e7f:	8d 85 f4 fe ff ff    	lea    -0x10c(%ebp),%eax
     e85:	89 04 24             	mov    %eax,(%esp)
     e88:	e8 1e 03 00 00       	call   11ab <getpgdirinfo>
    exit();
     e8d:	e8 61 02 00 00       	call   10f3 <exit>
     e92:	66 90                	xchg   %ax,%ax
     e94:	66 90                	xchg   %ax,%ax
     e96:	66 90                	xchg   %ax,%ax
     e98:	66 90                	xchg   %ax,%ax
     e9a:	66 90                	xchg   %ax,%ax
     e9c:	66 90                	xchg   %ax,%ax
     e9e:	66 90                	xchg   %ax,%ax

00000ea0 <strcpy>:
     ea0:	55                   	push   %ebp
     ea1:	31 c0                	xor    %eax,%eax
     ea3:	89 e5                	mov    %esp,%ebp
     ea5:	53                   	push   %ebx
     ea6:	8b 4d 08             	mov    0x8(%ebp),%ecx
     ea9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     eb0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     eb4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     eb7:	83 c0 01             	add    $0x1,%eax
     eba:	84 d2                	test   %dl,%dl
     ebc:	75 f2                	jne    eb0 <strcpy+0x10>
     ebe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ec1:	89 c8                	mov    %ecx,%eax
     ec3:	c9                   	leave  
     ec4:	c3                   	ret    
     ec5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ed0 <strcmp>:
     ed0:	55                   	push   %ebp
     ed1:	89 e5                	mov    %esp,%ebp
     ed3:	53                   	push   %ebx
     ed4:	8b 55 08             	mov    0x8(%ebp),%edx
     ed7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     eda:	0f b6 02             	movzbl (%edx),%eax
     edd:	84 c0                	test   %al,%al
     edf:	75 17                	jne    ef8 <strcmp+0x28>
     ee1:	eb 3a                	jmp    f1d <strcmp+0x4d>
     ee3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ee7:	90                   	nop
     ee8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
     eec:	83 c2 01             	add    $0x1,%edx
     eef:	8d 59 01             	lea    0x1(%ecx),%ebx
     ef2:	84 c0                	test   %al,%al
     ef4:	74 1a                	je     f10 <strcmp+0x40>
     ef6:	89 d9                	mov    %ebx,%ecx
     ef8:	0f b6 19             	movzbl (%ecx),%ebx
     efb:	38 c3                	cmp    %al,%bl
     efd:	74 e9                	je     ee8 <strcmp+0x18>
     eff:	29 d8                	sub    %ebx,%eax
     f01:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     f04:	c9                   	leave  
     f05:	c3                   	ret    
     f06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f0d:	8d 76 00             	lea    0x0(%esi),%esi
     f10:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     f14:	31 c0                	xor    %eax,%eax
     f16:	29 d8                	sub    %ebx,%eax
     f18:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     f1b:	c9                   	leave  
     f1c:	c3                   	ret    
     f1d:	0f b6 19             	movzbl (%ecx),%ebx
     f20:	31 c0                	xor    %eax,%eax
     f22:	eb db                	jmp    eff <strcmp+0x2f>
     f24:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f2f:	90                   	nop

00000f30 <strlen>:
     f30:	55                   	push   %ebp
     f31:	89 e5                	mov    %esp,%ebp
     f33:	8b 55 08             	mov    0x8(%ebp),%edx
     f36:	80 3a 00             	cmpb   $0x0,(%edx)
     f39:	74 15                	je     f50 <strlen+0x20>
     f3b:	31 c0                	xor    %eax,%eax
     f3d:	8d 76 00             	lea    0x0(%esi),%esi
     f40:	83 c0 01             	add    $0x1,%eax
     f43:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     f47:	89 c1                	mov    %eax,%ecx
     f49:	75 f5                	jne    f40 <strlen+0x10>
     f4b:	89 c8                	mov    %ecx,%eax
     f4d:	5d                   	pop    %ebp
     f4e:	c3                   	ret    
     f4f:	90                   	nop
     f50:	31 c9                	xor    %ecx,%ecx
     f52:	5d                   	pop    %ebp
     f53:	89 c8                	mov    %ecx,%eax
     f55:	c3                   	ret    
     f56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f5d:	8d 76 00             	lea    0x0(%esi),%esi

00000f60 <memset>:
     f60:	55                   	push   %ebp
     f61:	89 e5                	mov    %esp,%ebp
     f63:	57                   	push   %edi
     f64:	8b 55 08             	mov    0x8(%ebp),%edx
     f67:	8b 4d 10             	mov    0x10(%ebp),%ecx
     f6a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f6d:	89 d7                	mov    %edx,%edi
     f6f:	fc                   	cld    
     f70:	f3 aa                	rep stos %al,%es:(%edi)
     f72:	8b 7d fc             	mov    -0x4(%ebp),%edi
     f75:	89 d0                	mov    %edx,%eax
     f77:	c9                   	leave  
     f78:	c3                   	ret    
     f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000f80 <strchr>:
     f80:	55                   	push   %ebp
     f81:	89 e5                	mov    %esp,%ebp
     f83:	8b 45 08             	mov    0x8(%ebp),%eax
     f86:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
     f8a:	0f b6 10             	movzbl (%eax),%edx
     f8d:	84 d2                	test   %dl,%dl
     f8f:	75 12                	jne    fa3 <strchr+0x23>
     f91:	eb 1d                	jmp    fb0 <strchr+0x30>
     f93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f97:	90                   	nop
     f98:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     f9c:	83 c0 01             	add    $0x1,%eax
     f9f:	84 d2                	test   %dl,%dl
     fa1:	74 0d                	je     fb0 <strchr+0x30>
     fa3:	38 d1                	cmp    %dl,%cl
     fa5:	75 f1                	jne    f98 <strchr+0x18>
     fa7:	5d                   	pop    %ebp
     fa8:	c3                   	ret    
     fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fb0:	31 c0                	xor    %eax,%eax
     fb2:	5d                   	pop    %ebp
     fb3:	c3                   	ret    
     fb4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     fbf:	90                   	nop

00000fc0 <gets>:
     fc0:	55                   	push   %ebp
     fc1:	89 e5                	mov    %esp,%ebp
     fc3:	57                   	push   %edi
     fc4:	56                   	push   %esi
     fc5:	8d 7d e7             	lea    -0x19(%ebp),%edi
     fc8:	53                   	push   %ebx
     fc9:	31 db                	xor    %ebx,%ebx
     fcb:	83 ec 1c             	sub    $0x1c,%esp
     fce:	eb 27                	jmp    ff7 <gets+0x37>
     fd0:	83 ec 04             	sub    $0x4,%esp
     fd3:	6a 01                	push   $0x1
     fd5:	57                   	push   %edi
     fd6:	6a 00                	push   $0x0
     fd8:	e8 2e 01 00 00       	call   110b <read>
     fdd:	83 c4 10             	add    $0x10,%esp
     fe0:	85 c0                	test   %eax,%eax
     fe2:	7e 1d                	jle    1001 <gets+0x41>
     fe4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     fe8:	8b 55 08             	mov    0x8(%ebp),%edx
     feb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
     fef:	3c 0a                	cmp    $0xa,%al
     ff1:	74 1d                	je     1010 <gets+0x50>
     ff3:	3c 0d                	cmp    $0xd,%al
     ff5:	74 19                	je     1010 <gets+0x50>
     ff7:	89 de                	mov    %ebx,%esi
     ff9:	83 c3 01             	add    $0x1,%ebx
     ffc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     fff:	7c cf                	jl     fd0 <gets+0x10>
    1001:	8b 45 08             	mov    0x8(%ebp),%eax
    1004:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
    1008:	8d 65 f4             	lea    -0xc(%ebp),%esp
    100b:	5b                   	pop    %ebx
    100c:	5e                   	pop    %esi
    100d:	5f                   	pop    %edi
    100e:	5d                   	pop    %ebp
    100f:	c3                   	ret    
    1010:	8b 45 08             	mov    0x8(%ebp),%eax
    1013:	89 de                	mov    %ebx,%esi
    1015:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
    1019:	8d 65 f4             	lea    -0xc(%ebp),%esp
    101c:	5b                   	pop    %ebx
    101d:	5e                   	pop    %esi
    101e:	5f                   	pop    %edi
    101f:	5d                   	pop    %ebp
    1020:	c3                   	ret    
    1021:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1028:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    102f:	90                   	nop

00001030 <stat>:
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	56                   	push   %esi
    1034:	53                   	push   %ebx
    1035:	83 ec 08             	sub    $0x8,%esp
    1038:	6a 00                	push   $0x0
    103a:	ff 75 08             	push   0x8(%ebp)
    103d:	e8 f1 00 00 00       	call   1133 <open>
    1042:	83 c4 10             	add    $0x10,%esp
    1045:	85 c0                	test   %eax,%eax
    1047:	78 27                	js     1070 <stat+0x40>
    1049:	83 ec 08             	sub    $0x8,%esp
    104c:	ff 75 0c             	push   0xc(%ebp)
    104f:	89 c3                	mov    %eax,%ebx
    1051:	50                   	push   %eax
    1052:	e8 f4 00 00 00       	call   114b <fstat>
    1057:	89 1c 24             	mov    %ebx,(%esp)
    105a:	89 c6                	mov    %eax,%esi
    105c:	e8 ba 00 00 00       	call   111b <close>
    1061:	83 c4 10             	add    $0x10,%esp
    1064:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1067:	89 f0                	mov    %esi,%eax
    1069:	5b                   	pop    %ebx
    106a:	5e                   	pop    %esi
    106b:	5d                   	pop    %ebp
    106c:	c3                   	ret    
    106d:	8d 76 00             	lea    0x0(%esi),%esi
    1070:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1075:	eb ed                	jmp    1064 <stat+0x34>
    1077:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    107e:	66 90                	xchg   %ax,%ax

00001080 <atoi>:
    1080:	55                   	push   %ebp
    1081:	89 e5                	mov    %esp,%ebp
    1083:	53                   	push   %ebx
    1084:	8b 55 08             	mov    0x8(%ebp),%edx
    1087:	0f be 02             	movsbl (%edx),%eax
    108a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    108d:	80 f9 09             	cmp    $0x9,%cl
    1090:	b9 00 00 00 00       	mov    $0x0,%ecx
    1095:	77 1e                	ja     10b5 <atoi+0x35>
    1097:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    109e:	66 90                	xchg   %ax,%ax
    10a0:	83 c2 01             	add    $0x1,%edx
    10a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    10a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
    10aa:	0f be 02             	movsbl (%edx),%eax
    10ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
    10b0:	80 fb 09             	cmp    $0x9,%bl
    10b3:	76 eb                	jbe    10a0 <atoi+0x20>
    10b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10b8:	89 c8                	mov    %ecx,%eax
    10ba:	c9                   	leave  
    10bb:	c3                   	ret    
    10bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000010c0 <memmove>:
    10c0:	55                   	push   %ebp
    10c1:	89 e5                	mov    %esp,%ebp
    10c3:	57                   	push   %edi
    10c4:	8b 45 10             	mov    0x10(%ebp),%eax
    10c7:	8b 55 08             	mov    0x8(%ebp),%edx
    10ca:	56                   	push   %esi
    10cb:	8b 75 0c             	mov    0xc(%ebp),%esi
    10ce:	85 c0                	test   %eax,%eax
    10d0:	7e 13                	jle    10e5 <memmove+0x25>
    10d2:	01 d0                	add    %edx,%eax
    10d4:	89 d7                	mov    %edx,%edi
    10d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10dd:	8d 76 00             	lea    0x0(%esi),%esi
    10e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    10e1:	39 f8                	cmp    %edi,%eax
    10e3:	75 fb                	jne    10e0 <memmove+0x20>
    10e5:	5e                   	pop    %esi
    10e6:	89 d0                	mov    %edx,%eax
    10e8:	5f                   	pop    %edi
    10e9:	5d                   	pop    %ebp
    10ea:	c3                   	ret    

000010eb <fork>:
    10eb:	b8 01 00 00 00       	mov    $0x1,%eax
    10f0:	cd 40                	int    $0x40
    10f2:	c3                   	ret    

000010f3 <exit>:
    10f3:	b8 02 00 00 00       	mov    $0x2,%eax
    10f8:	cd 40                	int    $0x40
    10fa:	c3                   	ret    

000010fb <wait>:
    10fb:	b8 03 00 00 00       	mov    $0x3,%eax
    1100:	cd 40                	int    $0x40
    1102:	c3                   	ret    

00001103 <pipe>:
    1103:	b8 04 00 00 00       	mov    $0x4,%eax
    1108:	cd 40                	int    $0x40
    110a:	c3                   	ret    

0000110b <read>:
    110b:	b8 05 00 00 00       	mov    $0x5,%eax
    1110:	cd 40                	int    $0x40
    1112:	c3                   	ret    

00001113 <write>:
    1113:	b8 10 00 00 00       	mov    $0x10,%eax
    1118:	cd 40                	int    $0x40
    111a:	c3                   	ret    

0000111b <close>:
    111b:	b8 15 00 00 00       	mov    $0x15,%eax
    1120:	cd 40                	int    $0x40
    1122:	c3                   	ret    

00001123 <kill>:
    1123:	b8 06 00 00 00       	mov    $0x6,%eax
    1128:	cd 40                	int    $0x40
    112a:	c3                   	ret    

0000112b <exec>:
    112b:	b8 07 00 00 00       	mov    $0x7,%eax
    1130:	cd 40                	int    $0x40
    1132:	c3                   	ret    

00001133 <open>:
    1133:	b8 0f 00 00 00       	mov    $0xf,%eax
    1138:	cd 40                	int    $0x40
    113a:	c3                   	ret    

0000113b <mknod>:
    113b:	b8 11 00 00 00       	mov    $0x11,%eax
    1140:	cd 40                	int    $0x40
    1142:	c3                   	ret    

00001143 <unlink>:
    1143:	b8 12 00 00 00       	mov    $0x12,%eax
    1148:	cd 40                	int    $0x40
    114a:	c3                   	ret    

0000114b <fstat>:
    114b:	b8 08 00 00 00       	mov    $0x8,%eax
    1150:	cd 40                	int    $0x40
    1152:	c3                   	ret    

00001153 <link>:
    1153:	b8 13 00 00 00       	mov    $0x13,%eax
    1158:	cd 40                	int    $0x40
    115a:	c3                   	ret    

0000115b <mkdir>:
    115b:	b8 14 00 00 00       	mov    $0x14,%eax
    1160:	cd 40                	int    $0x40
    1162:	c3                   	ret    

00001163 <chdir>:
    1163:	b8 09 00 00 00       	mov    $0x9,%eax
    1168:	cd 40                	int    $0x40
    116a:	c3                   	ret    

0000116b <dup>:
    116b:	b8 0a 00 00 00       	mov    $0xa,%eax
    1170:	cd 40                	int    $0x40
    1172:	c3                   	ret    

00001173 <getpid>:
    1173:	b8 0b 00 00 00       	mov    $0xb,%eax
    1178:	cd 40                	int    $0x40
    117a:	c3                   	ret    

0000117b <sbrk>:
    117b:	b8 0c 00 00 00       	mov    $0xc,%eax
    1180:	cd 40                	int    $0x40
    1182:	c3                   	ret    

00001183 <sleep>:
    1183:	b8 0d 00 00 00       	mov    $0xd,%eax
    1188:	cd 40                	int    $0x40
    118a:	c3                   	ret    

0000118b <uptime>:
    118b:	b8 0e 00 00 00       	mov    $0xe,%eax
    1190:	cd 40                	int    $0x40
    1192:	c3                   	ret    

00001193 <wmap>:
    1193:	b8 16 00 00 00       	mov    $0x16,%eax
    1198:	cd 40                	int    $0x40
    119a:	c3                   	ret    

0000119b <wunmap>:
    119b:	b8 17 00 00 00       	mov    $0x17,%eax
    11a0:	cd 40                	int    $0x40
    11a2:	c3                   	ret    

000011a3 <wremap>:
    11a3:	b8 18 00 00 00       	mov    $0x18,%eax
    11a8:	cd 40                	int    $0x40
    11aa:	c3                   	ret    

000011ab <getpgdirinfo>:
    11ab:	b8 19 00 00 00       	mov    $0x19,%eax
    11b0:	cd 40                	int    $0x40
    11b2:	c3                   	ret    

000011b3 <getwmapinfo>:
    11b3:	b8 1a 00 00 00       	mov    $0x1a,%eax
    11b8:	cd 40                	int    $0x40
    11ba:	c3                   	ret    
    11bb:	66 90                	xchg   %ax,%ax
    11bd:	66 90                	xchg   %ax,%ax
    11bf:	90                   	nop

000011c0 <printint>:
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	57                   	push   %edi
    11c4:	56                   	push   %esi
    11c5:	53                   	push   %ebx
    11c6:	83 ec 3c             	sub    $0x3c,%esp
    11c9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
    11cc:	89 d1                	mov    %edx,%ecx
    11ce:	89 45 b8             	mov    %eax,-0x48(%ebp)
    11d1:	85 d2                	test   %edx,%edx
    11d3:	0f 89 7f 00 00 00    	jns    1258 <printint+0x98>
    11d9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    11dd:	74 79                	je     1258 <printint+0x98>
    11df:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    11e6:	f7 d9                	neg    %ecx
    11e8:	31 db                	xor    %ebx,%ebx
    11ea:	8d 75 d7             	lea    -0x29(%ebp),%esi
    11ed:	8d 76 00             	lea    0x0(%esi),%esi
    11f0:	89 c8                	mov    %ecx,%eax
    11f2:	31 d2                	xor    %edx,%edx
    11f4:	89 cf                	mov    %ecx,%edi
    11f6:	f7 75 c4             	divl   -0x3c(%ebp)
    11f9:	0f b6 92 e8 1c 00 00 	movzbl 0x1ce8(%edx),%edx
    1200:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1203:	89 d8                	mov    %ebx,%eax
    1205:	8d 5b 01             	lea    0x1(%ebx),%ebx
    1208:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    120b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
    120e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    1211:	76 dd                	jbe    11f0 <printint+0x30>
    1213:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    1216:	85 c9                	test   %ecx,%ecx
    1218:	74 0c                	je     1226 <printint+0x66>
    121a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    121f:	89 d8                	mov    %ebx,%eax
    1221:	ba 2d 00 00 00       	mov    $0x2d,%edx
    1226:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1229:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    122d:	eb 07                	jmp    1236 <printint+0x76>
    122f:	90                   	nop
    1230:	0f b6 13             	movzbl (%ebx),%edx
    1233:	83 eb 01             	sub    $0x1,%ebx
    1236:	83 ec 04             	sub    $0x4,%esp
    1239:	88 55 d7             	mov    %dl,-0x29(%ebp)
    123c:	6a 01                	push   $0x1
    123e:	56                   	push   %esi
    123f:	57                   	push   %edi
    1240:	e8 ce fe ff ff       	call   1113 <write>
    1245:	83 c4 10             	add    $0x10,%esp
    1248:	39 de                	cmp    %ebx,%esi
    124a:	75 e4                	jne    1230 <printint+0x70>
    124c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    124f:	5b                   	pop    %ebx
    1250:	5e                   	pop    %esi
    1251:	5f                   	pop    %edi
    1252:	5d                   	pop    %ebp
    1253:	c3                   	ret    
    1254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1258:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    125f:	eb 87                	jmp    11e8 <printint+0x28>
    1261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1268:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    126f:	90                   	nop

00001270 <printf>:
    1270:	55                   	push   %ebp
    1271:	89 e5                	mov    %esp,%ebp
    1273:	57                   	push   %edi
    1274:	56                   	push   %esi
    1275:	53                   	push   %ebx
    1276:	83 ec 2c             	sub    $0x2c,%esp
    1279:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    127c:	8b 75 08             	mov    0x8(%ebp),%esi
    127f:	0f b6 13             	movzbl (%ebx),%edx
    1282:	84 d2                	test   %dl,%dl
    1284:	74 6a                	je     12f0 <printf+0x80>
    1286:	8d 45 10             	lea    0x10(%ebp),%eax
    1289:	83 c3 01             	add    $0x1,%ebx
    128c:	8d 7d e7             	lea    -0x19(%ebp),%edi
    128f:	31 c9                	xor    %ecx,%ecx
    1291:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1294:	eb 36                	jmp    12cc <printf+0x5c>
    1296:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    129d:	8d 76 00             	lea    0x0(%esi),%esi
    12a0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    12a3:	b9 25 00 00 00       	mov    $0x25,%ecx
    12a8:	83 f8 25             	cmp    $0x25,%eax
    12ab:	74 15                	je     12c2 <printf+0x52>
    12ad:	83 ec 04             	sub    $0x4,%esp
    12b0:	88 55 e7             	mov    %dl,-0x19(%ebp)
    12b3:	6a 01                	push   $0x1
    12b5:	57                   	push   %edi
    12b6:	56                   	push   %esi
    12b7:	e8 57 fe ff ff       	call   1113 <write>
    12bc:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    12bf:	83 c4 10             	add    $0x10,%esp
    12c2:	0f b6 13             	movzbl (%ebx),%edx
    12c5:	83 c3 01             	add    $0x1,%ebx
    12c8:	84 d2                	test   %dl,%dl
    12ca:	74 24                	je     12f0 <printf+0x80>
    12cc:	0f b6 c2             	movzbl %dl,%eax
    12cf:	85 c9                	test   %ecx,%ecx
    12d1:	74 cd                	je     12a0 <printf+0x30>
    12d3:	83 f9 25             	cmp    $0x25,%ecx
    12d6:	75 ea                	jne    12c2 <printf+0x52>
    12d8:	83 f8 25             	cmp    $0x25,%eax
    12db:	0f 84 07 01 00 00    	je     13e8 <printf+0x178>
    12e1:	83 e8 63             	sub    $0x63,%eax
    12e4:	83 f8 15             	cmp    $0x15,%eax
    12e7:	77 17                	ja     1300 <printf+0x90>
    12e9:	ff 24 85 90 1c 00 00 	jmp    *0x1c90(,%eax,4)
    12f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12f3:	5b                   	pop    %ebx
    12f4:	5e                   	pop    %esi
    12f5:	5f                   	pop    %edi
    12f6:	5d                   	pop    %ebp
    12f7:	c3                   	ret    
    12f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12ff:	90                   	nop
    1300:	83 ec 04             	sub    $0x4,%esp
    1303:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    1306:	6a 01                	push   $0x1
    1308:	57                   	push   %edi
    1309:	56                   	push   %esi
    130a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    130e:	e8 00 fe ff ff       	call   1113 <write>
    1313:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1317:	83 c4 0c             	add    $0xc,%esp
    131a:	88 55 e7             	mov    %dl,-0x19(%ebp)
    131d:	6a 01                	push   $0x1
    131f:	57                   	push   %edi
    1320:	56                   	push   %esi
    1321:	e8 ed fd ff ff       	call   1113 <write>
    1326:	83 c4 10             	add    $0x10,%esp
    1329:	31 c9                	xor    %ecx,%ecx
    132b:	eb 95                	jmp    12c2 <printf+0x52>
    132d:	8d 76 00             	lea    0x0(%esi),%esi
    1330:	83 ec 0c             	sub    $0xc,%esp
    1333:	b9 10 00 00 00       	mov    $0x10,%ecx
    1338:	6a 00                	push   $0x0
    133a:	8b 45 d0             	mov    -0x30(%ebp),%eax
    133d:	8b 10                	mov    (%eax),%edx
    133f:	89 f0                	mov    %esi,%eax
    1341:	e8 7a fe ff ff       	call   11c0 <printint>
    1346:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    134a:	83 c4 10             	add    $0x10,%esp
    134d:	31 c9                	xor    %ecx,%ecx
    134f:	e9 6e ff ff ff       	jmp    12c2 <printf+0x52>
    1354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1358:	8b 45 d0             	mov    -0x30(%ebp),%eax
    135b:	8b 10                	mov    (%eax),%edx
    135d:	83 c0 04             	add    $0x4,%eax
    1360:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1363:	85 d2                	test   %edx,%edx
    1365:	0f 84 8d 00 00 00    	je     13f8 <printf+0x188>
    136b:	0f b6 02             	movzbl (%edx),%eax
    136e:	31 c9                	xor    %ecx,%ecx
    1370:	84 c0                	test   %al,%al
    1372:	0f 84 4a ff ff ff    	je     12c2 <printf+0x52>
    1378:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    137b:	89 d3                	mov    %edx,%ebx
    137d:	8d 76 00             	lea    0x0(%esi),%esi
    1380:	83 ec 04             	sub    $0x4,%esp
    1383:	83 c3 01             	add    $0x1,%ebx
    1386:	88 45 e7             	mov    %al,-0x19(%ebp)
    1389:	6a 01                	push   $0x1
    138b:	57                   	push   %edi
    138c:	56                   	push   %esi
    138d:	e8 81 fd ff ff       	call   1113 <write>
    1392:	0f b6 03             	movzbl (%ebx),%eax
    1395:	83 c4 10             	add    $0x10,%esp
    1398:	84 c0                	test   %al,%al
    139a:	75 e4                	jne    1380 <printf+0x110>
    139c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    139f:	31 c9                	xor    %ecx,%ecx
    13a1:	e9 1c ff ff ff       	jmp    12c2 <printf+0x52>
    13a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13ad:	8d 76 00             	lea    0x0(%esi),%esi
    13b0:	83 ec 0c             	sub    $0xc,%esp
    13b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    13b8:	6a 01                	push   $0x1
    13ba:	e9 7b ff ff ff       	jmp    133a <printf+0xca>
    13bf:	90                   	nop
    13c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    13c3:	83 ec 04             	sub    $0x4,%esp
    13c6:	8b 00                	mov    (%eax),%eax
    13c8:	6a 01                	push   $0x1
    13ca:	57                   	push   %edi
    13cb:	56                   	push   %esi
    13cc:	88 45 e7             	mov    %al,-0x19(%ebp)
    13cf:	e8 3f fd ff ff       	call   1113 <write>
    13d4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    13d8:	83 c4 10             	add    $0x10,%esp
    13db:	31 c9                	xor    %ecx,%ecx
    13dd:	e9 e0 fe ff ff       	jmp    12c2 <printf+0x52>
    13e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    13e8:	88 55 e7             	mov    %dl,-0x19(%ebp)
    13eb:	83 ec 04             	sub    $0x4,%esp
    13ee:	e9 2a ff ff ff       	jmp    131d <printf+0xad>
    13f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    13f7:	90                   	nop
    13f8:	ba 89 1c 00 00       	mov    $0x1c89,%edx
    13fd:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    1400:	b8 28 00 00 00       	mov    $0x28,%eax
    1405:	89 d3                	mov    %edx,%ebx
    1407:	e9 74 ff ff ff       	jmp    1380 <printf+0x110>
    140c:	66 90                	xchg   %ax,%ax
    140e:	66 90                	xchg   %ax,%ax

00001410 <free>:
    1410:	55                   	push   %ebp
    1411:	a1 94 20 00 00       	mov    0x2094,%eax
    1416:	89 e5                	mov    %esp,%ebp
    1418:	57                   	push   %edi
    1419:	56                   	push   %esi
    141a:	53                   	push   %ebx
    141b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    141e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1428:	89 c2                	mov    %eax,%edx
    142a:	8b 00                	mov    (%eax),%eax
    142c:	39 ca                	cmp    %ecx,%edx
    142e:	73 30                	jae    1460 <free+0x50>
    1430:	39 c1                	cmp    %eax,%ecx
    1432:	72 04                	jb     1438 <free+0x28>
    1434:	39 c2                	cmp    %eax,%edx
    1436:	72 f0                	jb     1428 <free+0x18>
    1438:	8b 73 fc             	mov    -0x4(%ebx),%esi
    143b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    143e:	39 f8                	cmp    %edi,%eax
    1440:	74 30                	je     1472 <free+0x62>
    1442:	89 43 f8             	mov    %eax,-0x8(%ebx)
    1445:	8b 42 04             	mov    0x4(%edx),%eax
    1448:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    144b:	39 f1                	cmp    %esi,%ecx
    144d:	74 3a                	je     1489 <free+0x79>
    144f:	89 0a                	mov    %ecx,(%edx)
    1451:	5b                   	pop    %ebx
    1452:	89 15 94 20 00 00    	mov    %edx,0x2094
    1458:	5e                   	pop    %esi
    1459:	5f                   	pop    %edi
    145a:	5d                   	pop    %ebp
    145b:	c3                   	ret    
    145c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1460:	39 c2                	cmp    %eax,%edx
    1462:	72 c4                	jb     1428 <free+0x18>
    1464:	39 c1                	cmp    %eax,%ecx
    1466:	73 c0                	jae    1428 <free+0x18>
    1468:	8b 73 fc             	mov    -0x4(%ebx),%esi
    146b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    146e:	39 f8                	cmp    %edi,%eax
    1470:	75 d0                	jne    1442 <free+0x32>
    1472:	03 70 04             	add    0x4(%eax),%esi
    1475:	89 73 fc             	mov    %esi,-0x4(%ebx)
    1478:	8b 02                	mov    (%edx),%eax
    147a:	8b 00                	mov    (%eax),%eax
    147c:	89 43 f8             	mov    %eax,-0x8(%ebx)
    147f:	8b 42 04             	mov    0x4(%edx),%eax
    1482:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1485:	39 f1                	cmp    %esi,%ecx
    1487:	75 c6                	jne    144f <free+0x3f>
    1489:	03 43 fc             	add    -0x4(%ebx),%eax
    148c:	89 15 94 20 00 00    	mov    %edx,0x2094
    1492:	89 42 04             	mov    %eax,0x4(%edx)
    1495:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    1498:	89 0a                	mov    %ecx,(%edx)
    149a:	5b                   	pop    %ebx
    149b:	5e                   	pop    %esi
    149c:	5f                   	pop    %edi
    149d:	5d                   	pop    %ebp
    149e:	c3                   	ret    
    149f:	90                   	nop

000014a0 <malloc>:
    14a0:	55                   	push   %ebp
    14a1:	89 e5                	mov    %esp,%ebp
    14a3:	57                   	push   %edi
    14a4:	56                   	push   %esi
    14a5:	53                   	push   %ebx
    14a6:	83 ec 1c             	sub    $0x1c,%esp
    14a9:	8b 45 08             	mov    0x8(%ebp),%eax
    14ac:	8b 3d 94 20 00 00    	mov    0x2094,%edi
    14b2:	8d 70 07             	lea    0x7(%eax),%esi
    14b5:	c1 ee 03             	shr    $0x3,%esi
    14b8:	83 c6 01             	add    $0x1,%esi
    14bb:	85 ff                	test   %edi,%edi
    14bd:	0f 84 9d 00 00 00    	je     1560 <malloc+0xc0>
    14c3:	8b 17                	mov    (%edi),%edx
    14c5:	8b 4a 04             	mov    0x4(%edx),%ecx
    14c8:	39 f1                	cmp    %esi,%ecx
    14ca:	73 6a                	jae    1536 <malloc+0x96>
    14cc:	bb 00 10 00 00       	mov    $0x1000,%ebx
    14d1:	39 de                	cmp    %ebx,%esi
    14d3:	0f 43 de             	cmovae %esi,%ebx
    14d6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    14dd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    14e0:	eb 17                	jmp    14f9 <malloc+0x59>
    14e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    14e8:	8b 02                	mov    (%edx),%eax
    14ea:	8b 48 04             	mov    0x4(%eax),%ecx
    14ed:	39 f1                	cmp    %esi,%ecx
    14ef:	73 4f                	jae    1540 <malloc+0xa0>
    14f1:	8b 3d 94 20 00 00    	mov    0x2094,%edi
    14f7:	89 c2                	mov    %eax,%edx
    14f9:	39 d7                	cmp    %edx,%edi
    14fb:	75 eb                	jne    14e8 <malloc+0x48>
    14fd:	83 ec 0c             	sub    $0xc,%esp
    1500:	ff 75 e4             	push   -0x1c(%ebp)
    1503:	e8 73 fc ff ff       	call   117b <sbrk>
    1508:	83 c4 10             	add    $0x10,%esp
    150b:	83 f8 ff             	cmp    $0xffffffff,%eax
    150e:	74 1c                	je     152c <malloc+0x8c>
    1510:	89 58 04             	mov    %ebx,0x4(%eax)
    1513:	83 ec 0c             	sub    $0xc,%esp
    1516:	83 c0 08             	add    $0x8,%eax
    1519:	50                   	push   %eax
    151a:	e8 f1 fe ff ff       	call   1410 <free>
    151f:	8b 15 94 20 00 00    	mov    0x2094,%edx
    1525:	83 c4 10             	add    $0x10,%esp
    1528:	85 d2                	test   %edx,%edx
    152a:	75 bc                	jne    14e8 <malloc+0x48>
    152c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    152f:	31 c0                	xor    %eax,%eax
    1531:	5b                   	pop    %ebx
    1532:	5e                   	pop    %esi
    1533:	5f                   	pop    %edi
    1534:	5d                   	pop    %ebp
    1535:	c3                   	ret    
    1536:	89 d0                	mov    %edx,%eax
    1538:	89 fa                	mov    %edi,%edx
    153a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1540:	39 ce                	cmp    %ecx,%esi
    1542:	74 4c                	je     1590 <malloc+0xf0>
    1544:	29 f1                	sub    %esi,%ecx
    1546:	89 48 04             	mov    %ecx,0x4(%eax)
    1549:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
    154c:	89 70 04             	mov    %esi,0x4(%eax)
    154f:	89 15 94 20 00 00    	mov    %edx,0x2094
    1555:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1558:	83 c0 08             	add    $0x8,%eax
    155b:	5b                   	pop    %ebx
    155c:	5e                   	pop    %esi
    155d:	5f                   	pop    %edi
    155e:	5d                   	pop    %ebp
    155f:	c3                   	ret    
    1560:	c7 05 94 20 00 00 98 	movl   $0x2098,0x2094
    1567:	20 00 00 
    156a:	bf 98 20 00 00       	mov    $0x2098,%edi
    156f:	c7 05 98 20 00 00 98 	movl   $0x2098,0x2098
    1576:	20 00 00 
    1579:	89 fa                	mov    %edi,%edx
    157b:	c7 05 9c 20 00 00 00 	movl   $0x0,0x209c
    1582:	00 00 00 
    1585:	e9 42 ff ff ff       	jmp    14cc <malloc+0x2c>
    158a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1590:	8b 08                	mov    (%eax),%ecx
    1592:	89 0a                	mov    %ecx,(%edx)
    1594:	eb b9                	jmp    154f <malloc+0xaf>
