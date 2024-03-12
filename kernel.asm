
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc d0 c6 11 80       	mov    $0x8011c6d0,%esp
8010002d:	b8 60 30 10 80       	mov    $0x80103060,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 c5 10 80       	mov    $0x8010c554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 e0 83 10 80       	push   $0x801083e0
80100051:	68 20 c5 10 80       	push   $0x8010c520
80100056:	e8 15 46 00 00       	call   80104670 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c 0c 11 80       	mov    $0x80110c1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c 0c 11 80 1c 	movl   $0x80110c1c,0x80110c6c
8010006a:	0c 11 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 0c 11 80 1c 	movl   $0x80110c1c,0x80110c70
80100074:	0c 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c 0c 11 80 	movl   $0x80110c1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 e7 83 10 80       	push   $0x801083e7
80100097:	50                   	push   %eax
80100098:	e8 a3 44 00 00       	call   80104540 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 0c 11 80       	mov    0x80110c70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 0c 11 80    	mov    %ebx,0x80110c70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 09 11 80    	cmp    $0x801109c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 c5 10 80       	push   $0x8010c520
801000e4:	e8 57 47 00 00       	call   80104840 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 0c 11 80    	mov    0x80110c70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c 0c 11 80    	cmp    $0x80110c1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c 0c 11 80    	cmp    $0x80110c1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c 0c 11 80    	mov    0x80110c6c,%ebx
80100126:	81 fb 1c 0c 11 80    	cmp    $0x80110c1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c 0c 11 80    	cmp    $0x80110c1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 c5 10 80       	push   $0x8010c520
80100162:	e8 79 46 00 00       	call   801047e0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 0e 44 00 00       	call   80104580 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 4f 21 00 00       	call   801022e0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 ee 83 10 80       	push   $0x801083ee
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 5d 44 00 00       	call   80104620 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
  iderw(b);
801001d4:	e9 07 21 00 00       	jmp    801022e0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 ff 83 10 80       	push   $0x801083ff
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 1c 44 00 00       	call   80104620 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 cc 43 00 00       	call   801045e0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010021b:	e8 20 46 00 00       	call   80104840 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 70 0c 11 80       	mov    0x80110c70,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 1c 0c 11 80 	movl   $0x80110c1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 70 0c 11 80       	mov    0x80110c70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 70 0c 11 80    	mov    %ebx,0x80110c70
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 20 c5 10 80 	movl   $0x8010c520,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 6f 45 00 00       	jmp    801047e0 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 06 84 10 80       	push   $0x80108406
80100279:	e8 02 01 00 00       	call   80100380 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 c7 15 00 00       	call   80101860 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 0f 11 80 	movl   $0x80110f20,(%esp)
801002a0:	e8 9b 45 00 00       	call   80104840 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 0f 11 80       	mov    0x80110f00,%eax
801002b5:	3b 05 04 0f 11 80    	cmp    0x80110f04,%eax
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 0f 11 80       	push   $0x80110f20
801002c8:	68 00 0f 11 80       	push   $0x80110f00
801002cd:	e8 0e 40 00 00       	call   801042e0 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 0f 11 80       	mov    0x80110f00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 0f 11 80    	cmp    0x80110f04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 e9 36 00 00       	call   801039d0 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 0f 11 80       	push   $0x80110f20
801002f6:	e8 e5 44 00 00       	call   801047e0 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 7c 14 00 00       	call   80101780 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret    
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 0f 11 80    	mov    %edx,0x80110f00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 0e 11 80 	movsbl -0x7feef180(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 0f 11 80       	push   $0x80110f20
8010034c:	e8 8f 44 00 00       	call   801047e0 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 26 14 00 00       	call   80101780 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret    
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 00 0f 11 80       	mov    %eax,0x80110f00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli    
  cons.locking = 0;
80100389:	c7 05 54 0f 11 80 00 	movl   $0x0,0x80110f54
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 52 25 00 00       	call   801028f0 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 0d 84 10 80       	push   $0x8010840d
801003a7:	e8 f4 02 00 00       	call   801006a0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 eb 02 00 00       	call   801006a0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 18 8f 10 80 	movl   $0x80108f18,(%esp)
801003bc:	e8 df 02 00 00       	call   801006a0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 c3 42 00 00       	call   80104690 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 21 84 10 80       	push   $0x80108421
801003dd:	e8 be 02 00 00       	call   801006a0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 0f 11 80 01 	movl   $0x1,0x80110f58
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 ea 00 00 00    	je     80100500 <consputc.part.0+0x100>
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 21 5e 00 00       	call   80106240 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100441:	c1 e1 08             	shl    $0x8,%ecx
80100444:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100445:	89 f2                	mov    %esi,%edx
80100447:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100448:	0f b6 c0             	movzbl %al,%eax
8010044b:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010044d:	83 fb 0a             	cmp    $0xa,%ebx
80100450:	0f 84 92 00 00 00    	je     801004e8 <consputc.part.0+0xe8>
  else if(c == BACKSPACE){
80100456:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045c:	74 72                	je     801004d0 <consputc.part.0+0xd0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010045e:	0f b6 db             	movzbl %bl,%ebx
80100461:	8d 70 01             	lea    0x1(%eax),%esi
80100464:	80 cf 07             	or     $0x7,%bh
80100467:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
8010046e:	80 
  if(pos < 0 || pos > 25*80)
8010046f:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100475:	0f 8f fb 00 00 00    	jg     80100576 <consputc.part.0+0x176>
  if((pos/80) >= 24){  // Scroll up.
8010047b:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100481:	0f 8f a9 00 00 00    	jg     80100530 <consputc.part.0+0x130>
  outb(CRTPORT+1, pos>>8);
80100487:	89 f0                	mov    %esi,%eax
  crt[pos] = ' ' | 0x0700;
80100489:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
80100490:	88 45 e7             	mov    %al,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
80100493:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100496:	bb d4 03 00 00       	mov    $0x3d4,%ebx
8010049b:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a0:	89 da                	mov    %ebx,%edx
801004a2:	ee                   	out    %al,(%dx)
801004a3:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004a8:	89 f8                	mov    %edi,%eax
801004aa:	89 ca                	mov    %ecx,%edx
801004ac:	ee                   	out    %al,(%dx)
801004ad:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b2:	89 da                	mov    %ebx,%edx
801004b4:	ee                   	out    %al,(%dx)
801004b5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004b9:	89 ca                	mov    %ecx,%edx
801004bb:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004bc:	b8 20 07 00 00       	mov    $0x720,%eax
801004c1:	66 89 06             	mov    %ax,(%esi)
}
801004c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c7:	5b                   	pop    %ebx
801004c8:	5e                   	pop    %esi
801004c9:	5f                   	pop    %edi
801004ca:	5d                   	pop    %ebp
801004cb:	c3                   	ret    
801004cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pos > 0) --pos;
801004d0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004d3:	85 c0                	test   %eax,%eax
801004d5:	75 98                	jne    8010046f <consputc.part.0+0x6f>
801004d7:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004db:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004e0:	31 ff                	xor    %edi,%edi
801004e2:	eb b2                	jmp    80100496 <consputc.part.0+0x96>
801004e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004e8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004ed:	f7 e2                	mul    %edx
801004ef:	c1 ea 06             	shr    $0x6,%edx
801004f2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004f5:	c1 e0 04             	shl    $0x4,%eax
801004f8:	8d 70 50             	lea    0x50(%eax),%esi
801004fb:	e9 6f ff ff ff       	jmp    8010046f <consputc.part.0+0x6f>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100500:	83 ec 0c             	sub    $0xc,%esp
80100503:	6a 08                	push   $0x8
80100505:	e8 36 5d 00 00       	call   80106240 <uartputc>
8010050a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100511:	e8 2a 5d 00 00       	call   80106240 <uartputc>
80100516:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051d:	e8 1e 5d 00 00       	call   80106240 <uartputc>
80100522:	83 c4 10             	add    $0x10,%esp
80100525:	e9 f8 fe ff ff       	jmp    80100422 <consputc.part.0+0x22>
8010052a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100530:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100533:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100536:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
8010053d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100542:	68 60 0e 00 00       	push   $0xe60
80100547:	68 a0 80 0b 80       	push   $0x800b80a0
8010054c:	68 00 80 0b 80       	push   $0x800b8000
80100551:	e8 4a 44 00 00       	call   801049a0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100556:	b8 80 07 00 00       	mov    $0x780,%eax
8010055b:	83 c4 0c             	add    $0xc,%esp
8010055e:	29 d8                	sub    %ebx,%eax
80100560:	01 c0                	add    %eax,%eax
80100562:	50                   	push   %eax
80100563:	6a 00                	push   $0x0
80100565:	56                   	push   %esi
80100566:	e8 95 43 00 00       	call   80104900 <memset>
  outb(CRTPORT+1, pos);
8010056b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010056e:	83 c4 10             	add    $0x10,%esp
80100571:	e9 20 ff ff ff       	jmp    80100496 <consputc.part.0+0x96>
    panic("pos under/overflow");
80100576:	83 ec 0c             	sub    $0xc,%esp
80100579:	68 25 84 10 80       	push   $0x80108425
8010057e:	e8 fd fd ff ff       	call   80100380 <panic>
80100583:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010058a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100590 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100590:	55                   	push   %ebp
80100591:	89 e5                	mov    %esp,%ebp
80100593:	57                   	push   %edi
80100594:	56                   	push   %esi
80100595:	53                   	push   %ebx
80100596:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100599:	ff 75 08             	push   0x8(%ebp)
{
8010059c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010059f:	e8 bc 12 00 00       	call   80101860 <iunlock>
  acquire(&cons.lock);
801005a4:	c7 04 24 20 0f 11 80 	movl   $0x80110f20,(%esp)
801005ab:	e8 90 42 00 00       	call   80104840 <acquire>
  for(i = 0; i < n; i++)
801005b0:	83 c4 10             	add    $0x10,%esp
801005b3:	85 f6                	test   %esi,%esi
801005b5:	7e 25                	jle    801005dc <consolewrite+0x4c>
801005b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005ba:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005bd:	8b 15 58 0f 11 80    	mov    0x80110f58,%edx
    consputc(buf[i] & 0xff);
801005c3:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801005c6:	85 d2                	test   %edx,%edx
801005c8:	74 06                	je     801005d0 <consolewrite+0x40>
  asm volatile("cli");
801005ca:	fa                   	cli    
    for(;;)
801005cb:	eb fe                	jmp    801005cb <consolewrite+0x3b>
801005cd:	8d 76 00             	lea    0x0(%esi),%esi
801005d0:	e8 2b fe ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
801005d5:	83 c3 01             	add    $0x1,%ebx
801005d8:	39 df                	cmp    %ebx,%edi
801005da:	75 e1                	jne    801005bd <consolewrite+0x2d>
  release(&cons.lock);
801005dc:	83 ec 0c             	sub    $0xc,%esp
801005df:	68 20 0f 11 80       	push   $0x80110f20
801005e4:	e8 f7 41 00 00       	call   801047e0 <release>
  ilock(ip);
801005e9:	58                   	pop    %eax
801005ea:	ff 75 08             	push   0x8(%ebp)
801005ed:	e8 8e 11 00 00       	call   80101780 <ilock>

  return n;
}
801005f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005f5:	89 f0                	mov    %esi,%eax
801005f7:	5b                   	pop    %ebx
801005f8:	5e                   	pop    %esi
801005f9:	5f                   	pop    %edi
801005fa:	5d                   	pop    %ebp
801005fb:	c3                   	ret    
801005fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100600 <printint>:
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 2c             	sub    $0x2c,%esp
80100609:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010060c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
8010060f:	85 c9                	test   %ecx,%ecx
80100611:	74 04                	je     80100617 <printint+0x17>
80100613:	85 c0                	test   %eax,%eax
80100615:	78 6d                	js     80100684 <printint+0x84>
    x = xx;
80100617:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010061e:	89 c1                	mov    %eax,%ecx
  i = 0;
80100620:	31 db                	xor    %ebx,%ebx
80100622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
80100628:	89 c8                	mov    %ecx,%eax
8010062a:	31 d2                	xor    %edx,%edx
8010062c:	89 de                	mov    %ebx,%esi
8010062e:	89 cf                	mov    %ecx,%edi
80100630:	f7 75 d4             	divl   -0x2c(%ebp)
80100633:	8d 5b 01             	lea    0x1(%ebx),%ebx
80100636:	0f b6 92 50 84 10 80 	movzbl -0x7fef7bb0(%edx),%edx
  }while((x /= base) != 0);
8010063d:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
8010063f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100643:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
80100646:	73 e0                	jae    80100628 <printint+0x28>
  if(sign)
80100648:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010064b:	85 c9                	test   %ecx,%ecx
8010064d:	74 0c                	je     8010065b <printint+0x5b>
    buf[i++] = '-';
8010064f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
80100654:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
80100656:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
8010065b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
8010065f:	0f be c2             	movsbl %dl,%eax
  if(panicked){
80100662:	8b 15 58 0f 11 80    	mov    0x80110f58,%edx
80100668:	85 d2                	test   %edx,%edx
8010066a:	74 04                	je     80100670 <printint+0x70>
8010066c:	fa                   	cli    
    for(;;)
8010066d:	eb fe                	jmp    8010066d <printint+0x6d>
8010066f:	90                   	nop
80100670:	e8 8b fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
80100675:	8d 45 d7             	lea    -0x29(%ebp),%eax
80100678:	39 c3                	cmp    %eax,%ebx
8010067a:	74 0e                	je     8010068a <printint+0x8a>
    consputc(buf[i]);
8010067c:	0f be 03             	movsbl (%ebx),%eax
8010067f:	83 eb 01             	sub    $0x1,%ebx
80100682:	eb de                	jmp    80100662 <printint+0x62>
    x = -xx;
80100684:	f7 d8                	neg    %eax
80100686:	89 c1                	mov    %eax,%ecx
80100688:	eb 96                	jmp    80100620 <printint+0x20>
}
8010068a:	83 c4 2c             	add    $0x2c,%esp
8010068d:	5b                   	pop    %ebx
8010068e:	5e                   	pop    %esi
8010068f:	5f                   	pop    %edi
80100690:	5d                   	pop    %ebp
80100691:	c3                   	ret    
80100692:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801006a0 <cprintf>:
{
801006a0:	55                   	push   %ebp
801006a1:	89 e5                	mov    %esp,%ebp
801006a3:	57                   	push   %edi
801006a4:	56                   	push   %esi
801006a5:	53                   	push   %ebx
801006a6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006a9:	a1 54 0f 11 80       	mov    0x80110f54,%eax
801006ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
801006b1:	85 c0                	test   %eax,%eax
801006b3:	0f 85 27 01 00 00    	jne    801007e0 <cprintf+0x140>
  if (fmt == 0)
801006b9:	8b 75 08             	mov    0x8(%ebp),%esi
801006bc:	85 f6                	test   %esi,%esi
801006be:	0f 84 ac 01 00 00    	je     80100870 <cprintf+0x1d0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006c4:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint*)(void*)(&fmt + 1);
801006c7:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006ca:	31 db                	xor    %ebx,%ebx
801006cc:	85 c0                	test   %eax,%eax
801006ce:	74 56                	je     80100726 <cprintf+0x86>
    if(c != '%'){
801006d0:	83 f8 25             	cmp    $0x25,%eax
801006d3:	0f 85 cf 00 00 00    	jne    801007a8 <cprintf+0x108>
    c = fmt[++i] & 0xff;
801006d9:	83 c3 01             	add    $0x1,%ebx
801006dc:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
801006e0:	85 d2                	test   %edx,%edx
801006e2:	74 42                	je     80100726 <cprintf+0x86>
    switch(c){
801006e4:	83 fa 70             	cmp    $0x70,%edx
801006e7:	0f 84 90 00 00 00    	je     8010077d <cprintf+0xdd>
801006ed:	7f 51                	jg     80100740 <cprintf+0xa0>
801006ef:	83 fa 25             	cmp    $0x25,%edx
801006f2:	0f 84 c0 00 00 00    	je     801007b8 <cprintf+0x118>
801006f8:	83 fa 64             	cmp    $0x64,%edx
801006fb:	0f 85 f4 00 00 00    	jne    801007f5 <cprintf+0x155>
      printint(*argp++, 10, 1);
80100701:	8d 47 04             	lea    0x4(%edi),%eax
80100704:	b9 01 00 00 00       	mov    $0x1,%ecx
80100709:	ba 0a 00 00 00       	mov    $0xa,%edx
8010070e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100711:	8b 07                	mov    (%edi),%eax
80100713:	e8 e8 fe ff ff       	call   80100600 <printint>
80100718:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010071b:	83 c3 01             	add    $0x1,%ebx
8010071e:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100722:	85 c0                	test   %eax,%eax
80100724:	75 aa                	jne    801006d0 <cprintf+0x30>
  if(locking)
80100726:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100729:	85 c0                	test   %eax,%eax
8010072b:	0f 85 22 01 00 00    	jne    80100853 <cprintf+0x1b3>
}
80100731:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100734:	5b                   	pop    %ebx
80100735:	5e                   	pop    %esi
80100736:	5f                   	pop    %edi
80100737:	5d                   	pop    %ebp
80100738:	c3                   	ret    
80100739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100740:	83 fa 73             	cmp    $0x73,%edx
80100743:	75 33                	jne    80100778 <cprintf+0xd8>
      if((s = (char*)*argp++) == 0)
80100745:	8d 47 04             	lea    0x4(%edi),%eax
80100748:	8b 3f                	mov    (%edi),%edi
8010074a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010074d:	85 ff                	test   %edi,%edi
8010074f:	0f 84 e3 00 00 00    	je     80100838 <cprintf+0x198>
      for(; *s; s++)
80100755:	0f be 07             	movsbl (%edi),%eax
80100758:	84 c0                	test   %al,%al
8010075a:	0f 84 08 01 00 00    	je     80100868 <cprintf+0x1c8>
  if(panicked){
80100760:	8b 15 58 0f 11 80    	mov    0x80110f58,%edx
80100766:	85 d2                	test   %edx,%edx
80100768:	0f 84 b2 00 00 00    	je     80100820 <cprintf+0x180>
8010076e:	fa                   	cli    
    for(;;)
8010076f:	eb fe                	jmp    8010076f <cprintf+0xcf>
80100771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100778:	83 fa 78             	cmp    $0x78,%edx
8010077b:	75 78                	jne    801007f5 <cprintf+0x155>
      printint(*argp++, 16, 0);
8010077d:	8d 47 04             	lea    0x4(%edi),%eax
80100780:	31 c9                	xor    %ecx,%ecx
80100782:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100787:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
8010078a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010078d:	8b 07                	mov    (%edi),%eax
8010078f:	e8 6c fe ff ff       	call   80100600 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100794:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
80100798:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010079b:	85 c0                	test   %eax,%eax
8010079d:	0f 85 2d ff ff ff    	jne    801006d0 <cprintf+0x30>
801007a3:	eb 81                	jmp    80100726 <cprintf+0x86>
801007a5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007a8:	8b 0d 58 0f 11 80    	mov    0x80110f58,%ecx
801007ae:	85 c9                	test   %ecx,%ecx
801007b0:	74 14                	je     801007c6 <cprintf+0x126>
801007b2:	fa                   	cli    
    for(;;)
801007b3:	eb fe                	jmp    801007b3 <cprintf+0x113>
801007b5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007b8:	a1 58 0f 11 80       	mov    0x80110f58,%eax
801007bd:	85 c0                	test   %eax,%eax
801007bf:	75 6c                	jne    8010082d <cprintf+0x18d>
801007c1:	b8 25 00 00 00       	mov    $0x25,%eax
801007c6:	e8 35 fc ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007cb:	83 c3 01             	add    $0x1,%ebx
801007ce:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801007d2:	85 c0                	test   %eax,%eax
801007d4:	0f 85 f6 fe ff ff    	jne    801006d0 <cprintf+0x30>
801007da:	e9 47 ff ff ff       	jmp    80100726 <cprintf+0x86>
801007df:	90                   	nop
    acquire(&cons.lock);
801007e0:	83 ec 0c             	sub    $0xc,%esp
801007e3:	68 20 0f 11 80       	push   $0x80110f20
801007e8:	e8 53 40 00 00       	call   80104840 <acquire>
801007ed:	83 c4 10             	add    $0x10,%esp
801007f0:	e9 c4 fe ff ff       	jmp    801006b9 <cprintf+0x19>
  if(panicked){
801007f5:	8b 0d 58 0f 11 80    	mov    0x80110f58,%ecx
801007fb:	85 c9                	test   %ecx,%ecx
801007fd:	75 31                	jne    80100830 <cprintf+0x190>
801007ff:	b8 25 00 00 00       	mov    $0x25,%eax
80100804:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100807:	e8 f4 fb ff ff       	call   80100400 <consputc.part.0>
8010080c:	8b 15 58 0f 11 80    	mov    0x80110f58,%edx
80100812:	85 d2                	test   %edx,%edx
80100814:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100817:	74 2e                	je     80100847 <cprintf+0x1a7>
80100819:	fa                   	cli    
    for(;;)
8010081a:	eb fe                	jmp    8010081a <cprintf+0x17a>
8010081c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100820:	e8 db fb ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
80100825:	83 c7 01             	add    $0x1,%edi
80100828:	e9 28 ff ff ff       	jmp    80100755 <cprintf+0xb5>
8010082d:	fa                   	cli    
    for(;;)
8010082e:	eb fe                	jmp    8010082e <cprintf+0x18e>
80100830:	fa                   	cli    
80100831:	eb fe                	jmp    80100831 <cprintf+0x191>
80100833:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100837:	90                   	nop
        s = "(null)";
80100838:	bf 38 84 10 80       	mov    $0x80108438,%edi
      for(; *s; s++)
8010083d:	b8 28 00 00 00       	mov    $0x28,%eax
80100842:	e9 19 ff ff ff       	jmp    80100760 <cprintf+0xc0>
80100847:	89 d0                	mov    %edx,%eax
80100849:	e8 b2 fb ff ff       	call   80100400 <consputc.part.0>
8010084e:	e9 c8 fe ff ff       	jmp    8010071b <cprintf+0x7b>
    release(&cons.lock);
80100853:	83 ec 0c             	sub    $0xc,%esp
80100856:	68 20 0f 11 80       	push   $0x80110f20
8010085b:	e8 80 3f 00 00       	call   801047e0 <release>
80100860:	83 c4 10             	add    $0x10,%esp
}
80100863:	e9 c9 fe ff ff       	jmp    80100731 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
80100868:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010086b:	e9 ab fe ff ff       	jmp    8010071b <cprintf+0x7b>
    panic("null fmt");
80100870:	83 ec 0c             	sub    $0xc,%esp
80100873:	68 3f 84 10 80       	push   $0x8010843f
80100878:	e8 03 fb ff ff       	call   80100380 <panic>
8010087d:	8d 76 00             	lea    0x0(%esi),%esi

80100880 <consoleintr>:
{
80100880:	55                   	push   %ebp
80100881:	89 e5                	mov    %esp,%ebp
80100883:	57                   	push   %edi
80100884:	56                   	push   %esi
  int c, doprocdump = 0;
80100885:	31 f6                	xor    %esi,%esi
{
80100887:	53                   	push   %ebx
80100888:	83 ec 18             	sub    $0x18,%esp
8010088b:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
8010088e:	68 20 0f 11 80       	push   $0x80110f20
80100893:	e8 a8 3f 00 00       	call   80104840 <acquire>
  while((c = getc()) >= 0){
80100898:	83 c4 10             	add    $0x10,%esp
8010089b:	eb 1a                	jmp    801008b7 <consoleintr+0x37>
8010089d:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
801008a0:	83 fb 08             	cmp    $0x8,%ebx
801008a3:	0f 84 d7 00 00 00    	je     80100980 <consoleintr+0x100>
801008a9:	83 fb 10             	cmp    $0x10,%ebx
801008ac:	0f 85 32 01 00 00    	jne    801009e4 <consoleintr+0x164>
801008b2:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
801008b7:	ff d7                	call   *%edi
801008b9:	89 c3                	mov    %eax,%ebx
801008bb:	85 c0                	test   %eax,%eax
801008bd:	0f 88 05 01 00 00    	js     801009c8 <consoleintr+0x148>
    switch(c){
801008c3:	83 fb 15             	cmp    $0x15,%ebx
801008c6:	74 78                	je     80100940 <consoleintr+0xc0>
801008c8:	7e d6                	jle    801008a0 <consoleintr+0x20>
801008ca:	83 fb 7f             	cmp    $0x7f,%ebx
801008cd:	0f 84 ad 00 00 00    	je     80100980 <consoleintr+0x100>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008d3:	a1 08 0f 11 80       	mov    0x80110f08,%eax
801008d8:	89 c2                	mov    %eax,%edx
801008da:	2b 15 00 0f 11 80    	sub    0x80110f00,%edx
801008e0:	83 fa 7f             	cmp    $0x7f,%edx
801008e3:	77 d2                	ja     801008b7 <consoleintr+0x37>
        input.buf[input.e++ % INPUT_BUF] = c;
801008e5:	8d 48 01             	lea    0x1(%eax),%ecx
  if(panicked){
801008e8:	8b 15 58 0f 11 80    	mov    0x80110f58,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
801008ee:	83 e0 7f             	and    $0x7f,%eax
801008f1:	89 0d 08 0f 11 80    	mov    %ecx,0x80110f08
        c = (c == '\r') ? '\n' : c;
801008f7:	83 fb 0d             	cmp    $0xd,%ebx
801008fa:	0f 84 13 01 00 00    	je     80100a13 <consoleintr+0x193>
        input.buf[input.e++ % INPUT_BUF] = c;
80100900:	88 98 80 0e 11 80    	mov    %bl,-0x7feef180(%eax)
  if(panicked){
80100906:	85 d2                	test   %edx,%edx
80100908:	0f 85 10 01 00 00    	jne    80100a1e <consoleintr+0x19e>
8010090e:	89 d8                	mov    %ebx,%eax
80100910:	e8 eb fa ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100915:	83 fb 0a             	cmp    $0xa,%ebx
80100918:	0f 84 14 01 00 00    	je     80100a32 <consoleintr+0x1b2>
8010091e:	83 fb 04             	cmp    $0x4,%ebx
80100921:	0f 84 0b 01 00 00    	je     80100a32 <consoleintr+0x1b2>
80100927:	a1 00 0f 11 80       	mov    0x80110f00,%eax
8010092c:	83 e8 80             	sub    $0xffffff80,%eax
8010092f:	39 05 08 0f 11 80    	cmp    %eax,0x80110f08
80100935:	75 80                	jne    801008b7 <consoleintr+0x37>
80100937:	e9 fb 00 00 00       	jmp    80100a37 <consoleintr+0x1b7>
8010093c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
80100940:	a1 08 0f 11 80       	mov    0x80110f08,%eax
80100945:	39 05 04 0f 11 80    	cmp    %eax,0x80110f04
8010094b:	0f 84 66 ff ff ff    	je     801008b7 <consoleintr+0x37>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100951:	83 e8 01             	sub    $0x1,%eax
80100954:	89 c2                	mov    %eax,%edx
80100956:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100959:	80 ba 80 0e 11 80 0a 	cmpb   $0xa,-0x7feef180(%edx)
80100960:	0f 84 51 ff ff ff    	je     801008b7 <consoleintr+0x37>
  if(panicked){
80100966:	8b 15 58 0f 11 80    	mov    0x80110f58,%edx
        input.e--;
8010096c:	a3 08 0f 11 80       	mov    %eax,0x80110f08
  if(panicked){
80100971:	85 d2                	test   %edx,%edx
80100973:	74 33                	je     801009a8 <consoleintr+0x128>
80100975:	fa                   	cli    
    for(;;)
80100976:	eb fe                	jmp    80100976 <consoleintr+0xf6>
80100978:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010097f:	90                   	nop
      if(input.e != input.w){
80100980:	a1 08 0f 11 80       	mov    0x80110f08,%eax
80100985:	3b 05 04 0f 11 80    	cmp    0x80110f04,%eax
8010098b:	0f 84 26 ff ff ff    	je     801008b7 <consoleintr+0x37>
        input.e--;
80100991:	83 e8 01             	sub    $0x1,%eax
80100994:	a3 08 0f 11 80       	mov    %eax,0x80110f08
  if(panicked){
80100999:	a1 58 0f 11 80       	mov    0x80110f58,%eax
8010099e:	85 c0                	test   %eax,%eax
801009a0:	74 56                	je     801009f8 <consoleintr+0x178>
801009a2:	fa                   	cli    
    for(;;)
801009a3:	eb fe                	jmp    801009a3 <consoleintr+0x123>
801009a5:	8d 76 00             	lea    0x0(%esi),%esi
801009a8:	b8 00 01 00 00       	mov    $0x100,%eax
801009ad:	e8 4e fa ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
801009b2:	a1 08 0f 11 80       	mov    0x80110f08,%eax
801009b7:	3b 05 04 0f 11 80    	cmp    0x80110f04,%eax
801009bd:	75 92                	jne    80100951 <consoleintr+0xd1>
801009bf:	e9 f3 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
801009c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
801009c8:	83 ec 0c             	sub    $0xc,%esp
801009cb:	68 20 0f 11 80       	push   $0x80110f20
801009d0:	e8 0b 3e 00 00       	call   801047e0 <release>
  if(doprocdump) {
801009d5:	83 c4 10             	add    $0x10,%esp
801009d8:	85 f6                	test   %esi,%esi
801009da:	75 2b                	jne    80100a07 <consoleintr+0x187>
}
801009dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009df:	5b                   	pop    %ebx
801009e0:	5e                   	pop    %esi
801009e1:	5f                   	pop    %edi
801009e2:	5d                   	pop    %ebp
801009e3:	c3                   	ret    
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009e4:	85 db                	test   %ebx,%ebx
801009e6:	0f 84 cb fe ff ff    	je     801008b7 <consoleintr+0x37>
801009ec:	e9 e2 fe ff ff       	jmp    801008d3 <consoleintr+0x53>
801009f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801009f8:	b8 00 01 00 00       	mov    $0x100,%eax
801009fd:	e8 fe f9 ff ff       	call   80100400 <consputc.part.0>
80100a02:	e9 b0 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
}
80100a07:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a0a:	5b                   	pop    %ebx
80100a0b:	5e                   	pop    %esi
80100a0c:	5f                   	pop    %edi
80100a0d:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a0e:	e9 6d 3a 00 00       	jmp    80104480 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a13:	c6 80 80 0e 11 80 0a 	movb   $0xa,-0x7feef180(%eax)
  if(panicked){
80100a1a:	85 d2                	test   %edx,%edx
80100a1c:	74 0a                	je     80100a28 <consoleintr+0x1a8>
80100a1e:	fa                   	cli    
    for(;;)
80100a1f:	eb fe                	jmp    80100a1f <consoleintr+0x19f>
80100a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a28:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a2d:	e8 ce f9 ff ff       	call   80100400 <consputc.part.0>
          input.w = input.e;
80100a32:	a1 08 0f 11 80       	mov    0x80110f08,%eax
          wakeup(&input.r);
80100a37:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a3a:	a3 04 0f 11 80       	mov    %eax,0x80110f04
          wakeup(&input.r);
80100a3f:	68 00 0f 11 80       	push   $0x80110f00
80100a44:	e8 57 39 00 00       	call   801043a0 <wakeup>
80100a49:	83 c4 10             	add    $0x10,%esp
80100a4c:	e9 66 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
80100a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a5f:	90                   	nop

80100a60 <consoleinit>:

void
consoleinit(void)
{
80100a60:	55                   	push   %ebp
80100a61:	89 e5                	mov    %esp,%ebp
80100a63:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a66:	68 48 84 10 80       	push   $0x80108448
80100a6b:	68 20 0f 11 80       	push   $0x80110f20
80100a70:	e8 fb 3b 00 00       	call   80104670 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a75:	58                   	pop    %eax
80100a76:	5a                   	pop    %edx
80100a77:	6a 00                	push   $0x0
80100a79:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a7b:	c7 05 0c 19 11 80 90 	movl   $0x80100590,0x8011190c
80100a82:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100a85:	c7 05 08 19 11 80 80 	movl   $0x80100280,0x80111908
80100a8c:	02 10 80 
  cons.locking = 1;
80100a8f:	c7 05 54 0f 11 80 01 	movl   $0x1,0x80110f54
80100a96:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100a99:	e8 e2 19 00 00       	call   80102480 <ioapicenable>
}
80100a9e:	83 c4 10             	add    $0x10,%esp
80100aa1:	c9                   	leave  
80100aa2:	c3                   	ret    
80100aa3:	66 90                	xchg   %ax,%ax
80100aa5:	66 90                	xchg   %ax,%ax
80100aa7:	66 90                	xchg   %ax,%ax
80100aa9:	66 90                	xchg   %ax,%ax
80100aab:	66 90                	xchg   %ax,%ax
80100aad:	66 90                	xchg   %ax,%ax
80100aaf:	90                   	nop

80100ab0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100ab0:	55                   	push   %ebp
80100ab1:	89 e5                	mov    %esp,%ebp
80100ab3:	57                   	push   %edi
80100ab4:	56                   	push   %esi
80100ab5:	53                   	push   %ebx
80100ab6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100abc:	e8 0f 2f 00 00       	call   801039d0 <myproc>
80100ac1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100ac7:	e8 94 22 00 00       	call   80102d60 <begin_op>

  if((ip = namei(path)) == 0){
80100acc:	83 ec 0c             	sub    $0xc,%esp
80100acf:	ff 75 08             	push   0x8(%ebp)
80100ad2:	e8 c9 15 00 00       	call   801020a0 <namei>
80100ad7:	83 c4 10             	add    $0x10,%esp
80100ada:	85 c0                	test   %eax,%eax
80100adc:	0f 84 02 03 00 00    	je     80100de4 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ae2:	83 ec 0c             	sub    $0xc,%esp
80100ae5:	89 c3                	mov    %eax,%ebx
80100ae7:	50                   	push   %eax
80100ae8:	e8 93 0c 00 00       	call   80101780 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100aed:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100af3:	6a 34                	push   $0x34
80100af5:	6a 00                	push   $0x0
80100af7:	50                   	push   %eax
80100af8:	53                   	push   %ebx
80100af9:	e8 92 0f 00 00       	call   80101a90 <readi>
80100afe:	83 c4 20             	add    $0x20,%esp
80100b01:	83 f8 34             	cmp    $0x34,%eax
80100b04:	74 22                	je     80100b28 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100b06:	83 ec 0c             	sub    $0xc,%esp
80100b09:	53                   	push   %ebx
80100b0a:	e8 01 0f 00 00       	call   80101a10 <iunlockput>
    end_op();
80100b0f:	e8 bc 22 00 00       	call   80102dd0 <end_op>
80100b14:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100b17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100b1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b1f:	5b                   	pop    %ebx
80100b20:	5e                   	pop    %esi
80100b21:	5f                   	pop    %edi
80100b22:	5d                   	pop    %ebp
80100b23:	c3                   	ret    
80100b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100b28:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b2f:	45 4c 46 
80100b32:	75 d2                	jne    80100b06 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100b34:	e8 27 69 00 00       	call   80107460 <setupkvm>
80100b39:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b3f:	85 c0                	test   %eax,%eax
80100b41:	74 c3                	je     80100b06 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b43:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b4a:	00 
80100b4b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b51:	0f 84 ac 02 00 00    	je     80100e03 <exec+0x353>
  sz = 0;
80100b57:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b5e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b61:	31 ff                	xor    %edi,%edi
80100b63:	e9 8e 00 00 00       	jmp    80100bf6 <exec+0x146>
80100b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b6f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80100b70:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b77:	75 6c                	jne    80100be5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100b79:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b7f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b85:	0f 82 87 00 00 00    	jb     80100c12 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b8b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b91:	72 7f                	jb     80100c12 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b93:	83 ec 04             	sub    $0x4,%esp
80100b96:	50                   	push   %eax
80100b97:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100b9d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100ba3:	e8 d8 66 00 00       	call   80107280 <allocuvm>
80100ba8:	83 c4 10             	add    $0x10,%esp
80100bab:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100bb1:	85 c0                	test   %eax,%eax
80100bb3:	74 5d                	je     80100c12 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100bb5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bbb:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bc0:	75 50                	jne    80100c12 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bc2:	83 ec 0c             	sub    $0xc,%esp
80100bc5:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100bcb:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100bd1:	53                   	push   %ebx
80100bd2:	50                   	push   %eax
80100bd3:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100bd9:	e8 b2 65 00 00       	call   80107190 <loaduvm>
80100bde:	83 c4 20             	add    $0x20,%esp
80100be1:	85 c0                	test   %eax,%eax
80100be3:	78 2d                	js     80100c12 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100be5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bec:	83 c7 01             	add    $0x1,%edi
80100bef:	83 c6 20             	add    $0x20,%esi
80100bf2:	39 f8                	cmp    %edi,%eax
80100bf4:	7e 3a                	jle    80100c30 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bf6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bfc:	6a 20                	push   $0x20
80100bfe:	56                   	push   %esi
80100bff:	50                   	push   %eax
80100c00:	53                   	push   %ebx
80100c01:	e8 8a 0e 00 00       	call   80101a90 <readi>
80100c06:	83 c4 10             	add    $0x10,%esp
80100c09:	83 f8 20             	cmp    $0x20,%eax
80100c0c:	0f 84 5e ff ff ff    	je     80100b70 <exec+0xc0>
    freevm(pgdir);
80100c12:	83 ec 0c             	sub    $0xc,%esp
80100c15:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c1b:	e8 c0 67 00 00       	call   801073e0 <freevm>
  if(ip){
80100c20:	83 c4 10             	add    $0x10,%esp
80100c23:	e9 de fe ff ff       	jmp    80100b06 <exec+0x56>
80100c28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c2f:	90                   	nop
  sz = PGROUNDUP(sz);
80100c30:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100c36:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100c3c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c42:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c48:	83 ec 0c             	sub    $0xc,%esp
80100c4b:	53                   	push   %ebx
80100c4c:	e8 bf 0d 00 00       	call   80101a10 <iunlockput>
  end_op();
80100c51:	e8 7a 21 00 00       	call   80102dd0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c56:	83 c4 0c             	add    $0xc,%esp
80100c59:	56                   	push   %esi
80100c5a:	57                   	push   %edi
80100c5b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c61:	57                   	push   %edi
80100c62:	e8 19 66 00 00       	call   80107280 <allocuvm>
80100c67:	83 c4 10             	add    $0x10,%esp
80100c6a:	89 c6                	mov    %eax,%esi
80100c6c:	85 c0                	test   %eax,%eax
80100c6e:	0f 84 94 00 00 00    	je     80100d08 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c74:	83 ec 08             	sub    $0x8,%esp
80100c77:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100c7d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c7f:	50                   	push   %eax
80100c80:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100c81:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c83:	e8 78 68 00 00       	call   80107500 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c88:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c8b:	83 c4 10             	add    $0x10,%esp
80100c8e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c94:	8b 00                	mov    (%eax),%eax
80100c96:	85 c0                	test   %eax,%eax
80100c98:	0f 84 8b 00 00 00    	je     80100d29 <exec+0x279>
80100c9e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100ca4:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100caa:	eb 23                	jmp    80100ccf <exec+0x21f>
80100cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100cb0:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100cb3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100cba:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100cbd:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100cc3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100cc6:	85 c0                	test   %eax,%eax
80100cc8:	74 59                	je     80100d23 <exec+0x273>
    if(argc >= MAXARG)
80100cca:	83 ff 20             	cmp    $0x20,%edi
80100ccd:	74 39                	je     80100d08 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ccf:	83 ec 0c             	sub    $0xc,%esp
80100cd2:	50                   	push   %eax
80100cd3:	e8 28 3e 00 00       	call   80104b00 <strlen>
80100cd8:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cda:	58                   	pop    %eax
80100cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cde:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ce1:	ff 34 b8             	push   (%eax,%edi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ce4:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ce7:	e8 14 3e 00 00       	call   80104b00 <strlen>
80100cec:	83 c0 01             	add    $0x1,%eax
80100cef:	50                   	push   %eax
80100cf0:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cf3:	ff 34 b8             	push   (%eax,%edi,4)
80100cf6:	53                   	push   %ebx
80100cf7:	56                   	push   %esi
80100cf8:	e8 d3 69 00 00       	call   801076d0 <copyout>
80100cfd:	83 c4 20             	add    $0x20,%esp
80100d00:	85 c0                	test   %eax,%eax
80100d02:	79 ac                	jns    80100cb0 <exec+0x200>
80100d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80100d08:	83 ec 0c             	sub    $0xc,%esp
80100d0b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d11:	e8 ca 66 00 00       	call   801073e0 <freevm>
80100d16:	83 c4 10             	add    $0x10,%esp
  return -1;
80100d19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d1e:	e9 f9 fd ff ff       	jmp    80100b1c <exec+0x6c>
80100d23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d29:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100d30:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100d32:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100d39:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d3d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d3f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100d42:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100d48:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d4a:	50                   	push   %eax
80100d4b:	52                   	push   %edx
80100d4c:	53                   	push   %ebx
80100d4d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100d53:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d5a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d5d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d63:	e8 68 69 00 00       	call   801076d0 <copyout>
80100d68:	83 c4 10             	add    $0x10,%esp
80100d6b:	85 c0                	test   %eax,%eax
80100d6d:	78 99                	js     80100d08 <exec+0x258>
  for(last=s=path; *s; s++)
80100d6f:	8b 45 08             	mov    0x8(%ebp),%eax
80100d72:	8b 55 08             	mov    0x8(%ebp),%edx
80100d75:	0f b6 00             	movzbl (%eax),%eax
80100d78:	84 c0                	test   %al,%al
80100d7a:	74 13                	je     80100d8f <exec+0x2df>
80100d7c:	89 d1                	mov    %edx,%ecx
80100d7e:	66 90                	xchg   %ax,%ax
      last = s+1;
80100d80:	83 c1 01             	add    $0x1,%ecx
80100d83:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d85:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100d88:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d8b:	84 c0                	test   %al,%al
80100d8d:	75 f1                	jne    80100d80 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d8f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100d95:	83 ec 04             	sub    $0x4,%esp
80100d98:	6a 10                	push   $0x10
80100d9a:	89 f8                	mov    %edi,%eax
80100d9c:	52                   	push   %edx
80100d9d:	83 c0 6c             	add    $0x6c,%eax
80100da0:	50                   	push   %eax
80100da1:	e8 1a 3d 00 00       	call   80104ac0 <safestrcpy>
  curproc->pgdir = pgdir;
80100da6:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100dac:	89 f8                	mov    %edi,%eax
80100dae:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100db1:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80100db3:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100db6:	89 c1                	mov    %eax,%ecx
80100db8:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dbe:	8b 40 18             	mov    0x18(%eax),%eax
80100dc1:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100dc4:	8b 41 18             	mov    0x18(%ecx),%eax
80100dc7:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100dca:	89 0c 24             	mov    %ecx,(%esp)
80100dcd:	e8 2e 62 00 00       	call   80107000 <switchuvm>
  freevm(oldpgdir);
80100dd2:	89 3c 24             	mov    %edi,(%esp)
80100dd5:	e8 06 66 00 00       	call   801073e0 <freevm>
  return 0;
80100dda:	83 c4 10             	add    $0x10,%esp
80100ddd:	31 c0                	xor    %eax,%eax
80100ddf:	e9 38 fd ff ff       	jmp    80100b1c <exec+0x6c>
    end_op();
80100de4:	e8 e7 1f 00 00       	call   80102dd0 <end_op>
    cprintf("exec: fail\n");
80100de9:	83 ec 0c             	sub    $0xc,%esp
80100dec:	68 61 84 10 80       	push   $0x80108461
80100df1:	e8 aa f8 ff ff       	call   801006a0 <cprintf>
    return -1;
80100df6:	83 c4 10             	add    $0x10,%esp
80100df9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100dfe:	e9 19 fd ff ff       	jmp    80100b1c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e03:	be 00 20 00 00       	mov    $0x2000,%esi
80100e08:	31 ff                	xor    %edi,%edi
80100e0a:	e9 39 fe ff ff       	jmp    80100c48 <exec+0x198>
80100e0f:	90                   	nop

80100e10 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e10:	55                   	push   %ebp
80100e11:	89 e5                	mov    %esp,%ebp
80100e13:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e16:	68 6d 84 10 80       	push   $0x8010846d
80100e1b:	68 60 0f 11 80       	push   $0x80110f60
80100e20:	e8 4b 38 00 00       	call   80104670 <initlock>
}
80100e25:	83 c4 10             	add    $0x10,%esp
80100e28:	c9                   	leave  
80100e29:	c3                   	ret    
80100e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e30 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e34:	bb 94 0f 11 80       	mov    $0x80110f94,%ebx
{
80100e39:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e3c:	68 60 0f 11 80       	push   $0x80110f60
80100e41:	e8 fa 39 00 00       	call   80104840 <acquire>
80100e46:	83 c4 10             	add    $0x10,%esp
80100e49:	eb 10                	jmp    80100e5b <filealloc+0x2b>
80100e4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e4f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e50:	83 c3 18             	add    $0x18,%ebx
80100e53:	81 fb f4 18 11 80    	cmp    $0x801118f4,%ebx
80100e59:	74 25                	je     80100e80 <filealloc+0x50>
    if(f->ref == 0){
80100e5b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e5e:	85 c0                	test   %eax,%eax
80100e60:	75 ee                	jne    80100e50 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e62:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e65:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e6c:	68 60 0f 11 80       	push   $0x80110f60
80100e71:	e8 6a 39 00 00       	call   801047e0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e76:	89 d8                	mov    %ebx,%eax
      return f;
80100e78:	83 c4 10             	add    $0x10,%esp
}
80100e7b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e7e:	c9                   	leave  
80100e7f:	c3                   	ret    
  release(&ftable.lock);
80100e80:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e83:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e85:	68 60 0f 11 80       	push   $0x80110f60
80100e8a:	e8 51 39 00 00       	call   801047e0 <release>
}
80100e8f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e91:	83 c4 10             	add    $0x10,%esp
}
80100e94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e97:	c9                   	leave  
80100e98:	c3                   	ret    
80100e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ea0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100ea0:	55                   	push   %ebp
80100ea1:	89 e5                	mov    %esp,%ebp
80100ea3:	53                   	push   %ebx
80100ea4:	83 ec 10             	sub    $0x10,%esp
80100ea7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100eaa:	68 60 0f 11 80       	push   $0x80110f60
80100eaf:	e8 8c 39 00 00       	call   80104840 <acquire>
  if(f->ref < 1)
80100eb4:	8b 43 04             	mov    0x4(%ebx),%eax
80100eb7:	83 c4 10             	add    $0x10,%esp
80100eba:	85 c0                	test   %eax,%eax
80100ebc:	7e 1a                	jle    80100ed8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100ebe:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ec1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100ec4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ec7:	68 60 0f 11 80       	push   $0x80110f60
80100ecc:	e8 0f 39 00 00       	call   801047e0 <release>
  return f;
}
80100ed1:	89 d8                	mov    %ebx,%eax
80100ed3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ed6:	c9                   	leave  
80100ed7:	c3                   	ret    
    panic("filedup");
80100ed8:	83 ec 0c             	sub    $0xc,%esp
80100edb:	68 74 84 10 80       	push   $0x80108474
80100ee0:	e8 9b f4 ff ff       	call   80100380 <panic>
80100ee5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ef0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	57                   	push   %edi
80100ef4:	56                   	push   %esi
80100ef5:	53                   	push   %ebx
80100ef6:	83 ec 28             	sub    $0x28,%esp
80100ef9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100efc:	68 60 0f 11 80       	push   $0x80110f60
80100f01:	e8 3a 39 00 00       	call   80104840 <acquire>
  if(f->ref < 1)
80100f06:	8b 53 04             	mov    0x4(%ebx),%edx
80100f09:	83 c4 10             	add    $0x10,%esp
80100f0c:	85 d2                	test   %edx,%edx
80100f0e:	0f 8e a5 00 00 00    	jle    80100fb9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100f14:	83 ea 01             	sub    $0x1,%edx
80100f17:	89 53 04             	mov    %edx,0x4(%ebx)
80100f1a:	75 44                	jne    80100f60 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f1c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100f20:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f23:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100f25:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f2b:	8b 73 0c             	mov    0xc(%ebx),%esi
80100f2e:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f31:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f34:	68 60 0f 11 80       	push   $0x80110f60
  ff = *f;
80100f39:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f3c:	e8 9f 38 00 00       	call   801047e0 <release>

  if(ff.type == FD_PIPE)
80100f41:	83 c4 10             	add    $0x10,%esp
80100f44:	83 ff 01             	cmp    $0x1,%edi
80100f47:	74 57                	je     80100fa0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f49:	83 ff 02             	cmp    $0x2,%edi
80100f4c:	74 2a                	je     80100f78 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f51:	5b                   	pop    %ebx
80100f52:	5e                   	pop    %esi
80100f53:	5f                   	pop    %edi
80100f54:	5d                   	pop    %ebp
80100f55:	c3                   	ret    
80100f56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f5d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80100f60:	c7 45 08 60 0f 11 80 	movl   $0x80110f60,0x8(%ebp)
}
80100f67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f6a:	5b                   	pop    %ebx
80100f6b:	5e                   	pop    %esi
80100f6c:	5f                   	pop    %edi
80100f6d:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f6e:	e9 6d 38 00 00       	jmp    801047e0 <release>
80100f73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f77:	90                   	nop
    begin_op();
80100f78:	e8 e3 1d 00 00       	call   80102d60 <begin_op>
    iput(ff.ip);
80100f7d:	83 ec 0c             	sub    $0xc,%esp
80100f80:	ff 75 e0             	push   -0x20(%ebp)
80100f83:	e8 28 09 00 00       	call   801018b0 <iput>
    end_op();
80100f88:	83 c4 10             	add    $0x10,%esp
}
80100f8b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f8e:	5b                   	pop    %ebx
80100f8f:	5e                   	pop    %esi
80100f90:	5f                   	pop    %edi
80100f91:	5d                   	pop    %ebp
    end_op();
80100f92:	e9 39 1e 00 00       	jmp    80102dd0 <end_op>
80100f97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f9e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80100fa0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100fa4:	83 ec 08             	sub    $0x8,%esp
80100fa7:	53                   	push   %ebx
80100fa8:	56                   	push   %esi
80100fa9:	e8 82 25 00 00       	call   80103530 <pipeclose>
80100fae:	83 c4 10             	add    $0x10,%esp
}
80100fb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb4:	5b                   	pop    %ebx
80100fb5:	5e                   	pop    %esi
80100fb6:	5f                   	pop    %edi
80100fb7:	5d                   	pop    %ebp
80100fb8:	c3                   	ret    
    panic("fileclose");
80100fb9:	83 ec 0c             	sub    $0xc,%esp
80100fbc:	68 7c 84 10 80       	push   $0x8010847c
80100fc1:	e8 ba f3 ff ff       	call   80100380 <panic>
80100fc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fcd:	8d 76 00             	lea    0x0(%esi),%esi

80100fd0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	53                   	push   %ebx
80100fd4:	83 ec 04             	sub    $0x4,%esp
80100fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100fda:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fdd:	75 31                	jne    80101010 <filestat+0x40>
    ilock(f->ip);
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	ff 73 10             	push   0x10(%ebx)
80100fe5:	e8 96 07 00 00       	call   80101780 <ilock>
    stati(f->ip, st);
80100fea:	58                   	pop    %eax
80100feb:	5a                   	pop    %edx
80100fec:	ff 75 0c             	push   0xc(%ebp)
80100fef:	ff 73 10             	push   0x10(%ebx)
80100ff2:	e8 69 0a 00 00       	call   80101a60 <stati>
    iunlock(f->ip);
80100ff7:	59                   	pop    %ecx
80100ff8:	ff 73 10             	push   0x10(%ebx)
80100ffb:	e8 60 08 00 00       	call   80101860 <iunlock>
    return 0;
  }
  return -1;
}
80101000:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101003:	83 c4 10             	add    $0x10,%esp
80101006:	31 c0                	xor    %eax,%eax
}
80101008:	c9                   	leave  
80101009:	c3                   	ret    
8010100a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101010:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101013:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101018:	c9                   	leave  
80101019:	c3                   	ret    
8010101a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101020 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	57                   	push   %edi
80101024:	56                   	push   %esi
80101025:	53                   	push   %ebx
80101026:	83 ec 0c             	sub    $0xc,%esp
80101029:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010102c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010102f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101032:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101036:	74 60                	je     80101098 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101038:	8b 03                	mov    (%ebx),%eax
8010103a:	83 f8 01             	cmp    $0x1,%eax
8010103d:	74 41                	je     80101080 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010103f:	83 f8 02             	cmp    $0x2,%eax
80101042:	75 5b                	jne    8010109f <fileread+0x7f>
    ilock(f->ip);
80101044:	83 ec 0c             	sub    $0xc,%esp
80101047:	ff 73 10             	push   0x10(%ebx)
8010104a:	e8 31 07 00 00       	call   80101780 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010104f:	57                   	push   %edi
80101050:	ff 73 14             	push   0x14(%ebx)
80101053:	56                   	push   %esi
80101054:	ff 73 10             	push   0x10(%ebx)
80101057:	e8 34 0a 00 00       	call   80101a90 <readi>
8010105c:	83 c4 20             	add    $0x20,%esp
8010105f:	89 c6                	mov    %eax,%esi
80101061:	85 c0                	test   %eax,%eax
80101063:	7e 03                	jle    80101068 <fileread+0x48>
      f->off += r;
80101065:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101068:	83 ec 0c             	sub    $0xc,%esp
8010106b:	ff 73 10             	push   0x10(%ebx)
8010106e:	e8 ed 07 00 00       	call   80101860 <iunlock>
    return r;
80101073:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101076:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101079:	89 f0                	mov    %esi,%eax
8010107b:	5b                   	pop    %ebx
8010107c:	5e                   	pop    %esi
8010107d:	5f                   	pop    %edi
8010107e:	5d                   	pop    %ebp
8010107f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101080:	8b 43 0c             	mov    0xc(%ebx),%eax
80101083:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101086:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101089:	5b                   	pop    %ebx
8010108a:	5e                   	pop    %esi
8010108b:	5f                   	pop    %edi
8010108c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010108d:	e9 3e 26 00 00       	jmp    801036d0 <piperead>
80101092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101098:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010109d:	eb d7                	jmp    80101076 <fileread+0x56>
  panic("fileread");
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	68 86 84 10 80       	push   $0x80108486
801010a7:	e8 d4 f2 ff ff       	call   80100380 <panic>
801010ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010b0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801010b0:	55                   	push   %ebp
801010b1:	89 e5                	mov    %esp,%ebp
801010b3:	57                   	push   %edi
801010b4:	56                   	push   %esi
801010b5:	53                   	push   %ebx
801010b6:	83 ec 1c             	sub    $0x1c,%esp
801010b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801010bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
801010bf:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010c2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801010c5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
801010c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801010cc:	0f 84 bd 00 00 00    	je     8010118f <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
801010d2:	8b 03                	mov    (%ebx),%eax
801010d4:	83 f8 01             	cmp    $0x1,%eax
801010d7:	0f 84 bf 00 00 00    	je     8010119c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010dd:	83 f8 02             	cmp    $0x2,%eax
801010e0:	0f 85 c8 00 00 00    	jne    801011ae <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801010e9:	31 f6                	xor    %esi,%esi
    while(i < n){
801010eb:	85 c0                	test   %eax,%eax
801010ed:	7f 30                	jg     8010111f <filewrite+0x6f>
801010ef:	e9 94 00 00 00       	jmp    80101188 <filewrite+0xd8>
801010f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801010f8:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
801010fb:	83 ec 0c             	sub    $0xc,%esp
801010fe:	ff 73 10             	push   0x10(%ebx)
        f->off += r;
80101101:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101104:	e8 57 07 00 00       	call   80101860 <iunlock>
      end_op();
80101109:	e8 c2 1c 00 00       	call   80102dd0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010110e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101111:	83 c4 10             	add    $0x10,%esp
80101114:	39 c7                	cmp    %eax,%edi
80101116:	75 5c                	jne    80101174 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101118:	01 fe                	add    %edi,%esi
    while(i < n){
8010111a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010111d:	7e 69                	jle    80101188 <filewrite+0xd8>
      int n1 = n - i;
8010111f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101122:	b8 00 06 00 00       	mov    $0x600,%eax
80101127:	29 f7                	sub    %esi,%edi
80101129:	39 c7                	cmp    %eax,%edi
8010112b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
8010112e:	e8 2d 1c 00 00       	call   80102d60 <begin_op>
      ilock(f->ip);
80101133:	83 ec 0c             	sub    $0xc,%esp
80101136:	ff 73 10             	push   0x10(%ebx)
80101139:	e8 42 06 00 00       	call   80101780 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010113e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101141:	57                   	push   %edi
80101142:	ff 73 14             	push   0x14(%ebx)
80101145:	01 f0                	add    %esi,%eax
80101147:	50                   	push   %eax
80101148:	ff 73 10             	push   0x10(%ebx)
8010114b:	e8 40 0a 00 00       	call   80101b90 <writei>
80101150:	83 c4 20             	add    $0x20,%esp
80101153:	85 c0                	test   %eax,%eax
80101155:	7f a1                	jg     801010f8 <filewrite+0x48>
      iunlock(f->ip);
80101157:	83 ec 0c             	sub    $0xc,%esp
8010115a:	ff 73 10             	push   0x10(%ebx)
8010115d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101160:	e8 fb 06 00 00       	call   80101860 <iunlock>
      end_op();
80101165:	e8 66 1c 00 00       	call   80102dd0 <end_op>
      if(r < 0)
8010116a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010116d:	83 c4 10             	add    $0x10,%esp
80101170:	85 c0                	test   %eax,%eax
80101172:	75 1b                	jne    8010118f <filewrite+0xdf>
        panic("short filewrite");
80101174:	83 ec 0c             	sub    $0xc,%esp
80101177:	68 8f 84 10 80       	push   $0x8010848f
8010117c:	e8 ff f1 ff ff       	call   80100380 <panic>
80101181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101188:	89 f0                	mov    %esi,%eax
8010118a:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
8010118d:	74 05                	je     80101194 <filewrite+0xe4>
8010118f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101197:	5b                   	pop    %ebx
80101198:	5e                   	pop    %esi
80101199:	5f                   	pop    %edi
8010119a:	5d                   	pop    %ebp
8010119b:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
8010119c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010119f:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011a5:	5b                   	pop    %ebx
801011a6:	5e                   	pop    %esi
801011a7:	5f                   	pop    %edi
801011a8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801011a9:	e9 22 24 00 00       	jmp    801035d0 <pipewrite>
  panic("filewrite");
801011ae:	83 ec 0c             	sub    $0xc,%esp
801011b1:	68 95 84 10 80       	push   $0x80108495
801011b6:	e8 c5 f1 ff ff       	call   80100380 <panic>
801011bb:	66 90                	xchg   %ax,%ax
801011bd:	66 90                	xchg   %ax,%ax
801011bf:	90                   	nop

801011c0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801011c0:	55                   	push   %ebp
801011c1:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
801011c3:	89 d0                	mov    %edx,%eax
801011c5:	c1 e8 0c             	shr    $0xc,%eax
801011c8:	03 05 cc 35 11 80    	add    0x801135cc,%eax
{
801011ce:	89 e5                	mov    %esp,%ebp
801011d0:	56                   	push   %esi
801011d1:	53                   	push   %ebx
801011d2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801011d4:	83 ec 08             	sub    $0x8,%esp
801011d7:	50                   	push   %eax
801011d8:	51                   	push   %ecx
801011d9:	e8 f2 ee ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801011de:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801011e0:	c1 fb 03             	sar    $0x3,%ebx
801011e3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801011e6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801011e8:	83 e1 07             	and    $0x7,%ecx
801011eb:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
801011f0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
801011f6:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801011f8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801011fd:	85 c1                	test   %eax,%ecx
801011ff:	74 23                	je     80101224 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101201:	f7 d0                	not    %eax
  log_write(bp);
80101203:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101206:	21 c8                	and    %ecx,%eax
80101208:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010120c:	56                   	push   %esi
8010120d:	e8 2e 1d 00 00       	call   80102f40 <log_write>
  brelse(bp);
80101212:	89 34 24             	mov    %esi,(%esp)
80101215:	e8 d6 ef ff ff       	call   801001f0 <brelse>
}
8010121a:	83 c4 10             	add    $0x10,%esp
8010121d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101220:	5b                   	pop    %ebx
80101221:	5e                   	pop    %esi
80101222:	5d                   	pop    %ebp
80101223:	c3                   	ret    
    panic("freeing free block");
80101224:	83 ec 0c             	sub    $0xc,%esp
80101227:	68 9f 84 10 80       	push   $0x8010849f
8010122c:	e8 4f f1 ff ff       	call   80100380 <panic>
80101231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010123f:	90                   	nop

80101240 <balloc>:
{
80101240:	55                   	push   %ebp
80101241:	89 e5                	mov    %esp,%ebp
80101243:	57                   	push   %edi
80101244:	56                   	push   %esi
80101245:	53                   	push   %ebx
80101246:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101249:	8b 0d b4 35 11 80    	mov    0x801135b4,%ecx
{
8010124f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101252:	85 c9                	test   %ecx,%ecx
80101254:	0f 84 87 00 00 00    	je     801012e1 <balloc+0xa1>
8010125a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101261:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101264:	83 ec 08             	sub    $0x8,%esp
80101267:	89 f0                	mov    %esi,%eax
80101269:	c1 f8 0c             	sar    $0xc,%eax
8010126c:	03 05 cc 35 11 80    	add    0x801135cc,%eax
80101272:	50                   	push   %eax
80101273:	ff 75 d8             	push   -0x28(%ebp)
80101276:	e8 55 ee ff ff       	call   801000d0 <bread>
8010127b:	83 c4 10             	add    $0x10,%esp
8010127e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101281:	a1 b4 35 11 80       	mov    0x801135b4,%eax
80101286:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101289:	31 c0                	xor    %eax,%eax
8010128b:	eb 2f                	jmp    801012bc <balloc+0x7c>
8010128d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101290:	89 c1                	mov    %eax,%ecx
80101292:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101297:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
8010129a:	83 e1 07             	and    $0x7,%ecx
8010129d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010129f:	89 c1                	mov    %eax,%ecx
801012a1:	c1 f9 03             	sar    $0x3,%ecx
801012a4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801012a9:	89 fa                	mov    %edi,%edx
801012ab:	85 df                	test   %ebx,%edi
801012ad:	74 41                	je     801012f0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012af:	83 c0 01             	add    $0x1,%eax
801012b2:	83 c6 01             	add    $0x1,%esi
801012b5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801012ba:	74 05                	je     801012c1 <balloc+0x81>
801012bc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801012bf:	77 cf                	ja     80101290 <balloc+0x50>
    brelse(bp);
801012c1:	83 ec 0c             	sub    $0xc,%esp
801012c4:	ff 75 e4             	push   -0x1c(%ebp)
801012c7:	e8 24 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801012cc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801012d3:	83 c4 10             	add    $0x10,%esp
801012d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801012d9:	39 05 b4 35 11 80    	cmp    %eax,0x801135b4
801012df:	77 80                	ja     80101261 <balloc+0x21>
  panic("balloc: out of blocks");
801012e1:	83 ec 0c             	sub    $0xc,%esp
801012e4:	68 b2 84 10 80       	push   $0x801084b2
801012e9:	e8 92 f0 ff ff       	call   80100380 <panic>
801012ee:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801012f0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801012f3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801012f6:	09 da                	or     %ebx,%edx
801012f8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801012fc:	57                   	push   %edi
801012fd:	e8 3e 1c 00 00       	call   80102f40 <log_write>
        brelse(bp);
80101302:	89 3c 24             	mov    %edi,(%esp)
80101305:	e8 e6 ee ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010130a:	58                   	pop    %eax
8010130b:	5a                   	pop    %edx
8010130c:	56                   	push   %esi
8010130d:	ff 75 d8             	push   -0x28(%ebp)
80101310:	e8 bb ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101315:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101318:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010131a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010131d:	68 00 02 00 00       	push   $0x200
80101322:	6a 00                	push   $0x0
80101324:	50                   	push   %eax
80101325:	e8 d6 35 00 00       	call   80104900 <memset>
  log_write(bp);
8010132a:	89 1c 24             	mov    %ebx,(%esp)
8010132d:	e8 0e 1c 00 00       	call   80102f40 <log_write>
  brelse(bp);
80101332:	89 1c 24             	mov    %ebx,(%esp)
80101335:	e8 b6 ee ff ff       	call   801001f0 <brelse>
}
8010133a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010133d:	89 f0                	mov    %esi,%eax
8010133f:	5b                   	pop    %ebx
80101340:	5e                   	pop    %esi
80101341:	5f                   	pop    %edi
80101342:	5d                   	pop    %ebp
80101343:	c3                   	ret    
80101344:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010134b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010134f:	90                   	nop

80101350 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101350:	55                   	push   %ebp
80101351:	89 e5                	mov    %esp,%ebp
80101353:	57                   	push   %edi
80101354:	89 c7                	mov    %eax,%edi
80101356:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101357:	31 f6                	xor    %esi,%esi
{
80101359:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010135a:	bb 94 19 11 80       	mov    $0x80111994,%ebx
{
8010135f:	83 ec 28             	sub    $0x28,%esp
80101362:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101365:	68 60 19 11 80       	push   $0x80111960
8010136a:	e8 d1 34 00 00       	call   80104840 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010136f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101372:	83 c4 10             	add    $0x10,%esp
80101375:	eb 1b                	jmp    80101392 <iget+0x42>
80101377:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010137e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101380:	39 3b                	cmp    %edi,(%ebx)
80101382:	74 6c                	je     801013f0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101384:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010138a:	81 fb b4 35 11 80    	cmp    $0x801135b4,%ebx
80101390:	73 26                	jae    801013b8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101392:	8b 43 08             	mov    0x8(%ebx),%eax
80101395:	85 c0                	test   %eax,%eax
80101397:	7f e7                	jg     80101380 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101399:	85 f6                	test   %esi,%esi
8010139b:	75 e7                	jne    80101384 <iget+0x34>
8010139d:	85 c0                	test   %eax,%eax
8010139f:	75 76                	jne    80101417 <iget+0xc7>
801013a1:	89 de                	mov    %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013a3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013a9:	81 fb b4 35 11 80    	cmp    $0x801135b4,%ebx
801013af:	72 e1                	jb     80101392 <iget+0x42>
801013b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801013b8:	85 f6                	test   %esi,%esi
801013ba:	74 79                	je     80101435 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801013bc:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801013bf:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801013c1:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801013c4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801013cb:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801013d2:	68 60 19 11 80       	push   $0x80111960
801013d7:	e8 04 34 00 00       	call   801047e0 <release>

  return ip;
801013dc:	83 c4 10             	add    $0x10,%esp
}
801013df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e2:	89 f0                	mov    %esi,%eax
801013e4:	5b                   	pop    %ebx
801013e5:	5e                   	pop    %esi
801013e6:	5f                   	pop    %edi
801013e7:	5d                   	pop    %ebp
801013e8:	c3                   	ret    
801013e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013f0:	39 53 04             	cmp    %edx,0x4(%ebx)
801013f3:	75 8f                	jne    80101384 <iget+0x34>
      release(&icache.lock);
801013f5:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801013f8:	83 c0 01             	add    $0x1,%eax
      return ip;
801013fb:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801013fd:	68 60 19 11 80       	push   $0x80111960
      ip->ref++;
80101402:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101405:	e8 d6 33 00 00       	call   801047e0 <release>
      return ip;
8010140a:	83 c4 10             	add    $0x10,%esp
}
8010140d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101410:	89 f0                	mov    %esi,%eax
80101412:	5b                   	pop    %ebx
80101413:	5e                   	pop    %esi
80101414:	5f                   	pop    %edi
80101415:	5d                   	pop    %ebp
80101416:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101417:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010141d:	81 fb b4 35 11 80    	cmp    $0x801135b4,%ebx
80101423:	73 10                	jae    80101435 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101425:	8b 43 08             	mov    0x8(%ebx),%eax
80101428:	85 c0                	test   %eax,%eax
8010142a:	0f 8f 50 ff ff ff    	jg     80101380 <iget+0x30>
80101430:	e9 68 ff ff ff       	jmp    8010139d <iget+0x4d>
    panic("iget: no inodes");
80101435:	83 ec 0c             	sub    $0xc,%esp
80101438:	68 c8 84 10 80       	push   $0x801084c8
8010143d:	e8 3e ef ff ff       	call   80100380 <panic>
80101442:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101450 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101450:	55                   	push   %ebp
80101451:	89 e5                	mov    %esp,%ebp
80101453:	57                   	push   %edi
80101454:	56                   	push   %esi
80101455:	89 c6                	mov    %eax,%esi
80101457:	53                   	push   %ebx
80101458:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010145b:	83 fa 0b             	cmp    $0xb,%edx
8010145e:	0f 86 8c 00 00 00    	jbe    801014f0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101464:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101467:	83 fb 7f             	cmp    $0x7f,%ebx
8010146a:	0f 87 a2 00 00 00    	ja     80101512 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101470:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101476:	85 c0                	test   %eax,%eax
80101478:	74 5e                	je     801014d8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010147a:	83 ec 08             	sub    $0x8,%esp
8010147d:	50                   	push   %eax
8010147e:	ff 36                	push   (%esi)
80101480:	e8 4b ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101485:	83 c4 10             	add    $0x10,%esp
80101488:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010148c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010148e:	8b 3b                	mov    (%ebx),%edi
80101490:	85 ff                	test   %edi,%edi
80101492:	74 1c                	je     801014b0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101494:	83 ec 0c             	sub    $0xc,%esp
80101497:	52                   	push   %edx
80101498:	e8 53 ed ff ff       	call   801001f0 <brelse>
8010149d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801014a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014a3:	89 f8                	mov    %edi,%eax
801014a5:	5b                   	pop    %ebx
801014a6:	5e                   	pop    %esi
801014a7:	5f                   	pop    %edi
801014a8:	5d                   	pop    %ebp
801014a9:	c3                   	ret    
801014aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801014b3:	8b 06                	mov    (%esi),%eax
801014b5:	e8 86 fd ff ff       	call   80101240 <balloc>
      log_write(bp);
801014ba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014bd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801014c0:	89 03                	mov    %eax,(%ebx)
801014c2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801014c4:	52                   	push   %edx
801014c5:	e8 76 1a 00 00       	call   80102f40 <log_write>
801014ca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014cd:	83 c4 10             	add    $0x10,%esp
801014d0:	eb c2                	jmp    80101494 <bmap+0x44>
801014d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801014d8:	8b 06                	mov    (%esi),%eax
801014da:	e8 61 fd ff ff       	call   80101240 <balloc>
801014df:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801014e5:	eb 93                	jmp    8010147a <bmap+0x2a>
801014e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801014ee:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
801014f0:	8d 5a 14             	lea    0x14(%edx),%ebx
801014f3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
801014f7:	85 ff                	test   %edi,%edi
801014f9:	75 a5                	jne    801014a0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
801014fb:	8b 00                	mov    (%eax),%eax
801014fd:	e8 3e fd ff ff       	call   80101240 <balloc>
80101502:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101506:	89 c7                	mov    %eax,%edi
}
80101508:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010150b:	5b                   	pop    %ebx
8010150c:	89 f8                	mov    %edi,%eax
8010150e:	5e                   	pop    %esi
8010150f:	5f                   	pop    %edi
80101510:	5d                   	pop    %ebp
80101511:	c3                   	ret    
  panic("bmap: out of range");
80101512:	83 ec 0c             	sub    $0xc,%esp
80101515:	68 d8 84 10 80       	push   $0x801084d8
8010151a:	e8 61 ee ff ff       	call   80100380 <panic>
8010151f:	90                   	nop

80101520 <readsb>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	56                   	push   %esi
80101524:	53                   	push   %ebx
80101525:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101528:	83 ec 08             	sub    $0x8,%esp
8010152b:	6a 01                	push   $0x1
8010152d:	ff 75 08             	push   0x8(%ebp)
80101530:	e8 9b eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101535:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101538:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010153a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010153d:	6a 1c                	push   $0x1c
8010153f:	50                   	push   %eax
80101540:	56                   	push   %esi
80101541:	e8 5a 34 00 00       	call   801049a0 <memmove>
  brelse(bp);
80101546:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101549:	83 c4 10             	add    $0x10,%esp
}
8010154c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010154f:	5b                   	pop    %ebx
80101550:	5e                   	pop    %esi
80101551:	5d                   	pop    %ebp
  brelse(bp);
80101552:	e9 99 ec ff ff       	jmp    801001f0 <brelse>
80101557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010155e:	66 90                	xchg   %ax,%ax

80101560 <iinit>:
{
80101560:	55                   	push   %ebp
80101561:	89 e5                	mov    %esp,%ebp
80101563:	53                   	push   %ebx
80101564:	bb a0 19 11 80       	mov    $0x801119a0,%ebx
80101569:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010156c:	68 eb 84 10 80       	push   $0x801084eb
80101571:	68 60 19 11 80       	push   $0x80111960
80101576:	e8 f5 30 00 00       	call   80104670 <initlock>
  for(i = 0; i < NINODE; i++) {
8010157b:	83 c4 10             	add    $0x10,%esp
8010157e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101580:	83 ec 08             	sub    $0x8,%esp
80101583:	68 f2 84 10 80       	push   $0x801084f2
80101588:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101589:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010158f:	e8 ac 2f 00 00       	call   80104540 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101594:	83 c4 10             	add    $0x10,%esp
80101597:	81 fb c0 35 11 80    	cmp    $0x801135c0,%ebx
8010159d:	75 e1                	jne    80101580 <iinit+0x20>
  bp = bread(dev, 1);
8010159f:	83 ec 08             	sub    $0x8,%esp
801015a2:	6a 01                	push   $0x1
801015a4:	ff 75 08             	push   0x8(%ebp)
801015a7:	e8 24 eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801015ac:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801015af:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015b1:	8d 40 5c             	lea    0x5c(%eax),%eax
801015b4:	6a 1c                	push   $0x1c
801015b6:	50                   	push   %eax
801015b7:	68 b4 35 11 80       	push   $0x801135b4
801015bc:	e8 df 33 00 00       	call   801049a0 <memmove>
  brelse(bp);
801015c1:	89 1c 24             	mov    %ebx,(%esp)
801015c4:	e8 27 ec ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801015c9:	ff 35 cc 35 11 80    	push   0x801135cc
801015cf:	ff 35 c8 35 11 80    	push   0x801135c8
801015d5:	ff 35 c4 35 11 80    	push   0x801135c4
801015db:	ff 35 c0 35 11 80    	push   0x801135c0
801015e1:	ff 35 bc 35 11 80    	push   0x801135bc
801015e7:	ff 35 b8 35 11 80    	push   0x801135b8
801015ed:	ff 35 b4 35 11 80    	push   0x801135b4
801015f3:	68 58 85 10 80       	push   $0x80108558
801015f8:	e8 a3 f0 ff ff       	call   801006a0 <cprintf>
}
801015fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101600:	83 c4 30             	add    $0x30,%esp
80101603:	c9                   	leave  
80101604:	c3                   	ret    
80101605:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010160c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101610 <ialloc>:
{
80101610:	55                   	push   %ebp
80101611:	89 e5                	mov    %esp,%ebp
80101613:	57                   	push   %edi
80101614:	56                   	push   %esi
80101615:	53                   	push   %ebx
80101616:	83 ec 1c             	sub    $0x1c,%esp
80101619:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010161c:	83 3d bc 35 11 80 01 	cmpl   $0x1,0x801135bc
{
80101623:	8b 75 08             	mov    0x8(%ebp),%esi
80101626:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101629:	0f 86 91 00 00 00    	jbe    801016c0 <ialloc+0xb0>
8010162f:	bf 01 00 00 00       	mov    $0x1,%edi
80101634:	eb 21                	jmp    80101657 <ialloc+0x47>
80101636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010163d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101640:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101643:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101646:	53                   	push   %ebx
80101647:	e8 a4 eb ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010164c:	83 c4 10             	add    $0x10,%esp
8010164f:	3b 3d bc 35 11 80    	cmp    0x801135bc,%edi
80101655:	73 69                	jae    801016c0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101657:	89 f8                	mov    %edi,%eax
80101659:	83 ec 08             	sub    $0x8,%esp
8010165c:	c1 e8 03             	shr    $0x3,%eax
8010165f:	03 05 c8 35 11 80    	add    0x801135c8,%eax
80101665:	50                   	push   %eax
80101666:	56                   	push   %esi
80101667:	e8 64 ea ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010166c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010166f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101671:	89 f8                	mov    %edi,%eax
80101673:	83 e0 07             	and    $0x7,%eax
80101676:	c1 e0 06             	shl    $0x6,%eax
80101679:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010167d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101681:	75 bd                	jne    80101640 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101683:	83 ec 04             	sub    $0x4,%esp
80101686:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101689:	6a 40                	push   $0x40
8010168b:	6a 00                	push   $0x0
8010168d:	51                   	push   %ecx
8010168e:	e8 6d 32 00 00       	call   80104900 <memset>
      dip->type = type;
80101693:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101697:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010169a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010169d:	89 1c 24             	mov    %ebx,(%esp)
801016a0:	e8 9b 18 00 00       	call   80102f40 <log_write>
      brelse(bp);
801016a5:	89 1c 24             	mov    %ebx,(%esp)
801016a8:	e8 43 eb ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801016ad:	83 c4 10             	add    $0x10,%esp
}
801016b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801016b3:	89 fa                	mov    %edi,%edx
}
801016b5:	5b                   	pop    %ebx
      return iget(dev, inum);
801016b6:	89 f0                	mov    %esi,%eax
}
801016b8:	5e                   	pop    %esi
801016b9:	5f                   	pop    %edi
801016ba:	5d                   	pop    %ebp
      return iget(dev, inum);
801016bb:	e9 90 fc ff ff       	jmp    80101350 <iget>
  panic("ialloc: no inodes");
801016c0:	83 ec 0c             	sub    $0xc,%esp
801016c3:	68 f8 84 10 80       	push   $0x801084f8
801016c8:	e8 b3 ec ff ff       	call   80100380 <panic>
801016cd:	8d 76 00             	lea    0x0(%esi),%esi

801016d0 <iupdate>:
{
801016d0:	55                   	push   %ebp
801016d1:	89 e5                	mov    %esp,%ebp
801016d3:	56                   	push   %esi
801016d4:	53                   	push   %ebx
801016d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016d8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016db:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016de:	83 ec 08             	sub    $0x8,%esp
801016e1:	c1 e8 03             	shr    $0x3,%eax
801016e4:	03 05 c8 35 11 80    	add    0x801135c8,%eax
801016ea:	50                   	push   %eax
801016eb:	ff 73 a4             	push   -0x5c(%ebx)
801016ee:	e8 dd e9 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801016f3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016f7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016fa:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016fc:	8b 43 a8             	mov    -0x58(%ebx),%eax
801016ff:	83 e0 07             	and    $0x7,%eax
80101702:	c1 e0 06             	shl    $0x6,%eax
80101705:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101709:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010170c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101710:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101713:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101717:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010171b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010171f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101723:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101727:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010172a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010172d:	6a 34                	push   $0x34
8010172f:	53                   	push   %ebx
80101730:	50                   	push   %eax
80101731:	e8 6a 32 00 00       	call   801049a0 <memmove>
  log_write(bp);
80101736:	89 34 24             	mov    %esi,(%esp)
80101739:	e8 02 18 00 00       	call   80102f40 <log_write>
  brelse(bp);
8010173e:	89 75 08             	mov    %esi,0x8(%ebp)
80101741:	83 c4 10             	add    $0x10,%esp
}
80101744:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101747:	5b                   	pop    %ebx
80101748:	5e                   	pop    %esi
80101749:	5d                   	pop    %ebp
  brelse(bp);
8010174a:	e9 a1 ea ff ff       	jmp    801001f0 <brelse>
8010174f:	90                   	nop

80101750 <idup>:
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	53                   	push   %ebx
80101754:	83 ec 10             	sub    $0x10,%esp
80101757:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010175a:	68 60 19 11 80       	push   $0x80111960
8010175f:	e8 dc 30 00 00       	call   80104840 <acquire>
  ip->ref++;
80101764:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101768:	c7 04 24 60 19 11 80 	movl   $0x80111960,(%esp)
8010176f:	e8 6c 30 00 00       	call   801047e0 <release>
}
80101774:	89 d8                	mov    %ebx,%eax
80101776:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101779:	c9                   	leave  
8010177a:	c3                   	ret    
8010177b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010177f:	90                   	nop

80101780 <ilock>:
{
80101780:	55                   	push   %ebp
80101781:	89 e5                	mov    %esp,%ebp
80101783:	56                   	push   %esi
80101784:	53                   	push   %ebx
80101785:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101788:	85 db                	test   %ebx,%ebx
8010178a:	0f 84 b7 00 00 00    	je     80101847 <ilock+0xc7>
80101790:	8b 53 08             	mov    0x8(%ebx),%edx
80101793:	85 d2                	test   %edx,%edx
80101795:	0f 8e ac 00 00 00    	jle    80101847 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010179b:	83 ec 0c             	sub    $0xc,%esp
8010179e:	8d 43 0c             	lea    0xc(%ebx),%eax
801017a1:	50                   	push   %eax
801017a2:	e8 d9 2d 00 00       	call   80104580 <acquiresleep>
  if(ip->valid == 0){
801017a7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801017aa:	83 c4 10             	add    $0x10,%esp
801017ad:	85 c0                	test   %eax,%eax
801017af:	74 0f                	je     801017c0 <ilock+0x40>
}
801017b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017b4:	5b                   	pop    %ebx
801017b5:	5e                   	pop    %esi
801017b6:	5d                   	pop    %ebp
801017b7:	c3                   	ret    
801017b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017bf:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017c0:	8b 43 04             	mov    0x4(%ebx),%eax
801017c3:	83 ec 08             	sub    $0x8,%esp
801017c6:	c1 e8 03             	shr    $0x3,%eax
801017c9:	03 05 c8 35 11 80    	add    0x801135c8,%eax
801017cf:	50                   	push   %eax
801017d0:	ff 33                	push   (%ebx)
801017d2:	e8 f9 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017d7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017da:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017dc:	8b 43 04             	mov    0x4(%ebx),%eax
801017df:	83 e0 07             	and    $0x7,%eax
801017e2:	c1 e0 06             	shl    $0x6,%eax
801017e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801017e9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017ec:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801017ef:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801017f3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801017f7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801017fb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801017ff:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101803:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101807:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010180b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010180e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101811:	6a 34                	push   $0x34
80101813:	50                   	push   %eax
80101814:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101817:	50                   	push   %eax
80101818:	e8 83 31 00 00       	call   801049a0 <memmove>
    brelse(bp);
8010181d:	89 34 24             	mov    %esi,(%esp)
80101820:	e8 cb e9 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101825:	83 c4 10             	add    $0x10,%esp
80101828:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010182d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101834:	0f 85 77 ff ff ff    	jne    801017b1 <ilock+0x31>
      panic("ilock: no type");
8010183a:	83 ec 0c             	sub    $0xc,%esp
8010183d:	68 10 85 10 80       	push   $0x80108510
80101842:	e8 39 eb ff ff       	call   80100380 <panic>
    panic("ilock");
80101847:	83 ec 0c             	sub    $0xc,%esp
8010184a:	68 0a 85 10 80       	push   $0x8010850a
8010184f:	e8 2c eb ff ff       	call   80100380 <panic>
80101854:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010185b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010185f:	90                   	nop

80101860 <iunlock>:
{
80101860:	55                   	push   %ebp
80101861:	89 e5                	mov    %esp,%ebp
80101863:	56                   	push   %esi
80101864:	53                   	push   %ebx
80101865:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101868:	85 db                	test   %ebx,%ebx
8010186a:	74 28                	je     80101894 <iunlock+0x34>
8010186c:	83 ec 0c             	sub    $0xc,%esp
8010186f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101872:	56                   	push   %esi
80101873:	e8 a8 2d 00 00       	call   80104620 <holdingsleep>
80101878:	83 c4 10             	add    $0x10,%esp
8010187b:	85 c0                	test   %eax,%eax
8010187d:	74 15                	je     80101894 <iunlock+0x34>
8010187f:	8b 43 08             	mov    0x8(%ebx),%eax
80101882:	85 c0                	test   %eax,%eax
80101884:	7e 0e                	jle    80101894 <iunlock+0x34>
  releasesleep(&ip->lock);
80101886:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101889:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010188c:	5b                   	pop    %ebx
8010188d:	5e                   	pop    %esi
8010188e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010188f:	e9 4c 2d 00 00       	jmp    801045e0 <releasesleep>
    panic("iunlock");
80101894:	83 ec 0c             	sub    $0xc,%esp
80101897:	68 1f 85 10 80       	push   $0x8010851f
8010189c:	e8 df ea ff ff       	call   80100380 <panic>
801018a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018af:	90                   	nop

801018b0 <iput>:
{
801018b0:	55                   	push   %ebp
801018b1:	89 e5                	mov    %esp,%ebp
801018b3:	57                   	push   %edi
801018b4:	56                   	push   %esi
801018b5:	53                   	push   %ebx
801018b6:	83 ec 28             	sub    $0x28,%esp
801018b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801018bc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801018bf:	57                   	push   %edi
801018c0:	e8 bb 2c 00 00       	call   80104580 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801018c5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801018c8:	83 c4 10             	add    $0x10,%esp
801018cb:	85 d2                	test   %edx,%edx
801018cd:	74 07                	je     801018d6 <iput+0x26>
801018cf:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801018d4:	74 32                	je     80101908 <iput+0x58>
  releasesleep(&ip->lock);
801018d6:	83 ec 0c             	sub    $0xc,%esp
801018d9:	57                   	push   %edi
801018da:	e8 01 2d 00 00       	call   801045e0 <releasesleep>
  acquire(&icache.lock);
801018df:	c7 04 24 60 19 11 80 	movl   $0x80111960,(%esp)
801018e6:	e8 55 2f 00 00       	call   80104840 <acquire>
  ip->ref--;
801018eb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018ef:	83 c4 10             	add    $0x10,%esp
801018f2:	c7 45 08 60 19 11 80 	movl   $0x80111960,0x8(%ebp)
}
801018f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018fc:	5b                   	pop    %ebx
801018fd:	5e                   	pop    %esi
801018fe:	5f                   	pop    %edi
801018ff:	5d                   	pop    %ebp
  release(&icache.lock);
80101900:	e9 db 2e 00 00       	jmp    801047e0 <release>
80101905:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101908:	83 ec 0c             	sub    $0xc,%esp
8010190b:	68 60 19 11 80       	push   $0x80111960
80101910:	e8 2b 2f 00 00       	call   80104840 <acquire>
    int r = ip->ref;
80101915:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101918:	c7 04 24 60 19 11 80 	movl   $0x80111960,(%esp)
8010191f:	e8 bc 2e 00 00       	call   801047e0 <release>
    if(r == 1){
80101924:	83 c4 10             	add    $0x10,%esp
80101927:	83 fe 01             	cmp    $0x1,%esi
8010192a:	75 aa                	jne    801018d6 <iput+0x26>
8010192c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101932:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101935:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101938:	89 cf                	mov    %ecx,%edi
8010193a:	eb 0b                	jmp    80101947 <iput+0x97>
8010193c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101940:	83 c6 04             	add    $0x4,%esi
80101943:	39 fe                	cmp    %edi,%esi
80101945:	74 19                	je     80101960 <iput+0xb0>
    if(ip->addrs[i]){
80101947:	8b 16                	mov    (%esi),%edx
80101949:	85 d2                	test   %edx,%edx
8010194b:	74 f3                	je     80101940 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010194d:	8b 03                	mov    (%ebx),%eax
8010194f:	e8 6c f8 ff ff       	call   801011c0 <bfree>
      ip->addrs[i] = 0;
80101954:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010195a:	eb e4                	jmp    80101940 <iput+0x90>
8010195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101960:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101966:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101969:	85 c0                	test   %eax,%eax
8010196b:	75 2d                	jne    8010199a <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010196d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101970:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101977:	53                   	push   %ebx
80101978:	e8 53 fd ff ff       	call   801016d0 <iupdate>
      ip->type = 0;
8010197d:	31 c0                	xor    %eax,%eax
8010197f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101983:	89 1c 24             	mov    %ebx,(%esp)
80101986:	e8 45 fd ff ff       	call   801016d0 <iupdate>
      ip->valid = 0;
8010198b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101992:	83 c4 10             	add    $0x10,%esp
80101995:	e9 3c ff ff ff       	jmp    801018d6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
8010199a:	83 ec 08             	sub    $0x8,%esp
8010199d:	50                   	push   %eax
8010199e:	ff 33                	push   (%ebx)
801019a0:	e8 2b e7 ff ff       	call   801000d0 <bread>
801019a5:	89 7d e0             	mov    %edi,-0x20(%ebp)
801019a8:	83 c4 10             	add    $0x10,%esp
801019ab:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801019b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801019b4:	8d 70 5c             	lea    0x5c(%eax),%esi
801019b7:	89 cf                	mov    %ecx,%edi
801019b9:	eb 0c                	jmp    801019c7 <iput+0x117>
801019bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019bf:	90                   	nop
801019c0:	83 c6 04             	add    $0x4,%esi
801019c3:	39 f7                	cmp    %esi,%edi
801019c5:	74 0f                	je     801019d6 <iput+0x126>
      if(a[j])
801019c7:	8b 16                	mov    (%esi),%edx
801019c9:	85 d2                	test   %edx,%edx
801019cb:	74 f3                	je     801019c0 <iput+0x110>
        bfree(ip->dev, a[j]);
801019cd:	8b 03                	mov    (%ebx),%eax
801019cf:	e8 ec f7 ff ff       	call   801011c0 <bfree>
801019d4:	eb ea                	jmp    801019c0 <iput+0x110>
    brelse(bp);
801019d6:	83 ec 0c             	sub    $0xc,%esp
801019d9:	ff 75 e4             	push   -0x1c(%ebp)
801019dc:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019df:	e8 0c e8 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019e4:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801019ea:	8b 03                	mov    (%ebx),%eax
801019ec:	e8 cf f7 ff ff       	call   801011c0 <bfree>
    ip->addrs[NDIRECT] = 0;
801019f1:	83 c4 10             	add    $0x10,%esp
801019f4:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801019fb:	00 00 00 
801019fe:	e9 6a ff ff ff       	jmp    8010196d <iput+0xbd>
80101a03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101a10 <iunlockput>:
{
80101a10:	55                   	push   %ebp
80101a11:	89 e5                	mov    %esp,%ebp
80101a13:	56                   	push   %esi
80101a14:	53                   	push   %ebx
80101a15:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101a18:	85 db                	test   %ebx,%ebx
80101a1a:	74 34                	je     80101a50 <iunlockput+0x40>
80101a1c:	83 ec 0c             	sub    $0xc,%esp
80101a1f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a22:	56                   	push   %esi
80101a23:	e8 f8 2b 00 00       	call   80104620 <holdingsleep>
80101a28:	83 c4 10             	add    $0x10,%esp
80101a2b:	85 c0                	test   %eax,%eax
80101a2d:	74 21                	je     80101a50 <iunlockput+0x40>
80101a2f:	8b 43 08             	mov    0x8(%ebx),%eax
80101a32:	85 c0                	test   %eax,%eax
80101a34:	7e 1a                	jle    80101a50 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101a36:	83 ec 0c             	sub    $0xc,%esp
80101a39:	56                   	push   %esi
80101a3a:	e8 a1 2b 00 00       	call   801045e0 <releasesleep>
  iput(ip);
80101a3f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a42:	83 c4 10             	add    $0x10,%esp
}
80101a45:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a48:	5b                   	pop    %ebx
80101a49:	5e                   	pop    %esi
80101a4a:	5d                   	pop    %ebp
  iput(ip);
80101a4b:	e9 60 fe ff ff       	jmp    801018b0 <iput>
    panic("iunlock");
80101a50:	83 ec 0c             	sub    $0xc,%esp
80101a53:	68 1f 85 10 80       	push   $0x8010851f
80101a58:	e8 23 e9 ff ff       	call   80100380 <panic>
80101a5d:	8d 76 00             	lea    0x0(%esi),%esi

80101a60 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	8b 55 08             	mov    0x8(%ebp),%edx
80101a66:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a69:	8b 0a                	mov    (%edx),%ecx
80101a6b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a6e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a71:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a74:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a78:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a7b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a7f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a83:	8b 52 58             	mov    0x58(%edx),%edx
80101a86:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a89:	5d                   	pop    %ebp
80101a8a:	c3                   	ret    
80101a8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a8f:	90                   	nop

80101a90 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a90:	55                   	push   %ebp
80101a91:	89 e5                	mov    %esp,%ebp
80101a93:	57                   	push   %edi
80101a94:	56                   	push   %esi
80101a95:	53                   	push   %ebx
80101a96:	83 ec 1c             	sub    $0x1c,%esp
80101a99:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101a9c:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9f:	8b 75 10             	mov    0x10(%ebp),%esi
80101aa2:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101aa5:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101aa8:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101aad:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ab0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101ab3:	0f 84 a7 00 00 00    	je     80101b60 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101ab9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101abc:	8b 40 58             	mov    0x58(%eax),%eax
80101abf:	39 c6                	cmp    %eax,%esi
80101ac1:	0f 87 ba 00 00 00    	ja     80101b81 <readi+0xf1>
80101ac7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101aca:	31 c9                	xor    %ecx,%ecx
80101acc:	89 da                	mov    %ebx,%edx
80101ace:	01 f2                	add    %esi,%edx
80101ad0:	0f 92 c1             	setb   %cl
80101ad3:	89 cf                	mov    %ecx,%edi
80101ad5:	0f 82 a6 00 00 00    	jb     80101b81 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101adb:	89 c1                	mov    %eax,%ecx
80101add:	29 f1                	sub    %esi,%ecx
80101adf:	39 d0                	cmp    %edx,%eax
80101ae1:	0f 43 cb             	cmovae %ebx,%ecx
80101ae4:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ae7:	85 c9                	test   %ecx,%ecx
80101ae9:	74 67                	je     80101b52 <readi+0xc2>
80101aeb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101aef:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101af0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101af3:	89 f2                	mov    %esi,%edx
80101af5:	c1 ea 09             	shr    $0x9,%edx
80101af8:	89 d8                	mov    %ebx,%eax
80101afa:	e8 51 f9 ff ff       	call   80101450 <bmap>
80101aff:	83 ec 08             	sub    $0x8,%esp
80101b02:	50                   	push   %eax
80101b03:	ff 33                	push   (%ebx)
80101b05:	e8 c6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b0a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b0d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b12:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b14:	89 f0                	mov    %esi,%eax
80101b16:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b1b:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b1d:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101b20:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b22:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b26:	39 d9                	cmp    %ebx,%ecx
80101b28:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b2b:	83 c4 0c             	add    $0xc,%esp
80101b2e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b2f:	01 df                	add    %ebx,%edi
80101b31:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101b33:	50                   	push   %eax
80101b34:	ff 75 e0             	push   -0x20(%ebp)
80101b37:	e8 64 2e 00 00       	call   801049a0 <memmove>
    brelse(bp);
80101b3c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b3f:	89 14 24             	mov    %edx,(%esp)
80101b42:	e8 a9 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b47:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b4a:	83 c4 10             	add    $0x10,%esp
80101b4d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b50:	77 9e                	ja     80101af0 <readi+0x60>
  }
  return n;
80101b52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b58:	5b                   	pop    %ebx
80101b59:	5e                   	pop    %esi
80101b5a:	5f                   	pop    %edi
80101b5b:	5d                   	pop    %ebp
80101b5c:	c3                   	ret    
80101b5d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b64:	66 83 f8 09          	cmp    $0x9,%ax
80101b68:	77 17                	ja     80101b81 <readi+0xf1>
80101b6a:	8b 04 c5 00 19 11 80 	mov    -0x7feee700(,%eax,8),%eax
80101b71:	85 c0                	test   %eax,%eax
80101b73:	74 0c                	je     80101b81 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101b75:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b7b:	5b                   	pop    %ebx
80101b7c:	5e                   	pop    %esi
80101b7d:	5f                   	pop    %edi
80101b7e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b7f:	ff e0                	jmp    *%eax
      return -1;
80101b81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b86:	eb cd                	jmp    80101b55 <readi+0xc5>
80101b88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b8f:	90                   	nop

80101b90 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	57                   	push   %edi
80101b94:	56                   	push   %esi
80101b95:	53                   	push   %ebx
80101b96:	83 ec 1c             	sub    $0x1c,%esp
80101b99:	8b 45 08             	mov    0x8(%ebp),%eax
80101b9c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b9f:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ba2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101ba7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101baa:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101bad:	8b 75 10             	mov    0x10(%ebp),%esi
80101bb0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101bb3:	0f 84 b7 00 00 00    	je     80101c70 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101bb9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bbc:	3b 70 58             	cmp    0x58(%eax),%esi
80101bbf:	0f 87 e7 00 00 00    	ja     80101cac <writei+0x11c>
80101bc5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101bc8:	31 d2                	xor    %edx,%edx
80101bca:	89 f8                	mov    %edi,%eax
80101bcc:	01 f0                	add    %esi,%eax
80101bce:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101bd1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101bd6:	0f 87 d0 00 00 00    	ja     80101cac <writei+0x11c>
80101bdc:	85 d2                	test   %edx,%edx
80101bde:	0f 85 c8 00 00 00    	jne    80101cac <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101be4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101beb:	85 ff                	test   %edi,%edi
80101bed:	74 72                	je     80101c61 <writei+0xd1>
80101bef:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bf0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101bf3:	89 f2                	mov    %esi,%edx
80101bf5:	c1 ea 09             	shr    $0x9,%edx
80101bf8:	89 f8                	mov    %edi,%eax
80101bfa:	e8 51 f8 ff ff       	call   80101450 <bmap>
80101bff:	83 ec 08             	sub    $0x8,%esp
80101c02:	50                   	push   %eax
80101c03:	ff 37                	push   (%edi)
80101c05:	e8 c6 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c0a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101c0f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c12:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c15:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c17:	89 f0                	mov    %esi,%eax
80101c19:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c1e:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c20:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c24:	39 d9                	cmp    %ebx,%ecx
80101c26:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c29:	83 c4 0c             	add    $0xc,%esp
80101c2c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c2d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101c2f:	ff 75 dc             	push   -0x24(%ebp)
80101c32:	50                   	push   %eax
80101c33:	e8 68 2d 00 00       	call   801049a0 <memmove>
    log_write(bp);
80101c38:	89 3c 24             	mov    %edi,(%esp)
80101c3b:	e8 00 13 00 00       	call   80102f40 <log_write>
    brelse(bp);
80101c40:	89 3c 24             	mov    %edi,(%esp)
80101c43:	e8 a8 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c48:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c4b:	83 c4 10             	add    $0x10,%esp
80101c4e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c51:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c54:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c57:	77 97                	ja     80101bf0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c59:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c5c:	3b 70 58             	cmp    0x58(%eax),%esi
80101c5f:	77 37                	ja     80101c98 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c61:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c67:	5b                   	pop    %ebx
80101c68:	5e                   	pop    %esi
80101c69:	5f                   	pop    %edi
80101c6a:	5d                   	pop    %ebp
80101c6b:	c3                   	ret    
80101c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c70:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c74:	66 83 f8 09          	cmp    $0x9,%ax
80101c78:	77 32                	ja     80101cac <writei+0x11c>
80101c7a:	8b 04 c5 04 19 11 80 	mov    -0x7feee6fc(,%eax,8),%eax
80101c81:	85 c0                	test   %eax,%eax
80101c83:	74 27                	je     80101cac <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101c85:	89 55 10             	mov    %edx,0x10(%ebp)
}
80101c88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c8b:	5b                   	pop    %ebx
80101c8c:	5e                   	pop    %esi
80101c8d:	5f                   	pop    %edi
80101c8e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c8f:	ff e0                	jmp    *%eax
80101c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c98:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c9b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101c9e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101ca1:	50                   	push   %eax
80101ca2:	e8 29 fa ff ff       	call   801016d0 <iupdate>
80101ca7:	83 c4 10             	add    $0x10,%esp
80101caa:	eb b5                	jmp    80101c61 <writei+0xd1>
      return -1;
80101cac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cb1:	eb b1                	jmp    80101c64 <writei+0xd4>
80101cb3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101cc0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101cc0:	55                   	push   %ebp
80101cc1:	89 e5                	mov    %esp,%ebp
80101cc3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101cc6:	6a 0e                	push   $0xe
80101cc8:	ff 75 0c             	push   0xc(%ebp)
80101ccb:	ff 75 08             	push   0x8(%ebp)
80101cce:	e8 3d 2d 00 00       	call   80104a10 <strncmp>
}
80101cd3:	c9                   	leave  
80101cd4:	c3                   	ret    
80101cd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ce0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101ce0:	55                   	push   %ebp
80101ce1:	89 e5                	mov    %esp,%ebp
80101ce3:	57                   	push   %edi
80101ce4:	56                   	push   %esi
80101ce5:	53                   	push   %ebx
80101ce6:	83 ec 1c             	sub    $0x1c,%esp
80101ce9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101cec:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101cf1:	0f 85 85 00 00 00    	jne    80101d7c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101cf7:	8b 53 58             	mov    0x58(%ebx),%edx
80101cfa:	31 ff                	xor    %edi,%edi
80101cfc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101cff:	85 d2                	test   %edx,%edx
80101d01:	74 3e                	je     80101d41 <dirlookup+0x61>
80101d03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d07:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d08:	6a 10                	push   $0x10
80101d0a:	57                   	push   %edi
80101d0b:	56                   	push   %esi
80101d0c:	53                   	push   %ebx
80101d0d:	e8 7e fd ff ff       	call   80101a90 <readi>
80101d12:	83 c4 10             	add    $0x10,%esp
80101d15:	83 f8 10             	cmp    $0x10,%eax
80101d18:	75 55                	jne    80101d6f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101d1a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d1f:	74 18                	je     80101d39 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d21:	83 ec 04             	sub    $0x4,%esp
80101d24:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d27:	6a 0e                	push   $0xe
80101d29:	50                   	push   %eax
80101d2a:	ff 75 0c             	push   0xc(%ebp)
80101d2d:	e8 de 2c 00 00       	call   80104a10 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101d32:	83 c4 10             	add    $0x10,%esp
80101d35:	85 c0                	test   %eax,%eax
80101d37:	74 17                	je     80101d50 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d39:	83 c7 10             	add    $0x10,%edi
80101d3c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101d3f:	72 c7                	jb     80101d08 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101d41:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101d44:	31 c0                	xor    %eax,%eax
}
80101d46:	5b                   	pop    %ebx
80101d47:	5e                   	pop    %esi
80101d48:	5f                   	pop    %edi
80101d49:	5d                   	pop    %ebp
80101d4a:	c3                   	ret    
80101d4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d4f:	90                   	nop
      if(poff)
80101d50:	8b 45 10             	mov    0x10(%ebp),%eax
80101d53:	85 c0                	test   %eax,%eax
80101d55:	74 05                	je     80101d5c <dirlookup+0x7c>
        *poff = off;
80101d57:	8b 45 10             	mov    0x10(%ebp),%eax
80101d5a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d5c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d60:	8b 03                	mov    (%ebx),%eax
80101d62:	e8 e9 f5 ff ff       	call   80101350 <iget>
}
80101d67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d6a:	5b                   	pop    %ebx
80101d6b:	5e                   	pop    %esi
80101d6c:	5f                   	pop    %edi
80101d6d:	5d                   	pop    %ebp
80101d6e:	c3                   	ret    
      panic("dirlookup read");
80101d6f:	83 ec 0c             	sub    $0xc,%esp
80101d72:	68 39 85 10 80       	push   $0x80108539
80101d77:	e8 04 e6 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101d7c:	83 ec 0c             	sub    $0xc,%esp
80101d7f:	68 27 85 10 80       	push   $0x80108527
80101d84:	e8 f7 e5 ff ff       	call   80100380 <panic>
80101d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d90 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d90:	55                   	push   %ebp
80101d91:	89 e5                	mov    %esp,%ebp
80101d93:	57                   	push   %edi
80101d94:	56                   	push   %esi
80101d95:	53                   	push   %ebx
80101d96:	89 c3                	mov    %eax,%ebx
80101d98:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d9b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d9e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101da1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101da4:	0f 84 64 01 00 00    	je     80101f0e <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101daa:	e8 21 1c 00 00       	call   801039d0 <myproc>
  acquire(&icache.lock);
80101daf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101db2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101db5:	68 60 19 11 80       	push   $0x80111960
80101dba:	e8 81 2a 00 00       	call   80104840 <acquire>
  ip->ref++;
80101dbf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101dc3:	c7 04 24 60 19 11 80 	movl   $0x80111960,(%esp)
80101dca:	e8 11 2a 00 00       	call   801047e0 <release>
80101dcf:	83 c4 10             	add    $0x10,%esp
80101dd2:	eb 07                	jmp    80101ddb <namex+0x4b>
80101dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101dd8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101ddb:	0f b6 03             	movzbl (%ebx),%eax
80101dde:	3c 2f                	cmp    $0x2f,%al
80101de0:	74 f6                	je     80101dd8 <namex+0x48>
  if(*path == 0)
80101de2:	84 c0                	test   %al,%al
80101de4:	0f 84 06 01 00 00    	je     80101ef0 <namex+0x160>
  while(*path != '/' && *path != 0)
80101dea:	0f b6 03             	movzbl (%ebx),%eax
80101ded:	84 c0                	test   %al,%al
80101def:	0f 84 10 01 00 00    	je     80101f05 <namex+0x175>
80101df5:	89 df                	mov    %ebx,%edi
80101df7:	3c 2f                	cmp    $0x2f,%al
80101df9:	0f 84 06 01 00 00    	je     80101f05 <namex+0x175>
80101dff:	90                   	nop
80101e00:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101e04:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101e07:	3c 2f                	cmp    $0x2f,%al
80101e09:	74 04                	je     80101e0f <namex+0x7f>
80101e0b:	84 c0                	test   %al,%al
80101e0d:	75 f1                	jne    80101e00 <namex+0x70>
  len = path - s;
80101e0f:	89 f8                	mov    %edi,%eax
80101e11:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101e13:	83 f8 0d             	cmp    $0xd,%eax
80101e16:	0f 8e ac 00 00 00    	jle    80101ec8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101e1c:	83 ec 04             	sub    $0x4,%esp
80101e1f:	6a 0e                	push   $0xe
80101e21:	53                   	push   %ebx
    path++;
80101e22:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80101e24:	ff 75 e4             	push   -0x1c(%ebp)
80101e27:	e8 74 2b 00 00       	call   801049a0 <memmove>
80101e2c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101e2f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101e32:	75 0c                	jne    80101e40 <namex+0xb0>
80101e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e38:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e3b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e3e:	74 f8                	je     80101e38 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e40:	83 ec 0c             	sub    $0xc,%esp
80101e43:	56                   	push   %esi
80101e44:	e8 37 f9 ff ff       	call   80101780 <ilock>
    if(ip->type != T_DIR){
80101e49:	83 c4 10             	add    $0x10,%esp
80101e4c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e51:	0f 85 cd 00 00 00    	jne    80101f24 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e57:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e5a:	85 c0                	test   %eax,%eax
80101e5c:	74 09                	je     80101e67 <namex+0xd7>
80101e5e:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e61:	0f 84 22 01 00 00    	je     80101f89 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e67:	83 ec 04             	sub    $0x4,%esp
80101e6a:	6a 00                	push   $0x0
80101e6c:	ff 75 e4             	push   -0x1c(%ebp)
80101e6f:	56                   	push   %esi
80101e70:	e8 6b fe ff ff       	call   80101ce0 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101e75:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80101e78:	83 c4 10             	add    $0x10,%esp
80101e7b:	89 c7                	mov    %eax,%edi
80101e7d:	85 c0                	test   %eax,%eax
80101e7f:	0f 84 e1 00 00 00    	je     80101f66 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101e85:	83 ec 0c             	sub    $0xc,%esp
80101e88:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101e8b:	52                   	push   %edx
80101e8c:	e8 8f 27 00 00       	call   80104620 <holdingsleep>
80101e91:	83 c4 10             	add    $0x10,%esp
80101e94:	85 c0                	test   %eax,%eax
80101e96:	0f 84 30 01 00 00    	je     80101fcc <namex+0x23c>
80101e9c:	8b 56 08             	mov    0x8(%esi),%edx
80101e9f:	85 d2                	test   %edx,%edx
80101ea1:	0f 8e 25 01 00 00    	jle    80101fcc <namex+0x23c>
  releasesleep(&ip->lock);
80101ea7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101eaa:	83 ec 0c             	sub    $0xc,%esp
80101ead:	52                   	push   %edx
80101eae:	e8 2d 27 00 00       	call   801045e0 <releasesleep>
  iput(ip);
80101eb3:	89 34 24             	mov    %esi,(%esp)
80101eb6:	89 fe                	mov    %edi,%esi
80101eb8:	e8 f3 f9 ff ff       	call   801018b0 <iput>
80101ebd:	83 c4 10             	add    $0x10,%esp
80101ec0:	e9 16 ff ff ff       	jmp    80101ddb <namex+0x4b>
80101ec5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101ec8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101ecb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
80101ece:	83 ec 04             	sub    $0x4,%esp
80101ed1:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101ed4:	50                   	push   %eax
80101ed5:	53                   	push   %ebx
    name[len] = 0;
80101ed6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80101ed8:	ff 75 e4             	push   -0x1c(%ebp)
80101edb:	e8 c0 2a 00 00       	call   801049a0 <memmove>
    name[len] = 0;
80101ee0:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101ee3:	83 c4 10             	add    $0x10,%esp
80101ee6:	c6 02 00             	movb   $0x0,(%edx)
80101ee9:	e9 41 ff ff ff       	jmp    80101e2f <namex+0x9f>
80101eee:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101ef0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101ef3:	85 c0                	test   %eax,%eax
80101ef5:	0f 85 be 00 00 00    	jne    80101fb9 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
80101efb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101efe:	89 f0                	mov    %esi,%eax
80101f00:	5b                   	pop    %ebx
80101f01:	5e                   	pop    %esi
80101f02:	5f                   	pop    %edi
80101f03:	5d                   	pop    %ebp
80101f04:	c3                   	ret    
  while(*path != '/' && *path != 0)
80101f05:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f08:	89 df                	mov    %ebx,%edi
80101f0a:	31 c0                	xor    %eax,%eax
80101f0c:	eb c0                	jmp    80101ece <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
80101f0e:	ba 01 00 00 00       	mov    $0x1,%edx
80101f13:	b8 01 00 00 00       	mov    $0x1,%eax
80101f18:	e8 33 f4 ff ff       	call   80101350 <iget>
80101f1d:	89 c6                	mov    %eax,%esi
80101f1f:	e9 b7 fe ff ff       	jmp    80101ddb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f24:	83 ec 0c             	sub    $0xc,%esp
80101f27:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f2a:	53                   	push   %ebx
80101f2b:	e8 f0 26 00 00       	call   80104620 <holdingsleep>
80101f30:	83 c4 10             	add    $0x10,%esp
80101f33:	85 c0                	test   %eax,%eax
80101f35:	0f 84 91 00 00 00    	je     80101fcc <namex+0x23c>
80101f3b:	8b 46 08             	mov    0x8(%esi),%eax
80101f3e:	85 c0                	test   %eax,%eax
80101f40:	0f 8e 86 00 00 00    	jle    80101fcc <namex+0x23c>
  releasesleep(&ip->lock);
80101f46:	83 ec 0c             	sub    $0xc,%esp
80101f49:	53                   	push   %ebx
80101f4a:	e8 91 26 00 00       	call   801045e0 <releasesleep>
  iput(ip);
80101f4f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101f52:	31 f6                	xor    %esi,%esi
  iput(ip);
80101f54:	e8 57 f9 ff ff       	call   801018b0 <iput>
      return 0;
80101f59:	83 c4 10             	add    $0x10,%esp
}
80101f5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f5f:	89 f0                	mov    %esi,%eax
80101f61:	5b                   	pop    %ebx
80101f62:	5e                   	pop    %esi
80101f63:	5f                   	pop    %edi
80101f64:	5d                   	pop    %ebp
80101f65:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f66:	83 ec 0c             	sub    $0xc,%esp
80101f69:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101f6c:	52                   	push   %edx
80101f6d:	e8 ae 26 00 00       	call   80104620 <holdingsleep>
80101f72:	83 c4 10             	add    $0x10,%esp
80101f75:	85 c0                	test   %eax,%eax
80101f77:	74 53                	je     80101fcc <namex+0x23c>
80101f79:	8b 4e 08             	mov    0x8(%esi),%ecx
80101f7c:	85 c9                	test   %ecx,%ecx
80101f7e:	7e 4c                	jle    80101fcc <namex+0x23c>
  releasesleep(&ip->lock);
80101f80:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f83:	83 ec 0c             	sub    $0xc,%esp
80101f86:	52                   	push   %edx
80101f87:	eb c1                	jmp    80101f4a <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f89:	83 ec 0c             	sub    $0xc,%esp
80101f8c:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f8f:	53                   	push   %ebx
80101f90:	e8 8b 26 00 00       	call   80104620 <holdingsleep>
80101f95:	83 c4 10             	add    $0x10,%esp
80101f98:	85 c0                	test   %eax,%eax
80101f9a:	74 30                	je     80101fcc <namex+0x23c>
80101f9c:	8b 7e 08             	mov    0x8(%esi),%edi
80101f9f:	85 ff                	test   %edi,%edi
80101fa1:	7e 29                	jle    80101fcc <namex+0x23c>
  releasesleep(&ip->lock);
80101fa3:	83 ec 0c             	sub    $0xc,%esp
80101fa6:	53                   	push   %ebx
80101fa7:	e8 34 26 00 00       	call   801045e0 <releasesleep>
}
80101fac:	83 c4 10             	add    $0x10,%esp
}
80101faf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fb2:	89 f0                	mov    %esi,%eax
80101fb4:	5b                   	pop    %ebx
80101fb5:	5e                   	pop    %esi
80101fb6:	5f                   	pop    %edi
80101fb7:	5d                   	pop    %ebp
80101fb8:	c3                   	ret    
    iput(ip);
80101fb9:	83 ec 0c             	sub    $0xc,%esp
80101fbc:	56                   	push   %esi
    return 0;
80101fbd:	31 f6                	xor    %esi,%esi
    iput(ip);
80101fbf:	e8 ec f8 ff ff       	call   801018b0 <iput>
    return 0;
80101fc4:	83 c4 10             	add    $0x10,%esp
80101fc7:	e9 2f ff ff ff       	jmp    80101efb <namex+0x16b>
    panic("iunlock");
80101fcc:	83 ec 0c             	sub    $0xc,%esp
80101fcf:	68 1f 85 10 80       	push   $0x8010851f
80101fd4:	e8 a7 e3 ff ff       	call   80100380 <panic>
80101fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101fe0 <dirlink>:
{
80101fe0:	55                   	push   %ebp
80101fe1:	89 e5                	mov    %esp,%ebp
80101fe3:	57                   	push   %edi
80101fe4:	56                   	push   %esi
80101fe5:	53                   	push   %ebx
80101fe6:	83 ec 20             	sub    $0x20,%esp
80101fe9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101fec:	6a 00                	push   $0x0
80101fee:	ff 75 0c             	push   0xc(%ebp)
80101ff1:	53                   	push   %ebx
80101ff2:	e8 e9 fc ff ff       	call   80101ce0 <dirlookup>
80101ff7:	83 c4 10             	add    $0x10,%esp
80101ffa:	85 c0                	test   %eax,%eax
80101ffc:	75 67                	jne    80102065 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101ffe:	8b 7b 58             	mov    0x58(%ebx),%edi
80102001:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102004:	85 ff                	test   %edi,%edi
80102006:	74 29                	je     80102031 <dirlink+0x51>
80102008:	31 ff                	xor    %edi,%edi
8010200a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010200d:	eb 09                	jmp    80102018 <dirlink+0x38>
8010200f:	90                   	nop
80102010:	83 c7 10             	add    $0x10,%edi
80102013:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102016:	73 19                	jae    80102031 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102018:	6a 10                	push   $0x10
8010201a:	57                   	push   %edi
8010201b:	56                   	push   %esi
8010201c:	53                   	push   %ebx
8010201d:	e8 6e fa ff ff       	call   80101a90 <readi>
80102022:	83 c4 10             	add    $0x10,%esp
80102025:	83 f8 10             	cmp    $0x10,%eax
80102028:	75 4e                	jne    80102078 <dirlink+0x98>
    if(de.inum == 0)
8010202a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010202f:	75 df                	jne    80102010 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102031:	83 ec 04             	sub    $0x4,%esp
80102034:	8d 45 da             	lea    -0x26(%ebp),%eax
80102037:	6a 0e                	push   $0xe
80102039:	ff 75 0c             	push   0xc(%ebp)
8010203c:	50                   	push   %eax
8010203d:	e8 1e 2a 00 00       	call   80104a60 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102042:	6a 10                	push   $0x10
  de.inum = inum;
80102044:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102047:	57                   	push   %edi
80102048:	56                   	push   %esi
80102049:	53                   	push   %ebx
  de.inum = inum;
8010204a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010204e:	e8 3d fb ff ff       	call   80101b90 <writei>
80102053:	83 c4 20             	add    $0x20,%esp
80102056:	83 f8 10             	cmp    $0x10,%eax
80102059:	75 2a                	jne    80102085 <dirlink+0xa5>
  return 0;
8010205b:	31 c0                	xor    %eax,%eax
}
8010205d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102060:	5b                   	pop    %ebx
80102061:	5e                   	pop    %esi
80102062:	5f                   	pop    %edi
80102063:	5d                   	pop    %ebp
80102064:	c3                   	ret    
    iput(ip);
80102065:	83 ec 0c             	sub    $0xc,%esp
80102068:	50                   	push   %eax
80102069:	e8 42 f8 ff ff       	call   801018b0 <iput>
    return -1;
8010206e:	83 c4 10             	add    $0x10,%esp
80102071:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102076:	eb e5                	jmp    8010205d <dirlink+0x7d>
      panic("dirlink read");
80102078:	83 ec 0c             	sub    $0xc,%esp
8010207b:	68 48 85 10 80       	push   $0x80108548
80102080:	e8 fb e2 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102085:	83 ec 0c             	sub    $0xc,%esp
80102088:	68 72 8b 10 80       	push   $0x80108b72
8010208d:	e8 ee e2 ff ff       	call   80100380 <panic>
80102092:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801020a0 <namei>:

struct inode*
namei(char *path)
{
801020a0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801020a1:	31 d2                	xor    %edx,%edx
{
801020a3:	89 e5                	mov    %esp,%ebp
801020a5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801020a8:	8b 45 08             	mov    0x8(%ebp),%eax
801020ab:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801020ae:	e8 dd fc ff ff       	call   80101d90 <namex>
}
801020b3:	c9                   	leave  
801020b4:	c3                   	ret    
801020b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020c0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801020c0:	55                   	push   %ebp
  return namex(path, 1, name);
801020c1:	ba 01 00 00 00       	mov    $0x1,%edx
{
801020c6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801020c8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801020cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
801020ce:	5d                   	pop    %ebp
  return namex(path, 1, name);
801020cf:	e9 bc fc ff ff       	jmp    80101d90 <namex>
801020d4:	66 90                	xchg   %ax,%ax
801020d6:	66 90                	xchg   %ax,%ax
801020d8:	66 90                	xchg   %ax,%ax
801020da:	66 90                	xchg   %ax,%ax
801020dc:	66 90                	xchg   %ax,%ax
801020de:	66 90                	xchg   %ax,%ax

801020e0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801020e0:	55                   	push   %ebp
801020e1:	89 e5                	mov    %esp,%ebp
801020e3:	57                   	push   %edi
801020e4:	56                   	push   %esi
801020e5:	53                   	push   %ebx
801020e6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801020e9:	85 c0                	test   %eax,%eax
801020eb:	0f 84 b4 00 00 00    	je     801021a5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801020f1:	8b 70 08             	mov    0x8(%eax),%esi
801020f4:	89 c3                	mov    %eax,%ebx
801020f6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801020fc:	0f 87 96 00 00 00    	ja     80102198 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102102:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102107:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010210e:	66 90                	xchg   %ax,%ax
80102110:	89 ca                	mov    %ecx,%edx
80102112:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102113:	83 e0 c0             	and    $0xffffffc0,%eax
80102116:	3c 40                	cmp    $0x40,%al
80102118:	75 f6                	jne    80102110 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010211a:	31 ff                	xor    %edi,%edi
8010211c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102121:	89 f8                	mov    %edi,%eax
80102123:	ee                   	out    %al,(%dx)
80102124:	b8 01 00 00 00       	mov    $0x1,%eax
80102129:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010212e:	ee                   	out    %al,(%dx)
8010212f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102134:	89 f0                	mov    %esi,%eax
80102136:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102137:	89 f0                	mov    %esi,%eax
80102139:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010213e:	c1 f8 08             	sar    $0x8,%eax
80102141:	ee                   	out    %al,(%dx)
80102142:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102147:	89 f8                	mov    %edi,%eax
80102149:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010214a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010214e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102153:	c1 e0 04             	shl    $0x4,%eax
80102156:	83 e0 10             	and    $0x10,%eax
80102159:	83 c8 e0             	or     $0xffffffe0,%eax
8010215c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010215d:	f6 03 04             	testb  $0x4,(%ebx)
80102160:	75 16                	jne    80102178 <idestart+0x98>
80102162:	b8 20 00 00 00       	mov    $0x20,%eax
80102167:	89 ca                	mov    %ecx,%edx
80102169:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010216a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010216d:	5b                   	pop    %ebx
8010216e:	5e                   	pop    %esi
8010216f:	5f                   	pop    %edi
80102170:	5d                   	pop    %ebp
80102171:	c3                   	ret    
80102172:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102178:	b8 30 00 00 00       	mov    $0x30,%eax
8010217d:	89 ca                	mov    %ecx,%edx
8010217f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102180:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102185:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102188:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010218d:	fc                   	cld    
8010218e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102190:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102193:	5b                   	pop    %ebx
80102194:	5e                   	pop    %esi
80102195:	5f                   	pop    %edi
80102196:	5d                   	pop    %ebp
80102197:	c3                   	ret    
    panic("incorrect blockno");
80102198:	83 ec 0c             	sub    $0xc,%esp
8010219b:	68 b4 85 10 80       	push   $0x801085b4
801021a0:	e8 db e1 ff ff       	call   80100380 <panic>
    panic("idestart");
801021a5:	83 ec 0c             	sub    $0xc,%esp
801021a8:	68 ab 85 10 80       	push   $0x801085ab
801021ad:	e8 ce e1 ff ff       	call   80100380 <panic>
801021b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021c0 <ideinit>:
{
801021c0:	55                   	push   %ebp
801021c1:	89 e5                	mov    %esp,%ebp
801021c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801021c6:	68 c6 85 10 80       	push   $0x801085c6
801021cb:	68 00 36 11 80       	push   $0x80113600
801021d0:	e8 9b 24 00 00       	call   80104670 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801021d5:	58                   	pop    %eax
801021d6:	a1 84 37 11 80       	mov    0x80113784,%eax
801021db:	5a                   	pop    %edx
801021dc:	83 e8 01             	sub    $0x1,%eax
801021df:	50                   	push   %eax
801021e0:	6a 0e                	push   $0xe
801021e2:	e8 99 02 00 00       	call   80102480 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021e7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021ea:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021ef:	90                   	nop
801021f0:	ec                   	in     (%dx),%al
801021f1:	83 e0 c0             	and    $0xffffffc0,%eax
801021f4:	3c 40                	cmp    $0x40,%al
801021f6:	75 f8                	jne    801021f0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021f8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801021fd:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102202:	ee                   	out    %al,(%dx)
80102203:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102208:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010220d:	eb 06                	jmp    80102215 <ideinit+0x55>
8010220f:	90                   	nop
  for(i=0; i<1000; i++){
80102210:	83 e9 01             	sub    $0x1,%ecx
80102213:	74 0f                	je     80102224 <ideinit+0x64>
80102215:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102216:	84 c0                	test   %al,%al
80102218:	74 f6                	je     80102210 <ideinit+0x50>
      havedisk1 = 1;
8010221a:	c7 05 e0 35 11 80 01 	movl   $0x1,0x801135e0
80102221:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102224:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102229:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010222e:	ee                   	out    %al,(%dx)
}
8010222f:	c9                   	leave  
80102230:	c3                   	ret    
80102231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010223f:	90                   	nop

80102240 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	57                   	push   %edi
80102244:	56                   	push   %esi
80102245:	53                   	push   %ebx
80102246:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102249:	68 00 36 11 80       	push   $0x80113600
8010224e:	e8 ed 25 00 00       	call   80104840 <acquire>

  if((b = idequeue) == 0){
80102253:	8b 1d e4 35 11 80    	mov    0x801135e4,%ebx
80102259:	83 c4 10             	add    $0x10,%esp
8010225c:	85 db                	test   %ebx,%ebx
8010225e:	74 63                	je     801022c3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102260:	8b 43 58             	mov    0x58(%ebx),%eax
80102263:	a3 e4 35 11 80       	mov    %eax,0x801135e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102268:	8b 33                	mov    (%ebx),%esi
8010226a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102270:	75 2f                	jne    801022a1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102272:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010227e:	66 90                	xchg   %ax,%ax
80102280:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102281:	89 c1                	mov    %eax,%ecx
80102283:	83 e1 c0             	and    $0xffffffc0,%ecx
80102286:	80 f9 40             	cmp    $0x40,%cl
80102289:	75 f5                	jne    80102280 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010228b:	a8 21                	test   $0x21,%al
8010228d:	75 12                	jne    801022a1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010228f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102292:	b9 80 00 00 00       	mov    $0x80,%ecx
80102297:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010229c:	fc                   	cld    
8010229d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010229f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
801022a1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801022a4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801022a7:	83 ce 02             	or     $0x2,%esi
801022aa:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801022ac:	53                   	push   %ebx
801022ad:	e8 ee 20 00 00       	call   801043a0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801022b2:	a1 e4 35 11 80       	mov    0x801135e4,%eax
801022b7:	83 c4 10             	add    $0x10,%esp
801022ba:	85 c0                	test   %eax,%eax
801022bc:	74 05                	je     801022c3 <ideintr+0x83>
    idestart(idequeue);
801022be:	e8 1d fe ff ff       	call   801020e0 <idestart>
    release(&idelock);
801022c3:	83 ec 0c             	sub    $0xc,%esp
801022c6:	68 00 36 11 80       	push   $0x80113600
801022cb:	e8 10 25 00 00       	call   801047e0 <release>

  release(&idelock);
}
801022d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022d3:	5b                   	pop    %ebx
801022d4:	5e                   	pop    %esi
801022d5:	5f                   	pop    %edi
801022d6:	5d                   	pop    %ebp
801022d7:	c3                   	ret    
801022d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022df:	90                   	nop

801022e0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801022e0:	55                   	push   %ebp
801022e1:	89 e5                	mov    %esp,%ebp
801022e3:	53                   	push   %ebx
801022e4:	83 ec 10             	sub    $0x10,%esp
801022e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801022ea:	8d 43 0c             	lea    0xc(%ebx),%eax
801022ed:	50                   	push   %eax
801022ee:	e8 2d 23 00 00       	call   80104620 <holdingsleep>
801022f3:	83 c4 10             	add    $0x10,%esp
801022f6:	85 c0                	test   %eax,%eax
801022f8:	0f 84 c3 00 00 00    	je     801023c1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801022fe:	8b 03                	mov    (%ebx),%eax
80102300:	83 e0 06             	and    $0x6,%eax
80102303:	83 f8 02             	cmp    $0x2,%eax
80102306:	0f 84 a8 00 00 00    	je     801023b4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010230c:	8b 53 04             	mov    0x4(%ebx),%edx
8010230f:	85 d2                	test   %edx,%edx
80102311:	74 0d                	je     80102320 <iderw+0x40>
80102313:	a1 e0 35 11 80       	mov    0x801135e0,%eax
80102318:	85 c0                	test   %eax,%eax
8010231a:	0f 84 87 00 00 00    	je     801023a7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102320:	83 ec 0c             	sub    $0xc,%esp
80102323:	68 00 36 11 80       	push   $0x80113600
80102328:	e8 13 25 00 00       	call   80104840 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010232d:	a1 e4 35 11 80       	mov    0x801135e4,%eax
  b->qnext = 0;
80102332:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102339:	83 c4 10             	add    $0x10,%esp
8010233c:	85 c0                	test   %eax,%eax
8010233e:	74 60                	je     801023a0 <iderw+0xc0>
80102340:	89 c2                	mov    %eax,%edx
80102342:	8b 40 58             	mov    0x58(%eax),%eax
80102345:	85 c0                	test   %eax,%eax
80102347:	75 f7                	jne    80102340 <iderw+0x60>
80102349:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010234c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010234e:	39 1d e4 35 11 80    	cmp    %ebx,0x801135e4
80102354:	74 3a                	je     80102390 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102356:	8b 03                	mov    (%ebx),%eax
80102358:	83 e0 06             	and    $0x6,%eax
8010235b:	83 f8 02             	cmp    $0x2,%eax
8010235e:	74 1b                	je     8010237b <iderw+0x9b>
    sleep(b, &idelock);
80102360:	83 ec 08             	sub    $0x8,%esp
80102363:	68 00 36 11 80       	push   $0x80113600
80102368:	53                   	push   %ebx
80102369:	e8 72 1f 00 00       	call   801042e0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010236e:	8b 03                	mov    (%ebx),%eax
80102370:	83 c4 10             	add    $0x10,%esp
80102373:	83 e0 06             	and    $0x6,%eax
80102376:	83 f8 02             	cmp    $0x2,%eax
80102379:	75 e5                	jne    80102360 <iderw+0x80>
  }


  release(&idelock);
8010237b:	c7 45 08 00 36 11 80 	movl   $0x80113600,0x8(%ebp)
}
80102382:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102385:	c9                   	leave  
  release(&idelock);
80102386:	e9 55 24 00 00       	jmp    801047e0 <release>
8010238b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010238f:	90                   	nop
    idestart(b);
80102390:	89 d8                	mov    %ebx,%eax
80102392:	e8 49 fd ff ff       	call   801020e0 <idestart>
80102397:	eb bd                	jmp    80102356 <iderw+0x76>
80102399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023a0:	ba e4 35 11 80       	mov    $0x801135e4,%edx
801023a5:	eb a5                	jmp    8010234c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801023a7:	83 ec 0c             	sub    $0xc,%esp
801023aa:	68 f5 85 10 80       	push   $0x801085f5
801023af:	e8 cc df ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
801023b4:	83 ec 0c             	sub    $0xc,%esp
801023b7:	68 e0 85 10 80       	push   $0x801085e0
801023bc:	e8 bf df ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
801023c1:	83 ec 0c             	sub    $0xc,%esp
801023c4:	68 ca 85 10 80       	push   $0x801085ca
801023c9:	e8 b2 df ff ff       	call   80100380 <panic>
801023ce:	66 90                	xchg   %ax,%ax

801023d0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801023d0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801023d1:	c7 05 34 36 11 80 00 	movl   $0xfec00000,0x80113634
801023d8:	00 c0 fe 
{
801023db:	89 e5                	mov    %esp,%ebp
801023dd:	56                   	push   %esi
801023de:	53                   	push   %ebx
  ioapic->reg = reg;
801023df:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801023e6:	00 00 00 
  return ioapic->data;
801023e9:	8b 15 34 36 11 80    	mov    0x80113634,%edx
801023ef:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801023f2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801023f8:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801023fe:	0f b6 15 80 37 11 80 	movzbl 0x80113780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102405:	c1 ee 10             	shr    $0x10,%esi
80102408:	89 f0                	mov    %esi,%eax
8010240a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010240d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102410:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102413:	39 c2                	cmp    %eax,%edx
80102415:	74 16                	je     8010242d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102417:	83 ec 0c             	sub    $0xc,%esp
8010241a:	68 14 86 10 80       	push   $0x80108614
8010241f:	e8 7c e2 ff ff       	call   801006a0 <cprintf>
  ioapic->reg = reg;
80102424:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
8010242a:	83 c4 10             	add    $0x10,%esp
8010242d:	83 c6 21             	add    $0x21,%esi
{
80102430:	ba 10 00 00 00       	mov    $0x10,%edx
80102435:	b8 20 00 00 00       	mov    $0x20,%eax
8010243a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102440:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102442:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102444:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
  for(i = 0; i <= maxintr; i++){
8010244a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010244d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102453:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102456:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
80102459:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010245c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010245e:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
80102464:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010246b:	39 f0                	cmp    %esi,%eax
8010246d:	75 d1                	jne    80102440 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010246f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102472:	5b                   	pop    %ebx
80102473:	5e                   	pop    %esi
80102474:	5d                   	pop    %ebp
80102475:	c3                   	ret    
80102476:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010247d:	8d 76 00             	lea    0x0(%esi),%esi

80102480 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102480:	55                   	push   %ebp
  ioapic->reg = reg;
80102481:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
{
80102487:	89 e5                	mov    %esp,%ebp
80102489:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010248c:	8d 50 20             	lea    0x20(%eax),%edx
8010248f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102493:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102495:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010249b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010249e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801024a4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801024a6:	a1 34 36 11 80       	mov    0x80113634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024ab:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801024ae:	89 50 10             	mov    %edx,0x10(%eax)
}
801024b1:	5d                   	pop    %ebp
801024b2:	c3                   	ret    
801024b3:	66 90                	xchg   %ax,%ax
801024b5:	66 90                	xchg   %ax,%ax
801024b7:	66 90                	xchg   %ax,%ax
801024b9:	66 90                	xchg   %ax,%ax
801024bb:	66 90                	xchg   %ax,%ax
801024bd:	66 90                	xchg   %ax,%ax
801024bf:	90                   	nop

801024c0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801024c0:	55                   	push   %ebp
801024c1:	89 e5                	mov    %esp,%ebp
801024c3:	53                   	push   %ebx
801024c4:	83 ec 04             	sub    $0x4,%esp
801024c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801024ca:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801024d0:	75 76                	jne    80102548 <kfree+0x88>
801024d2:	81 fb d0 c6 11 80    	cmp    $0x8011c6d0,%ebx
801024d8:	72 6e                	jb     80102548 <kfree+0x88>
801024da:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024e0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024e5:	77 61                	ja     80102548 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801024e7:	83 ec 04             	sub    $0x4,%esp
801024ea:	68 00 10 00 00       	push   $0x1000
801024ef:	6a 01                	push   $0x1
801024f1:	53                   	push   %ebx
801024f2:	e8 09 24 00 00       	call   80104900 <memset>

  if(kmem.use_lock)
801024f7:	8b 15 74 36 11 80    	mov    0x80113674,%edx
801024fd:	83 c4 10             	add    $0x10,%esp
80102500:	85 d2                	test   %edx,%edx
80102502:	75 1c                	jne    80102520 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102504:	a1 78 36 11 80       	mov    0x80113678,%eax
80102509:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010250b:	a1 74 36 11 80       	mov    0x80113674,%eax
  kmem.freelist = r;
80102510:	89 1d 78 36 11 80    	mov    %ebx,0x80113678
  if(kmem.use_lock)
80102516:	85 c0                	test   %eax,%eax
80102518:	75 1e                	jne    80102538 <kfree+0x78>
    release(&kmem.lock);
}
8010251a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010251d:	c9                   	leave  
8010251e:	c3                   	ret    
8010251f:	90                   	nop
    acquire(&kmem.lock);
80102520:	83 ec 0c             	sub    $0xc,%esp
80102523:	68 40 36 11 80       	push   $0x80113640
80102528:	e8 13 23 00 00       	call   80104840 <acquire>
8010252d:	83 c4 10             	add    $0x10,%esp
80102530:	eb d2                	jmp    80102504 <kfree+0x44>
80102532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102538:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)
}
8010253f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102542:	c9                   	leave  
    release(&kmem.lock);
80102543:	e9 98 22 00 00       	jmp    801047e0 <release>
    panic("kfree");
80102548:	83 ec 0c             	sub    $0xc,%esp
8010254b:	68 46 86 10 80       	push   $0x80108646
80102550:	e8 2b de ff ff       	call   80100380 <panic>
80102555:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010255c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102560 <freerange>:
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102564:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102567:	8b 75 0c             	mov    0xc(%ebp),%esi
8010256a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010256b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102571:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102577:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010257d:	39 de                	cmp    %ebx,%esi
8010257f:	72 23                	jb     801025a4 <freerange+0x44>
80102581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102588:	83 ec 0c             	sub    $0xc,%esp
8010258b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102591:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102597:	50                   	push   %eax
80102598:	e8 23 ff ff ff       	call   801024c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010259d:	83 c4 10             	add    $0x10,%esp
801025a0:	39 f3                	cmp    %esi,%ebx
801025a2:	76 e4                	jbe    80102588 <freerange+0x28>
}
801025a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025a7:	5b                   	pop    %ebx
801025a8:	5e                   	pop    %esi
801025a9:	5d                   	pop    %ebp
801025aa:	c3                   	ret    
801025ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025af:	90                   	nop

801025b0 <kinit2>:
{
801025b0:	55                   	push   %ebp
801025b1:	89 e5                	mov    %esp,%ebp
801025b3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801025b4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025b7:	8b 75 0c             	mov    0xc(%ebp),%esi
801025ba:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025cd:	39 de                	cmp    %ebx,%esi
801025cf:	72 23                	jb     801025f4 <kinit2+0x44>
801025d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801025d8:	83 ec 0c             	sub    $0xc,%esp
801025db:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025e7:	50                   	push   %eax
801025e8:	e8 d3 fe ff ff       	call   801024c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025ed:	83 c4 10             	add    $0x10,%esp
801025f0:	39 de                	cmp    %ebx,%esi
801025f2:	73 e4                	jae    801025d8 <kinit2+0x28>
  kmem.use_lock = 1;
801025f4:	c7 05 74 36 11 80 01 	movl   $0x1,0x80113674
801025fb:	00 00 00 
}
801025fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102601:	5b                   	pop    %ebx
80102602:	5e                   	pop    %esi
80102603:	5d                   	pop    %ebp
80102604:	c3                   	ret    
80102605:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010260c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102610 <kinit1>:
{
80102610:	55                   	push   %ebp
80102611:	89 e5                	mov    %esp,%ebp
80102613:	56                   	push   %esi
80102614:	53                   	push   %ebx
80102615:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102618:	83 ec 08             	sub    $0x8,%esp
8010261b:	68 4c 86 10 80       	push   $0x8010864c
80102620:	68 40 36 11 80       	push   $0x80113640
80102625:	e8 46 20 00 00       	call   80104670 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010262a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010262d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102630:	c7 05 74 36 11 80 00 	movl   $0x0,0x80113674
80102637:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010263a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102640:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102646:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010264c:	39 de                	cmp    %ebx,%esi
8010264e:	72 1c                	jb     8010266c <kinit1+0x5c>
    kfree(p);
80102650:	83 ec 0c             	sub    $0xc,%esp
80102653:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102659:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010265f:	50                   	push   %eax
80102660:	e8 5b fe ff ff       	call   801024c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102665:	83 c4 10             	add    $0x10,%esp
80102668:	39 de                	cmp    %ebx,%esi
8010266a:	73 e4                	jae    80102650 <kinit1+0x40>
}
8010266c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010266f:	5b                   	pop    %ebx
80102670:	5e                   	pop    %esi
80102671:	5d                   	pop    %ebp
80102672:	c3                   	ret    
80102673:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010267a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102680 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102680:	a1 74 36 11 80       	mov    0x80113674,%eax
80102685:	85 c0                	test   %eax,%eax
80102687:	75 1f                	jne    801026a8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102689:	a1 78 36 11 80       	mov    0x80113678,%eax
  if(r)
8010268e:	85 c0                	test   %eax,%eax
80102690:	74 0e                	je     801026a0 <kalloc+0x20>
    kmem.freelist = r->next;
80102692:	8b 10                	mov    (%eax),%edx
80102694:	89 15 78 36 11 80    	mov    %edx,0x80113678
  if(kmem.use_lock)
8010269a:	c3                   	ret    
8010269b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010269f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
801026a0:	c3                   	ret    
801026a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801026a8:	55                   	push   %ebp
801026a9:	89 e5                	mov    %esp,%ebp
801026ab:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801026ae:	68 40 36 11 80       	push   $0x80113640
801026b3:	e8 88 21 00 00       	call   80104840 <acquire>
  r = kmem.freelist;
801026b8:	a1 78 36 11 80       	mov    0x80113678,%eax
  if(kmem.use_lock)
801026bd:	8b 15 74 36 11 80    	mov    0x80113674,%edx
  if(r)
801026c3:	83 c4 10             	add    $0x10,%esp
801026c6:	85 c0                	test   %eax,%eax
801026c8:	74 08                	je     801026d2 <kalloc+0x52>
    kmem.freelist = r->next;
801026ca:	8b 08                	mov    (%eax),%ecx
801026cc:	89 0d 78 36 11 80    	mov    %ecx,0x80113678
  if(kmem.use_lock)
801026d2:	85 d2                	test   %edx,%edx
801026d4:	74 16                	je     801026ec <kalloc+0x6c>
    release(&kmem.lock);
801026d6:	83 ec 0c             	sub    $0xc,%esp
801026d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801026dc:	68 40 36 11 80       	push   $0x80113640
801026e1:	e8 fa 20 00 00       	call   801047e0 <release>
  return (char*)r;
801026e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801026e9:	83 c4 10             	add    $0x10,%esp
}
801026ec:	c9                   	leave  
801026ed:	c3                   	ret    
801026ee:	66 90                	xchg   %ax,%ax

801026f0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026f0:	ba 64 00 00 00       	mov    $0x64,%edx
801026f5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801026f6:	a8 01                	test   $0x1,%al
801026f8:	0f 84 c2 00 00 00    	je     801027c0 <kbdgetc+0xd0>
{
801026fe:	55                   	push   %ebp
801026ff:	ba 60 00 00 00       	mov    $0x60,%edx
80102704:	89 e5                	mov    %esp,%ebp
80102706:	53                   	push   %ebx
80102707:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102708:	8b 1d 7c 36 11 80    	mov    0x8011367c,%ebx
  data = inb(KBDATAP);
8010270e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102711:	3c e0                	cmp    $0xe0,%al
80102713:	74 5b                	je     80102770 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102715:	89 da                	mov    %ebx,%edx
80102717:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
8010271a:	84 c0                	test   %al,%al
8010271c:	78 62                	js     80102780 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010271e:	85 d2                	test   %edx,%edx
80102720:	74 09                	je     8010272b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102722:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102725:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102728:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010272b:	0f b6 91 80 87 10 80 	movzbl -0x7fef7880(%ecx),%edx
  shift ^= togglecode[data];
80102732:	0f b6 81 80 86 10 80 	movzbl -0x7fef7980(%ecx),%eax
  shift |= shiftcode[data];
80102739:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010273b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010273d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010273f:	89 15 7c 36 11 80    	mov    %edx,0x8011367c
  c = charcode[shift & (CTL | SHIFT)][data];
80102745:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102748:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010274b:	8b 04 85 60 86 10 80 	mov    -0x7fef79a0(,%eax,4),%eax
80102752:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102756:	74 0b                	je     80102763 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102758:	8d 50 9f             	lea    -0x61(%eax),%edx
8010275b:	83 fa 19             	cmp    $0x19,%edx
8010275e:	77 48                	ja     801027a8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102760:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102763:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102766:	c9                   	leave  
80102767:	c3                   	ret    
80102768:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010276f:	90                   	nop
    shift |= E0ESC;
80102770:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102773:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102775:	89 1d 7c 36 11 80    	mov    %ebx,0x8011367c
}
8010277b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010277e:	c9                   	leave  
8010277f:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
80102780:	83 e0 7f             	and    $0x7f,%eax
80102783:	85 d2                	test   %edx,%edx
80102785:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102788:	0f b6 81 80 87 10 80 	movzbl -0x7fef7880(%ecx),%eax
8010278f:	83 c8 40             	or     $0x40,%eax
80102792:	0f b6 c0             	movzbl %al,%eax
80102795:	f7 d0                	not    %eax
80102797:	21 d8                	and    %ebx,%eax
}
80102799:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
8010279c:	a3 7c 36 11 80       	mov    %eax,0x8011367c
    return 0;
801027a1:	31 c0                	xor    %eax,%eax
}
801027a3:	c9                   	leave  
801027a4:	c3                   	ret    
801027a5:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801027a8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801027ab:	8d 50 20             	lea    0x20(%eax),%edx
}
801027ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027b1:	c9                   	leave  
      c += 'a' - 'A';
801027b2:	83 f9 1a             	cmp    $0x1a,%ecx
801027b5:	0f 42 c2             	cmovb  %edx,%eax
}
801027b8:	c3                   	ret    
801027b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801027c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801027c5:	c3                   	ret    
801027c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027cd:	8d 76 00             	lea    0x0(%esi),%esi

801027d0 <kbdintr>:

void
kbdintr(void)
{
801027d0:	55                   	push   %ebp
801027d1:	89 e5                	mov    %esp,%ebp
801027d3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801027d6:	68 f0 26 10 80       	push   $0x801026f0
801027db:	e8 a0 e0 ff ff       	call   80100880 <consoleintr>
}
801027e0:	83 c4 10             	add    $0x10,%esp
801027e3:	c9                   	leave  
801027e4:	c3                   	ret    
801027e5:	66 90                	xchg   %ax,%ax
801027e7:	66 90                	xchg   %ax,%ax
801027e9:	66 90                	xchg   %ax,%ax
801027eb:	66 90                	xchg   %ax,%ax
801027ed:	66 90                	xchg   %ax,%ax
801027ef:	90                   	nop

801027f0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801027f0:	a1 80 36 11 80       	mov    0x80113680,%eax
801027f5:	85 c0                	test   %eax,%eax
801027f7:	0f 84 cb 00 00 00    	je     801028c8 <lapicinit+0xd8>
  lapic[index] = value;
801027fd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102804:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102807:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010280a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102811:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102814:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102817:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010281e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102821:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102824:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010282b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010282e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102831:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102838:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010283b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010283e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102845:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102848:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010284b:	8b 50 30             	mov    0x30(%eax),%edx
8010284e:	c1 ea 10             	shr    $0x10,%edx
80102851:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102857:	75 77                	jne    801028d0 <lapicinit+0xe0>
  lapic[index] = value;
80102859:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102860:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102863:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102866:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010286d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102870:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102873:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010287a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010287d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102880:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102887:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010288a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010288d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102894:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102897:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010289a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801028a1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801028a4:	8b 50 20             	mov    0x20(%eax),%edx
801028a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028ae:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801028b0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801028b6:	80 e6 10             	and    $0x10,%dh
801028b9:	75 f5                	jne    801028b0 <lapicinit+0xc0>
  lapic[index] = value;
801028bb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801028c2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028c5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801028c8:	c3                   	ret    
801028c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801028d0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801028d7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028da:	8b 50 20             	mov    0x20(%eax),%edx
}
801028dd:	e9 77 ff ff ff       	jmp    80102859 <lapicinit+0x69>
801028e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801028f0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801028f0:	a1 80 36 11 80       	mov    0x80113680,%eax
801028f5:	85 c0                	test   %eax,%eax
801028f7:	74 07                	je     80102900 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801028f9:	8b 40 20             	mov    0x20(%eax),%eax
801028fc:	c1 e8 18             	shr    $0x18,%eax
801028ff:	c3                   	ret    
    return 0;
80102900:	31 c0                	xor    %eax,%eax
}
80102902:	c3                   	ret    
80102903:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010290a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102910 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102910:	a1 80 36 11 80       	mov    0x80113680,%eax
80102915:	85 c0                	test   %eax,%eax
80102917:	74 0d                	je     80102926 <lapiceoi+0x16>
  lapic[index] = value;
80102919:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102920:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102923:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102926:	c3                   	ret    
80102927:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010292e:	66 90                	xchg   %ax,%ax

80102930 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102930:	c3                   	ret    
80102931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102938:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010293f:	90                   	nop

80102940 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102940:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102941:	b8 0f 00 00 00       	mov    $0xf,%eax
80102946:	ba 70 00 00 00       	mov    $0x70,%edx
8010294b:	89 e5                	mov    %esp,%ebp
8010294d:	53                   	push   %ebx
8010294e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102951:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102954:	ee                   	out    %al,(%dx)
80102955:	b8 0a 00 00 00       	mov    $0xa,%eax
8010295a:	ba 71 00 00 00       	mov    $0x71,%edx
8010295f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102960:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102962:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102965:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010296b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010296d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102970:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102972:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102975:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102978:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010297e:	a1 80 36 11 80       	mov    0x80113680,%eax
80102983:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102989:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010298c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102993:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102996:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102999:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801029a0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029a3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029a6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029ac:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029af:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029b5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029b8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029be:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029c1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029c7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801029ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029cd:	c9                   	leave  
801029ce:	c3                   	ret    
801029cf:	90                   	nop

801029d0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801029d0:	55                   	push   %ebp
801029d1:	b8 0b 00 00 00       	mov    $0xb,%eax
801029d6:	ba 70 00 00 00       	mov    $0x70,%edx
801029db:	89 e5                	mov    %esp,%ebp
801029dd:	57                   	push   %edi
801029de:	56                   	push   %esi
801029df:	53                   	push   %ebx
801029e0:	83 ec 4c             	sub    $0x4c,%esp
801029e3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e4:	ba 71 00 00 00       	mov    $0x71,%edx
801029e9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801029ea:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029ed:	bb 70 00 00 00       	mov    $0x70,%ebx
801029f2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801029f5:	8d 76 00             	lea    0x0(%esi),%esi
801029f8:	31 c0                	xor    %eax,%eax
801029fa:	89 da                	mov    %ebx,%edx
801029fc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029fd:	b9 71 00 00 00       	mov    $0x71,%ecx
80102a02:	89 ca                	mov    %ecx,%edx
80102a04:	ec                   	in     (%dx),%al
80102a05:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a08:	89 da                	mov    %ebx,%edx
80102a0a:	b8 02 00 00 00       	mov    $0x2,%eax
80102a0f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a10:	89 ca                	mov    %ecx,%edx
80102a12:	ec                   	in     (%dx),%al
80102a13:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a16:	89 da                	mov    %ebx,%edx
80102a18:	b8 04 00 00 00       	mov    $0x4,%eax
80102a1d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a1e:	89 ca                	mov    %ecx,%edx
80102a20:	ec                   	in     (%dx),%al
80102a21:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a24:	89 da                	mov    %ebx,%edx
80102a26:	b8 07 00 00 00       	mov    $0x7,%eax
80102a2b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a2c:	89 ca                	mov    %ecx,%edx
80102a2e:	ec                   	in     (%dx),%al
80102a2f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a32:	89 da                	mov    %ebx,%edx
80102a34:	b8 08 00 00 00       	mov    $0x8,%eax
80102a39:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a3a:	89 ca                	mov    %ecx,%edx
80102a3c:	ec                   	in     (%dx),%al
80102a3d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a3f:	89 da                	mov    %ebx,%edx
80102a41:	b8 09 00 00 00       	mov    $0x9,%eax
80102a46:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a47:	89 ca                	mov    %ecx,%edx
80102a49:	ec                   	in     (%dx),%al
80102a4a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a4c:	89 da                	mov    %ebx,%edx
80102a4e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a53:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a54:	89 ca                	mov    %ecx,%edx
80102a56:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a57:	84 c0                	test   %al,%al
80102a59:	78 9d                	js     801029f8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102a5b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102a5f:	89 fa                	mov    %edi,%edx
80102a61:	0f b6 fa             	movzbl %dl,%edi
80102a64:	89 f2                	mov    %esi,%edx
80102a66:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a69:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102a6d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a70:	89 da                	mov    %ebx,%edx
80102a72:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102a75:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a78:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102a7c:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102a7f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a82:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102a86:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a89:	31 c0                	xor    %eax,%eax
80102a8b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a8c:	89 ca                	mov    %ecx,%edx
80102a8e:	ec                   	in     (%dx),%al
80102a8f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a92:	89 da                	mov    %ebx,%edx
80102a94:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a97:	b8 02 00 00 00       	mov    $0x2,%eax
80102a9c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a9d:	89 ca                	mov    %ecx,%edx
80102a9f:	ec                   	in     (%dx),%al
80102aa0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa3:	89 da                	mov    %ebx,%edx
80102aa5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102aa8:	b8 04 00 00 00       	mov    $0x4,%eax
80102aad:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aae:	89 ca                	mov    %ecx,%edx
80102ab0:	ec                   	in     (%dx),%al
80102ab1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ab4:	89 da                	mov    %ebx,%edx
80102ab6:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102ab9:	b8 07 00 00 00       	mov    $0x7,%eax
80102abe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102abf:	89 ca                	mov    %ecx,%edx
80102ac1:	ec                   	in     (%dx),%al
80102ac2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ac5:	89 da                	mov    %ebx,%edx
80102ac7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102aca:	b8 08 00 00 00       	mov    $0x8,%eax
80102acf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ad0:	89 ca                	mov    %ecx,%edx
80102ad2:	ec                   	in     (%dx),%al
80102ad3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ad6:	89 da                	mov    %ebx,%edx
80102ad8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102adb:	b8 09 00 00 00       	mov    $0x9,%eax
80102ae0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ae1:	89 ca                	mov    %ecx,%edx
80102ae3:	ec                   	in     (%dx),%al
80102ae4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ae7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102aea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102aed:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102af0:	6a 18                	push   $0x18
80102af2:	50                   	push   %eax
80102af3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102af6:	50                   	push   %eax
80102af7:	e8 54 1e 00 00       	call   80104950 <memcmp>
80102afc:	83 c4 10             	add    $0x10,%esp
80102aff:	85 c0                	test   %eax,%eax
80102b01:	0f 85 f1 fe ff ff    	jne    801029f8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102b07:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102b0b:	75 78                	jne    80102b85 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102b0d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b10:	89 c2                	mov    %eax,%edx
80102b12:	83 e0 0f             	and    $0xf,%eax
80102b15:	c1 ea 04             	shr    $0x4,%edx
80102b18:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b1b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b1e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102b21:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b24:	89 c2                	mov    %eax,%edx
80102b26:	83 e0 0f             	and    $0xf,%eax
80102b29:	c1 ea 04             	shr    $0x4,%edx
80102b2c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b2f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b32:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102b35:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b38:	89 c2                	mov    %eax,%edx
80102b3a:	83 e0 0f             	and    $0xf,%eax
80102b3d:	c1 ea 04             	shr    $0x4,%edx
80102b40:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b43:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b46:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102b49:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b4c:	89 c2                	mov    %eax,%edx
80102b4e:	83 e0 0f             	and    $0xf,%eax
80102b51:	c1 ea 04             	shr    $0x4,%edx
80102b54:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b57:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b5a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102b5d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b60:	89 c2                	mov    %eax,%edx
80102b62:	83 e0 0f             	and    $0xf,%eax
80102b65:	c1 ea 04             	shr    $0x4,%edx
80102b68:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b6b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b6e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b71:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b74:	89 c2                	mov    %eax,%edx
80102b76:	83 e0 0f             	and    $0xf,%eax
80102b79:	c1 ea 04             	shr    $0x4,%edx
80102b7c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b7f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b82:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b85:	8b 75 08             	mov    0x8(%ebp),%esi
80102b88:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b8b:	89 06                	mov    %eax,(%esi)
80102b8d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b90:	89 46 04             	mov    %eax,0x4(%esi)
80102b93:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b96:	89 46 08             	mov    %eax,0x8(%esi)
80102b99:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b9c:	89 46 0c             	mov    %eax,0xc(%esi)
80102b9f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ba2:	89 46 10             	mov    %eax,0x10(%esi)
80102ba5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ba8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102bab:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102bb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bb5:	5b                   	pop    %ebx
80102bb6:	5e                   	pop    %esi
80102bb7:	5f                   	pop    %edi
80102bb8:	5d                   	pop    %ebp
80102bb9:	c3                   	ret    
80102bba:	66 90                	xchg   %ax,%ax
80102bbc:	66 90                	xchg   %ax,%ax
80102bbe:	66 90                	xchg   %ax,%ax

80102bc0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bc0:	8b 0d e8 36 11 80    	mov    0x801136e8,%ecx
80102bc6:	85 c9                	test   %ecx,%ecx
80102bc8:	0f 8e 8a 00 00 00    	jle    80102c58 <install_trans+0x98>
{
80102bce:	55                   	push   %ebp
80102bcf:	89 e5                	mov    %esp,%ebp
80102bd1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102bd2:	31 ff                	xor    %edi,%edi
{
80102bd4:	56                   	push   %esi
80102bd5:	53                   	push   %ebx
80102bd6:	83 ec 0c             	sub    $0xc,%esp
80102bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102be0:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102be5:	83 ec 08             	sub    $0x8,%esp
80102be8:	01 f8                	add    %edi,%eax
80102bea:	83 c0 01             	add    $0x1,%eax
80102bed:	50                   	push   %eax
80102bee:	ff 35 e4 36 11 80    	push   0x801136e4
80102bf4:	e8 d7 d4 ff ff       	call   801000d0 <bread>
80102bf9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bfb:	58                   	pop    %eax
80102bfc:	5a                   	pop    %edx
80102bfd:	ff 34 bd ec 36 11 80 	push   -0x7feec914(,%edi,4)
80102c04:	ff 35 e4 36 11 80    	push   0x801136e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102c0a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c0d:	e8 be d4 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c12:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c15:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c17:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c1a:	68 00 02 00 00       	push   $0x200
80102c1f:	50                   	push   %eax
80102c20:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102c23:	50                   	push   %eax
80102c24:	e8 77 1d 00 00       	call   801049a0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102c29:	89 1c 24             	mov    %ebx,(%esp)
80102c2c:	e8 7f d5 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102c31:	89 34 24             	mov    %esi,(%esp)
80102c34:	e8 b7 d5 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102c39:	89 1c 24             	mov    %ebx,(%esp)
80102c3c:	e8 af d5 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c41:	83 c4 10             	add    $0x10,%esp
80102c44:	39 3d e8 36 11 80    	cmp    %edi,0x801136e8
80102c4a:	7f 94                	jg     80102be0 <install_trans+0x20>
  }
}
80102c4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c4f:	5b                   	pop    %ebx
80102c50:	5e                   	pop    %esi
80102c51:	5f                   	pop    %edi
80102c52:	5d                   	pop    %ebp
80102c53:	c3                   	ret    
80102c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c58:	c3                   	ret    
80102c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c60 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c60:	55                   	push   %ebp
80102c61:	89 e5                	mov    %esp,%ebp
80102c63:	53                   	push   %ebx
80102c64:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c67:	ff 35 d4 36 11 80    	push   0x801136d4
80102c6d:	ff 35 e4 36 11 80    	push   0x801136e4
80102c73:	e8 58 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c78:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c7b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102c7d:	a1 e8 36 11 80       	mov    0x801136e8,%eax
80102c82:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102c85:	85 c0                	test   %eax,%eax
80102c87:	7e 19                	jle    80102ca2 <write_head+0x42>
80102c89:	31 d2                	xor    %edx,%edx
80102c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c8f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102c90:	8b 0c 95 ec 36 11 80 	mov    -0x7feec914(,%edx,4),%ecx
80102c97:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102c9b:	83 c2 01             	add    $0x1,%edx
80102c9e:	39 d0                	cmp    %edx,%eax
80102ca0:	75 ee                	jne    80102c90 <write_head+0x30>
  }
  bwrite(buf);
80102ca2:	83 ec 0c             	sub    $0xc,%esp
80102ca5:	53                   	push   %ebx
80102ca6:	e8 05 d5 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102cab:	89 1c 24             	mov    %ebx,(%esp)
80102cae:	e8 3d d5 ff ff       	call   801001f0 <brelse>
}
80102cb3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102cb6:	83 c4 10             	add    $0x10,%esp
80102cb9:	c9                   	leave  
80102cba:	c3                   	ret    
80102cbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102cbf:	90                   	nop

80102cc0 <initlog>:
{
80102cc0:	55                   	push   %ebp
80102cc1:	89 e5                	mov    %esp,%ebp
80102cc3:	53                   	push   %ebx
80102cc4:	83 ec 2c             	sub    $0x2c,%esp
80102cc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102cca:	68 80 88 10 80       	push   $0x80108880
80102ccf:	68 a0 36 11 80       	push   $0x801136a0
80102cd4:	e8 97 19 00 00       	call   80104670 <initlock>
  readsb(dev, &sb);
80102cd9:	58                   	pop    %eax
80102cda:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102cdd:	5a                   	pop    %edx
80102cde:	50                   	push   %eax
80102cdf:	53                   	push   %ebx
80102ce0:	e8 3b e8 ff ff       	call   80101520 <readsb>
  log.start = sb.logstart;
80102ce5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102ce8:	59                   	pop    %ecx
  log.dev = dev;
80102ce9:	89 1d e4 36 11 80    	mov    %ebx,0x801136e4
  log.size = sb.nlog;
80102cef:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102cf2:	a3 d4 36 11 80       	mov    %eax,0x801136d4
  log.size = sb.nlog;
80102cf7:	89 15 d8 36 11 80    	mov    %edx,0x801136d8
  struct buf *buf = bread(log.dev, log.start);
80102cfd:	5a                   	pop    %edx
80102cfe:	50                   	push   %eax
80102cff:	53                   	push   %ebx
80102d00:	e8 cb d3 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102d05:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102d08:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102d0b:	89 1d e8 36 11 80    	mov    %ebx,0x801136e8
  for (i = 0; i < log.lh.n; i++) {
80102d11:	85 db                	test   %ebx,%ebx
80102d13:	7e 1d                	jle    80102d32 <initlog+0x72>
80102d15:	31 d2                	xor    %edx,%edx
80102d17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d1e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102d20:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102d24:	89 0c 95 ec 36 11 80 	mov    %ecx,-0x7feec914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102d2b:	83 c2 01             	add    $0x1,%edx
80102d2e:	39 d3                	cmp    %edx,%ebx
80102d30:	75 ee                	jne    80102d20 <initlog+0x60>
  brelse(buf);
80102d32:	83 ec 0c             	sub    $0xc,%esp
80102d35:	50                   	push   %eax
80102d36:	e8 b5 d4 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102d3b:	e8 80 fe ff ff       	call   80102bc0 <install_trans>
  log.lh.n = 0;
80102d40:	c7 05 e8 36 11 80 00 	movl   $0x0,0x801136e8
80102d47:	00 00 00 
  write_head(); // clear the log
80102d4a:	e8 11 ff ff ff       	call   80102c60 <write_head>
}
80102d4f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d52:	83 c4 10             	add    $0x10,%esp
80102d55:	c9                   	leave  
80102d56:	c3                   	ret    
80102d57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d5e:	66 90                	xchg   %ax,%ax

80102d60 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d60:	55                   	push   %ebp
80102d61:	89 e5                	mov    %esp,%ebp
80102d63:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d66:	68 a0 36 11 80       	push   $0x801136a0
80102d6b:	e8 d0 1a 00 00       	call   80104840 <acquire>
80102d70:	83 c4 10             	add    $0x10,%esp
80102d73:	eb 18                	jmp    80102d8d <begin_op+0x2d>
80102d75:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d78:	83 ec 08             	sub    $0x8,%esp
80102d7b:	68 a0 36 11 80       	push   $0x801136a0
80102d80:	68 a0 36 11 80       	push   $0x801136a0
80102d85:	e8 56 15 00 00       	call   801042e0 <sleep>
80102d8a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102d8d:	a1 e0 36 11 80       	mov    0x801136e0,%eax
80102d92:	85 c0                	test   %eax,%eax
80102d94:	75 e2                	jne    80102d78 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d96:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102d9b:	8b 15 e8 36 11 80    	mov    0x801136e8,%edx
80102da1:	83 c0 01             	add    $0x1,%eax
80102da4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102da7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102daa:	83 fa 1e             	cmp    $0x1e,%edx
80102dad:	7f c9                	jg     80102d78 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102daf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102db2:	a3 dc 36 11 80       	mov    %eax,0x801136dc
      release(&log.lock);
80102db7:	68 a0 36 11 80       	push   $0x801136a0
80102dbc:	e8 1f 1a 00 00       	call   801047e0 <release>
      break;
    }
  }
}
80102dc1:	83 c4 10             	add    $0x10,%esp
80102dc4:	c9                   	leave  
80102dc5:	c3                   	ret    
80102dc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dcd:	8d 76 00             	lea    0x0(%esi),%esi

80102dd0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102dd0:	55                   	push   %ebp
80102dd1:	89 e5                	mov    %esp,%ebp
80102dd3:	57                   	push   %edi
80102dd4:	56                   	push   %esi
80102dd5:	53                   	push   %ebx
80102dd6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102dd9:	68 a0 36 11 80       	push   $0x801136a0
80102dde:	e8 5d 1a 00 00       	call   80104840 <acquire>
  log.outstanding -= 1;
80102de3:	a1 dc 36 11 80       	mov    0x801136dc,%eax
  if(log.committing)
80102de8:	8b 35 e0 36 11 80    	mov    0x801136e0,%esi
80102dee:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102df1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102df4:	89 1d dc 36 11 80    	mov    %ebx,0x801136dc
  if(log.committing)
80102dfa:	85 f6                	test   %esi,%esi
80102dfc:	0f 85 22 01 00 00    	jne    80102f24 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102e02:	85 db                	test   %ebx,%ebx
80102e04:	0f 85 f6 00 00 00    	jne    80102f00 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102e0a:	c7 05 e0 36 11 80 01 	movl   $0x1,0x801136e0
80102e11:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102e14:	83 ec 0c             	sub    $0xc,%esp
80102e17:	68 a0 36 11 80       	push   $0x801136a0
80102e1c:	e8 bf 19 00 00       	call   801047e0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102e21:	8b 0d e8 36 11 80    	mov    0x801136e8,%ecx
80102e27:	83 c4 10             	add    $0x10,%esp
80102e2a:	85 c9                	test   %ecx,%ecx
80102e2c:	7f 42                	jg     80102e70 <end_op+0xa0>
    acquire(&log.lock);
80102e2e:	83 ec 0c             	sub    $0xc,%esp
80102e31:	68 a0 36 11 80       	push   $0x801136a0
80102e36:	e8 05 1a 00 00       	call   80104840 <acquire>
    wakeup(&log);
80102e3b:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
    log.committing = 0;
80102e42:	c7 05 e0 36 11 80 00 	movl   $0x0,0x801136e0
80102e49:	00 00 00 
    wakeup(&log);
80102e4c:	e8 4f 15 00 00       	call   801043a0 <wakeup>
    release(&log.lock);
80102e51:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
80102e58:	e8 83 19 00 00       	call   801047e0 <release>
80102e5d:	83 c4 10             	add    $0x10,%esp
}
80102e60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e63:	5b                   	pop    %ebx
80102e64:	5e                   	pop    %esi
80102e65:	5f                   	pop    %edi
80102e66:	5d                   	pop    %ebp
80102e67:	c3                   	ret    
80102e68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e6f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102e70:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102e75:	83 ec 08             	sub    $0x8,%esp
80102e78:	01 d8                	add    %ebx,%eax
80102e7a:	83 c0 01             	add    $0x1,%eax
80102e7d:	50                   	push   %eax
80102e7e:	ff 35 e4 36 11 80    	push   0x801136e4
80102e84:	e8 47 d2 ff ff       	call   801000d0 <bread>
80102e89:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e8b:	58                   	pop    %eax
80102e8c:	5a                   	pop    %edx
80102e8d:	ff 34 9d ec 36 11 80 	push   -0x7feec914(,%ebx,4)
80102e94:	ff 35 e4 36 11 80    	push   0x801136e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102e9a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e9d:	e8 2e d2 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102ea2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ea5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102ea7:	8d 40 5c             	lea    0x5c(%eax),%eax
80102eaa:	68 00 02 00 00       	push   $0x200
80102eaf:	50                   	push   %eax
80102eb0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102eb3:	50                   	push   %eax
80102eb4:	e8 e7 1a 00 00       	call   801049a0 <memmove>
    bwrite(to);  // write the log
80102eb9:	89 34 24             	mov    %esi,(%esp)
80102ebc:	e8 ef d2 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102ec1:	89 3c 24             	mov    %edi,(%esp)
80102ec4:	e8 27 d3 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102ec9:	89 34 24             	mov    %esi,(%esp)
80102ecc:	e8 1f d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ed1:	83 c4 10             	add    $0x10,%esp
80102ed4:	3b 1d e8 36 11 80    	cmp    0x801136e8,%ebx
80102eda:	7c 94                	jl     80102e70 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102edc:	e8 7f fd ff ff       	call   80102c60 <write_head>
    install_trans(); // Now install writes to home locations
80102ee1:	e8 da fc ff ff       	call   80102bc0 <install_trans>
    log.lh.n = 0;
80102ee6:	c7 05 e8 36 11 80 00 	movl   $0x0,0x801136e8
80102eed:	00 00 00 
    write_head();    // Erase the transaction from the log
80102ef0:	e8 6b fd ff ff       	call   80102c60 <write_head>
80102ef5:	e9 34 ff ff ff       	jmp    80102e2e <end_op+0x5e>
80102efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102f00:	83 ec 0c             	sub    $0xc,%esp
80102f03:	68 a0 36 11 80       	push   $0x801136a0
80102f08:	e8 93 14 00 00       	call   801043a0 <wakeup>
  release(&log.lock);
80102f0d:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
80102f14:	e8 c7 18 00 00       	call   801047e0 <release>
80102f19:	83 c4 10             	add    $0x10,%esp
}
80102f1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f1f:	5b                   	pop    %ebx
80102f20:	5e                   	pop    %esi
80102f21:	5f                   	pop    %edi
80102f22:	5d                   	pop    %ebp
80102f23:	c3                   	ret    
    panic("log.committing");
80102f24:	83 ec 0c             	sub    $0xc,%esp
80102f27:	68 84 88 10 80       	push   $0x80108884
80102f2c:	e8 4f d4 ff ff       	call   80100380 <panic>
80102f31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f3f:	90                   	nop

80102f40 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f40:	55                   	push   %ebp
80102f41:	89 e5                	mov    %esp,%ebp
80102f43:	53                   	push   %ebx
80102f44:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f47:	8b 15 e8 36 11 80    	mov    0x801136e8,%edx
{
80102f4d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f50:	83 fa 1d             	cmp    $0x1d,%edx
80102f53:	0f 8f 85 00 00 00    	jg     80102fde <log_write+0x9e>
80102f59:	a1 d8 36 11 80       	mov    0x801136d8,%eax
80102f5e:	83 e8 01             	sub    $0x1,%eax
80102f61:	39 c2                	cmp    %eax,%edx
80102f63:	7d 79                	jge    80102fde <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f65:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102f6a:	85 c0                	test   %eax,%eax
80102f6c:	7e 7d                	jle    80102feb <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f6e:	83 ec 0c             	sub    $0xc,%esp
80102f71:	68 a0 36 11 80       	push   $0x801136a0
80102f76:	e8 c5 18 00 00       	call   80104840 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f7b:	8b 15 e8 36 11 80    	mov    0x801136e8,%edx
80102f81:	83 c4 10             	add    $0x10,%esp
80102f84:	85 d2                	test   %edx,%edx
80102f86:	7e 4a                	jle    80102fd2 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f88:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102f8b:	31 c0                	xor    %eax,%eax
80102f8d:	eb 08                	jmp    80102f97 <log_write+0x57>
80102f8f:	90                   	nop
80102f90:	83 c0 01             	add    $0x1,%eax
80102f93:	39 c2                	cmp    %eax,%edx
80102f95:	74 29                	je     80102fc0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f97:	39 0c 85 ec 36 11 80 	cmp    %ecx,-0x7feec914(,%eax,4)
80102f9e:	75 f0                	jne    80102f90 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80102fa0:	89 0c 85 ec 36 11 80 	mov    %ecx,-0x7feec914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102fa7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80102faa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80102fad:	c7 45 08 a0 36 11 80 	movl   $0x801136a0,0x8(%ebp)
}
80102fb4:	c9                   	leave  
  release(&log.lock);
80102fb5:	e9 26 18 00 00       	jmp    801047e0 <release>
80102fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102fc0:	89 0c 95 ec 36 11 80 	mov    %ecx,-0x7feec914(,%edx,4)
    log.lh.n++;
80102fc7:	83 c2 01             	add    $0x1,%edx
80102fca:	89 15 e8 36 11 80    	mov    %edx,0x801136e8
80102fd0:	eb d5                	jmp    80102fa7 <log_write+0x67>
  log.lh.block[i] = b->blockno;
80102fd2:	8b 43 08             	mov    0x8(%ebx),%eax
80102fd5:	a3 ec 36 11 80       	mov    %eax,0x801136ec
  if (i == log.lh.n)
80102fda:	75 cb                	jne    80102fa7 <log_write+0x67>
80102fdc:	eb e9                	jmp    80102fc7 <log_write+0x87>
    panic("too big a transaction");
80102fde:	83 ec 0c             	sub    $0xc,%esp
80102fe1:	68 93 88 10 80       	push   $0x80108893
80102fe6:	e8 95 d3 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
80102feb:	83 ec 0c             	sub    $0xc,%esp
80102fee:	68 a9 88 10 80       	push   $0x801088a9
80102ff3:	e8 88 d3 ff ff       	call   80100380 <panic>
80102ff8:	66 90                	xchg   %ax,%ax
80102ffa:	66 90                	xchg   %ax,%ax
80102ffc:	66 90                	xchg   %ax,%ax
80102ffe:	66 90                	xchg   %ax,%ax

80103000 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103000:	55                   	push   %ebp
80103001:	89 e5                	mov    %esp,%ebp
80103003:	53                   	push   %ebx
80103004:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103007:	e8 a4 09 00 00       	call   801039b0 <cpuid>
8010300c:	89 c3                	mov    %eax,%ebx
8010300e:	e8 9d 09 00 00       	call   801039b0 <cpuid>
80103013:	83 ec 04             	sub    $0x4,%esp
80103016:	53                   	push   %ebx
80103017:	50                   	push   %eax
80103018:	68 c4 88 10 80       	push   $0x801088c4
8010301d:	e8 7e d6 ff ff       	call   801006a0 <cprintf>
  idtinit();       // load idt register
80103022:	e8 99 2c 00 00       	call   80105cc0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103027:	e8 24 09 00 00       	call   80103950 <mycpu>
8010302c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010302e:	b8 01 00 00 00       	mov    $0x1,%eax
80103033:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010303a:	e8 91 0e 00 00       	call   80103ed0 <scheduler>
8010303f:	90                   	nop

80103040 <mpenter>:
{
80103040:	55                   	push   %ebp
80103041:	89 e5                	mov    %esp,%ebp
80103043:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103046:	e8 a5 3f 00 00       	call   80106ff0 <switchkvm>
  seginit();
8010304b:	e8 90 3d 00 00       	call   80106de0 <seginit>
  lapicinit();
80103050:	e8 9b f7 ff ff       	call   801027f0 <lapicinit>
  mpmain();
80103055:	e8 a6 ff ff ff       	call   80103000 <mpmain>
8010305a:	66 90                	xchg   %ax,%ax
8010305c:	66 90                	xchg   %ax,%ax
8010305e:	66 90                	xchg   %ax,%ax

80103060 <main>:
{
80103060:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103064:	83 e4 f0             	and    $0xfffffff0,%esp
80103067:	ff 71 fc             	push   -0x4(%ecx)
8010306a:	55                   	push   %ebp
8010306b:	89 e5                	mov    %esp,%ebp
8010306d:	53                   	push   %ebx
8010306e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010306f:	83 ec 08             	sub    $0x8,%esp
80103072:	68 00 00 40 80       	push   $0x80400000
80103077:	68 d0 c6 11 80       	push   $0x8011c6d0
8010307c:	e8 8f f5 ff ff       	call   80102610 <kinit1>
  kvmalloc();      // kernel page table
80103081:	e8 5a 44 00 00       	call   801074e0 <kvmalloc>
  mpinit();        // detect other processors
80103086:	e8 85 01 00 00       	call   80103210 <mpinit>
  lapicinit();     // interrupt controller
8010308b:	e8 60 f7 ff ff       	call   801027f0 <lapicinit>
  seginit();       // segment descriptors
80103090:	e8 4b 3d 00 00       	call   80106de0 <seginit>
  picinit();       // disable pic
80103095:	e8 76 03 00 00       	call   80103410 <picinit>
  ioapicinit();    // another interrupt controller
8010309a:	e8 31 f3 ff ff       	call   801023d0 <ioapicinit>
  consoleinit();   // console hardware
8010309f:	e8 bc d9 ff ff       	call   80100a60 <consoleinit>
  uartinit();      // serial port
801030a4:	e8 b7 30 00 00       	call   80106160 <uartinit>
  pinit();         // process table
801030a9:	e8 82 08 00 00       	call   80103930 <pinit>
  tvinit();        // trap vectors
801030ae:	e8 8d 2b 00 00       	call   80105c40 <tvinit>
  binit();         // buffer cache
801030b3:	e8 88 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
801030b8:	e8 53 dd ff ff       	call   80100e10 <fileinit>
  ideinit();       // disk 
801030bd:	e8 fe f0 ff ff       	call   801021c0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801030c2:	83 c4 0c             	add    $0xc,%esp
801030c5:	68 8a 00 00 00       	push   $0x8a
801030ca:	68 8c c4 10 80       	push   $0x8010c48c
801030cf:	68 00 70 00 80       	push   $0x80007000
801030d4:	e8 c7 18 00 00       	call   801049a0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801030d9:	83 c4 10             	add    $0x10,%esp
801030dc:	69 05 84 37 11 80 b0 	imul   $0xb0,0x80113784,%eax
801030e3:	00 00 00 
801030e6:	05 a0 37 11 80       	add    $0x801137a0,%eax
801030eb:	3d a0 37 11 80       	cmp    $0x801137a0,%eax
801030f0:	76 7e                	jbe    80103170 <main+0x110>
801030f2:	bb a0 37 11 80       	mov    $0x801137a0,%ebx
801030f7:	eb 20                	jmp    80103119 <main+0xb9>
801030f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103100:	69 05 84 37 11 80 b0 	imul   $0xb0,0x80113784,%eax
80103107:	00 00 00 
8010310a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103110:	05 a0 37 11 80       	add    $0x801137a0,%eax
80103115:	39 c3                	cmp    %eax,%ebx
80103117:	73 57                	jae    80103170 <main+0x110>
    if(c == mycpu())  // We've started already.
80103119:	e8 32 08 00 00       	call   80103950 <mycpu>
8010311e:	39 c3                	cmp    %eax,%ebx
80103120:	74 de                	je     80103100 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103122:	e8 59 f5 ff ff       	call   80102680 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103127:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010312a:	c7 05 f8 6f 00 80 40 	movl   $0x80103040,0x80006ff8
80103131:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103134:	c7 05 f4 6f 00 80 00 	movl   $0x10b000,0x80006ff4
8010313b:	b0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010313e:	05 00 10 00 00       	add    $0x1000,%eax
80103143:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103148:	0f b6 03             	movzbl (%ebx),%eax
8010314b:	68 00 70 00 00       	push   $0x7000
80103150:	50                   	push   %eax
80103151:	e8 ea f7 ff ff       	call   80102940 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103156:	83 c4 10             	add    $0x10,%esp
80103159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103160:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103166:	85 c0                	test   %eax,%eax
80103168:	74 f6                	je     80103160 <main+0x100>
8010316a:	eb 94                	jmp    80103100 <main+0xa0>
8010316c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103170:	83 ec 08             	sub    $0x8,%esp
80103173:	68 00 00 00 8e       	push   $0x8e000000
80103178:	68 00 00 40 80       	push   $0x80400000
8010317d:	e8 2e f4 ff ff       	call   801025b0 <kinit2>
  userinit();      // first user process
80103182:	e8 79 08 00 00       	call   80103a00 <userinit>
  mpmain();        // finish this processor's setup
80103187:	e8 74 fe ff ff       	call   80103000 <mpmain>
8010318c:	66 90                	xchg   %ax,%ax
8010318e:	66 90                	xchg   %ax,%ax

80103190 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103190:	55                   	push   %ebp
80103191:	89 e5                	mov    %esp,%ebp
80103193:	57                   	push   %edi
80103194:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103195:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010319b:	53                   	push   %ebx
  e = addr+len;
8010319c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010319f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801031a2:	39 de                	cmp    %ebx,%esi
801031a4:	72 10                	jb     801031b6 <mpsearch1+0x26>
801031a6:	eb 50                	jmp    801031f8 <mpsearch1+0x68>
801031a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031af:	90                   	nop
801031b0:	89 fe                	mov    %edi,%esi
801031b2:	39 fb                	cmp    %edi,%ebx
801031b4:	76 42                	jbe    801031f8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031b6:	83 ec 04             	sub    $0x4,%esp
801031b9:	8d 7e 10             	lea    0x10(%esi),%edi
801031bc:	6a 04                	push   $0x4
801031be:	68 d8 88 10 80       	push   $0x801088d8
801031c3:	56                   	push   %esi
801031c4:	e8 87 17 00 00       	call   80104950 <memcmp>
801031c9:	83 c4 10             	add    $0x10,%esp
801031cc:	85 c0                	test   %eax,%eax
801031ce:	75 e0                	jne    801031b0 <mpsearch1+0x20>
801031d0:	89 f2                	mov    %esi,%edx
801031d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801031d8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801031db:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801031de:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801031e0:	39 fa                	cmp    %edi,%edx
801031e2:	75 f4                	jne    801031d8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031e4:	84 c0                	test   %al,%al
801031e6:	75 c8                	jne    801031b0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801031e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031eb:	89 f0                	mov    %esi,%eax
801031ed:	5b                   	pop    %ebx
801031ee:	5e                   	pop    %esi
801031ef:	5f                   	pop    %edi
801031f0:	5d                   	pop    %ebp
801031f1:	c3                   	ret    
801031f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801031f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801031fb:	31 f6                	xor    %esi,%esi
}
801031fd:	5b                   	pop    %ebx
801031fe:	89 f0                	mov    %esi,%eax
80103200:	5e                   	pop    %esi
80103201:	5f                   	pop    %edi
80103202:	5d                   	pop    %ebp
80103203:	c3                   	ret    
80103204:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010320b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010320f:	90                   	nop

80103210 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103210:	55                   	push   %ebp
80103211:	89 e5                	mov    %esp,%ebp
80103213:	57                   	push   %edi
80103214:	56                   	push   %esi
80103215:	53                   	push   %ebx
80103216:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103219:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103220:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103227:	c1 e0 08             	shl    $0x8,%eax
8010322a:	09 d0                	or     %edx,%eax
8010322c:	c1 e0 04             	shl    $0x4,%eax
8010322f:	75 1b                	jne    8010324c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103231:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103238:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010323f:	c1 e0 08             	shl    $0x8,%eax
80103242:	09 d0                	or     %edx,%eax
80103244:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103247:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010324c:	ba 00 04 00 00       	mov    $0x400,%edx
80103251:	e8 3a ff ff ff       	call   80103190 <mpsearch1>
80103256:	89 c3                	mov    %eax,%ebx
80103258:	85 c0                	test   %eax,%eax
8010325a:	0f 84 40 01 00 00    	je     801033a0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103260:	8b 73 04             	mov    0x4(%ebx),%esi
80103263:	85 f6                	test   %esi,%esi
80103265:	0f 84 25 01 00 00    	je     80103390 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
8010326b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010326e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103274:	6a 04                	push   $0x4
80103276:	68 dd 88 10 80       	push   $0x801088dd
8010327b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010327c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010327f:	e8 cc 16 00 00       	call   80104950 <memcmp>
80103284:	83 c4 10             	add    $0x10,%esp
80103287:	85 c0                	test   %eax,%eax
80103289:	0f 85 01 01 00 00    	jne    80103390 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
8010328f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103296:	3c 01                	cmp    $0x1,%al
80103298:	74 08                	je     801032a2 <mpinit+0x92>
8010329a:	3c 04                	cmp    $0x4,%al
8010329c:	0f 85 ee 00 00 00    	jne    80103390 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
801032a2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
801032a9:	66 85 d2             	test   %dx,%dx
801032ac:	74 22                	je     801032d0 <mpinit+0xc0>
801032ae:	8d 3c 32             	lea    (%edx,%esi,1),%edi
801032b1:	89 f0                	mov    %esi,%eax
  sum = 0;
801032b3:	31 d2                	xor    %edx,%edx
801032b5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801032b8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
801032bf:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801032c2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801032c4:	39 c7                	cmp    %eax,%edi
801032c6:	75 f0                	jne    801032b8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
801032c8:	84 d2                	test   %dl,%dl
801032ca:	0f 85 c0 00 00 00    	jne    80103390 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801032d0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
801032d6:	a3 80 36 11 80       	mov    %eax,0x80113680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032db:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801032e2:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
801032e8:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032ed:	03 55 e4             	add    -0x1c(%ebp),%edx
801032f0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801032f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801032f7:	90                   	nop
801032f8:	39 d0                	cmp    %edx,%eax
801032fa:	73 15                	jae    80103311 <mpinit+0x101>
    switch(*p){
801032fc:	0f b6 08             	movzbl (%eax),%ecx
801032ff:	80 f9 02             	cmp    $0x2,%cl
80103302:	74 4c                	je     80103350 <mpinit+0x140>
80103304:	77 3a                	ja     80103340 <mpinit+0x130>
80103306:	84 c9                	test   %cl,%cl
80103308:	74 56                	je     80103360 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010330a:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010330d:	39 d0                	cmp    %edx,%eax
8010330f:	72 eb                	jb     801032fc <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103311:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103314:	85 f6                	test   %esi,%esi
80103316:	0f 84 d9 00 00 00    	je     801033f5 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010331c:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103320:	74 15                	je     80103337 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103322:	b8 70 00 00 00       	mov    $0x70,%eax
80103327:	ba 22 00 00 00       	mov    $0x22,%edx
8010332c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010332d:	ba 23 00 00 00       	mov    $0x23,%edx
80103332:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103333:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103336:	ee                   	out    %al,(%dx)
  }
}
80103337:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010333a:	5b                   	pop    %ebx
8010333b:	5e                   	pop    %esi
8010333c:	5f                   	pop    %edi
8010333d:	5d                   	pop    %ebp
8010333e:	c3                   	ret    
8010333f:	90                   	nop
    switch(*p){
80103340:	83 e9 03             	sub    $0x3,%ecx
80103343:	80 f9 01             	cmp    $0x1,%cl
80103346:	76 c2                	jbe    8010330a <mpinit+0xfa>
80103348:	31 f6                	xor    %esi,%esi
8010334a:	eb ac                	jmp    801032f8 <mpinit+0xe8>
8010334c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103350:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103354:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103357:	88 0d 80 37 11 80    	mov    %cl,0x80113780
      continue;
8010335d:	eb 99                	jmp    801032f8 <mpinit+0xe8>
8010335f:	90                   	nop
      if(ncpu < NCPU) {
80103360:	8b 0d 84 37 11 80    	mov    0x80113784,%ecx
80103366:	83 f9 07             	cmp    $0x7,%ecx
80103369:	7f 19                	jg     80103384 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010336b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103371:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103375:	83 c1 01             	add    $0x1,%ecx
80103378:	89 0d 84 37 11 80    	mov    %ecx,0x80113784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010337e:	88 9f a0 37 11 80    	mov    %bl,-0x7feec860(%edi)
      p += sizeof(struct mpproc);
80103384:	83 c0 14             	add    $0x14,%eax
      continue;
80103387:	e9 6c ff ff ff       	jmp    801032f8 <mpinit+0xe8>
8010338c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103390:	83 ec 0c             	sub    $0xc,%esp
80103393:	68 e2 88 10 80       	push   $0x801088e2
80103398:	e8 e3 cf ff ff       	call   80100380 <panic>
8010339d:	8d 76 00             	lea    0x0(%esi),%esi
{
801033a0:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801033a5:	eb 13                	jmp    801033ba <mpinit+0x1aa>
801033a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033ae:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
801033b0:	89 f3                	mov    %esi,%ebx
801033b2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801033b8:	74 d6                	je     80103390 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033ba:	83 ec 04             	sub    $0x4,%esp
801033bd:	8d 73 10             	lea    0x10(%ebx),%esi
801033c0:	6a 04                	push   $0x4
801033c2:	68 d8 88 10 80       	push   $0x801088d8
801033c7:	53                   	push   %ebx
801033c8:	e8 83 15 00 00       	call   80104950 <memcmp>
801033cd:	83 c4 10             	add    $0x10,%esp
801033d0:	85 c0                	test   %eax,%eax
801033d2:	75 dc                	jne    801033b0 <mpinit+0x1a0>
801033d4:	89 da                	mov    %ebx,%edx
801033d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033dd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801033e0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801033e3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801033e6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801033e8:	39 d6                	cmp    %edx,%esi
801033ea:	75 f4                	jne    801033e0 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033ec:	84 c0                	test   %al,%al
801033ee:	75 c0                	jne    801033b0 <mpinit+0x1a0>
801033f0:	e9 6b fe ff ff       	jmp    80103260 <mpinit+0x50>
    panic("Didn't find a suitable machine");
801033f5:	83 ec 0c             	sub    $0xc,%esp
801033f8:	68 fc 88 10 80       	push   $0x801088fc
801033fd:	e8 7e cf ff ff       	call   80100380 <panic>
80103402:	66 90                	xchg   %ax,%ax
80103404:	66 90                	xchg   %ax,%ax
80103406:	66 90                	xchg   %ax,%ax
80103408:	66 90                	xchg   %ax,%ax
8010340a:	66 90                	xchg   %ax,%ax
8010340c:	66 90                	xchg   %ax,%ax
8010340e:	66 90                	xchg   %ax,%ax

80103410 <picinit>:
80103410:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103415:	ba 21 00 00 00       	mov    $0x21,%edx
8010341a:	ee                   	out    %al,(%dx)
8010341b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103420:	ee                   	out    %al,(%dx)
80103421:	c3                   	ret    
80103422:	66 90                	xchg   %ax,%ax
80103424:	66 90                	xchg   %ax,%ax
80103426:	66 90                	xchg   %ax,%ax
80103428:	66 90                	xchg   %ax,%ax
8010342a:	66 90                	xchg   %ax,%ax
8010342c:	66 90                	xchg   %ax,%ax
8010342e:	66 90                	xchg   %ax,%ax

80103430 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103430:	55                   	push   %ebp
80103431:	89 e5                	mov    %esp,%ebp
80103433:	57                   	push   %edi
80103434:	56                   	push   %esi
80103435:	53                   	push   %ebx
80103436:	83 ec 0c             	sub    $0xc,%esp
80103439:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010343c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010343f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103445:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010344b:	e8 e0 d9 ff ff       	call   80100e30 <filealloc>
80103450:	89 03                	mov    %eax,(%ebx)
80103452:	85 c0                	test   %eax,%eax
80103454:	0f 84 a8 00 00 00    	je     80103502 <pipealloc+0xd2>
8010345a:	e8 d1 d9 ff ff       	call   80100e30 <filealloc>
8010345f:	89 06                	mov    %eax,(%esi)
80103461:	85 c0                	test   %eax,%eax
80103463:	0f 84 87 00 00 00    	je     801034f0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103469:	e8 12 f2 ff ff       	call   80102680 <kalloc>
8010346e:	89 c7                	mov    %eax,%edi
80103470:	85 c0                	test   %eax,%eax
80103472:	0f 84 b0 00 00 00    	je     80103528 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80103478:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010347f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103482:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103485:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010348c:	00 00 00 
  p->nwrite = 0;
8010348f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103496:	00 00 00 
  p->nread = 0;
80103499:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801034a0:	00 00 00 
  initlock(&p->lock, "pipe");
801034a3:	68 1b 89 10 80       	push   $0x8010891b
801034a8:	50                   	push   %eax
801034a9:	e8 c2 11 00 00       	call   80104670 <initlock>
  (*f0)->type = FD_PIPE;
801034ae:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801034b0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801034b3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801034b9:	8b 03                	mov    (%ebx),%eax
801034bb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801034bf:	8b 03                	mov    (%ebx),%eax
801034c1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801034c5:	8b 03                	mov    (%ebx),%eax
801034c7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801034ca:	8b 06                	mov    (%esi),%eax
801034cc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801034d2:	8b 06                	mov    (%esi),%eax
801034d4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801034d8:	8b 06                	mov    (%esi),%eax
801034da:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801034de:	8b 06                	mov    (%esi),%eax
801034e0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801034e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801034e6:	31 c0                	xor    %eax,%eax
}
801034e8:	5b                   	pop    %ebx
801034e9:	5e                   	pop    %esi
801034ea:	5f                   	pop    %edi
801034eb:	5d                   	pop    %ebp
801034ec:	c3                   	ret    
801034ed:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
801034f0:	8b 03                	mov    (%ebx),%eax
801034f2:	85 c0                	test   %eax,%eax
801034f4:	74 1e                	je     80103514 <pipealloc+0xe4>
    fileclose(*f0);
801034f6:	83 ec 0c             	sub    $0xc,%esp
801034f9:	50                   	push   %eax
801034fa:	e8 f1 d9 ff ff       	call   80100ef0 <fileclose>
801034ff:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103502:	8b 06                	mov    (%esi),%eax
80103504:	85 c0                	test   %eax,%eax
80103506:	74 0c                	je     80103514 <pipealloc+0xe4>
    fileclose(*f1);
80103508:	83 ec 0c             	sub    $0xc,%esp
8010350b:	50                   	push   %eax
8010350c:	e8 df d9 ff ff       	call   80100ef0 <fileclose>
80103511:	83 c4 10             	add    $0x10,%esp
}
80103514:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103517:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010351c:	5b                   	pop    %ebx
8010351d:	5e                   	pop    %esi
8010351e:	5f                   	pop    %edi
8010351f:	5d                   	pop    %ebp
80103520:	c3                   	ret    
80103521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103528:	8b 03                	mov    (%ebx),%eax
8010352a:	85 c0                	test   %eax,%eax
8010352c:	75 c8                	jne    801034f6 <pipealloc+0xc6>
8010352e:	eb d2                	jmp    80103502 <pipealloc+0xd2>

80103530 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103530:	55                   	push   %ebp
80103531:	89 e5                	mov    %esp,%ebp
80103533:	56                   	push   %esi
80103534:	53                   	push   %ebx
80103535:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103538:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010353b:	83 ec 0c             	sub    $0xc,%esp
8010353e:	53                   	push   %ebx
8010353f:	e8 fc 12 00 00       	call   80104840 <acquire>
  if(writable){
80103544:	83 c4 10             	add    $0x10,%esp
80103547:	85 f6                	test   %esi,%esi
80103549:	74 65                	je     801035b0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010354b:	83 ec 0c             	sub    $0xc,%esp
8010354e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103554:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010355b:	00 00 00 
    wakeup(&p->nread);
8010355e:	50                   	push   %eax
8010355f:	e8 3c 0e 00 00       	call   801043a0 <wakeup>
80103564:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103567:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010356d:	85 d2                	test   %edx,%edx
8010356f:	75 0a                	jne    8010357b <pipeclose+0x4b>
80103571:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103577:	85 c0                	test   %eax,%eax
80103579:	74 15                	je     80103590 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010357b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010357e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103581:	5b                   	pop    %ebx
80103582:	5e                   	pop    %esi
80103583:	5d                   	pop    %ebp
    release(&p->lock);
80103584:	e9 57 12 00 00       	jmp    801047e0 <release>
80103589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103590:	83 ec 0c             	sub    $0xc,%esp
80103593:	53                   	push   %ebx
80103594:	e8 47 12 00 00       	call   801047e0 <release>
    kfree((char*)p);
80103599:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010359c:	83 c4 10             	add    $0x10,%esp
}
8010359f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801035a2:	5b                   	pop    %ebx
801035a3:	5e                   	pop    %esi
801035a4:	5d                   	pop    %ebp
    kfree((char*)p);
801035a5:	e9 16 ef ff ff       	jmp    801024c0 <kfree>
801035aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801035b0:	83 ec 0c             	sub    $0xc,%esp
801035b3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801035b9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801035c0:	00 00 00 
    wakeup(&p->nwrite);
801035c3:	50                   	push   %eax
801035c4:	e8 d7 0d 00 00       	call   801043a0 <wakeup>
801035c9:	83 c4 10             	add    $0x10,%esp
801035cc:	eb 99                	jmp    80103567 <pipeclose+0x37>
801035ce:	66 90                	xchg   %ax,%ax

801035d0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801035d0:	55                   	push   %ebp
801035d1:	89 e5                	mov    %esp,%ebp
801035d3:	57                   	push   %edi
801035d4:	56                   	push   %esi
801035d5:	53                   	push   %ebx
801035d6:	83 ec 28             	sub    $0x28,%esp
801035d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801035dc:	53                   	push   %ebx
801035dd:	e8 5e 12 00 00       	call   80104840 <acquire>
  for(i = 0; i < n; i++){
801035e2:	8b 45 10             	mov    0x10(%ebp),%eax
801035e5:	83 c4 10             	add    $0x10,%esp
801035e8:	85 c0                	test   %eax,%eax
801035ea:	0f 8e c0 00 00 00    	jle    801036b0 <pipewrite+0xe0>
801035f0:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035f3:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801035f9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801035ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103602:	03 45 10             	add    0x10(%ebp),%eax
80103605:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103608:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010360e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103614:	89 ca                	mov    %ecx,%edx
80103616:	05 00 02 00 00       	add    $0x200,%eax
8010361b:	39 c1                	cmp    %eax,%ecx
8010361d:	74 3f                	je     8010365e <pipewrite+0x8e>
8010361f:	eb 67                	jmp    80103688 <pipewrite+0xb8>
80103621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103628:	e8 a3 03 00 00       	call   801039d0 <myproc>
8010362d:	8b 48 24             	mov    0x24(%eax),%ecx
80103630:	85 c9                	test   %ecx,%ecx
80103632:	75 34                	jne    80103668 <pipewrite+0x98>
      wakeup(&p->nread);
80103634:	83 ec 0c             	sub    $0xc,%esp
80103637:	57                   	push   %edi
80103638:	e8 63 0d 00 00       	call   801043a0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010363d:	58                   	pop    %eax
8010363e:	5a                   	pop    %edx
8010363f:	53                   	push   %ebx
80103640:	56                   	push   %esi
80103641:	e8 9a 0c 00 00       	call   801042e0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103646:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010364c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103652:	83 c4 10             	add    $0x10,%esp
80103655:	05 00 02 00 00       	add    $0x200,%eax
8010365a:	39 c2                	cmp    %eax,%edx
8010365c:	75 2a                	jne    80103688 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010365e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103664:	85 c0                	test   %eax,%eax
80103666:	75 c0                	jne    80103628 <pipewrite+0x58>
        release(&p->lock);
80103668:	83 ec 0c             	sub    $0xc,%esp
8010366b:	53                   	push   %ebx
8010366c:	e8 6f 11 00 00       	call   801047e0 <release>
        return -1;
80103671:	83 c4 10             	add    $0x10,%esp
80103674:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103679:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010367c:	5b                   	pop    %ebx
8010367d:	5e                   	pop    %esi
8010367e:	5f                   	pop    %edi
8010367f:	5d                   	pop    %ebp
80103680:	c3                   	ret    
80103681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103688:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010368b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010368e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103694:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
8010369a:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
8010369d:	83 c6 01             	add    $0x1,%esi
801036a0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801036a3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801036a7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801036aa:	0f 85 58 ff ff ff    	jne    80103608 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801036b0:	83 ec 0c             	sub    $0xc,%esp
801036b3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801036b9:	50                   	push   %eax
801036ba:	e8 e1 0c 00 00       	call   801043a0 <wakeup>
  release(&p->lock);
801036bf:	89 1c 24             	mov    %ebx,(%esp)
801036c2:	e8 19 11 00 00       	call   801047e0 <release>
  return n;
801036c7:	8b 45 10             	mov    0x10(%ebp),%eax
801036ca:	83 c4 10             	add    $0x10,%esp
801036cd:	eb aa                	jmp    80103679 <pipewrite+0xa9>
801036cf:	90                   	nop

801036d0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	57                   	push   %edi
801036d4:	56                   	push   %esi
801036d5:	53                   	push   %ebx
801036d6:	83 ec 18             	sub    $0x18,%esp
801036d9:	8b 75 08             	mov    0x8(%ebp),%esi
801036dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801036df:	56                   	push   %esi
801036e0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801036e6:	e8 55 11 00 00       	call   80104840 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036eb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801036f1:	83 c4 10             	add    $0x10,%esp
801036f4:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
801036fa:	74 2f                	je     8010372b <piperead+0x5b>
801036fc:	eb 37                	jmp    80103735 <piperead+0x65>
801036fe:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103700:	e8 cb 02 00 00       	call   801039d0 <myproc>
80103705:	8b 48 24             	mov    0x24(%eax),%ecx
80103708:	85 c9                	test   %ecx,%ecx
8010370a:	0f 85 80 00 00 00    	jne    80103790 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103710:	83 ec 08             	sub    $0x8,%esp
80103713:	56                   	push   %esi
80103714:	53                   	push   %ebx
80103715:	e8 c6 0b 00 00       	call   801042e0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010371a:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103720:	83 c4 10             	add    $0x10,%esp
80103723:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103729:	75 0a                	jne    80103735 <piperead+0x65>
8010372b:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103731:	85 c0                	test   %eax,%eax
80103733:	75 cb                	jne    80103700 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103735:	8b 55 10             	mov    0x10(%ebp),%edx
80103738:	31 db                	xor    %ebx,%ebx
8010373a:	85 d2                	test   %edx,%edx
8010373c:	7f 20                	jg     8010375e <piperead+0x8e>
8010373e:	eb 2c                	jmp    8010376c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103740:	8d 48 01             	lea    0x1(%eax),%ecx
80103743:	25 ff 01 00 00       	and    $0x1ff,%eax
80103748:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010374e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103753:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103756:	83 c3 01             	add    $0x1,%ebx
80103759:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010375c:	74 0e                	je     8010376c <piperead+0x9c>
    if(p->nread == p->nwrite)
8010375e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103764:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010376a:	75 d4                	jne    80103740 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010376c:	83 ec 0c             	sub    $0xc,%esp
8010376f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103775:	50                   	push   %eax
80103776:	e8 25 0c 00 00       	call   801043a0 <wakeup>
  release(&p->lock);
8010377b:	89 34 24             	mov    %esi,(%esp)
8010377e:	e8 5d 10 00 00       	call   801047e0 <release>
  return i;
80103783:	83 c4 10             	add    $0x10,%esp
}
80103786:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103789:	89 d8                	mov    %ebx,%eax
8010378b:	5b                   	pop    %ebx
8010378c:	5e                   	pop    %esi
8010378d:	5f                   	pop    %edi
8010378e:	5d                   	pop    %ebp
8010378f:	c3                   	ret    
      release(&p->lock);
80103790:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103793:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103798:	56                   	push   %esi
80103799:	e8 42 10 00 00       	call   801047e0 <release>
      return -1;
8010379e:	83 c4 10             	add    $0x10,%esp
}
801037a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037a4:	89 d8                	mov    %ebx,%eax
801037a6:	5b                   	pop    %ebx
801037a7:	5e                   	pop    %esi
801037a8:	5f                   	pop    %edi
801037a9:	5d                   	pop    %ebp
801037aa:	c3                   	ret    
801037ab:	66 90                	xchg   %ax,%ax
801037ad:	66 90                	xchg   %ax,%ax
801037af:	90                   	nop

801037b0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037b4:	bb 54 3d 11 80       	mov    $0x80113d54,%ebx
{
801037b9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801037bc:	68 20 3d 11 80       	push   $0x80113d20
801037c1:	e8 7a 10 00 00       	call   80104840 <acquire>
801037c6:	83 c4 10             	add    $0x10,%esp
801037c9:	eb 17                	jmp    801037e2 <allocproc+0x32>
801037cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037cf:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037d0:	81 c3 c4 01 00 00    	add    $0x1c4,%ebx
801037d6:	81 fb 54 ae 11 80    	cmp    $0x8011ae54,%ebx
801037dc:	0f 84 c6 00 00 00    	je     801038a8 <allocproc+0xf8>
    if(p->state == UNUSED)
801037e2:	8b 43 0c             	mov    0xc(%ebx),%eax
801037e5:	85 c0                	test   %eax,%eax
801037e7:	75 e7                	jne    801037d0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037e9:	a1 04 c0 10 80       	mov    0x8010c004,%eax

  release(&ptable.lock);
801037ee:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801037f1:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801037f8:	89 43 10             	mov    %eax,0x10(%ebx)
801037fb:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
801037fe:	68 20 3d 11 80       	push   $0x80113d20
  p->pid = nextpid++;
80103803:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
80103809:	e8 d2 0f 00 00       	call   801047e0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010380e:	e8 6d ee ff ff       	call   80102680 <kalloc>
80103813:	83 c4 10             	add    $0x10,%esp
80103816:	89 43 08             	mov    %eax,0x8(%ebx)
80103819:	85 c0                	test   %eax,%eax
8010381b:	0f 84 a0 00 00 00    	je     801038c1 <allocproc+0x111>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103821:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103827:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010382a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010382f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103832:	c7 40 14 32 5c 10 80 	movl   $0x80105c32,0x14(%eax)
  p->context = (struct context*)sp;
80103839:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010383c:	6a 14                	push   $0x14
8010383e:	6a 00                	push   $0x0
80103840:	50                   	push   %eax
80103841:	e8 ba 10 00 00       	call   80104900 <memset>
  p->context->eip = (uint)forkret;
80103846:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103849:	8d 93 bc 01 00 00    	lea    0x1bc(%ebx),%edx
8010384f:	83 c4 10             	add    $0x10,%esp
80103852:	c7 40 10 e0 38 10 80 	movl   $0x801038e0,0x10(%eax)

  for (int i = 0; i < 16; ++i) {
80103859:	8d 43 7c             	lea    0x7c(%ebx),%eax
8010385c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->addr[i].va = 0;
80103860:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for (int i = 0; i < 16; ++i) {
80103866:	83 c0 14             	add    $0x14,%eax
    p->addr[i].size = 0;
80103869:	c7 40 f0 00 00 00 00 	movl   $0x0,-0x10(%eax)
    p->addr[i].phys_page_used = 0;
80103870:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
    p->addr[i].flags = 0;
80103877:	c7 40 f4 00 00 00 00 	movl   $0x0,-0xc(%eax)
    p->addr[i].fd = 0;
8010387e:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%eax)
  for (int i = 0; i < 16; ++i) {
80103885:	39 d0                	cmp    %edx,%eax
80103887:	75 d7                	jne    80103860 <allocproc+0xb0>
    //p->addr[i].access = 0;
  }
  p->memory_used = 0;
80103889:	c7 83 bc 01 00 00 00 	movl   $0x0,0x1bc(%ebx)
80103890:	00 00 00 
  p->n_mmaps = 0;

  return p;
}
80103893:	89 d8                	mov    %ebx,%eax
  p->n_mmaps = 0;
80103895:	c7 83 c0 01 00 00 00 	movl   $0x0,0x1c0(%ebx)
8010389c:	00 00 00 
}
8010389f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038a2:	c9                   	leave  
801038a3:	c3                   	ret    
801038a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801038a8:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801038ab:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801038ad:	68 20 3d 11 80       	push   $0x80113d20
801038b2:	e8 29 0f 00 00       	call   801047e0 <release>
}
801038b7:	89 d8                	mov    %ebx,%eax
  return 0;
801038b9:	83 c4 10             	add    $0x10,%esp
}
801038bc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038bf:	c9                   	leave  
801038c0:	c3                   	ret    
    p->state = UNUSED;
801038c1:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801038c8:	31 db                	xor    %ebx,%ebx
}
801038ca:	89 d8                	mov    %ebx,%eax
801038cc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038cf:	c9                   	leave  
801038d0:	c3                   	ret    
801038d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038df:	90                   	nop

801038e0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801038e6:	68 20 3d 11 80       	push   $0x80113d20
801038eb:	e8 f0 0e 00 00       	call   801047e0 <release>

  if (first) {
801038f0:	a1 00 c0 10 80       	mov    0x8010c000,%eax
801038f5:	83 c4 10             	add    $0x10,%esp
801038f8:	85 c0                	test   %eax,%eax
801038fa:	75 04                	jne    80103900 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038fc:	c9                   	leave  
801038fd:	c3                   	ret    
801038fe:	66 90                	xchg   %ax,%ax
    first = 0;
80103900:	c7 05 00 c0 10 80 00 	movl   $0x0,0x8010c000
80103907:	00 00 00 
    iinit(ROOTDEV);
8010390a:	83 ec 0c             	sub    $0xc,%esp
8010390d:	6a 01                	push   $0x1
8010390f:	e8 4c dc ff ff       	call   80101560 <iinit>
    initlog(ROOTDEV);
80103914:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010391b:	e8 a0 f3 ff ff       	call   80102cc0 <initlog>
}
80103920:	83 c4 10             	add    $0x10,%esp
80103923:	c9                   	leave  
80103924:	c3                   	ret    
80103925:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010392c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103930 <pinit>:
{
80103930:	55                   	push   %ebp
80103931:	89 e5                	mov    %esp,%ebp
80103933:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103936:	68 20 89 10 80       	push   $0x80108920
8010393b:	68 20 3d 11 80       	push   $0x80113d20
80103940:	e8 2b 0d 00 00       	call   80104670 <initlock>
}
80103945:	83 c4 10             	add    $0x10,%esp
80103948:	c9                   	leave  
80103949:	c3                   	ret    
8010394a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103950 <mycpu>:
{
80103950:	55                   	push   %ebp
80103951:	89 e5                	mov    %esp,%ebp
80103953:	56                   	push   %esi
80103954:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103955:	9c                   	pushf  
80103956:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103957:	f6 c4 02             	test   $0x2,%ah
8010395a:	75 46                	jne    801039a2 <mycpu+0x52>
  apicid = lapicid();
8010395c:	e8 8f ef ff ff       	call   801028f0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103961:	8b 35 84 37 11 80    	mov    0x80113784,%esi
80103967:	85 f6                	test   %esi,%esi
80103969:	7e 2a                	jle    80103995 <mycpu+0x45>
8010396b:	31 d2                	xor    %edx,%edx
8010396d:	eb 08                	jmp    80103977 <mycpu+0x27>
8010396f:	90                   	nop
80103970:	83 c2 01             	add    $0x1,%edx
80103973:	39 f2                	cmp    %esi,%edx
80103975:	74 1e                	je     80103995 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103977:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010397d:	0f b6 99 a0 37 11 80 	movzbl -0x7feec860(%ecx),%ebx
80103984:	39 c3                	cmp    %eax,%ebx
80103986:	75 e8                	jne    80103970 <mycpu+0x20>
}
80103988:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010398b:	8d 81 a0 37 11 80    	lea    -0x7feec860(%ecx),%eax
}
80103991:	5b                   	pop    %ebx
80103992:	5e                   	pop    %esi
80103993:	5d                   	pop    %ebp
80103994:	c3                   	ret    
  panic("unknown apicid\n");
80103995:	83 ec 0c             	sub    $0xc,%esp
80103998:	68 27 89 10 80       	push   $0x80108927
8010399d:	e8 de c9 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
801039a2:	83 ec 0c             	sub    $0xc,%esp
801039a5:	68 14 8a 10 80       	push   $0x80108a14
801039aa:	e8 d1 c9 ff ff       	call   80100380 <panic>
801039af:	90                   	nop

801039b0 <cpuid>:
cpuid() {
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801039b6:	e8 95 ff ff ff       	call   80103950 <mycpu>
}
801039bb:	c9                   	leave  
  return mycpu()-cpus;
801039bc:	2d a0 37 11 80       	sub    $0x801137a0,%eax
801039c1:	c1 f8 04             	sar    $0x4,%eax
801039c4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801039ca:	c3                   	ret    
801039cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039cf:	90                   	nop

801039d0 <myproc>:
myproc(void) {
801039d0:	55                   	push   %ebp
801039d1:	89 e5                	mov    %esp,%ebp
801039d3:	53                   	push   %ebx
801039d4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801039d7:	e8 14 0d 00 00       	call   801046f0 <pushcli>
  c = mycpu();
801039dc:	e8 6f ff ff ff       	call   80103950 <mycpu>
  p = c->proc;
801039e1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039e7:	e8 54 0d 00 00       	call   80104740 <popcli>
}
801039ec:	89 d8                	mov    %ebx,%eax
801039ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039f1:	c9                   	leave  
801039f2:	c3                   	ret    
801039f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a00 <userinit>:
{
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	53                   	push   %ebx
80103a04:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103a07:	e8 a4 fd ff ff       	call   801037b0 <allocproc>
80103a0c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103a0e:	a3 54 ae 11 80       	mov    %eax,0x8011ae54
  if((p->pgdir = setupkvm()) == 0)
80103a13:	e8 48 3a 00 00       	call   80107460 <setupkvm>
80103a18:	89 43 04             	mov    %eax,0x4(%ebx)
80103a1b:	85 c0                	test   %eax,%eax
80103a1d:	0f 84 bd 00 00 00    	je     80103ae0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a23:	83 ec 04             	sub    $0x4,%esp
80103a26:	68 2c 00 00 00       	push   $0x2c
80103a2b:	68 60 c4 10 80       	push   $0x8010c460
80103a30:	50                   	push   %eax
80103a31:	e8 da 36 00 00       	call   80107110 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103a36:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103a39:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103a3f:	6a 4c                	push   $0x4c
80103a41:	6a 00                	push   $0x0
80103a43:	ff 73 18             	push   0x18(%ebx)
80103a46:	e8 b5 0e 00 00       	call   80104900 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a4b:	8b 43 18             	mov    0x18(%ebx),%eax
80103a4e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a53:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a56:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a5b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a5f:	8b 43 18             	mov    0x18(%ebx),%eax
80103a62:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a66:	8b 43 18             	mov    0x18(%ebx),%eax
80103a69:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a6d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a71:	8b 43 18             	mov    0x18(%ebx),%eax
80103a74:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a78:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a7c:	8b 43 18             	mov    0x18(%ebx),%eax
80103a7f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a86:	8b 43 18             	mov    0x18(%ebx),%eax
80103a89:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a90:	8b 43 18             	mov    0x18(%ebx),%eax
80103a93:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a9a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a9d:	6a 10                	push   $0x10
80103a9f:	68 50 89 10 80       	push   $0x80108950
80103aa4:	50                   	push   %eax
80103aa5:	e8 16 10 00 00       	call   80104ac0 <safestrcpy>
  p->cwd = namei("/");
80103aaa:	c7 04 24 59 89 10 80 	movl   $0x80108959,(%esp)
80103ab1:	e8 ea e5 ff ff       	call   801020a0 <namei>
80103ab6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103ab9:	c7 04 24 20 3d 11 80 	movl   $0x80113d20,(%esp)
80103ac0:	e8 7b 0d 00 00       	call   80104840 <acquire>
  p->state = RUNNABLE;
80103ac5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103acc:	c7 04 24 20 3d 11 80 	movl   $0x80113d20,(%esp)
80103ad3:	e8 08 0d 00 00       	call   801047e0 <release>
}
80103ad8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103adb:	83 c4 10             	add    $0x10,%esp
80103ade:	c9                   	leave  
80103adf:	c3                   	ret    
    panic("userinit: out of memory?");
80103ae0:	83 ec 0c             	sub    $0xc,%esp
80103ae3:	68 37 89 10 80       	push   $0x80108937
80103ae8:	e8 93 c8 ff ff       	call   80100380 <panic>
80103aed:	8d 76 00             	lea    0x0(%esi),%esi

80103af0 <growproc>:
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	56                   	push   %esi
80103af4:	53                   	push   %ebx
80103af5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103af8:	e8 f3 0b 00 00       	call   801046f0 <pushcli>
  c = mycpu();
80103afd:	e8 4e fe ff ff       	call   80103950 <mycpu>
  p = c->proc;
80103b02:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b08:	e8 33 0c 00 00       	call   80104740 <popcli>
  sz = curproc->sz;
80103b0d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103b0f:	85 f6                	test   %esi,%esi
80103b11:	7f 1d                	jg     80103b30 <growproc+0x40>
  } else if(n < 0){
80103b13:	75 3b                	jne    80103b50 <growproc+0x60>
  switchuvm(curproc);
80103b15:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103b18:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103b1a:	53                   	push   %ebx
80103b1b:	e8 e0 34 00 00       	call   80107000 <switchuvm>
  return 0;
80103b20:	83 c4 10             	add    $0x10,%esp
80103b23:	31 c0                	xor    %eax,%eax
}
80103b25:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b28:	5b                   	pop    %ebx
80103b29:	5e                   	pop    %esi
80103b2a:	5d                   	pop    %ebp
80103b2b:	c3                   	ret    
80103b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b30:	83 ec 04             	sub    $0x4,%esp
80103b33:	01 c6                	add    %eax,%esi
80103b35:	56                   	push   %esi
80103b36:	50                   	push   %eax
80103b37:	ff 73 04             	push   0x4(%ebx)
80103b3a:	e8 41 37 00 00       	call   80107280 <allocuvm>
80103b3f:	83 c4 10             	add    $0x10,%esp
80103b42:	85 c0                	test   %eax,%eax
80103b44:	75 cf                	jne    80103b15 <growproc+0x25>
      return -1;
80103b46:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b4b:	eb d8                	jmp    80103b25 <growproc+0x35>
80103b4d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b50:	83 ec 04             	sub    $0x4,%esp
80103b53:	01 c6                	add    %eax,%esi
80103b55:	56                   	push   %esi
80103b56:	50                   	push   %eax
80103b57:	ff 73 04             	push   0x4(%ebx)
80103b5a:	e8 51 38 00 00       	call   801073b0 <deallocuvm>
80103b5f:	83 c4 10             	add    $0x10,%esp
80103b62:	85 c0                	test   %eax,%eax
80103b64:	75 af                	jne    80103b15 <growproc+0x25>
80103b66:	eb de                	jmp    80103b46 <growproc+0x56>
80103b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b6f:	90                   	nop

80103b70 <map_shared>:
void map_shared(uint addr, int size, pde_t* ptp, pde_t* ptc) {
80103b70:	55                   	push   %ebp
80103b71:	89 e5                	mov    %esp,%ebp
80103b73:	57                   	push   %edi
80103b74:	56                   	push   %esi
80103b75:	53                   	push   %ebx
80103b76:	83 ec 0c             	sub    $0xc,%esp
80103b79:	8b 45 0c             	mov    0xc(%ebp),%eax
80103b7c:	8b 7d 08             	mov    0x8(%ebp),%edi
  while(count < size / 4096) {
80103b7f:	85 c0                	test   %eax,%eax
80103b81:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80103b87:	0f 49 f0             	cmovns %eax,%esi
80103b8a:	c1 fe 0c             	sar    $0xc,%esi
80103b8d:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80103b92:	7e 59                	jle    80103bed <map_shared+0x7d>
  int count = 0;
80103b94:	31 db                	xor    %ebx,%ebx
80103b96:	eb 15                	jmp    80103bad <map_shared+0x3d>
80103b98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b9f:	90                   	nop
	  ++count;
80103ba0:	83 c3 01             	add    $0x1,%ebx
  while(count < size / 4096) {
80103ba3:	81 c7 00 10 00 00    	add    $0x1000,%edi
80103ba9:	39 f3                	cmp    %esi,%ebx
80103bab:	7d 40                	jge    80103bed <map_shared+0x7d>
    pte_t* pte = walkpgdir(ptp, (void*)addr + (count * 4096), 0);
80103bad:	83 ec 04             	sub    $0x4,%esp
80103bb0:	6a 00                	push   $0x0
80103bb2:	57                   	push   %edi
80103bb3:	ff 75 10             	push   0x10(%ebp)
80103bb6:	e8 b5 32 00 00       	call   80106e70 <walkpgdir>
	  if(PTE_P & *pte){
80103bbb:	83 c4 10             	add    $0x10,%esp
80103bbe:	8b 00                	mov    (%eax),%eax
80103bc0:	a8 01                	test   $0x1,%al
80103bc2:	74 dc                	je     80103ba0 <map_shared+0x30>
	    mappages(ptc, (void*)(addr + count * 4096), 4096, physical_address, PTE_W | PTE_U);
80103bc4:	83 ec 0c             	sub    $0xc,%esp
	    int physical_address = PTE_ADDR(*pte); 	
80103bc7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
	  ++count;
80103bcc:	83 c3 01             	add    $0x1,%ebx
	    mappages(ptc, (void*)(addr + count * 4096), 4096, physical_address, PTE_W | PTE_U);
80103bcf:	6a 06                	push   $0x6
80103bd1:	50                   	push   %eax
80103bd2:	68 00 10 00 00       	push   $0x1000
80103bd7:	57                   	push   %edi
  while(count < size / 4096) {
80103bd8:	81 c7 00 10 00 00    	add    $0x1000,%edi
	    mappages(ptc, (void*)(addr + count * 4096), 4096, physical_address, PTE_W | PTE_U);
80103bde:	ff 75 14             	push   0x14(%ebp)
80103be1:	e8 1a 33 00 00       	call   80106f00 <mappages>
80103be6:	83 c4 20             	add    $0x20,%esp
  while(count < size / 4096) {
80103be9:	39 f3                	cmp    %esi,%ebx
80103beb:	7c c0                	jl     80103bad <map_shared+0x3d>
}
80103bed:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bf0:	5b                   	pop    %ebx
80103bf1:	5e                   	pop    %esi
80103bf2:	5f                   	pop    %edi
80103bf3:	5d                   	pop    %ebp
80103bf4:	c3                   	ret    
80103bf5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103c00 <map_private>:
void map_private(uint addr, int size, pde_t* ptp, pde_t* ptc) {
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	57                   	push   %edi
80103c04:	56                   	push   %esi
80103c05:	53                   	push   %ebx
80103c06:	83 ec 20             	sub    $0x20,%esp
80103c09:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80103c0c:	8b 75 08             	mov    0x8(%ebp),%esi
80103c0f:	8b 45 10             	mov    0x10(%ebp),%eax
  cprintf("addr %x, size %d\n", addr, size);
80103c12:	53                   	push   %ebx
80103c13:	56                   	push   %esi
80103c14:	68 5b 89 10 80       	push   $0x8010895b
void map_private(uint addr, int size, pde_t* ptp, pde_t* ptc) {
80103c19:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103c1c:	8b 45 14             	mov    0x14(%ebp),%eax
80103c1f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  cprintf("addr %x, size %d\n", addr, size);
80103c22:	e8 79 ca ff ff       	call   801006a0 <cprintf>
  while(count < size / 4096) {
80103c27:	8d 83 ff 0f 00 00    	lea    0xfff(%ebx),%eax
80103c2d:	83 c4 10             	add    $0x10,%esp
80103c30:	85 db                	test   %ebx,%ebx
80103c32:	0f 49 c3             	cmovns %ebx,%eax
80103c35:	c1 f8 0c             	sar    $0xc,%eax
80103c38:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103c3b:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80103c41:	0f 8e 89 00 00 00    	jle    80103cd0 <map_private+0xd0>
  int count = 0;
80103c47:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80103c4a:	31 ff                	xor    %edi,%edi
80103c4c:	eb 10                	jmp    80103c5e <map_private+0x5e>
80103c4e:	66 90                	xchg   %ax,%ax
	  ++count;
80103c50:	83 c7 01             	add    $0x1,%edi
  while(count < size / 4096) {
80103c53:	81 c6 00 10 00 00    	add    $0x1000,%esi
80103c59:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80103c5c:	7d 72                	jge    80103cd0 <map_private+0xd0>
    pte_t* pte = walkpgdir(ptp, (void*)(addr + (count * 4096)), 0);
80103c5e:	83 ec 04             	sub    $0x4,%esp
80103c61:	6a 00                	push   $0x0
80103c63:	56                   	push   %esi
80103c64:	53                   	push   %ebx
80103c65:	e8 06 32 00 00       	call   80106e70 <walkpgdir>
	  if(PTE_P & *pte){
80103c6a:	83 c4 10             	add    $0x10,%esp
80103c6d:	8b 00                	mov    (%eax),%eax
80103c6f:	a8 01                	test   $0x1,%al
80103c71:	74 dd                	je     80103c50 <map_private+0x50>
	    int physical_address = PTE_ADDR(*pte);
80103c73:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80103c78:	89 45 e0             	mov    %eax,-0x20(%ebp)
      mem = kalloc();
80103c7b:	e8 00 ea ff ff       	call   80102680 <kalloc>
80103c80:	89 c2                	mov    %eax,%edx
      if(mem == 0){
80103c82:	85 c0                	test   %eax,%eax
80103c84:	74 5a                	je     80103ce0 <map_private+0xe0>
      memmove((void*) mem, (void*)(P2V(physical_address)), 4096);
80103c86:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103c89:	83 ec 04             	sub    $0x4,%esp
80103c8c:	89 55 e0             	mov    %edx,-0x20(%ebp)
	  ++count;
80103c8f:	83 c7 01             	add    $0x1,%edi
      memmove((void*) mem, (void*)(P2V(physical_address)), 4096);
80103c92:	68 00 10 00 00       	push   $0x1000
80103c97:	05 00 00 00 80       	add    $0x80000000,%eax
80103c9c:	50                   	push   %eax
80103c9d:	52                   	push   %edx
80103c9e:	e8 fd 0c 00 00       	call   801049a0 <memmove>
      mappages(ptc, (void*)(addr + count * 4096), 4096, V2P(mem), PTE_W | PTE_U);
80103ca3:	8b 55 e0             	mov    -0x20(%ebp),%edx
80103ca6:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
80103cad:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80103cb3:	52                   	push   %edx
80103cb4:	68 00 10 00 00       	push   $0x1000
80103cb9:	56                   	push   %esi
  while(count < size / 4096) {
80103cba:	81 c6 00 10 00 00    	add    $0x1000,%esi
      mappages(ptc, (void*)(addr + count * 4096), 4096, V2P(mem), PTE_W | PTE_U);
80103cc0:	ff 75 dc             	push   -0x24(%ebp)
80103cc3:	e8 38 32 00 00       	call   80106f00 <mappages>
80103cc8:	83 c4 20             	add    $0x20,%esp
  while(count < size / 4096) {
80103ccb:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80103cce:	7c 8e                	jl     80103c5e <map_private+0x5e>
}
80103cd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103cd3:	5b                   	pop    %ebx
80103cd4:	5e                   	pop    %esi
80103cd5:	5f                   	pop    %edi
80103cd6:	5d                   	pop    %ebp
80103cd7:	c3                   	ret    
80103cd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cdf:	90                   	nop
        cprintf("kalloc failed in map private fork\n");
80103ce0:	c7 45 08 3c 8a 10 80 	movl   $0x80108a3c,0x8(%ebp)
}
80103ce7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103cea:	5b                   	pop    %ebx
80103ceb:	5e                   	pop    %esi
80103cec:	5f                   	pop    %edi
80103ced:	5d                   	pop    %ebp
        cprintf("kalloc failed in map private fork\n");
80103cee:	e9 ad c9 ff ff       	jmp    801006a0 <cprintf>
80103cf3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103d00 <fork>:
{
80103d00:	55                   	push   %ebp
80103d01:	89 e5                	mov    %esp,%ebp
80103d03:	57                   	push   %edi
80103d04:	56                   	push   %esi
80103d05:	53                   	push   %ebx
80103d06:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103d09:	e8 e2 09 00 00       	call   801046f0 <pushcli>
  c = mycpu();
80103d0e:	e8 3d fc ff ff       	call   80103950 <mycpu>
  p = c->proc;
80103d13:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d19:	e8 22 0a 00 00       	call   80104740 <popcli>
  if((np = allocproc()) == 0){
80103d1e:	e8 8d fa ff ff       	call   801037b0 <allocproc>
80103d23:	85 c0                	test   %eax,%eax
80103d25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103d28:	0f 84 6a 01 00 00    	je     80103e98 <fork+0x198>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103d2e:	83 ec 08             	sub    $0x8,%esp
80103d31:	ff 33                	push   (%ebx)
80103d33:	ff 73 04             	push   0x4(%ebx)
80103d36:	e8 15 38 00 00       	call   80107550 <copyuvm>
80103d3b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103d3e:	83 c4 10             	add    $0x10,%esp
80103d41:	89 42 04             	mov    %eax,0x4(%edx)
80103d44:	85 c0                	test   %eax,%eax
80103d46:	0f 84 53 01 00 00    	je     80103e9f <fork+0x19f>
  np->sz = curproc->sz;
80103d4c:	8b 03                	mov    (%ebx),%eax
  *np->tf = *curproc->tf;
80103d4e:	8b 7a 18             	mov    0x18(%edx),%edi
  np->parent = curproc;
80103d51:	89 5a 14             	mov    %ebx,0x14(%edx)
  *np->tf = *curproc->tf;
80103d54:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
80103d59:	89 02                	mov    %eax,(%edx)
  *np->tf = *curproc->tf;
80103d5b:	8b 73 18             	mov    0x18(%ebx),%esi
80103d5e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  np->n_mmaps = curproc->n_mmaps;
80103d60:	be 7c 00 00 00       	mov    $0x7c,%esi
  np->memory_used = curproc->memory_used;
80103d65:	8b 83 bc 01 00 00    	mov    0x1bc(%ebx),%eax
80103d6b:	89 82 bc 01 00 00    	mov    %eax,0x1bc(%edx)
  np->n_mmaps = curproc->n_mmaps;
80103d71:	8b 83 c0 01 00 00    	mov    0x1c0(%ebx),%eax
80103d77:	89 82 c0 01 00 00    	mov    %eax,0x1c0(%edx)
  for(int k = 0; k < 16; ++k) {
80103d7d:	eb 14                	jmp    80103d93 <fork+0x93>
80103d7f:	90                   	nop
    } else if(np->addr[k].flags & MAP_PRIVATE) {
80103d80:	a8 01                	test   $0x1,%al
80103d82:	0f 85 f0 00 00 00    	jne    80103e78 <fork+0x178>
  for(int k = 0; k < 16; ++k) {
80103d88:	83 c6 14             	add    $0x14,%esi
80103d8b:	81 fe bc 01 00 00    	cmp    $0x1bc,%esi
80103d91:	74 50                	je     80103de3 <fork+0xe3>
    np->addr[k] = curproc->addr[k];
80103d93:	8b 04 33             	mov    (%ebx,%esi,1),%eax
80103d96:	89 04 32             	mov    %eax,(%edx,%esi,1)
80103d99:	8b 44 33 04          	mov    0x4(%ebx,%esi,1),%eax
80103d9d:	89 44 32 04          	mov    %eax,0x4(%edx,%esi,1)
80103da1:	8b 44 33 08          	mov    0x8(%ebx,%esi,1),%eax
80103da5:	89 44 32 08          	mov    %eax,0x8(%edx,%esi,1)
80103da9:	8b 4c 33 0c          	mov    0xc(%ebx,%esi,1),%ecx
80103dad:	89 4c 32 0c          	mov    %ecx,0xc(%edx,%esi,1)
80103db1:	8b 4c 33 10          	mov    0x10(%ebx,%esi,1),%ecx
80103db5:	89 4c 32 10          	mov    %ecx,0x10(%edx,%esi,1)
    if (np->addr[k].flags & MAP_SHARED) {
80103db9:	a8 02                	test   $0x2,%al
80103dbb:	74 c3                	je     80103d80 <fork+0x80>
      map_shared(np->addr[k].va, np->addr[k].size, curproc->pgdir, np->pgdir);
80103dbd:	ff 72 04             	push   0x4(%edx)
80103dc0:	ff 73 04             	push   0x4(%ebx)
80103dc3:	ff 74 32 04          	push   0x4(%edx,%esi,1)
80103dc7:	ff 34 32             	push   (%edx,%esi,1)
  for(int k = 0; k < 16; ++k) {
80103dca:	83 c6 14             	add    $0x14,%esi
      map_shared(np->addr[k].va, np->addr[k].size, curproc->pgdir, np->pgdir);
80103dcd:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103dd0:	e8 9b fd ff ff       	call   80103b70 <map_shared>
80103dd5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  for(int k = 0; k < 16; ++k) {
80103dd8:	83 c4 10             	add    $0x10,%esp
80103ddb:	81 fe bc 01 00 00    	cmp    $0x1bc,%esi
80103de1:	75 b0                	jne    80103d93 <fork+0x93>
  np->tf->eax = 0;
80103de3:	8b 42 18             	mov    0x18(%edx),%eax
  for(i = 0; i < NOFILE; i++)
80103de6:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103de8:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103def:	90                   	nop
    if(curproc->ofile[i])
80103df0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103df4:	85 c0                	test   %eax,%eax
80103df6:	74 16                	je     80103e0e <fork+0x10e>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103df8:	83 ec 0c             	sub    $0xc,%esp
80103dfb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103dfe:	50                   	push   %eax
80103dff:	e8 9c d0 ff ff       	call   80100ea0 <filedup>
80103e04:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103e07:	83 c4 10             	add    $0x10,%esp
80103e0a:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103e0e:	83 c6 01             	add    $0x1,%esi
80103e11:	83 fe 10             	cmp    $0x10,%esi
80103e14:	75 da                	jne    80103df0 <fork+0xf0>
  np->cwd = idup(curproc->cwd);
80103e16:	83 ec 0c             	sub    $0xc,%esp
80103e19:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e1c:	83 c3 6c             	add    $0x6c,%ebx
80103e1f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  np->cwd = idup(curproc->cwd);
80103e22:	e8 29 d9 ff ff       	call   80101750 <idup>
80103e27:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e2a:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103e2d:	89 42 68             	mov    %eax,0x68(%edx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e30:	8d 42 6c             	lea    0x6c(%edx),%eax
80103e33:	6a 10                	push   $0x10
80103e35:	53                   	push   %ebx
80103e36:	50                   	push   %eax
80103e37:	e8 84 0c 00 00       	call   80104ac0 <safestrcpy>
  pid = np->pid;
80103e3c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103e3f:	8b 5a 10             	mov    0x10(%edx),%ebx
  acquire(&ptable.lock);
80103e42:	c7 04 24 20 3d 11 80 	movl   $0x80113d20,(%esp)
80103e49:	e8 f2 09 00 00       	call   80104840 <acquire>
  np->state = RUNNABLE;
80103e4e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103e51:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  release(&ptable.lock);
80103e58:	c7 04 24 20 3d 11 80 	movl   $0x80113d20,(%esp)
80103e5f:	e8 7c 09 00 00       	call   801047e0 <release>
  return pid;
80103e64:	83 c4 10             	add    $0x10,%esp
}
80103e67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e6a:	89 d8                	mov    %ebx,%eax
80103e6c:	5b                   	pop    %ebx
80103e6d:	5e                   	pop    %esi
80103e6e:	5f                   	pop    %edi
80103e6f:	5d                   	pop    %ebp
80103e70:	c3                   	ret    
80103e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      map_private(np->addr[k].va, np->addr[k].size, curproc->pgdir, np->pgdir);
80103e78:	ff 72 04             	push   0x4(%edx)
80103e7b:	ff 73 04             	push   0x4(%ebx)
80103e7e:	ff 74 32 04          	push   0x4(%edx,%esi,1)
80103e82:	ff 34 32             	push   (%edx,%esi,1)
80103e85:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103e88:	e8 73 fd ff ff       	call   80103c00 <map_private>
80103e8d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103e90:	83 c4 10             	add    $0x10,%esp
80103e93:	e9 f0 fe ff ff       	jmp    80103d88 <fork+0x88>
    return -1;
80103e98:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103e9d:	eb c8                	jmp    80103e67 <fork+0x167>
    kfree(np->kstack);
80103e9f:	83 ec 0c             	sub    $0xc,%esp
80103ea2:	ff 72 08             	push   0x8(%edx)
    return -1;
80103ea5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    kfree(np->kstack);
80103eaa:	e8 11 e6 ff ff       	call   801024c0 <kfree>
    np->kstack = 0;
80103eaf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    return -1;
80103eb2:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
80103eb5:	c7 42 08 00 00 00 00 	movl   $0x0,0x8(%edx)
    np->state = UNUSED;
80103ebc:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
    return -1;
80103ec3:	eb a2                	jmp    80103e67 <fork+0x167>
80103ec5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ed0 <scheduler>:
{
80103ed0:	55                   	push   %ebp
80103ed1:	89 e5                	mov    %esp,%ebp
80103ed3:	57                   	push   %edi
80103ed4:	56                   	push   %esi
80103ed5:	53                   	push   %ebx
80103ed6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103ed9:	e8 72 fa ff ff       	call   80103950 <mycpu>
  c->proc = 0;
80103ede:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103ee5:	00 00 00 
  struct cpu *c = mycpu();
80103ee8:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103eea:	8d 78 04             	lea    0x4(%eax),%edi
80103eed:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103ef0:	fb                   	sti    
    acquire(&ptable.lock);
80103ef1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ef4:	bb 54 3d 11 80       	mov    $0x80113d54,%ebx
    acquire(&ptable.lock);
80103ef9:	68 20 3d 11 80       	push   $0x80113d20
80103efe:	e8 3d 09 00 00       	call   80104840 <acquire>
80103f03:	83 c4 10             	add    $0x10,%esp
80103f06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f0d:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80103f10:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103f14:	75 33                	jne    80103f49 <scheduler+0x79>
      switchuvm(p);
80103f16:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103f19:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103f1f:	53                   	push   %ebx
80103f20:	e8 db 30 00 00       	call   80107000 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103f25:	58                   	pop    %eax
80103f26:	5a                   	pop    %edx
80103f27:	ff 73 1c             	push   0x1c(%ebx)
80103f2a:	57                   	push   %edi
      p->state = RUNNING;
80103f2b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103f32:	e8 e4 0b 00 00       	call   80104b1b <swtch>
      switchkvm();
80103f37:	e8 b4 30 00 00       	call   80106ff0 <switchkvm>
      c->proc = 0;
80103f3c:	83 c4 10             	add    $0x10,%esp
80103f3f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103f46:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f49:	81 c3 c4 01 00 00    	add    $0x1c4,%ebx
80103f4f:	81 fb 54 ae 11 80    	cmp    $0x8011ae54,%ebx
80103f55:	75 b9                	jne    80103f10 <scheduler+0x40>
    release(&ptable.lock);
80103f57:	83 ec 0c             	sub    $0xc,%esp
80103f5a:	68 20 3d 11 80       	push   $0x80113d20
80103f5f:	e8 7c 08 00 00       	call   801047e0 <release>
    sti();
80103f64:	83 c4 10             	add    $0x10,%esp
80103f67:	eb 87                	jmp    80103ef0 <scheduler+0x20>
80103f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103f70 <sched>:
{
80103f70:	55                   	push   %ebp
80103f71:	89 e5                	mov    %esp,%ebp
80103f73:	56                   	push   %esi
80103f74:	53                   	push   %ebx
  pushcli();
80103f75:	e8 76 07 00 00       	call   801046f0 <pushcli>
  c = mycpu();
80103f7a:	e8 d1 f9 ff ff       	call   80103950 <mycpu>
  p = c->proc;
80103f7f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f85:	e8 b6 07 00 00       	call   80104740 <popcli>
  if(!holding(&ptable.lock))
80103f8a:	83 ec 0c             	sub    $0xc,%esp
80103f8d:	68 20 3d 11 80       	push   $0x80113d20
80103f92:	e8 09 08 00 00       	call   801047a0 <holding>
80103f97:	83 c4 10             	add    $0x10,%esp
80103f9a:	85 c0                	test   %eax,%eax
80103f9c:	74 4f                	je     80103fed <sched+0x7d>
  if(mycpu()->ncli != 1)
80103f9e:	e8 ad f9 ff ff       	call   80103950 <mycpu>
80103fa3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103faa:	75 68                	jne    80104014 <sched+0xa4>
  if(p->state == RUNNING)
80103fac:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103fb0:	74 55                	je     80104007 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103fb2:	9c                   	pushf  
80103fb3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103fb4:	f6 c4 02             	test   $0x2,%ah
80103fb7:	75 41                	jne    80103ffa <sched+0x8a>
  intena = mycpu()->intena;
80103fb9:	e8 92 f9 ff ff       	call   80103950 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103fbe:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103fc1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103fc7:	e8 84 f9 ff ff       	call   80103950 <mycpu>
80103fcc:	83 ec 08             	sub    $0x8,%esp
80103fcf:	ff 70 04             	push   0x4(%eax)
80103fd2:	53                   	push   %ebx
80103fd3:	e8 43 0b 00 00       	call   80104b1b <swtch>
  mycpu()->intena = intena;
80103fd8:	e8 73 f9 ff ff       	call   80103950 <mycpu>
}
80103fdd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103fe0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103fe6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fe9:	5b                   	pop    %ebx
80103fea:	5e                   	pop    %esi
80103feb:	5d                   	pop    %ebp
80103fec:	c3                   	ret    
    panic("sched ptable.lock");
80103fed:	83 ec 0c             	sub    $0xc,%esp
80103ff0:	68 6d 89 10 80       	push   $0x8010896d
80103ff5:	e8 86 c3 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103ffa:	83 ec 0c             	sub    $0xc,%esp
80103ffd:	68 99 89 10 80       	push   $0x80108999
80104002:	e8 79 c3 ff ff       	call   80100380 <panic>
    panic("sched running");
80104007:	83 ec 0c             	sub    $0xc,%esp
8010400a:	68 8b 89 10 80       	push   $0x8010898b
8010400f:	e8 6c c3 ff ff       	call   80100380 <panic>
    panic("sched locks");
80104014:	83 ec 0c             	sub    $0xc,%esp
80104017:	68 7f 89 10 80       	push   $0x8010897f
8010401c:	e8 5f c3 ff ff       	call   80100380 <panic>
80104021:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104028:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010402f:	90                   	nop

80104030 <exit>:
{
80104030:	55                   	push   %ebp
80104031:	89 e5                	mov    %esp,%ebp
80104033:	57                   	push   %edi
80104034:	56                   	push   %esi
80104035:	53                   	push   %ebx
80104036:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104039:	e8 92 f9 ff ff       	call   801039d0 <myproc>
  if(curproc == initproc)
8010403e:	39 05 54 ae 11 80    	cmp    %eax,0x8011ae54
80104044:	0f 84 07 01 00 00    	je     80104151 <exit+0x121>
8010404a:	89 c3                	mov    %eax,%ebx
8010404c:	8d 70 28             	lea    0x28(%eax),%esi
8010404f:	8d 78 68             	lea    0x68(%eax),%edi
80104052:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80104058:	8b 06                	mov    (%esi),%eax
8010405a:	85 c0                	test   %eax,%eax
8010405c:	74 12                	je     80104070 <exit+0x40>
      fileclose(curproc->ofile[fd]);
8010405e:	83 ec 0c             	sub    $0xc,%esp
80104061:	50                   	push   %eax
80104062:	e8 89 ce ff ff       	call   80100ef0 <fileclose>
      curproc->ofile[fd] = 0;
80104067:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010406d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104070:	83 c6 04             	add    $0x4,%esi
80104073:	39 f7                	cmp    %esi,%edi
80104075:	75 e1                	jne    80104058 <exit+0x28>
  begin_op();
80104077:	e8 e4 ec ff ff       	call   80102d60 <begin_op>
  iput(curproc->cwd);
8010407c:	83 ec 0c             	sub    $0xc,%esp
8010407f:	ff 73 68             	push   0x68(%ebx)
80104082:	e8 29 d8 ff ff       	call   801018b0 <iput>
  end_op();
80104087:	e8 44 ed ff ff       	call   80102dd0 <end_op>
  curproc->cwd = 0;
8010408c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80104093:	c7 04 24 20 3d 11 80 	movl   $0x80113d20,(%esp)
8010409a:	e8 a1 07 00 00       	call   80104840 <acquire>
  wakeup1(curproc->parent);
8010409f:	8b 53 14             	mov    0x14(%ebx),%edx
801040a2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040a5:	b8 54 3d 11 80       	mov    $0x80113d54,%eax
801040aa:	eb 10                	jmp    801040bc <exit+0x8c>
801040ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801040b0:	05 c4 01 00 00       	add    $0x1c4,%eax
801040b5:	3d 54 ae 11 80       	cmp    $0x8011ae54,%eax
801040ba:	74 1e                	je     801040da <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
801040bc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040c0:	75 ee                	jne    801040b0 <exit+0x80>
801040c2:	3b 50 20             	cmp    0x20(%eax),%edx
801040c5:	75 e9                	jne    801040b0 <exit+0x80>
      p->state = RUNNABLE;
801040c7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040ce:	05 c4 01 00 00       	add    $0x1c4,%eax
801040d3:	3d 54 ae 11 80       	cmp    $0x8011ae54,%eax
801040d8:	75 e2                	jne    801040bc <exit+0x8c>
      p->parent = initproc;
801040da:	8b 0d 54 ae 11 80    	mov    0x8011ae54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040e0:	ba 54 3d 11 80       	mov    $0x80113d54,%edx
801040e5:	eb 17                	jmp    801040fe <exit+0xce>
801040e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040ee:	66 90                	xchg   %ax,%ax
801040f0:	81 c2 c4 01 00 00    	add    $0x1c4,%edx
801040f6:	81 fa 54 ae 11 80    	cmp    $0x8011ae54,%edx
801040fc:	74 3a                	je     80104138 <exit+0x108>
    if(p->parent == curproc){
801040fe:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104101:	75 ed                	jne    801040f0 <exit+0xc0>
      if(p->state == ZOMBIE)
80104103:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104107:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010410a:	75 e4                	jne    801040f0 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010410c:	b8 54 3d 11 80       	mov    $0x80113d54,%eax
80104111:	eb 11                	jmp    80104124 <exit+0xf4>
80104113:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104117:	90                   	nop
80104118:	05 c4 01 00 00       	add    $0x1c4,%eax
8010411d:	3d 54 ae 11 80       	cmp    $0x8011ae54,%eax
80104122:	74 cc                	je     801040f0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80104124:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104128:	75 ee                	jne    80104118 <exit+0xe8>
8010412a:	3b 48 20             	cmp    0x20(%eax),%ecx
8010412d:	75 e9                	jne    80104118 <exit+0xe8>
      p->state = RUNNABLE;
8010412f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104136:	eb e0                	jmp    80104118 <exit+0xe8>
  curproc->state = ZOMBIE;
80104138:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
8010413f:	e8 2c fe ff ff       	call   80103f70 <sched>
  panic("zombie exit");
80104144:	83 ec 0c             	sub    $0xc,%esp
80104147:	68 ba 89 10 80       	push   $0x801089ba
8010414c:	e8 2f c2 ff ff       	call   80100380 <panic>
    panic("init exiting");
80104151:	83 ec 0c             	sub    $0xc,%esp
80104154:	68 ad 89 10 80       	push   $0x801089ad
80104159:	e8 22 c2 ff ff       	call   80100380 <panic>
8010415e:	66 90                	xchg   %ax,%ax

80104160 <wait>:
{
80104160:	55                   	push   %ebp
80104161:	89 e5                	mov    %esp,%ebp
80104163:	56                   	push   %esi
80104164:	53                   	push   %ebx
  pushcli();
80104165:	e8 86 05 00 00       	call   801046f0 <pushcli>
  c = mycpu();
8010416a:	e8 e1 f7 ff ff       	call   80103950 <mycpu>
  p = c->proc;
8010416f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104175:	e8 c6 05 00 00       	call   80104740 <popcli>
  acquire(&ptable.lock);
8010417a:	83 ec 0c             	sub    $0xc,%esp
8010417d:	68 20 3d 11 80       	push   $0x80113d20
80104182:	e8 b9 06 00 00       	call   80104840 <acquire>
80104187:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010418a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010418c:	bb 54 3d 11 80       	mov    $0x80113d54,%ebx
80104191:	eb 13                	jmp    801041a6 <wait+0x46>
80104193:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104197:	90                   	nop
80104198:	81 c3 c4 01 00 00    	add    $0x1c4,%ebx
8010419e:	81 fb 54 ae 11 80    	cmp    $0x8011ae54,%ebx
801041a4:	74 1e                	je     801041c4 <wait+0x64>
      if(p->parent != curproc)
801041a6:	39 73 14             	cmp    %esi,0x14(%ebx)
801041a9:	75 ed                	jne    80104198 <wait+0x38>
      if(p->state == ZOMBIE){
801041ab:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801041af:	74 5f                	je     80104210 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041b1:	81 c3 c4 01 00 00    	add    $0x1c4,%ebx
      havekids = 1;
801041b7:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041bc:	81 fb 54 ae 11 80    	cmp    $0x8011ae54,%ebx
801041c2:	75 e2                	jne    801041a6 <wait+0x46>
    if(!havekids || curproc->killed){
801041c4:	85 c0                	test   %eax,%eax
801041c6:	0f 84 9a 00 00 00    	je     80104266 <wait+0x106>
801041cc:	8b 46 24             	mov    0x24(%esi),%eax
801041cf:	85 c0                	test   %eax,%eax
801041d1:	0f 85 8f 00 00 00    	jne    80104266 <wait+0x106>
  pushcli();
801041d7:	e8 14 05 00 00       	call   801046f0 <pushcli>
  c = mycpu();
801041dc:	e8 6f f7 ff ff       	call   80103950 <mycpu>
  p = c->proc;
801041e1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801041e7:	e8 54 05 00 00       	call   80104740 <popcli>
  if(p == 0)
801041ec:	85 db                	test   %ebx,%ebx
801041ee:	0f 84 89 00 00 00    	je     8010427d <wait+0x11d>
  p->chan = chan;
801041f4:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
801041f7:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801041fe:	e8 6d fd ff ff       	call   80103f70 <sched>
  p->chan = 0;
80104203:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010420a:	e9 7b ff ff ff       	jmp    8010418a <wait+0x2a>
8010420f:	90                   	nop
        kfree(p->kstack);
80104210:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104213:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104216:	ff 73 08             	push   0x8(%ebx)
80104219:	e8 a2 e2 ff ff       	call   801024c0 <kfree>
        p->kstack = 0;
8010421e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104225:	5a                   	pop    %edx
80104226:	ff 73 04             	push   0x4(%ebx)
80104229:	e8 b2 31 00 00       	call   801073e0 <freevm>
        p->pid = 0;
8010422e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104235:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010423c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104240:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104247:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010424e:	c7 04 24 20 3d 11 80 	movl   $0x80113d20,(%esp)
80104255:	e8 86 05 00 00       	call   801047e0 <release>
        return pid;
8010425a:	83 c4 10             	add    $0x10,%esp
}
8010425d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104260:	89 f0                	mov    %esi,%eax
80104262:	5b                   	pop    %ebx
80104263:	5e                   	pop    %esi
80104264:	5d                   	pop    %ebp
80104265:	c3                   	ret    
      release(&ptable.lock);
80104266:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104269:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010426e:	68 20 3d 11 80       	push   $0x80113d20
80104273:	e8 68 05 00 00       	call   801047e0 <release>
      return -1;
80104278:	83 c4 10             	add    $0x10,%esp
8010427b:	eb e0                	jmp    8010425d <wait+0xfd>
    panic("sleep");
8010427d:	83 ec 0c             	sub    $0xc,%esp
80104280:	68 c6 89 10 80       	push   $0x801089c6
80104285:	e8 f6 c0 ff ff       	call   80100380 <panic>
8010428a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104290 <yield>:
{
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	53                   	push   %ebx
80104294:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104297:	68 20 3d 11 80       	push   $0x80113d20
8010429c:	e8 9f 05 00 00       	call   80104840 <acquire>
  pushcli();
801042a1:	e8 4a 04 00 00       	call   801046f0 <pushcli>
  c = mycpu();
801042a6:	e8 a5 f6 ff ff       	call   80103950 <mycpu>
  p = c->proc;
801042ab:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042b1:	e8 8a 04 00 00       	call   80104740 <popcli>
  myproc()->state = RUNNABLE;
801042b6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801042bd:	e8 ae fc ff ff       	call   80103f70 <sched>
  release(&ptable.lock);
801042c2:	c7 04 24 20 3d 11 80 	movl   $0x80113d20,(%esp)
801042c9:	e8 12 05 00 00       	call   801047e0 <release>
}
801042ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042d1:	83 c4 10             	add    $0x10,%esp
801042d4:	c9                   	leave  
801042d5:	c3                   	ret    
801042d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042dd:	8d 76 00             	lea    0x0(%esi),%esi

801042e0 <sleep>:
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	57                   	push   %edi
801042e4:	56                   	push   %esi
801042e5:	53                   	push   %ebx
801042e6:	83 ec 0c             	sub    $0xc,%esp
801042e9:	8b 7d 08             	mov    0x8(%ebp),%edi
801042ec:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801042ef:	e8 fc 03 00 00       	call   801046f0 <pushcli>
  c = mycpu();
801042f4:	e8 57 f6 ff ff       	call   80103950 <mycpu>
  p = c->proc;
801042f9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042ff:	e8 3c 04 00 00       	call   80104740 <popcli>
  if(p == 0)
80104304:	85 db                	test   %ebx,%ebx
80104306:	0f 84 87 00 00 00    	je     80104393 <sleep+0xb3>
  if(lk == 0)
8010430c:	85 f6                	test   %esi,%esi
8010430e:	74 76                	je     80104386 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104310:	81 fe 20 3d 11 80    	cmp    $0x80113d20,%esi
80104316:	74 50                	je     80104368 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104318:	83 ec 0c             	sub    $0xc,%esp
8010431b:	68 20 3d 11 80       	push   $0x80113d20
80104320:	e8 1b 05 00 00       	call   80104840 <acquire>
    release(lk);
80104325:	89 34 24             	mov    %esi,(%esp)
80104328:	e8 b3 04 00 00       	call   801047e0 <release>
  p->chan = chan;
8010432d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104330:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104337:	e8 34 fc ff ff       	call   80103f70 <sched>
  p->chan = 0;
8010433c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104343:	c7 04 24 20 3d 11 80 	movl   $0x80113d20,(%esp)
8010434a:	e8 91 04 00 00       	call   801047e0 <release>
    acquire(lk);
8010434f:	89 75 08             	mov    %esi,0x8(%ebp)
80104352:	83 c4 10             	add    $0x10,%esp
}
80104355:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104358:	5b                   	pop    %ebx
80104359:	5e                   	pop    %esi
8010435a:	5f                   	pop    %edi
8010435b:	5d                   	pop    %ebp
    acquire(lk);
8010435c:	e9 df 04 00 00       	jmp    80104840 <acquire>
80104361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104368:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010436b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104372:	e8 f9 fb ff ff       	call   80103f70 <sched>
  p->chan = 0;
80104377:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010437e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104381:	5b                   	pop    %ebx
80104382:	5e                   	pop    %esi
80104383:	5f                   	pop    %edi
80104384:	5d                   	pop    %ebp
80104385:	c3                   	ret    
    panic("sleep without lk");
80104386:	83 ec 0c             	sub    $0xc,%esp
80104389:	68 cc 89 10 80       	push   $0x801089cc
8010438e:	e8 ed bf ff ff       	call   80100380 <panic>
    panic("sleep");
80104393:	83 ec 0c             	sub    $0xc,%esp
80104396:	68 c6 89 10 80       	push   $0x801089c6
8010439b:	e8 e0 bf ff ff       	call   80100380 <panic>

801043a0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	53                   	push   %ebx
801043a4:	83 ec 10             	sub    $0x10,%esp
801043a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801043aa:	68 20 3d 11 80       	push   $0x80113d20
801043af:	e8 8c 04 00 00       	call   80104840 <acquire>
801043b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043b7:	b8 54 3d 11 80       	mov    $0x80113d54,%eax
801043bc:	eb 0e                	jmp    801043cc <wakeup+0x2c>
801043be:	66 90                	xchg   %ax,%ax
801043c0:	05 c4 01 00 00       	add    $0x1c4,%eax
801043c5:	3d 54 ae 11 80       	cmp    $0x8011ae54,%eax
801043ca:	74 1e                	je     801043ea <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
801043cc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801043d0:	75 ee                	jne    801043c0 <wakeup+0x20>
801043d2:	3b 58 20             	cmp    0x20(%eax),%ebx
801043d5:	75 e9                	jne    801043c0 <wakeup+0x20>
      p->state = RUNNABLE;
801043d7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043de:	05 c4 01 00 00       	add    $0x1c4,%eax
801043e3:	3d 54 ae 11 80       	cmp    $0x8011ae54,%eax
801043e8:	75 e2                	jne    801043cc <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
801043ea:	c7 45 08 20 3d 11 80 	movl   $0x80113d20,0x8(%ebp)
}
801043f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043f4:	c9                   	leave  
  release(&ptable.lock);
801043f5:	e9 e6 03 00 00       	jmp    801047e0 <release>
801043fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104400 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	53                   	push   %ebx
80104404:	83 ec 10             	sub    $0x10,%esp
80104407:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010440a:	68 20 3d 11 80       	push   $0x80113d20
8010440f:	e8 2c 04 00 00       	call   80104840 <acquire>
80104414:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104417:	b8 54 3d 11 80       	mov    $0x80113d54,%eax
8010441c:	eb 0e                	jmp    8010442c <kill+0x2c>
8010441e:	66 90                	xchg   %ax,%ax
80104420:	05 c4 01 00 00       	add    $0x1c4,%eax
80104425:	3d 54 ae 11 80       	cmp    $0x8011ae54,%eax
8010442a:	74 34                	je     80104460 <kill+0x60>
    if(p->pid == pid){
8010442c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010442f:	75 ef                	jne    80104420 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104431:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104435:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010443c:	75 07                	jne    80104445 <kill+0x45>
        p->state = RUNNABLE;
8010443e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104445:	83 ec 0c             	sub    $0xc,%esp
80104448:	68 20 3d 11 80       	push   $0x80113d20
8010444d:	e8 8e 03 00 00       	call   801047e0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104452:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104455:	83 c4 10             	add    $0x10,%esp
80104458:	31 c0                	xor    %eax,%eax
}
8010445a:	c9                   	leave  
8010445b:	c3                   	ret    
8010445c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104460:	83 ec 0c             	sub    $0xc,%esp
80104463:	68 20 3d 11 80       	push   $0x80113d20
80104468:	e8 73 03 00 00       	call   801047e0 <release>
}
8010446d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104470:	83 c4 10             	add    $0x10,%esp
80104473:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104478:	c9                   	leave  
80104479:	c3                   	ret    
8010447a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104480 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	57                   	push   %edi
80104484:	56                   	push   %esi
80104485:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104488:	53                   	push   %ebx
80104489:	bb c0 3d 11 80       	mov    $0x80113dc0,%ebx
8010448e:	83 ec 3c             	sub    $0x3c,%esp
80104491:	eb 27                	jmp    801044ba <procdump+0x3a>
80104493:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104497:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104498:	83 ec 0c             	sub    $0xc,%esp
8010449b:	68 18 8f 10 80       	push   $0x80108f18
801044a0:	e8 fb c1 ff ff       	call   801006a0 <cprintf>
801044a5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044a8:	81 c3 c4 01 00 00    	add    $0x1c4,%ebx
801044ae:	81 fb c0 ae 11 80    	cmp    $0x8011aec0,%ebx
801044b4:	0f 84 7e 00 00 00    	je     80104538 <procdump+0xb8>
    if(p->state == UNUSED)
801044ba:	8b 43 a0             	mov    -0x60(%ebx),%eax
801044bd:	85 c0                	test   %eax,%eax
801044bf:	74 e7                	je     801044a8 <procdump+0x28>
      state = "???";
801044c1:	ba dd 89 10 80       	mov    $0x801089dd,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801044c6:	83 f8 05             	cmp    $0x5,%eax
801044c9:	77 11                	ja     801044dc <procdump+0x5c>
801044cb:	8b 14 85 60 8a 10 80 	mov    -0x7fef75a0(,%eax,4),%edx
      state = "???";
801044d2:	b8 dd 89 10 80       	mov    $0x801089dd,%eax
801044d7:	85 d2                	test   %edx,%edx
801044d9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801044dc:	53                   	push   %ebx
801044dd:	52                   	push   %edx
801044de:	ff 73 a4             	push   -0x5c(%ebx)
801044e1:	68 e1 89 10 80       	push   $0x801089e1
801044e6:	e8 b5 c1 ff ff       	call   801006a0 <cprintf>
    if(p->state == SLEEPING){
801044eb:	83 c4 10             	add    $0x10,%esp
801044ee:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801044f2:	75 a4                	jne    80104498 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801044f4:	83 ec 08             	sub    $0x8,%esp
801044f7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801044fa:	8d 7d c0             	lea    -0x40(%ebp),%edi
801044fd:	50                   	push   %eax
801044fe:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104501:	8b 40 0c             	mov    0xc(%eax),%eax
80104504:	83 c0 08             	add    $0x8,%eax
80104507:	50                   	push   %eax
80104508:	e8 83 01 00 00       	call   80104690 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010450d:	83 c4 10             	add    $0x10,%esp
80104510:	8b 17                	mov    (%edi),%edx
80104512:	85 d2                	test   %edx,%edx
80104514:	74 82                	je     80104498 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104516:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104519:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010451c:	52                   	push   %edx
8010451d:	68 21 84 10 80       	push   $0x80108421
80104522:	e8 79 c1 ff ff       	call   801006a0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104527:	83 c4 10             	add    $0x10,%esp
8010452a:	39 fe                	cmp    %edi,%esi
8010452c:	75 e2                	jne    80104510 <procdump+0x90>
8010452e:	e9 65 ff ff ff       	jmp    80104498 <procdump+0x18>
80104533:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104537:	90                   	nop
  }
}
80104538:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010453b:	5b                   	pop    %ebx
8010453c:	5e                   	pop    %esi
8010453d:	5f                   	pop    %edi
8010453e:	5d                   	pop    %ebp
8010453f:	c3                   	ret    

80104540 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	53                   	push   %ebx
80104544:	83 ec 0c             	sub    $0xc,%esp
80104547:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010454a:	68 78 8a 10 80       	push   $0x80108a78
8010454f:	8d 43 04             	lea    0x4(%ebx),%eax
80104552:	50                   	push   %eax
80104553:	e8 18 01 00 00       	call   80104670 <initlock>
  lk->name = name;
80104558:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010455b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104561:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104564:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010456b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010456e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104571:	c9                   	leave  
80104572:	c3                   	ret    
80104573:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010457a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104580 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104580:	55                   	push   %ebp
80104581:	89 e5                	mov    %esp,%ebp
80104583:	56                   	push   %esi
80104584:	53                   	push   %ebx
80104585:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104588:	8d 73 04             	lea    0x4(%ebx),%esi
8010458b:	83 ec 0c             	sub    $0xc,%esp
8010458e:	56                   	push   %esi
8010458f:	e8 ac 02 00 00       	call   80104840 <acquire>
  while (lk->locked) {
80104594:	8b 13                	mov    (%ebx),%edx
80104596:	83 c4 10             	add    $0x10,%esp
80104599:	85 d2                	test   %edx,%edx
8010459b:	74 16                	je     801045b3 <acquiresleep+0x33>
8010459d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801045a0:	83 ec 08             	sub    $0x8,%esp
801045a3:	56                   	push   %esi
801045a4:	53                   	push   %ebx
801045a5:	e8 36 fd ff ff       	call   801042e0 <sleep>
  while (lk->locked) {
801045aa:	8b 03                	mov    (%ebx),%eax
801045ac:	83 c4 10             	add    $0x10,%esp
801045af:	85 c0                	test   %eax,%eax
801045b1:	75 ed                	jne    801045a0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801045b3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801045b9:	e8 12 f4 ff ff       	call   801039d0 <myproc>
801045be:	8b 40 10             	mov    0x10(%eax),%eax
801045c1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801045c4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801045c7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045ca:	5b                   	pop    %ebx
801045cb:	5e                   	pop    %esi
801045cc:	5d                   	pop    %ebp
  release(&lk->lk);
801045cd:	e9 0e 02 00 00       	jmp    801047e0 <release>
801045d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801045e0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	56                   	push   %esi
801045e4:	53                   	push   %ebx
801045e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801045e8:	8d 73 04             	lea    0x4(%ebx),%esi
801045eb:	83 ec 0c             	sub    $0xc,%esp
801045ee:	56                   	push   %esi
801045ef:	e8 4c 02 00 00       	call   80104840 <acquire>
  lk->locked = 0;
801045f4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801045fa:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104601:	89 1c 24             	mov    %ebx,(%esp)
80104604:	e8 97 fd ff ff       	call   801043a0 <wakeup>
  release(&lk->lk);
80104609:	89 75 08             	mov    %esi,0x8(%ebp)
8010460c:	83 c4 10             	add    $0x10,%esp
}
8010460f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104612:	5b                   	pop    %ebx
80104613:	5e                   	pop    %esi
80104614:	5d                   	pop    %ebp
  release(&lk->lk);
80104615:	e9 c6 01 00 00       	jmp    801047e0 <release>
8010461a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104620 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	57                   	push   %edi
80104624:	31 ff                	xor    %edi,%edi
80104626:	56                   	push   %esi
80104627:	53                   	push   %ebx
80104628:	83 ec 18             	sub    $0x18,%esp
8010462b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010462e:	8d 73 04             	lea    0x4(%ebx),%esi
80104631:	56                   	push   %esi
80104632:	e8 09 02 00 00       	call   80104840 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104637:	8b 03                	mov    (%ebx),%eax
80104639:	83 c4 10             	add    $0x10,%esp
8010463c:	85 c0                	test   %eax,%eax
8010463e:	75 18                	jne    80104658 <holdingsleep+0x38>
  release(&lk->lk);
80104640:	83 ec 0c             	sub    $0xc,%esp
80104643:	56                   	push   %esi
80104644:	e8 97 01 00 00       	call   801047e0 <release>
  return r;
}
80104649:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010464c:	89 f8                	mov    %edi,%eax
8010464e:	5b                   	pop    %ebx
8010464f:	5e                   	pop    %esi
80104650:	5f                   	pop    %edi
80104651:	5d                   	pop    %ebp
80104652:	c3                   	ret    
80104653:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104657:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
80104658:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010465b:	e8 70 f3 ff ff       	call   801039d0 <myproc>
80104660:	39 58 10             	cmp    %ebx,0x10(%eax)
80104663:	0f 94 c0             	sete   %al
80104666:	0f b6 c0             	movzbl %al,%eax
80104669:	89 c7                	mov    %eax,%edi
8010466b:	eb d3                	jmp    80104640 <holdingsleep+0x20>
8010466d:	66 90                	xchg   %ax,%ax
8010466f:	90                   	nop

80104670 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104676:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104679:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010467f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104682:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104689:	5d                   	pop    %ebp
8010468a:	c3                   	ret    
8010468b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010468f:	90                   	nop

80104690 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104690:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104691:	31 d2                	xor    %edx,%edx
{
80104693:	89 e5                	mov    %esp,%ebp
80104695:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104696:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104699:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010469c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
8010469f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801046a0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801046a6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801046ac:	77 1a                	ja     801046c8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801046ae:	8b 58 04             	mov    0x4(%eax),%ebx
801046b1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801046b4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801046b7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801046b9:	83 fa 0a             	cmp    $0xa,%edx
801046bc:	75 e2                	jne    801046a0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801046be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046c1:	c9                   	leave  
801046c2:	c3                   	ret    
801046c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046c7:	90                   	nop
  for(; i < 10; i++)
801046c8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801046cb:	8d 51 28             	lea    0x28(%ecx),%edx
801046ce:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801046d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801046d6:	83 c0 04             	add    $0x4,%eax
801046d9:	39 d0                	cmp    %edx,%eax
801046db:	75 f3                	jne    801046d0 <getcallerpcs+0x40>
}
801046dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046e0:	c9                   	leave  
801046e1:	c3                   	ret    
801046e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801046f0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	53                   	push   %ebx
801046f4:	83 ec 04             	sub    $0x4,%esp
801046f7:	9c                   	pushf  
801046f8:	5b                   	pop    %ebx
  asm volatile("cli");
801046f9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801046fa:	e8 51 f2 ff ff       	call   80103950 <mycpu>
801046ff:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104705:	85 c0                	test   %eax,%eax
80104707:	74 17                	je     80104720 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104709:	e8 42 f2 ff ff       	call   80103950 <mycpu>
8010470e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104715:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104718:	c9                   	leave  
80104719:	c3                   	ret    
8010471a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104720:	e8 2b f2 ff ff       	call   80103950 <mycpu>
80104725:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010472b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104731:	eb d6                	jmp    80104709 <pushcli+0x19>
80104733:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010473a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104740 <popcli>:

void
popcli(void)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104746:	9c                   	pushf  
80104747:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104748:	f6 c4 02             	test   $0x2,%ah
8010474b:	75 35                	jne    80104782 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010474d:	e8 fe f1 ff ff       	call   80103950 <mycpu>
80104752:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104759:	78 34                	js     8010478f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010475b:	e8 f0 f1 ff ff       	call   80103950 <mycpu>
80104760:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104766:	85 d2                	test   %edx,%edx
80104768:	74 06                	je     80104770 <popcli+0x30>
    sti();
}
8010476a:	c9                   	leave  
8010476b:	c3                   	ret    
8010476c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104770:	e8 db f1 ff ff       	call   80103950 <mycpu>
80104775:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010477b:	85 c0                	test   %eax,%eax
8010477d:	74 eb                	je     8010476a <popcli+0x2a>
  asm volatile("sti");
8010477f:	fb                   	sti    
}
80104780:	c9                   	leave  
80104781:	c3                   	ret    
    panic("popcli - interruptible");
80104782:	83 ec 0c             	sub    $0xc,%esp
80104785:	68 83 8a 10 80       	push   $0x80108a83
8010478a:	e8 f1 bb ff ff       	call   80100380 <panic>
    panic("popcli");
8010478f:	83 ec 0c             	sub    $0xc,%esp
80104792:	68 9a 8a 10 80       	push   $0x80108a9a
80104797:	e8 e4 bb ff ff       	call   80100380 <panic>
8010479c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047a0 <holding>:
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	56                   	push   %esi
801047a4:	53                   	push   %ebx
801047a5:	8b 75 08             	mov    0x8(%ebp),%esi
801047a8:	31 db                	xor    %ebx,%ebx
  pushcli();
801047aa:	e8 41 ff ff ff       	call   801046f0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801047af:	8b 06                	mov    (%esi),%eax
801047b1:	85 c0                	test   %eax,%eax
801047b3:	75 0b                	jne    801047c0 <holding+0x20>
  popcli();
801047b5:	e8 86 ff ff ff       	call   80104740 <popcli>
}
801047ba:	89 d8                	mov    %ebx,%eax
801047bc:	5b                   	pop    %ebx
801047bd:	5e                   	pop    %esi
801047be:	5d                   	pop    %ebp
801047bf:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
801047c0:	8b 5e 08             	mov    0x8(%esi),%ebx
801047c3:	e8 88 f1 ff ff       	call   80103950 <mycpu>
801047c8:	39 c3                	cmp    %eax,%ebx
801047ca:	0f 94 c3             	sete   %bl
  popcli();
801047cd:	e8 6e ff ff ff       	call   80104740 <popcli>
  r = lock->locked && lock->cpu == mycpu();
801047d2:	0f b6 db             	movzbl %bl,%ebx
}
801047d5:	89 d8                	mov    %ebx,%eax
801047d7:	5b                   	pop    %ebx
801047d8:	5e                   	pop    %esi
801047d9:	5d                   	pop    %ebp
801047da:	c3                   	ret    
801047db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047df:	90                   	nop

801047e0 <release>:
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	56                   	push   %esi
801047e4:	53                   	push   %ebx
801047e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801047e8:	e8 03 ff ff ff       	call   801046f0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801047ed:	8b 03                	mov    (%ebx),%eax
801047ef:	85 c0                	test   %eax,%eax
801047f1:	75 15                	jne    80104808 <release+0x28>
  popcli();
801047f3:	e8 48 ff ff ff       	call   80104740 <popcli>
    panic("release");
801047f8:	83 ec 0c             	sub    $0xc,%esp
801047fb:	68 a1 8a 10 80       	push   $0x80108aa1
80104800:	e8 7b bb ff ff       	call   80100380 <panic>
80104805:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104808:	8b 73 08             	mov    0x8(%ebx),%esi
8010480b:	e8 40 f1 ff ff       	call   80103950 <mycpu>
80104810:	39 c6                	cmp    %eax,%esi
80104812:	75 df                	jne    801047f3 <release+0x13>
  popcli();
80104814:	e8 27 ff ff ff       	call   80104740 <popcli>
  lk->pcs[0] = 0;
80104819:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104820:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104827:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010482c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104832:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104835:	5b                   	pop    %ebx
80104836:	5e                   	pop    %esi
80104837:	5d                   	pop    %ebp
  popcli();
80104838:	e9 03 ff ff ff       	jmp    80104740 <popcli>
8010483d:	8d 76 00             	lea    0x0(%esi),%esi

80104840 <acquire>:
{
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	53                   	push   %ebx
80104844:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104847:	e8 a4 fe ff ff       	call   801046f0 <pushcli>
  if(holding(lk))
8010484c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010484f:	e8 9c fe ff ff       	call   801046f0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104854:	8b 03                	mov    (%ebx),%eax
80104856:	85 c0                	test   %eax,%eax
80104858:	75 7e                	jne    801048d8 <acquire+0x98>
  popcli();
8010485a:	e8 e1 fe ff ff       	call   80104740 <popcli>
  asm volatile("lock; xchgl %0, %1" :
8010485f:	b9 01 00 00 00       	mov    $0x1,%ecx
80104864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80104868:	8b 55 08             	mov    0x8(%ebp),%edx
8010486b:	89 c8                	mov    %ecx,%eax
8010486d:	f0 87 02             	lock xchg %eax,(%edx)
80104870:	85 c0                	test   %eax,%eax
80104872:	75 f4                	jne    80104868 <acquire+0x28>
  __sync_synchronize();
80104874:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104879:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010487c:	e8 cf f0 ff ff       	call   80103950 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104881:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80104884:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80104886:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80104889:	31 c0                	xor    %eax,%eax
8010488b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010488f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104890:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104896:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010489c:	77 1a                	ja     801048b8 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
8010489e:	8b 5a 04             	mov    0x4(%edx),%ebx
801048a1:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
801048a5:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801048a8:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801048aa:	83 f8 0a             	cmp    $0xa,%eax
801048ad:	75 e1                	jne    80104890 <acquire+0x50>
}
801048af:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048b2:	c9                   	leave  
801048b3:	c3                   	ret    
801048b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
801048b8:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
801048bc:	8d 51 34             	lea    0x34(%ecx),%edx
801048bf:	90                   	nop
    pcs[i] = 0;
801048c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801048c6:	83 c0 04             	add    $0x4,%eax
801048c9:	39 c2                	cmp    %eax,%edx
801048cb:	75 f3                	jne    801048c0 <acquire+0x80>
}
801048cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048d0:	c9                   	leave  
801048d1:	c3                   	ret    
801048d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801048d8:	8b 5b 08             	mov    0x8(%ebx),%ebx
801048db:	e8 70 f0 ff ff       	call   80103950 <mycpu>
801048e0:	39 c3                	cmp    %eax,%ebx
801048e2:	0f 85 72 ff ff ff    	jne    8010485a <acquire+0x1a>
  popcli();
801048e8:	e8 53 fe ff ff       	call   80104740 <popcli>
    panic("acquire");
801048ed:	83 ec 0c             	sub    $0xc,%esp
801048f0:	68 a9 8a 10 80       	push   $0x80108aa9
801048f5:	e8 86 ba ff ff       	call   80100380 <panic>
801048fa:	66 90                	xchg   %ax,%ax
801048fc:	66 90                	xchg   %ax,%ax
801048fe:	66 90                	xchg   %ax,%ax

80104900 <memset>:
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	57                   	push   %edi
80104904:	8b 55 08             	mov    0x8(%ebp),%edx
80104907:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010490a:	53                   	push   %ebx
8010490b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010490e:	89 d7                	mov    %edx,%edi
80104910:	09 cf                	or     %ecx,%edi
80104912:	83 e7 03             	and    $0x3,%edi
80104915:	75 29                	jne    80104940 <memset+0x40>
80104917:	0f b6 f8             	movzbl %al,%edi
8010491a:	c1 e0 18             	shl    $0x18,%eax
8010491d:	89 fb                	mov    %edi,%ebx
8010491f:	c1 e9 02             	shr    $0x2,%ecx
80104922:	c1 e3 10             	shl    $0x10,%ebx
80104925:	09 d8                	or     %ebx,%eax
80104927:	09 f8                	or     %edi,%eax
80104929:	c1 e7 08             	shl    $0x8,%edi
8010492c:	09 f8                	or     %edi,%eax
8010492e:	89 d7                	mov    %edx,%edi
80104930:	fc                   	cld    
80104931:	f3 ab                	rep stos %eax,%es:(%edi)
80104933:	5b                   	pop    %ebx
80104934:	89 d0                	mov    %edx,%eax
80104936:	5f                   	pop    %edi
80104937:	5d                   	pop    %ebp
80104938:	c3                   	ret    
80104939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104940:	89 d7                	mov    %edx,%edi
80104942:	fc                   	cld    
80104943:	f3 aa                	rep stos %al,%es:(%edi)
80104945:	5b                   	pop    %ebx
80104946:	89 d0                	mov    %edx,%eax
80104948:	5f                   	pop    %edi
80104949:	5d                   	pop    %ebp
8010494a:	c3                   	ret    
8010494b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010494f:	90                   	nop

80104950 <memcmp>:
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	56                   	push   %esi
80104954:	8b 75 10             	mov    0x10(%ebp),%esi
80104957:	8b 55 08             	mov    0x8(%ebp),%edx
8010495a:	53                   	push   %ebx
8010495b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010495e:	85 f6                	test   %esi,%esi
80104960:	74 2e                	je     80104990 <memcmp+0x40>
80104962:	01 c6                	add    %eax,%esi
80104964:	eb 14                	jmp    8010497a <memcmp+0x2a>
80104966:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010496d:	8d 76 00             	lea    0x0(%esi),%esi
80104970:	83 c0 01             	add    $0x1,%eax
80104973:	83 c2 01             	add    $0x1,%edx
80104976:	39 f0                	cmp    %esi,%eax
80104978:	74 16                	je     80104990 <memcmp+0x40>
8010497a:	0f b6 0a             	movzbl (%edx),%ecx
8010497d:	0f b6 18             	movzbl (%eax),%ebx
80104980:	38 d9                	cmp    %bl,%cl
80104982:	74 ec                	je     80104970 <memcmp+0x20>
80104984:	0f b6 c1             	movzbl %cl,%eax
80104987:	29 d8                	sub    %ebx,%eax
80104989:	5b                   	pop    %ebx
8010498a:	5e                   	pop    %esi
8010498b:	5d                   	pop    %ebp
8010498c:	c3                   	ret    
8010498d:	8d 76 00             	lea    0x0(%esi),%esi
80104990:	5b                   	pop    %ebx
80104991:	31 c0                	xor    %eax,%eax
80104993:	5e                   	pop    %esi
80104994:	5d                   	pop    %ebp
80104995:	c3                   	ret    
80104996:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010499d:	8d 76 00             	lea    0x0(%esi),%esi

801049a0 <memmove>:
801049a0:	55                   	push   %ebp
801049a1:	89 e5                	mov    %esp,%ebp
801049a3:	57                   	push   %edi
801049a4:	8b 55 08             	mov    0x8(%ebp),%edx
801049a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801049aa:	56                   	push   %esi
801049ab:	8b 75 0c             	mov    0xc(%ebp),%esi
801049ae:	39 d6                	cmp    %edx,%esi
801049b0:	73 26                	jae    801049d8 <memmove+0x38>
801049b2:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
801049b5:	39 fa                	cmp    %edi,%edx
801049b7:	73 1f                	jae    801049d8 <memmove+0x38>
801049b9:	8d 41 ff             	lea    -0x1(%ecx),%eax
801049bc:	85 c9                	test   %ecx,%ecx
801049be:	74 0c                	je     801049cc <memmove+0x2c>
801049c0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801049c4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
801049c7:	83 e8 01             	sub    $0x1,%eax
801049ca:	73 f4                	jae    801049c0 <memmove+0x20>
801049cc:	5e                   	pop    %esi
801049cd:	89 d0                	mov    %edx,%eax
801049cf:	5f                   	pop    %edi
801049d0:	5d                   	pop    %ebp
801049d1:	c3                   	ret    
801049d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049d8:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
801049db:	89 d7                	mov    %edx,%edi
801049dd:	85 c9                	test   %ecx,%ecx
801049df:	74 eb                	je     801049cc <memmove+0x2c>
801049e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049e8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
801049e9:	39 c6                	cmp    %eax,%esi
801049eb:	75 fb                	jne    801049e8 <memmove+0x48>
801049ed:	5e                   	pop    %esi
801049ee:	89 d0                	mov    %edx,%eax
801049f0:	5f                   	pop    %edi
801049f1:	5d                   	pop    %ebp
801049f2:	c3                   	ret    
801049f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a00 <memcpy>:
80104a00:	eb 9e                	jmp    801049a0 <memmove>
80104a02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104a10 <strncmp>:
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	56                   	push   %esi
80104a14:	8b 75 10             	mov    0x10(%ebp),%esi
80104a17:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104a1a:	53                   	push   %ebx
80104a1b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a1e:	85 f6                	test   %esi,%esi
80104a20:	74 2e                	je     80104a50 <strncmp+0x40>
80104a22:	01 d6                	add    %edx,%esi
80104a24:	eb 18                	jmp    80104a3e <strncmp+0x2e>
80104a26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a2d:	8d 76 00             	lea    0x0(%esi),%esi
80104a30:	38 d8                	cmp    %bl,%al
80104a32:	75 14                	jne    80104a48 <strncmp+0x38>
80104a34:	83 c2 01             	add    $0x1,%edx
80104a37:	83 c1 01             	add    $0x1,%ecx
80104a3a:	39 f2                	cmp    %esi,%edx
80104a3c:	74 12                	je     80104a50 <strncmp+0x40>
80104a3e:	0f b6 01             	movzbl (%ecx),%eax
80104a41:	0f b6 1a             	movzbl (%edx),%ebx
80104a44:	84 c0                	test   %al,%al
80104a46:	75 e8                	jne    80104a30 <strncmp+0x20>
80104a48:	29 d8                	sub    %ebx,%eax
80104a4a:	5b                   	pop    %ebx
80104a4b:	5e                   	pop    %esi
80104a4c:	5d                   	pop    %ebp
80104a4d:	c3                   	ret    
80104a4e:	66 90                	xchg   %ax,%ax
80104a50:	5b                   	pop    %ebx
80104a51:	31 c0                	xor    %eax,%eax
80104a53:	5e                   	pop    %esi
80104a54:	5d                   	pop    %ebp
80104a55:	c3                   	ret    
80104a56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a5d:	8d 76 00             	lea    0x0(%esi),%esi

80104a60 <strncpy>:
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	57                   	push   %edi
80104a64:	56                   	push   %esi
80104a65:	8b 75 08             	mov    0x8(%ebp),%esi
80104a68:	53                   	push   %ebx
80104a69:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104a6c:	89 f0                	mov    %esi,%eax
80104a6e:	eb 15                	jmp    80104a85 <strncpy+0x25>
80104a70:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104a74:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104a77:	83 c0 01             	add    $0x1,%eax
80104a7a:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
80104a7e:	88 50 ff             	mov    %dl,-0x1(%eax)
80104a81:	84 d2                	test   %dl,%dl
80104a83:	74 09                	je     80104a8e <strncpy+0x2e>
80104a85:	89 cb                	mov    %ecx,%ebx
80104a87:	83 e9 01             	sub    $0x1,%ecx
80104a8a:	85 db                	test   %ebx,%ebx
80104a8c:	7f e2                	jg     80104a70 <strncpy+0x10>
80104a8e:	89 c2                	mov    %eax,%edx
80104a90:	85 c9                	test   %ecx,%ecx
80104a92:	7e 17                	jle    80104aab <strncpy+0x4b>
80104a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a98:	83 c2 01             	add    $0x1,%edx
80104a9b:	89 c1                	mov    %eax,%ecx
80104a9d:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
80104aa1:	29 d1                	sub    %edx,%ecx
80104aa3:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80104aa7:	85 c9                	test   %ecx,%ecx
80104aa9:	7f ed                	jg     80104a98 <strncpy+0x38>
80104aab:	5b                   	pop    %ebx
80104aac:	89 f0                	mov    %esi,%eax
80104aae:	5e                   	pop    %esi
80104aaf:	5f                   	pop    %edi
80104ab0:	5d                   	pop    %ebp
80104ab1:	c3                   	ret    
80104ab2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104ac0 <safestrcpy>:
80104ac0:	55                   	push   %ebp
80104ac1:	89 e5                	mov    %esp,%ebp
80104ac3:	56                   	push   %esi
80104ac4:	8b 55 10             	mov    0x10(%ebp),%edx
80104ac7:	8b 75 08             	mov    0x8(%ebp),%esi
80104aca:	53                   	push   %ebx
80104acb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ace:	85 d2                	test   %edx,%edx
80104ad0:	7e 25                	jle    80104af7 <safestrcpy+0x37>
80104ad2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104ad6:	89 f2                	mov    %esi,%edx
80104ad8:	eb 16                	jmp    80104af0 <safestrcpy+0x30>
80104ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ae0:	0f b6 08             	movzbl (%eax),%ecx
80104ae3:	83 c0 01             	add    $0x1,%eax
80104ae6:	83 c2 01             	add    $0x1,%edx
80104ae9:	88 4a ff             	mov    %cl,-0x1(%edx)
80104aec:	84 c9                	test   %cl,%cl
80104aee:	74 04                	je     80104af4 <safestrcpy+0x34>
80104af0:	39 d8                	cmp    %ebx,%eax
80104af2:	75 ec                	jne    80104ae0 <safestrcpy+0x20>
80104af4:	c6 02 00             	movb   $0x0,(%edx)
80104af7:	89 f0                	mov    %esi,%eax
80104af9:	5b                   	pop    %ebx
80104afa:	5e                   	pop    %esi
80104afb:	5d                   	pop    %ebp
80104afc:	c3                   	ret    
80104afd:	8d 76 00             	lea    0x0(%esi),%esi

80104b00 <strlen>:
80104b00:	55                   	push   %ebp
80104b01:	31 c0                	xor    %eax,%eax
80104b03:	89 e5                	mov    %esp,%ebp
80104b05:	8b 55 08             	mov    0x8(%ebp),%edx
80104b08:	80 3a 00             	cmpb   $0x0,(%edx)
80104b0b:	74 0c                	je     80104b19 <strlen+0x19>
80104b0d:	8d 76 00             	lea    0x0(%esi),%esi
80104b10:	83 c0 01             	add    $0x1,%eax
80104b13:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104b17:	75 f7                	jne    80104b10 <strlen+0x10>
80104b19:	5d                   	pop    %ebp
80104b1a:	c3                   	ret    

80104b1b <swtch>:
80104b1b:	8b 44 24 04          	mov    0x4(%esp),%eax
80104b1f:	8b 54 24 08          	mov    0x8(%esp),%edx
80104b23:	55                   	push   %ebp
80104b24:	53                   	push   %ebx
80104b25:	56                   	push   %esi
80104b26:	57                   	push   %edi
80104b27:	89 20                	mov    %esp,(%eax)
80104b29:	89 d4                	mov    %edx,%esp
80104b2b:	5f                   	pop    %edi
80104b2c:	5e                   	pop    %esi
80104b2d:	5b                   	pop    %ebx
80104b2e:	5d                   	pop    %ebp
80104b2f:	c3                   	ret    

80104b30 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	53                   	push   %ebx
80104b34:	83 ec 04             	sub    $0x4,%esp
80104b37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104b3a:	e8 91 ee ff ff       	call   801039d0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b3f:	8b 00                	mov    (%eax),%eax
80104b41:	39 d8                	cmp    %ebx,%eax
80104b43:	76 1b                	jbe    80104b60 <fetchint+0x30>
80104b45:	8d 53 04             	lea    0x4(%ebx),%edx
80104b48:	39 d0                	cmp    %edx,%eax
80104b4a:	72 14                	jb     80104b60 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104b4c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b4f:	8b 13                	mov    (%ebx),%edx
80104b51:	89 10                	mov    %edx,(%eax)
  return 0;
80104b53:	31 c0                	xor    %eax,%eax
}
80104b55:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b58:	c9                   	leave  
80104b59:	c3                   	ret    
80104b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104b60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b65:	eb ee                	jmp    80104b55 <fetchint+0x25>
80104b67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b6e:	66 90                	xchg   %ax,%ax

80104b70 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104b70:	55                   	push   %ebp
80104b71:	89 e5                	mov    %esp,%ebp
80104b73:	53                   	push   %ebx
80104b74:	83 ec 04             	sub    $0x4,%esp
80104b77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104b7a:	e8 51 ee ff ff       	call   801039d0 <myproc>

  if(addr >= curproc->sz)
80104b7f:	39 18                	cmp    %ebx,(%eax)
80104b81:	76 2d                	jbe    80104bb0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104b83:	8b 55 0c             	mov    0xc(%ebp),%edx
80104b86:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104b88:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104b8a:	39 d3                	cmp    %edx,%ebx
80104b8c:	73 22                	jae    80104bb0 <fetchstr+0x40>
80104b8e:	89 d8                	mov    %ebx,%eax
80104b90:	eb 0d                	jmp    80104b9f <fetchstr+0x2f>
80104b92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b98:	83 c0 01             	add    $0x1,%eax
80104b9b:	39 c2                	cmp    %eax,%edx
80104b9d:	76 11                	jbe    80104bb0 <fetchstr+0x40>
    if(*s == 0)
80104b9f:	80 38 00             	cmpb   $0x0,(%eax)
80104ba2:	75 f4                	jne    80104b98 <fetchstr+0x28>
      return s - *pp;
80104ba4:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104ba6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ba9:	c9                   	leave  
80104baa:	c3                   	ret    
80104bab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104baf:	90                   	nop
80104bb0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104bb3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104bb8:	c9                   	leave  
80104bb9:	c3                   	ret    
80104bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104bc0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104bc0:	55                   	push   %ebp
80104bc1:	89 e5                	mov    %esp,%ebp
80104bc3:	56                   	push   %esi
80104bc4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104bc5:	e8 06 ee ff ff       	call   801039d0 <myproc>
80104bca:	8b 55 08             	mov    0x8(%ebp),%edx
80104bcd:	8b 40 18             	mov    0x18(%eax),%eax
80104bd0:	8b 40 44             	mov    0x44(%eax),%eax
80104bd3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104bd6:	e8 f5 ed ff ff       	call   801039d0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104bdb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104bde:	8b 00                	mov    (%eax),%eax
80104be0:	39 c6                	cmp    %eax,%esi
80104be2:	73 1c                	jae    80104c00 <argint+0x40>
80104be4:	8d 53 08             	lea    0x8(%ebx),%edx
80104be7:	39 d0                	cmp    %edx,%eax
80104be9:	72 15                	jb     80104c00 <argint+0x40>
  *ip = *(int*)(addr);
80104beb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bee:	8b 53 04             	mov    0x4(%ebx),%edx
80104bf1:	89 10                	mov    %edx,(%eax)
  return 0;
80104bf3:	31 c0                	xor    %eax,%eax
}
80104bf5:	5b                   	pop    %ebx
80104bf6:	5e                   	pop    %esi
80104bf7:	5d                   	pop    %ebp
80104bf8:	c3                   	ret    
80104bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104c00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c05:	eb ee                	jmp    80104bf5 <argint+0x35>
80104c07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c0e:	66 90                	xchg   %ax,%ax

80104c10 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104c10:	55                   	push   %ebp
80104c11:	89 e5                	mov    %esp,%ebp
80104c13:	57                   	push   %edi
80104c14:	56                   	push   %esi
80104c15:	53                   	push   %ebx
80104c16:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104c19:	e8 b2 ed ff ff       	call   801039d0 <myproc>
80104c1e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c20:	e8 ab ed ff ff       	call   801039d0 <myproc>
80104c25:	8b 55 08             	mov    0x8(%ebp),%edx
80104c28:	8b 40 18             	mov    0x18(%eax),%eax
80104c2b:	8b 40 44             	mov    0x44(%eax),%eax
80104c2e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104c31:	e8 9a ed ff ff       	call   801039d0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c36:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c39:	8b 00                	mov    (%eax),%eax
80104c3b:	39 c7                	cmp    %eax,%edi
80104c3d:	73 31                	jae    80104c70 <argptr+0x60>
80104c3f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104c42:	39 c8                	cmp    %ecx,%eax
80104c44:	72 2a                	jb     80104c70 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104c46:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104c49:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104c4c:	85 d2                	test   %edx,%edx
80104c4e:	78 20                	js     80104c70 <argptr+0x60>
80104c50:	8b 16                	mov    (%esi),%edx
80104c52:	39 c2                	cmp    %eax,%edx
80104c54:	76 1a                	jbe    80104c70 <argptr+0x60>
80104c56:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104c59:	01 c3                	add    %eax,%ebx
80104c5b:	39 da                	cmp    %ebx,%edx
80104c5d:	72 11                	jb     80104c70 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104c5f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104c62:	89 02                	mov    %eax,(%edx)
  return 0;
80104c64:	31 c0                	xor    %eax,%eax
}
80104c66:	83 c4 0c             	add    $0xc,%esp
80104c69:	5b                   	pop    %ebx
80104c6a:	5e                   	pop    %esi
80104c6b:	5f                   	pop    %edi
80104c6c:	5d                   	pop    %ebp
80104c6d:	c3                   	ret    
80104c6e:	66 90                	xchg   %ax,%ax
    return -1;
80104c70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c75:	eb ef                	jmp    80104c66 <argptr+0x56>
80104c77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c7e:	66 90                	xchg   %ax,%ax

80104c80 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104c80:	55                   	push   %ebp
80104c81:	89 e5                	mov    %esp,%ebp
80104c83:	56                   	push   %esi
80104c84:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c85:	e8 46 ed ff ff       	call   801039d0 <myproc>
80104c8a:	8b 55 08             	mov    0x8(%ebp),%edx
80104c8d:	8b 40 18             	mov    0x18(%eax),%eax
80104c90:	8b 40 44             	mov    0x44(%eax),%eax
80104c93:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104c96:	e8 35 ed ff ff       	call   801039d0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c9b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c9e:	8b 00                	mov    (%eax),%eax
80104ca0:	39 c6                	cmp    %eax,%esi
80104ca2:	73 44                	jae    80104ce8 <argstr+0x68>
80104ca4:	8d 53 08             	lea    0x8(%ebx),%edx
80104ca7:	39 d0                	cmp    %edx,%eax
80104ca9:	72 3d                	jb     80104ce8 <argstr+0x68>
  *ip = *(int*)(addr);
80104cab:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104cae:	e8 1d ed ff ff       	call   801039d0 <myproc>
  if(addr >= curproc->sz)
80104cb3:	3b 18                	cmp    (%eax),%ebx
80104cb5:	73 31                	jae    80104ce8 <argstr+0x68>
  *pp = (char*)addr;
80104cb7:	8b 55 0c             	mov    0xc(%ebp),%edx
80104cba:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104cbc:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104cbe:	39 d3                	cmp    %edx,%ebx
80104cc0:	73 26                	jae    80104ce8 <argstr+0x68>
80104cc2:	89 d8                	mov    %ebx,%eax
80104cc4:	eb 11                	jmp    80104cd7 <argstr+0x57>
80104cc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ccd:	8d 76 00             	lea    0x0(%esi),%esi
80104cd0:	83 c0 01             	add    $0x1,%eax
80104cd3:	39 c2                	cmp    %eax,%edx
80104cd5:	76 11                	jbe    80104ce8 <argstr+0x68>
    if(*s == 0)
80104cd7:	80 38 00             	cmpb   $0x0,(%eax)
80104cda:	75 f4                	jne    80104cd0 <argstr+0x50>
      return s - *pp;
80104cdc:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104cde:	5b                   	pop    %ebx
80104cdf:	5e                   	pop    %esi
80104ce0:	5d                   	pop    %ebp
80104ce1:	c3                   	ret    
80104ce2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ce8:	5b                   	pop    %ebx
    return -1;
80104ce9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cee:	5e                   	pop    %esi
80104cef:	5d                   	pop    %ebp
80104cf0:	c3                   	ret    
80104cf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cff:	90                   	nop

80104d00 <syscall>:
[SYS_getwmapinfo]  sys_getwmapinfo
};

void
syscall(void)
{
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	53                   	push   %ebx
80104d04:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104d07:	e8 c4 ec ff ff       	call   801039d0 <myproc>
80104d0c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104d0e:	8b 40 18             	mov    0x18(%eax),%eax
80104d11:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104d14:	8d 50 ff             	lea    -0x1(%eax),%edx
80104d17:	83 fa 19             	cmp    $0x19,%edx
80104d1a:	77 24                	ja     80104d40 <syscall+0x40>
80104d1c:	8b 14 85 e0 8a 10 80 	mov    -0x7fef7520(,%eax,4),%edx
80104d23:	85 d2                	test   %edx,%edx
80104d25:	74 19                	je     80104d40 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104d27:	ff d2                	call   *%edx
80104d29:	89 c2                	mov    %eax,%edx
80104d2b:	8b 43 18             	mov    0x18(%ebx),%eax
80104d2e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104d31:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d34:	c9                   	leave  
80104d35:	c3                   	ret    
80104d36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d3d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104d40:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104d41:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104d44:	50                   	push   %eax
80104d45:	ff 73 10             	push   0x10(%ebx)
80104d48:	68 b1 8a 10 80       	push   $0x80108ab1
80104d4d:	e8 4e b9 ff ff       	call   801006a0 <cprintf>
    curproc->tf->eax = -1;
80104d52:	8b 43 18             	mov    0x18(%ebx),%eax
80104d55:	83 c4 10             	add    $0x10,%esp
80104d58:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104d5f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d62:	c9                   	leave  
80104d63:	c3                   	ret    
80104d64:	66 90                	xchg   %ax,%ax
80104d66:	66 90                	xchg   %ax,%ax
80104d68:	66 90                	xchg   %ax,%ax
80104d6a:	66 90                	xchg   %ax,%ax
80104d6c:	66 90                	xchg   %ax,%ax
80104d6e:	66 90                	xchg   %ax,%ax

80104d70 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	57                   	push   %edi
80104d74:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104d75:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104d78:	53                   	push   %ebx
80104d79:	83 ec 34             	sub    $0x34,%esp
80104d7c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104d7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104d82:	57                   	push   %edi
80104d83:	50                   	push   %eax
{
80104d84:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104d87:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104d8a:	e8 31 d3 ff ff       	call   801020c0 <nameiparent>
80104d8f:	83 c4 10             	add    $0x10,%esp
80104d92:	85 c0                	test   %eax,%eax
80104d94:	0f 84 46 01 00 00    	je     80104ee0 <create+0x170>
    return 0;
  ilock(dp);
80104d9a:	83 ec 0c             	sub    $0xc,%esp
80104d9d:	89 c3                	mov    %eax,%ebx
80104d9f:	50                   	push   %eax
80104da0:	e8 db c9 ff ff       	call   80101780 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104da5:	83 c4 0c             	add    $0xc,%esp
80104da8:	6a 00                	push   $0x0
80104daa:	57                   	push   %edi
80104dab:	53                   	push   %ebx
80104dac:	e8 2f cf ff ff       	call   80101ce0 <dirlookup>
80104db1:	83 c4 10             	add    $0x10,%esp
80104db4:	89 c6                	mov    %eax,%esi
80104db6:	85 c0                	test   %eax,%eax
80104db8:	74 56                	je     80104e10 <create+0xa0>
    iunlockput(dp);
80104dba:	83 ec 0c             	sub    $0xc,%esp
80104dbd:	53                   	push   %ebx
80104dbe:	e8 4d cc ff ff       	call   80101a10 <iunlockput>
    ilock(ip);
80104dc3:	89 34 24             	mov    %esi,(%esp)
80104dc6:	e8 b5 c9 ff ff       	call   80101780 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104dcb:	83 c4 10             	add    $0x10,%esp
80104dce:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104dd3:	75 1b                	jne    80104df0 <create+0x80>
80104dd5:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104dda:	75 14                	jne    80104df0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104ddc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ddf:	89 f0                	mov    %esi,%eax
80104de1:	5b                   	pop    %ebx
80104de2:	5e                   	pop    %esi
80104de3:	5f                   	pop    %edi
80104de4:	5d                   	pop    %ebp
80104de5:	c3                   	ret    
80104de6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ded:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80104df0:	83 ec 0c             	sub    $0xc,%esp
80104df3:	56                   	push   %esi
    return 0;
80104df4:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80104df6:	e8 15 cc ff ff       	call   80101a10 <iunlockput>
    return 0;
80104dfb:	83 c4 10             	add    $0x10,%esp
}
80104dfe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e01:	89 f0                	mov    %esi,%eax
80104e03:	5b                   	pop    %ebx
80104e04:	5e                   	pop    %esi
80104e05:	5f                   	pop    %edi
80104e06:	5d                   	pop    %ebp
80104e07:	c3                   	ret    
80104e08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e0f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80104e10:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104e14:	83 ec 08             	sub    $0x8,%esp
80104e17:	50                   	push   %eax
80104e18:	ff 33                	push   (%ebx)
80104e1a:	e8 f1 c7 ff ff       	call   80101610 <ialloc>
80104e1f:	83 c4 10             	add    $0x10,%esp
80104e22:	89 c6                	mov    %eax,%esi
80104e24:	85 c0                	test   %eax,%eax
80104e26:	0f 84 cd 00 00 00    	je     80104ef9 <create+0x189>
  ilock(ip);
80104e2c:	83 ec 0c             	sub    $0xc,%esp
80104e2f:	50                   	push   %eax
80104e30:	e8 4b c9 ff ff       	call   80101780 <ilock>
  ip->major = major;
80104e35:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104e39:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104e3d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104e41:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104e45:	b8 01 00 00 00       	mov    $0x1,%eax
80104e4a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104e4e:	89 34 24             	mov    %esi,(%esp)
80104e51:	e8 7a c8 ff ff       	call   801016d0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104e56:	83 c4 10             	add    $0x10,%esp
80104e59:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104e5e:	74 30                	je     80104e90 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104e60:	83 ec 04             	sub    $0x4,%esp
80104e63:	ff 76 04             	push   0x4(%esi)
80104e66:	57                   	push   %edi
80104e67:	53                   	push   %ebx
80104e68:	e8 73 d1 ff ff       	call   80101fe0 <dirlink>
80104e6d:	83 c4 10             	add    $0x10,%esp
80104e70:	85 c0                	test   %eax,%eax
80104e72:	78 78                	js     80104eec <create+0x17c>
  iunlockput(dp);
80104e74:	83 ec 0c             	sub    $0xc,%esp
80104e77:	53                   	push   %ebx
80104e78:	e8 93 cb ff ff       	call   80101a10 <iunlockput>
  return ip;
80104e7d:	83 c4 10             	add    $0x10,%esp
}
80104e80:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e83:	89 f0                	mov    %esi,%eax
80104e85:	5b                   	pop    %ebx
80104e86:	5e                   	pop    %esi
80104e87:	5f                   	pop    %edi
80104e88:	5d                   	pop    %ebp
80104e89:	c3                   	ret    
80104e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104e90:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104e93:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104e98:	53                   	push   %ebx
80104e99:	e8 32 c8 ff ff       	call   801016d0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104e9e:	83 c4 0c             	add    $0xc,%esp
80104ea1:	ff 76 04             	push   0x4(%esi)
80104ea4:	68 68 8b 10 80       	push   $0x80108b68
80104ea9:	56                   	push   %esi
80104eaa:	e8 31 d1 ff ff       	call   80101fe0 <dirlink>
80104eaf:	83 c4 10             	add    $0x10,%esp
80104eb2:	85 c0                	test   %eax,%eax
80104eb4:	78 18                	js     80104ece <create+0x15e>
80104eb6:	83 ec 04             	sub    $0x4,%esp
80104eb9:	ff 73 04             	push   0x4(%ebx)
80104ebc:	68 67 8b 10 80       	push   $0x80108b67
80104ec1:	56                   	push   %esi
80104ec2:	e8 19 d1 ff ff       	call   80101fe0 <dirlink>
80104ec7:	83 c4 10             	add    $0x10,%esp
80104eca:	85 c0                	test   %eax,%eax
80104ecc:	79 92                	jns    80104e60 <create+0xf0>
      panic("create dots");
80104ece:	83 ec 0c             	sub    $0xc,%esp
80104ed1:	68 5b 8b 10 80       	push   $0x80108b5b
80104ed6:	e8 a5 b4 ff ff       	call   80100380 <panic>
80104edb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104edf:	90                   	nop
}
80104ee0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104ee3:	31 f6                	xor    %esi,%esi
}
80104ee5:	5b                   	pop    %ebx
80104ee6:	89 f0                	mov    %esi,%eax
80104ee8:	5e                   	pop    %esi
80104ee9:	5f                   	pop    %edi
80104eea:	5d                   	pop    %ebp
80104eeb:	c3                   	ret    
    panic("create: dirlink");
80104eec:	83 ec 0c             	sub    $0xc,%esp
80104eef:	68 6a 8b 10 80       	push   $0x80108b6a
80104ef4:	e8 87 b4 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104ef9:	83 ec 0c             	sub    $0xc,%esp
80104efc:	68 4c 8b 10 80       	push   $0x80108b4c
80104f01:	e8 7a b4 ff ff       	call   80100380 <panic>
80104f06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f0d:	8d 76 00             	lea    0x0(%esi),%esi

80104f10 <sys_dup>:
{
80104f10:	55                   	push   %ebp
80104f11:	89 e5                	mov    %esp,%ebp
80104f13:	56                   	push   %esi
80104f14:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f15:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104f18:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f1b:	50                   	push   %eax
80104f1c:	6a 00                	push   $0x0
80104f1e:	e8 9d fc ff ff       	call   80104bc0 <argint>
80104f23:	83 c4 10             	add    $0x10,%esp
80104f26:	85 c0                	test   %eax,%eax
80104f28:	78 36                	js     80104f60 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f2a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f2e:	77 30                	ja     80104f60 <sys_dup+0x50>
80104f30:	e8 9b ea ff ff       	call   801039d0 <myproc>
80104f35:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f38:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104f3c:	85 f6                	test   %esi,%esi
80104f3e:	74 20                	je     80104f60 <sys_dup+0x50>
  struct proc *curproc = myproc();
80104f40:	e8 8b ea ff ff       	call   801039d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104f45:	31 db                	xor    %ebx,%ebx
80104f47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f4e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80104f50:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104f54:	85 d2                	test   %edx,%edx
80104f56:	74 18                	je     80104f70 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80104f58:	83 c3 01             	add    $0x1,%ebx
80104f5b:	83 fb 10             	cmp    $0x10,%ebx
80104f5e:	75 f0                	jne    80104f50 <sys_dup+0x40>
}
80104f60:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104f63:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104f68:	89 d8                	mov    %ebx,%eax
80104f6a:	5b                   	pop    %ebx
80104f6b:	5e                   	pop    %esi
80104f6c:	5d                   	pop    %ebp
80104f6d:	c3                   	ret    
80104f6e:	66 90                	xchg   %ax,%ax
  filedup(f);
80104f70:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80104f73:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104f77:	56                   	push   %esi
80104f78:	e8 23 bf ff ff       	call   80100ea0 <filedup>
  return fd;
80104f7d:	83 c4 10             	add    $0x10,%esp
}
80104f80:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f83:	89 d8                	mov    %ebx,%eax
80104f85:	5b                   	pop    %ebx
80104f86:	5e                   	pop    %esi
80104f87:	5d                   	pop    %ebp
80104f88:	c3                   	ret    
80104f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104f90 <sys_read>:
{
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	56                   	push   %esi
80104f94:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f95:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104f98:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f9b:	53                   	push   %ebx
80104f9c:	6a 00                	push   $0x0
80104f9e:	e8 1d fc ff ff       	call   80104bc0 <argint>
80104fa3:	83 c4 10             	add    $0x10,%esp
80104fa6:	85 c0                	test   %eax,%eax
80104fa8:	78 5e                	js     80105008 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104faa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104fae:	77 58                	ja     80105008 <sys_read+0x78>
80104fb0:	e8 1b ea ff ff       	call   801039d0 <myproc>
80104fb5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104fb8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104fbc:	85 f6                	test   %esi,%esi
80104fbe:	74 48                	je     80105008 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104fc0:	83 ec 08             	sub    $0x8,%esp
80104fc3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104fc6:	50                   	push   %eax
80104fc7:	6a 02                	push   $0x2
80104fc9:	e8 f2 fb ff ff       	call   80104bc0 <argint>
80104fce:	83 c4 10             	add    $0x10,%esp
80104fd1:	85 c0                	test   %eax,%eax
80104fd3:	78 33                	js     80105008 <sys_read+0x78>
80104fd5:	83 ec 04             	sub    $0x4,%esp
80104fd8:	ff 75 f0             	push   -0x10(%ebp)
80104fdb:	53                   	push   %ebx
80104fdc:	6a 01                	push   $0x1
80104fde:	e8 2d fc ff ff       	call   80104c10 <argptr>
80104fe3:	83 c4 10             	add    $0x10,%esp
80104fe6:	85 c0                	test   %eax,%eax
80104fe8:	78 1e                	js     80105008 <sys_read+0x78>
  return fileread(f, p, n);
80104fea:	83 ec 04             	sub    $0x4,%esp
80104fed:	ff 75 f0             	push   -0x10(%ebp)
80104ff0:	ff 75 f4             	push   -0xc(%ebp)
80104ff3:	56                   	push   %esi
80104ff4:	e8 27 c0 ff ff       	call   80101020 <fileread>
80104ff9:	83 c4 10             	add    $0x10,%esp
}
80104ffc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104fff:	5b                   	pop    %ebx
80105000:	5e                   	pop    %esi
80105001:	5d                   	pop    %ebp
80105002:	c3                   	ret    
80105003:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105007:	90                   	nop
    return -1;
80105008:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010500d:	eb ed                	jmp    80104ffc <sys_read+0x6c>
8010500f:	90                   	nop

80105010 <sys_write>:
{
80105010:	55                   	push   %ebp
80105011:	89 e5                	mov    %esp,%ebp
80105013:	56                   	push   %esi
80105014:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105015:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105018:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010501b:	53                   	push   %ebx
8010501c:	6a 00                	push   $0x0
8010501e:	e8 9d fb ff ff       	call   80104bc0 <argint>
80105023:	83 c4 10             	add    $0x10,%esp
80105026:	85 c0                	test   %eax,%eax
80105028:	78 5e                	js     80105088 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010502a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010502e:	77 58                	ja     80105088 <sys_write+0x78>
80105030:	e8 9b e9 ff ff       	call   801039d0 <myproc>
80105035:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105038:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010503c:	85 f6                	test   %esi,%esi
8010503e:	74 48                	je     80105088 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105040:	83 ec 08             	sub    $0x8,%esp
80105043:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105046:	50                   	push   %eax
80105047:	6a 02                	push   $0x2
80105049:	e8 72 fb ff ff       	call   80104bc0 <argint>
8010504e:	83 c4 10             	add    $0x10,%esp
80105051:	85 c0                	test   %eax,%eax
80105053:	78 33                	js     80105088 <sys_write+0x78>
80105055:	83 ec 04             	sub    $0x4,%esp
80105058:	ff 75 f0             	push   -0x10(%ebp)
8010505b:	53                   	push   %ebx
8010505c:	6a 01                	push   $0x1
8010505e:	e8 ad fb ff ff       	call   80104c10 <argptr>
80105063:	83 c4 10             	add    $0x10,%esp
80105066:	85 c0                	test   %eax,%eax
80105068:	78 1e                	js     80105088 <sys_write+0x78>
  return filewrite(f, p, n);
8010506a:	83 ec 04             	sub    $0x4,%esp
8010506d:	ff 75 f0             	push   -0x10(%ebp)
80105070:	ff 75 f4             	push   -0xc(%ebp)
80105073:	56                   	push   %esi
80105074:	e8 37 c0 ff ff       	call   801010b0 <filewrite>
80105079:	83 c4 10             	add    $0x10,%esp
}
8010507c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010507f:	5b                   	pop    %ebx
80105080:	5e                   	pop    %esi
80105081:	5d                   	pop    %ebp
80105082:	c3                   	ret    
80105083:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105087:	90                   	nop
    return -1;
80105088:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010508d:	eb ed                	jmp    8010507c <sys_write+0x6c>
8010508f:	90                   	nop

80105090 <sys_close>:
{
80105090:	55                   	push   %ebp
80105091:	89 e5                	mov    %esp,%ebp
80105093:	56                   	push   %esi
80105094:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105095:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105098:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010509b:	50                   	push   %eax
8010509c:	6a 00                	push   $0x0
8010509e:	e8 1d fb ff ff       	call   80104bc0 <argint>
801050a3:	83 c4 10             	add    $0x10,%esp
801050a6:	85 c0                	test   %eax,%eax
801050a8:	78 3e                	js     801050e8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801050aa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801050ae:	77 38                	ja     801050e8 <sys_close+0x58>
801050b0:	e8 1b e9 ff ff       	call   801039d0 <myproc>
801050b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801050b8:	8d 5a 08             	lea    0x8(%edx),%ebx
801050bb:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
801050bf:	85 f6                	test   %esi,%esi
801050c1:	74 25                	je     801050e8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
801050c3:	e8 08 e9 ff ff       	call   801039d0 <myproc>
  fileclose(f);
801050c8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801050cb:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
801050d2:	00 
  fileclose(f);
801050d3:	56                   	push   %esi
801050d4:	e8 17 be ff ff       	call   80100ef0 <fileclose>
  return 0;
801050d9:	83 c4 10             	add    $0x10,%esp
801050dc:	31 c0                	xor    %eax,%eax
}
801050de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050e1:	5b                   	pop    %ebx
801050e2:	5e                   	pop    %esi
801050e3:	5d                   	pop    %ebp
801050e4:	c3                   	ret    
801050e5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801050e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050ed:	eb ef                	jmp    801050de <sys_close+0x4e>
801050ef:	90                   	nop

801050f0 <sys_fstat>:
{
801050f0:	55                   	push   %ebp
801050f1:	89 e5                	mov    %esp,%ebp
801050f3:	56                   	push   %esi
801050f4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801050f5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801050f8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801050fb:	53                   	push   %ebx
801050fc:	6a 00                	push   $0x0
801050fe:	e8 bd fa ff ff       	call   80104bc0 <argint>
80105103:	83 c4 10             	add    $0x10,%esp
80105106:	85 c0                	test   %eax,%eax
80105108:	78 46                	js     80105150 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010510a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010510e:	77 40                	ja     80105150 <sys_fstat+0x60>
80105110:	e8 bb e8 ff ff       	call   801039d0 <myproc>
80105115:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105118:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010511c:	85 f6                	test   %esi,%esi
8010511e:	74 30                	je     80105150 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105120:	83 ec 04             	sub    $0x4,%esp
80105123:	6a 14                	push   $0x14
80105125:	53                   	push   %ebx
80105126:	6a 01                	push   $0x1
80105128:	e8 e3 fa ff ff       	call   80104c10 <argptr>
8010512d:	83 c4 10             	add    $0x10,%esp
80105130:	85 c0                	test   %eax,%eax
80105132:	78 1c                	js     80105150 <sys_fstat+0x60>
  return filestat(f, st);
80105134:	83 ec 08             	sub    $0x8,%esp
80105137:	ff 75 f4             	push   -0xc(%ebp)
8010513a:	56                   	push   %esi
8010513b:	e8 90 be ff ff       	call   80100fd0 <filestat>
80105140:	83 c4 10             	add    $0x10,%esp
}
80105143:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105146:	5b                   	pop    %ebx
80105147:	5e                   	pop    %esi
80105148:	5d                   	pop    %ebp
80105149:	c3                   	ret    
8010514a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105150:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105155:	eb ec                	jmp    80105143 <sys_fstat+0x53>
80105157:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010515e:	66 90                	xchg   %ax,%ax

80105160 <sys_link>:
{
80105160:	55                   	push   %ebp
80105161:	89 e5                	mov    %esp,%ebp
80105163:	57                   	push   %edi
80105164:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105165:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105168:	53                   	push   %ebx
80105169:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010516c:	50                   	push   %eax
8010516d:	6a 00                	push   $0x0
8010516f:	e8 0c fb ff ff       	call   80104c80 <argstr>
80105174:	83 c4 10             	add    $0x10,%esp
80105177:	85 c0                	test   %eax,%eax
80105179:	0f 88 fb 00 00 00    	js     8010527a <sys_link+0x11a>
8010517f:	83 ec 08             	sub    $0x8,%esp
80105182:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105185:	50                   	push   %eax
80105186:	6a 01                	push   $0x1
80105188:	e8 f3 fa ff ff       	call   80104c80 <argstr>
8010518d:	83 c4 10             	add    $0x10,%esp
80105190:	85 c0                	test   %eax,%eax
80105192:	0f 88 e2 00 00 00    	js     8010527a <sys_link+0x11a>
  begin_op();
80105198:	e8 c3 db ff ff       	call   80102d60 <begin_op>
  if((ip = namei(old)) == 0){
8010519d:	83 ec 0c             	sub    $0xc,%esp
801051a0:	ff 75 d4             	push   -0x2c(%ebp)
801051a3:	e8 f8 ce ff ff       	call   801020a0 <namei>
801051a8:	83 c4 10             	add    $0x10,%esp
801051ab:	89 c3                	mov    %eax,%ebx
801051ad:	85 c0                	test   %eax,%eax
801051af:	0f 84 e4 00 00 00    	je     80105299 <sys_link+0x139>
  ilock(ip);
801051b5:	83 ec 0c             	sub    $0xc,%esp
801051b8:	50                   	push   %eax
801051b9:	e8 c2 c5 ff ff       	call   80101780 <ilock>
  if(ip->type == T_DIR){
801051be:	83 c4 10             	add    $0x10,%esp
801051c1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051c6:	0f 84 b5 00 00 00    	je     80105281 <sys_link+0x121>
  iupdate(ip);
801051cc:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801051cf:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801051d4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801051d7:	53                   	push   %ebx
801051d8:	e8 f3 c4 ff ff       	call   801016d0 <iupdate>
  iunlock(ip);
801051dd:	89 1c 24             	mov    %ebx,(%esp)
801051e0:	e8 7b c6 ff ff       	call   80101860 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801051e5:	58                   	pop    %eax
801051e6:	5a                   	pop    %edx
801051e7:	57                   	push   %edi
801051e8:	ff 75 d0             	push   -0x30(%ebp)
801051eb:	e8 d0 ce ff ff       	call   801020c0 <nameiparent>
801051f0:	83 c4 10             	add    $0x10,%esp
801051f3:	89 c6                	mov    %eax,%esi
801051f5:	85 c0                	test   %eax,%eax
801051f7:	74 5b                	je     80105254 <sys_link+0xf4>
  ilock(dp);
801051f9:	83 ec 0c             	sub    $0xc,%esp
801051fc:	50                   	push   %eax
801051fd:	e8 7e c5 ff ff       	call   80101780 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105202:	8b 03                	mov    (%ebx),%eax
80105204:	83 c4 10             	add    $0x10,%esp
80105207:	39 06                	cmp    %eax,(%esi)
80105209:	75 3d                	jne    80105248 <sys_link+0xe8>
8010520b:	83 ec 04             	sub    $0x4,%esp
8010520e:	ff 73 04             	push   0x4(%ebx)
80105211:	57                   	push   %edi
80105212:	56                   	push   %esi
80105213:	e8 c8 cd ff ff       	call   80101fe0 <dirlink>
80105218:	83 c4 10             	add    $0x10,%esp
8010521b:	85 c0                	test   %eax,%eax
8010521d:	78 29                	js     80105248 <sys_link+0xe8>
  iunlockput(dp);
8010521f:	83 ec 0c             	sub    $0xc,%esp
80105222:	56                   	push   %esi
80105223:	e8 e8 c7 ff ff       	call   80101a10 <iunlockput>
  iput(ip);
80105228:	89 1c 24             	mov    %ebx,(%esp)
8010522b:	e8 80 c6 ff ff       	call   801018b0 <iput>
  end_op();
80105230:	e8 9b db ff ff       	call   80102dd0 <end_op>
  return 0;
80105235:	83 c4 10             	add    $0x10,%esp
80105238:	31 c0                	xor    %eax,%eax
}
8010523a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010523d:	5b                   	pop    %ebx
8010523e:	5e                   	pop    %esi
8010523f:	5f                   	pop    %edi
80105240:	5d                   	pop    %ebp
80105241:	c3                   	ret    
80105242:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105248:	83 ec 0c             	sub    $0xc,%esp
8010524b:	56                   	push   %esi
8010524c:	e8 bf c7 ff ff       	call   80101a10 <iunlockput>
    goto bad;
80105251:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105254:	83 ec 0c             	sub    $0xc,%esp
80105257:	53                   	push   %ebx
80105258:	e8 23 c5 ff ff       	call   80101780 <ilock>
  ip->nlink--;
8010525d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105262:	89 1c 24             	mov    %ebx,(%esp)
80105265:	e8 66 c4 ff ff       	call   801016d0 <iupdate>
  iunlockput(ip);
8010526a:	89 1c 24             	mov    %ebx,(%esp)
8010526d:	e8 9e c7 ff ff       	call   80101a10 <iunlockput>
  end_op();
80105272:	e8 59 db ff ff       	call   80102dd0 <end_op>
  return -1;
80105277:	83 c4 10             	add    $0x10,%esp
8010527a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010527f:	eb b9                	jmp    8010523a <sys_link+0xda>
    iunlockput(ip);
80105281:	83 ec 0c             	sub    $0xc,%esp
80105284:	53                   	push   %ebx
80105285:	e8 86 c7 ff ff       	call   80101a10 <iunlockput>
    end_op();
8010528a:	e8 41 db ff ff       	call   80102dd0 <end_op>
    return -1;
8010528f:	83 c4 10             	add    $0x10,%esp
80105292:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105297:	eb a1                	jmp    8010523a <sys_link+0xda>
    end_op();
80105299:	e8 32 db ff ff       	call   80102dd0 <end_op>
    return -1;
8010529e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052a3:	eb 95                	jmp    8010523a <sys_link+0xda>
801052a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052b0 <sys_unlink>:
{
801052b0:	55                   	push   %ebp
801052b1:	89 e5                	mov    %esp,%ebp
801052b3:	57                   	push   %edi
801052b4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
801052b5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801052b8:	53                   	push   %ebx
801052b9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
801052bc:	50                   	push   %eax
801052bd:	6a 00                	push   $0x0
801052bf:	e8 bc f9 ff ff       	call   80104c80 <argstr>
801052c4:	83 c4 10             	add    $0x10,%esp
801052c7:	85 c0                	test   %eax,%eax
801052c9:	0f 88 7a 01 00 00    	js     80105449 <sys_unlink+0x199>
  begin_op();
801052cf:	e8 8c da ff ff       	call   80102d60 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801052d4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801052d7:	83 ec 08             	sub    $0x8,%esp
801052da:	53                   	push   %ebx
801052db:	ff 75 c0             	push   -0x40(%ebp)
801052de:	e8 dd cd ff ff       	call   801020c0 <nameiparent>
801052e3:	83 c4 10             	add    $0x10,%esp
801052e6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801052e9:	85 c0                	test   %eax,%eax
801052eb:	0f 84 62 01 00 00    	je     80105453 <sys_unlink+0x1a3>
  ilock(dp);
801052f1:	8b 7d b4             	mov    -0x4c(%ebp),%edi
801052f4:	83 ec 0c             	sub    $0xc,%esp
801052f7:	57                   	push   %edi
801052f8:	e8 83 c4 ff ff       	call   80101780 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801052fd:	58                   	pop    %eax
801052fe:	5a                   	pop    %edx
801052ff:	68 68 8b 10 80       	push   $0x80108b68
80105304:	53                   	push   %ebx
80105305:	e8 b6 c9 ff ff       	call   80101cc0 <namecmp>
8010530a:	83 c4 10             	add    $0x10,%esp
8010530d:	85 c0                	test   %eax,%eax
8010530f:	0f 84 fb 00 00 00    	je     80105410 <sys_unlink+0x160>
80105315:	83 ec 08             	sub    $0x8,%esp
80105318:	68 67 8b 10 80       	push   $0x80108b67
8010531d:	53                   	push   %ebx
8010531e:	e8 9d c9 ff ff       	call   80101cc0 <namecmp>
80105323:	83 c4 10             	add    $0x10,%esp
80105326:	85 c0                	test   %eax,%eax
80105328:	0f 84 e2 00 00 00    	je     80105410 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010532e:	83 ec 04             	sub    $0x4,%esp
80105331:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105334:	50                   	push   %eax
80105335:	53                   	push   %ebx
80105336:	57                   	push   %edi
80105337:	e8 a4 c9 ff ff       	call   80101ce0 <dirlookup>
8010533c:	83 c4 10             	add    $0x10,%esp
8010533f:	89 c3                	mov    %eax,%ebx
80105341:	85 c0                	test   %eax,%eax
80105343:	0f 84 c7 00 00 00    	je     80105410 <sys_unlink+0x160>
  ilock(ip);
80105349:	83 ec 0c             	sub    $0xc,%esp
8010534c:	50                   	push   %eax
8010534d:	e8 2e c4 ff ff       	call   80101780 <ilock>
  if(ip->nlink < 1)
80105352:	83 c4 10             	add    $0x10,%esp
80105355:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010535a:	0f 8e 1c 01 00 00    	jle    8010547c <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105360:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105365:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105368:	74 66                	je     801053d0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010536a:	83 ec 04             	sub    $0x4,%esp
8010536d:	6a 10                	push   $0x10
8010536f:	6a 00                	push   $0x0
80105371:	57                   	push   %edi
80105372:	e8 89 f5 ff ff       	call   80104900 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105377:	6a 10                	push   $0x10
80105379:	ff 75 c4             	push   -0x3c(%ebp)
8010537c:	57                   	push   %edi
8010537d:	ff 75 b4             	push   -0x4c(%ebp)
80105380:	e8 0b c8 ff ff       	call   80101b90 <writei>
80105385:	83 c4 20             	add    $0x20,%esp
80105388:	83 f8 10             	cmp    $0x10,%eax
8010538b:	0f 85 de 00 00 00    	jne    8010546f <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
80105391:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105396:	0f 84 94 00 00 00    	je     80105430 <sys_unlink+0x180>
  iunlockput(dp);
8010539c:	83 ec 0c             	sub    $0xc,%esp
8010539f:	ff 75 b4             	push   -0x4c(%ebp)
801053a2:	e8 69 c6 ff ff       	call   80101a10 <iunlockput>
  ip->nlink--;
801053a7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801053ac:	89 1c 24             	mov    %ebx,(%esp)
801053af:	e8 1c c3 ff ff       	call   801016d0 <iupdate>
  iunlockput(ip);
801053b4:	89 1c 24             	mov    %ebx,(%esp)
801053b7:	e8 54 c6 ff ff       	call   80101a10 <iunlockput>
  end_op();
801053bc:	e8 0f da ff ff       	call   80102dd0 <end_op>
  return 0;
801053c1:	83 c4 10             	add    $0x10,%esp
801053c4:	31 c0                	xor    %eax,%eax
}
801053c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053c9:	5b                   	pop    %ebx
801053ca:	5e                   	pop    %esi
801053cb:	5f                   	pop    %edi
801053cc:	5d                   	pop    %ebp
801053cd:	c3                   	ret    
801053ce:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801053d0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801053d4:	76 94                	jbe    8010536a <sys_unlink+0xba>
801053d6:	be 20 00 00 00       	mov    $0x20,%esi
801053db:	eb 0b                	jmp    801053e8 <sys_unlink+0x138>
801053dd:	8d 76 00             	lea    0x0(%esi),%esi
801053e0:	83 c6 10             	add    $0x10,%esi
801053e3:	3b 73 58             	cmp    0x58(%ebx),%esi
801053e6:	73 82                	jae    8010536a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801053e8:	6a 10                	push   $0x10
801053ea:	56                   	push   %esi
801053eb:	57                   	push   %edi
801053ec:	53                   	push   %ebx
801053ed:	e8 9e c6 ff ff       	call   80101a90 <readi>
801053f2:	83 c4 10             	add    $0x10,%esp
801053f5:	83 f8 10             	cmp    $0x10,%eax
801053f8:	75 68                	jne    80105462 <sys_unlink+0x1b2>
    if(de.inum != 0)
801053fa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801053ff:	74 df                	je     801053e0 <sys_unlink+0x130>
    iunlockput(ip);
80105401:	83 ec 0c             	sub    $0xc,%esp
80105404:	53                   	push   %ebx
80105405:	e8 06 c6 ff ff       	call   80101a10 <iunlockput>
    goto bad;
8010540a:	83 c4 10             	add    $0x10,%esp
8010540d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105410:	83 ec 0c             	sub    $0xc,%esp
80105413:	ff 75 b4             	push   -0x4c(%ebp)
80105416:	e8 f5 c5 ff ff       	call   80101a10 <iunlockput>
  end_op();
8010541b:	e8 b0 d9 ff ff       	call   80102dd0 <end_op>
  return -1;
80105420:	83 c4 10             	add    $0x10,%esp
80105423:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105428:	eb 9c                	jmp    801053c6 <sys_unlink+0x116>
8010542a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105430:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105433:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105436:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010543b:	50                   	push   %eax
8010543c:	e8 8f c2 ff ff       	call   801016d0 <iupdate>
80105441:	83 c4 10             	add    $0x10,%esp
80105444:	e9 53 ff ff ff       	jmp    8010539c <sys_unlink+0xec>
    return -1;
80105449:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010544e:	e9 73 ff ff ff       	jmp    801053c6 <sys_unlink+0x116>
    end_op();
80105453:	e8 78 d9 ff ff       	call   80102dd0 <end_op>
    return -1;
80105458:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010545d:	e9 64 ff ff ff       	jmp    801053c6 <sys_unlink+0x116>
      panic("isdirempty: readi");
80105462:	83 ec 0c             	sub    $0xc,%esp
80105465:	68 8c 8b 10 80       	push   $0x80108b8c
8010546a:	e8 11 af ff ff       	call   80100380 <panic>
    panic("unlink: writei");
8010546f:	83 ec 0c             	sub    $0xc,%esp
80105472:	68 9e 8b 10 80       	push   $0x80108b9e
80105477:	e8 04 af ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
8010547c:	83 ec 0c             	sub    $0xc,%esp
8010547f:	68 7a 8b 10 80       	push   $0x80108b7a
80105484:	e8 f7 ae ff ff       	call   80100380 <panic>
80105489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105490 <sys_open>:

int
sys_open(void)
{
80105490:	55                   	push   %ebp
80105491:	89 e5                	mov    %esp,%ebp
80105493:	57                   	push   %edi
80105494:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105495:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105498:	53                   	push   %ebx
80105499:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010549c:	50                   	push   %eax
8010549d:	6a 00                	push   $0x0
8010549f:	e8 dc f7 ff ff       	call   80104c80 <argstr>
801054a4:	83 c4 10             	add    $0x10,%esp
801054a7:	85 c0                	test   %eax,%eax
801054a9:	0f 88 8e 00 00 00    	js     8010553d <sys_open+0xad>
801054af:	83 ec 08             	sub    $0x8,%esp
801054b2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801054b5:	50                   	push   %eax
801054b6:	6a 01                	push   $0x1
801054b8:	e8 03 f7 ff ff       	call   80104bc0 <argint>
801054bd:	83 c4 10             	add    $0x10,%esp
801054c0:	85 c0                	test   %eax,%eax
801054c2:	78 79                	js     8010553d <sys_open+0xad>
    return -1;

  begin_op();
801054c4:	e8 97 d8 ff ff       	call   80102d60 <begin_op>

  if(omode & O_CREATE){
801054c9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801054cd:	75 79                	jne    80105548 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801054cf:	83 ec 0c             	sub    $0xc,%esp
801054d2:	ff 75 e0             	push   -0x20(%ebp)
801054d5:	e8 c6 cb ff ff       	call   801020a0 <namei>
801054da:	83 c4 10             	add    $0x10,%esp
801054dd:	89 c6                	mov    %eax,%esi
801054df:	85 c0                	test   %eax,%eax
801054e1:	0f 84 7e 00 00 00    	je     80105565 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
801054e7:	83 ec 0c             	sub    $0xc,%esp
801054ea:	50                   	push   %eax
801054eb:	e8 90 c2 ff ff       	call   80101780 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801054f0:	83 c4 10             	add    $0x10,%esp
801054f3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801054f8:	0f 84 c2 00 00 00    	je     801055c0 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801054fe:	e8 2d b9 ff ff       	call   80100e30 <filealloc>
80105503:	89 c7                	mov    %eax,%edi
80105505:	85 c0                	test   %eax,%eax
80105507:	74 23                	je     8010552c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105509:	e8 c2 e4 ff ff       	call   801039d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010550e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105510:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105514:	85 d2                	test   %edx,%edx
80105516:	74 60                	je     80105578 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105518:	83 c3 01             	add    $0x1,%ebx
8010551b:	83 fb 10             	cmp    $0x10,%ebx
8010551e:	75 f0                	jne    80105510 <sys_open+0x80>
    if(f)
      fileclose(f);
80105520:	83 ec 0c             	sub    $0xc,%esp
80105523:	57                   	push   %edi
80105524:	e8 c7 b9 ff ff       	call   80100ef0 <fileclose>
80105529:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010552c:	83 ec 0c             	sub    $0xc,%esp
8010552f:	56                   	push   %esi
80105530:	e8 db c4 ff ff       	call   80101a10 <iunlockput>
    end_op();
80105535:	e8 96 d8 ff ff       	call   80102dd0 <end_op>
    return -1;
8010553a:	83 c4 10             	add    $0x10,%esp
8010553d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105542:	eb 6d                	jmp    801055b1 <sys_open+0x121>
80105544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105548:	83 ec 0c             	sub    $0xc,%esp
8010554b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010554e:	31 c9                	xor    %ecx,%ecx
80105550:	ba 02 00 00 00       	mov    $0x2,%edx
80105555:	6a 00                	push   $0x0
80105557:	e8 14 f8 ff ff       	call   80104d70 <create>
    if(ip == 0){
8010555c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010555f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105561:	85 c0                	test   %eax,%eax
80105563:	75 99                	jne    801054fe <sys_open+0x6e>
      end_op();
80105565:	e8 66 d8 ff ff       	call   80102dd0 <end_op>
      return -1;
8010556a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010556f:	eb 40                	jmp    801055b1 <sys_open+0x121>
80105571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105578:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010557b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010557f:	56                   	push   %esi
80105580:	e8 db c2 ff ff       	call   80101860 <iunlock>
  end_op();
80105585:	e8 46 d8 ff ff       	call   80102dd0 <end_op>

  f->type = FD_INODE;
8010558a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105590:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105593:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105596:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105599:	89 d0                	mov    %edx,%eax
  f->off = 0;
8010559b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801055a2:	f7 d0                	not    %eax
801055a4:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801055a7:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801055aa:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801055ad:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801055b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055b4:	89 d8                	mov    %ebx,%eax
801055b6:	5b                   	pop    %ebx
801055b7:	5e                   	pop    %esi
801055b8:	5f                   	pop    %edi
801055b9:	5d                   	pop    %ebp
801055ba:	c3                   	ret    
801055bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055bf:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
801055c0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801055c3:	85 c9                	test   %ecx,%ecx
801055c5:	0f 84 33 ff ff ff    	je     801054fe <sys_open+0x6e>
801055cb:	e9 5c ff ff ff       	jmp    8010552c <sys_open+0x9c>

801055d0 <sys_mkdir>:

int
sys_mkdir(void)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801055d6:	e8 85 d7 ff ff       	call   80102d60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801055db:	83 ec 08             	sub    $0x8,%esp
801055de:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055e1:	50                   	push   %eax
801055e2:	6a 00                	push   $0x0
801055e4:	e8 97 f6 ff ff       	call   80104c80 <argstr>
801055e9:	83 c4 10             	add    $0x10,%esp
801055ec:	85 c0                	test   %eax,%eax
801055ee:	78 30                	js     80105620 <sys_mkdir+0x50>
801055f0:	83 ec 0c             	sub    $0xc,%esp
801055f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055f6:	31 c9                	xor    %ecx,%ecx
801055f8:	ba 01 00 00 00       	mov    $0x1,%edx
801055fd:	6a 00                	push   $0x0
801055ff:	e8 6c f7 ff ff       	call   80104d70 <create>
80105604:	83 c4 10             	add    $0x10,%esp
80105607:	85 c0                	test   %eax,%eax
80105609:	74 15                	je     80105620 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010560b:	83 ec 0c             	sub    $0xc,%esp
8010560e:	50                   	push   %eax
8010560f:	e8 fc c3 ff ff       	call   80101a10 <iunlockput>
  end_op();
80105614:	e8 b7 d7 ff ff       	call   80102dd0 <end_op>
  return 0;
80105619:	83 c4 10             	add    $0x10,%esp
8010561c:	31 c0                	xor    %eax,%eax
}
8010561e:	c9                   	leave  
8010561f:	c3                   	ret    
    end_op();
80105620:	e8 ab d7 ff ff       	call   80102dd0 <end_op>
    return -1;
80105625:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010562a:	c9                   	leave  
8010562b:	c3                   	ret    
8010562c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105630 <sys_mknod>:

int
sys_mknod(void)
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105636:	e8 25 d7 ff ff       	call   80102d60 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010563b:	83 ec 08             	sub    $0x8,%esp
8010563e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105641:	50                   	push   %eax
80105642:	6a 00                	push   $0x0
80105644:	e8 37 f6 ff ff       	call   80104c80 <argstr>
80105649:	83 c4 10             	add    $0x10,%esp
8010564c:	85 c0                	test   %eax,%eax
8010564e:	78 60                	js     801056b0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105650:	83 ec 08             	sub    $0x8,%esp
80105653:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105656:	50                   	push   %eax
80105657:	6a 01                	push   $0x1
80105659:	e8 62 f5 ff ff       	call   80104bc0 <argint>
  if((argstr(0, &path)) < 0 ||
8010565e:	83 c4 10             	add    $0x10,%esp
80105661:	85 c0                	test   %eax,%eax
80105663:	78 4b                	js     801056b0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105665:	83 ec 08             	sub    $0x8,%esp
80105668:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010566b:	50                   	push   %eax
8010566c:	6a 02                	push   $0x2
8010566e:	e8 4d f5 ff ff       	call   80104bc0 <argint>
     argint(1, &major) < 0 ||
80105673:	83 c4 10             	add    $0x10,%esp
80105676:	85 c0                	test   %eax,%eax
80105678:	78 36                	js     801056b0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010567a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010567e:	83 ec 0c             	sub    $0xc,%esp
80105681:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105685:	ba 03 00 00 00       	mov    $0x3,%edx
8010568a:	50                   	push   %eax
8010568b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010568e:	e8 dd f6 ff ff       	call   80104d70 <create>
     argint(2, &minor) < 0 ||
80105693:	83 c4 10             	add    $0x10,%esp
80105696:	85 c0                	test   %eax,%eax
80105698:	74 16                	je     801056b0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010569a:	83 ec 0c             	sub    $0xc,%esp
8010569d:	50                   	push   %eax
8010569e:	e8 6d c3 ff ff       	call   80101a10 <iunlockput>
  end_op();
801056a3:	e8 28 d7 ff ff       	call   80102dd0 <end_op>
  return 0;
801056a8:	83 c4 10             	add    $0x10,%esp
801056ab:	31 c0                	xor    %eax,%eax
}
801056ad:	c9                   	leave  
801056ae:	c3                   	ret    
801056af:	90                   	nop
    end_op();
801056b0:	e8 1b d7 ff ff       	call   80102dd0 <end_op>
    return -1;
801056b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056ba:	c9                   	leave  
801056bb:	c3                   	ret    
801056bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056c0 <sys_chdir>:

int
sys_chdir(void)
{
801056c0:	55                   	push   %ebp
801056c1:	89 e5                	mov    %esp,%ebp
801056c3:	56                   	push   %esi
801056c4:	53                   	push   %ebx
801056c5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801056c8:	e8 03 e3 ff ff       	call   801039d0 <myproc>
801056cd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801056cf:	e8 8c d6 ff ff       	call   80102d60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801056d4:	83 ec 08             	sub    $0x8,%esp
801056d7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056da:	50                   	push   %eax
801056db:	6a 00                	push   $0x0
801056dd:	e8 9e f5 ff ff       	call   80104c80 <argstr>
801056e2:	83 c4 10             	add    $0x10,%esp
801056e5:	85 c0                	test   %eax,%eax
801056e7:	78 77                	js     80105760 <sys_chdir+0xa0>
801056e9:	83 ec 0c             	sub    $0xc,%esp
801056ec:	ff 75 f4             	push   -0xc(%ebp)
801056ef:	e8 ac c9 ff ff       	call   801020a0 <namei>
801056f4:	83 c4 10             	add    $0x10,%esp
801056f7:	89 c3                	mov    %eax,%ebx
801056f9:	85 c0                	test   %eax,%eax
801056fb:	74 63                	je     80105760 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801056fd:	83 ec 0c             	sub    $0xc,%esp
80105700:	50                   	push   %eax
80105701:	e8 7a c0 ff ff       	call   80101780 <ilock>
  if(ip->type != T_DIR){
80105706:	83 c4 10             	add    $0x10,%esp
80105709:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010570e:	75 30                	jne    80105740 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105710:	83 ec 0c             	sub    $0xc,%esp
80105713:	53                   	push   %ebx
80105714:	e8 47 c1 ff ff       	call   80101860 <iunlock>
  iput(curproc->cwd);
80105719:	58                   	pop    %eax
8010571a:	ff 76 68             	push   0x68(%esi)
8010571d:	e8 8e c1 ff ff       	call   801018b0 <iput>
  end_op();
80105722:	e8 a9 d6 ff ff       	call   80102dd0 <end_op>
  curproc->cwd = ip;
80105727:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010572a:	83 c4 10             	add    $0x10,%esp
8010572d:	31 c0                	xor    %eax,%eax
}
8010572f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105732:	5b                   	pop    %ebx
80105733:	5e                   	pop    %esi
80105734:	5d                   	pop    %ebp
80105735:	c3                   	ret    
80105736:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010573d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105740:	83 ec 0c             	sub    $0xc,%esp
80105743:	53                   	push   %ebx
80105744:	e8 c7 c2 ff ff       	call   80101a10 <iunlockput>
    end_op();
80105749:	e8 82 d6 ff ff       	call   80102dd0 <end_op>
    return -1;
8010574e:	83 c4 10             	add    $0x10,%esp
80105751:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105756:	eb d7                	jmp    8010572f <sys_chdir+0x6f>
80105758:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010575f:	90                   	nop
    end_op();
80105760:	e8 6b d6 ff ff       	call   80102dd0 <end_op>
    return -1;
80105765:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010576a:	eb c3                	jmp    8010572f <sys_chdir+0x6f>
8010576c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105770 <sys_exec>:

int
sys_exec(void)
{
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	57                   	push   %edi
80105774:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105775:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010577b:	53                   	push   %ebx
8010577c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105782:	50                   	push   %eax
80105783:	6a 00                	push   $0x0
80105785:	e8 f6 f4 ff ff       	call   80104c80 <argstr>
8010578a:	83 c4 10             	add    $0x10,%esp
8010578d:	85 c0                	test   %eax,%eax
8010578f:	0f 88 87 00 00 00    	js     8010581c <sys_exec+0xac>
80105795:	83 ec 08             	sub    $0x8,%esp
80105798:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010579e:	50                   	push   %eax
8010579f:	6a 01                	push   $0x1
801057a1:	e8 1a f4 ff ff       	call   80104bc0 <argint>
801057a6:	83 c4 10             	add    $0x10,%esp
801057a9:	85 c0                	test   %eax,%eax
801057ab:	78 6f                	js     8010581c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801057ad:	83 ec 04             	sub    $0x4,%esp
801057b0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
801057b6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801057b8:	68 80 00 00 00       	push   $0x80
801057bd:	6a 00                	push   $0x0
801057bf:	56                   	push   %esi
801057c0:	e8 3b f1 ff ff       	call   80104900 <memset>
801057c5:	83 c4 10             	add    $0x10,%esp
801057c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057cf:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801057d0:	83 ec 08             	sub    $0x8,%esp
801057d3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
801057d9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
801057e0:	50                   	push   %eax
801057e1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801057e7:	01 f8                	add    %edi,%eax
801057e9:	50                   	push   %eax
801057ea:	e8 41 f3 ff ff       	call   80104b30 <fetchint>
801057ef:	83 c4 10             	add    $0x10,%esp
801057f2:	85 c0                	test   %eax,%eax
801057f4:	78 26                	js     8010581c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
801057f6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801057fc:	85 c0                	test   %eax,%eax
801057fe:	74 30                	je     80105830 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105800:	83 ec 08             	sub    $0x8,%esp
80105803:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105806:	52                   	push   %edx
80105807:	50                   	push   %eax
80105808:	e8 63 f3 ff ff       	call   80104b70 <fetchstr>
8010580d:	83 c4 10             	add    $0x10,%esp
80105810:	85 c0                	test   %eax,%eax
80105812:	78 08                	js     8010581c <sys_exec+0xac>
  for(i=0;; i++){
80105814:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105817:	83 fb 20             	cmp    $0x20,%ebx
8010581a:	75 b4                	jne    801057d0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010581c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010581f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105824:	5b                   	pop    %ebx
80105825:	5e                   	pop    %esi
80105826:	5f                   	pop    %edi
80105827:	5d                   	pop    %ebp
80105828:	c3                   	ret    
80105829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105830:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105837:	00 00 00 00 
  return exec(path, argv);
8010583b:	83 ec 08             	sub    $0x8,%esp
8010583e:	56                   	push   %esi
8010583f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105845:	e8 66 b2 ff ff       	call   80100ab0 <exec>
8010584a:	83 c4 10             	add    $0x10,%esp
}
8010584d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105850:	5b                   	pop    %ebx
80105851:	5e                   	pop    %esi
80105852:	5f                   	pop    %edi
80105853:	5d                   	pop    %ebp
80105854:	c3                   	ret    
80105855:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010585c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105860 <sys_pipe>:

int
sys_pipe(void)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	57                   	push   %edi
80105864:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105865:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105868:	53                   	push   %ebx
80105869:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010586c:	6a 08                	push   $0x8
8010586e:	50                   	push   %eax
8010586f:	6a 00                	push   $0x0
80105871:	e8 9a f3 ff ff       	call   80104c10 <argptr>
80105876:	83 c4 10             	add    $0x10,%esp
80105879:	85 c0                	test   %eax,%eax
8010587b:	78 4a                	js     801058c7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010587d:	83 ec 08             	sub    $0x8,%esp
80105880:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105883:	50                   	push   %eax
80105884:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105887:	50                   	push   %eax
80105888:	e8 a3 db ff ff       	call   80103430 <pipealloc>
8010588d:	83 c4 10             	add    $0x10,%esp
80105890:	85 c0                	test   %eax,%eax
80105892:	78 33                	js     801058c7 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105894:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105897:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105899:	e8 32 e1 ff ff       	call   801039d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010589e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
801058a0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801058a4:	85 f6                	test   %esi,%esi
801058a6:	74 28                	je     801058d0 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
801058a8:	83 c3 01             	add    $0x1,%ebx
801058ab:	83 fb 10             	cmp    $0x10,%ebx
801058ae:	75 f0                	jne    801058a0 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801058b0:	83 ec 0c             	sub    $0xc,%esp
801058b3:	ff 75 e0             	push   -0x20(%ebp)
801058b6:	e8 35 b6 ff ff       	call   80100ef0 <fileclose>
    fileclose(wf);
801058bb:	58                   	pop    %eax
801058bc:	ff 75 e4             	push   -0x1c(%ebp)
801058bf:	e8 2c b6 ff ff       	call   80100ef0 <fileclose>
    return -1;
801058c4:	83 c4 10             	add    $0x10,%esp
801058c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058cc:	eb 53                	jmp    80105921 <sys_pipe+0xc1>
801058ce:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801058d0:	8d 73 08             	lea    0x8(%ebx),%esi
801058d3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801058d7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801058da:	e8 f1 e0 ff ff       	call   801039d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801058df:	31 d2                	xor    %edx,%edx
801058e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801058e8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801058ec:	85 c9                	test   %ecx,%ecx
801058ee:	74 20                	je     80105910 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
801058f0:	83 c2 01             	add    $0x1,%edx
801058f3:	83 fa 10             	cmp    $0x10,%edx
801058f6:	75 f0                	jne    801058e8 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
801058f8:	e8 d3 e0 ff ff       	call   801039d0 <myproc>
801058fd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105904:	00 
80105905:	eb a9                	jmp    801058b0 <sys_pipe+0x50>
80105907:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010590e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105910:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105914:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105917:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105919:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010591c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010591f:	31 c0                	xor    %eax,%eax
}
80105921:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105924:	5b                   	pop    %ebx
80105925:	5e                   	pop    %esi
80105926:	5f                   	pop    %edi
80105927:	5d                   	pop    %ebp
80105928:	c3                   	ret    
80105929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105930 <sys_wmap>:
uint sys_wmap(void) {
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	83 ec 20             	sub    $0x20,%esp
  uint addr;
  int length;
  int flags;
  int fd;
  if(argint(0, (int*)&addr) < 0 || argint(1, &length) < 0 || argint(2, &flags) < 0 || argint(3, &fd) < 0) {
80105936:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105939:	50                   	push   %eax
8010593a:	6a 00                	push   $0x0
8010593c:	e8 7f f2 ff ff       	call   80104bc0 <argint>
80105941:	83 c4 10             	add    $0x10,%esp
80105944:	85 c0                	test   %eax,%eax
80105946:	78 58                	js     801059a0 <sys_wmap+0x70>
80105948:	83 ec 08             	sub    $0x8,%esp
8010594b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010594e:	50                   	push   %eax
8010594f:	6a 01                	push   $0x1
80105951:	e8 6a f2 ff ff       	call   80104bc0 <argint>
80105956:	83 c4 10             	add    $0x10,%esp
80105959:	85 c0                	test   %eax,%eax
8010595b:	78 43                	js     801059a0 <sys_wmap+0x70>
8010595d:	83 ec 08             	sub    $0x8,%esp
80105960:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105963:	50                   	push   %eax
80105964:	6a 02                	push   $0x2
80105966:	e8 55 f2 ff ff       	call   80104bc0 <argint>
8010596b:	83 c4 10             	add    $0x10,%esp
8010596e:	85 c0                	test   %eax,%eax
80105970:	78 2e                	js     801059a0 <sys_wmap+0x70>
80105972:	83 ec 08             	sub    $0x8,%esp
80105975:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105978:	50                   	push   %eax
80105979:	6a 03                	push   $0x3
8010597b:	e8 40 f2 ff ff       	call   80104bc0 <argint>
80105980:	83 c4 10             	add    $0x10,%esp
80105983:	85 c0                	test   %eax,%eax
80105985:	78 19                	js     801059a0 <sys_wmap+0x70>
   return -1;
  }
  //cprintf("addr = %x\n", addr);
  uint map = wmap(addr, length, flags, fd);
80105987:	ff 75 f4             	push   -0xc(%ebp)
8010598a:	ff 75 f0             	push   -0x10(%ebp)
8010598d:	ff 75 ec             	push   -0x14(%ebp)
80105990:	ff 75 e8             	push   -0x18(%ebp)
80105993:	e8 18 1e 00 00       	call   801077b0 <wmap>
  return map;
80105998:	83 c4 10             	add    $0x10,%esp
}
8010599b:	c9                   	leave  
8010599c:	c3                   	ret    
8010599d:	8d 76 00             	lea    0x0(%esi),%esi
801059a0:	c9                   	leave  
   return -1;
801059a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059a6:	c3                   	ret    
801059a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059ae:	66 90                	xchg   %ax,%ax

801059b0 <sys_wunmap>:

int
sys_wunmap(void)
{
801059b0:	55                   	push   %ebp
801059b1:	89 e5                	mov    %esp,%ebp
801059b3:	83 ec 20             	sub    $0x20,%esp
  uint addr;
  if (argint(0, (int*)&addr) < 0) {
801059b6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059b9:	50                   	push   %eax
801059ba:	6a 00                	push   $0x0
801059bc:	e8 ff f1 ff ff       	call   80104bc0 <argint>
801059c1:	83 c4 10             	add    $0x10,%esp
801059c4:	85 c0                	test   %eax,%eax
801059c6:	78 18                	js     801059e0 <sys_wunmap+0x30>
   return -1;
  }

  if(wunmap(addr) == 0){
801059c8:	83 ec 0c             	sub    $0xc,%esp
801059cb:	ff 75 f4             	push   -0xc(%ebp)
801059ce:	e8 7d 20 00 00       	call   80107a50 <wunmap>
801059d3:	83 c4 10             	add    $0x10,%esp
    return 0;
  }
  else{
    return -1;
  }
}
801059d6:	c9                   	leave  
  if(wunmap(addr) == 0){
801059d7:	f7 d8                	neg    %eax
801059d9:	19 c0                	sbb    %eax,%eax
}
801059db:	c3                   	ret    
801059dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059e0:	c9                   	leave  
   return -1;
801059e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059e6:	c3                   	ret    
801059e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059ee:	66 90                	xchg   %ax,%ax

801059f0 <sys_wremap>:
uint sys_wremap(void) {
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	83 ec 20             	sub    $0x20,%esp
  uint oldaddr;
  int oldsize;
  int newsize;
  int flags;
  if(argint(0, (int*)&oldaddr) < 0 || argint(1, &oldsize) < 0 || argint(2, &newsize) < 0 || argint(3, &flags) < 0) {
801059f6:	8d 45 e8             	lea    -0x18(%ebp),%eax
801059f9:	50                   	push   %eax
801059fa:	6a 00                	push   $0x0
801059fc:	e8 bf f1 ff ff       	call   80104bc0 <argint>
80105a01:	83 c4 10             	add    $0x10,%esp
80105a04:	85 c0                	test   %eax,%eax
80105a06:	78 58                	js     80105a60 <sys_wremap+0x70>
80105a08:	83 ec 08             	sub    $0x8,%esp
80105a0b:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105a0e:	50                   	push   %eax
80105a0f:	6a 01                	push   $0x1
80105a11:	e8 aa f1 ff ff       	call   80104bc0 <argint>
80105a16:	83 c4 10             	add    $0x10,%esp
80105a19:	85 c0                	test   %eax,%eax
80105a1b:	78 43                	js     80105a60 <sys_wremap+0x70>
80105a1d:	83 ec 08             	sub    $0x8,%esp
80105a20:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a23:	50                   	push   %eax
80105a24:	6a 02                	push   $0x2
80105a26:	e8 95 f1 ff ff       	call   80104bc0 <argint>
80105a2b:	83 c4 10             	add    $0x10,%esp
80105a2e:	85 c0                	test   %eax,%eax
80105a30:	78 2e                	js     80105a60 <sys_wremap+0x70>
80105a32:	83 ec 08             	sub    $0x8,%esp
80105a35:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a38:	50                   	push   %eax
80105a39:	6a 03                	push   $0x3
80105a3b:	e8 80 f1 ff ff       	call   80104bc0 <argint>
80105a40:	83 c4 10             	add    $0x10,%esp
80105a43:	85 c0                	test   %eax,%eax
80105a45:	78 19                	js     80105a60 <sys_wremap+0x70>
    return -1;
  }
  
  return wremap(oldaddr, oldsize, newsize, flags);
80105a47:	ff 75 f4             	push   -0xc(%ebp)
80105a4a:	ff 75 f0             	push   -0x10(%ebp)
80105a4d:	ff 75 ec             	push   -0x14(%ebp)
80105a50:	ff 75 e8             	push   -0x18(%ebp)
80105a53:	e8 38 24 00 00       	call   80107e90 <wremap>
80105a58:	83 c4 10             	add    $0x10,%esp
}
80105a5b:	c9                   	leave  
80105a5c:	c3                   	ret    
80105a5d:	8d 76 00             	lea    0x0(%esi),%esi
80105a60:	c9                   	leave  
    return -1;
80105a61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a66:	c3                   	ret    
80105a67:	66 90                	xchg   %ax,%ax
80105a69:	66 90                	xchg   %ax,%ax
80105a6b:	66 90                	xchg   %ax,%ax
80105a6d:	66 90                	xchg   %ax,%ax
80105a6f:	90                   	nop

80105a70 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105a70:	e9 8b e2 ff ff       	jmp    80103d00 <fork>
80105a75:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a80 <sys_exit>:
}

int
sys_exit(void)
{
80105a80:	55                   	push   %ebp
80105a81:	89 e5                	mov    %esp,%ebp
80105a83:	83 ec 08             	sub    $0x8,%esp
  exit();
80105a86:	e8 a5 e5 ff ff       	call   80104030 <exit>
  return 0;  // not reached
}
80105a8b:	31 c0                	xor    %eax,%eax
80105a8d:	c9                   	leave  
80105a8e:	c3                   	ret    
80105a8f:	90                   	nop

80105a90 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105a90:	e9 cb e6 ff ff       	jmp    80104160 <wait>
80105a95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105aa0 <sys_kill>:
}

int
sys_kill(void)
{
80105aa0:	55                   	push   %ebp
80105aa1:	89 e5                	mov    %esp,%ebp
80105aa3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105aa6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105aa9:	50                   	push   %eax
80105aaa:	6a 00                	push   $0x0
80105aac:	e8 0f f1 ff ff       	call   80104bc0 <argint>
80105ab1:	83 c4 10             	add    $0x10,%esp
80105ab4:	85 c0                	test   %eax,%eax
80105ab6:	78 18                	js     80105ad0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105ab8:	83 ec 0c             	sub    $0xc,%esp
80105abb:	ff 75 f4             	push   -0xc(%ebp)
80105abe:	e8 3d e9 ff ff       	call   80104400 <kill>
80105ac3:	83 c4 10             	add    $0x10,%esp
}
80105ac6:	c9                   	leave  
80105ac7:	c3                   	ret    
80105ac8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105acf:	90                   	nop
80105ad0:	c9                   	leave  
    return -1;
80105ad1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ad6:	c3                   	ret    
80105ad7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ade:	66 90                	xchg   %ax,%ax

80105ae0 <sys_getpid>:

int
sys_getpid(void)
{
80105ae0:	55                   	push   %ebp
80105ae1:	89 e5                	mov    %esp,%ebp
80105ae3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105ae6:	e8 e5 de ff ff       	call   801039d0 <myproc>
80105aeb:	8b 40 10             	mov    0x10(%eax),%eax
}
80105aee:	c9                   	leave  
80105aef:	c3                   	ret    

80105af0 <sys_sbrk>:

int
sys_sbrk(void)
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105af4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105af7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105afa:	50                   	push   %eax
80105afb:	6a 00                	push   $0x0
80105afd:	e8 be f0 ff ff       	call   80104bc0 <argint>
80105b02:	83 c4 10             	add    $0x10,%esp
80105b05:	85 c0                	test   %eax,%eax
80105b07:	78 27                	js     80105b30 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105b09:	e8 c2 de ff ff       	call   801039d0 <myproc>
  if(growproc(n) < 0)
80105b0e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105b11:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105b13:	ff 75 f4             	push   -0xc(%ebp)
80105b16:	e8 d5 df ff ff       	call   80103af0 <growproc>
80105b1b:	83 c4 10             	add    $0x10,%esp
80105b1e:	85 c0                	test   %eax,%eax
80105b20:	78 0e                	js     80105b30 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105b22:	89 d8                	mov    %ebx,%eax
80105b24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b27:	c9                   	leave  
80105b28:	c3                   	ret    
80105b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105b30:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105b35:	eb eb                	jmp    80105b22 <sys_sbrk+0x32>
80105b37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b3e:	66 90                	xchg   %ax,%ax

80105b40 <sys_sleep>:

int
sys_sleep(void)
{
80105b40:	55                   	push   %ebp
80105b41:	89 e5                	mov    %esp,%ebp
80105b43:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105b44:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105b47:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105b4a:	50                   	push   %eax
80105b4b:	6a 00                	push   $0x0
80105b4d:	e8 6e f0 ff ff       	call   80104bc0 <argint>
80105b52:	83 c4 10             	add    $0x10,%esp
80105b55:	85 c0                	test   %eax,%eax
80105b57:	0f 88 8a 00 00 00    	js     80105be7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105b5d:	83 ec 0c             	sub    $0xc,%esp
80105b60:	68 80 ae 11 80       	push   $0x8011ae80
80105b65:	e8 d6 ec ff ff       	call   80104840 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105b6a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105b6d:	8b 1d 60 ae 11 80    	mov    0x8011ae60,%ebx
  while(ticks - ticks0 < n){
80105b73:	83 c4 10             	add    $0x10,%esp
80105b76:	85 d2                	test   %edx,%edx
80105b78:	75 27                	jne    80105ba1 <sys_sleep+0x61>
80105b7a:	eb 54                	jmp    80105bd0 <sys_sleep+0x90>
80105b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105b80:	83 ec 08             	sub    $0x8,%esp
80105b83:	68 80 ae 11 80       	push   $0x8011ae80
80105b88:	68 60 ae 11 80       	push   $0x8011ae60
80105b8d:	e8 4e e7 ff ff       	call   801042e0 <sleep>
  while(ticks - ticks0 < n){
80105b92:	a1 60 ae 11 80       	mov    0x8011ae60,%eax
80105b97:	83 c4 10             	add    $0x10,%esp
80105b9a:	29 d8                	sub    %ebx,%eax
80105b9c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105b9f:	73 2f                	jae    80105bd0 <sys_sleep+0x90>
    if(myproc()->killed){
80105ba1:	e8 2a de ff ff       	call   801039d0 <myproc>
80105ba6:	8b 40 24             	mov    0x24(%eax),%eax
80105ba9:	85 c0                	test   %eax,%eax
80105bab:	74 d3                	je     80105b80 <sys_sleep+0x40>
      release(&tickslock);
80105bad:	83 ec 0c             	sub    $0xc,%esp
80105bb0:	68 80 ae 11 80       	push   $0x8011ae80
80105bb5:	e8 26 ec ff ff       	call   801047e0 <release>
  }
  release(&tickslock);
  return 0;
}
80105bba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
80105bbd:	83 c4 10             	add    $0x10,%esp
80105bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bc5:	c9                   	leave  
80105bc6:	c3                   	ret    
80105bc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bce:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80105bd0:	83 ec 0c             	sub    $0xc,%esp
80105bd3:	68 80 ae 11 80       	push   $0x8011ae80
80105bd8:	e8 03 ec ff ff       	call   801047e0 <release>
  return 0;
80105bdd:	83 c4 10             	add    $0x10,%esp
80105be0:	31 c0                	xor    %eax,%eax
}
80105be2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105be5:	c9                   	leave  
80105be6:	c3                   	ret    
    return -1;
80105be7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bec:	eb f4                	jmp    80105be2 <sys_sleep+0xa2>
80105bee:	66 90                	xchg   %ax,%ax

80105bf0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105bf0:	55                   	push   %ebp
80105bf1:	89 e5                	mov    %esp,%ebp
80105bf3:	53                   	push   %ebx
80105bf4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105bf7:	68 80 ae 11 80       	push   $0x8011ae80
80105bfc:	e8 3f ec ff ff       	call   80104840 <acquire>
  xticks = ticks;
80105c01:	8b 1d 60 ae 11 80    	mov    0x8011ae60,%ebx
  release(&tickslock);
80105c07:	c7 04 24 80 ae 11 80 	movl   $0x8011ae80,(%esp)
80105c0e:	e8 cd eb ff ff       	call   801047e0 <release>
  return xticks;
}
80105c13:	89 d8                	mov    %ebx,%eax
80105c15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c18:	c9                   	leave  
80105c19:	c3                   	ret    

80105c1a <alltraps>:
80105c1a:	1e                   	push   %ds
80105c1b:	06                   	push   %es
80105c1c:	0f a0                	push   %fs
80105c1e:	0f a8                	push   %gs
80105c20:	60                   	pusha  
80105c21:	66 b8 10 00          	mov    $0x10,%ax
80105c25:	8e d8                	mov    %eax,%ds
80105c27:	8e c0                	mov    %eax,%es
80105c29:	54                   	push   %esp
80105c2a:	e8 c1 00 00 00       	call   80105cf0 <trap>
80105c2f:	83 c4 04             	add    $0x4,%esp

80105c32 <trapret>:
80105c32:	61                   	popa   
80105c33:	0f a9                	pop    %gs
80105c35:	0f a1                	pop    %fs
80105c37:	07                   	pop    %es
80105c38:	1f                   	pop    %ds
80105c39:	83 c4 08             	add    $0x8,%esp
80105c3c:	cf                   	iret   
80105c3d:	66 90                	xchg   %ax,%ax
80105c3f:	90                   	nop

80105c40 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105c40:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105c41:	31 c0                	xor    %eax,%eax
{
80105c43:	89 e5                	mov    %esp,%ebp
80105c45:	83 ec 08             	sub    $0x8,%esp
80105c48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c4f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105c50:	8b 14 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%edx
80105c57:	c7 04 c5 c2 ae 11 80 	movl   $0x8e000008,-0x7fee513e(,%eax,8)
80105c5e:	08 00 00 8e 
80105c62:	66 89 14 c5 c0 ae 11 	mov    %dx,-0x7fee5140(,%eax,8)
80105c69:	80 
80105c6a:	c1 ea 10             	shr    $0x10,%edx
80105c6d:	66 89 14 c5 c6 ae 11 	mov    %dx,-0x7fee513a(,%eax,8)
80105c74:	80 
  for(i = 0; i < 256; i++)
80105c75:	83 c0 01             	add    $0x1,%eax
80105c78:	3d 00 01 00 00       	cmp    $0x100,%eax
80105c7d:	75 d1                	jne    80105c50 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105c7f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c82:	a1 08 c1 10 80       	mov    0x8010c108,%eax
80105c87:	c7 05 c2 b0 11 80 08 	movl   $0xef000008,0x8011b0c2
80105c8e:	00 00 ef 
  initlock(&tickslock, "time");
80105c91:	68 ad 8b 10 80       	push   $0x80108bad
80105c96:	68 80 ae 11 80       	push   $0x8011ae80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c9b:	66 a3 c0 b0 11 80    	mov    %ax,0x8011b0c0
80105ca1:	c1 e8 10             	shr    $0x10,%eax
80105ca4:	66 a3 c6 b0 11 80    	mov    %ax,0x8011b0c6
  initlock(&tickslock, "time");
80105caa:	e8 c1 e9 ff ff       	call   80104670 <initlock>
}
80105caf:	83 c4 10             	add    $0x10,%esp
80105cb2:	c9                   	leave  
80105cb3:	c3                   	ret    
80105cb4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105cbf:	90                   	nop

80105cc0 <idtinit>:

void
idtinit(void)
{
80105cc0:	55                   	push   %ebp
  pd[0] = size-1;
80105cc1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105cc6:	89 e5                	mov    %esp,%ebp
80105cc8:	83 ec 10             	sub    $0x10,%esp
80105ccb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105ccf:	b8 c0 ae 11 80       	mov    $0x8011aec0,%eax
80105cd4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105cd8:	c1 e8 10             	shr    $0x10,%eax
80105cdb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105cdf:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105ce2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105ce5:	c9                   	leave  
80105ce6:	c3                   	ret    
80105ce7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cee:	66 90                	xchg   %ax,%ax

80105cf0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105cf0:	55                   	push   %ebp
80105cf1:	89 e5                	mov    %esp,%ebp
80105cf3:	57                   	push   %edi
80105cf4:	56                   	push   %esi
80105cf5:	53                   	push   %ebx
80105cf6:	83 ec 1c             	sub    $0x1c,%esp
80105cf9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(tf->trapno == T_SYSCALL){
80105cfc:	8b 46 30             	mov    0x30(%esi),%eax
80105cff:	83 f8 40             	cmp    $0x40,%eax
80105d02:	0f 84 38 01 00 00    	je     80105e40 <trap+0x150>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105d08:	83 e8 0e             	sub    $0xe,%eax
80105d0b:	83 f8 31             	cmp    $0x31,%eax
80105d0e:	0f 87 8c 00 00 00    	ja     80105da0 <trap+0xb0>
80105d14:	ff 24 85 ac 8c 10 80 	jmp    *-0x7fef7354(,%eax,4)
80105d1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d1f:	90                   	nop
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105d20:	e8 8b dc ff ff       	call   801039b0 <cpuid>
80105d25:	85 c0                	test   %eax,%eax
80105d27:	0f 84 03 03 00 00    	je     80106030 <trap+0x340>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105d2d:	e8 de cb ff ff       	call   80102910 <lapiceoi>


  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d32:	e8 99 dc ff ff       	call   801039d0 <myproc>
80105d37:	85 c0                	test   %eax,%eax
80105d39:	74 1d                	je     80105d58 <trap+0x68>
80105d3b:	e8 90 dc ff ff       	call   801039d0 <myproc>
80105d40:	8b 50 24             	mov    0x24(%eax),%edx
80105d43:	85 d2                	test   %edx,%edx
80105d45:	74 11                	je     80105d58 <trap+0x68>
80105d47:	0f b7 46 3c          	movzwl 0x3c(%esi),%eax
80105d4b:	83 e0 03             	and    $0x3,%eax
80105d4e:	66 83 f8 03          	cmp    $0x3,%ax
80105d52:	0f 84 b8 02 00 00    	je     80106010 <trap+0x320>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105d58:	e8 73 dc ff ff       	call   801039d0 <myproc>
80105d5d:	85 c0                	test   %eax,%eax
80105d5f:	74 0f                	je     80105d70 <trap+0x80>
80105d61:	e8 6a dc ff ff       	call   801039d0 <myproc>
80105d66:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105d6a:	0f 84 b8 00 00 00    	je     80105e28 <trap+0x138>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d70:	e8 5b dc ff ff       	call   801039d0 <myproc>
80105d75:	85 c0                	test   %eax,%eax
80105d77:	74 1d                	je     80105d96 <trap+0xa6>
80105d79:	e8 52 dc ff ff       	call   801039d0 <myproc>
80105d7e:	8b 40 24             	mov    0x24(%eax),%eax
80105d81:	85 c0                	test   %eax,%eax
80105d83:	74 11                	je     80105d96 <trap+0xa6>
80105d85:	0f b7 46 3c          	movzwl 0x3c(%esi),%eax
80105d89:	83 e0 03             	and    $0x3,%eax
80105d8c:	66 83 f8 03          	cmp    $0x3,%ax
80105d90:	0f 84 d7 00 00 00    	je     80105e6d <trap+0x17d>
    exit();
}
80105d96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d99:	5b                   	pop    %ebx
80105d9a:	5e                   	pop    %esi
80105d9b:	5f                   	pop    %edi
80105d9c:	5d                   	pop    %ebp
80105d9d:	c3                   	ret    
80105d9e:	66 90                	xchg   %ax,%ax
    if(myproc() == 0 || (tf->cs&3) == 0){
80105da0:	e8 2b dc ff ff       	call   801039d0 <myproc>
80105da5:	85 c0                	test   %eax,%eax
80105da7:	0f 84 4c 03 00 00    	je     801060f9 <trap+0x409>
80105dad:	f6 46 3c 03          	testb  $0x3,0x3c(%esi)
80105db1:	0f 84 42 03 00 00    	je     801060f9 <trap+0x409>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105db7:	0f 20 d1             	mov    %cr2,%ecx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105dba:	8b 56 38             	mov    0x38(%esi),%edx
80105dbd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105dc0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105dc3:	e8 e8 db ff ff       	call   801039b0 <cpuid>
80105dc8:	8b 5e 30             	mov    0x30(%esi),%ebx
80105dcb:	89 c7                	mov    %eax,%edi
80105dcd:	8b 46 34             	mov    0x34(%esi),%eax
80105dd0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105dd3:	e8 f8 db ff ff       	call   801039d0 <myproc>
80105dd8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105ddb:	e8 f0 db ff ff       	call   801039d0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105de0:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105de3:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105de6:	51                   	push   %ecx
80105de7:	52                   	push   %edx
80105de8:	57                   	push   %edi
80105de9:	ff 75 e4             	push   -0x1c(%ebp)
80105dec:	53                   	push   %ebx
            myproc()->pid, myproc()->name, tf->trapno,
80105ded:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80105df0:	83 c3 6c             	add    $0x6c,%ebx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105df3:	53                   	push   %ebx
80105df4:	ff 70 10             	push   0x10(%eax)
80105df7:	68 68 8c 10 80       	push   $0x80108c68
80105dfc:	e8 9f a8 ff ff       	call   801006a0 <cprintf>
    myproc()->killed = 1;
80105e01:	83 c4 20             	add    $0x20,%esp
80105e04:	e8 c7 db ff ff       	call   801039d0 <myproc>
80105e09:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e10:	e8 bb db ff ff       	call   801039d0 <myproc>
80105e15:	85 c0                	test   %eax,%eax
80105e17:	0f 85 1e ff ff ff    	jne    80105d3b <trap+0x4b>
80105e1d:	e9 36 ff ff ff       	jmp    80105d58 <trap+0x68>
80105e22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105e28:	83 7e 30 20          	cmpl   $0x20,0x30(%esi)
80105e2c:	0f 85 3e ff ff ff    	jne    80105d70 <trap+0x80>
    yield();
80105e32:	e8 59 e4 ff ff       	call   80104290 <yield>
80105e37:	e9 34 ff ff ff       	jmp    80105d70 <trap+0x80>
80105e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105e40:	e8 8b db ff ff       	call   801039d0 <myproc>
80105e45:	8b 40 24             	mov    0x24(%eax),%eax
80105e48:	85 c0                	test   %eax,%eax
80105e4a:	0f 85 d0 01 00 00    	jne    80106020 <trap+0x330>
    myproc()->tf = tf;
80105e50:	e8 7b db ff ff       	call   801039d0 <myproc>
80105e55:	89 70 18             	mov    %esi,0x18(%eax)
    syscall();
80105e58:	e8 a3 ee ff ff       	call   80104d00 <syscall>
    if(myproc()->killed)
80105e5d:	e8 6e db ff ff       	call   801039d0 <myproc>
80105e62:	8b 40 24             	mov    0x24(%eax),%eax
80105e65:	85 c0                	test   %eax,%eax
80105e67:	0f 84 29 ff ff ff    	je     80105d96 <trap+0xa6>
}
80105e6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e70:	5b                   	pop    %ebx
80105e71:	5e                   	pop    %esi
80105e72:	5f                   	pop    %edi
80105e73:	5d                   	pop    %ebp
      exit();
80105e74:	e9 b7 e1 ff ff       	jmp    80104030 <exit>
80105e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105e80:	8b 7e 38             	mov    0x38(%esi),%edi
80105e83:	0f b7 5e 3c          	movzwl 0x3c(%esi),%ebx
80105e87:	e8 24 db ff ff       	call   801039b0 <cpuid>
80105e8c:	57                   	push   %edi
80105e8d:	53                   	push   %ebx
80105e8e:	50                   	push   %eax
80105e8f:	68 10 8c 10 80       	push   $0x80108c10
80105e94:	e8 07 a8 ff ff       	call   801006a0 <cprintf>
    lapiceoi();
80105e99:	e8 72 ca ff ff       	call   80102910 <lapiceoi>
    break;
80105e9e:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ea1:	e8 2a db ff ff       	call   801039d0 <myproc>
80105ea6:	85 c0                	test   %eax,%eax
80105ea8:	0f 85 8d fe ff ff    	jne    80105d3b <trap+0x4b>
80105eae:	e9 a5 fe ff ff       	jmp    80105d58 <trap+0x68>
80105eb3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105eb7:	90                   	nop
    kbdintr();
80105eb8:	e8 13 c9 ff ff       	call   801027d0 <kbdintr>
    lapiceoi();
80105ebd:	e8 4e ca ff ff       	call   80102910 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ec2:	e8 09 db ff ff       	call   801039d0 <myproc>
80105ec7:	85 c0                	test   %eax,%eax
80105ec9:	0f 85 6c fe ff ff    	jne    80105d3b <trap+0x4b>
80105ecf:	e9 84 fe ff ff       	jmp    80105d58 <trap+0x68>
80105ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105ed8:	e8 c3 03 00 00       	call   801062a0 <uartintr>
    lapiceoi();
80105edd:	e8 2e ca ff ff       	call   80102910 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ee2:	e8 e9 da ff ff       	call   801039d0 <myproc>
80105ee7:	85 c0                	test   %eax,%eax
80105ee9:	0f 85 4c fe ff ff    	jne    80105d3b <trap+0x4b>
80105eef:	e9 64 fe ff ff       	jmp    80105d58 <trap+0x68>
80105ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105ef8:	e8 43 c3 ff ff       	call   80102240 <ideintr>
80105efd:	e9 2b fe ff ff       	jmp    80105d2d <trap+0x3d>
80105f02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    struct proc* p = myproc();
80105f08:	e8 c3 da ff ff       	call   801039d0 <myproc>
    if(p->pgdir==0) {
80105f0d:	8b 78 04             	mov    0x4(%eax),%edi
    struct proc* p = myproc();
80105f10:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(p->pgdir==0) {
80105f13:	85 ff                	test   %edi,%edi
80105f15:	0f 84 4d 01 00 00    	je     80106068 <trap+0x378>
80105f1b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    for(int i = 0; i < 16; ++i) {
80105f1e:	31 d2                	xor    %edx,%edx
    int success = 0;
80105f20:	89 75 dc             	mov    %esi,-0x24(%ebp)
80105f23:	31 ff                	xor    %edi,%edi
80105f25:	89 d6                	mov    %edx,%esi
80105f27:	8d 58 7c             	lea    0x7c(%eax),%ebx
80105f2a:	eb 13                	jmp    80105f3f <trap+0x24f>
80105f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(int i = 0; i < 16; ++i) {
80105f30:	83 c6 01             	add    $0x1,%esi
80105f33:	83 c3 14             	add    $0x14,%ebx
80105f36:	83 fe 10             	cmp    $0x10,%esi
80105f39:	0f 84 89 00 00 00    	je     80105fc8 <trap+0x2d8>
80105f3f:	0f 20 d1             	mov    %cr2,%ecx
      if (rcr2()>=p->addr[i].va && rcr2() < p->addr[i].va+p->addr[i].size) {
80105f42:	8b 03                	mov    (%ebx),%eax
80105f44:	39 c8                	cmp    %ecx,%eax
80105f46:	77 e8                	ja     80105f30 <trap+0x240>
80105f48:	0f 20 d1             	mov    %cr2,%ecx
80105f4b:	03 43 04             	add    0x4(%ebx),%eax
80105f4e:	39 c8                	cmp    %ecx,%eax
80105f50:	76 de                	jbe    80105f30 <trap+0x240>
80105f52:	0f 20 d7             	mov    %cr2,%edi
        mem = kalloc();
80105f55:	e8 26 c7 ff ff       	call   80102680 <kalloc>
        temp_length = PGROUNDDOWN(rcr2());
80105f5a:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
        mem = kalloc();
80105f60:	89 c1                	mov    %eax,%ecx
        if(mem == 0){
80105f62:	85 c0                	test   %eax,%eax
80105f64:	0f 84 1f 01 00 00    	je     80106089 <trap+0x399>
        mappages(p->pgdir, (void*)temp_length, PAGE_SIZE, V2P(mem), PTE_W | PTE_U);
80105f6a:	83 ec 0c             	sub    $0xc,%esp
80105f6d:	8d 80 00 00 00 80    	lea    -0x80000000(%eax),%eax
80105f73:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80105f76:	6a 06                	push   $0x6
80105f78:	50                   	push   %eax
80105f79:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f7c:	68 00 10 00 00       	push   $0x1000
80105f81:	57                   	push   %edi
80105f82:	ff 70 04             	push   0x4(%eax)
80105f85:	e8 76 0f 00 00       	call   80106f00 <mappages>
        memset(mem, 0, PGSIZE);
80105f8a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80105f8d:	83 c4 1c             	add    $0x1c,%esp
        p->addr[i].phys_page_used += 1;
80105f90:	83 43 10 01          	addl   $0x1,0x10(%ebx)
        memset(mem, 0, PGSIZE);
80105f94:	68 00 10 00 00       	push   $0x1000
80105f99:	6a 00                	push   $0x0
80105f9b:	51                   	push   %ecx
80105f9c:	e8 5f e9 ff ff       	call   80104900 <memset>
        if(p->addr[i].flags & MAP_ANONYMOUS){
80105fa1:	83 c4 10             	add    $0x10,%esp
80105fa4:	f6 43 08 04          	testb  $0x4,0x8(%ebx)
80105fa8:	0f 85 e8 00 00 00    	jne    80106096 <trap+0x3a6>
        else if(p->addr[i].fd){
80105fae:	8b 43 0c             	mov    0xc(%ebx),%eax
80105fb1:	85 c0                	test   %eax,%eax
80105fb3:	0f 85 e5 00 00 00    	jne    8010609e <trap+0x3ae>
        success = 1;
80105fb9:	bf 01 00 00 00       	mov    $0x1,%edi
80105fbe:	e9 6d ff ff ff       	jmp    80105f30 <trap+0x240>
80105fc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105fc7:	90                   	nop
    if (!success) {
80105fc8:	8b 75 dc             	mov    -0x24(%ebp),%esi
80105fcb:	85 ff                	test   %edi,%edi
80105fcd:	0f 85 5f fd ff ff    	jne    80105d32 <trap+0x42>
80105fd3:	0f 20 d0             	mov    %cr2,%eax
      cprintf("addr %x, pid %d, killed: %d\n", rcr2(), p->pid, p->killed);
80105fd6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80105fd9:	ff 77 24             	push   0x24(%edi)
80105fdc:	ff 77 10             	push   0x10(%edi)
80105fdf:	50                   	push   %eax
80105fe0:	68 d9 8b 10 80       	push   $0x80108bd9
80105fe5:	e8 b6 a6 ff ff       	call   801006a0 <cprintf>
      cprintf("Segmentation Fault\n");
80105fea:	c7 04 24 f6 8b 10 80 	movl   $0x80108bf6,(%esp)
80105ff1:	e8 aa a6 ff ff       	call   801006a0 <cprintf>
      kill(p->pid);
80105ff6:	59                   	pop    %ecx
80105ff7:	ff 77 10             	push   0x10(%edi)
80105ffa:	e8 01 e4 ff ff       	call   80104400 <kill>
80105fff:	83 c4 10             	add    $0x10,%esp
80106002:	e9 2b fd ff ff       	jmp    80105d32 <trap+0x42>
80106007:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010600e:	66 90                	xchg   %ax,%ax
    exit();
80106010:	e8 1b e0 ff ff       	call   80104030 <exit>
80106015:	e9 3e fd ff ff       	jmp    80105d58 <trap+0x68>
8010601a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106020:	e8 0b e0 ff ff       	call   80104030 <exit>
80106025:	e9 26 fe ff ff       	jmp    80105e50 <trap+0x160>
8010602a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80106030:	83 ec 0c             	sub    $0xc,%esp
80106033:	68 80 ae 11 80       	push   $0x8011ae80
80106038:	e8 03 e8 ff ff       	call   80104840 <acquire>
      wakeup(&ticks);
8010603d:	c7 04 24 60 ae 11 80 	movl   $0x8011ae60,(%esp)
      ticks++;
80106044:	83 05 60 ae 11 80 01 	addl   $0x1,0x8011ae60
      wakeup(&ticks);
8010604b:	e8 50 e3 ff ff       	call   801043a0 <wakeup>
      release(&tickslock);
80106050:	c7 04 24 80 ae 11 80 	movl   $0x8011ae80,(%esp)
80106057:	e8 84 e7 ff ff       	call   801047e0 <release>
8010605c:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010605f:	e9 c9 fc ff ff       	jmp    80105d2d <trap+0x3d>
80106064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("Invalid page directory\n");
80106068:	83 ec 0c             	sub    $0xc,%esp
8010606b:	68 b2 8b 10 80       	push   $0x80108bb2
          cprintf("kalloc failed\n");
80106070:	e8 2b a6 ff ff       	call   801006a0 <cprintf>
          kill(p->pid);
80106075:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106078:	5b                   	pop    %ebx
80106079:	ff 70 10             	push   0x10(%eax)
8010607c:	e8 7f e3 ff ff       	call   80104400 <kill>
80106081:	83 c4 10             	add    $0x10,%esp
80106084:	e9 a9 fc ff ff       	jmp    80105d32 <trap+0x42>
          cprintf("kalloc failed\n");
80106089:	83 ec 0c             	sub    $0xc,%esp
8010608c:	8b 75 dc             	mov    -0x24(%ebp),%esi
8010608f:	68 ca 8b 10 80       	push   $0x80108bca
80106094:	eb da                	jmp    80106070 <trap+0x380>
80106096:	8b 75 dc             	mov    -0x24(%ebp),%esi
80106099:	e9 94 fc ff ff       	jmp    80105d32 <trap+0x42>
          struct file *f = p->ofile[p->addr[i].fd];
8010609e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801060a1:	89 f2                	mov    %esi,%edx
801060a3:	8b 75 dc             	mov    -0x24(%ebp),%esi
801060a6:	8b 5c 81 28          	mov    0x28(%ecx,%eax,4),%ebx
          f->off = temp_length - p->addr[i].va;
801060aa:	8d 04 92             	lea    (%edx,%edx,4),%eax
801060ad:	89 fa                	mov    %edi,%edx
801060af:	2b 54 81 7c          	sub    0x7c(%ecx,%eax,4),%edx
            if(f->type == FD_INODE){
801060b3:	83 3b 02             	cmpl   $0x2,(%ebx)
          f->off = temp_length - p->addr[i].va;
801060b6:	89 53 14             	mov    %edx,0x14(%ebx)
            if(f->type == FD_INODE){
801060b9:	0f 85 73 fc ff ff    	jne    80105d32 <trap+0x42>
              ilock(f->ip);
801060bf:	83 ec 0c             	sub    $0xc,%esp
801060c2:	ff 73 10             	push   0x10(%ebx)
801060c5:	e8 b6 b6 ff ff       	call   80101780 <ilock>
              if((r = readi(f->ip, (void*)temp_length, f->off, PAGE_SIZE)) > 0)
801060ca:	68 00 10 00 00       	push   $0x1000
801060cf:	ff 73 14             	push   0x14(%ebx)
801060d2:	57                   	push   %edi
801060d3:	ff 73 10             	push   0x10(%ebx)
801060d6:	e8 b5 b9 ff ff       	call   80101a90 <readi>
801060db:	83 c4 20             	add    $0x20,%esp
801060de:	85 c0                	test   %eax,%eax
801060e0:	0f 8e 4c fc ff ff    	jle    80105d32 <trap+0x42>
              iunlock(f->ip);
801060e6:	83 ec 0c             	sub    $0xc,%esp
801060e9:	ff 73 10             	push   0x10(%ebx)
801060ec:	e8 6f b7 ff ff       	call   80101860 <iunlock>
801060f1:	83 c4 10             	add    $0x10,%esp
801060f4:	e9 39 fc ff ff       	jmp    80105d32 <trap+0x42>
801060f9:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801060fc:	8b 5e 38             	mov    0x38(%esi),%ebx
801060ff:	e8 ac d8 ff ff       	call   801039b0 <cpuid>
80106104:	83 ec 0c             	sub    $0xc,%esp
80106107:	57                   	push   %edi
80106108:	53                   	push   %ebx
80106109:	50                   	push   %eax
8010610a:	ff 76 30             	push   0x30(%esi)
8010610d:	68 34 8c 10 80       	push   $0x80108c34
80106112:	e8 89 a5 ff ff       	call   801006a0 <cprintf>
      panic("trap");
80106117:	83 c4 14             	add    $0x14,%esp
8010611a:	68 0a 8c 10 80       	push   $0x80108c0a
8010611f:	e8 5c a2 ff ff       	call   80100380 <panic>
80106124:	66 90                	xchg   %ax,%ax
80106126:	66 90                	xchg   %ax,%ax
80106128:	66 90                	xchg   %ax,%ax
8010612a:	66 90                	xchg   %ax,%ax
8010612c:	66 90                	xchg   %ax,%ax
8010612e:	66 90                	xchg   %ax,%ax

80106130 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106130:	a1 c0 b6 11 80       	mov    0x8011b6c0,%eax
80106135:	85 c0                	test   %eax,%eax
80106137:	74 17                	je     80106150 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106139:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010613e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010613f:	a8 01                	test   $0x1,%al
80106141:	74 0d                	je     80106150 <uartgetc+0x20>
80106143:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106148:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106149:	0f b6 c0             	movzbl %al,%eax
8010614c:	c3                   	ret    
8010614d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106150:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106155:	c3                   	ret    
80106156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010615d:	8d 76 00             	lea    0x0(%esi),%esi

80106160 <uartinit>:
{
80106160:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106161:	31 c9                	xor    %ecx,%ecx
80106163:	89 c8                	mov    %ecx,%eax
80106165:	89 e5                	mov    %esp,%ebp
80106167:	57                   	push   %edi
80106168:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010616d:	56                   	push   %esi
8010616e:	89 fa                	mov    %edi,%edx
80106170:	53                   	push   %ebx
80106171:	83 ec 1c             	sub    $0x1c,%esp
80106174:	ee                   	out    %al,(%dx)
80106175:	be fb 03 00 00       	mov    $0x3fb,%esi
8010617a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010617f:	89 f2                	mov    %esi,%edx
80106181:	ee                   	out    %al,(%dx)
80106182:	b8 0c 00 00 00       	mov    $0xc,%eax
80106187:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010618c:	ee                   	out    %al,(%dx)
8010618d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106192:	89 c8                	mov    %ecx,%eax
80106194:	89 da                	mov    %ebx,%edx
80106196:	ee                   	out    %al,(%dx)
80106197:	b8 03 00 00 00       	mov    $0x3,%eax
8010619c:	89 f2                	mov    %esi,%edx
8010619e:	ee                   	out    %al,(%dx)
8010619f:	ba fc 03 00 00       	mov    $0x3fc,%edx
801061a4:	89 c8                	mov    %ecx,%eax
801061a6:	ee                   	out    %al,(%dx)
801061a7:	b8 01 00 00 00       	mov    $0x1,%eax
801061ac:	89 da                	mov    %ebx,%edx
801061ae:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801061af:	ba fd 03 00 00       	mov    $0x3fd,%edx
801061b4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801061b5:	3c ff                	cmp    $0xff,%al
801061b7:	74 78                	je     80106231 <uartinit+0xd1>
  uart = 1;
801061b9:	c7 05 c0 b6 11 80 01 	movl   $0x1,0x8011b6c0
801061c0:	00 00 00 
801061c3:	89 fa                	mov    %edi,%edx
801061c5:	ec                   	in     (%dx),%al
801061c6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801061cb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801061cc:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801061cf:	bf 74 8d 10 80       	mov    $0x80108d74,%edi
801061d4:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
801061d9:	6a 00                	push   $0x0
801061db:	6a 04                	push   $0x4
801061dd:	e8 9e c2 ff ff       	call   80102480 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
801061e2:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
801061e6:	83 c4 10             	add    $0x10,%esp
801061e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
801061f0:	a1 c0 b6 11 80       	mov    0x8011b6c0,%eax
801061f5:	bb 80 00 00 00       	mov    $0x80,%ebx
801061fa:	85 c0                	test   %eax,%eax
801061fc:	75 14                	jne    80106212 <uartinit+0xb2>
801061fe:	eb 23                	jmp    80106223 <uartinit+0xc3>
    microdelay(10);
80106200:	83 ec 0c             	sub    $0xc,%esp
80106203:	6a 0a                	push   $0xa
80106205:	e8 26 c7 ff ff       	call   80102930 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010620a:	83 c4 10             	add    $0x10,%esp
8010620d:	83 eb 01             	sub    $0x1,%ebx
80106210:	74 07                	je     80106219 <uartinit+0xb9>
80106212:	89 f2                	mov    %esi,%edx
80106214:	ec                   	in     (%dx),%al
80106215:	a8 20                	test   $0x20,%al
80106217:	74 e7                	je     80106200 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106219:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010621d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106222:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106223:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106227:	83 c7 01             	add    $0x1,%edi
8010622a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010622d:	84 c0                	test   %al,%al
8010622f:	75 bf                	jne    801061f0 <uartinit+0x90>
}
80106231:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106234:	5b                   	pop    %ebx
80106235:	5e                   	pop    %esi
80106236:	5f                   	pop    %edi
80106237:	5d                   	pop    %ebp
80106238:	c3                   	ret    
80106239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106240 <uartputc>:
  if(!uart)
80106240:	a1 c0 b6 11 80       	mov    0x8011b6c0,%eax
80106245:	85 c0                	test   %eax,%eax
80106247:	74 47                	je     80106290 <uartputc+0x50>
{
80106249:	55                   	push   %ebp
8010624a:	89 e5                	mov    %esp,%ebp
8010624c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010624d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106252:	53                   	push   %ebx
80106253:	bb 80 00 00 00       	mov    $0x80,%ebx
80106258:	eb 18                	jmp    80106272 <uartputc+0x32>
8010625a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80106260:	83 ec 0c             	sub    $0xc,%esp
80106263:	6a 0a                	push   $0xa
80106265:	e8 c6 c6 ff ff       	call   80102930 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010626a:	83 c4 10             	add    $0x10,%esp
8010626d:	83 eb 01             	sub    $0x1,%ebx
80106270:	74 07                	je     80106279 <uartputc+0x39>
80106272:	89 f2                	mov    %esi,%edx
80106274:	ec                   	in     (%dx),%al
80106275:	a8 20                	test   $0x20,%al
80106277:	74 e7                	je     80106260 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106279:	8b 45 08             	mov    0x8(%ebp),%eax
8010627c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106281:	ee                   	out    %al,(%dx)
}
80106282:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106285:	5b                   	pop    %ebx
80106286:	5e                   	pop    %esi
80106287:	5d                   	pop    %ebp
80106288:	c3                   	ret    
80106289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106290:	c3                   	ret    
80106291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106298:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010629f:	90                   	nop

801062a0 <uartintr>:

void
uartintr(void)
{
801062a0:	55                   	push   %ebp
801062a1:	89 e5                	mov    %esp,%ebp
801062a3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801062a6:	68 30 61 10 80       	push   $0x80106130
801062ab:	e8 d0 a5 ff ff       	call   80100880 <consoleintr>
}
801062b0:	83 c4 10             	add    $0x10,%esp
801062b3:	c9                   	leave  
801062b4:	c3                   	ret    

801062b5 <vector0>:
801062b5:	6a 00                	push   $0x0
801062b7:	6a 00                	push   $0x0
801062b9:	e9 5c f9 ff ff       	jmp    80105c1a <alltraps>

801062be <vector1>:
801062be:	6a 00                	push   $0x0
801062c0:	6a 01                	push   $0x1
801062c2:	e9 53 f9 ff ff       	jmp    80105c1a <alltraps>

801062c7 <vector2>:
801062c7:	6a 00                	push   $0x0
801062c9:	6a 02                	push   $0x2
801062cb:	e9 4a f9 ff ff       	jmp    80105c1a <alltraps>

801062d0 <vector3>:
801062d0:	6a 00                	push   $0x0
801062d2:	6a 03                	push   $0x3
801062d4:	e9 41 f9 ff ff       	jmp    80105c1a <alltraps>

801062d9 <vector4>:
801062d9:	6a 00                	push   $0x0
801062db:	6a 04                	push   $0x4
801062dd:	e9 38 f9 ff ff       	jmp    80105c1a <alltraps>

801062e2 <vector5>:
801062e2:	6a 00                	push   $0x0
801062e4:	6a 05                	push   $0x5
801062e6:	e9 2f f9 ff ff       	jmp    80105c1a <alltraps>

801062eb <vector6>:
801062eb:	6a 00                	push   $0x0
801062ed:	6a 06                	push   $0x6
801062ef:	e9 26 f9 ff ff       	jmp    80105c1a <alltraps>

801062f4 <vector7>:
801062f4:	6a 00                	push   $0x0
801062f6:	6a 07                	push   $0x7
801062f8:	e9 1d f9 ff ff       	jmp    80105c1a <alltraps>

801062fd <vector8>:
801062fd:	6a 08                	push   $0x8
801062ff:	e9 16 f9 ff ff       	jmp    80105c1a <alltraps>

80106304 <vector9>:
80106304:	6a 00                	push   $0x0
80106306:	6a 09                	push   $0x9
80106308:	e9 0d f9 ff ff       	jmp    80105c1a <alltraps>

8010630d <vector10>:
8010630d:	6a 0a                	push   $0xa
8010630f:	e9 06 f9 ff ff       	jmp    80105c1a <alltraps>

80106314 <vector11>:
80106314:	6a 0b                	push   $0xb
80106316:	e9 ff f8 ff ff       	jmp    80105c1a <alltraps>

8010631b <vector12>:
8010631b:	6a 0c                	push   $0xc
8010631d:	e9 f8 f8 ff ff       	jmp    80105c1a <alltraps>

80106322 <vector13>:
80106322:	6a 0d                	push   $0xd
80106324:	e9 f1 f8 ff ff       	jmp    80105c1a <alltraps>

80106329 <vector14>:
80106329:	6a 0e                	push   $0xe
8010632b:	e9 ea f8 ff ff       	jmp    80105c1a <alltraps>

80106330 <vector15>:
80106330:	6a 00                	push   $0x0
80106332:	6a 0f                	push   $0xf
80106334:	e9 e1 f8 ff ff       	jmp    80105c1a <alltraps>

80106339 <vector16>:
80106339:	6a 00                	push   $0x0
8010633b:	6a 10                	push   $0x10
8010633d:	e9 d8 f8 ff ff       	jmp    80105c1a <alltraps>

80106342 <vector17>:
80106342:	6a 11                	push   $0x11
80106344:	e9 d1 f8 ff ff       	jmp    80105c1a <alltraps>

80106349 <vector18>:
80106349:	6a 00                	push   $0x0
8010634b:	6a 12                	push   $0x12
8010634d:	e9 c8 f8 ff ff       	jmp    80105c1a <alltraps>

80106352 <vector19>:
80106352:	6a 00                	push   $0x0
80106354:	6a 13                	push   $0x13
80106356:	e9 bf f8 ff ff       	jmp    80105c1a <alltraps>

8010635b <vector20>:
8010635b:	6a 00                	push   $0x0
8010635d:	6a 14                	push   $0x14
8010635f:	e9 b6 f8 ff ff       	jmp    80105c1a <alltraps>

80106364 <vector21>:
80106364:	6a 00                	push   $0x0
80106366:	6a 15                	push   $0x15
80106368:	e9 ad f8 ff ff       	jmp    80105c1a <alltraps>

8010636d <vector22>:
8010636d:	6a 00                	push   $0x0
8010636f:	6a 16                	push   $0x16
80106371:	e9 a4 f8 ff ff       	jmp    80105c1a <alltraps>

80106376 <vector23>:
80106376:	6a 00                	push   $0x0
80106378:	6a 17                	push   $0x17
8010637a:	e9 9b f8 ff ff       	jmp    80105c1a <alltraps>

8010637f <vector24>:
8010637f:	6a 00                	push   $0x0
80106381:	6a 18                	push   $0x18
80106383:	e9 92 f8 ff ff       	jmp    80105c1a <alltraps>

80106388 <vector25>:
80106388:	6a 00                	push   $0x0
8010638a:	6a 19                	push   $0x19
8010638c:	e9 89 f8 ff ff       	jmp    80105c1a <alltraps>

80106391 <vector26>:
80106391:	6a 00                	push   $0x0
80106393:	6a 1a                	push   $0x1a
80106395:	e9 80 f8 ff ff       	jmp    80105c1a <alltraps>

8010639a <vector27>:
8010639a:	6a 00                	push   $0x0
8010639c:	6a 1b                	push   $0x1b
8010639e:	e9 77 f8 ff ff       	jmp    80105c1a <alltraps>

801063a3 <vector28>:
801063a3:	6a 00                	push   $0x0
801063a5:	6a 1c                	push   $0x1c
801063a7:	e9 6e f8 ff ff       	jmp    80105c1a <alltraps>

801063ac <vector29>:
801063ac:	6a 00                	push   $0x0
801063ae:	6a 1d                	push   $0x1d
801063b0:	e9 65 f8 ff ff       	jmp    80105c1a <alltraps>

801063b5 <vector30>:
801063b5:	6a 00                	push   $0x0
801063b7:	6a 1e                	push   $0x1e
801063b9:	e9 5c f8 ff ff       	jmp    80105c1a <alltraps>

801063be <vector31>:
801063be:	6a 00                	push   $0x0
801063c0:	6a 1f                	push   $0x1f
801063c2:	e9 53 f8 ff ff       	jmp    80105c1a <alltraps>

801063c7 <vector32>:
801063c7:	6a 00                	push   $0x0
801063c9:	6a 20                	push   $0x20
801063cb:	e9 4a f8 ff ff       	jmp    80105c1a <alltraps>

801063d0 <vector33>:
801063d0:	6a 00                	push   $0x0
801063d2:	6a 21                	push   $0x21
801063d4:	e9 41 f8 ff ff       	jmp    80105c1a <alltraps>

801063d9 <vector34>:
801063d9:	6a 00                	push   $0x0
801063db:	6a 22                	push   $0x22
801063dd:	e9 38 f8 ff ff       	jmp    80105c1a <alltraps>

801063e2 <vector35>:
801063e2:	6a 00                	push   $0x0
801063e4:	6a 23                	push   $0x23
801063e6:	e9 2f f8 ff ff       	jmp    80105c1a <alltraps>

801063eb <vector36>:
801063eb:	6a 00                	push   $0x0
801063ed:	6a 24                	push   $0x24
801063ef:	e9 26 f8 ff ff       	jmp    80105c1a <alltraps>

801063f4 <vector37>:
801063f4:	6a 00                	push   $0x0
801063f6:	6a 25                	push   $0x25
801063f8:	e9 1d f8 ff ff       	jmp    80105c1a <alltraps>

801063fd <vector38>:
801063fd:	6a 00                	push   $0x0
801063ff:	6a 26                	push   $0x26
80106401:	e9 14 f8 ff ff       	jmp    80105c1a <alltraps>

80106406 <vector39>:
80106406:	6a 00                	push   $0x0
80106408:	6a 27                	push   $0x27
8010640a:	e9 0b f8 ff ff       	jmp    80105c1a <alltraps>

8010640f <vector40>:
8010640f:	6a 00                	push   $0x0
80106411:	6a 28                	push   $0x28
80106413:	e9 02 f8 ff ff       	jmp    80105c1a <alltraps>

80106418 <vector41>:
80106418:	6a 00                	push   $0x0
8010641a:	6a 29                	push   $0x29
8010641c:	e9 f9 f7 ff ff       	jmp    80105c1a <alltraps>

80106421 <vector42>:
80106421:	6a 00                	push   $0x0
80106423:	6a 2a                	push   $0x2a
80106425:	e9 f0 f7 ff ff       	jmp    80105c1a <alltraps>

8010642a <vector43>:
8010642a:	6a 00                	push   $0x0
8010642c:	6a 2b                	push   $0x2b
8010642e:	e9 e7 f7 ff ff       	jmp    80105c1a <alltraps>

80106433 <vector44>:
80106433:	6a 00                	push   $0x0
80106435:	6a 2c                	push   $0x2c
80106437:	e9 de f7 ff ff       	jmp    80105c1a <alltraps>

8010643c <vector45>:
8010643c:	6a 00                	push   $0x0
8010643e:	6a 2d                	push   $0x2d
80106440:	e9 d5 f7 ff ff       	jmp    80105c1a <alltraps>

80106445 <vector46>:
80106445:	6a 00                	push   $0x0
80106447:	6a 2e                	push   $0x2e
80106449:	e9 cc f7 ff ff       	jmp    80105c1a <alltraps>

8010644e <vector47>:
8010644e:	6a 00                	push   $0x0
80106450:	6a 2f                	push   $0x2f
80106452:	e9 c3 f7 ff ff       	jmp    80105c1a <alltraps>

80106457 <vector48>:
80106457:	6a 00                	push   $0x0
80106459:	6a 30                	push   $0x30
8010645b:	e9 ba f7 ff ff       	jmp    80105c1a <alltraps>

80106460 <vector49>:
80106460:	6a 00                	push   $0x0
80106462:	6a 31                	push   $0x31
80106464:	e9 b1 f7 ff ff       	jmp    80105c1a <alltraps>

80106469 <vector50>:
80106469:	6a 00                	push   $0x0
8010646b:	6a 32                	push   $0x32
8010646d:	e9 a8 f7 ff ff       	jmp    80105c1a <alltraps>

80106472 <vector51>:
80106472:	6a 00                	push   $0x0
80106474:	6a 33                	push   $0x33
80106476:	e9 9f f7 ff ff       	jmp    80105c1a <alltraps>

8010647b <vector52>:
8010647b:	6a 00                	push   $0x0
8010647d:	6a 34                	push   $0x34
8010647f:	e9 96 f7 ff ff       	jmp    80105c1a <alltraps>

80106484 <vector53>:
80106484:	6a 00                	push   $0x0
80106486:	6a 35                	push   $0x35
80106488:	e9 8d f7 ff ff       	jmp    80105c1a <alltraps>

8010648d <vector54>:
8010648d:	6a 00                	push   $0x0
8010648f:	6a 36                	push   $0x36
80106491:	e9 84 f7 ff ff       	jmp    80105c1a <alltraps>

80106496 <vector55>:
80106496:	6a 00                	push   $0x0
80106498:	6a 37                	push   $0x37
8010649a:	e9 7b f7 ff ff       	jmp    80105c1a <alltraps>

8010649f <vector56>:
8010649f:	6a 00                	push   $0x0
801064a1:	6a 38                	push   $0x38
801064a3:	e9 72 f7 ff ff       	jmp    80105c1a <alltraps>

801064a8 <vector57>:
801064a8:	6a 00                	push   $0x0
801064aa:	6a 39                	push   $0x39
801064ac:	e9 69 f7 ff ff       	jmp    80105c1a <alltraps>

801064b1 <vector58>:
801064b1:	6a 00                	push   $0x0
801064b3:	6a 3a                	push   $0x3a
801064b5:	e9 60 f7 ff ff       	jmp    80105c1a <alltraps>

801064ba <vector59>:
801064ba:	6a 00                	push   $0x0
801064bc:	6a 3b                	push   $0x3b
801064be:	e9 57 f7 ff ff       	jmp    80105c1a <alltraps>

801064c3 <vector60>:
801064c3:	6a 00                	push   $0x0
801064c5:	6a 3c                	push   $0x3c
801064c7:	e9 4e f7 ff ff       	jmp    80105c1a <alltraps>

801064cc <vector61>:
801064cc:	6a 00                	push   $0x0
801064ce:	6a 3d                	push   $0x3d
801064d0:	e9 45 f7 ff ff       	jmp    80105c1a <alltraps>

801064d5 <vector62>:
801064d5:	6a 00                	push   $0x0
801064d7:	6a 3e                	push   $0x3e
801064d9:	e9 3c f7 ff ff       	jmp    80105c1a <alltraps>

801064de <vector63>:
801064de:	6a 00                	push   $0x0
801064e0:	6a 3f                	push   $0x3f
801064e2:	e9 33 f7 ff ff       	jmp    80105c1a <alltraps>

801064e7 <vector64>:
801064e7:	6a 00                	push   $0x0
801064e9:	6a 40                	push   $0x40
801064eb:	e9 2a f7 ff ff       	jmp    80105c1a <alltraps>

801064f0 <vector65>:
801064f0:	6a 00                	push   $0x0
801064f2:	6a 41                	push   $0x41
801064f4:	e9 21 f7 ff ff       	jmp    80105c1a <alltraps>

801064f9 <vector66>:
801064f9:	6a 00                	push   $0x0
801064fb:	6a 42                	push   $0x42
801064fd:	e9 18 f7 ff ff       	jmp    80105c1a <alltraps>

80106502 <vector67>:
80106502:	6a 00                	push   $0x0
80106504:	6a 43                	push   $0x43
80106506:	e9 0f f7 ff ff       	jmp    80105c1a <alltraps>

8010650b <vector68>:
8010650b:	6a 00                	push   $0x0
8010650d:	6a 44                	push   $0x44
8010650f:	e9 06 f7 ff ff       	jmp    80105c1a <alltraps>

80106514 <vector69>:
80106514:	6a 00                	push   $0x0
80106516:	6a 45                	push   $0x45
80106518:	e9 fd f6 ff ff       	jmp    80105c1a <alltraps>

8010651d <vector70>:
8010651d:	6a 00                	push   $0x0
8010651f:	6a 46                	push   $0x46
80106521:	e9 f4 f6 ff ff       	jmp    80105c1a <alltraps>

80106526 <vector71>:
80106526:	6a 00                	push   $0x0
80106528:	6a 47                	push   $0x47
8010652a:	e9 eb f6 ff ff       	jmp    80105c1a <alltraps>

8010652f <vector72>:
8010652f:	6a 00                	push   $0x0
80106531:	6a 48                	push   $0x48
80106533:	e9 e2 f6 ff ff       	jmp    80105c1a <alltraps>

80106538 <vector73>:
80106538:	6a 00                	push   $0x0
8010653a:	6a 49                	push   $0x49
8010653c:	e9 d9 f6 ff ff       	jmp    80105c1a <alltraps>

80106541 <vector74>:
80106541:	6a 00                	push   $0x0
80106543:	6a 4a                	push   $0x4a
80106545:	e9 d0 f6 ff ff       	jmp    80105c1a <alltraps>

8010654a <vector75>:
8010654a:	6a 00                	push   $0x0
8010654c:	6a 4b                	push   $0x4b
8010654e:	e9 c7 f6 ff ff       	jmp    80105c1a <alltraps>

80106553 <vector76>:
80106553:	6a 00                	push   $0x0
80106555:	6a 4c                	push   $0x4c
80106557:	e9 be f6 ff ff       	jmp    80105c1a <alltraps>

8010655c <vector77>:
8010655c:	6a 00                	push   $0x0
8010655e:	6a 4d                	push   $0x4d
80106560:	e9 b5 f6 ff ff       	jmp    80105c1a <alltraps>

80106565 <vector78>:
80106565:	6a 00                	push   $0x0
80106567:	6a 4e                	push   $0x4e
80106569:	e9 ac f6 ff ff       	jmp    80105c1a <alltraps>

8010656e <vector79>:
8010656e:	6a 00                	push   $0x0
80106570:	6a 4f                	push   $0x4f
80106572:	e9 a3 f6 ff ff       	jmp    80105c1a <alltraps>

80106577 <vector80>:
80106577:	6a 00                	push   $0x0
80106579:	6a 50                	push   $0x50
8010657b:	e9 9a f6 ff ff       	jmp    80105c1a <alltraps>

80106580 <vector81>:
80106580:	6a 00                	push   $0x0
80106582:	6a 51                	push   $0x51
80106584:	e9 91 f6 ff ff       	jmp    80105c1a <alltraps>

80106589 <vector82>:
80106589:	6a 00                	push   $0x0
8010658b:	6a 52                	push   $0x52
8010658d:	e9 88 f6 ff ff       	jmp    80105c1a <alltraps>

80106592 <vector83>:
80106592:	6a 00                	push   $0x0
80106594:	6a 53                	push   $0x53
80106596:	e9 7f f6 ff ff       	jmp    80105c1a <alltraps>

8010659b <vector84>:
8010659b:	6a 00                	push   $0x0
8010659d:	6a 54                	push   $0x54
8010659f:	e9 76 f6 ff ff       	jmp    80105c1a <alltraps>

801065a4 <vector85>:
801065a4:	6a 00                	push   $0x0
801065a6:	6a 55                	push   $0x55
801065a8:	e9 6d f6 ff ff       	jmp    80105c1a <alltraps>

801065ad <vector86>:
801065ad:	6a 00                	push   $0x0
801065af:	6a 56                	push   $0x56
801065b1:	e9 64 f6 ff ff       	jmp    80105c1a <alltraps>

801065b6 <vector87>:
801065b6:	6a 00                	push   $0x0
801065b8:	6a 57                	push   $0x57
801065ba:	e9 5b f6 ff ff       	jmp    80105c1a <alltraps>

801065bf <vector88>:
801065bf:	6a 00                	push   $0x0
801065c1:	6a 58                	push   $0x58
801065c3:	e9 52 f6 ff ff       	jmp    80105c1a <alltraps>

801065c8 <vector89>:
801065c8:	6a 00                	push   $0x0
801065ca:	6a 59                	push   $0x59
801065cc:	e9 49 f6 ff ff       	jmp    80105c1a <alltraps>

801065d1 <vector90>:
801065d1:	6a 00                	push   $0x0
801065d3:	6a 5a                	push   $0x5a
801065d5:	e9 40 f6 ff ff       	jmp    80105c1a <alltraps>

801065da <vector91>:
801065da:	6a 00                	push   $0x0
801065dc:	6a 5b                	push   $0x5b
801065de:	e9 37 f6 ff ff       	jmp    80105c1a <alltraps>

801065e3 <vector92>:
801065e3:	6a 00                	push   $0x0
801065e5:	6a 5c                	push   $0x5c
801065e7:	e9 2e f6 ff ff       	jmp    80105c1a <alltraps>

801065ec <vector93>:
801065ec:	6a 00                	push   $0x0
801065ee:	6a 5d                	push   $0x5d
801065f0:	e9 25 f6 ff ff       	jmp    80105c1a <alltraps>

801065f5 <vector94>:
801065f5:	6a 00                	push   $0x0
801065f7:	6a 5e                	push   $0x5e
801065f9:	e9 1c f6 ff ff       	jmp    80105c1a <alltraps>

801065fe <vector95>:
801065fe:	6a 00                	push   $0x0
80106600:	6a 5f                	push   $0x5f
80106602:	e9 13 f6 ff ff       	jmp    80105c1a <alltraps>

80106607 <vector96>:
80106607:	6a 00                	push   $0x0
80106609:	6a 60                	push   $0x60
8010660b:	e9 0a f6 ff ff       	jmp    80105c1a <alltraps>

80106610 <vector97>:
80106610:	6a 00                	push   $0x0
80106612:	6a 61                	push   $0x61
80106614:	e9 01 f6 ff ff       	jmp    80105c1a <alltraps>

80106619 <vector98>:
80106619:	6a 00                	push   $0x0
8010661b:	6a 62                	push   $0x62
8010661d:	e9 f8 f5 ff ff       	jmp    80105c1a <alltraps>

80106622 <vector99>:
80106622:	6a 00                	push   $0x0
80106624:	6a 63                	push   $0x63
80106626:	e9 ef f5 ff ff       	jmp    80105c1a <alltraps>

8010662b <vector100>:
8010662b:	6a 00                	push   $0x0
8010662d:	6a 64                	push   $0x64
8010662f:	e9 e6 f5 ff ff       	jmp    80105c1a <alltraps>

80106634 <vector101>:
80106634:	6a 00                	push   $0x0
80106636:	6a 65                	push   $0x65
80106638:	e9 dd f5 ff ff       	jmp    80105c1a <alltraps>

8010663d <vector102>:
8010663d:	6a 00                	push   $0x0
8010663f:	6a 66                	push   $0x66
80106641:	e9 d4 f5 ff ff       	jmp    80105c1a <alltraps>

80106646 <vector103>:
80106646:	6a 00                	push   $0x0
80106648:	6a 67                	push   $0x67
8010664a:	e9 cb f5 ff ff       	jmp    80105c1a <alltraps>

8010664f <vector104>:
8010664f:	6a 00                	push   $0x0
80106651:	6a 68                	push   $0x68
80106653:	e9 c2 f5 ff ff       	jmp    80105c1a <alltraps>

80106658 <vector105>:
80106658:	6a 00                	push   $0x0
8010665a:	6a 69                	push   $0x69
8010665c:	e9 b9 f5 ff ff       	jmp    80105c1a <alltraps>

80106661 <vector106>:
80106661:	6a 00                	push   $0x0
80106663:	6a 6a                	push   $0x6a
80106665:	e9 b0 f5 ff ff       	jmp    80105c1a <alltraps>

8010666a <vector107>:
8010666a:	6a 00                	push   $0x0
8010666c:	6a 6b                	push   $0x6b
8010666e:	e9 a7 f5 ff ff       	jmp    80105c1a <alltraps>

80106673 <vector108>:
80106673:	6a 00                	push   $0x0
80106675:	6a 6c                	push   $0x6c
80106677:	e9 9e f5 ff ff       	jmp    80105c1a <alltraps>

8010667c <vector109>:
8010667c:	6a 00                	push   $0x0
8010667e:	6a 6d                	push   $0x6d
80106680:	e9 95 f5 ff ff       	jmp    80105c1a <alltraps>

80106685 <vector110>:
80106685:	6a 00                	push   $0x0
80106687:	6a 6e                	push   $0x6e
80106689:	e9 8c f5 ff ff       	jmp    80105c1a <alltraps>

8010668e <vector111>:
8010668e:	6a 00                	push   $0x0
80106690:	6a 6f                	push   $0x6f
80106692:	e9 83 f5 ff ff       	jmp    80105c1a <alltraps>

80106697 <vector112>:
80106697:	6a 00                	push   $0x0
80106699:	6a 70                	push   $0x70
8010669b:	e9 7a f5 ff ff       	jmp    80105c1a <alltraps>

801066a0 <vector113>:
801066a0:	6a 00                	push   $0x0
801066a2:	6a 71                	push   $0x71
801066a4:	e9 71 f5 ff ff       	jmp    80105c1a <alltraps>

801066a9 <vector114>:
801066a9:	6a 00                	push   $0x0
801066ab:	6a 72                	push   $0x72
801066ad:	e9 68 f5 ff ff       	jmp    80105c1a <alltraps>

801066b2 <vector115>:
801066b2:	6a 00                	push   $0x0
801066b4:	6a 73                	push   $0x73
801066b6:	e9 5f f5 ff ff       	jmp    80105c1a <alltraps>

801066bb <vector116>:
801066bb:	6a 00                	push   $0x0
801066bd:	6a 74                	push   $0x74
801066bf:	e9 56 f5 ff ff       	jmp    80105c1a <alltraps>

801066c4 <vector117>:
801066c4:	6a 00                	push   $0x0
801066c6:	6a 75                	push   $0x75
801066c8:	e9 4d f5 ff ff       	jmp    80105c1a <alltraps>

801066cd <vector118>:
801066cd:	6a 00                	push   $0x0
801066cf:	6a 76                	push   $0x76
801066d1:	e9 44 f5 ff ff       	jmp    80105c1a <alltraps>

801066d6 <vector119>:
801066d6:	6a 00                	push   $0x0
801066d8:	6a 77                	push   $0x77
801066da:	e9 3b f5 ff ff       	jmp    80105c1a <alltraps>

801066df <vector120>:
801066df:	6a 00                	push   $0x0
801066e1:	6a 78                	push   $0x78
801066e3:	e9 32 f5 ff ff       	jmp    80105c1a <alltraps>

801066e8 <vector121>:
801066e8:	6a 00                	push   $0x0
801066ea:	6a 79                	push   $0x79
801066ec:	e9 29 f5 ff ff       	jmp    80105c1a <alltraps>

801066f1 <vector122>:
801066f1:	6a 00                	push   $0x0
801066f3:	6a 7a                	push   $0x7a
801066f5:	e9 20 f5 ff ff       	jmp    80105c1a <alltraps>

801066fa <vector123>:
801066fa:	6a 00                	push   $0x0
801066fc:	6a 7b                	push   $0x7b
801066fe:	e9 17 f5 ff ff       	jmp    80105c1a <alltraps>

80106703 <vector124>:
80106703:	6a 00                	push   $0x0
80106705:	6a 7c                	push   $0x7c
80106707:	e9 0e f5 ff ff       	jmp    80105c1a <alltraps>

8010670c <vector125>:
8010670c:	6a 00                	push   $0x0
8010670e:	6a 7d                	push   $0x7d
80106710:	e9 05 f5 ff ff       	jmp    80105c1a <alltraps>

80106715 <vector126>:
80106715:	6a 00                	push   $0x0
80106717:	6a 7e                	push   $0x7e
80106719:	e9 fc f4 ff ff       	jmp    80105c1a <alltraps>

8010671e <vector127>:
8010671e:	6a 00                	push   $0x0
80106720:	6a 7f                	push   $0x7f
80106722:	e9 f3 f4 ff ff       	jmp    80105c1a <alltraps>

80106727 <vector128>:
80106727:	6a 00                	push   $0x0
80106729:	68 80 00 00 00       	push   $0x80
8010672e:	e9 e7 f4 ff ff       	jmp    80105c1a <alltraps>

80106733 <vector129>:
80106733:	6a 00                	push   $0x0
80106735:	68 81 00 00 00       	push   $0x81
8010673a:	e9 db f4 ff ff       	jmp    80105c1a <alltraps>

8010673f <vector130>:
8010673f:	6a 00                	push   $0x0
80106741:	68 82 00 00 00       	push   $0x82
80106746:	e9 cf f4 ff ff       	jmp    80105c1a <alltraps>

8010674b <vector131>:
8010674b:	6a 00                	push   $0x0
8010674d:	68 83 00 00 00       	push   $0x83
80106752:	e9 c3 f4 ff ff       	jmp    80105c1a <alltraps>

80106757 <vector132>:
80106757:	6a 00                	push   $0x0
80106759:	68 84 00 00 00       	push   $0x84
8010675e:	e9 b7 f4 ff ff       	jmp    80105c1a <alltraps>

80106763 <vector133>:
80106763:	6a 00                	push   $0x0
80106765:	68 85 00 00 00       	push   $0x85
8010676a:	e9 ab f4 ff ff       	jmp    80105c1a <alltraps>

8010676f <vector134>:
8010676f:	6a 00                	push   $0x0
80106771:	68 86 00 00 00       	push   $0x86
80106776:	e9 9f f4 ff ff       	jmp    80105c1a <alltraps>

8010677b <vector135>:
8010677b:	6a 00                	push   $0x0
8010677d:	68 87 00 00 00       	push   $0x87
80106782:	e9 93 f4 ff ff       	jmp    80105c1a <alltraps>

80106787 <vector136>:
80106787:	6a 00                	push   $0x0
80106789:	68 88 00 00 00       	push   $0x88
8010678e:	e9 87 f4 ff ff       	jmp    80105c1a <alltraps>

80106793 <vector137>:
80106793:	6a 00                	push   $0x0
80106795:	68 89 00 00 00       	push   $0x89
8010679a:	e9 7b f4 ff ff       	jmp    80105c1a <alltraps>

8010679f <vector138>:
8010679f:	6a 00                	push   $0x0
801067a1:	68 8a 00 00 00       	push   $0x8a
801067a6:	e9 6f f4 ff ff       	jmp    80105c1a <alltraps>

801067ab <vector139>:
801067ab:	6a 00                	push   $0x0
801067ad:	68 8b 00 00 00       	push   $0x8b
801067b2:	e9 63 f4 ff ff       	jmp    80105c1a <alltraps>

801067b7 <vector140>:
801067b7:	6a 00                	push   $0x0
801067b9:	68 8c 00 00 00       	push   $0x8c
801067be:	e9 57 f4 ff ff       	jmp    80105c1a <alltraps>

801067c3 <vector141>:
801067c3:	6a 00                	push   $0x0
801067c5:	68 8d 00 00 00       	push   $0x8d
801067ca:	e9 4b f4 ff ff       	jmp    80105c1a <alltraps>

801067cf <vector142>:
801067cf:	6a 00                	push   $0x0
801067d1:	68 8e 00 00 00       	push   $0x8e
801067d6:	e9 3f f4 ff ff       	jmp    80105c1a <alltraps>

801067db <vector143>:
801067db:	6a 00                	push   $0x0
801067dd:	68 8f 00 00 00       	push   $0x8f
801067e2:	e9 33 f4 ff ff       	jmp    80105c1a <alltraps>

801067e7 <vector144>:
801067e7:	6a 00                	push   $0x0
801067e9:	68 90 00 00 00       	push   $0x90
801067ee:	e9 27 f4 ff ff       	jmp    80105c1a <alltraps>

801067f3 <vector145>:
801067f3:	6a 00                	push   $0x0
801067f5:	68 91 00 00 00       	push   $0x91
801067fa:	e9 1b f4 ff ff       	jmp    80105c1a <alltraps>

801067ff <vector146>:
801067ff:	6a 00                	push   $0x0
80106801:	68 92 00 00 00       	push   $0x92
80106806:	e9 0f f4 ff ff       	jmp    80105c1a <alltraps>

8010680b <vector147>:
8010680b:	6a 00                	push   $0x0
8010680d:	68 93 00 00 00       	push   $0x93
80106812:	e9 03 f4 ff ff       	jmp    80105c1a <alltraps>

80106817 <vector148>:
80106817:	6a 00                	push   $0x0
80106819:	68 94 00 00 00       	push   $0x94
8010681e:	e9 f7 f3 ff ff       	jmp    80105c1a <alltraps>

80106823 <vector149>:
80106823:	6a 00                	push   $0x0
80106825:	68 95 00 00 00       	push   $0x95
8010682a:	e9 eb f3 ff ff       	jmp    80105c1a <alltraps>

8010682f <vector150>:
8010682f:	6a 00                	push   $0x0
80106831:	68 96 00 00 00       	push   $0x96
80106836:	e9 df f3 ff ff       	jmp    80105c1a <alltraps>

8010683b <vector151>:
8010683b:	6a 00                	push   $0x0
8010683d:	68 97 00 00 00       	push   $0x97
80106842:	e9 d3 f3 ff ff       	jmp    80105c1a <alltraps>

80106847 <vector152>:
80106847:	6a 00                	push   $0x0
80106849:	68 98 00 00 00       	push   $0x98
8010684e:	e9 c7 f3 ff ff       	jmp    80105c1a <alltraps>

80106853 <vector153>:
80106853:	6a 00                	push   $0x0
80106855:	68 99 00 00 00       	push   $0x99
8010685a:	e9 bb f3 ff ff       	jmp    80105c1a <alltraps>

8010685f <vector154>:
8010685f:	6a 00                	push   $0x0
80106861:	68 9a 00 00 00       	push   $0x9a
80106866:	e9 af f3 ff ff       	jmp    80105c1a <alltraps>

8010686b <vector155>:
8010686b:	6a 00                	push   $0x0
8010686d:	68 9b 00 00 00       	push   $0x9b
80106872:	e9 a3 f3 ff ff       	jmp    80105c1a <alltraps>

80106877 <vector156>:
80106877:	6a 00                	push   $0x0
80106879:	68 9c 00 00 00       	push   $0x9c
8010687e:	e9 97 f3 ff ff       	jmp    80105c1a <alltraps>

80106883 <vector157>:
80106883:	6a 00                	push   $0x0
80106885:	68 9d 00 00 00       	push   $0x9d
8010688a:	e9 8b f3 ff ff       	jmp    80105c1a <alltraps>

8010688f <vector158>:
8010688f:	6a 00                	push   $0x0
80106891:	68 9e 00 00 00       	push   $0x9e
80106896:	e9 7f f3 ff ff       	jmp    80105c1a <alltraps>

8010689b <vector159>:
8010689b:	6a 00                	push   $0x0
8010689d:	68 9f 00 00 00       	push   $0x9f
801068a2:	e9 73 f3 ff ff       	jmp    80105c1a <alltraps>

801068a7 <vector160>:
801068a7:	6a 00                	push   $0x0
801068a9:	68 a0 00 00 00       	push   $0xa0
801068ae:	e9 67 f3 ff ff       	jmp    80105c1a <alltraps>

801068b3 <vector161>:
801068b3:	6a 00                	push   $0x0
801068b5:	68 a1 00 00 00       	push   $0xa1
801068ba:	e9 5b f3 ff ff       	jmp    80105c1a <alltraps>

801068bf <vector162>:
801068bf:	6a 00                	push   $0x0
801068c1:	68 a2 00 00 00       	push   $0xa2
801068c6:	e9 4f f3 ff ff       	jmp    80105c1a <alltraps>

801068cb <vector163>:
801068cb:	6a 00                	push   $0x0
801068cd:	68 a3 00 00 00       	push   $0xa3
801068d2:	e9 43 f3 ff ff       	jmp    80105c1a <alltraps>

801068d7 <vector164>:
801068d7:	6a 00                	push   $0x0
801068d9:	68 a4 00 00 00       	push   $0xa4
801068de:	e9 37 f3 ff ff       	jmp    80105c1a <alltraps>

801068e3 <vector165>:
801068e3:	6a 00                	push   $0x0
801068e5:	68 a5 00 00 00       	push   $0xa5
801068ea:	e9 2b f3 ff ff       	jmp    80105c1a <alltraps>

801068ef <vector166>:
801068ef:	6a 00                	push   $0x0
801068f1:	68 a6 00 00 00       	push   $0xa6
801068f6:	e9 1f f3 ff ff       	jmp    80105c1a <alltraps>

801068fb <vector167>:
801068fb:	6a 00                	push   $0x0
801068fd:	68 a7 00 00 00       	push   $0xa7
80106902:	e9 13 f3 ff ff       	jmp    80105c1a <alltraps>

80106907 <vector168>:
80106907:	6a 00                	push   $0x0
80106909:	68 a8 00 00 00       	push   $0xa8
8010690e:	e9 07 f3 ff ff       	jmp    80105c1a <alltraps>

80106913 <vector169>:
80106913:	6a 00                	push   $0x0
80106915:	68 a9 00 00 00       	push   $0xa9
8010691a:	e9 fb f2 ff ff       	jmp    80105c1a <alltraps>

8010691f <vector170>:
8010691f:	6a 00                	push   $0x0
80106921:	68 aa 00 00 00       	push   $0xaa
80106926:	e9 ef f2 ff ff       	jmp    80105c1a <alltraps>

8010692b <vector171>:
8010692b:	6a 00                	push   $0x0
8010692d:	68 ab 00 00 00       	push   $0xab
80106932:	e9 e3 f2 ff ff       	jmp    80105c1a <alltraps>

80106937 <vector172>:
80106937:	6a 00                	push   $0x0
80106939:	68 ac 00 00 00       	push   $0xac
8010693e:	e9 d7 f2 ff ff       	jmp    80105c1a <alltraps>

80106943 <vector173>:
80106943:	6a 00                	push   $0x0
80106945:	68 ad 00 00 00       	push   $0xad
8010694a:	e9 cb f2 ff ff       	jmp    80105c1a <alltraps>

8010694f <vector174>:
8010694f:	6a 00                	push   $0x0
80106951:	68 ae 00 00 00       	push   $0xae
80106956:	e9 bf f2 ff ff       	jmp    80105c1a <alltraps>

8010695b <vector175>:
8010695b:	6a 00                	push   $0x0
8010695d:	68 af 00 00 00       	push   $0xaf
80106962:	e9 b3 f2 ff ff       	jmp    80105c1a <alltraps>

80106967 <vector176>:
80106967:	6a 00                	push   $0x0
80106969:	68 b0 00 00 00       	push   $0xb0
8010696e:	e9 a7 f2 ff ff       	jmp    80105c1a <alltraps>

80106973 <vector177>:
80106973:	6a 00                	push   $0x0
80106975:	68 b1 00 00 00       	push   $0xb1
8010697a:	e9 9b f2 ff ff       	jmp    80105c1a <alltraps>

8010697f <vector178>:
8010697f:	6a 00                	push   $0x0
80106981:	68 b2 00 00 00       	push   $0xb2
80106986:	e9 8f f2 ff ff       	jmp    80105c1a <alltraps>

8010698b <vector179>:
8010698b:	6a 00                	push   $0x0
8010698d:	68 b3 00 00 00       	push   $0xb3
80106992:	e9 83 f2 ff ff       	jmp    80105c1a <alltraps>

80106997 <vector180>:
80106997:	6a 00                	push   $0x0
80106999:	68 b4 00 00 00       	push   $0xb4
8010699e:	e9 77 f2 ff ff       	jmp    80105c1a <alltraps>

801069a3 <vector181>:
801069a3:	6a 00                	push   $0x0
801069a5:	68 b5 00 00 00       	push   $0xb5
801069aa:	e9 6b f2 ff ff       	jmp    80105c1a <alltraps>

801069af <vector182>:
801069af:	6a 00                	push   $0x0
801069b1:	68 b6 00 00 00       	push   $0xb6
801069b6:	e9 5f f2 ff ff       	jmp    80105c1a <alltraps>

801069bb <vector183>:
801069bb:	6a 00                	push   $0x0
801069bd:	68 b7 00 00 00       	push   $0xb7
801069c2:	e9 53 f2 ff ff       	jmp    80105c1a <alltraps>

801069c7 <vector184>:
801069c7:	6a 00                	push   $0x0
801069c9:	68 b8 00 00 00       	push   $0xb8
801069ce:	e9 47 f2 ff ff       	jmp    80105c1a <alltraps>

801069d3 <vector185>:
801069d3:	6a 00                	push   $0x0
801069d5:	68 b9 00 00 00       	push   $0xb9
801069da:	e9 3b f2 ff ff       	jmp    80105c1a <alltraps>

801069df <vector186>:
801069df:	6a 00                	push   $0x0
801069e1:	68 ba 00 00 00       	push   $0xba
801069e6:	e9 2f f2 ff ff       	jmp    80105c1a <alltraps>

801069eb <vector187>:
801069eb:	6a 00                	push   $0x0
801069ed:	68 bb 00 00 00       	push   $0xbb
801069f2:	e9 23 f2 ff ff       	jmp    80105c1a <alltraps>

801069f7 <vector188>:
801069f7:	6a 00                	push   $0x0
801069f9:	68 bc 00 00 00       	push   $0xbc
801069fe:	e9 17 f2 ff ff       	jmp    80105c1a <alltraps>

80106a03 <vector189>:
80106a03:	6a 00                	push   $0x0
80106a05:	68 bd 00 00 00       	push   $0xbd
80106a0a:	e9 0b f2 ff ff       	jmp    80105c1a <alltraps>

80106a0f <vector190>:
80106a0f:	6a 00                	push   $0x0
80106a11:	68 be 00 00 00       	push   $0xbe
80106a16:	e9 ff f1 ff ff       	jmp    80105c1a <alltraps>

80106a1b <vector191>:
80106a1b:	6a 00                	push   $0x0
80106a1d:	68 bf 00 00 00       	push   $0xbf
80106a22:	e9 f3 f1 ff ff       	jmp    80105c1a <alltraps>

80106a27 <vector192>:
80106a27:	6a 00                	push   $0x0
80106a29:	68 c0 00 00 00       	push   $0xc0
80106a2e:	e9 e7 f1 ff ff       	jmp    80105c1a <alltraps>

80106a33 <vector193>:
80106a33:	6a 00                	push   $0x0
80106a35:	68 c1 00 00 00       	push   $0xc1
80106a3a:	e9 db f1 ff ff       	jmp    80105c1a <alltraps>

80106a3f <vector194>:
80106a3f:	6a 00                	push   $0x0
80106a41:	68 c2 00 00 00       	push   $0xc2
80106a46:	e9 cf f1 ff ff       	jmp    80105c1a <alltraps>

80106a4b <vector195>:
80106a4b:	6a 00                	push   $0x0
80106a4d:	68 c3 00 00 00       	push   $0xc3
80106a52:	e9 c3 f1 ff ff       	jmp    80105c1a <alltraps>

80106a57 <vector196>:
80106a57:	6a 00                	push   $0x0
80106a59:	68 c4 00 00 00       	push   $0xc4
80106a5e:	e9 b7 f1 ff ff       	jmp    80105c1a <alltraps>

80106a63 <vector197>:
80106a63:	6a 00                	push   $0x0
80106a65:	68 c5 00 00 00       	push   $0xc5
80106a6a:	e9 ab f1 ff ff       	jmp    80105c1a <alltraps>

80106a6f <vector198>:
80106a6f:	6a 00                	push   $0x0
80106a71:	68 c6 00 00 00       	push   $0xc6
80106a76:	e9 9f f1 ff ff       	jmp    80105c1a <alltraps>

80106a7b <vector199>:
80106a7b:	6a 00                	push   $0x0
80106a7d:	68 c7 00 00 00       	push   $0xc7
80106a82:	e9 93 f1 ff ff       	jmp    80105c1a <alltraps>

80106a87 <vector200>:
80106a87:	6a 00                	push   $0x0
80106a89:	68 c8 00 00 00       	push   $0xc8
80106a8e:	e9 87 f1 ff ff       	jmp    80105c1a <alltraps>

80106a93 <vector201>:
80106a93:	6a 00                	push   $0x0
80106a95:	68 c9 00 00 00       	push   $0xc9
80106a9a:	e9 7b f1 ff ff       	jmp    80105c1a <alltraps>

80106a9f <vector202>:
80106a9f:	6a 00                	push   $0x0
80106aa1:	68 ca 00 00 00       	push   $0xca
80106aa6:	e9 6f f1 ff ff       	jmp    80105c1a <alltraps>

80106aab <vector203>:
80106aab:	6a 00                	push   $0x0
80106aad:	68 cb 00 00 00       	push   $0xcb
80106ab2:	e9 63 f1 ff ff       	jmp    80105c1a <alltraps>

80106ab7 <vector204>:
80106ab7:	6a 00                	push   $0x0
80106ab9:	68 cc 00 00 00       	push   $0xcc
80106abe:	e9 57 f1 ff ff       	jmp    80105c1a <alltraps>

80106ac3 <vector205>:
80106ac3:	6a 00                	push   $0x0
80106ac5:	68 cd 00 00 00       	push   $0xcd
80106aca:	e9 4b f1 ff ff       	jmp    80105c1a <alltraps>

80106acf <vector206>:
80106acf:	6a 00                	push   $0x0
80106ad1:	68 ce 00 00 00       	push   $0xce
80106ad6:	e9 3f f1 ff ff       	jmp    80105c1a <alltraps>

80106adb <vector207>:
80106adb:	6a 00                	push   $0x0
80106add:	68 cf 00 00 00       	push   $0xcf
80106ae2:	e9 33 f1 ff ff       	jmp    80105c1a <alltraps>

80106ae7 <vector208>:
80106ae7:	6a 00                	push   $0x0
80106ae9:	68 d0 00 00 00       	push   $0xd0
80106aee:	e9 27 f1 ff ff       	jmp    80105c1a <alltraps>

80106af3 <vector209>:
80106af3:	6a 00                	push   $0x0
80106af5:	68 d1 00 00 00       	push   $0xd1
80106afa:	e9 1b f1 ff ff       	jmp    80105c1a <alltraps>

80106aff <vector210>:
80106aff:	6a 00                	push   $0x0
80106b01:	68 d2 00 00 00       	push   $0xd2
80106b06:	e9 0f f1 ff ff       	jmp    80105c1a <alltraps>

80106b0b <vector211>:
80106b0b:	6a 00                	push   $0x0
80106b0d:	68 d3 00 00 00       	push   $0xd3
80106b12:	e9 03 f1 ff ff       	jmp    80105c1a <alltraps>

80106b17 <vector212>:
80106b17:	6a 00                	push   $0x0
80106b19:	68 d4 00 00 00       	push   $0xd4
80106b1e:	e9 f7 f0 ff ff       	jmp    80105c1a <alltraps>

80106b23 <vector213>:
80106b23:	6a 00                	push   $0x0
80106b25:	68 d5 00 00 00       	push   $0xd5
80106b2a:	e9 eb f0 ff ff       	jmp    80105c1a <alltraps>

80106b2f <vector214>:
80106b2f:	6a 00                	push   $0x0
80106b31:	68 d6 00 00 00       	push   $0xd6
80106b36:	e9 df f0 ff ff       	jmp    80105c1a <alltraps>

80106b3b <vector215>:
80106b3b:	6a 00                	push   $0x0
80106b3d:	68 d7 00 00 00       	push   $0xd7
80106b42:	e9 d3 f0 ff ff       	jmp    80105c1a <alltraps>

80106b47 <vector216>:
80106b47:	6a 00                	push   $0x0
80106b49:	68 d8 00 00 00       	push   $0xd8
80106b4e:	e9 c7 f0 ff ff       	jmp    80105c1a <alltraps>

80106b53 <vector217>:
80106b53:	6a 00                	push   $0x0
80106b55:	68 d9 00 00 00       	push   $0xd9
80106b5a:	e9 bb f0 ff ff       	jmp    80105c1a <alltraps>

80106b5f <vector218>:
80106b5f:	6a 00                	push   $0x0
80106b61:	68 da 00 00 00       	push   $0xda
80106b66:	e9 af f0 ff ff       	jmp    80105c1a <alltraps>

80106b6b <vector219>:
80106b6b:	6a 00                	push   $0x0
80106b6d:	68 db 00 00 00       	push   $0xdb
80106b72:	e9 a3 f0 ff ff       	jmp    80105c1a <alltraps>

80106b77 <vector220>:
80106b77:	6a 00                	push   $0x0
80106b79:	68 dc 00 00 00       	push   $0xdc
80106b7e:	e9 97 f0 ff ff       	jmp    80105c1a <alltraps>

80106b83 <vector221>:
80106b83:	6a 00                	push   $0x0
80106b85:	68 dd 00 00 00       	push   $0xdd
80106b8a:	e9 8b f0 ff ff       	jmp    80105c1a <alltraps>

80106b8f <vector222>:
80106b8f:	6a 00                	push   $0x0
80106b91:	68 de 00 00 00       	push   $0xde
80106b96:	e9 7f f0 ff ff       	jmp    80105c1a <alltraps>

80106b9b <vector223>:
80106b9b:	6a 00                	push   $0x0
80106b9d:	68 df 00 00 00       	push   $0xdf
80106ba2:	e9 73 f0 ff ff       	jmp    80105c1a <alltraps>

80106ba7 <vector224>:
80106ba7:	6a 00                	push   $0x0
80106ba9:	68 e0 00 00 00       	push   $0xe0
80106bae:	e9 67 f0 ff ff       	jmp    80105c1a <alltraps>

80106bb3 <vector225>:
80106bb3:	6a 00                	push   $0x0
80106bb5:	68 e1 00 00 00       	push   $0xe1
80106bba:	e9 5b f0 ff ff       	jmp    80105c1a <alltraps>

80106bbf <vector226>:
80106bbf:	6a 00                	push   $0x0
80106bc1:	68 e2 00 00 00       	push   $0xe2
80106bc6:	e9 4f f0 ff ff       	jmp    80105c1a <alltraps>

80106bcb <vector227>:
80106bcb:	6a 00                	push   $0x0
80106bcd:	68 e3 00 00 00       	push   $0xe3
80106bd2:	e9 43 f0 ff ff       	jmp    80105c1a <alltraps>

80106bd7 <vector228>:
80106bd7:	6a 00                	push   $0x0
80106bd9:	68 e4 00 00 00       	push   $0xe4
80106bde:	e9 37 f0 ff ff       	jmp    80105c1a <alltraps>

80106be3 <vector229>:
80106be3:	6a 00                	push   $0x0
80106be5:	68 e5 00 00 00       	push   $0xe5
80106bea:	e9 2b f0 ff ff       	jmp    80105c1a <alltraps>

80106bef <vector230>:
80106bef:	6a 00                	push   $0x0
80106bf1:	68 e6 00 00 00       	push   $0xe6
80106bf6:	e9 1f f0 ff ff       	jmp    80105c1a <alltraps>

80106bfb <vector231>:
80106bfb:	6a 00                	push   $0x0
80106bfd:	68 e7 00 00 00       	push   $0xe7
80106c02:	e9 13 f0 ff ff       	jmp    80105c1a <alltraps>

80106c07 <vector232>:
80106c07:	6a 00                	push   $0x0
80106c09:	68 e8 00 00 00       	push   $0xe8
80106c0e:	e9 07 f0 ff ff       	jmp    80105c1a <alltraps>

80106c13 <vector233>:
80106c13:	6a 00                	push   $0x0
80106c15:	68 e9 00 00 00       	push   $0xe9
80106c1a:	e9 fb ef ff ff       	jmp    80105c1a <alltraps>

80106c1f <vector234>:
80106c1f:	6a 00                	push   $0x0
80106c21:	68 ea 00 00 00       	push   $0xea
80106c26:	e9 ef ef ff ff       	jmp    80105c1a <alltraps>

80106c2b <vector235>:
80106c2b:	6a 00                	push   $0x0
80106c2d:	68 eb 00 00 00       	push   $0xeb
80106c32:	e9 e3 ef ff ff       	jmp    80105c1a <alltraps>

80106c37 <vector236>:
80106c37:	6a 00                	push   $0x0
80106c39:	68 ec 00 00 00       	push   $0xec
80106c3e:	e9 d7 ef ff ff       	jmp    80105c1a <alltraps>

80106c43 <vector237>:
80106c43:	6a 00                	push   $0x0
80106c45:	68 ed 00 00 00       	push   $0xed
80106c4a:	e9 cb ef ff ff       	jmp    80105c1a <alltraps>

80106c4f <vector238>:
80106c4f:	6a 00                	push   $0x0
80106c51:	68 ee 00 00 00       	push   $0xee
80106c56:	e9 bf ef ff ff       	jmp    80105c1a <alltraps>

80106c5b <vector239>:
80106c5b:	6a 00                	push   $0x0
80106c5d:	68 ef 00 00 00       	push   $0xef
80106c62:	e9 b3 ef ff ff       	jmp    80105c1a <alltraps>

80106c67 <vector240>:
80106c67:	6a 00                	push   $0x0
80106c69:	68 f0 00 00 00       	push   $0xf0
80106c6e:	e9 a7 ef ff ff       	jmp    80105c1a <alltraps>

80106c73 <vector241>:
80106c73:	6a 00                	push   $0x0
80106c75:	68 f1 00 00 00       	push   $0xf1
80106c7a:	e9 9b ef ff ff       	jmp    80105c1a <alltraps>

80106c7f <vector242>:
80106c7f:	6a 00                	push   $0x0
80106c81:	68 f2 00 00 00       	push   $0xf2
80106c86:	e9 8f ef ff ff       	jmp    80105c1a <alltraps>

80106c8b <vector243>:
80106c8b:	6a 00                	push   $0x0
80106c8d:	68 f3 00 00 00       	push   $0xf3
80106c92:	e9 83 ef ff ff       	jmp    80105c1a <alltraps>

80106c97 <vector244>:
80106c97:	6a 00                	push   $0x0
80106c99:	68 f4 00 00 00       	push   $0xf4
80106c9e:	e9 77 ef ff ff       	jmp    80105c1a <alltraps>

80106ca3 <vector245>:
80106ca3:	6a 00                	push   $0x0
80106ca5:	68 f5 00 00 00       	push   $0xf5
80106caa:	e9 6b ef ff ff       	jmp    80105c1a <alltraps>

80106caf <vector246>:
80106caf:	6a 00                	push   $0x0
80106cb1:	68 f6 00 00 00       	push   $0xf6
80106cb6:	e9 5f ef ff ff       	jmp    80105c1a <alltraps>

80106cbb <vector247>:
80106cbb:	6a 00                	push   $0x0
80106cbd:	68 f7 00 00 00       	push   $0xf7
80106cc2:	e9 53 ef ff ff       	jmp    80105c1a <alltraps>

80106cc7 <vector248>:
80106cc7:	6a 00                	push   $0x0
80106cc9:	68 f8 00 00 00       	push   $0xf8
80106cce:	e9 47 ef ff ff       	jmp    80105c1a <alltraps>

80106cd3 <vector249>:
80106cd3:	6a 00                	push   $0x0
80106cd5:	68 f9 00 00 00       	push   $0xf9
80106cda:	e9 3b ef ff ff       	jmp    80105c1a <alltraps>

80106cdf <vector250>:
80106cdf:	6a 00                	push   $0x0
80106ce1:	68 fa 00 00 00       	push   $0xfa
80106ce6:	e9 2f ef ff ff       	jmp    80105c1a <alltraps>

80106ceb <vector251>:
80106ceb:	6a 00                	push   $0x0
80106ced:	68 fb 00 00 00       	push   $0xfb
80106cf2:	e9 23 ef ff ff       	jmp    80105c1a <alltraps>

80106cf7 <vector252>:
80106cf7:	6a 00                	push   $0x0
80106cf9:	68 fc 00 00 00       	push   $0xfc
80106cfe:	e9 17 ef ff ff       	jmp    80105c1a <alltraps>

80106d03 <vector253>:
80106d03:	6a 00                	push   $0x0
80106d05:	68 fd 00 00 00       	push   $0xfd
80106d0a:	e9 0b ef ff ff       	jmp    80105c1a <alltraps>

80106d0f <vector254>:
80106d0f:	6a 00                	push   $0x0
80106d11:	68 fe 00 00 00       	push   $0xfe
80106d16:	e9 ff ee ff ff       	jmp    80105c1a <alltraps>

80106d1b <vector255>:
80106d1b:	6a 00                	push   $0x0
80106d1d:	68 ff 00 00 00       	push   $0xff
80106d22:	e9 f3 ee ff ff       	jmp    80105c1a <alltraps>
80106d27:	66 90                	xchg   %ax,%ax
80106d29:	66 90                	xchg   %ax,%ax
80106d2b:	66 90                	xchg   %ax,%ax
80106d2d:	66 90                	xchg   %ax,%ax
80106d2f:	90                   	nop

80106d30 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106d30:	55                   	push   %ebp
80106d31:	89 e5                	mov    %esp,%ebp
80106d33:	57                   	push   %edi
80106d34:	56                   	push   %esi
80106d35:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106d36:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106d3c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106d42:	83 ec 1c             	sub    $0x1c,%esp
80106d45:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106d48:	39 d3                	cmp    %edx,%ebx
80106d4a:	73 49                	jae    80106d95 <deallocuvm.part.0+0x65>
80106d4c:	89 c7                	mov    %eax,%edi
80106d4e:	eb 0c                	jmp    80106d5c <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106d50:	83 c0 01             	add    $0x1,%eax
80106d53:	c1 e0 16             	shl    $0x16,%eax
80106d56:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106d58:	39 da                	cmp    %ebx,%edx
80106d5a:	76 39                	jbe    80106d95 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
80106d5c:	89 d8                	mov    %ebx,%eax
80106d5e:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80106d61:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80106d64:	f6 c1 01             	test   $0x1,%cl
80106d67:	74 e7                	je     80106d50 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80106d69:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106d6b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106d71:	c1 ee 0a             	shr    $0xa,%esi
80106d74:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
80106d7a:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80106d81:	85 f6                	test   %esi,%esi
80106d83:	74 cb                	je     80106d50 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80106d85:	8b 06                	mov    (%esi),%eax
80106d87:	a8 01                	test   $0x1,%al
80106d89:	75 15                	jne    80106da0 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
80106d8b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d91:	39 da                	cmp    %ebx,%edx
80106d93:	77 c7                	ja     80106d5c <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106d95:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106d98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d9b:	5b                   	pop    %ebx
80106d9c:	5e                   	pop    %esi
80106d9d:	5f                   	pop    %edi
80106d9e:	5d                   	pop    %ebp
80106d9f:	c3                   	ret    
      if(pa == 0)
80106da0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106da5:	74 25                	je     80106dcc <deallocuvm.part.0+0x9c>
      kfree(v);
80106da7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106daa:	05 00 00 00 80       	add    $0x80000000,%eax
80106daf:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106db2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106db8:	50                   	push   %eax
80106db9:	e8 02 b7 ff ff       	call   801024c0 <kfree>
      *pte = 0;
80106dbe:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80106dc4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106dc7:	83 c4 10             	add    $0x10,%esp
80106dca:	eb 8c                	jmp    80106d58 <deallocuvm.part.0+0x28>
        panic("kfree");
80106dcc:	83 ec 0c             	sub    $0xc,%esp
80106dcf:	68 46 86 10 80       	push   $0x80108646
80106dd4:	e8 a7 95 ff ff       	call   80100380 <panic>
80106dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106de0 <seginit>:
{
80106de0:	55                   	push   %ebp
80106de1:	89 e5                	mov    %esp,%ebp
80106de3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106de6:	e8 c5 cb ff ff       	call   801039b0 <cpuid>
  pd[0] = size-1;
80106deb:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106df0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106df6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106dfa:	c7 80 18 38 11 80 ff 	movl   $0xffff,-0x7feec7e8(%eax)
80106e01:	ff 00 00 
80106e04:	c7 80 1c 38 11 80 00 	movl   $0xcf9a00,-0x7feec7e4(%eax)
80106e0b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106e0e:	c7 80 20 38 11 80 ff 	movl   $0xffff,-0x7feec7e0(%eax)
80106e15:	ff 00 00 
80106e18:	c7 80 24 38 11 80 00 	movl   $0xcf9200,-0x7feec7dc(%eax)
80106e1f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106e22:	c7 80 28 38 11 80 ff 	movl   $0xffff,-0x7feec7d8(%eax)
80106e29:	ff 00 00 
80106e2c:	c7 80 2c 38 11 80 00 	movl   $0xcffa00,-0x7feec7d4(%eax)
80106e33:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106e36:	c7 80 30 38 11 80 ff 	movl   $0xffff,-0x7feec7d0(%eax)
80106e3d:	ff 00 00 
80106e40:	c7 80 34 38 11 80 00 	movl   $0xcff200,-0x7feec7cc(%eax)
80106e47:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106e4a:	05 10 38 11 80       	add    $0x80113810,%eax
  pd[1] = (uint)p;
80106e4f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106e53:	c1 e8 10             	shr    $0x10,%eax
80106e56:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106e5a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106e5d:	0f 01 10             	lgdtl  (%eax)
}
80106e60:	c9                   	leave  
80106e61:	c3                   	ret    
80106e62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106e70 <walkpgdir>:
{
80106e70:	55                   	push   %ebp
80106e71:	89 e5                	mov    %esp,%ebp
80106e73:	57                   	push   %edi
80106e74:	56                   	push   %esi
80106e75:	53                   	push   %ebx
80106e76:	83 ec 0c             	sub    $0xc,%esp
80106e79:	8b 7d 0c             	mov    0xc(%ebp),%edi
  pde = &pgdir[PDX(va)];
80106e7c:	8b 55 08             	mov    0x8(%ebp),%edx
80106e7f:	89 fe                	mov    %edi,%esi
80106e81:	c1 ee 16             	shr    $0x16,%esi
80106e84:	8d 34 b2             	lea    (%edx,%esi,4),%esi
  if(*pde & PTE_P){
80106e87:	8b 1e                	mov    (%esi),%ebx
80106e89:	f6 c3 01             	test   $0x1,%bl
80106e8c:	74 22                	je     80106eb0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106e8e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106e94:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
  return &pgtab[PTX(va)];
80106e9a:	89 f8                	mov    %edi,%eax
}
80106e9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106e9f:	c1 e8 0a             	shr    $0xa,%eax
80106ea2:	25 fc 0f 00 00       	and    $0xffc,%eax
80106ea7:	01 d8                	add    %ebx,%eax
}
80106ea9:	5b                   	pop    %ebx
80106eaa:	5e                   	pop    %esi
80106eab:	5f                   	pop    %edi
80106eac:	5d                   	pop    %ebp
80106ead:	c3                   	ret    
80106eae:	66 90                	xchg   %ax,%ax
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106eb0:	8b 45 10             	mov    0x10(%ebp),%eax
80106eb3:	85 c0                	test   %eax,%eax
80106eb5:	74 31                	je     80106ee8 <walkpgdir+0x78>
80106eb7:	e8 c4 b7 ff ff       	call   80102680 <kalloc>
80106ebc:	89 c3                	mov    %eax,%ebx
80106ebe:	85 c0                	test   %eax,%eax
80106ec0:	74 26                	je     80106ee8 <walkpgdir+0x78>
    memset(pgtab, 0, PGSIZE);
80106ec2:	83 ec 04             	sub    $0x4,%esp
80106ec5:	68 00 10 00 00       	push   $0x1000
80106eca:	6a 00                	push   $0x0
80106ecc:	50                   	push   %eax
80106ecd:	e8 2e da ff ff       	call   80104900 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106ed2:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106ed8:	83 c4 10             	add    $0x10,%esp
80106edb:	83 c8 07             	or     $0x7,%eax
80106ede:	89 06                	mov    %eax,(%esi)
80106ee0:	eb b8                	jmp    80106e9a <walkpgdir+0x2a>
80106ee2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80106ee8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106eeb:	31 c0                	xor    %eax,%eax
}
80106eed:	5b                   	pop    %ebx
80106eee:	5e                   	pop    %esi
80106eef:	5f                   	pop    %edi
80106ef0:	5d                   	pop    %ebp
80106ef1:	c3                   	ret    
80106ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106f00 <mappages>:
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	57                   	push   %edi
80106f04:	56                   	push   %esi
80106f05:	53                   	push   %ebx
80106f06:	83 ec 1c             	sub    $0x1c,%esp
80106f09:	8b 45 0c             	mov    0xc(%ebp),%eax
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106f0c:	8b 55 10             	mov    0x10(%ebp),%edx
  a = (char*)PGROUNDDOWN((uint)va);
80106f0f:	89 c3                	mov    %eax,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106f11:	8d 44 10 ff          	lea    -0x1(%eax,%edx,1),%eax
80106f15:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80106f1a:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106f20:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106f23:	8b 45 14             	mov    0x14(%ebp),%eax
80106f26:	29 d8                	sub    %ebx,%eax
80106f28:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106f2b:	eb 3a                	jmp    80106f67 <mappages+0x67>
80106f2d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106f30:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106f32:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106f37:	c1 ea 0a             	shr    $0xa,%edx
80106f3a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106f40:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106f47:	85 c0                	test   %eax,%eax
80106f49:	74 75                	je     80106fc0 <mappages+0xc0>
    if(*pte & PTE_P)
80106f4b:	f6 00 01             	testb  $0x1,(%eax)
80106f4e:	0f 85 86 00 00 00    	jne    80106fda <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106f54:	0b 75 18             	or     0x18(%ebp),%esi
80106f57:	83 ce 01             	or     $0x1,%esi
80106f5a:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106f5c:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80106f5f:	74 6f                	je     80106fd0 <mappages+0xd0>
    a += PGSIZE;
80106f61:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106f67:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106f6a:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106f6d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80106f70:	89 d8                	mov    %ebx,%eax
80106f72:	c1 e8 16             	shr    $0x16,%eax
80106f75:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106f78:	8b 07                	mov    (%edi),%eax
80106f7a:	a8 01                	test   $0x1,%al
80106f7c:	75 b2                	jne    80106f30 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106f7e:	e8 fd b6 ff ff       	call   80102680 <kalloc>
80106f83:	85 c0                	test   %eax,%eax
80106f85:	74 39                	je     80106fc0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106f87:	83 ec 04             	sub    $0x4,%esp
80106f8a:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106f8d:	68 00 10 00 00       	push   $0x1000
80106f92:	6a 00                	push   $0x0
80106f94:	50                   	push   %eax
80106f95:	e8 66 d9 ff ff       	call   80104900 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106f9a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  return &pgtab[PTX(va)];
80106f9d:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106fa0:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106fa6:	83 c8 07             	or     $0x7,%eax
80106fa9:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106fab:	89 d8                	mov    %ebx,%eax
80106fad:	c1 e8 0a             	shr    $0xa,%eax
80106fb0:	25 fc 0f 00 00       	and    $0xffc,%eax
80106fb5:	01 d0                	add    %edx,%eax
80106fb7:	eb 92                	jmp    80106f4b <mappages+0x4b>
80106fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80106fc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106fc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106fc8:	5b                   	pop    %ebx
80106fc9:	5e                   	pop    %esi
80106fca:	5f                   	pop    %edi
80106fcb:	5d                   	pop    %ebp
80106fcc:	c3                   	ret    
80106fcd:	8d 76 00             	lea    0x0(%esi),%esi
80106fd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106fd3:	31 c0                	xor    %eax,%eax
}
80106fd5:	5b                   	pop    %ebx
80106fd6:	5e                   	pop    %esi
80106fd7:	5f                   	pop    %edi
80106fd8:	5d                   	pop    %ebp
80106fd9:	c3                   	ret    
      panic("remap");
80106fda:	83 ec 0c             	sub    $0xc,%esp
80106fdd:	68 7c 8d 10 80       	push   $0x80108d7c
80106fe2:	e8 99 93 ff ff       	call   80100380 <panic>
80106fe7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fee:	66 90                	xchg   %ax,%ax

80106ff0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ff0:	a1 c4 b6 11 80       	mov    0x8011b6c4,%eax
80106ff5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106ffa:	0f 22 d8             	mov    %eax,%cr3
}
80106ffd:	c3                   	ret    
80106ffe:	66 90                	xchg   %ax,%ax

80107000 <switchuvm>:
{
80107000:	55                   	push   %ebp
80107001:	89 e5                	mov    %esp,%ebp
80107003:	57                   	push   %edi
80107004:	56                   	push   %esi
80107005:	53                   	push   %ebx
80107006:	83 ec 1c             	sub    $0x1c,%esp
80107009:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010700c:	85 f6                	test   %esi,%esi
8010700e:	0f 84 cb 00 00 00    	je     801070df <switchuvm+0xdf>
  if(p->kstack == 0)
80107014:	8b 46 08             	mov    0x8(%esi),%eax
80107017:	85 c0                	test   %eax,%eax
80107019:	0f 84 da 00 00 00    	je     801070f9 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010701f:	8b 46 04             	mov    0x4(%esi),%eax
80107022:	85 c0                	test   %eax,%eax
80107024:	0f 84 c2 00 00 00    	je     801070ec <switchuvm+0xec>
  pushcli();
8010702a:	e8 c1 d6 ff ff       	call   801046f0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010702f:	e8 1c c9 ff ff       	call   80103950 <mycpu>
80107034:	89 c3                	mov    %eax,%ebx
80107036:	e8 15 c9 ff ff       	call   80103950 <mycpu>
8010703b:	89 c7                	mov    %eax,%edi
8010703d:	e8 0e c9 ff ff       	call   80103950 <mycpu>
80107042:	83 c7 08             	add    $0x8,%edi
80107045:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107048:	e8 03 c9 ff ff       	call   80103950 <mycpu>
8010704d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107050:	ba 67 00 00 00       	mov    $0x67,%edx
80107055:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010705c:	83 c0 08             	add    $0x8,%eax
8010705f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107066:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010706b:	83 c1 08             	add    $0x8,%ecx
8010706e:	c1 e8 18             	shr    $0x18,%eax
80107071:	c1 e9 10             	shr    $0x10,%ecx
80107074:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010707a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107080:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107085:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010708c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107091:	e8 ba c8 ff ff       	call   80103950 <mycpu>
80107096:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010709d:	e8 ae c8 ff ff       	call   80103950 <mycpu>
801070a2:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801070a6:	8b 5e 08             	mov    0x8(%esi),%ebx
801070a9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801070af:	e8 9c c8 ff ff       	call   80103950 <mycpu>
801070b4:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801070b7:	e8 94 c8 ff ff       	call   80103950 <mycpu>
801070bc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801070c0:	b8 28 00 00 00       	mov    $0x28,%eax
801070c5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801070c8:	8b 46 04             	mov    0x4(%esi),%eax
801070cb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801070d0:	0f 22 d8             	mov    %eax,%cr3
}
801070d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070d6:	5b                   	pop    %ebx
801070d7:	5e                   	pop    %esi
801070d8:	5f                   	pop    %edi
801070d9:	5d                   	pop    %ebp
  popcli();
801070da:	e9 61 d6 ff ff       	jmp    80104740 <popcli>
    panic("switchuvm: no process");
801070df:	83 ec 0c             	sub    $0xc,%esp
801070e2:	68 82 8d 10 80       	push   $0x80108d82
801070e7:	e8 94 92 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
801070ec:	83 ec 0c             	sub    $0xc,%esp
801070ef:	68 ad 8d 10 80       	push   $0x80108dad
801070f4:	e8 87 92 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
801070f9:	83 ec 0c             	sub    $0xc,%esp
801070fc:	68 98 8d 10 80       	push   $0x80108d98
80107101:	e8 7a 92 ff ff       	call   80100380 <panic>
80107106:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010710d:	8d 76 00             	lea    0x0(%esi),%esi

80107110 <inituvm>:
{
80107110:	55                   	push   %ebp
80107111:	89 e5                	mov    %esp,%ebp
80107113:	57                   	push   %edi
80107114:	56                   	push   %esi
80107115:	53                   	push   %ebx
80107116:	83 ec 1c             	sub    $0x1c,%esp
80107119:	8b 75 10             	mov    0x10(%ebp),%esi
8010711c:	8b 55 08             	mov    0x8(%ebp),%edx
8010711f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80107122:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107128:	77 50                	ja     8010717a <inituvm+0x6a>
8010712a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  mem = kalloc();
8010712d:	e8 4e b5 ff ff       	call   80102680 <kalloc>
  memset(mem, 0, PGSIZE);
80107132:	83 ec 04             	sub    $0x4,%esp
80107135:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010713a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010713c:	6a 00                	push   $0x0
8010713e:	50                   	push   %eax
8010713f:	e8 bc d7 ff ff       	call   80104900 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107144:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107147:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010714d:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
80107154:	50                   	push   %eax
80107155:	68 00 10 00 00       	push   $0x1000
8010715a:	6a 00                	push   $0x0
8010715c:	52                   	push   %edx
8010715d:	e8 9e fd ff ff       	call   80106f00 <mappages>
  memmove(mem, init, sz);
80107162:	89 75 10             	mov    %esi,0x10(%ebp)
80107165:	83 c4 20             	add    $0x20,%esp
80107168:	89 7d 0c             	mov    %edi,0xc(%ebp)
8010716b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010716e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107171:	5b                   	pop    %ebx
80107172:	5e                   	pop    %esi
80107173:	5f                   	pop    %edi
80107174:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107175:	e9 26 d8 ff ff       	jmp    801049a0 <memmove>
    panic("inituvm: more than a page");
8010717a:	83 ec 0c             	sub    $0xc,%esp
8010717d:	68 c1 8d 10 80       	push   $0x80108dc1
80107182:	e8 f9 91 ff ff       	call   80100380 <panic>
80107187:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010718e:	66 90                	xchg   %ax,%ax

80107190 <loaduvm>:
{
80107190:	55                   	push   %ebp
80107191:	89 e5                	mov    %esp,%ebp
80107193:	57                   	push   %edi
80107194:	56                   	push   %esi
80107195:	53                   	push   %ebx
80107196:	83 ec 1c             	sub    $0x1c,%esp
80107199:	8b 45 0c             	mov    0xc(%ebp),%eax
8010719c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
8010719f:	a9 ff 0f 00 00       	test   $0xfff,%eax
801071a4:	0f 85 bb 00 00 00    	jne    80107265 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
801071aa:	01 f0                	add    %esi,%eax
801071ac:	89 f3                	mov    %esi,%ebx
801071ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801071b1:	8b 45 14             	mov    0x14(%ebp),%eax
801071b4:	01 f0                	add    %esi,%eax
801071b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801071b9:	85 f6                	test   %esi,%esi
801071bb:	0f 84 87 00 00 00    	je     80107248 <loaduvm+0xb8>
801071c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
801071c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
801071cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
801071ce:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
801071d0:	89 c2                	mov    %eax,%edx
801071d2:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801071d5:	8b 14 91             	mov    (%ecx,%edx,4),%edx
801071d8:	f6 c2 01             	test   $0x1,%dl
801071db:	75 13                	jne    801071f0 <loaduvm+0x60>
      panic("loaduvm: address should exist");
801071dd:	83 ec 0c             	sub    $0xc,%esp
801071e0:	68 db 8d 10 80       	push   $0x80108ddb
801071e5:	e8 96 91 ff ff       	call   80100380 <panic>
801071ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801071f0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801071f3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801071f9:	25 fc 0f 00 00       	and    $0xffc,%eax
801071fe:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107205:	85 c0                	test   %eax,%eax
80107207:	74 d4                	je     801071dd <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80107209:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010720b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
8010720e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107213:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107218:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010721e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107221:	29 d9                	sub    %ebx,%ecx
80107223:	05 00 00 00 80       	add    $0x80000000,%eax
80107228:	57                   	push   %edi
80107229:	51                   	push   %ecx
8010722a:	50                   	push   %eax
8010722b:	ff 75 10             	push   0x10(%ebp)
8010722e:	e8 5d a8 ff ff       	call   80101a90 <readi>
80107233:	83 c4 10             	add    $0x10,%esp
80107236:	39 f8                	cmp    %edi,%eax
80107238:	75 1e                	jne    80107258 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
8010723a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107240:	89 f0                	mov    %esi,%eax
80107242:	29 d8                	sub    %ebx,%eax
80107244:	39 c6                	cmp    %eax,%esi
80107246:	77 80                	ja     801071c8 <loaduvm+0x38>
}
80107248:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010724b:	31 c0                	xor    %eax,%eax
}
8010724d:	5b                   	pop    %ebx
8010724e:	5e                   	pop    %esi
8010724f:	5f                   	pop    %edi
80107250:	5d                   	pop    %ebp
80107251:	c3                   	ret    
80107252:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107258:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010725b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107260:	5b                   	pop    %ebx
80107261:	5e                   	pop    %esi
80107262:	5f                   	pop    %edi
80107263:	5d                   	pop    %ebp
80107264:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80107265:	83 ec 0c             	sub    $0xc,%esp
80107268:	68 7c 8e 10 80       	push   $0x80108e7c
8010726d:	e8 0e 91 ff ff       	call   80100380 <panic>
80107272:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107280 <allocuvm>:
{
80107280:	55                   	push   %ebp
80107281:	89 e5                	mov    %esp,%ebp
80107283:	57                   	push   %edi
80107284:	56                   	push   %esi
80107285:	53                   	push   %ebx
80107286:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107289:	8b 7d 10             	mov    0x10(%ebp),%edi
8010728c:	85 ff                	test   %edi,%edi
8010728e:	0f 88 bc 00 00 00    	js     80107350 <allocuvm+0xd0>
  if(newsz < oldsz)
80107294:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107297:	0f 82 a3 00 00 00    	jb     80107340 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010729d:	8b 45 0c             	mov    0xc(%ebp),%eax
801072a0:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
801072a6:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
801072ac:	39 75 10             	cmp    %esi,0x10(%ebp)
801072af:	0f 86 8e 00 00 00    	jbe    80107343 <allocuvm+0xc3>
801072b5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801072b8:	8b 7d 08             	mov    0x8(%ebp),%edi
801072bb:	eb 43                	jmp    80107300 <allocuvm+0x80>
801072bd:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
801072c0:	83 ec 04             	sub    $0x4,%esp
801072c3:	68 00 10 00 00       	push   $0x1000
801072c8:	6a 00                	push   $0x0
801072ca:	50                   	push   %eax
801072cb:	e8 30 d6 ff ff       	call   80104900 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801072d0:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801072d6:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
801072dd:	50                   	push   %eax
801072de:	68 00 10 00 00       	push   $0x1000
801072e3:	56                   	push   %esi
801072e4:	57                   	push   %edi
801072e5:	e8 16 fc ff ff       	call   80106f00 <mappages>
801072ea:	83 c4 20             	add    $0x20,%esp
801072ed:	85 c0                	test   %eax,%eax
801072ef:	78 6f                	js     80107360 <allocuvm+0xe0>
  for(; a < newsz; a += PGSIZE){
801072f1:	81 c6 00 10 00 00    	add    $0x1000,%esi
801072f7:	39 75 10             	cmp    %esi,0x10(%ebp)
801072fa:	0f 86 a0 00 00 00    	jbe    801073a0 <allocuvm+0x120>
    mem = kalloc();
80107300:	e8 7b b3 ff ff       	call   80102680 <kalloc>
80107305:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107307:	85 c0                	test   %eax,%eax
80107309:	75 b5                	jne    801072c0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010730b:	83 ec 0c             	sub    $0xc,%esp
8010730e:	68 f9 8d 10 80       	push   $0x80108df9
80107313:	e8 88 93 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80107318:	8b 45 0c             	mov    0xc(%ebp),%eax
8010731b:	83 c4 10             	add    $0x10,%esp
8010731e:	39 45 10             	cmp    %eax,0x10(%ebp)
80107321:	74 2d                	je     80107350 <allocuvm+0xd0>
80107323:	8b 55 10             	mov    0x10(%ebp),%edx
80107326:	89 c1                	mov    %eax,%ecx
80107328:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
8010732b:	31 ff                	xor    %edi,%edi
8010732d:	e8 fe f9 ff ff       	call   80106d30 <deallocuvm.part.0>
}
80107332:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107335:	89 f8                	mov    %edi,%eax
80107337:	5b                   	pop    %ebx
80107338:	5e                   	pop    %esi
80107339:	5f                   	pop    %edi
8010733a:	5d                   	pop    %ebp
8010733b:	c3                   	ret    
8010733c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107340:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80107343:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107346:	89 f8                	mov    %edi,%eax
80107348:	5b                   	pop    %ebx
80107349:	5e                   	pop    %esi
8010734a:	5f                   	pop    %edi
8010734b:	5d                   	pop    %ebp
8010734c:	c3                   	ret    
8010734d:	8d 76 00             	lea    0x0(%esi),%esi
80107350:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80107353:	31 ff                	xor    %edi,%edi
}
80107355:	5b                   	pop    %ebx
80107356:	89 f8                	mov    %edi,%eax
80107358:	5e                   	pop    %esi
80107359:	5f                   	pop    %edi
8010735a:	5d                   	pop    %ebp
8010735b:	c3                   	ret    
8010735c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("allocuvm out of memory (2)\n");
80107360:	83 ec 0c             	sub    $0xc,%esp
80107363:	68 11 8e 10 80       	push   $0x80108e11
80107368:	e8 33 93 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
8010736d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107370:	83 c4 10             	add    $0x10,%esp
80107373:	39 45 10             	cmp    %eax,0x10(%ebp)
80107376:	74 0d                	je     80107385 <allocuvm+0x105>
80107378:	89 c1                	mov    %eax,%ecx
8010737a:	8b 55 10             	mov    0x10(%ebp),%edx
8010737d:	8b 45 08             	mov    0x8(%ebp),%eax
80107380:	e8 ab f9 ff ff       	call   80106d30 <deallocuvm.part.0>
      kfree(mem);
80107385:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80107388:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010738a:	53                   	push   %ebx
8010738b:	e8 30 b1 ff ff       	call   801024c0 <kfree>
      return 0;
80107390:	83 c4 10             	add    $0x10,%esp
}
80107393:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107396:	89 f8                	mov    %edi,%eax
80107398:	5b                   	pop    %ebx
80107399:	5e                   	pop    %esi
8010739a:	5f                   	pop    %edi
8010739b:	5d                   	pop    %ebp
8010739c:	c3                   	ret    
8010739d:	8d 76 00             	lea    0x0(%esi),%esi
801073a0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801073a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073a6:	5b                   	pop    %ebx
801073a7:	5e                   	pop    %esi
801073a8:	89 f8                	mov    %edi,%eax
801073aa:	5f                   	pop    %edi
801073ab:	5d                   	pop    %ebp
801073ac:	c3                   	ret    
801073ad:	8d 76 00             	lea    0x0(%esi),%esi

801073b0 <deallocuvm>:
{
801073b0:	55                   	push   %ebp
801073b1:	89 e5                	mov    %esp,%ebp
801073b3:	8b 55 0c             	mov    0xc(%ebp),%edx
801073b6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801073b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801073bc:	39 d1                	cmp    %edx,%ecx
801073be:	73 10                	jae    801073d0 <deallocuvm+0x20>
}
801073c0:	5d                   	pop    %ebp
801073c1:	e9 6a f9 ff ff       	jmp    80106d30 <deallocuvm.part.0>
801073c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073cd:	8d 76 00             	lea    0x0(%esi),%esi
801073d0:	89 d0                	mov    %edx,%eax
801073d2:	5d                   	pop    %ebp
801073d3:	c3                   	ret    
801073d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801073df:	90                   	nop

801073e0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801073e0:	55                   	push   %ebp
801073e1:	89 e5                	mov    %esp,%ebp
801073e3:	57                   	push   %edi
801073e4:	56                   	push   %esi
801073e5:	53                   	push   %ebx
801073e6:	83 ec 0c             	sub    $0xc,%esp
801073e9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801073ec:	85 f6                	test   %esi,%esi
801073ee:	74 59                	je     80107449 <freevm+0x69>
  if(newsz >= oldsz)
801073f0:	31 c9                	xor    %ecx,%ecx
801073f2:	ba 00 00 00 60       	mov    $0x60000000,%edx
801073f7:	89 f0                	mov    %esi,%eax
801073f9:	89 f3                	mov    %esi,%ebx
801073fb:	e8 30 f9 ff ff       	call   80106d30 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, 0x60000000, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107400:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107406:	eb 0f                	jmp    80107417 <freevm+0x37>
80107408:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010740f:	90                   	nop
80107410:	83 c3 04             	add    $0x4,%ebx
80107413:	39 df                	cmp    %ebx,%edi
80107415:	74 23                	je     8010743a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107417:	8b 03                	mov    (%ebx),%eax
80107419:	a8 01                	test   $0x1,%al
8010741b:	74 f3                	je     80107410 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010741d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107422:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107425:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107428:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010742d:	50                   	push   %eax
8010742e:	e8 8d b0 ff ff       	call   801024c0 <kfree>
80107433:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107436:	39 df                	cmp    %ebx,%edi
80107438:	75 dd                	jne    80107417 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010743a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010743d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107440:	5b                   	pop    %ebx
80107441:	5e                   	pop    %esi
80107442:	5f                   	pop    %edi
80107443:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107444:	e9 77 b0 ff ff       	jmp    801024c0 <kfree>
    panic("freevm: no pgdir");
80107449:	83 ec 0c             	sub    $0xc,%esp
8010744c:	68 2d 8e 10 80       	push   $0x80108e2d
80107451:	e8 2a 8f ff ff       	call   80100380 <panic>
80107456:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010745d:	8d 76 00             	lea    0x0(%esi),%esi

80107460 <setupkvm>:
{
80107460:	55                   	push   %ebp
80107461:	89 e5                	mov    %esp,%ebp
80107463:	56                   	push   %esi
80107464:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107465:	e8 16 b2 ff ff       	call   80102680 <kalloc>
8010746a:	89 c6                	mov    %eax,%esi
8010746c:	85 c0                	test   %eax,%eax
8010746e:	74 42                	je     801074b2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107470:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107473:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
80107478:	68 00 10 00 00       	push   $0x1000
8010747d:	6a 00                	push   $0x0
8010747f:	50                   	push   %eax
80107480:	e8 7b d4 ff ff       	call   80104900 <memset>
80107485:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107488:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010748b:	8b 53 08             	mov    0x8(%ebx),%edx
8010748e:	83 ec 0c             	sub    $0xc,%esp
80107491:	ff 73 0c             	push   0xc(%ebx)
80107494:	29 c2                	sub    %eax,%edx
80107496:	50                   	push   %eax
80107497:	52                   	push   %edx
80107498:	ff 33                	push   (%ebx)
8010749a:	56                   	push   %esi
8010749b:	e8 60 fa ff ff       	call   80106f00 <mappages>
801074a0:	83 c4 20             	add    $0x20,%esp
801074a3:	85 c0                	test   %eax,%eax
801074a5:	78 19                	js     801074c0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801074a7:	83 c3 10             	add    $0x10,%ebx
801074aa:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
801074b0:	75 d6                	jne    80107488 <setupkvm+0x28>
}
801074b2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801074b5:	89 f0                	mov    %esi,%eax
801074b7:	5b                   	pop    %ebx
801074b8:	5e                   	pop    %esi
801074b9:	5d                   	pop    %ebp
801074ba:	c3                   	ret    
801074bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801074bf:	90                   	nop
      freevm(pgdir);
801074c0:	83 ec 0c             	sub    $0xc,%esp
801074c3:	56                   	push   %esi
      return 0;
801074c4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801074c6:	e8 15 ff ff ff       	call   801073e0 <freevm>
      return 0;
801074cb:	83 c4 10             	add    $0x10,%esp
}
801074ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801074d1:	89 f0                	mov    %esi,%eax
801074d3:	5b                   	pop    %ebx
801074d4:	5e                   	pop    %esi
801074d5:	5d                   	pop    %ebp
801074d6:	c3                   	ret    
801074d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074de:	66 90                	xchg   %ax,%ax

801074e0 <kvmalloc>:
{
801074e0:	55                   	push   %ebp
801074e1:	89 e5                	mov    %esp,%ebp
801074e3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801074e6:	e8 75 ff ff ff       	call   80107460 <setupkvm>
801074eb:	a3 c4 b6 11 80       	mov    %eax,0x8011b6c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801074f0:	05 00 00 00 80       	add    $0x80000000,%eax
801074f5:	0f 22 d8             	mov    %eax,%cr3
}
801074f8:	c9                   	leave  
801074f9:	c3                   	ret    
801074fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107500 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107500:	55                   	push   %ebp
80107501:	89 e5                	mov    %esp,%ebp
80107503:	83 ec 08             	sub    $0x8,%esp
80107506:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107509:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010750c:	89 c1                	mov    %eax,%ecx
8010750e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107511:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107514:	f6 c2 01             	test   $0x1,%dl
80107517:	75 17                	jne    80107530 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107519:	83 ec 0c             	sub    $0xc,%esp
8010751c:	68 3e 8e 10 80       	push   $0x80108e3e
80107521:	e8 5a 8e ff ff       	call   80100380 <panic>
80107526:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010752d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107530:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107533:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107539:	25 fc 0f 00 00       	and    $0xffc,%eax
8010753e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107545:	85 c0                	test   %eax,%eax
80107547:	74 d0                	je     80107519 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107549:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010754c:	c9                   	leave  
8010754d:	c3                   	ret    
8010754e:	66 90                	xchg   %ax,%ax

80107550 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107550:	55                   	push   %ebp
80107551:	89 e5                	mov    %esp,%ebp
80107553:	57                   	push   %edi
80107554:	56                   	push   %esi
80107555:	53                   	push   %ebx
80107556:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107559:	e8 02 ff ff ff       	call   80107460 <setupkvm>
8010755e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107561:	85 c0                	test   %eax,%eax
80107563:	0f 84 c0 00 00 00    	je     80107629 <copyuvm+0xd9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107569:	8b 55 0c             	mov    0xc(%ebp),%edx
8010756c:	85 d2                	test   %edx,%edx
8010756e:	0f 84 b5 00 00 00    	je     80107629 <copyuvm+0xd9>
80107574:	31 f6                	xor    %esi,%esi
80107576:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010757d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80107580:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107583:	89 f0                	mov    %esi,%eax
80107585:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107588:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010758b:	a8 01                	test   $0x1,%al
8010758d:	75 11                	jne    801075a0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010758f:	83 ec 0c             	sub    $0xc,%esp
80107592:	68 48 8e 10 80       	push   $0x80108e48
80107597:	e8 e4 8d ff ff       	call   80100380 <panic>
8010759c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
801075a0:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801075a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801075a7:	c1 ea 0a             	shr    $0xa,%edx
801075aa:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801075b0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801075b7:	85 c0                	test   %eax,%eax
801075b9:	74 d4                	je     8010758f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
801075bb:	8b 38                	mov    (%eax),%edi
801075bd:	f7 c7 01 00 00 00    	test   $0x1,%edi
801075c3:	0f 84 9b 00 00 00    	je     80107664 <copyuvm+0x114>
    //   }
    // }
    // if (j != 16) {
    //   continue;
    // }
    pa = PTE_ADDR(*pte);
801075c9:	89 fb                	mov    %edi,%ebx
    flags = PTE_FLAGS(*pte);
801075cb:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
801075d1:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
801075d4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    if((mem = kalloc()) == 0)
801075da:	e8 a1 b0 ff ff       	call   80102680 <kalloc>
801075df:	89 c7                	mov    %eax,%edi
801075e1:	85 c0                	test   %eax,%eax
801075e3:	74 5f                	je     80107644 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801075e5:	83 ec 04             	sub    $0x4,%esp
801075e8:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801075ee:	68 00 10 00 00       	push   $0x1000
801075f3:	53                   	push   %ebx
801075f4:	50                   	push   %eax
801075f5:	e8 a6 d3 ff ff       	call   801049a0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801075fa:	58                   	pop    %eax
801075fb:	8d 87 00 00 00 80    	lea    -0x80000000(%edi),%eax
80107601:	ff 75 e4             	push   -0x1c(%ebp)
80107604:	50                   	push   %eax
80107605:	68 00 10 00 00       	push   $0x1000
8010760a:	56                   	push   %esi
8010760b:	ff 75 e0             	push   -0x20(%ebp)
8010760e:	e8 ed f8 ff ff       	call   80106f00 <mappages>
80107613:	83 c4 20             	add    $0x20,%esp
80107616:	85 c0                	test   %eax,%eax
80107618:	78 1e                	js     80107638 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
8010761a:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107620:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107623:	0f 87 57 ff ff ff    	ja     80107580 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107629:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010762c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010762f:	5b                   	pop    %ebx
80107630:	5e                   	pop    %esi
80107631:	5f                   	pop    %edi
80107632:	5d                   	pop    %ebp
80107633:	c3                   	ret    
80107634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107638:	83 ec 0c             	sub    $0xc,%esp
8010763b:	57                   	push   %edi
8010763c:	e8 7f ae ff ff       	call   801024c0 <kfree>
      goto bad;
80107641:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107644:	83 ec 0c             	sub    $0xc,%esp
80107647:	ff 75 e0             	push   -0x20(%ebp)
8010764a:	e8 91 fd ff ff       	call   801073e0 <freevm>
  return 0;
8010764f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107656:	83 c4 10             	add    $0x10,%esp
}
80107659:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010765c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010765f:	5b                   	pop    %ebx
80107660:	5e                   	pop    %esi
80107661:	5f                   	pop    %edi
80107662:	5d                   	pop    %ebp
80107663:	c3                   	ret    
      panic("copyuvm: page not present");
80107664:	83 ec 0c             	sub    $0xc,%esp
80107667:	68 62 8e 10 80       	push   $0x80108e62
8010766c:	e8 0f 8d ff ff       	call   80100380 <panic>
80107671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107678:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010767f:	90                   	nop

80107680 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107680:	55                   	push   %ebp
80107681:	89 e5                	mov    %esp,%ebp
80107683:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107686:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107689:	89 c1                	mov    %eax,%ecx
8010768b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010768e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107691:	f6 c2 01             	test   $0x1,%dl
80107694:	0f 84 00 01 00 00    	je     8010779a <uva2ka.cold>
  return &pgtab[PTX(va)];
8010769a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010769d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801076a3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
801076a4:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
801076a9:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
801076b0:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801076b2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801076b7:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801076ba:	05 00 00 00 80       	add    $0x80000000,%eax
801076bf:	83 fa 05             	cmp    $0x5,%edx
801076c2:	ba 00 00 00 00       	mov    $0x0,%edx
801076c7:	0f 45 c2             	cmovne %edx,%eax
}
801076ca:	c3                   	ret    
801076cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801076cf:	90                   	nop

801076d0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801076d0:	55                   	push   %ebp
801076d1:	89 e5                	mov    %esp,%ebp
801076d3:	57                   	push   %edi
801076d4:	56                   	push   %esi
801076d5:	53                   	push   %ebx
801076d6:	83 ec 0c             	sub    $0xc,%esp
801076d9:	8b 75 14             	mov    0x14(%ebp),%esi
801076dc:	8b 45 0c             	mov    0xc(%ebp),%eax
801076df:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801076e2:	85 f6                	test   %esi,%esi
801076e4:	75 51                	jne    80107737 <copyout+0x67>
801076e6:	e9 a5 00 00 00       	jmp    80107790 <copyout+0xc0>
801076eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801076ef:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
801076f0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801076f6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
801076fc:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107702:	74 75                	je     80107779 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
80107704:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107706:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80107709:	29 c3                	sub    %eax,%ebx
8010770b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107711:	39 f3                	cmp    %esi,%ebx
80107713:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80107716:	29 f8                	sub    %edi,%eax
80107718:	83 ec 04             	sub    $0x4,%esp
8010771b:	01 c1                	add    %eax,%ecx
8010771d:	53                   	push   %ebx
8010771e:	52                   	push   %edx
8010771f:	51                   	push   %ecx
80107720:	e8 7b d2 ff ff       	call   801049a0 <memmove>
    len -= n;
    buf += n;
80107725:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107728:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010772e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107731:	01 da                	add    %ebx,%edx
  while(len > 0){
80107733:	29 de                	sub    %ebx,%esi
80107735:	74 59                	je     80107790 <copyout+0xc0>
  if(*pde & PTE_P){
80107737:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010773a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010773c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010773e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107741:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107747:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010774a:	f6 c1 01             	test   $0x1,%cl
8010774d:	0f 84 4e 00 00 00    	je     801077a1 <copyout.cold>
  return &pgtab[PTX(va)];
80107753:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107755:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010775b:	c1 eb 0c             	shr    $0xc,%ebx
8010775e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107764:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010776b:	89 d9                	mov    %ebx,%ecx
8010776d:	83 e1 05             	and    $0x5,%ecx
80107770:	83 f9 05             	cmp    $0x5,%ecx
80107773:	0f 84 77 ff ff ff    	je     801076f0 <copyout+0x20>
  }
  return 0;
}
80107779:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010777c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107781:	5b                   	pop    %ebx
80107782:	5e                   	pop    %esi
80107783:	5f                   	pop    %edi
80107784:	5d                   	pop    %ebp
80107785:	c3                   	ret    
80107786:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010778d:	8d 76 00             	lea    0x0(%esi),%esi
80107790:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107793:	31 c0                	xor    %eax,%eax
}
80107795:	5b                   	pop    %ebx
80107796:	5e                   	pop    %esi
80107797:	5f                   	pop    %edi
80107798:	5d                   	pop    %ebp
80107799:	c3                   	ret    

8010779a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
8010779a:	a1 00 00 00 00       	mov    0x0,%eax
8010779f:	0f 0b                	ud2    

801077a1 <copyout.cold>:
801077a1:	a1 00 00 00 00       	mov    0x0,%eax
801077a6:	0f 0b                	ud2    
801077a8:	66 90                	xchg   %ax,%ax
801077aa:	66 90                	xchg   %ax,%ax
801077ac:	66 90                	xchg   %ax,%ax
801077ae:	66 90                	xchg   %ax,%ax

801077b0 <wmap>:
#include "sleeplock.h"
#include "fs.h"
#include "file.h"

uint wmap(uint addr, int length, int flags, int fd)
{
801077b0:	55                   	push   %ebp
801077b1:	89 e5                	mov    %esp,%ebp
801077b3:	57                   	push   %edi
801077b4:	56                   	push   %esi
801077b5:	53                   	push   %ebx
801077b6:	83 ec 2c             	sub    $0x2c,%esp
  if (length <= 0)
801077b9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
801077bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (length <= 0)
801077bf:	85 f6                	test   %esi,%esi
801077c1:	0f 8e 30 02 00 00    	jle    801079f7 <wmap+0x247>
  {
    cprintf("Length less or equal to 0\n");
    return -1;
  }
  struct proc *p = myproc();
801077c7:	e8 04 c2 ff ff       	call   801039d0 <myproc>
  // cprintf("proc parent: %d\n", p->parent->pid);
  // cprintf("curr proc id: %d\n", p->pid);
  // cprintf("addr requested: %x\n", addr);
  if (p->memory_used + length > 0x20000000)
801077cc:	89 c7                	mov    %eax,%edi
  struct proc *p = myproc();
801077ce:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if (p->memory_used + length > 0x20000000)
801077d1:	8b 45 0c             	mov    0xc(%ebp),%eax
801077d4:	03 87 bc 01 00 00    	add    0x1bc(%edi),%eax
801077da:	3d 00 00 00 20       	cmp    $0x20000000,%eax
801077df:	0f 8f 31 02 00 00    	jg     80107a16 <wmap+0x266>
  {
    cprintf("Not enough memory\n");
    return -1;
  }
  if (addr < 0x60000000 || addr + length - 1 >= 0x80000000)
801077e5:	81 fb ff ff ff 5f    	cmp    $0x5fffffff,%ebx
801077eb:	0f 86 a2 01 00 00    	jbe    80107993 <wmap+0x1e3>
801077f1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801077f4:	01 d9                	add    %ebx,%ecx
801077f6:	89 c8                	mov    %ecx,%eax
801077f8:	83 e8 01             	sub    $0x1,%eax
801077fb:	0f 88 92 01 00 00    	js     80107993 <wmap+0x1e3>
  {
    cprintf("Wrong address");
    return -1;
  }
  if (flags & MAP_FIXED)
80107801:	f6 45 10 08          	testb  $0x8,0x10(%ebp)
80107805:	0f 84 7e 00 00 00    	je     80107889 <wmap+0xd9>
8010780b:	8b 7d dc             	mov    -0x24(%ebp),%edi
8010780e:	8d 87 80 00 00 00    	lea    0x80(%edi),%eax
80107814:	8d b7 c0 01 00 00    	lea    0x1c0(%edi),%esi
8010781a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  {
    for (int i = 0; i < 16; ++i)
    {
      if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size > addr + length))
80107820:	8b 50 fc             	mov    -0x4(%eax),%edx
80107823:	39 da                	cmp    %ebx,%edx
80107825:	77 0c                	ja     80107833 <wmap+0x83>
80107827:	8b 38                	mov    (%eax),%edi
80107829:	01 d7                	add    %edx,%edi
8010782b:	39 df                	cmp    %ebx,%edi
8010782d:	0f 87 02 02 00 00    	ja     80107a35 <wmap+0x285>
80107833:	39 d1                	cmp    %edx,%ecx
80107835:	76 0a                	jbe    80107841 <wmap+0x91>
80107837:	03 10                	add    (%eax),%edx
80107839:	39 d1                	cmp    %edx,%ecx
8010783b:	0f 82 f4 01 00 00    	jb     80107a35 <wmap+0x285>
    for (int i = 0; i < 16; ++i)
80107841:	83 c0 14             	add    $0x14,%eax
80107844:	39 f0                	cmp    %esi,%eax
80107846:	75 d8                	jne    80107820 <wmap+0x70>
80107848:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010784b:	83 c0 7c             	add    $0x7c,%eax
8010784e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80107851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    // cprintf("\t-Done. Final addr 0x%x\n", addr);
  }

  // cprintf("pid in wmap: %d\n",p->pid);
  for (int i = 0; i < 16; ++i)
80107858:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010785b:	31 d2                	xor    %edx,%edx
8010785d:	8d 76 00             	lea    0x0(%esi),%esi
  {

    if (p->addr[i].va == 0)
80107860:	8b 08                	mov    (%eax),%ecx
80107862:	85 c9                	test   %ecx,%ecx
80107864:	0f 84 48 01 00 00    	je     801079b2 <wmap+0x202>
  for (int i = 0; i < 16; ++i)
8010786a:	83 c2 01             	add    $0x1,%edx
8010786d:	83 c0 14             	add    $0x14,%eax
80107870:	83 fa 10             	cmp    $0x10,%edx
80107873:	75 eb                	jne    80107860 <wmap+0xb0>
      p->addr[i].fd = fd;
      // p->addr[i].access += 1;
      break;
    }
  }
  p->n_mmaps += 1;
80107875:	8b 45 dc             	mov    -0x24(%ebp),%eax
80107878:	83 80 c0 01 00 00 01 	addl   $0x1,0x1c0(%eax)
  //   cprintf("addr[0]\nva = 0x%x\nlength = %d\nflags = %d\nfd = %d\n", p->addr[i].va, p->addr[i].size, p->addr[i].flags, p->addr[i].fd);
  // }
  // struct address* head = myproc()->head;
  // cprintf("adding addr %x to index of maps:\n", addr);
  return addr;
}
8010787f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107882:	89 d8                	mov    %ebx,%eax
80107884:	5b                   	pop    %ebx
80107885:	5e                   	pop    %esi
80107886:	5f                   	pop    %edi
80107887:	5d                   	pop    %ebp
80107888:	c3                   	ret    
80107889:	8b 5d dc             	mov    -0x24(%ebp),%ebx
    int num_va = 0;
8010788c:	31 c9                	xor    %ecx,%ecx
8010788e:	8d 43 7c             	lea    0x7c(%ebx),%eax
80107891:	8d 93 bc 01 00 00    	lea    0x1bc(%ebx),%edx
80107897:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010789a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        ++num_va;
801078a0:	83 38 01             	cmpl   $0x1,(%eax)
801078a3:	83 d9 ff             	sbb    $0xffffffff,%ecx
    for (int k = 0; k < 16; ++k)
801078a6:	83 c0 14             	add    $0x14,%eax
801078a9:	39 c2                	cmp    %eax,%edx
801078ab:	75 f3                	jne    801078a0 <wmap+0xf0>
801078ad:	8b 45 dc             	mov    -0x24(%ebp),%eax
    int count = 0;
801078b0:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    addr = 0x60000000;
801078b3:	bb 00 00 00 60       	mov    $0x60000000,%ebx
    int count = 0;
801078b8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801078bf:	83 e8 80             	sub    $0xffffff80,%eax
801078c2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801078c5:	8d 76 00             	lea    0x0(%esi),%esi
        if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size >= addr + length) || ((addr < p->addr[i].va) && ((addr + length) > p->addr[i].va)))
801078c8:	8b 7d 0c             	mov    0xc(%ebp),%edi
801078cb:	8b 55 e0             	mov    -0x20(%ebp),%edx
      for (i = 0; i < 16; ++i)
801078ce:	31 c9                	xor    %ecx,%ecx
        if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size >= addr + length) || ((addr < p->addr[i].va) && ((addr + length) > p->addr[i].va)))
801078d0:	01 df                	add    %ebx,%edi
801078d2:	eb 2b                	jmp    801078ff <wmap+0x14f>
801078d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801078d8:	8b 32                	mov    (%edx),%esi
801078da:	01 c6                	add    %eax,%esi
801078dc:	39 de                	cmp    %ebx,%esi
801078de:	77 36                	ja     80107916 <wmap+0x166>
801078e0:	39 f8                	cmp    %edi,%eax
801078e2:	73 0c                	jae    801078f0 <wmap+0x140>
801078e4:	39 fe                	cmp    %edi,%esi
801078e6:	73 2e                	jae    80107916 <wmap+0x166>
801078e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801078ef:	90                   	nop
      for (i = 0; i < 16; ++i)
801078f0:	83 c1 01             	add    $0x1,%ecx
801078f3:	83 c2 14             	add    $0x14,%edx
801078f6:	83 f9 10             	cmp    $0x10,%ecx
801078f9:	0f 84 59 ff ff ff    	je     80107858 <wmap+0xa8>
        if (p->addr[i].va == 0)
801078ff:	8b 42 fc             	mov    -0x4(%edx),%eax
80107902:	85 c0                	test   %eax,%eax
80107904:	74 ea                	je     801078f0 <wmap+0x140>
        if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size >= addr + length) || ((addr < p->addr[i].va) && ((addr + length) > p->addr[i].va)))
80107906:	39 d8                	cmp    %ebx,%eax
80107908:	76 ce                	jbe    801078d8 <wmap+0x128>
8010790a:	39 f8                	cmp    %edi,%eax
8010790c:	73 e2                	jae    801078f0 <wmap+0x140>
8010790e:	8b 32                	mov    (%edx),%esi
80107910:	01 c6                	add    %eax,%esi
80107912:	39 f7                	cmp    %esi,%edi
80107914:	77 6c                	ja     80107982 <wmap+0x1d2>
            addr = 0x60000000;
80107916:	bb 00 00 00 60       	mov    $0x60000000,%ebx
          if (p->addr[i].va + p->addr[i].size == 0x80000000)
8010791b:	81 fe 00 00 00 80    	cmp    $0x80000000,%esi
80107921:	74 1e                	je     80107941 <wmap+0x191>
            if (addr + length > 0x80000000)
80107923:	8b 45 0c             	mov    0xc(%ebp),%eax
            addr = PGROUNDUP(p->addr[i].va + p->addr[i].size);
80107926:	8d 9e ff 0f 00 00    	lea    0xfff(%esi),%ebx
8010792c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
            if (addr + length > 0x80000000)
80107932:	01 d8                	add    %ebx,%eax
            addr = 0x60000000;
80107934:	3d 00 00 00 80       	cmp    $0x80000000,%eax
80107939:	b8 00 00 00 60       	mov    $0x60000000,%eax
8010793e:	0f 47 d8             	cmova  %eax,%ebx
          cprintf("\t-New addr after if against addr[%d] is 0x%x\n", i, addr);
80107941:	83 ec 04             	sub    $0x4,%esp
80107944:	53                   	push   %ebx
80107945:	51                   	push   %ecx
80107946:	68 9c 8f 10 80       	push   $0x80108f9c
8010794b:	e8 50 8d ff ff       	call   801006a0 <cprintf>
      ++count;
80107950:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
      else if (count > num_va)
80107954:	83 c4 10             	add    $0x10,%esp
      ++count;
80107957:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      else if (count > num_va)
8010795a:	39 45 d8             	cmp    %eax,-0x28(%ebp)
8010795d:	0f 8d 65 ff ff ff    	jge    801078c8 <wmap+0x118>
        cprintf("Not enough contiguous memory\n");
80107963:	83 ec 0c             	sub    $0xc,%esp
        return -1;
80107966:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
        cprintf("Not enough contiguous memory\n");
8010796b:	68 db 8e 10 80       	push   $0x80108edb
80107970:	e8 2b 8d ff ff       	call   801006a0 <cprintf>
        return -1;
80107975:	83 c4 10             	add    $0x10,%esp
}
80107978:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010797b:	89 d8                	mov    %ebx,%eax
8010797d:	5b                   	pop    %ebx
8010797e:	5e                   	pop    %esi
8010797f:	5f                   	pop    %edi
80107980:	5d                   	pop    %ebp
80107981:	c3                   	ret    
        if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size >= addr + length) || ((addr < p->addr[i].va) && ((addr + length) > p->addr[i].va)))
80107982:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80107985:	8d 14 89             	lea    (%ecx,%ecx,4),%edx
80107988:	03 84 93 80 00 00 00 	add    0x80(%ebx,%edx,4),%eax
8010798f:	89 c6                	mov    %eax,%esi
80107991:	eb 83                	jmp    80107916 <wmap+0x166>
    cprintf("Wrong address");
80107993:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80107996:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    cprintf("Wrong address");
8010799b:	68 cd 8e 10 80       	push   $0x80108ecd
801079a0:	e8 fb 8c ff ff       	call   801006a0 <cprintf>
    return -1;
801079a5:	83 c4 10             	add    $0x10,%esp
}
801079a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079ab:	89 d8                	mov    %ebx,%eax
801079ad:	5b                   	pop    %ebx
801079ae:	5e                   	pop    %esi
801079af:	5f                   	pop    %edi
801079b0:	5d                   	pop    %ebp
801079b1:	c3                   	ret    
      p->addr[i].va = addr;
801079b2:	8b 7d dc             	mov    -0x24(%ebp),%edi
801079b5:	8d 04 92             	lea    (%edx,%edx,4),%eax
      cprintf("length = %x\n", length);
801079b8:	83 ec 08             	sub    $0x8,%esp
      p->addr[i].va = addr;
801079bb:	8d 34 87             	lea    (%edi,%eax,4),%esi
801079be:	89 5e 7c             	mov    %ebx,0x7c(%esi)
      cprintf("length = %x\n", length);
801079c1:	ff 75 0c             	push   0xc(%ebp)
801079c4:	68 f9 8e 10 80       	push   $0x80108ef9
801079c9:	e8 d2 8c ff ff       	call   801006a0 <cprintf>
      p->memory_used += length;
801079ce:	8b 45 0c             	mov    0xc(%ebp),%eax
801079d1:	01 87 bc 01 00 00    	add    %eax,0x1bc(%edi)
      break;
801079d7:	83 c4 10             	add    $0x10,%esp
      p->addr[i].size = length;
801079da:	89 86 80 00 00 00    	mov    %eax,0x80(%esi)
      p->addr[i].flags = flags;
801079e0:	8b 45 10             	mov    0x10(%ebp),%eax
801079e3:	89 86 84 00 00 00    	mov    %eax,0x84(%esi)
      p->addr[i].fd = fd;
801079e9:	8b 45 14             	mov    0x14(%ebp),%eax
801079ec:	89 86 88 00 00 00    	mov    %eax,0x88(%esi)
      break;
801079f2:	e9 7e fe ff ff       	jmp    80107875 <wmap+0xc5>
    cprintf("Length less or equal to 0\n");
801079f7:	83 ec 0c             	sub    $0xc,%esp
    return -1;
801079fa:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    cprintf("Length less or equal to 0\n");
801079ff:	68 9f 8e 10 80       	push   $0x80108e9f
80107a04:	e8 97 8c ff ff       	call   801006a0 <cprintf>
    return -1;
80107a09:	83 c4 10             	add    $0x10,%esp
}
80107a0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a0f:	89 d8                	mov    %ebx,%eax
80107a11:	5b                   	pop    %ebx
80107a12:	5e                   	pop    %esi
80107a13:	5f                   	pop    %edi
80107a14:	5d                   	pop    %ebp
80107a15:	c3                   	ret    
    cprintf("Not enough memory\n");
80107a16:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80107a19:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    cprintf("Not enough memory\n");
80107a1e:	68 ba 8e 10 80       	push   $0x80108eba
80107a23:	e8 78 8c ff ff       	call   801006a0 <cprintf>
    return -1;
80107a28:	83 c4 10             	add    $0x10,%esp
}
80107a2b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a2e:	89 d8                	mov    %ebx,%eax
80107a30:	5b                   	pop    %ebx
80107a31:	5e                   	pop    %esi
80107a32:	5f                   	pop    %edi
80107a33:	5d                   	pop    %ebp
80107a34:	c3                   	ret    
        cprintf("Address suggested already in memory\n");
80107a35:	83 ec 0c             	sub    $0xc,%esp
        return -1;
80107a38:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
        cprintf("Address suggested already in memory\n");
80107a3d:	68 74 8f 10 80       	push   $0x80108f74
80107a42:	e8 59 8c ff ff       	call   801006a0 <cprintf>
        return -1;
80107a47:	83 c4 10             	add    $0x10,%esp
80107a4a:	e9 30 fe ff ff       	jmp    8010787f <wmap+0xcf>
80107a4f:	90                   	nop

80107a50 <wunmap>:

int wunmap(uint addr)
{
80107a50:	55                   	push   %ebp
80107a51:	89 e5                	mov    %esp,%ebp
80107a53:	57                   	push   %edi
80107a54:	56                   	push   %esi
80107a55:	53                   	push   %ebx
80107a56:	83 ec 2c             	sub    $0x2c,%esp
80107a59:	8b 5d 08             	mov    0x8(%ebp),%ebx

  struct proc *p = myproc();
80107a5c:	e8 6f bf ff ff       	call   801039d0 <myproc>
  pte_t *pte;
  int boo = 0;
  for (int i = 0; i < 16; ++i) {
80107a61:	31 c9                	xor    %ecx,%ecx
80107a63:	8d 70 7c             	lea    0x7c(%eax),%esi
  struct proc *p = myproc();
80107a66:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for (int i = 0; i < 16; ++i) {
80107a69:	89 75 e0             	mov    %esi,-0x20(%ebp)
  struct proc *p = myproc();
80107a6c:	89 f7                	mov    %esi,%edi
  for (int i = 0; i < 16; ++i) {
80107a6e:	89 ce                	mov    %ecx,%esi
80107a70:	eb 15                	jmp    80107a87 <wunmap+0x37>
80107a72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107a78:	83 c6 01             	add    $0x1,%esi
80107a7b:	83 c7 14             	add    $0x14,%edi
80107a7e:	83 fe 10             	cmp    $0x10,%esi
80107a81:	0f 84 41 01 00 00    	je     80107bc8 <wunmap+0x178>
    // PTE_P present bit && *pte to check if valid and then kfree and 0 it
    cprintf("p->addr[i].va = %x && p->addr[i].phys_page_used = %d expected > 0\n", p->addr[i].va, p->addr[i].phys_page_used);
80107a87:	83 ec 04             	sub    $0x4,%esp
80107a8a:	ff 77 10             	push   0x10(%edi)
80107a8d:	ff 37                	push   (%edi)
80107a8f:	68 cc 8f 10 80       	push   $0x80108fcc
80107a94:	e8 07 8c ff ff       	call   801006a0 <cprintf>
    if (p->addr[i].va == addr && p->addr[i].phys_page_used > 0) {
80107a99:	83 c4 10             	add    $0x10,%esp
80107a9c:	39 1f                	cmp    %ebx,(%edi)
80107a9e:	75 d8                	jne    80107a78 <wunmap+0x28>
80107aa0:	8b 4f 10             	mov    0x10(%edi),%ecx
80107aa3:	85 c9                	test   %ecx,%ecx
80107aa5:	7e d1                	jle    80107a78 <wunmap+0x28>
      cprintf("p->addr[i].flags & MAP_SHARED = %d && p->addr[i].flags & MAP_ANONYNOUS = %d\n", p->addr[i].flags & MAP_SHARED, !(p->addr[i].flags & MAP_ANONYMOUS));
80107aa7:	89 f1                	mov    %esi,%ecx
80107aa9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107aac:	83 ec 04             	sub    $0x4,%esp
80107aaf:	8b 75 e0             	mov    -0x20(%ebp),%esi
80107ab2:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
80107ab5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80107ab8:	8d 3c 82             	lea    (%edx,%eax,4),%edi
80107abb:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107abe:	31 d2                	xor    %edx,%edx
80107ac0:	8b 87 84 00 00 00    	mov    0x84(%edi),%eax
80107ac6:	a8 04                	test   $0x4,%al
80107ac8:	0f 94 c2             	sete   %dl
80107acb:	83 e0 02             	and    $0x2,%eax
80107ace:	52                   	push   %edx
80107acf:	50                   	push   %eax
80107ad0:	68 10 90 10 80       	push   $0x80109010
80107ad5:	e8 c6 8b ff ff       	call   801006a0 <cprintf>
      if (p->addr[i].flags & MAP_SHARED && !(p->addr[i].flags & MAP_ANONYMOUS)) {
80107ada:	8b 87 84 00 00 00    	mov    0x84(%edi),%eax
80107ae0:	83 c4 10             	add    $0x10,%esp
80107ae3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80107ae6:	a8 02                	test   $0x2,%al
80107ae8:	0f 85 22 01 00 00    	jne    80107c10 <wunmap+0x1c0>
          break;
        }
      }
      else {
        // unmap normal
        int size = p->addr[i].size;
80107aee:	8b 87 80 00 00 00    	mov    0x80(%edi),%eax
        int j = 0;
        while (size > 0)
80107af4:	85 c0                	test   %eax,%eax
80107af6:	7e 71                	jle    80107b69 <wunmap+0x119>
80107af8:	83 e8 01             	sub    $0x1,%eax
80107afb:	8d b3 00 10 00 00    	lea    0x1000(%ebx),%esi
80107b01:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80107b04:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107b09:	8d 3c 30             	lea    (%eax,%esi,1),%edi
80107b0c:	89 d8                	mov    %ebx,%eax
80107b0e:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80107b11:	eb 11                	jmp    80107b24 <wunmap+0xd4>
80107b13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107b17:	90                   	nop
80107b18:	89 f0                	mov    %esi,%eax
80107b1a:	39 fe                	cmp    %edi,%esi
80107b1c:	74 48                	je     80107b66 <wunmap+0x116>
80107b1e:	81 c6 00 10 00 00    	add    $0x1000,%esi
        {
          pte = walkpgdir(p->pgdir, (void *)addr + j * PAGE_SIZE, 0);
80107b24:	83 ec 04             	sub    $0x4,%esp
80107b27:	6a 00                	push   $0x0
80107b29:	50                   	push   %eax
80107b2a:	ff 73 04             	push   0x4(%ebx)
80107b2d:	e8 3e f3 ff ff       	call   80106e70 <walkpgdir>
          int physical_address = PTE_ADDR(*pte);
          size -= PAGE_SIZE;
          ++j;
          if (PTE_P & *pte)
80107b32:	83 c4 10             	add    $0x10,%esp
          int physical_address = PTE_ADDR(*pte);
80107b35:	8b 08                	mov    (%eax),%ecx
          if (PTE_P & *pte)
80107b37:	f6 c1 01             	test   $0x1,%cl
80107b3a:	74 dc                	je     80107b18 <wunmap+0xc8>
          int physical_address = PTE_ADDR(*pte);
80107b3c:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
          {
            kfree(P2V(physical_address));
80107b42:	83 ec 0c             	sub    $0xc,%esp
80107b45:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107b48:	81 c1 00 00 00 80    	add    $0x80000000,%ecx
80107b4e:	51                   	push   %ecx
80107b4f:	e8 6c a9 ff ff       	call   801024c0 <kfree>
            *pte = 0;
80107b54:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107b57:	83 c4 10             	add    $0x10,%esp
80107b5a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
        while (size > 0)
80107b60:	89 f0                	mov    %esi,%eax
80107b62:	39 fe                	cmp    %edi,%esi
80107b64:	75 b8                	jne    80107b1e <wunmap+0xce>
80107b66:	8b 4d dc             	mov    -0x24(%ebp),%ecx
          }
        }
        p->addr[i].va = 0;
80107b69:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
80107b6c:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107b6f:	8d 04 81             	lea    (%ecx,%eax,4),%eax
        p->addr[i].flags = 0;
        p->addr[i].fd = 0;
        p->memory_used -= p->addr[i].size;
80107b72:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
        p->addr[i].va = 0;
80107b78:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
        p->addr[i].flags = 0;
80107b7f:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%eax)
80107b86:	00 00 00 
        p->addr[i].fd = 0;
80107b89:	c7 80 88 00 00 00 00 	movl   $0x0,0x88(%eax)
80107b90:	00 00 00 
        p->memory_used -= p->addr[i].size;
80107b93:	29 91 bc 01 00 00    	sub    %edx,0x1bc(%ecx)
        p->addr[i].size = 0;
80107b99:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80107ba0:	00 00 00 
        p->addr[i].phys_page_used = 0;
80107ba3:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
80107baa:	00 00 00 
        p->addr[i].size = 0;
        p->addr[i].phys_page_used = 0;
      }
    }
  }
  p->n_mmaps -= 1;
80107bad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107bb0:	83 a8 c0 01 00 00 01 	subl   $0x1,0x1c0(%eax)
  return 0;
}
80107bb7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107bba:	31 c0                	xor    %eax,%eax
80107bbc:	5b                   	pop    %ebx
80107bbd:	5e                   	pop    %esi
80107bbe:	5f                   	pop    %edi
80107bbf:	5d                   	pop    %ebp
80107bc0:	c3                   	ret    
80107bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107bc8:	8b 75 e0             	mov    -0x20(%ebp),%esi
80107bcb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107bce:	8d 82 bc 01 00 00    	lea    0x1bc(%edx),%eax
80107bd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if (p->addr[i].va == addr)
80107bd8:	39 1e                	cmp    %ebx,(%esi)
80107bda:	75 2b                	jne    80107c07 <wunmap+0x1b7>
        p->memory_used -= p->addr[i].size;
80107bdc:	8b 4e 04             	mov    0x4(%esi),%ecx
        p->addr[i].va = 0;
80107bdf:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
        p->addr[i].flags = 0;
80107be5:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
        p->addr[i].fd = 0;
80107bec:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
        p->memory_used -= p->addr[i].size;
80107bf3:	29 8a bc 01 00 00    	sub    %ecx,0x1bc(%edx)
        p->addr[i].size = 0;
80107bf9:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
        p->addr[i].phys_page_used = 0;
80107c00:	c7 46 10 00 00 00 00 	movl   $0x0,0x10(%esi)
    for (int i = 0; i < 16; ++i)
80107c07:	83 c6 14             	add    $0x14,%esi
80107c0a:	39 f0                	cmp    %esi,%eax
80107c0c:	75 ca                	jne    80107bd8 <wunmap+0x188>
80107c0e:	eb 9d                	jmp    80107bad <wunmap+0x15d>
      if (p->addr[i].flags & MAP_SHARED && !(p->addr[i].flags & MAP_ANONYMOUS)) {
80107c10:	83 e0 04             	and    $0x4,%eax
80107c13:	0f 84 83 00 00 00    	je     80107c9c <wunmap+0x24c>
          if (p->parent->pid == 2) {
80107c19:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107c1c:	8b 40 14             	mov    0x14(%eax),%eax
80107c1f:	83 78 10 02          	cmpl   $0x2,0x10(%eax)
80107c23:	75 a6                	jne    80107bcb <wunmap+0x17b>
          int size = p->addr[i].size;
80107c25:	8b 87 80 00 00 00    	mov    0x80(%edi),%eax
          while (size > 0) {
80107c2b:	85 c0                	test   %eax,%eax
80107c2d:	0f 8e 36 ff ff ff    	jle    80107b69 <wunmap+0x119>
80107c33:	8d 78 ff             	lea    -0x1(%eax),%edi
80107c36:	8d b3 00 10 00 00    	lea    0x1000(%ebx),%esi
80107c3c:	89 d8                	mov    %ebx,%eax
80107c3e:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80107c41:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80107c47:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80107c4a:	01 f7                	add    %esi,%edi
80107c4c:	eb 10                	jmp    80107c5e <wunmap+0x20e>
80107c4e:	89 f0                	mov    %esi,%eax
80107c50:	39 f7                	cmp    %esi,%edi
80107c52:	0f 84 0e ff ff ff    	je     80107b66 <wunmap+0x116>
80107c58:	81 c6 00 10 00 00    	add    $0x1000,%esi
            pte = walkpgdir(p->pgdir, (void *)addr + j * PAGE_SIZE, 0);
80107c5e:	83 ec 04             	sub    $0x4,%esp
80107c61:	6a 00                	push   $0x0
80107c63:	50                   	push   %eax
80107c64:	ff 73 04             	push   0x4(%ebx)
80107c67:	e8 04 f2 ff ff       	call   80106e70 <walkpgdir>
            if (PTE_P & *pte) {
80107c6c:	83 c4 10             	add    $0x10,%esp
            int physical_address = PTE_ADDR(*pte);
80107c6f:	8b 08                	mov    (%eax),%ecx
            if (PTE_P & *pte) {
80107c71:	f6 c1 01             	test   $0x1,%cl
80107c74:	74 d8                	je     80107c4e <wunmap+0x1fe>
            int physical_address = PTE_ADDR(*pte);
80107c76:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
              kfree(P2V(physical_address));
80107c7c:	83 ec 0c             	sub    $0xc,%esp
80107c7f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107c82:	81 c1 00 00 00 80    	add    $0x80000000,%ecx
80107c88:	51                   	push   %ecx
80107c89:	e8 32 a8 ff ff       	call   801024c0 <kfree>
              *pte = 0;
80107c8e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107c91:	83 c4 10             	add    $0x10,%esp
80107c94:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80107c9a:	eb b2                	jmp    80107c4e <wunmap+0x1fe>
        cprintf("attempting umap1:\n\n");
80107c9c:	83 ec 0c             	sub    $0xc,%esp
80107c9f:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80107ca2:	68 06 8f 10 80       	push   $0x80108f06
80107ca7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80107caa:	e8 f1 89 ff ff       	call   801006a0 <cprintf>
        struct file *f = p->ofile[p->addr[i].fd];
80107caf:	8b 87 88 00 00 00    	mov    0x88(%edi),%eax
80107cb5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107cb8:	8b 44 82 28          	mov    0x28(%edx,%eax,4),%eax
        f->off = 0;
80107cbc:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        struct file *f = p->ofile[p->addr[i].fd];
80107cc3:	89 45 e0             	mov    %eax,-0x20(%ebp)
        cprintf("size = %x\n", p->addr[i].size);
80107cc6:	58                   	pop    %eax
80107cc7:	5a                   	pop    %edx
80107cc8:	ff b7 80 00 00 00    	push   0x80(%edi)
80107cce:	68 1a 8f 10 80       	push   $0x80108f1a
80107cd3:	e8 c8 89 ff ff       	call   801006a0 <cprintf>
        while(offset < p->addr[i].size){
80107cd8:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80107cdb:	89 75 d8             	mov    %esi,-0x28(%ebp)
80107cde:	83 c4 10             	add    $0x10,%esp
80107ce1:	8b 87 80 00 00 00    	mov    0x80(%edi),%eax
80107ce7:	8b 75 d4             	mov    -0x2c(%ebp),%esi
80107cea:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107ced:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
80107cf0:	8b 7d dc             	mov    -0x24(%ebp),%edi
80107cf3:	eb 17                	jmp    80107d0c <wunmap+0x2bc>
80107cf5:	8d 76 00             	lea    0x0(%esi),%esi
          if(offset > p->addr[i].size){
80107cf8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
          offset += PAGE_SIZE;
80107cfb:	81 c6 00 10 00 00    	add    $0x1000,%esi
          if(offset > p->addr[i].size){
80107d01:	8b 84 b8 80 00 00 00 	mov    0x80(%eax,%edi,4),%eax
80107d08:	39 f0                	cmp    %esi,%eax
80107d0a:	7c 71                	jl     80107d7d <wunmap+0x32d>
        while(offset < p->addr[i].size){
80107d0c:	39 c6                	cmp    %eax,%esi
80107d0e:	7d 6d                	jge    80107d7d <wunmap+0x32d>
          cprintf("writing address: %x\n", p->addr[i].va + offset);
80107d10:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107d13:	83 ec 08             	sub    $0x8,%esp
80107d16:	8d 1c b8             	lea    (%eax,%edi,4),%ebx
80107d19:	8b 43 7c             	mov    0x7c(%ebx),%eax
80107d1c:	01 f0                	add    %esi,%eax
80107d1e:	50                   	push   %eax
80107d1f:	68 25 8f 10 80       	push   $0x80108f25
80107d24:	e8 77 89 ff ff       	call   801006a0 <cprintf>
          if (f->type == FD_INODE) {
80107d29:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d2c:	83 c4 10             	add    $0x10,%esp
80107d2f:	83 38 02             	cmpl   $0x2,(%eax)
80107d32:	75 c4                	jne    80107cf8 <wunmap+0x2a8>
            begin_op();
80107d34:	e8 27 b0 ff ff       	call   80102d60 <begin_op>
            ilock(f->ip);
80107d39:	8b 55 e0             	mov    -0x20(%ebp),%edx
80107d3c:	83 ec 0c             	sub    $0xc,%esp
80107d3f:	ff 72 10             	push   0x10(%edx)
80107d42:	e8 39 9a ff ff       	call   80101780 <ilock>
            writei(f->ip, (void *)p->addr[i].va+offset, f->off+offset, PAGE_SIZE);
80107d47:	8b 55 e0             	mov    -0x20(%ebp),%edx
80107d4a:	68 00 10 00 00       	push   $0x1000
80107d4f:	8b 42 14             	mov    0x14(%edx),%eax
80107d52:	01 f0                	add    %esi,%eax
80107d54:	50                   	push   %eax
80107d55:	8b 43 7c             	mov    0x7c(%ebx),%eax
80107d58:	89 d3                	mov    %edx,%ebx
80107d5a:	01 f0                	add    %esi,%eax
80107d5c:	50                   	push   %eax
80107d5d:	ff 72 10             	push   0x10(%edx)
80107d60:	e8 2b 9e ff ff       	call   80101b90 <writei>
            iunlock(f->ip);
80107d65:	83 c4 14             	add    $0x14,%esp
80107d68:	ff 73 10             	push   0x10(%ebx)
80107d6b:	e8 f0 9a ff ff       	call   80101860 <iunlock>
            end_op();
80107d70:	e8 5b b0 ff ff       	call   80102dd0 <end_op>
80107d75:	83 c4 10             	add    $0x10,%esp
80107d78:	e9 7b ff ff ff       	jmp    80107cf8 <wunmap+0x2a8>
        if (p->parent->pid == 2) {
80107d7d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107d80:	8b 75 d8             	mov    -0x28(%ebp),%esi
80107d83:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
80107d86:	8b 5d 08             	mov    0x8(%ebp),%ebx
80107d89:	8b 40 14             	mov    0x14(%eax),%eax
80107d8c:	83 78 10 02          	cmpl   $0x2,0x10(%eax)
80107d90:	0f 85 d8 00 00 00    	jne    80107e6e <wunmap+0x41e>
          int size = p->addr[i].size;
80107d96:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107d99:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
80107d9c:	8b 84 82 80 00 00 00 	mov    0x80(%edx,%eax,4),%eax
          while (size > 0) {
80107da3:	85 c0                	test   %eax,%eax
80107da5:	7e 6e                	jle    80107e15 <wunmap+0x3c5>
80107da7:	8d 78 ff             	lea    -0x1(%eax),%edi
80107daa:	8d b3 00 10 00 00    	lea    0x1000(%ebx),%esi
80107db0:	89 d8                	mov    %ebx,%eax
80107db2:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80107db5:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80107dbb:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80107dbe:	01 f7                	add    %esi,%edi
80107dc0:	eb 12                	jmp    80107dd4 <wunmap+0x384>
80107dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107dc8:	89 f0                	mov    %esi,%eax
80107dca:	39 f7                	cmp    %esi,%edi
80107dcc:	74 44                	je     80107e12 <wunmap+0x3c2>
80107dce:	81 c6 00 10 00 00    	add    $0x1000,%esi
            pte = walkpgdir(p->pgdir, (void *)addr + j * PAGE_SIZE, 0);
80107dd4:	83 ec 04             	sub    $0x4,%esp
80107dd7:	6a 00                	push   $0x0
80107dd9:	50                   	push   %eax
80107dda:	ff 73 04             	push   0x4(%ebx)
80107ddd:	e8 8e f0 ff ff       	call   80106e70 <walkpgdir>
            if (PTE_P & *pte) {
80107de2:	83 c4 10             	add    $0x10,%esp
            int physical_address = PTE_ADDR(*pte);
80107de5:	8b 08                	mov    (%eax),%ecx
            if (PTE_P & *pte) {
80107de7:	f6 c1 01             	test   $0x1,%cl
80107dea:	74 dc                	je     80107dc8 <wunmap+0x378>
            int physical_address = PTE_ADDR(*pte);
80107dec:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
              kfree(P2V(physical_address));
80107df2:	83 ec 0c             	sub    $0xc,%esp
80107df5:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107df8:	81 c1 00 00 00 80    	add    $0x80000000,%ecx
80107dfe:	51                   	push   %ecx
80107dff:	e8 bc a6 ff ff       	call   801024c0 <kfree>
              *pte = 0;
80107e04:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107e07:	83 c4 10             	add    $0x10,%esp
80107e0a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80107e10:	eb b6                	jmp    80107dc8 <wunmap+0x378>
80107e12:	8b 4d dc             	mov    -0x24(%ebp),%ecx
          p->addr[i].va = 0;
80107e15:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
80107e18:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
          cprintf("reached unmap\n");
80107e1b:	83 ec 0c             	sub    $0xc,%esp
          p->addr[i].va = 0;
80107e1e:	8d 04 81             	lea    (%ecx,%eax,4),%eax
          p->memory_used -= p->addr[i].size;
80107e21:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
          p->addr[i].va = 0;
80107e27:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
          p->addr[i].flags = 0;
80107e2e:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%eax)
80107e35:	00 00 00 
          p->addr[i].fd = 0;
80107e38:	c7 80 88 00 00 00 00 	movl   $0x0,0x88(%eax)
80107e3f:	00 00 00 
          p->memory_used -= p->addr[i].size;
80107e42:	29 91 bc 01 00 00    	sub    %edx,0x1bc(%ecx)
          p->addr[i].size = 0;
80107e48:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80107e4f:	00 00 00 
          p->addr[i].phys_page_used = 0;
80107e52:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
80107e59:	00 00 00 
          cprintf("reached unmap\n");
80107e5c:	68 3a 8f 10 80       	push   $0x80108f3a
80107e61:	e8 3a 88 ff ff       	call   801006a0 <cprintf>
80107e66:	83 c4 10             	add    $0x10,%esp
80107e69:	e9 3f fd ff ff       	jmp    80107bad <wunmap+0x15d>
          cprintf("reached child unmap\n");
80107e6e:	83 ec 0c             	sub    $0xc,%esp
80107e71:	68 49 8f 10 80       	push   $0x80108f49
80107e76:	e8 25 88 ff ff       	call   801006a0 <cprintf>
80107e7b:	83 c4 10             	add    $0x10,%esp
80107e7e:	e9 48 fd ff ff       	jmp    80107bcb <wunmap+0x17b>
80107e83:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107e90 <wremap>:

uint wremap(uint oldaddr, int oldsize, int newsize, int flags)
{
80107e90:	55                   	push   %ebp
80107e91:	89 e5                	mov    %esp,%ebp
80107e93:	57                   	push   %edi
80107e94:	56                   	push   %esi
80107e95:	53                   	push   %ebx
80107e96:	83 ec 2c             	sub    $0x2c,%esp
  if (newsize % 4096 != 0) {
80107e99:	f7 45 10 ff 0f 00 00 	testl  $0xfff,0x10(%ebp)
80107ea0:	74 1e                	je     80107ec0 <wremap+0x30>
    newsize = (newsize / 4096) * 4096 + 4096;
80107ea2:	8b 45 10             	mov    0x10(%ebp),%eax
80107ea5:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107ea8:	05 ff 0f 00 00       	add    $0xfff,%eax
80107ead:	85 c9                	test   %ecx,%ecx
80107eaf:	0f 49 45 10          	cmovns 0x10(%ebp),%eax
80107eb3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107eb8:	05 00 10 00 00       	add    $0x1000,%eax
80107ebd:	89 45 10             	mov    %eax,0x10(%ebp)
  }
  struct proc *p = myproc();
80107ec0:	e8 0b bb ff ff       	call   801039d0 <myproc>
  int i;
  for (i = 0; i < 16; ++i)
80107ec5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80107ec8:	8b 75 0c             	mov    0xc(%ebp),%esi
80107ecb:	31 c9                	xor    %ecx,%ecx
  struct proc *p = myproc();
80107ecd:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for (i = 0; i < 16; ++i)
80107ed0:	83 c0 7c             	add    $0x7c,%eax
  struct proc *p = myproc();
80107ed3:	89 c2                	mov    %eax,%edx
80107ed5:	eb 18                	jmp    80107eef <wremap+0x5f>
80107ed7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ede:	66 90                	xchg   %ax,%ax
  for (i = 0; i < 16; ++i)
80107ee0:	83 c1 01             	add    $0x1,%ecx
80107ee3:	83 c2 14             	add    $0x14,%edx
80107ee6:	83 f9 10             	cmp    $0x10,%ecx
80107ee9:	0f 84 01 03 00 00    	je     801081f0 <wremap+0x360>
  { // finds where in addr is the address given as argument
    // cprintf("--------va %x, size %d, oldaddr %x, oldsize %d\n", p->addr[i].va, p->addr[i].size, oldaddr, oldsize);
    if (p->addr[i].va == oldaddr && p->addr[i].size == oldsize)
80107eef:	39 1a                	cmp    %ebx,(%edx)
80107ef1:	75 ed                	jne    80107ee0 <wremap+0x50>
80107ef3:	39 72 04             	cmp    %esi,0x4(%edx)
80107ef6:	75 e8                	jne    80107ee0 <wremap+0x50>
80107ef8:	8b 7d dc             	mov    -0x24(%ebp),%edi
    if (p->addr[j].va == 0)
    {
      continue;
    }
    // cprintf("\t-%x <= %x < %x\n", p->addr[j].va, oldaddr + newsize, p->addr[j].va + p->addr[j].size);
    if ((p->addr[j].va > oldaddr) && (p->addr[j].va < oldaddr + newsize))
80107efb:	8b 5d 10             	mov    0x10(%ebp),%ebx
80107efe:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80107f01:	8b 75 08             	mov    0x8(%ebp),%esi
80107f04:	03 5d 08             	add    0x8(%ebp),%ebx
80107f07:	8d 8f bc 01 00 00    	lea    0x1bc(%edi),%ecx
80107f0d:	eb 0c                	jmp    80107f1b <wremap+0x8b>
80107f0f:	90                   	nop
  for (int j = 0; j < 16; ++j)
80107f10:	83 c0 14             	add    $0x14,%eax
80107f13:	39 c1                	cmp    %eax,%ecx
80107f15:	0f 84 b5 01 00 00    	je     801080d0 <wremap+0x240>
    if (p->addr[j].va == 0)
80107f1b:	8b 10                	mov    (%eax),%edx
    if ((p->addr[j].va > oldaddr) && (p->addr[j].va < oldaddr + newsize))
80107f1d:	39 f2                	cmp    %esi,%edx
80107f1f:	76 ef                	jbe    80107f10 <wremap+0x80>
80107f21:	39 da                	cmp    %ebx,%edx
80107f23:	73 eb                	jae    80107f10 <wremap+0x80>
      p->memory_used += newsize - oldsize;
      return oldaddr;
      // cprintf("va %x, size %d\n", p->addr[i].va, p->addr[i].size);
    }
  }
  else if (!(flags & MREMAP_MAYMOVE))
80107f25:	f6 45 14 01          	testb  $0x1,0x14(%ebp)
80107f29:	0f 84 a5 02 00 00    	je     801081d4 <wremap+0x344>
    return -1;
  }
  else
  { // VALID FOR MOVING
    // cprintf("\t-Valid for moving\n");
    if (newsize < oldsize)
80107f2f:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f32:	39 45 10             	cmp    %eax,0x10(%ebp)
80107f35:	0f 8c dc 01 00 00    	jl     80108117 <wremap+0x287>
      // flush TLB
      // switchuvm(p);
      p->memory_used -= oldsize - newsize;
      return oldaddr;
    }
    else if (oldsize < newsize)
80107f3b:	0f 8e 71 02 00 00    	jle    801081b2 <wremap+0x322>
    {
      // find first free contiguous block in address space
      int addr = oldaddr;
80107f41:	8b 5d 08             	mov    0x8(%ebp),%ebx
80107f44:	b8 10 00 00 00       	mov    $0x10,%eax
      int valid = 0;
      int num_va = 0;
80107f49:	31 d2                	xor    %edx,%edx
80107f4b:	89 d9                	mov    %ebx,%ecx
80107f4d:	8d 76 00             	lea    0x0(%esi),%esi
      for (int k = 0; k < 16; ++k)
      {
        if (p->addr[i].va != 0)
        {
          ++num_va;
80107f50:	83 f9 01             	cmp    $0x1,%ecx
80107f53:	83 da ff             	sbb    $0xffffffff,%edx
      for (int k = 0; k < 16; ++k)
80107f56:	83 e8 01             	sub    $0x1,%eax
80107f59:	75 f5                	jne    80107f50 <wremap+0xc0>
80107f5b:	8b 45 dc             	mov    -0x24(%ebp),%eax
        }
      }
      int count = 0;
80107f5e:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80107f61:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107f68:	8d b8 80 00 00 00    	lea    0x80(%eax),%edi
80107f6e:	89 7d d8             	mov    %edi,-0x28(%ebp)
80107f71:	8d b8 c0 01 00 00    	lea    0x1c0(%eax),%edi
80107f77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107f7e:	66 90                	xchg   %ax,%ax
        {
          if (p->addr[i].va == 0)
          {
            continue;
          }
          if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + newsize && p->addr[i].va + p->addr[i].size >= addr + newsize))
80107f80:	8b 75 10             	mov    0x10(%ebp),%esi
80107f83:	8b 45 d8             	mov    -0x28(%ebp),%eax
80107f86:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80107f89:	01 de                	add    %ebx,%esi
80107f8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107f8f:	90                   	nop
          if (p->addr[i].va == 0)
80107f90:	8b 50 fc             	mov    -0x4(%eax),%edx
80107f93:	85 d2                	test   %edx,%edx
80107f95:	74 20                	je     80107fb7 <wremap+0x127>
          if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + newsize && p->addr[i].va + p->addr[i].size >= addr + newsize))
80107f97:	39 da                	cmp    %ebx,%edx
80107f99:	77 0c                	ja     80107fa7 <wremap+0x117>
80107f9b:	8b 08                	mov    (%eax),%ecx
80107f9d:	01 d1                	add    %edx,%ecx
80107f9f:	39 d9                	cmp    %ebx,%ecx
80107fa1:	0f 87 d9 00 00 00    	ja     80108080 <wremap+0x1f0>
80107fa7:	39 f2                	cmp    %esi,%edx
80107fa9:	73 0c                	jae    80107fb7 <wremap+0x127>
80107fab:	8b 08                	mov    (%eax),%ecx
80107fad:	01 d1                	add    %edx,%ecx
80107faf:	39 ce                	cmp    %ecx,%esi
80107fb1:	0f 86 c9 00 00 00    	jbe    80108080 <wremap+0x1f0>
        for (i = 0; i < 16; ++i)
80107fb7:	83 c0 14             	add    $0x14,%eax
80107fba:	39 c7                	cmp    %eax,%edi
80107fbc:	75 d2                	jne    80107f90 <wremap+0x100>
          return -1;
        }
      }
      // cprintf("\t-Done. Final addr 0x%x\n", addr);//FOUND THE NEW ADDRESS
      count = 0;
      while (count < oldsize / 4096)
80107fbe:	8b 45 0c             	mov    0xc(%ebp),%eax
80107fc1:	8b 55 0c             	mov    0xc(%ebp),%edx
80107fc4:	8b 75 08             	mov    0x8(%ebp),%esi
80107fc7:	05 ff 0f 00 00       	add    $0xfff,%eax
80107fcc:	85 d2                	test   %edx,%edx
80107fce:	0f 49 45 0c          	cmovns 0xc(%ebp),%eax
      count = 0;
80107fd2:	31 ff                	xor    %edi,%edi
      while (count < oldsize / 4096)
80107fd4:	c1 f8 0c             	sar    $0xc,%eax
80107fd7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        pte_t *pte = walkpgdir(p->pgdir, (void *)oldaddr + (count * PAGE_SIZE), 0);
        if (PTE_P & *pte)
        {
          int physical_address = PTE_ADDR(*pte);
          *pte = 0;
          mappages(p->pgdir, (void *)(addr + count * 4096), 4096, physical_address, PTE_W | PTE_U);
80107fda:	89 d8                	mov    %ebx,%eax
80107fdc:	29 f0                	sub    %esi,%eax
      while (count < oldsize / 4096)
80107fde:	81 7d 0c ff 0f 00 00 	cmpl   $0xfff,0xc(%ebp)
          mappages(p->pgdir, (void *)(addr + count * 4096), 4096, physical_address, PTE_W | PTE_U);
80107fe5:	89 45 d8             	mov    %eax,-0x28(%ebp)
      while (count < oldsize / 4096)
80107fe8:	7f 14                	jg     80107ffe <wremap+0x16e>
80107fea:	eb 66                	jmp    80108052 <wremap+0x1c2>
80107fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        }
        ++count;
80107ff0:	83 c7 01             	add    $0x1,%edi
      while (count < oldsize / 4096)
80107ff3:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107ff9:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107ffc:	7e 54                	jle    80108052 <wremap+0x1c2>
        pte_t *pte = walkpgdir(p->pgdir, (void *)oldaddr + (count * PAGE_SIZE), 0);
80107ffe:	8b 45 dc             	mov    -0x24(%ebp),%eax
80108001:	83 ec 04             	sub    $0x4,%esp
80108004:	6a 00                	push   $0x0
80108006:	56                   	push   %esi
80108007:	ff 70 04             	push   0x4(%eax)
8010800a:	e8 61 ee ff ff       	call   80106e70 <walkpgdir>
        if (PTE_P & *pte)
8010800f:	83 c4 10             	add    $0x10,%esp
80108012:	8b 10                	mov    (%eax),%edx
80108014:	f6 c2 01             	test   $0x1,%dl
80108017:	74 d7                	je     80107ff0 <wremap+0x160>
          *pte = 0;
80108019:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
          mappages(p->pgdir, (void *)(addr + count * 4096), 4096, physical_address, PTE_W | PTE_U);
8010801f:	8b 45 d8             	mov    -0x28(%ebp),%eax
80108022:	83 ec 0c             	sub    $0xc,%esp
          int physical_address = PTE_ADDR(*pte);
80108025:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
          mappages(p->pgdir, (void *)(addr + count * 4096), 4096, physical_address, PTE_W | PTE_U);
8010802b:	6a 06                	push   $0x6
        ++count;
8010802d:	83 c7 01             	add    $0x1,%edi
          mappages(p->pgdir, (void *)(addr + count * 4096), 4096, physical_address, PTE_W | PTE_U);
80108030:	01 f0                	add    %esi,%eax
80108032:	52                   	push   %edx
      while (count < oldsize / 4096)
80108033:	81 c6 00 10 00 00    	add    $0x1000,%esi
          mappages(p->pgdir, (void *)(addr + count * 4096), 4096, physical_address, PTE_W | PTE_U);
80108039:	68 00 10 00 00       	push   $0x1000
8010803e:	50                   	push   %eax
8010803f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80108042:	ff 70 04             	push   0x4(%eax)
80108045:	e8 b6 ee ff ff       	call   80106f00 <mappages>
8010804a:	83 c4 20             	add    $0x20,%esp
      while (count < oldsize / 4096)
8010804d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80108050:	7f ac                	jg     80107ffe <wremap+0x16e>
      }
      p->addr[location_array].va = addr;
80108052:	8b 45 d0             	mov    -0x30(%ebp),%eax
80108055:	8b 7d dc             	mov    -0x24(%ebp),%edi
80108058:	8d 04 80             	lea    (%eax,%eax,4),%eax
8010805b:	8d 04 87             	lea    (%edi,%eax,4),%eax
8010805e:	89 58 7c             	mov    %ebx,0x7c(%eax)
      p->addr[location_array].size = newsize;
80108061:	8b 5d 10             	mov    0x10(%ebp),%ebx
80108064:	89 98 80 00 00 00    	mov    %ebx,0x80(%eax)
      p->memory_used += newsize - oldsize;
8010806a:	89 d8                	mov    %ebx,%eax
8010806c:	2b 45 0c             	sub    0xc(%ebp),%eax
8010806f:	01 87 bc 01 00 00    	add    %eax,0x1bc(%edi)
  {
    // cprintf("va %x, size %d\n", p->addr[g].va, p->addr[g].size);
  }
  cprintf("Shouldn't be here\n");
  return -1;
}
80108075:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108078:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010807b:	5b                   	pop    %ebx
8010807c:	5e                   	pop    %esi
8010807d:	5f                   	pop    %edi
8010807e:	5d                   	pop    %ebp
8010807f:	c3                   	ret    
              addr = 0x60000000;
80108080:	bb 00 00 00 60       	mov    $0x60000000,%ebx
            if (p->addr[i].va + p->addr[i].size == 0x80000000)
80108085:	81 f9 00 00 00 80    	cmp    $0x80000000,%ecx
8010808b:	74 0d                	je     8010809a <wremap+0x20a>
              if (addr + newsize > 0x80000000)
8010808d:	8b 45 10             	mov    0x10(%ebp),%eax
80108090:	01 c8                	add    %ecx,%eax
              addr = 0x60000000;
80108092:	3d 00 00 00 80       	cmp    $0x80000000,%eax
80108097:	0f 46 d9             	cmovbe %ecx,%ebx
        ++count;
8010809a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010809e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        else if (count > num_va)
801080a1:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
801080a4:	0f 8d d6 fe ff ff    	jge    80107f80 <wremap+0xf0>
          cprintf("Not enough contiguous memory\n");
801080aa:	83 ec 0c             	sub    $0xc,%esp
801080ad:	68 db 8e 10 80       	push   $0x80108edb
801080b2:	e8 e9 85 ff ff       	call   801006a0 <cprintf>
          return -1;
801080b7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
801080be:	83 c4 10             	add    $0x10,%esp
}
801080c1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801080c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801080c7:	5b                   	pop    %ebx
801080c8:	5e                   	pop    %esi
801080c9:	5f                   	pop    %edi
801080ca:	5d                   	pop    %ebp
801080cb:	c3                   	ret    
801080cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (oldaddr + newsize > 0x80000000)
801080d0:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801080d6:	0f 87 49 fe ff ff    	ja     80107f25 <wremap+0x95>
    if (newsize < oldsize)
801080dc:	8b 45 0c             	mov    0xc(%ebp),%eax
801080df:	39 45 10             	cmp    %eax,0x10(%ebp)
801080e2:	0f 8c 24 01 00 00    	jl     8010820c <wremap+0x37c>
    else if (oldsize < newsize)
801080e8:	0f 8e c4 00 00 00    	jle    801081b2 <wremap+0x322>
      p->addr[i].size = newsize;
801080ee:	8b 45 d0             	mov    -0x30(%ebp),%eax
801080f1:	8b 7d dc             	mov    -0x24(%ebp),%edi
801080f4:	8b 5d 10             	mov    0x10(%ebp),%ebx
801080f7:	8d 04 80             	lea    (%eax,%eax,4),%eax
801080fa:	89 9c 87 80 00 00 00 	mov    %ebx,0x80(%edi,%eax,4)
      p->memory_used += newsize - oldsize;
80108101:	89 d8                	mov    %ebx,%eax
80108103:	2b 45 0c             	sub    0xc(%ebp),%eax
80108106:	01 87 bc 01 00 00    	add    %eax,0x1bc(%edi)
      return oldaddr;
8010810c:	8b 45 08             	mov    0x8(%ebp),%eax
8010810f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108112:	e9 5e ff ff ff       	jmp    80108075 <wremap+0x1e5>
      while (address < oldaddr + oldsize)
80108117:	8b 7d 08             	mov    0x8(%ebp),%edi
8010811a:	01 c7                	add    %eax,%edi
8010811c:	39 fb                	cmp    %edi,%ebx
8010811e:	73 63                	jae    80108183 <wremap+0x2f3>
80108120:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80108123:	89 df                	mov    %ebx,%edi
80108125:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80108128:	eb 11                	jmp    8010813b <wremap+0x2ab>
8010812a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        address += PAGE_SIZE;
80108130:	81 c7 00 10 00 00    	add    $0x1000,%edi
      while (address < oldaddr + oldsize)
80108136:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80108139:	73 48                	jae    80108183 <wremap+0x2f3>
        pte_t *pte = walkpgdir(p->pgdir, (void *)address, 0); // CHECK THISSSSSS
8010813b:	83 ec 04             	sub    $0x4,%esp
8010813e:	6a 00                	push   $0x0
80108140:	57                   	push   %edi
80108141:	ff 73 04             	push   0x4(%ebx)
80108144:	e8 27 ed ff ff       	call   80106e70 <walkpgdir>
        if (PTE_P & *pte)
80108149:	83 c4 10             	add    $0x10,%esp
        pte_t *pte = walkpgdir(p->pgdir, (void *)address, 0); // CHECK THISSSSSS
8010814c:	89 c6                	mov    %eax,%esi
        int physical_address = PTE_ADDR(*pte);
8010814e:	8b 00                	mov    (%eax),%eax
        if (PTE_P & *pte)
80108150:	a8 01                	test   $0x1,%al
80108152:	74 dc                	je     80108130 <wremap+0x2a0>
        int physical_address = PTE_ADDR(*pte);
80108154:	25 00 f0 ff ff       	and    $0xfffff000,%eax
          kfree(P2V(physical_address));
80108159:	83 ec 0c             	sub    $0xc,%esp
        address += PAGE_SIZE;
8010815c:	81 c7 00 10 00 00    	add    $0x1000,%edi
          kfree(P2V(physical_address));
80108162:	05 00 00 00 80       	add    $0x80000000,%eax
80108167:	50                   	push   %eax
80108168:	e8 53 a3 ff ff       	call   801024c0 <kfree>
          *pte = 0;
8010816d:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
          switchuvm(p);
80108173:	89 1c 24             	mov    %ebx,(%esp)
80108176:	e8 85 ee ff ff       	call   80107000 <switchuvm>
8010817b:	83 c4 10             	add    $0x10,%esp
      while (address < oldaddr + oldsize)
8010817e:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80108181:	72 b8                	jb     8010813b <wremap+0x2ab>
      p->addr[i].size = newsize;
80108183:	8b 45 d0             	mov    -0x30(%ebp),%eax
80108186:	8b 7d dc             	mov    -0x24(%ebp),%edi
80108189:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010818c:	8d 04 80             	lea    (%eax,%eax,4),%eax
8010818f:	89 9c 87 80 00 00 00 	mov    %ebx,0x80(%edi,%eax,4)
      p->memory_used -= oldsize - newsize;
80108196:	8b 45 0c             	mov    0xc(%ebp),%eax
80108199:	29 d8                	sub    %ebx,%eax
8010819b:	29 87 bc 01 00 00    	sub    %eax,0x1bc(%edi)
      return oldaddr;
801081a1:	8b 45 08             	mov    0x8(%ebp),%eax
801081a4:	89 45 e0             	mov    %eax,-0x20(%ebp)
}
801081a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801081aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801081ad:	5b                   	pop    %ebx
801081ae:	5e                   	pop    %esi
801081af:	5f                   	pop    %edi
801081b0:	5d                   	pop    %ebp
801081b1:	c3                   	ret    
  cprintf("Shouldn't be here\n");
801081b2:	83 ec 0c             	sub    $0xc,%esp
801081b5:	68 5e 8f 10 80       	push   $0x80108f5e
801081ba:	e8 e1 84 ff ff       	call   801006a0 <cprintf>
  return -1;
801081bf:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
801081c6:	83 c4 10             	add    $0x10,%esp
}
801081c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801081cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801081cf:	5b                   	pop    %ebx
801081d0:	5e                   	pop    %esi
801081d1:	5f                   	pop    %edi
801081d2:	5d                   	pop    %ebp
801081d3:	c3                   	ret    
    cprintf("\t-Cannot remap in place and flag specified no move. No remap\n");
801081d4:	83 ec 0c             	sub    $0xc,%esp
801081d7:	68 60 90 10 80       	push   $0x80109060
801081dc:	e8 bf 84 ff ff       	call   801006a0 <cprintf>
    return -1;
801081e1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
801081e8:	83 c4 10             	add    $0x10,%esp
801081eb:	e9 85 fe ff ff       	jmp    80108075 <wremap+0x1e5>
    cprintf("Address given is not mapped by wmap\n");
801081f0:	83 ec 0c             	sub    $0xc,%esp
801081f3:	68 a0 90 10 80       	push   $0x801090a0
801081f8:	e8 a3 84 ff ff       	call   801006a0 <cprintf>
    return -1;
801081fd:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
80108204:	83 c4 10             	add    $0x10,%esp
80108207:	e9 69 fe ff ff       	jmp    80108075 <wremap+0x1e5>
      while (address < oldaddr + oldsize)
8010820c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010820f:	01 c7                	add    %eax,%edi
80108211:	39 fb                	cmp    %edi,%ebx
80108213:	0f 83 6a ff ff ff    	jae    80108183 <wremap+0x2f3>
80108219:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010821c:	89 df                	mov    %ebx,%edi
8010821e:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80108221:	eb 14                	jmp    80108237 <wremap+0x3a7>
80108223:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108227:	90                   	nop
        address += PAGE_SIZE;
80108228:	81 c7 00 10 00 00    	add    $0x1000,%edi
      while (address < oldaddr + oldsize)
8010822e:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80108231:	0f 83 4c ff ff ff    	jae    80108183 <wremap+0x2f3>
        pte_t *pte = walkpgdir(p->pgdir, (void *)address, 0); // CHECK THIS!!!!!!!!!!
80108237:	83 ec 04             	sub    $0x4,%esp
8010823a:	6a 00                	push   $0x0
8010823c:	57                   	push   %edi
8010823d:	ff 73 04             	push   0x4(%ebx)
80108240:	e8 2b ec ff ff       	call   80106e70 <walkpgdir>
        if (PTE_P & *pte)
80108245:	83 c4 10             	add    $0x10,%esp
        pte_t *pte = walkpgdir(p->pgdir, (void *)address, 0); // CHECK THIS!!!!!!!!!!
80108248:	89 c6                	mov    %eax,%esi
        int physical_address = PTE_ADDR(*pte);
8010824a:	8b 00                	mov    (%eax),%eax
        if (PTE_P & *pte)
8010824c:	a8 01                	test   $0x1,%al
8010824e:	74 d8                	je     80108228 <wremap+0x398>
        int physical_address = PTE_ADDR(*pte);
80108250:	25 00 f0 ff ff       	and    $0xfffff000,%eax
          kfree(P2V(physical_address));
80108255:	83 ec 0c             	sub    $0xc,%esp
80108258:	05 00 00 00 80       	add    $0x80000000,%eax
8010825d:	50                   	push   %eax
8010825e:	e8 5d a2 ff ff       	call   801024c0 <kfree>
          *pte = 0;
80108263:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
          switchuvm(p);
80108269:	89 1c 24             	mov    %ebx,(%esp)
8010826c:	e8 8f ed ff ff       	call   80107000 <switchuvm>
80108271:	83 c4 10             	add    $0x10,%esp
80108274:	eb b2                	jmp    80108228 <wremap+0x398>
80108276:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010827d:	8d 76 00             	lea    0x0(%esi),%esi

80108280 <sys_getpgdirinfo>:

int sys_getpgdirinfo(void)
{
80108280:	55                   	push   %ebp
80108281:	89 e5                	mov    %esp,%ebp
80108283:	57                   	push   %edi
80108284:	56                   	push   %esi
  struct pgdirinfo *pdinfo;
  if (argptr(0, (void *)&pdinfo, sizeof(struct pgdirinfo)) < 0)
80108285:	8d 45 e4             	lea    -0x1c(%ebp),%eax
{
80108288:	53                   	push   %ebx
80108289:	83 ec 30             	sub    $0x30,%esp
  if (argptr(0, (void *)&pdinfo, sizeof(struct pgdirinfo)) < 0)
8010828c:	68 04 01 00 00       	push   $0x104
80108291:	50                   	push   %eax
80108292:	6a 00                	push   $0x0
80108294:	e8 77 c9 ff ff       	call   80104c10 <argptr>
80108299:	83 c4 10             	add    $0x10,%esp
8010829c:	85 c0                	test   %eax,%eax
8010829e:	0f 88 a0 00 00 00    	js     80108344 <sys_getpgdirinfo+0xc4>
  {
    return -1;
  }
  pdinfo->n_upages = 0;
801082a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801082a7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  struct proc *p = myproc();
801082ad:	e8 1e b7 ff ff       	call   801039d0 <myproc>
801082b2:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
801082b9:	89 45 cc             	mov    %eax,-0x34(%ebp)
  for (int i = 0; i < NPDENTRIES; ++i)
801082bc:	eb 10                	jmp    801082ce <sys_getpgdirinfo+0x4e>
801082be:	66 90                	xchg   %ax,%ax
801082c0:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
801082c4:	8b 45 d0             	mov    -0x30(%ebp),%eax
801082c7:	3d 00 10 00 00       	cmp    $0x1000,%eax
801082cc:	74 6c                	je     8010833a <sys_getpgdirinfo+0xba>
  {
    uint va;
    uint pa;
    pde_t *dirent = &(p->pgdir[i]);
    if (!((*dirent) & PTE_P))
801082ce:	8b 45 cc             	mov    -0x34(%ebp),%eax
801082d1:	8b 7d d0             	mov    -0x30(%ebp),%edi
801082d4:	8b 40 04             	mov    0x4(%eax),%eax
801082d7:	8b 14 38             	mov    (%eax,%edi,1),%edx
801082da:	f6 c2 01             	test   $0x1,%dl
801082dd:	74 e1                	je     801082c0 <sys_getpgdirinfo+0x40>
    {
      continue;
    }

    pte_t *pageTable = P2V(PTE_ADDR(*dirent));
801082df:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801082e5:	c1 e7 14             	shl    $0x14,%edi
801082e8:	31 c0                	xor    %eax,%eax
801082ea:	89 7d d4             	mov    %edi,-0x2c(%ebp)
801082ed:	81 c2 00 00 00 80    	add    $0x80000000,%edx
    for (int j = 0; j < NPTENTRIES; ++j)
801082f3:	eb 12                	jmp    80108307 <sys_getpgdirinfo+0x87>
801082f5:	8d 76 00             	lea    0x0(%esi),%esi
801082f8:	05 00 10 00 00       	add    $0x1000,%eax
801082fd:	83 c2 04             	add    $0x4,%edx
80108300:	3d 00 00 40 00       	cmp    $0x400000,%eax
80108305:	74 b9                	je     801082c0 <sys_getpgdirinfo+0x40>
    {
      va = PGADDR(i, j, 0);
      pde_t *pte = &pageTable[j];
      // cprintf("pa = %x\n", pa);
      if ((*pte & PTE_P) && (*pte & PTE_U))
80108307:	8b 0a                	mov    (%edx),%ecx
80108309:	89 cb                	mov    %ecx,%ebx
8010830b:	83 e3 05             	and    $0x5,%ebx
8010830e:	83 fb 05             	cmp    $0x5,%ebx
80108311:	75 e5                	jne    801082f8 <sys_getpgdirinfo+0x78>
      {
        pa = (uint)(PTE_ADDR(*pte));
        if (pdinfo->n_upages < 32)
80108313:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80108316:	8b 1e                	mov    (%esi),%ebx
80108318:	83 fb 1f             	cmp    $0x1f,%ebx
8010831b:	77 db                	ja     801082f8 <sys_getpgdirinfo+0x78>
        {
          pdinfo->va[pdinfo->n_upages] = va;
8010831d:	8b 7d d4             	mov    -0x2c(%ebp),%edi
        pa = (uint)(PTE_ADDR(*pte));
80108320:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
80108326:	89 8c 9e 84 00 00 00 	mov    %ecx,0x84(%esi,%ebx,4)
          pdinfo->va[pdinfo->n_upages] = va;
8010832d:	09 c7                	or     %eax,%edi
8010832f:	89 7c 9e 04          	mov    %edi,0x4(%esi,%ebx,4)
          pdinfo->pa[pdinfo->n_upages] = pa;
          pdinfo->n_upages++;
80108333:	83 c3 01             	add    $0x1,%ebx
80108336:	89 1e                	mov    %ebx,(%esi)
80108338:	eb be                	jmp    801082f8 <sys_getpgdirinfo+0x78>
        }
      }
    }
  }
  return 0;
8010833a:	31 c0                	xor    %eax,%eax
}
8010833c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010833f:	5b                   	pop    %ebx
80108340:	5e                   	pop    %esi
80108341:	5f                   	pop    %edi
80108342:	5d                   	pop    %ebp
80108343:	c3                   	ret    
    return -1;
80108344:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108349:	eb f1                	jmp    8010833c <sys_getpgdirinfo+0xbc>
8010834b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010834f:	90                   	nop

80108350 <sys_getwmapinfo>:
int sys_getwmapinfo(void)
{
80108350:	55                   	push   %ebp
80108351:	89 e5                	mov    %esp,%ebp
80108353:	53                   	push   %ebx
  struct wmapinfo *wminfo;
  if (argptr(0, (void *)&wminfo, sizeof(struct wmapinfo)) < 0)
80108354:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80108357:	83 ec 18             	sub    $0x18,%esp
  if (argptr(0, (void *)&wminfo, sizeof(struct wmapinfo)) < 0)
8010835a:	68 c4 00 00 00       	push   $0xc4
8010835f:	50                   	push   %eax
80108360:	6a 00                	push   $0x0
80108362:	e8 a9 c8 ff ff       	call   80104c10 <argptr>
80108367:	83 c4 10             	add    $0x10,%esp
8010836a:	85 c0                	test   %eax,%eax
8010836c:	78 4c                	js     801083ba <sys_getwmapinfo+0x6a>
  {
    return -1;
  }
  struct proc *p = myproc();
8010836e:	e8 5d b6 ff ff       	call   801039d0 <myproc>
  if (wminfo == 0 || p == 0)
80108373:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108376:	85 d2                	test   %edx,%edx
80108378:	74 40                	je     801083ba <sys_getwmapinfo+0x6a>
8010837a:	85 c0                	test   %eax,%eax
8010837c:	74 3c                	je     801083ba <sys_getwmapinfo+0x6a>
  {
    return -1;
  }
  wminfo->total_mmaps = p->n_mmaps;
8010837e:	8b 88 c0 01 00 00    	mov    0x1c0(%eax),%ecx
80108384:	89 0a                	mov    %ecx,(%edx)
  for (int i = 0; i < MAX_WMMAP_INFO; ++i)
80108386:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80108389:	8d 50 7c             	lea    0x7c(%eax),%edx
8010838c:	8d 4b 04             	lea    0x4(%ebx),%ecx
8010838f:	8d 98 bc 01 00 00    	lea    0x1bc(%eax),%ebx
80108395:	8d 76 00             	lea    0x0(%esi),%esi
  {
    wminfo->addr[i] = p->addr[i].va;
80108398:	8b 02                	mov    (%edx),%eax
  for (int i = 0; i < MAX_WMMAP_INFO; ++i)
8010839a:	83 c2 14             	add    $0x14,%edx
8010839d:	83 c1 04             	add    $0x4,%ecx
    wminfo->addr[i] = p->addr[i].va;
801083a0:	89 41 fc             	mov    %eax,-0x4(%ecx)
    wminfo->length[i] = p->addr[i].size;
801083a3:	8b 42 f0             	mov    -0x10(%edx),%eax
801083a6:	89 41 3c             	mov    %eax,0x3c(%ecx)
    wminfo->n_loaded_pages[i] = p->addr[i].phys_page_used;
801083a9:	8b 42 fc             	mov    -0x4(%edx),%eax
801083ac:	89 41 7c             	mov    %eax,0x7c(%ecx)
  for (int i = 0; i < MAX_WMMAP_INFO; ++i)
801083af:	39 da                	cmp    %ebx,%edx
801083b1:	75 e5                	jne    80108398 <sys_getwmapinfo+0x48>
    // cprintf("loaded pages[%d]: %d\n",i, p->addr[i].phys_page_used[i]);
  }
  return 0;
801083b3:	31 c0                	xor    %eax,%eax
}
801083b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801083b8:	c9                   	leave  
801083b9:	c3                   	ret    
    return -1;
801083ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801083bf:	eb f4                	jmp    801083b5 <sys_getwmapinfo+0x65>
