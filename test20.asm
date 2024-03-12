
_test20:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    }
    close(fd);
    return N_PAGES * PGSIZE;
}

int main() {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	81 ec 7c 02 00 00    	sub    $0x27c,%esp
    printf(1, "\n\n%s\n", test_name);
  17:	ff 35 1c 12 00 00    	push   0x121c
  1d:	68 b5 0b 00 00       	push   $0xbb5
  22:	6a 01                	push   $0x1
  24:	e8 37 08 00 00       	call   860 <printf>

    // validate initial state
    struct wmapinfo winfo1;
    get_n_validate_wmap_info(&winfo1, 0); // no maps exist
  29:	58                   	pop    %eax
  2a:	8d 85 9c fd ff ff    	lea    -0x264(%ebp),%eax
  30:	5a                   	pop    %edx
  31:	6a 00                	push   $0x0
  33:	50                   	push   %eax
  34:	e8 87 02 00 00       	call   2c0 <get_n_validate_wmap_info>
    printf(1, "Initially 0 maps. \tOkay.\n");
  39:	59                   	pop    %ecx
  3a:	5b                   	pop    %ebx
  3b:	68 bb 0b 00 00       	push   $0xbbb
  40:	6a 01                	push   $0x1
  42:	e8 19 08 00 00       	call   860 <printf>

    // create and open a big file
    char *filename = "big.txt";
    int N_PAGES = 5;
    int filelength = create_big_file(filename, N_PAGES);
  47:	5e                   	pop    %esi
  48:	5f                   	pop    %edi
  49:	6a 05                	push   $0x5
  4b:	68 d5 0b 00 00       	push   $0xbd5
  50:	e8 3b 03 00 00       	call   390 <create_big_file>
  55:	89 c6                	mov    %eax,%esi
    int fd = open(filename, O_RDWR);
  57:	58                   	pop    %eax
  58:	5a                   	pop    %edx
  59:	6a 02                	push   $0x2
  5b:	68 d5 0b 00 00       	push   $0xbd5
  60:	e8 be 06 00 00       	call   723 <open>
    if (fd < 0) {
  65:	83 c4 10             	add    $0x10,%esp
  68:	85 c0                	test   %eax,%eax
  6a:	78 35                	js     a1 <main+0xa1>
  6c:	89 c3                	mov    %eax,%ebx
        printf(1, "Cause: Failed to open file %s\n", filename);
        failed();
    }
    struct stat st;
    if (fstat(fd, &st) < 0) {
  6e:	8d 85 88 fd ff ff    	lea    -0x278(%ebp),%eax
  74:	57                   	push   %edi
  75:	57                   	push   %edi
  76:	50                   	push   %eax
  77:	53                   	push   %ebx
  78:	e8 be 06 00 00       	call   73b <fstat>
  7d:	83 c4 10             	add    $0x10,%esp
  80:	85 c0                	test   %eax,%eax
  82:	78 34                	js     b8 <main+0xb8>
        printf(1, "Cause: Failed to get file stat\n");
        failed();
    }
    if (st.size != filelength) {
  84:	8b bd 98 fd ff ff    	mov    -0x268(%ebp),%edi
  8a:	39 f7                	cmp    %esi,%edi
  8c:	74 3d                	je     cb <main+0xcb>
        printf(1, "Cause: File size %d != %d\n", st.size, filelength);
  8e:	56                   	push   %esi
  8f:	57                   	push   %edi
  90:	68 dd 0b 00 00       	push   $0xbdd
  95:	6a 01                	push   $0x1
  97:	e8 c4 07 00 00       	call   860 <printf>
        failed();
  9c:	e8 ff 01 00 00       	call   2a0 <failed>
        printf(1, "Cause: Failed to open file %s\n", filename);
  a1:	50                   	push   %eax
  a2:	68 d5 0b 00 00       	push   $0xbd5
  a7:	68 24 0d 00 00       	push   $0xd24
  ac:	6a 01                	push   $0x1
  ae:	e8 ad 07 00 00       	call   860 <printf>
        failed();
  b3:	e8 e8 01 00 00       	call   2a0 <failed>
        printf(1, "Cause: Failed to get file stat\n");
  b8:	51                   	push   %ecx
  b9:	51                   	push   %ecx
  ba:	68 44 0d 00 00       	push   $0xd44
  bf:	6a 01                	push   $0x1
  c1:	e8 9a 07 00 00       	call   860 <printf>
        failed();
  c6:	e8 d5 01 00 00       	call   2a0 <failed>
    }
    printf(1, "Created file %s with length %d. \tOkay.\n", filename, filelength);
  cb:	57                   	push   %edi
  cc:	68 d5 0b 00 00       	push   $0xbd5
  d1:	68 64 0d 00 00       	push   $0xd64
  d6:	6a 01                	push   $0x1
  d8:	e8 83 07 00 00       	call   860 <printf>

    // place map 1 (fixed and filebacked)
    int fixed_filebacked_shared = MAP_FIXED | MAP_SHARED;
    uint addr = 0x60021000;
    uint length = filelength;
    uint map = wmap(addr, length, fixed_filebacked_shared, fd);
  dd:	53                   	push   %ebx
  de:	6a 0a                	push   $0xa
  e0:	57                   	push   %edi
  e1:	68 00 10 02 60       	push   $0x60021000
  e6:	e8 98 06 00 00       	call   783 <wmap>
    if (map != addr) {
  eb:	83 c4 20             	add    $0x20,%esp
  ee:	3d 00 10 02 60       	cmp    $0x60021000,%eax
  f3:	74 13                	je     108 <main+0x108>
        printf(1, "Cause: `wmap()` returned %d\n", map);
  f5:	52                   	push   %edx
  f6:	50                   	push   %eax
  f7:	68 f8 0b 00 00       	push   $0xbf8
  fc:	6a 01                	push   $0x1
  fe:	e8 5d 07 00 00       	call   860 <printf>
        failed();
 103:	e8 98 01 00 00       	call   2a0 <failed>
    }
    // validate mid state
    struct wmapinfo winfo2;
    get_n_validate_wmap_info(&winfo2, 1);   // 1 map exists
 108:	57                   	push   %edi
 109:	57                   	push   %edi
 10a:	8d bd 60 fe ff ff    	lea    -0x1a0(%ebp),%edi
 110:	6a 01                	push   $0x1
 112:	57                   	push   %edi
 113:	e8 a8 01 00 00       	call   2c0 <get_n_validate_wmap_info>
    map_exists(&winfo2, map, length, TRUE); // map 1 exists
 118:	6a 01                	push   $0x1
 11a:	56                   	push   %esi
 11b:	68 00 10 02 60       	push   $0x60021000
 120:	57                   	push   %edi
 121:	e8 ea 01 00 00       	call   310 <map_exists>
 126:	83 c4 10             	add    $0x10,%esp
    printf(1, "Placed map 1 at 0x%x with length %d. \tOkay.\n", map, length);
 129:	56                   	push   %esi
 12a:	68 00 10 02 60       	push   $0x60021000
 12f:	68 8c 0d 00 00       	push   $0xd8c
 134:	6a 01                	push   $0x1
 136:	e8 25 07 00 00       	call   860 <printf>

    // change all pages of map 1
    char *arr = (char *)map;
    char val = 'p';
    for (int i = 0; i < length; i++) {
 13b:	83 c4 20             	add    $0x20,%esp
 13e:	31 c0                	xor    %eax,%eax
 140:	eb 0a                	jmp    14c <main+0x14c>
        arr[i] = val;
 142:	c6 80 00 10 02 60 70 	movb   $0x70,0x60021000(%eax)
    for (int i = 0; i < length; i++) {
 149:	83 c0 01             	add    $0x1,%eax
 14c:	39 f0                	cmp    %esi,%eax
 14e:	75 f2                	jne    142 <main+0x142>
    }
    // unmap the map
    int ret = wunmap(map);
 150:	83 ec 0c             	sub    $0xc,%esp
 153:	68 00 10 02 60       	push   $0x60021000
 158:	e8 2e 06 00 00       	call   78b <wunmap>
    if (ret < 0) {
 15d:	83 c4 10             	add    $0x10,%esp
 160:	85 c0                	test   %eax,%eax
 162:	78 57                	js     1bb <main+0x1bb>
        printf(1, "Cause: `wunmap()` returned %d\n", ret);
        failed();
    }
    // validate final state
    struct wmapinfo winfo3;
    get_n_validate_wmap_info(&winfo3, 0); // no maps exist
 164:	50                   	push   %eax
 165:	50                   	push   %eax
 166:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
 16c:	6a 00                	push   $0x0
 16e:	50                   	push   %eax
 16f:	e8 4c 01 00 00       	call   2c0 <get_n_validate_wmap_info>
    printf(1, "Unmapped map 1. \tOkay.\n"); 
 174:	58                   	pop    %eax
 175:	5a                   	pop    %edx
 176:	68 15 0c 00 00       	push   $0xc15
 17b:	6a 01                	push   $0x1
 17d:	e8 de 06 00 00       	call   860 <printf>
    close(fd); // close the files
 182:	89 1c 24             	mov    %ebx,(%esp)
 185:	e8 81 05 00 00       	call   70b <close>

    // reopen the file and validate its content
    fd = open(filename, 'r');
 18a:	59                   	pop    %ecx
 18b:	5b                   	pop    %ebx
 18c:	6a 72                	push   $0x72
 18e:	68 d5 0b 00 00       	push   $0xbd5
 193:	e8 8b 05 00 00       	call   723 <open>
    if (fd < 0) {
 198:	83 c4 10             	add    $0x10,%esp
    fd = open(filename, 'r');
 19b:	89 c3                	mov    %eax,%ebx
    if (fd < 0) {
 19d:	85 c0                	test   %eax,%eax
 19f:	0f 88 fc fe ff ff    	js     a1 <main+0xa1>
        printf(1, "Cause: Failed to open file %s\n", filename);
        failed();
    }
    int bufflen = 512;
    char buff[bufflen + 1];
 1a5:	89 e0                	mov    %esp,%eax
 1a7:	39 c4                	cmp    %eax,%esp
 1a9:	74 23                	je     1ce <main+0x1ce>
 1ab:	81 ec 00 10 00 00    	sub    $0x1000,%esp
 1b1:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
 1b8:	00 
 1b9:	eb ec                	jmp    1a7 <main+0x1a7>
        printf(1, "Cause: `wunmap()` returned %d\n", ret);
 1bb:	56                   	push   %esi
 1bc:	50                   	push   %eax
 1bd:	68 bc 0d 00 00       	push   $0xdbc
 1c2:	6a 01                	push   $0x1
 1c4:	e8 97 06 00 00       	call   860 <printf>
        failed();
 1c9:	e8 d2 00 00 00       	call   2a0 <failed>
    char buff[bufflen + 1];
 1ce:	81 ec 10 02 00 00    	sub    $0x210,%esp
 1d4:	83 8c 24 0c 02 00 00 	orl    $0x0,0x20c(%esp)
 1db:	00 
    for (int i = 0; i < filelength; i += bufflen) {
 1dc:	c7 85 84 fd ff ff 00 	movl   $0x0,-0x27c(%ebp)
 1e3:	00 00 00 
    char buff[bufflen + 1];
 1e6:	89 e7                	mov    %esp,%edi
    for (int i = 0; i < filelength; i += bufflen) {
 1e8:	39 b5 84 fd ff ff    	cmp    %esi,-0x27c(%ebp)
 1ee:	7d 5c                	jge    24c <main+0x24c>
        if (read(fd, buff, bufflen) != bufflen) {
 1f0:	50                   	push   %eax
 1f1:	68 00 02 00 00       	push   $0x200
 1f6:	57                   	push   %edi
 1f7:	53                   	push   %ebx
 1f8:	e8 fe 04 00 00       	call   6fb <read>
 1fd:	83 c4 10             	add    $0x10,%esp
 200:	3d 00 02 00 00       	cmp    $0x200,%eax
 205:	75 61                	jne    268 <main+0x268>
            printf(1, "Error: Read from file %s FAILED\n", filename);
            failed();
        }
        for (int j = 0; j < bufflen; j++) {
 207:	31 c0                	xor    %eax,%eax
 209:	eb 0a                	jmp    215 <main+0x215>
 20b:	83 c0 01             	add    $0x1,%eax
 20e:	3d 00 02 00 00       	cmp    $0x200,%eax
 213:	74 2b                	je     240 <main+0x240>
            if (buff[j] != val) {
 215:	0f be 0c 07          	movsbl (%edi,%eax,1),%ecx
 219:	80 f9 70             	cmp    $0x70,%cl
 21c:	74 ed                	je     20b <main+0x20b>
                printf(1, "buff[j] = %c\t val = %c", buff[j], val);
 21e:	6a 70                	push   $0x70
 220:	51                   	push   %ecx
 221:	68 2d 0c 00 00       	push   $0xc2d
 226:	6a 01                	push   $0x1
 228:	e8 33 06 00 00       	call   860 <printf>
                printf(1, "Error: File content is not as expected\n");
 22d:	59                   	pop    %ecx
 22e:	5b                   	pop    %ebx
 22f:	68 00 0e 00 00       	push   $0xe00
 234:	6a 01                	push   $0x1
 236:	e8 25 06 00 00       	call   860 <printf>
                failed();
 23b:	e8 60 00 00 00       	call   2a0 <failed>
    for (int i = 0; i < filelength; i += bufflen) {
 240:	81 85 84 fd ff ff 00 	addl   $0x200,-0x27c(%ebp)
 247:	02 00 00 
 24a:	eb 9c                	jmp    1e8 <main+0x1e8>
            }
        }
    }
    close(fd);
 24c:	83 ec 0c             	sub    $0xc,%esp
 24f:	53                   	push   %ebx
 250:	e8 b6 04 00 00       	call   70b <close>
    printf(1, "File content is as expected. \tOkay.\n");
 255:	58                   	pop    %eax
 256:	5a                   	pop    %edx
 257:	68 28 0e 00 00       	push   $0xe28
 25c:	6a 01                	push   $0x1
 25e:	e8 fd 05 00 00       	call   860 <printf>

    // test ends
    success();
 263:	e8 18 00 00 00       	call   280 <success>
            printf(1, "Error: Read from file %s FAILED\n", filename);
 268:	56                   	push   %esi
 269:	68 d5 0b 00 00       	push   $0xbd5
 26e:	68 dc 0d 00 00       	push   $0xddc
 273:	6a 01                	push   $0x1
 275:	e8 e6 05 00 00       	call   860 <printf>
            failed();
 27a:	e8 21 00 00 00       	call   2a0 <failed>
 27f:	90                   	nop

00000280 <success>:
void success() {
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	83 ec 10             	sub    $0x10,%esp
    printf(1, "\nWMMAP\t SUCCESS\n\n");
 286:	68 88 0b 00 00       	push   $0xb88
 28b:	6a 01                	push   $0x1
 28d:	e8 ce 05 00 00       	call   860 <printf>
    exit();
 292:	e8 4c 04 00 00       	call   6e3 <exit>
 297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 29e:	66 90                	xchg   %ax,%ax

000002a0 <failed>:
void failed() {
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	83 ec 10             	sub    $0x10,%esp
    printf(1, "\nWMMAP\t FAILED\n\n");
 2a6:	68 9a 0b 00 00       	push   $0xb9a
 2ab:	6a 01                	push   $0x1
 2ad:	e8 ae 05 00 00       	call   860 <printf>
    exit();
 2b2:	e8 2c 04 00 00       	call   6e3 <exit>
 2b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2be:	66 90                	xchg   %ax,%ax

000002c0 <get_n_validate_wmap_info>:
void get_n_validate_wmap_info(struct wmapinfo *info, int expected_total_mmaps) {
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	53                   	push   %ebx
 2c4:	83 ec 10             	sub    $0x10,%esp
 2c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int ret = getwmapinfo(info);
 2ca:	53                   	push   %ebx
 2cb:	e8 d3 04 00 00       	call   7a3 <getwmapinfo>
    if (ret < 0) {
 2d0:	83 c4 10             	add    $0x10,%esp
 2d3:	85 c0                	test   %eax,%eax
 2d5:	78 0c                	js     2e3 <get_n_validate_wmap_info+0x23>
    if (info->total_mmaps != expected_total_mmaps) {
 2d7:	8b 03                	mov    (%ebx),%eax
 2d9:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2dc:	75 18                	jne    2f6 <get_n_validate_wmap_info+0x36>
}
 2de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2e1:	c9                   	leave  
 2e2:	c3                   	ret    
        printf(1, "Cause: `getwmapinfo()` returned %d\n", ret);
 2e3:	52                   	push   %edx
 2e4:	50                   	push   %eax
 2e5:	68 4c 0c 00 00       	push   $0xc4c
 2ea:	6a 01                	push   $0x1
 2ec:	e8 6f 05 00 00       	call   860 <printf>
        failed();
 2f1:	e8 aa ff ff ff       	call   2a0 <failed>
        printf(1, "Cause: expected %d maps, but found %d\n", expected_total_mmaps, info->total_mmaps);
 2f6:	50                   	push   %eax
 2f7:	ff 75 0c             	push   0xc(%ebp)
 2fa:	68 70 0c 00 00       	push   $0xc70
 2ff:	6a 01                	push   $0x1
 301:	e8 5a 05 00 00       	call   860 <printf>
        failed();
 306:	e8 95 ff ff ff       	call   2a0 <failed>
 30b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 30f:	90                   	nop

00000310 <map_exists>:
void map_exists(struct wmapinfo *info, uint addr, int length, int expected) {
 310:	55                   	push   %ebp
    for (int i = 0; i < info->total_mmaps; i++) {
 311:	31 c0                	xor    %eax,%eax
void map_exists(struct wmapinfo *info, uint addr, int length, int expected) {
 313:	89 e5                	mov    %esp,%ebp
 315:	56                   	push   %esi
 316:	8b 55 08             	mov    0x8(%ebp),%edx
 319:	8b 75 10             	mov    0x10(%ebp),%esi
 31c:	53                   	push   %ebx
 31d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    for (int i = 0; i < info->total_mmaps; i++) {
 320:	8b 0a                	mov    (%edx),%ecx
 322:	85 c9                	test   %ecx,%ecx
 324:	7f 11                	jg     337 <map_exists+0x27>
 326:	eb 20                	jmp    348 <map_exists+0x38>
 328:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 32f:	90                   	nop
 330:	83 c0 01             	add    $0x1,%eax
 333:	39 c8                	cmp    %ecx,%eax
 335:	74 21                	je     358 <map_exists+0x48>
        if (info->addr[i] == addr && info->length[i] == length) {
 337:	39 5c 82 04          	cmp    %ebx,0x4(%edx,%eax,4)
 33b:	75 f3                	jne    330 <map_exists+0x20>
 33d:	39 74 82 44          	cmp    %esi,0x44(%edx,%eax,4)
 341:	75 ed                	jne    330 <map_exists+0x20>
            found = 1;
 343:	b8 01 00 00 00       	mov    $0x1,%eax
    if (found != expected) {
 348:	3b 45 14             	cmp    0x14(%ebp),%eax
 34b:	75 0f                	jne    35c <map_exists+0x4c>
}
 34d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 350:	5b                   	pop    %ebx
 351:	5e                   	pop    %esi
 352:	5d                   	pop    %ebp
 353:	c3                   	ret    
 354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int found = 0;
 358:	31 c0                	xor    %eax,%eax
 35a:	eb ec                	jmp    348 <map_exists+0x38>
        printf(1, "Cause: expected 0x%x with length %d to %s in the list of maps\n", addr, length, expected ? "exist" : "not exist");
 35c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 360:	ba ab 0b 00 00       	mov    $0xbab,%edx
 365:	b8 af 0b 00 00       	mov    $0xbaf,%eax
 36a:	0f 44 c2             	cmove  %edx,%eax
 36d:	83 ec 0c             	sub    $0xc,%esp
 370:	50                   	push   %eax
 371:	56                   	push   %esi
 372:	53                   	push   %ebx
 373:	68 98 0c 00 00       	push   $0xc98
 378:	6a 01                	push   $0x1
 37a:	e8 e1 04 00 00       	call   860 <printf>
        failed();
 37f:	83 c4 20             	add    $0x20,%esp
 382:	e8 19 ff ff ff       	call   2a0 <failed>
 387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 38e:	66 90                	xchg   %ax,%ax

00000390 <create_big_file>:
int create_big_file(char *filename, int N_PAGES) {
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
 396:	83 ec 1c             	sub    $0x1c,%esp
 399:	8b 5d 08             	mov    0x8(%ebp),%ebx
    char buff[bufflen + 1];
 39c:	89 e0                	mov    %esp,%eax
 39e:	39 c4                	cmp    %eax,%esp
 3a0:	74 12                	je     3b4 <create_big_file+0x24>
 3a2:	81 ec 00 10 00 00    	sub    $0x1000,%esp
 3a8:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
 3af:	00 
 3b0:	39 c4                	cmp    %eax,%esp
 3b2:	75 ee                	jne    3a2 <create_big_file+0x12>
 3b4:	81 ec 10 02 00 00    	sub    $0x210,%esp
 3ba:	83 8c 24 0c 02 00 00 	orl    $0x0,0x20c(%esp)
 3c1:	00 
 3c2:	89 e6                	mov    %esp,%esi
    int fd = open(filename, O_CREATE | O_RDWR);
 3c4:	83 ec 08             	sub    $0x8,%esp
 3c7:	68 02 02 00 00       	push   $0x202
 3cc:	53                   	push   %ebx
 3cd:	e8 51 03 00 00       	call   723 <open>
    if (fd < 0) {
 3d2:	89 f4                	mov    %esi,%esp
    int fd = open(filename, O_CREATE | O_RDWR);
 3d4:	89 45 e0             	mov    %eax,-0x20(%ebp)
    if (fd < 0) {
 3d7:	85 c0                	test   %eax,%eax
 3d9:	0f 88 9c 00 00 00    	js     47b <create_big_file+0xeb>
    for (int i = 0; i < N_PAGES; i++) {
 3df:	8b 55 0c             	mov    0xc(%ebp),%edx
 3e2:	8d 9e 00 02 00 00    	lea    0x200(%esi),%ebx
 3e8:	89 f7                	mov    %esi,%edi
 3ea:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
 3f1:	89 de                	mov    %ebx,%esi
 3f3:	85 d2                	test   %edx,%edx
 3f5:	7e 56                	jle    44d <create_big_file+0xbd>
 3f7:	0f b6 45 dc          	movzbl -0x24(%ebp),%eax
        for (int k = 0; k < m; k++) {
 3fb:	31 d2                	xor    %edx,%edx
 3fd:	8d 58 61             	lea    0x61(%eax),%ebx
            for (int j = 0; j < bufflen; j++) {
 400:	89 f8                	mov    %edi,%eax
 402:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                buff[j] = c;
 408:	88 18                	mov    %bl,(%eax)
            for (int j = 0; j < bufflen; j++) {
 40a:	83 c0 01             	add    $0x1,%eax
 40d:	39 f0                	cmp    %esi,%eax
 40f:	75 f7                	jne    408 <create_big_file+0x78>
            if (write(fd, buff, bufflen) != bufflen) {
 411:	83 ec 04             	sub    $0x4,%esp
            buff[bufflen] = '\0';
 414:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 417:	c6 87 00 02 00 00 00 	movb   $0x0,0x200(%edi)
            if (write(fd, buff, bufflen) != bufflen) {
 41e:	68 00 02 00 00       	push   $0x200
 423:	57                   	push   %edi
 424:	ff 75 e0             	push   -0x20(%ebp)
 427:	e8 d7 02 00 00       	call   703 <write>
 42c:	83 c4 10             	add    $0x10,%esp
 42f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 432:	3d 00 02 00 00       	cmp    $0x200,%eax
 437:	75 2d                	jne    466 <create_big_file+0xd6>
        for (int k = 0; k < m; k++) {
 439:	83 c2 01             	add    $0x1,%edx
 43c:	83 fa 08             	cmp    $0x8,%edx
 43f:	75 bf                	jne    400 <create_big_file+0x70>
    for (int i = 0; i < N_PAGES; i++) {
 441:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
 445:	8b 45 dc             	mov    -0x24(%ebp),%eax
 448:	39 45 0c             	cmp    %eax,0xc(%ebp)
 44b:	75 aa                	jne    3f7 <create_big_file+0x67>
    close(fd);
 44d:	83 ec 0c             	sub    $0xc,%esp
 450:	ff 75 e0             	push   -0x20(%ebp)
 453:	e8 b3 02 00 00       	call   70b <close>
    return N_PAGES * PGSIZE;
 458:	8b 45 0c             	mov    0xc(%ebp),%eax
}
 45b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 45e:	5b                   	pop    %ebx
 45f:	5e                   	pop    %esi
    return N_PAGES * PGSIZE;
 460:	c1 e0 0c             	shl    $0xc,%eax
}
 463:	5f                   	pop    %edi
 464:	5d                   	pop    %ebp
 465:	c3                   	ret    
                printf(1, "Error: Write to file FAILED (%d, %d)\n", i, k);
 466:	52                   	push   %edx
 467:	ff 75 dc             	push   -0x24(%ebp)
 46a:	68 fc 0c 00 00       	push   $0xcfc
 46f:	6a 01                	push   $0x1
 471:	e8 ea 03 00 00       	call   860 <printf>
                failed();
 476:	e8 25 fe ff ff       	call   2a0 <failed>
        printf(1, "\tCause:\tFailed to create file %s\n", filename);
 47b:	50                   	push   %eax
 47c:	53                   	push   %ebx
 47d:	68 d8 0c 00 00       	push   $0xcd8
 482:	6a 01                	push   $0x1
 484:	e8 d7 03 00 00       	call   860 <printf>
        failed();
 489:	e8 12 fe ff ff       	call   2a0 <failed>
 48e:	66 90                	xchg   %ax,%ax

00000490 <strcpy>:
 490:	55                   	push   %ebp
 491:	31 c0                	xor    %eax,%eax
 493:	89 e5                	mov    %esp,%ebp
 495:	53                   	push   %ebx
 496:	8b 4d 08             	mov    0x8(%ebp),%ecx
 499:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4a0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 4a4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 4a7:	83 c0 01             	add    $0x1,%eax
 4aa:	84 d2                	test   %dl,%dl
 4ac:	75 f2                	jne    4a0 <strcpy+0x10>
 4ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4b1:	89 c8                	mov    %ecx,%eax
 4b3:	c9                   	leave  
 4b4:	c3                   	ret    
 4b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004c0 <strcmp>:
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	53                   	push   %ebx
 4c4:	8b 55 08             	mov    0x8(%ebp),%edx
 4c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 4ca:	0f b6 02             	movzbl (%edx),%eax
 4cd:	84 c0                	test   %al,%al
 4cf:	75 17                	jne    4e8 <strcmp+0x28>
 4d1:	eb 3a                	jmp    50d <strcmp+0x4d>
 4d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4d7:	90                   	nop
 4d8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
 4dc:	83 c2 01             	add    $0x1,%edx
 4df:	8d 59 01             	lea    0x1(%ecx),%ebx
 4e2:	84 c0                	test   %al,%al
 4e4:	74 1a                	je     500 <strcmp+0x40>
 4e6:	89 d9                	mov    %ebx,%ecx
 4e8:	0f b6 19             	movzbl (%ecx),%ebx
 4eb:	38 c3                	cmp    %al,%bl
 4ed:	74 e9                	je     4d8 <strcmp+0x18>
 4ef:	29 d8                	sub    %ebx,%eax
 4f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4f4:	c9                   	leave  
 4f5:	c3                   	ret    
 4f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
 500:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 504:	31 c0                	xor    %eax,%eax
 506:	29 d8                	sub    %ebx,%eax
 508:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 50b:	c9                   	leave  
 50c:	c3                   	ret    
 50d:	0f b6 19             	movzbl (%ecx),%ebx
 510:	31 c0                	xor    %eax,%eax
 512:	eb db                	jmp    4ef <strcmp+0x2f>
 514:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 51b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 51f:	90                   	nop

00000520 <strlen>:
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	8b 55 08             	mov    0x8(%ebp),%edx
 526:	80 3a 00             	cmpb   $0x0,(%edx)
 529:	74 15                	je     540 <strlen+0x20>
 52b:	31 c0                	xor    %eax,%eax
 52d:	8d 76 00             	lea    0x0(%esi),%esi
 530:	83 c0 01             	add    $0x1,%eax
 533:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 537:	89 c1                	mov    %eax,%ecx
 539:	75 f5                	jne    530 <strlen+0x10>
 53b:	89 c8                	mov    %ecx,%eax
 53d:	5d                   	pop    %ebp
 53e:	c3                   	ret    
 53f:	90                   	nop
 540:	31 c9                	xor    %ecx,%ecx
 542:	5d                   	pop    %ebp
 543:	89 c8                	mov    %ecx,%eax
 545:	c3                   	ret    
 546:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 54d:	8d 76 00             	lea    0x0(%esi),%esi

00000550 <memset>:
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	57                   	push   %edi
 554:	8b 55 08             	mov    0x8(%ebp),%edx
 557:	8b 4d 10             	mov    0x10(%ebp),%ecx
 55a:	8b 45 0c             	mov    0xc(%ebp),%eax
 55d:	89 d7                	mov    %edx,%edi
 55f:	fc                   	cld    
 560:	f3 aa                	rep stos %al,%es:(%edi)
 562:	8b 7d fc             	mov    -0x4(%ebp),%edi
 565:	89 d0                	mov    %edx,%eax
 567:	c9                   	leave  
 568:	c3                   	ret    
 569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000570 <strchr>:
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	8b 45 08             	mov    0x8(%ebp),%eax
 576:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 57a:	0f b6 10             	movzbl (%eax),%edx
 57d:	84 d2                	test   %dl,%dl
 57f:	75 12                	jne    593 <strchr+0x23>
 581:	eb 1d                	jmp    5a0 <strchr+0x30>
 583:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 587:	90                   	nop
 588:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 58c:	83 c0 01             	add    $0x1,%eax
 58f:	84 d2                	test   %dl,%dl
 591:	74 0d                	je     5a0 <strchr+0x30>
 593:	38 d1                	cmp    %dl,%cl
 595:	75 f1                	jne    588 <strchr+0x18>
 597:	5d                   	pop    %ebp
 598:	c3                   	ret    
 599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5a0:	31 c0                	xor    %eax,%eax
 5a2:	5d                   	pop    %ebp
 5a3:	c3                   	ret    
 5a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5af:	90                   	nop

000005b0 <gets>:
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	56                   	push   %esi
 5b5:	8d 7d e7             	lea    -0x19(%ebp),%edi
 5b8:	53                   	push   %ebx
 5b9:	31 db                	xor    %ebx,%ebx
 5bb:	83 ec 1c             	sub    $0x1c,%esp
 5be:	eb 27                	jmp    5e7 <gets+0x37>
 5c0:	83 ec 04             	sub    $0x4,%esp
 5c3:	6a 01                	push   $0x1
 5c5:	57                   	push   %edi
 5c6:	6a 00                	push   $0x0
 5c8:	e8 2e 01 00 00       	call   6fb <read>
 5cd:	83 c4 10             	add    $0x10,%esp
 5d0:	85 c0                	test   %eax,%eax
 5d2:	7e 1d                	jle    5f1 <gets+0x41>
 5d4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 5d8:	8b 55 08             	mov    0x8(%ebp),%edx
 5db:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 5df:	3c 0a                	cmp    $0xa,%al
 5e1:	74 1d                	je     600 <gets+0x50>
 5e3:	3c 0d                	cmp    $0xd,%al
 5e5:	74 19                	je     600 <gets+0x50>
 5e7:	89 de                	mov    %ebx,%esi
 5e9:	83 c3 01             	add    $0x1,%ebx
 5ec:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 5ef:	7c cf                	jl     5c0 <gets+0x10>
 5f1:	8b 45 08             	mov    0x8(%ebp),%eax
 5f4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 5f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5fb:	5b                   	pop    %ebx
 5fc:	5e                   	pop    %esi
 5fd:	5f                   	pop    %edi
 5fe:	5d                   	pop    %ebp
 5ff:	c3                   	ret    
 600:	8b 45 08             	mov    0x8(%ebp),%eax
 603:	89 de                	mov    %ebx,%esi
 605:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 609:	8d 65 f4             	lea    -0xc(%ebp),%esp
 60c:	5b                   	pop    %ebx
 60d:	5e                   	pop    %esi
 60e:	5f                   	pop    %edi
 60f:	5d                   	pop    %ebp
 610:	c3                   	ret    
 611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 618:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 61f:	90                   	nop

00000620 <stat>:
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	56                   	push   %esi
 624:	53                   	push   %ebx
 625:	83 ec 08             	sub    $0x8,%esp
 628:	6a 00                	push   $0x0
 62a:	ff 75 08             	push   0x8(%ebp)
 62d:	e8 f1 00 00 00       	call   723 <open>
 632:	83 c4 10             	add    $0x10,%esp
 635:	85 c0                	test   %eax,%eax
 637:	78 27                	js     660 <stat+0x40>
 639:	83 ec 08             	sub    $0x8,%esp
 63c:	ff 75 0c             	push   0xc(%ebp)
 63f:	89 c3                	mov    %eax,%ebx
 641:	50                   	push   %eax
 642:	e8 f4 00 00 00       	call   73b <fstat>
 647:	89 1c 24             	mov    %ebx,(%esp)
 64a:	89 c6                	mov    %eax,%esi
 64c:	e8 ba 00 00 00       	call   70b <close>
 651:	83 c4 10             	add    $0x10,%esp
 654:	8d 65 f8             	lea    -0x8(%ebp),%esp
 657:	89 f0                	mov    %esi,%eax
 659:	5b                   	pop    %ebx
 65a:	5e                   	pop    %esi
 65b:	5d                   	pop    %ebp
 65c:	c3                   	ret    
 65d:	8d 76 00             	lea    0x0(%esi),%esi
 660:	be ff ff ff ff       	mov    $0xffffffff,%esi
 665:	eb ed                	jmp    654 <stat+0x34>
 667:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 66e:	66 90                	xchg   %ax,%ax

00000670 <atoi>:
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	53                   	push   %ebx
 674:	8b 55 08             	mov    0x8(%ebp),%edx
 677:	0f be 02             	movsbl (%edx),%eax
 67a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 67d:	80 f9 09             	cmp    $0x9,%cl
 680:	b9 00 00 00 00       	mov    $0x0,%ecx
 685:	77 1e                	ja     6a5 <atoi+0x35>
 687:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 68e:	66 90                	xchg   %ax,%ax
 690:	83 c2 01             	add    $0x1,%edx
 693:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 696:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 69a:	0f be 02             	movsbl (%edx),%eax
 69d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 6a0:	80 fb 09             	cmp    $0x9,%bl
 6a3:	76 eb                	jbe    690 <atoi+0x20>
 6a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6a8:	89 c8                	mov    %ecx,%eax
 6aa:	c9                   	leave  
 6ab:	c3                   	ret    
 6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006b0 <memmove>:
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	8b 45 10             	mov    0x10(%ebp),%eax
 6b7:	8b 55 08             	mov    0x8(%ebp),%edx
 6ba:	56                   	push   %esi
 6bb:	8b 75 0c             	mov    0xc(%ebp),%esi
 6be:	85 c0                	test   %eax,%eax
 6c0:	7e 13                	jle    6d5 <memmove+0x25>
 6c2:	01 d0                	add    %edx,%eax
 6c4:	89 d7                	mov    %edx,%edi
 6c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
 6d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 6d1:	39 f8                	cmp    %edi,%eax
 6d3:	75 fb                	jne    6d0 <memmove+0x20>
 6d5:	5e                   	pop    %esi
 6d6:	89 d0                	mov    %edx,%eax
 6d8:	5f                   	pop    %edi
 6d9:	5d                   	pop    %ebp
 6da:	c3                   	ret    

000006db <fork>:
 6db:	b8 01 00 00 00       	mov    $0x1,%eax
 6e0:	cd 40                	int    $0x40
 6e2:	c3                   	ret    

000006e3 <exit>:
 6e3:	b8 02 00 00 00       	mov    $0x2,%eax
 6e8:	cd 40                	int    $0x40
 6ea:	c3                   	ret    

000006eb <wait>:
 6eb:	b8 03 00 00 00       	mov    $0x3,%eax
 6f0:	cd 40                	int    $0x40
 6f2:	c3                   	ret    

000006f3 <pipe>:
 6f3:	b8 04 00 00 00       	mov    $0x4,%eax
 6f8:	cd 40                	int    $0x40
 6fa:	c3                   	ret    

000006fb <read>:
 6fb:	b8 05 00 00 00       	mov    $0x5,%eax
 700:	cd 40                	int    $0x40
 702:	c3                   	ret    

00000703 <write>:
 703:	b8 10 00 00 00       	mov    $0x10,%eax
 708:	cd 40                	int    $0x40
 70a:	c3                   	ret    

0000070b <close>:
 70b:	b8 15 00 00 00       	mov    $0x15,%eax
 710:	cd 40                	int    $0x40
 712:	c3                   	ret    

00000713 <kill>:
 713:	b8 06 00 00 00       	mov    $0x6,%eax
 718:	cd 40                	int    $0x40
 71a:	c3                   	ret    

0000071b <exec>:
 71b:	b8 07 00 00 00       	mov    $0x7,%eax
 720:	cd 40                	int    $0x40
 722:	c3                   	ret    

00000723 <open>:
 723:	b8 0f 00 00 00       	mov    $0xf,%eax
 728:	cd 40                	int    $0x40
 72a:	c3                   	ret    

0000072b <mknod>:
 72b:	b8 11 00 00 00       	mov    $0x11,%eax
 730:	cd 40                	int    $0x40
 732:	c3                   	ret    

00000733 <unlink>:
 733:	b8 12 00 00 00       	mov    $0x12,%eax
 738:	cd 40                	int    $0x40
 73a:	c3                   	ret    

0000073b <fstat>:
 73b:	b8 08 00 00 00       	mov    $0x8,%eax
 740:	cd 40                	int    $0x40
 742:	c3                   	ret    

00000743 <link>:
 743:	b8 13 00 00 00       	mov    $0x13,%eax
 748:	cd 40                	int    $0x40
 74a:	c3                   	ret    

0000074b <mkdir>:
 74b:	b8 14 00 00 00       	mov    $0x14,%eax
 750:	cd 40                	int    $0x40
 752:	c3                   	ret    

00000753 <chdir>:
 753:	b8 09 00 00 00       	mov    $0x9,%eax
 758:	cd 40                	int    $0x40
 75a:	c3                   	ret    

0000075b <dup>:
 75b:	b8 0a 00 00 00       	mov    $0xa,%eax
 760:	cd 40                	int    $0x40
 762:	c3                   	ret    

00000763 <getpid>:
 763:	b8 0b 00 00 00       	mov    $0xb,%eax
 768:	cd 40                	int    $0x40
 76a:	c3                   	ret    

0000076b <sbrk>:
 76b:	b8 0c 00 00 00       	mov    $0xc,%eax
 770:	cd 40                	int    $0x40
 772:	c3                   	ret    

00000773 <sleep>:
 773:	b8 0d 00 00 00       	mov    $0xd,%eax
 778:	cd 40                	int    $0x40
 77a:	c3                   	ret    

0000077b <uptime>:
 77b:	b8 0e 00 00 00       	mov    $0xe,%eax
 780:	cd 40                	int    $0x40
 782:	c3                   	ret    

00000783 <wmap>:
 783:	b8 16 00 00 00       	mov    $0x16,%eax
 788:	cd 40                	int    $0x40
 78a:	c3                   	ret    

0000078b <wunmap>:
 78b:	b8 17 00 00 00       	mov    $0x17,%eax
 790:	cd 40                	int    $0x40
 792:	c3                   	ret    

00000793 <wremap>:
 793:	b8 18 00 00 00       	mov    $0x18,%eax
 798:	cd 40                	int    $0x40
 79a:	c3                   	ret    

0000079b <getpgdirinfo>:
 79b:	b8 19 00 00 00       	mov    $0x19,%eax
 7a0:	cd 40                	int    $0x40
 7a2:	c3                   	ret    

000007a3 <getwmapinfo>:
 7a3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 7a8:	cd 40                	int    $0x40
 7aa:	c3                   	ret    
 7ab:	66 90                	xchg   %ax,%ax
 7ad:	66 90                	xchg   %ax,%ax
 7af:	90                   	nop

000007b0 <printint>:
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	57                   	push   %edi
 7b4:	56                   	push   %esi
 7b5:	53                   	push   %ebx
 7b6:	83 ec 3c             	sub    $0x3c,%esp
 7b9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 7bc:	89 d1                	mov    %edx,%ecx
 7be:	89 45 b8             	mov    %eax,-0x48(%ebp)
 7c1:	85 d2                	test   %edx,%edx
 7c3:	0f 89 7f 00 00 00    	jns    848 <printint+0x98>
 7c9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 7cd:	74 79                	je     848 <printint+0x98>
 7cf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
 7d6:	f7 d9                	neg    %ecx
 7d8:	31 db                	xor    %ebx,%ebx
 7da:	8d 75 d7             	lea    -0x29(%ebp),%esi
 7dd:	8d 76 00             	lea    0x0(%esi),%esi
 7e0:	89 c8                	mov    %ecx,%eax
 7e2:	31 d2                	xor    %edx,%edx
 7e4:	89 cf                	mov    %ecx,%edi
 7e6:	f7 75 c4             	divl   -0x3c(%ebp)
 7e9:	0f b6 92 ac 0e 00 00 	movzbl 0xeac(%edx),%edx
 7f0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 7f3:	89 d8                	mov    %ebx,%eax
 7f5:	8d 5b 01             	lea    0x1(%ebx),%ebx
 7f8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 7fb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
 7fe:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 801:	76 dd                	jbe    7e0 <printint+0x30>
 803:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 806:	85 c9                	test   %ecx,%ecx
 808:	74 0c                	je     816 <printint+0x66>
 80a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 80f:	89 d8                	mov    %ebx,%eax
 811:	ba 2d 00 00 00       	mov    $0x2d,%edx
 816:	8b 7d b8             	mov    -0x48(%ebp),%edi
 819:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 81d:	eb 07                	jmp    826 <printint+0x76>
 81f:	90                   	nop
 820:	0f b6 13             	movzbl (%ebx),%edx
 823:	83 eb 01             	sub    $0x1,%ebx
 826:	83 ec 04             	sub    $0x4,%esp
 829:	88 55 d7             	mov    %dl,-0x29(%ebp)
 82c:	6a 01                	push   $0x1
 82e:	56                   	push   %esi
 82f:	57                   	push   %edi
 830:	e8 ce fe ff ff       	call   703 <write>
 835:	83 c4 10             	add    $0x10,%esp
 838:	39 de                	cmp    %ebx,%esi
 83a:	75 e4                	jne    820 <printint+0x70>
 83c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 83f:	5b                   	pop    %ebx
 840:	5e                   	pop    %esi
 841:	5f                   	pop    %edi
 842:	5d                   	pop    %ebp
 843:	c3                   	ret    
 844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 848:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 84f:	eb 87                	jmp    7d8 <printint+0x28>
 851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 858:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 85f:	90                   	nop

00000860 <printf>:
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	57                   	push   %edi
 864:	56                   	push   %esi
 865:	53                   	push   %ebx
 866:	83 ec 2c             	sub    $0x2c,%esp
 869:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 86c:	8b 75 08             	mov    0x8(%ebp),%esi
 86f:	0f b6 13             	movzbl (%ebx),%edx
 872:	84 d2                	test   %dl,%dl
 874:	74 6a                	je     8e0 <printf+0x80>
 876:	8d 45 10             	lea    0x10(%ebp),%eax
 879:	83 c3 01             	add    $0x1,%ebx
 87c:	8d 7d e7             	lea    -0x19(%ebp),%edi
 87f:	31 c9                	xor    %ecx,%ecx
 881:	89 45 d0             	mov    %eax,-0x30(%ebp)
 884:	eb 36                	jmp    8bc <printf+0x5c>
 886:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 88d:	8d 76 00             	lea    0x0(%esi),%esi
 890:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 893:	b9 25 00 00 00       	mov    $0x25,%ecx
 898:	83 f8 25             	cmp    $0x25,%eax
 89b:	74 15                	je     8b2 <printf+0x52>
 89d:	83 ec 04             	sub    $0x4,%esp
 8a0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 8a3:	6a 01                	push   $0x1
 8a5:	57                   	push   %edi
 8a6:	56                   	push   %esi
 8a7:	e8 57 fe ff ff       	call   703 <write>
 8ac:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 8af:	83 c4 10             	add    $0x10,%esp
 8b2:	0f b6 13             	movzbl (%ebx),%edx
 8b5:	83 c3 01             	add    $0x1,%ebx
 8b8:	84 d2                	test   %dl,%dl
 8ba:	74 24                	je     8e0 <printf+0x80>
 8bc:	0f b6 c2             	movzbl %dl,%eax
 8bf:	85 c9                	test   %ecx,%ecx
 8c1:	74 cd                	je     890 <printf+0x30>
 8c3:	83 f9 25             	cmp    $0x25,%ecx
 8c6:	75 ea                	jne    8b2 <printf+0x52>
 8c8:	83 f8 25             	cmp    $0x25,%eax
 8cb:	0f 84 07 01 00 00    	je     9d8 <printf+0x178>
 8d1:	83 e8 63             	sub    $0x63,%eax
 8d4:	83 f8 15             	cmp    $0x15,%eax
 8d7:	77 17                	ja     8f0 <printf+0x90>
 8d9:	ff 24 85 54 0e 00 00 	jmp    *0xe54(,%eax,4)
 8e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8e3:	5b                   	pop    %ebx
 8e4:	5e                   	pop    %esi
 8e5:	5f                   	pop    %edi
 8e6:	5d                   	pop    %ebp
 8e7:	c3                   	ret    
 8e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ef:	90                   	nop
 8f0:	83 ec 04             	sub    $0x4,%esp
 8f3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 8f6:	6a 01                	push   $0x1
 8f8:	57                   	push   %edi
 8f9:	56                   	push   %esi
 8fa:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 8fe:	e8 00 fe ff ff       	call   703 <write>
 903:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 907:	83 c4 0c             	add    $0xc,%esp
 90a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 90d:	6a 01                	push   $0x1
 90f:	57                   	push   %edi
 910:	56                   	push   %esi
 911:	e8 ed fd ff ff       	call   703 <write>
 916:	83 c4 10             	add    $0x10,%esp
 919:	31 c9                	xor    %ecx,%ecx
 91b:	eb 95                	jmp    8b2 <printf+0x52>
 91d:	8d 76 00             	lea    0x0(%esi),%esi
 920:	83 ec 0c             	sub    $0xc,%esp
 923:	b9 10 00 00 00       	mov    $0x10,%ecx
 928:	6a 00                	push   $0x0
 92a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 92d:	8b 10                	mov    (%eax),%edx
 92f:	89 f0                	mov    %esi,%eax
 931:	e8 7a fe ff ff       	call   7b0 <printint>
 936:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 93a:	83 c4 10             	add    $0x10,%esp
 93d:	31 c9                	xor    %ecx,%ecx
 93f:	e9 6e ff ff ff       	jmp    8b2 <printf+0x52>
 944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 948:	8b 45 d0             	mov    -0x30(%ebp),%eax
 94b:	8b 10                	mov    (%eax),%edx
 94d:	83 c0 04             	add    $0x4,%eax
 950:	89 45 d0             	mov    %eax,-0x30(%ebp)
 953:	85 d2                	test   %edx,%edx
 955:	0f 84 8d 00 00 00    	je     9e8 <printf+0x188>
 95b:	0f b6 02             	movzbl (%edx),%eax
 95e:	31 c9                	xor    %ecx,%ecx
 960:	84 c0                	test   %al,%al
 962:	0f 84 4a ff ff ff    	je     8b2 <printf+0x52>
 968:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 96b:	89 d3                	mov    %edx,%ebx
 96d:	8d 76 00             	lea    0x0(%esi),%esi
 970:	83 ec 04             	sub    $0x4,%esp
 973:	83 c3 01             	add    $0x1,%ebx
 976:	88 45 e7             	mov    %al,-0x19(%ebp)
 979:	6a 01                	push   $0x1
 97b:	57                   	push   %edi
 97c:	56                   	push   %esi
 97d:	e8 81 fd ff ff       	call   703 <write>
 982:	0f b6 03             	movzbl (%ebx),%eax
 985:	83 c4 10             	add    $0x10,%esp
 988:	84 c0                	test   %al,%al
 98a:	75 e4                	jne    970 <printf+0x110>
 98c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 98f:	31 c9                	xor    %ecx,%ecx
 991:	e9 1c ff ff ff       	jmp    8b2 <printf+0x52>
 996:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 99d:	8d 76 00             	lea    0x0(%esi),%esi
 9a0:	83 ec 0c             	sub    $0xc,%esp
 9a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 9a8:	6a 01                	push   $0x1
 9aa:	e9 7b ff ff ff       	jmp    92a <printf+0xca>
 9af:	90                   	nop
 9b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 9b3:	83 ec 04             	sub    $0x4,%esp
 9b6:	8b 00                	mov    (%eax),%eax
 9b8:	6a 01                	push   $0x1
 9ba:	57                   	push   %edi
 9bb:	56                   	push   %esi
 9bc:	88 45 e7             	mov    %al,-0x19(%ebp)
 9bf:	e8 3f fd ff ff       	call   703 <write>
 9c4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 9c8:	83 c4 10             	add    $0x10,%esp
 9cb:	31 c9                	xor    %ecx,%ecx
 9cd:	e9 e0 fe ff ff       	jmp    8b2 <printf+0x52>
 9d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 9d8:	88 55 e7             	mov    %dl,-0x19(%ebp)
 9db:	83 ec 04             	sub    $0x4,%esp
 9de:	e9 2a ff ff ff       	jmp    90d <printf+0xad>
 9e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 9e7:	90                   	nop
 9e8:	ba 4d 0e 00 00       	mov    $0xe4d,%edx
 9ed:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 9f0:	b8 28 00 00 00       	mov    $0x28,%eax
 9f5:	89 d3                	mov    %edx,%ebx
 9f7:	e9 74 ff ff ff       	jmp    970 <printf+0x110>
 9fc:	66 90                	xchg   %ax,%ax
 9fe:	66 90                	xchg   %ax,%ax

00000a00 <free>:
 a00:	55                   	push   %ebp
 a01:	a1 20 12 00 00       	mov    0x1220,%eax
 a06:	89 e5                	mov    %esp,%ebp
 a08:	57                   	push   %edi
 a09:	56                   	push   %esi
 a0a:	53                   	push   %ebx
 a0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a0e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a18:	89 c2                	mov    %eax,%edx
 a1a:	8b 00                	mov    (%eax),%eax
 a1c:	39 ca                	cmp    %ecx,%edx
 a1e:	73 30                	jae    a50 <free+0x50>
 a20:	39 c1                	cmp    %eax,%ecx
 a22:	72 04                	jb     a28 <free+0x28>
 a24:	39 c2                	cmp    %eax,%edx
 a26:	72 f0                	jb     a18 <free+0x18>
 a28:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a2b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a2e:	39 f8                	cmp    %edi,%eax
 a30:	74 30                	je     a62 <free+0x62>
 a32:	89 43 f8             	mov    %eax,-0x8(%ebx)
 a35:	8b 42 04             	mov    0x4(%edx),%eax
 a38:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a3b:	39 f1                	cmp    %esi,%ecx
 a3d:	74 3a                	je     a79 <free+0x79>
 a3f:	89 0a                	mov    %ecx,(%edx)
 a41:	5b                   	pop    %ebx
 a42:	89 15 20 12 00 00    	mov    %edx,0x1220
 a48:	5e                   	pop    %esi
 a49:	5f                   	pop    %edi
 a4a:	5d                   	pop    %ebp
 a4b:	c3                   	ret    
 a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a50:	39 c2                	cmp    %eax,%edx
 a52:	72 c4                	jb     a18 <free+0x18>
 a54:	39 c1                	cmp    %eax,%ecx
 a56:	73 c0                	jae    a18 <free+0x18>
 a58:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a5b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a5e:	39 f8                	cmp    %edi,%eax
 a60:	75 d0                	jne    a32 <free+0x32>
 a62:	03 70 04             	add    0x4(%eax),%esi
 a65:	89 73 fc             	mov    %esi,-0x4(%ebx)
 a68:	8b 02                	mov    (%edx),%eax
 a6a:	8b 00                	mov    (%eax),%eax
 a6c:	89 43 f8             	mov    %eax,-0x8(%ebx)
 a6f:	8b 42 04             	mov    0x4(%edx),%eax
 a72:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a75:	39 f1                	cmp    %esi,%ecx
 a77:	75 c6                	jne    a3f <free+0x3f>
 a79:	03 43 fc             	add    -0x4(%ebx),%eax
 a7c:	89 15 20 12 00 00    	mov    %edx,0x1220
 a82:	89 42 04             	mov    %eax,0x4(%edx)
 a85:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 a88:	89 0a                	mov    %ecx,(%edx)
 a8a:	5b                   	pop    %ebx
 a8b:	5e                   	pop    %esi
 a8c:	5f                   	pop    %edi
 a8d:	5d                   	pop    %ebp
 a8e:	c3                   	ret    
 a8f:	90                   	nop

00000a90 <malloc>:
 a90:	55                   	push   %ebp
 a91:	89 e5                	mov    %esp,%ebp
 a93:	57                   	push   %edi
 a94:	56                   	push   %esi
 a95:	53                   	push   %ebx
 a96:	83 ec 1c             	sub    $0x1c,%esp
 a99:	8b 45 08             	mov    0x8(%ebp),%eax
 a9c:	8b 3d 20 12 00 00    	mov    0x1220,%edi
 aa2:	8d 70 07             	lea    0x7(%eax),%esi
 aa5:	c1 ee 03             	shr    $0x3,%esi
 aa8:	83 c6 01             	add    $0x1,%esi
 aab:	85 ff                	test   %edi,%edi
 aad:	0f 84 9d 00 00 00    	je     b50 <malloc+0xc0>
 ab3:	8b 17                	mov    (%edi),%edx
 ab5:	8b 4a 04             	mov    0x4(%edx),%ecx
 ab8:	39 f1                	cmp    %esi,%ecx
 aba:	73 6a                	jae    b26 <malloc+0x96>
 abc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 ac1:	39 de                	cmp    %ebx,%esi
 ac3:	0f 43 de             	cmovae %esi,%ebx
 ac6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 acd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 ad0:	eb 17                	jmp    ae9 <malloc+0x59>
 ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 ad8:	8b 02                	mov    (%edx),%eax
 ada:	8b 48 04             	mov    0x4(%eax),%ecx
 add:	39 f1                	cmp    %esi,%ecx
 adf:	73 4f                	jae    b30 <malloc+0xa0>
 ae1:	8b 3d 20 12 00 00    	mov    0x1220,%edi
 ae7:	89 c2                	mov    %eax,%edx
 ae9:	39 d7                	cmp    %edx,%edi
 aeb:	75 eb                	jne    ad8 <malloc+0x48>
 aed:	83 ec 0c             	sub    $0xc,%esp
 af0:	ff 75 e4             	push   -0x1c(%ebp)
 af3:	e8 73 fc ff ff       	call   76b <sbrk>
 af8:	83 c4 10             	add    $0x10,%esp
 afb:	83 f8 ff             	cmp    $0xffffffff,%eax
 afe:	74 1c                	je     b1c <malloc+0x8c>
 b00:	89 58 04             	mov    %ebx,0x4(%eax)
 b03:	83 ec 0c             	sub    $0xc,%esp
 b06:	83 c0 08             	add    $0x8,%eax
 b09:	50                   	push   %eax
 b0a:	e8 f1 fe ff ff       	call   a00 <free>
 b0f:	8b 15 20 12 00 00    	mov    0x1220,%edx
 b15:	83 c4 10             	add    $0x10,%esp
 b18:	85 d2                	test   %edx,%edx
 b1a:	75 bc                	jne    ad8 <malloc+0x48>
 b1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b1f:	31 c0                	xor    %eax,%eax
 b21:	5b                   	pop    %ebx
 b22:	5e                   	pop    %esi
 b23:	5f                   	pop    %edi
 b24:	5d                   	pop    %ebp
 b25:	c3                   	ret    
 b26:	89 d0                	mov    %edx,%eax
 b28:	89 fa                	mov    %edi,%edx
 b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 b30:	39 ce                	cmp    %ecx,%esi
 b32:	74 4c                	je     b80 <malloc+0xf0>
 b34:	29 f1                	sub    %esi,%ecx
 b36:	89 48 04             	mov    %ecx,0x4(%eax)
 b39:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 b3c:	89 70 04             	mov    %esi,0x4(%eax)
 b3f:	89 15 20 12 00 00    	mov    %edx,0x1220
 b45:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b48:	83 c0 08             	add    $0x8,%eax
 b4b:	5b                   	pop    %ebx
 b4c:	5e                   	pop    %esi
 b4d:	5f                   	pop    %edi
 b4e:	5d                   	pop    %ebp
 b4f:	c3                   	ret    
 b50:	c7 05 20 12 00 00 24 	movl   $0x1224,0x1220
 b57:	12 00 00 
 b5a:	bf 24 12 00 00       	mov    $0x1224,%edi
 b5f:	c7 05 24 12 00 00 24 	movl   $0x1224,0x1224
 b66:	12 00 00 
 b69:	89 fa                	mov    %edi,%edx
 b6b:	c7 05 28 12 00 00 00 	movl   $0x0,0x1228
 b72:	00 00 00 
 b75:	e9 42 ff ff ff       	jmp    abc <malloc+0x2c>
 b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 b80:	8b 08                	mov    (%eax),%ecx
 b82:	89 0a                	mov    %ecx,(%edx)
 b84:	eb b9                	jmp    b3f <malloc+0xaf>
