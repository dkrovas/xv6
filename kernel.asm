
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
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc d0 b6 11 80       	mov    $0x8011b6d0,%esp
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
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 00 7a 10 80       	push   $0x80107a00
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 f5 43 00 00       	call   80104450 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
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
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 7a 10 80       	push   $0x80107a07
80100097:	50                   	push   %eax
80100098:	e8 83 42 00 00       	call   80104320 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
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
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 37 45 00 00       	call   80104620 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
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
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
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
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 59 44 00 00       	call   801045c0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ee 41 00 00       	call   80104360 <acquiresleep>
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
801001a1:	68 0e 7a 10 80       	push   $0x80107a0e
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
801001be:	e8 3d 42 00 00       	call   80104400 <holdingsleep>
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
801001dc:	68 1f 7a 10 80       	push   $0x80107a1f
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
801001ff:	e8 fc 41 00 00       	call   80104400 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 ac 41 00 00       	call   801043c0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 00 44 00 00       	call   80104620 <acquire>
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
80100242:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 4f 43 00 00       	jmp    801045c0 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 26 7a 10 80       	push   $0x80107a26
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
80100299:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002a0:	e8 7b 43 00 00       	call   80104620 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002b5:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
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
801002c3:	68 20 ff 10 80       	push   $0x8010ff20
801002c8:	68 00 ff 10 80       	push   $0x8010ff00
801002cd:	e8 ee 3d 00 00       	call   801040c0 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 e9 36 00 00       	call   801039d0 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ff 10 80       	push   $0x8010ff20
801002f6:	e8 c5 42 00 00       	call   801045c0 <release>
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
8010031b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
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
80100347:	68 20 ff 10 80       	push   $0x8010ff20
8010034c:	e8 6f 42 00 00       	call   801045c0 <release>
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
8010036d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
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
80100389:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 52 25 00 00       	call   801028f0 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 2d 7a 10 80       	push   $0x80107a2d
801003a7:	e8 f4 02 00 00       	call   801006a0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 eb 02 00 00       	call   801006a0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 ef 83 10 80 	movl   $0x801083ef,(%esp)
801003bc:	e8 df 02 00 00       	call   801006a0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 a3 40 00 00       	call   80104470 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 41 7a 10 80       	push   $0x80107a41
801003dd:	e8 be 02 00 00       	call   801006a0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
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
8010041a:	e8 f1 59 00 00       	call   80105e10 <uartputc>
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
80100505:	e8 06 59 00 00       	call   80105e10 <uartputc>
8010050a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100511:	e8 fa 58 00 00       	call   80105e10 <uartputc>
80100516:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051d:	e8 ee 58 00 00       	call   80105e10 <uartputc>
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
80100551:	e8 2a 42 00 00       	call   80104780 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100556:	b8 80 07 00 00       	mov    $0x780,%eax
8010055b:	83 c4 0c             	add    $0xc,%esp
8010055e:	29 d8                	sub    %ebx,%eax
80100560:	01 c0                	add    %eax,%eax
80100562:	50                   	push   %eax
80100563:	6a 00                	push   $0x0
80100565:	56                   	push   %esi
80100566:	e8 75 41 00 00       	call   801046e0 <memset>
  outb(CRTPORT+1, pos);
8010056b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010056e:	83 c4 10             	add    $0x10,%esp
80100571:	e9 20 ff ff ff       	jmp    80100496 <consputc.part.0+0x96>
    panic("pos under/overflow");
80100576:	83 ec 0c             	sub    $0xc,%esp
80100579:	68 45 7a 10 80       	push   $0x80107a45
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
801005a4:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801005ab:	e8 70 40 00 00       	call   80104620 <acquire>
  for(i = 0; i < n; i++)
801005b0:	83 c4 10             	add    $0x10,%esp
801005b3:	85 f6                	test   %esi,%esi
801005b5:	7e 25                	jle    801005dc <consolewrite+0x4c>
801005b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005ba:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005bd:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
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
801005df:	68 20 ff 10 80       	push   $0x8010ff20
801005e4:	e8 d7 3f 00 00       	call   801045c0 <release>
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
80100636:	0f b6 92 70 7a 10 80 	movzbl -0x7fef8590(%edx),%edx
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
80100662:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
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
801006a9:	a1 54 ff 10 80       	mov    0x8010ff54,%eax
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
80100760:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
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
801007a8:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007ae:	85 c9                	test   %ecx,%ecx
801007b0:	74 14                	je     801007c6 <cprintf+0x126>
801007b2:	fa                   	cli    
    for(;;)
801007b3:	eb fe                	jmp    801007b3 <cprintf+0x113>
801007b5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007b8:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
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
801007e3:	68 20 ff 10 80       	push   $0x8010ff20
801007e8:	e8 33 3e 00 00       	call   80104620 <acquire>
801007ed:	83 c4 10             	add    $0x10,%esp
801007f0:	e9 c4 fe ff ff       	jmp    801006b9 <cprintf+0x19>
  if(panicked){
801007f5:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007fb:	85 c9                	test   %ecx,%ecx
801007fd:	75 31                	jne    80100830 <cprintf+0x190>
801007ff:	b8 25 00 00 00       	mov    $0x25,%eax
80100804:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100807:	e8 f4 fb ff ff       	call   80100400 <consputc.part.0>
8010080c:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
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
80100838:	bf 58 7a 10 80       	mov    $0x80107a58,%edi
      for(; *s; s++)
8010083d:	b8 28 00 00 00       	mov    $0x28,%eax
80100842:	e9 19 ff ff ff       	jmp    80100760 <cprintf+0xc0>
80100847:	89 d0                	mov    %edx,%eax
80100849:	e8 b2 fb ff ff       	call   80100400 <consputc.part.0>
8010084e:	e9 c8 fe ff ff       	jmp    8010071b <cprintf+0x7b>
    release(&cons.lock);
80100853:	83 ec 0c             	sub    $0xc,%esp
80100856:	68 20 ff 10 80       	push   $0x8010ff20
8010085b:	e8 60 3d 00 00       	call   801045c0 <release>
80100860:	83 c4 10             	add    $0x10,%esp
}
80100863:	e9 c9 fe ff ff       	jmp    80100731 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
80100868:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010086b:	e9 ab fe ff ff       	jmp    8010071b <cprintf+0x7b>
    panic("null fmt");
80100870:	83 ec 0c             	sub    $0xc,%esp
80100873:	68 5f 7a 10 80       	push   $0x80107a5f
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
8010088e:	68 20 ff 10 80       	push   $0x8010ff20
80100893:	e8 88 3d 00 00       	call   80104620 <acquire>
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
801008d3:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801008d8:	89 c2                	mov    %eax,%edx
801008da:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
801008e0:	83 fa 7f             	cmp    $0x7f,%edx
801008e3:	77 d2                	ja     801008b7 <consoleintr+0x37>
        input.buf[input.e++ % INPUT_BUF] = c;
801008e5:	8d 48 01             	lea    0x1(%eax),%ecx
  if(panicked){
801008e8:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
801008ee:	83 e0 7f             	and    $0x7f,%eax
801008f1:	89 0d 08 ff 10 80    	mov    %ecx,0x8010ff08
        c = (c == '\r') ? '\n' : c;
801008f7:	83 fb 0d             	cmp    $0xd,%ebx
801008fa:	0f 84 13 01 00 00    	je     80100a13 <consoleintr+0x193>
        input.buf[input.e++ % INPUT_BUF] = c;
80100900:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
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
80100927:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
8010092c:	83 e8 80             	sub    $0xffffff80,%eax
8010092f:	39 05 08 ff 10 80    	cmp    %eax,0x8010ff08
80100935:	75 80                	jne    801008b7 <consoleintr+0x37>
80100937:	e9 fb 00 00 00       	jmp    80100a37 <consoleintr+0x1b7>
8010093c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
80100940:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100945:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
8010094b:	0f 84 66 ff ff ff    	je     801008b7 <consoleintr+0x37>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100951:	83 e8 01             	sub    $0x1,%eax
80100954:	89 c2                	mov    %eax,%edx
80100956:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100959:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
80100960:	0f 84 51 ff ff ff    	je     801008b7 <consoleintr+0x37>
  if(panicked){
80100966:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.e--;
8010096c:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100971:	85 d2                	test   %edx,%edx
80100973:	74 33                	je     801009a8 <consoleintr+0x128>
80100975:	fa                   	cli    
    for(;;)
80100976:	eb fe                	jmp    80100976 <consoleintr+0xf6>
80100978:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010097f:	90                   	nop
      if(input.e != input.w){
80100980:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100985:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
8010098b:	0f 84 26 ff ff ff    	je     801008b7 <consoleintr+0x37>
        input.e--;
80100991:	83 e8 01             	sub    $0x1,%eax
80100994:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100999:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
8010099e:	85 c0                	test   %eax,%eax
801009a0:	74 56                	je     801009f8 <consoleintr+0x178>
801009a2:	fa                   	cli    
    for(;;)
801009a3:	eb fe                	jmp    801009a3 <consoleintr+0x123>
801009a5:	8d 76 00             	lea    0x0(%esi),%esi
801009a8:	b8 00 01 00 00       	mov    $0x100,%eax
801009ad:	e8 4e fa ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
801009b2:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801009b7:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801009bd:	75 92                	jne    80100951 <consoleintr+0xd1>
801009bf:	e9 f3 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
801009c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
801009c8:	83 ec 0c             	sub    $0xc,%esp
801009cb:	68 20 ff 10 80       	push   $0x8010ff20
801009d0:	e8 eb 3b 00 00       	call   801045c0 <release>
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
80100a0e:	e9 4d 38 00 00       	jmp    80104260 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a13:	c6 80 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%eax)
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
80100a32:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
          wakeup(&input.r);
80100a37:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a3a:	a3 04 ff 10 80       	mov    %eax,0x8010ff04
          wakeup(&input.r);
80100a3f:	68 00 ff 10 80       	push   $0x8010ff00
80100a44:	e8 37 37 00 00       	call   80104180 <wakeup>
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
80100a66:	68 68 7a 10 80       	push   $0x80107a68
80100a6b:	68 20 ff 10 80       	push   $0x8010ff20
80100a70:	e8 db 39 00 00       	call   80104450 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a75:	58                   	pop    %eax
80100a76:	5a                   	pop    %edx
80100a77:	6a 00                	push   $0x0
80100a79:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a7b:	c7 05 0c 09 11 80 90 	movl   $0x80100590,0x8011090c
80100a82:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100a85:	c7 05 08 09 11 80 80 	movl   $0x80100280,0x80110908
80100a8c:	02 10 80 
  cons.locking = 1;
80100a8f:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
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
80100b34:	e8 f7 64 00 00       	call   80107030 <setupkvm>
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
80100ba3:	e8 a8 62 00 00       	call   80106e50 <allocuvm>
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
80100bd9:	e8 82 61 00 00       	call   80106d60 <loaduvm>
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
80100c1b:	e8 90 63 00 00       	call   80106fb0 <freevm>
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
80100c62:	e8 e9 61 00 00       	call   80106e50 <allocuvm>
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
80100c83:	e8 48 64 00 00       	call   801070d0 <clearpteu>
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
80100cd3:	e8 08 3c 00 00       	call   801048e0 <strlen>
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
80100ce7:	e8 f4 3b 00 00       	call   801048e0 <strlen>
80100cec:	83 c0 01             	add    $0x1,%eax
80100cef:	50                   	push   %eax
80100cf0:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cf3:	ff 34 b8             	push   (%eax,%edi,4)
80100cf6:	53                   	push   %ebx
80100cf7:	56                   	push   %esi
80100cf8:	e8 a3 65 00 00       	call   801072a0 <copyout>
80100cfd:	83 c4 20             	add    $0x20,%esp
80100d00:	85 c0                	test   %eax,%eax
80100d02:	79 ac                	jns    80100cb0 <exec+0x200>
80100d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80100d08:	83 ec 0c             	sub    $0xc,%esp
80100d0b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d11:	e8 9a 62 00 00       	call   80106fb0 <freevm>
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
80100d63:	e8 38 65 00 00       	call   801072a0 <copyout>
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
80100da1:	e8 fa 3a 00 00       	call   801048a0 <safestrcpy>
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
80100dcd:	e8 fe 5d 00 00       	call   80106bd0 <switchuvm>
  freevm(oldpgdir);
80100dd2:	89 3c 24             	mov    %edi,(%esp)
80100dd5:	e8 d6 61 00 00       	call   80106fb0 <freevm>
  return 0;
80100dda:	83 c4 10             	add    $0x10,%esp
80100ddd:	31 c0                	xor    %eax,%eax
80100ddf:	e9 38 fd ff ff       	jmp    80100b1c <exec+0x6c>
    end_op();
80100de4:	e8 e7 1f 00 00       	call   80102dd0 <end_op>
    cprintf("exec: fail\n");
80100de9:	83 ec 0c             	sub    $0xc,%esp
80100dec:	68 81 7a 10 80       	push   $0x80107a81
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
80100e16:	68 8d 7a 10 80       	push   $0x80107a8d
80100e1b:	68 60 ff 10 80       	push   $0x8010ff60
80100e20:	e8 2b 36 00 00       	call   80104450 <initlock>
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
80100e34:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
{
80100e39:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e3c:	68 60 ff 10 80       	push   $0x8010ff60
80100e41:	e8 da 37 00 00       	call   80104620 <acquire>
80100e46:	83 c4 10             	add    $0x10,%esp
80100e49:	eb 10                	jmp    80100e5b <filealloc+0x2b>
80100e4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e4f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e50:	83 c3 18             	add    $0x18,%ebx
80100e53:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
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
80100e6c:	68 60 ff 10 80       	push   $0x8010ff60
80100e71:	e8 4a 37 00 00       	call   801045c0 <release>
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
80100e85:	68 60 ff 10 80       	push   $0x8010ff60
80100e8a:	e8 31 37 00 00       	call   801045c0 <release>
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
80100eaa:	68 60 ff 10 80       	push   $0x8010ff60
80100eaf:	e8 6c 37 00 00       	call   80104620 <acquire>
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
80100ec7:	68 60 ff 10 80       	push   $0x8010ff60
80100ecc:	e8 ef 36 00 00       	call   801045c0 <release>
  return f;
}
80100ed1:	89 d8                	mov    %ebx,%eax
80100ed3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ed6:	c9                   	leave  
80100ed7:	c3                   	ret    
    panic("filedup");
80100ed8:	83 ec 0c             	sub    $0xc,%esp
80100edb:	68 94 7a 10 80       	push   $0x80107a94
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
80100efc:	68 60 ff 10 80       	push   $0x8010ff60
80100f01:	e8 1a 37 00 00       	call   80104620 <acquire>
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
80100f34:	68 60 ff 10 80       	push   $0x8010ff60
  ff = *f;
80100f39:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f3c:	e8 7f 36 00 00       	call   801045c0 <release>

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
80100f60:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80100f67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f6a:	5b                   	pop    %ebx
80100f6b:	5e                   	pop    %esi
80100f6c:	5f                   	pop    %edi
80100f6d:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f6e:	e9 4d 36 00 00       	jmp    801045c0 <release>
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
80100fbc:	68 9c 7a 10 80       	push   $0x80107a9c
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
801010a2:	68 a6 7a 10 80       	push   $0x80107aa6
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
80101177:	68 af 7a 10 80       	push   $0x80107aaf
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
801011b1:	68 b5 7a 10 80       	push   $0x80107ab5
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
801011c8:	03 05 cc 25 11 80    	add    0x801125cc,%eax
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
80101227:	68 bf 7a 10 80       	push   $0x80107abf
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
80101249:	8b 0d b4 25 11 80    	mov    0x801125b4,%ecx
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
8010126c:	03 05 cc 25 11 80    	add    0x801125cc,%eax
80101272:	50                   	push   %eax
80101273:	ff 75 d8             	push   -0x28(%ebp)
80101276:	e8 55 ee ff ff       	call   801000d0 <bread>
8010127b:	83 c4 10             	add    $0x10,%esp
8010127e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101281:	a1 b4 25 11 80       	mov    0x801125b4,%eax
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
801012d9:	39 05 b4 25 11 80    	cmp    %eax,0x801125b4
801012df:	77 80                	ja     80101261 <balloc+0x21>
  panic("balloc: out of blocks");
801012e1:	83 ec 0c             	sub    $0xc,%esp
801012e4:	68 d2 7a 10 80       	push   $0x80107ad2
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
80101325:	e8 b6 33 00 00       	call   801046e0 <memset>
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
8010135a:	bb 94 09 11 80       	mov    $0x80110994,%ebx
{
8010135f:	83 ec 28             	sub    $0x28,%esp
80101362:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101365:	68 60 09 11 80       	push   $0x80110960
8010136a:	e8 b1 32 00 00       	call   80104620 <acquire>
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
8010138a:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
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
801013a9:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
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
801013d2:	68 60 09 11 80       	push   $0x80110960
801013d7:	e8 e4 31 00 00       	call   801045c0 <release>

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
801013fd:	68 60 09 11 80       	push   $0x80110960
      ip->ref++;
80101402:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101405:	e8 b6 31 00 00       	call   801045c0 <release>
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
8010141d:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101423:	73 10                	jae    80101435 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101425:	8b 43 08             	mov    0x8(%ebx),%eax
80101428:	85 c0                	test   %eax,%eax
8010142a:	0f 8f 50 ff ff ff    	jg     80101380 <iget+0x30>
80101430:	e9 68 ff ff ff       	jmp    8010139d <iget+0x4d>
    panic("iget: no inodes");
80101435:	83 ec 0c             	sub    $0xc,%esp
80101438:	68 e8 7a 10 80       	push   $0x80107ae8
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
80101515:	68 f8 7a 10 80       	push   $0x80107af8
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
80101541:	e8 3a 32 00 00       	call   80104780 <memmove>
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
80101564:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
80101569:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010156c:	68 0b 7b 10 80       	push   $0x80107b0b
80101571:	68 60 09 11 80       	push   $0x80110960
80101576:	e8 d5 2e 00 00       	call   80104450 <initlock>
  for(i = 0; i < NINODE; i++) {
8010157b:	83 c4 10             	add    $0x10,%esp
8010157e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101580:	83 ec 08             	sub    $0x8,%esp
80101583:	68 12 7b 10 80       	push   $0x80107b12
80101588:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101589:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010158f:	e8 8c 2d 00 00       	call   80104320 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101594:	83 c4 10             	add    $0x10,%esp
80101597:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
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
801015b7:	68 b4 25 11 80       	push   $0x801125b4
801015bc:	e8 bf 31 00 00       	call   80104780 <memmove>
  brelse(bp);
801015c1:	89 1c 24             	mov    %ebx,(%esp)
801015c4:	e8 27 ec ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801015c9:	ff 35 cc 25 11 80    	push   0x801125cc
801015cf:	ff 35 c8 25 11 80    	push   0x801125c8
801015d5:	ff 35 c4 25 11 80    	push   0x801125c4
801015db:	ff 35 c0 25 11 80    	push   0x801125c0
801015e1:	ff 35 bc 25 11 80    	push   0x801125bc
801015e7:	ff 35 b8 25 11 80    	push   0x801125b8
801015ed:	ff 35 b4 25 11 80    	push   0x801125b4
801015f3:	68 78 7b 10 80       	push   $0x80107b78
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
8010161c:	83 3d bc 25 11 80 01 	cmpl   $0x1,0x801125bc
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
8010164f:	3b 3d bc 25 11 80    	cmp    0x801125bc,%edi
80101655:	73 69                	jae    801016c0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101657:	89 f8                	mov    %edi,%eax
80101659:	83 ec 08             	sub    $0x8,%esp
8010165c:	c1 e8 03             	shr    $0x3,%eax
8010165f:	03 05 c8 25 11 80    	add    0x801125c8,%eax
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
8010168e:	e8 4d 30 00 00       	call   801046e0 <memset>
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
801016c3:	68 18 7b 10 80       	push   $0x80107b18
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
801016e4:	03 05 c8 25 11 80    	add    0x801125c8,%eax
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
80101731:	e8 4a 30 00 00       	call   80104780 <memmove>
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
8010175a:	68 60 09 11 80       	push   $0x80110960
8010175f:	e8 bc 2e 00 00       	call   80104620 <acquire>
  ip->ref++;
80101764:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101768:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010176f:	e8 4c 2e 00 00       	call   801045c0 <release>
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
801017a2:	e8 b9 2b 00 00       	call   80104360 <acquiresleep>
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
801017c9:	03 05 c8 25 11 80    	add    0x801125c8,%eax
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
80101818:	e8 63 2f 00 00       	call   80104780 <memmove>
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
8010183d:	68 30 7b 10 80       	push   $0x80107b30
80101842:	e8 39 eb ff ff       	call   80100380 <panic>
    panic("ilock");
80101847:	83 ec 0c             	sub    $0xc,%esp
8010184a:	68 2a 7b 10 80       	push   $0x80107b2a
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
80101873:	e8 88 2b 00 00       	call   80104400 <holdingsleep>
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
8010188f:	e9 2c 2b 00 00       	jmp    801043c0 <releasesleep>
    panic("iunlock");
80101894:	83 ec 0c             	sub    $0xc,%esp
80101897:	68 3f 7b 10 80       	push   $0x80107b3f
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
801018c0:	e8 9b 2a 00 00       	call   80104360 <acquiresleep>
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
801018da:	e8 e1 2a 00 00       	call   801043c0 <releasesleep>
  acquire(&icache.lock);
801018df:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801018e6:	e8 35 2d 00 00       	call   80104620 <acquire>
  ip->ref--;
801018eb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018ef:	83 c4 10             	add    $0x10,%esp
801018f2:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
801018f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018fc:	5b                   	pop    %ebx
801018fd:	5e                   	pop    %esi
801018fe:	5f                   	pop    %edi
801018ff:	5d                   	pop    %ebp
  release(&icache.lock);
80101900:	e9 bb 2c 00 00       	jmp    801045c0 <release>
80101905:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101908:	83 ec 0c             	sub    $0xc,%esp
8010190b:	68 60 09 11 80       	push   $0x80110960
80101910:	e8 0b 2d 00 00       	call   80104620 <acquire>
    int r = ip->ref;
80101915:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101918:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010191f:	e8 9c 2c 00 00       	call   801045c0 <release>
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
80101a23:	e8 d8 29 00 00       	call   80104400 <holdingsleep>
80101a28:	83 c4 10             	add    $0x10,%esp
80101a2b:	85 c0                	test   %eax,%eax
80101a2d:	74 21                	je     80101a50 <iunlockput+0x40>
80101a2f:	8b 43 08             	mov    0x8(%ebx),%eax
80101a32:	85 c0                	test   %eax,%eax
80101a34:	7e 1a                	jle    80101a50 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101a36:	83 ec 0c             	sub    $0xc,%esp
80101a39:	56                   	push   %esi
80101a3a:	e8 81 29 00 00       	call   801043c0 <releasesleep>
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
80101a53:	68 3f 7b 10 80       	push   $0x80107b3f
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
80101b37:	e8 44 2c 00 00       	call   80104780 <memmove>
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
80101b6a:	8b 04 c5 00 09 11 80 	mov    -0x7feef700(,%eax,8),%eax
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
80101c33:	e8 48 2b 00 00       	call   80104780 <memmove>
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
80101c7a:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
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
80101cce:	e8 1d 2b 00 00       	call   801047f0 <strncmp>
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
80101d2d:	e8 be 2a 00 00       	call   801047f0 <strncmp>
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
80101d72:	68 59 7b 10 80       	push   $0x80107b59
80101d77:	e8 04 e6 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101d7c:	83 ec 0c             	sub    $0xc,%esp
80101d7f:	68 47 7b 10 80       	push   $0x80107b47
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
80101db5:	68 60 09 11 80       	push   $0x80110960
80101dba:	e8 61 28 00 00       	call   80104620 <acquire>
  ip->ref++;
80101dbf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101dc3:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101dca:	e8 f1 27 00 00       	call   801045c0 <release>
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
80101e27:	e8 54 29 00 00       	call   80104780 <memmove>
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
80101e8c:	e8 6f 25 00 00       	call   80104400 <holdingsleep>
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
80101eae:	e8 0d 25 00 00       	call   801043c0 <releasesleep>
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
80101edb:	e8 a0 28 00 00       	call   80104780 <memmove>
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
80101f2b:	e8 d0 24 00 00       	call   80104400 <holdingsleep>
80101f30:	83 c4 10             	add    $0x10,%esp
80101f33:	85 c0                	test   %eax,%eax
80101f35:	0f 84 91 00 00 00    	je     80101fcc <namex+0x23c>
80101f3b:	8b 46 08             	mov    0x8(%esi),%eax
80101f3e:	85 c0                	test   %eax,%eax
80101f40:	0f 8e 86 00 00 00    	jle    80101fcc <namex+0x23c>
  releasesleep(&ip->lock);
80101f46:	83 ec 0c             	sub    $0xc,%esp
80101f49:	53                   	push   %ebx
80101f4a:	e8 71 24 00 00       	call   801043c0 <releasesleep>
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
80101f6d:	e8 8e 24 00 00       	call   80104400 <holdingsleep>
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
80101f90:	e8 6b 24 00 00       	call   80104400 <holdingsleep>
80101f95:	83 c4 10             	add    $0x10,%esp
80101f98:	85 c0                	test   %eax,%eax
80101f9a:	74 30                	je     80101fcc <namex+0x23c>
80101f9c:	8b 7e 08             	mov    0x8(%esi),%edi
80101f9f:	85 ff                	test   %edi,%edi
80101fa1:	7e 29                	jle    80101fcc <namex+0x23c>
  releasesleep(&ip->lock);
80101fa3:	83 ec 0c             	sub    $0xc,%esp
80101fa6:	53                   	push   %ebx
80101fa7:	e8 14 24 00 00       	call   801043c0 <releasesleep>
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
80101fcf:	68 3f 7b 10 80       	push   $0x80107b3f
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
8010203d:	e8 fe 27 00 00       	call   80104840 <strncpy>
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
8010207b:	68 68 7b 10 80       	push   $0x80107b68
80102080:	e8 fb e2 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102085:	83 ec 0c             	sub    $0xc,%esp
80102088:	68 52 81 10 80       	push   $0x80108152
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
8010219b:	68 d4 7b 10 80       	push   $0x80107bd4
801021a0:	e8 db e1 ff ff       	call   80100380 <panic>
    panic("idestart");
801021a5:	83 ec 0c             	sub    $0xc,%esp
801021a8:	68 cb 7b 10 80       	push   $0x80107bcb
801021ad:	e8 ce e1 ff ff       	call   80100380 <panic>
801021b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021c0 <ideinit>:
{
801021c0:	55                   	push   %ebp
801021c1:	89 e5                	mov    %esp,%ebp
801021c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801021c6:	68 e6 7b 10 80       	push   $0x80107be6
801021cb:	68 00 26 11 80       	push   $0x80112600
801021d0:	e8 7b 22 00 00       	call   80104450 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801021d5:	58                   	pop    %eax
801021d6:	a1 84 27 11 80       	mov    0x80112784,%eax
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
8010221a:	c7 05 e0 25 11 80 01 	movl   $0x1,0x801125e0
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
80102249:	68 00 26 11 80       	push   $0x80112600
8010224e:	e8 cd 23 00 00       	call   80104620 <acquire>

  if((b = idequeue) == 0){
80102253:	8b 1d e4 25 11 80    	mov    0x801125e4,%ebx
80102259:	83 c4 10             	add    $0x10,%esp
8010225c:	85 db                	test   %ebx,%ebx
8010225e:	74 63                	je     801022c3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102260:	8b 43 58             	mov    0x58(%ebx),%eax
80102263:	a3 e4 25 11 80       	mov    %eax,0x801125e4

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
801022ad:	e8 ce 1e 00 00       	call   80104180 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801022b2:	a1 e4 25 11 80       	mov    0x801125e4,%eax
801022b7:	83 c4 10             	add    $0x10,%esp
801022ba:	85 c0                	test   %eax,%eax
801022bc:	74 05                	je     801022c3 <ideintr+0x83>
    idestart(idequeue);
801022be:	e8 1d fe ff ff       	call   801020e0 <idestart>
    release(&idelock);
801022c3:	83 ec 0c             	sub    $0xc,%esp
801022c6:	68 00 26 11 80       	push   $0x80112600
801022cb:	e8 f0 22 00 00       	call   801045c0 <release>

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
801022ee:	e8 0d 21 00 00       	call   80104400 <holdingsleep>
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
80102313:	a1 e0 25 11 80       	mov    0x801125e0,%eax
80102318:	85 c0                	test   %eax,%eax
8010231a:	0f 84 87 00 00 00    	je     801023a7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102320:	83 ec 0c             	sub    $0xc,%esp
80102323:	68 00 26 11 80       	push   $0x80112600
80102328:	e8 f3 22 00 00       	call   80104620 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010232d:	a1 e4 25 11 80       	mov    0x801125e4,%eax
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
8010234e:	39 1d e4 25 11 80    	cmp    %ebx,0x801125e4
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
80102363:	68 00 26 11 80       	push   $0x80112600
80102368:	53                   	push   %ebx
80102369:	e8 52 1d 00 00       	call   801040c0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010236e:	8b 03                	mov    (%ebx),%eax
80102370:	83 c4 10             	add    $0x10,%esp
80102373:	83 e0 06             	and    $0x6,%eax
80102376:	83 f8 02             	cmp    $0x2,%eax
80102379:	75 e5                	jne    80102360 <iderw+0x80>
  }


  release(&idelock);
8010237b:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
}
80102382:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102385:	c9                   	leave  
  release(&idelock);
80102386:	e9 35 22 00 00       	jmp    801045c0 <release>
8010238b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010238f:	90                   	nop
    idestart(b);
80102390:	89 d8                	mov    %ebx,%eax
80102392:	e8 49 fd ff ff       	call   801020e0 <idestart>
80102397:	eb bd                	jmp    80102356 <iderw+0x76>
80102399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023a0:	ba e4 25 11 80       	mov    $0x801125e4,%edx
801023a5:	eb a5                	jmp    8010234c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801023a7:	83 ec 0c             	sub    $0xc,%esp
801023aa:	68 15 7c 10 80       	push   $0x80107c15
801023af:	e8 cc df ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
801023b4:	83 ec 0c             	sub    $0xc,%esp
801023b7:	68 00 7c 10 80       	push   $0x80107c00
801023bc:	e8 bf df ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
801023c1:	83 ec 0c             	sub    $0xc,%esp
801023c4:	68 ea 7b 10 80       	push   $0x80107bea
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
801023d1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801023d8:	00 c0 fe 
{
801023db:	89 e5                	mov    %esp,%ebp
801023dd:	56                   	push   %esi
801023de:	53                   	push   %ebx
  ioapic->reg = reg;
801023df:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801023e6:	00 00 00 
  return ioapic->data;
801023e9:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801023ef:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801023f2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801023f8:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801023fe:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
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
8010241a:	68 34 7c 10 80       	push   $0x80107c34
8010241f:	e8 7c e2 ff ff       	call   801006a0 <cprintf>
  ioapic->reg = reg;
80102424:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
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
80102444:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
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
8010245e:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
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
80102481:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
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
80102495:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010249b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010249e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801024a4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801024a6:	a1 34 26 11 80       	mov    0x80112634,%eax
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
801024d2:	81 fb d0 b6 11 80    	cmp    $0x8011b6d0,%ebx
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
801024f2:	e8 e9 21 00 00       	call   801046e0 <memset>

  if(kmem.use_lock)
801024f7:	8b 15 74 26 11 80    	mov    0x80112674,%edx
801024fd:	83 c4 10             	add    $0x10,%esp
80102500:	85 d2                	test   %edx,%edx
80102502:	75 1c                	jne    80102520 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102504:	a1 78 26 11 80       	mov    0x80112678,%eax
80102509:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010250b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102510:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
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
80102523:	68 40 26 11 80       	push   $0x80112640
80102528:	e8 f3 20 00 00       	call   80104620 <acquire>
8010252d:	83 c4 10             	add    $0x10,%esp
80102530:	eb d2                	jmp    80102504 <kfree+0x44>
80102532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102538:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010253f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102542:	c9                   	leave  
    release(&kmem.lock);
80102543:	e9 78 20 00 00       	jmp    801045c0 <release>
    panic("kfree");
80102548:	83 ec 0c             	sub    $0xc,%esp
8010254b:	68 66 7c 10 80       	push   $0x80107c66
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
801025f4:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
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
8010261b:	68 6c 7c 10 80       	push   $0x80107c6c
80102620:	68 40 26 11 80       	push   $0x80112640
80102625:	e8 26 1e 00 00       	call   80104450 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010262a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010262d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102630:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
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
80102680:	a1 74 26 11 80       	mov    0x80112674,%eax
80102685:	85 c0                	test   %eax,%eax
80102687:	75 1f                	jne    801026a8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102689:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
8010268e:	85 c0                	test   %eax,%eax
80102690:	74 0e                	je     801026a0 <kalloc+0x20>
    kmem.freelist = r->next;
80102692:	8b 10                	mov    (%eax),%edx
80102694:	89 15 78 26 11 80    	mov    %edx,0x80112678
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
801026ae:	68 40 26 11 80       	push   $0x80112640
801026b3:	e8 68 1f 00 00       	call   80104620 <acquire>
  r = kmem.freelist;
801026b8:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(kmem.use_lock)
801026bd:	8b 15 74 26 11 80    	mov    0x80112674,%edx
  if(r)
801026c3:	83 c4 10             	add    $0x10,%esp
801026c6:	85 c0                	test   %eax,%eax
801026c8:	74 08                	je     801026d2 <kalloc+0x52>
    kmem.freelist = r->next;
801026ca:	8b 08                	mov    (%eax),%ecx
801026cc:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
801026d2:	85 d2                	test   %edx,%edx
801026d4:	74 16                	je     801026ec <kalloc+0x6c>
    release(&kmem.lock);
801026d6:	83 ec 0c             	sub    $0xc,%esp
801026d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801026dc:	68 40 26 11 80       	push   $0x80112640
801026e1:	e8 da 1e 00 00       	call   801045c0 <release>
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
80102708:	8b 1d 7c 26 11 80    	mov    0x8011267c,%ebx
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
8010272b:	0f b6 91 a0 7d 10 80 	movzbl -0x7fef8260(%ecx),%edx
  shift ^= togglecode[data];
80102732:	0f b6 81 a0 7c 10 80 	movzbl -0x7fef8360(%ecx),%eax
  shift |= shiftcode[data];
80102739:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010273b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010273d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010273f:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
  c = charcode[shift & (CTL | SHIFT)][data];
80102745:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102748:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010274b:	8b 04 85 80 7c 10 80 	mov    -0x7fef8380(,%eax,4),%eax
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
80102775:	89 1d 7c 26 11 80    	mov    %ebx,0x8011267c
}
8010277b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010277e:	c9                   	leave  
8010277f:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
80102780:	83 e0 7f             	and    $0x7f,%eax
80102783:	85 d2                	test   %edx,%edx
80102785:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102788:	0f b6 81 a0 7d 10 80 	movzbl -0x7fef8260(%ecx),%eax
8010278f:	83 c8 40             	or     $0x40,%eax
80102792:	0f b6 c0             	movzbl %al,%eax
80102795:	f7 d0                	not    %eax
80102797:	21 d8                	and    %ebx,%eax
}
80102799:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
8010279c:	a3 7c 26 11 80       	mov    %eax,0x8011267c
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
801027f0:	a1 80 26 11 80       	mov    0x80112680,%eax
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
801028f0:	a1 80 26 11 80       	mov    0x80112680,%eax
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
80102910:	a1 80 26 11 80       	mov    0x80112680,%eax
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
8010297e:	a1 80 26 11 80       	mov    0x80112680,%eax
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
80102af7:	e8 34 1c 00 00       	call   80104730 <memcmp>
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
80102bc0:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
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
80102be0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102be5:	83 ec 08             	sub    $0x8,%esp
80102be8:	01 f8                	add    %edi,%eax
80102bea:	83 c0 01             	add    $0x1,%eax
80102bed:	50                   	push   %eax
80102bee:	ff 35 e4 26 11 80    	push   0x801126e4
80102bf4:	e8 d7 d4 ff ff       	call   801000d0 <bread>
80102bf9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bfb:	58                   	pop    %eax
80102bfc:	5a                   	pop    %edx
80102bfd:	ff 34 bd ec 26 11 80 	push   -0x7feed914(,%edi,4)
80102c04:	ff 35 e4 26 11 80    	push   0x801126e4
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
80102c24:	e8 57 1b 00 00       	call   80104780 <memmove>
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
80102c44:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
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
80102c67:	ff 35 d4 26 11 80    	push   0x801126d4
80102c6d:	ff 35 e4 26 11 80    	push   0x801126e4
80102c73:	e8 58 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c78:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c7b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102c7d:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102c82:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102c85:	85 c0                	test   %eax,%eax
80102c87:	7e 19                	jle    80102ca2 <write_head+0x42>
80102c89:	31 d2                	xor    %edx,%edx
80102c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c8f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102c90:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
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
80102cca:	68 a0 7e 10 80       	push   $0x80107ea0
80102ccf:	68 a0 26 11 80       	push   $0x801126a0
80102cd4:	e8 77 17 00 00       	call   80104450 <initlock>
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
80102ce9:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102cef:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102cf2:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
80102cf7:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  struct buf *buf = bread(log.dev, log.start);
80102cfd:	5a                   	pop    %edx
80102cfe:	50                   	push   %eax
80102cff:	53                   	push   %ebx
80102d00:	e8 cb d3 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102d05:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102d08:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102d0b:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102d11:	85 db                	test   %ebx,%ebx
80102d13:	7e 1d                	jle    80102d32 <initlog+0x72>
80102d15:	31 d2                	xor    %edx,%edx
80102d17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d1e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102d20:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102d24:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
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
80102d40:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
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
80102d66:	68 a0 26 11 80       	push   $0x801126a0
80102d6b:	e8 b0 18 00 00       	call   80104620 <acquire>
80102d70:	83 c4 10             	add    $0x10,%esp
80102d73:	eb 18                	jmp    80102d8d <begin_op+0x2d>
80102d75:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d78:	83 ec 08             	sub    $0x8,%esp
80102d7b:	68 a0 26 11 80       	push   $0x801126a0
80102d80:	68 a0 26 11 80       	push   $0x801126a0
80102d85:	e8 36 13 00 00       	call   801040c0 <sleep>
80102d8a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102d8d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102d92:	85 c0                	test   %eax,%eax
80102d94:	75 e2                	jne    80102d78 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d96:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102d9b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
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
80102db2:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102db7:	68 a0 26 11 80       	push   $0x801126a0
80102dbc:	e8 ff 17 00 00       	call   801045c0 <release>
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
80102dd9:	68 a0 26 11 80       	push   $0x801126a0
80102dde:	e8 3d 18 00 00       	call   80104620 <acquire>
  log.outstanding -= 1;
80102de3:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102de8:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102dee:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102df1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102df4:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102dfa:	85 f6                	test   %esi,%esi
80102dfc:	0f 85 22 01 00 00    	jne    80102f24 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102e02:	85 db                	test   %ebx,%ebx
80102e04:	0f 85 f6 00 00 00    	jne    80102f00 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102e0a:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102e11:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102e14:	83 ec 0c             	sub    $0xc,%esp
80102e17:	68 a0 26 11 80       	push   $0x801126a0
80102e1c:	e8 9f 17 00 00       	call   801045c0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102e21:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102e27:	83 c4 10             	add    $0x10,%esp
80102e2a:	85 c9                	test   %ecx,%ecx
80102e2c:	7f 42                	jg     80102e70 <end_op+0xa0>
    acquire(&log.lock);
80102e2e:	83 ec 0c             	sub    $0xc,%esp
80102e31:	68 a0 26 11 80       	push   $0x801126a0
80102e36:	e8 e5 17 00 00       	call   80104620 <acquire>
    wakeup(&log);
80102e3b:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80102e42:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102e49:	00 00 00 
    wakeup(&log);
80102e4c:	e8 2f 13 00 00       	call   80104180 <wakeup>
    release(&log.lock);
80102e51:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e58:	e8 63 17 00 00       	call   801045c0 <release>
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
80102e70:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102e75:	83 ec 08             	sub    $0x8,%esp
80102e78:	01 d8                	add    %ebx,%eax
80102e7a:	83 c0 01             	add    $0x1,%eax
80102e7d:	50                   	push   %eax
80102e7e:	ff 35 e4 26 11 80    	push   0x801126e4
80102e84:	e8 47 d2 ff ff       	call   801000d0 <bread>
80102e89:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e8b:	58                   	pop    %eax
80102e8c:	5a                   	pop    %edx
80102e8d:	ff 34 9d ec 26 11 80 	push   -0x7feed914(,%ebx,4)
80102e94:	ff 35 e4 26 11 80    	push   0x801126e4
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
80102eb4:	e8 c7 18 00 00       	call   80104780 <memmove>
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
80102ed4:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102eda:	7c 94                	jl     80102e70 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102edc:	e8 7f fd ff ff       	call   80102c60 <write_head>
    install_trans(); // Now install writes to home locations
80102ee1:	e8 da fc ff ff       	call   80102bc0 <install_trans>
    log.lh.n = 0;
80102ee6:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102eed:	00 00 00 
    write_head();    // Erase the transaction from the log
80102ef0:	e8 6b fd ff ff       	call   80102c60 <write_head>
80102ef5:	e9 34 ff ff ff       	jmp    80102e2e <end_op+0x5e>
80102efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102f00:	83 ec 0c             	sub    $0xc,%esp
80102f03:	68 a0 26 11 80       	push   $0x801126a0
80102f08:	e8 73 12 00 00       	call   80104180 <wakeup>
  release(&log.lock);
80102f0d:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102f14:	e8 a7 16 00 00       	call   801045c0 <release>
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
80102f27:	68 a4 7e 10 80       	push   $0x80107ea4
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
80102f47:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
80102f4d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f50:	83 fa 1d             	cmp    $0x1d,%edx
80102f53:	0f 8f 85 00 00 00    	jg     80102fde <log_write+0x9e>
80102f59:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102f5e:	83 e8 01             	sub    $0x1,%eax
80102f61:	39 c2                	cmp    %eax,%edx
80102f63:	7d 79                	jge    80102fde <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f65:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102f6a:	85 c0                	test   %eax,%eax
80102f6c:	7e 7d                	jle    80102feb <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f6e:	83 ec 0c             	sub    $0xc,%esp
80102f71:	68 a0 26 11 80       	push   $0x801126a0
80102f76:	e8 a5 16 00 00       	call   80104620 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f7b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
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
80102f97:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
80102f9e:	75 f0                	jne    80102f90 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80102fa0:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102fa7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80102faa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80102fad:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102fb4:	c9                   	leave  
  release(&log.lock);
80102fb5:	e9 06 16 00 00       	jmp    801045c0 <release>
80102fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102fc0:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
    log.lh.n++;
80102fc7:	83 c2 01             	add    $0x1,%edx
80102fca:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
80102fd0:	eb d5                	jmp    80102fa7 <log_write+0x67>
  log.lh.block[i] = b->blockno;
80102fd2:	8b 43 08             	mov    0x8(%ebx),%eax
80102fd5:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102fda:	75 cb                	jne    80102fa7 <log_write+0x67>
80102fdc:	eb e9                	jmp    80102fc7 <log_write+0x87>
    panic("too big a transaction");
80102fde:	83 ec 0c             	sub    $0xc,%esp
80102fe1:	68 b3 7e 10 80       	push   $0x80107eb3
80102fe6:	e8 95 d3 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
80102feb:	83 ec 0c             	sub    $0xc,%esp
80102fee:	68 c9 7e 10 80       	push   $0x80107ec9
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
80103018:	68 e4 7e 10 80       	push   $0x80107ee4
8010301d:	e8 7e d6 ff ff       	call   801006a0 <cprintf>
  idtinit();       // load idt register
80103022:	e8 39 29 00 00       	call   80105960 <idtinit>
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
8010303a:	e8 71 0c 00 00       	call   80103cb0 <scheduler>
8010303f:	90                   	nop

80103040 <mpenter>:
{
80103040:	55                   	push   %ebp
80103041:	89 e5                	mov    %esp,%ebp
80103043:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103046:	e8 75 3b 00 00       	call   80106bc0 <switchkvm>
  seginit();
8010304b:	e8 60 39 00 00       	call   801069b0 <seginit>
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
80103077:	68 d0 b6 11 80       	push   $0x8011b6d0
8010307c:	e8 8f f5 ff ff       	call   80102610 <kinit1>
  kvmalloc();      // kernel page table
80103081:	e8 2a 40 00 00       	call   801070b0 <kvmalloc>
  mpinit();        // detect other processors
80103086:	e8 85 01 00 00       	call   80103210 <mpinit>
  lapicinit();     // interrupt controller
8010308b:	e8 60 f7 ff ff       	call   801027f0 <lapicinit>
  seginit();       // segment descriptors
80103090:	e8 1b 39 00 00       	call   801069b0 <seginit>
  picinit();       // disable pic
80103095:	e8 76 03 00 00       	call   80103410 <picinit>
  ioapicinit();    // another interrupt controller
8010309a:	e8 31 f3 ff ff       	call   801023d0 <ioapicinit>
  consoleinit();   // console hardware
8010309f:	e8 bc d9 ff ff       	call   80100a60 <consoleinit>
  uartinit();      // serial port
801030a4:	e8 87 2c 00 00       	call   80105d30 <uartinit>
  pinit();         // process table
801030a9:	e8 82 08 00 00       	call   80103930 <pinit>
  tvinit();        // trap vectors
801030ae:	e8 2d 28 00 00       	call   801058e0 <tvinit>
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
801030ca:	68 8c b4 10 80       	push   $0x8010b48c
801030cf:	68 00 70 00 80       	push   $0x80007000
801030d4:	e8 a7 16 00 00       	call   80104780 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801030d9:	83 c4 10             	add    $0x10,%esp
801030dc:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
801030e3:	00 00 00 
801030e6:	05 a0 27 11 80       	add    $0x801127a0,%eax
801030eb:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
801030f0:	76 7e                	jbe    80103170 <main+0x110>
801030f2:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
801030f7:	eb 20                	jmp    80103119 <main+0xb9>
801030f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103100:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
80103107:	00 00 00 
8010310a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103110:	05 a0 27 11 80       	add    $0x801127a0,%eax
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
80103134:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010313b:	a0 10 00 
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
801031be:	68 f8 7e 10 80       	push   $0x80107ef8
801031c3:	56                   	push   %esi
801031c4:	e8 67 15 00 00       	call   80104730 <memcmp>
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
80103276:	68 fd 7e 10 80       	push   $0x80107efd
8010327b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010327c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010327f:	e8 ac 14 00 00       	call   80104730 <memcmp>
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
801032d6:	a3 80 26 11 80       	mov    %eax,0x80112680
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
80103357:	88 0d 80 27 11 80    	mov    %cl,0x80112780
      continue;
8010335d:	eb 99                	jmp    801032f8 <mpinit+0xe8>
8010335f:	90                   	nop
      if(ncpu < NCPU) {
80103360:	8b 0d 84 27 11 80    	mov    0x80112784,%ecx
80103366:	83 f9 07             	cmp    $0x7,%ecx
80103369:	7f 19                	jg     80103384 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010336b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103371:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103375:	83 c1 01             	add    $0x1,%ecx
80103378:	89 0d 84 27 11 80    	mov    %ecx,0x80112784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010337e:	88 9f a0 27 11 80    	mov    %bl,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
80103384:	83 c0 14             	add    $0x14,%eax
      continue;
80103387:	e9 6c ff ff ff       	jmp    801032f8 <mpinit+0xe8>
8010338c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103390:	83 ec 0c             	sub    $0xc,%esp
80103393:	68 02 7f 10 80       	push   $0x80107f02
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
801033c2:	68 f8 7e 10 80       	push   $0x80107ef8
801033c7:	53                   	push   %ebx
801033c8:	e8 63 13 00 00       	call   80104730 <memcmp>
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
801033f8:	68 1c 7f 10 80       	push   $0x80107f1c
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
801034a3:	68 3b 7f 10 80       	push   $0x80107f3b
801034a8:	50                   	push   %eax
801034a9:	e8 a2 0f 00 00       	call   80104450 <initlock>
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
8010353f:	e8 dc 10 00 00       	call   80104620 <acquire>
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
8010355f:	e8 1c 0c 00 00       	call   80104180 <wakeup>
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
80103584:	e9 37 10 00 00       	jmp    801045c0 <release>
80103589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103590:	83 ec 0c             	sub    $0xc,%esp
80103593:	53                   	push   %ebx
80103594:	e8 27 10 00 00       	call   801045c0 <release>
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
801035c4:	e8 b7 0b 00 00       	call   80104180 <wakeup>
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
801035dd:	e8 3e 10 00 00       	call   80104620 <acquire>
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
80103638:	e8 43 0b 00 00       	call   80104180 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010363d:	58                   	pop    %eax
8010363e:	5a                   	pop    %edx
8010363f:	53                   	push   %ebx
80103640:	56                   	push   %esi
80103641:	e8 7a 0a 00 00       	call   801040c0 <sleep>
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
8010366c:	e8 4f 0f 00 00       	call   801045c0 <release>
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
801036ba:	e8 c1 0a 00 00       	call   80104180 <wakeup>
  release(&p->lock);
801036bf:	89 1c 24             	mov    %ebx,(%esp)
801036c2:	e8 f9 0e 00 00       	call   801045c0 <release>
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
801036e6:	e8 35 0f 00 00       	call   80104620 <acquire>
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
80103715:	e8 a6 09 00 00       	call   801040c0 <sleep>
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
80103776:	e8 05 0a 00 00       	call   80104180 <wakeup>
  release(&p->lock);
8010377b:	89 34 24             	mov    %esi,(%esp)
8010377e:	e8 3d 0e 00 00       	call   801045c0 <release>
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
80103799:	e8 22 0e 00 00       	call   801045c0 <release>
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
801037b4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801037b9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801037bc:	68 20 2d 11 80       	push   $0x80112d20
801037c1:	e8 5a 0e 00 00       	call   80104620 <acquire>
801037c6:	83 c4 10             	add    $0x10,%esp
801037c9:	eb 17                	jmp    801037e2 <allocproc+0x32>
801037cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037cf:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037d0:	81 c3 c4 01 00 00    	add    $0x1c4,%ebx
801037d6:	81 fb 54 9e 11 80    	cmp    $0x80119e54,%ebx
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
801037e9:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
801037ee:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801037f1:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801037f8:	89 43 10             	mov    %eax,0x10(%ebx)
801037fb:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
801037fe:	68 20 2d 11 80       	push   $0x80112d20
  p->pid = nextpid++;
80103803:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103809:	e8 b2 0d 00 00       	call   801045c0 <release>

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
80103832:	c7 40 14 d2 58 10 80 	movl   $0x801058d2,0x14(%eax)
  p->context = (struct context*)sp;
80103839:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010383c:	6a 14                	push   $0x14
8010383e:	6a 00                	push   $0x0
80103840:	50                   	push   %eax
80103841:	e8 9a 0e 00 00       	call   801046e0 <memset>
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
801038ad:	68 20 2d 11 80       	push   $0x80112d20
801038b2:	e8 09 0d 00 00       	call   801045c0 <release>
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
801038e6:	68 20 2d 11 80       	push   $0x80112d20
801038eb:	e8 d0 0c 00 00       	call   801045c0 <release>

  if (first) {
801038f0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
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
80103900:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
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
80103936:	68 40 7f 10 80       	push   $0x80107f40
8010393b:	68 20 2d 11 80       	push   $0x80112d20
80103940:	e8 0b 0b 00 00       	call   80104450 <initlock>
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
80103961:	8b 35 84 27 11 80    	mov    0x80112784,%esi
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
8010397d:	0f b6 99 a0 27 11 80 	movzbl -0x7feed860(%ecx),%ebx
80103984:	39 c3                	cmp    %eax,%ebx
80103986:	75 e8                	jne    80103970 <mycpu+0x20>
}
80103988:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010398b:	8d 81 a0 27 11 80    	lea    -0x7feed860(%ecx),%eax
}
80103991:	5b                   	pop    %ebx
80103992:	5e                   	pop    %esi
80103993:	5d                   	pop    %ebp
80103994:	c3                   	ret    
  panic("unknown apicid\n");
80103995:	83 ec 0c             	sub    $0xc,%esp
80103998:	68 47 7f 10 80       	push   $0x80107f47
8010399d:	e8 de c9 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
801039a2:	83 ec 0c             	sub    $0xc,%esp
801039a5:	68 24 80 10 80       	push   $0x80108024
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
801039bc:	2d a0 27 11 80       	sub    $0x801127a0,%eax
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
801039d7:	e8 f4 0a 00 00       	call   801044d0 <pushcli>
  c = mycpu();
801039dc:	e8 6f ff ff ff       	call   80103950 <mycpu>
  p = c->proc;
801039e1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039e7:	e8 34 0b 00 00       	call   80104520 <popcli>
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
80103a0e:	a3 54 9e 11 80       	mov    %eax,0x80119e54
  if((p->pgdir = setupkvm()) == 0)
80103a13:	e8 18 36 00 00       	call   80107030 <setupkvm>
80103a18:	89 43 04             	mov    %eax,0x4(%ebx)
80103a1b:	85 c0                	test   %eax,%eax
80103a1d:	0f 84 bd 00 00 00    	je     80103ae0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a23:	83 ec 04             	sub    $0x4,%esp
80103a26:	68 2c 00 00 00       	push   $0x2c
80103a2b:	68 60 b4 10 80       	push   $0x8010b460
80103a30:	50                   	push   %eax
80103a31:	e8 aa 32 00 00       	call   80106ce0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103a36:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103a39:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103a3f:	6a 4c                	push   $0x4c
80103a41:	6a 00                	push   $0x0
80103a43:	ff 73 18             	push   0x18(%ebx)
80103a46:	e8 95 0c 00 00       	call   801046e0 <memset>
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
80103a9f:	68 70 7f 10 80       	push   $0x80107f70
80103aa4:	50                   	push   %eax
80103aa5:	e8 f6 0d 00 00       	call   801048a0 <safestrcpy>
  p->cwd = namei("/");
80103aaa:	c7 04 24 79 7f 10 80 	movl   $0x80107f79,(%esp)
80103ab1:	e8 ea e5 ff ff       	call   801020a0 <namei>
80103ab6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103ab9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ac0:	e8 5b 0b 00 00       	call   80104620 <acquire>
  p->state = RUNNABLE;
80103ac5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103acc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ad3:	e8 e8 0a 00 00       	call   801045c0 <release>
}
80103ad8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103adb:	83 c4 10             	add    $0x10,%esp
80103ade:	c9                   	leave  
80103adf:	c3                   	ret    
    panic("userinit: out of memory?");
80103ae0:	83 ec 0c             	sub    $0xc,%esp
80103ae3:	68 57 7f 10 80       	push   $0x80107f57
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
80103af8:	e8 d3 09 00 00       	call   801044d0 <pushcli>
  c = mycpu();
80103afd:	e8 4e fe ff ff       	call   80103950 <mycpu>
  p = c->proc;
80103b02:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b08:	e8 13 0a 00 00       	call   80104520 <popcli>
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
80103b1b:	e8 b0 30 00 00       	call   80106bd0 <switchuvm>
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
80103b3a:	e8 11 33 00 00       	call   80106e50 <allocuvm>
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
80103b5a:	e8 21 34 00 00       	call   80106f80 <deallocuvm>
80103b5f:	83 c4 10             	add    $0x10,%esp
80103b62:	85 c0                	test   %eax,%eax
80103b64:	75 af                	jne    80103b15 <growproc+0x25>
80103b66:	eb de                	jmp    80103b46 <growproc+0x56>
80103b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b6f:	90                   	nop

80103b70 <fork>:
{
80103b70:	55                   	push   %ebp
80103b71:	89 e5                	mov    %esp,%ebp
80103b73:	57                   	push   %edi
80103b74:	56                   	push   %esi
80103b75:	53                   	push   %ebx
80103b76:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103b79:	e8 52 09 00 00       	call   801044d0 <pushcli>
  c = mycpu();
80103b7e:	e8 cd fd ff ff       	call   80103950 <mycpu>
  p = c->proc;
80103b83:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b89:	e8 92 09 00 00       	call   80104520 <popcli>
  for (int i = 0; i < 16; ++i) {
80103b8e:	8d 83 84 00 00 00    	lea    0x84(%ebx),%eax
80103b94:	8d 8b c4 01 00 00    	lea    0x1c4(%ebx),%ecx
80103b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (curproc->addr[i].flags & MAP_PRIVATE) {
80103ba0:	8b 10                	mov    (%eax),%edx
80103ba2:	f6 c2 01             	test   $0x1,%dl
80103ba5:	74 05                	je     80103bac <fork+0x3c>
        curproc->addr[i].flags = curproc->addr[i].flags | MAP_ANONYMOUS; //Making all the mappings anonymous, because the mapping is private
80103ba7:	83 ca 04             	or     $0x4,%edx
80103baa:	89 10                	mov    %edx,(%eax)
  for (int i = 0; i < 16; ++i) {
80103bac:	83 c0 14             	add    $0x14,%eax
80103baf:	39 c1                	cmp    %eax,%ecx
80103bb1:	75 ed                	jne    80103ba0 <fork+0x30>
  if((np = allocproc()) == 0){
80103bb3:	e8 f8 fb ff ff       	call   801037b0 <allocproc>
80103bb8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103bbb:	89 c7                	mov    %eax,%edi
80103bbd:	85 c0                	test   %eax,%eax
80103bbf:	0f 84 b8 00 00 00    	je     80103c7d <fork+0x10d>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103bc5:	83 ec 08             	sub    $0x8,%esp
80103bc8:	ff 33                	push   (%ebx)
80103bca:	ff 73 04             	push   0x4(%ebx)
80103bcd:	e8 4e 35 00 00       	call   80107120 <copyuvm>
80103bd2:	83 c4 10             	add    $0x10,%esp
80103bd5:	89 47 04             	mov    %eax,0x4(%edi)
80103bd8:	85 c0                	test   %eax,%eax
80103bda:	0f 84 a4 00 00 00    	je     80103c84 <fork+0x114>
  np->sz = curproc->sz;
80103be0:	8b 03                	mov    (%ebx),%eax
80103be2:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103be5:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103be7:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103bea:	89 c8                	mov    %ecx,%eax
80103bec:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103bef:	b9 13 00 00 00       	mov    $0x13,%ecx
80103bf4:	8b 73 18             	mov    0x18(%ebx),%esi
80103bf7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103bf9:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103bfb:	8b 40 18             	mov    0x18(%eax),%eax
80103bfe:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103c05:	8d 76 00             	lea    0x0(%esi),%esi
    if(curproc->ofile[i])
80103c08:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103c0c:	85 c0                	test   %eax,%eax
80103c0e:	74 13                	je     80103c23 <fork+0xb3>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103c10:	83 ec 0c             	sub    $0xc,%esp
80103c13:	50                   	push   %eax
80103c14:	e8 87 d2 ff ff       	call   80100ea0 <filedup>
80103c19:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103c1c:	83 c4 10             	add    $0x10,%esp
80103c1f:	89 44 b7 28          	mov    %eax,0x28(%edi,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103c23:	83 c6 01             	add    $0x1,%esi
80103c26:	83 fe 10             	cmp    $0x10,%esi
80103c29:	75 dd                	jne    80103c08 <fork+0x98>
  np->cwd = idup(curproc->cwd);
80103c2b:	83 ec 0c             	sub    $0xc,%esp
80103c2e:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c31:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103c34:	e8 17 db ff ff       	call   80101750 <idup>
80103c39:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c3c:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103c3f:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c42:	8d 47 6c             	lea    0x6c(%edi),%eax
80103c45:	6a 10                	push   $0x10
80103c47:	53                   	push   %ebx
80103c48:	50                   	push   %eax
80103c49:	e8 52 0c 00 00       	call   801048a0 <safestrcpy>
  pid = np->pid;
80103c4e:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103c51:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c58:	e8 c3 09 00 00       	call   80104620 <acquire>
  np->state = RUNNABLE;
80103c5d:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103c64:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c6b:	e8 50 09 00 00       	call   801045c0 <release>
  return pid;
80103c70:	83 c4 10             	add    $0x10,%esp
}
80103c73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c76:	89 d8                	mov    %ebx,%eax
80103c78:	5b                   	pop    %ebx
80103c79:	5e                   	pop    %esi
80103c7a:	5f                   	pop    %edi
80103c7b:	5d                   	pop    %ebp
80103c7c:	c3                   	ret    
    return -1;
80103c7d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c82:	eb ef                	jmp    80103c73 <fork+0x103>
    kfree(np->kstack);
80103c84:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103c87:	83 ec 0c             	sub    $0xc,%esp
80103c8a:	ff 73 08             	push   0x8(%ebx)
80103c8d:	e8 2e e8 ff ff       	call   801024c0 <kfree>
    np->kstack = 0;
80103c92:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103c99:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103c9c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103ca3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103ca8:	eb c9                	jmp    80103c73 <fork+0x103>
80103caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103cb0 <scheduler>:
{
80103cb0:	55                   	push   %ebp
80103cb1:	89 e5                	mov    %esp,%ebp
80103cb3:	57                   	push   %edi
80103cb4:	56                   	push   %esi
80103cb5:	53                   	push   %ebx
80103cb6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103cb9:	e8 92 fc ff ff       	call   80103950 <mycpu>
  c->proc = 0;
80103cbe:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103cc5:	00 00 00 
  struct cpu *c = mycpu();
80103cc8:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103cca:	8d 78 04             	lea    0x4(%eax),%edi
80103ccd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103cd0:	fb                   	sti    
    acquire(&ptable.lock);
80103cd1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cd4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103cd9:	68 20 2d 11 80       	push   $0x80112d20
80103cde:	e8 3d 09 00 00       	call   80104620 <acquire>
80103ce3:	83 c4 10             	add    $0x10,%esp
80103ce6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ced:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80103cf0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103cf4:	75 33                	jne    80103d29 <scheduler+0x79>
      switchuvm(p);
80103cf6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103cf9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103cff:	53                   	push   %ebx
80103d00:	e8 cb 2e 00 00       	call   80106bd0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103d05:	58                   	pop    %eax
80103d06:	5a                   	pop    %edx
80103d07:	ff 73 1c             	push   0x1c(%ebx)
80103d0a:	57                   	push   %edi
      p->state = RUNNING;
80103d0b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103d12:	e8 e4 0b 00 00       	call   801048fb <swtch>
      switchkvm();
80103d17:	e8 a4 2e 00 00       	call   80106bc0 <switchkvm>
      c->proc = 0;
80103d1c:	83 c4 10             	add    $0x10,%esp
80103d1f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103d26:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d29:	81 c3 c4 01 00 00    	add    $0x1c4,%ebx
80103d2f:	81 fb 54 9e 11 80    	cmp    $0x80119e54,%ebx
80103d35:	75 b9                	jne    80103cf0 <scheduler+0x40>
    release(&ptable.lock);
80103d37:	83 ec 0c             	sub    $0xc,%esp
80103d3a:	68 20 2d 11 80       	push   $0x80112d20
80103d3f:	e8 7c 08 00 00       	call   801045c0 <release>
    sti();
80103d44:	83 c4 10             	add    $0x10,%esp
80103d47:	eb 87                	jmp    80103cd0 <scheduler+0x20>
80103d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d50 <sched>:
{
80103d50:	55                   	push   %ebp
80103d51:	89 e5                	mov    %esp,%ebp
80103d53:	56                   	push   %esi
80103d54:	53                   	push   %ebx
  pushcli();
80103d55:	e8 76 07 00 00       	call   801044d0 <pushcli>
  c = mycpu();
80103d5a:	e8 f1 fb ff ff       	call   80103950 <mycpu>
  p = c->proc;
80103d5f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d65:	e8 b6 07 00 00       	call   80104520 <popcli>
  if(!holding(&ptable.lock))
80103d6a:	83 ec 0c             	sub    $0xc,%esp
80103d6d:	68 20 2d 11 80       	push   $0x80112d20
80103d72:	e8 09 08 00 00       	call   80104580 <holding>
80103d77:	83 c4 10             	add    $0x10,%esp
80103d7a:	85 c0                	test   %eax,%eax
80103d7c:	74 4f                	je     80103dcd <sched+0x7d>
  if(mycpu()->ncli != 1)
80103d7e:	e8 cd fb ff ff       	call   80103950 <mycpu>
80103d83:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103d8a:	75 68                	jne    80103df4 <sched+0xa4>
  if(p->state == RUNNING)
80103d8c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103d90:	74 55                	je     80103de7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d92:	9c                   	pushf  
80103d93:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103d94:	f6 c4 02             	test   $0x2,%ah
80103d97:	75 41                	jne    80103dda <sched+0x8a>
  intena = mycpu()->intena;
80103d99:	e8 b2 fb ff ff       	call   80103950 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103d9e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103da1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103da7:	e8 a4 fb ff ff       	call   80103950 <mycpu>
80103dac:	83 ec 08             	sub    $0x8,%esp
80103daf:	ff 70 04             	push   0x4(%eax)
80103db2:	53                   	push   %ebx
80103db3:	e8 43 0b 00 00       	call   801048fb <swtch>
  mycpu()->intena = intena;
80103db8:	e8 93 fb ff ff       	call   80103950 <mycpu>
}
80103dbd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103dc0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103dc6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103dc9:	5b                   	pop    %ebx
80103dca:	5e                   	pop    %esi
80103dcb:	5d                   	pop    %ebp
80103dcc:	c3                   	ret    
    panic("sched ptable.lock");
80103dcd:	83 ec 0c             	sub    $0xc,%esp
80103dd0:	68 7b 7f 10 80       	push   $0x80107f7b
80103dd5:	e8 a6 c5 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103dda:	83 ec 0c             	sub    $0xc,%esp
80103ddd:	68 a7 7f 10 80       	push   $0x80107fa7
80103de2:	e8 99 c5 ff ff       	call   80100380 <panic>
    panic("sched running");
80103de7:	83 ec 0c             	sub    $0xc,%esp
80103dea:	68 99 7f 10 80       	push   $0x80107f99
80103def:	e8 8c c5 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103df4:	83 ec 0c             	sub    $0xc,%esp
80103df7:	68 8d 7f 10 80       	push   $0x80107f8d
80103dfc:	e8 7f c5 ff ff       	call   80100380 <panic>
80103e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e0f:	90                   	nop

80103e10 <exit>:
{
80103e10:	55                   	push   %ebp
80103e11:	89 e5                	mov    %esp,%ebp
80103e13:	57                   	push   %edi
80103e14:	56                   	push   %esi
80103e15:	53                   	push   %ebx
80103e16:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103e19:	e8 b2 fb ff ff       	call   801039d0 <myproc>
  if(curproc == initproc)
80103e1e:	39 05 54 9e 11 80    	cmp    %eax,0x80119e54
80103e24:	0f 84 07 01 00 00    	je     80103f31 <exit+0x121>
80103e2a:	89 c3                	mov    %eax,%ebx
80103e2c:	8d 70 28             	lea    0x28(%eax),%esi
80103e2f:	8d 78 68             	lea    0x68(%eax),%edi
80103e32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103e38:	8b 06                	mov    (%esi),%eax
80103e3a:	85 c0                	test   %eax,%eax
80103e3c:	74 12                	je     80103e50 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80103e3e:	83 ec 0c             	sub    $0xc,%esp
80103e41:	50                   	push   %eax
80103e42:	e8 a9 d0 ff ff       	call   80100ef0 <fileclose>
      curproc->ofile[fd] = 0;
80103e47:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103e4d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103e50:	83 c6 04             	add    $0x4,%esi
80103e53:	39 f7                	cmp    %esi,%edi
80103e55:	75 e1                	jne    80103e38 <exit+0x28>
  begin_op();
80103e57:	e8 04 ef ff ff       	call   80102d60 <begin_op>
  iput(curproc->cwd);
80103e5c:	83 ec 0c             	sub    $0xc,%esp
80103e5f:	ff 73 68             	push   0x68(%ebx)
80103e62:	e8 49 da ff ff       	call   801018b0 <iput>
  end_op();
80103e67:	e8 64 ef ff ff       	call   80102dd0 <end_op>
  curproc->cwd = 0;
80103e6c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103e73:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e7a:	e8 a1 07 00 00       	call   80104620 <acquire>
  wakeup1(curproc->parent);
80103e7f:	8b 53 14             	mov    0x14(%ebx),%edx
80103e82:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e85:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103e8a:	eb 10                	jmp    80103e9c <exit+0x8c>
80103e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e90:	05 c4 01 00 00       	add    $0x1c4,%eax
80103e95:	3d 54 9e 11 80       	cmp    $0x80119e54,%eax
80103e9a:	74 1e                	je     80103eba <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
80103e9c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103ea0:	75 ee                	jne    80103e90 <exit+0x80>
80103ea2:	3b 50 20             	cmp    0x20(%eax),%edx
80103ea5:	75 e9                	jne    80103e90 <exit+0x80>
      p->state = RUNNABLE;
80103ea7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103eae:	05 c4 01 00 00       	add    $0x1c4,%eax
80103eb3:	3d 54 9e 11 80       	cmp    $0x80119e54,%eax
80103eb8:	75 e2                	jne    80103e9c <exit+0x8c>
      p->parent = initproc;
80103eba:	8b 0d 54 9e 11 80    	mov    0x80119e54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ec0:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103ec5:	eb 17                	jmp    80103ede <exit+0xce>
80103ec7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ece:	66 90                	xchg   %ax,%ax
80103ed0:	81 c2 c4 01 00 00    	add    $0x1c4,%edx
80103ed6:	81 fa 54 9e 11 80    	cmp    $0x80119e54,%edx
80103edc:	74 3a                	je     80103f18 <exit+0x108>
    if(p->parent == curproc){
80103ede:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103ee1:	75 ed                	jne    80103ed0 <exit+0xc0>
      if(p->state == ZOMBIE)
80103ee3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103ee7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103eea:	75 e4                	jne    80103ed0 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103eec:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103ef1:	eb 11                	jmp    80103f04 <exit+0xf4>
80103ef3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ef7:	90                   	nop
80103ef8:	05 c4 01 00 00       	add    $0x1c4,%eax
80103efd:	3d 54 9e 11 80       	cmp    $0x80119e54,%eax
80103f02:	74 cc                	je     80103ed0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103f04:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f08:	75 ee                	jne    80103ef8 <exit+0xe8>
80103f0a:	3b 48 20             	cmp    0x20(%eax),%ecx
80103f0d:	75 e9                	jne    80103ef8 <exit+0xe8>
      p->state = RUNNABLE;
80103f0f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f16:	eb e0                	jmp    80103ef8 <exit+0xe8>
  curproc->state = ZOMBIE;
80103f18:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103f1f:	e8 2c fe ff ff       	call   80103d50 <sched>
  panic("zombie exit");
80103f24:	83 ec 0c             	sub    $0xc,%esp
80103f27:	68 c8 7f 10 80       	push   $0x80107fc8
80103f2c:	e8 4f c4 ff ff       	call   80100380 <panic>
    panic("init exiting");
80103f31:	83 ec 0c             	sub    $0xc,%esp
80103f34:	68 bb 7f 10 80       	push   $0x80107fbb
80103f39:	e8 42 c4 ff ff       	call   80100380 <panic>
80103f3e:	66 90                	xchg   %ax,%ax

80103f40 <wait>:
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	56                   	push   %esi
80103f44:	53                   	push   %ebx
  pushcli();
80103f45:	e8 86 05 00 00       	call   801044d0 <pushcli>
  c = mycpu();
80103f4a:	e8 01 fa ff ff       	call   80103950 <mycpu>
  p = c->proc;
80103f4f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f55:	e8 c6 05 00 00       	call   80104520 <popcli>
  acquire(&ptable.lock);
80103f5a:	83 ec 0c             	sub    $0xc,%esp
80103f5d:	68 20 2d 11 80       	push   $0x80112d20
80103f62:	e8 b9 06 00 00       	call   80104620 <acquire>
80103f67:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103f6a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f6c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103f71:	eb 13                	jmp    80103f86 <wait+0x46>
80103f73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f77:	90                   	nop
80103f78:	81 c3 c4 01 00 00    	add    $0x1c4,%ebx
80103f7e:	81 fb 54 9e 11 80    	cmp    $0x80119e54,%ebx
80103f84:	74 1e                	je     80103fa4 <wait+0x64>
      if(p->parent != curproc)
80103f86:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f89:	75 ed                	jne    80103f78 <wait+0x38>
      if(p->state == ZOMBIE){
80103f8b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f8f:	74 5f                	je     80103ff0 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f91:	81 c3 c4 01 00 00    	add    $0x1c4,%ebx
      havekids = 1;
80103f97:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f9c:	81 fb 54 9e 11 80    	cmp    $0x80119e54,%ebx
80103fa2:	75 e2                	jne    80103f86 <wait+0x46>
    if(!havekids || curproc->killed){
80103fa4:	85 c0                	test   %eax,%eax
80103fa6:	0f 84 9a 00 00 00    	je     80104046 <wait+0x106>
80103fac:	8b 46 24             	mov    0x24(%esi),%eax
80103faf:	85 c0                	test   %eax,%eax
80103fb1:	0f 85 8f 00 00 00    	jne    80104046 <wait+0x106>
  pushcli();
80103fb7:	e8 14 05 00 00       	call   801044d0 <pushcli>
  c = mycpu();
80103fbc:	e8 8f f9 ff ff       	call   80103950 <mycpu>
  p = c->proc;
80103fc1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fc7:	e8 54 05 00 00       	call   80104520 <popcli>
  if(p == 0)
80103fcc:	85 db                	test   %ebx,%ebx
80103fce:	0f 84 89 00 00 00    	je     8010405d <wait+0x11d>
  p->chan = chan;
80103fd4:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80103fd7:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103fde:	e8 6d fd ff ff       	call   80103d50 <sched>
  p->chan = 0;
80103fe3:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103fea:	e9 7b ff ff ff       	jmp    80103f6a <wait+0x2a>
80103fef:	90                   	nop
        kfree(p->kstack);
80103ff0:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80103ff3:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103ff6:	ff 73 08             	push   0x8(%ebx)
80103ff9:	e8 c2 e4 ff ff       	call   801024c0 <kfree>
        p->kstack = 0;
80103ffe:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104005:	5a                   	pop    %edx
80104006:	ff 73 04             	push   0x4(%ebx)
80104009:	e8 a2 2f 00 00       	call   80106fb0 <freevm>
        p->pid = 0;
8010400e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104015:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010401c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104020:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104027:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010402e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104035:	e8 86 05 00 00       	call   801045c0 <release>
        return pid;
8010403a:	83 c4 10             	add    $0x10,%esp
}
8010403d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104040:	89 f0                	mov    %esi,%eax
80104042:	5b                   	pop    %ebx
80104043:	5e                   	pop    %esi
80104044:	5d                   	pop    %ebp
80104045:	c3                   	ret    
      release(&ptable.lock);
80104046:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104049:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010404e:	68 20 2d 11 80       	push   $0x80112d20
80104053:	e8 68 05 00 00       	call   801045c0 <release>
      return -1;
80104058:	83 c4 10             	add    $0x10,%esp
8010405b:	eb e0                	jmp    8010403d <wait+0xfd>
    panic("sleep");
8010405d:	83 ec 0c             	sub    $0xc,%esp
80104060:	68 d4 7f 10 80       	push   $0x80107fd4
80104065:	e8 16 c3 ff ff       	call   80100380 <panic>
8010406a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104070 <yield>:
{
80104070:	55                   	push   %ebp
80104071:	89 e5                	mov    %esp,%ebp
80104073:	53                   	push   %ebx
80104074:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104077:	68 20 2d 11 80       	push   $0x80112d20
8010407c:	e8 9f 05 00 00       	call   80104620 <acquire>
  pushcli();
80104081:	e8 4a 04 00 00       	call   801044d0 <pushcli>
  c = mycpu();
80104086:	e8 c5 f8 ff ff       	call   80103950 <mycpu>
  p = c->proc;
8010408b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104091:	e8 8a 04 00 00       	call   80104520 <popcli>
  myproc()->state = RUNNABLE;
80104096:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010409d:	e8 ae fc ff ff       	call   80103d50 <sched>
  release(&ptable.lock);
801040a2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801040a9:	e8 12 05 00 00       	call   801045c0 <release>
}
801040ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040b1:	83 c4 10             	add    $0x10,%esp
801040b4:	c9                   	leave  
801040b5:	c3                   	ret    
801040b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040bd:	8d 76 00             	lea    0x0(%esi),%esi

801040c0 <sleep>:
{
801040c0:	55                   	push   %ebp
801040c1:	89 e5                	mov    %esp,%ebp
801040c3:	57                   	push   %edi
801040c4:	56                   	push   %esi
801040c5:	53                   	push   %ebx
801040c6:	83 ec 0c             	sub    $0xc,%esp
801040c9:	8b 7d 08             	mov    0x8(%ebp),%edi
801040cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801040cf:	e8 fc 03 00 00       	call   801044d0 <pushcli>
  c = mycpu();
801040d4:	e8 77 f8 ff ff       	call   80103950 <mycpu>
  p = c->proc;
801040d9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040df:	e8 3c 04 00 00       	call   80104520 <popcli>
  if(p == 0)
801040e4:	85 db                	test   %ebx,%ebx
801040e6:	0f 84 87 00 00 00    	je     80104173 <sleep+0xb3>
  if(lk == 0)
801040ec:	85 f6                	test   %esi,%esi
801040ee:	74 76                	je     80104166 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801040f0:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
801040f6:	74 50                	je     80104148 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801040f8:	83 ec 0c             	sub    $0xc,%esp
801040fb:	68 20 2d 11 80       	push   $0x80112d20
80104100:	e8 1b 05 00 00       	call   80104620 <acquire>
    release(lk);
80104105:	89 34 24             	mov    %esi,(%esp)
80104108:	e8 b3 04 00 00       	call   801045c0 <release>
  p->chan = chan;
8010410d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104110:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104117:	e8 34 fc ff ff       	call   80103d50 <sched>
  p->chan = 0;
8010411c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104123:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010412a:	e8 91 04 00 00       	call   801045c0 <release>
    acquire(lk);
8010412f:	89 75 08             	mov    %esi,0x8(%ebp)
80104132:	83 c4 10             	add    $0x10,%esp
}
80104135:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104138:	5b                   	pop    %ebx
80104139:	5e                   	pop    %esi
8010413a:	5f                   	pop    %edi
8010413b:	5d                   	pop    %ebp
    acquire(lk);
8010413c:	e9 df 04 00 00       	jmp    80104620 <acquire>
80104141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104148:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010414b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104152:	e8 f9 fb ff ff       	call   80103d50 <sched>
  p->chan = 0;
80104157:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010415e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104161:	5b                   	pop    %ebx
80104162:	5e                   	pop    %esi
80104163:	5f                   	pop    %edi
80104164:	5d                   	pop    %ebp
80104165:	c3                   	ret    
    panic("sleep without lk");
80104166:	83 ec 0c             	sub    $0xc,%esp
80104169:	68 da 7f 10 80       	push   $0x80107fda
8010416e:	e8 0d c2 ff ff       	call   80100380 <panic>
    panic("sleep");
80104173:	83 ec 0c             	sub    $0xc,%esp
80104176:	68 d4 7f 10 80       	push   $0x80107fd4
8010417b:	e8 00 c2 ff ff       	call   80100380 <panic>

80104180 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	53                   	push   %ebx
80104184:	83 ec 10             	sub    $0x10,%esp
80104187:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010418a:	68 20 2d 11 80       	push   $0x80112d20
8010418f:	e8 8c 04 00 00       	call   80104620 <acquire>
80104194:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104197:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010419c:	eb 0e                	jmp    801041ac <wakeup+0x2c>
8010419e:	66 90                	xchg   %ax,%ax
801041a0:	05 c4 01 00 00       	add    $0x1c4,%eax
801041a5:	3d 54 9e 11 80       	cmp    $0x80119e54,%eax
801041aa:	74 1e                	je     801041ca <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
801041ac:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801041b0:	75 ee                	jne    801041a0 <wakeup+0x20>
801041b2:	3b 58 20             	cmp    0x20(%eax),%ebx
801041b5:	75 e9                	jne    801041a0 <wakeup+0x20>
      p->state = RUNNABLE;
801041b7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041be:	05 c4 01 00 00       	add    $0x1c4,%eax
801041c3:	3d 54 9e 11 80       	cmp    $0x80119e54,%eax
801041c8:	75 e2                	jne    801041ac <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
801041ca:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
801041d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041d4:	c9                   	leave  
  release(&ptable.lock);
801041d5:	e9 e6 03 00 00       	jmp    801045c0 <release>
801041da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801041e0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	53                   	push   %ebx
801041e4:	83 ec 10             	sub    $0x10,%esp
801041e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801041ea:	68 20 2d 11 80       	push   $0x80112d20
801041ef:	e8 2c 04 00 00       	call   80104620 <acquire>
801041f4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041f7:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801041fc:	eb 0e                	jmp    8010420c <kill+0x2c>
801041fe:	66 90                	xchg   %ax,%ax
80104200:	05 c4 01 00 00       	add    $0x1c4,%eax
80104205:	3d 54 9e 11 80       	cmp    $0x80119e54,%eax
8010420a:	74 34                	je     80104240 <kill+0x60>
    if(p->pid == pid){
8010420c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010420f:	75 ef                	jne    80104200 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104211:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104215:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010421c:	75 07                	jne    80104225 <kill+0x45>
        p->state = RUNNABLE;
8010421e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104225:	83 ec 0c             	sub    $0xc,%esp
80104228:	68 20 2d 11 80       	push   $0x80112d20
8010422d:	e8 8e 03 00 00       	call   801045c0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104232:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104235:	83 c4 10             	add    $0x10,%esp
80104238:	31 c0                	xor    %eax,%eax
}
8010423a:	c9                   	leave  
8010423b:	c3                   	ret    
8010423c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104240:	83 ec 0c             	sub    $0xc,%esp
80104243:	68 20 2d 11 80       	push   $0x80112d20
80104248:	e8 73 03 00 00       	call   801045c0 <release>
}
8010424d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104250:	83 c4 10             	add    $0x10,%esp
80104253:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104258:	c9                   	leave  
80104259:	c3                   	ret    
8010425a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104260 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	57                   	push   %edi
80104264:	56                   	push   %esi
80104265:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104268:	53                   	push   %ebx
80104269:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
8010426e:	83 ec 3c             	sub    $0x3c,%esp
80104271:	eb 27                	jmp    8010429a <procdump+0x3a>
80104273:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104277:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104278:	83 ec 0c             	sub    $0xc,%esp
8010427b:	68 ef 83 10 80       	push   $0x801083ef
80104280:	e8 1b c4 ff ff       	call   801006a0 <cprintf>
80104285:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104288:	81 c3 c4 01 00 00    	add    $0x1c4,%ebx
8010428e:	81 fb c0 9e 11 80    	cmp    $0x80119ec0,%ebx
80104294:	0f 84 7e 00 00 00    	je     80104318 <procdump+0xb8>
    if(p->state == UNUSED)
8010429a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010429d:	85 c0                	test   %eax,%eax
8010429f:	74 e7                	je     80104288 <procdump+0x28>
      state = "???";
801042a1:	ba eb 7f 10 80       	mov    $0x80107feb,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801042a6:	83 f8 05             	cmp    $0x5,%eax
801042a9:	77 11                	ja     801042bc <procdump+0x5c>
801042ab:	8b 14 85 4c 80 10 80 	mov    -0x7fef7fb4(,%eax,4),%edx
      state = "???";
801042b2:	b8 eb 7f 10 80       	mov    $0x80107feb,%eax
801042b7:	85 d2                	test   %edx,%edx
801042b9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801042bc:	53                   	push   %ebx
801042bd:	52                   	push   %edx
801042be:	ff 73 a4             	push   -0x5c(%ebx)
801042c1:	68 ef 7f 10 80       	push   $0x80107fef
801042c6:	e8 d5 c3 ff ff       	call   801006a0 <cprintf>
    if(p->state == SLEEPING){
801042cb:	83 c4 10             	add    $0x10,%esp
801042ce:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801042d2:	75 a4                	jne    80104278 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801042d4:	83 ec 08             	sub    $0x8,%esp
801042d7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801042da:	8d 7d c0             	lea    -0x40(%ebp),%edi
801042dd:	50                   	push   %eax
801042de:	8b 43 b0             	mov    -0x50(%ebx),%eax
801042e1:	8b 40 0c             	mov    0xc(%eax),%eax
801042e4:	83 c0 08             	add    $0x8,%eax
801042e7:	50                   	push   %eax
801042e8:	e8 83 01 00 00       	call   80104470 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801042ed:	83 c4 10             	add    $0x10,%esp
801042f0:	8b 17                	mov    (%edi),%edx
801042f2:	85 d2                	test   %edx,%edx
801042f4:	74 82                	je     80104278 <procdump+0x18>
        cprintf(" %p", pc[i]);
801042f6:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801042f9:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
801042fc:	52                   	push   %edx
801042fd:	68 41 7a 10 80       	push   $0x80107a41
80104302:	e8 99 c3 ff ff       	call   801006a0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104307:	83 c4 10             	add    $0x10,%esp
8010430a:	39 fe                	cmp    %edi,%esi
8010430c:	75 e2                	jne    801042f0 <procdump+0x90>
8010430e:	e9 65 ff ff ff       	jmp    80104278 <procdump+0x18>
80104313:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104317:	90                   	nop
  }
}
80104318:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010431b:	5b                   	pop    %ebx
8010431c:	5e                   	pop    %esi
8010431d:	5f                   	pop    %edi
8010431e:	5d                   	pop    %ebp
8010431f:	c3                   	ret    

80104320 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	53                   	push   %ebx
80104324:	83 ec 0c             	sub    $0xc,%esp
80104327:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010432a:	68 64 80 10 80       	push   $0x80108064
8010432f:	8d 43 04             	lea    0x4(%ebx),%eax
80104332:	50                   	push   %eax
80104333:	e8 18 01 00 00       	call   80104450 <initlock>
  lk->name = name;
80104338:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010433b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104341:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104344:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010434b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010434e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104351:	c9                   	leave  
80104352:	c3                   	ret    
80104353:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010435a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104360 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	56                   	push   %esi
80104364:	53                   	push   %ebx
80104365:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104368:	8d 73 04             	lea    0x4(%ebx),%esi
8010436b:	83 ec 0c             	sub    $0xc,%esp
8010436e:	56                   	push   %esi
8010436f:	e8 ac 02 00 00       	call   80104620 <acquire>
  while (lk->locked) {
80104374:	8b 13                	mov    (%ebx),%edx
80104376:	83 c4 10             	add    $0x10,%esp
80104379:	85 d2                	test   %edx,%edx
8010437b:	74 16                	je     80104393 <acquiresleep+0x33>
8010437d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104380:	83 ec 08             	sub    $0x8,%esp
80104383:	56                   	push   %esi
80104384:	53                   	push   %ebx
80104385:	e8 36 fd ff ff       	call   801040c0 <sleep>
  while (lk->locked) {
8010438a:	8b 03                	mov    (%ebx),%eax
8010438c:	83 c4 10             	add    $0x10,%esp
8010438f:	85 c0                	test   %eax,%eax
80104391:	75 ed                	jne    80104380 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104393:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104399:	e8 32 f6 ff ff       	call   801039d0 <myproc>
8010439e:	8b 40 10             	mov    0x10(%eax),%eax
801043a1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801043a4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801043a7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043aa:	5b                   	pop    %ebx
801043ab:	5e                   	pop    %esi
801043ac:	5d                   	pop    %ebp
  release(&lk->lk);
801043ad:	e9 0e 02 00 00       	jmp    801045c0 <release>
801043b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043c0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	56                   	push   %esi
801043c4:	53                   	push   %ebx
801043c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801043c8:	8d 73 04             	lea    0x4(%ebx),%esi
801043cb:	83 ec 0c             	sub    $0xc,%esp
801043ce:	56                   	push   %esi
801043cf:	e8 4c 02 00 00       	call   80104620 <acquire>
  lk->locked = 0;
801043d4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801043da:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801043e1:	89 1c 24             	mov    %ebx,(%esp)
801043e4:	e8 97 fd ff ff       	call   80104180 <wakeup>
  release(&lk->lk);
801043e9:	89 75 08             	mov    %esi,0x8(%ebp)
801043ec:	83 c4 10             	add    $0x10,%esp
}
801043ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043f2:	5b                   	pop    %ebx
801043f3:	5e                   	pop    %esi
801043f4:	5d                   	pop    %ebp
  release(&lk->lk);
801043f5:	e9 c6 01 00 00       	jmp    801045c0 <release>
801043fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104400 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	57                   	push   %edi
80104404:	31 ff                	xor    %edi,%edi
80104406:	56                   	push   %esi
80104407:	53                   	push   %ebx
80104408:	83 ec 18             	sub    $0x18,%esp
8010440b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010440e:	8d 73 04             	lea    0x4(%ebx),%esi
80104411:	56                   	push   %esi
80104412:	e8 09 02 00 00       	call   80104620 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104417:	8b 03                	mov    (%ebx),%eax
80104419:	83 c4 10             	add    $0x10,%esp
8010441c:	85 c0                	test   %eax,%eax
8010441e:	75 18                	jne    80104438 <holdingsleep+0x38>
  release(&lk->lk);
80104420:	83 ec 0c             	sub    $0xc,%esp
80104423:	56                   	push   %esi
80104424:	e8 97 01 00 00       	call   801045c0 <release>
  return r;
}
80104429:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010442c:	89 f8                	mov    %edi,%eax
8010442e:	5b                   	pop    %ebx
8010442f:	5e                   	pop    %esi
80104430:	5f                   	pop    %edi
80104431:	5d                   	pop    %ebp
80104432:	c3                   	ret    
80104433:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104437:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
80104438:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010443b:	e8 90 f5 ff ff       	call   801039d0 <myproc>
80104440:	39 58 10             	cmp    %ebx,0x10(%eax)
80104443:	0f 94 c0             	sete   %al
80104446:	0f b6 c0             	movzbl %al,%eax
80104449:	89 c7                	mov    %eax,%edi
8010444b:	eb d3                	jmp    80104420 <holdingsleep+0x20>
8010444d:	66 90                	xchg   %ax,%ax
8010444f:	90                   	nop

80104450 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104456:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104459:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010445f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104462:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104469:	5d                   	pop    %ebp
8010446a:	c3                   	ret    
8010446b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010446f:	90                   	nop

80104470 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104470:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104471:	31 d2                	xor    %edx,%edx
{
80104473:	89 e5                	mov    %esp,%ebp
80104475:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104476:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104479:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010447c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
8010447f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104480:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104486:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010448c:	77 1a                	ja     801044a8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010448e:	8b 58 04             	mov    0x4(%eax),%ebx
80104491:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104494:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104497:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104499:	83 fa 0a             	cmp    $0xa,%edx
8010449c:	75 e2                	jne    80104480 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010449e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044a1:	c9                   	leave  
801044a2:	c3                   	ret    
801044a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044a7:	90                   	nop
  for(; i < 10; i++)
801044a8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801044ab:	8d 51 28             	lea    0x28(%ecx),%edx
801044ae:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801044b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801044b6:	83 c0 04             	add    $0x4,%eax
801044b9:	39 d0                	cmp    %edx,%eax
801044bb:	75 f3                	jne    801044b0 <getcallerpcs+0x40>
}
801044bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044c0:	c9                   	leave  
801044c1:	c3                   	ret    
801044c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801044d0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	53                   	push   %ebx
801044d4:	83 ec 04             	sub    $0x4,%esp
801044d7:	9c                   	pushf  
801044d8:	5b                   	pop    %ebx
  asm volatile("cli");
801044d9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801044da:	e8 71 f4 ff ff       	call   80103950 <mycpu>
801044df:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801044e5:	85 c0                	test   %eax,%eax
801044e7:	74 17                	je     80104500 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
801044e9:	e8 62 f4 ff ff       	call   80103950 <mycpu>
801044ee:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801044f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044f8:	c9                   	leave  
801044f9:	c3                   	ret    
801044fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104500:	e8 4b f4 ff ff       	call   80103950 <mycpu>
80104505:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010450b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104511:	eb d6                	jmp    801044e9 <pushcli+0x19>
80104513:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010451a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104520 <popcli>:

void
popcli(void)
{
80104520:	55                   	push   %ebp
80104521:	89 e5                	mov    %esp,%ebp
80104523:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104526:	9c                   	pushf  
80104527:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104528:	f6 c4 02             	test   $0x2,%ah
8010452b:	75 35                	jne    80104562 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010452d:	e8 1e f4 ff ff       	call   80103950 <mycpu>
80104532:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104539:	78 34                	js     8010456f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010453b:	e8 10 f4 ff ff       	call   80103950 <mycpu>
80104540:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104546:	85 d2                	test   %edx,%edx
80104548:	74 06                	je     80104550 <popcli+0x30>
    sti();
}
8010454a:	c9                   	leave  
8010454b:	c3                   	ret    
8010454c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104550:	e8 fb f3 ff ff       	call   80103950 <mycpu>
80104555:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010455b:	85 c0                	test   %eax,%eax
8010455d:	74 eb                	je     8010454a <popcli+0x2a>
  asm volatile("sti");
8010455f:	fb                   	sti    
}
80104560:	c9                   	leave  
80104561:	c3                   	ret    
    panic("popcli - interruptible");
80104562:	83 ec 0c             	sub    $0xc,%esp
80104565:	68 6f 80 10 80       	push   $0x8010806f
8010456a:	e8 11 be ff ff       	call   80100380 <panic>
    panic("popcli");
8010456f:	83 ec 0c             	sub    $0xc,%esp
80104572:	68 86 80 10 80       	push   $0x80108086
80104577:	e8 04 be ff ff       	call   80100380 <panic>
8010457c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104580 <holding>:
{
80104580:	55                   	push   %ebp
80104581:	89 e5                	mov    %esp,%ebp
80104583:	56                   	push   %esi
80104584:	53                   	push   %ebx
80104585:	8b 75 08             	mov    0x8(%ebp),%esi
80104588:	31 db                	xor    %ebx,%ebx
  pushcli();
8010458a:	e8 41 ff ff ff       	call   801044d0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010458f:	8b 06                	mov    (%esi),%eax
80104591:	85 c0                	test   %eax,%eax
80104593:	75 0b                	jne    801045a0 <holding+0x20>
  popcli();
80104595:	e8 86 ff ff ff       	call   80104520 <popcli>
}
8010459a:	89 d8                	mov    %ebx,%eax
8010459c:	5b                   	pop    %ebx
8010459d:	5e                   	pop    %esi
8010459e:	5d                   	pop    %ebp
8010459f:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
801045a0:	8b 5e 08             	mov    0x8(%esi),%ebx
801045a3:	e8 a8 f3 ff ff       	call   80103950 <mycpu>
801045a8:	39 c3                	cmp    %eax,%ebx
801045aa:	0f 94 c3             	sete   %bl
  popcli();
801045ad:	e8 6e ff ff ff       	call   80104520 <popcli>
  r = lock->locked && lock->cpu == mycpu();
801045b2:	0f b6 db             	movzbl %bl,%ebx
}
801045b5:	89 d8                	mov    %ebx,%eax
801045b7:	5b                   	pop    %ebx
801045b8:	5e                   	pop    %esi
801045b9:	5d                   	pop    %ebp
801045ba:	c3                   	ret    
801045bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045bf:	90                   	nop

801045c0 <release>:
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	56                   	push   %esi
801045c4:	53                   	push   %ebx
801045c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801045c8:	e8 03 ff ff ff       	call   801044d0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801045cd:	8b 03                	mov    (%ebx),%eax
801045cf:	85 c0                	test   %eax,%eax
801045d1:	75 15                	jne    801045e8 <release+0x28>
  popcli();
801045d3:	e8 48 ff ff ff       	call   80104520 <popcli>
    panic("release");
801045d8:	83 ec 0c             	sub    $0xc,%esp
801045db:	68 8d 80 10 80       	push   $0x8010808d
801045e0:	e8 9b bd ff ff       	call   80100380 <panic>
801045e5:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801045e8:	8b 73 08             	mov    0x8(%ebx),%esi
801045eb:	e8 60 f3 ff ff       	call   80103950 <mycpu>
801045f0:	39 c6                	cmp    %eax,%esi
801045f2:	75 df                	jne    801045d3 <release+0x13>
  popcli();
801045f4:	e8 27 ff ff ff       	call   80104520 <popcli>
  lk->pcs[0] = 0;
801045f9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104600:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104607:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010460c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104612:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104615:	5b                   	pop    %ebx
80104616:	5e                   	pop    %esi
80104617:	5d                   	pop    %ebp
  popcli();
80104618:	e9 03 ff ff ff       	jmp    80104520 <popcli>
8010461d:	8d 76 00             	lea    0x0(%esi),%esi

80104620 <acquire>:
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	53                   	push   %ebx
80104624:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104627:	e8 a4 fe ff ff       	call   801044d0 <pushcli>
  if(holding(lk))
8010462c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010462f:	e8 9c fe ff ff       	call   801044d0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104634:	8b 03                	mov    (%ebx),%eax
80104636:	85 c0                	test   %eax,%eax
80104638:	75 7e                	jne    801046b8 <acquire+0x98>
  popcli();
8010463a:	e8 e1 fe ff ff       	call   80104520 <popcli>
  asm volatile("lock; xchgl %0, %1" :
8010463f:	b9 01 00 00 00       	mov    $0x1,%ecx
80104644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80104648:	8b 55 08             	mov    0x8(%ebp),%edx
8010464b:	89 c8                	mov    %ecx,%eax
8010464d:	f0 87 02             	lock xchg %eax,(%edx)
80104650:	85 c0                	test   %eax,%eax
80104652:	75 f4                	jne    80104648 <acquire+0x28>
  __sync_synchronize();
80104654:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104659:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010465c:	e8 ef f2 ff ff       	call   80103950 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104661:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80104664:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80104666:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80104669:	31 c0                	xor    %eax,%eax
8010466b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010466f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104670:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104676:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010467c:	77 1a                	ja     80104698 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
8010467e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104681:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104685:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104688:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010468a:	83 f8 0a             	cmp    $0xa,%eax
8010468d:	75 e1                	jne    80104670 <acquire+0x50>
}
8010468f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104692:	c9                   	leave  
80104693:	c3                   	ret    
80104694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104698:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
8010469c:	8d 51 34             	lea    0x34(%ecx),%edx
8010469f:	90                   	nop
    pcs[i] = 0;
801046a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801046a6:	83 c0 04             	add    $0x4,%eax
801046a9:	39 c2                	cmp    %eax,%edx
801046ab:	75 f3                	jne    801046a0 <acquire+0x80>
}
801046ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046b0:	c9                   	leave  
801046b1:	c3                   	ret    
801046b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801046b8:	8b 5b 08             	mov    0x8(%ebx),%ebx
801046bb:	e8 90 f2 ff ff       	call   80103950 <mycpu>
801046c0:	39 c3                	cmp    %eax,%ebx
801046c2:	0f 85 72 ff ff ff    	jne    8010463a <acquire+0x1a>
  popcli();
801046c8:	e8 53 fe ff ff       	call   80104520 <popcli>
    panic("acquire");
801046cd:	83 ec 0c             	sub    $0xc,%esp
801046d0:	68 95 80 10 80       	push   $0x80108095
801046d5:	e8 a6 bc ff ff       	call   80100380 <panic>
801046da:	66 90                	xchg   %ax,%ax
801046dc:	66 90                	xchg   %ax,%ax
801046de:	66 90                	xchg   %ax,%ax

801046e0 <memset>:
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	57                   	push   %edi
801046e4:	8b 55 08             	mov    0x8(%ebp),%edx
801046e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801046ea:	53                   	push   %ebx
801046eb:	8b 45 0c             	mov    0xc(%ebp),%eax
801046ee:	89 d7                	mov    %edx,%edi
801046f0:	09 cf                	or     %ecx,%edi
801046f2:	83 e7 03             	and    $0x3,%edi
801046f5:	75 29                	jne    80104720 <memset+0x40>
801046f7:	0f b6 f8             	movzbl %al,%edi
801046fa:	c1 e0 18             	shl    $0x18,%eax
801046fd:	89 fb                	mov    %edi,%ebx
801046ff:	c1 e9 02             	shr    $0x2,%ecx
80104702:	c1 e3 10             	shl    $0x10,%ebx
80104705:	09 d8                	or     %ebx,%eax
80104707:	09 f8                	or     %edi,%eax
80104709:	c1 e7 08             	shl    $0x8,%edi
8010470c:	09 f8                	or     %edi,%eax
8010470e:	89 d7                	mov    %edx,%edi
80104710:	fc                   	cld    
80104711:	f3 ab                	rep stos %eax,%es:(%edi)
80104713:	5b                   	pop    %ebx
80104714:	89 d0                	mov    %edx,%eax
80104716:	5f                   	pop    %edi
80104717:	5d                   	pop    %ebp
80104718:	c3                   	ret    
80104719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104720:	89 d7                	mov    %edx,%edi
80104722:	fc                   	cld    
80104723:	f3 aa                	rep stos %al,%es:(%edi)
80104725:	5b                   	pop    %ebx
80104726:	89 d0                	mov    %edx,%eax
80104728:	5f                   	pop    %edi
80104729:	5d                   	pop    %ebp
8010472a:	c3                   	ret    
8010472b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010472f:	90                   	nop

80104730 <memcmp>:
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	56                   	push   %esi
80104734:	8b 75 10             	mov    0x10(%ebp),%esi
80104737:	8b 55 08             	mov    0x8(%ebp),%edx
8010473a:	53                   	push   %ebx
8010473b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010473e:	85 f6                	test   %esi,%esi
80104740:	74 2e                	je     80104770 <memcmp+0x40>
80104742:	01 c6                	add    %eax,%esi
80104744:	eb 14                	jmp    8010475a <memcmp+0x2a>
80104746:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010474d:	8d 76 00             	lea    0x0(%esi),%esi
80104750:	83 c0 01             	add    $0x1,%eax
80104753:	83 c2 01             	add    $0x1,%edx
80104756:	39 f0                	cmp    %esi,%eax
80104758:	74 16                	je     80104770 <memcmp+0x40>
8010475a:	0f b6 0a             	movzbl (%edx),%ecx
8010475d:	0f b6 18             	movzbl (%eax),%ebx
80104760:	38 d9                	cmp    %bl,%cl
80104762:	74 ec                	je     80104750 <memcmp+0x20>
80104764:	0f b6 c1             	movzbl %cl,%eax
80104767:	29 d8                	sub    %ebx,%eax
80104769:	5b                   	pop    %ebx
8010476a:	5e                   	pop    %esi
8010476b:	5d                   	pop    %ebp
8010476c:	c3                   	ret    
8010476d:	8d 76 00             	lea    0x0(%esi),%esi
80104770:	5b                   	pop    %ebx
80104771:	31 c0                	xor    %eax,%eax
80104773:	5e                   	pop    %esi
80104774:	5d                   	pop    %ebp
80104775:	c3                   	ret    
80104776:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010477d:	8d 76 00             	lea    0x0(%esi),%esi

80104780 <memmove>:
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	57                   	push   %edi
80104784:	8b 55 08             	mov    0x8(%ebp),%edx
80104787:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010478a:	56                   	push   %esi
8010478b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010478e:	39 d6                	cmp    %edx,%esi
80104790:	73 26                	jae    801047b8 <memmove+0x38>
80104792:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104795:	39 fa                	cmp    %edi,%edx
80104797:	73 1f                	jae    801047b8 <memmove+0x38>
80104799:	8d 41 ff             	lea    -0x1(%ecx),%eax
8010479c:	85 c9                	test   %ecx,%ecx
8010479e:	74 0c                	je     801047ac <memmove+0x2c>
801047a0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801047a4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
801047a7:	83 e8 01             	sub    $0x1,%eax
801047aa:	73 f4                	jae    801047a0 <memmove+0x20>
801047ac:	5e                   	pop    %esi
801047ad:	89 d0                	mov    %edx,%eax
801047af:	5f                   	pop    %edi
801047b0:	5d                   	pop    %ebp
801047b1:	c3                   	ret    
801047b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047b8:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
801047bb:	89 d7                	mov    %edx,%edi
801047bd:	85 c9                	test   %ecx,%ecx
801047bf:	74 eb                	je     801047ac <memmove+0x2c>
801047c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047c8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
801047c9:	39 c6                	cmp    %eax,%esi
801047cb:	75 fb                	jne    801047c8 <memmove+0x48>
801047cd:	5e                   	pop    %esi
801047ce:	89 d0                	mov    %edx,%eax
801047d0:	5f                   	pop    %edi
801047d1:	5d                   	pop    %ebp
801047d2:	c3                   	ret    
801047d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047e0 <memcpy>:
801047e0:	eb 9e                	jmp    80104780 <memmove>
801047e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047f0 <strncmp>:
801047f0:	55                   	push   %ebp
801047f1:	89 e5                	mov    %esp,%ebp
801047f3:	56                   	push   %esi
801047f4:	8b 75 10             	mov    0x10(%ebp),%esi
801047f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
801047fa:	53                   	push   %ebx
801047fb:	8b 55 0c             	mov    0xc(%ebp),%edx
801047fe:	85 f6                	test   %esi,%esi
80104800:	74 2e                	je     80104830 <strncmp+0x40>
80104802:	01 d6                	add    %edx,%esi
80104804:	eb 18                	jmp    8010481e <strncmp+0x2e>
80104806:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010480d:	8d 76 00             	lea    0x0(%esi),%esi
80104810:	38 d8                	cmp    %bl,%al
80104812:	75 14                	jne    80104828 <strncmp+0x38>
80104814:	83 c2 01             	add    $0x1,%edx
80104817:	83 c1 01             	add    $0x1,%ecx
8010481a:	39 f2                	cmp    %esi,%edx
8010481c:	74 12                	je     80104830 <strncmp+0x40>
8010481e:	0f b6 01             	movzbl (%ecx),%eax
80104821:	0f b6 1a             	movzbl (%edx),%ebx
80104824:	84 c0                	test   %al,%al
80104826:	75 e8                	jne    80104810 <strncmp+0x20>
80104828:	29 d8                	sub    %ebx,%eax
8010482a:	5b                   	pop    %ebx
8010482b:	5e                   	pop    %esi
8010482c:	5d                   	pop    %ebp
8010482d:	c3                   	ret    
8010482e:	66 90                	xchg   %ax,%ax
80104830:	5b                   	pop    %ebx
80104831:	31 c0                	xor    %eax,%eax
80104833:	5e                   	pop    %esi
80104834:	5d                   	pop    %ebp
80104835:	c3                   	ret    
80104836:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010483d:	8d 76 00             	lea    0x0(%esi),%esi

80104840 <strncpy>:
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	57                   	push   %edi
80104844:	56                   	push   %esi
80104845:	8b 75 08             	mov    0x8(%ebp),%esi
80104848:	53                   	push   %ebx
80104849:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010484c:	89 f0                	mov    %esi,%eax
8010484e:	eb 15                	jmp    80104865 <strncpy+0x25>
80104850:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104854:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104857:	83 c0 01             	add    $0x1,%eax
8010485a:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
8010485e:	88 50 ff             	mov    %dl,-0x1(%eax)
80104861:	84 d2                	test   %dl,%dl
80104863:	74 09                	je     8010486e <strncpy+0x2e>
80104865:	89 cb                	mov    %ecx,%ebx
80104867:	83 e9 01             	sub    $0x1,%ecx
8010486a:	85 db                	test   %ebx,%ebx
8010486c:	7f e2                	jg     80104850 <strncpy+0x10>
8010486e:	89 c2                	mov    %eax,%edx
80104870:	85 c9                	test   %ecx,%ecx
80104872:	7e 17                	jle    8010488b <strncpy+0x4b>
80104874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104878:	83 c2 01             	add    $0x1,%edx
8010487b:	89 c1                	mov    %eax,%ecx
8010487d:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
80104881:	29 d1                	sub    %edx,%ecx
80104883:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80104887:	85 c9                	test   %ecx,%ecx
80104889:	7f ed                	jg     80104878 <strncpy+0x38>
8010488b:	5b                   	pop    %ebx
8010488c:	89 f0                	mov    %esi,%eax
8010488e:	5e                   	pop    %esi
8010488f:	5f                   	pop    %edi
80104890:	5d                   	pop    %ebp
80104891:	c3                   	ret    
80104892:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801048a0 <safestrcpy>:
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	56                   	push   %esi
801048a4:	8b 55 10             	mov    0x10(%ebp),%edx
801048a7:	8b 75 08             	mov    0x8(%ebp),%esi
801048aa:	53                   	push   %ebx
801048ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801048ae:	85 d2                	test   %edx,%edx
801048b0:	7e 25                	jle    801048d7 <safestrcpy+0x37>
801048b2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
801048b6:	89 f2                	mov    %esi,%edx
801048b8:	eb 16                	jmp    801048d0 <safestrcpy+0x30>
801048ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048c0:	0f b6 08             	movzbl (%eax),%ecx
801048c3:	83 c0 01             	add    $0x1,%eax
801048c6:	83 c2 01             	add    $0x1,%edx
801048c9:	88 4a ff             	mov    %cl,-0x1(%edx)
801048cc:	84 c9                	test   %cl,%cl
801048ce:	74 04                	je     801048d4 <safestrcpy+0x34>
801048d0:	39 d8                	cmp    %ebx,%eax
801048d2:	75 ec                	jne    801048c0 <safestrcpy+0x20>
801048d4:	c6 02 00             	movb   $0x0,(%edx)
801048d7:	89 f0                	mov    %esi,%eax
801048d9:	5b                   	pop    %ebx
801048da:	5e                   	pop    %esi
801048db:	5d                   	pop    %ebp
801048dc:	c3                   	ret    
801048dd:	8d 76 00             	lea    0x0(%esi),%esi

801048e0 <strlen>:
801048e0:	55                   	push   %ebp
801048e1:	31 c0                	xor    %eax,%eax
801048e3:	89 e5                	mov    %esp,%ebp
801048e5:	8b 55 08             	mov    0x8(%ebp),%edx
801048e8:	80 3a 00             	cmpb   $0x0,(%edx)
801048eb:	74 0c                	je     801048f9 <strlen+0x19>
801048ed:	8d 76 00             	lea    0x0(%esi),%esi
801048f0:	83 c0 01             	add    $0x1,%eax
801048f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801048f7:	75 f7                	jne    801048f0 <strlen+0x10>
801048f9:	5d                   	pop    %ebp
801048fa:	c3                   	ret    

801048fb <swtch>:
801048fb:	8b 44 24 04          	mov    0x4(%esp),%eax
801048ff:	8b 54 24 08          	mov    0x8(%esp),%edx
80104903:	55                   	push   %ebp
80104904:	53                   	push   %ebx
80104905:	56                   	push   %esi
80104906:	57                   	push   %edi
80104907:	89 20                	mov    %esp,(%eax)
80104909:	89 d4                	mov    %edx,%esp
8010490b:	5f                   	pop    %edi
8010490c:	5e                   	pop    %esi
8010490d:	5b                   	pop    %ebx
8010490e:	5d                   	pop    %ebp
8010490f:	c3                   	ret    

80104910 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	53                   	push   %ebx
80104914:	83 ec 04             	sub    $0x4,%esp
80104917:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010491a:	e8 b1 f0 ff ff       	call   801039d0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010491f:	8b 00                	mov    (%eax),%eax
80104921:	39 d8                	cmp    %ebx,%eax
80104923:	76 1b                	jbe    80104940 <fetchint+0x30>
80104925:	8d 53 04             	lea    0x4(%ebx),%edx
80104928:	39 d0                	cmp    %edx,%eax
8010492a:	72 14                	jb     80104940 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010492c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010492f:	8b 13                	mov    (%ebx),%edx
80104931:	89 10                	mov    %edx,(%eax)
  return 0;
80104933:	31 c0                	xor    %eax,%eax
}
80104935:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104938:	c9                   	leave  
80104939:	c3                   	ret    
8010493a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104940:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104945:	eb ee                	jmp    80104935 <fetchint+0x25>
80104947:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010494e:	66 90                	xchg   %ax,%ax

80104950 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	53                   	push   %ebx
80104954:	83 ec 04             	sub    $0x4,%esp
80104957:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010495a:	e8 71 f0 ff ff       	call   801039d0 <myproc>

  if(addr >= curproc->sz)
8010495f:	39 18                	cmp    %ebx,(%eax)
80104961:	76 2d                	jbe    80104990 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104963:	8b 55 0c             	mov    0xc(%ebp),%edx
80104966:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104968:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010496a:	39 d3                	cmp    %edx,%ebx
8010496c:	73 22                	jae    80104990 <fetchstr+0x40>
8010496e:	89 d8                	mov    %ebx,%eax
80104970:	eb 0d                	jmp    8010497f <fetchstr+0x2f>
80104972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104978:	83 c0 01             	add    $0x1,%eax
8010497b:	39 c2                	cmp    %eax,%edx
8010497d:	76 11                	jbe    80104990 <fetchstr+0x40>
    if(*s == 0)
8010497f:	80 38 00             	cmpb   $0x0,(%eax)
80104982:	75 f4                	jne    80104978 <fetchstr+0x28>
      return s - *pp;
80104984:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104986:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104989:	c9                   	leave  
8010498a:	c3                   	ret    
8010498b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010498f:	90                   	nop
80104990:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104993:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104998:	c9                   	leave  
80104999:	c3                   	ret    
8010499a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049a0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801049a0:	55                   	push   %ebp
801049a1:	89 e5                	mov    %esp,%ebp
801049a3:	56                   	push   %esi
801049a4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049a5:	e8 26 f0 ff ff       	call   801039d0 <myproc>
801049aa:	8b 55 08             	mov    0x8(%ebp),%edx
801049ad:	8b 40 18             	mov    0x18(%eax),%eax
801049b0:	8b 40 44             	mov    0x44(%eax),%eax
801049b3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801049b6:	e8 15 f0 ff ff       	call   801039d0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049bb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049be:	8b 00                	mov    (%eax),%eax
801049c0:	39 c6                	cmp    %eax,%esi
801049c2:	73 1c                	jae    801049e0 <argint+0x40>
801049c4:	8d 53 08             	lea    0x8(%ebx),%edx
801049c7:	39 d0                	cmp    %edx,%eax
801049c9:	72 15                	jb     801049e0 <argint+0x40>
  *ip = *(int*)(addr);
801049cb:	8b 45 0c             	mov    0xc(%ebp),%eax
801049ce:	8b 53 04             	mov    0x4(%ebx),%edx
801049d1:	89 10                	mov    %edx,(%eax)
  return 0;
801049d3:	31 c0                	xor    %eax,%eax
}
801049d5:	5b                   	pop    %ebx
801049d6:	5e                   	pop    %esi
801049d7:	5d                   	pop    %ebp
801049d8:	c3                   	ret    
801049d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801049e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049e5:	eb ee                	jmp    801049d5 <argint+0x35>
801049e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049ee:	66 90                	xchg   %ax,%ax

801049f0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	57                   	push   %edi
801049f4:	56                   	push   %esi
801049f5:	53                   	push   %ebx
801049f6:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
801049f9:	e8 d2 ef ff ff       	call   801039d0 <myproc>
801049fe:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a00:	e8 cb ef ff ff       	call   801039d0 <myproc>
80104a05:	8b 55 08             	mov    0x8(%ebp),%edx
80104a08:	8b 40 18             	mov    0x18(%eax),%eax
80104a0b:	8b 40 44             	mov    0x44(%eax),%eax
80104a0e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104a11:	e8 ba ef ff ff       	call   801039d0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a16:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a19:	8b 00                	mov    (%eax),%eax
80104a1b:	39 c7                	cmp    %eax,%edi
80104a1d:	73 31                	jae    80104a50 <argptr+0x60>
80104a1f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104a22:	39 c8                	cmp    %ecx,%eax
80104a24:	72 2a                	jb     80104a50 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104a26:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104a29:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104a2c:	85 d2                	test   %edx,%edx
80104a2e:	78 20                	js     80104a50 <argptr+0x60>
80104a30:	8b 16                	mov    (%esi),%edx
80104a32:	39 c2                	cmp    %eax,%edx
80104a34:	76 1a                	jbe    80104a50 <argptr+0x60>
80104a36:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104a39:	01 c3                	add    %eax,%ebx
80104a3b:	39 da                	cmp    %ebx,%edx
80104a3d:	72 11                	jb     80104a50 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104a3f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a42:	89 02                	mov    %eax,(%edx)
  return 0;
80104a44:	31 c0                	xor    %eax,%eax
}
80104a46:	83 c4 0c             	add    $0xc,%esp
80104a49:	5b                   	pop    %ebx
80104a4a:	5e                   	pop    %esi
80104a4b:	5f                   	pop    %edi
80104a4c:	5d                   	pop    %ebp
80104a4d:	c3                   	ret    
80104a4e:	66 90                	xchg   %ax,%ax
    return -1;
80104a50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a55:	eb ef                	jmp    80104a46 <argptr+0x56>
80104a57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a5e:	66 90                	xchg   %ax,%ax

80104a60 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	56                   	push   %esi
80104a64:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a65:	e8 66 ef ff ff       	call   801039d0 <myproc>
80104a6a:	8b 55 08             	mov    0x8(%ebp),%edx
80104a6d:	8b 40 18             	mov    0x18(%eax),%eax
80104a70:	8b 40 44             	mov    0x44(%eax),%eax
80104a73:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104a76:	e8 55 ef ff ff       	call   801039d0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a7b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a7e:	8b 00                	mov    (%eax),%eax
80104a80:	39 c6                	cmp    %eax,%esi
80104a82:	73 44                	jae    80104ac8 <argstr+0x68>
80104a84:	8d 53 08             	lea    0x8(%ebx),%edx
80104a87:	39 d0                	cmp    %edx,%eax
80104a89:	72 3d                	jb     80104ac8 <argstr+0x68>
  *ip = *(int*)(addr);
80104a8b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104a8e:	e8 3d ef ff ff       	call   801039d0 <myproc>
  if(addr >= curproc->sz)
80104a93:	3b 18                	cmp    (%eax),%ebx
80104a95:	73 31                	jae    80104ac8 <argstr+0x68>
  *pp = (char*)addr;
80104a97:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a9a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104a9c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104a9e:	39 d3                	cmp    %edx,%ebx
80104aa0:	73 26                	jae    80104ac8 <argstr+0x68>
80104aa2:	89 d8                	mov    %ebx,%eax
80104aa4:	eb 11                	jmp    80104ab7 <argstr+0x57>
80104aa6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104aad:	8d 76 00             	lea    0x0(%esi),%esi
80104ab0:	83 c0 01             	add    $0x1,%eax
80104ab3:	39 c2                	cmp    %eax,%edx
80104ab5:	76 11                	jbe    80104ac8 <argstr+0x68>
    if(*s == 0)
80104ab7:	80 38 00             	cmpb   $0x0,(%eax)
80104aba:	75 f4                	jne    80104ab0 <argstr+0x50>
      return s - *pp;
80104abc:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104abe:	5b                   	pop    %ebx
80104abf:	5e                   	pop    %esi
80104ac0:	5d                   	pop    %ebp
80104ac1:	c3                   	ret    
80104ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ac8:	5b                   	pop    %ebx
    return -1;
80104ac9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ace:	5e                   	pop    %esi
80104acf:	5d                   	pop    %ebp
80104ad0:	c3                   	ret    
80104ad1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ad8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104adf:	90                   	nop

80104ae0 <syscall>:
[SYS_getwmapinfo]  sys_getwmapinfo
};

void
syscall(void)
{
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	53                   	push   %ebx
80104ae4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104ae7:	e8 e4 ee ff ff       	call   801039d0 <myproc>
80104aec:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104aee:	8b 40 18             	mov    0x18(%eax),%eax
80104af1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104af4:	8d 50 ff             	lea    -0x1(%eax),%edx
80104af7:	83 fa 19             	cmp    $0x19,%edx
80104afa:	77 24                	ja     80104b20 <syscall+0x40>
80104afc:	8b 14 85 c0 80 10 80 	mov    -0x7fef7f40(,%eax,4),%edx
80104b03:	85 d2                	test   %edx,%edx
80104b05:	74 19                	je     80104b20 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104b07:	ff d2                	call   *%edx
80104b09:	89 c2                	mov    %eax,%edx
80104b0b:	8b 43 18             	mov    0x18(%ebx),%eax
80104b0e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104b11:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b14:	c9                   	leave  
80104b15:	c3                   	ret    
80104b16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b1d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104b20:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104b21:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104b24:	50                   	push   %eax
80104b25:	ff 73 10             	push   0x10(%ebx)
80104b28:	68 9d 80 10 80       	push   $0x8010809d
80104b2d:	e8 6e bb ff ff       	call   801006a0 <cprintf>
    curproc->tf->eax = -1;
80104b32:	8b 43 18             	mov    0x18(%ebx),%eax
80104b35:	83 c4 10             	add    $0x10,%esp
80104b38:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104b3f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b42:	c9                   	leave  
80104b43:	c3                   	ret    
80104b44:	66 90                	xchg   %ax,%ax
80104b46:	66 90                	xchg   %ax,%ax
80104b48:	66 90                	xchg   %ax,%ax
80104b4a:	66 90                	xchg   %ax,%ax
80104b4c:	66 90                	xchg   %ax,%ax
80104b4e:	66 90                	xchg   %ax,%ax

80104b50 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	57                   	push   %edi
80104b54:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b55:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104b58:	53                   	push   %ebx
80104b59:	83 ec 34             	sub    $0x34,%esp
80104b5c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104b5f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104b62:	57                   	push   %edi
80104b63:	50                   	push   %eax
{
80104b64:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104b67:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104b6a:	e8 51 d5 ff ff       	call   801020c0 <nameiparent>
80104b6f:	83 c4 10             	add    $0x10,%esp
80104b72:	85 c0                	test   %eax,%eax
80104b74:	0f 84 46 01 00 00    	je     80104cc0 <create+0x170>
    return 0;
  ilock(dp);
80104b7a:	83 ec 0c             	sub    $0xc,%esp
80104b7d:	89 c3                	mov    %eax,%ebx
80104b7f:	50                   	push   %eax
80104b80:	e8 fb cb ff ff       	call   80101780 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104b85:	83 c4 0c             	add    $0xc,%esp
80104b88:	6a 00                	push   $0x0
80104b8a:	57                   	push   %edi
80104b8b:	53                   	push   %ebx
80104b8c:	e8 4f d1 ff ff       	call   80101ce0 <dirlookup>
80104b91:	83 c4 10             	add    $0x10,%esp
80104b94:	89 c6                	mov    %eax,%esi
80104b96:	85 c0                	test   %eax,%eax
80104b98:	74 56                	je     80104bf0 <create+0xa0>
    iunlockput(dp);
80104b9a:	83 ec 0c             	sub    $0xc,%esp
80104b9d:	53                   	push   %ebx
80104b9e:	e8 6d ce ff ff       	call   80101a10 <iunlockput>
    ilock(ip);
80104ba3:	89 34 24             	mov    %esi,(%esp)
80104ba6:	e8 d5 cb ff ff       	call   80101780 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104bab:	83 c4 10             	add    $0x10,%esp
80104bae:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104bb3:	75 1b                	jne    80104bd0 <create+0x80>
80104bb5:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104bba:	75 14                	jne    80104bd0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104bbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bbf:	89 f0                	mov    %esi,%eax
80104bc1:	5b                   	pop    %ebx
80104bc2:	5e                   	pop    %esi
80104bc3:	5f                   	pop    %edi
80104bc4:	5d                   	pop    %ebp
80104bc5:	c3                   	ret    
80104bc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bcd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80104bd0:	83 ec 0c             	sub    $0xc,%esp
80104bd3:	56                   	push   %esi
    return 0;
80104bd4:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80104bd6:	e8 35 ce ff ff       	call   80101a10 <iunlockput>
    return 0;
80104bdb:	83 c4 10             	add    $0x10,%esp
}
80104bde:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104be1:	89 f0                	mov    %esi,%eax
80104be3:	5b                   	pop    %ebx
80104be4:	5e                   	pop    %esi
80104be5:	5f                   	pop    %edi
80104be6:	5d                   	pop    %ebp
80104be7:	c3                   	ret    
80104be8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bef:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80104bf0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104bf4:	83 ec 08             	sub    $0x8,%esp
80104bf7:	50                   	push   %eax
80104bf8:	ff 33                	push   (%ebx)
80104bfa:	e8 11 ca ff ff       	call   80101610 <ialloc>
80104bff:	83 c4 10             	add    $0x10,%esp
80104c02:	89 c6                	mov    %eax,%esi
80104c04:	85 c0                	test   %eax,%eax
80104c06:	0f 84 cd 00 00 00    	je     80104cd9 <create+0x189>
  ilock(ip);
80104c0c:	83 ec 0c             	sub    $0xc,%esp
80104c0f:	50                   	push   %eax
80104c10:	e8 6b cb ff ff       	call   80101780 <ilock>
  ip->major = major;
80104c15:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104c19:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104c1d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104c21:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104c25:	b8 01 00 00 00       	mov    $0x1,%eax
80104c2a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104c2e:	89 34 24             	mov    %esi,(%esp)
80104c31:	e8 9a ca ff ff       	call   801016d0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104c36:	83 c4 10             	add    $0x10,%esp
80104c39:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104c3e:	74 30                	je     80104c70 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104c40:	83 ec 04             	sub    $0x4,%esp
80104c43:	ff 76 04             	push   0x4(%esi)
80104c46:	57                   	push   %edi
80104c47:	53                   	push   %ebx
80104c48:	e8 93 d3 ff ff       	call   80101fe0 <dirlink>
80104c4d:	83 c4 10             	add    $0x10,%esp
80104c50:	85 c0                	test   %eax,%eax
80104c52:	78 78                	js     80104ccc <create+0x17c>
  iunlockput(dp);
80104c54:	83 ec 0c             	sub    $0xc,%esp
80104c57:	53                   	push   %ebx
80104c58:	e8 b3 cd ff ff       	call   80101a10 <iunlockput>
  return ip;
80104c5d:	83 c4 10             	add    $0x10,%esp
}
80104c60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c63:	89 f0                	mov    %esi,%eax
80104c65:	5b                   	pop    %ebx
80104c66:	5e                   	pop    %esi
80104c67:	5f                   	pop    %edi
80104c68:	5d                   	pop    %ebp
80104c69:	c3                   	ret    
80104c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104c70:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104c73:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104c78:	53                   	push   %ebx
80104c79:	e8 52 ca ff ff       	call   801016d0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104c7e:	83 c4 0c             	add    $0xc,%esp
80104c81:	ff 76 04             	push   0x4(%esi)
80104c84:	68 48 81 10 80       	push   $0x80108148
80104c89:	56                   	push   %esi
80104c8a:	e8 51 d3 ff ff       	call   80101fe0 <dirlink>
80104c8f:	83 c4 10             	add    $0x10,%esp
80104c92:	85 c0                	test   %eax,%eax
80104c94:	78 18                	js     80104cae <create+0x15e>
80104c96:	83 ec 04             	sub    $0x4,%esp
80104c99:	ff 73 04             	push   0x4(%ebx)
80104c9c:	68 47 81 10 80       	push   $0x80108147
80104ca1:	56                   	push   %esi
80104ca2:	e8 39 d3 ff ff       	call   80101fe0 <dirlink>
80104ca7:	83 c4 10             	add    $0x10,%esp
80104caa:	85 c0                	test   %eax,%eax
80104cac:	79 92                	jns    80104c40 <create+0xf0>
      panic("create dots");
80104cae:	83 ec 0c             	sub    $0xc,%esp
80104cb1:	68 3b 81 10 80       	push   $0x8010813b
80104cb6:	e8 c5 b6 ff ff       	call   80100380 <panic>
80104cbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104cbf:	90                   	nop
}
80104cc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104cc3:	31 f6                	xor    %esi,%esi
}
80104cc5:	5b                   	pop    %ebx
80104cc6:	89 f0                	mov    %esi,%eax
80104cc8:	5e                   	pop    %esi
80104cc9:	5f                   	pop    %edi
80104cca:	5d                   	pop    %ebp
80104ccb:	c3                   	ret    
    panic("create: dirlink");
80104ccc:	83 ec 0c             	sub    $0xc,%esp
80104ccf:	68 4a 81 10 80       	push   $0x8010814a
80104cd4:	e8 a7 b6 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104cd9:	83 ec 0c             	sub    $0xc,%esp
80104cdc:	68 2c 81 10 80       	push   $0x8010812c
80104ce1:	e8 9a b6 ff ff       	call   80100380 <panic>
80104ce6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ced:	8d 76 00             	lea    0x0(%esi),%esi

80104cf0 <sys_dup>:
{
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	56                   	push   %esi
80104cf4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104cf5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104cf8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104cfb:	50                   	push   %eax
80104cfc:	6a 00                	push   $0x0
80104cfe:	e8 9d fc ff ff       	call   801049a0 <argint>
80104d03:	83 c4 10             	add    $0x10,%esp
80104d06:	85 c0                	test   %eax,%eax
80104d08:	78 36                	js     80104d40 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104d0a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104d0e:	77 30                	ja     80104d40 <sys_dup+0x50>
80104d10:	e8 bb ec ff ff       	call   801039d0 <myproc>
80104d15:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d18:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104d1c:	85 f6                	test   %esi,%esi
80104d1e:	74 20                	je     80104d40 <sys_dup+0x50>
  struct proc *curproc = myproc();
80104d20:	e8 ab ec ff ff       	call   801039d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104d25:	31 db                	xor    %ebx,%ebx
80104d27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d2e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80104d30:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104d34:	85 d2                	test   %edx,%edx
80104d36:	74 18                	je     80104d50 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80104d38:	83 c3 01             	add    $0x1,%ebx
80104d3b:	83 fb 10             	cmp    $0x10,%ebx
80104d3e:	75 f0                	jne    80104d30 <sys_dup+0x40>
}
80104d40:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104d43:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104d48:	89 d8                	mov    %ebx,%eax
80104d4a:	5b                   	pop    %ebx
80104d4b:	5e                   	pop    %esi
80104d4c:	5d                   	pop    %ebp
80104d4d:	c3                   	ret    
80104d4e:	66 90                	xchg   %ax,%ax
  filedup(f);
80104d50:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80104d53:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104d57:	56                   	push   %esi
80104d58:	e8 43 c1 ff ff       	call   80100ea0 <filedup>
  return fd;
80104d5d:	83 c4 10             	add    $0x10,%esp
}
80104d60:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d63:	89 d8                	mov    %ebx,%eax
80104d65:	5b                   	pop    %ebx
80104d66:	5e                   	pop    %esi
80104d67:	5d                   	pop    %ebp
80104d68:	c3                   	ret    
80104d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104d70 <sys_read>:
{
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	56                   	push   %esi
80104d74:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104d75:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104d78:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104d7b:	53                   	push   %ebx
80104d7c:	6a 00                	push   $0x0
80104d7e:	e8 1d fc ff ff       	call   801049a0 <argint>
80104d83:	83 c4 10             	add    $0x10,%esp
80104d86:	85 c0                	test   %eax,%eax
80104d88:	78 5e                	js     80104de8 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104d8a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104d8e:	77 58                	ja     80104de8 <sys_read+0x78>
80104d90:	e8 3b ec ff ff       	call   801039d0 <myproc>
80104d95:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d98:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104d9c:	85 f6                	test   %esi,%esi
80104d9e:	74 48                	je     80104de8 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104da0:	83 ec 08             	sub    $0x8,%esp
80104da3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104da6:	50                   	push   %eax
80104da7:	6a 02                	push   $0x2
80104da9:	e8 f2 fb ff ff       	call   801049a0 <argint>
80104dae:	83 c4 10             	add    $0x10,%esp
80104db1:	85 c0                	test   %eax,%eax
80104db3:	78 33                	js     80104de8 <sys_read+0x78>
80104db5:	83 ec 04             	sub    $0x4,%esp
80104db8:	ff 75 f0             	push   -0x10(%ebp)
80104dbb:	53                   	push   %ebx
80104dbc:	6a 01                	push   $0x1
80104dbe:	e8 2d fc ff ff       	call   801049f0 <argptr>
80104dc3:	83 c4 10             	add    $0x10,%esp
80104dc6:	85 c0                	test   %eax,%eax
80104dc8:	78 1e                	js     80104de8 <sys_read+0x78>
  return fileread(f, p, n);
80104dca:	83 ec 04             	sub    $0x4,%esp
80104dcd:	ff 75 f0             	push   -0x10(%ebp)
80104dd0:	ff 75 f4             	push   -0xc(%ebp)
80104dd3:	56                   	push   %esi
80104dd4:	e8 47 c2 ff ff       	call   80101020 <fileread>
80104dd9:	83 c4 10             	add    $0x10,%esp
}
80104ddc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ddf:	5b                   	pop    %ebx
80104de0:	5e                   	pop    %esi
80104de1:	5d                   	pop    %ebp
80104de2:	c3                   	ret    
80104de3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104de7:	90                   	nop
    return -1;
80104de8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ded:	eb ed                	jmp    80104ddc <sys_read+0x6c>
80104def:	90                   	nop

80104df0 <sys_write>:
{
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	56                   	push   %esi
80104df4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104df5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104df8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104dfb:	53                   	push   %ebx
80104dfc:	6a 00                	push   $0x0
80104dfe:	e8 9d fb ff ff       	call   801049a0 <argint>
80104e03:	83 c4 10             	add    $0x10,%esp
80104e06:	85 c0                	test   %eax,%eax
80104e08:	78 5e                	js     80104e68 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104e0a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e0e:	77 58                	ja     80104e68 <sys_write+0x78>
80104e10:	e8 bb eb ff ff       	call   801039d0 <myproc>
80104e15:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e18:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104e1c:	85 f6                	test   %esi,%esi
80104e1e:	74 48                	je     80104e68 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e20:	83 ec 08             	sub    $0x8,%esp
80104e23:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e26:	50                   	push   %eax
80104e27:	6a 02                	push   $0x2
80104e29:	e8 72 fb ff ff       	call   801049a0 <argint>
80104e2e:	83 c4 10             	add    $0x10,%esp
80104e31:	85 c0                	test   %eax,%eax
80104e33:	78 33                	js     80104e68 <sys_write+0x78>
80104e35:	83 ec 04             	sub    $0x4,%esp
80104e38:	ff 75 f0             	push   -0x10(%ebp)
80104e3b:	53                   	push   %ebx
80104e3c:	6a 01                	push   $0x1
80104e3e:	e8 ad fb ff ff       	call   801049f0 <argptr>
80104e43:	83 c4 10             	add    $0x10,%esp
80104e46:	85 c0                	test   %eax,%eax
80104e48:	78 1e                	js     80104e68 <sys_write+0x78>
  return filewrite(f, p, n);
80104e4a:	83 ec 04             	sub    $0x4,%esp
80104e4d:	ff 75 f0             	push   -0x10(%ebp)
80104e50:	ff 75 f4             	push   -0xc(%ebp)
80104e53:	56                   	push   %esi
80104e54:	e8 57 c2 ff ff       	call   801010b0 <filewrite>
80104e59:	83 c4 10             	add    $0x10,%esp
}
80104e5c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e5f:	5b                   	pop    %ebx
80104e60:	5e                   	pop    %esi
80104e61:	5d                   	pop    %ebp
80104e62:	c3                   	ret    
80104e63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e67:	90                   	nop
    return -1;
80104e68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e6d:	eb ed                	jmp    80104e5c <sys_write+0x6c>
80104e6f:	90                   	nop

80104e70 <sys_close>:
{
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
80104e73:	56                   	push   %esi
80104e74:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104e75:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104e78:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104e7b:	50                   	push   %eax
80104e7c:	6a 00                	push   $0x0
80104e7e:	e8 1d fb ff ff       	call   801049a0 <argint>
80104e83:	83 c4 10             	add    $0x10,%esp
80104e86:	85 c0                	test   %eax,%eax
80104e88:	78 3e                	js     80104ec8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104e8a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e8e:	77 38                	ja     80104ec8 <sys_close+0x58>
80104e90:	e8 3b eb ff ff       	call   801039d0 <myproc>
80104e95:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e98:	8d 5a 08             	lea    0x8(%edx),%ebx
80104e9b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80104e9f:	85 f6                	test   %esi,%esi
80104ea1:	74 25                	je     80104ec8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80104ea3:	e8 28 eb ff ff       	call   801039d0 <myproc>
  fileclose(f);
80104ea8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104eab:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80104eb2:	00 
  fileclose(f);
80104eb3:	56                   	push   %esi
80104eb4:	e8 37 c0 ff ff       	call   80100ef0 <fileclose>
  return 0;
80104eb9:	83 c4 10             	add    $0x10,%esp
80104ebc:	31 c0                	xor    %eax,%eax
}
80104ebe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ec1:	5b                   	pop    %ebx
80104ec2:	5e                   	pop    %esi
80104ec3:	5d                   	pop    %ebp
80104ec4:	c3                   	ret    
80104ec5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104ec8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ecd:	eb ef                	jmp    80104ebe <sys_close+0x4e>
80104ecf:	90                   	nop

80104ed0 <sys_fstat>:
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	56                   	push   %esi
80104ed4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104ed5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104ed8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104edb:	53                   	push   %ebx
80104edc:	6a 00                	push   $0x0
80104ede:	e8 bd fa ff ff       	call   801049a0 <argint>
80104ee3:	83 c4 10             	add    $0x10,%esp
80104ee6:	85 c0                	test   %eax,%eax
80104ee8:	78 46                	js     80104f30 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104eea:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104eee:	77 40                	ja     80104f30 <sys_fstat+0x60>
80104ef0:	e8 db ea ff ff       	call   801039d0 <myproc>
80104ef5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104ef8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104efc:	85 f6                	test   %esi,%esi
80104efe:	74 30                	je     80104f30 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104f00:	83 ec 04             	sub    $0x4,%esp
80104f03:	6a 14                	push   $0x14
80104f05:	53                   	push   %ebx
80104f06:	6a 01                	push   $0x1
80104f08:	e8 e3 fa ff ff       	call   801049f0 <argptr>
80104f0d:	83 c4 10             	add    $0x10,%esp
80104f10:	85 c0                	test   %eax,%eax
80104f12:	78 1c                	js     80104f30 <sys_fstat+0x60>
  return filestat(f, st);
80104f14:	83 ec 08             	sub    $0x8,%esp
80104f17:	ff 75 f4             	push   -0xc(%ebp)
80104f1a:	56                   	push   %esi
80104f1b:	e8 b0 c0 ff ff       	call   80100fd0 <filestat>
80104f20:	83 c4 10             	add    $0x10,%esp
}
80104f23:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f26:	5b                   	pop    %ebx
80104f27:	5e                   	pop    %esi
80104f28:	5d                   	pop    %ebp
80104f29:	c3                   	ret    
80104f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f35:	eb ec                	jmp    80104f23 <sys_fstat+0x53>
80104f37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f3e:	66 90                	xchg   %ax,%ax

80104f40 <sys_link>:
{
80104f40:	55                   	push   %ebp
80104f41:	89 e5                	mov    %esp,%ebp
80104f43:	57                   	push   %edi
80104f44:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f45:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104f48:	53                   	push   %ebx
80104f49:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f4c:	50                   	push   %eax
80104f4d:	6a 00                	push   $0x0
80104f4f:	e8 0c fb ff ff       	call   80104a60 <argstr>
80104f54:	83 c4 10             	add    $0x10,%esp
80104f57:	85 c0                	test   %eax,%eax
80104f59:	0f 88 fb 00 00 00    	js     8010505a <sys_link+0x11a>
80104f5f:	83 ec 08             	sub    $0x8,%esp
80104f62:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104f65:	50                   	push   %eax
80104f66:	6a 01                	push   $0x1
80104f68:	e8 f3 fa ff ff       	call   80104a60 <argstr>
80104f6d:	83 c4 10             	add    $0x10,%esp
80104f70:	85 c0                	test   %eax,%eax
80104f72:	0f 88 e2 00 00 00    	js     8010505a <sys_link+0x11a>
  begin_op();
80104f78:	e8 e3 dd ff ff       	call   80102d60 <begin_op>
  if((ip = namei(old)) == 0){
80104f7d:	83 ec 0c             	sub    $0xc,%esp
80104f80:	ff 75 d4             	push   -0x2c(%ebp)
80104f83:	e8 18 d1 ff ff       	call   801020a0 <namei>
80104f88:	83 c4 10             	add    $0x10,%esp
80104f8b:	89 c3                	mov    %eax,%ebx
80104f8d:	85 c0                	test   %eax,%eax
80104f8f:	0f 84 e4 00 00 00    	je     80105079 <sys_link+0x139>
  ilock(ip);
80104f95:	83 ec 0c             	sub    $0xc,%esp
80104f98:	50                   	push   %eax
80104f99:	e8 e2 c7 ff ff       	call   80101780 <ilock>
  if(ip->type == T_DIR){
80104f9e:	83 c4 10             	add    $0x10,%esp
80104fa1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104fa6:	0f 84 b5 00 00 00    	je     80105061 <sys_link+0x121>
  iupdate(ip);
80104fac:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80104faf:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80104fb4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104fb7:	53                   	push   %ebx
80104fb8:	e8 13 c7 ff ff       	call   801016d0 <iupdate>
  iunlock(ip);
80104fbd:	89 1c 24             	mov    %ebx,(%esp)
80104fc0:	e8 9b c8 ff ff       	call   80101860 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104fc5:	58                   	pop    %eax
80104fc6:	5a                   	pop    %edx
80104fc7:	57                   	push   %edi
80104fc8:	ff 75 d0             	push   -0x30(%ebp)
80104fcb:	e8 f0 d0 ff ff       	call   801020c0 <nameiparent>
80104fd0:	83 c4 10             	add    $0x10,%esp
80104fd3:	89 c6                	mov    %eax,%esi
80104fd5:	85 c0                	test   %eax,%eax
80104fd7:	74 5b                	je     80105034 <sys_link+0xf4>
  ilock(dp);
80104fd9:	83 ec 0c             	sub    $0xc,%esp
80104fdc:	50                   	push   %eax
80104fdd:	e8 9e c7 ff ff       	call   80101780 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104fe2:	8b 03                	mov    (%ebx),%eax
80104fe4:	83 c4 10             	add    $0x10,%esp
80104fe7:	39 06                	cmp    %eax,(%esi)
80104fe9:	75 3d                	jne    80105028 <sys_link+0xe8>
80104feb:	83 ec 04             	sub    $0x4,%esp
80104fee:	ff 73 04             	push   0x4(%ebx)
80104ff1:	57                   	push   %edi
80104ff2:	56                   	push   %esi
80104ff3:	e8 e8 cf ff ff       	call   80101fe0 <dirlink>
80104ff8:	83 c4 10             	add    $0x10,%esp
80104ffb:	85 c0                	test   %eax,%eax
80104ffd:	78 29                	js     80105028 <sys_link+0xe8>
  iunlockput(dp);
80104fff:	83 ec 0c             	sub    $0xc,%esp
80105002:	56                   	push   %esi
80105003:	e8 08 ca ff ff       	call   80101a10 <iunlockput>
  iput(ip);
80105008:	89 1c 24             	mov    %ebx,(%esp)
8010500b:	e8 a0 c8 ff ff       	call   801018b0 <iput>
  end_op();
80105010:	e8 bb dd ff ff       	call   80102dd0 <end_op>
  return 0;
80105015:	83 c4 10             	add    $0x10,%esp
80105018:	31 c0                	xor    %eax,%eax
}
8010501a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010501d:	5b                   	pop    %ebx
8010501e:	5e                   	pop    %esi
8010501f:	5f                   	pop    %edi
80105020:	5d                   	pop    %ebp
80105021:	c3                   	ret    
80105022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105028:	83 ec 0c             	sub    $0xc,%esp
8010502b:	56                   	push   %esi
8010502c:	e8 df c9 ff ff       	call   80101a10 <iunlockput>
    goto bad;
80105031:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105034:	83 ec 0c             	sub    $0xc,%esp
80105037:	53                   	push   %ebx
80105038:	e8 43 c7 ff ff       	call   80101780 <ilock>
  ip->nlink--;
8010503d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105042:	89 1c 24             	mov    %ebx,(%esp)
80105045:	e8 86 c6 ff ff       	call   801016d0 <iupdate>
  iunlockput(ip);
8010504a:	89 1c 24             	mov    %ebx,(%esp)
8010504d:	e8 be c9 ff ff       	call   80101a10 <iunlockput>
  end_op();
80105052:	e8 79 dd ff ff       	call   80102dd0 <end_op>
  return -1;
80105057:	83 c4 10             	add    $0x10,%esp
8010505a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010505f:	eb b9                	jmp    8010501a <sys_link+0xda>
    iunlockput(ip);
80105061:	83 ec 0c             	sub    $0xc,%esp
80105064:	53                   	push   %ebx
80105065:	e8 a6 c9 ff ff       	call   80101a10 <iunlockput>
    end_op();
8010506a:	e8 61 dd ff ff       	call   80102dd0 <end_op>
    return -1;
8010506f:	83 c4 10             	add    $0x10,%esp
80105072:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105077:	eb a1                	jmp    8010501a <sys_link+0xda>
    end_op();
80105079:	e8 52 dd ff ff       	call   80102dd0 <end_op>
    return -1;
8010507e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105083:	eb 95                	jmp    8010501a <sys_link+0xda>
80105085:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010508c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105090 <sys_unlink>:
{
80105090:	55                   	push   %ebp
80105091:	89 e5                	mov    %esp,%ebp
80105093:	57                   	push   %edi
80105094:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105095:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105098:	53                   	push   %ebx
80105099:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010509c:	50                   	push   %eax
8010509d:	6a 00                	push   $0x0
8010509f:	e8 bc f9 ff ff       	call   80104a60 <argstr>
801050a4:	83 c4 10             	add    $0x10,%esp
801050a7:	85 c0                	test   %eax,%eax
801050a9:	0f 88 7a 01 00 00    	js     80105229 <sys_unlink+0x199>
  begin_op();
801050af:	e8 ac dc ff ff       	call   80102d60 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801050b4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801050b7:	83 ec 08             	sub    $0x8,%esp
801050ba:	53                   	push   %ebx
801050bb:	ff 75 c0             	push   -0x40(%ebp)
801050be:	e8 fd cf ff ff       	call   801020c0 <nameiparent>
801050c3:	83 c4 10             	add    $0x10,%esp
801050c6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801050c9:	85 c0                	test   %eax,%eax
801050cb:	0f 84 62 01 00 00    	je     80105233 <sys_unlink+0x1a3>
  ilock(dp);
801050d1:	8b 7d b4             	mov    -0x4c(%ebp),%edi
801050d4:	83 ec 0c             	sub    $0xc,%esp
801050d7:	57                   	push   %edi
801050d8:	e8 a3 c6 ff ff       	call   80101780 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801050dd:	58                   	pop    %eax
801050de:	5a                   	pop    %edx
801050df:	68 48 81 10 80       	push   $0x80108148
801050e4:	53                   	push   %ebx
801050e5:	e8 d6 cb ff ff       	call   80101cc0 <namecmp>
801050ea:	83 c4 10             	add    $0x10,%esp
801050ed:	85 c0                	test   %eax,%eax
801050ef:	0f 84 fb 00 00 00    	je     801051f0 <sys_unlink+0x160>
801050f5:	83 ec 08             	sub    $0x8,%esp
801050f8:	68 47 81 10 80       	push   $0x80108147
801050fd:	53                   	push   %ebx
801050fe:	e8 bd cb ff ff       	call   80101cc0 <namecmp>
80105103:	83 c4 10             	add    $0x10,%esp
80105106:	85 c0                	test   %eax,%eax
80105108:	0f 84 e2 00 00 00    	je     801051f0 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010510e:	83 ec 04             	sub    $0x4,%esp
80105111:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105114:	50                   	push   %eax
80105115:	53                   	push   %ebx
80105116:	57                   	push   %edi
80105117:	e8 c4 cb ff ff       	call   80101ce0 <dirlookup>
8010511c:	83 c4 10             	add    $0x10,%esp
8010511f:	89 c3                	mov    %eax,%ebx
80105121:	85 c0                	test   %eax,%eax
80105123:	0f 84 c7 00 00 00    	je     801051f0 <sys_unlink+0x160>
  ilock(ip);
80105129:	83 ec 0c             	sub    $0xc,%esp
8010512c:	50                   	push   %eax
8010512d:	e8 4e c6 ff ff       	call   80101780 <ilock>
  if(ip->nlink < 1)
80105132:	83 c4 10             	add    $0x10,%esp
80105135:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010513a:	0f 8e 1c 01 00 00    	jle    8010525c <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105140:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105145:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105148:	74 66                	je     801051b0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010514a:	83 ec 04             	sub    $0x4,%esp
8010514d:	6a 10                	push   $0x10
8010514f:	6a 00                	push   $0x0
80105151:	57                   	push   %edi
80105152:	e8 89 f5 ff ff       	call   801046e0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105157:	6a 10                	push   $0x10
80105159:	ff 75 c4             	push   -0x3c(%ebp)
8010515c:	57                   	push   %edi
8010515d:	ff 75 b4             	push   -0x4c(%ebp)
80105160:	e8 2b ca ff ff       	call   80101b90 <writei>
80105165:	83 c4 20             	add    $0x20,%esp
80105168:	83 f8 10             	cmp    $0x10,%eax
8010516b:	0f 85 de 00 00 00    	jne    8010524f <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
80105171:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105176:	0f 84 94 00 00 00    	je     80105210 <sys_unlink+0x180>
  iunlockput(dp);
8010517c:	83 ec 0c             	sub    $0xc,%esp
8010517f:	ff 75 b4             	push   -0x4c(%ebp)
80105182:	e8 89 c8 ff ff       	call   80101a10 <iunlockput>
  ip->nlink--;
80105187:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010518c:	89 1c 24             	mov    %ebx,(%esp)
8010518f:	e8 3c c5 ff ff       	call   801016d0 <iupdate>
  iunlockput(ip);
80105194:	89 1c 24             	mov    %ebx,(%esp)
80105197:	e8 74 c8 ff ff       	call   80101a10 <iunlockput>
  end_op();
8010519c:	e8 2f dc ff ff       	call   80102dd0 <end_op>
  return 0;
801051a1:	83 c4 10             	add    $0x10,%esp
801051a4:	31 c0                	xor    %eax,%eax
}
801051a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051a9:	5b                   	pop    %ebx
801051aa:	5e                   	pop    %esi
801051ab:	5f                   	pop    %edi
801051ac:	5d                   	pop    %ebp
801051ad:	c3                   	ret    
801051ae:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801051b0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801051b4:	76 94                	jbe    8010514a <sys_unlink+0xba>
801051b6:	be 20 00 00 00       	mov    $0x20,%esi
801051bb:	eb 0b                	jmp    801051c8 <sys_unlink+0x138>
801051bd:	8d 76 00             	lea    0x0(%esi),%esi
801051c0:	83 c6 10             	add    $0x10,%esi
801051c3:	3b 73 58             	cmp    0x58(%ebx),%esi
801051c6:	73 82                	jae    8010514a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801051c8:	6a 10                	push   $0x10
801051ca:	56                   	push   %esi
801051cb:	57                   	push   %edi
801051cc:	53                   	push   %ebx
801051cd:	e8 be c8 ff ff       	call   80101a90 <readi>
801051d2:	83 c4 10             	add    $0x10,%esp
801051d5:	83 f8 10             	cmp    $0x10,%eax
801051d8:	75 68                	jne    80105242 <sys_unlink+0x1b2>
    if(de.inum != 0)
801051da:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801051df:	74 df                	je     801051c0 <sys_unlink+0x130>
    iunlockput(ip);
801051e1:	83 ec 0c             	sub    $0xc,%esp
801051e4:	53                   	push   %ebx
801051e5:	e8 26 c8 ff ff       	call   80101a10 <iunlockput>
    goto bad;
801051ea:	83 c4 10             	add    $0x10,%esp
801051ed:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
801051f0:	83 ec 0c             	sub    $0xc,%esp
801051f3:	ff 75 b4             	push   -0x4c(%ebp)
801051f6:	e8 15 c8 ff ff       	call   80101a10 <iunlockput>
  end_op();
801051fb:	e8 d0 db ff ff       	call   80102dd0 <end_op>
  return -1;
80105200:	83 c4 10             	add    $0x10,%esp
80105203:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105208:	eb 9c                	jmp    801051a6 <sys_unlink+0x116>
8010520a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105210:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105213:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105216:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010521b:	50                   	push   %eax
8010521c:	e8 af c4 ff ff       	call   801016d0 <iupdate>
80105221:	83 c4 10             	add    $0x10,%esp
80105224:	e9 53 ff ff ff       	jmp    8010517c <sys_unlink+0xec>
    return -1;
80105229:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010522e:	e9 73 ff ff ff       	jmp    801051a6 <sys_unlink+0x116>
    end_op();
80105233:	e8 98 db ff ff       	call   80102dd0 <end_op>
    return -1;
80105238:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010523d:	e9 64 ff ff ff       	jmp    801051a6 <sys_unlink+0x116>
      panic("isdirempty: readi");
80105242:	83 ec 0c             	sub    $0xc,%esp
80105245:	68 6c 81 10 80       	push   $0x8010816c
8010524a:	e8 31 b1 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
8010524f:	83 ec 0c             	sub    $0xc,%esp
80105252:	68 7e 81 10 80       	push   $0x8010817e
80105257:	e8 24 b1 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
8010525c:	83 ec 0c             	sub    $0xc,%esp
8010525f:	68 5a 81 10 80       	push   $0x8010815a
80105264:	e8 17 b1 ff ff       	call   80100380 <panic>
80105269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105270 <sys_open>:

int
sys_open(void)
{
80105270:	55                   	push   %ebp
80105271:	89 e5                	mov    %esp,%ebp
80105273:	57                   	push   %edi
80105274:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105275:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105278:	53                   	push   %ebx
80105279:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010527c:	50                   	push   %eax
8010527d:	6a 00                	push   $0x0
8010527f:	e8 dc f7 ff ff       	call   80104a60 <argstr>
80105284:	83 c4 10             	add    $0x10,%esp
80105287:	85 c0                	test   %eax,%eax
80105289:	0f 88 8e 00 00 00    	js     8010531d <sys_open+0xad>
8010528f:	83 ec 08             	sub    $0x8,%esp
80105292:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105295:	50                   	push   %eax
80105296:	6a 01                	push   $0x1
80105298:	e8 03 f7 ff ff       	call   801049a0 <argint>
8010529d:	83 c4 10             	add    $0x10,%esp
801052a0:	85 c0                	test   %eax,%eax
801052a2:	78 79                	js     8010531d <sys_open+0xad>
    return -1;

  begin_op();
801052a4:	e8 b7 da ff ff       	call   80102d60 <begin_op>

  if(omode & O_CREATE){
801052a9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801052ad:	75 79                	jne    80105328 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801052af:	83 ec 0c             	sub    $0xc,%esp
801052b2:	ff 75 e0             	push   -0x20(%ebp)
801052b5:	e8 e6 cd ff ff       	call   801020a0 <namei>
801052ba:	83 c4 10             	add    $0x10,%esp
801052bd:	89 c6                	mov    %eax,%esi
801052bf:	85 c0                	test   %eax,%eax
801052c1:	0f 84 7e 00 00 00    	je     80105345 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
801052c7:	83 ec 0c             	sub    $0xc,%esp
801052ca:	50                   	push   %eax
801052cb:	e8 b0 c4 ff ff       	call   80101780 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801052d0:	83 c4 10             	add    $0x10,%esp
801052d3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801052d8:	0f 84 c2 00 00 00    	je     801053a0 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801052de:	e8 4d bb ff ff       	call   80100e30 <filealloc>
801052e3:	89 c7                	mov    %eax,%edi
801052e5:	85 c0                	test   %eax,%eax
801052e7:	74 23                	je     8010530c <sys_open+0x9c>
  struct proc *curproc = myproc();
801052e9:	e8 e2 e6 ff ff       	call   801039d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801052ee:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
801052f0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801052f4:	85 d2                	test   %edx,%edx
801052f6:	74 60                	je     80105358 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
801052f8:	83 c3 01             	add    $0x1,%ebx
801052fb:	83 fb 10             	cmp    $0x10,%ebx
801052fe:	75 f0                	jne    801052f0 <sys_open+0x80>
    if(f)
      fileclose(f);
80105300:	83 ec 0c             	sub    $0xc,%esp
80105303:	57                   	push   %edi
80105304:	e8 e7 bb ff ff       	call   80100ef0 <fileclose>
80105309:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010530c:	83 ec 0c             	sub    $0xc,%esp
8010530f:	56                   	push   %esi
80105310:	e8 fb c6 ff ff       	call   80101a10 <iunlockput>
    end_op();
80105315:	e8 b6 da ff ff       	call   80102dd0 <end_op>
    return -1;
8010531a:	83 c4 10             	add    $0x10,%esp
8010531d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105322:	eb 6d                	jmp    80105391 <sys_open+0x121>
80105324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105328:	83 ec 0c             	sub    $0xc,%esp
8010532b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010532e:	31 c9                	xor    %ecx,%ecx
80105330:	ba 02 00 00 00       	mov    $0x2,%edx
80105335:	6a 00                	push   $0x0
80105337:	e8 14 f8 ff ff       	call   80104b50 <create>
    if(ip == 0){
8010533c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010533f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105341:	85 c0                	test   %eax,%eax
80105343:	75 99                	jne    801052de <sys_open+0x6e>
      end_op();
80105345:	e8 86 da ff ff       	call   80102dd0 <end_op>
      return -1;
8010534a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010534f:	eb 40                	jmp    80105391 <sys_open+0x121>
80105351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105358:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010535b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010535f:	56                   	push   %esi
80105360:	e8 fb c4 ff ff       	call   80101860 <iunlock>
  end_op();
80105365:	e8 66 da ff ff       	call   80102dd0 <end_op>

  f->type = FD_INODE;
8010536a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105370:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105373:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105376:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105379:	89 d0                	mov    %edx,%eax
  f->off = 0;
8010537b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105382:	f7 d0                	not    %eax
80105384:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105387:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010538a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010538d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105391:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105394:	89 d8                	mov    %ebx,%eax
80105396:	5b                   	pop    %ebx
80105397:	5e                   	pop    %esi
80105398:	5f                   	pop    %edi
80105399:	5d                   	pop    %ebp
8010539a:	c3                   	ret    
8010539b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010539f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
801053a0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801053a3:	85 c9                	test   %ecx,%ecx
801053a5:	0f 84 33 ff ff ff    	je     801052de <sys_open+0x6e>
801053ab:	e9 5c ff ff ff       	jmp    8010530c <sys_open+0x9c>

801053b0 <sys_mkdir>:

int
sys_mkdir(void)
{
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801053b6:	e8 a5 d9 ff ff       	call   80102d60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801053bb:	83 ec 08             	sub    $0x8,%esp
801053be:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053c1:	50                   	push   %eax
801053c2:	6a 00                	push   $0x0
801053c4:	e8 97 f6 ff ff       	call   80104a60 <argstr>
801053c9:	83 c4 10             	add    $0x10,%esp
801053cc:	85 c0                	test   %eax,%eax
801053ce:	78 30                	js     80105400 <sys_mkdir+0x50>
801053d0:	83 ec 0c             	sub    $0xc,%esp
801053d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053d6:	31 c9                	xor    %ecx,%ecx
801053d8:	ba 01 00 00 00       	mov    $0x1,%edx
801053dd:	6a 00                	push   $0x0
801053df:	e8 6c f7 ff ff       	call   80104b50 <create>
801053e4:	83 c4 10             	add    $0x10,%esp
801053e7:	85 c0                	test   %eax,%eax
801053e9:	74 15                	je     80105400 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053eb:	83 ec 0c             	sub    $0xc,%esp
801053ee:	50                   	push   %eax
801053ef:	e8 1c c6 ff ff       	call   80101a10 <iunlockput>
  end_op();
801053f4:	e8 d7 d9 ff ff       	call   80102dd0 <end_op>
  return 0;
801053f9:	83 c4 10             	add    $0x10,%esp
801053fc:	31 c0                	xor    %eax,%eax
}
801053fe:	c9                   	leave  
801053ff:	c3                   	ret    
    end_op();
80105400:	e8 cb d9 ff ff       	call   80102dd0 <end_op>
    return -1;
80105405:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010540a:	c9                   	leave  
8010540b:	c3                   	ret    
8010540c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105410 <sys_mknod>:

int
sys_mknod(void)
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105416:	e8 45 d9 ff ff       	call   80102d60 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010541b:	83 ec 08             	sub    $0x8,%esp
8010541e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105421:	50                   	push   %eax
80105422:	6a 00                	push   $0x0
80105424:	e8 37 f6 ff ff       	call   80104a60 <argstr>
80105429:	83 c4 10             	add    $0x10,%esp
8010542c:	85 c0                	test   %eax,%eax
8010542e:	78 60                	js     80105490 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105430:	83 ec 08             	sub    $0x8,%esp
80105433:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105436:	50                   	push   %eax
80105437:	6a 01                	push   $0x1
80105439:	e8 62 f5 ff ff       	call   801049a0 <argint>
  if((argstr(0, &path)) < 0 ||
8010543e:	83 c4 10             	add    $0x10,%esp
80105441:	85 c0                	test   %eax,%eax
80105443:	78 4b                	js     80105490 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105445:	83 ec 08             	sub    $0x8,%esp
80105448:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010544b:	50                   	push   %eax
8010544c:	6a 02                	push   $0x2
8010544e:	e8 4d f5 ff ff       	call   801049a0 <argint>
     argint(1, &major) < 0 ||
80105453:	83 c4 10             	add    $0x10,%esp
80105456:	85 c0                	test   %eax,%eax
80105458:	78 36                	js     80105490 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010545a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010545e:	83 ec 0c             	sub    $0xc,%esp
80105461:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105465:	ba 03 00 00 00       	mov    $0x3,%edx
8010546a:	50                   	push   %eax
8010546b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010546e:	e8 dd f6 ff ff       	call   80104b50 <create>
     argint(2, &minor) < 0 ||
80105473:	83 c4 10             	add    $0x10,%esp
80105476:	85 c0                	test   %eax,%eax
80105478:	74 16                	je     80105490 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010547a:	83 ec 0c             	sub    $0xc,%esp
8010547d:	50                   	push   %eax
8010547e:	e8 8d c5 ff ff       	call   80101a10 <iunlockput>
  end_op();
80105483:	e8 48 d9 ff ff       	call   80102dd0 <end_op>
  return 0;
80105488:	83 c4 10             	add    $0x10,%esp
8010548b:	31 c0                	xor    %eax,%eax
}
8010548d:	c9                   	leave  
8010548e:	c3                   	ret    
8010548f:	90                   	nop
    end_op();
80105490:	e8 3b d9 ff ff       	call   80102dd0 <end_op>
    return -1;
80105495:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010549a:	c9                   	leave  
8010549b:	c3                   	ret    
8010549c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054a0 <sys_chdir>:

int
sys_chdir(void)
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	56                   	push   %esi
801054a4:	53                   	push   %ebx
801054a5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801054a8:	e8 23 e5 ff ff       	call   801039d0 <myproc>
801054ad:	89 c6                	mov    %eax,%esi
  
  begin_op();
801054af:	e8 ac d8 ff ff       	call   80102d60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801054b4:	83 ec 08             	sub    $0x8,%esp
801054b7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054ba:	50                   	push   %eax
801054bb:	6a 00                	push   $0x0
801054bd:	e8 9e f5 ff ff       	call   80104a60 <argstr>
801054c2:	83 c4 10             	add    $0x10,%esp
801054c5:	85 c0                	test   %eax,%eax
801054c7:	78 77                	js     80105540 <sys_chdir+0xa0>
801054c9:	83 ec 0c             	sub    $0xc,%esp
801054cc:	ff 75 f4             	push   -0xc(%ebp)
801054cf:	e8 cc cb ff ff       	call   801020a0 <namei>
801054d4:	83 c4 10             	add    $0x10,%esp
801054d7:	89 c3                	mov    %eax,%ebx
801054d9:	85 c0                	test   %eax,%eax
801054db:	74 63                	je     80105540 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801054dd:	83 ec 0c             	sub    $0xc,%esp
801054e0:	50                   	push   %eax
801054e1:	e8 9a c2 ff ff       	call   80101780 <ilock>
  if(ip->type != T_DIR){
801054e6:	83 c4 10             	add    $0x10,%esp
801054e9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054ee:	75 30                	jne    80105520 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801054f0:	83 ec 0c             	sub    $0xc,%esp
801054f3:	53                   	push   %ebx
801054f4:	e8 67 c3 ff ff       	call   80101860 <iunlock>
  iput(curproc->cwd);
801054f9:	58                   	pop    %eax
801054fa:	ff 76 68             	push   0x68(%esi)
801054fd:	e8 ae c3 ff ff       	call   801018b0 <iput>
  end_op();
80105502:	e8 c9 d8 ff ff       	call   80102dd0 <end_op>
  curproc->cwd = ip;
80105507:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010550a:	83 c4 10             	add    $0x10,%esp
8010550d:	31 c0                	xor    %eax,%eax
}
8010550f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105512:	5b                   	pop    %ebx
80105513:	5e                   	pop    %esi
80105514:	5d                   	pop    %ebp
80105515:	c3                   	ret    
80105516:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010551d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105520:	83 ec 0c             	sub    $0xc,%esp
80105523:	53                   	push   %ebx
80105524:	e8 e7 c4 ff ff       	call   80101a10 <iunlockput>
    end_op();
80105529:	e8 a2 d8 ff ff       	call   80102dd0 <end_op>
    return -1;
8010552e:	83 c4 10             	add    $0x10,%esp
80105531:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105536:	eb d7                	jmp    8010550f <sys_chdir+0x6f>
80105538:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010553f:	90                   	nop
    end_op();
80105540:	e8 8b d8 ff ff       	call   80102dd0 <end_op>
    return -1;
80105545:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010554a:	eb c3                	jmp    8010550f <sys_chdir+0x6f>
8010554c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105550 <sys_exec>:

int
sys_exec(void)
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	57                   	push   %edi
80105554:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105555:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010555b:	53                   	push   %ebx
8010555c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105562:	50                   	push   %eax
80105563:	6a 00                	push   $0x0
80105565:	e8 f6 f4 ff ff       	call   80104a60 <argstr>
8010556a:	83 c4 10             	add    $0x10,%esp
8010556d:	85 c0                	test   %eax,%eax
8010556f:	0f 88 87 00 00 00    	js     801055fc <sys_exec+0xac>
80105575:	83 ec 08             	sub    $0x8,%esp
80105578:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010557e:	50                   	push   %eax
8010557f:	6a 01                	push   $0x1
80105581:	e8 1a f4 ff ff       	call   801049a0 <argint>
80105586:	83 c4 10             	add    $0x10,%esp
80105589:	85 c0                	test   %eax,%eax
8010558b:	78 6f                	js     801055fc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010558d:	83 ec 04             	sub    $0x4,%esp
80105590:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105596:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105598:	68 80 00 00 00       	push   $0x80
8010559d:	6a 00                	push   $0x0
8010559f:	56                   	push   %esi
801055a0:	e8 3b f1 ff ff       	call   801046e0 <memset>
801055a5:	83 c4 10             	add    $0x10,%esp
801055a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055af:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801055b0:	83 ec 08             	sub    $0x8,%esp
801055b3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
801055b9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
801055c0:	50                   	push   %eax
801055c1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801055c7:	01 f8                	add    %edi,%eax
801055c9:	50                   	push   %eax
801055ca:	e8 41 f3 ff ff       	call   80104910 <fetchint>
801055cf:	83 c4 10             	add    $0x10,%esp
801055d2:	85 c0                	test   %eax,%eax
801055d4:	78 26                	js     801055fc <sys_exec+0xac>
      return -1;
    if(uarg == 0){
801055d6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801055dc:	85 c0                	test   %eax,%eax
801055de:	74 30                	je     80105610 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801055e0:	83 ec 08             	sub    $0x8,%esp
801055e3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
801055e6:	52                   	push   %edx
801055e7:	50                   	push   %eax
801055e8:	e8 63 f3 ff ff       	call   80104950 <fetchstr>
801055ed:	83 c4 10             	add    $0x10,%esp
801055f0:	85 c0                	test   %eax,%eax
801055f2:	78 08                	js     801055fc <sys_exec+0xac>
  for(i=0;; i++){
801055f4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801055f7:	83 fb 20             	cmp    $0x20,%ebx
801055fa:	75 b4                	jne    801055b0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801055fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801055ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105604:	5b                   	pop    %ebx
80105605:	5e                   	pop    %esi
80105606:	5f                   	pop    %edi
80105607:	5d                   	pop    %ebp
80105608:	c3                   	ret    
80105609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105610:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105617:	00 00 00 00 
  return exec(path, argv);
8010561b:	83 ec 08             	sub    $0x8,%esp
8010561e:	56                   	push   %esi
8010561f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105625:	e8 86 b4 ff ff       	call   80100ab0 <exec>
8010562a:	83 c4 10             	add    $0x10,%esp
}
8010562d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105630:	5b                   	pop    %ebx
80105631:	5e                   	pop    %esi
80105632:	5f                   	pop    %edi
80105633:	5d                   	pop    %ebp
80105634:	c3                   	ret    
80105635:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010563c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105640 <sys_pipe>:

int
sys_pipe(void)
{
80105640:	55                   	push   %ebp
80105641:	89 e5                	mov    %esp,%ebp
80105643:	57                   	push   %edi
80105644:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105645:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105648:	53                   	push   %ebx
80105649:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010564c:	6a 08                	push   $0x8
8010564e:	50                   	push   %eax
8010564f:	6a 00                	push   $0x0
80105651:	e8 9a f3 ff ff       	call   801049f0 <argptr>
80105656:	83 c4 10             	add    $0x10,%esp
80105659:	85 c0                	test   %eax,%eax
8010565b:	78 4a                	js     801056a7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010565d:	83 ec 08             	sub    $0x8,%esp
80105660:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105663:	50                   	push   %eax
80105664:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105667:	50                   	push   %eax
80105668:	e8 c3 dd ff ff       	call   80103430 <pipealloc>
8010566d:	83 c4 10             	add    $0x10,%esp
80105670:	85 c0                	test   %eax,%eax
80105672:	78 33                	js     801056a7 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105674:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105677:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105679:	e8 52 e3 ff ff       	call   801039d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010567e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105680:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105684:	85 f6                	test   %esi,%esi
80105686:	74 28                	je     801056b0 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80105688:	83 c3 01             	add    $0x1,%ebx
8010568b:	83 fb 10             	cmp    $0x10,%ebx
8010568e:	75 f0                	jne    80105680 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105690:	83 ec 0c             	sub    $0xc,%esp
80105693:	ff 75 e0             	push   -0x20(%ebp)
80105696:	e8 55 b8 ff ff       	call   80100ef0 <fileclose>
    fileclose(wf);
8010569b:	58                   	pop    %eax
8010569c:	ff 75 e4             	push   -0x1c(%ebp)
8010569f:	e8 4c b8 ff ff       	call   80100ef0 <fileclose>
    return -1;
801056a4:	83 c4 10             	add    $0x10,%esp
801056a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056ac:	eb 53                	jmp    80105701 <sys_pipe+0xc1>
801056ae:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801056b0:	8d 73 08             	lea    0x8(%ebx),%esi
801056b3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801056b7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801056ba:	e8 11 e3 ff ff       	call   801039d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801056bf:	31 d2                	xor    %edx,%edx
801056c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801056c8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801056cc:	85 c9                	test   %ecx,%ecx
801056ce:	74 20                	je     801056f0 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
801056d0:	83 c2 01             	add    $0x1,%edx
801056d3:	83 fa 10             	cmp    $0x10,%edx
801056d6:	75 f0                	jne    801056c8 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
801056d8:	e8 f3 e2 ff ff       	call   801039d0 <myproc>
801056dd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801056e4:	00 
801056e5:	eb a9                	jmp    80105690 <sys_pipe+0x50>
801056e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056ee:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801056f0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
801056f4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056f7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801056f9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056fc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801056ff:	31 c0                	xor    %eax,%eax
}
80105701:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105704:	5b                   	pop    %ebx
80105705:	5e                   	pop    %esi
80105706:	5f                   	pop    %edi
80105707:	5d                   	pop    %ebp
80105708:	c3                   	ret    
80105709:	66 90                	xchg   %ax,%ax
8010570b:	66 90                	xchg   %ax,%ax
8010570d:	66 90                	xchg   %ax,%ax
8010570f:	90                   	nop

80105710 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105710:	e9 5b e4 ff ff       	jmp    80103b70 <fork>
80105715:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010571c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105720 <sys_exit>:
}

int
sys_exit(void)
{
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	83 ec 08             	sub    $0x8,%esp
  exit();
80105726:	e8 e5 e6 ff ff       	call   80103e10 <exit>
  return 0;  // not reached
}
8010572b:	31 c0                	xor    %eax,%eax
8010572d:	c9                   	leave  
8010572e:	c3                   	ret    
8010572f:	90                   	nop

80105730 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105730:	e9 0b e8 ff ff       	jmp    80103f40 <wait>
80105735:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010573c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105740 <sys_kill>:
}

int
sys_kill(void)
{
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
80105743:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105746:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105749:	50                   	push   %eax
8010574a:	6a 00                	push   $0x0
8010574c:	e8 4f f2 ff ff       	call   801049a0 <argint>
80105751:	83 c4 10             	add    $0x10,%esp
80105754:	85 c0                	test   %eax,%eax
80105756:	78 18                	js     80105770 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105758:	83 ec 0c             	sub    $0xc,%esp
8010575b:	ff 75 f4             	push   -0xc(%ebp)
8010575e:	e8 7d ea ff ff       	call   801041e0 <kill>
80105763:	83 c4 10             	add    $0x10,%esp
}
80105766:	c9                   	leave  
80105767:	c3                   	ret    
80105768:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010576f:	90                   	nop
80105770:	c9                   	leave  
    return -1;
80105771:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105776:	c3                   	ret    
80105777:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010577e:	66 90                	xchg   %ax,%ax

80105780 <sys_getpid>:

int
sys_getpid(void)
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105786:	e8 45 e2 ff ff       	call   801039d0 <myproc>
8010578b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010578e:	c9                   	leave  
8010578f:	c3                   	ret    

80105790 <sys_sbrk>:

int
sys_sbrk(void)
{
80105790:	55                   	push   %ebp
80105791:	89 e5                	mov    %esp,%ebp
80105793:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105794:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105797:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010579a:	50                   	push   %eax
8010579b:	6a 00                	push   $0x0
8010579d:	e8 fe f1 ff ff       	call   801049a0 <argint>
801057a2:	83 c4 10             	add    $0x10,%esp
801057a5:	85 c0                	test   %eax,%eax
801057a7:	78 27                	js     801057d0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801057a9:	e8 22 e2 ff ff       	call   801039d0 <myproc>
  if(growproc(n) < 0)
801057ae:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801057b1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801057b3:	ff 75 f4             	push   -0xc(%ebp)
801057b6:	e8 35 e3 ff ff       	call   80103af0 <growproc>
801057bb:	83 c4 10             	add    $0x10,%esp
801057be:	85 c0                	test   %eax,%eax
801057c0:	78 0e                	js     801057d0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801057c2:	89 d8                	mov    %ebx,%eax
801057c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057c7:	c9                   	leave  
801057c8:	c3                   	ret    
801057c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801057d0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801057d5:	eb eb                	jmp    801057c2 <sys_sbrk+0x32>
801057d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057de:	66 90                	xchg   %ax,%ax

801057e0 <sys_sleep>:

int
sys_sleep(void)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801057e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801057e7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801057ea:	50                   	push   %eax
801057eb:	6a 00                	push   $0x0
801057ed:	e8 ae f1 ff ff       	call   801049a0 <argint>
801057f2:	83 c4 10             	add    $0x10,%esp
801057f5:	85 c0                	test   %eax,%eax
801057f7:	0f 88 8a 00 00 00    	js     80105887 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801057fd:	83 ec 0c             	sub    $0xc,%esp
80105800:	68 80 9e 11 80       	push   $0x80119e80
80105805:	e8 16 ee ff ff       	call   80104620 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010580a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
8010580d:	8b 1d 60 9e 11 80    	mov    0x80119e60,%ebx
  while(ticks - ticks0 < n){
80105813:	83 c4 10             	add    $0x10,%esp
80105816:	85 d2                	test   %edx,%edx
80105818:	75 27                	jne    80105841 <sys_sleep+0x61>
8010581a:	eb 54                	jmp    80105870 <sys_sleep+0x90>
8010581c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105820:	83 ec 08             	sub    $0x8,%esp
80105823:	68 80 9e 11 80       	push   $0x80119e80
80105828:	68 60 9e 11 80       	push   $0x80119e60
8010582d:	e8 8e e8 ff ff       	call   801040c0 <sleep>
  while(ticks - ticks0 < n){
80105832:	a1 60 9e 11 80       	mov    0x80119e60,%eax
80105837:	83 c4 10             	add    $0x10,%esp
8010583a:	29 d8                	sub    %ebx,%eax
8010583c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010583f:	73 2f                	jae    80105870 <sys_sleep+0x90>
    if(myproc()->killed){
80105841:	e8 8a e1 ff ff       	call   801039d0 <myproc>
80105846:	8b 40 24             	mov    0x24(%eax),%eax
80105849:	85 c0                	test   %eax,%eax
8010584b:	74 d3                	je     80105820 <sys_sleep+0x40>
      release(&tickslock);
8010584d:	83 ec 0c             	sub    $0xc,%esp
80105850:	68 80 9e 11 80       	push   $0x80119e80
80105855:	e8 66 ed ff ff       	call   801045c0 <release>
  }
  release(&tickslock);
  return 0;
}
8010585a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010585d:	83 c4 10             	add    $0x10,%esp
80105860:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105865:	c9                   	leave  
80105866:	c3                   	ret    
80105867:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010586e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80105870:	83 ec 0c             	sub    $0xc,%esp
80105873:	68 80 9e 11 80       	push   $0x80119e80
80105878:	e8 43 ed ff ff       	call   801045c0 <release>
  return 0;
8010587d:	83 c4 10             	add    $0x10,%esp
80105880:	31 c0                	xor    %eax,%eax
}
80105882:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105885:	c9                   	leave  
80105886:	c3                   	ret    
    return -1;
80105887:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010588c:	eb f4                	jmp    80105882 <sys_sleep+0xa2>
8010588e:	66 90                	xchg   %ax,%ax

80105890 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105890:	55                   	push   %ebp
80105891:	89 e5                	mov    %esp,%ebp
80105893:	53                   	push   %ebx
80105894:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105897:	68 80 9e 11 80       	push   $0x80119e80
8010589c:	e8 7f ed ff ff       	call   80104620 <acquire>
  xticks = ticks;
801058a1:	8b 1d 60 9e 11 80    	mov    0x80119e60,%ebx
  release(&tickslock);
801058a7:	c7 04 24 80 9e 11 80 	movl   $0x80119e80,(%esp)
801058ae:	e8 0d ed ff ff       	call   801045c0 <release>
  return xticks;
}
801058b3:	89 d8                	mov    %ebx,%eax
801058b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058b8:	c9                   	leave  
801058b9:	c3                   	ret    

801058ba <alltraps>:
801058ba:	1e                   	push   %ds
801058bb:	06                   	push   %es
801058bc:	0f a0                	push   %fs
801058be:	0f a8                	push   %gs
801058c0:	60                   	pusha  
801058c1:	66 b8 10 00          	mov    $0x10,%ax
801058c5:	8e d8                	mov    %eax,%ds
801058c7:	8e c0                	mov    %eax,%es
801058c9:	54                   	push   %esp
801058ca:	e8 c1 00 00 00       	call   80105990 <trap>
801058cf:	83 c4 04             	add    $0x4,%esp

801058d2 <trapret>:
801058d2:	61                   	popa   
801058d3:	0f a9                	pop    %gs
801058d5:	0f a1                	pop    %fs
801058d7:	07                   	pop    %es
801058d8:	1f                   	pop    %ds
801058d9:	83 c4 08             	add    $0x8,%esp
801058dc:	cf                   	iret   
801058dd:	66 90                	xchg   %ax,%ax
801058df:	90                   	nop

801058e0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801058e0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801058e1:	31 c0                	xor    %eax,%eax
{
801058e3:	89 e5                	mov    %esp,%ebp
801058e5:	83 ec 08             	sub    $0x8,%esp
801058e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058ef:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801058f0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
801058f7:	c7 04 c5 c2 9e 11 80 	movl   $0x8e000008,-0x7fee613e(,%eax,8)
801058fe:	08 00 00 8e 
80105902:	66 89 14 c5 c0 9e 11 	mov    %dx,-0x7fee6140(,%eax,8)
80105909:	80 
8010590a:	c1 ea 10             	shr    $0x10,%edx
8010590d:	66 89 14 c5 c6 9e 11 	mov    %dx,-0x7fee613a(,%eax,8)
80105914:	80 
  for(i = 0; i < 256; i++)
80105915:	83 c0 01             	add    $0x1,%eax
80105918:	3d 00 01 00 00       	cmp    $0x100,%eax
8010591d:	75 d1                	jne    801058f0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010591f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105922:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80105927:	c7 05 c2 a0 11 80 08 	movl   $0xef000008,0x8011a0c2
8010592e:	00 00 ef 
  initlock(&tickslock, "time");
80105931:	68 8d 81 10 80       	push   $0x8010818d
80105936:	68 80 9e 11 80       	push   $0x80119e80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010593b:	66 a3 c0 a0 11 80    	mov    %ax,0x8011a0c0
80105941:	c1 e8 10             	shr    $0x10,%eax
80105944:	66 a3 c6 a0 11 80    	mov    %ax,0x8011a0c6
  initlock(&tickslock, "time");
8010594a:	e8 01 eb ff ff       	call   80104450 <initlock>
}
8010594f:	83 c4 10             	add    $0x10,%esp
80105952:	c9                   	leave  
80105953:	c3                   	ret    
80105954:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010595b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010595f:	90                   	nop

80105960 <idtinit>:

void
idtinit(void)
{
80105960:	55                   	push   %ebp
  pd[0] = size-1;
80105961:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105966:	89 e5                	mov    %esp,%ebp
80105968:	83 ec 10             	sub    $0x10,%esp
8010596b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010596f:	b8 c0 9e 11 80       	mov    $0x80119ec0,%eax
80105974:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105978:	c1 e8 10             	shr    $0x10,%eax
8010597b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010597f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105982:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105985:	c9                   	leave  
80105986:	c3                   	ret    
80105987:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010598e:	66 90                	xchg   %ax,%ax

80105990 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
80105993:	57                   	push   %edi
80105994:	56                   	push   %esi
80105995:	53                   	push   %ebx
80105996:	83 ec 1c             	sub    $0x1c,%esp
80105999:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010599c:	8b 43 30             	mov    0x30(%ebx),%eax
8010599f:	83 f8 40             	cmp    $0x40,%eax
801059a2:	0f 84 38 01 00 00    	je     80105ae0 <trap+0x150>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801059a8:	83 e8 0e             	sub    $0xe,%eax
801059ab:	83 f8 31             	cmp    $0x31,%eax
801059ae:	0f 87 8c 00 00 00    	ja     80105a40 <trap+0xb0>
801059b4:	ff 24 85 70 82 10 80 	jmp    *-0x7fef7d90(,%eax,4)
801059bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059bf:	90                   	nop
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
801059c0:	e8 eb df ff ff       	call   801039b0 <cpuid>
801059c5:	85 c0                	test   %eax,%eax
801059c7:	0f 84 63 02 00 00    	je     80105c30 <trap+0x2a0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
801059cd:	e8 3e cf ff ff       	call   80102910 <lapiceoi>


  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801059d2:	e8 f9 df ff ff       	call   801039d0 <myproc>
801059d7:	85 c0                	test   %eax,%eax
801059d9:	74 1d                	je     801059f8 <trap+0x68>
801059db:	e8 f0 df ff ff       	call   801039d0 <myproc>
801059e0:	8b 50 24             	mov    0x24(%eax),%edx
801059e3:	85 d2                	test   %edx,%edx
801059e5:	74 11                	je     801059f8 <trap+0x68>
801059e7:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801059eb:	83 e0 03             	and    $0x3,%eax
801059ee:	66 83 f8 03          	cmp    $0x3,%ax
801059f2:	0f 84 18 02 00 00    	je     80105c10 <trap+0x280>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801059f8:	e8 d3 df ff ff       	call   801039d0 <myproc>
801059fd:	85 c0                	test   %eax,%eax
801059ff:	74 0f                	je     80105a10 <trap+0x80>
80105a01:	e8 ca df ff ff       	call   801039d0 <myproc>
80105a06:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105a0a:	0f 84 b8 00 00 00    	je     80105ac8 <trap+0x138>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a10:	e8 bb df ff ff       	call   801039d0 <myproc>
80105a15:	85 c0                	test   %eax,%eax
80105a17:	74 1d                	je     80105a36 <trap+0xa6>
80105a19:	e8 b2 df ff ff       	call   801039d0 <myproc>
80105a1e:	8b 40 24             	mov    0x24(%eax),%eax
80105a21:	85 c0                	test   %eax,%eax
80105a23:	74 11                	je     80105a36 <trap+0xa6>
80105a25:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105a29:	83 e0 03             	and    $0x3,%eax
80105a2c:	66 83 f8 03          	cmp    $0x3,%ax
80105a30:	0f 84 d7 00 00 00    	je     80105b0d <trap+0x17d>
    exit();
}
80105a36:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a39:	5b                   	pop    %ebx
80105a3a:	5e                   	pop    %esi
80105a3b:	5f                   	pop    %edi
80105a3c:	5d                   	pop    %ebp
80105a3d:	c3                   	ret    
80105a3e:	66 90                	xchg   %ax,%ax
    if(myproc() == 0 || (tf->cs&3) == 0){
80105a40:	e8 8b df ff ff       	call   801039d0 <myproc>
80105a45:	85 c0                	test   %eax,%eax
80105a47:	0f 84 88 02 00 00    	je     80105cd5 <trap+0x345>
80105a4d:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105a51:	0f 84 7e 02 00 00    	je     80105cd5 <trap+0x345>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105a57:	0f 20 d1             	mov    %cr2,%ecx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a5a:	8b 53 38             	mov    0x38(%ebx),%edx
80105a5d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105a60:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105a63:	e8 48 df ff ff       	call   801039b0 <cpuid>
80105a68:	8b 73 30             	mov    0x30(%ebx),%esi
80105a6b:	89 c7                	mov    %eax,%edi
80105a6d:	8b 43 34             	mov    0x34(%ebx),%eax
80105a70:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105a73:	e8 58 df ff ff       	call   801039d0 <myproc>
80105a78:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105a7b:	e8 50 df ff ff       	call   801039d0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a80:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105a83:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105a86:	51                   	push   %ecx
80105a87:	52                   	push   %edx
80105a88:	57                   	push   %edi
80105a89:	ff 75 e4             	push   -0x1c(%ebp)
80105a8c:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105a8d:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105a90:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a93:	56                   	push   %esi
80105a94:	ff 70 10             	push   0x10(%eax)
80105a97:	68 2c 82 10 80       	push   $0x8010822c
80105a9c:	e8 ff ab ff ff       	call   801006a0 <cprintf>
    myproc()->killed = 1;
80105aa1:	83 c4 20             	add    $0x20,%esp
80105aa4:	e8 27 df ff ff       	call   801039d0 <myproc>
80105aa9:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ab0:	e8 1b df ff ff       	call   801039d0 <myproc>
80105ab5:	85 c0                	test   %eax,%eax
80105ab7:	0f 85 1e ff ff ff    	jne    801059db <trap+0x4b>
80105abd:	e9 36 ff ff ff       	jmp    801059f8 <trap+0x68>
80105ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105ac8:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105acc:	0f 85 3e ff ff ff    	jne    80105a10 <trap+0x80>
    yield();
80105ad2:	e8 99 e5 ff ff       	call   80104070 <yield>
80105ad7:	e9 34 ff ff ff       	jmp    80105a10 <trap+0x80>
80105adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105ae0:	e8 eb de ff ff       	call   801039d0 <myproc>
80105ae5:	8b 40 24             	mov    0x24(%eax),%eax
80105ae8:	85 c0                	test   %eax,%eax
80105aea:	0f 85 30 01 00 00    	jne    80105c20 <trap+0x290>
    myproc()->tf = tf;
80105af0:	e8 db de ff ff       	call   801039d0 <myproc>
80105af5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105af8:	e8 e3 ef ff ff       	call   80104ae0 <syscall>
    if(myproc()->killed)
80105afd:	e8 ce de ff ff       	call   801039d0 <myproc>
80105b02:	8b 40 24             	mov    0x24(%eax),%eax
80105b05:	85 c0                	test   %eax,%eax
80105b07:	0f 84 29 ff ff ff    	je     80105a36 <trap+0xa6>
}
80105b0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b10:	5b                   	pop    %ebx
80105b11:	5e                   	pop    %esi
80105b12:	5f                   	pop    %edi
80105b13:	5d                   	pop    %ebp
      exit();
80105b14:	e9 f7 e2 ff ff       	jmp    80103e10 <exit>
80105b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105b20:	8b 7b 38             	mov    0x38(%ebx),%edi
80105b23:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105b27:	e8 84 de ff ff       	call   801039b0 <cpuid>
80105b2c:	57                   	push   %edi
80105b2d:	56                   	push   %esi
80105b2e:	50                   	push   %eax
80105b2f:	68 d4 81 10 80       	push   $0x801081d4
80105b34:	e8 67 ab ff ff       	call   801006a0 <cprintf>
    lapiceoi();
80105b39:	e8 d2 cd ff ff       	call   80102910 <lapiceoi>
    break;
80105b3e:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b41:	e8 8a de ff ff       	call   801039d0 <myproc>
80105b46:	85 c0                	test   %eax,%eax
80105b48:	0f 85 8d fe ff ff    	jne    801059db <trap+0x4b>
80105b4e:	e9 a5 fe ff ff       	jmp    801059f8 <trap+0x68>
80105b53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b57:	90                   	nop
    kbdintr();
80105b58:	e8 73 cc ff ff       	call   801027d0 <kbdintr>
    lapiceoi();
80105b5d:	e8 ae cd ff ff       	call   80102910 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b62:	e8 69 de ff ff       	call   801039d0 <myproc>
80105b67:	85 c0                	test   %eax,%eax
80105b69:	0f 85 6c fe ff ff    	jne    801059db <trap+0x4b>
80105b6f:	e9 84 fe ff ff       	jmp    801059f8 <trap+0x68>
80105b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105b78:	e8 f3 02 00 00       	call   80105e70 <uartintr>
    lapiceoi();
80105b7d:	e8 8e cd ff ff       	call   80102910 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b82:	e8 49 de ff ff       	call   801039d0 <myproc>
80105b87:	85 c0                	test   %eax,%eax
80105b89:	0f 85 4c fe ff ff    	jne    801059db <trap+0x4b>
80105b8f:	e9 64 fe ff ff       	jmp    801059f8 <trap+0x68>
80105b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105b98:	e8 a3 c6 ff ff       	call   80102240 <ideintr>
80105b9d:	e9 2b fe ff ff       	jmp    801059cd <trap+0x3d>
80105ba2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    struct proc* p = myproc();
80105ba8:	e8 23 de ff ff       	call   801039d0 <myproc>
    for(int i = 0; i < 16; ++i) {
80105bad:	31 f6                	xor    %esi,%esi
    struct proc* p = myproc();
80105baf:	89 c2                	mov    %eax,%edx
    if(p->pgdir==0) {
80105bb1:	8d 40 7c             	lea    0x7c(%eax),%eax
80105bb4:	8b 7a 04             	mov    0x4(%edx),%edi
80105bb7:	85 ff                	test   %edi,%edi
80105bb9:	0f 84 f9 00 00 00    	je     80105cb8 <trap+0x328>
80105bbf:	90                   	nop
80105bc0:	0f 20 d7             	mov    %cr2,%edi
      if (rcr2()>=p->addr[i].va && rcr2() < p->addr[i].va+p->addr[i].size) {
80105bc3:	8b 08                	mov    (%eax),%ecx
80105bc5:	39 f9                	cmp    %edi,%ecx
80105bc7:	77 0e                	ja     80105bd7 <trap+0x247>
80105bc9:	0f 20 d7             	mov    %cr2,%edi
80105bcc:	03 48 04             	add    0x4(%eax),%ecx
80105bcf:	39 f9                	cmp    %edi,%ecx
80105bd1:	0f 87 91 00 00 00    	ja     80105c68 <trap+0x2d8>
    for(int i = 0; i < 16; ++i) {
80105bd7:	83 c6 01             	add    $0x1,%esi
80105bda:	83 c0 14             	add    $0x14,%eax
80105bdd:	83 fe 10             	cmp    $0x10,%esi
80105be0:	75 de                	jne    80105bc0 <trap+0x230>
      cprintf("Segmentation Fault\n");
80105be2:	83 ec 0c             	sub    $0xc,%esp
80105be5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80105be8:	68 b9 81 10 80       	push   $0x801081b9
          cprintf("kalloc failed\n");
80105bed:	e8 ae aa ff ff       	call   801006a0 <cprintf>
          kill(p->pid);
80105bf2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105bf5:	59                   	pop    %ecx
80105bf6:	ff 72 10             	push   0x10(%edx)
80105bf9:	e8 e2 e5 ff ff       	call   801041e0 <kill>
80105bfe:	83 c4 10             	add    $0x10,%esp
80105c01:	e9 cc fd ff ff       	jmp    801059d2 <trap+0x42>
80105c06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c0d:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80105c10:	e8 fb e1 ff ff       	call   80103e10 <exit>
80105c15:	e9 de fd ff ff       	jmp    801059f8 <trap+0x68>
80105c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105c20:	e8 eb e1 ff ff       	call   80103e10 <exit>
80105c25:	e9 c6 fe ff ff       	jmp    80105af0 <trap+0x160>
80105c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105c30:	83 ec 0c             	sub    $0xc,%esp
80105c33:	68 80 9e 11 80       	push   $0x80119e80
80105c38:	e8 e3 e9 ff ff       	call   80104620 <acquire>
      wakeup(&ticks);
80105c3d:	c7 04 24 60 9e 11 80 	movl   $0x80119e60,(%esp)
      ticks++;
80105c44:	83 05 60 9e 11 80 01 	addl   $0x1,0x80119e60
      wakeup(&ticks);
80105c4b:	e8 30 e5 ff ff       	call   80104180 <wakeup>
      release(&tickslock);
80105c50:	c7 04 24 80 9e 11 80 	movl   $0x80119e80,(%esp)
80105c57:	e8 64 e9 ff ff       	call   801045c0 <release>
80105c5c:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105c5f:	e9 69 fd ff ff       	jmp    801059cd <trap+0x3d>
80105c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c68:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80105c6b:	0f 20 d7             	mov    %cr2,%edi
        mem = kalloc();
80105c6e:	e8 0d ca ff ff       	call   80102680 <kalloc>
        if(mem == 0){
80105c73:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105c76:	85 c0                	test   %eax,%eax
80105c78:	74 4e                	je     80105cc8 <trap+0x338>
        mappages(p->pgdir, (void*)temp_length, PAGE_SIZE, V2P(mem), PTE_W | PTE_U);
80105c7a:	83 ec 0c             	sub    $0xc,%esp
80105c7d:	05 00 00 00 80       	add    $0x80000000,%eax
        temp_length = PGROUNDDOWN(rcr2());
80105c82:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
        mappages(p->pgdir, (void*)temp_length, PAGE_SIZE, V2P(mem), PTE_W | PTE_U);
80105c88:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80105c8b:	6a 06                	push   $0x6
80105c8d:	50                   	push   %eax
80105c8e:	68 00 10 00 00       	push   $0x1000
80105c93:	57                   	push   %edi
80105c94:	ff 72 04             	push   0x4(%edx)
80105c97:	e8 34 0e 00 00       	call   80106ad0 <mappages>
        p->addr[i].phys_page_used += 1;
80105c9c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105c9f:	8d 04 b6             	lea    (%esi,%esi,4),%eax
80105ca2:	83 c4 20             	add    $0x20,%esp
80105ca5:	83 84 82 8c 00 00 00 	addl   $0x1,0x8c(%edx,%eax,4)
80105cac:	01 
    if (!success) {
80105cad:	e9 20 fd ff ff       	jmp    801059d2 <trap+0x42>
80105cb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("Invalid page directory\n");
80105cb8:	83 ec 0c             	sub    $0xc,%esp
80105cbb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80105cbe:	68 92 81 10 80       	push   $0x80108192
80105cc3:	e9 25 ff ff ff       	jmp    80105bed <trap+0x25d>
          cprintf("kalloc failed\n");
80105cc8:	83 ec 0c             	sub    $0xc,%esp
80105ccb:	68 aa 81 10 80       	push   $0x801081aa
80105cd0:	e9 18 ff ff ff       	jmp    80105bed <trap+0x25d>
80105cd5:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105cd8:	8b 73 38             	mov    0x38(%ebx),%esi
80105cdb:	e8 d0 dc ff ff       	call   801039b0 <cpuid>
80105ce0:	83 ec 0c             	sub    $0xc,%esp
80105ce3:	57                   	push   %edi
80105ce4:	56                   	push   %esi
80105ce5:	50                   	push   %eax
80105ce6:	ff 73 30             	push   0x30(%ebx)
80105ce9:	68 f8 81 10 80       	push   $0x801081f8
80105cee:	e8 ad a9 ff ff       	call   801006a0 <cprintf>
      panic("trap");
80105cf3:	83 c4 14             	add    $0x14,%esp
80105cf6:	68 cd 81 10 80       	push   $0x801081cd
80105cfb:	e8 80 a6 ff ff       	call   80100380 <panic>

80105d00 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105d00:	a1 c0 a6 11 80       	mov    0x8011a6c0,%eax
80105d05:	85 c0                	test   %eax,%eax
80105d07:	74 17                	je     80105d20 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d09:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d0e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105d0f:	a8 01                	test   $0x1,%al
80105d11:	74 0d                	je     80105d20 <uartgetc+0x20>
80105d13:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d18:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105d19:	0f b6 c0             	movzbl %al,%eax
80105d1c:	c3                   	ret    
80105d1d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105d20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d25:	c3                   	ret    
80105d26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d2d:	8d 76 00             	lea    0x0(%esi),%esi

80105d30 <uartinit>:
{
80105d30:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d31:	31 c9                	xor    %ecx,%ecx
80105d33:	89 c8                	mov    %ecx,%eax
80105d35:	89 e5                	mov    %esp,%ebp
80105d37:	57                   	push   %edi
80105d38:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105d3d:	56                   	push   %esi
80105d3e:	89 fa                	mov    %edi,%edx
80105d40:	53                   	push   %ebx
80105d41:	83 ec 1c             	sub    $0x1c,%esp
80105d44:	ee                   	out    %al,(%dx)
80105d45:	be fb 03 00 00       	mov    $0x3fb,%esi
80105d4a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105d4f:	89 f2                	mov    %esi,%edx
80105d51:	ee                   	out    %al,(%dx)
80105d52:	b8 0c 00 00 00       	mov    $0xc,%eax
80105d57:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d5c:	ee                   	out    %al,(%dx)
80105d5d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105d62:	89 c8                	mov    %ecx,%eax
80105d64:	89 da                	mov    %ebx,%edx
80105d66:	ee                   	out    %al,(%dx)
80105d67:	b8 03 00 00 00       	mov    $0x3,%eax
80105d6c:	89 f2                	mov    %esi,%edx
80105d6e:	ee                   	out    %al,(%dx)
80105d6f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105d74:	89 c8                	mov    %ecx,%eax
80105d76:	ee                   	out    %al,(%dx)
80105d77:	b8 01 00 00 00       	mov    $0x1,%eax
80105d7c:	89 da                	mov    %ebx,%edx
80105d7e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d7f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d84:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105d85:	3c ff                	cmp    $0xff,%al
80105d87:	74 78                	je     80105e01 <uartinit+0xd1>
  uart = 1;
80105d89:	c7 05 c0 a6 11 80 01 	movl   $0x1,0x8011a6c0
80105d90:	00 00 00 
80105d93:	89 fa                	mov    %edi,%edx
80105d95:	ec                   	in     (%dx),%al
80105d96:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d9b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105d9c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105d9f:	bf 38 83 10 80       	mov    $0x80108338,%edi
80105da4:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80105da9:	6a 00                	push   $0x0
80105dab:	6a 04                	push   $0x4
80105dad:	e8 ce c6 ff ff       	call   80102480 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80105db2:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
80105db6:	83 c4 10             	add    $0x10,%esp
80105db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80105dc0:	a1 c0 a6 11 80       	mov    0x8011a6c0,%eax
80105dc5:	bb 80 00 00 00       	mov    $0x80,%ebx
80105dca:	85 c0                	test   %eax,%eax
80105dcc:	75 14                	jne    80105de2 <uartinit+0xb2>
80105dce:	eb 23                	jmp    80105df3 <uartinit+0xc3>
    microdelay(10);
80105dd0:	83 ec 0c             	sub    $0xc,%esp
80105dd3:	6a 0a                	push   $0xa
80105dd5:	e8 56 cb ff ff       	call   80102930 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105dda:	83 c4 10             	add    $0x10,%esp
80105ddd:	83 eb 01             	sub    $0x1,%ebx
80105de0:	74 07                	je     80105de9 <uartinit+0xb9>
80105de2:	89 f2                	mov    %esi,%edx
80105de4:	ec                   	in     (%dx),%al
80105de5:	a8 20                	test   $0x20,%al
80105de7:	74 e7                	je     80105dd0 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105de9:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105ded:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105df2:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80105df3:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80105df7:	83 c7 01             	add    $0x1,%edi
80105dfa:	88 45 e7             	mov    %al,-0x19(%ebp)
80105dfd:	84 c0                	test   %al,%al
80105dff:	75 bf                	jne    80105dc0 <uartinit+0x90>
}
80105e01:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e04:	5b                   	pop    %ebx
80105e05:	5e                   	pop    %esi
80105e06:	5f                   	pop    %edi
80105e07:	5d                   	pop    %ebp
80105e08:	c3                   	ret    
80105e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e10 <uartputc>:
  if(!uart)
80105e10:	a1 c0 a6 11 80       	mov    0x8011a6c0,%eax
80105e15:	85 c0                	test   %eax,%eax
80105e17:	74 47                	je     80105e60 <uartputc+0x50>
{
80105e19:	55                   	push   %ebp
80105e1a:	89 e5                	mov    %esp,%ebp
80105e1c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105e1d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105e22:	53                   	push   %ebx
80105e23:	bb 80 00 00 00       	mov    $0x80,%ebx
80105e28:	eb 18                	jmp    80105e42 <uartputc+0x32>
80105e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80105e30:	83 ec 0c             	sub    $0xc,%esp
80105e33:	6a 0a                	push   $0xa
80105e35:	e8 f6 ca ff ff       	call   80102930 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105e3a:	83 c4 10             	add    $0x10,%esp
80105e3d:	83 eb 01             	sub    $0x1,%ebx
80105e40:	74 07                	je     80105e49 <uartputc+0x39>
80105e42:	89 f2                	mov    %esi,%edx
80105e44:	ec                   	in     (%dx),%al
80105e45:	a8 20                	test   $0x20,%al
80105e47:	74 e7                	je     80105e30 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105e49:	8b 45 08             	mov    0x8(%ebp),%eax
80105e4c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e51:	ee                   	out    %al,(%dx)
}
80105e52:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105e55:	5b                   	pop    %ebx
80105e56:	5e                   	pop    %esi
80105e57:	5d                   	pop    %ebp
80105e58:	c3                   	ret    
80105e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e60:	c3                   	ret    
80105e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e6f:	90                   	nop

80105e70 <uartintr>:

void
uartintr(void)
{
80105e70:	55                   	push   %ebp
80105e71:	89 e5                	mov    %esp,%ebp
80105e73:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105e76:	68 00 5d 10 80       	push   $0x80105d00
80105e7b:	e8 00 aa ff ff       	call   80100880 <consoleintr>
}
80105e80:	83 c4 10             	add    $0x10,%esp
80105e83:	c9                   	leave  
80105e84:	c3                   	ret    

80105e85 <vector0>:
80105e85:	6a 00                	push   $0x0
80105e87:	6a 00                	push   $0x0
80105e89:	e9 2c fa ff ff       	jmp    801058ba <alltraps>

80105e8e <vector1>:
80105e8e:	6a 00                	push   $0x0
80105e90:	6a 01                	push   $0x1
80105e92:	e9 23 fa ff ff       	jmp    801058ba <alltraps>

80105e97 <vector2>:
80105e97:	6a 00                	push   $0x0
80105e99:	6a 02                	push   $0x2
80105e9b:	e9 1a fa ff ff       	jmp    801058ba <alltraps>

80105ea0 <vector3>:
80105ea0:	6a 00                	push   $0x0
80105ea2:	6a 03                	push   $0x3
80105ea4:	e9 11 fa ff ff       	jmp    801058ba <alltraps>

80105ea9 <vector4>:
80105ea9:	6a 00                	push   $0x0
80105eab:	6a 04                	push   $0x4
80105ead:	e9 08 fa ff ff       	jmp    801058ba <alltraps>

80105eb2 <vector5>:
80105eb2:	6a 00                	push   $0x0
80105eb4:	6a 05                	push   $0x5
80105eb6:	e9 ff f9 ff ff       	jmp    801058ba <alltraps>

80105ebb <vector6>:
80105ebb:	6a 00                	push   $0x0
80105ebd:	6a 06                	push   $0x6
80105ebf:	e9 f6 f9 ff ff       	jmp    801058ba <alltraps>

80105ec4 <vector7>:
80105ec4:	6a 00                	push   $0x0
80105ec6:	6a 07                	push   $0x7
80105ec8:	e9 ed f9 ff ff       	jmp    801058ba <alltraps>

80105ecd <vector8>:
80105ecd:	6a 08                	push   $0x8
80105ecf:	e9 e6 f9 ff ff       	jmp    801058ba <alltraps>

80105ed4 <vector9>:
80105ed4:	6a 00                	push   $0x0
80105ed6:	6a 09                	push   $0x9
80105ed8:	e9 dd f9 ff ff       	jmp    801058ba <alltraps>

80105edd <vector10>:
80105edd:	6a 0a                	push   $0xa
80105edf:	e9 d6 f9 ff ff       	jmp    801058ba <alltraps>

80105ee4 <vector11>:
80105ee4:	6a 0b                	push   $0xb
80105ee6:	e9 cf f9 ff ff       	jmp    801058ba <alltraps>

80105eeb <vector12>:
80105eeb:	6a 0c                	push   $0xc
80105eed:	e9 c8 f9 ff ff       	jmp    801058ba <alltraps>

80105ef2 <vector13>:
80105ef2:	6a 0d                	push   $0xd
80105ef4:	e9 c1 f9 ff ff       	jmp    801058ba <alltraps>

80105ef9 <vector14>:
80105ef9:	6a 0e                	push   $0xe
80105efb:	e9 ba f9 ff ff       	jmp    801058ba <alltraps>

80105f00 <vector15>:
80105f00:	6a 00                	push   $0x0
80105f02:	6a 0f                	push   $0xf
80105f04:	e9 b1 f9 ff ff       	jmp    801058ba <alltraps>

80105f09 <vector16>:
80105f09:	6a 00                	push   $0x0
80105f0b:	6a 10                	push   $0x10
80105f0d:	e9 a8 f9 ff ff       	jmp    801058ba <alltraps>

80105f12 <vector17>:
80105f12:	6a 11                	push   $0x11
80105f14:	e9 a1 f9 ff ff       	jmp    801058ba <alltraps>

80105f19 <vector18>:
80105f19:	6a 00                	push   $0x0
80105f1b:	6a 12                	push   $0x12
80105f1d:	e9 98 f9 ff ff       	jmp    801058ba <alltraps>

80105f22 <vector19>:
80105f22:	6a 00                	push   $0x0
80105f24:	6a 13                	push   $0x13
80105f26:	e9 8f f9 ff ff       	jmp    801058ba <alltraps>

80105f2b <vector20>:
80105f2b:	6a 00                	push   $0x0
80105f2d:	6a 14                	push   $0x14
80105f2f:	e9 86 f9 ff ff       	jmp    801058ba <alltraps>

80105f34 <vector21>:
80105f34:	6a 00                	push   $0x0
80105f36:	6a 15                	push   $0x15
80105f38:	e9 7d f9 ff ff       	jmp    801058ba <alltraps>

80105f3d <vector22>:
80105f3d:	6a 00                	push   $0x0
80105f3f:	6a 16                	push   $0x16
80105f41:	e9 74 f9 ff ff       	jmp    801058ba <alltraps>

80105f46 <vector23>:
80105f46:	6a 00                	push   $0x0
80105f48:	6a 17                	push   $0x17
80105f4a:	e9 6b f9 ff ff       	jmp    801058ba <alltraps>

80105f4f <vector24>:
80105f4f:	6a 00                	push   $0x0
80105f51:	6a 18                	push   $0x18
80105f53:	e9 62 f9 ff ff       	jmp    801058ba <alltraps>

80105f58 <vector25>:
80105f58:	6a 00                	push   $0x0
80105f5a:	6a 19                	push   $0x19
80105f5c:	e9 59 f9 ff ff       	jmp    801058ba <alltraps>

80105f61 <vector26>:
80105f61:	6a 00                	push   $0x0
80105f63:	6a 1a                	push   $0x1a
80105f65:	e9 50 f9 ff ff       	jmp    801058ba <alltraps>

80105f6a <vector27>:
80105f6a:	6a 00                	push   $0x0
80105f6c:	6a 1b                	push   $0x1b
80105f6e:	e9 47 f9 ff ff       	jmp    801058ba <alltraps>

80105f73 <vector28>:
80105f73:	6a 00                	push   $0x0
80105f75:	6a 1c                	push   $0x1c
80105f77:	e9 3e f9 ff ff       	jmp    801058ba <alltraps>

80105f7c <vector29>:
80105f7c:	6a 00                	push   $0x0
80105f7e:	6a 1d                	push   $0x1d
80105f80:	e9 35 f9 ff ff       	jmp    801058ba <alltraps>

80105f85 <vector30>:
80105f85:	6a 00                	push   $0x0
80105f87:	6a 1e                	push   $0x1e
80105f89:	e9 2c f9 ff ff       	jmp    801058ba <alltraps>

80105f8e <vector31>:
80105f8e:	6a 00                	push   $0x0
80105f90:	6a 1f                	push   $0x1f
80105f92:	e9 23 f9 ff ff       	jmp    801058ba <alltraps>

80105f97 <vector32>:
80105f97:	6a 00                	push   $0x0
80105f99:	6a 20                	push   $0x20
80105f9b:	e9 1a f9 ff ff       	jmp    801058ba <alltraps>

80105fa0 <vector33>:
80105fa0:	6a 00                	push   $0x0
80105fa2:	6a 21                	push   $0x21
80105fa4:	e9 11 f9 ff ff       	jmp    801058ba <alltraps>

80105fa9 <vector34>:
80105fa9:	6a 00                	push   $0x0
80105fab:	6a 22                	push   $0x22
80105fad:	e9 08 f9 ff ff       	jmp    801058ba <alltraps>

80105fb2 <vector35>:
80105fb2:	6a 00                	push   $0x0
80105fb4:	6a 23                	push   $0x23
80105fb6:	e9 ff f8 ff ff       	jmp    801058ba <alltraps>

80105fbb <vector36>:
80105fbb:	6a 00                	push   $0x0
80105fbd:	6a 24                	push   $0x24
80105fbf:	e9 f6 f8 ff ff       	jmp    801058ba <alltraps>

80105fc4 <vector37>:
80105fc4:	6a 00                	push   $0x0
80105fc6:	6a 25                	push   $0x25
80105fc8:	e9 ed f8 ff ff       	jmp    801058ba <alltraps>

80105fcd <vector38>:
80105fcd:	6a 00                	push   $0x0
80105fcf:	6a 26                	push   $0x26
80105fd1:	e9 e4 f8 ff ff       	jmp    801058ba <alltraps>

80105fd6 <vector39>:
80105fd6:	6a 00                	push   $0x0
80105fd8:	6a 27                	push   $0x27
80105fda:	e9 db f8 ff ff       	jmp    801058ba <alltraps>

80105fdf <vector40>:
80105fdf:	6a 00                	push   $0x0
80105fe1:	6a 28                	push   $0x28
80105fe3:	e9 d2 f8 ff ff       	jmp    801058ba <alltraps>

80105fe8 <vector41>:
80105fe8:	6a 00                	push   $0x0
80105fea:	6a 29                	push   $0x29
80105fec:	e9 c9 f8 ff ff       	jmp    801058ba <alltraps>

80105ff1 <vector42>:
80105ff1:	6a 00                	push   $0x0
80105ff3:	6a 2a                	push   $0x2a
80105ff5:	e9 c0 f8 ff ff       	jmp    801058ba <alltraps>

80105ffa <vector43>:
80105ffa:	6a 00                	push   $0x0
80105ffc:	6a 2b                	push   $0x2b
80105ffe:	e9 b7 f8 ff ff       	jmp    801058ba <alltraps>

80106003 <vector44>:
80106003:	6a 00                	push   $0x0
80106005:	6a 2c                	push   $0x2c
80106007:	e9 ae f8 ff ff       	jmp    801058ba <alltraps>

8010600c <vector45>:
8010600c:	6a 00                	push   $0x0
8010600e:	6a 2d                	push   $0x2d
80106010:	e9 a5 f8 ff ff       	jmp    801058ba <alltraps>

80106015 <vector46>:
80106015:	6a 00                	push   $0x0
80106017:	6a 2e                	push   $0x2e
80106019:	e9 9c f8 ff ff       	jmp    801058ba <alltraps>

8010601e <vector47>:
8010601e:	6a 00                	push   $0x0
80106020:	6a 2f                	push   $0x2f
80106022:	e9 93 f8 ff ff       	jmp    801058ba <alltraps>

80106027 <vector48>:
80106027:	6a 00                	push   $0x0
80106029:	6a 30                	push   $0x30
8010602b:	e9 8a f8 ff ff       	jmp    801058ba <alltraps>

80106030 <vector49>:
80106030:	6a 00                	push   $0x0
80106032:	6a 31                	push   $0x31
80106034:	e9 81 f8 ff ff       	jmp    801058ba <alltraps>

80106039 <vector50>:
80106039:	6a 00                	push   $0x0
8010603b:	6a 32                	push   $0x32
8010603d:	e9 78 f8 ff ff       	jmp    801058ba <alltraps>

80106042 <vector51>:
80106042:	6a 00                	push   $0x0
80106044:	6a 33                	push   $0x33
80106046:	e9 6f f8 ff ff       	jmp    801058ba <alltraps>

8010604b <vector52>:
8010604b:	6a 00                	push   $0x0
8010604d:	6a 34                	push   $0x34
8010604f:	e9 66 f8 ff ff       	jmp    801058ba <alltraps>

80106054 <vector53>:
80106054:	6a 00                	push   $0x0
80106056:	6a 35                	push   $0x35
80106058:	e9 5d f8 ff ff       	jmp    801058ba <alltraps>

8010605d <vector54>:
8010605d:	6a 00                	push   $0x0
8010605f:	6a 36                	push   $0x36
80106061:	e9 54 f8 ff ff       	jmp    801058ba <alltraps>

80106066 <vector55>:
80106066:	6a 00                	push   $0x0
80106068:	6a 37                	push   $0x37
8010606a:	e9 4b f8 ff ff       	jmp    801058ba <alltraps>

8010606f <vector56>:
8010606f:	6a 00                	push   $0x0
80106071:	6a 38                	push   $0x38
80106073:	e9 42 f8 ff ff       	jmp    801058ba <alltraps>

80106078 <vector57>:
80106078:	6a 00                	push   $0x0
8010607a:	6a 39                	push   $0x39
8010607c:	e9 39 f8 ff ff       	jmp    801058ba <alltraps>

80106081 <vector58>:
80106081:	6a 00                	push   $0x0
80106083:	6a 3a                	push   $0x3a
80106085:	e9 30 f8 ff ff       	jmp    801058ba <alltraps>

8010608a <vector59>:
8010608a:	6a 00                	push   $0x0
8010608c:	6a 3b                	push   $0x3b
8010608e:	e9 27 f8 ff ff       	jmp    801058ba <alltraps>

80106093 <vector60>:
80106093:	6a 00                	push   $0x0
80106095:	6a 3c                	push   $0x3c
80106097:	e9 1e f8 ff ff       	jmp    801058ba <alltraps>

8010609c <vector61>:
8010609c:	6a 00                	push   $0x0
8010609e:	6a 3d                	push   $0x3d
801060a0:	e9 15 f8 ff ff       	jmp    801058ba <alltraps>

801060a5 <vector62>:
801060a5:	6a 00                	push   $0x0
801060a7:	6a 3e                	push   $0x3e
801060a9:	e9 0c f8 ff ff       	jmp    801058ba <alltraps>

801060ae <vector63>:
801060ae:	6a 00                	push   $0x0
801060b0:	6a 3f                	push   $0x3f
801060b2:	e9 03 f8 ff ff       	jmp    801058ba <alltraps>

801060b7 <vector64>:
801060b7:	6a 00                	push   $0x0
801060b9:	6a 40                	push   $0x40
801060bb:	e9 fa f7 ff ff       	jmp    801058ba <alltraps>

801060c0 <vector65>:
801060c0:	6a 00                	push   $0x0
801060c2:	6a 41                	push   $0x41
801060c4:	e9 f1 f7 ff ff       	jmp    801058ba <alltraps>

801060c9 <vector66>:
801060c9:	6a 00                	push   $0x0
801060cb:	6a 42                	push   $0x42
801060cd:	e9 e8 f7 ff ff       	jmp    801058ba <alltraps>

801060d2 <vector67>:
801060d2:	6a 00                	push   $0x0
801060d4:	6a 43                	push   $0x43
801060d6:	e9 df f7 ff ff       	jmp    801058ba <alltraps>

801060db <vector68>:
801060db:	6a 00                	push   $0x0
801060dd:	6a 44                	push   $0x44
801060df:	e9 d6 f7 ff ff       	jmp    801058ba <alltraps>

801060e4 <vector69>:
801060e4:	6a 00                	push   $0x0
801060e6:	6a 45                	push   $0x45
801060e8:	e9 cd f7 ff ff       	jmp    801058ba <alltraps>

801060ed <vector70>:
801060ed:	6a 00                	push   $0x0
801060ef:	6a 46                	push   $0x46
801060f1:	e9 c4 f7 ff ff       	jmp    801058ba <alltraps>

801060f6 <vector71>:
801060f6:	6a 00                	push   $0x0
801060f8:	6a 47                	push   $0x47
801060fa:	e9 bb f7 ff ff       	jmp    801058ba <alltraps>

801060ff <vector72>:
801060ff:	6a 00                	push   $0x0
80106101:	6a 48                	push   $0x48
80106103:	e9 b2 f7 ff ff       	jmp    801058ba <alltraps>

80106108 <vector73>:
80106108:	6a 00                	push   $0x0
8010610a:	6a 49                	push   $0x49
8010610c:	e9 a9 f7 ff ff       	jmp    801058ba <alltraps>

80106111 <vector74>:
80106111:	6a 00                	push   $0x0
80106113:	6a 4a                	push   $0x4a
80106115:	e9 a0 f7 ff ff       	jmp    801058ba <alltraps>

8010611a <vector75>:
8010611a:	6a 00                	push   $0x0
8010611c:	6a 4b                	push   $0x4b
8010611e:	e9 97 f7 ff ff       	jmp    801058ba <alltraps>

80106123 <vector76>:
80106123:	6a 00                	push   $0x0
80106125:	6a 4c                	push   $0x4c
80106127:	e9 8e f7 ff ff       	jmp    801058ba <alltraps>

8010612c <vector77>:
8010612c:	6a 00                	push   $0x0
8010612e:	6a 4d                	push   $0x4d
80106130:	e9 85 f7 ff ff       	jmp    801058ba <alltraps>

80106135 <vector78>:
80106135:	6a 00                	push   $0x0
80106137:	6a 4e                	push   $0x4e
80106139:	e9 7c f7 ff ff       	jmp    801058ba <alltraps>

8010613e <vector79>:
8010613e:	6a 00                	push   $0x0
80106140:	6a 4f                	push   $0x4f
80106142:	e9 73 f7 ff ff       	jmp    801058ba <alltraps>

80106147 <vector80>:
80106147:	6a 00                	push   $0x0
80106149:	6a 50                	push   $0x50
8010614b:	e9 6a f7 ff ff       	jmp    801058ba <alltraps>

80106150 <vector81>:
80106150:	6a 00                	push   $0x0
80106152:	6a 51                	push   $0x51
80106154:	e9 61 f7 ff ff       	jmp    801058ba <alltraps>

80106159 <vector82>:
80106159:	6a 00                	push   $0x0
8010615b:	6a 52                	push   $0x52
8010615d:	e9 58 f7 ff ff       	jmp    801058ba <alltraps>

80106162 <vector83>:
80106162:	6a 00                	push   $0x0
80106164:	6a 53                	push   $0x53
80106166:	e9 4f f7 ff ff       	jmp    801058ba <alltraps>

8010616b <vector84>:
8010616b:	6a 00                	push   $0x0
8010616d:	6a 54                	push   $0x54
8010616f:	e9 46 f7 ff ff       	jmp    801058ba <alltraps>

80106174 <vector85>:
80106174:	6a 00                	push   $0x0
80106176:	6a 55                	push   $0x55
80106178:	e9 3d f7 ff ff       	jmp    801058ba <alltraps>

8010617d <vector86>:
8010617d:	6a 00                	push   $0x0
8010617f:	6a 56                	push   $0x56
80106181:	e9 34 f7 ff ff       	jmp    801058ba <alltraps>

80106186 <vector87>:
80106186:	6a 00                	push   $0x0
80106188:	6a 57                	push   $0x57
8010618a:	e9 2b f7 ff ff       	jmp    801058ba <alltraps>

8010618f <vector88>:
8010618f:	6a 00                	push   $0x0
80106191:	6a 58                	push   $0x58
80106193:	e9 22 f7 ff ff       	jmp    801058ba <alltraps>

80106198 <vector89>:
80106198:	6a 00                	push   $0x0
8010619a:	6a 59                	push   $0x59
8010619c:	e9 19 f7 ff ff       	jmp    801058ba <alltraps>

801061a1 <vector90>:
801061a1:	6a 00                	push   $0x0
801061a3:	6a 5a                	push   $0x5a
801061a5:	e9 10 f7 ff ff       	jmp    801058ba <alltraps>

801061aa <vector91>:
801061aa:	6a 00                	push   $0x0
801061ac:	6a 5b                	push   $0x5b
801061ae:	e9 07 f7 ff ff       	jmp    801058ba <alltraps>

801061b3 <vector92>:
801061b3:	6a 00                	push   $0x0
801061b5:	6a 5c                	push   $0x5c
801061b7:	e9 fe f6 ff ff       	jmp    801058ba <alltraps>

801061bc <vector93>:
801061bc:	6a 00                	push   $0x0
801061be:	6a 5d                	push   $0x5d
801061c0:	e9 f5 f6 ff ff       	jmp    801058ba <alltraps>

801061c5 <vector94>:
801061c5:	6a 00                	push   $0x0
801061c7:	6a 5e                	push   $0x5e
801061c9:	e9 ec f6 ff ff       	jmp    801058ba <alltraps>

801061ce <vector95>:
801061ce:	6a 00                	push   $0x0
801061d0:	6a 5f                	push   $0x5f
801061d2:	e9 e3 f6 ff ff       	jmp    801058ba <alltraps>

801061d7 <vector96>:
801061d7:	6a 00                	push   $0x0
801061d9:	6a 60                	push   $0x60
801061db:	e9 da f6 ff ff       	jmp    801058ba <alltraps>

801061e0 <vector97>:
801061e0:	6a 00                	push   $0x0
801061e2:	6a 61                	push   $0x61
801061e4:	e9 d1 f6 ff ff       	jmp    801058ba <alltraps>

801061e9 <vector98>:
801061e9:	6a 00                	push   $0x0
801061eb:	6a 62                	push   $0x62
801061ed:	e9 c8 f6 ff ff       	jmp    801058ba <alltraps>

801061f2 <vector99>:
801061f2:	6a 00                	push   $0x0
801061f4:	6a 63                	push   $0x63
801061f6:	e9 bf f6 ff ff       	jmp    801058ba <alltraps>

801061fb <vector100>:
801061fb:	6a 00                	push   $0x0
801061fd:	6a 64                	push   $0x64
801061ff:	e9 b6 f6 ff ff       	jmp    801058ba <alltraps>

80106204 <vector101>:
80106204:	6a 00                	push   $0x0
80106206:	6a 65                	push   $0x65
80106208:	e9 ad f6 ff ff       	jmp    801058ba <alltraps>

8010620d <vector102>:
8010620d:	6a 00                	push   $0x0
8010620f:	6a 66                	push   $0x66
80106211:	e9 a4 f6 ff ff       	jmp    801058ba <alltraps>

80106216 <vector103>:
80106216:	6a 00                	push   $0x0
80106218:	6a 67                	push   $0x67
8010621a:	e9 9b f6 ff ff       	jmp    801058ba <alltraps>

8010621f <vector104>:
8010621f:	6a 00                	push   $0x0
80106221:	6a 68                	push   $0x68
80106223:	e9 92 f6 ff ff       	jmp    801058ba <alltraps>

80106228 <vector105>:
80106228:	6a 00                	push   $0x0
8010622a:	6a 69                	push   $0x69
8010622c:	e9 89 f6 ff ff       	jmp    801058ba <alltraps>

80106231 <vector106>:
80106231:	6a 00                	push   $0x0
80106233:	6a 6a                	push   $0x6a
80106235:	e9 80 f6 ff ff       	jmp    801058ba <alltraps>

8010623a <vector107>:
8010623a:	6a 00                	push   $0x0
8010623c:	6a 6b                	push   $0x6b
8010623e:	e9 77 f6 ff ff       	jmp    801058ba <alltraps>

80106243 <vector108>:
80106243:	6a 00                	push   $0x0
80106245:	6a 6c                	push   $0x6c
80106247:	e9 6e f6 ff ff       	jmp    801058ba <alltraps>

8010624c <vector109>:
8010624c:	6a 00                	push   $0x0
8010624e:	6a 6d                	push   $0x6d
80106250:	e9 65 f6 ff ff       	jmp    801058ba <alltraps>

80106255 <vector110>:
80106255:	6a 00                	push   $0x0
80106257:	6a 6e                	push   $0x6e
80106259:	e9 5c f6 ff ff       	jmp    801058ba <alltraps>

8010625e <vector111>:
8010625e:	6a 00                	push   $0x0
80106260:	6a 6f                	push   $0x6f
80106262:	e9 53 f6 ff ff       	jmp    801058ba <alltraps>

80106267 <vector112>:
80106267:	6a 00                	push   $0x0
80106269:	6a 70                	push   $0x70
8010626b:	e9 4a f6 ff ff       	jmp    801058ba <alltraps>

80106270 <vector113>:
80106270:	6a 00                	push   $0x0
80106272:	6a 71                	push   $0x71
80106274:	e9 41 f6 ff ff       	jmp    801058ba <alltraps>

80106279 <vector114>:
80106279:	6a 00                	push   $0x0
8010627b:	6a 72                	push   $0x72
8010627d:	e9 38 f6 ff ff       	jmp    801058ba <alltraps>

80106282 <vector115>:
80106282:	6a 00                	push   $0x0
80106284:	6a 73                	push   $0x73
80106286:	e9 2f f6 ff ff       	jmp    801058ba <alltraps>

8010628b <vector116>:
8010628b:	6a 00                	push   $0x0
8010628d:	6a 74                	push   $0x74
8010628f:	e9 26 f6 ff ff       	jmp    801058ba <alltraps>

80106294 <vector117>:
80106294:	6a 00                	push   $0x0
80106296:	6a 75                	push   $0x75
80106298:	e9 1d f6 ff ff       	jmp    801058ba <alltraps>

8010629d <vector118>:
8010629d:	6a 00                	push   $0x0
8010629f:	6a 76                	push   $0x76
801062a1:	e9 14 f6 ff ff       	jmp    801058ba <alltraps>

801062a6 <vector119>:
801062a6:	6a 00                	push   $0x0
801062a8:	6a 77                	push   $0x77
801062aa:	e9 0b f6 ff ff       	jmp    801058ba <alltraps>

801062af <vector120>:
801062af:	6a 00                	push   $0x0
801062b1:	6a 78                	push   $0x78
801062b3:	e9 02 f6 ff ff       	jmp    801058ba <alltraps>

801062b8 <vector121>:
801062b8:	6a 00                	push   $0x0
801062ba:	6a 79                	push   $0x79
801062bc:	e9 f9 f5 ff ff       	jmp    801058ba <alltraps>

801062c1 <vector122>:
801062c1:	6a 00                	push   $0x0
801062c3:	6a 7a                	push   $0x7a
801062c5:	e9 f0 f5 ff ff       	jmp    801058ba <alltraps>

801062ca <vector123>:
801062ca:	6a 00                	push   $0x0
801062cc:	6a 7b                	push   $0x7b
801062ce:	e9 e7 f5 ff ff       	jmp    801058ba <alltraps>

801062d3 <vector124>:
801062d3:	6a 00                	push   $0x0
801062d5:	6a 7c                	push   $0x7c
801062d7:	e9 de f5 ff ff       	jmp    801058ba <alltraps>

801062dc <vector125>:
801062dc:	6a 00                	push   $0x0
801062de:	6a 7d                	push   $0x7d
801062e0:	e9 d5 f5 ff ff       	jmp    801058ba <alltraps>

801062e5 <vector126>:
801062e5:	6a 00                	push   $0x0
801062e7:	6a 7e                	push   $0x7e
801062e9:	e9 cc f5 ff ff       	jmp    801058ba <alltraps>

801062ee <vector127>:
801062ee:	6a 00                	push   $0x0
801062f0:	6a 7f                	push   $0x7f
801062f2:	e9 c3 f5 ff ff       	jmp    801058ba <alltraps>

801062f7 <vector128>:
801062f7:	6a 00                	push   $0x0
801062f9:	68 80 00 00 00       	push   $0x80
801062fe:	e9 b7 f5 ff ff       	jmp    801058ba <alltraps>

80106303 <vector129>:
80106303:	6a 00                	push   $0x0
80106305:	68 81 00 00 00       	push   $0x81
8010630a:	e9 ab f5 ff ff       	jmp    801058ba <alltraps>

8010630f <vector130>:
8010630f:	6a 00                	push   $0x0
80106311:	68 82 00 00 00       	push   $0x82
80106316:	e9 9f f5 ff ff       	jmp    801058ba <alltraps>

8010631b <vector131>:
8010631b:	6a 00                	push   $0x0
8010631d:	68 83 00 00 00       	push   $0x83
80106322:	e9 93 f5 ff ff       	jmp    801058ba <alltraps>

80106327 <vector132>:
80106327:	6a 00                	push   $0x0
80106329:	68 84 00 00 00       	push   $0x84
8010632e:	e9 87 f5 ff ff       	jmp    801058ba <alltraps>

80106333 <vector133>:
80106333:	6a 00                	push   $0x0
80106335:	68 85 00 00 00       	push   $0x85
8010633a:	e9 7b f5 ff ff       	jmp    801058ba <alltraps>

8010633f <vector134>:
8010633f:	6a 00                	push   $0x0
80106341:	68 86 00 00 00       	push   $0x86
80106346:	e9 6f f5 ff ff       	jmp    801058ba <alltraps>

8010634b <vector135>:
8010634b:	6a 00                	push   $0x0
8010634d:	68 87 00 00 00       	push   $0x87
80106352:	e9 63 f5 ff ff       	jmp    801058ba <alltraps>

80106357 <vector136>:
80106357:	6a 00                	push   $0x0
80106359:	68 88 00 00 00       	push   $0x88
8010635e:	e9 57 f5 ff ff       	jmp    801058ba <alltraps>

80106363 <vector137>:
80106363:	6a 00                	push   $0x0
80106365:	68 89 00 00 00       	push   $0x89
8010636a:	e9 4b f5 ff ff       	jmp    801058ba <alltraps>

8010636f <vector138>:
8010636f:	6a 00                	push   $0x0
80106371:	68 8a 00 00 00       	push   $0x8a
80106376:	e9 3f f5 ff ff       	jmp    801058ba <alltraps>

8010637b <vector139>:
8010637b:	6a 00                	push   $0x0
8010637d:	68 8b 00 00 00       	push   $0x8b
80106382:	e9 33 f5 ff ff       	jmp    801058ba <alltraps>

80106387 <vector140>:
80106387:	6a 00                	push   $0x0
80106389:	68 8c 00 00 00       	push   $0x8c
8010638e:	e9 27 f5 ff ff       	jmp    801058ba <alltraps>

80106393 <vector141>:
80106393:	6a 00                	push   $0x0
80106395:	68 8d 00 00 00       	push   $0x8d
8010639a:	e9 1b f5 ff ff       	jmp    801058ba <alltraps>

8010639f <vector142>:
8010639f:	6a 00                	push   $0x0
801063a1:	68 8e 00 00 00       	push   $0x8e
801063a6:	e9 0f f5 ff ff       	jmp    801058ba <alltraps>

801063ab <vector143>:
801063ab:	6a 00                	push   $0x0
801063ad:	68 8f 00 00 00       	push   $0x8f
801063b2:	e9 03 f5 ff ff       	jmp    801058ba <alltraps>

801063b7 <vector144>:
801063b7:	6a 00                	push   $0x0
801063b9:	68 90 00 00 00       	push   $0x90
801063be:	e9 f7 f4 ff ff       	jmp    801058ba <alltraps>

801063c3 <vector145>:
801063c3:	6a 00                	push   $0x0
801063c5:	68 91 00 00 00       	push   $0x91
801063ca:	e9 eb f4 ff ff       	jmp    801058ba <alltraps>

801063cf <vector146>:
801063cf:	6a 00                	push   $0x0
801063d1:	68 92 00 00 00       	push   $0x92
801063d6:	e9 df f4 ff ff       	jmp    801058ba <alltraps>

801063db <vector147>:
801063db:	6a 00                	push   $0x0
801063dd:	68 93 00 00 00       	push   $0x93
801063e2:	e9 d3 f4 ff ff       	jmp    801058ba <alltraps>

801063e7 <vector148>:
801063e7:	6a 00                	push   $0x0
801063e9:	68 94 00 00 00       	push   $0x94
801063ee:	e9 c7 f4 ff ff       	jmp    801058ba <alltraps>

801063f3 <vector149>:
801063f3:	6a 00                	push   $0x0
801063f5:	68 95 00 00 00       	push   $0x95
801063fa:	e9 bb f4 ff ff       	jmp    801058ba <alltraps>

801063ff <vector150>:
801063ff:	6a 00                	push   $0x0
80106401:	68 96 00 00 00       	push   $0x96
80106406:	e9 af f4 ff ff       	jmp    801058ba <alltraps>

8010640b <vector151>:
8010640b:	6a 00                	push   $0x0
8010640d:	68 97 00 00 00       	push   $0x97
80106412:	e9 a3 f4 ff ff       	jmp    801058ba <alltraps>

80106417 <vector152>:
80106417:	6a 00                	push   $0x0
80106419:	68 98 00 00 00       	push   $0x98
8010641e:	e9 97 f4 ff ff       	jmp    801058ba <alltraps>

80106423 <vector153>:
80106423:	6a 00                	push   $0x0
80106425:	68 99 00 00 00       	push   $0x99
8010642a:	e9 8b f4 ff ff       	jmp    801058ba <alltraps>

8010642f <vector154>:
8010642f:	6a 00                	push   $0x0
80106431:	68 9a 00 00 00       	push   $0x9a
80106436:	e9 7f f4 ff ff       	jmp    801058ba <alltraps>

8010643b <vector155>:
8010643b:	6a 00                	push   $0x0
8010643d:	68 9b 00 00 00       	push   $0x9b
80106442:	e9 73 f4 ff ff       	jmp    801058ba <alltraps>

80106447 <vector156>:
80106447:	6a 00                	push   $0x0
80106449:	68 9c 00 00 00       	push   $0x9c
8010644e:	e9 67 f4 ff ff       	jmp    801058ba <alltraps>

80106453 <vector157>:
80106453:	6a 00                	push   $0x0
80106455:	68 9d 00 00 00       	push   $0x9d
8010645a:	e9 5b f4 ff ff       	jmp    801058ba <alltraps>

8010645f <vector158>:
8010645f:	6a 00                	push   $0x0
80106461:	68 9e 00 00 00       	push   $0x9e
80106466:	e9 4f f4 ff ff       	jmp    801058ba <alltraps>

8010646b <vector159>:
8010646b:	6a 00                	push   $0x0
8010646d:	68 9f 00 00 00       	push   $0x9f
80106472:	e9 43 f4 ff ff       	jmp    801058ba <alltraps>

80106477 <vector160>:
80106477:	6a 00                	push   $0x0
80106479:	68 a0 00 00 00       	push   $0xa0
8010647e:	e9 37 f4 ff ff       	jmp    801058ba <alltraps>

80106483 <vector161>:
80106483:	6a 00                	push   $0x0
80106485:	68 a1 00 00 00       	push   $0xa1
8010648a:	e9 2b f4 ff ff       	jmp    801058ba <alltraps>

8010648f <vector162>:
8010648f:	6a 00                	push   $0x0
80106491:	68 a2 00 00 00       	push   $0xa2
80106496:	e9 1f f4 ff ff       	jmp    801058ba <alltraps>

8010649b <vector163>:
8010649b:	6a 00                	push   $0x0
8010649d:	68 a3 00 00 00       	push   $0xa3
801064a2:	e9 13 f4 ff ff       	jmp    801058ba <alltraps>

801064a7 <vector164>:
801064a7:	6a 00                	push   $0x0
801064a9:	68 a4 00 00 00       	push   $0xa4
801064ae:	e9 07 f4 ff ff       	jmp    801058ba <alltraps>

801064b3 <vector165>:
801064b3:	6a 00                	push   $0x0
801064b5:	68 a5 00 00 00       	push   $0xa5
801064ba:	e9 fb f3 ff ff       	jmp    801058ba <alltraps>

801064bf <vector166>:
801064bf:	6a 00                	push   $0x0
801064c1:	68 a6 00 00 00       	push   $0xa6
801064c6:	e9 ef f3 ff ff       	jmp    801058ba <alltraps>

801064cb <vector167>:
801064cb:	6a 00                	push   $0x0
801064cd:	68 a7 00 00 00       	push   $0xa7
801064d2:	e9 e3 f3 ff ff       	jmp    801058ba <alltraps>

801064d7 <vector168>:
801064d7:	6a 00                	push   $0x0
801064d9:	68 a8 00 00 00       	push   $0xa8
801064de:	e9 d7 f3 ff ff       	jmp    801058ba <alltraps>

801064e3 <vector169>:
801064e3:	6a 00                	push   $0x0
801064e5:	68 a9 00 00 00       	push   $0xa9
801064ea:	e9 cb f3 ff ff       	jmp    801058ba <alltraps>

801064ef <vector170>:
801064ef:	6a 00                	push   $0x0
801064f1:	68 aa 00 00 00       	push   $0xaa
801064f6:	e9 bf f3 ff ff       	jmp    801058ba <alltraps>

801064fb <vector171>:
801064fb:	6a 00                	push   $0x0
801064fd:	68 ab 00 00 00       	push   $0xab
80106502:	e9 b3 f3 ff ff       	jmp    801058ba <alltraps>

80106507 <vector172>:
80106507:	6a 00                	push   $0x0
80106509:	68 ac 00 00 00       	push   $0xac
8010650e:	e9 a7 f3 ff ff       	jmp    801058ba <alltraps>

80106513 <vector173>:
80106513:	6a 00                	push   $0x0
80106515:	68 ad 00 00 00       	push   $0xad
8010651a:	e9 9b f3 ff ff       	jmp    801058ba <alltraps>

8010651f <vector174>:
8010651f:	6a 00                	push   $0x0
80106521:	68 ae 00 00 00       	push   $0xae
80106526:	e9 8f f3 ff ff       	jmp    801058ba <alltraps>

8010652b <vector175>:
8010652b:	6a 00                	push   $0x0
8010652d:	68 af 00 00 00       	push   $0xaf
80106532:	e9 83 f3 ff ff       	jmp    801058ba <alltraps>

80106537 <vector176>:
80106537:	6a 00                	push   $0x0
80106539:	68 b0 00 00 00       	push   $0xb0
8010653e:	e9 77 f3 ff ff       	jmp    801058ba <alltraps>

80106543 <vector177>:
80106543:	6a 00                	push   $0x0
80106545:	68 b1 00 00 00       	push   $0xb1
8010654a:	e9 6b f3 ff ff       	jmp    801058ba <alltraps>

8010654f <vector178>:
8010654f:	6a 00                	push   $0x0
80106551:	68 b2 00 00 00       	push   $0xb2
80106556:	e9 5f f3 ff ff       	jmp    801058ba <alltraps>

8010655b <vector179>:
8010655b:	6a 00                	push   $0x0
8010655d:	68 b3 00 00 00       	push   $0xb3
80106562:	e9 53 f3 ff ff       	jmp    801058ba <alltraps>

80106567 <vector180>:
80106567:	6a 00                	push   $0x0
80106569:	68 b4 00 00 00       	push   $0xb4
8010656e:	e9 47 f3 ff ff       	jmp    801058ba <alltraps>

80106573 <vector181>:
80106573:	6a 00                	push   $0x0
80106575:	68 b5 00 00 00       	push   $0xb5
8010657a:	e9 3b f3 ff ff       	jmp    801058ba <alltraps>

8010657f <vector182>:
8010657f:	6a 00                	push   $0x0
80106581:	68 b6 00 00 00       	push   $0xb6
80106586:	e9 2f f3 ff ff       	jmp    801058ba <alltraps>

8010658b <vector183>:
8010658b:	6a 00                	push   $0x0
8010658d:	68 b7 00 00 00       	push   $0xb7
80106592:	e9 23 f3 ff ff       	jmp    801058ba <alltraps>

80106597 <vector184>:
80106597:	6a 00                	push   $0x0
80106599:	68 b8 00 00 00       	push   $0xb8
8010659e:	e9 17 f3 ff ff       	jmp    801058ba <alltraps>

801065a3 <vector185>:
801065a3:	6a 00                	push   $0x0
801065a5:	68 b9 00 00 00       	push   $0xb9
801065aa:	e9 0b f3 ff ff       	jmp    801058ba <alltraps>

801065af <vector186>:
801065af:	6a 00                	push   $0x0
801065b1:	68 ba 00 00 00       	push   $0xba
801065b6:	e9 ff f2 ff ff       	jmp    801058ba <alltraps>

801065bb <vector187>:
801065bb:	6a 00                	push   $0x0
801065bd:	68 bb 00 00 00       	push   $0xbb
801065c2:	e9 f3 f2 ff ff       	jmp    801058ba <alltraps>

801065c7 <vector188>:
801065c7:	6a 00                	push   $0x0
801065c9:	68 bc 00 00 00       	push   $0xbc
801065ce:	e9 e7 f2 ff ff       	jmp    801058ba <alltraps>

801065d3 <vector189>:
801065d3:	6a 00                	push   $0x0
801065d5:	68 bd 00 00 00       	push   $0xbd
801065da:	e9 db f2 ff ff       	jmp    801058ba <alltraps>

801065df <vector190>:
801065df:	6a 00                	push   $0x0
801065e1:	68 be 00 00 00       	push   $0xbe
801065e6:	e9 cf f2 ff ff       	jmp    801058ba <alltraps>

801065eb <vector191>:
801065eb:	6a 00                	push   $0x0
801065ed:	68 bf 00 00 00       	push   $0xbf
801065f2:	e9 c3 f2 ff ff       	jmp    801058ba <alltraps>

801065f7 <vector192>:
801065f7:	6a 00                	push   $0x0
801065f9:	68 c0 00 00 00       	push   $0xc0
801065fe:	e9 b7 f2 ff ff       	jmp    801058ba <alltraps>

80106603 <vector193>:
80106603:	6a 00                	push   $0x0
80106605:	68 c1 00 00 00       	push   $0xc1
8010660a:	e9 ab f2 ff ff       	jmp    801058ba <alltraps>

8010660f <vector194>:
8010660f:	6a 00                	push   $0x0
80106611:	68 c2 00 00 00       	push   $0xc2
80106616:	e9 9f f2 ff ff       	jmp    801058ba <alltraps>

8010661b <vector195>:
8010661b:	6a 00                	push   $0x0
8010661d:	68 c3 00 00 00       	push   $0xc3
80106622:	e9 93 f2 ff ff       	jmp    801058ba <alltraps>

80106627 <vector196>:
80106627:	6a 00                	push   $0x0
80106629:	68 c4 00 00 00       	push   $0xc4
8010662e:	e9 87 f2 ff ff       	jmp    801058ba <alltraps>

80106633 <vector197>:
80106633:	6a 00                	push   $0x0
80106635:	68 c5 00 00 00       	push   $0xc5
8010663a:	e9 7b f2 ff ff       	jmp    801058ba <alltraps>

8010663f <vector198>:
8010663f:	6a 00                	push   $0x0
80106641:	68 c6 00 00 00       	push   $0xc6
80106646:	e9 6f f2 ff ff       	jmp    801058ba <alltraps>

8010664b <vector199>:
8010664b:	6a 00                	push   $0x0
8010664d:	68 c7 00 00 00       	push   $0xc7
80106652:	e9 63 f2 ff ff       	jmp    801058ba <alltraps>

80106657 <vector200>:
80106657:	6a 00                	push   $0x0
80106659:	68 c8 00 00 00       	push   $0xc8
8010665e:	e9 57 f2 ff ff       	jmp    801058ba <alltraps>

80106663 <vector201>:
80106663:	6a 00                	push   $0x0
80106665:	68 c9 00 00 00       	push   $0xc9
8010666a:	e9 4b f2 ff ff       	jmp    801058ba <alltraps>

8010666f <vector202>:
8010666f:	6a 00                	push   $0x0
80106671:	68 ca 00 00 00       	push   $0xca
80106676:	e9 3f f2 ff ff       	jmp    801058ba <alltraps>

8010667b <vector203>:
8010667b:	6a 00                	push   $0x0
8010667d:	68 cb 00 00 00       	push   $0xcb
80106682:	e9 33 f2 ff ff       	jmp    801058ba <alltraps>

80106687 <vector204>:
80106687:	6a 00                	push   $0x0
80106689:	68 cc 00 00 00       	push   $0xcc
8010668e:	e9 27 f2 ff ff       	jmp    801058ba <alltraps>

80106693 <vector205>:
80106693:	6a 00                	push   $0x0
80106695:	68 cd 00 00 00       	push   $0xcd
8010669a:	e9 1b f2 ff ff       	jmp    801058ba <alltraps>

8010669f <vector206>:
8010669f:	6a 00                	push   $0x0
801066a1:	68 ce 00 00 00       	push   $0xce
801066a6:	e9 0f f2 ff ff       	jmp    801058ba <alltraps>

801066ab <vector207>:
801066ab:	6a 00                	push   $0x0
801066ad:	68 cf 00 00 00       	push   $0xcf
801066b2:	e9 03 f2 ff ff       	jmp    801058ba <alltraps>

801066b7 <vector208>:
801066b7:	6a 00                	push   $0x0
801066b9:	68 d0 00 00 00       	push   $0xd0
801066be:	e9 f7 f1 ff ff       	jmp    801058ba <alltraps>

801066c3 <vector209>:
801066c3:	6a 00                	push   $0x0
801066c5:	68 d1 00 00 00       	push   $0xd1
801066ca:	e9 eb f1 ff ff       	jmp    801058ba <alltraps>

801066cf <vector210>:
801066cf:	6a 00                	push   $0x0
801066d1:	68 d2 00 00 00       	push   $0xd2
801066d6:	e9 df f1 ff ff       	jmp    801058ba <alltraps>

801066db <vector211>:
801066db:	6a 00                	push   $0x0
801066dd:	68 d3 00 00 00       	push   $0xd3
801066e2:	e9 d3 f1 ff ff       	jmp    801058ba <alltraps>

801066e7 <vector212>:
801066e7:	6a 00                	push   $0x0
801066e9:	68 d4 00 00 00       	push   $0xd4
801066ee:	e9 c7 f1 ff ff       	jmp    801058ba <alltraps>

801066f3 <vector213>:
801066f3:	6a 00                	push   $0x0
801066f5:	68 d5 00 00 00       	push   $0xd5
801066fa:	e9 bb f1 ff ff       	jmp    801058ba <alltraps>

801066ff <vector214>:
801066ff:	6a 00                	push   $0x0
80106701:	68 d6 00 00 00       	push   $0xd6
80106706:	e9 af f1 ff ff       	jmp    801058ba <alltraps>

8010670b <vector215>:
8010670b:	6a 00                	push   $0x0
8010670d:	68 d7 00 00 00       	push   $0xd7
80106712:	e9 a3 f1 ff ff       	jmp    801058ba <alltraps>

80106717 <vector216>:
80106717:	6a 00                	push   $0x0
80106719:	68 d8 00 00 00       	push   $0xd8
8010671e:	e9 97 f1 ff ff       	jmp    801058ba <alltraps>

80106723 <vector217>:
80106723:	6a 00                	push   $0x0
80106725:	68 d9 00 00 00       	push   $0xd9
8010672a:	e9 8b f1 ff ff       	jmp    801058ba <alltraps>

8010672f <vector218>:
8010672f:	6a 00                	push   $0x0
80106731:	68 da 00 00 00       	push   $0xda
80106736:	e9 7f f1 ff ff       	jmp    801058ba <alltraps>

8010673b <vector219>:
8010673b:	6a 00                	push   $0x0
8010673d:	68 db 00 00 00       	push   $0xdb
80106742:	e9 73 f1 ff ff       	jmp    801058ba <alltraps>

80106747 <vector220>:
80106747:	6a 00                	push   $0x0
80106749:	68 dc 00 00 00       	push   $0xdc
8010674e:	e9 67 f1 ff ff       	jmp    801058ba <alltraps>

80106753 <vector221>:
80106753:	6a 00                	push   $0x0
80106755:	68 dd 00 00 00       	push   $0xdd
8010675a:	e9 5b f1 ff ff       	jmp    801058ba <alltraps>

8010675f <vector222>:
8010675f:	6a 00                	push   $0x0
80106761:	68 de 00 00 00       	push   $0xde
80106766:	e9 4f f1 ff ff       	jmp    801058ba <alltraps>

8010676b <vector223>:
8010676b:	6a 00                	push   $0x0
8010676d:	68 df 00 00 00       	push   $0xdf
80106772:	e9 43 f1 ff ff       	jmp    801058ba <alltraps>

80106777 <vector224>:
80106777:	6a 00                	push   $0x0
80106779:	68 e0 00 00 00       	push   $0xe0
8010677e:	e9 37 f1 ff ff       	jmp    801058ba <alltraps>

80106783 <vector225>:
80106783:	6a 00                	push   $0x0
80106785:	68 e1 00 00 00       	push   $0xe1
8010678a:	e9 2b f1 ff ff       	jmp    801058ba <alltraps>

8010678f <vector226>:
8010678f:	6a 00                	push   $0x0
80106791:	68 e2 00 00 00       	push   $0xe2
80106796:	e9 1f f1 ff ff       	jmp    801058ba <alltraps>

8010679b <vector227>:
8010679b:	6a 00                	push   $0x0
8010679d:	68 e3 00 00 00       	push   $0xe3
801067a2:	e9 13 f1 ff ff       	jmp    801058ba <alltraps>

801067a7 <vector228>:
801067a7:	6a 00                	push   $0x0
801067a9:	68 e4 00 00 00       	push   $0xe4
801067ae:	e9 07 f1 ff ff       	jmp    801058ba <alltraps>

801067b3 <vector229>:
801067b3:	6a 00                	push   $0x0
801067b5:	68 e5 00 00 00       	push   $0xe5
801067ba:	e9 fb f0 ff ff       	jmp    801058ba <alltraps>

801067bf <vector230>:
801067bf:	6a 00                	push   $0x0
801067c1:	68 e6 00 00 00       	push   $0xe6
801067c6:	e9 ef f0 ff ff       	jmp    801058ba <alltraps>

801067cb <vector231>:
801067cb:	6a 00                	push   $0x0
801067cd:	68 e7 00 00 00       	push   $0xe7
801067d2:	e9 e3 f0 ff ff       	jmp    801058ba <alltraps>

801067d7 <vector232>:
801067d7:	6a 00                	push   $0x0
801067d9:	68 e8 00 00 00       	push   $0xe8
801067de:	e9 d7 f0 ff ff       	jmp    801058ba <alltraps>

801067e3 <vector233>:
801067e3:	6a 00                	push   $0x0
801067e5:	68 e9 00 00 00       	push   $0xe9
801067ea:	e9 cb f0 ff ff       	jmp    801058ba <alltraps>

801067ef <vector234>:
801067ef:	6a 00                	push   $0x0
801067f1:	68 ea 00 00 00       	push   $0xea
801067f6:	e9 bf f0 ff ff       	jmp    801058ba <alltraps>

801067fb <vector235>:
801067fb:	6a 00                	push   $0x0
801067fd:	68 eb 00 00 00       	push   $0xeb
80106802:	e9 b3 f0 ff ff       	jmp    801058ba <alltraps>

80106807 <vector236>:
80106807:	6a 00                	push   $0x0
80106809:	68 ec 00 00 00       	push   $0xec
8010680e:	e9 a7 f0 ff ff       	jmp    801058ba <alltraps>

80106813 <vector237>:
80106813:	6a 00                	push   $0x0
80106815:	68 ed 00 00 00       	push   $0xed
8010681a:	e9 9b f0 ff ff       	jmp    801058ba <alltraps>

8010681f <vector238>:
8010681f:	6a 00                	push   $0x0
80106821:	68 ee 00 00 00       	push   $0xee
80106826:	e9 8f f0 ff ff       	jmp    801058ba <alltraps>

8010682b <vector239>:
8010682b:	6a 00                	push   $0x0
8010682d:	68 ef 00 00 00       	push   $0xef
80106832:	e9 83 f0 ff ff       	jmp    801058ba <alltraps>

80106837 <vector240>:
80106837:	6a 00                	push   $0x0
80106839:	68 f0 00 00 00       	push   $0xf0
8010683e:	e9 77 f0 ff ff       	jmp    801058ba <alltraps>

80106843 <vector241>:
80106843:	6a 00                	push   $0x0
80106845:	68 f1 00 00 00       	push   $0xf1
8010684a:	e9 6b f0 ff ff       	jmp    801058ba <alltraps>

8010684f <vector242>:
8010684f:	6a 00                	push   $0x0
80106851:	68 f2 00 00 00       	push   $0xf2
80106856:	e9 5f f0 ff ff       	jmp    801058ba <alltraps>

8010685b <vector243>:
8010685b:	6a 00                	push   $0x0
8010685d:	68 f3 00 00 00       	push   $0xf3
80106862:	e9 53 f0 ff ff       	jmp    801058ba <alltraps>

80106867 <vector244>:
80106867:	6a 00                	push   $0x0
80106869:	68 f4 00 00 00       	push   $0xf4
8010686e:	e9 47 f0 ff ff       	jmp    801058ba <alltraps>

80106873 <vector245>:
80106873:	6a 00                	push   $0x0
80106875:	68 f5 00 00 00       	push   $0xf5
8010687a:	e9 3b f0 ff ff       	jmp    801058ba <alltraps>

8010687f <vector246>:
8010687f:	6a 00                	push   $0x0
80106881:	68 f6 00 00 00       	push   $0xf6
80106886:	e9 2f f0 ff ff       	jmp    801058ba <alltraps>

8010688b <vector247>:
8010688b:	6a 00                	push   $0x0
8010688d:	68 f7 00 00 00       	push   $0xf7
80106892:	e9 23 f0 ff ff       	jmp    801058ba <alltraps>

80106897 <vector248>:
80106897:	6a 00                	push   $0x0
80106899:	68 f8 00 00 00       	push   $0xf8
8010689e:	e9 17 f0 ff ff       	jmp    801058ba <alltraps>

801068a3 <vector249>:
801068a3:	6a 00                	push   $0x0
801068a5:	68 f9 00 00 00       	push   $0xf9
801068aa:	e9 0b f0 ff ff       	jmp    801058ba <alltraps>

801068af <vector250>:
801068af:	6a 00                	push   $0x0
801068b1:	68 fa 00 00 00       	push   $0xfa
801068b6:	e9 ff ef ff ff       	jmp    801058ba <alltraps>

801068bb <vector251>:
801068bb:	6a 00                	push   $0x0
801068bd:	68 fb 00 00 00       	push   $0xfb
801068c2:	e9 f3 ef ff ff       	jmp    801058ba <alltraps>

801068c7 <vector252>:
801068c7:	6a 00                	push   $0x0
801068c9:	68 fc 00 00 00       	push   $0xfc
801068ce:	e9 e7 ef ff ff       	jmp    801058ba <alltraps>

801068d3 <vector253>:
801068d3:	6a 00                	push   $0x0
801068d5:	68 fd 00 00 00       	push   $0xfd
801068da:	e9 db ef ff ff       	jmp    801058ba <alltraps>

801068df <vector254>:
801068df:	6a 00                	push   $0x0
801068e1:	68 fe 00 00 00       	push   $0xfe
801068e6:	e9 cf ef ff ff       	jmp    801058ba <alltraps>

801068eb <vector255>:
801068eb:	6a 00                	push   $0x0
801068ed:	68 ff 00 00 00       	push   $0xff
801068f2:	e9 c3 ef ff ff       	jmp    801058ba <alltraps>
801068f7:	66 90                	xchg   %ax,%ax
801068f9:	66 90                	xchg   %ax,%ax
801068fb:	66 90                	xchg   %ax,%ax
801068fd:	66 90                	xchg   %ax,%ax
801068ff:	90                   	nop

80106900 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106900:	55                   	push   %ebp
80106901:	89 e5                	mov    %esp,%ebp
80106903:	57                   	push   %edi
80106904:	56                   	push   %esi
80106905:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106906:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010690c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106912:	83 ec 1c             	sub    $0x1c,%esp
80106915:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106918:	39 d3                	cmp    %edx,%ebx
8010691a:	73 49                	jae    80106965 <deallocuvm.part.0+0x65>
8010691c:	89 c7                	mov    %eax,%edi
8010691e:	eb 0c                	jmp    8010692c <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106920:	83 c0 01             	add    $0x1,%eax
80106923:	c1 e0 16             	shl    $0x16,%eax
80106926:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106928:	39 da                	cmp    %ebx,%edx
8010692a:	76 39                	jbe    80106965 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
8010692c:	89 d8                	mov    %ebx,%eax
8010692e:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80106931:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80106934:	f6 c1 01             	test   $0x1,%cl
80106937:	74 e7                	je     80106920 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80106939:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010693b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106941:	c1 ee 0a             	shr    $0xa,%esi
80106944:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
8010694a:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80106951:	85 f6                	test   %esi,%esi
80106953:	74 cb                	je     80106920 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80106955:	8b 06                	mov    (%esi),%eax
80106957:	a8 01                	test   $0x1,%al
80106959:	75 15                	jne    80106970 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
8010695b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106961:	39 da                	cmp    %ebx,%edx
80106963:	77 c7                	ja     8010692c <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106965:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106968:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010696b:	5b                   	pop    %ebx
8010696c:	5e                   	pop    %esi
8010696d:	5f                   	pop    %edi
8010696e:	5d                   	pop    %ebp
8010696f:	c3                   	ret    
      if(pa == 0)
80106970:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106975:	74 25                	je     8010699c <deallocuvm.part.0+0x9c>
      kfree(v);
80106977:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010697a:	05 00 00 00 80       	add    $0x80000000,%eax
8010697f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106982:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106988:	50                   	push   %eax
80106989:	e8 32 bb ff ff       	call   801024c0 <kfree>
      *pte = 0;
8010698e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80106994:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106997:	83 c4 10             	add    $0x10,%esp
8010699a:	eb 8c                	jmp    80106928 <deallocuvm.part.0+0x28>
        panic("kfree");
8010699c:	83 ec 0c             	sub    $0xc,%esp
8010699f:	68 66 7c 10 80       	push   $0x80107c66
801069a4:	e8 d7 99 ff ff       	call   80100380 <panic>
801069a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801069b0 <seginit>:
{
801069b0:	55                   	push   %ebp
801069b1:	89 e5                	mov    %esp,%ebp
801069b3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801069b6:	e8 f5 cf ff ff       	call   801039b0 <cpuid>
  pd[0] = size-1;
801069bb:	ba 2f 00 00 00       	mov    $0x2f,%edx
801069c0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801069c6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801069ca:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
801069d1:	ff 00 00 
801069d4:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
801069db:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801069de:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
801069e5:	ff 00 00 
801069e8:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
801069ef:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801069f2:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
801069f9:	ff 00 00 
801069fc:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
80106a03:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a06:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
80106a0d:	ff 00 00 
80106a10:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
80106a17:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106a1a:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
80106a1f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106a23:	c1 e8 10             	shr    $0x10,%eax
80106a26:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106a2a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106a2d:	0f 01 10             	lgdtl  (%eax)
}
80106a30:	c9                   	leave  
80106a31:	c3                   	ret    
80106a32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a40 <walkpgdir>:
{
80106a40:	55                   	push   %ebp
80106a41:	89 e5                	mov    %esp,%ebp
80106a43:	57                   	push   %edi
80106a44:	56                   	push   %esi
80106a45:	53                   	push   %ebx
80106a46:	83 ec 0c             	sub    $0xc,%esp
80106a49:	8b 7d 0c             	mov    0xc(%ebp),%edi
  pde = &pgdir[PDX(va)];
80106a4c:	8b 55 08             	mov    0x8(%ebp),%edx
80106a4f:	89 fe                	mov    %edi,%esi
80106a51:	c1 ee 16             	shr    $0x16,%esi
80106a54:	8d 34 b2             	lea    (%edx,%esi,4),%esi
  if(*pde & PTE_P){
80106a57:	8b 1e                	mov    (%esi),%ebx
80106a59:	f6 c3 01             	test   $0x1,%bl
80106a5c:	74 22                	je     80106a80 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106a5e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106a64:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
  return &pgtab[PTX(va)];
80106a6a:	89 f8                	mov    %edi,%eax
}
80106a6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106a6f:	c1 e8 0a             	shr    $0xa,%eax
80106a72:	25 fc 0f 00 00       	and    $0xffc,%eax
80106a77:	01 d8                	add    %ebx,%eax
}
80106a79:	5b                   	pop    %ebx
80106a7a:	5e                   	pop    %esi
80106a7b:	5f                   	pop    %edi
80106a7c:	5d                   	pop    %ebp
80106a7d:	c3                   	ret    
80106a7e:	66 90                	xchg   %ax,%ax
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106a80:	8b 45 10             	mov    0x10(%ebp),%eax
80106a83:	85 c0                	test   %eax,%eax
80106a85:	74 31                	je     80106ab8 <walkpgdir+0x78>
80106a87:	e8 f4 bb ff ff       	call   80102680 <kalloc>
80106a8c:	89 c3                	mov    %eax,%ebx
80106a8e:	85 c0                	test   %eax,%eax
80106a90:	74 26                	je     80106ab8 <walkpgdir+0x78>
    memset(pgtab, 0, PGSIZE);
80106a92:	83 ec 04             	sub    $0x4,%esp
80106a95:	68 00 10 00 00       	push   $0x1000
80106a9a:	6a 00                	push   $0x0
80106a9c:	50                   	push   %eax
80106a9d:	e8 3e dc ff ff       	call   801046e0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106aa2:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106aa8:	83 c4 10             	add    $0x10,%esp
80106aab:	83 c8 07             	or     $0x7,%eax
80106aae:	89 06                	mov    %eax,(%esi)
80106ab0:	eb b8                	jmp    80106a6a <walkpgdir+0x2a>
80106ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80106ab8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106abb:	31 c0                	xor    %eax,%eax
}
80106abd:	5b                   	pop    %ebx
80106abe:	5e                   	pop    %esi
80106abf:	5f                   	pop    %edi
80106ac0:	5d                   	pop    %ebp
80106ac1:	c3                   	ret    
80106ac2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ad0 <mappages>:
{
80106ad0:	55                   	push   %ebp
80106ad1:	89 e5                	mov    %esp,%ebp
80106ad3:	57                   	push   %edi
80106ad4:	56                   	push   %esi
80106ad5:	53                   	push   %ebx
80106ad6:	83 ec 1c             	sub    $0x1c,%esp
80106ad9:	8b 45 0c             	mov    0xc(%ebp),%eax
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106adc:	8b 55 10             	mov    0x10(%ebp),%edx
  a = (char*)PGROUNDDOWN((uint)va);
80106adf:	89 c3                	mov    %eax,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106ae1:	8d 44 10 ff          	lea    -0x1(%eax,%edx,1),%eax
80106ae5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80106aea:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106af0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106af3:	8b 45 14             	mov    0x14(%ebp),%eax
80106af6:	29 d8                	sub    %ebx,%eax
80106af8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106afb:	eb 3a                	jmp    80106b37 <mappages+0x67>
80106afd:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106b00:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106b02:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106b07:	c1 ea 0a             	shr    $0xa,%edx
80106b0a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106b10:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106b17:	85 c0                	test   %eax,%eax
80106b19:	74 75                	je     80106b90 <mappages+0xc0>
    if(*pte & PTE_P)
80106b1b:	f6 00 01             	testb  $0x1,(%eax)
80106b1e:	0f 85 86 00 00 00    	jne    80106baa <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106b24:	0b 75 18             	or     0x18(%ebp),%esi
80106b27:	83 ce 01             	or     $0x1,%esi
80106b2a:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106b2c:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80106b2f:	74 6f                	je     80106ba0 <mappages+0xd0>
    a += PGSIZE;
80106b31:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106b37:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106b3a:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106b3d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80106b40:	89 d8                	mov    %ebx,%eax
80106b42:	c1 e8 16             	shr    $0x16,%eax
80106b45:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106b48:	8b 07                	mov    (%edi),%eax
80106b4a:	a8 01                	test   $0x1,%al
80106b4c:	75 b2                	jne    80106b00 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106b4e:	e8 2d bb ff ff       	call   80102680 <kalloc>
80106b53:	85 c0                	test   %eax,%eax
80106b55:	74 39                	je     80106b90 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106b57:	83 ec 04             	sub    $0x4,%esp
80106b5a:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106b5d:	68 00 10 00 00       	push   $0x1000
80106b62:	6a 00                	push   $0x0
80106b64:	50                   	push   %eax
80106b65:	e8 76 db ff ff       	call   801046e0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106b6a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  return &pgtab[PTX(va)];
80106b6d:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106b70:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106b76:	83 c8 07             	or     $0x7,%eax
80106b79:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106b7b:	89 d8                	mov    %ebx,%eax
80106b7d:	c1 e8 0a             	shr    $0xa,%eax
80106b80:	25 fc 0f 00 00       	and    $0xffc,%eax
80106b85:	01 d0                	add    %edx,%eax
80106b87:	eb 92                	jmp    80106b1b <mappages+0x4b>
80106b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80106b90:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106b93:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b98:	5b                   	pop    %ebx
80106b99:	5e                   	pop    %esi
80106b9a:	5f                   	pop    %edi
80106b9b:	5d                   	pop    %ebp
80106b9c:	c3                   	ret    
80106b9d:	8d 76 00             	lea    0x0(%esi),%esi
80106ba0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106ba3:	31 c0                	xor    %eax,%eax
}
80106ba5:	5b                   	pop    %ebx
80106ba6:	5e                   	pop    %esi
80106ba7:	5f                   	pop    %edi
80106ba8:	5d                   	pop    %ebp
80106ba9:	c3                   	ret    
      panic("remap");
80106baa:	83 ec 0c             	sub    $0xc,%esp
80106bad:	68 40 83 10 80       	push   $0x80108340
80106bb2:	e8 c9 97 ff ff       	call   80100380 <panic>
80106bb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bbe:	66 90                	xchg   %ax,%ax

80106bc0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106bc0:	a1 c4 a6 11 80       	mov    0x8011a6c4,%eax
80106bc5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106bca:	0f 22 d8             	mov    %eax,%cr3
}
80106bcd:	c3                   	ret    
80106bce:	66 90                	xchg   %ax,%ax

80106bd0 <switchuvm>:
{
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	57                   	push   %edi
80106bd4:	56                   	push   %esi
80106bd5:	53                   	push   %ebx
80106bd6:	83 ec 1c             	sub    $0x1c,%esp
80106bd9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106bdc:	85 f6                	test   %esi,%esi
80106bde:	0f 84 cb 00 00 00    	je     80106caf <switchuvm+0xdf>
  if(p->kstack == 0)
80106be4:	8b 46 08             	mov    0x8(%esi),%eax
80106be7:	85 c0                	test   %eax,%eax
80106be9:	0f 84 da 00 00 00    	je     80106cc9 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106bef:	8b 46 04             	mov    0x4(%esi),%eax
80106bf2:	85 c0                	test   %eax,%eax
80106bf4:	0f 84 c2 00 00 00    	je     80106cbc <switchuvm+0xec>
  pushcli();
80106bfa:	e8 d1 d8 ff ff       	call   801044d0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106bff:	e8 4c cd ff ff       	call   80103950 <mycpu>
80106c04:	89 c3                	mov    %eax,%ebx
80106c06:	e8 45 cd ff ff       	call   80103950 <mycpu>
80106c0b:	89 c7                	mov    %eax,%edi
80106c0d:	e8 3e cd ff ff       	call   80103950 <mycpu>
80106c12:	83 c7 08             	add    $0x8,%edi
80106c15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106c18:	e8 33 cd ff ff       	call   80103950 <mycpu>
80106c1d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106c20:	ba 67 00 00 00       	mov    $0x67,%edx
80106c25:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106c2c:	83 c0 08             	add    $0x8,%eax
80106c2f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c36:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106c3b:	83 c1 08             	add    $0x8,%ecx
80106c3e:	c1 e8 18             	shr    $0x18,%eax
80106c41:	c1 e9 10             	shr    $0x10,%ecx
80106c44:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106c4a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106c50:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106c55:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106c5c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106c61:	e8 ea cc ff ff       	call   80103950 <mycpu>
80106c66:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106c6d:	e8 de cc ff ff       	call   80103950 <mycpu>
80106c72:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106c76:	8b 5e 08             	mov    0x8(%esi),%ebx
80106c79:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c7f:	e8 cc cc ff ff       	call   80103950 <mycpu>
80106c84:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c87:	e8 c4 cc ff ff       	call   80103950 <mycpu>
80106c8c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106c90:	b8 28 00 00 00       	mov    $0x28,%eax
80106c95:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106c98:	8b 46 04             	mov    0x4(%esi),%eax
80106c9b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106ca0:	0f 22 d8             	mov    %eax,%cr3
}
80106ca3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ca6:	5b                   	pop    %ebx
80106ca7:	5e                   	pop    %esi
80106ca8:	5f                   	pop    %edi
80106ca9:	5d                   	pop    %ebp
  popcli();
80106caa:	e9 71 d8 ff ff       	jmp    80104520 <popcli>
    panic("switchuvm: no process");
80106caf:	83 ec 0c             	sub    $0xc,%esp
80106cb2:	68 46 83 10 80       	push   $0x80108346
80106cb7:	e8 c4 96 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
80106cbc:	83 ec 0c             	sub    $0xc,%esp
80106cbf:	68 71 83 10 80       	push   $0x80108371
80106cc4:	e8 b7 96 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80106cc9:	83 ec 0c             	sub    $0xc,%esp
80106ccc:	68 5c 83 10 80       	push   $0x8010835c
80106cd1:	e8 aa 96 ff ff       	call   80100380 <panic>
80106cd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cdd:	8d 76 00             	lea    0x0(%esi),%esi

80106ce0 <inituvm>:
{
80106ce0:	55                   	push   %ebp
80106ce1:	89 e5                	mov    %esp,%ebp
80106ce3:	57                   	push   %edi
80106ce4:	56                   	push   %esi
80106ce5:	53                   	push   %ebx
80106ce6:	83 ec 1c             	sub    $0x1c,%esp
80106ce9:	8b 75 10             	mov    0x10(%ebp),%esi
80106cec:	8b 55 08             	mov    0x8(%ebp),%edx
80106cef:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106cf2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106cf8:	77 50                	ja     80106d4a <inituvm+0x6a>
80106cfa:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  mem = kalloc();
80106cfd:	e8 7e b9 ff ff       	call   80102680 <kalloc>
  memset(mem, 0, PGSIZE);
80106d02:	83 ec 04             	sub    $0x4,%esp
80106d05:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106d0a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106d0c:	6a 00                	push   $0x0
80106d0e:	50                   	push   %eax
80106d0f:	e8 cc d9 ff ff       	call   801046e0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106d14:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106d17:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106d1d:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
80106d24:	50                   	push   %eax
80106d25:	68 00 10 00 00       	push   $0x1000
80106d2a:	6a 00                	push   $0x0
80106d2c:	52                   	push   %edx
80106d2d:	e8 9e fd ff ff       	call   80106ad0 <mappages>
  memmove(mem, init, sz);
80106d32:	89 75 10             	mov    %esi,0x10(%ebp)
80106d35:	83 c4 20             	add    $0x20,%esp
80106d38:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106d3b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106d3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d41:	5b                   	pop    %ebx
80106d42:	5e                   	pop    %esi
80106d43:	5f                   	pop    %edi
80106d44:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106d45:	e9 36 da ff ff       	jmp    80104780 <memmove>
    panic("inituvm: more than a page");
80106d4a:	83 ec 0c             	sub    $0xc,%esp
80106d4d:	68 85 83 10 80       	push   $0x80108385
80106d52:	e8 29 96 ff ff       	call   80100380 <panic>
80106d57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d5e:	66 90                	xchg   %ax,%ax

80106d60 <loaduvm>:
{
80106d60:	55                   	push   %ebp
80106d61:	89 e5                	mov    %esp,%ebp
80106d63:	57                   	push   %edi
80106d64:	56                   	push   %esi
80106d65:	53                   	push   %ebx
80106d66:	83 ec 1c             	sub    $0x1c,%esp
80106d69:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d6c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80106d6f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80106d74:	0f 85 bb 00 00 00    	jne    80106e35 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
80106d7a:	01 f0                	add    %esi,%eax
80106d7c:	89 f3                	mov    %esi,%ebx
80106d7e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d81:	8b 45 14             	mov    0x14(%ebp),%eax
80106d84:	01 f0                	add    %esi,%eax
80106d86:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80106d89:	85 f6                	test   %esi,%esi
80106d8b:	0f 84 87 00 00 00    	je     80106e18 <loaduvm+0xb8>
80106d91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80106d98:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
80106d9b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106d9e:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80106da0:	89 c2                	mov    %eax,%edx
80106da2:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106da5:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80106da8:	f6 c2 01             	test   $0x1,%dl
80106dab:	75 13                	jne    80106dc0 <loaduvm+0x60>
      panic("loaduvm: address should exist");
80106dad:	83 ec 0c             	sub    $0xc,%esp
80106db0:	68 9f 83 10 80       	push   $0x8010839f
80106db5:	e8 c6 95 ff ff       	call   80100380 <panic>
80106dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106dc0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106dc3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80106dc9:	25 fc 0f 00 00       	and    $0xffc,%eax
80106dce:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106dd5:	85 c0                	test   %eax,%eax
80106dd7:	74 d4                	je     80106dad <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80106dd9:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106ddb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80106dde:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106de3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106de8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80106dee:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106df1:	29 d9                	sub    %ebx,%ecx
80106df3:	05 00 00 00 80       	add    $0x80000000,%eax
80106df8:	57                   	push   %edi
80106df9:	51                   	push   %ecx
80106dfa:	50                   	push   %eax
80106dfb:	ff 75 10             	push   0x10(%ebp)
80106dfe:	e8 8d ac ff ff       	call   80101a90 <readi>
80106e03:	83 c4 10             	add    $0x10,%esp
80106e06:	39 f8                	cmp    %edi,%eax
80106e08:	75 1e                	jne    80106e28 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106e0a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80106e10:	89 f0                	mov    %esi,%eax
80106e12:	29 d8                	sub    %ebx,%eax
80106e14:	39 c6                	cmp    %eax,%esi
80106e16:	77 80                	ja     80106d98 <loaduvm+0x38>
}
80106e18:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106e1b:	31 c0                	xor    %eax,%eax
}
80106e1d:	5b                   	pop    %ebx
80106e1e:	5e                   	pop    %esi
80106e1f:	5f                   	pop    %edi
80106e20:	5d                   	pop    %ebp
80106e21:	c3                   	ret    
80106e22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e28:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106e2b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e30:	5b                   	pop    %ebx
80106e31:	5e                   	pop    %esi
80106e32:	5f                   	pop    %edi
80106e33:	5d                   	pop    %ebp
80106e34:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80106e35:	83 ec 0c             	sub    $0xc,%esp
80106e38:	68 40 84 10 80       	push   $0x80108440
80106e3d:	e8 3e 95 ff ff       	call   80100380 <panic>
80106e42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106e50 <allocuvm>:
{
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
80106e53:	57                   	push   %edi
80106e54:	56                   	push   %esi
80106e55:	53                   	push   %ebx
80106e56:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106e59:	8b 7d 10             	mov    0x10(%ebp),%edi
80106e5c:	85 ff                	test   %edi,%edi
80106e5e:	0f 88 bc 00 00 00    	js     80106f20 <allocuvm+0xd0>
  if(newsz < oldsz)
80106e64:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106e67:	0f 82 a3 00 00 00    	jb     80106f10 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80106e6d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e70:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80106e76:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80106e7c:	39 75 10             	cmp    %esi,0x10(%ebp)
80106e7f:	0f 86 8e 00 00 00    	jbe    80106f13 <allocuvm+0xc3>
80106e85:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106e88:	8b 7d 08             	mov    0x8(%ebp),%edi
80106e8b:	eb 43                	jmp    80106ed0 <allocuvm+0x80>
80106e8d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106e90:	83 ec 04             	sub    $0x4,%esp
80106e93:	68 00 10 00 00       	push   $0x1000
80106e98:	6a 00                	push   $0x0
80106e9a:	50                   	push   %eax
80106e9b:	e8 40 d8 ff ff       	call   801046e0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106ea0:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106ea6:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
80106ead:	50                   	push   %eax
80106eae:	68 00 10 00 00       	push   $0x1000
80106eb3:	56                   	push   %esi
80106eb4:	57                   	push   %edi
80106eb5:	e8 16 fc ff ff       	call   80106ad0 <mappages>
80106eba:	83 c4 20             	add    $0x20,%esp
80106ebd:	85 c0                	test   %eax,%eax
80106ebf:	78 6f                	js     80106f30 <allocuvm+0xe0>
  for(; a < newsz; a += PGSIZE){
80106ec1:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106ec7:	39 75 10             	cmp    %esi,0x10(%ebp)
80106eca:	0f 86 a0 00 00 00    	jbe    80106f70 <allocuvm+0x120>
    mem = kalloc();
80106ed0:	e8 ab b7 ff ff       	call   80102680 <kalloc>
80106ed5:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106ed7:	85 c0                	test   %eax,%eax
80106ed9:	75 b5                	jne    80106e90 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106edb:	83 ec 0c             	sub    $0xc,%esp
80106ede:	68 bd 83 10 80       	push   $0x801083bd
80106ee3:	e8 b8 97 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80106ee8:	8b 45 0c             	mov    0xc(%ebp),%eax
80106eeb:	83 c4 10             	add    $0x10,%esp
80106eee:	39 45 10             	cmp    %eax,0x10(%ebp)
80106ef1:	74 2d                	je     80106f20 <allocuvm+0xd0>
80106ef3:	8b 55 10             	mov    0x10(%ebp),%edx
80106ef6:	89 c1                	mov    %eax,%ecx
80106ef8:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106efb:	31 ff                	xor    %edi,%edi
80106efd:	e8 fe f9 ff ff       	call   80106900 <deallocuvm.part.0>
}
80106f02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f05:	89 f8                	mov    %edi,%eax
80106f07:	5b                   	pop    %ebx
80106f08:	5e                   	pop    %esi
80106f09:	5f                   	pop    %edi
80106f0a:	5d                   	pop    %ebp
80106f0b:	c3                   	ret    
80106f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80106f10:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106f13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f16:	89 f8                	mov    %edi,%eax
80106f18:	5b                   	pop    %ebx
80106f19:	5e                   	pop    %esi
80106f1a:	5f                   	pop    %edi
80106f1b:	5d                   	pop    %ebp
80106f1c:	c3                   	ret    
80106f1d:	8d 76 00             	lea    0x0(%esi),%esi
80106f20:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106f23:	31 ff                	xor    %edi,%edi
}
80106f25:	5b                   	pop    %ebx
80106f26:	89 f8                	mov    %edi,%eax
80106f28:	5e                   	pop    %esi
80106f29:	5f                   	pop    %edi
80106f2a:	5d                   	pop    %ebp
80106f2b:	c3                   	ret    
80106f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("allocuvm out of memory (2)\n");
80106f30:	83 ec 0c             	sub    $0xc,%esp
80106f33:	68 d5 83 10 80       	push   $0x801083d5
80106f38:	e8 63 97 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80106f3d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f40:	83 c4 10             	add    $0x10,%esp
80106f43:	39 45 10             	cmp    %eax,0x10(%ebp)
80106f46:	74 0d                	je     80106f55 <allocuvm+0x105>
80106f48:	89 c1                	mov    %eax,%ecx
80106f4a:	8b 55 10             	mov    0x10(%ebp),%edx
80106f4d:	8b 45 08             	mov    0x8(%ebp),%eax
80106f50:	e8 ab f9 ff ff       	call   80106900 <deallocuvm.part.0>
      kfree(mem);
80106f55:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106f58:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106f5a:	53                   	push   %ebx
80106f5b:	e8 60 b5 ff ff       	call   801024c0 <kfree>
      return 0;
80106f60:	83 c4 10             	add    $0x10,%esp
}
80106f63:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f66:	89 f8                	mov    %edi,%eax
80106f68:	5b                   	pop    %ebx
80106f69:	5e                   	pop    %esi
80106f6a:	5f                   	pop    %edi
80106f6b:	5d                   	pop    %ebp
80106f6c:	c3                   	ret    
80106f6d:	8d 76 00             	lea    0x0(%esi),%esi
80106f70:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106f73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f76:	5b                   	pop    %ebx
80106f77:	5e                   	pop    %esi
80106f78:	89 f8                	mov    %edi,%eax
80106f7a:	5f                   	pop    %edi
80106f7b:	5d                   	pop    %ebp
80106f7c:	c3                   	ret    
80106f7d:	8d 76 00             	lea    0x0(%esi),%esi

80106f80 <deallocuvm>:
{
80106f80:	55                   	push   %ebp
80106f81:	89 e5                	mov    %esp,%ebp
80106f83:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f86:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106f89:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106f8c:	39 d1                	cmp    %edx,%ecx
80106f8e:	73 10                	jae    80106fa0 <deallocuvm+0x20>
}
80106f90:	5d                   	pop    %ebp
80106f91:	e9 6a f9 ff ff       	jmp    80106900 <deallocuvm.part.0>
80106f96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f9d:	8d 76 00             	lea    0x0(%esi),%esi
80106fa0:	89 d0                	mov    %edx,%eax
80106fa2:	5d                   	pop    %ebp
80106fa3:	c3                   	ret    
80106fa4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106faf:	90                   	nop

80106fb0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106fb0:	55                   	push   %ebp
80106fb1:	89 e5                	mov    %esp,%ebp
80106fb3:	57                   	push   %edi
80106fb4:	56                   	push   %esi
80106fb5:	53                   	push   %ebx
80106fb6:	83 ec 0c             	sub    $0xc,%esp
80106fb9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106fbc:	85 f6                	test   %esi,%esi
80106fbe:	74 59                	je     80107019 <freevm+0x69>
  if(newsz >= oldsz)
80106fc0:	31 c9                	xor    %ecx,%ecx
80106fc2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106fc7:	89 f0                	mov    %esi,%eax
80106fc9:	89 f3                	mov    %esi,%ebx
80106fcb:	e8 30 f9 ff ff       	call   80106900 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106fd0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106fd6:	eb 0f                	jmp    80106fe7 <freevm+0x37>
80106fd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fdf:	90                   	nop
80106fe0:	83 c3 04             	add    $0x4,%ebx
80106fe3:	39 df                	cmp    %ebx,%edi
80106fe5:	74 23                	je     8010700a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106fe7:	8b 03                	mov    (%ebx),%eax
80106fe9:	a8 01                	test   $0x1,%al
80106feb:	74 f3                	je     80106fe0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106fed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106ff2:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106ff5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106ff8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106ffd:	50                   	push   %eax
80106ffe:	e8 bd b4 ff ff       	call   801024c0 <kfree>
80107003:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107006:	39 df                	cmp    %ebx,%edi
80107008:	75 dd                	jne    80106fe7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010700a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010700d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107010:	5b                   	pop    %ebx
80107011:	5e                   	pop    %esi
80107012:	5f                   	pop    %edi
80107013:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107014:	e9 a7 b4 ff ff       	jmp    801024c0 <kfree>
    panic("freevm: no pgdir");
80107019:	83 ec 0c             	sub    $0xc,%esp
8010701c:	68 f1 83 10 80       	push   $0x801083f1
80107021:	e8 5a 93 ff ff       	call   80100380 <panic>
80107026:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010702d:	8d 76 00             	lea    0x0(%esi),%esi

80107030 <setupkvm>:
{
80107030:	55                   	push   %ebp
80107031:	89 e5                	mov    %esp,%ebp
80107033:	56                   	push   %esi
80107034:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107035:	e8 46 b6 ff ff       	call   80102680 <kalloc>
8010703a:	89 c6                	mov    %eax,%esi
8010703c:	85 c0                	test   %eax,%eax
8010703e:	74 42                	je     80107082 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107040:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107043:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107048:	68 00 10 00 00       	push   $0x1000
8010704d:	6a 00                	push   $0x0
8010704f:	50                   	push   %eax
80107050:	e8 8b d6 ff ff       	call   801046e0 <memset>
80107055:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107058:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010705b:	8b 53 08             	mov    0x8(%ebx),%edx
8010705e:	83 ec 0c             	sub    $0xc,%esp
80107061:	ff 73 0c             	push   0xc(%ebx)
80107064:	29 c2                	sub    %eax,%edx
80107066:	50                   	push   %eax
80107067:	52                   	push   %edx
80107068:	ff 33                	push   (%ebx)
8010706a:	56                   	push   %esi
8010706b:	e8 60 fa ff ff       	call   80106ad0 <mappages>
80107070:	83 c4 20             	add    $0x20,%esp
80107073:	85 c0                	test   %eax,%eax
80107075:	78 19                	js     80107090 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107077:	83 c3 10             	add    $0x10,%ebx
8010707a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107080:	75 d6                	jne    80107058 <setupkvm+0x28>
}
80107082:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107085:	89 f0                	mov    %esi,%eax
80107087:	5b                   	pop    %ebx
80107088:	5e                   	pop    %esi
80107089:	5d                   	pop    %ebp
8010708a:	c3                   	ret    
8010708b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010708f:	90                   	nop
      freevm(pgdir);
80107090:	83 ec 0c             	sub    $0xc,%esp
80107093:	56                   	push   %esi
      return 0;
80107094:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107096:	e8 15 ff ff ff       	call   80106fb0 <freevm>
      return 0;
8010709b:	83 c4 10             	add    $0x10,%esp
}
8010709e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801070a1:	89 f0                	mov    %esi,%eax
801070a3:	5b                   	pop    %ebx
801070a4:	5e                   	pop    %esi
801070a5:	5d                   	pop    %ebp
801070a6:	c3                   	ret    
801070a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070ae:	66 90                	xchg   %ax,%ax

801070b0 <kvmalloc>:
{
801070b0:	55                   	push   %ebp
801070b1:	89 e5                	mov    %esp,%ebp
801070b3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801070b6:	e8 75 ff ff ff       	call   80107030 <setupkvm>
801070bb:	a3 c4 a6 11 80       	mov    %eax,0x8011a6c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801070c0:	05 00 00 00 80       	add    $0x80000000,%eax
801070c5:	0f 22 d8             	mov    %eax,%cr3
}
801070c8:	c9                   	leave  
801070c9:	c3                   	ret    
801070ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801070d0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	83 ec 08             	sub    $0x8,%esp
801070d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801070d9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801070dc:	89 c1                	mov    %eax,%ecx
801070de:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801070e1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801070e4:	f6 c2 01             	test   $0x1,%dl
801070e7:	75 17                	jne    80107100 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801070e9:	83 ec 0c             	sub    $0xc,%esp
801070ec:	68 02 84 10 80       	push   $0x80108402
801070f1:	e8 8a 92 ff ff       	call   80100380 <panic>
801070f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070fd:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107100:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107103:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107109:	25 fc 0f 00 00       	and    $0xffc,%eax
8010710e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107115:	85 c0                	test   %eax,%eax
80107117:	74 d0                	je     801070e9 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107119:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010711c:	c9                   	leave  
8010711d:	c3                   	ret    
8010711e:	66 90                	xchg   %ax,%ax

80107120 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107120:	55                   	push   %ebp
80107121:	89 e5                	mov    %esp,%ebp
80107123:	57                   	push   %edi
80107124:	56                   	push   %esi
80107125:	53                   	push   %ebx
80107126:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107129:	e8 02 ff ff ff       	call   80107030 <setupkvm>
8010712e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107131:	85 c0                	test   %eax,%eax
80107133:	0f 84 c0 00 00 00    	je     801071f9 <copyuvm+0xd9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107139:	8b 55 0c             	mov    0xc(%ebp),%edx
8010713c:	85 d2                	test   %edx,%edx
8010713e:	0f 84 b5 00 00 00    	je     801071f9 <copyuvm+0xd9>
80107144:	31 f6                	xor    %esi,%esi
80107146:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010714d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80107150:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107153:	89 f0                	mov    %esi,%eax
80107155:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107158:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010715b:	a8 01                	test   $0x1,%al
8010715d:	75 11                	jne    80107170 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010715f:	83 ec 0c             	sub    $0xc,%esp
80107162:	68 0c 84 10 80       	push   $0x8010840c
80107167:	e8 14 92 ff ff       	call   80100380 <panic>
8010716c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107170:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107172:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107177:	c1 ea 0a             	shr    $0xa,%edx
8010717a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107180:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107187:	85 c0                	test   %eax,%eax
80107189:	74 d4                	je     8010715f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010718b:	8b 38                	mov    (%eax),%edi
8010718d:	f7 c7 01 00 00 00    	test   $0x1,%edi
80107193:	0f 84 9b 00 00 00    	je     80107234 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107199:	89 fb                	mov    %edi,%ebx
    flags = PTE_FLAGS(*pte);
8010719b:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
801071a1:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
801071a4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    if((mem = kalloc()) == 0)
801071aa:	e8 d1 b4 ff ff       	call   80102680 <kalloc>
801071af:	89 c7                	mov    %eax,%edi
801071b1:	85 c0                	test   %eax,%eax
801071b3:	74 5f                	je     80107214 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801071b5:	83 ec 04             	sub    $0x4,%esp
801071b8:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801071be:	68 00 10 00 00       	push   $0x1000
801071c3:	53                   	push   %ebx
801071c4:	50                   	push   %eax
801071c5:	e8 b6 d5 ff ff       	call   80104780 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801071ca:	58                   	pop    %eax
801071cb:	8d 87 00 00 00 80    	lea    -0x80000000(%edi),%eax
801071d1:	ff 75 e4             	push   -0x1c(%ebp)
801071d4:	50                   	push   %eax
801071d5:	68 00 10 00 00       	push   $0x1000
801071da:	56                   	push   %esi
801071db:	ff 75 e0             	push   -0x20(%ebp)
801071de:	e8 ed f8 ff ff       	call   80106ad0 <mappages>
801071e3:	83 c4 20             	add    $0x20,%esp
801071e6:	85 c0                	test   %eax,%eax
801071e8:	78 1e                	js     80107208 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
801071ea:	81 c6 00 10 00 00    	add    $0x1000,%esi
801071f0:	39 75 0c             	cmp    %esi,0xc(%ebp)
801071f3:	0f 87 57 ff ff ff    	ja     80107150 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
801071f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801071fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071ff:	5b                   	pop    %ebx
80107200:	5e                   	pop    %esi
80107201:	5f                   	pop    %edi
80107202:	5d                   	pop    %ebp
80107203:	c3                   	ret    
80107204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107208:	83 ec 0c             	sub    $0xc,%esp
8010720b:	57                   	push   %edi
8010720c:	e8 af b2 ff ff       	call   801024c0 <kfree>
      goto bad;
80107211:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107214:	83 ec 0c             	sub    $0xc,%esp
80107217:	ff 75 e0             	push   -0x20(%ebp)
8010721a:	e8 91 fd ff ff       	call   80106fb0 <freevm>
  return 0;
8010721f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107226:	83 c4 10             	add    $0x10,%esp
}
80107229:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010722c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010722f:	5b                   	pop    %ebx
80107230:	5e                   	pop    %esi
80107231:	5f                   	pop    %edi
80107232:	5d                   	pop    %ebp
80107233:	c3                   	ret    
      panic("copyuvm: page not present");
80107234:	83 ec 0c             	sub    $0xc,%esp
80107237:	68 26 84 10 80       	push   $0x80108426
8010723c:	e8 3f 91 ff ff       	call   80100380 <panic>
80107241:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107248:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010724f:	90                   	nop

80107250 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107250:	55                   	push   %ebp
80107251:	89 e5                	mov    %esp,%ebp
80107253:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107256:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107259:	89 c1                	mov    %eax,%ecx
8010725b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010725e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107261:	f6 c2 01             	test   $0x1,%dl
80107264:	0f 84 00 01 00 00    	je     8010736a <uva2ka.cold>
  return &pgtab[PTX(va)];
8010726a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010726d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107273:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107274:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107279:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80107280:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107282:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107287:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010728a:	05 00 00 00 80       	add    $0x80000000,%eax
8010728f:	83 fa 05             	cmp    $0x5,%edx
80107292:	ba 00 00 00 00       	mov    $0x0,%edx
80107297:	0f 45 c2             	cmovne %edx,%eax
}
8010729a:	c3                   	ret    
8010729b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010729f:	90                   	nop

801072a0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801072a0:	55                   	push   %ebp
801072a1:	89 e5                	mov    %esp,%ebp
801072a3:	57                   	push   %edi
801072a4:	56                   	push   %esi
801072a5:	53                   	push   %ebx
801072a6:	83 ec 0c             	sub    $0xc,%esp
801072a9:	8b 75 14             	mov    0x14(%ebp),%esi
801072ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801072af:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801072b2:	85 f6                	test   %esi,%esi
801072b4:	75 51                	jne    80107307 <copyout+0x67>
801072b6:	e9 a5 00 00 00       	jmp    80107360 <copyout+0xc0>
801072bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801072bf:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
801072c0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801072c6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
801072cc:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801072d2:	74 75                	je     80107349 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
801072d4:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801072d6:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
801072d9:	29 c3                	sub    %eax,%ebx
801072db:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801072e1:	39 f3                	cmp    %esi,%ebx
801072e3:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
801072e6:	29 f8                	sub    %edi,%eax
801072e8:	83 ec 04             	sub    $0x4,%esp
801072eb:	01 c1                	add    %eax,%ecx
801072ed:	53                   	push   %ebx
801072ee:	52                   	push   %edx
801072ef:	51                   	push   %ecx
801072f0:	e8 8b d4 ff ff       	call   80104780 <memmove>
    len -= n;
    buf += n;
801072f5:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
801072f8:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
801072fe:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107301:	01 da                	add    %ebx,%edx
  while(len > 0){
80107303:	29 de                	sub    %ebx,%esi
80107305:	74 59                	je     80107360 <copyout+0xc0>
  if(*pde & PTE_P){
80107307:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010730a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010730c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010730e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107311:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107317:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010731a:	f6 c1 01             	test   $0x1,%cl
8010731d:	0f 84 4e 00 00 00    	je     80107371 <copyout.cold>
  return &pgtab[PTX(va)];
80107323:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107325:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010732b:	c1 eb 0c             	shr    $0xc,%ebx
8010732e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107334:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010733b:	89 d9                	mov    %ebx,%ecx
8010733d:	83 e1 05             	and    $0x5,%ecx
80107340:	83 f9 05             	cmp    $0x5,%ecx
80107343:	0f 84 77 ff ff ff    	je     801072c0 <copyout+0x20>
  }
  return 0;
}
80107349:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010734c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107351:	5b                   	pop    %ebx
80107352:	5e                   	pop    %esi
80107353:	5f                   	pop    %edi
80107354:	5d                   	pop    %ebp
80107355:	c3                   	ret    
80107356:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010735d:	8d 76 00             	lea    0x0(%esi),%esi
80107360:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107363:	31 c0                	xor    %eax,%eax
}
80107365:	5b                   	pop    %ebx
80107366:	5e                   	pop    %esi
80107367:	5f                   	pop    %edi
80107368:	5d                   	pop    %ebp
80107369:	c3                   	ret    

8010736a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
8010736a:	a1 00 00 00 00       	mov    0x0,%eax
8010736f:	0f 0b                	ud2    

80107371 <copyout.cold>:
80107371:	a1 00 00 00 00       	mov    0x0,%eax
80107376:	0f 0b                	ud2    
80107378:	66 90                	xchg   %ax,%ax
8010737a:	66 90                	xchg   %ax,%ax
8010737c:	66 90                	xchg   %ax,%ax
8010737e:	66 90                	xchg   %ax,%ax

80107380 <sys_wmap>:
#include "mmu.h"
#include "param.h"
#include "proc.h"


uint sys_wmap(void) {
80107380:	55                   	push   %ebp
80107381:	89 e5                	mov    %esp,%ebp
80107383:	57                   	push   %edi
80107384:	56                   	push   %esi
  uint addr;
  int length;
  int flags;
  int fd;
  if(argint(0, (int*)&addr) < 0 || argint(1, &length) < 0 || argint(2, &flags) < 0 || argint(3, &fd) < 0) {
80107385:	8d 45 d8             	lea    -0x28(%ebp),%eax
uint sys_wmap(void) {
80107388:	53                   	push   %ebx
80107389:	83 ec 34             	sub    $0x34,%esp
  if(argint(0, (int*)&addr) < 0 || argint(1, &length) < 0 || argint(2, &flags) < 0 || argint(3, &fd) < 0) {
8010738c:	50                   	push   %eax
8010738d:	6a 00                	push   $0x0
8010738f:	e8 0c d6 ff ff       	call   801049a0 <argint>
80107394:	83 c4 10             	add    $0x10,%esp
80107397:	85 c0                	test   %eax,%eax
80107399:	0f 88 71 01 00 00    	js     80107510 <sys_wmap+0x190>
8010739f:	83 ec 08             	sub    $0x8,%esp
801073a2:	8d 45 dc             	lea    -0x24(%ebp),%eax
801073a5:	50                   	push   %eax
801073a6:	6a 01                	push   $0x1
801073a8:	e8 f3 d5 ff ff       	call   801049a0 <argint>
801073ad:	83 c4 10             	add    $0x10,%esp
801073b0:	85 c0                	test   %eax,%eax
801073b2:	0f 88 58 01 00 00    	js     80107510 <sys_wmap+0x190>
801073b8:	83 ec 08             	sub    $0x8,%esp
801073bb:	8d 45 e0             	lea    -0x20(%ebp),%eax
801073be:	50                   	push   %eax
801073bf:	6a 02                	push   $0x2
801073c1:	e8 da d5 ff ff       	call   801049a0 <argint>
801073c6:	83 c4 10             	add    $0x10,%esp
801073c9:	85 c0                	test   %eax,%eax
801073cb:	0f 88 3f 01 00 00    	js     80107510 <sys_wmap+0x190>
801073d1:	83 ec 08             	sub    $0x8,%esp
801073d4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801073d7:	50                   	push   %eax
801073d8:	6a 03                	push   $0x3
801073da:	e8 c1 d5 ff ff       	call   801049a0 <argint>
801073df:	83 c4 10             	add    $0x10,%esp
801073e2:	85 c0                	test   %eax,%eax
801073e4:	0f 88 26 01 00 00    	js     80107510 <sys_wmap+0x190>
   return -1;
  }
  if (length <= 0) {
801073ea:	8b 75 dc             	mov    -0x24(%ebp),%esi
801073ed:	85 f6                	test   %esi,%esi
801073ef:	0f 8e e4 01 00 00    	jle    801075d9 <sys_wmap+0x259>
    cprintf("Length less or equal to 0\n");
    return -1;
  }
  struct proc* p = myproc();
801073f5:	e8 d6 c5 ff ff       	call   801039d0 <myproc>
  if (p->memory_used + length > 0x20000000) {
801073fa:	8b 7d dc             	mov    -0x24(%ebp),%edi
  struct proc* p = myproc();
801073fd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if (p->memory_used + length > 0x20000000) {
80107400:	8b 80 bc 01 00 00    	mov    0x1bc(%eax),%eax
80107406:	01 f8                	add    %edi,%eax
80107408:	3d 00 00 00 20       	cmp    $0x20000000,%eax
8010740d:	0f 8f e0 01 00 00    	jg     801075f3 <sys_wmap+0x273>
    cprintf("Not enough memory\n");
    return -1;
  }
  if (addr < 0x60000000 || addr + length - 1 >= 0x80000000){
80107413:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80107416:	81 f9 ff ff ff 5f    	cmp    $0x5fffffff,%ecx
8010741c:	0f 86 fd 00 00 00    	jbe    8010751f <sys_wmap+0x19f>
80107422:	01 cf                	add    %ecx,%edi
80107424:	89 f8                	mov    %edi,%eax
80107426:	83 e8 01             	sub    $0x1,%eax
80107429:	0f 88 f0 00 00 00    	js     8010751f <sys_wmap+0x19f>
    cprintf("Wrong address");
    return -1;
  }
  if (flags & MAP_FIXED) {
8010742f:	f6 45 e0 08          	testb  $0x8,-0x20(%ebp)
80107433:	0f 85 90 00 00 00    	jne    801074c9 <sys_wmap+0x149>
80107439:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010743c:	83 e8 80             	sub    $0xffffff80,%eax
8010743f:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
  } else {
    int valid = 0;
    while (!valid) {
      int i;
      for(i = 0; i < 16; ++i) {
80107442:	8b 55 d0             	mov    -0x30(%ebp),%edx
80107445:	31 db                	xor    %ebx,%ebx
80107447:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010744e:	66 90                	xchg   %ax,%ax
        if(p->addr[i].va == 0) {
80107450:	8b 42 fc             	mov    -0x4(%edx),%eax
80107453:	85 c0                	test   %eax,%eax
80107455:	74 20                	je     80107477 <sys_wmap+0xf7>
          continue;
        }
        if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size > addr + length)) { //checks if boundaries of mem being asked are in any of vas of maps already made
80107457:	39 c8                	cmp    %ecx,%eax
80107459:	77 0c                	ja     80107467 <sys_wmap+0xe7>
8010745b:	8b 32                	mov    (%edx),%esi
8010745d:	01 c6                	add    %eax,%esi
8010745f:	39 ce                	cmp    %ecx,%esi
80107461:	0f 87 d9 00 00 00    	ja     80107540 <sys_wmap+0x1c0>
80107467:	39 f8                	cmp    %edi,%eax
80107469:	73 0c                	jae    80107477 <sys_wmap+0xf7>
8010746b:	8b 32                	mov    (%edx),%esi
8010746d:	01 c6                	add    %eax,%esi
8010746f:	39 f7                	cmp    %esi,%edi
80107471:	0f 82 c9 00 00 00    	jb     80107540 <sys_wmap+0x1c0>
      for(i = 0; i < 16; ++i) {
80107477:	83 c3 01             	add    $0x1,%ebx
8010747a:	83 c2 14             	add    $0x14,%edx
8010747d:	83 fb 10             	cmp    $0x10,%ebx
80107480:	75 ce                	jne    80107450 <sys_wmap+0xd0>
      }
      if (i == 16) {
        valid = 1;
      }
    }
    cprintf("\t-Done. Final addr 0x%x\n", addr);
80107482:	83 ec 08             	sub    $0x8,%esp
80107485:	51                   	push   %ecx
80107486:	68 9f 84 10 80       	push   $0x8010849f
8010748b:	e8 10 92 ff ff       	call   801006a0 <cprintf>
  }

  //cprintf("pid in wmap: %d\n",p->pid);
  for(int i=0; i<16; ++i){
    if(p->addr[i].va==0) {
      p->addr[i].va = addr;
80107490:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80107493:	83 c4 10             	add    $0x10,%esp
  for(int i=0; i<16; ++i){
80107496:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80107499:	8d 50 7c             	lea    0x7c(%eax),%edx
8010749c:	31 c0                	xor    %eax,%eax
8010749e:	66 90                	xchg   %ax,%ax
    if(p->addr[i].va==0) {
801074a0:	8b 1a                	mov    (%edx),%ebx
801074a2:	85 db                	test   %ebx,%ebx
801074a4:	0f 84 fd 00 00 00    	je     801075a7 <sys_wmap+0x227>
  for(int i=0; i<16; ++i){
801074aa:	83 c0 01             	add    $0x1,%eax
801074ad:	83 c2 14             	add    $0x14,%edx
801074b0:	83 f8 10             	cmp    $0x10,%eax
801074b3:	75 eb                	jne    801074a0 <sys_wmap+0x120>
      p->addr[i].flags = flags;
      p->addr[i].fd = fd;
      break;
    }
  }
  p->n_mmaps += 1;
801074b5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801074b8:	83 80 c0 01 00 00 01 	addl   $0x1,0x1c0(%eax)
  // for(int i = 0; i < p->size_addr; ++i) {
  //   cprintf("addr[0]\nva = 0x%x\nlength = %d\nflags = %d\nfd = %d\n", p->addr[i].va, p->addr[i].size, p->addr[i].flags, p->addr[i].fd);
  // }
 // struct address* head = myproc()->head;
  return addr;
}
801074bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074c2:	89 c8                	mov    %ecx,%eax
801074c4:	5b                   	pop    %ebx
801074c5:	5e                   	pop    %esi
801074c6:	5f                   	pop    %edi
801074c7:	5d                   	pop    %ebp
801074c8:	c3                   	ret    
801074c9:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
801074cc:	8d 83 80 00 00 00    	lea    0x80(%ebx),%eax
801074d2:	81 c3 c0 01 00 00    	add    $0x1c0,%ebx
801074d8:	eb 17                	jmp    801074f1 <sys_wmap+0x171>
801074da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size > addr + length)) {
801074e0:	39 d7                	cmp    %edx,%edi
801074e2:	76 06                	jbe    801074ea <sys_wmap+0x16a>
801074e4:	03 10                	add    (%eax),%edx
801074e6:	39 d7                	cmp    %edx,%edi
801074e8:	72 16                	jb     80107500 <sys_wmap+0x180>
    for(int i = 0; i < 16; ++i) {
801074ea:	83 c0 14             	add    $0x14,%eax
801074ed:	39 d8                	cmp    %ebx,%eax
801074ef:	74 a5                	je     80107496 <sys_wmap+0x116>
      if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size > addr + length)) {
801074f1:	8b 50 fc             	mov    -0x4(%eax),%edx
801074f4:	39 d1                	cmp    %edx,%ecx
801074f6:	72 e8                	jb     801074e0 <sys_wmap+0x160>
801074f8:	8b 30                	mov    (%eax),%esi
801074fa:	01 d6                	add    %edx,%esi
801074fc:	39 f1                	cmp    %esi,%ecx
801074fe:	73 e0                	jae    801074e0 <sys_wmap+0x160>
        cprintf("Address suggested already in memory\n");
80107500:	83 ec 0c             	sub    $0xc,%esp
80107503:	68 04 85 10 80       	push   $0x80108504
80107508:	e8 93 91 ff ff       	call   801006a0 <cprintf>
        return -1;
8010750d:	83 c4 10             	add    $0x10,%esp
80107510:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
}
80107515:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107518:	89 c8                	mov    %ecx,%eax
8010751a:	5b                   	pop    %ebx
8010751b:	5e                   	pop    %esi
8010751c:	5f                   	pop    %edi
8010751d:	5d                   	pop    %ebp
8010751e:	c3                   	ret    
    cprintf("Wrong address");
8010751f:	83 ec 0c             	sub    $0xc,%esp
80107522:	68 91 84 10 80       	push   $0x80108491
80107527:	e8 74 91 ff ff       	call   801006a0 <cprintf>
    return -1;
8010752c:	83 c4 10             	add    $0x10,%esp
8010752f:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80107534:	eb df                	jmp    80107515 <sys_wmap+0x195>
80107536:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010753d:	8d 76 00             	lea    0x0(%esi),%esi
          cprintf("\t-In if addr = 0x%x, checking against addr[%d], interval 0x%x, 0x%x\n", addr, i, p->addr[i].va, p->addr[i].va + p->addr[i].size);
80107540:	83 ec 0c             	sub    $0xc,%esp
80107543:	56                   	push   %esi
80107544:	50                   	push   %eax
80107545:	53                   	push   %ebx
80107546:	51                   	push   %ecx
80107547:	68 2c 85 10 80       	push   $0x8010852c
8010754c:	e8 4f 91 ff ff       	call   801006a0 <cprintf>
          if (p->addr[i].va + p->addr[i].size == 0x80000000) {
80107551:	8b 7d d4             	mov    -0x2c(%ebp),%edi
80107554:	8d 14 9b             	lea    (%ebx,%ebx,4),%edx
80107557:	83 c4 20             	add    $0x20,%esp
8010755a:	8b 44 97 7c          	mov    0x7c(%edi,%edx,4),%eax
8010755e:	03 84 97 80 00 00 00 	add    0x80(%edi,%edx,4),%eax
80107565:	3d 00 00 00 80       	cmp    $0x80000000,%eax
8010756a:	74 10                	je     8010757c <sys_wmap+0x1fc>
            if (addr + length > 0x80000000) {
8010756c:	8b 55 dc             	mov    -0x24(%ebp),%edx
            addr = p->addr[i].va + p->addr[i].size;
8010756f:	89 45 d8             	mov    %eax,-0x28(%ebp)
            if (addr + length > 0x80000000) {
80107572:	01 c2                	add    %eax,%edx
80107574:	81 fa 00 00 00 80    	cmp    $0x80000000,%edx
8010757a:	76 0c                	jbe    80107588 <sys_wmap+0x208>
            addr = 0x60000000;
8010757c:	c7 45 d8 00 00 00 60 	movl   $0x60000000,-0x28(%ebp)
80107583:	b8 00 00 00 60       	mov    $0x60000000,%eax
          cprintf("\t-New addr after if against addr[%d] is 0x%x\n", i, addr);
80107588:	83 ec 04             	sub    $0x4,%esp
8010758b:	50                   	push   %eax
8010758c:	53                   	push   %ebx
8010758d:	68 74 85 10 80       	push   $0x80108574
80107592:	e8 09 91 ff ff       	call   801006a0 <cprintf>
        if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size > addr + length)) { //checks if boundaries of mem being asked are in any of vas of maps already made
80107597:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010759a:	8b 7d dc             	mov    -0x24(%ebp),%edi
8010759d:	83 c4 10             	add    $0x10,%esp
801075a0:	01 cf                	add    %ecx,%edi
801075a2:	e9 9b fe ff ff       	jmp    80107442 <sys_wmap+0xc2>
      p->addr[i].va = addr;
801075a7:	8b 7d d4             	mov    -0x2c(%ebp),%edi
      p->memory_used += length;
801075aa:	8b 55 dc             	mov    -0x24(%ebp),%edx
      p->addr[i].va = addr;
801075ad:	8d 04 80             	lea    (%eax,%eax,4),%eax
801075b0:	8d 04 87             	lea    (%edi,%eax,4),%eax
801075b3:	89 48 7c             	mov    %ecx,0x7c(%eax)
      p->memory_used += length;
801075b6:	01 97 bc 01 00 00    	add    %edx,0x1bc(%edi)
      p->addr[i].size = length;
801075bc:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
      p->addr[i].flags = flags;
801075c2:	8b 55 e0             	mov    -0x20(%ebp),%edx
801075c5:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
      p->addr[i].fd = fd;
801075cb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801075ce:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
      break;
801075d4:	e9 dc fe ff ff       	jmp    801074b5 <sys_wmap+0x135>
    cprintf("Length less or equal to 0\n");
801075d9:	83 ec 0c             	sub    $0xc,%esp
801075dc:	68 63 84 10 80       	push   $0x80108463
801075e1:	e8 ba 90 ff ff       	call   801006a0 <cprintf>
    return -1;
801075e6:	83 c4 10             	add    $0x10,%esp
801075e9:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
801075ee:	e9 22 ff ff ff       	jmp    80107515 <sys_wmap+0x195>
    cprintf("Not enough memory\n");
801075f3:	83 ec 0c             	sub    $0xc,%esp
801075f6:	68 7e 84 10 80       	push   $0x8010847e
801075fb:	e8 a0 90 ff ff       	call   801006a0 <cprintf>
    return -1;
80107600:	83 c4 10             	add    $0x10,%esp
80107603:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80107608:	e9 08 ff ff ff       	jmp    80107515 <sys_wmap+0x195>
8010760d:	8d 76 00             	lea    0x0(%esi),%esi

80107610 <sys_wunmap>:

int sys_wunmap(void) {
80107610:	55                   	push   %ebp
80107611:	89 e5                	mov    %esp,%ebp
80107613:	57                   	push   %edi
80107614:	56                   	push   %esi
  uint addr;
  if (argint(0, (int*)&addr) < 0) {
80107615:	8d 45 e4             	lea    -0x1c(%ebp),%eax
int sys_wunmap(void) {
80107618:	53                   	push   %ebx
80107619:	83 ec 34             	sub    $0x34,%esp
  if (argint(0, (int*)&addr) < 0) {
8010761c:	50                   	push   %eax
8010761d:	6a 00                	push   $0x0
8010761f:	e8 7c d3 ff ff       	call   801049a0 <argint>
80107624:	83 c4 10             	add    $0x10,%esp
80107627:	85 c0                	test   %eax,%eax
80107629:	0f 88 59 01 00 00    	js     80107788 <sys_wunmap+0x178>
   return -1;
  }
  struct proc* p = myproc();
8010762f:	e8 9c c3 ff ff       	call   801039d0 <myproc>
  pte_t *pte;
  for(int i = 0; i < 16; ++i) {
80107634:	31 f6                	xor    %esi,%esi
  struct proc* p = myproc();
80107636:	89 c7                	mov    %eax,%edi

      //PTE_P present bit && *pte to check if valid and then kfree and 0 it.

    if (p->addr[i].va == addr && p->addr[i].phys_page_used>0) {
80107638:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010763b:	8d 5f 7c             	lea    0x7c(%edi),%ebx
8010763e:	89 da                	mov    %ebx,%edx
80107640:	eb 15                	jmp    80107657 <sys_wunmap+0x47>
80107642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(int i = 0; i < 16; ++i) {
80107648:	83 c6 01             	add    $0x1,%esi
8010764b:	83 c2 14             	add    $0x14,%edx
8010764e:	83 fe 10             	cmp    $0x10,%esi
80107651:	0f 84 d5 00 00 00    	je     8010772c <sys_wunmap+0x11c>
    if (p->addr[i].va == addr && p->addr[i].phys_page_used>0) {
80107657:	39 02                	cmp    %eax,(%edx)
80107659:	75 ed                	jne    80107648 <sys_wunmap+0x38>
8010765b:	8b 4a 10             	mov    0x10(%edx),%ecx
8010765e:	85 c9                	test   %ecx,%ecx
80107660:	7e e6                	jle    80107648 <sys_wunmap+0x38>
      int size = p->addr[i].size;
80107662:	8d 14 b6             	lea    (%esi,%esi,4),%edx
80107665:	8b 94 97 80 00 00 00 	mov    0x80(%edi,%edx,4),%edx
      int j = 0;
      while(size > 0){
8010766c:	85 d2                	test   %edx,%edx
8010766e:	7e 7b                	jle    801076eb <sys_wunmap+0xdb>
80107670:	83 ea 01             	sub    $0x1,%edx
80107673:	89 5d d0             	mov    %ebx,-0x30(%ebp)
80107676:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
8010767c:	89 75 cc             	mov    %esi,-0x34(%ebp)
8010767f:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80107685:	31 d2                	xor    %edx,%edx
80107687:	89 d6                	mov    %edx,%esi
80107689:	89 cb                	mov    %ecx,%ebx
8010768b:	eb 10                	jmp    8010769d <sys_wunmap+0x8d>
8010768d:	8d 76 00             	lea    0x0(%esi),%esi
80107690:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107696:	39 de                	cmp    %ebx,%esi
80107698:	74 4b                	je     801076e5 <sys_wunmap+0xd5>
        pte = walkpgdir(p->pgdir, (void*)addr + j*PAGE_SIZE, 0);
8010769a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010769d:	83 ec 04             	sub    $0x4,%esp
801076a0:	01 f0                	add    %esi,%eax
801076a2:	6a 00                	push   $0x0
801076a4:	50                   	push   %eax
801076a5:	ff 77 04             	push   0x4(%edi)
801076a8:	e8 93 f3 ff ff       	call   80106a40 <walkpgdir>
        int physical_address = PTE_ADDR(*pte);
        //cprintf("pte = %x", *pte);
        size-=PAGE_SIZE;
        ++j;
        if(PTE_P & *pte){
801076ad:	83 c4 10             	add    $0x10,%esp
        int physical_address = PTE_ADDR(*pte);
801076b0:	8b 08                	mov    (%eax),%ecx
        if(PTE_P & *pte){
801076b2:	f6 c1 01             	test   $0x1,%cl
801076b5:	74 d9                	je     80107690 <sys_wunmap+0x80>
        int physical_address = PTE_ADDR(*pte);
801076b7:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
          kfree(P2V(physical_address));
801076bd:	83 ec 0c             	sub    $0xc,%esp
801076c0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
      while(size > 0){
801076c3:	81 c6 00 10 00 00    	add    $0x1000,%esi
          kfree(P2V(physical_address));
801076c9:	81 c1 00 00 00 80    	add    $0x80000000,%ecx
801076cf:	51                   	push   %ecx
801076d0:	e8 eb ad ff ff       	call   801024c0 <kfree>
          
          *pte = 0;
801076d5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801076d8:	83 c4 10             	add    $0x10,%esp
801076db:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
      while(size > 0){
801076e1:	39 de                	cmp    %ebx,%esi
801076e3:	75 b5                	jne    8010769a <sys_wunmap+0x8a>
801076e5:	8b 5d d0             	mov    -0x30(%ebp),%ebx
801076e8:	8b 75 cc             	mov    -0x34(%ebp),%esi
        }

      }
      p->addr[i].va = 0;
801076eb:	8d 04 b6             	lea    (%esi,%esi,4),%eax
801076ee:	8d 04 87             	lea    (%edi,%eax,4),%eax
      p->addr[i].flags = 0;
      p->addr[i].fd = 0;
      p->memory_used -= p->addr[i].size;
801076f1:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
      p->addr[i].va = 0;
801076f7:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
      p->addr[i].flags = 0;
801076fe:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%eax)
80107705:	00 00 00 
      p->addr[i].fd = 0;
80107708:	c7 80 88 00 00 00 00 	movl   $0x0,0x88(%eax)
8010770f:	00 00 00 
      p->memory_used -= p->addr[i].size;
80107712:	29 97 bc 01 00 00    	sub    %edx,0x1bc(%edi)
      p->addr[i].size = 0;
80107718:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010771f:	00 00 00 
      p->addr[i].phys_page_used = 0;
80107722:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
80107729:	00 00 00 
      break;
    }
  }
  // flush TLB
  switchuvm(p);
8010772c:	83 ec 0c             	sub    $0xc,%esp
8010772f:	57                   	push   %edi
80107730:	e8 9b f4 ff ff       	call   80106bd0 <switchuvm>
    for(int i = 0; i < 16; ++i) {
      if (p->addr[i].va == addr) {
80107735:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107738:	8d 87 bc 01 00 00    	lea    0x1bc(%edi),%eax
8010773e:	83 c4 10             	add    $0x10,%esp
80107741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107748:	39 13                	cmp    %edx,(%ebx)
8010774a:	75 2b                	jne    80107777 <sys_wunmap+0x167>

        p->addr[i].va = 0;
        p->addr[i].flags = 0;
        p->addr[i].fd = 0;
        p->memory_used -= p->addr[i].size;
8010774c:	8b 4b 04             	mov    0x4(%ebx),%ecx
        p->addr[i].va = 0;
8010774f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        p->addr[i].flags = 0;
80107755:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        p->addr[i].fd = 0;
8010775c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        p->memory_used -= p->addr[i].size;
80107763:	29 8f bc 01 00 00    	sub    %ecx,0x1bc(%edi)
        p->addr[i].size = 0;
80107769:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
         p->addr[i].phys_page_used = 0;
80107770:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
    for(int i = 0; i < 16; ++i) {
80107777:	83 c3 14             	add    $0x14,%ebx
8010777a:	39 c3                	cmp    %eax,%ebx
8010777c:	75 ca                	jne    80107748 <sys_wunmap+0x138>
      }
    }
  return 0;
8010777e:	31 c0                	xor    %eax,%eax
}
80107780:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107783:	5b                   	pop    %ebx
80107784:	5e                   	pop    %esi
80107785:	5f                   	pop    %edi
80107786:	5d                   	pop    %ebp
80107787:	c3                   	ret    
   return -1;
80107788:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010778d:	eb f1                	jmp    80107780 <sys_wunmap+0x170>
8010778f:	90                   	nop

80107790 <sys_wremap>:

uint sys_wremap(void) {
80107790:	55                   	push   %ebp
80107791:	89 e5                	mov    %esp,%ebp
80107793:	57                   	push   %edi
80107794:	56                   	push   %esi
  uint oldaddr;
  int oldsize;
  int newsize;
  int flags;
  if(argint(0, (int*)&oldaddr) < 0 || argint(1, &oldsize) < 0 || argint(2, &newsize) < 0 || argint(3, &flags) < 0) {
80107795:	8d 45 d8             	lea    -0x28(%ebp),%eax
uint sys_wremap(void) {
80107798:	53                   	push   %ebx
80107799:	83 ec 24             	sub    $0x24,%esp
  if(argint(0, (int*)&oldaddr) < 0 || argint(1, &oldsize) < 0 || argint(2, &newsize) < 0 || argint(3, &flags) < 0) {
8010779c:	50                   	push   %eax
8010779d:	6a 00                	push   $0x0
8010779f:	e8 fc d1 ff ff       	call   801049a0 <argint>
801077a4:	83 c4 10             	add    $0x10,%esp
801077a7:	85 c0                	test   %eax,%eax
801077a9:	0f 88 41 01 00 00    	js     801078f0 <sys_wremap+0x160>
801077af:	83 ec 08             	sub    $0x8,%esp
801077b2:	8d 45 dc             	lea    -0x24(%ebp),%eax
801077b5:	50                   	push   %eax
801077b6:	6a 01                	push   $0x1
801077b8:	e8 e3 d1 ff ff       	call   801049a0 <argint>
801077bd:	83 c4 10             	add    $0x10,%esp
801077c0:	85 c0                	test   %eax,%eax
801077c2:	0f 88 28 01 00 00    	js     801078f0 <sys_wremap+0x160>
801077c8:	83 ec 08             	sub    $0x8,%esp
801077cb:	8d 45 e0             	lea    -0x20(%ebp),%eax
801077ce:	50                   	push   %eax
801077cf:	6a 02                	push   $0x2
801077d1:	e8 ca d1 ff ff       	call   801049a0 <argint>
801077d6:	83 c4 10             	add    $0x10,%esp
801077d9:	85 c0                	test   %eax,%eax
801077db:	0f 88 0f 01 00 00    	js     801078f0 <sys_wremap+0x160>
801077e1:	83 ec 08             	sub    $0x8,%esp
801077e4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801077e7:	50                   	push   %eax
801077e8:	6a 03                	push   $0x3
801077ea:	e8 b1 d1 ff ff       	call   801049a0 <argint>
801077ef:	83 c4 10             	add    $0x10,%esp
801077f2:	85 c0                	test   %eax,%eax
801077f4:	0f 88 f6 00 00 00    	js     801078f0 <sys_wremap+0x160>
    return -1;
  }
  struct proc *p = myproc();
801077fa:	e8 d1 c1 ff ff       	call   801039d0 <myproc>
  int i;
  for(i = 0; i < 16; ++i){
    if(p->addr[i].va == oldaddr && p->addr[i].size == oldsize){
801077ff:	8b 55 d8             	mov    -0x28(%ebp),%edx
80107802:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80107805:	8d 58 7c             	lea    0x7c(%eax),%ebx
80107808:	8d b8 bc 01 00 00    	lea    0x1bc(%eax),%edi
8010780e:	89 d8                	mov    %ebx,%eax
80107810:	eb 11                	jmp    80107823 <sys_wremap+0x93>
80107812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; i < 16; ++i){
80107818:	83 c0 14             	add    $0x14,%eax
8010781b:	39 f8                	cmp    %edi,%eax
8010781d:	0f 84 bd 00 00 00    	je     801078e0 <sys_wremap+0x150>
    if(p->addr[i].va == oldaddr && p->addr[i].size == oldsize){
80107823:	39 10                	cmp    %edx,(%eax)
80107825:	75 f1                	jne    80107818 <sys_wremap+0x88>
80107827:	39 48 04             	cmp    %ecx,0x4(%eax)
8010782a:	75 ec                	jne    80107818 <sys_wremap+0x88>
  int valid = 1;
  for (int j = 0; j < 16; ++j) {
    if(p->addr[j].va == 0) {
      continue;
    }
    cprintf("\t-%x <= %x < %x\n", p->addr[j].va, oldaddr + newsize, p->addr[j].va + p->addr[j].size);
8010782c:	be 01 00 00 00       	mov    $0x1,%esi
80107831:	03 55 e0             	add    -0x20(%ebp),%edx
80107834:	eb 14                	jmp    8010784a <sys_wremap+0xba>
80107836:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010783d:	8d 76 00             	lea    0x0(%esi),%esi
    if ((p->addr[j].va > oldaddr) && (p->addr[j].va < oldaddr + newsize)) {
80107840:	03 55 e0             	add    -0x20(%ebp),%edx
  for (int j = 0; j < 16; ++j) {
80107843:	83 c3 14             	add    $0x14,%ebx
80107846:	39 fb                	cmp    %edi,%ebx
80107848:	74 56                	je     801078a0 <sys_wremap+0x110>
    if(p->addr[j].va == 0) {
8010784a:	8b 03                	mov    (%ebx),%eax
8010784c:	85 c0                	test   %eax,%eax
8010784e:	74 f3                	je     80107843 <sys_wremap+0xb3>
    cprintf("\t-%x <= %x < %x\n", p->addr[j].va, oldaddr + newsize, p->addr[j].va + p->addr[j].size);
80107850:	8b 4b 04             	mov    0x4(%ebx),%ecx
80107853:	01 c1                	add    %eax,%ecx
80107855:	51                   	push   %ecx
80107856:	52                   	push   %edx
80107857:	50                   	push   %eax
80107858:	68 b8 84 10 80       	push   $0x801084b8
8010785d:	e8 3e 8e ff ff       	call   801006a0 <cprintf>
    if ((p->addr[j].va > oldaddr) && (p->addr[j].va < oldaddr + newsize)) {
80107862:	8b 03                	mov    (%ebx),%eax
80107864:	8b 55 d8             	mov    -0x28(%ebp),%edx
80107867:	83 c4 10             	add    $0x10,%esp
8010786a:	39 d0                	cmp    %edx,%eax
8010786c:	76 d2                	jbe    80107840 <sys_wremap+0xb0>
8010786e:	03 55 e0             	add    -0x20(%ebp),%edx
80107871:	39 d0                	cmp    %edx,%eax
80107873:	73 ce                	jae    80107843 <sys_wremap+0xb3>
      cprintf("\t-Address %x between %x and %x, making valid 0\n", oldaddr + newsize, p->addr[j].va, p->addr[j].va + p->addr[j].size);
80107875:	8b 4b 04             	mov    0x4(%ebx),%ecx
  for (int j = 0; j < 16; ++j) {
80107878:	83 c3 14             	add    $0x14,%ebx
      valid = 0;
8010787b:	31 f6                	xor    %esi,%esi
      cprintf("\t-Address %x between %x and %x, making valid 0\n", oldaddr + newsize, p->addr[j].va, p->addr[j].va + p->addr[j].size);
8010787d:	01 c1                	add    %eax,%ecx
8010787f:	51                   	push   %ecx
80107880:	50                   	push   %eax
80107881:	52                   	push   %edx
80107882:	68 a4 85 10 80       	push   $0x801085a4
80107887:	e8 14 8e ff ff       	call   801006a0 <cprintf>
      continue;
    }
  }
  if (oldaddr + newsize > 0x80000000) {
8010788c:	8b 55 e0             	mov    -0x20(%ebp),%edx
      continue;
8010788f:	83 c4 10             	add    $0x10,%esp
  if (oldaddr + newsize > 0x80000000) {
80107892:	03 55 d8             	add    -0x28(%ebp),%edx
  for (int j = 0; j < 16; ++j) {
80107895:	39 fb                	cmp    %edi,%ebx
80107897:	75 b1                	jne    8010784a <sys_wremap+0xba>
80107899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    valid = 0;
  }
  cprintf("\t-flag is %d\n", flags);
801078a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if (oldaddr + newsize > 0x80000000) {
801078a3:	81 fa 00 00 00 80    	cmp    $0x80000000,%edx
801078a9:	76 55                	jbe    80107900 <sys_wremap+0x170>
  cprintf("\t-flag is %d\n", flags);
801078ab:	83 ec 08             	sub    $0x8,%esp
801078ae:	50                   	push   %eax
801078af:	68 c9 84 10 80       	push   $0x801084c9
801078b4:	e8 e7 8d ff ff       	call   801006a0 <cprintf>
801078b9:	83 c4 10             	add    $0x10,%esp
  if (valid == 1) {
    cprintf("\t-Valid for in place\n");
  } else if ((valid == 0) && !(flags & MREMAP_MAYMOVE)) {
801078bc:	f6 45 e4 01          	testb  $0x1,-0x1c(%ebp)
801078c0:	74 6e                	je     80107930 <sys_wremap+0x1a0>
    cprintf("\t-Cannot remap in place and flag specified no move. No remap\n");
  } else {
    cprintf("\t-Valid for moving\n");
801078c2:	83 ec 0c             	sub    $0xc,%esp
801078c5:	68 ed 84 10 80       	push   $0x801084ed
801078ca:	e8 d1 8d ff ff       	call   801006a0 <cprintf>
801078cf:	83 c4 10             	add    $0x10,%esp
    //remap by changing initial address
  }
  
  return 0;
}
801078d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801078d5:	31 c0                	xor    %eax,%eax
}
801078d7:	5b                   	pop    %ebx
801078d8:	5e                   	pop    %esi
801078d9:	5f                   	pop    %edi
801078da:	5d                   	pop    %ebp
801078db:	c3                   	ret    
801078dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("Address given is not mapped by wmap\n");
801078e0:	83 ec 0c             	sub    $0xc,%esp
801078e3:	68 14 86 10 80       	push   $0x80108614
801078e8:	e8 b3 8d ff ff       	call   801006a0 <cprintf>
    return -1;
801078ed:	83 c4 10             	add    $0x10,%esp
801078f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801078f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078f8:	5b                   	pop    %ebx
801078f9:	5e                   	pop    %esi
801078fa:	5f                   	pop    %edi
801078fb:	5d                   	pop    %ebp
801078fc:	c3                   	ret    
801078fd:	8d 76 00             	lea    0x0(%esi),%esi
  cprintf("\t-flag is %d\n", flags);
80107900:	83 ec 08             	sub    $0x8,%esp
80107903:	50                   	push   %eax
80107904:	68 c9 84 10 80       	push   $0x801084c9
80107909:	e8 92 8d ff ff       	call   801006a0 <cprintf>
  if (valid == 1) {
8010790e:	83 c4 10             	add    $0x10,%esp
80107911:	83 fe 01             	cmp    $0x1,%esi
80107914:	75 a6                	jne    801078bc <sys_wremap+0x12c>
    cprintf("\t-Valid for in place\n");
80107916:	83 ec 0c             	sub    $0xc,%esp
80107919:	68 d7 84 10 80       	push   $0x801084d7
8010791e:	e8 7d 8d ff ff       	call   801006a0 <cprintf>
80107923:	83 c4 10             	add    $0x10,%esp
  return 0;
80107926:	31 c0                	xor    %eax,%eax
80107928:	eb cb                	jmp    801078f5 <sys_wremap+0x165>
8010792a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("\t-Cannot remap in place and flag specified no move. No remap\n");
80107930:	83 ec 0c             	sub    $0xc,%esp
80107933:	68 d4 85 10 80       	push   $0x801085d4
80107938:	e8 63 8d ff ff       	call   801006a0 <cprintf>
8010793d:	83 c4 10             	add    $0x10,%esp
  return 0;
80107940:	31 c0                	xor    %eax,%eax
    cprintf("\t-Cannot remap in place and flag specified no move. No remap\n");
80107942:	eb b1                	jmp    801078f5 <sys_wremap+0x165>
80107944:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010794b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010794f:	90                   	nop

80107950 <sys_getpgdirinfo>:

int sys_getpgdirinfo(void) {
80107950:	55                   	push   %ebp
80107951:	89 e5                	mov    %esp,%ebp
80107953:	83 ec 1c             	sub    $0x1c,%esp
  struct pgdirinfo* pdinfo;
  if (argptr(0, (void*)&pdinfo, sizeof(struct pgdirinfo)) < 0) {
80107956:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107959:	68 04 01 00 00       	push   $0x104
8010795e:	50                   	push   %eax
8010795f:	6a 00                	push   $0x0
80107961:	e8 8a d0 ff ff       	call   801049f0 <argptr>
  // struct proc *p = myproc();
  // for(int i = 0; i < 16; ++i){
    
  // }
  return 0;
}
80107966:	c9                   	leave  
  if (argptr(0, (void*)&pdinfo, sizeof(struct pgdirinfo)) < 0) {
80107967:	c1 f8 1f             	sar    $0x1f,%eax
}
8010796a:	c3                   	ret    
8010796b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010796f:	90                   	nop

80107970 <sys_getwmapinfo>:

int sys_getwmapinfo(void) {
80107970:	55                   	push   %ebp
80107971:	89 e5                	mov    %esp,%ebp
80107973:	53                   	push   %ebx
  struct wmapinfo* wminfo;
  if (argptr(0, (void*)&wminfo, sizeof(struct wmapinfo)) < 0) {
80107974:	8d 45 f4             	lea    -0xc(%ebp),%eax
int sys_getwmapinfo(void) {
80107977:	83 ec 18             	sub    $0x18,%esp
  if (argptr(0, (void*)&wminfo, sizeof(struct wmapinfo)) < 0) {
8010797a:	68 c4 00 00 00       	push   $0xc4
8010797f:	50                   	push   %eax
80107980:	6a 00                	push   $0x0
80107982:	e8 69 d0 ff ff       	call   801049f0 <argptr>
80107987:	83 c4 10             	add    $0x10,%esp
8010798a:	85 c0                	test   %eax,%eax
8010798c:	78 4c                	js     801079da <sys_getwmapinfo+0x6a>
   return -1;
  }
  struct proc *p = myproc();
8010798e:	e8 3d c0 ff ff       	call   801039d0 <myproc>
  if(wminfo == 0 || p == 0){
80107993:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107996:	85 d2                	test   %edx,%edx
80107998:	74 40                	je     801079da <sys_getwmapinfo+0x6a>
8010799a:	85 c0                	test   %eax,%eax
8010799c:	74 3c                	je     801079da <sys_getwmapinfo+0x6a>
    return -1;
  }
  wminfo->total_mmaps =p->n_mmaps;
8010799e:	8b 88 c0 01 00 00    	mov    0x1c0(%eax),%ecx
801079a4:	89 0a                	mov    %ecx,(%edx)
  for(int i = 0; i < MAX_WMMAP_INFO; ++i){
801079a6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801079a9:	8d 50 7c             	lea    0x7c(%eax),%edx
801079ac:	8d 4b 04             	lea    0x4(%ebx),%ecx
801079af:	8d 98 bc 01 00 00    	lea    0x1bc(%eax),%ebx
801079b5:	8d 76 00             	lea    0x0(%esi),%esi
    wminfo->addr[i] = p->addr[i].va;
801079b8:	8b 02                	mov    (%edx),%eax
  for(int i = 0; i < MAX_WMMAP_INFO; ++i){
801079ba:	83 c2 14             	add    $0x14,%edx
801079bd:	83 c1 04             	add    $0x4,%ecx
    wminfo->addr[i] = p->addr[i].va;
801079c0:	89 41 fc             	mov    %eax,-0x4(%ecx)
    wminfo->length[i] = p->addr[i].size;
801079c3:	8b 42 f0             	mov    -0x10(%edx),%eax
801079c6:	89 41 3c             	mov    %eax,0x3c(%ecx)
    wminfo->n_loaded_pages[i] = p->addr[i].phys_page_used;
801079c9:	8b 42 fc             	mov    -0x4(%edx),%eax
801079cc:	89 41 7c             	mov    %eax,0x7c(%ecx)
  for(int i = 0; i < MAX_WMMAP_INFO; ++i){
801079cf:	39 da                	cmp    %ebx,%edx
801079d1:	75 e5                	jne    801079b8 <sys_getwmapinfo+0x48>
    // cprintf("loaded pages[%d]: %d\n",i, p->addr[i].phys_page_used[i]);
  }
  return 0;
801079d3:	31 c0                	xor    %eax,%eax
801079d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801079d8:	c9                   	leave  
801079d9:	c3                   	ret    
   return -1;
801079da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801079df:	eb f4                	jmp    801079d5 <sys_getwmapinfo+0x65>
