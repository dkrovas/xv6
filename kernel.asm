
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
80100028:	bc d0 a6 12 80       	mov    $0x8012a6d0,%esp
8010002d:	b8 60 30 10 80       	mov    $0x80103060,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
80100049:	83 ec 0c             	sub    $0xc,%esp
8010004c:	68 e0 79 10 80       	push   $0x801079e0
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 b5 43 00 00       	call   80104410 <initlock>
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
80100092:	68 e7 79 10 80       	push   $0x801079e7
80100097:	50                   	push   %eax
80100098:	e8 43 42 00 00       	call   801042e0 <initsleeplock>
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 f7 44 00 00       	call   801045e0 <acquire>
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 19 44 00 00       	call   80104580 <release>
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ae 41 00 00       	call   80104320 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 4f 21 00 00       	call   801022e0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 ee 79 10 80       	push   $0x801079ee
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 fd 41 00 00       	call   801043c0 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
801001d4:	e9 07 21 00 00       	jmp    801022e0 <iderw>
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 ff 79 10 80       	push   $0x801079ff
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 bc 41 00 00       	call   801043c0 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 6c 41 00 00       	call   80104380 <releasesleep>
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 c0 43 00 00       	call   801045e0 <acquire>
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100223:	83 c4 10             	add    $0x10,%esp
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
80100242:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100247:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
80100251:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
80100259:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
8010025f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
8010026c:	e9 0f 43 00 00       	jmp    80104580 <release>
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 06 7a 10 80       	push   $0x80107a06
80100279:	e8 02 01 00 00       	call   80100380 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010028f:	ff 75 08             	push   0x8(%ebp)
80100292:	89 df                	mov    %ebx,%edi
80100294:	e8 c7 15 00 00       	call   80101860 <iunlock>
80100299:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002a0:	e8 3b 43 00 00       	call   801045e0 <acquire>
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
801002b0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002b5:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 ff 10 80       	push   $0x8010ff20
801002c8:	68 00 ff 10 80       	push   $0x8010ff00
801002cd:	e8 ae 3d 00 00       	call   80104080 <sleep>
801002d2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
801002e2:	e8 c9 36 00 00       	call   801039b0 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ff 10 80       	push   $0x8010ff20
801002f6:	e8 85 42 00 00       	call   80104580 <release>
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 7c 14 00 00       	call   80101780 <ilock>
80100304:	83 c4 10             	add    $0x10,%esp
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret    
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
80100332:	83 c6 01             	add    $0x1,%esi
80100335:	83 eb 01             	sub    $0x1,%ebx
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 ff 10 80       	push   $0x8010ff20
8010034c:	e8 2f 42 00 00       	call   80104580 <release>
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 26 14 00 00       	call   80101780 <ilock>
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100362:	29 d8                	sub    %ebx,%eax
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret    
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
8010036d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

80100380 <panic>:
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
80100388:	fa                   	cli    
80100389:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
80100390:	00 00 00 
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
80100399:	e8 52 25 00 00       	call   801028f0 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 0d 7a 10 80       	push   $0x80107a0d
801003a7:	e8 f4 02 00 00       	call   801006a0 <cprintf>
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 eb 02 00 00       	call   801006a0 <cprintf>
801003b5:	c7 04 24 df 83 10 80 	movl   $0x801083df,(%esp)
801003bc:	e8 df 02 00 00       	call   801006a0 <cprintf>
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 63 40 00 00       	call   80104430 <getcallerpcs>
801003cd:	83 c4 10             	add    $0x10,%esp
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
801003d5:	83 c3 04             	add    $0x4,%ebx
801003d8:	68 21 7a 10 80       	push   $0x80107a21
801003dd:	e8 be 02 00 00       	call   801006a0 <cprintf>
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
801003e9:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
801003f0:	00 00 00 
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100400 <consputc.part.0>:
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 1c             	sub    $0x1c,%esp
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 ea 00 00 00    	je     80100500 <consputc.part.0+0x100>
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 61 5a 00 00       	call   80105e80 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
80100437:	0f b6 c8             	movzbl %al,%ecx
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100441:	c1 e1 08             	shl    $0x8,%ecx
80100444:	ee                   	out    %al,(%dx)
80100445:	89 f2                	mov    %esi,%edx
80100447:	ec                   	in     (%dx),%al
80100448:	0f b6 c0             	movzbl %al,%eax
8010044b:	09 c8                	or     %ecx,%eax
8010044d:	83 fb 0a             	cmp    $0xa,%ebx
80100450:	0f 84 92 00 00 00    	je     801004e8 <consputc.part.0+0xe8>
80100456:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045c:	74 72                	je     801004d0 <consputc.part.0+0xd0>
8010045e:	0f b6 db             	movzbl %bl,%ebx
80100461:	8d 70 01             	lea    0x1(%eax),%esi
80100464:	80 cf 07             	or     $0x7,%bh
80100467:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
8010046e:	80 
8010046f:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100475:	0f 8f fb 00 00 00    	jg     80100576 <consputc.part.0+0x176>
8010047b:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100481:	0f 8f a9 00 00 00    	jg     80100530 <consputc.part.0+0x130>
80100487:	89 f0                	mov    %esi,%eax
80100489:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
80100490:	88 45 e7             	mov    %al,-0x19(%ebp)
80100493:	0f b6 fc             	movzbl %ah,%edi
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
801004bc:	b8 20 07 00 00       	mov    $0x720,%eax
801004c1:	66 89 06             	mov    %ax,(%esi)
801004c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c7:	5b                   	pop    %ebx
801004c8:	5e                   	pop    %esi
801004c9:	5f                   	pop    %edi
801004ca:	5d                   	pop    %ebp
801004cb:	c3                   	ret    
801004cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801004d0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004d3:	85 c0                	test   %eax,%eax
801004d5:	75 98                	jne    8010046f <consputc.part.0+0x6f>
801004d7:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004db:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004e0:	31 ff                	xor    %edi,%edi
801004e2:	eb b2                	jmp    80100496 <consputc.part.0+0x96>
801004e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801004e8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004ed:	f7 e2                	mul    %edx
801004ef:	c1 ea 06             	shr    $0x6,%edx
801004f2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004f5:	c1 e0 04             	shl    $0x4,%eax
801004f8:	8d 70 50             	lea    0x50(%eax),%esi
801004fb:	e9 6f ff ff ff       	jmp    8010046f <consputc.part.0+0x6f>
80100500:	83 ec 0c             	sub    $0xc,%esp
80100503:	6a 08                	push   $0x8
80100505:	e8 76 59 00 00       	call   80105e80 <uartputc>
8010050a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100511:	e8 6a 59 00 00       	call   80105e80 <uartputc>
80100516:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051d:	e8 5e 59 00 00       	call   80105e80 <uartputc>
80100522:	83 c4 10             	add    $0x10,%esp
80100525:	e9 f8 fe ff ff       	jmp    80100422 <consputc.part.0+0x22>
8010052a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100530:	83 ec 04             	sub    $0x4,%esp
80100533:	8d 5e b0             	lea    -0x50(%esi),%ebx
80100536:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
8010053d:	bf 07 00 00 00       	mov    $0x7,%edi
80100542:	68 60 0e 00 00       	push   $0xe60
80100547:	68 a0 80 0b 80       	push   $0x800b80a0
8010054c:	68 00 80 0b 80       	push   $0x800b8000
80100551:	e8 ea 41 00 00       	call   80104740 <memmove>
80100556:	b8 80 07 00 00       	mov    $0x780,%eax
8010055b:	83 c4 0c             	add    $0xc,%esp
8010055e:	29 d8                	sub    %ebx,%eax
80100560:	01 c0                	add    %eax,%eax
80100562:	50                   	push   %eax
80100563:	6a 00                	push   $0x0
80100565:	56                   	push   %esi
80100566:	e8 35 41 00 00       	call   801046a0 <memset>
8010056b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010056e:	83 c4 10             	add    $0x10,%esp
80100571:	e9 20 ff ff ff       	jmp    80100496 <consputc.part.0+0x96>
80100576:	83 ec 0c             	sub    $0xc,%esp
80100579:	68 25 7a 10 80       	push   $0x80107a25
8010057e:	e8 fd fd ff ff       	call   80100380 <panic>
80100583:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010058a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100590 <consolewrite>:
80100590:	55                   	push   %ebp
80100591:	89 e5                	mov    %esp,%ebp
80100593:	57                   	push   %edi
80100594:	56                   	push   %esi
80100595:	53                   	push   %ebx
80100596:	83 ec 18             	sub    $0x18,%esp
80100599:	ff 75 08             	push   0x8(%ebp)
8010059c:	8b 75 10             	mov    0x10(%ebp),%esi
8010059f:	e8 bc 12 00 00       	call   80101860 <iunlock>
801005a4:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801005ab:	e8 30 40 00 00       	call   801045e0 <acquire>
801005b0:	83 c4 10             	add    $0x10,%esp
801005b3:	85 f6                	test   %esi,%esi
801005b5:	7e 25                	jle    801005dc <consolewrite+0x4c>
801005b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005ba:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
801005bd:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
801005c3:	0f b6 03             	movzbl (%ebx),%eax
801005c6:	85 d2                	test   %edx,%edx
801005c8:	74 06                	je     801005d0 <consolewrite+0x40>
801005ca:	fa                   	cli    
801005cb:	eb fe                	jmp    801005cb <consolewrite+0x3b>
801005cd:	8d 76 00             	lea    0x0(%esi),%esi
801005d0:	e8 2b fe ff ff       	call   80100400 <consputc.part.0>
801005d5:	83 c3 01             	add    $0x1,%ebx
801005d8:	39 df                	cmp    %ebx,%edi
801005da:	75 e1                	jne    801005bd <consolewrite+0x2d>
801005dc:	83 ec 0c             	sub    $0xc,%esp
801005df:	68 20 ff 10 80       	push   $0x8010ff20
801005e4:	e8 97 3f 00 00       	call   80104580 <release>
801005e9:	58                   	pop    %eax
801005ea:	ff 75 08             	push   0x8(%ebp)
801005ed:	e8 8e 11 00 00       	call   80101780 <ilock>
801005f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005f5:	89 f0                	mov    %esi,%eax
801005f7:	5b                   	pop    %ebx
801005f8:	5e                   	pop    %esi
801005f9:	5f                   	pop    %edi
801005fa:	5d                   	pop    %ebp
801005fb:	c3                   	ret    
801005fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100600 <printint>:
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 2c             	sub    $0x2c,%esp
80100609:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010060c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010060f:	85 c9                	test   %ecx,%ecx
80100611:	74 04                	je     80100617 <printint+0x17>
80100613:	85 c0                	test   %eax,%eax
80100615:	78 6d                	js     80100684 <printint+0x84>
80100617:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010061e:	89 c1                	mov    %eax,%ecx
80100620:	31 db                	xor    %ebx,%ebx
80100622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100628:	89 c8                	mov    %ecx,%eax
8010062a:	31 d2                	xor    %edx,%edx
8010062c:	89 de                	mov    %ebx,%esi
8010062e:	89 cf                	mov    %ecx,%edi
80100630:	f7 75 d4             	divl   -0x2c(%ebp)
80100633:	8d 5b 01             	lea    0x1(%ebx),%ebx
80100636:	0f b6 92 50 7a 10 80 	movzbl -0x7fef85b0(%edx),%edx
8010063d:	89 c1                	mov    %eax,%ecx
8010063f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
80100643:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
80100646:	73 e0                	jae    80100628 <printint+0x28>
80100648:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010064b:	85 c9                	test   %ecx,%ecx
8010064d:	74 0c                	je     8010065b <printint+0x5b>
8010064f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
80100654:	89 de                	mov    %ebx,%esi
80100656:	ba 2d 00 00 00       	mov    $0x2d,%edx
8010065b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
8010065f:	0f be c2             	movsbl %dl,%eax
80100662:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100668:	85 d2                	test   %edx,%edx
8010066a:	74 04                	je     80100670 <printint+0x70>
8010066c:	fa                   	cli    
8010066d:	eb fe                	jmp    8010066d <printint+0x6d>
8010066f:	90                   	nop
80100670:	e8 8b fd ff ff       	call   80100400 <consputc.part.0>
80100675:	8d 45 d7             	lea    -0x29(%ebp),%eax
80100678:	39 c3                	cmp    %eax,%ebx
8010067a:	74 0e                	je     8010068a <printint+0x8a>
8010067c:	0f be 03             	movsbl (%ebx),%eax
8010067f:	83 eb 01             	sub    $0x1,%ebx
80100682:	eb de                	jmp    80100662 <printint+0x62>
80100684:	f7 d8                	neg    %eax
80100686:	89 c1                	mov    %eax,%ecx
80100688:	eb 96                	jmp    80100620 <printint+0x20>
8010068a:	83 c4 2c             	add    $0x2c,%esp
8010068d:	5b                   	pop    %ebx
8010068e:	5e                   	pop    %esi
8010068f:	5f                   	pop    %edi
80100690:	5d                   	pop    %ebp
80100691:	c3                   	ret    
80100692:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801006a0 <cprintf>:
801006a0:	55                   	push   %ebp
801006a1:	89 e5                	mov    %esp,%ebp
801006a3:	57                   	push   %edi
801006a4:	56                   	push   %esi
801006a5:	53                   	push   %ebx
801006a6:	83 ec 1c             	sub    $0x1c,%esp
801006a9:	a1 54 ff 10 80       	mov    0x8010ff54,%eax
801006ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006b1:	85 c0                	test   %eax,%eax
801006b3:	0f 85 27 01 00 00    	jne    801007e0 <cprintf+0x140>
801006b9:	8b 75 08             	mov    0x8(%ebp),%esi
801006bc:	85 f6                	test   %esi,%esi
801006be:	0f 84 ac 01 00 00    	je     80100870 <cprintf+0x1d0>
801006c4:	0f b6 06             	movzbl (%esi),%eax
801006c7:	8d 7d 0c             	lea    0xc(%ebp),%edi
801006ca:	31 db                	xor    %ebx,%ebx
801006cc:	85 c0                	test   %eax,%eax
801006ce:	74 56                	je     80100726 <cprintf+0x86>
801006d0:	83 f8 25             	cmp    $0x25,%eax
801006d3:	0f 85 cf 00 00 00    	jne    801007a8 <cprintf+0x108>
801006d9:	83 c3 01             	add    $0x1,%ebx
801006dc:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
801006e0:	85 d2                	test   %edx,%edx
801006e2:	74 42                	je     80100726 <cprintf+0x86>
801006e4:	83 fa 70             	cmp    $0x70,%edx
801006e7:	0f 84 90 00 00 00    	je     8010077d <cprintf+0xdd>
801006ed:	7f 51                	jg     80100740 <cprintf+0xa0>
801006ef:	83 fa 25             	cmp    $0x25,%edx
801006f2:	0f 84 c0 00 00 00    	je     801007b8 <cprintf+0x118>
801006f8:	83 fa 64             	cmp    $0x64,%edx
801006fb:	0f 85 f4 00 00 00    	jne    801007f5 <cprintf+0x155>
80100701:	8d 47 04             	lea    0x4(%edi),%eax
80100704:	b9 01 00 00 00       	mov    $0x1,%ecx
80100709:	ba 0a 00 00 00       	mov    $0xa,%edx
8010070e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100711:	8b 07                	mov    (%edi),%eax
80100713:	e8 e8 fe ff ff       	call   80100600 <printint>
80100718:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010071b:	83 c3 01             	add    $0x1,%ebx
8010071e:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100722:	85 c0                	test   %eax,%eax
80100724:	75 aa                	jne    801006d0 <cprintf+0x30>
80100726:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100729:	85 c0                	test   %eax,%eax
8010072b:	0f 85 22 01 00 00    	jne    80100853 <cprintf+0x1b3>
80100731:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100734:	5b                   	pop    %ebx
80100735:	5e                   	pop    %esi
80100736:	5f                   	pop    %edi
80100737:	5d                   	pop    %ebp
80100738:	c3                   	ret    
80100739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100740:	83 fa 73             	cmp    $0x73,%edx
80100743:	75 33                	jne    80100778 <cprintf+0xd8>
80100745:	8d 47 04             	lea    0x4(%edi),%eax
80100748:	8b 3f                	mov    (%edi),%edi
8010074a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010074d:	85 ff                	test   %edi,%edi
8010074f:	0f 84 e3 00 00 00    	je     80100838 <cprintf+0x198>
80100755:	0f be 07             	movsbl (%edi),%eax
80100758:	84 c0                	test   %al,%al
8010075a:	0f 84 08 01 00 00    	je     80100868 <cprintf+0x1c8>
80100760:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100766:	85 d2                	test   %edx,%edx
80100768:	0f 84 b2 00 00 00    	je     80100820 <cprintf+0x180>
8010076e:	fa                   	cli    
8010076f:	eb fe                	jmp    8010076f <cprintf+0xcf>
80100771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100778:	83 fa 78             	cmp    $0x78,%edx
8010077b:	75 78                	jne    801007f5 <cprintf+0x155>
8010077d:	8d 47 04             	lea    0x4(%edi),%eax
80100780:	31 c9                	xor    %ecx,%ecx
80100782:	ba 10 00 00 00       	mov    $0x10,%edx
80100787:	83 c3 01             	add    $0x1,%ebx
8010078a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010078d:	8b 07                	mov    (%edi),%eax
8010078f:	e8 6c fe ff ff       	call   80100600 <printint>
80100794:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100798:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010079b:	85 c0                	test   %eax,%eax
8010079d:	0f 85 2d ff ff ff    	jne    801006d0 <cprintf+0x30>
801007a3:	eb 81                	jmp    80100726 <cprintf+0x86>
801007a5:	8d 76 00             	lea    0x0(%esi),%esi
801007a8:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007ae:	85 c9                	test   %ecx,%ecx
801007b0:	74 14                	je     801007c6 <cprintf+0x126>
801007b2:	fa                   	cli    
801007b3:	eb fe                	jmp    801007b3 <cprintf+0x113>
801007b5:	8d 76 00             	lea    0x0(%esi),%esi
801007b8:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801007bd:	85 c0                	test   %eax,%eax
801007bf:	75 6c                	jne    8010082d <cprintf+0x18d>
801007c1:	b8 25 00 00 00       	mov    $0x25,%eax
801007c6:	e8 35 fc ff ff       	call   80100400 <consputc.part.0>
801007cb:	83 c3 01             	add    $0x1,%ebx
801007ce:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801007d2:	85 c0                	test   %eax,%eax
801007d4:	0f 85 f6 fe ff ff    	jne    801006d0 <cprintf+0x30>
801007da:	e9 47 ff ff ff       	jmp    80100726 <cprintf+0x86>
801007df:	90                   	nop
801007e0:	83 ec 0c             	sub    $0xc,%esp
801007e3:	68 20 ff 10 80       	push   $0x8010ff20
801007e8:	e8 f3 3d 00 00       	call   801045e0 <acquire>
801007ed:	83 c4 10             	add    $0x10,%esp
801007f0:	e9 c4 fe ff ff       	jmp    801006b9 <cprintf+0x19>
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
8010081a:	eb fe                	jmp    8010081a <cprintf+0x17a>
8010081c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100820:	e8 db fb ff ff       	call   80100400 <consputc.part.0>
80100825:	83 c7 01             	add    $0x1,%edi
80100828:	e9 28 ff ff ff       	jmp    80100755 <cprintf+0xb5>
8010082d:	fa                   	cli    
8010082e:	eb fe                	jmp    8010082e <cprintf+0x18e>
80100830:	fa                   	cli    
80100831:	eb fe                	jmp    80100831 <cprintf+0x191>
80100833:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100837:	90                   	nop
80100838:	bf 38 7a 10 80       	mov    $0x80107a38,%edi
8010083d:	b8 28 00 00 00       	mov    $0x28,%eax
80100842:	e9 19 ff ff ff       	jmp    80100760 <cprintf+0xc0>
80100847:	89 d0                	mov    %edx,%eax
80100849:	e8 b2 fb ff ff       	call   80100400 <consputc.part.0>
8010084e:	e9 c8 fe ff ff       	jmp    8010071b <cprintf+0x7b>
80100853:	83 ec 0c             	sub    $0xc,%esp
80100856:	68 20 ff 10 80       	push   $0x8010ff20
8010085b:	e8 20 3d 00 00       	call   80104580 <release>
80100860:	83 c4 10             	add    $0x10,%esp
80100863:	e9 c9 fe ff ff       	jmp    80100731 <cprintf+0x91>
80100868:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010086b:	e9 ab fe ff ff       	jmp    8010071b <cprintf+0x7b>
80100870:	83 ec 0c             	sub    $0xc,%esp
80100873:	68 3f 7a 10 80       	push   $0x80107a3f
80100878:	e8 03 fb ff ff       	call   80100380 <panic>
8010087d:	8d 76 00             	lea    0x0(%esi),%esi

80100880 <consoleintr>:
80100880:	55                   	push   %ebp
80100881:	89 e5                	mov    %esp,%ebp
80100883:	57                   	push   %edi
80100884:	56                   	push   %esi
80100885:	31 f6                	xor    %esi,%esi
80100887:	53                   	push   %ebx
80100888:	83 ec 18             	sub    $0x18,%esp
8010088b:	8b 7d 08             	mov    0x8(%ebp),%edi
8010088e:	68 20 ff 10 80       	push   $0x8010ff20
80100893:	e8 48 3d 00 00       	call   801045e0 <acquire>
80100898:	83 c4 10             	add    $0x10,%esp
8010089b:	eb 1a                	jmp    801008b7 <consoleintr+0x37>
8010089d:	8d 76 00             	lea    0x0(%esi),%esi
801008a0:	83 fb 08             	cmp    $0x8,%ebx
801008a3:	0f 84 d7 00 00 00    	je     80100980 <consoleintr+0x100>
801008a9:	83 fb 10             	cmp    $0x10,%ebx
801008ac:	0f 85 32 01 00 00    	jne    801009e4 <consoleintr+0x164>
801008b2:	be 01 00 00 00       	mov    $0x1,%esi
801008b7:	ff d7                	call   *%edi
801008b9:	89 c3                	mov    %eax,%ebx
801008bb:	85 c0                	test   %eax,%eax
801008bd:	0f 88 05 01 00 00    	js     801009c8 <consoleintr+0x148>
801008c3:	83 fb 15             	cmp    $0x15,%ebx
801008c6:	74 78                	je     80100940 <consoleintr+0xc0>
801008c8:	7e d6                	jle    801008a0 <consoleintr+0x20>
801008ca:	83 fb 7f             	cmp    $0x7f,%ebx
801008cd:	0f 84 ad 00 00 00    	je     80100980 <consoleintr+0x100>
801008d3:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801008d8:	89 c2                	mov    %eax,%edx
801008da:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
801008e0:	83 fa 7f             	cmp    $0x7f,%edx
801008e3:	77 d2                	ja     801008b7 <consoleintr+0x37>
801008e5:	8d 48 01             	lea    0x1(%eax),%ecx
801008e8:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
801008ee:	83 e0 7f             	and    $0x7f,%eax
801008f1:	89 0d 08 ff 10 80    	mov    %ecx,0x8010ff08
801008f7:	83 fb 0d             	cmp    $0xd,%ebx
801008fa:	0f 84 13 01 00 00    	je     80100a13 <consoleintr+0x193>
80100900:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
80100906:	85 d2                	test   %edx,%edx
80100908:	0f 85 10 01 00 00    	jne    80100a1e <consoleintr+0x19e>
8010090e:	89 d8                	mov    %ebx,%eax
80100910:	e8 eb fa ff ff       	call   80100400 <consputc.part.0>
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
80100940:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100945:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
8010094b:	0f 84 66 ff ff ff    	je     801008b7 <consoleintr+0x37>
80100951:	83 e8 01             	sub    $0x1,%eax
80100954:	89 c2                	mov    %eax,%edx
80100956:	83 e2 7f             	and    $0x7f,%edx
80100959:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
80100960:	0f 84 51 ff ff ff    	je     801008b7 <consoleintr+0x37>
80100966:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
8010096c:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
80100971:	85 d2                	test   %edx,%edx
80100973:	74 33                	je     801009a8 <consoleintr+0x128>
80100975:	fa                   	cli    
80100976:	eb fe                	jmp    80100976 <consoleintr+0xf6>
80100978:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010097f:	90                   	nop
80100980:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100985:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
8010098b:	0f 84 26 ff ff ff    	je     801008b7 <consoleintr+0x37>
80100991:	83 e8 01             	sub    $0x1,%eax
80100994:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
80100999:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
8010099e:	85 c0                	test   %eax,%eax
801009a0:	74 56                	je     801009f8 <consoleintr+0x178>
801009a2:	fa                   	cli    
801009a3:	eb fe                	jmp    801009a3 <consoleintr+0x123>
801009a5:	8d 76 00             	lea    0x0(%esi),%esi
801009a8:	b8 00 01 00 00       	mov    $0x100,%eax
801009ad:	e8 4e fa ff ff       	call   80100400 <consputc.part.0>
801009b2:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801009b7:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801009bd:	75 92                	jne    80100951 <consoleintr+0xd1>
801009bf:	e9 f3 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
801009c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801009c8:	83 ec 0c             	sub    $0xc,%esp
801009cb:	68 20 ff 10 80       	push   $0x8010ff20
801009d0:	e8 ab 3b 00 00       	call   80104580 <release>
801009d5:	83 c4 10             	add    $0x10,%esp
801009d8:	85 f6                	test   %esi,%esi
801009da:	75 2b                	jne    80100a07 <consoleintr+0x187>
801009dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009df:	5b                   	pop    %ebx
801009e0:	5e                   	pop    %esi
801009e1:	5f                   	pop    %edi
801009e2:	5d                   	pop    %ebp
801009e3:	c3                   	ret    
801009e4:	85 db                	test   %ebx,%ebx
801009e6:	0f 84 cb fe ff ff    	je     801008b7 <consoleintr+0x37>
801009ec:	e9 e2 fe ff ff       	jmp    801008d3 <consoleintr+0x53>
801009f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801009f8:	b8 00 01 00 00       	mov    $0x100,%eax
801009fd:	e8 fe f9 ff ff       	call   80100400 <consputc.part.0>
80100a02:	e9 b0 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
80100a07:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a0a:	5b                   	pop    %ebx
80100a0b:	5e                   	pop    %esi
80100a0c:	5f                   	pop    %edi
80100a0d:	5d                   	pop    %ebp
80100a0e:	e9 0d 38 00 00       	jmp    80104220 <procdump>
80100a13:	c6 80 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%eax)
80100a1a:	85 d2                	test   %edx,%edx
80100a1c:	74 0a                	je     80100a28 <consoleintr+0x1a8>
80100a1e:	fa                   	cli    
80100a1f:	eb fe                	jmp    80100a1f <consoleintr+0x19f>
80100a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a28:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a2d:	e8 ce f9 ff ff       	call   80100400 <consputc.part.0>
80100a32:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100a37:	83 ec 0c             	sub    $0xc,%esp
80100a3a:	a3 04 ff 10 80       	mov    %eax,0x8010ff04
80100a3f:	68 00 ff 10 80       	push   $0x8010ff00
80100a44:	e8 f7 36 00 00       	call   80104140 <wakeup>
80100a49:	83 c4 10             	add    $0x10,%esp
80100a4c:	e9 66 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
80100a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a5f:	90                   	nop

80100a60 <consoleinit>:
80100a60:	55                   	push   %ebp
80100a61:	89 e5                	mov    %esp,%ebp
80100a63:	83 ec 10             	sub    $0x10,%esp
80100a66:	68 48 7a 10 80       	push   $0x80107a48
80100a6b:	68 20 ff 10 80       	push   $0x8010ff20
80100a70:	e8 9b 39 00 00       	call   80104410 <initlock>
80100a75:	58                   	pop    %eax
80100a76:	5a                   	pop    %edx
80100a77:	6a 00                	push   $0x0
80100a79:	6a 01                	push   $0x1
80100a7b:	c7 05 0c 09 11 80 90 	movl   $0x80100590,0x8011090c
80100a82:	05 10 80 
80100a85:	c7 05 08 09 11 80 80 	movl   $0x80100280,0x80110908
80100a8c:	02 10 80 
80100a8f:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
80100a96:	00 00 00 
80100a99:	e8 e2 19 00 00       	call   80102480 <ioapicenable>
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
80100ab0:	55                   	push   %ebp
80100ab1:	89 e5                	mov    %esp,%ebp
80100ab3:	57                   	push   %edi
80100ab4:	56                   	push   %esi
80100ab5:	53                   	push   %ebx
80100ab6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
80100abc:	e8 ef 2e 00 00       	call   801039b0 <myproc>
80100ac1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ac7:	e8 94 22 00 00       	call   80102d60 <begin_op>
80100acc:	83 ec 0c             	sub    $0xc,%esp
80100acf:	ff 75 08             	push   0x8(%ebp)
80100ad2:	e8 c9 15 00 00       	call   801020a0 <namei>
80100ad7:	83 c4 10             	add    $0x10,%esp
80100ada:	85 c0                	test   %eax,%eax
80100adc:	0f 84 02 03 00 00    	je     80100de4 <exec+0x334>
80100ae2:	83 ec 0c             	sub    $0xc,%esp
80100ae5:	89 c3                	mov    %eax,%ebx
80100ae7:	50                   	push   %eax
80100ae8:	e8 93 0c 00 00       	call   80101780 <ilock>
80100aed:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100af3:	6a 34                	push   $0x34
80100af5:	6a 00                	push   $0x0
80100af7:	50                   	push   %eax
80100af8:	53                   	push   %ebx
80100af9:	e8 92 0f 00 00       	call   80101a90 <readi>
80100afe:	83 c4 20             	add    $0x20,%esp
80100b01:	83 f8 34             	cmp    $0x34,%eax
80100b04:	74 22                	je     80100b28 <exec+0x78>
80100b06:	83 ec 0c             	sub    $0xc,%esp
80100b09:	53                   	push   %ebx
80100b0a:	e8 01 0f 00 00       	call   80101a10 <iunlockput>
80100b0f:	e8 bc 22 00 00       	call   80102dd0 <end_op>
80100b14:	83 c4 10             	add    $0x10,%esp
80100b17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b1f:	5b                   	pop    %ebx
80100b20:	5e                   	pop    %esi
80100b21:	5f                   	pop    %edi
80100b22:	5d                   	pop    %ebp
80100b23:	c3                   	ret    
80100b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100b28:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b2f:	45 4c 46 
80100b32:	75 d2                	jne    80100b06 <exec+0x56>
80100b34:	e8 67 65 00 00       	call   801070a0 <setupkvm>
80100b39:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b3f:	85 c0                	test   %eax,%eax
80100b41:	74 c3                	je     80100b06 <exec+0x56>
80100b43:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b4a:	00 
80100b4b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b51:	0f 84 ac 02 00 00    	je     80100e03 <exec+0x353>
80100b57:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b5e:	00 00 00 
80100b61:	31 ff                	xor    %edi,%edi
80100b63:	e9 8e 00 00 00       	jmp    80100bf6 <exec+0x146>
80100b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b6f:	90                   	nop
80100b70:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b77:	75 6c                	jne    80100be5 <exec+0x135>
80100b79:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b7f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b85:	0f 82 87 00 00 00    	jb     80100c12 <exec+0x162>
80100b8b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b91:	72 7f                	jb     80100c12 <exec+0x162>
80100b93:	83 ec 04             	sub    $0x4,%esp
80100b96:	50                   	push   %eax
80100b97:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100b9d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100ba3:	e8 18 63 00 00       	call   80106ec0 <allocuvm>
80100ba8:	83 c4 10             	add    $0x10,%esp
80100bab:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100bb1:	85 c0                	test   %eax,%eax
80100bb3:	74 5d                	je     80100c12 <exec+0x162>
80100bb5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bbb:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bc0:	75 50                	jne    80100c12 <exec+0x162>
80100bc2:	83 ec 0c             	sub    $0xc,%esp
80100bc5:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100bcb:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100bd1:	53                   	push   %ebx
80100bd2:	50                   	push   %eax
80100bd3:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100bd9:	e8 f2 61 00 00       	call   80106dd0 <loaduvm>
80100bde:	83 c4 20             	add    $0x20,%esp
80100be1:	85 c0                	test   %eax,%eax
80100be3:	78 2d                	js     80100c12 <exec+0x162>
80100be5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bec:	83 c7 01             	add    $0x1,%edi
80100bef:	83 c6 20             	add    $0x20,%esi
80100bf2:	39 f8                	cmp    %edi,%eax
80100bf4:	7e 3a                	jle    80100c30 <exec+0x180>
80100bf6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bfc:	6a 20                	push   $0x20
80100bfe:	56                   	push   %esi
80100bff:	50                   	push   %eax
80100c00:	53                   	push   %ebx
80100c01:	e8 8a 0e 00 00       	call   80101a90 <readi>
80100c06:	83 c4 10             	add    $0x10,%esp
80100c09:	83 f8 20             	cmp    $0x20,%eax
80100c0c:	0f 84 5e ff ff ff    	je     80100b70 <exec+0xc0>
80100c12:	83 ec 0c             	sub    $0xc,%esp
80100c15:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c1b:	e8 00 64 00 00       	call   80107020 <freevm>
80100c20:	83 c4 10             	add    $0x10,%esp
80100c23:	e9 de fe ff ff       	jmp    80100b06 <exec+0x56>
80100c28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c2f:	90                   	nop
80100c30:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100c36:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100c3c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100c42:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
80100c48:	83 ec 0c             	sub    $0xc,%esp
80100c4b:	53                   	push   %ebx
80100c4c:	e8 bf 0d 00 00       	call   80101a10 <iunlockput>
80100c51:	e8 7a 21 00 00       	call   80102dd0 <end_op>
80100c56:	83 c4 0c             	add    $0xc,%esp
80100c59:	56                   	push   %esi
80100c5a:	57                   	push   %edi
80100c5b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c61:	57                   	push   %edi
80100c62:	e8 59 62 00 00       	call   80106ec0 <allocuvm>
80100c67:	83 c4 10             	add    $0x10,%esp
80100c6a:	89 c6                	mov    %eax,%esi
80100c6c:	85 c0                	test   %eax,%eax
80100c6e:	0f 84 94 00 00 00    	je     80100d08 <exec+0x258>
80100c74:	83 ec 08             	sub    $0x8,%esp
80100c77:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100c7d:	89 f3                	mov    %esi,%ebx
80100c7f:	50                   	push   %eax
80100c80:	57                   	push   %edi
80100c81:	31 ff                	xor    %edi,%edi
80100c83:	e8 b8 64 00 00       	call   80107140 <clearpteu>
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
80100cb3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
80100cba:	83 c7 01             	add    $0x1,%edi
80100cbd:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100cc3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100cc6:	85 c0                	test   %eax,%eax
80100cc8:	74 59                	je     80100d23 <exec+0x273>
80100cca:	83 ff 20             	cmp    $0x20,%edi
80100ccd:	74 39                	je     80100d08 <exec+0x258>
80100ccf:	83 ec 0c             	sub    $0xc,%esp
80100cd2:	50                   	push   %eax
80100cd3:	e8 c8 3b 00 00       	call   801048a0 <strlen>
80100cd8:	29 c3                	sub    %eax,%ebx
80100cda:	58                   	pop    %eax
80100cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cde:	83 eb 01             	sub    $0x1,%ebx
80100ce1:	ff 34 b8             	push   (%eax,%edi,4)
80100ce4:	83 e3 fc             	and    $0xfffffffc,%ebx
80100ce7:	e8 b4 3b 00 00       	call   801048a0 <strlen>
80100cec:	83 c0 01             	add    $0x1,%eax
80100cef:	50                   	push   %eax
80100cf0:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cf3:	ff 34 b8             	push   (%eax,%edi,4)
80100cf6:	53                   	push   %ebx
80100cf7:	56                   	push   %esi
80100cf8:	e8 13 66 00 00       	call   80107310 <copyout>
80100cfd:	83 c4 20             	add    $0x20,%esp
80100d00:	85 c0                	test   %eax,%eax
80100d02:	79 ac                	jns    80100cb0 <exec+0x200>
80100d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100d08:	83 ec 0c             	sub    $0xc,%esp
80100d0b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d11:	e8 0a 63 00 00       	call   80107020 <freevm>
80100d16:	83 c4 10             	add    $0x10,%esp
80100d19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d1e:	e9 f9 fd ff ff       	jmp    80100b1c <exec+0x6c>
80100d23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100d29:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100d30:	89 d9                	mov    %ebx,%ecx
80100d32:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100d39:	00 00 00 00 
80100d3d:	29 c1                	sub    %eax,%ecx
80100d3f:	83 c0 0c             	add    $0xc,%eax
80100d42:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
80100d48:	29 c3                	sub    %eax,%ebx
80100d4a:	50                   	push   %eax
80100d4b:	52                   	push   %edx
80100d4c:	53                   	push   %ebx
80100d4d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d53:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d5a:	ff ff ff 
80100d5d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
80100d63:	e8 a8 65 00 00       	call   80107310 <copyout>
80100d68:	83 c4 10             	add    $0x10,%esp
80100d6b:	85 c0                	test   %eax,%eax
80100d6d:	78 99                	js     80100d08 <exec+0x258>
80100d6f:	8b 45 08             	mov    0x8(%ebp),%eax
80100d72:	8b 55 08             	mov    0x8(%ebp),%edx
80100d75:	0f b6 00             	movzbl (%eax),%eax
80100d78:	84 c0                	test   %al,%al
80100d7a:	74 13                	je     80100d8f <exec+0x2df>
80100d7c:	89 d1                	mov    %edx,%ecx
80100d7e:	66 90                	xchg   %ax,%ax
80100d80:	83 c1 01             	add    $0x1,%ecx
80100d83:	3c 2f                	cmp    $0x2f,%al
80100d85:	0f b6 01             	movzbl (%ecx),%eax
80100d88:	0f 44 d1             	cmove  %ecx,%edx
80100d8b:	84 c0                	test   %al,%al
80100d8d:	75 f1                	jne    80100d80 <exec+0x2d0>
80100d8f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100d95:	83 ec 04             	sub    $0x4,%esp
80100d98:	6a 10                	push   $0x10
80100d9a:	89 f8                	mov    %edi,%eax
80100d9c:	52                   	push   %edx
80100d9d:	83 c0 6c             	add    $0x6c,%eax
80100da0:	50                   	push   %eax
80100da1:	e8 ba 3a 00 00       	call   80104860 <safestrcpy>
80100da6:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100dac:	89 f8                	mov    %edi,%eax
80100dae:	8b 7f 04             	mov    0x4(%edi),%edi
80100db1:	89 30                	mov    %esi,(%eax)
80100db3:	89 48 04             	mov    %ecx,0x4(%eax)
80100db6:	89 c1                	mov    %eax,%ecx
80100db8:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dbe:	8b 40 18             	mov    0x18(%eax),%eax
80100dc1:	89 50 38             	mov    %edx,0x38(%eax)
80100dc4:	8b 41 18             	mov    0x18(%ecx),%eax
80100dc7:	89 58 44             	mov    %ebx,0x44(%eax)
80100dca:	89 0c 24             	mov    %ecx,(%esp)
80100dcd:	e8 6e 5e 00 00       	call   80106c40 <switchuvm>
80100dd2:	89 3c 24             	mov    %edi,(%esp)
80100dd5:	e8 46 62 00 00       	call   80107020 <freevm>
80100dda:	83 c4 10             	add    $0x10,%esp
80100ddd:	31 c0                	xor    %eax,%eax
80100ddf:	e9 38 fd ff ff       	jmp    80100b1c <exec+0x6c>
80100de4:	e8 e7 1f 00 00       	call   80102dd0 <end_op>
80100de9:	83 ec 0c             	sub    $0xc,%esp
80100dec:	68 61 7a 10 80       	push   $0x80107a61
80100df1:	e8 aa f8 ff ff       	call   801006a0 <cprintf>
80100df6:	83 c4 10             	add    $0x10,%esp
80100df9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100dfe:	e9 19 fd ff ff       	jmp    80100b1c <exec+0x6c>
80100e03:	be 00 20 00 00       	mov    $0x2000,%esi
80100e08:	31 ff                	xor    %edi,%edi
80100e0a:	e9 39 fe ff ff       	jmp    80100c48 <exec+0x198>
80100e0f:	90                   	nop

80100e10 <fileinit>:
80100e10:	55                   	push   %ebp
80100e11:	89 e5                	mov    %esp,%ebp
80100e13:	83 ec 10             	sub    $0x10,%esp
80100e16:	68 6d 7a 10 80       	push   $0x80107a6d
80100e1b:	68 60 ff 10 80       	push   $0x8010ff60
80100e20:	e8 eb 35 00 00       	call   80104410 <initlock>
80100e25:	83 c4 10             	add    $0x10,%esp
80100e28:	c9                   	leave  
80100e29:	c3                   	ret    
80100e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e30 <filealloc>:
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	53                   	push   %ebx
80100e34:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
80100e39:	83 ec 10             	sub    $0x10,%esp
80100e3c:	68 60 ff 10 80       	push   $0x8010ff60
80100e41:	e8 9a 37 00 00       	call   801045e0 <acquire>
80100e46:	83 c4 10             	add    $0x10,%esp
80100e49:	eb 10                	jmp    80100e5b <filealloc+0x2b>
80100e4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e4f:	90                   	nop
80100e50:	83 c3 18             	add    $0x18,%ebx
80100e53:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
80100e59:	74 25                	je     80100e80 <filealloc+0x50>
80100e5b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e5e:	85 c0                	test   %eax,%eax
80100e60:	75 ee                	jne    80100e50 <filealloc+0x20>
80100e62:	83 ec 0c             	sub    $0xc,%esp
80100e65:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
80100e6c:	68 60 ff 10 80       	push   $0x8010ff60
80100e71:	e8 0a 37 00 00       	call   80104580 <release>
80100e76:	89 d8                	mov    %ebx,%eax
80100e78:	83 c4 10             	add    $0x10,%esp
80100e7b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e7e:	c9                   	leave  
80100e7f:	c3                   	ret    
80100e80:	83 ec 0c             	sub    $0xc,%esp
80100e83:	31 db                	xor    %ebx,%ebx
80100e85:	68 60 ff 10 80       	push   $0x8010ff60
80100e8a:	e8 f1 36 00 00       	call   80104580 <release>
80100e8f:	89 d8                	mov    %ebx,%eax
80100e91:	83 c4 10             	add    $0x10,%esp
80100e94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e97:	c9                   	leave  
80100e98:	c3                   	ret    
80100e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ea0 <filedup>:
80100ea0:	55                   	push   %ebp
80100ea1:	89 e5                	mov    %esp,%ebp
80100ea3:	53                   	push   %ebx
80100ea4:	83 ec 10             	sub    $0x10,%esp
80100ea7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100eaa:	68 60 ff 10 80       	push   $0x8010ff60
80100eaf:	e8 2c 37 00 00       	call   801045e0 <acquire>
80100eb4:	8b 43 04             	mov    0x4(%ebx),%eax
80100eb7:	83 c4 10             	add    $0x10,%esp
80100eba:	85 c0                	test   %eax,%eax
80100ebc:	7e 1a                	jle    80100ed8 <filedup+0x38>
80100ebe:	83 c0 01             	add    $0x1,%eax
80100ec1:	83 ec 0c             	sub    $0xc,%esp
80100ec4:	89 43 04             	mov    %eax,0x4(%ebx)
80100ec7:	68 60 ff 10 80       	push   $0x8010ff60
80100ecc:	e8 af 36 00 00       	call   80104580 <release>
80100ed1:	89 d8                	mov    %ebx,%eax
80100ed3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ed6:	c9                   	leave  
80100ed7:	c3                   	ret    
80100ed8:	83 ec 0c             	sub    $0xc,%esp
80100edb:	68 74 7a 10 80       	push   $0x80107a74
80100ee0:	e8 9b f4 ff ff       	call   80100380 <panic>
80100ee5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ef0 <fileclose>:
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	57                   	push   %edi
80100ef4:	56                   	push   %esi
80100ef5:	53                   	push   %ebx
80100ef6:	83 ec 28             	sub    $0x28,%esp
80100ef9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100efc:	68 60 ff 10 80       	push   $0x8010ff60
80100f01:	e8 da 36 00 00       	call   801045e0 <acquire>
80100f06:	8b 53 04             	mov    0x4(%ebx),%edx
80100f09:	83 c4 10             	add    $0x10,%esp
80100f0c:	85 d2                	test   %edx,%edx
80100f0e:	0f 8e a5 00 00 00    	jle    80100fb9 <fileclose+0xc9>
80100f14:	83 ea 01             	sub    $0x1,%edx
80100f17:	89 53 04             	mov    %edx,0x4(%ebx)
80100f1a:	75 44                	jne    80100f60 <fileclose+0x70>
80100f1c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100f20:	83 ec 0c             	sub    $0xc,%esp
80100f23:	8b 3b                	mov    (%ebx),%edi
80100f25:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100f2b:	8b 73 0c             	mov    0xc(%ebx),%esi
80100f2e:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f31:	8b 43 10             	mov    0x10(%ebx),%eax
80100f34:	68 60 ff 10 80       	push   $0x8010ff60
80100f39:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100f3c:	e8 3f 36 00 00       	call   80104580 <release>
80100f41:	83 c4 10             	add    $0x10,%esp
80100f44:	83 ff 01             	cmp    $0x1,%edi
80100f47:	74 57                	je     80100fa0 <fileclose+0xb0>
80100f49:	83 ff 02             	cmp    $0x2,%edi
80100f4c:	74 2a                	je     80100f78 <fileclose+0x88>
80100f4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f51:	5b                   	pop    %ebx
80100f52:	5e                   	pop    %esi
80100f53:	5f                   	pop    %edi
80100f54:	5d                   	pop    %ebp
80100f55:	c3                   	ret    
80100f56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f5d:	8d 76 00             	lea    0x0(%esi),%esi
80100f60:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
80100f67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f6a:	5b                   	pop    %ebx
80100f6b:	5e                   	pop    %esi
80100f6c:	5f                   	pop    %edi
80100f6d:	5d                   	pop    %ebp
80100f6e:	e9 0d 36 00 00       	jmp    80104580 <release>
80100f73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f77:	90                   	nop
80100f78:	e8 e3 1d 00 00       	call   80102d60 <begin_op>
80100f7d:	83 ec 0c             	sub    $0xc,%esp
80100f80:	ff 75 e0             	push   -0x20(%ebp)
80100f83:	e8 28 09 00 00       	call   801018b0 <iput>
80100f88:	83 c4 10             	add    $0x10,%esp
80100f8b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f8e:	5b                   	pop    %ebx
80100f8f:	5e                   	pop    %esi
80100f90:	5f                   	pop    %edi
80100f91:	5d                   	pop    %ebp
80100f92:	e9 39 1e 00 00       	jmp    80102dd0 <end_op>
80100f97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f9e:	66 90                	xchg   %ax,%ax
80100fa0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100fa4:	83 ec 08             	sub    $0x8,%esp
80100fa7:	53                   	push   %ebx
80100fa8:	56                   	push   %esi
80100fa9:	e8 82 25 00 00       	call   80103530 <pipeclose>
80100fae:	83 c4 10             	add    $0x10,%esp
80100fb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb4:	5b                   	pop    %ebx
80100fb5:	5e                   	pop    %esi
80100fb6:	5f                   	pop    %edi
80100fb7:	5d                   	pop    %ebp
80100fb8:	c3                   	ret    
80100fb9:	83 ec 0c             	sub    $0xc,%esp
80100fbc:	68 7c 7a 10 80       	push   $0x80107a7c
80100fc1:	e8 ba f3 ff ff       	call   80100380 <panic>
80100fc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fcd:	8d 76 00             	lea    0x0(%esi),%esi

80100fd0 <filestat>:
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	53                   	push   %ebx
80100fd4:	83 ec 04             	sub    $0x4,%esp
80100fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100fda:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fdd:	75 31                	jne    80101010 <filestat+0x40>
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	ff 73 10             	push   0x10(%ebx)
80100fe5:	e8 96 07 00 00       	call   80101780 <ilock>
80100fea:	58                   	pop    %eax
80100feb:	5a                   	pop    %edx
80100fec:	ff 75 0c             	push   0xc(%ebp)
80100fef:	ff 73 10             	push   0x10(%ebx)
80100ff2:	e8 69 0a 00 00       	call   80101a60 <stati>
80100ff7:	59                   	pop    %ecx
80100ff8:	ff 73 10             	push   0x10(%ebx)
80100ffb:	e8 60 08 00 00       	call   80101860 <iunlock>
80101000:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101003:	83 c4 10             	add    $0x10,%esp
80101006:	31 c0                	xor    %eax,%eax
80101008:	c9                   	leave  
80101009:	c3                   	ret    
8010100a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101010:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101013:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101018:	c9                   	leave  
80101019:	c3                   	ret    
8010101a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101020 <fileread>:
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	57                   	push   %edi
80101024:	56                   	push   %esi
80101025:	53                   	push   %ebx
80101026:	83 ec 0c             	sub    $0xc,%esp
80101029:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010102c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010102f:	8b 7d 10             	mov    0x10(%ebp),%edi
80101032:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101036:	74 60                	je     80101098 <fileread+0x78>
80101038:	8b 03                	mov    (%ebx),%eax
8010103a:	83 f8 01             	cmp    $0x1,%eax
8010103d:	74 41                	je     80101080 <fileread+0x60>
8010103f:	83 f8 02             	cmp    $0x2,%eax
80101042:	75 5b                	jne    8010109f <fileread+0x7f>
80101044:	83 ec 0c             	sub    $0xc,%esp
80101047:	ff 73 10             	push   0x10(%ebx)
8010104a:	e8 31 07 00 00       	call   80101780 <ilock>
8010104f:	57                   	push   %edi
80101050:	ff 73 14             	push   0x14(%ebx)
80101053:	56                   	push   %esi
80101054:	ff 73 10             	push   0x10(%ebx)
80101057:	e8 34 0a 00 00       	call   80101a90 <readi>
8010105c:	83 c4 20             	add    $0x20,%esp
8010105f:	89 c6                	mov    %eax,%esi
80101061:	85 c0                	test   %eax,%eax
80101063:	7e 03                	jle    80101068 <fileread+0x48>
80101065:	01 43 14             	add    %eax,0x14(%ebx)
80101068:	83 ec 0c             	sub    $0xc,%esp
8010106b:	ff 73 10             	push   0x10(%ebx)
8010106e:	e8 ed 07 00 00       	call   80101860 <iunlock>
80101073:	83 c4 10             	add    $0x10,%esp
80101076:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101079:	89 f0                	mov    %esi,%eax
8010107b:	5b                   	pop    %ebx
8010107c:	5e                   	pop    %esi
8010107d:	5f                   	pop    %edi
8010107e:	5d                   	pop    %ebp
8010107f:	c3                   	ret    
80101080:	8b 43 0c             	mov    0xc(%ebx),%eax
80101083:	89 45 08             	mov    %eax,0x8(%ebp)
80101086:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101089:	5b                   	pop    %ebx
8010108a:	5e                   	pop    %esi
8010108b:	5f                   	pop    %edi
8010108c:	5d                   	pop    %ebp
8010108d:	e9 3e 26 00 00       	jmp    801036d0 <piperead>
80101092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101098:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010109d:	eb d7                	jmp    80101076 <fileread+0x56>
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	68 86 7a 10 80       	push   $0x80107a86
801010a7:	e8 d4 f2 ff ff       	call   80100380 <panic>
801010ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010b0 <filewrite>:
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
801010c5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
801010c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801010cc:	0f 84 bd 00 00 00    	je     8010118f <filewrite+0xdf>
801010d2:	8b 03                	mov    (%ebx),%eax
801010d4:	83 f8 01             	cmp    $0x1,%eax
801010d7:	0f 84 bf 00 00 00    	je     8010119c <filewrite+0xec>
801010dd:	83 f8 02             	cmp    $0x2,%eax
801010e0:	0f 85 c8 00 00 00    	jne    801011ae <filewrite+0xfe>
801010e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010e9:	31 f6                	xor    %esi,%esi
801010eb:	85 c0                	test   %eax,%eax
801010ed:	7f 30                	jg     8010111f <filewrite+0x6f>
801010ef:	e9 94 00 00 00       	jmp    80101188 <filewrite+0xd8>
801010f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801010f8:	01 43 14             	add    %eax,0x14(%ebx)
801010fb:	83 ec 0c             	sub    $0xc,%esp
801010fe:	ff 73 10             	push   0x10(%ebx)
80101101:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101104:	e8 57 07 00 00       	call   80101860 <iunlock>
80101109:	e8 c2 1c 00 00       	call   80102dd0 <end_op>
8010110e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101111:	83 c4 10             	add    $0x10,%esp
80101114:	39 c7                	cmp    %eax,%edi
80101116:	75 5c                	jne    80101174 <filewrite+0xc4>
80101118:	01 fe                	add    %edi,%esi
8010111a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010111d:	7e 69                	jle    80101188 <filewrite+0xd8>
8010111f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101122:	b8 00 06 00 00       	mov    $0x600,%eax
80101127:	29 f7                	sub    %esi,%edi
80101129:	39 c7                	cmp    %eax,%edi
8010112b:	0f 4f f8             	cmovg  %eax,%edi
8010112e:	e8 2d 1c 00 00       	call   80102d60 <begin_op>
80101133:	83 ec 0c             	sub    $0xc,%esp
80101136:	ff 73 10             	push   0x10(%ebx)
80101139:	e8 42 06 00 00       	call   80101780 <ilock>
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
80101157:	83 ec 0c             	sub    $0xc,%esp
8010115a:	ff 73 10             	push   0x10(%ebx)
8010115d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101160:	e8 fb 06 00 00       	call   80101860 <iunlock>
80101165:	e8 66 1c 00 00       	call   80102dd0 <end_op>
8010116a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010116d:	83 c4 10             	add    $0x10,%esp
80101170:	85 c0                	test   %eax,%eax
80101172:	75 1b                	jne    8010118f <filewrite+0xdf>
80101174:	83 ec 0c             	sub    $0xc,%esp
80101177:	68 8f 7a 10 80       	push   $0x80107a8f
8010117c:	e8 ff f1 ff ff       	call   80100380 <panic>
80101181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101188:	89 f0                	mov    %esi,%eax
8010118a:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
8010118d:	74 05                	je     80101194 <filewrite+0xe4>
8010118f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101197:	5b                   	pop    %ebx
80101198:	5e                   	pop    %esi
80101199:	5f                   	pop    %edi
8010119a:	5d                   	pop    %ebp
8010119b:	c3                   	ret    
8010119c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010119f:	89 45 08             	mov    %eax,0x8(%ebp)
801011a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011a5:	5b                   	pop    %ebx
801011a6:	5e                   	pop    %esi
801011a7:	5f                   	pop    %edi
801011a8:	5d                   	pop    %ebp
801011a9:	e9 22 24 00 00       	jmp    801035d0 <pipewrite>
801011ae:	83 ec 0c             	sub    $0xc,%esp
801011b1:	68 95 7a 10 80       	push   $0x80107a95
801011b6:	e8 c5 f1 ff ff       	call   80100380 <panic>
801011bb:	66 90                	xchg   %ax,%ax
801011bd:	66 90                	xchg   %ax,%ax
801011bf:	90                   	nop

801011c0 <bfree>:
801011c0:	55                   	push   %ebp
801011c1:	89 c1                	mov    %eax,%ecx
801011c3:	89 d0                	mov    %edx,%eax
801011c5:	c1 e8 0c             	shr    $0xc,%eax
801011c8:	03 05 cc 25 11 80    	add    0x801125cc,%eax
801011ce:	89 e5                	mov    %esp,%ebp
801011d0:	56                   	push   %esi
801011d1:	53                   	push   %ebx
801011d2:	89 d3                	mov    %edx,%ebx
801011d4:	83 ec 08             	sub    $0x8,%esp
801011d7:	50                   	push   %eax
801011d8:	51                   	push   %ecx
801011d9:	e8 f2 ee ff ff       	call   801000d0 <bread>
801011de:	89 d9                	mov    %ebx,%ecx
801011e0:	c1 fb 03             	sar    $0x3,%ebx
801011e3:	83 c4 10             	add    $0x10,%esp
801011e6:	89 c6                	mov    %eax,%esi
801011e8:	83 e1 07             	and    $0x7,%ecx
801011eb:	b8 01 00 00 00       	mov    $0x1,%eax
801011f0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801011f6:	d3 e0                	shl    %cl,%eax
801011f8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801011fd:	85 c1                	test   %eax,%ecx
801011ff:	74 23                	je     80101224 <bfree+0x64>
80101201:	f7 d0                	not    %eax
80101203:	83 ec 0c             	sub    $0xc,%esp
80101206:	21 c8                	and    %ecx,%eax
80101208:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
8010120c:	56                   	push   %esi
8010120d:	e8 2e 1d 00 00       	call   80102f40 <log_write>
80101212:	89 34 24             	mov    %esi,(%esp)
80101215:	e8 d6 ef ff ff       	call   801001f0 <brelse>
8010121a:	83 c4 10             	add    $0x10,%esp
8010121d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101220:	5b                   	pop    %ebx
80101221:	5e                   	pop    %esi
80101222:	5d                   	pop    %ebp
80101223:	c3                   	ret    
80101224:	83 ec 0c             	sub    $0xc,%esp
80101227:	68 9f 7a 10 80       	push   $0x80107a9f
8010122c:	e8 4f f1 ff ff       	call   80100380 <panic>
80101231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010123f:	90                   	nop

80101240 <balloc>:
80101240:	55                   	push   %ebp
80101241:	89 e5                	mov    %esp,%ebp
80101243:	57                   	push   %edi
80101244:	56                   	push   %esi
80101245:	53                   	push   %ebx
80101246:	83 ec 1c             	sub    $0x1c,%esp
80101249:	8b 0d b4 25 11 80    	mov    0x801125b4,%ecx
8010124f:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101252:	85 c9                	test   %ecx,%ecx
80101254:	0f 84 87 00 00 00    	je     801012e1 <balloc+0xa1>
8010125a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
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
80101281:	a1 b4 25 11 80       	mov    0x801125b4,%eax
80101286:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101289:	31 c0                	xor    %eax,%eax
8010128b:	eb 2f                	jmp    801012bc <balloc+0x7c>
8010128d:	8d 76 00             	lea    0x0(%esi),%esi
80101290:	89 c1                	mov    %eax,%ecx
80101292:	bb 01 00 00 00       	mov    $0x1,%ebx
80101297:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010129a:	83 e1 07             	and    $0x7,%ecx
8010129d:	d3 e3                	shl    %cl,%ebx
8010129f:	89 c1                	mov    %eax,%ecx
801012a1:	c1 f9 03             	sar    $0x3,%ecx
801012a4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801012a9:	89 fa                	mov    %edi,%edx
801012ab:	85 df                	test   %ebx,%edi
801012ad:	74 41                	je     801012f0 <balloc+0xb0>
801012af:	83 c0 01             	add    $0x1,%eax
801012b2:	83 c6 01             	add    $0x1,%esi
801012b5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801012ba:	74 05                	je     801012c1 <balloc+0x81>
801012bc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801012bf:	77 cf                	ja     80101290 <balloc+0x50>
801012c1:	83 ec 0c             	sub    $0xc,%esp
801012c4:	ff 75 e4             	push   -0x1c(%ebp)
801012c7:	e8 24 ef ff ff       	call   801001f0 <brelse>
801012cc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801012d3:	83 c4 10             	add    $0x10,%esp
801012d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801012d9:	39 05 b4 25 11 80    	cmp    %eax,0x801125b4
801012df:	77 80                	ja     80101261 <balloc+0x21>
801012e1:	83 ec 0c             	sub    $0xc,%esp
801012e4:	68 b2 7a 10 80       	push   $0x80107ab2
801012e9:	e8 92 f0 ff ff       	call   80100380 <panic>
801012ee:	66 90                	xchg   %ax,%ax
801012f0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801012f3:	83 ec 0c             	sub    $0xc,%esp
801012f6:	09 da                	or     %ebx,%edx
801012f8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
801012fc:	57                   	push   %edi
801012fd:	e8 3e 1c 00 00       	call   80102f40 <log_write>
80101302:	89 3c 24             	mov    %edi,(%esp)
80101305:	e8 e6 ee ff ff       	call   801001f0 <brelse>
8010130a:	58                   	pop    %eax
8010130b:	5a                   	pop    %edx
8010130c:	56                   	push   %esi
8010130d:	ff 75 d8             	push   -0x28(%ebp)
80101310:	e8 bb ed ff ff       	call   801000d0 <bread>
80101315:	83 c4 0c             	add    $0xc,%esp
80101318:	89 c3                	mov    %eax,%ebx
8010131a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010131d:	68 00 02 00 00       	push   $0x200
80101322:	6a 00                	push   $0x0
80101324:	50                   	push   %eax
80101325:	e8 76 33 00 00       	call   801046a0 <memset>
8010132a:	89 1c 24             	mov    %ebx,(%esp)
8010132d:	e8 0e 1c 00 00       	call   80102f40 <log_write>
80101332:	89 1c 24             	mov    %ebx,(%esp)
80101335:	e8 b6 ee ff ff       	call   801001f0 <brelse>
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
80101350:	55                   	push   %ebp
80101351:	89 e5                	mov    %esp,%ebp
80101353:	57                   	push   %edi
80101354:	89 c7                	mov    %eax,%edi
80101356:	56                   	push   %esi
80101357:	31 f6                	xor    %esi,%esi
80101359:	53                   	push   %ebx
8010135a:	bb 94 09 11 80       	mov    $0x80110994,%ebx
8010135f:	83 ec 28             	sub    $0x28,%esp
80101362:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101365:	68 60 09 11 80       	push   $0x80110960
8010136a:	e8 71 32 00 00       	call   801045e0 <acquire>
8010136f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101372:	83 c4 10             	add    $0x10,%esp
80101375:	eb 1b                	jmp    80101392 <iget+0x42>
80101377:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010137e:	66 90                	xchg   %ax,%ax
80101380:	39 3b                	cmp    %edi,(%ebx)
80101382:	74 6c                	je     801013f0 <iget+0xa0>
80101384:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010138a:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101390:	73 26                	jae    801013b8 <iget+0x68>
80101392:	8b 43 08             	mov    0x8(%ebx),%eax
80101395:	85 c0                	test   %eax,%eax
80101397:	7f e7                	jg     80101380 <iget+0x30>
80101399:	85 f6                	test   %esi,%esi
8010139b:	75 e7                	jne    80101384 <iget+0x34>
8010139d:	85 c0                	test   %eax,%eax
8010139f:	75 76                	jne    80101417 <iget+0xc7>
801013a1:	89 de                	mov    %ebx,%esi
801013a3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013a9:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
801013af:	72 e1                	jb     80101392 <iget+0x42>
801013b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801013b8:	85 f6                	test   %esi,%esi
801013ba:	74 79                	je     80101435 <iget+0xe5>
801013bc:	83 ec 0c             	sub    $0xc,%esp
801013bf:	89 3e                	mov    %edi,(%esi)
801013c1:	89 56 04             	mov    %edx,0x4(%esi)
801013c4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
801013cb:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
801013d2:	68 60 09 11 80       	push   $0x80110960
801013d7:	e8 a4 31 00 00       	call   80104580 <release>
801013dc:	83 c4 10             	add    $0x10,%esp
801013df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e2:	89 f0                	mov    %esi,%eax
801013e4:	5b                   	pop    %ebx
801013e5:	5e                   	pop    %esi
801013e6:	5f                   	pop    %edi
801013e7:	5d                   	pop    %ebp
801013e8:	c3                   	ret    
801013e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801013f0:	39 53 04             	cmp    %edx,0x4(%ebx)
801013f3:	75 8f                	jne    80101384 <iget+0x34>
801013f5:	83 ec 0c             	sub    $0xc,%esp
801013f8:	83 c0 01             	add    $0x1,%eax
801013fb:	89 de                	mov    %ebx,%esi
801013fd:	68 60 09 11 80       	push   $0x80110960
80101402:	89 43 08             	mov    %eax,0x8(%ebx)
80101405:	e8 76 31 00 00       	call   80104580 <release>
8010140a:	83 c4 10             	add    $0x10,%esp
8010140d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101410:	89 f0                	mov    %esi,%eax
80101412:	5b                   	pop    %ebx
80101413:	5e                   	pop    %esi
80101414:	5f                   	pop    %edi
80101415:	5d                   	pop    %ebp
80101416:	c3                   	ret    
80101417:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010141d:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101423:	73 10                	jae    80101435 <iget+0xe5>
80101425:	8b 43 08             	mov    0x8(%ebx),%eax
80101428:	85 c0                	test   %eax,%eax
8010142a:	0f 8f 50 ff ff ff    	jg     80101380 <iget+0x30>
80101430:	e9 68 ff ff ff       	jmp    8010139d <iget+0x4d>
80101435:	83 ec 0c             	sub    $0xc,%esp
80101438:	68 c8 7a 10 80       	push   $0x80107ac8
8010143d:	e8 3e ef ff ff       	call   80100380 <panic>
80101442:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101450 <bmap>:
80101450:	55                   	push   %ebp
80101451:	89 e5                	mov    %esp,%ebp
80101453:	57                   	push   %edi
80101454:	56                   	push   %esi
80101455:	89 c6                	mov    %eax,%esi
80101457:	53                   	push   %ebx
80101458:	83 ec 1c             	sub    $0x1c,%esp
8010145b:	83 fa 0b             	cmp    $0xb,%edx
8010145e:	0f 86 8c 00 00 00    	jbe    801014f0 <bmap+0xa0>
80101464:	8d 5a f4             	lea    -0xc(%edx),%ebx
80101467:	83 fb 7f             	cmp    $0x7f,%ebx
8010146a:	0f 87 a2 00 00 00    	ja     80101512 <bmap+0xc2>
80101470:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101476:	85 c0                	test   %eax,%eax
80101478:	74 5e                	je     801014d8 <bmap+0x88>
8010147a:	83 ec 08             	sub    $0x8,%esp
8010147d:	50                   	push   %eax
8010147e:	ff 36                	push   (%esi)
80101480:	e8 4b ec ff ff       	call   801000d0 <bread>
80101485:	83 c4 10             	add    $0x10,%esp
80101488:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
8010148c:	89 c2                	mov    %eax,%edx
8010148e:	8b 3b                	mov    (%ebx),%edi
80101490:	85 ff                	test   %edi,%edi
80101492:	74 1c                	je     801014b0 <bmap+0x60>
80101494:	83 ec 0c             	sub    $0xc,%esp
80101497:	52                   	push   %edx
80101498:	e8 53 ed ff ff       	call   801001f0 <brelse>
8010149d:	83 c4 10             	add    $0x10,%esp
801014a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014a3:	89 f8                	mov    %edi,%eax
801014a5:	5b                   	pop    %ebx
801014a6:	5e                   	pop    %esi
801014a7:	5f                   	pop    %edi
801014a8:	5d                   	pop    %ebp
801014a9:	c3                   	ret    
801014aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801014b3:	8b 06                	mov    (%esi),%eax
801014b5:	e8 86 fd ff ff       	call   80101240 <balloc>
801014ba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014bd:	83 ec 0c             	sub    $0xc,%esp
801014c0:	89 03                	mov    %eax,(%ebx)
801014c2:	89 c7                	mov    %eax,%edi
801014c4:	52                   	push   %edx
801014c5:	e8 76 1a 00 00       	call   80102f40 <log_write>
801014ca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014cd:	83 c4 10             	add    $0x10,%esp
801014d0:	eb c2                	jmp    80101494 <bmap+0x44>
801014d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014d8:	8b 06                	mov    (%esi),%eax
801014da:	e8 61 fd ff ff       	call   80101240 <balloc>
801014df:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801014e5:	eb 93                	jmp    8010147a <bmap+0x2a>
801014e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801014ee:	66 90                	xchg   %ax,%ax
801014f0:	8d 5a 14             	lea    0x14(%edx),%ebx
801014f3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
801014f7:	85 ff                	test   %edi,%edi
801014f9:	75 a5                	jne    801014a0 <bmap+0x50>
801014fb:	8b 00                	mov    (%eax),%eax
801014fd:	e8 3e fd ff ff       	call   80101240 <balloc>
80101502:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101506:	89 c7                	mov    %eax,%edi
80101508:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010150b:	5b                   	pop    %ebx
8010150c:	89 f8                	mov    %edi,%eax
8010150e:	5e                   	pop    %esi
8010150f:	5f                   	pop    %edi
80101510:	5d                   	pop    %ebp
80101511:	c3                   	ret    
80101512:	83 ec 0c             	sub    $0xc,%esp
80101515:	68 d8 7a 10 80       	push   $0x80107ad8
8010151a:	e8 61 ee ff ff       	call   80100380 <panic>
8010151f:	90                   	nop

80101520 <readsb>:
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	56                   	push   %esi
80101524:	53                   	push   %ebx
80101525:	8b 75 0c             	mov    0xc(%ebp),%esi
80101528:	83 ec 08             	sub    $0x8,%esp
8010152b:	6a 01                	push   $0x1
8010152d:	ff 75 08             	push   0x8(%ebp)
80101530:	e8 9b eb ff ff       	call   801000d0 <bread>
80101535:	83 c4 0c             	add    $0xc,%esp
80101538:	89 c3                	mov    %eax,%ebx
8010153a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010153d:	6a 1c                	push   $0x1c
8010153f:	50                   	push   %eax
80101540:	56                   	push   %esi
80101541:	e8 fa 31 00 00       	call   80104740 <memmove>
80101546:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101549:	83 c4 10             	add    $0x10,%esp
8010154c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010154f:	5b                   	pop    %ebx
80101550:	5e                   	pop    %esi
80101551:	5d                   	pop    %ebp
80101552:	e9 99 ec ff ff       	jmp    801001f0 <brelse>
80101557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010155e:	66 90                	xchg   %ax,%ax

80101560 <iinit>:
80101560:	55                   	push   %ebp
80101561:	89 e5                	mov    %esp,%ebp
80101563:	53                   	push   %ebx
80101564:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
80101569:	83 ec 0c             	sub    $0xc,%esp
8010156c:	68 eb 7a 10 80       	push   $0x80107aeb
80101571:	68 60 09 11 80       	push   $0x80110960
80101576:	e8 95 2e 00 00       	call   80104410 <initlock>
8010157b:	83 c4 10             	add    $0x10,%esp
8010157e:	66 90                	xchg   %ax,%ax
80101580:	83 ec 08             	sub    $0x8,%esp
80101583:	68 f2 7a 10 80       	push   $0x80107af2
80101588:	53                   	push   %ebx
80101589:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010158f:	e8 4c 2d 00 00       	call   801042e0 <initsleeplock>
80101594:	83 c4 10             	add    $0x10,%esp
80101597:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
8010159d:	75 e1                	jne    80101580 <iinit+0x20>
8010159f:	83 ec 08             	sub    $0x8,%esp
801015a2:	6a 01                	push   $0x1
801015a4:	ff 75 08             	push   0x8(%ebp)
801015a7:	e8 24 eb ff ff       	call   801000d0 <bread>
801015ac:	83 c4 0c             	add    $0xc,%esp
801015af:	89 c3                	mov    %eax,%ebx
801015b1:	8d 40 5c             	lea    0x5c(%eax),%eax
801015b4:	6a 1c                	push   $0x1c
801015b6:	50                   	push   %eax
801015b7:	68 b4 25 11 80       	push   $0x801125b4
801015bc:	e8 7f 31 00 00       	call   80104740 <memmove>
801015c1:	89 1c 24             	mov    %ebx,(%esp)
801015c4:	e8 27 ec ff ff       	call   801001f0 <brelse>
801015c9:	ff 35 cc 25 11 80    	push   0x801125cc
801015cf:	ff 35 c8 25 11 80    	push   0x801125c8
801015d5:	ff 35 c4 25 11 80    	push   0x801125c4
801015db:	ff 35 c0 25 11 80    	push   0x801125c0
801015e1:	ff 35 bc 25 11 80    	push   0x801125bc
801015e7:	ff 35 b8 25 11 80    	push   0x801125b8
801015ed:	ff 35 b4 25 11 80    	push   0x801125b4
801015f3:	68 58 7b 10 80       	push   $0x80107b58
801015f8:	e8 a3 f0 ff ff       	call   801006a0 <cprintf>
801015fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101600:	83 c4 30             	add    $0x30,%esp
80101603:	c9                   	leave  
80101604:	c3                   	ret    
80101605:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010160c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101610 <ialloc>:
80101610:	55                   	push   %ebp
80101611:	89 e5                	mov    %esp,%ebp
80101613:	57                   	push   %edi
80101614:	56                   	push   %esi
80101615:	53                   	push   %ebx
80101616:	83 ec 1c             	sub    $0x1c,%esp
80101619:	8b 45 0c             	mov    0xc(%ebp),%eax
8010161c:	83 3d bc 25 11 80 01 	cmpl   $0x1,0x801125bc
80101623:	8b 75 08             	mov    0x8(%ebp),%esi
80101626:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101629:	0f 86 91 00 00 00    	jbe    801016c0 <ialloc+0xb0>
8010162f:	bf 01 00 00 00       	mov    $0x1,%edi
80101634:	eb 21                	jmp    80101657 <ialloc+0x47>
80101636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010163d:	8d 76 00             	lea    0x0(%esi),%esi
80101640:	83 ec 0c             	sub    $0xc,%esp
80101643:	83 c7 01             	add    $0x1,%edi
80101646:	53                   	push   %ebx
80101647:	e8 a4 eb ff ff       	call   801001f0 <brelse>
8010164c:	83 c4 10             	add    $0x10,%esp
8010164f:	3b 3d bc 25 11 80    	cmp    0x801125bc,%edi
80101655:	73 69                	jae    801016c0 <ialloc+0xb0>
80101657:	89 f8                	mov    %edi,%eax
80101659:	83 ec 08             	sub    $0x8,%esp
8010165c:	c1 e8 03             	shr    $0x3,%eax
8010165f:	03 05 c8 25 11 80    	add    0x801125c8,%eax
80101665:	50                   	push   %eax
80101666:	56                   	push   %esi
80101667:	e8 64 ea ff ff       	call   801000d0 <bread>
8010166c:	83 c4 10             	add    $0x10,%esp
8010166f:	89 c3                	mov    %eax,%ebx
80101671:	89 f8                	mov    %edi,%eax
80101673:	83 e0 07             	and    $0x7,%eax
80101676:	c1 e0 06             	shl    $0x6,%eax
80101679:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
8010167d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101681:	75 bd                	jne    80101640 <ialloc+0x30>
80101683:	83 ec 04             	sub    $0x4,%esp
80101686:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101689:	6a 40                	push   $0x40
8010168b:	6a 00                	push   $0x0
8010168d:	51                   	push   %ecx
8010168e:	e8 0d 30 00 00       	call   801046a0 <memset>
80101693:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101697:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010169a:	66 89 01             	mov    %ax,(%ecx)
8010169d:	89 1c 24             	mov    %ebx,(%esp)
801016a0:	e8 9b 18 00 00       	call   80102f40 <log_write>
801016a5:	89 1c 24             	mov    %ebx,(%esp)
801016a8:	e8 43 eb ff ff       	call   801001f0 <brelse>
801016ad:	83 c4 10             	add    $0x10,%esp
801016b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016b3:	89 fa                	mov    %edi,%edx
801016b5:	5b                   	pop    %ebx
801016b6:	89 f0                	mov    %esi,%eax
801016b8:	5e                   	pop    %esi
801016b9:	5f                   	pop    %edi
801016ba:	5d                   	pop    %ebp
801016bb:	e9 90 fc ff ff       	jmp    80101350 <iget>
801016c0:	83 ec 0c             	sub    $0xc,%esp
801016c3:	68 f8 7a 10 80       	push   $0x80107af8
801016c8:	e8 b3 ec ff ff       	call   80100380 <panic>
801016cd:	8d 76 00             	lea    0x0(%esi),%esi

801016d0 <iupdate>:
801016d0:	55                   	push   %ebp
801016d1:	89 e5                	mov    %esp,%ebp
801016d3:	56                   	push   %esi
801016d4:	53                   	push   %ebx
801016d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801016d8:	8b 43 04             	mov    0x4(%ebx),%eax
801016db:	83 c3 5c             	add    $0x5c,%ebx
801016de:	83 ec 08             	sub    $0x8,%esp
801016e1:	c1 e8 03             	shr    $0x3,%eax
801016e4:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801016ea:	50                   	push   %eax
801016eb:	ff 73 a4             	push   -0x5c(%ebx)
801016ee:	e8 dd e9 ff ff       	call   801000d0 <bread>
801016f3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
801016f7:	83 c4 0c             	add    $0xc,%esp
801016fa:	89 c6                	mov    %eax,%esi
801016fc:	8b 43 a8             	mov    -0x58(%ebx),%eax
801016ff:	83 e0 07             	and    $0x7,%eax
80101702:	c1 e0 06             	shl    $0x6,%eax
80101705:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80101709:	66 89 10             	mov    %dx,(%eax)
8010170c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
80101710:	83 c0 0c             	add    $0xc,%eax
80101713:	66 89 50 f6          	mov    %dx,-0xa(%eax)
80101717:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010171b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
8010171f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101723:	66 89 50 fa          	mov    %dx,-0x6(%eax)
80101727:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010172a:	89 50 fc             	mov    %edx,-0x4(%eax)
8010172d:	6a 34                	push   $0x34
8010172f:	53                   	push   %ebx
80101730:	50                   	push   %eax
80101731:	e8 0a 30 00 00       	call   80104740 <memmove>
80101736:	89 34 24             	mov    %esi,(%esp)
80101739:	e8 02 18 00 00       	call   80102f40 <log_write>
8010173e:	89 75 08             	mov    %esi,0x8(%ebp)
80101741:	83 c4 10             	add    $0x10,%esp
80101744:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101747:	5b                   	pop    %ebx
80101748:	5e                   	pop    %esi
80101749:	5d                   	pop    %ebp
8010174a:	e9 a1 ea ff ff       	jmp    801001f0 <brelse>
8010174f:	90                   	nop

80101750 <idup>:
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	53                   	push   %ebx
80101754:	83 ec 10             	sub    $0x10,%esp
80101757:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010175a:	68 60 09 11 80       	push   $0x80110960
8010175f:	e8 7c 2e 00 00       	call   801045e0 <acquire>
80101764:	83 43 08 01          	addl   $0x1,0x8(%ebx)
80101768:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010176f:	e8 0c 2e 00 00       	call   80104580 <release>
80101774:	89 d8                	mov    %ebx,%eax
80101776:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101779:	c9                   	leave  
8010177a:	c3                   	ret    
8010177b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010177f:	90                   	nop

80101780 <ilock>:
80101780:	55                   	push   %ebp
80101781:	89 e5                	mov    %esp,%ebp
80101783:	56                   	push   %esi
80101784:	53                   	push   %ebx
80101785:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101788:	85 db                	test   %ebx,%ebx
8010178a:	0f 84 b7 00 00 00    	je     80101847 <ilock+0xc7>
80101790:	8b 53 08             	mov    0x8(%ebx),%edx
80101793:	85 d2                	test   %edx,%edx
80101795:	0f 8e ac 00 00 00    	jle    80101847 <ilock+0xc7>
8010179b:	83 ec 0c             	sub    $0xc,%esp
8010179e:	8d 43 0c             	lea    0xc(%ebx),%eax
801017a1:	50                   	push   %eax
801017a2:	e8 79 2b 00 00       	call   80104320 <acquiresleep>
801017a7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801017aa:	83 c4 10             	add    $0x10,%esp
801017ad:	85 c0                	test   %eax,%eax
801017af:	74 0f                	je     801017c0 <ilock+0x40>
801017b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017b4:	5b                   	pop    %ebx
801017b5:	5e                   	pop    %esi
801017b6:	5d                   	pop    %ebp
801017b7:	c3                   	ret    
801017b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017bf:	90                   	nop
801017c0:	8b 43 04             	mov    0x4(%ebx),%eax
801017c3:	83 ec 08             	sub    $0x8,%esp
801017c6:	c1 e8 03             	shr    $0x3,%eax
801017c9:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801017cf:	50                   	push   %eax
801017d0:	ff 33                	push   (%ebx)
801017d2:	e8 f9 e8 ff ff       	call   801000d0 <bread>
801017d7:	83 c4 0c             	add    $0xc,%esp
801017da:	89 c6                	mov    %eax,%esi
801017dc:	8b 43 04             	mov    0x4(%ebx),%eax
801017df:	83 e0 07             	and    $0x7,%eax
801017e2:	c1 e0 06             	shl    $0x6,%eax
801017e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
801017e9:	0f b7 10             	movzwl (%eax),%edx
801017ec:	83 c0 0c             	add    $0xc,%eax
801017ef:	66 89 53 50          	mov    %dx,0x50(%ebx)
801017f3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801017f7:	66 89 53 52          	mov    %dx,0x52(%ebx)
801017fb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801017ff:	66 89 53 54          	mov    %dx,0x54(%ebx)
80101803:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101807:	66 89 53 56          	mov    %dx,0x56(%ebx)
8010180b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010180e:	89 53 58             	mov    %edx,0x58(%ebx)
80101811:	6a 34                	push   $0x34
80101813:	50                   	push   %eax
80101814:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101817:	50                   	push   %eax
80101818:	e8 23 2f 00 00       	call   80104740 <memmove>
8010181d:	89 34 24             	mov    %esi,(%esp)
80101820:	e8 cb e9 ff ff       	call   801001f0 <brelse>
80101825:	83 c4 10             	add    $0x10,%esp
80101828:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
8010182d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
80101834:	0f 85 77 ff ff ff    	jne    801017b1 <ilock+0x31>
8010183a:	83 ec 0c             	sub    $0xc,%esp
8010183d:	68 10 7b 10 80       	push   $0x80107b10
80101842:	e8 39 eb ff ff       	call   80100380 <panic>
80101847:	83 ec 0c             	sub    $0xc,%esp
8010184a:	68 0a 7b 10 80       	push   $0x80107b0a
8010184f:	e8 2c eb ff ff       	call   80100380 <panic>
80101854:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010185b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010185f:	90                   	nop

80101860 <iunlock>:
80101860:	55                   	push   %ebp
80101861:	89 e5                	mov    %esp,%ebp
80101863:	56                   	push   %esi
80101864:	53                   	push   %ebx
80101865:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101868:	85 db                	test   %ebx,%ebx
8010186a:	74 28                	je     80101894 <iunlock+0x34>
8010186c:	83 ec 0c             	sub    $0xc,%esp
8010186f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101872:	56                   	push   %esi
80101873:	e8 48 2b 00 00       	call   801043c0 <holdingsleep>
80101878:	83 c4 10             	add    $0x10,%esp
8010187b:	85 c0                	test   %eax,%eax
8010187d:	74 15                	je     80101894 <iunlock+0x34>
8010187f:	8b 43 08             	mov    0x8(%ebx),%eax
80101882:	85 c0                	test   %eax,%eax
80101884:	7e 0e                	jle    80101894 <iunlock+0x34>
80101886:	89 75 08             	mov    %esi,0x8(%ebp)
80101889:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010188c:	5b                   	pop    %ebx
8010188d:	5e                   	pop    %esi
8010188e:	5d                   	pop    %ebp
8010188f:	e9 ec 2a 00 00       	jmp    80104380 <releasesleep>
80101894:	83 ec 0c             	sub    $0xc,%esp
80101897:	68 1f 7b 10 80       	push   $0x80107b1f
8010189c:	e8 df ea ff ff       	call   80100380 <panic>
801018a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018af:	90                   	nop

801018b0 <iput>:
801018b0:	55                   	push   %ebp
801018b1:	89 e5                	mov    %esp,%ebp
801018b3:	57                   	push   %edi
801018b4:	56                   	push   %esi
801018b5:	53                   	push   %ebx
801018b6:	83 ec 28             	sub    $0x28,%esp
801018b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801018bc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801018bf:	57                   	push   %edi
801018c0:	e8 5b 2a 00 00       	call   80104320 <acquiresleep>
801018c5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801018c8:	83 c4 10             	add    $0x10,%esp
801018cb:	85 d2                	test   %edx,%edx
801018cd:	74 07                	je     801018d6 <iput+0x26>
801018cf:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801018d4:	74 32                	je     80101908 <iput+0x58>
801018d6:	83 ec 0c             	sub    $0xc,%esp
801018d9:	57                   	push   %edi
801018da:	e8 a1 2a 00 00       	call   80104380 <releasesleep>
801018df:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801018e6:	e8 f5 2c 00 00       	call   801045e0 <acquire>
801018eb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
801018ef:	83 c4 10             	add    $0x10,%esp
801018f2:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
801018f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018fc:	5b                   	pop    %ebx
801018fd:	5e                   	pop    %esi
801018fe:	5f                   	pop    %edi
801018ff:	5d                   	pop    %ebp
80101900:	e9 7b 2c 00 00       	jmp    80104580 <release>
80101905:	8d 76 00             	lea    0x0(%esi),%esi
80101908:	83 ec 0c             	sub    $0xc,%esp
8010190b:	68 60 09 11 80       	push   $0x80110960
80101910:	e8 cb 2c 00 00       	call   801045e0 <acquire>
80101915:	8b 73 08             	mov    0x8(%ebx),%esi
80101918:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010191f:	e8 5c 2c 00 00       	call   80104580 <release>
80101924:	83 c4 10             	add    $0x10,%esp
80101927:	83 fe 01             	cmp    $0x1,%esi
8010192a:	75 aa                	jne    801018d6 <iput+0x26>
8010192c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101932:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101935:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101938:	89 cf                	mov    %ecx,%edi
8010193a:	eb 0b                	jmp    80101947 <iput+0x97>
8010193c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101940:	83 c6 04             	add    $0x4,%esi
80101943:	39 fe                	cmp    %edi,%esi
80101945:	74 19                	je     80101960 <iput+0xb0>
80101947:	8b 16                	mov    (%esi),%edx
80101949:	85 d2                	test   %edx,%edx
8010194b:	74 f3                	je     80101940 <iput+0x90>
8010194d:	8b 03                	mov    (%ebx),%eax
8010194f:	e8 6c f8 ff ff       	call   801011c0 <bfree>
80101954:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010195a:	eb e4                	jmp    80101940 <iput+0x90>
8010195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101960:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101966:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101969:	85 c0                	test   %eax,%eax
8010196b:	75 2d                	jne    8010199a <iput+0xea>
8010196d:	83 ec 0c             	sub    $0xc,%esp
80101970:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
80101977:	53                   	push   %ebx
80101978:	e8 53 fd ff ff       	call   801016d0 <iupdate>
8010197d:	31 c0                	xor    %eax,%eax
8010197f:	66 89 43 50          	mov    %ax,0x50(%ebx)
80101983:	89 1c 24             	mov    %ebx,(%esp)
80101986:	e8 45 fd ff ff       	call   801016d0 <iupdate>
8010198b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101992:	83 c4 10             	add    $0x10,%esp
80101995:	e9 3c ff ff ff       	jmp    801018d6 <iput+0x26>
8010199a:	83 ec 08             	sub    $0x8,%esp
8010199d:	50                   	push   %eax
8010199e:	ff 33                	push   (%ebx)
801019a0:	e8 2b e7 ff ff       	call   801000d0 <bread>
801019a5:	89 7d e0             	mov    %edi,-0x20(%ebp)
801019a8:	83 c4 10             	add    $0x10,%esp
801019ab:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801019b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801019b4:	8d 70 5c             	lea    0x5c(%eax),%esi
801019b7:	89 cf                	mov    %ecx,%edi
801019b9:	eb 0c                	jmp    801019c7 <iput+0x117>
801019bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019bf:	90                   	nop
801019c0:	83 c6 04             	add    $0x4,%esi
801019c3:	39 f7                	cmp    %esi,%edi
801019c5:	74 0f                	je     801019d6 <iput+0x126>
801019c7:	8b 16                	mov    (%esi),%edx
801019c9:	85 d2                	test   %edx,%edx
801019cb:	74 f3                	je     801019c0 <iput+0x110>
801019cd:	8b 03                	mov    (%ebx),%eax
801019cf:	e8 ec f7 ff ff       	call   801011c0 <bfree>
801019d4:	eb ea                	jmp    801019c0 <iput+0x110>
801019d6:	83 ec 0c             	sub    $0xc,%esp
801019d9:	ff 75 e4             	push   -0x1c(%ebp)
801019dc:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019df:	e8 0c e8 ff ff       	call   801001f0 <brelse>
801019e4:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801019ea:	8b 03                	mov    (%ebx),%eax
801019ec:	e8 cf f7 ff ff       	call   801011c0 <bfree>
801019f1:	83 c4 10             	add    $0x10,%esp
801019f4:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801019fb:	00 00 00 
801019fe:	e9 6a ff ff ff       	jmp    8010196d <iput+0xbd>
80101a03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101a10 <iunlockput>:
80101a10:	55                   	push   %ebp
80101a11:	89 e5                	mov    %esp,%ebp
80101a13:	56                   	push   %esi
80101a14:	53                   	push   %ebx
80101a15:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101a18:	85 db                	test   %ebx,%ebx
80101a1a:	74 34                	je     80101a50 <iunlockput+0x40>
80101a1c:	83 ec 0c             	sub    $0xc,%esp
80101a1f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a22:	56                   	push   %esi
80101a23:	e8 98 29 00 00       	call   801043c0 <holdingsleep>
80101a28:	83 c4 10             	add    $0x10,%esp
80101a2b:	85 c0                	test   %eax,%eax
80101a2d:	74 21                	je     80101a50 <iunlockput+0x40>
80101a2f:	8b 43 08             	mov    0x8(%ebx),%eax
80101a32:	85 c0                	test   %eax,%eax
80101a34:	7e 1a                	jle    80101a50 <iunlockput+0x40>
80101a36:	83 ec 0c             	sub    $0xc,%esp
80101a39:	56                   	push   %esi
80101a3a:	e8 41 29 00 00       	call   80104380 <releasesleep>
80101a3f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a42:	83 c4 10             	add    $0x10,%esp
80101a45:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a48:	5b                   	pop    %ebx
80101a49:	5e                   	pop    %esi
80101a4a:	5d                   	pop    %ebp
80101a4b:	e9 60 fe ff ff       	jmp    801018b0 <iput>
80101a50:	83 ec 0c             	sub    $0xc,%esp
80101a53:	68 1f 7b 10 80       	push   $0x80107b1f
80101a58:	e8 23 e9 ff ff       	call   80100380 <panic>
80101a5d:	8d 76 00             	lea    0x0(%esi),%esi

80101a60 <stati>:
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	8b 55 08             	mov    0x8(%ebp),%edx
80101a66:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a69:	8b 0a                	mov    (%edx),%ecx
80101a6b:	89 48 04             	mov    %ecx,0x4(%eax)
80101a6e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a71:	89 48 08             	mov    %ecx,0x8(%eax)
80101a74:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a78:	66 89 08             	mov    %cx,(%eax)
80101a7b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a7f:	66 89 48 0c          	mov    %cx,0xc(%eax)
80101a83:	8b 52 58             	mov    0x58(%edx),%edx
80101a86:	89 50 10             	mov    %edx,0x10(%eax)
80101a89:	5d                   	pop    %ebp
80101a8a:	c3                   	ret    
80101a8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a8f:	90                   	nop

80101a90 <readi>:
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
80101aa8:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101aad:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ab0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101ab3:	0f 84 a7 00 00 00    	je     80101b60 <readi+0xd0>
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
80101adb:	89 c1                	mov    %eax,%ecx
80101add:	29 f1                	sub    %esi,%ecx
80101adf:	39 d0                	cmp    %edx,%eax
80101ae1:	0f 43 cb             	cmovae %ebx,%ecx
80101ae4:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101ae7:	85 c9                	test   %ecx,%ecx
80101ae9:	74 67                	je     80101b52 <readi+0xc2>
80101aeb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101aef:	90                   	nop
80101af0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101af3:	89 f2                	mov    %esi,%edx
80101af5:	c1 ea 09             	shr    $0x9,%edx
80101af8:	89 d8                	mov    %ebx,%eax
80101afa:	e8 51 f9 ff ff       	call   80101450 <bmap>
80101aff:	83 ec 08             	sub    $0x8,%esp
80101b02:	50                   	push   %eax
80101b03:	ff 33                	push   (%ebx)
80101b05:	e8 c6 e5 ff ff       	call   801000d0 <bread>
80101b0a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b0d:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b12:	89 c2                	mov    %eax,%edx
80101b14:	89 f0                	mov    %esi,%eax
80101b16:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b1b:	29 fb                	sub    %edi,%ebx
80101b1d:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101b20:	29 c1                	sub    %eax,%ecx
80101b22:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101b26:	39 d9                	cmp    %ebx,%ecx
80101b28:	0f 46 d9             	cmovbe %ecx,%ebx
80101b2b:	83 c4 0c             	add    $0xc,%esp
80101b2e:	53                   	push   %ebx
80101b2f:	01 df                	add    %ebx,%edi
80101b31:	01 de                	add    %ebx,%esi
80101b33:	50                   	push   %eax
80101b34:	ff 75 e0             	push   -0x20(%ebp)
80101b37:	e8 04 2c 00 00       	call   80104740 <memmove>
80101b3c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b3f:	89 14 24             	mov    %edx,(%esp)
80101b42:	e8 a9 e6 ff ff       	call   801001f0 <brelse>
80101b47:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b4a:	83 c4 10             	add    $0x10,%esp
80101b4d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b50:	77 9e                	ja     80101af0 <readi+0x60>
80101b52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b58:	5b                   	pop    %ebx
80101b59:	5e                   	pop    %esi
80101b5a:	5f                   	pop    %edi
80101b5b:	5d                   	pop    %ebp
80101b5c:	c3                   	ret    
80101b5d:	8d 76 00             	lea    0x0(%esi),%esi
80101b60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b64:	66 83 f8 09          	cmp    $0x9,%ax
80101b68:	77 17                	ja     80101b81 <readi+0xf1>
80101b6a:	8b 04 c5 00 09 11 80 	mov    -0x7feef700(,%eax,8),%eax
80101b71:	85 c0                	test   %eax,%eax
80101b73:	74 0c                	je     80101b81 <readi+0xf1>
80101b75:	89 7d 10             	mov    %edi,0x10(%ebp)
80101b78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b7b:	5b                   	pop    %ebx
80101b7c:	5e                   	pop    %esi
80101b7d:	5f                   	pop    %edi
80101b7e:	5d                   	pop    %ebp
80101b7f:	ff e0                	jmp    *%eax
80101b81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b86:	eb cd                	jmp    80101b55 <readi+0xc5>
80101b88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b8f:	90                   	nop

80101b90 <writei>:
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	57                   	push   %edi
80101b94:	56                   	push   %esi
80101b95:	53                   	push   %ebx
80101b96:	83 ec 1c             	sub    $0x1c,%esp
80101b99:	8b 45 08             	mov    0x8(%ebp),%eax
80101b9c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b9f:	8b 55 14             	mov    0x14(%ebp),%edx
80101ba2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101ba7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101baa:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101bad:	8b 75 10             	mov    0x10(%ebp),%esi
80101bb0:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101bb3:	0f 84 b7 00 00 00    	je     80101c70 <writei+0xe0>
80101bb9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bbc:	3b 70 58             	cmp    0x58(%eax),%esi
80101bbf:	0f 87 e7 00 00 00    	ja     80101cac <writei+0x11c>
80101bc5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101bc8:	31 d2                	xor    %edx,%edx
80101bca:	89 f8                	mov    %edi,%eax
80101bcc:	01 f0                	add    %esi,%eax
80101bce:	0f 92 c2             	setb   %dl
80101bd1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101bd6:	0f 87 d0 00 00 00    	ja     80101cac <writei+0x11c>
80101bdc:	85 d2                	test   %edx,%edx
80101bde:	0f 85 c8 00 00 00    	jne    80101cac <writei+0x11c>
80101be4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101beb:	85 ff                	test   %edi,%edi
80101bed:	74 72                	je     80101c61 <writei+0xd1>
80101bef:	90                   	nop
80101bf0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101bf3:	89 f2                	mov    %esi,%edx
80101bf5:	c1 ea 09             	shr    $0x9,%edx
80101bf8:	89 f8                	mov    %edi,%eax
80101bfa:	e8 51 f8 ff ff       	call   80101450 <bmap>
80101bff:	83 ec 08             	sub    $0x8,%esp
80101c02:	50                   	push   %eax
80101c03:	ff 37                	push   (%edi)
80101c05:	e8 c6 e4 ff ff       	call   801000d0 <bread>
80101c0a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101c0f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c12:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
80101c15:	89 c7                	mov    %eax,%edi
80101c17:	89 f0                	mov    %esi,%eax
80101c19:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c1e:	29 c1                	sub    %eax,%ecx
80101c20:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
80101c24:	39 d9                	cmp    %ebx,%ecx
80101c26:	0f 46 d9             	cmovbe %ecx,%ebx
80101c29:	83 c4 0c             	add    $0xc,%esp
80101c2c:	53                   	push   %ebx
80101c2d:	01 de                	add    %ebx,%esi
80101c2f:	ff 75 dc             	push   -0x24(%ebp)
80101c32:	50                   	push   %eax
80101c33:	e8 08 2b 00 00       	call   80104740 <memmove>
80101c38:	89 3c 24             	mov    %edi,(%esp)
80101c3b:	e8 00 13 00 00       	call   80102f40 <log_write>
80101c40:	89 3c 24             	mov    %edi,(%esp)
80101c43:	e8 a8 e5 ff ff       	call   801001f0 <brelse>
80101c48:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c4b:	83 c4 10             	add    $0x10,%esp
80101c4e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c51:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c54:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c57:	77 97                	ja     80101bf0 <writei+0x60>
80101c59:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c5c:	3b 70 58             	cmp    0x58(%eax),%esi
80101c5f:	77 37                	ja     80101c98 <writei+0x108>
80101c61:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101c64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c67:	5b                   	pop    %ebx
80101c68:	5e                   	pop    %esi
80101c69:	5f                   	pop    %edi
80101c6a:	5d                   	pop    %ebp
80101c6b:	c3                   	ret    
80101c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c70:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c74:	66 83 f8 09          	cmp    $0x9,%ax
80101c78:	77 32                	ja     80101cac <writei+0x11c>
80101c7a:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
80101c81:	85 c0                	test   %eax,%eax
80101c83:	74 27                	je     80101cac <writei+0x11c>
80101c85:	89 55 10             	mov    %edx,0x10(%ebp)
80101c88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c8b:	5b                   	pop    %ebx
80101c8c:	5e                   	pop    %esi
80101c8d:	5f                   	pop    %edi
80101c8e:	5d                   	pop    %ebp
80101c8f:	ff e0                	jmp    *%eax
80101c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c98:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c9b:	83 ec 0c             	sub    $0xc,%esp
80101c9e:	89 70 58             	mov    %esi,0x58(%eax)
80101ca1:	50                   	push   %eax
80101ca2:	e8 29 fa ff ff       	call   801016d0 <iupdate>
80101ca7:	83 c4 10             	add    $0x10,%esp
80101caa:	eb b5                	jmp    80101c61 <writei+0xd1>
80101cac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cb1:	eb b1                	jmp    80101c64 <writei+0xd4>
80101cb3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101cc0 <namecmp>:
80101cc0:	55                   	push   %ebp
80101cc1:	89 e5                	mov    %esp,%ebp
80101cc3:	83 ec 0c             	sub    $0xc,%esp
80101cc6:	6a 0e                	push   $0xe
80101cc8:	ff 75 0c             	push   0xc(%ebp)
80101ccb:	ff 75 08             	push   0x8(%ebp)
80101cce:	e8 dd 2a 00 00       	call   801047b0 <strncmp>
80101cd3:	c9                   	leave  
80101cd4:	c3                   	ret    
80101cd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ce0 <dirlookup>:
80101ce0:	55                   	push   %ebp
80101ce1:	89 e5                	mov    %esp,%ebp
80101ce3:	57                   	push   %edi
80101ce4:	56                   	push   %esi
80101ce5:	53                   	push   %ebx
80101ce6:	83 ec 1c             	sub    $0x1c,%esp
80101ce9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101cec:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101cf1:	0f 85 85 00 00 00    	jne    80101d7c <dirlookup+0x9c>
80101cf7:	8b 53 58             	mov    0x58(%ebx),%edx
80101cfa:	31 ff                	xor    %edi,%edi
80101cfc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101cff:	85 d2                	test   %edx,%edx
80101d01:	74 3e                	je     80101d41 <dirlookup+0x61>
80101d03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d07:	90                   	nop
80101d08:	6a 10                	push   $0x10
80101d0a:	57                   	push   %edi
80101d0b:	56                   	push   %esi
80101d0c:	53                   	push   %ebx
80101d0d:	e8 7e fd ff ff       	call   80101a90 <readi>
80101d12:	83 c4 10             	add    $0x10,%esp
80101d15:	83 f8 10             	cmp    $0x10,%eax
80101d18:	75 55                	jne    80101d6f <dirlookup+0x8f>
80101d1a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d1f:	74 18                	je     80101d39 <dirlookup+0x59>
80101d21:	83 ec 04             	sub    $0x4,%esp
80101d24:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d27:	6a 0e                	push   $0xe
80101d29:	50                   	push   %eax
80101d2a:	ff 75 0c             	push   0xc(%ebp)
80101d2d:	e8 7e 2a 00 00       	call   801047b0 <strncmp>
80101d32:	83 c4 10             	add    $0x10,%esp
80101d35:	85 c0                	test   %eax,%eax
80101d37:	74 17                	je     80101d50 <dirlookup+0x70>
80101d39:	83 c7 10             	add    $0x10,%edi
80101d3c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101d3f:	72 c7                	jb     80101d08 <dirlookup+0x28>
80101d41:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d44:	31 c0                	xor    %eax,%eax
80101d46:	5b                   	pop    %ebx
80101d47:	5e                   	pop    %esi
80101d48:	5f                   	pop    %edi
80101d49:	5d                   	pop    %ebp
80101d4a:	c3                   	ret    
80101d4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d4f:	90                   	nop
80101d50:	8b 45 10             	mov    0x10(%ebp),%eax
80101d53:	85 c0                	test   %eax,%eax
80101d55:	74 05                	je     80101d5c <dirlookup+0x7c>
80101d57:	8b 45 10             	mov    0x10(%ebp),%eax
80101d5a:	89 38                	mov    %edi,(%eax)
80101d5c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101d60:	8b 03                	mov    (%ebx),%eax
80101d62:	e8 e9 f5 ff ff       	call   80101350 <iget>
80101d67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d6a:	5b                   	pop    %ebx
80101d6b:	5e                   	pop    %esi
80101d6c:	5f                   	pop    %edi
80101d6d:	5d                   	pop    %ebp
80101d6e:	c3                   	ret    
80101d6f:	83 ec 0c             	sub    $0xc,%esp
80101d72:	68 39 7b 10 80       	push   $0x80107b39
80101d77:	e8 04 e6 ff ff       	call   80100380 <panic>
80101d7c:	83 ec 0c             	sub    $0xc,%esp
80101d7f:	68 27 7b 10 80       	push   $0x80107b27
80101d84:	e8 f7 e5 ff ff       	call   80100380 <panic>
80101d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d90 <namex>:
80101d90:	55                   	push   %ebp
80101d91:	89 e5                	mov    %esp,%ebp
80101d93:	57                   	push   %edi
80101d94:	56                   	push   %esi
80101d95:	53                   	push   %ebx
80101d96:	89 c3                	mov    %eax,%ebx
80101d98:	83 ec 1c             	sub    $0x1c,%esp
80101d9b:	80 38 2f             	cmpb   $0x2f,(%eax)
80101d9e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101da1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101da4:	0f 84 64 01 00 00    	je     80101f0e <namex+0x17e>
80101daa:	e8 01 1c 00 00       	call   801039b0 <myproc>
80101daf:	83 ec 0c             	sub    $0xc,%esp
80101db2:	8b 70 68             	mov    0x68(%eax),%esi
80101db5:	68 60 09 11 80       	push   $0x80110960
80101dba:	e8 21 28 00 00       	call   801045e0 <acquire>
80101dbf:	83 46 08 01          	addl   $0x1,0x8(%esi)
80101dc3:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101dca:	e8 b1 27 00 00       	call   80104580 <release>
80101dcf:	83 c4 10             	add    $0x10,%esp
80101dd2:	eb 07                	jmp    80101ddb <namex+0x4b>
80101dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101dd8:	83 c3 01             	add    $0x1,%ebx
80101ddb:	0f b6 03             	movzbl (%ebx),%eax
80101dde:	3c 2f                	cmp    $0x2f,%al
80101de0:	74 f6                	je     80101dd8 <namex+0x48>
80101de2:	84 c0                	test   %al,%al
80101de4:	0f 84 06 01 00 00    	je     80101ef0 <namex+0x160>
80101dea:	0f b6 03             	movzbl (%ebx),%eax
80101ded:	84 c0                	test   %al,%al
80101def:	0f 84 10 01 00 00    	je     80101f05 <namex+0x175>
80101df5:	89 df                	mov    %ebx,%edi
80101df7:	3c 2f                	cmp    $0x2f,%al
80101df9:	0f 84 06 01 00 00    	je     80101f05 <namex+0x175>
80101dff:	90                   	nop
80101e00:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80101e04:	83 c7 01             	add    $0x1,%edi
80101e07:	3c 2f                	cmp    $0x2f,%al
80101e09:	74 04                	je     80101e0f <namex+0x7f>
80101e0b:	84 c0                	test   %al,%al
80101e0d:	75 f1                	jne    80101e00 <namex+0x70>
80101e0f:	89 f8                	mov    %edi,%eax
80101e11:	29 d8                	sub    %ebx,%eax
80101e13:	83 f8 0d             	cmp    $0xd,%eax
80101e16:	0f 8e ac 00 00 00    	jle    80101ec8 <namex+0x138>
80101e1c:	83 ec 04             	sub    $0x4,%esp
80101e1f:	6a 0e                	push   $0xe
80101e21:	53                   	push   %ebx
80101e22:	89 fb                	mov    %edi,%ebx
80101e24:	ff 75 e4             	push   -0x1c(%ebp)
80101e27:	e8 14 29 00 00       	call   80104740 <memmove>
80101e2c:	83 c4 10             	add    $0x10,%esp
80101e2f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101e32:	75 0c                	jne    80101e40 <namex+0xb0>
80101e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e38:	83 c3 01             	add    $0x1,%ebx
80101e3b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e3e:	74 f8                	je     80101e38 <namex+0xa8>
80101e40:	83 ec 0c             	sub    $0xc,%esp
80101e43:	56                   	push   %esi
80101e44:	e8 37 f9 ff ff       	call   80101780 <ilock>
80101e49:	83 c4 10             	add    $0x10,%esp
80101e4c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e51:	0f 85 cd 00 00 00    	jne    80101f24 <namex+0x194>
80101e57:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e5a:	85 c0                	test   %eax,%eax
80101e5c:	74 09                	je     80101e67 <namex+0xd7>
80101e5e:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e61:	0f 84 22 01 00 00    	je     80101f89 <namex+0x1f9>
80101e67:	83 ec 04             	sub    $0x4,%esp
80101e6a:	6a 00                	push   $0x0
80101e6c:	ff 75 e4             	push   -0x1c(%ebp)
80101e6f:	56                   	push   %esi
80101e70:	e8 6b fe ff ff       	call   80101ce0 <dirlookup>
80101e75:	8d 56 0c             	lea    0xc(%esi),%edx
80101e78:	83 c4 10             	add    $0x10,%esp
80101e7b:	89 c7                	mov    %eax,%edi
80101e7d:	85 c0                	test   %eax,%eax
80101e7f:	0f 84 e1 00 00 00    	je     80101f66 <namex+0x1d6>
80101e85:	83 ec 0c             	sub    $0xc,%esp
80101e88:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101e8b:	52                   	push   %edx
80101e8c:	e8 2f 25 00 00       	call   801043c0 <holdingsleep>
80101e91:	83 c4 10             	add    $0x10,%esp
80101e94:	85 c0                	test   %eax,%eax
80101e96:	0f 84 30 01 00 00    	je     80101fcc <namex+0x23c>
80101e9c:	8b 56 08             	mov    0x8(%esi),%edx
80101e9f:	85 d2                	test   %edx,%edx
80101ea1:	0f 8e 25 01 00 00    	jle    80101fcc <namex+0x23c>
80101ea7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101eaa:	83 ec 0c             	sub    $0xc,%esp
80101ead:	52                   	push   %edx
80101eae:	e8 cd 24 00 00       	call   80104380 <releasesleep>
80101eb3:	89 34 24             	mov    %esi,(%esp)
80101eb6:	89 fe                	mov    %edi,%esi
80101eb8:	e8 f3 f9 ff ff       	call   801018b0 <iput>
80101ebd:	83 c4 10             	add    $0x10,%esp
80101ec0:	e9 16 ff ff ff       	jmp    80101ddb <namex+0x4b>
80101ec5:	8d 76 00             	lea    0x0(%esi),%esi
80101ec8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101ecb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
80101ece:	83 ec 04             	sub    $0x4,%esp
80101ed1:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101ed4:	50                   	push   %eax
80101ed5:	53                   	push   %ebx
80101ed6:	89 fb                	mov    %edi,%ebx
80101ed8:	ff 75 e4             	push   -0x1c(%ebp)
80101edb:	e8 60 28 00 00       	call   80104740 <memmove>
80101ee0:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101ee3:	83 c4 10             	add    $0x10,%esp
80101ee6:	c6 02 00             	movb   $0x0,(%edx)
80101ee9:	e9 41 ff ff ff       	jmp    80101e2f <namex+0x9f>
80101eee:	66 90                	xchg   %ax,%ax
80101ef0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101ef3:	85 c0                	test   %eax,%eax
80101ef5:	0f 85 be 00 00 00    	jne    80101fb9 <namex+0x229>
80101efb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101efe:	89 f0                	mov    %esi,%eax
80101f00:	5b                   	pop    %ebx
80101f01:	5e                   	pop    %esi
80101f02:	5f                   	pop    %edi
80101f03:	5d                   	pop    %ebp
80101f04:	c3                   	ret    
80101f05:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f08:	89 df                	mov    %ebx,%edi
80101f0a:	31 c0                	xor    %eax,%eax
80101f0c:	eb c0                	jmp    80101ece <namex+0x13e>
80101f0e:	ba 01 00 00 00       	mov    $0x1,%edx
80101f13:	b8 01 00 00 00       	mov    $0x1,%eax
80101f18:	e8 33 f4 ff ff       	call   80101350 <iget>
80101f1d:	89 c6                	mov    %eax,%esi
80101f1f:	e9 b7 fe ff ff       	jmp    80101ddb <namex+0x4b>
80101f24:	83 ec 0c             	sub    $0xc,%esp
80101f27:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f2a:	53                   	push   %ebx
80101f2b:	e8 90 24 00 00       	call   801043c0 <holdingsleep>
80101f30:	83 c4 10             	add    $0x10,%esp
80101f33:	85 c0                	test   %eax,%eax
80101f35:	0f 84 91 00 00 00    	je     80101fcc <namex+0x23c>
80101f3b:	8b 46 08             	mov    0x8(%esi),%eax
80101f3e:	85 c0                	test   %eax,%eax
80101f40:	0f 8e 86 00 00 00    	jle    80101fcc <namex+0x23c>
80101f46:	83 ec 0c             	sub    $0xc,%esp
80101f49:	53                   	push   %ebx
80101f4a:	e8 31 24 00 00       	call   80104380 <releasesleep>
80101f4f:	89 34 24             	mov    %esi,(%esp)
80101f52:	31 f6                	xor    %esi,%esi
80101f54:	e8 57 f9 ff ff       	call   801018b0 <iput>
80101f59:	83 c4 10             	add    $0x10,%esp
80101f5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f5f:	89 f0                	mov    %esi,%eax
80101f61:	5b                   	pop    %ebx
80101f62:	5e                   	pop    %esi
80101f63:	5f                   	pop    %edi
80101f64:	5d                   	pop    %ebp
80101f65:	c3                   	ret    
80101f66:	83 ec 0c             	sub    $0xc,%esp
80101f69:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101f6c:	52                   	push   %edx
80101f6d:	e8 4e 24 00 00       	call   801043c0 <holdingsleep>
80101f72:	83 c4 10             	add    $0x10,%esp
80101f75:	85 c0                	test   %eax,%eax
80101f77:	74 53                	je     80101fcc <namex+0x23c>
80101f79:	8b 4e 08             	mov    0x8(%esi),%ecx
80101f7c:	85 c9                	test   %ecx,%ecx
80101f7e:	7e 4c                	jle    80101fcc <namex+0x23c>
80101f80:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f83:	83 ec 0c             	sub    $0xc,%esp
80101f86:	52                   	push   %edx
80101f87:	eb c1                	jmp    80101f4a <namex+0x1ba>
80101f89:	83 ec 0c             	sub    $0xc,%esp
80101f8c:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f8f:	53                   	push   %ebx
80101f90:	e8 2b 24 00 00       	call   801043c0 <holdingsleep>
80101f95:	83 c4 10             	add    $0x10,%esp
80101f98:	85 c0                	test   %eax,%eax
80101f9a:	74 30                	je     80101fcc <namex+0x23c>
80101f9c:	8b 7e 08             	mov    0x8(%esi),%edi
80101f9f:	85 ff                	test   %edi,%edi
80101fa1:	7e 29                	jle    80101fcc <namex+0x23c>
80101fa3:	83 ec 0c             	sub    $0xc,%esp
80101fa6:	53                   	push   %ebx
80101fa7:	e8 d4 23 00 00       	call   80104380 <releasesleep>
80101fac:	83 c4 10             	add    $0x10,%esp
80101faf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fb2:	89 f0                	mov    %esi,%eax
80101fb4:	5b                   	pop    %ebx
80101fb5:	5e                   	pop    %esi
80101fb6:	5f                   	pop    %edi
80101fb7:	5d                   	pop    %ebp
80101fb8:	c3                   	ret    
80101fb9:	83 ec 0c             	sub    $0xc,%esp
80101fbc:	56                   	push   %esi
80101fbd:	31 f6                	xor    %esi,%esi
80101fbf:	e8 ec f8 ff ff       	call   801018b0 <iput>
80101fc4:	83 c4 10             	add    $0x10,%esp
80101fc7:	e9 2f ff ff ff       	jmp    80101efb <namex+0x16b>
80101fcc:	83 ec 0c             	sub    $0xc,%esp
80101fcf:	68 1f 7b 10 80       	push   $0x80107b1f
80101fd4:	e8 a7 e3 ff ff       	call   80100380 <panic>
80101fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101fe0 <dirlink>:
80101fe0:	55                   	push   %ebp
80101fe1:	89 e5                	mov    %esp,%ebp
80101fe3:	57                   	push   %edi
80101fe4:	56                   	push   %esi
80101fe5:	53                   	push   %ebx
80101fe6:	83 ec 20             	sub    $0x20,%esp
80101fe9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101fec:	6a 00                	push   $0x0
80101fee:	ff 75 0c             	push   0xc(%ebp)
80101ff1:	53                   	push   %ebx
80101ff2:	e8 e9 fc ff ff       	call   80101ce0 <dirlookup>
80101ff7:	83 c4 10             	add    $0x10,%esp
80101ffa:	85 c0                	test   %eax,%eax
80101ffc:	75 67                	jne    80102065 <dirlink+0x85>
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
80102018:	6a 10                	push   $0x10
8010201a:	57                   	push   %edi
8010201b:	56                   	push   %esi
8010201c:	53                   	push   %ebx
8010201d:	e8 6e fa ff ff       	call   80101a90 <readi>
80102022:	83 c4 10             	add    $0x10,%esp
80102025:	83 f8 10             	cmp    $0x10,%eax
80102028:	75 4e                	jne    80102078 <dirlink+0x98>
8010202a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010202f:	75 df                	jne    80102010 <dirlink+0x30>
80102031:	83 ec 04             	sub    $0x4,%esp
80102034:	8d 45 da             	lea    -0x26(%ebp),%eax
80102037:	6a 0e                	push   $0xe
80102039:	ff 75 0c             	push   0xc(%ebp)
8010203c:	50                   	push   %eax
8010203d:	e8 be 27 00 00       	call   80104800 <strncpy>
80102042:	6a 10                	push   $0x10
80102044:	8b 45 10             	mov    0x10(%ebp),%eax
80102047:	57                   	push   %edi
80102048:	56                   	push   %esi
80102049:	53                   	push   %ebx
8010204a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
8010204e:	e8 3d fb ff ff       	call   80101b90 <writei>
80102053:	83 c4 20             	add    $0x20,%esp
80102056:	83 f8 10             	cmp    $0x10,%eax
80102059:	75 2a                	jne    80102085 <dirlink+0xa5>
8010205b:	31 c0                	xor    %eax,%eax
8010205d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102060:	5b                   	pop    %ebx
80102061:	5e                   	pop    %esi
80102062:	5f                   	pop    %edi
80102063:	5d                   	pop    %ebp
80102064:	c3                   	ret    
80102065:	83 ec 0c             	sub    $0xc,%esp
80102068:	50                   	push   %eax
80102069:	e8 42 f8 ff ff       	call   801018b0 <iput>
8010206e:	83 c4 10             	add    $0x10,%esp
80102071:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102076:	eb e5                	jmp    8010205d <dirlink+0x7d>
80102078:	83 ec 0c             	sub    $0xc,%esp
8010207b:	68 48 7b 10 80       	push   $0x80107b48
80102080:	e8 fb e2 ff ff       	call   80100380 <panic>
80102085:	83 ec 0c             	sub    $0xc,%esp
80102088:	68 32 81 10 80       	push   $0x80108132
8010208d:	e8 ee e2 ff ff       	call   80100380 <panic>
80102092:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801020a0 <namei>:
801020a0:	55                   	push   %ebp
801020a1:	31 d2                	xor    %edx,%edx
801020a3:	89 e5                	mov    %esp,%ebp
801020a5:	83 ec 18             	sub    $0x18,%esp
801020a8:	8b 45 08             	mov    0x8(%ebp),%eax
801020ab:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801020ae:	e8 dd fc ff ff       	call   80101d90 <namex>
801020b3:	c9                   	leave  
801020b4:	c3                   	ret    
801020b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020c0 <nameiparent>:
801020c0:	55                   	push   %ebp
801020c1:	ba 01 00 00 00       	mov    $0x1,%edx
801020c6:	89 e5                	mov    %esp,%ebp
801020c8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801020cb:	8b 45 08             	mov    0x8(%ebp),%eax
801020ce:	5d                   	pop    %ebp
801020cf:	e9 bc fc ff ff       	jmp    80101d90 <namex>
801020d4:	66 90                	xchg   %ax,%ax
801020d6:	66 90                	xchg   %ax,%ax
801020d8:	66 90                	xchg   %ax,%ax
801020da:	66 90                	xchg   %ax,%ax
801020dc:	66 90                	xchg   %ax,%ax
801020de:	66 90                	xchg   %ax,%ax

801020e0 <idestart>:
801020e0:	55                   	push   %ebp
801020e1:	89 e5                	mov    %esp,%ebp
801020e3:	57                   	push   %edi
801020e4:	56                   	push   %esi
801020e5:	53                   	push   %ebx
801020e6:	83 ec 0c             	sub    $0xc,%esp
801020e9:	85 c0                	test   %eax,%eax
801020eb:	0f 84 b4 00 00 00    	je     801021a5 <idestart+0xc5>
801020f1:	8b 70 08             	mov    0x8(%eax),%esi
801020f4:	89 c3                	mov    %eax,%ebx
801020f6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801020fc:	0f 87 96 00 00 00    	ja     80102198 <idestart+0xb8>
80102102:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102107:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010210e:	66 90                	xchg   %ax,%ax
80102110:	89 ca                	mov    %ecx,%edx
80102112:	ec                   	in     (%dx),%al
80102113:	83 e0 c0             	and    $0xffffffc0,%eax
80102116:	3c 40                	cmp    $0x40,%al
80102118:	75 f6                	jne    80102110 <idestart+0x30>
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
80102137:	89 f0                	mov    %esi,%eax
80102139:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010213e:	c1 f8 08             	sar    $0x8,%eax
80102141:	ee                   	out    %al,(%dx)
80102142:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102147:	89 f8                	mov    %edi,%eax
80102149:	ee                   	out    %al,(%dx)
8010214a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010214e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102153:	c1 e0 04             	shl    $0x4,%eax
80102156:	83 e0 10             	and    $0x10,%eax
80102159:	83 c8 e0             	or     $0xffffffe0,%eax
8010215c:	ee                   	out    %al,(%dx)
8010215d:	f6 03 04             	testb  $0x4,(%ebx)
80102160:	75 16                	jne    80102178 <idestart+0x98>
80102162:	b8 20 00 00 00       	mov    $0x20,%eax
80102167:	89 ca                	mov    %ecx,%edx
80102169:	ee                   	out    %al,(%dx)
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
80102180:	b9 80 00 00 00       	mov    $0x80,%ecx
80102185:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102188:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010218d:	fc                   	cld    
8010218e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102190:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102193:	5b                   	pop    %ebx
80102194:	5e                   	pop    %esi
80102195:	5f                   	pop    %edi
80102196:	5d                   	pop    %ebp
80102197:	c3                   	ret    
80102198:	83 ec 0c             	sub    $0xc,%esp
8010219b:	68 b4 7b 10 80       	push   $0x80107bb4
801021a0:	e8 db e1 ff ff       	call   80100380 <panic>
801021a5:	83 ec 0c             	sub    $0xc,%esp
801021a8:	68 ab 7b 10 80       	push   $0x80107bab
801021ad:	e8 ce e1 ff ff       	call   80100380 <panic>
801021b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021c0 <ideinit>:
801021c0:	55                   	push   %ebp
801021c1:	89 e5                	mov    %esp,%ebp
801021c3:	83 ec 10             	sub    $0x10,%esp
801021c6:	68 c6 7b 10 80       	push   $0x80107bc6
801021cb:	68 00 26 11 80       	push   $0x80112600
801021d0:	e8 3b 22 00 00       	call   80104410 <initlock>
801021d5:	58                   	pop    %eax
801021d6:	a1 84 27 11 80       	mov    0x80112784,%eax
801021db:	5a                   	pop    %edx
801021dc:	83 e8 01             	sub    $0x1,%eax
801021df:	50                   	push   %eax
801021e0:	6a 0e                	push   $0xe
801021e2:	e8 99 02 00 00       	call   80102480 <ioapicenable>
801021e7:	83 c4 10             	add    $0x10,%esp
801021ea:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021ef:	90                   	nop
801021f0:	ec                   	in     (%dx),%al
801021f1:	83 e0 c0             	and    $0xffffffc0,%eax
801021f4:	3c 40                	cmp    $0x40,%al
801021f6:	75 f8                	jne    801021f0 <ideinit+0x30>
801021f8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801021fd:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102202:	ee                   	out    %al,(%dx)
80102203:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102208:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010220d:	eb 06                	jmp    80102215 <ideinit+0x55>
8010220f:	90                   	nop
80102210:	83 e9 01             	sub    $0x1,%ecx
80102213:	74 0f                	je     80102224 <ideinit+0x64>
80102215:	ec                   	in     (%dx),%al
80102216:	84 c0                	test   %al,%al
80102218:	74 f6                	je     80102210 <ideinit+0x50>
8010221a:	c7 05 e0 25 11 80 01 	movl   $0x1,0x801125e0
80102221:	00 00 00 
80102224:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102229:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010222e:	ee                   	out    %al,(%dx)
8010222f:	c9                   	leave  
80102230:	c3                   	ret    
80102231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010223f:	90                   	nop

80102240 <ideintr>:
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	57                   	push   %edi
80102244:	56                   	push   %esi
80102245:	53                   	push   %ebx
80102246:	83 ec 18             	sub    $0x18,%esp
80102249:	68 00 26 11 80       	push   $0x80112600
8010224e:	e8 8d 23 00 00       	call   801045e0 <acquire>
80102253:	8b 1d e4 25 11 80    	mov    0x801125e4,%ebx
80102259:	83 c4 10             	add    $0x10,%esp
8010225c:	85 db                	test   %ebx,%ebx
8010225e:	74 63                	je     801022c3 <ideintr+0x83>
80102260:	8b 43 58             	mov    0x58(%ebx),%eax
80102263:	a3 e4 25 11 80       	mov    %eax,0x801125e4
80102268:	8b 33                	mov    (%ebx),%esi
8010226a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102270:	75 2f                	jne    801022a1 <ideintr+0x61>
80102272:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010227e:	66 90                	xchg   %ax,%ax
80102280:	ec                   	in     (%dx),%al
80102281:	89 c1                	mov    %eax,%ecx
80102283:	83 e1 c0             	and    $0xffffffc0,%ecx
80102286:	80 f9 40             	cmp    $0x40,%cl
80102289:	75 f5                	jne    80102280 <ideintr+0x40>
8010228b:	a8 21                	test   $0x21,%al
8010228d:	75 12                	jne    801022a1 <ideintr+0x61>
8010228f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
80102292:	b9 80 00 00 00       	mov    $0x80,%ecx
80102297:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010229c:	fc                   	cld    
8010229d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010229f:	8b 33                	mov    (%ebx),%esi
801022a1:	83 e6 fb             	and    $0xfffffffb,%esi
801022a4:	83 ec 0c             	sub    $0xc,%esp
801022a7:	83 ce 02             	or     $0x2,%esi
801022aa:	89 33                	mov    %esi,(%ebx)
801022ac:	53                   	push   %ebx
801022ad:	e8 8e 1e 00 00       	call   80104140 <wakeup>
801022b2:	a1 e4 25 11 80       	mov    0x801125e4,%eax
801022b7:	83 c4 10             	add    $0x10,%esp
801022ba:	85 c0                	test   %eax,%eax
801022bc:	74 05                	je     801022c3 <ideintr+0x83>
801022be:	e8 1d fe ff ff       	call   801020e0 <idestart>
801022c3:	83 ec 0c             	sub    $0xc,%esp
801022c6:	68 00 26 11 80       	push   $0x80112600
801022cb:	e8 b0 22 00 00       	call   80104580 <release>
801022d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022d3:	5b                   	pop    %ebx
801022d4:	5e                   	pop    %esi
801022d5:	5f                   	pop    %edi
801022d6:	5d                   	pop    %ebp
801022d7:	c3                   	ret    
801022d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022df:	90                   	nop

801022e0 <iderw>:
801022e0:	55                   	push   %ebp
801022e1:	89 e5                	mov    %esp,%ebp
801022e3:	53                   	push   %ebx
801022e4:	83 ec 10             	sub    $0x10,%esp
801022e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801022ea:	8d 43 0c             	lea    0xc(%ebx),%eax
801022ed:	50                   	push   %eax
801022ee:	e8 cd 20 00 00       	call   801043c0 <holdingsleep>
801022f3:	83 c4 10             	add    $0x10,%esp
801022f6:	85 c0                	test   %eax,%eax
801022f8:	0f 84 c3 00 00 00    	je     801023c1 <iderw+0xe1>
801022fe:	8b 03                	mov    (%ebx),%eax
80102300:	83 e0 06             	and    $0x6,%eax
80102303:	83 f8 02             	cmp    $0x2,%eax
80102306:	0f 84 a8 00 00 00    	je     801023b4 <iderw+0xd4>
8010230c:	8b 53 04             	mov    0x4(%ebx),%edx
8010230f:	85 d2                	test   %edx,%edx
80102311:	74 0d                	je     80102320 <iderw+0x40>
80102313:	a1 e0 25 11 80       	mov    0x801125e0,%eax
80102318:	85 c0                	test   %eax,%eax
8010231a:	0f 84 87 00 00 00    	je     801023a7 <iderw+0xc7>
80102320:	83 ec 0c             	sub    $0xc,%esp
80102323:	68 00 26 11 80       	push   $0x80112600
80102328:	e8 b3 22 00 00       	call   801045e0 <acquire>
8010232d:	a1 e4 25 11 80       	mov    0x801125e4,%eax
80102332:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
80102339:	83 c4 10             	add    $0x10,%esp
8010233c:	85 c0                	test   %eax,%eax
8010233e:	74 60                	je     801023a0 <iderw+0xc0>
80102340:	89 c2                	mov    %eax,%edx
80102342:	8b 40 58             	mov    0x58(%eax),%eax
80102345:	85 c0                	test   %eax,%eax
80102347:	75 f7                	jne    80102340 <iderw+0x60>
80102349:	83 c2 58             	add    $0x58,%edx
8010234c:	89 1a                	mov    %ebx,(%edx)
8010234e:	39 1d e4 25 11 80    	cmp    %ebx,0x801125e4
80102354:	74 3a                	je     80102390 <iderw+0xb0>
80102356:	8b 03                	mov    (%ebx),%eax
80102358:	83 e0 06             	and    $0x6,%eax
8010235b:	83 f8 02             	cmp    $0x2,%eax
8010235e:	74 1b                	je     8010237b <iderw+0x9b>
80102360:	83 ec 08             	sub    $0x8,%esp
80102363:	68 00 26 11 80       	push   $0x80112600
80102368:	53                   	push   %ebx
80102369:	e8 12 1d 00 00       	call   80104080 <sleep>
8010236e:	8b 03                	mov    (%ebx),%eax
80102370:	83 c4 10             	add    $0x10,%esp
80102373:	83 e0 06             	and    $0x6,%eax
80102376:	83 f8 02             	cmp    $0x2,%eax
80102379:	75 e5                	jne    80102360 <iderw+0x80>
8010237b:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
80102382:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102385:	c9                   	leave  
80102386:	e9 f5 21 00 00       	jmp    80104580 <release>
8010238b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010238f:	90                   	nop
80102390:	89 d8                	mov    %ebx,%eax
80102392:	e8 49 fd ff ff       	call   801020e0 <idestart>
80102397:	eb bd                	jmp    80102356 <iderw+0x76>
80102399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023a0:	ba e4 25 11 80       	mov    $0x801125e4,%edx
801023a5:	eb a5                	jmp    8010234c <iderw+0x6c>
801023a7:	83 ec 0c             	sub    $0xc,%esp
801023aa:	68 f5 7b 10 80       	push   $0x80107bf5
801023af:	e8 cc df ff ff       	call   80100380 <panic>
801023b4:	83 ec 0c             	sub    $0xc,%esp
801023b7:	68 e0 7b 10 80       	push   $0x80107be0
801023bc:	e8 bf df ff ff       	call   80100380 <panic>
801023c1:	83 ec 0c             	sub    $0xc,%esp
801023c4:	68 ca 7b 10 80       	push   $0x80107bca
801023c9:	e8 b2 df ff ff       	call   80100380 <panic>
801023ce:	66 90                	xchg   %ax,%ax

801023d0 <ioapicinit>:
801023d0:	55                   	push   %ebp
801023d1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801023d8:	00 c0 fe 
801023db:	89 e5                	mov    %esp,%ebp
801023dd:	56                   	push   %esi
801023de:	53                   	push   %ebx
801023df:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801023e6:	00 00 00 
801023e9:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801023ef:	8b 72 10             	mov    0x10(%edx),%esi
801023f2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
801023f8:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801023fe:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80102405:	c1 ee 10             	shr    $0x10,%esi
80102408:	89 f0                	mov    %esi,%eax
8010240a:	0f b6 f0             	movzbl %al,%esi
8010240d:	8b 41 10             	mov    0x10(%ecx),%eax
80102410:	c1 e8 18             	shr    $0x18,%eax
80102413:	39 c2                	cmp    %eax,%edx
80102415:	74 16                	je     8010242d <ioapicinit+0x5d>
80102417:	83 ec 0c             	sub    $0xc,%esp
8010241a:	68 14 7c 10 80       	push   $0x80107c14
8010241f:	e8 7c e2 ff ff       	call   801006a0 <cprintf>
80102424:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010242a:	83 c4 10             	add    $0x10,%esp
8010242d:	83 c6 21             	add    $0x21,%esi
80102430:	ba 10 00 00 00       	mov    $0x10,%edx
80102435:	b8 20 00 00 00       	mov    $0x20,%eax
8010243a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102440:	89 11                	mov    %edx,(%ecx)
80102442:	89 c3                	mov    %eax,%ebx
80102444:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010244a:	83 c0 01             	add    $0x1,%eax
8010244d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102453:	89 59 10             	mov    %ebx,0x10(%ecx)
80102456:	8d 5a 01             	lea    0x1(%edx),%ebx
80102459:	83 c2 02             	add    $0x2,%edx
8010245c:	89 19                	mov    %ebx,(%ecx)
8010245e:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102464:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
8010246b:	39 f0                	cmp    %esi,%eax
8010246d:	75 d1                	jne    80102440 <ioapicinit+0x70>
8010246f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102472:	5b                   	pop    %ebx
80102473:	5e                   	pop    %esi
80102474:	5d                   	pop    %ebp
80102475:	c3                   	ret    
80102476:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010247d:	8d 76 00             	lea    0x0(%esi),%esi

80102480 <ioapicenable>:
80102480:	55                   	push   %ebp
80102481:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102487:	89 e5                	mov    %esp,%ebp
80102489:	8b 45 08             	mov    0x8(%ebp),%eax
8010248c:	8d 50 20             	lea    0x20(%eax),%edx
8010248f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
80102493:	89 01                	mov    %eax,(%ecx)
80102495:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010249b:	83 c0 01             	add    $0x1,%eax
8010249e:	89 51 10             	mov    %edx,0x10(%ecx)
801024a1:	8b 55 0c             	mov    0xc(%ebp),%edx
801024a4:	89 01                	mov    %eax,(%ecx)
801024a6:	a1 34 26 11 80       	mov    0x80112634,%eax
801024ab:	c1 e2 18             	shl    $0x18,%edx
801024ae:	89 50 10             	mov    %edx,0x10(%eax)
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
801024c0:	55                   	push   %ebp
801024c1:	89 e5                	mov    %esp,%ebp
801024c3:	53                   	push   %ebx
801024c4:	83 ec 04             	sub    $0x4,%esp
801024c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801024ca:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801024d0:	75 76                	jne    80102548 <kfree+0x88>
801024d2:	81 fb d0 a6 12 80    	cmp    $0x8012a6d0,%ebx
801024d8:	72 6e                	jb     80102548 <kfree+0x88>
801024da:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024e0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024e5:	77 61                	ja     80102548 <kfree+0x88>
801024e7:	83 ec 04             	sub    $0x4,%esp
801024ea:	68 00 10 00 00       	push   $0x1000
801024ef:	6a 01                	push   $0x1
801024f1:	53                   	push   %ebx
801024f2:	e8 a9 21 00 00       	call   801046a0 <memset>
801024f7:	8b 15 74 26 11 80    	mov    0x80112674,%edx
801024fd:	83 c4 10             	add    $0x10,%esp
80102500:	85 d2                	test   %edx,%edx
80102502:	75 1c                	jne    80102520 <kfree+0x60>
80102504:	a1 78 26 11 80       	mov    0x80112678,%eax
80102509:	89 03                	mov    %eax,(%ebx)
8010250b:	a1 74 26 11 80       	mov    0x80112674,%eax
80102510:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
80102516:	85 c0                	test   %eax,%eax
80102518:	75 1e                	jne    80102538 <kfree+0x78>
8010251a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010251d:	c9                   	leave  
8010251e:	c3                   	ret    
8010251f:	90                   	nop
80102520:	83 ec 0c             	sub    $0xc,%esp
80102523:	68 40 26 11 80       	push   $0x80112640
80102528:	e8 b3 20 00 00       	call   801045e0 <acquire>
8010252d:	83 c4 10             	add    $0x10,%esp
80102530:	eb d2                	jmp    80102504 <kfree+0x44>
80102532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102538:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
8010253f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102542:	c9                   	leave  
80102543:	e9 38 20 00 00       	jmp    80104580 <release>
80102548:	83 ec 0c             	sub    $0xc,%esp
8010254b:	68 46 7c 10 80       	push   $0x80107c46
80102550:	e8 2b de ff ff       	call   80100380 <panic>
80102555:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010255c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102560 <freerange>:
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	56                   	push   %esi
80102564:	8b 45 08             	mov    0x8(%ebp),%eax
80102567:	8b 75 0c             	mov    0xc(%ebp),%esi
8010256a:	53                   	push   %ebx
8010256b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102571:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102577:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010257d:	39 de                	cmp    %ebx,%esi
8010257f:	72 23                	jb     801025a4 <freerange+0x44>
80102581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102588:	83 ec 0c             	sub    $0xc,%esp
8010258b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102591:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102597:	50                   	push   %eax
80102598:	e8 23 ff ff ff       	call   801024c0 <kfree>
8010259d:	83 c4 10             	add    $0x10,%esp
801025a0:	39 f3                	cmp    %esi,%ebx
801025a2:	76 e4                	jbe    80102588 <freerange+0x28>
801025a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025a7:	5b                   	pop    %ebx
801025a8:	5e                   	pop    %esi
801025a9:	5d                   	pop    %ebp
801025aa:	c3                   	ret    
801025ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025af:	90                   	nop

801025b0 <kinit2>:
801025b0:	55                   	push   %ebp
801025b1:	89 e5                	mov    %esp,%ebp
801025b3:	56                   	push   %esi
801025b4:	8b 45 08             	mov    0x8(%ebp),%eax
801025b7:	8b 75 0c             	mov    0xc(%ebp),%esi
801025ba:	53                   	push   %ebx
801025bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801025c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025cd:	39 de                	cmp    %ebx,%esi
801025cf:	72 23                	jb     801025f4 <kinit2+0x44>
801025d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025d8:	83 ec 0c             	sub    $0xc,%esp
801025db:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801025e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025e7:	50                   	push   %eax
801025e8:	e8 d3 fe ff ff       	call   801024c0 <kfree>
801025ed:	83 c4 10             	add    $0x10,%esp
801025f0:	39 de                	cmp    %ebx,%esi
801025f2:	73 e4                	jae    801025d8 <kinit2+0x28>
801025f4:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
801025fb:	00 00 00 
801025fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102601:	5b                   	pop    %ebx
80102602:	5e                   	pop    %esi
80102603:	5d                   	pop    %ebp
80102604:	c3                   	ret    
80102605:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010260c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102610 <kinit1>:
80102610:	55                   	push   %ebp
80102611:	89 e5                	mov    %esp,%ebp
80102613:	56                   	push   %esi
80102614:	53                   	push   %ebx
80102615:	8b 75 0c             	mov    0xc(%ebp),%esi
80102618:	83 ec 08             	sub    $0x8,%esp
8010261b:	68 4c 7c 10 80       	push   $0x80107c4c
80102620:	68 40 26 11 80       	push   $0x80112640
80102625:	e8 e6 1d 00 00       	call   80104410 <initlock>
8010262a:	8b 45 08             	mov    0x8(%ebp),%eax
8010262d:	83 c4 10             	add    $0x10,%esp
80102630:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102637:	00 00 00 
8010263a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102640:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102646:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010264c:	39 de                	cmp    %ebx,%esi
8010264e:	72 1c                	jb     8010266c <kinit1+0x5c>
80102650:	83 ec 0c             	sub    $0xc,%esp
80102653:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102659:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010265f:	50                   	push   %eax
80102660:	e8 5b fe ff ff       	call   801024c0 <kfree>
80102665:	83 c4 10             	add    $0x10,%esp
80102668:	39 de                	cmp    %ebx,%esi
8010266a:	73 e4                	jae    80102650 <kinit1+0x40>
8010266c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010266f:	5b                   	pop    %ebx
80102670:	5e                   	pop    %esi
80102671:	5d                   	pop    %ebp
80102672:	c3                   	ret    
80102673:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010267a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102680 <kalloc>:
80102680:	a1 74 26 11 80       	mov    0x80112674,%eax
80102685:	85 c0                	test   %eax,%eax
80102687:	75 1f                	jne    801026a8 <kalloc+0x28>
80102689:	a1 78 26 11 80       	mov    0x80112678,%eax
8010268e:	85 c0                	test   %eax,%eax
80102690:	74 0e                	je     801026a0 <kalloc+0x20>
80102692:	8b 10                	mov    (%eax),%edx
80102694:	89 15 78 26 11 80    	mov    %edx,0x80112678
8010269a:	c3                   	ret    
8010269b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010269f:	90                   	nop
801026a0:	c3                   	ret    
801026a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026a8:	55                   	push   %ebp
801026a9:	89 e5                	mov    %esp,%ebp
801026ab:	83 ec 24             	sub    $0x24,%esp
801026ae:	68 40 26 11 80       	push   $0x80112640
801026b3:	e8 28 1f 00 00       	call   801045e0 <acquire>
801026b8:	a1 78 26 11 80       	mov    0x80112678,%eax
801026bd:	8b 15 74 26 11 80    	mov    0x80112674,%edx
801026c3:	83 c4 10             	add    $0x10,%esp
801026c6:	85 c0                	test   %eax,%eax
801026c8:	74 08                	je     801026d2 <kalloc+0x52>
801026ca:	8b 08                	mov    (%eax),%ecx
801026cc:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
801026d2:	85 d2                	test   %edx,%edx
801026d4:	74 16                	je     801026ec <kalloc+0x6c>
801026d6:	83 ec 0c             	sub    $0xc,%esp
801026d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801026dc:	68 40 26 11 80       	push   $0x80112640
801026e1:	e8 9a 1e 00 00       	call   80104580 <release>
801026e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801026e9:	83 c4 10             	add    $0x10,%esp
801026ec:	c9                   	leave  
801026ed:	c3                   	ret    
801026ee:	66 90                	xchg   %ax,%ax

801026f0 <kbdgetc>:
801026f0:	ba 64 00 00 00       	mov    $0x64,%edx
801026f5:	ec                   	in     (%dx),%al
801026f6:	a8 01                	test   $0x1,%al
801026f8:	0f 84 c2 00 00 00    	je     801027c0 <kbdgetc+0xd0>
801026fe:	55                   	push   %ebp
801026ff:	ba 60 00 00 00       	mov    $0x60,%edx
80102704:	89 e5                	mov    %esp,%ebp
80102706:	53                   	push   %ebx
80102707:	ec                   	in     (%dx),%al
80102708:	8b 1d 7c 26 11 80    	mov    0x8011267c,%ebx
8010270e:	0f b6 c8             	movzbl %al,%ecx
80102711:	3c e0                	cmp    $0xe0,%al
80102713:	74 5b                	je     80102770 <kbdgetc+0x80>
80102715:	89 da                	mov    %ebx,%edx
80102717:	83 e2 40             	and    $0x40,%edx
8010271a:	84 c0                	test   %al,%al
8010271c:	78 62                	js     80102780 <kbdgetc+0x90>
8010271e:	85 d2                	test   %edx,%edx
80102720:	74 09                	je     8010272b <kbdgetc+0x3b>
80102722:	83 c8 80             	or     $0xffffff80,%eax
80102725:	83 e3 bf             	and    $0xffffffbf,%ebx
80102728:	0f b6 c8             	movzbl %al,%ecx
8010272b:	0f b6 91 80 7d 10 80 	movzbl -0x7fef8280(%ecx),%edx
80102732:	0f b6 81 80 7c 10 80 	movzbl -0x7fef8380(%ecx),%eax
80102739:	09 da                	or     %ebx,%edx
8010273b:	31 c2                	xor    %eax,%edx
8010273d:	89 d0                	mov    %edx,%eax
8010273f:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
80102745:	83 e0 03             	and    $0x3,%eax
80102748:	83 e2 08             	and    $0x8,%edx
8010274b:	8b 04 85 60 7c 10 80 	mov    -0x7fef83a0(,%eax,4),%eax
80102752:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
80102756:	74 0b                	je     80102763 <kbdgetc+0x73>
80102758:	8d 50 9f             	lea    -0x61(%eax),%edx
8010275b:	83 fa 19             	cmp    $0x19,%edx
8010275e:	77 48                	ja     801027a8 <kbdgetc+0xb8>
80102760:	83 e8 20             	sub    $0x20,%eax
80102763:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102766:	c9                   	leave  
80102767:	c3                   	ret    
80102768:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010276f:	90                   	nop
80102770:	83 cb 40             	or     $0x40,%ebx
80102773:	31 c0                	xor    %eax,%eax
80102775:	89 1d 7c 26 11 80    	mov    %ebx,0x8011267c
8010277b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010277e:	c9                   	leave  
8010277f:	c3                   	ret    
80102780:	83 e0 7f             	and    $0x7f,%eax
80102783:	85 d2                	test   %edx,%edx
80102785:	0f 44 c8             	cmove  %eax,%ecx
80102788:	0f b6 81 80 7d 10 80 	movzbl -0x7fef8280(%ecx),%eax
8010278f:	83 c8 40             	or     $0x40,%eax
80102792:	0f b6 c0             	movzbl %al,%eax
80102795:	f7 d0                	not    %eax
80102797:	21 d8                	and    %ebx,%eax
80102799:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010279c:	a3 7c 26 11 80       	mov    %eax,0x8011267c
801027a1:	31 c0                	xor    %eax,%eax
801027a3:	c9                   	leave  
801027a4:	c3                   	ret    
801027a5:	8d 76 00             	lea    0x0(%esi),%esi
801027a8:	8d 48 bf             	lea    -0x41(%eax),%ecx
801027ab:	8d 50 20             	lea    0x20(%eax),%edx
801027ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027b1:	c9                   	leave  
801027b2:	83 f9 1a             	cmp    $0x1a,%ecx
801027b5:	0f 42 c2             	cmovb  %edx,%eax
801027b8:	c3                   	ret    
801027b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801027c5:	c3                   	ret    
801027c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027cd:	8d 76 00             	lea    0x0(%esi),%esi

801027d0 <kbdintr>:
801027d0:	55                   	push   %ebp
801027d1:	89 e5                	mov    %esp,%ebp
801027d3:	83 ec 14             	sub    $0x14,%esp
801027d6:	68 f0 26 10 80       	push   $0x801026f0
801027db:	e8 a0 e0 ff ff       	call   80100880 <consoleintr>
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
801027f0:	a1 80 26 11 80       	mov    0x80112680,%eax
801027f5:	85 c0                	test   %eax,%eax
801027f7:	0f 84 cb 00 00 00    	je     801028c8 <lapicinit+0xd8>
801027fd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102804:	01 00 00 
80102807:	8b 50 20             	mov    0x20(%eax),%edx
8010280a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102811:	00 00 00 
80102814:	8b 50 20             	mov    0x20(%eax),%edx
80102817:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010281e:	00 02 00 
80102821:	8b 50 20             	mov    0x20(%eax),%edx
80102824:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010282b:	96 98 00 
8010282e:	8b 50 20             	mov    0x20(%eax),%edx
80102831:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102838:	00 01 00 
8010283b:	8b 50 20             	mov    0x20(%eax),%edx
8010283e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102845:	00 01 00 
80102848:	8b 50 20             	mov    0x20(%eax),%edx
8010284b:	8b 50 30             	mov    0x30(%eax),%edx
8010284e:	c1 ea 10             	shr    $0x10,%edx
80102851:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102857:	75 77                	jne    801028d0 <lapicinit+0xe0>
80102859:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102860:	00 00 00 
80102863:	8b 50 20             	mov    0x20(%eax),%edx
80102866:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010286d:	00 00 00 
80102870:	8b 50 20             	mov    0x20(%eax),%edx
80102873:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010287a:	00 00 00 
8010287d:	8b 50 20             	mov    0x20(%eax),%edx
80102880:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102887:	00 00 00 
8010288a:	8b 50 20             	mov    0x20(%eax),%edx
8010288d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102894:	00 00 00 
80102897:	8b 50 20             	mov    0x20(%eax),%edx
8010289a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801028a1:	85 08 00 
801028a4:	8b 50 20             	mov    0x20(%eax),%edx
801028a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028ae:	66 90                	xchg   %ax,%ax
801028b0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801028b6:	80 e6 10             	and    $0x10,%dh
801028b9:	75 f5                	jne    801028b0 <lapicinit+0xc0>
801028bb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801028c2:	00 00 00 
801028c5:	8b 40 20             	mov    0x20(%eax),%eax
801028c8:	c3                   	ret    
801028c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028d0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801028d7:	00 01 00 
801028da:	8b 50 20             	mov    0x20(%eax),%edx
801028dd:	e9 77 ff ff ff       	jmp    80102859 <lapicinit+0x69>
801028e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801028f0 <lapicid>:
801028f0:	a1 80 26 11 80       	mov    0x80112680,%eax
801028f5:	85 c0                	test   %eax,%eax
801028f7:	74 07                	je     80102900 <lapicid+0x10>
801028f9:	8b 40 20             	mov    0x20(%eax),%eax
801028fc:	c1 e8 18             	shr    $0x18,%eax
801028ff:	c3                   	ret    
80102900:	31 c0                	xor    %eax,%eax
80102902:	c3                   	ret    
80102903:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010290a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102910 <lapiceoi>:
80102910:	a1 80 26 11 80       	mov    0x80112680,%eax
80102915:	85 c0                	test   %eax,%eax
80102917:	74 0d                	je     80102926 <lapiceoi+0x16>
80102919:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102920:	00 00 00 
80102923:	8b 40 20             	mov    0x20(%eax),%eax
80102926:	c3                   	ret    
80102927:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010292e:	66 90                	xchg   %ax,%ax

80102930 <microdelay>:
80102930:	c3                   	ret    
80102931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102938:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010293f:	90                   	nop

80102940 <lapicstartap>:
80102940:	55                   	push   %ebp
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
80102960:	31 c0                	xor    %eax,%eax
80102962:	c1 e3 18             	shl    $0x18,%ebx
80102965:	66 a3 67 04 00 80    	mov    %ax,0x80000467
8010296b:	89 c8                	mov    %ecx,%eax
8010296d:	c1 e9 0c             	shr    $0xc,%ecx
80102970:	89 da                	mov    %ebx,%edx
80102972:	c1 e8 04             	shr    $0x4,%eax
80102975:	80 cd 06             	or     $0x6,%ch
80102978:	66 a3 69 04 00 80    	mov    %ax,0x80000469
8010297e:	a1 80 26 11 80       	mov    0x80112680,%eax
80102983:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
80102989:	8b 58 20             	mov    0x20(%eax),%ebx
8010298c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102993:	c5 00 00 
80102996:	8b 58 20             	mov    0x20(%eax),%ebx
80102999:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801029a0:	85 00 00 
801029a3:	8b 58 20             	mov    0x20(%eax),%ebx
801029a6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
801029ac:	8b 58 20             	mov    0x20(%eax),%ebx
801029af:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
801029b5:	8b 58 20             	mov    0x20(%eax),%ebx
801029b8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
801029be:	8b 50 20             	mov    0x20(%eax),%edx
801029c1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
801029c7:	8b 40 20             	mov    0x20(%eax),%eax
801029ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029cd:	c9                   	leave  
801029ce:	c3                   	ret    
801029cf:	90                   	nop

801029d0 <cmostime>:
801029d0:	55                   	push   %ebp
801029d1:	b8 0b 00 00 00       	mov    $0xb,%eax
801029d6:	ba 70 00 00 00       	mov    $0x70,%edx
801029db:	89 e5                	mov    %esp,%ebp
801029dd:	57                   	push   %edi
801029de:	56                   	push   %esi
801029df:	53                   	push   %ebx
801029e0:	83 ec 4c             	sub    $0x4c,%esp
801029e3:	ee                   	out    %al,(%dx)
801029e4:	ba 71 00 00 00       	mov    $0x71,%edx
801029e9:	ec                   	in     (%dx),%al
801029ea:	83 e0 04             	and    $0x4,%eax
801029ed:	bb 70 00 00 00       	mov    $0x70,%ebx
801029f2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801029f5:	8d 76 00             	lea    0x0(%esi),%esi
801029f8:	31 c0                	xor    %eax,%eax
801029fa:	89 da                	mov    %ebx,%edx
801029fc:	ee                   	out    %al,(%dx)
801029fd:	b9 71 00 00 00       	mov    $0x71,%ecx
80102a02:	89 ca                	mov    %ecx,%edx
80102a04:	ec                   	in     (%dx),%al
80102a05:	88 45 b7             	mov    %al,-0x49(%ebp)
80102a08:	89 da                	mov    %ebx,%edx
80102a0a:	b8 02 00 00 00       	mov    $0x2,%eax
80102a0f:	ee                   	out    %al,(%dx)
80102a10:	89 ca                	mov    %ecx,%edx
80102a12:	ec                   	in     (%dx),%al
80102a13:	88 45 b6             	mov    %al,-0x4a(%ebp)
80102a16:	89 da                	mov    %ebx,%edx
80102a18:	b8 04 00 00 00       	mov    $0x4,%eax
80102a1d:	ee                   	out    %al,(%dx)
80102a1e:	89 ca                	mov    %ecx,%edx
80102a20:	ec                   	in     (%dx),%al
80102a21:	88 45 b5             	mov    %al,-0x4b(%ebp)
80102a24:	89 da                	mov    %ebx,%edx
80102a26:	b8 07 00 00 00       	mov    $0x7,%eax
80102a2b:	ee                   	out    %al,(%dx)
80102a2c:	89 ca                	mov    %ecx,%edx
80102a2e:	ec                   	in     (%dx),%al
80102a2f:	88 45 b4             	mov    %al,-0x4c(%ebp)
80102a32:	89 da                	mov    %ebx,%edx
80102a34:	b8 08 00 00 00       	mov    $0x8,%eax
80102a39:	ee                   	out    %al,(%dx)
80102a3a:	89 ca                	mov    %ecx,%edx
80102a3c:	ec                   	in     (%dx),%al
80102a3d:	89 c7                	mov    %eax,%edi
80102a3f:	89 da                	mov    %ebx,%edx
80102a41:	b8 09 00 00 00       	mov    $0x9,%eax
80102a46:	ee                   	out    %al,(%dx)
80102a47:	89 ca                	mov    %ecx,%edx
80102a49:	ec                   	in     (%dx),%al
80102a4a:	89 c6                	mov    %eax,%esi
80102a4c:	89 da                	mov    %ebx,%edx
80102a4e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a53:	ee                   	out    %al,(%dx)
80102a54:	89 ca                	mov    %ecx,%edx
80102a56:	ec                   	in     (%dx),%al
80102a57:	84 c0                	test   %al,%al
80102a59:	78 9d                	js     801029f8 <cmostime+0x28>
80102a5b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102a5f:	89 fa                	mov    %edi,%edx
80102a61:	0f b6 fa             	movzbl %dl,%edi
80102a64:	89 f2                	mov    %esi,%edx
80102a66:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a69:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102a6d:	0f b6 f2             	movzbl %dl,%esi
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
80102a8c:	89 ca                	mov    %ecx,%edx
80102a8e:	ec                   	in     (%dx),%al
80102a8f:	0f b6 c0             	movzbl %al,%eax
80102a92:	89 da                	mov    %ebx,%edx
80102a94:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a97:	b8 02 00 00 00       	mov    $0x2,%eax
80102a9c:	ee                   	out    %al,(%dx)
80102a9d:	89 ca                	mov    %ecx,%edx
80102a9f:	ec                   	in     (%dx),%al
80102aa0:	0f b6 c0             	movzbl %al,%eax
80102aa3:	89 da                	mov    %ebx,%edx
80102aa5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102aa8:	b8 04 00 00 00       	mov    $0x4,%eax
80102aad:	ee                   	out    %al,(%dx)
80102aae:	89 ca                	mov    %ecx,%edx
80102ab0:	ec                   	in     (%dx),%al
80102ab1:	0f b6 c0             	movzbl %al,%eax
80102ab4:	89 da                	mov    %ebx,%edx
80102ab6:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102ab9:	b8 07 00 00 00       	mov    $0x7,%eax
80102abe:	ee                   	out    %al,(%dx)
80102abf:	89 ca                	mov    %ecx,%edx
80102ac1:	ec                   	in     (%dx),%al
80102ac2:	0f b6 c0             	movzbl %al,%eax
80102ac5:	89 da                	mov    %ebx,%edx
80102ac7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102aca:	b8 08 00 00 00       	mov    $0x8,%eax
80102acf:	ee                   	out    %al,(%dx)
80102ad0:	89 ca                	mov    %ecx,%edx
80102ad2:	ec                   	in     (%dx),%al
80102ad3:	0f b6 c0             	movzbl %al,%eax
80102ad6:	89 da                	mov    %ebx,%edx
80102ad8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102adb:	b8 09 00 00 00       	mov    $0x9,%eax
80102ae0:	ee                   	out    %al,(%dx)
80102ae1:	89 ca                	mov    %ecx,%edx
80102ae3:	ec                   	in     (%dx),%al
80102ae4:	0f b6 c0             	movzbl %al,%eax
80102ae7:	83 ec 04             	sub    $0x4,%esp
80102aea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102aed:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102af0:	6a 18                	push   $0x18
80102af2:	50                   	push   %eax
80102af3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102af6:	50                   	push   %eax
80102af7:	e8 f4 1b 00 00       	call   801046f0 <memcmp>
80102afc:	83 c4 10             	add    $0x10,%esp
80102aff:	85 c0                	test   %eax,%eax
80102b01:	0f 85 f1 fe ff ff    	jne    801029f8 <cmostime+0x28>
80102b07:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102b0b:	75 78                	jne    80102b85 <cmostime+0x1b5>
80102b0d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b10:	89 c2                	mov    %eax,%edx
80102b12:	83 e0 0f             	and    $0xf,%eax
80102b15:	c1 ea 04             	shr    $0x4,%edx
80102b18:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b1b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b1e:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102b21:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b24:	89 c2                	mov    %eax,%edx
80102b26:	83 e0 0f             	and    $0xf,%eax
80102b29:	c1 ea 04             	shr    $0x4,%edx
80102b2c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b2f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b32:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102b35:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b38:	89 c2                	mov    %eax,%edx
80102b3a:	83 e0 0f             	and    $0xf,%eax
80102b3d:	c1 ea 04             	shr    $0x4,%edx
80102b40:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b43:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b46:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102b49:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b4c:	89 c2                	mov    %eax,%edx
80102b4e:	83 e0 0f             	and    $0xf,%eax
80102b51:	c1 ea 04             	shr    $0x4,%edx
80102b54:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b57:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b5a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102b5d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b60:	89 c2                	mov    %eax,%edx
80102b62:	83 e0 0f             	and    $0xf,%eax
80102b65:	c1 ea 04             	shr    $0x4,%edx
80102b68:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b6b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b6e:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102b71:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b74:	89 c2                	mov    %eax,%edx
80102b76:	83 e0 0f             	and    $0xf,%eax
80102b79:	c1 ea 04             	shr    $0x4,%edx
80102b7c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b7f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b82:	89 45 cc             	mov    %eax,-0x34(%ebp)
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
80102bab:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
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
80102bc0:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102bc6:	85 c9                	test   %ecx,%ecx
80102bc8:	0f 8e 8a 00 00 00    	jle    80102c58 <install_trans+0x98>
80102bce:	55                   	push   %ebp
80102bcf:	89 e5                	mov    %esp,%ebp
80102bd1:	57                   	push   %edi
80102bd2:	31 ff                	xor    %edi,%edi
80102bd4:	56                   	push   %esi
80102bd5:	53                   	push   %ebx
80102bd6:	83 ec 0c             	sub    $0xc,%esp
80102bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102be0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102be5:	83 ec 08             	sub    $0x8,%esp
80102be8:	01 f8                	add    %edi,%eax
80102bea:	83 c0 01             	add    $0x1,%eax
80102bed:	50                   	push   %eax
80102bee:	ff 35 e4 26 11 80    	push   0x801126e4
80102bf4:	e8 d7 d4 ff ff       	call   801000d0 <bread>
80102bf9:	89 c6                	mov    %eax,%esi
80102bfb:	58                   	pop    %eax
80102bfc:	5a                   	pop    %edx
80102bfd:	ff 34 bd ec 26 11 80 	push   -0x7feed914(,%edi,4)
80102c04:	ff 35 e4 26 11 80    	push   0x801126e4
80102c0a:	83 c7 01             	add    $0x1,%edi
80102c0d:	e8 be d4 ff ff       	call   801000d0 <bread>
80102c12:	83 c4 0c             	add    $0xc,%esp
80102c15:	89 c3                	mov    %eax,%ebx
80102c17:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c1a:	68 00 02 00 00       	push   $0x200
80102c1f:	50                   	push   %eax
80102c20:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102c23:	50                   	push   %eax
80102c24:	e8 17 1b 00 00       	call   80104740 <memmove>
80102c29:	89 1c 24             	mov    %ebx,(%esp)
80102c2c:	e8 7f d5 ff ff       	call   801001b0 <bwrite>
80102c31:	89 34 24             	mov    %esi,(%esp)
80102c34:	e8 b7 d5 ff ff       	call   801001f0 <brelse>
80102c39:	89 1c 24             	mov    %ebx,(%esp)
80102c3c:	e8 af d5 ff ff       	call   801001f0 <brelse>
80102c41:	83 c4 10             	add    $0x10,%esp
80102c44:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
80102c4a:	7f 94                	jg     80102be0 <install_trans+0x20>
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
80102c60:	55                   	push   %ebp
80102c61:	89 e5                	mov    %esp,%ebp
80102c63:	53                   	push   %ebx
80102c64:	83 ec 0c             	sub    $0xc,%esp
80102c67:	ff 35 d4 26 11 80    	push   0x801126d4
80102c6d:	ff 35 e4 26 11 80    	push   0x801126e4
80102c73:	e8 58 d4 ff ff       	call   801000d0 <bread>
80102c78:	83 c4 10             	add    $0x10,%esp
80102c7b:	89 c3                	mov    %eax,%ebx
80102c7d:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102c82:	89 43 5c             	mov    %eax,0x5c(%ebx)
80102c85:	85 c0                	test   %eax,%eax
80102c87:	7e 19                	jle    80102ca2 <write_head+0x42>
80102c89:	31 d2                	xor    %edx,%edx
80102c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c8f:	90                   	nop
80102c90:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80102c97:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
80102c9b:	83 c2 01             	add    $0x1,%edx
80102c9e:	39 d0                	cmp    %edx,%eax
80102ca0:	75 ee                	jne    80102c90 <write_head+0x30>
80102ca2:	83 ec 0c             	sub    $0xc,%esp
80102ca5:	53                   	push   %ebx
80102ca6:	e8 05 d5 ff ff       	call   801001b0 <bwrite>
80102cab:	89 1c 24             	mov    %ebx,(%esp)
80102cae:	e8 3d d5 ff ff       	call   801001f0 <brelse>
80102cb3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102cb6:	83 c4 10             	add    $0x10,%esp
80102cb9:	c9                   	leave  
80102cba:	c3                   	ret    
80102cbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102cbf:	90                   	nop

80102cc0 <initlog>:
80102cc0:	55                   	push   %ebp
80102cc1:	89 e5                	mov    %esp,%ebp
80102cc3:	53                   	push   %ebx
80102cc4:	83 ec 2c             	sub    $0x2c,%esp
80102cc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102cca:	68 80 7e 10 80       	push   $0x80107e80
80102ccf:	68 a0 26 11 80       	push   $0x801126a0
80102cd4:	e8 37 17 00 00       	call   80104410 <initlock>
80102cd9:	58                   	pop    %eax
80102cda:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102cdd:	5a                   	pop    %edx
80102cde:	50                   	push   %eax
80102cdf:	53                   	push   %ebx
80102ce0:	e8 3b e8 ff ff       	call   80101520 <readsb>
80102ce5:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102ce8:	59                   	pop    %ecx
80102ce9:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
80102cef:	8b 55 e8             	mov    -0x18(%ebp),%edx
80102cf2:	a3 d4 26 11 80       	mov    %eax,0x801126d4
80102cf7:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
80102cfd:	5a                   	pop    %edx
80102cfe:	50                   	push   %eax
80102cff:	53                   	push   %ebx
80102d00:	e8 cb d3 ff ff       	call   801000d0 <bread>
80102d05:	83 c4 10             	add    $0x10,%esp
80102d08:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102d0b:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
80102d11:	85 db                	test   %ebx,%ebx
80102d13:	7e 1d                	jle    80102d32 <initlog+0x72>
80102d15:	31 d2                	xor    %edx,%edx
80102d17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d1e:	66 90                	xchg   %ax,%ax
80102d20:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102d24:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
80102d2b:	83 c2 01             	add    $0x1,%edx
80102d2e:	39 d3                	cmp    %edx,%ebx
80102d30:	75 ee                	jne    80102d20 <initlog+0x60>
80102d32:	83 ec 0c             	sub    $0xc,%esp
80102d35:	50                   	push   %eax
80102d36:	e8 b5 d4 ff ff       	call   801001f0 <brelse>
80102d3b:	e8 80 fe ff ff       	call   80102bc0 <install_trans>
80102d40:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102d47:	00 00 00 
80102d4a:	e8 11 ff ff ff       	call   80102c60 <write_head>
80102d4f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d52:	83 c4 10             	add    $0x10,%esp
80102d55:	c9                   	leave  
80102d56:	c3                   	ret    
80102d57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d5e:	66 90                	xchg   %ax,%ax

80102d60 <begin_op>:
80102d60:	55                   	push   %ebp
80102d61:	89 e5                	mov    %esp,%ebp
80102d63:	83 ec 14             	sub    $0x14,%esp
80102d66:	68 a0 26 11 80       	push   $0x801126a0
80102d6b:	e8 70 18 00 00       	call   801045e0 <acquire>
80102d70:	83 c4 10             	add    $0x10,%esp
80102d73:	eb 18                	jmp    80102d8d <begin_op+0x2d>
80102d75:	8d 76 00             	lea    0x0(%esi),%esi
80102d78:	83 ec 08             	sub    $0x8,%esp
80102d7b:	68 a0 26 11 80       	push   $0x801126a0
80102d80:	68 a0 26 11 80       	push   $0x801126a0
80102d85:	e8 f6 12 00 00       	call   80104080 <sleep>
80102d8a:	83 c4 10             	add    $0x10,%esp
80102d8d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102d92:	85 c0                	test   %eax,%eax
80102d94:	75 e2                	jne    80102d78 <begin_op+0x18>
80102d96:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102d9b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102da1:	83 c0 01             	add    $0x1,%eax
80102da4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102da7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102daa:	83 fa 1e             	cmp    $0x1e,%edx
80102dad:	7f c9                	jg     80102d78 <begin_op+0x18>
80102daf:	83 ec 0c             	sub    $0xc,%esp
80102db2:	a3 dc 26 11 80       	mov    %eax,0x801126dc
80102db7:	68 a0 26 11 80       	push   $0x801126a0
80102dbc:	e8 bf 17 00 00       	call   80104580 <release>
80102dc1:	83 c4 10             	add    $0x10,%esp
80102dc4:	c9                   	leave  
80102dc5:	c3                   	ret    
80102dc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dcd:	8d 76 00             	lea    0x0(%esi),%esi

80102dd0 <end_op>:
80102dd0:	55                   	push   %ebp
80102dd1:	89 e5                	mov    %esp,%ebp
80102dd3:	57                   	push   %edi
80102dd4:	56                   	push   %esi
80102dd5:	53                   	push   %ebx
80102dd6:	83 ec 18             	sub    $0x18,%esp
80102dd9:	68 a0 26 11 80       	push   $0x801126a0
80102dde:	e8 fd 17 00 00       	call   801045e0 <acquire>
80102de3:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102de8:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102dee:	83 c4 10             	add    $0x10,%esp
80102df1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102df4:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
80102dfa:	85 f6                	test   %esi,%esi
80102dfc:	0f 85 22 01 00 00    	jne    80102f24 <end_op+0x154>
80102e02:	85 db                	test   %ebx,%ebx
80102e04:	0f 85 f6 00 00 00    	jne    80102f00 <end_op+0x130>
80102e0a:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102e11:	00 00 00 
80102e14:	83 ec 0c             	sub    $0xc,%esp
80102e17:	68 a0 26 11 80       	push   $0x801126a0
80102e1c:	e8 5f 17 00 00       	call   80104580 <release>
80102e21:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102e27:	83 c4 10             	add    $0x10,%esp
80102e2a:	85 c9                	test   %ecx,%ecx
80102e2c:	7f 42                	jg     80102e70 <end_op+0xa0>
80102e2e:	83 ec 0c             	sub    $0xc,%esp
80102e31:	68 a0 26 11 80       	push   $0x801126a0
80102e36:	e8 a5 17 00 00       	call   801045e0 <acquire>
80102e3b:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e42:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102e49:	00 00 00 
80102e4c:	e8 ef 12 00 00       	call   80104140 <wakeup>
80102e51:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e58:	e8 23 17 00 00       	call   80104580 <release>
80102e5d:	83 c4 10             	add    $0x10,%esp
80102e60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e63:	5b                   	pop    %ebx
80102e64:	5e                   	pop    %esi
80102e65:	5f                   	pop    %edi
80102e66:	5d                   	pop    %ebp
80102e67:	c3                   	ret    
80102e68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e6f:	90                   	nop
80102e70:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102e75:	83 ec 08             	sub    $0x8,%esp
80102e78:	01 d8                	add    %ebx,%eax
80102e7a:	83 c0 01             	add    $0x1,%eax
80102e7d:	50                   	push   %eax
80102e7e:	ff 35 e4 26 11 80    	push   0x801126e4
80102e84:	e8 47 d2 ff ff       	call   801000d0 <bread>
80102e89:	89 c6                	mov    %eax,%esi
80102e8b:	58                   	pop    %eax
80102e8c:	5a                   	pop    %edx
80102e8d:	ff 34 9d ec 26 11 80 	push   -0x7feed914(,%ebx,4)
80102e94:	ff 35 e4 26 11 80    	push   0x801126e4
80102e9a:	83 c3 01             	add    $0x1,%ebx
80102e9d:	e8 2e d2 ff ff       	call   801000d0 <bread>
80102ea2:	83 c4 0c             	add    $0xc,%esp
80102ea5:	89 c7                	mov    %eax,%edi
80102ea7:	8d 40 5c             	lea    0x5c(%eax),%eax
80102eaa:	68 00 02 00 00       	push   $0x200
80102eaf:	50                   	push   %eax
80102eb0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102eb3:	50                   	push   %eax
80102eb4:	e8 87 18 00 00       	call   80104740 <memmove>
80102eb9:	89 34 24             	mov    %esi,(%esp)
80102ebc:	e8 ef d2 ff ff       	call   801001b0 <bwrite>
80102ec1:	89 3c 24             	mov    %edi,(%esp)
80102ec4:	e8 27 d3 ff ff       	call   801001f0 <brelse>
80102ec9:	89 34 24             	mov    %esi,(%esp)
80102ecc:	e8 1f d3 ff ff       	call   801001f0 <brelse>
80102ed1:	83 c4 10             	add    $0x10,%esp
80102ed4:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102eda:	7c 94                	jl     80102e70 <end_op+0xa0>
80102edc:	e8 7f fd ff ff       	call   80102c60 <write_head>
80102ee1:	e8 da fc ff ff       	call   80102bc0 <install_trans>
80102ee6:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102eed:	00 00 00 
80102ef0:	e8 6b fd ff ff       	call   80102c60 <write_head>
80102ef5:	e9 34 ff ff ff       	jmp    80102e2e <end_op+0x5e>
80102efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102f00:	83 ec 0c             	sub    $0xc,%esp
80102f03:	68 a0 26 11 80       	push   $0x801126a0
80102f08:	e8 33 12 00 00       	call   80104140 <wakeup>
80102f0d:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102f14:	e8 67 16 00 00       	call   80104580 <release>
80102f19:	83 c4 10             	add    $0x10,%esp
80102f1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f1f:	5b                   	pop    %ebx
80102f20:	5e                   	pop    %esi
80102f21:	5f                   	pop    %edi
80102f22:	5d                   	pop    %ebp
80102f23:	c3                   	ret    
80102f24:	83 ec 0c             	sub    $0xc,%esp
80102f27:	68 84 7e 10 80       	push   $0x80107e84
80102f2c:	e8 4f d4 ff ff       	call   80100380 <panic>
80102f31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f3f:	90                   	nop

80102f40 <log_write>:
80102f40:	55                   	push   %ebp
80102f41:	89 e5                	mov    %esp,%ebp
80102f43:	53                   	push   %ebx
80102f44:	83 ec 04             	sub    $0x4,%esp
80102f47:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102f4d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102f50:	83 fa 1d             	cmp    $0x1d,%edx
80102f53:	0f 8f 85 00 00 00    	jg     80102fde <log_write+0x9e>
80102f59:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102f5e:	83 e8 01             	sub    $0x1,%eax
80102f61:	39 c2                	cmp    %eax,%edx
80102f63:	7d 79                	jge    80102fde <log_write+0x9e>
80102f65:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102f6a:	85 c0                	test   %eax,%eax
80102f6c:	7e 7d                	jle    80102feb <log_write+0xab>
80102f6e:	83 ec 0c             	sub    $0xc,%esp
80102f71:	68 a0 26 11 80       	push   $0x801126a0
80102f76:	e8 65 16 00 00       	call   801045e0 <acquire>
80102f7b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102f81:	83 c4 10             	add    $0x10,%esp
80102f84:	85 d2                	test   %edx,%edx
80102f86:	7e 4a                	jle    80102fd2 <log_write+0x92>
80102f88:	8b 4b 08             	mov    0x8(%ebx),%ecx
80102f8b:	31 c0                	xor    %eax,%eax
80102f8d:	eb 08                	jmp    80102f97 <log_write+0x57>
80102f8f:	90                   	nop
80102f90:	83 c0 01             	add    $0x1,%eax
80102f93:	39 c2                	cmp    %eax,%edx
80102f95:	74 29                	je     80102fc0 <log_write+0x80>
80102f97:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
80102f9e:	75 f0                	jne    80102f90 <log_write+0x50>
80102fa0:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
80102fa7:	83 0b 04             	orl    $0x4,(%ebx)
80102faa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102fad:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
80102fb4:	c9                   	leave  
80102fb5:	e9 c6 15 00 00       	jmp    80104580 <release>
80102fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102fc0:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
80102fc7:	83 c2 01             	add    $0x1,%edx
80102fca:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
80102fd0:	eb d5                	jmp    80102fa7 <log_write+0x67>
80102fd2:	8b 43 08             	mov    0x8(%ebx),%eax
80102fd5:	a3 ec 26 11 80       	mov    %eax,0x801126ec
80102fda:	75 cb                	jne    80102fa7 <log_write+0x67>
80102fdc:	eb e9                	jmp    80102fc7 <log_write+0x87>
80102fde:	83 ec 0c             	sub    $0xc,%esp
80102fe1:	68 93 7e 10 80       	push   $0x80107e93
80102fe6:	e8 95 d3 ff ff       	call   80100380 <panic>
80102feb:	83 ec 0c             	sub    $0xc,%esp
80102fee:	68 a9 7e 10 80       	push   $0x80107ea9
80102ff3:	e8 88 d3 ff ff       	call   80100380 <panic>
80102ff8:	66 90                	xchg   %ax,%ax
80102ffa:	66 90                	xchg   %ax,%ax
80102ffc:	66 90                	xchg   %ax,%ax
80102ffe:	66 90                	xchg   %ax,%ax

80103000 <mpmain>:
80103000:	55                   	push   %ebp
80103001:	89 e5                	mov    %esp,%ebp
80103003:	53                   	push   %ebx
80103004:	83 ec 04             	sub    $0x4,%esp
80103007:	e8 84 09 00 00       	call   80103990 <cpuid>
8010300c:	89 c3                	mov    %eax,%ebx
8010300e:	e8 7d 09 00 00       	call   80103990 <cpuid>
80103013:	83 ec 04             	sub    $0x4,%esp
80103016:	53                   	push   %ebx
80103017:	50                   	push   %eax
80103018:	68 c4 7e 10 80       	push   $0x80107ec4
8010301d:	e8 7e d6 ff ff       	call   801006a0 <cprintf>
80103022:	e8 f9 28 00 00       	call   80105920 <idtinit>
80103027:	e8 04 09 00 00       	call   80103930 <mycpu>
8010302c:	89 c2                	mov    %eax,%edx
8010302e:	b8 01 00 00 00       	mov    $0x1,%eax
80103033:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
8010303a:	e8 31 0c 00 00       	call   80103c70 <scheduler>
8010303f:	90                   	nop

80103040 <mpenter>:
80103040:	55                   	push   %ebp
80103041:	89 e5                	mov    %esp,%ebp
80103043:	83 ec 08             	sub    $0x8,%esp
80103046:	e8 e5 3b 00 00       	call   80106c30 <switchkvm>
8010304b:	e8 d0 39 00 00       	call   80106a20 <seginit>
80103050:	e8 9b f7 ff ff       	call   801027f0 <lapicinit>
80103055:	e8 a6 ff ff ff       	call   80103000 <mpmain>
8010305a:	66 90                	xchg   %ax,%ax
8010305c:	66 90                	xchg   %ax,%ax
8010305e:	66 90                	xchg   %ax,%ax

80103060 <main>:
80103060:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103064:	83 e4 f0             	and    $0xfffffff0,%esp
80103067:	ff 71 fc             	push   -0x4(%ecx)
8010306a:	55                   	push   %ebp
8010306b:	89 e5                	mov    %esp,%ebp
8010306d:	53                   	push   %ebx
8010306e:	51                   	push   %ecx
8010306f:	83 ec 08             	sub    $0x8,%esp
80103072:	68 00 00 40 80       	push   $0x80400000
80103077:	68 d0 a6 12 80       	push   $0x8012a6d0
8010307c:	e8 8f f5 ff ff       	call   80102610 <kinit1>
80103081:	e8 9a 40 00 00       	call   80107120 <kvmalloc>
80103086:	e8 85 01 00 00       	call   80103210 <mpinit>
8010308b:	e8 60 f7 ff ff       	call   801027f0 <lapicinit>
80103090:	e8 8b 39 00 00       	call   80106a20 <seginit>
80103095:	e8 76 03 00 00       	call   80103410 <picinit>
8010309a:	e8 31 f3 ff ff       	call   801023d0 <ioapicinit>
8010309f:	e8 bc d9 ff ff       	call   80100a60 <consoleinit>
801030a4:	e8 f7 2c 00 00       	call   80105da0 <uartinit>
801030a9:	e8 62 08 00 00       	call   80103910 <pinit>
801030ae:	e8 ed 27 00 00       	call   801058a0 <tvinit>
801030b3:	e8 88 cf ff ff       	call   80100040 <binit>
801030b8:	e8 53 dd ff ff       	call   80100e10 <fileinit>
801030bd:	e8 fe f0 ff ff       	call   801021c0 <ideinit>
801030c2:	83 c4 0c             	add    $0xc,%esp
801030c5:	68 8a 00 00 00       	push   $0x8a
801030ca:	68 8c b4 10 80       	push   $0x8010b48c
801030cf:	68 00 70 00 80       	push   $0x80007000
801030d4:	e8 67 16 00 00       	call   80104740 <memmove>
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
80103119:	e8 12 08 00 00       	call   80103930 <mycpu>
8010311e:	39 c3                	cmp    %eax,%ebx
80103120:	74 de                	je     80103100 <main+0xa0>
80103122:	e8 59 f5 ff ff       	call   80102680 <kalloc>
80103127:	83 ec 08             	sub    $0x8,%esp
8010312a:	c7 05 f8 6f 00 80 40 	movl   $0x80103040,0x80006ff8
80103131:	30 10 80 
80103134:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010313b:	a0 10 00 
8010313e:	05 00 10 00 00       	add    $0x1000,%eax
80103143:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
80103148:	0f b6 03             	movzbl (%ebx),%eax
8010314b:	68 00 70 00 00       	push   $0x7000
80103150:	50                   	push   %eax
80103151:	e8 ea f7 ff ff       	call   80102940 <lapicstartap>
80103156:	83 c4 10             	add    $0x10,%esp
80103159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103160:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103166:	85 c0                	test   %eax,%eax
80103168:	74 f6                	je     80103160 <main+0x100>
8010316a:	eb 94                	jmp    80103100 <main+0xa0>
8010316c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103170:	83 ec 08             	sub    $0x8,%esp
80103173:	68 00 00 00 8e       	push   $0x8e000000
80103178:	68 00 00 40 80       	push   $0x80400000
8010317d:	e8 2e f4 ff ff       	call   801025b0 <kinit2>
80103182:	e8 59 08 00 00       	call   801039e0 <userinit>
80103187:	e8 74 fe ff ff       	call   80103000 <mpmain>
8010318c:	66 90                	xchg   %ax,%ax
8010318e:	66 90                	xchg   %ax,%ax

80103190 <mpsearch1>:
80103190:	55                   	push   %ebp
80103191:	89 e5                	mov    %esp,%ebp
80103193:	57                   	push   %edi
80103194:	56                   	push   %esi
80103195:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
8010319b:	53                   	push   %ebx
8010319c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
8010319f:	83 ec 0c             	sub    $0xc,%esp
801031a2:	39 de                	cmp    %ebx,%esi
801031a4:	72 10                	jb     801031b6 <mpsearch1+0x26>
801031a6:	eb 50                	jmp    801031f8 <mpsearch1+0x68>
801031a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031af:	90                   	nop
801031b0:	89 fe                	mov    %edi,%esi
801031b2:	39 fb                	cmp    %edi,%ebx
801031b4:	76 42                	jbe    801031f8 <mpsearch1+0x68>
801031b6:	83 ec 04             	sub    $0x4,%esp
801031b9:	8d 7e 10             	lea    0x10(%esi),%edi
801031bc:	6a 04                	push   $0x4
801031be:	68 d8 7e 10 80       	push   $0x80107ed8
801031c3:	56                   	push   %esi
801031c4:	e8 27 15 00 00       	call   801046f0 <memcmp>
801031c9:	83 c4 10             	add    $0x10,%esp
801031cc:	85 c0                	test   %eax,%eax
801031ce:	75 e0                	jne    801031b0 <mpsearch1+0x20>
801031d0:	89 f2                	mov    %esi,%edx
801031d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801031d8:	0f b6 0a             	movzbl (%edx),%ecx
801031db:	83 c2 01             	add    $0x1,%edx
801031de:	01 c8                	add    %ecx,%eax
801031e0:	39 fa                	cmp    %edi,%edx
801031e2:	75 f4                	jne    801031d8 <mpsearch1+0x48>
801031e4:	84 c0                	test   %al,%al
801031e6:	75 c8                	jne    801031b0 <mpsearch1+0x20>
801031e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031eb:	89 f0                	mov    %esi,%eax
801031ed:	5b                   	pop    %ebx
801031ee:	5e                   	pop    %esi
801031ef:	5f                   	pop    %edi
801031f0:	5d                   	pop    %ebp
801031f1:	c3                   	ret    
801031f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801031f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031fb:	31 f6                	xor    %esi,%esi
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
80103210:	55                   	push   %ebp
80103211:	89 e5                	mov    %esp,%ebp
80103213:	57                   	push   %edi
80103214:	56                   	push   %esi
80103215:	53                   	push   %ebx
80103216:	83 ec 1c             	sub    $0x1c,%esp
80103219:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103220:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103227:	c1 e0 08             	shl    $0x8,%eax
8010322a:	09 d0                	or     %edx,%eax
8010322c:	c1 e0 04             	shl    $0x4,%eax
8010322f:	75 1b                	jne    8010324c <mpinit+0x3c>
80103231:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103238:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010323f:	c1 e0 08             	shl    $0x8,%eax
80103242:	09 d0                	or     %edx,%eax
80103244:	c1 e0 0a             	shl    $0xa,%eax
80103247:	2d 00 04 00 00       	sub    $0x400,%eax
8010324c:	ba 00 04 00 00       	mov    $0x400,%edx
80103251:	e8 3a ff ff ff       	call   80103190 <mpsearch1>
80103256:	89 c3                	mov    %eax,%ebx
80103258:	85 c0                	test   %eax,%eax
8010325a:	0f 84 40 01 00 00    	je     801033a0 <mpinit+0x190>
80103260:	8b 73 04             	mov    0x4(%ebx),%esi
80103263:	85 f6                	test   %esi,%esi
80103265:	0f 84 25 01 00 00    	je     80103390 <mpinit+0x180>
8010326b:	83 ec 04             	sub    $0x4,%esp
8010326e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103274:	6a 04                	push   $0x4
80103276:	68 dd 7e 10 80       	push   $0x80107edd
8010327b:	50                   	push   %eax
8010327c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010327f:	e8 6c 14 00 00       	call   801046f0 <memcmp>
80103284:	83 c4 10             	add    $0x10,%esp
80103287:	85 c0                	test   %eax,%eax
80103289:	0f 85 01 01 00 00    	jne    80103390 <mpinit+0x180>
8010328f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103296:	3c 01                	cmp    $0x1,%al
80103298:	74 08                	je     801032a2 <mpinit+0x92>
8010329a:	3c 04                	cmp    $0x4,%al
8010329c:	0f 85 ee 00 00 00    	jne    80103390 <mpinit+0x180>
801032a2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801032a9:	66 85 d2             	test   %dx,%dx
801032ac:	74 22                	je     801032d0 <mpinit+0xc0>
801032ae:	8d 3c 32             	lea    (%edx,%esi,1),%edi
801032b1:	89 f0                	mov    %esi,%eax
801032b3:	31 d2                	xor    %edx,%edx
801032b5:	8d 76 00             	lea    0x0(%esi),%esi
801032b8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
801032bf:	83 c0 01             	add    $0x1,%eax
801032c2:	01 ca                	add    %ecx,%edx
801032c4:	39 c7                	cmp    %eax,%edi
801032c6:	75 f0                	jne    801032b8 <mpinit+0xa8>
801032c8:	84 d2                	test   %dl,%dl
801032ca:	0f 85 c0 00 00 00    	jne    80103390 <mpinit+0x180>
801032d0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
801032d6:	a3 80 26 11 80       	mov    %eax,0x80112680
801032db:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801032e2:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
801032e8:	be 01 00 00 00       	mov    $0x1,%esi
801032ed:	03 55 e4             	add    -0x1c(%ebp),%edx
801032f0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801032f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801032f7:	90                   	nop
801032f8:	39 d0                	cmp    %edx,%eax
801032fa:	73 15                	jae    80103311 <mpinit+0x101>
801032fc:	0f b6 08             	movzbl (%eax),%ecx
801032ff:	80 f9 02             	cmp    $0x2,%cl
80103302:	74 4c                	je     80103350 <mpinit+0x140>
80103304:	77 3a                	ja     80103340 <mpinit+0x130>
80103306:	84 c9                	test   %cl,%cl
80103308:	74 56                	je     80103360 <mpinit+0x150>
8010330a:	83 c0 08             	add    $0x8,%eax
8010330d:	39 d0                	cmp    %edx,%eax
8010330f:	72 eb                	jb     801032fc <mpinit+0xec>
80103311:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103314:	85 f6                	test   %esi,%esi
80103316:	0f 84 d9 00 00 00    	je     801033f5 <mpinit+0x1e5>
8010331c:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103320:	74 15                	je     80103337 <mpinit+0x127>
80103322:	b8 70 00 00 00       	mov    $0x70,%eax
80103327:	ba 22 00 00 00       	mov    $0x22,%edx
8010332c:	ee                   	out    %al,(%dx)
8010332d:	ba 23 00 00 00       	mov    $0x23,%edx
80103332:	ec                   	in     (%dx),%al
80103333:	83 c8 01             	or     $0x1,%eax
80103336:	ee                   	out    %al,(%dx)
80103337:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010333a:	5b                   	pop    %ebx
8010333b:	5e                   	pop    %esi
8010333c:	5f                   	pop    %edi
8010333d:	5d                   	pop    %ebp
8010333e:	c3                   	ret    
8010333f:	90                   	nop
80103340:	83 e9 03             	sub    $0x3,%ecx
80103343:	80 f9 01             	cmp    $0x1,%cl
80103346:	76 c2                	jbe    8010330a <mpinit+0xfa>
80103348:	31 f6                	xor    %esi,%esi
8010334a:	eb ac                	jmp    801032f8 <mpinit+0xe8>
8010334c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103350:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
80103354:	83 c0 08             	add    $0x8,%eax
80103357:	88 0d 80 27 11 80    	mov    %cl,0x80112780
8010335d:	eb 99                	jmp    801032f8 <mpinit+0xe8>
8010335f:	90                   	nop
80103360:	8b 0d 84 27 11 80    	mov    0x80112784,%ecx
80103366:	83 f9 07             	cmp    $0x7,%ecx
80103369:	7f 19                	jg     80103384 <mpinit+0x174>
8010336b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103371:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
80103375:	83 c1 01             	add    $0x1,%ecx
80103378:	89 0d 84 27 11 80    	mov    %ecx,0x80112784
8010337e:	88 9f a0 27 11 80    	mov    %bl,-0x7feed860(%edi)
80103384:	83 c0 14             	add    $0x14,%eax
80103387:	e9 6c ff ff ff       	jmp    801032f8 <mpinit+0xe8>
8010338c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103390:	83 ec 0c             	sub    $0xc,%esp
80103393:	68 e2 7e 10 80       	push   $0x80107ee2
80103398:	e8 e3 cf ff ff       	call   80100380 <panic>
8010339d:	8d 76 00             	lea    0x0(%esi),%esi
801033a0:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801033a5:	eb 13                	jmp    801033ba <mpinit+0x1aa>
801033a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033ae:	66 90                	xchg   %ax,%ax
801033b0:	89 f3                	mov    %esi,%ebx
801033b2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801033b8:	74 d6                	je     80103390 <mpinit+0x180>
801033ba:	83 ec 04             	sub    $0x4,%esp
801033bd:	8d 73 10             	lea    0x10(%ebx),%esi
801033c0:	6a 04                	push   $0x4
801033c2:	68 d8 7e 10 80       	push   $0x80107ed8
801033c7:	53                   	push   %ebx
801033c8:	e8 23 13 00 00       	call   801046f0 <memcmp>
801033cd:	83 c4 10             	add    $0x10,%esp
801033d0:	85 c0                	test   %eax,%eax
801033d2:	75 dc                	jne    801033b0 <mpinit+0x1a0>
801033d4:	89 da                	mov    %ebx,%edx
801033d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033dd:	8d 76 00             	lea    0x0(%esi),%esi
801033e0:	0f b6 0a             	movzbl (%edx),%ecx
801033e3:	83 c2 01             	add    $0x1,%edx
801033e6:	01 c8                	add    %ecx,%eax
801033e8:	39 d6                	cmp    %edx,%esi
801033ea:	75 f4                	jne    801033e0 <mpinit+0x1d0>
801033ec:	84 c0                	test   %al,%al
801033ee:	75 c0                	jne    801033b0 <mpinit+0x1a0>
801033f0:	e9 6b fe ff ff       	jmp    80103260 <mpinit+0x50>
801033f5:	83 ec 0c             	sub    $0xc,%esp
801033f8:	68 fc 7e 10 80       	push   $0x80107efc
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
80103430:	55                   	push   %ebp
80103431:	89 e5                	mov    %esp,%ebp
80103433:	57                   	push   %edi
80103434:	56                   	push   %esi
80103435:	53                   	push   %ebx
80103436:	83 ec 0c             	sub    $0xc,%esp
80103439:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010343c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010343f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103445:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010344b:	e8 e0 d9 ff ff       	call   80100e30 <filealloc>
80103450:	89 03                	mov    %eax,(%ebx)
80103452:	85 c0                	test   %eax,%eax
80103454:	0f 84 a8 00 00 00    	je     80103502 <pipealloc+0xd2>
8010345a:	e8 d1 d9 ff ff       	call   80100e30 <filealloc>
8010345f:	89 06                	mov    %eax,(%esi)
80103461:	85 c0                	test   %eax,%eax
80103463:	0f 84 87 00 00 00    	je     801034f0 <pipealloc+0xc0>
80103469:	e8 12 f2 ff ff       	call   80102680 <kalloc>
8010346e:	89 c7                	mov    %eax,%edi
80103470:	85 c0                	test   %eax,%eax
80103472:	0f 84 b0 00 00 00    	je     80103528 <pipealloc+0xf8>
80103478:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010347f:	00 00 00 
80103482:	83 ec 08             	sub    $0x8,%esp
80103485:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010348c:	00 00 00 
8010348f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103496:	00 00 00 
80103499:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801034a0:	00 00 00 
801034a3:	68 1b 7f 10 80       	push   $0x80107f1b
801034a8:	50                   	push   %eax
801034a9:	e8 62 0f 00 00       	call   80104410 <initlock>
801034ae:	8b 03                	mov    (%ebx),%eax
801034b0:	83 c4 10             	add    $0x10,%esp
801034b3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
801034b9:	8b 03                	mov    (%ebx),%eax
801034bb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
801034bf:	8b 03                	mov    (%ebx),%eax
801034c1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
801034c5:	8b 03                	mov    (%ebx),%eax
801034c7:	89 78 0c             	mov    %edi,0xc(%eax)
801034ca:	8b 06                	mov    (%esi),%eax
801034cc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
801034d2:	8b 06                	mov    (%esi),%eax
801034d4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
801034d8:	8b 06                	mov    (%esi),%eax
801034da:	c6 40 09 01          	movb   $0x1,0x9(%eax)
801034de:	8b 06                	mov    (%esi),%eax
801034e0:	89 78 0c             	mov    %edi,0xc(%eax)
801034e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034e6:	31 c0                	xor    %eax,%eax
801034e8:	5b                   	pop    %ebx
801034e9:	5e                   	pop    %esi
801034ea:	5f                   	pop    %edi
801034eb:	5d                   	pop    %ebp
801034ec:	c3                   	ret    
801034ed:	8d 76 00             	lea    0x0(%esi),%esi
801034f0:	8b 03                	mov    (%ebx),%eax
801034f2:	85 c0                	test   %eax,%eax
801034f4:	74 1e                	je     80103514 <pipealloc+0xe4>
801034f6:	83 ec 0c             	sub    $0xc,%esp
801034f9:	50                   	push   %eax
801034fa:	e8 f1 d9 ff ff       	call   80100ef0 <fileclose>
801034ff:	83 c4 10             	add    $0x10,%esp
80103502:	8b 06                	mov    (%esi),%eax
80103504:	85 c0                	test   %eax,%eax
80103506:	74 0c                	je     80103514 <pipealloc+0xe4>
80103508:	83 ec 0c             	sub    $0xc,%esp
8010350b:	50                   	push   %eax
8010350c:	e8 df d9 ff ff       	call   80100ef0 <fileclose>
80103511:	83 c4 10             	add    $0x10,%esp
80103514:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103517:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010351c:	5b                   	pop    %ebx
8010351d:	5e                   	pop    %esi
8010351e:	5f                   	pop    %edi
8010351f:	5d                   	pop    %ebp
80103520:	c3                   	ret    
80103521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103528:	8b 03                	mov    (%ebx),%eax
8010352a:	85 c0                	test   %eax,%eax
8010352c:	75 c8                	jne    801034f6 <pipealloc+0xc6>
8010352e:	eb d2                	jmp    80103502 <pipealloc+0xd2>

80103530 <pipeclose>:
80103530:	55                   	push   %ebp
80103531:	89 e5                	mov    %esp,%ebp
80103533:	56                   	push   %esi
80103534:	53                   	push   %ebx
80103535:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103538:	8b 75 0c             	mov    0xc(%ebp),%esi
8010353b:	83 ec 0c             	sub    $0xc,%esp
8010353e:	53                   	push   %ebx
8010353f:	e8 9c 10 00 00       	call   801045e0 <acquire>
80103544:	83 c4 10             	add    $0x10,%esp
80103547:	85 f6                	test   %esi,%esi
80103549:	74 65                	je     801035b0 <pipeclose+0x80>
8010354b:	83 ec 0c             	sub    $0xc,%esp
8010354e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103554:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010355b:	00 00 00 
8010355e:	50                   	push   %eax
8010355f:	e8 dc 0b 00 00       	call   80104140 <wakeup>
80103564:	83 c4 10             	add    $0x10,%esp
80103567:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010356d:	85 d2                	test   %edx,%edx
8010356f:	75 0a                	jne    8010357b <pipeclose+0x4b>
80103571:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103577:	85 c0                	test   %eax,%eax
80103579:	74 15                	je     80103590 <pipeclose+0x60>
8010357b:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010357e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103581:	5b                   	pop    %ebx
80103582:	5e                   	pop    %esi
80103583:	5d                   	pop    %ebp
80103584:	e9 f7 0f 00 00       	jmp    80104580 <release>
80103589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103590:	83 ec 0c             	sub    $0xc,%esp
80103593:	53                   	push   %ebx
80103594:	e8 e7 0f 00 00       	call   80104580 <release>
80103599:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010359c:	83 c4 10             	add    $0x10,%esp
8010359f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801035a2:	5b                   	pop    %ebx
801035a3:	5e                   	pop    %esi
801035a4:	5d                   	pop    %ebp
801035a5:	e9 16 ef ff ff       	jmp    801024c0 <kfree>
801035aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801035b0:	83 ec 0c             	sub    $0xc,%esp
801035b3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801035b9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801035c0:	00 00 00 
801035c3:	50                   	push   %eax
801035c4:	e8 77 0b 00 00       	call   80104140 <wakeup>
801035c9:	83 c4 10             	add    $0x10,%esp
801035cc:	eb 99                	jmp    80103567 <pipeclose+0x37>
801035ce:	66 90                	xchg   %ax,%ax

801035d0 <pipewrite>:
801035d0:	55                   	push   %ebp
801035d1:	89 e5                	mov    %esp,%ebp
801035d3:	57                   	push   %edi
801035d4:	56                   	push   %esi
801035d5:	53                   	push   %ebx
801035d6:	83 ec 28             	sub    $0x28,%esp
801035d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801035dc:	53                   	push   %ebx
801035dd:	e8 fe 0f 00 00       	call   801045e0 <acquire>
801035e2:	8b 45 10             	mov    0x10(%ebp),%eax
801035e5:	83 c4 10             	add    $0x10,%esp
801035e8:	85 c0                	test   %eax,%eax
801035ea:	0f 8e c0 00 00 00    	jle    801036b0 <pipewrite+0xe0>
801035f0:	8b 45 0c             	mov    0xc(%ebp),%eax
801035f3:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
801035f9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801035ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103602:	03 45 10             	add    0x10(%ebp),%eax
80103605:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103608:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010360e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103614:	89 ca                	mov    %ecx,%edx
80103616:	05 00 02 00 00       	add    $0x200,%eax
8010361b:	39 c1                	cmp    %eax,%ecx
8010361d:	74 3f                	je     8010365e <pipewrite+0x8e>
8010361f:	eb 67                	jmp    80103688 <pipewrite+0xb8>
80103621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103628:	e8 83 03 00 00       	call   801039b0 <myproc>
8010362d:	8b 48 24             	mov    0x24(%eax),%ecx
80103630:	85 c9                	test   %ecx,%ecx
80103632:	75 34                	jne    80103668 <pipewrite+0x98>
80103634:	83 ec 0c             	sub    $0xc,%esp
80103637:	57                   	push   %edi
80103638:	e8 03 0b 00 00       	call   80104140 <wakeup>
8010363d:	58                   	pop    %eax
8010363e:	5a                   	pop    %edx
8010363f:	53                   	push   %ebx
80103640:	56                   	push   %esi
80103641:	e8 3a 0a 00 00       	call   80104080 <sleep>
80103646:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010364c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103652:	83 c4 10             	add    $0x10,%esp
80103655:	05 00 02 00 00       	add    $0x200,%eax
8010365a:	39 c2                	cmp    %eax,%edx
8010365c:	75 2a                	jne    80103688 <pipewrite+0xb8>
8010365e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103664:	85 c0                	test   %eax,%eax
80103666:	75 c0                	jne    80103628 <pipewrite+0x58>
80103668:	83 ec 0c             	sub    $0xc,%esp
8010366b:	53                   	push   %ebx
8010366c:	e8 0f 0f 00 00       	call   80104580 <release>
80103671:	83 c4 10             	add    $0x10,%esp
80103674:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103679:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010367c:	5b                   	pop    %ebx
8010367d:	5e                   	pop    %esi
8010367e:	5f                   	pop    %edi
8010367f:	5d                   	pop    %ebp
80103680:	c3                   	ret    
80103681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103688:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010368b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010368e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103694:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
8010369a:	0f b6 06             	movzbl (%esi),%eax
8010369d:	83 c6 01             	add    $0x1,%esi
801036a0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
801036a3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
801036a7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801036aa:	0f 85 58 ff ff ff    	jne    80103608 <pipewrite+0x38>
801036b0:	83 ec 0c             	sub    $0xc,%esp
801036b3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801036b9:	50                   	push   %eax
801036ba:	e8 81 0a 00 00       	call   80104140 <wakeup>
801036bf:	89 1c 24             	mov    %ebx,(%esp)
801036c2:	e8 b9 0e 00 00       	call   80104580 <release>
801036c7:	8b 45 10             	mov    0x10(%ebp),%eax
801036ca:	83 c4 10             	add    $0x10,%esp
801036cd:	eb aa                	jmp    80103679 <pipewrite+0xa9>
801036cf:	90                   	nop

801036d0 <piperead>:
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	57                   	push   %edi
801036d4:	56                   	push   %esi
801036d5:	53                   	push   %ebx
801036d6:	83 ec 18             	sub    $0x18,%esp
801036d9:	8b 75 08             	mov    0x8(%ebp),%esi
801036dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801036df:	56                   	push   %esi
801036e0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801036e6:	e8 f5 0e 00 00       	call   801045e0 <acquire>
801036eb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801036f1:	83 c4 10             	add    $0x10,%esp
801036f4:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
801036fa:	74 2f                	je     8010372b <piperead+0x5b>
801036fc:	eb 37                	jmp    80103735 <piperead+0x65>
801036fe:	66 90                	xchg   %ax,%ax
80103700:	e8 ab 02 00 00       	call   801039b0 <myproc>
80103705:	8b 48 24             	mov    0x24(%eax),%ecx
80103708:	85 c9                	test   %ecx,%ecx
8010370a:	0f 85 80 00 00 00    	jne    80103790 <piperead+0xc0>
80103710:	83 ec 08             	sub    $0x8,%esp
80103713:	56                   	push   %esi
80103714:	53                   	push   %ebx
80103715:	e8 66 09 00 00       	call   80104080 <sleep>
8010371a:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103720:	83 c4 10             	add    $0x10,%esp
80103723:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103729:	75 0a                	jne    80103735 <piperead+0x65>
8010372b:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103731:	85 c0                	test   %eax,%eax
80103733:	75 cb                	jne    80103700 <piperead+0x30>
80103735:	8b 55 10             	mov    0x10(%ebp),%edx
80103738:	31 db                	xor    %ebx,%ebx
8010373a:	85 d2                	test   %edx,%edx
8010373c:	7f 20                	jg     8010375e <piperead+0x8e>
8010373e:	eb 2c                	jmp    8010376c <piperead+0x9c>
80103740:	8d 48 01             	lea    0x1(%eax),%ecx
80103743:	25 ff 01 00 00       	and    $0x1ff,%eax
80103748:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010374e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103753:	88 04 1f             	mov    %al,(%edi,%ebx,1)
80103756:	83 c3 01             	add    $0x1,%ebx
80103759:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010375c:	74 0e                	je     8010376c <piperead+0x9c>
8010375e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103764:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010376a:	75 d4                	jne    80103740 <piperead+0x70>
8010376c:	83 ec 0c             	sub    $0xc,%esp
8010376f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103775:	50                   	push   %eax
80103776:	e8 c5 09 00 00       	call   80104140 <wakeup>
8010377b:	89 34 24             	mov    %esi,(%esp)
8010377e:	e8 fd 0d 00 00       	call   80104580 <release>
80103783:	83 c4 10             	add    $0x10,%esp
80103786:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103789:	89 d8                	mov    %ebx,%eax
8010378b:	5b                   	pop    %ebx
8010378c:	5e                   	pop    %esi
8010378d:	5f                   	pop    %edi
8010378e:	5d                   	pop    %ebp
8010378f:	c3                   	ret    
80103790:	83 ec 0c             	sub    $0xc,%esp
80103793:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103798:	56                   	push   %esi
80103799:	e8 e2 0d 00 00       	call   80104580 <release>
8010379e:	83 c4 10             	add    $0x10,%esp
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
801037c1:	e8 1a 0e 00 00       	call   801045e0 <acquire>
801037c6:	83 c4 10             	add    $0x10,%esp
801037c9:	eb 17                	jmp    801037e2 <allocproc+0x32>
801037cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037cf:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037d0:	81 c3 84 05 00 00    	add    $0x584,%ebx
801037d6:	81 fb 54 8e 12 80    	cmp    $0x80128e54,%ebx
801037dc:	0f 84 ae 00 00 00    	je     80103890 <allocproc+0xe0>
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
80103809:	e8 72 0d 00 00       	call   80104580 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010380e:	e8 6d ee ff ff       	call   80102680 <kalloc>
80103813:	83 c4 10             	add    $0x10,%esp
80103816:	89 43 08             	mov    %eax,0x8(%ebx)
80103819:	85 c0                	test   %eax,%eax
8010381b:	0f 84 88 00 00 00    	je     801038a9 <allocproc+0xf9>
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
80103832:	c7 40 14 92 58 10 80 	movl   $0x80105892,0x14(%eax)
  p->context = (struct context*)sp;
80103839:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010383c:	6a 14                	push   $0x14
8010383e:	6a 00                	push   $0x0
80103840:	50                   	push   %eax
80103841:	e8 5a 0e 00 00       	call   801046a0 <memset>
  p->context->eip = (uint)forkret;
80103846:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103849:	8d 93 7c 05 00 00    	lea    0x57c(%ebx),%edx
8010384f:	83 c4 10             	add    $0x10,%esp
80103852:	c7 40 10 c0 38 10 80 	movl   $0x801038c0,0x10(%eax)

  for (int i = 0; i < 16; ++i) {
80103859:	8d 43 7c             	lea    0x7c(%ebx),%eax
8010385c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->addr[i].va = 0;
80103860:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for (int i = 0; i < 16; ++i) {
80103866:	83 c0 50             	add    $0x50,%eax
    p->addr[i].size = 0;
80103869:	c7 40 b4 00 00 00 00 	movl   $0x0,-0x4c(%eax)
  for (int i = 0; i < 16; ++i) {
80103870:	39 c2                	cmp    %eax,%edx
80103872:	75 ec                	jne    80103860 <allocproc+0xb0>
  }
  p->memory_used = 0;
80103874:	c7 83 7c 05 00 00 00 	movl   $0x0,0x57c(%ebx)
8010387b:	00 00 00 
  p->n_mmaps = 0;

  return p;
}
8010387e:	89 d8                	mov    %ebx,%eax
  p->n_mmaps = 0;
80103880:	c7 83 80 05 00 00 00 	movl   $0x0,0x580(%ebx)
80103887:	00 00 00 
}
8010388a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010388d:	c9                   	leave  
8010388e:	c3                   	ret    
8010388f:	90                   	nop
  release(&ptable.lock);
80103890:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103893:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103895:	68 20 2d 11 80       	push   $0x80112d20
8010389a:	e8 e1 0c 00 00       	call   80104580 <release>
}
8010389f:	89 d8                	mov    %ebx,%eax
  return 0;
801038a1:	83 c4 10             	add    $0x10,%esp
}
801038a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038a7:	c9                   	leave  
801038a8:	c3                   	ret    
    p->state = UNUSED;
801038a9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801038b0:	31 db                	xor    %ebx,%ebx
}
801038b2:	89 d8                	mov    %ebx,%eax
801038b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038b7:	c9                   	leave  
801038b8:	c3                   	ret    
801038b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801038c0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801038c6:	68 20 2d 11 80       	push   $0x80112d20
801038cb:	e8 b0 0c 00 00       	call   80104580 <release>

  if (first) {
801038d0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801038d5:	83 c4 10             	add    $0x10,%esp
801038d8:	85 c0                	test   %eax,%eax
801038da:	75 04                	jne    801038e0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038dc:	c9                   	leave  
801038dd:	c3                   	ret    
801038de:	66 90                	xchg   %ax,%ax
    first = 0;
801038e0:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
801038e7:	00 00 00 
    iinit(ROOTDEV);
801038ea:	83 ec 0c             	sub    $0xc,%esp
801038ed:	6a 01                	push   $0x1
801038ef:	e8 6c dc ff ff       	call   80101560 <iinit>
    initlog(ROOTDEV);
801038f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801038fb:	e8 c0 f3 ff ff       	call   80102cc0 <initlog>
}
80103900:	83 c4 10             	add    $0x10,%esp
80103903:	c9                   	leave  
80103904:	c3                   	ret    
80103905:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010390c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103910 <pinit>:
{
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103916:	68 20 7f 10 80       	push   $0x80107f20
8010391b:	68 20 2d 11 80       	push   $0x80112d20
80103920:	e8 eb 0a 00 00       	call   80104410 <initlock>
}
80103925:	83 c4 10             	add    $0x10,%esp
80103928:	c9                   	leave  
80103929:	c3                   	ret    
8010392a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103930 <mycpu>:
{
80103930:	55                   	push   %ebp
80103931:	89 e5                	mov    %esp,%ebp
80103933:	56                   	push   %esi
80103934:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103935:	9c                   	pushf  
80103936:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103937:	f6 c4 02             	test   $0x2,%ah
8010393a:	75 46                	jne    80103982 <mycpu+0x52>
  apicid = lapicid();
8010393c:	e8 af ef ff ff       	call   801028f0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103941:	8b 35 84 27 11 80    	mov    0x80112784,%esi
80103947:	85 f6                	test   %esi,%esi
80103949:	7e 2a                	jle    80103975 <mycpu+0x45>
8010394b:	31 d2                	xor    %edx,%edx
8010394d:	eb 08                	jmp    80103957 <mycpu+0x27>
8010394f:	90                   	nop
80103950:	83 c2 01             	add    $0x1,%edx
80103953:	39 f2                	cmp    %esi,%edx
80103955:	74 1e                	je     80103975 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103957:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010395d:	0f b6 99 a0 27 11 80 	movzbl -0x7feed860(%ecx),%ebx
80103964:	39 c3                	cmp    %eax,%ebx
80103966:	75 e8                	jne    80103950 <mycpu+0x20>
}
80103968:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010396b:	8d 81 a0 27 11 80    	lea    -0x7feed860(%ecx),%eax
}
80103971:	5b                   	pop    %ebx
80103972:	5e                   	pop    %esi
80103973:	5d                   	pop    %ebp
80103974:	c3                   	ret    
  panic("unknown apicid\n");
80103975:	83 ec 0c             	sub    $0xc,%esp
80103978:	68 27 7f 10 80       	push   $0x80107f27
8010397d:	e8 fe c9 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103982:	83 ec 0c             	sub    $0xc,%esp
80103985:	68 04 80 10 80       	push   $0x80108004
8010398a:	e8 f1 c9 ff ff       	call   80100380 <panic>
8010398f:	90                   	nop

80103990 <cpuid>:
cpuid() {
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103996:	e8 95 ff ff ff       	call   80103930 <mycpu>
}
8010399b:	c9                   	leave  
  return mycpu()-cpus;
8010399c:	2d a0 27 11 80       	sub    $0x801127a0,%eax
801039a1:	c1 f8 04             	sar    $0x4,%eax
801039a4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801039aa:	c3                   	ret    
801039ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039af:	90                   	nop

801039b0 <myproc>:
myproc(void) {
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	53                   	push   %ebx
801039b4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801039b7:	e8 d4 0a 00 00       	call   80104490 <pushcli>
  c = mycpu();
801039bc:	e8 6f ff ff ff       	call   80103930 <mycpu>
  p = c->proc;
801039c1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039c7:	e8 14 0b 00 00       	call   801044e0 <popcli>
}
801039cc:	89 d8                	mov    %ebx,%eax
801039ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039d1:	c9                   	leave  
801039d2:	c3                   	ret    
801039d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801039e0 <userinit>:
{
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
801039e3:	53                   	push   %ebx
801039e4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801039e7:	e8 c4 fd ff ff       	call   801037b0 <allocproc>
801039ec:	89 c3                	mov    %eax,%ebx
  initproc = p;
801039ee:	a3 54 8e 12 80       	mov    %eax,0x80128e54
  if((p->pgdir = setupkvm()) == 0)
801039f3:	e8 a8 36 00 00       	call   801070a0 <setupkvm>
801039f8:	89 43 04             	mov    %eax,0x4(%ebx)
801039fb:	85 c0                	test   %eax,%eax
801039fd:	0f 84 bd 00 00 00    	je     80103ac0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a03:	83 ec 04             	sub    $0x4,%esp
80103a06:	68 2c 00 00 00       	push   $0x2c
80103a0b:	68 60 b4 10 80       	push   $0x8010b460
80103a10:	50                   	push   %eax
80103a11:	e8 3a 33 00 00       	call   80106d50 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103a16:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103a19:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103a1f:	6a 4c                	push   $0x4c
80103a21:	6a 00                	push   $0x0
80103a23:	ff 73 18             	push   0x18(%ebx)
80103a26:	e8 75 0c 00 00       	call   801046a0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a2b:	8b 43 18             	mov    0x18(%ebx),%eax
80103a2e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a33:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a36:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a3b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a3f:	8b 43 18             	mov    0x18(%ebx),%eax
80103a42:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a46:	8b 43 18             	mov    0x18(%ebx),%eax
80103a49:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a4d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a51:	8b 43 18             	mov    0x18(%ebx),%eax
80103a54:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a58:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a5c:	8b 43 18             	mov    0x18(%ebx),%eax
80103a5f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a66:	8b 43 18             	mov    0x18(%ebx),%eax
80103a69:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a70:	8b 43 18             	mov    0x18(%ebx),%eax
80103a73:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a7a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a7d:	6a 10                	push   $0x10
80103a7f:	68 50 7f 10 80       	push   $0x80107f50
80103a84:	50                   	push   %eax
80103a85:	e8 d6 0d 00 00       	call   80104860 <safestrcpy>
  p->cwd = namei("/");
80103a8a:	c7 04 24 59 7f 10 80 	movl   $0x80107f59,(%esp)
80103a91:	e8 0a e6 ff ff       	call   801020a0 <namei>
80103a96:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103a99:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103aa0:	e8 3b 0b 00 00       	call   801045e0 <acquire>
  p->state = RUNNABLE;
80103aa5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103aac:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ab3:	e8 c8 0a 00 00       	call   80104580 <release>
}
80103ab8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103abb:	83 c4 10             	add    $0x10,%esp
80103abe:	c9                   	leave  
80103abf:	c3                   	ret    
    panic("userinit: out of memory?");
80103ac0:	83 ec 0c             	sub    $0xc,%esp
80103ac3:	68 37 7f 10 80       	push   $0x80107f37
80103ac8:	e8 b3 c8 ff ff       	call   80100380 <panic>
80103acd:	8d 76 00             	lea    0x0(%esi),%esi

80103ad0 <growproc>:
{
80103ad0:	55                   	push   %ebp
80103ad1:	89 e5                	mov    %esp,%ebp
80103ad3:	56                   	push   %esi
80103ad4:	53                   	push   %ebx
80103ad5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103ad8:	e8 b3 09 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103add:	e8 4e fe ff ff       	call   80103930 <mycpu>
  p = c->proc;
80103ae2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ae8:	e8 f3 09 00 00       	call   801044e0 <popcli>
  sz = curproc->sz;
80103aed:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103aef:	85 f6                	test   %esi,%esi
80103af1:	7f 1d                	jg     80103b10 <growproc+0x40>
  } else if(n < 0){
80103af3:	75 3b                	jne    80103b30 <growproc+0x60>
  switchuvm(curproc);
80103af5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103af8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103afa:	53                   	push   %ebx
80103afb:	e8 40 31 00 00       	call   80106c40 <switchuvm>
  return 0;
80103b00:	83 c4 10             	add    $0x10,%esp
80103b03:	31 c0                	xor    %eax,%eax
}
80103b05:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b08:	5b                   	pop    %ebx
80103b09:	5e                   	pop    %esi
80103b0a:	5d                   	pop    %ebp
80103b0b:	c3                   	ret    
80103b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b10:	83 ec 04             	sub    $0x4,%esp
80103b13:	01 c6                	add    %eax,%esi
80103b15:	56                   	push   %esi
80103b16:	50                   	push   %eax
80103b17:	ff 73 04             	push   0x4(%ebx)
80103b1a:	e8 a1 33 00 00       	call   80106ec0 <allocuvm>
80103b1f:	83 c4 10             	add    $0x10,%esp
80103b22:	85 c0                	test   %eax,%eax
80103b24:	75 cf                	jne    80103af5 <growproc+0x25>
      return -1;
80103b26:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b2b:	eb d8                	jmp    80103b05 <growproc+0x35>
80103b2d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b30:	83 ec 04             	sub    $0x4,%esp
80103b33:	01 c6                	add    %eax,%esi
80103b35:	56                   	push   %esi
80103b36:	50                   	push   %eax
80103b37:	ff 73 04             	push   0x4(%ebx)
80103b3a:	e8 b1 34 00 00       	call   80106ff0 <deallocuvm>
80103b3f:	83 c4 10             	add    $0x10,%esp
80103b42:	85 c0                	test   %eax,%eax
80103b44:	75 af                	jne    80103af5 <growproc+0x25>
80103b46:	eb de                	jmp    80103b26 <growproc+0x56>
80103b48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b4f:	90                   	nop

80103b50 <fork>:
{
80103b50:	55                   	push   %ebp
80103b51:	89 e5                	mov    %esp,%ebp
80103b53:	57                   	push   %edi
80103b54:	56                   	push   %esi
80103b55:	53                   	push   %ebx
80103b56:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103b59:	e8 32 09 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103b5e:	e8 cd fd ff ff       	call   80103930 <mycpu>
  p = c->proc;
80103b63:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b69:	e8 72 09 00 00       	call   801044e0 <popcli>
  if((np = allocproc()) == 0){
80103b6e:	e8 3d fc ff ff       	call   801037b0 <allocproc>
80103b73:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b76:	85 c0                	test   %eax,%eax
80103b78:	0f 84 b7 00 00 00    	je     80103c35 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b7e:	83 ec 08             	sub    $0x8,%esp
80103b81:	ff 33                	push   (%ebx)
80103b83:	89 c7                	mov    %eax,%edi
80103b85:	ff 73 04             	push   0x4(%ebx)
80103b88:	e8 03 36 00 00       	call   80107190 <copyuvm>
80103b8d:	83 c4 10             	add    $0x10,%esp
80103b90:	89 47 04             	mov    %eax,0x4(%edi)
80103b93:	85 c0                	test   %eax,%eax
80103b95:	0f 84 a1 00 00 00    	je     80103c3c <fork+0xec>
  np->sz = curproc->sz;
80103b9b:	8b 03                	mov    (%ebx),%eax
80103b9d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103ba0:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103ba2:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103ba5:	89 c8                	mov    %ecx,%eax
80103ba7:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103baa:	b9 13 00 00 00       	mov    $0x13,%ecx
80103baf:	8b 73 18             	mov    0x18(%ebx),%esi
80103bb2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103bb4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103bb6:	8b 40 18             	mov    0x18(%eax),%eax
80103bb9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103bc0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103bc4:	85 c0                	test   %eax,%eax
80103bc6:	74 13                	je     80103bdb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103bc8:	83 ec 0c             	sub    $0xc,%esp
80103bcb:	50                   	push   %eax
80103bcc:	e8 cf d2 ff ff       	call   80100ea0 <filedup>
80103bd1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103bd4:	83 c4 10             	add    $0x10,%esp
80103bd7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103bdb:	83 c6 01             	add    $0x1,%esi
80103bde:	83 fe 10             	cmp    $0x10,%esi
80103be1:	75 dd                	jne    80103bc0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103be3:	83 ec 0c             	sub    $0xc,%esp
80103be6:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103be9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103bec:	e8 5f db ff ff       	call   80101750 <idup>
80103bf1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bf4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103bf7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bfa:	8d 47 6c             	lea    0x6c(%edi),%eax
80103bfd:	6a 10                	push   $0x10
80103bff:	53                   	push   %ebx
80103c00:	50                   	push   %eax
80103c01:	e8 5a 0c 00 00       	call   80104860 <safestrcpy>
  pid = np->pid;
80103c06:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103c09:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c10:	e8 cb 09 00 00       	call   801045e0 <acquire>
  np->state = RUNNABLE;
80103c15:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103c1c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c23:	e8 58 09 00 00       	call   80104580 <release>
  return pid;
80103c28:	83 c4 10             	add    $0x10,%esp
}
80103c2b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c2e:	89 d8                	mov    %ebx,%eax
80103c30:	5b                   	pop    %ebx
80103c31:	5e                   	pop    %esi
80103c32:	5f                   	pop    %edi
80103c33:	5d                   	pop    %ebp
80103c34:	c3                   	ret    
    return -1;
80103c35:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c3a:	eb ef                	jmp    80103c2b <fork+0xdb>
    kfree(np->kstack);
80103c3c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103c3f:	83 ec 0c             	sub    $0xc,%esp
80103c42:	ff 73 08             	push   0x8(%ebx)
80103c45:	e8 76 e8 ff ff       	call   801024c0 <kfree>
    np->kstack = 0;
80103c4a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103c51:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103c54:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103c5b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c60:	eb c9                	jmp    80103c2b <fork+0xdb>
80103c62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c70 <scheduler>:
{
80103c70:	55                   	push   %ebp
80103c71:	89 e5                	mov    %esp,%ebp
80103c73:	57                   	push   %edi
80103c74:	56                   	push   %esi
80103c75:	53                   	push   %ebx
80103c76:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103c79:	e8 b2 fc ff ff       	call   80103930 <mycpu>
  c->proc = 0;
80103c7e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103c85:	00 00 00 
  struct cpu *c = mycpu();
80103c88:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103c8a:	8d 78 04             	lea    0x4(%eax),%edi
80103c8d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103c90:	fb                   	sti    
    acquire(&ptable.lock);
80103c91:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c94:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103c99:	68 20 2d 11 80       	push   $0x80112d20
80103c9e:	e8 3d 09 00 00       	call   801045e0 <acquire>
80103ca3:	83 c4 10             	add    $0x10,%esp
80103ca6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cad:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80103cb0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103cb4:	75 33                	jne    80103ce9 <scheduler+0x79>
      switchuvm(p);
80103cb6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103cb9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103cbf:	53                   	push   %ebx
80103cc0:	e8 7b 2f 00 00       	call   80106c40 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103cc5:	58                   	pop    %eax
80103cc6:	5a                   	pop    %edx
80103cc7:	ff 73 1c             	push   0x1c(%ebx)
80103cca:	57                   	push   %edi
      p->state = RUNNING;
80103ccb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103cd2:	e8 e4 0b 00 00       	call   801048bb <swtch>
      switchkvm();
80103cd7:	e8 54 2f 00 00       	call   80106c30 <switchkvm>
      c->proc = 0;
80103cdc:	83 c4 10             	add    $0x10,%esp
80103cdf:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103ce6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ce9:	81 c3 84 05 00 00    	add    $0x584,%ebx
80103cef:	81 fb 54 8e 12 80    	cmp    $0x80128e54,%ebx
80103cf5:	75 b9                	jne    80103cb0 <scheduler+0x40>
    release(&ptable.lock);
80103cf7:	83 ec 0c             	sub    $0xc,%esp
80103cfa:	68 20 2d 11 80       	push   $0x80112d20
80103cff:	e8 7c 08 00 00       	call   80104580 <release>
    sti();
80103d04:	83 c4 10             	add    $0x10,%esp
80103d07:	eb 87                	jmp    80103c90 <scheduler+0x20>
80103d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d10 <sched>:
{
80103d10:	55                   	push   %ebp
80103d11:	89 e5                	mov    %esp,%ebp
80103d13:	56                   	push   %esi
80103d14:	53                   	push   %ebx
  pushcli();
80103d15:	e8 76 07 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103d1a:	e8 11 fc ff ff       	call   80103930 <mycpu>
  p = c->proc;
80103d1f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d25:	e8 b6 07 00 00       	call   801044e0 <popcli>
  if(!holding(&ptable.lock))
80103d2a:	83 ec 0c             	sub    $0xc,%esp
80103d2d:	68 20 2d 11 80       	push   $0x80112d20
80103d32:	e8 09 08 00 00       	call   80104540 <holding>
80103d37:	83 c4 10             	add    $0x10,%esp
80103d3a:	85 c0                	test   %eax,%eax
80103d3c:	74 4f                	je     80103d8d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103d3e:	e8 ed fb ff ff       	call   80103930 <mycpu>
80103d43:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103d4a:	75 68                	jne    80103db4 <sched+0xa4>
  if(p->state == RUNNING)
80103d4c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103d50:	74 55                	je     80103da7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d52:	9c                   	pushf  
80103d53:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103d54:	f6 c4 02             	test   $0x2,%ah
80103d57:	75 41                	jne    80103d9a <sched+0x8a>
  intena = mycpu()->intena;
80103d59:	e8 d2 fb ff ff       	call   80103930 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103d5e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103d61:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103d67:	e8 c4 fb ff ff       	call   80103930 <mycpu>
80103d6c:	83 ec 08             	sub    $0x8,%esp
80103d6f:	ff 70 04             	push   0x4(%eax)
80103d72:	53                   	push   %ebx
80103d73:	e8 43 0b 00 00       	call   801048bb <swtch>
  mycpu()->intena = intena;
80103d78:	e8 b3 fb ff ff       	call   80103930 <mycpu>
}
80103d7d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103d80:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d86:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d89:	5b                   	pop    %ebx
80103d8a:	5e                   	pop    %esi
80103d8b:	5d                   	pop    %ebp
80103d8c:	c3                   	ret    
    panic("sched ptable.lock");
80103d8d:	83 ec 0c             	sub    $0xc,%esp
80103d90:	68 5b 7f 10 80       	push   $0x80107f5b
80103d95:	e8 e6 c5 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103d9a:	83 ec 0c             	sub    $0xc,%esp
80103d9d:	68 87 7f 10 80       	push   $0x80107f87
80103da2:	e8 d9 c5 ff ff       	call   80100380 <panic>
    panic("sched running");
80103da7:	83 ec 0c             	sub    $0xc,%esp
80103daa:	68 79 7f 10 80       	push   $0x80107f79
80103daf:	e8 cc c5 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103db4:	83 ec 0c             	sub    $0xc,%esp
80103db7:	68 6d 7f 10 80       	push   $0x80107f6d
80103dbc:	e8 bf c5 ff ff       	call   80100380 <panic>
80103dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103dc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103dcf:	90                   	nop

80103dd0 <exit>:
{
80103dd0:	55                   	push   %ebp
80103dd1:	89 e5                	mov    %esp,%ebp
80103dd3:	57                   	push   %edi
80103dd4:	56                   	push   %esi
80103dd5:	53                   	push   %ebx
80103dd6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103dd9:	e8 d2 fb ff ff       	call   801039b0 <myproc>
  if(curproc == initproc)
80103dde:	39 05 54 8e 12 80    	cmp    %eax,0x80128e54
80103de4:	0f 84 07 01 00 00    	je     80103ef1 <exit+0x121>
80103dea:	89 c3                	mov    %eax,%ebx
80103dec:	8d 70 28             	lea    0x28(%eax),%esi
80103def:	8d 78 68             	lea    0x68(%eax),%edi
80103df2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103df8:	8b 06                	mov    (%esi),%eax
80103dfa:	85 c0                	test   %eax,%eax
80103dfc:	74 12                	je     80103e10 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80103dfe:	83 ec 0c             	sub    $0xc,%esp
80103e01:	50                   	push   %eax
80103e02:	e8 e9 d0 ff ff       	call   80100ef0 <fileclose>
      curproc->ofile[fd] = 0;
80103e07:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103e0d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103e10:	83 c6 04             	add    $0x4,%esi
80103e13:	39 f7                	cmp    %esi,%edi
80103e15:	75 e1                	jne    80103df8 <exit+0x28>
  begin_op();
80103e17:	e8 44 ef ff ff       	call   80102d60 <begin_op>
  iput(curproc->cwd);
80103e1c:	83 ec 0c             	sub    $0xc,%esp
80103e1f:	ff 73 68             	push   0x68(%ebx)
80103e22:	e8 89 da ff ff       	call   801018b0 <iput>
  end_op();
80103e27:	e8 a4 ef ff ff       	call   80102dd0 <end_op>
  curproc->cwd = 0;
80103e2c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103e33:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e3a:	e8 a1 07 00 00       	call   801045e0 <acquire>
  wakeup1(curproc->parent);
80103e3f:	8b 53 14             	mov    0x14(%ebx),%edx
80103e42:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e45:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103e4a:	eb 10                	jmp    80103e5c <exit+0x8c>
80103e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e50:	05 84 05 00 00       	add    $0x584,%eax
80103e55:	3d 54 8e 12 80       	cmp    $0x80128e54,%eax
80103e5a:	74 1e                	je     80103e7a <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
80103e5c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e60:	75 ee                	jne    80103e50 <exit+0x80>
80103e62:	3b 50 20             	cmp    0x20(%eax),%edx
80103e65:	75 e9                	jne    80103e50 <exit+0x80>
      p->state = RUNNABLE;
80103e67:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e6e:	05 84 05 00 00       	add    $0x584,%eax
80103e73:	3d 54 8e 12 80       	cmp    $0x80128e54,%eax
80103e78:	75 e2                	jne    80103e5c <exit+0x8c>
      p->parent = initproc;
80103e7a:	8b 0d 54 8e 12 80    	mov    0x80128e54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e80:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103e85:	eb 17                	jmp    80103e9e <exit+0xce>
80103e87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e8e:	66 90                	xchg   %ax,%ax
80103e90:	81 c2 84 05 00 00    	add    $0x584,%edx
80103e96:	81 fa 54 8e 12 80    	cmp    $0x80128e54,%edx
80103e9c:	74 3a                	je     80103ed8 <exit+0x108>
    if(p->parent == curproc){
80103e9e:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103ea1:	75 ed                	jne    80103e90 <exit+0xc0>
      if(p->state == ZOMBIE)
80103ea3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103ea7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103eaa:	75 e4                	jne    80103e90 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103eac:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103eb1:	eb 11                	jmp    80103ec4 <exit+0xf4>
80103eb3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103eb7:	90                   	nop
80103eb8:	05 84 05 00 00       	add    $0x584,%eax
80103ebd:	3d 54 8e 12 80       	cmp    $0x80128e54,%eax
80103ec2:	74 cc                	je     80103e90 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103ec4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103ec8:	75 ee                	jne    80103eb8 <exit+0xe8>
80103eca:	3b 48 20             	cmp    0x20(%eax),%ecx
80103ecd:	75 e9                	jne    80103eb8 <exit+0xe8>
      p->state = RUNNABLE;
80103ecf:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103ed6:	eb e0                	jmp    80103eb8 <exit+0xe8>
  curproc->state = ZOMBIE;
80103ed8:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103edf:	e8 2c fe ff ff       	call   80103d10 <sched>
  panic("zombie exit");
80103ee4:	83 ec 0c             	sub    $0xc,%esp
80103ee7:	68 a8 7f 10 80       	push   $0x80107fa8
80103eec:	e8 8f c4 ff ff       	call   80100380 <panic>
    panic("init exiting");
80103ef1:	83 ec 0c             	sub    $0xc,%esp
80103ef4:	68 9b 7f 10 80       	push   $0x80107f9b
80103ef9:	e8 82 c4 ff ff       	call   80100380 <panic>
80103efe:	66 90                	xchg   %ax,%ax

80103f00 <wait>:
{
80103f00:	55                   	push   %ebp
80103f01:	89 e5                	mov    %esp,%ebp
80103f03:	56                   	push   %esi
80103f04:	53                   	push   %ebx
  pushcli();
80103f05:	e8 86 05 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103f0a:	e8 21 fa ff ff       	call   80103930 <mycpu>
  p = c->proc;
80103f0f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f15:	e8 c6 05 00 00       	call   801044e0 <popcli>
  acquire(&ptable.lock);
80103f1a:	83 ec 0c             	sub    $0xc,%esp
80103f1d:	68 20 2d 11 80       	push   $0x80112d20
80103f22:	e8 b9 06 00 00       	call   801045e0 <acquire>
80103f27:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103f2a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f2c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103f31:	eb 13                	jmp    80103f46 <wait+0x46>
80103f33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f37:	90                   	nop
80103f38:	81 c3 84 05 00 00    	add    $0x584,%ebx
80103f3e:	81 fb 54 8e 12 80    	cmp    $0x80128e54,%ebx
80103f44:	74 1e                	je     80103f64 <wait+0x64>
      if(p->parent != curproc)
80103f46:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f49:	75 ed                	jne    80103f38 <wait+0x38>
      if(p->state == ZOMBIE){
80103f4b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f4f:	74 5f                	je     80103fb0 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f51:	81 c3 84 05 00 00    	add    $0x584,%ebx
      havekids = 1;
80103f57:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f5c:	81 fb 54 8e 12 80    	cmp    $0x80128e54,%ebx
80103f62:	75 e2                	jne    80103f46 <wait+0x46>
    if(!havekids || curproc->killed){
80103f64:	85 c0                	test   %eax,%eax
80103f66:	0f 84 9a 00 00 00    	je     80104006 <wait+0x106>
80103f6c:	8b 46 24             	mov    0x24(%esi),%eax
80103f6f:	85 c0                	test   %eax,%eax
80103f71:	0f 85 8f 00 00 00    	jne    80104006 <wait+0x106>
  pushcli();
80103f77:	e8 14 05 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103f7c:	e8 af f9 ff ff       	call   80103930 <mycpu>
  p = c->proc;
80103f81:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f87:	e8 54 05 00 00       	call   801044e0 <popcli>
  if(p == 0)
80103f8c:	85 db                	test   %ebx,%ebx
80103f8e:	0f 84 89 00 00 00    	je     8010401d <wait+0x11d>
  p->chan = chan;
80103f94:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80103f97:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f9e:	e8 6d fd ff ff       	call   80103d10 <sched>
  p->chan = 0;
80103fa3:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103faa:	e9 7b ff ff ff       	jmp    80103f2a <wait+0x2a>
80103faf:	90                   	nop
        kfree(p->kstack);
80103fb0:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80103fb3:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103fb6:	ff 73 08             	push   0x8(%ebx)
80103fb9:	e8 02 e5 ff ff       	call   801024c0 <kfree>
        p->kstack = 0;
80103fbe:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103fc5:	5a                   	pop    %edx
80103fc6:	ff 73 04             	push   0x4(%ebx)
80103fc9:	e8 52 30 00 00       	call   80107020 <freevm>
        p->pid = 0;
80103fce:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103fd5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103fdc:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103fe0:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103fe7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103fee:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ff5:	e8 86 05 00 00       	call   80104580 <release>
        return pid;
80103ffa:	83 c4 10             	add    $0x10,%esp
}
80103ffd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104000:	89 f0                	mov    %esi,%eax
80104002:	5b                   	pop    %ebx
80104003:	5e                   	pop    %esi
80104004:	5d                   	pop    %ebp
80104005:	c3                   	ret    
      release(&ptable.lock);
80104006:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104009:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010400e:	68 20 2d 11 80       	push   $0x80112d20
80104013:	e8 68 05 00 00       	call   80104580 <release>
      return -1;
80104018:	83 c4 10             	add    $0x10,%esp
8010401b:	eb e0                	jmp    80103ffd <wait+0xfd>
    panic("sleep");
8010401d:	83 ec 0c             	sub    $0xc,%esp
80104020:	68 b4 7f 10 80       	push   $0x80107fb4
80104025:	e8 56 c3 ff ff       	call   80100380 <panic>
8010402a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104030 <yield>:
{
80104030:	55                   	push   %ebp
80104031:	89 e5                	mov    %esp,%ebp
80104033:	53                   	push   %ebx
80104034:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104037:	68 20 2d 11 80       	push   $0x80112d20
8010403c:	e8 9f 05 00 00       	call   801045e0 <acquire>
  pushcli();
80104041:	e8 4a 04 00 00       	call   80104490 <pushcli>
  c = mycpu();
80104046:	e8 e5 f8 ff ff       	call   80103930 <mycpu>
  p = c->proc;
8010404b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104051:	e8 8a 04 00 00       	call   801044e0 <popcli>
  myproc()->state = RUNNABLE;
80104056:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010405d:	e8 ae fc ff ff       	call   80103d10 <sched>
  release(&ptable.lock);
80104062:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104069:	e8 12 05 00 00       	call   80104580 <release>
}
8010406e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104071:	83 c4 10             	add    $0x10,%esp
80104074:	c9                   	leave  
80104075:	c3                   	ret    
80104076:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010407d:	8d 76 00             	lea    0x0(%esi),%esi

80104080 <sleep>:
{
80104080:	55                   	push   %ebp
80104081:	89 e5                	mov    %esp,%ebp
80104083:	57                   	push   %edi
80104084:	56                   	push   %esi
80104085:	53                   	push   %ebx
80104086:	83 ec 0c             	sub    $0xc,%esp
80104089:	8b 7d 08             	mov    0x8(%ebp),%edi
8010408c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010408f:	e8 fc 03 00 00       	call   80104490 <pushcli>
  c = mycpu();
80104094:	e8 97 f8 ff ff       	call   80103930 <mycpu>
  p = c->proc;
80104099:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010409f:	e8 3c 04 00 00       	call   801044e0 <popcli>
  if(p == 0)
801040a4:	85 db                	test   %ebx,%ebx
801040a6:	0f 84 87 00 00 00    	je     80104133 <sleep+0xb3>
  if(lk == 0)
801040ac:	85 f6                	test   %esi,%esi
801040ae:	74 76                	je     80104126 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801040b0:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
801040b6:	74 50                	je     80104108 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801040b8:	83 ec 0c             	sub    $0xc,%esp
801040bb:	68 20 2d 11 80       	push   $0x80112d20
801040c0:	e8 1b 05 00 00       	call   801045e0 <acquire>
    release(lk);
801040c5:	89 34 24             	mov    %esi,(%esp)
801040c8:	e8 b3 04 00 00       	call   80104580 <release>
  p->chan = chan;
801040cd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801040d0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801040d7:	e8 34 fc ff ff       	call   80103d10 <sched>
  p->chan = 0;
801040dc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801040e3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801040ea:	e8 91 04 00 00       	call   80104580 <release>
    acquire(lk);
801040ef:	89 75 08             	mov    %esi,0x8(%ebp)
801040f2:	83 c4 10             	add    $0x10,%esp
}
801040f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040f8:	5b                   	pop    %ebx
801040f9:	5e                   	pop    %esi
801040fa:	5f                   	pop    %edi
801040fb:	5d                   	pop    %ebp
    acquire(lk);
801040fc:	e9 df 04 00 00       	jmp    801045e0 <acquire>
80104101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104108:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010410b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104112:	e8 f9 fb ff ff       	call   80103d10 <sched>
  p->chan = 0;
80104117:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010411e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104121:	5b                   	pop    %ebx
80104122:	5e                   	pop    %esi
80104123:	5f                   	pop    %edi
80104124:	5d                   	pop    %ebp
80104125:	c3                   	ret    
    panic("sleep without lk");
80104126:	83 ec 0c             	sub    $0xc,%esp
80104129:	68 ba 7f 10 80       	push   $0x80107fba
8010412e:	e8 4d c2 ff ff       	call   80100380 <panic>
    panic("sleep");
80104133:	83 ec 0c             	sub    $0xc,%esp
80104136:	68 b4 7f 10 80       	push   $0x80107fb4
8010413b:	e8 40 c2 ff ff       	call   80100380 <panic>

80104140 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	53                   	push   %ebx
80104144:	83 ec 10             	sub    $0x10,%esp
80104147:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010414a:	68 20 2d 11 80       	push   $0x80112d20
8010414f:	e8 8c 04 00 00       	call   801045e0 <acquire>
80104154:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104157:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010415c:	eb 0e                	jmp    8010416c <wakeup+0x2c>
8010415e:	66 90                	xchg   %ax,%ax
80104160:	05 84 05 00 00       	add    $0x584,%eax
80104165:	3d 54 8e 12 80       	cmp    $0x80128e54,%eax
8010416a:	74 1e                	je     8010418a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010416c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104170:	75 ee                	jne    80104160 <wakeup+0x20>
80104172:	3b 58 20             	cmp    0x20(%eax),%ebx
80104175:	75 e9                	jne    80104160 <wakeup+0x20>
      p->state = RUNNABLE;
80104177:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010417e:	05 84 05 00 00       	add    $0x584,%eax
80104183:	3d 54 8e 12 80       	cmp    $0x80128e54,%eax
80104188:	75 e2                	jne    8010416c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010418a:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80104191:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104194:	c9                   	leave  
  release(&ptable.lock);
80104195:	e9 e6 03 00 00       	jmp    80104580 <release>
8010419a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801041a0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801041a0:	55                   	push   %ebp
801041a1:	89 e5                	mov    %esp,%ebp
801041a3:	53                   	push   %ebx
801041a4:	83 ec 10             	sub    $0x10,%esp
801041a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801041aa:	68 20 2d 11 80       	push   $0x80112d20
801041af:	e8 2c 04 00 00       	call   801045e0 <acquire>
801041b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041b7:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801041bc:	eb 0e                	jmp    801041cc <kill+0x2c>
801041be:	66 90                	xchg   %ax,%ax
801041c0:	05 84 05 00 00       	add    $0x584,%eax
801041c5:	3d 54 8e 12 80       	cmp    $0x80128e54,%eax
801041ca:	74 34                	je     80104200 <kill+0x60>
    if(p->pid == pid){
801041cc:	39 58 10             	cmp    %ebx,0x10(%eax)
801041cf:	75 ef                	jne    801041c0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801041d1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801041d5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801041dc:	75 07                	jne    801041e5 <kill+0x45>
        p->state = RUNNABLE;
801041de:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801041e5:	83 ec 0c             	sub    $0xc,%esp
801041e8:	68 20 2d 11 80       	push   $0x80112d20
801041ed:	e8 8e 03 00 00       	call   80104580 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801041f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801041f5:	83 c4 10             	add    $0x10,%esp
801041f8:	31 c0                	xor    %eax,%eax
}
801041fa:	c9                   	leave  
801041fb:	c3                   	ret    
801041fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104200:	83 ec 0c             	sub    $0xc,%esp
80104203:	68 20 2d 11 80       	push   $0x80112d20
80104208:	e8 73 03 00 00       	call   80104580 <release>
}
8010420d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104210:	83 c4 10             	add    $0x10,%esp
80104213:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104218:	c9                   	leave  
80104219:	c3                   	ret    
8010421a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104220 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	57                   	push   %edi
80104224:	56                   	push   %esi
80104225:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104228:	53                   	push   %ebx
80104229:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
8010422e:	83 ec 3c             	sub    $0x3c,%esp
80104231:	eb 27                	jmp    8010425a <procdump+0x3a>
80104233:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104237:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104238:	83 ec 0c             	sub    $0xc,%esp
8010423b:	68 df 83 10 80       	push   $0x801083df
80104240:	e8 5b c4 ff ff       	call   801006a0 <cprintf>
80104245:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104248:	81 c3 84 05 00 00    	add    $0x584,%ebx
8010424e:	81 fb c0 8e 12 80    	cmp    $0x80128ec0,%ebx
80104254:	0f 84 7e 00 00 00    	je     801042d8 <procdump+0xb8>
    if(p->state == UNUSED)
8010425a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010425d:	85 c0                	test   %eax,%eax
8010425f:	74 e7                	je     80104248 <procdump+0x28>
      state = "???";
80104261:	ba cb 7f 10 80       	mov    $0x80107fcb,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104266:	83 f8 05             	cmp    $0x5,%eax
80104269:	77 11                	ja     8010427c <procdump+0x5c>
8010426b:	8b 14 85 2c 80 10 80 	mov    -0x7fef7fd4(,%eax,4),%edx
      state = "???";
80104272:	b8 cb 7f 10 80       	mov    $0x80107fcb,%eax
80104277:	85 d2                	test   %edx,%edx
80104279:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010427c:	53                   	push   %ebx
8010427d:	52                   	push   %edx
8010427e:	ff 73 a4             	push   -0x5c(%ebx)
80104281:	68 cf 7f 10 80       	push   $0x80107fcf
80104286:	e8 15 c4 ff ff       	call   801006a0 <cprintf>
    if(p->state == SLEEPING){
8010428b:	83 c4 10             	add    $0x10,%esp
8010428e:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104292:	75 a4                	jne    80104238 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104294:	83 ec 08             	sub    $0x8,%esp
80104297:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010429a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010429d:	50                   	push   %eax
8010429e:	8b 43 b0             	mov    -0x50(%ebx),%eax
801042a1:	8b 40 0c             	mov    0xc(%eax),%eax
801042a4:	83 c0 08             	add    $0x8,%eax
801042a7:	50                   	push   %eax
801042a8:	e8 83 01 00 00       	call   80104430 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801042ad:	83 c4 10             	add    $0x10,%esp
801042b0:	8b 17                	mov    (%edi),%edx
801042b2:	85 d2                	test   %edx,%edx
801042b4:	74 82                	je     80104238 <procdump+0x18>
        cprintf(" %p", pc[i]);
801042b6:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801042b9:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
801042bc:	52                   	push   %edx
801042bd:	68 21 7a 10 80       	push   $0x80107a21
801042c2:	e8 d9 c3 ff ff       	call   801006a0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801042c7:	83 c4 10             	add    $0x10,%esp
801042ca:	39 fe                	cmp    %edi,%esi
801042cc:	75 e2                	jne    801042b0 <procdump+0x90>
801042ce:	e9 65 ff ff ff       	jmp    80104238 <procdump+0x18>
801042d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042d7:	90                   	nop
  }
}
801042d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042db:	5b                   	pop    %ebx
801042dc:	5e                   	pop    %esi
801042dd:	5f                   	pop    %edi
801042de:	5d                   	pop    %ebp
801042df:	c3                   	ret    

801042e0 <initsleeplock>:
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	53                   	push   %ebx
801042e4:	83 ec 0c             	sub    $0xc,%esp
801042e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801042ea:	68 44 80 10 80       	push   $0x80108044
801042ef:	8d 43 04             	lea    0x4(%ebx),%eax
801042f2:	50                   	push   %eax
801042f3:	e8 18 01 00 00       	call   80104410 <initlock>
801042f8:	8b 45 0c             	mov    0xc(%ebp),%eax
801042fb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104301:	83 c4 10             	add    $0x10,%esp
80104304:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
8010430b:	89 43 38             	mov    %eax,0x38(%ebx)
8010430e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104311:	c9                   	leave  
80104312:	c3                   	ret    
80104313:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010431a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104320 <acquiresleep>:
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	56                   	push   %esi
80104324:	53                   	push   %ebx
80104325:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104328:	8d 73 04             	lea    0x4(%ebx),%esi
8010432b:	83 ec 0c             	sub    $0xc,%esp
8010432e:	56                   	push   %esi
8010432f:	e8 ac 02 00 00       	call   801045e0 <acquire>
80104334:	8b 13                	mov    (%ebx),%edx
80104336:	83 c4 10             	add    $0x10,%esp
80104339:	85 d2                	test   %edx,%edx
8010433b:	74 16                	je     80104353 <acquiresleep+0x33>
8010433d:	8d 76 00             	lea    0x0(%esi),%esi
80104340:	83 ec 08             	sub    $0x8,%esp
80104343:	56                   	push   %esi
80104344:	53                   	push   %ebx
80104345:	e8 36 fd ff ff       	call   80104080 <sleep>
8010434a:	8b 03                	mov    (%ebx),%eax
8010434c:	83 c4 10             	add    $0x10,%esp
8010434f:	85 c0                	test   %eax,%eax
80104351:	75 ed                	jne    80104340 <acquiresleep+0x20>
80104353:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
80104359:	e8 52 f6 ff ff       	call   801039b0 <myproc>
8010435e:	8b 40 10             	mov    0x10(%eax),%eax
80104361:	89 43 3c             	mov    %eax,0x3c(%ebx)
80104364:	89 75 08             	mov    %esi,0x8(%ebp)
80104367:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010436a:	5b                   	pop    %ebx
8010436b:	5e                   	pop    %esi
8010436c:	5d                   	pop    %ebp
8010436d:	e9 0e 02 00 00       	jmp    80104580 <release>
80104372:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104380 <releasesleep>:
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	56                   	push   %esi
80104384:	53                   	push   %ebx
80104385:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104388:	8d 73 04             	lea    0x4(%ebx),%esi
8010438b:	83 ec 0c             	sub    $0xc,%esp
8010438e:	56                   	push   %esi
8010438f:	e8 4c 02 00 00       	call   801045e0 <acquire>
80104394:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010439a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
801043a1:	89 1c 24             	mov    %ebx,(%esp)
801043a4:	e8 97 fd ff ff       	call   80104140 <wakeup>
801043a9:	89 75 08             	mov    %esi,0x8(%ebp)
801043ac:	83 c4 10             	add    $0x10,%esp
801043af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043b2:	5b                   	pop    %ebx
801043b3:	5e                   	pop    %esi
801043b4:	5d                   	pop    %ebp
801043b5:	e9 c6 01 00 00       	jmp    80104580 <release>
801043ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043c0 <holdingsleep>:
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	57                   	push   %edi
801043c4:	31 ff                	xor    %edi,%edi
801043c6:	56                   	push   %esi
801043c7:	53                   	push   %ebx
801043c8:	83 ec 18             	sub    $0x18,%esp
801043cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
801043ce:	8d 73 04             	lea    0x4(%ebx),%esi
801043d1:	56                   	push   %esi
801043d2:	e8 09 02 00 00       	call   801045e0 <acquire>
801043d7:	8b 03                	mov    (%ebx),%eax
801043d9:	83 c4 10             	add    $0x10,%esp
801043dc:	85 c0                	test   %eax,%eax
801043de:	75 18                	jne    801043f8 <holdingsleep+0x38>
801043e0:	83 ec 0c             	sub    $0xc,%esp
801043e3:	56                   	push   %esi
801043e4:	e8 97 01 00 00       	call   80104580 <release>
801043e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043ec:	89 f8                	mov    %edi,%eax
801043ee:	5b                   	pop    %ebx
801043ef:	5e                   	pop    %esi
801043f0:	5f                   	pop    %edi
801043f1:	5d                   	pop    %ebp
801043f2:	c3                   	ret    
801043f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043f7:	90                   	nop
801043f8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801043fb:	e8 b0 f5 ff ff       	call   801039b0 <myproc>
80104400:	39 58 10             	cmp    %ebx,0x10(%eax)
80104403:	0f 94 c0             	sete   %al
80104406:	0f b6 c0             	movzbl %al,%eax
80104409:	89 c7                	mov    %eax,%edi
8010440b:	eb d3                	jmp    801043e0 <holdingsleep+0x20>
8010440d:	66 90                	xchg   %ax,%ax
8010440f:	90                   	nop

80104410 <initlock>:
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	8b 45 08             	mov    0x8(%ebp),%eax
80104416:	8b 55 0c             	mov    0xc(%ebp),%edx
80104419:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010441f:	89 50 04             	mov    %edx,0x4(%eax)
80104422:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104429:	5d                   	pop    %ebp
8010442a:	c3                   	ret    
8010442b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010442f:	90                   	nop

80104430 <getcallerpcs>:
80104430:	55                   	push   %ebp
80104431:	31 d2                	xor    %edx,%edx
80104433:	89 e5                	mov    %esp,%ebp
80104435:	53                   	push   %ebx
80104436:	8b 45 08             	mov    0x8(%ebp),%eax
80104439:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010443c:	83 e8 08             	sub    $0x8,%eax
8010443f:	90                   	nop
80104440:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104446:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010444c:	77 1a                	ja     80104468 <getcallerpcs+0x38>
8010444e:	8b 58 04             	mov    0x4(%eax),%ebx
80104451:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
80104454:	83 c2 01             	add    $0x1,%edx
80104457:	8b 00                	mov    (%eax),%eax
80104459:	83 fa 0a             	cmp    $0xa,%edx
8010445c:	75 e2                	jne    80104440 <getcallerpcs+0x10>
8010445e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104461:	c9                   	leave  
80104462:	c3                   	ret    
80104463:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104467:	90                   	nop
80104468:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010446b:	8d 51 28             	lea    0x28(%ecx),%edx
8010446e:	66 90                	xchg   %ax,%ax
80104470:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104476:	83 c0 04             	add    $0x4,%eax
80104479:	39 d0                	cmp    %edx,%eax
8010447b:	75 f3                	jne    80104470 <getcallerpcs+0x40>
8010447d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104480:	c9                   	leave  
80104481:	c3                   	ret    
80104482:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104490 <pushcli>:
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	53                   	push   %ebx
80104494:	83 ec 04             	sub    $0x4,%esp
80104497:	9c                   	pushf  
80104498:	5b                   	pop    %ebx
80104499:	fa                   	cli    
8010449a:	e8 91 f4 ff ff       	call   80103930 <mycpu>
8010449f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801044a5:	85 c0                	test   %eax,%eax
801044a7:	74 17                	je     801044c0 <pushcli+0x30>
801044a9:	e8 82 f4 ff ff       	call   80103930 <mycpu>
801044ae:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
801044b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044b8:	c9                   	leave  
801044b9:	c3                   	ret    
801044ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044c0:	e8 6b f4 ff ff       	call   80103930 <mycpu>
801044c5:	81 e3 00 02 00 00    	and    $0x200,%ebx
801044cb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801044d1:	eb d6                	jmp    801044a9 <pushcli+0x19>
801044d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801044e0 <popcli>:
801044e0:	55                   	push   %ebp
801044e1:	89 e5                	mov    %esp,%ebp
801044e3:	83 ec 08             	sub    $0x8,%esp
801044e6:	9c                   	pushf  
801044e7:	58                   	pop    %eax
801044e8:	f6 c4 02             	test   $0x2,%ah
801044eb:	75 35                	jne    80104522 <popcli+0x42>
801044ed:	e8 3e f4 ff ff       	call   80103930 <mycpu>
801044f2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801044f9:	78 34                	js     8010452f <popcli+0x4f>
801044fb:	e8 30 f4 ff ff       	call   80103930 <mycpu>
80104500:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104506:	85 d2                	test   %edx,%edx
80104508:	74 06                	je     80104510 <popcli+0x30>
8010450a:	c9                   	leave  
8010450b:	c3                   	ret    
8010450c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104510:	e8 1b f4 ff ff       	call   80103930 <mycpu>
80104515:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010451b:	85 c0                	test   %eax,%eax
8010451d:	74 eb                	je     8010450a <popcli+0x2a>
8010451f:	fb                   	sti    
80104520:	c9                   	leave  
80104521:	c3                   	ret    
80104522:	83 ec 0c             	sub    $0xc,%esp
80104525:	68 4f 80 10 80       	push   $0x8010804f
8010452a:	e8 51 be ff ff       	call   80100380 <panic>
8010452f:	83 ec 0c             	sub    $0xc,%esp
80104532:	68 66 80 10 80       	push   $0x80108066
80104537:	e8 44 be ff ff       	call   80100380 <panic>
8010453c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104540 <holding>:
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	56                   	push   %esi
80104544:	53                   	push   %ebx
80104545:	8b 75 08             	mov    0x8(%ebp),%esi
80104548:	31 db                	xor    %ebx,%ebx
8010454a:	e8 41 ff ff ff       	call   80104490 <pushcli>
8010454f:	8b 06                	mov    (%esi),%eax
80104551:	85 c0                	test   %eax,%eax
80104553:	75 0b                	jne    80104560 <holding+0x20>
80104555:	e8 86 ff ff ff       	call   801044e0 <popcli>
8010455a:	89 d8                	mov    %ebx,%eax
8010455c:	5b                   	pop    %ebx
8010455d:	5e                   	pop    %esi
8010455e:	5d                   	pop    %ebp
8010455f:	c3                   	ret    
80104560:	8b 5e 08             	mov    0x8(%esi),%ebx
80104563:	e8 c8 f3 ff ff       	call   80103930 <mycpu>
80104568:	39 c3                	cmp    %eax,%ebx
8010456a:	0f 94 c3             	sete   %bl
8010456d:	e8 6e ff ff ff       	call   801044e0 <popcli>
80104572:	0f b6 db             	movzbl %bl,%ebx
80104575:	89 d8                	mov    %ebx,%eax
80104577:	5b                   	pop    %ebx
80104578:	5e                   	pop    %esi
80104579:	5d                   	pop    %ebp
8010457a:	c3                   	ret    
8010457b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010457f:	90                   	nop

80104580 <release>:
80104580:	55                   	push   %ebp
80104581:	89 e5                	mov    %esp,%ebp
80104583:	56                   	push   %esi
80104584:	53                   	push   %ebx
80104585:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104588:	e8 03 ff ff ff       	call   80104490 <pushcli>
8010458d:	8b 03                	mov    (%ebx),%eax
8010458f:	85 c0                	test   %eax,%eax
80104591:	75 15                	jne    801045a8 <release+0x28>
80104593:	e8 48 ff ff ff       	call   801044e0 <popcli>
80104598:	83 ec 0c             	sub    $0xc,%esp
8010459b:	68 6d 80 10 80       	push   $0x8010806d
801045a0:	e8 db bd ff ff       	call   80100380 <panic>
801045a5:	8d 76 00             	lea    0x0(%esi),%esi
801045a8:	8b 73 08             	mov    0x8(%ebx),%esi
801045ab:	e8 80 f3 ff ff       	call   80103930 <mycpu>
801045b0:	39 c6                	cmp    %eax,%esi
801045b2:	75 df                	jne    80104593 <release+0x13>
801045b4:	e8 27 ff ff ff       	call   801044e0 <popcli>
801045b9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
801045c0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
801045c7:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
801045cc:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801045d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045d5:	5b                   	pop    %ebx
801045d6:	5e                   	pop    %esi
801045d7:	5d                   	pop    %ebp
801045d8:	e9 03 ff ff ff       	jmp    801044e0 <popcli>
801045dd:	8d 76 00             	lea    0x0(%esi),%esi

801045e0 <acquire>:
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	53                   	push   %ebx
801045e4:	83 ec 04             	sub    $0x4,%esp
801045e7:	e8 a4 fe ff ff       	call   80104490 <pushcli>
801045ec:	8b 5d 08             	mov    0x8(%ebp),%ebx
801045ef:	e8 9c fe ff ff       	call   80104490 <pushcli>
801045f4:	8b 03                	mov    (%ebx),%eax
801045f6:	85 c0                	test   %eax,%eax
801045f8:	75 7e                	jne    80104678 <acquire+0x98>
801045fa:	e8 e1 fe ff ff       	call   801044e0 <popcli>
801045ff:	b9 01 00 00 00       	mov    $0x1,%ecx
80104604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104608:	8b 55 08             	mov    0x8(%ebp),%edx
8010460b:	89 c8                	mov    %ecx,%eax
8010460d:	f0 87 02             	lock xchg %eax,(%edx)
80104610:	85 c0                	test   %eax,%eax
80104612:	75 f4                	jne    80104608 <acquire+0x28>
80104614:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
80104619:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010461c:	e8 0f f3 ff ff       	call   80103930 <mycpu>
80104621:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104624:	89 ea                	mov    %ebp,%edx
80104626:	89 43 08             	mov    %eax,0x8(%ebx)
80104629:	31 c0                	xor    %eax,%eax
8010462b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010462f:	90                   	nop
80104630:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104636:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010463c:	77 1a                	ja     80104658 <acquire+0x78>
8010463e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104641:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
80104645:	83 c0 01             	add    $0x1,%eax
80104648:	8b 12                	mov    (%edx),%edx
8010464a:	83 f8 0a             	cmp    $0xa,%eax
8010464d:	75 e1                	jne    80104630 <acquire+0x50>
8010464f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104652:	c9                   	leave  
80104653:	c3                   	ret    
80104654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104658:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
8010465c:	8d 51 34             	lea    0x34(%ecx),%edx
8010465f:	90                   	nop
80104660:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104666:	83 c0 04             	add    $0x4,%eax
80104669:	39 c2                	cmp    %eax,%edx
8010466b:	75 f3                	jne    80104660 <acquire+0x80>
8010466d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104670:	c9                   	leave  
80104671:	c3                   	ret    
80104672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104678:	8b 5b 08             	mov    0x8(%ebx),%ebx
8010467b:	e8 b0 f2 ff ff       	call   80103930 <mycpu>
80104680:	39 c3                	cmp    %eax,%ebx
80104682:	0f 85 72 ff ff ff    	jne    801045fa <acquire+0x1a>
80104688:	e8 53 fe ff ff       	call   801044e0 <popcli>
8010468d:	83 ec 0c             	sub    $0xc,%esp
80104690:	68 75 80 10 80       	push   $0x80108075
80104695:	e8 e6 bc ff ff       	call   80100380 <panic>
8010469a:	66 90                	xchg   %ax,%ax
8010469c:	66 90                	xchg   %ax,%ax
8010469e:	66 90                	xchg   %ax,%ax

801046a0 <memset>:
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	57                   	push   %edi
801046a4:	8b 55 08             	mov    0x8(%ebp),%edx
801046a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801046aa:	53                   	push   %ebx
801046ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801046ae:	89 d7                	mov    %edx,%edi
801046b0:	09 cf                	or     %ecx,%edi
801046b2:	83 e7 03             	and    $0x3,%edi
801046b5:	75 29                	jne    801046e0 <memset+0x40>
801046b7:	0f b6 f8             	movzbl %al,%edi
801046ba:	c1 e0 18             	shl    $0x18,%eax
801046bd:	89 fb                	mov    %edi,%ebx
801046bf:	c1 e9 02             	shr    $0x2,%ecx
801046c2:	c1 e3 10             	shl    $0x10,%ebx
801046c5:	09 d8                	or     %ebx,%eax
801046c7:	09 f8                	or     %edi,%eax
801046c9:	c1 e7 08             	shl    $0x8,%edi
801046cc:	09 f8                	or     %edi,%eax
801046ce:	89 d7                	mov    %edx,%edi
801046d0:	fc                   	cld    
801046d1:	f3 ab                	rep stos %eax,%es:(%edi)
801046d3:	5b                   	pop    %ebx
801046d4:	89 d0                	mov    %edx,%eax
801046d6:	5f                   	pop    %edi
801046d7:	5d                   	pop    %ebp
801046d8:	c3                   	ret    
801046d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046e0:	89 d7                	mov    %edx,%edi
801046e2:	fc                   	cld    
801046e3:	f3 aa                	rep stos %al,%es:(%edi)
801046e5:	5b                   	pop    %ebx
801046e6:	89 d0                	mov    %edx,%eax
801046e8:	5f                   	pop    %edi
801046e9:	5d                   	pop    %ebp
801046ea:	c3                   	ret    
801046eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046ef:	90                   	nop

801046f0 <memcmp>:
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	56                   	push   %esi
801046f4:	8b 75 10             	mov    0x10(%ebp),%esi
801046f7:	8b 55 08             	mov    0x8(%ebp),%edx
801046fa:	53                   	push   %ebx
801046fb:	8b 45 0c             	mov    0xc(%ebp),%eax
801046fe:	85 f6                	test   %esi,%esi
80104700:	74 2e                	je     80104730 <memcmp+0x40>
80104702:	01 c6                	add    %eax,%esi
80104704:	eb 14                	jmp    8010471a <memcmp+0x2a>
80104706:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010470d:	8d 76 00             	lea    0x0(%esi),%esi
80104710:	83 c0 01             	add    $0x1,%eax
80104713:	83 c2 01             	add    $0x1,%edx
80104716:	39 f0                	cmp    %esi,%eax
80104718:	74 16                	je     80104730 <memcmp+0x40>
8010471a:	0f b6 0a             	movzbl (%edx),%ecx
8010471d:	0f b6 18             	movzbl (%eax),%ebx
80104720:	38 d9                	cmp    %bl,%cl
80104722:	74 ec                	je     80104710 <memcmp+0x20>
80104724:	0f b6 c1             	movzbl %cl,%eax
80104727:	29 d8                	sub    %ebx,%eax
80104729:	5b                   	pop    %ebx
8010472a:	5e                   	pop    %esi
8010472b:	5d                   	pop    %ebp
8010472c:	c3                   	ret    
8010472d:	8d 76 00             	lea    0x0(%esi),%esi
80104730:	5b                   	pop    %ebx
80104731:	31 c0                	xor    %eax,%eax
80104733:	5e                   	pop    %esi
80104734:	5d                   	pop    %ebp
80104735:	c3                   	ret    
80104736:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010473d:	8d 76 00             	lea    0x0(%esi),%esi

80104740 <memmove>:
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	57                   	push   %edi
80104744:	8b 55 08             	mov    0x8(%ebp),%edx
80104747:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010474a:	56                   	push   %esi
8010474b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010474e:	39 d6                	cmp    %edx,%esi
80104750:	73 26                	jae    80104778 <memmove+0x38>
80104752:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104755:	39 fa                	cmp    %edi,%edx
80104757:	73 1f                	jae    80104778 <memmove+0x38>
80104759:	8d 41 ff             	lea    -0x1(%ecx),%eax
8010475c:	85 c9                	test   %ecx,%ecx
8010475e:	74 0c                	je     8010476c <memmove+0x2c>
80104760:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104764:	88 0c 02             	mov    %cl,(%edx,%eax,1)
80104767:	83 e8 01             	sub    $0x1,%eax
8010476a:	73 f4                	jae    80104760 <memmove+0x20>
8010476c:	5e                   	pop    %esi
8010476d:	89 d0                	mov    %edx,%eax
8010476f:	5f                   	pop    %edi
80104770:	5d                   	pop    %ebp
80104771:	c3                   	ret    
80104772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104778:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
8010477b:	89 d7                	mov    %edx,%edi
8010477d:	85 c9                	test   %ecx,%ecx
8010477f:	74 eb                	je     8010476c <memmove+0x2c>
80104781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104788:	a4                   	movsb  %ds:(%esi),%es:(%edi)
80104789:	39 c6                	cmp    %eax,%esi
8010478b:	75 fb                	jne    80104788 <memmove+0x48>
8010478d:	5e                   	pop    %esi
8010478e:	89 d0                	mov    %edx,%eax
80104790:	5f                   	pop    %edi
80104791:	5d                   	pop    %ebp
80104792:	c3                   	ret    
80104793:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010479a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047a0 <memcpy>:
801047a0:	eb 9e                	jmp    80104740 <memmove>
801047a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047b0 <strncmp>:
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	56                   	push   %esi
801047b4:	8b 75 10             	mov    0x10(%ebp),%esi
801047b7:	8b 4d 08             	mov    0x8(%ebp),%ecx
801047ba:	53                   	push   %ebx
801047bb:	8b 55 0c             	mov    0xc(%ebp),%edx
801047be:	85 f6                	test   %esi,%esi
801047c0:	74 2e                	je     801047f0 <strncmp+0x40>
801047c2:	01 d6                	add    %edx,%esi
801047c4:	eb 18                	jmp    801047de <strncmp+0x2e>
801047c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047cd:	8d 76 00             	lea    0x0(%esi),%esi
801047d0:	38 d8                	cmp    %bl,%al
801047d2:	75 14                	jne    801047e8 <strncmp+0x38>
801047d4:	83 c2 01             	add    $0x1,%edx
801047d7:	83 c1 01             	add    $0x1,%ecx
801047da:	39 f2                	cmp    %esi,%edx
801047dc:	74 12                	je     801047f0 <strncmp+0x40>
801047de:	0f b6 01             	movzbl (%ecx),%eax
801047e1:	0f b6 1a             	movzbl (%edx),%ebx
801047e4:	84 c0                	test   %al,%al
801047e6:	75 e8                	jne    801047d0 <strncmp+0x20>
801047e8:	29 d8                	sub    %ebx,%eax
801047ea:	5b                   	pop    %ebx
801047eb:	5e                   	pop    %esi
801047ec:	5d                   	pop    %ebp
801047ed:	c3                   	ret    
801047ee:	66 90                	xchg   %ax,%ax
801047f0:	5b                   	pop    %ebx
801047f1:	31 c0                	xor    %eax,%eax
801047f3:	5e                   	pop    %esi
801047f4:	5d                   	pop    %ebp
801047f5:	c3                   	ret    
801047f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047fd:	8d 76 00             	lea    0x0(%esi),%esi

80104800 <strncpy>:
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	57                   	push   %edi
80104804:	56                   	push   %esi
80104805:	8b 75 08             	mov    0x8(%ebp),%esi
80104808:	53                   	push   %ebx
80104809:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010480c:	89 f0                	mov    %esi,%eax
8010480e:	eb 15                	jmp    80104825 <strncpy+0x25>
80104810:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104814:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104817:	83 c0 01             	add    $0x1,%eax
8010481a:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
8010481e:	88 50 ff             	mov    %dl,-0x1(%eax)
80104821:	84 d2                	test   %dl,%dl
80104823:	74 09                	je     8010482e <strncpy+0x2e>
80104825:	89 cb                	mov    %ecx,%ebx
80104827:	83 e9 01             	sub    $0x1,%ecx
8010482a:	85 db                	test   %ebx,%ebx
8010482c:	7f e2                	jg     80104810 <strncpy+0x10>
8010482e:	89 c2                	mov    %eax,%edx
80104830:	85 c9                	test   %ecx,%ecx
80104832:	7e 17                	jle    8010484b <strncpy+0x4b>
80104834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104838:	83 c2 01             	add    $0x1,%edx
8010483b:	89 c1                	mov    %eax,%ecx
8010483d:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
80104841:	29 d1                	sub    %edx,%ecx
80104843:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80104847:	85 c9                	test   %ecx,%ecx
80104849:	7f ed                	jg     80104838 <strncpy+0x38>
8010484b:	5b                   	pop    %ebx
8010484c:	89 f0                	mov    %esi,%eax
8010484e:	5e                   	pop    %esi
8010484f:	5f                   	pop    %edi
80104850:	5d                   	pop    %ebp
80104851:	c3                   	ret    
80104852:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104860 <safestrcpy>:
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	56                   	push   %esi
80104864:	8b 55 10             	mov    0x10(%ebp),%edx
80104867:	8b 75 08             	mov    0x8(%ebp),%esi
8010486a:	53                   	push   %ebx
8010486b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010486e:	85 d2                	test   %edx,%edx
80104870:	7e 25                	jle    80104897 <safestrcpy+0x37>
80104872:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104876:	89 f2                	mov    %esi,%edx
80104878:	eb 16                	jmp    80104890 <safestrcpy+0x30>
8010487a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104880:	0f b6 08             	movzbl (%eax),%ecx
80104883:	83 c0 01             	add    $0x1,%eax
80104886:	83 c2 01             	add    $0x1,%edx
80104889:	88 4a ff             	mov    %cl,-0x1(%edx)
8010488c:	84 c9                	test   %cl,%cl
8010488e:	74 04                	je     80104894 <safestrcpy+0x34>
80104890:	39 d8                	cmp    %ebx,%eax
80104892:	75 ec                	jne    80104880 <safestrcpy+0x20>
80104894:	c6 02 00             	movb   $0x0,(%edx)
80104897:	89 f0                	mov    %esi,%eax
80104899:	5b                   	pop    %ebx
8010489a:	5e                   	pop    %esi
8010489b:	5d                   	pop    %ebp
8010489c:	c3                   	ret    
8010489d:	8d 76 00             	lea    0x0(%esi),%esi

801048a0 <strlen>:
801048a0:	55                   	push   %ebp
801048a1:	31 c0                	xor    %eax,%eax
801048a3:	89 e5                	mov    %esp,%ebp
801048a5:	8b 55 08             	mov    0x8(%ebp),%edx
801048a8:	80 3a 00             	cmpb   $0x0,(%edx)
801048ab:	74 0c                	je     801048b9 <strlen+0x19>
801048ad:	8d 76 00             	lea    0x0(%esi),%esi
801048b0:	83 c0 01             	add    $0x1,%eax
801048b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801048b7:	75 f7                	jne    801048b0 <strlen+0x10>
801048b9:	5d                   	pop    %ebp
801048ba:	c3                   	ret    

801048bb <swtch>:
801048bb:	8b 44 24 04          	mov    0x4(%esp),%eax
801048bf:	8b 54 24 08          	mov    0x8(%esp),%edx
801048c3:	55                   	push   %ebp
801048c4:	53                   	push   %ebx
801048c5:	56                   	push   %esi
801048c6:	57                   	push   %edi
801048c7:	89 20                	mov    %esp,(%eax)
801048c9:	89 d4                	mov    %edx,%esp
801048cb:	5f                   	pop    %edi
801048cc:	5e                   	pop    %esi
801048cd:	5b                   	pop    %ebx
801048ce:	5d                   	pop    %ebp
801048cf:	c3                   	ret    

801048d0 <fetchint>:
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	53                   	push   %ebx
801048d4:	83 ec 04             	sub    $0x4,%esp
801048d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801048da:	e8 d1 f0 ff ff       	call   801039b0 <myproc>
801048df:	8b 00                	mov    (%eax),%eax
801048e1:	39 d8                	cmp    %ebx,%eax
801048e3:	76 1b                	jbe    80104900 <fetchint+0x30>
801048e5:	8d 53 04             	lea    0x4(%ebx),%edx
801048e8:	39 d0                	cmp    %edx,%eax
801048ea:	72 14                	jb     80104900 <fetchint+0x30>
801048ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801048ef:	8b 13                	mov    (%ebx),%edx
801048f1:	89 10                	mov    %edx,(%eax)
801048f3:	31 c0                	xor    %eax,%eax
801048f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048f8:	c9                   	leave  
801048f9:	c3                   	ret    
801048fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104900:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104905:	eb ee                	jmp    801048f5 <fetchint+0x25>
80104907:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010490e:	66 90                	xchg   %ax,%ax

80104910 <fetchstr>:
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	53                   	push   %ebx
80104914:	83 ec 04             	sub    $0x4,%esp
80104917:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010491a:	e8 91 f0 ff ff       	call   801039b0 <myproc>
8010491f:	39 18                	cmp    %ebx,(%eax)
80104921:	76 2d                	jbe    80104950 <fetchstr+0x40>
80104923:	8b 55 0c             	mov    0xc(%ebp),%edx
80104926:	89 1a                	mov    %ebx,(%edx)
80104928:	8b 10                	mov    (%eax),%edx
8010492a:	39 d3                	cmp    %edx,%ebx
8010492c:	73 22                	jae    80104950 <fetchstr+0x40>
8010492e:	89 d8                	mov    %ebx,%eax
80104930:	eb 0d                	jmp    8010493f <fetchstr+0x2f>
80104932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104938:	83 c0 01             	add    $0x1,%eax
8010493b:	39 c2                	cmp    %eax,%edx
8010493d:	76 11                	jbe    80104950 <fetchstr+0x40>
8010493f:	80 38 00             	cmpb   $0x0,(%eax)
80104942:	75 f4                	jne    80104938 <fetchstr+0x28>
80104944:	29 d8                	sub    %ebx,%eax
80104946:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104949:	c9                   	leave  
8010494a:	c3                   	ret    
8010494b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010494f:	90                   	nop
80104950:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104953:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104958:	c9                   	leave  
80104959:	c3                   	ret    
8010495a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104960 <argint>:
80104960:	55                   	push   %ebp
80104961:	89 e5                	mov    %esp,%ebp
80104963:	56                   	push   %esi
80104964:	53                   	push   %ebx
80104965:	e8 46 f0 ff ff       	call   801039b0 <myproc>
8010496a:	8b 55 08             	mov    0x8(%ebp),%edx
8010496d:	8b 40 18             	mov    0x18(%eax),%eax
80104970:	8b 40 44             	mov    0x44(%eax),%eax
80104973:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80104976:	e8 35 f0 ff ff       	call   801039b0 <myproc>
8010497b:	8d 73 04             	lea    0x4(%ebx),%esi
8010497e:	8b 00                	mov    (%eax),%eax
80104980:	39 c6                	cmp    %eax,%esi
80104982:	73 1c                	jae    801049a0 <argint+0x40>
80104984:	8d 53 08             	lea    0x8(%ebx),%edx
80104987:	39 d0                	cmp    %edx,%eax
80104989:	72 15                	jb     801049a0 <argint+0x40>
8010498b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010498e:	8b 53 04             	mov    0x4(%ebx),%edx
80104991:	89 10                	mov    %edx,(%eax)
80104993:	31 c0                	xor    %eax,%eax
80104995:	5b                   	pop    %ebx
80104996:	5e                   	pop    %esi
80104997:	5d                   	pop    %ebp
80104998:	c3                   	ret    
80104999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049a5:	eb ee                	jmp    80104995 <argint+0x35>
801049a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049ae:	66 90                	xchg   %ax,%ax

801049b0 <argptr>:
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	57                   	push   %edi
801049b4:	56                   	push   %esi
801049b5:	53                   	push   %ebx
801049b6:	83 ec 0c             	sub    $0xc,%esp
801049b9:	e8 f2 ef ff ff       	call   801039b0 <myproc>
801049be:	89 c6                	mov    %eax,%esi
801049c0:	e8 eb ef ff ff       	call   801039b0 <myproc>
801049c5:	8b 55 08             	mov    0x8(%ebp),%edx
801049c8:	8b 40 18             	mov    0x18(%eax),%eax
801049cb:	8b 40 44             	mov    0x44(%eax),%eax
801049ce:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
801049d1:	e8 da ef ff ff       	call   801039b0 <myproc>
801049d6:	8d 7b 04             	lea    0x4(%ebx),%edi
801049d9:	8b 00                	mov    (%eax),%eax
801049db:	39 c7                	cmp    %eax,%edi
801049dd:	73 31                	jae    80104a10 <argptr+0x60>
801049df:	8d 4b 08             	lea    0x8(%ebx),%ecx
801049e2:	39 c8                	cmp    %ecx,%eax
801049e4:	72 2a                	jb     80104a10 <argptr+0x60>
801049e6:	8b 55 10             	mov    0x10(%ebp),%edx
801049e9:	8b 43 04             	mov    0x4(%ebx),%eax
801049ec:	85 d2                	test   %edx,%edx
801049ee:	78 20                	js     80104a10 <argptr+0x60>
801049f0:	8b 16                	mov    (%esi),%edx
801049f2:	39 c2                	cmp    %eax,%edx
801049f4:	76 1a                	jbe    80104a10 <argptr+0x60>
801049f6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801049f9:	01 c3                	add    %eax,%ebx
801049fb:	39 da                	cmp    %ebx,%edx
801049fd:	72 11                	jb     80104a10 <argptr+0x60>
801049ff:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a02:	89 02                	mov    %eax,(%edx)
80104a04:	31 c0                	xor    %eax,%eax
80104a06:	83 c4 0c             	add    $0xc,%esp
80104a09:	5b                   	pop    %ebx
80104a0a:	5e                   	pop    %esi
80104a0b:	5f                   	pop    %edi
80104a0c:	5d                   	pop    %ebp
80104a0d:	c3                   	ret    
80104a0e:	66 90                	xchg   %ax,%ax
80104a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a15:	eb ef                	jmp    80104a06 <argptr+0x56>
80104a17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a1e:	66 90                	xchg   %ax,%ax

80104a20 <argstr>:
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	56                   	push   %esi
80104a24:	53                   	push   %ebx
80104a25:	e8 86 ef ff ff       	call   801039b0 <myproc>
80104a2a:	8b 55 08             	mov    0x8(%ebp),%edx
80104a2d:	8b 40 18             	mov    0x18(%eax),%eax
80104a30:	8b 40 44             	mov    0x44(%eax),%eax
80104a33:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80104a36:	e8 75 ef ff ff       	call   801039b0 <myproc>
80104a3b:	8d 73 04             	lea    0x4(%ebx),%esi
80104a3e:	8b 00                	mov    (%eax),%eax
80104a40:	39 c6                	cmp    %eax,%esi
80104a42:	73 44                	jae    80104a88 <argstr+0x68>
80104a44:	8d 53 08             	lea    0x8(%ebx),%edx
80104a47:	39 d0                	cmp    %edx,%eax
80104a49:	72 3d                	jb     80104a88 <argstr+0x68>
80104a4b:	8b 5b 04             	mov    0x4(%ebx),%ebx
80104a4e:	e8 5d ef ff ff       	call   801039b0 <myproc>
80104a53:	3b 18                	cmp    (%eax),%ebx
80104a55:	73 31                	jae    80104a88 <argstr+0x68>
80104a57:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a5a:	89 1a                	mov    %ebx,(%edx)
80104a5c:	8b 10                	mov    (%eax),%edx
80104a5e:	39 d3                	cmp    %edx,%ebx
80104a60:	73 26                	jae    80104a88 <argstr+0x68>
80104a62:	89 d8                	mov    %ebx,%eax
80104a64:	eb 11                	jmp    80104a77 <argstr+0x57>
80104a66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a6d:	8d 76 00             	lea    0x0(%esi),%esi
80104a70:	83 c0 01             	add    $0x1,%eax
80104a73:	39 c2                	cmp    %eax,%edx
80104a75:	76 11                	jbe    80104a88 <argstr+0x68>
80104a77:	80 38 00             	cmpb   $0x0,(%eax)
80104a7a:	75 f4                	jne    80104a70 <argstr+0x50>
80104a7c:	29 d8                	sub    %ebx,%eax
80104a7e:	5b                   	pop    %ebx
80104a7f:	5e                   	pop    %esi
80104a80:	5d                   	pop    %ebp
80104a81:	c3                   	ret    
80104a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a88:	5b                   	pop    %ebx
80104a89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a8e:	5e                   	pop    %esi
80104a8f:	5d                   	pop    %ebp
80104a90:	c3                   	ret    
80104a91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a9f:	90                   	nop

80104aa0 <syscall>:
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	53                   	push   %ebx
80104aa4:	83 ec 04             	sub    $0x4,%esp
80104aa7:	e8 04 ef ff ff       	call   801039b0 <myproc>
80104aac:	89 c3                	mov    %eax,%ebx
80104aae:	8b 40 18             	mov    0x18(%eax),%eax
80104ab1:	8b 40 1c             	mov    0x1c(%eax),%eax
80104ab4:	8d 50 ff             	lea    -0x1(%eax),%edx
80104ab7:	83 fa 19             	cmp    $0x19,%edx
80104aba:	77 24                	ja     80104ae0 <syscall+0x40>
80104abc:	8b 14 85 a0 80 10 80 	mov    -0x7fef7f60(,%eax,4),%edx
80104ac3:	85 d2                	test   %edx,%edx
80104ac5:	74 19                	je     80104ae0 <syscall+0x40>
80104ac7:	ff d2                	call   *%edx
80104ac9:	89 c2                	mov    %eax,%edx
80104acb:	8b 43 18             	mov    0x18(%ebx),%eax
80104ace:	89 50 1c             	mov    %edx,0x1c(%eax)
80104ad1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ad4:	c9                   	leave  
80104ad5:	c3                   	ret    
80104ad6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104add:	8d 76 00             	lea    0x0(%esi),%esi
80104ae0:	50                   	push   %eax
80104ae1:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104ae4:	50                   	push   %eax
80104ae5:	ff 73 10             	push   0x10(%ebx)
80104ae8:	68 7d 80 10 80       	push   $0x8010807d
80104aed:	e8 ae bb ff ff       	call   801006a0 <cprintf>
80104af2:	8b 43 18             	mov    0x18(%ebx),%eax
80104af5:	83 c4 10             	add    $0x10,%esp
80104af8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
80104aff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b02:	c9                   	leave  
80104b03:	c3                   	ret    
80104b04:	66 90                	xchg   %ax,%ax
80104b06:	66 90                	xchg   %ax,%ax
80104b08:	66 90                	xchg   %ax,%ax
80104b0a:	66 90                	xchg   %ax,%ax
80104b0c:	66 90                	xchg   %ax,%ax
80104b0e:	66 90                	xchg   %ax,%ax

80104b10 <create>:
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	57                   	push   %edi
80104b14:	56                   	push   %esi
80104b15:	8d 7d da             	lea    -0x26(%ebp),%edi
80104b18:	53                   	push   %ebx
80104b19:	83 ec 34             	sub    $0x34,%esp
80104b1c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104b1f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b22:	57                   	push   %edi
80104b23:	50                   	push   %eax
80104b24:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104b27:	89 4d cc             	mov    %ecx,-0x34(%ebp)
80104b2a:	e8 91 d5 ff ff       	call   801020c0 <nameiparent>
80104b2f:	83 c4 10             	add    $0x10,%esp
80104b32:	85 c0                	test   %eax,%eax
80104b34:	0f 84 46 01 00 00    	je     80104c80 <create+0x170>
80104b3a:	83 ec 0c             	sub    $0xc,%esp
80104b3d:	89 c3                	mov    %eax,%ebx
80104b3f:	50                   	push   %eax
80104b40:	e8 3b cc ff ff       	call   80101780 <ilock>
80104b45:	83 c4 0c             	add    $0xc,%esp
80104b48:	6a 00                	push   $0x0
80104b4a:	57                   	push   %edi
80104b4b:	53                   	push   %ebx
80104b4c:	e8 8f d1 ff ff       	call   80101ce0 <dirlookup>
80104b51:	83 c4 10             	add    $0x10,%esp
80104b54:	89 c6                	mov    %eax,%esi
80104b56:	85 c0                	test   %eax,%eax
80104b58:	74 56                	je     80104bb0 <create+0xa0>
80104b5a:	83 ec 0c             	sub    $0xc,%esp
80104b5d:	53                   	push   %ebx
80104b5e:	e8 ad ce ff ff       	call   80101a10 <iunlockput>
80104b63:	89 34 24             	mov    %esi,(%esp)
80104b66:	e8 15 cc ff ff       	call   80101780 <ilock>
80104b6b:	83 c4 10             	add    $0x10,%esp
80104b6e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104b73:	75 1b                	jne    80104b90 <create+0x80>
80104b75:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104b7a:	75 14                	jne    80104b90 <create+0x80>
80104b7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b7f:	89 f0                	mov    %esi,%eax
80104b81:	5b                   	pop    %ebx
80104b82:	5e                   	pop    %esi
80104b83:	5f                   	pop    %edi
80104b84:	5d                   	pop    %ebp
80104b85:	c3                   	ret    
80104b86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b8d:	8d 76 00             	lea    0x0(%esi),%esi
80104b90:	83 ec 0c             	sub    $0xc,%esp
80104b93:	56                   	push   %esi
80104b94:	31 f6                	xor    %esi,%esi
80104b96:	e8 75 ce ff ff       	call   80101a10 <iunlockput>
80104b9b:	83 c4 10             	add    $0x10,%esp
80104b9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ba1:	89 f0                	mov    %esi,%eax
80104ba3:	5b                   	pop    %ebx
80104ba4:	5e                   	pop    %esi
80104ba5:	5f                   	pop    %edi
80104ba6:	5d                   	pop    %ebp
80104ba7:	c3                   	ret    
80104ba8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104baf:	90                   	nop
80104bb0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104bb4:	83 ec 08             	sub    $0x8,%esp
80104bb7:	50                   	push   %eax
80104bb8:	ff 33                	push   (%ebx)
80104bba:	e8 51 ca ff ff       	call   80101610 <ialloc>
80104bbf:	83 c4 10             	add    $0x10,%esp
80104bc2:	89 c6                	mov    %eax,%esi
80104bc4:	85 c0                	test   %eax,%eax
80104bc6:	0f 84 cd 00 00 00    	je     80104c99 <create+0x189>
80104bcc:	83 ec 0c             	sub    $0xc,%esp
80104bcf:	50                   	push   %eax
80104bd0:	e8 ab cb ff ff       	call   80101780 <ilock>
80104bd5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104bd9:	66 89 46 52          	mov    %ax,0x52(%esi)
80104bdd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104be1:	66 89 46 54          	mov    %ax,0x54(%esi)
80104be5:	b8 01 00 00 00       	mov    $0x1,%eax
80104bea:	66 89 46 56          	mov    %ax,0x56(%esi)
80104bee:	89 34 24             	mov    %esi,(%esp)
80104bf1:	e8 da ca ff ff       	call   801016d0 <iupdate>
80104bf6:	83 c4 10             	add    $0x10,%esp
80104bf9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104bfe:	74 30                	je     80104c30 <create+0x120>
80104c00:	83 ec 04             	sub    $0x4,%esp
80104c03:	ff 76 04             	push   0x4(%esi)
80104c06:	57                   	push   %edi
80104c07:	53                   	push   %ebx
80104c08:	e8 d3 d3 ff ff       	call   80101fe0 <dirlink>
80104c0d:	83 c4 10             	add    $0x10,%esp
80104c10:	85 c0                	test   %eax,%eax
80104c12:	78 78                	js     80104c8c <create+0x17c>
80104c14:	83 ec 0c             	sub    $0xc,%esp
80104c17:	53                   	push   %ebx
80104c18:	e8 f3 cd ff ff       	call   80101a10 <iunlockput>
80104c1d:	83 c4 10             	add    $0x10,%esp
80104c20:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c23:	89 f0                	mov    %esi,%eax
80104c25:	5b                   	pop    %ebx
80104c26:	5e                   	pop    %esi
80104c27:	5f                   	pop    %edi
80104c28:	5d                   	pop    %ebp
80104c29:	c3                   	ret    
80104c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c30:	83 ec 0c             	sub    $0xc,%esp
80104c33:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80104c38:	53                   	push   %ebx
80104c39:	e8 92 ca ff ff       	call   801016d0 <iupdate>
80104c3e:	83 c4 0c             	add    $0xc,%esp
80104c41:	ff 76 04             	push   0x4(%esi)
80104c44:	68 28 81 10 80       	push   $0x80108128
80104c49:	56                   	push   %esi
80104c4a:	e8 91 d3 ff ff       	call   80101fe0 <dirlink>
80104c4f:	83 c4 10             	add    $0x10,%esp
80104c52:	85 c0                	test   %eax,%eax
80104c54:	78 18                	js     80104c6e <create+0x15e>
80104c56:	83 ec 04             	sub    $0x4,%esp
80104c59:	ff 73 04             	push   0x4(%ebx)
80104c5c:	68 27 81 10 80       	push   $0x80108127
80104c61:	56                   	push   %esi
80104c62:	e8 79 d3 ff ff       	call   80101fe0 <dirlink>
80104c67:	83 c4 10             	add    $0x10,%esp
80104c6a:	85 c0                	test   %eax,%eax
80104c6c:	79 92                	jns    80104c00 <create+0xf0>
80104c6e:	83 ec 0c             	sub    $0xc,%esp
80104c71:	68 1b 81 10 80       	push   $0x8010811b
80104c76:	e8 05 b7 ff ff       	call   80100380 <panic>
80104c7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c7f:	90                   	nop
80104c80:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c83:	31 f6                	xor    %esi,%esi
80104c85:	5b                   	pop    %ebx
80104c86:	89 f0                	mov    %esi,%eax
80104c88:	5e                   	pop    %esi
80104c89:	5f                   	pop    %edi
80104c8a:	5d                   	pop    %ebp
80104c8b:	c3                   	ret    
80104c8c:	83 ec 0c             	sub    $0xc,%esp
80104c8f:	68 2a 81 10 80       	push   $0x8010812a
80104c94:	e8 e7 b6 ff ff       	call   80100380 <panic>
80104c99:	83 ec 0c             	sub    $0xc,%esp
80104c9c:	68 0c 81 10 80       	push   $0x8010810c
80104ca1:	e8 da b6 ff ff       	call   80100380 <panic>
80104ca6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cad:	8d 76 00             	lea    0x0(%esi),%esi

80104cb0 <sys_dup>:
80104cb0:	55                   	push   %ebp
80104cb1:	89 e5                	mov    %esp,%ebp
80104cb3:	56                   	push   %esi
80104cb4:	53                   	push   %ebx
80104cb5:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cb8:	83 ec 18             	sub    $0x18,%esp
80104cbb:	50                   	push   %eax
80104cbc:	6a 00                	push   $0x0
80104cbe:	e8 9d fc ff ff       	call   80104960 <argint>
80104cc3:	83 c4 10             	add    $0x10,%esp
80104cc6:	85 c0                	test   %eax,%eax
80104cc8:	78 36                	js     80104d00 <sys_dup+0x50>
80104cca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104cce:	77 30                	ja     80104d00 <sys_dup+0x50>
80104cd0:	e8 db ec ff ff       	call   801039b0 <myproc>
80104cd5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104cd8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104cdc:	85 f6                	test   %esi,%esi
80104cde:	74 20                	je     80104d00 <sys_dup+0x50>
80104ce0:	e8 cb ec ff ff       	call   801039b0 <myproc>
80104ce5:	31 db                	xor    %ebx,%ebx
80104ce7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cee:	66 90                	xchg   %ax,%ax
80104cf0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104cf4:	85 d2                	test   %edx,%edx
80104cf6:	74 18                	je     80104d10 <sys_dup+0x60>
80104cf8:	83 c3 01             	add    $0x1,%ebx
80104cfb:	83 fb 10             	cmp    $0x10,%ebx
80104cfe:	75 f0                	jne    80104cf0 <sys_dup+0x40>
80104d00:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d03:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104d08:	89 d8                	mov    %ebx,%eax
80104d0a:	5b                   	pop    %ebx
80104d0b:	5e                   	pop    %esi
80104d0c:	5d                   	pop    %ebp
80104d0d:	c3                   	ret    
80104d0e:	66 90                	xchg   %ax,%ax
80104d10:	83 ec 0c             	sub    $0xc,%esp
80104d13:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
80104d17:	56                   	push   %esi
80104d18:	e8 83 c1 ff ff       	call   80100ea0 <filedup>
80104d1d:	83 c4 10             	add    $0x10,%esp
80104d20:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d23:	89 d8                	mov    %ebx,%eax
80104d25:	5b                   	pop    %ebx
80104d26:	5e                   	pop    %esi
80104d27:	5d                   	pop    %ebp
80104d28:	c3                   	ret    
80104d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104d30 <sys_read>:
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
80104d33:	56                   	push   %esi
80104d34:	53                   	push   %ebx
80104d35:	8d 5d f4             	lea    -0xc(%ebp),%ebx
80104d38:	83 ec 18             	sub    $0x18,%esp
80104d3b:	53                   	push   %ebx
80104d3c:	6a 00                	push   $0x0
80104d3e:	e8 1d fc ff ff       	call   80104960 <argint>
80104d43:	83 c4 10             	add    $0x10,%esp
80104d46:	85 c0                	test   %eax,%eax
80104d48:	78 5e                	js     80104da8 <sys_read+0x78>
80104d4a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104d4e:	77 58                	ja     80104da8 <sys_read+0x78>
80104d50:	e8 5b ec ff ff       	call   801039b0 <myproc>
80104d55:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d58:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104d5c:	85 f6                	test   %esi,%esi
80104d5e:	74 48                	je     80104da8 <sys_read+0x78>
80104d60:	83 ec 08             	sub    $0x8,%esp
80104d63:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d66:	50                   	push   %eax
80104d67:	6a 02                	push   $0x2
80104d69:	e8 f2 fb ff ff       	call   80104960 <argint>
80104d6e:	83 c4 10             	add    $0x10,%esp
80104d71:	85 c0                	test   %eax,%eax
80104d73:	78 33                	js     80104da8 <sys_read+0x78>
80104d75:	83 ec 04             	sub    $0x4,%esp
80104d78:	ff 75 f0             	push   -0x10(%ebp)
80104d7b:	53                   	push   %ebx
80104d7c:	6a 01                	push   $0x1
80104d7e:	e8 2d fc ff ff       	call   801049b0 <argptr>
80104d83:	83 c4 10             	add    $0x10,%esp
80104d86:	85 c0                	test   %eax,%eax
80104d88:	78 1e                	js     80104da8 <sys_read+0x78>
80104d8a:	83 ec 04             	sub    $0x4,%esp
80104d8d:	ff 75 f0             	push   -0x10(%ebp)
80104d90:	ff 75 f4             	push   -0xc(%ebp)
80104d93:	56                   	push   %esi
80104d94:	e8 87 c2 ff ff       	call   80101020 <fileread>
80104d99:	83 c4 10             	add    $0x10,%esp
80104d9c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d9f:	5b                   	pop    %ebx
80104da0:	5e                   	pop    %esi
80104da1:	5d                   	pop    %ebp
80104da2:	c3                   	ret    
80104da3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104da7:	90                   	nop
80104da8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104dad:	eb ed                	jmp    80104d9c <sys_read+0x6c>
80104daf:	90                   	nop

80104db0 <sys_write>:
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	56                   	push   %esi
80104db4:	53                   	push   %ebx
80104db5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
80104db8:	83 ec 18             	sub    $0x18,%esp
80104dbb:	53                   	push   %ebx
80104dbc:	6a 00                	push   $0x0
80104dbe:	e8 9d fb ff ff       	call   80104960 <argint>
80104dc3:	83 c4 10             	add    $0x10,%esp
80104dc6:	85 c0                	test   %eax,%eax
80104dc8:	78 5e                	js     80104e28 <sys_write+0x78>
80104dca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104dce:	77 58                	ja     80104e28 <sys_write+0x78>
80104dd0:	e8 db eb ff ff       	call   801039b0 <myproc>
80104dd5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104dd8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104ddc:	85 f6                	test   %esi,%esi
80104dde:	74 48                	je     80104e28 <sys_write+0x78>
80104de0:	83 ec 08             	sub    $0x8,%esp
80104de3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104de6:	50                   	push   %eax
80104de7:	6a 02                	push   $0x2
80104de9:	e8 72 fb ff ff       	call   80104960 <argint>
80104dee:	83 c4 10             	add    $0x10,%esp
80104df1:	85 c0                	test   %eax,%eax
80104df3:	78 33                	js     80104e28 <sys_write+0x78>
80104df5:	83 ec 04             	sub    $0x4,%esp
80104df8:	ff 75 f0             	push   -0x10(%ebp)
80104dfb:	53                   	push   %ebx
80104dfc:	6a 01                	push   $0x1
80104dfe:	e8 ad fb ff ff       	call   801049b0 <argptr>
80104e03:	83 c4 10             	add    $0x10,%esp
80104e06:	85 c0                	test   %eax,%eax
80104e08:	78 1e                	js     80104e28 <sys_write+0x78>
80104e0a:	83 ec 04             	sub    $0x4,%esp
80104e0d:	ff 75 f0             	push   -0x10(%ebp)
80104e10:	ff 75 f4             	push   -0xc(%ebp)
80104e13:	56                   	push   %esi
80104e14:	e8 97 c2 ff ff       	call   801010b0 <filewrite>
80104e19:	83 c4 10             	add    $0x10,%esp
80104e1c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e1f:	5b                   	pop    %ebx
80104e20:	5e                   	pop    %esi
80104e21:	5d                   	pop    %ebp
80104e22:	c3                   	ret    
80104e23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e27:	90                   	nop
80104e28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e2d:	eb ed                	jmp    80104e1c <sys_write+0x6c>
80104e2f:	90                   	nop

80104e30 <sys_close>:
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	56                   	push   %esi
80104e34:	53                   	push   %ebx
80104e35:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e38:	83 ec 18             	sub    $0x18,%esp
80104e3b:	50                   	push   %eax
80104e3c:	6a 00                	push   $0x0
80104e3e:	e8 1d fb ff ff       	call   80104960 <argint>
80104e43:	83 c4 10             	add    $0x10,%esp
80104e46:	85 c0                	test   %eax,%eax
80104e48:	78 3e                	js     80104e88 <sys_close+0x58>
80104e4a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e4e:	77 38                	ja     80104e88 <sys_close+0x58>
80104e50:	e8 5b eb ff ff       	call   801039b0 <myproc>
80104e55:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e58:	8d 5a 08             	lea    0x8(%edx),%ebx
80104e5b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80104e5f:	85 f6                	test   %esi,%esi
80104e61:	74 25                	je     80104e88 <sys_close+0x58>
80104e63:	e8 48 eb ff ff       	call   801039b0 <myproc>
80104e68:	83 ec 0c             	sub    $0xc,%esp
80104e6b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80104e72:	00 
80104e73:	56                   	push   %esi
80104e74:	e8 77 c0 ff ff       	call   80100ef0 <fileclose>
80104e79:	83 c4 10             	add    $0x10,%esp
80104e7c:	31 c0                	xor    %eax,%eax
80104e7e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e81:	5b                   	pop    %ebx
80104e82:	5e                   	pop    %esi
80104e83:	5d                   	pop    %ebp
80104e84:	c3                   	ret    
80104e85:	8d 76 00             	lea    0x0(%esi),%esi
80104e88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e8d:	eb ef                	jmp    80104e7e <sys_close+0x4e>
80104e8f:	90                   	nop

80104e90 <sys_fstat>:
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	56                   	push   %esi
80104e94:	53                   	push   %ebx
80104e95:	8d 5d f4             	lea    -0xc(%ebp),%ebx
80104e98:	83 ec 18             	sub    $0x18,%esp
80104e9b:	53                   	push   %ebx
80104e9c:	6a 00                	push   $0x0
80104e9e:	e8 bd fa ff ff       	call   80104960 <argint>
80104ea3:	83 c4 10             	add    $0x10,%esp
80104ea6:	85 c0                	test   %eax,%eax
80104ea8:	78 46                	js     80104ef0 <sys_fstat+0x60>
80104eaa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104eae:	77 40                	ja     80104ef0 <sys_fstat+0x60>
80104eb0:	e8 fb ea ff ff       	call   801039b0 <myproc>
80104eb5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104eb8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104ebc:	85 f6                	test   %esi,%esi
80104ebe:	74 30                	je     80104ef0 <sys_fstat+0x60>
80104ec0:	83 ec 04             	sub    $0x4,%esp
80104ec3:	6a 14                	push   $0x14
80104ec5:	53                   	push   %ebx
80104ec6:	6a 01                	push   $0x1
80104ec8:	e8 e3 fa ff ff       	call   801049b0 <argptr>
80104ecd:	83 c4 10             	add    $0x10,%esp
80104ed0:	85 c0                	test   %eax,%eax
80104ed2:	78 1c                	js     80104ef0 <sys_fstat+0x60>
80104ed4:	83 ec 08             	sub    $0x8,%esp
80104ed7:	ff 75 f4             	push   -0xc(%ebp)
80104eda:	56                   	push   %esi
80104edb:	e8 f0 c0 ff ff       	call   80100fd0 <filestat>
80104ee0:	83 c4 10             	add    $0x10,%esp
80104ee3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ee6:	5b                   	pop    %ebx
80104ee7:	5e                   	pop    %esi
80104ee8:	5d                   	pop    %ebp
80104ee9:	c3                   	ret    
80104eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ef0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ef5:	eb ec                	jmp    80104ee3 <sys_fstat+0x53>
80104ef7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104efe:	66 90                	xchg   %ax,%ax

80104f00 <sys_link>:
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	57                   	push   %edi
80104f04:	56                   	push   %esi
80104f05:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104f08:	53                   	push   %ebx
80104f09:	83 ec 34             	sub    $0x34,%esp
80104f0c:	50                   	push   %eax
80104f0d:	6a 00                	push   $0x0
80104f0f:	e8 0c fb ff ff       	call   80104a20 <argstr>
80104f14:	83 c4 10             	add    $0x10,%esp
80104f17:	85 c0                	test   %eax,%eax
80104f19:	0f 88 fb 00 00 00    	js     8010501a <sys_link+0x11a>
80104f1f:	83 ec 08             	sub    $0x8,%esp
80104f22:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104f25:	50                   	push   %eax
80104f26:	6a 01                	push   $0x1
80104f28:	e8 f3 fa ff ff       	call   80104a20 <argstr>
80104f2d:	83 c4 10             	add    $0x10,%esp
80104f30:	85 c0                	test   %eax,%eax
80104f32:	0f 88 e2 00 00 00    	js     8010501a <sys_link+0x11a>
80104f38:	e8 23 de ff ff       	call   80102d60 <begin_op>
80104f3d:	83 ec 0c             	sub    $0xc,%esp
80104f40:	ff 75 d4             	push   -0x2c(%ebp)
80104f43:	e8 58 d1 ff ff       	call   801020a0 <namei>
80104f48:	83 c4 10             	add    $0x10,%esp
80104f4b:	89 c3                	mov    %eax,%ebx
80104f4d:	85 c0                	test   %eax,%eax
80104f4f:	0f 84 e4 00 00 00    	je     80105039 <sys_link+0x139>
80104f55:	83 ec 0c             	sub    $0xc,%esp
80104f58:	50                   	push   %eax
80104f59:	e8 22 c8 ff ff       	call   80101780 <ilock>
80104f5e:	83 c4 10             	add    $0x10,%esp
80104f61:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f66:	0f 84 b5 00 00 00    	je     80105021 <sys_link+0x121>
80104f6c:	83 ec 0c             	sub    $0xc,%esp
80104f6f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80104f74:	8d 7d da             	lea    -0x26(%ebp),%edi
80104f77:	53                   	push   %ebx
80104f78:	e8 53 c7 ff ff       	call   801016d0 <iupdate>
80104f7d:	89 1c 24             	mov    %ebx,(%esp)
80104f80:	e8 db c8 ff ff       	call   80101860 <iunlock>
80104f85:	58                   	pop    %eax
80104f86:	5a                   	pop    %edx
80104f87:	57                   	push   %edi
80104f88:	ff 75 d0             	push   -0x30(%ebp)
80104f8b:	e8 30 d1 ff ff       	call   801020c0 <nameiparent>
80104f90:	83 c4 10             	add    $0x10,%esp
80104f93:	89 c6                	mov    %eax,%esi
80104f95:	85 c0                	test   %eax,%eax
80104f97:	74 5b                	je     80104ff4 <sys_link+0xf4>
80104f99:	83 ec 0c             	sub    $0xc,%esp
80104f9c:	50                   	push   %eax
80104f9d:	e8 de c7 ff ff       	call   80101780 <ilock>
80104fa2:	8b 03                	mov    (%ebx),%eax
80104fa4:	83 c4 10             	add    $0x10,%esp
80104fa7:	39 06                	cmp    %eax,(%esi)
80104fa9:	75 3d                	jne    80104fe8 <sys_link+0xe8>
80104fab:	83 ec 04             	sub    $0x4,%esp
80104fae:	ff 73 04             	push   0x4(%ebx)
80104fb1:	57                   	push   %edi
80104fb2:	56                   	push   %esi
80104fb3:	e8 28 d0 ff ff       	call   80101fe0 <dirlink>
80104fb8:	83 c4 10             	add    $0x10,%esp
80104fbb:	85 c0                	test   %eax,%eax
80104fbd:	78 29                	js     80104fe8 <sys_link+0xe8>
80104fbf:	83 ec 0c             	sub    $0xc,%esp
80104fc2:	56                   	push   %esi
80104fc3:	e8 48 ca ff ff       	call   80101a10 <iunlockput>
80104fc8:	89 1c 24             	mov    %ebx,(%esp)
80104fcb:	e8 e0 c8 ff ff       	call   801018b0 <iput>
80104fd0:	e8 fb dd ff ff       	call   80102dd0 <end_op>
80104fd5:	83 c4 10             	add    $0x10,%esp
80104fd8:	31 c0                	xor    %eax,%eax
80104fda:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fdd:	5b                   	pop    %ebx
80104fde:	5e                   	pop    %esi
80104fdf:	5f                   	pop    %edi
80104fe0:	5d                   	pop    %ebp
80104fe1:	c3                   	ret    
80104fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fe8:	83 ec 0c             	sub    $0xc,%esp
80104feb:	56                   	push   %esi
80104fec:	e8 1f ca ff ff       	call   80101a10 <iunlockput>
80104ff1:	83 c4 10             	add    $0x10,%esp
80104ff4:	83 ec 0c             	sub    $0xc,%esp
80104ff7:	53                   	push   %ebx
80104ff8:	e8 83 c7 ff ff       	call   80101780 <ilock>
80104ffd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80105002:	89 1c 24             	mov    %ebx,(%esp)
80105005:	e8 c6 c6 ff ff       	call   801016d0 <iupdate>
8010500a:	89 1c 24             	mov    %ebx,(%esp)
8010500d:	e8 fe c9 ff ff       	call   80101a10 <iunlockput>
80105012:	e8 b9 dd ff ff       	call   80102dd0 <end_op>
80105017:	83 c4 10             	add    $0x10,%esp
8010501a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010501f:	eb b9                	jmp    80104fda <sys_link+0xda>
80105021:	83 ec 0c             	sub    $0xc,%esp
80105024:	53                   	push   %ebx
80105025:	e8 e6 c9 ff ff       	call   80101a10 <iunlockput>
8010502a:	e8 a1 dd ff ff       	call   80102dd0 <end_op>
8010502f:	83 c4 10             	add    $0x10,%esp
80105032:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105037:	eb a1                	jmp    80104fda <sys_link+0xda>
80105039:	e8 92 dd ff ff       	call   80102dd0 <end_op>
8010503e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105043:	eb 95                	jmp    80104fda <sys_link+0xda>
80105045:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010504c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105050 <sys_unlink>:
80105050:	55                   	push   %ebp
80105051:	89 e5                	mov    %esp,%ebp
80105053:	57                   	push   %edi
80105054:	56                   	push   %esi
80105055:	8d 45 c0             	lea    -0x40(%ebp),%eax
80105058:	53                   	push   %ebx
80105059:	83 ec 54             	sub    $0x54,%esp
8010505c:	50                   	push   %eax
8010505d:	6a 00                	push   $0x0
8010505f:	e8 bc f9 ff ff       	call   80104a20 <argstr>
80105064:	83 c4 10             	add    $0x10,%esp
80105067:	85 c0                	test   %eax,%eax
80105069:	0f 88 7a 01 00 00    	js     801051e9 <sys_unlink+0x199>
8010506f:	e8 ec dc ff ff       	call   80102d60 <begin_op>
80105074:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105077:	83 ec 08             	sub    $0x8,%esp
8010507a:	53                   	push   %ebx
8010507b:	ff 75 c0             	push   -0x40(%ebp)
8010507e:	e8 3d d0 ff ff       	call   801020c0 <nameiparent>
80105083:	83 c4 10             	add    $0x10,%esp
80105086:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105089:	85 c0                	test   %eax,%eax
8010508b:	0f 84 62 01 00 00    	je     801051f3 <sys_unlink+0x1a3>
80105091:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105094:	83 ec 0c             	sub    $0xc,%esp
80105097:	57                   	push   %edi
80105098:	e8 e3 c6 ff ff       	call   80101780 <ilock>
8010509d:	58                   	pop    %eax
8010509e:	5a                   	pop    %edx
8010509f:	68 28 81 10 80       	push   $0x80108128
801050a4:	53                   	push   %ebx
801050a5:	e8 16 cc ff ff       	call   80101cc0 <namecmp>
801050aa:	83 c4 10             	add    $0x10,%esp
801050ad:	85 c0                	test   %eax,%eax
801050af:	0f 84 fb 00 00 00    	je     801051b0 <sys_unlink+0x160>
801050b5:	83 ec 08             	sub    $0x8,%esp
801050b8:	68 27 81 10 80       	push   $0x80108127
801050bd:	53                   	push   %ebx
801050be:	e8 fd cb ff ff       	call   80101cc0 <namecmp>
801050c3:	83 c4 10             	add    $0x10,%esp
801050c6:	85 c0                	test   %eax,%eax
801050c8:	0f 84 e2 00 00 00    	je     801051b0 <sys_unlink+0x160>
801050ce:	83 ec 04             	sub    $0x4,%esp
801050d1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801050d4:	50                   	push   %eax
801050d5:	53                   	push   %ebx
801050d6:	57                   	push   %edi
801050d7:	e8 04 cc ff ff       	call   80101ce0 <dirlookup>
801050dc:	83 c4 10             	add    $0x10,%esp
801050df:	89 c3                	mov    %eax,%ebx
801050e1:	85 c0                	test   %eax,%eax
801050e3:	0f 84 c7 00 00 00    	je     801051b0 <sys_unlink+0x160>
801050e9:	83 ec 0c             	sub    $0xc,%esp
801050ec:	50                   	push   %eax
801050ed:	e8 8e c6 ff ff       	call   80101780 <ilock>
801050f2:	83 c4 10             	add    $0x10,%esp
801050f5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801050fa:	0f 8e 1c 01 00 00    	jle    8010521c <sys_unlink+0x1cc>
80105100:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105105:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105108:	74 66                	je     80105170 <sys_unlink+0x120>
8010510a:	83 ec 04             	sub    $0x4,%esp
8010510d:	6a 10                	push   $0x10
8010510f:	6a 00                	push   $0x0
80105111:	57                   	push   %edi
80105112:	e8 89 f5 ff ff       	call   801046a0 <memset>
80105117:	6a 10                	push   $0x10
80105119:	ff 75 c4             	push   -0x3c(%ebp)
8010511c:	57                   	push   %edi
8010511d:	ff 75 b4             	push   -0x4c(%ebp)
80105120:	e8 6b ca ff ff       	call   80101b90 <writei>
80105125:	83 c4 20             	add    $0x20,%esp
80105128:	83 f8 10             	cmp    $0x10,%eax
8010512b:	0f 85 de 00 00 00    	jne    8010520f <sys_unlink+0x1bf>
80105131:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105136:	0f 84 94 00 00 00    	je     801051d0 <sys_unlink+0x180>
8010513c:	83 ec 0c             	sub    $0xc,%esp
8010513f:	ff 75 b4             	push   -0x4c(%ebp)
80105142:	e8 c9 c8 ff ff       	call   80101a10 <iunlockput>
80105147:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
8010514c:	89 1c 24             	mov    %ebx,(%esp)
8010514f:	e8 7c c5 ff ff       	call   801016d0 <iupdate>
80105154:	89 1c 24             	mov    %ebx,(%esp)
80105157:	e8 b4 c8 ff ff       	call   80101a10 <iunlockput>
8010515c:	e8 6f dc ff ff       	call   80102dd0 <end_op>
80105161:	83 c4 10             	add    $0x10,%esp
80105164:	31 c0                	xor    %eax,%eax
80105166:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105169:	5b                   	pop    %ebx
8010516a:	5e                   	pop    %esi
8010516b:	5f                   	pop    %edi
8010516c:	5d                   	pop    %ebp
8010516d:	c3                   	ret    
8010516e:	66 90                	xchg   %ax,%ax
80105170:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105174:	76 94                	jbe    8010510a <sys_unlink+0xba>
80105176:	be 20 00 00 00       	mov    $0x20,%esi
8010517b:	eb 0b                	jmp    80105188 <sys_unlink+0x138>
8010517d:	8d 76 00             	lea    0x0(%esi),%esi
80105180:	83 c6 10             	add    $0x10,%esi
80105183:	3b 73 58             	cmp    0x58(%ebx),%esi
80105186:	73 82                	jae    8010510a <sys_unlink+0xba>
80105188:	6a 10                	push   $0x10
8010518a:	56                   	push   %esi
8010518b:	57                   	push   %edi
8010518c:	53                   	push   %ebx
8010518d:	e8 fe c8 ff ff       	call   80101a90 <readi>
80105192:	83 c4 10             	add    $0x10,%esp
80105195:	83 f8 10             	cmp    $0x10,%eax
80105198:	75 68                	jne    80105202 <sys_unlink+0x1b2>
8010519a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010519f:	74 df                	je     80105180 <sys_unlink+0x130>
801051a1:	83 ec 0c             	sub    $0xc,%esp
801051a4:	53                   	push   %ebx
801051a5:	e8 66 c8 ff ff       	call   80101a10 <iunlockput>
801051aa:	83 c4 10             	add    $0x10,%esp
801051ad:	8d 76 00             	lea    0x0(%esi),%esi
801051b0:	83 ec 0c             	sub    $0xc,%esp
801051b3:	ff 75 b4             	push   -0x4c(%ebp)
801051b6:	e8 55 c8 ff ff       	call   80101a10 <iunlockput>
801051bb:	e8 10 dc ff ff       	call   80102dd0 <end_op>
801051c0:	83 c4 10             	add    $0x10,%esp
801051c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051c8:	eb 9c                	jmp    80105166 <sys_unlink+0x116>
801051ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801051d0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801051d3:	83 ec 0c             	sub    $0xc,%esp
801051d6:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
801051db:	50                   	push   %eax
801051dc:	e8 ef c4 ff ff       	call   801016d0 <iupdate>
801051e1:	83 c4 10             	add    $0x10,%esp
801051e4:	e9 53 ff ff ff       	jmp    8010513c <sys_unlink+0xec>
801051e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051ee:	e9 73 ff ff ff       	jmp    80105166 <sys_unlink+0x116>
801051f3:	e8 d8 db ff ff       	call   80102dd0 <end_op>
801051f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051fd:	e9 64 ff ff ff       	jmp    80105166 <sys_unlink+0x116>
80105202:	83 ec 0c             	sub    $0xc,%esp
80105205:	68 4c 81 10 80       	push   $0x8010814c
8010520a:	e8 71 b1 ff ff       	call   80100380 <panic>
8010520f:	83 ec 0c             	sub    $0xc,%esp
80105212:	68 5e 81 10 80       	push   $0x8010815e
80105217:	e8 64 b1 ff ff       	call   80100380 <panic>
8010521c:	83 ec 0c             	sub    $0xc,%esp
8010521f:	68 3a 81 10 80       	push   $0x8010813a
80105224:	e8 57 b1 ff ff       	call   80100380 <panic>
80105229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105230 <sys_open>:
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	57                   	push   %edi
80105234:	56                   	push   %esi
80105235:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105238:	53                   	push   %ebx
80105239:	83 ec 24             	sub    $0x24,%esp
8010523c:	50                   	push   %eax
8010523d:	6a 00                	push   $0x0
8010523f:	e8 dc f7 ff ff       	call   80104a20 <argstr>
80105244:	83 c4 10             	add    $0x10,%esp
80105247:	85 c0                	test   %eax,%eax
80105249:	0f 88 8e 00 00 00    	js     801052dd <sys_open+0xad>
8010524f:	83 ec 08             	sub    $0x8,%esp
80105252:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105255:	50                   	push   %eax
80105256:	6a 01                	push   $0x1
80105258:	e8 03 f7 ff ff       	call   80104960 <argint>
8010525d:	83 c4 10             	add    $0x10,%esp
80105260:	85 c0                	test   %eax,%eax
80105262:	78 79                	js     801052dd <sys_open+0xad>
80105264:	e8 f7 da ff ff       	call   80102d60 <begin_op>
80105269:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010526d:	75 79                	jne    801052e8 <sys_open+0xb8>
8010526f:	83 ec 0c             	sub    $0xc,%esp
80105272:	ff 75 e0             	push   -0x20(%ebp)
80105275:	e8 26 ce ff ff       	call   801020a0 <namei>
8010527a:	83 c4 10             	add    $0x10,%esp
8010527d:	89 c6                	mov    %eax,%esi
8010527f:	85 c0                	test   %eax,%eax
80105281:	0f 84 7e 00 00 00    	je     80105305 <sys_open+0xd5>
80105287:	83 ec 0c             	sub    $0xc,%esp
8010528a:	50                   	push   %eax
8010528b:	e8 f0 c4 ff ff       	call   80101780 <ilock>
80105290:	83 c4 10             	add    $0x10,%esp
80105293:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105298:	0f 84 c2 00 00 00    	je     80105360 <sys_open+0x130>
8010529e:	e8 8d bb ff ff       	call   80100e30 <filealloc>
801052a3:	89 c7                	mov    %eax,%edi
801052a5:	85 c0                	test   %eax,%eax
801052a7:	74 23                	je     801052cc <sys_open+0x9c>
801052a9:	e8 02 e7 ff ff       	call   801039b0 <myproc>
801052ae:	31 db                	xor    %ebx,%ebx
801052b0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801052b4:	85 d2                	test   %edx,%edx
801052b6:	74 60                	je     80105318 <sys_open+0xe8>
801052b8:	83 c3 01             	add    $0x1,%ebx
801052bb:	83 fb 10             	cmp    $0x10,%ebx
801052be:	75 f0                	jne    801052b0 <sys_open+0x80>
801052c0:	83 ec 0c             	sub    $0xc,%esp
801052c3:	57                   	push   %edi
801052c4:	e8 27 bc ff ff       	call   80100ef0 <fileclose>
801052c9:	83 c4 10             	add    $0x10,%esp
801052cc:	83 ec 0c             	sub    $0xc,%esp
801052cf:	56                   	push   %esi
801052d0:	e8 3b c7 ff ff       	call   80101a10 <iunlockput>
801052d5:	e8 f6 da ff ff       	call   80102dd0 <end_op>
801052da:	83 c4 10             	add    $0x10,%esp
801052dd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801052e2:	eb 6d                	jmp    80105351 <sys_open+0x121>
801052e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052e8:	83 ec 0c             	sub    $0xc,%esp
801052eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801052ee:	31 c9                	xor    %ecx,%ecx
801052f0:	ba 02 00 00 00       	mov    $0x2,%edx
801052f5:	6a 00                	push   $0x0
801052f7:	e8 14 f8 ff ff       	call   80104b10 <create>
801052fc:	83 c4 10             	add    $0x10,%esp
801052ff:	89 c6                	mov    %eax,%esi
80105301:	85 c0                	test   %eax,%eax
80105303:	75 99                	jne    8010529e <sys_open+0x6e>
80105305:	e8 c6 da ff ff       	call   80102dd0 <end_op>
8010530a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010530f:	eb 40                	jmp    80105351 <sys_open+0x121>
80105311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105318:	83 ec 0c             	sub    $0xc,%esp
8010531b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
8010531f:	56                   	push   %esi
80105320:	e8 3b c5 ff ff       	call   80101860 <iunlock>
80105325:	e8 a6 da ff ff       	call   80102dd0 <end_op>
8010532a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
80105330:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105333:	83 c4 10             	add    $0x10,%esp
80105336:	89 77 10             	mov    %esi,0x10(%edi)
80105339:	89 d0                	mov    %edx,%eax
8010533b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
80105342:	f7 d0                	not    %eax
80105344:	83 e0 01             	and    $0x1,%eax
80105347:	83 e2 03             	and    $0x3,%edx
8010534a:	88 47 08             	mov    %al,0x8(%edi)
8010534d:	0f 95 47 09          	setne  0x9(%edi)
80105351:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105354:	89 d8                	mov    %ebx,%eax
80105356:	5b                   	pop    %ebx
80105357:	5e                   	pop    %esi
80105358:	5f                   	pop    %edi
80105359:	5d                   	pop    %ebp
8010535a:	c3                   	ret    
8010535b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010535f:	90                   	nop
80105360:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105363:	85 c9                	test   %ecx,%ecx
80105365:	0f 84 33 ff ff ff    	je     8010529e <sys_open+0x6e>
8010536b:	e9 5c ff ff ff       	jmp    801052cc <sys_open+0x9c>

80105370 <sys_mkdir>:
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	83 ec 18             	sub    $0x18,%esp
80105376:	e8 e5 d9 ff ff       	call   80102d60 <begin_op>
8010537b:	83 ec 08             	sub    $0x8,%esp
8010537e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105381:	50                   	push   %eax
80105382:	6a 00                	push   $0x0
80105384:	e8 97 f6 ff ff       	call   80104a20 <argstr>
80105389:	83 c4 10             	add    $0x10,%esp
8010538c:	85 c0                	test   %eax,%eax
8010538e:	78 30                	js     801053c0 <sys_mkdir+0x50>
80105390:	83 ec 0c             	sub    $0xc,%esp
80105393:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105396:	31 c9                	xor    %ecx,%ecx
80105398:	ba 01 00 00 00       	mov    $0x1,%edx
8010539d:	6a 00                	push   $0x0
8010539f:	e8 6c f7 ff ff       	call   80104b10 <create>
801053a4:	83 c4 10             	add    $0x10,%esp
801053a7:	85 c0                	test   %eax,%eax
801053a9:	74 15                	je     801053c0 <sys_mkdir+0x50>
801053ab:	83 ec 0c             	sub    $0xc,%esp
801053ae:	50                   	push   %eax
801053af:	e8 5c c6 ff ff       	call   80101a10 <iunlockput>
801053b4:	e8 17 da ff ff       	call   80102dd0 <end_op>
801053b9:	83 c4 10             	add    $0x10,%esp
801053bc:	31 c0                	xor    %eax,%eax
801053be:	c9                   	leave  
801053bf:	c3                   	ret    
801053c0:	e8 0b da ff ff       	call   80102dd0 <end_op>
801053c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053ca:	c9                   	leave  
801053cb:	c3                   	ret    
801053cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053d0 <sys_mknod>:
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	83 ec 18             	sub    $0x18,%esp
801053d6:	e8 85 d9 ff ff       	call   80102d60 <begin_op>
801053db:	83 ec 08             	sub    $0x8,%esp
801053de:	8d 45 ec             	lea    -0x14(%ebp),%eax
801053e1:	50                   	push   %eax
801053e2:	6a 00                	push   $0x0
801053e4:	e8 37 f6 ff ff       	call   80104a20 <argstr>
801053e9:	83 c4 10             	add    $0x10,%esp
801053ec:	85 c0                	test   %eax,%eax
801053ee:	78 60                	js     80105450 <sys_mknod+0x80>
801053f0:	83 ec 08             	sub    $0x8,%esp
801053f3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053f6:	50                   	push   %eax
801053f7:	6a 01                	push   $0x1
801053f9:	e8 62 f5 ff ff       	call   80104960 <argint>
801053fe:	83 c4 10             	add    $0x10,%esp
80105401:	85 c0                	test   %eax,%eax
80105403:	78 4b                	js     80105450 <sys_mknod+0x80>
80105405:	83 ec 08             	sub    $0x8,%esp
80105408:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010540b:	50                   	push   %eax
8010540c:	6a 02                	push   $0x2
8010540e:	e8 4d f5 ff ff       	call   80104960 <argint>
80105413:	83 c4 10             	add    $0x10,%esp
80105416:	85 c0                	test   %eax,%eax
80105418:	78 36                	js     80105450 <sys_mknod+0x80>
8010541a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010541e:	83 ec 0c             	sub    $0xc,%esp
80105421:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105425:	ba 03 00 00 00       	mov    $0x3,%edx
8010542a:	50                   	push   %eax
8010542b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010542e:	e8 dd f6 ff ff       	call   80104b10 <create>
80105433:	83 c4 10             	add    $0x10,%esp
80105436:	85 c0                	test   %eax,%eax
80105438:	74 16                	je     80105450 <sys_mknod+0x80>
8010543a:	83 ec 0c             	sub    $0xc,%esp
8010543d:	50                   	push   %eax
8010543e:	e8 cd c5 ff ff       	call   80101a10 <iunlockput>
80105443:	e8 88 d9 ff ff       	call   80102dd0 <end_op>
80105448:	83 c4 10             	add    $0x10,%esp
8010544b:	31 c0                	xor    %eax,%eax
8010544d:	c9                   	leave  
8010544e:	c3                   	ret    
8010544f:	90                   	nop
80105450:	e8 7b d9 ff ff       	call   80102dd0 <end_op>
80105455:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010545a:	c9                   	leave  
8010545b:	c3                   	ret    
8010545c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105460 <sys_chdir>:
80105460:	55                   	push   %ebp
80105461:	89 e5                	mov    %esp,%ebp
80105463:	56                   	push   %esi
80105464:	53                   	push   %ebx
80105465:	83 ec 10             	sub    $0x10,%esp
80105468:	e8 43 e5 ff ff       	call   801039b0 <myproc>
8010546d:	89 c6                	mov    %eax,%esi
8010546f:	e8 ec d8 ff ff       	call   80102d60 <begin_op>
80105474:	83 ec 08             	sub    $0x8,%esp
80105477:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010547a:	50                   	push   %eax
8010547b:	6a 00                	push   $0x0
8010547d:	e8 9e f5 ff ff       	call   80104a20 <argstr>
80105482:	83 c4 10             	add    $0x10,%esp
80105485:	85 c0                	test   %eax,%eax
80105487:	78 77                	js     80105500 <sys_chdir+0xa0>
80105489:	83 ec 0c             	sub    $0xc,%esp
8010548c:	ff 75 f4             	push   -0xc(%ebp)
8010548f:	e8 0c cc ff ff       	call   801020a0 <namei>
80105494:	83 c4 10             	add    $0x10,%esp
80105497:	89 c3                	mov    %eax,%ebx
80105499:	85 c0                	test   %eax,%eax
8010549b:	74 63                	je     80105500 <sys_chdir+0xa0>
8010549d:	83 ec 0c             	sub    $0xc,%esp
801054a0:	50                   	push   %eax
801054a1:	e8 da c2 ff ff       	call   80101780 <ilock>
801054a6:	83 c4 10             	add    $0x10,%esp
801054a9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054ae:	75 30                	jne    801054e0 <sys_chdir+0x80>
801054b0:	83 ec 0c             	sub    $0xc,%esp
801054b3:	53                   	push   %ebx
801054b4:	e8 a7 c3 ff ff       	call   80101860 <iunlock>
801054b9:	58                   	pop    %eax
801054ba:	ff 76 68             	push   0x68(%esi)
801054bd:	e8 ee c3 ff ff       	call   801018b0 <iput>
801054c2:	e8 09 d9 ff ff       	call   80102dd0 <end_op>
801054c7:	89 5e 68             	mov    %ebx,0x68(%esi)
801054ca:	83 c4 10             	add    $0x10,%esp
801054cd:	31 c0                	xor    %eax,%eax
801054cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801054d2:	5b                   	pop    %ebx
801054d3:	5e                   	pop    %esi
801054d4:	5d                   	pop    %ebp
801054d5:	c3                   	ret    
801054d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054dd:	8d 76 00             	lea    0x0(%esi),%esi
801054e0:	83 ec 0c             	sub    $0xc,%esp
801054e3:	53                   	push   %ebx
801054e4:	e8 27 c5 ff ff       	call   80101a10 <iunlockput>
801054e9:	e8 e2 d8 ff ff       	call   80102dd0 <end_op>
801054ee:	83 c4 10             	add    $0x10,%esp
801054f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054f6:	eb d7                	jmp    801054cf <sys_chdir+0x6f>
801054f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054ff:	90                   	nop
80105500:	e8 cb d8 ff ff       	call   80102dd0 <end_op>
80105505:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010550a:	eb c3                	jmp    801054cf <sys_chdir+0x6f>
8010550c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105510 <sys_exec>:
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	57                   	push   %edi
80105514:	56                   	push   %esi
80105515:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
8010551b:	53                   	push   %ebx
8010551c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
80105522:	50                   	push   %eax
80105523:	6a 00                	push   $0x0
80105525:	e8 f6 f4 ff ff       	call   80104a20 <argstr>
8010552a:	83 c4 10             	add    $0x10,%esp
8010552d:	85 c0                	test   %eax,%eax
8010552f:	0f 88 87 00 00 00    	js     801055bc <sys_exec+0xac>
80105535:	83 ec 08             	sub    $0x8,%esp
80105538:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010553e:	50                   	push   %eax
8010553f:	6a 01                	push   $0x1
80105541:	e8 1a f4 ff ff       	call   80104960 <argint>
80105546:	83 c4 10             	add    $0x10,%esp
80105549:	85 c0                	test   %eax,%eax
8010554b:	78 6f                	js     801055bc <sys_exec+0xac>
8010554d:	83 ec 04             	sub    $0x4,%esp
80105550:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105556:	31 db                	xor    %ebx,%ebx
80105558:	68 80 00 00 00       	push   $0x80
8010555d:	6a 00                	push   $0x0
8010555f:	56                   	push   %esi
80105560:	e8 3b f1 ff ff       	call   801046a0 <memset>
80105565:	83 c4 10             	add    $0x10,%esp
80105568:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010556f:	90                   	nop
80105570:	83 ec 08             	sub    $0x8,%esp
80105573:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105579:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105580:	50                   	push   %eax
80105581:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105587:	01 f8                	add    %edi,%eax
80105589:	50                   	push   %eax
8010558a:	e8 41 f3 ff ff       	call   801048d0 <fetchint>
8010558f:	83 c4 10             	add    $0x10,%esp
80105592:	85 c0                	test   %eax,%eax
80105594:	78 26                	js     801055bc <sys_exec+0xac>
80105596:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010559c:	85 c0                	test   %eax,%eax
8010559e:	74 30                	je     801055d0 <sys_exec+0xc0>
801055a0:	83 ec 08             	sub    $0x8,%esp
801055a3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
801055a6:	52                   	push   %edx
801055a7:	50                   	push   %eax
801055a8:	e8 63 f3 ff ff       	call   80104910 <fetchstr>
801055ad:	83 c4 10             	add    $0x10,%esp
801055b0:	85 c0                	test   %eax,%eax
801055b2:	78 08                	js     801055bc <sys_exec+0xac>
801055b4:	83 c3 01             	add    $0x1,%ebx
801055b7:	83 fb 20             	cmp    $0x20,%ebx
801055ba:	75 b4                	jne    80105570 <sys_exec+0x60>
801055bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055c4:	5b                   	pop    %ebx
801055c5:	5e                   	pop    %esi
801055c6:	5f                   	pop    %edi
801055c7:	5d                   	pop    %ebp
801055c8:	c3                   	ret    
801055c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055d0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801055d7:	00 00 00 00 
801055db:	83 ec 08             	sub    $0x8,%esp
801055de:	56                   	push   %esi
801055df:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
801055e5:	e8 c6 b4 ff ff       	call   80100ab0 <exec>
801055ea:	83 c4 10             	add    $0x10,%esp
801055ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055f0:	5b                   	pop    %ebx
801055f1:	5e                   	pop    %esi
801055f2:	5f                   	pop    %edi
801055f3:	5d                   	pop    %ebp
801055f4:	c3                   	ret    
801055f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105600 <sys_pipe>:
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	57                   	push   %edi
80105604:	56                   	push   %esi
80105605:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105608:	53                   	push   %ebx
80105609:	83 ec 20             	sub    $0x20,%esp
8010560c:	6a 08                	push   $0x8
8010560e:	50                   	push   %eax
8010560f:	6a 00                	push   $0x0
80105611:	e8 9a f3 ff ff       	call   801049b0 <argptr>
80105616:	83 c4 10             	add    $0x10,%esp
80105619:	85 c0                	test   %eax,%eax
8010561b:	78 4a                	js     80105667 <sys_pipe+0x67>
8010561d:	83 ec 08             	sub    $0x8,%esp
80105620:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105623:	50                   	push   %eax
80105624:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105627:	50                   	push   %eax
80105628:	e8 03 de ff ff       	call   80103430 <pipealloc>
8010562d:	83 c4 10             	add    $0x10,%esp
80105630:	85 c0                	test   %eax,%eax
80105632:	78 33                	js     80105667 <sys_pipe+0x67>
80105634:	8b 7d e0             	mov    -0x20(%ebp),%edi
80105637:	31 db                	xor    %ebx,%ebx
80105639:	e8 72 e3 ff ff       	call   801039b0 <myproc>
8010563e:	66 90                	xchg   %ax,%ax
80105640:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105644:	85 f6                	test   %esi,%esi
80105646:	74 28                	je     80105670 <sys_pipe+0x70>
80105648:	83 c3 01             	add    $0x1,%ebx
8010564b:	83 fb 10             	cmp    $0x10,%ebx
8010564e:	75 f0                	jne    80105640 <sys_pipe+0x40>
80105650:	83 ec 0c             	sub    $0xc,%esp
80105653:	ff 75 e0             	push   -0x20(%ebp)
80105656:	e8 95 b8 ff ff       	call   80100ef0 <fileclose>
8010565b:	58                   	pop    %eax
8010565c:	ff 75 e4             	push   -0x1c(%ebp)
8010565f:	e8 8c b8 ff ff       	call   80100ef0 <fileclose>
80105664:	83 c4 10             	add    $0x10,%esp
80105667:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010566c:	eb 53                	jmp    801056c1 <sys_pipe+0xc1>
8010566e:	66 90                	xchg   %ax,%ax
80105670:	8d 73 08             	lea    0x8(%ebx),%esi
80105673:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
80105677:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010567a:	e8 31 e3 ff ff       	call   801039b0 <myproc>
8010567f:	31 d2                	xor    %edx,%edx
80105681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105688:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010568c:	85 c9                	test   %ecx,%ecx
8010568e:	74 20                	je     801056b0 <sys_pipe+0xb0>
80105690:	83 c2 01             	add    $0x1,%edx
80105693:	83 fa 10             	cmp    $0x10,%edx
80105696:	75 f0                	jne    80105688 <sys_pipe+0x88>
80105698:	e8 13 e3 ff ff       	call   801039b0 <myproc>
8010569d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801056a4:	00 
801056a5:	eb a9                	jmp    80105650 <sys_pipe+0x50>
801056a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056ae:	66 90                	xchg   %ax,%ax
801056b0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
801056b4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056b7:	89 18                	mov    %ebx,(%eax)
801056b9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056bc:	89 50 04             	mov    %edx,0x4(%eax)
801056bf:	31 c0                	xor    %eax,%eax
801056c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056c4:	5b                   	pop    %ebx
801056c5:	5e                   	pop    %esi
801056c6:	5f                   	pop    %edi
801056c7:	5d                   	pop    %ebp
801056c8:	c3                   	ret    
801056c9:	66 90                	xchg   %ax,%ax
801056cb:	66 90                	xchg   %ax,%ax
801056cd:	66 90                	xchg   %ax,%ax
801056cf:	90                   	nop

801056d0 <sys_fork>:
801056d0:	e9 7b e4 ff ff       	jmp    80103b50 <fork>
801056d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056e0 <sys_exit>:
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	83 ec 08             	sub    $0x8,%esp
801056e6:	e8 e5 e6 ff ff       	call   80103dd0 <exit>
801056eb:	31 c0                	xor    %eax,%eax
801056ed:	c9                   	leave  
801056ee:	c3                   	ret    
801056ef:	90                   	nop

801056f0 <sys_wait>:
801056f0:	e9 0b e8 ff ff       	jmp    80103f00 <wait>
801056f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105700 <sys_kill>:
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	83 ec 20             	sub    $0x20,%esp
80105706:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105709:	50                   	push   %eax
8010570a:	6a 00                	push   $0x0
8010570c:	e8 4f f2 ff ff       	call   80104960 <argint>
80105711:	83 c4 10             	add    $0x10,%esp
80105714:	85 c0                	test   %eax,%eax
80105716:	78 18                	js     80105730 <sys_kill+0x30>
80105718:	83 ec 0c             	sub    $0xc,%esp
8010571b:	ff 75 f4             	push   -0xc(%ebp)
8010571e:	e8 7d ea ff ff       	call   801041a0 <kill>
80105723:	83 c4 10             	add    $0x10,%esp
80105726:	c9                   	leave  
80105727:	c3                   	ret    
80105728:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010572f:	90                   	nop
80105730:	c9                   	leave  
80105731:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105736:	c3                   	ret    
80105737:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010573e:	66 90                	xchg   %ax,%ax

80105740 <sys_getpid>:
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
80105743:	83 ec 08             	sub    $0x8,%esp
80105746:	e8 65 e2 ff ff       	call   801039b0 <myproc>
8010574b:	8b 40 10             	mov    0x10(%eax),%eax
8010574e:	c9                   	leave  
8010574f:	c3                   	ret    

80105750 <sys_sbrk>:
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	53                   	push   %ebx
80105754:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105757:	83 ec 1c             	sub    $0x1c,%esp
8010575a:	50                   	push   %eax
8010575b:	6a 00                	push   $0x0
8010575d:	e8 fe f1 ff ff       	call   80104960 <argint>
80105762:	83 c4 10             	add    $0x10,%esp
80105765:	85 c0                	test   %eax,%eax
80105767:	78 27                	js     80105790 <sys_sbrk+0x40>
80105769:	e8 42 e2 ff ff       	call   801039b0 <myproc>
8010576e:	83 ec 0c             	sub    $0xc,%esp
80105771:	8b 18                	mov    (%eax),%ebx
80105773:	ff 75 f4             	push   -0xc(%ebp)
80105776:	e8 55 e3 ff ff       	call   80103ad0 <growproc>
8010577b:	83 c4 10             	add    $0x10,%esp
8010577e:	85 c0                	test   %eax,%eax
80105780:	78 0e                	js     80105790 <sys_sbrk+0x40>
80105782:	89 d8                	mov    %ebx,%eax
80105784:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105787:	c9                   	leave  
80105788:	c3                   	ret    
80105789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105790:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105795:	eb eb                	jmp    80105782 <sys_sbrk+0x32>
80105797:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010579e:	66 90                	xchg   %ax,%ax

801057a0 <sys_sleep>:
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	53                   	push   %ebx
801057a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057a7:	83 ec 1c             	sub    $0x1c,%esp
801057aa:	50                   	push   %eax
801057ab:	6a 00                	push   $0x0
801057ad:	e8 ae f1 ff ff       	call   80104960 <argint>
801057b2:	83 c4 10             	add    $0x10,%esp
801057b5:	85 c0                	test   %eax,%eax
801057b7:	0f 88 8a 00 00 00    	js     80105847 <sys_sleep+0xa7>
801057bd:	83 ec 0c             	sub    $0xc,%esp
801057c0:	68 80 8e 12 80       	push   $0x80128e80
801057c5:	e8 16 ee ff ff       	call   801045e0 <acquire>
801057ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
801057cd:	8b 1d 60 8e 12 80    	mov    0x80128e60,%ebx
801057d3:	83 c4 10             	add    $0x10,%esp
801057d6:	85 d2                	test   %edx,%edx
801057d8:	75 27                	jne    80105801 <sys_sleep+0x61>
801057da:	eb 54                	jmp    80105830 <sys_sleep+0x90>
801057dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057e0:	83 ec 08             	sub    $0x8,%esp
801057e3:	68 80 8e 12 80       	push   $0x80128e80
801057e8:	68 60 8e 12 80       	push   $0x80128e60
801057ed:	e8 8e e8 ff ff       	call   80104080 <sleep>
801057f2:	a1 60 8e 12 80       	mov    0x80128e60,%eax
801057f7:	83 c4 10             	add    $0x10,%esp
801057fa:	29 d8                	sub    %ebx,%eax
801057fc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801057ff:	73 2f                	jae    80105830 <sys_sleep+0x90>
80105801:	e8 aa e1 ff ff       	call   801039b0 <myproc>
80105806:	8b 40 24             	mov    0x24(%eax),%eax
80105809:	85 c0                	test   %eax,%eax
8010580b:	74 d3                	je     801057e0 <sys_sleep+0x40>
8010580d:	83 ec 0c             	sub    $0xc,%esp
80105810:	68 80 8e 12 80       	push   $0x80128e80
80105815:	e8 66 ed ff ff       	call   80104580 <release>
8010581a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010581d:	83 c4 10             	add    $0x10,%esp
80105820:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105825:	c9                   	leave  
80105826:	c3                   	ret    
80105827:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010582e:	66 90                	xchg   %ax,%ax
80105830:	83 ec 0c             	sub    $0xc,%esp
80105833:	68 80 8e 12 80       	push   $0x80128e80
80105838:	e8 43 ed ff ff       	call   80104580 <release>
8010583d:	83 c4 10             	add    $0x10,%esp
80105840:	31 c0                	xor    %eax,%eax
80105842:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105845:	c9                   	leave  
80105846:	c3                   	ret    
80105847:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010584c:	eb f4                	jmp    80105842 <sys_sleep+0xa2>
8010584e:	66 90                	xchg   %ax,%ax

80105850 <sys_uptime>:
80105850:	55                   	push   %ebp
80105851:	89 e5                	mov    %esp,%ebp
80105853:	53                   	push   %ebx
80105854:	83 ec 10             	sub    $0x10,%esp
80105857:	68 80 8e 12 80       	push   $0x80128e80
8010585c:	e8 7f ed ff ff       	call   801045e0 <acquire>
80105861:	8b 1d 60 8e 12 80    	mov    0x80128e60,%ebx
80105867:	c7 04 24 80 8e 12 80 	movl   $0x80128e80,(%esp)
8010586e:	e8 0d ed ff ff       	call   80104580 <release>
80105873:	89 d8                	mov    %ebx,%eax
80105875:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105878:	c9                   	leave  
80105879:	c3                   	ret    

8010587a <alltraps>:
8010587a:	1e                   	push   %ds
8010587b:	06                   	push   %es
8010587c:	0f a0                	push   %fs
8010587e:	0f a8                	push   %gs
80105880:	60                   	pusha  
80105881:	66 b8 10 00          	mov    $0x10,%ax
80105885:	8e d8                	mov    %eax,%ds
80105887:	8e c0                	mov    %eax,%es
80105889:	54                   	push   %esp
8010588a:	e8 c1 00 00 00       	call   80105950 <trap>
8010588f:	83 c4 04             	add    $0x4,%esp

80105892 <trapret>:
80105892:	61                   	popa   
80105893:	0f a9                	pop    %gs
80105895:	0f a1                	pop    %fs
80105897:	07                   	pop    %es
80105898:	1f                   	pop    %ds
80105899:	83 c4 08             	add    $0x8,%esp
8010589c:	cf                   	iret   
8010589d:	66 90                	xchg   %ax,%ax
8010589f:	90                   	nop

801058a0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801058a0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801058a1:	31 c0                	xor    %eax,%eax
{
801058a3:	89 e5                	mov    %esp,%ebp
801058a5:	83 ec 08             	sub    $0x8,%esp
801058a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058af:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801058b0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
801058b7:	c7 04 c5 c2 8e 12 80 	movl   $0x8e000008,-0x7fed713e(,%eax,8)
801058be:	08 00 00 8e 
801058c2:	66 89 14 c5 c0 8e 12 	mov    %dx,-0x7fed7140(,%eax,8)
801058c9:	80 
801058ca:	c1 ea 10             	shr    $0x10,%edx
801058cd:	66 89 14 c5 c6 8e 12 	mov    %dx,-0x7fed713a(,%eax,8)
801058d4:	80 
  for(i = 0; i < 256; i++)
801058d5:	83 c0 01             	add    $0x1,%eax
801058d8:	3d 00 01 00 00       	cmp    $0x100,%eax
801058dd:	75 d1                	jne    801058b0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
801058df:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801058e2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
801058e7:	c7 05 c2 90 12 80 08 	movl   $0xef000008,0x801290c2
801058ee:	00 00 ef 
  initlock(&tickslock, "time");
801058f1:	68 6d 81 10 80       	push   $0x8010816d
801058f6:	68 80 8e 12 80       	push   $0x80128e80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801058fb:	66 a3 c0 90 12 80    	mov    %ax,0x801290c0
80105901:	c1 e8 10             	shr    $0x10,%eax
80105904:	66 a3 c6 90 12 80    	mov    %ax,0x801290c6
  initlock(&tickslock, "time");
8010590a:	e8 01 eb ff ff       	call   80104410 <initlock>
}
8010590f:	83 c4 10             	add    $0x10,%esp
80105912:	c9                   	leave  
80105913:	c3                   	ret    
80105914:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010591b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010591f:	90                   	nop

80105920 <idtinit>:

void
idtinit(void)
{
80105920:	55                   	push   %ebp
  pd[0] = size-1;
80105921:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105926:	89 e5                	mov    %esp,%ebp
80105928:	83 ec 10             	sub    $0x10,%esp
8010592b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010592f:	b8 c0 8e 12 80       	mov    $0x80128ec0,%eax
80105934:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105938:	c1 e8 10             	shr    $0x10,%eax
8010593b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010593f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105942:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105945:	c9                   	leave  
80105946:	c3                   	ret    
80105947:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010594e:	66 90                	xchg   %ax,%ax

80105950 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	57                   	push   %edi
80105954:	56                   	push   %esi
80105955:	53                   	push   %ebx
80105956:	83 ec 2c             	sub    $0x2c,%esp
80105959:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010595c:	8b 43 30             	mov    0x30(%ebx),%eax
8010595f:	83 f8 40             	cmp    $0x40,%eax
80105962:	0f 84 38 01 00 00    	je     80105aa0 <trap+0x150>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105968:	83 e8 0e             	sub    $0xe,%eax
8010596b:	83 f8 31             	cmp    $0x31,%eax
8010596e:	0f 87 8c 00 00 00    	ja     80105a00 <trap+0xb0>
80105974:	ff 24 85 60 82 10 80 	jmp    *-0x7fef7da0(,%eax,4)
8010597b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010597f:	90                   	nop
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105980:	e8 0b e0 ff ff       	call   80103990 <cpuid>
80105985:	85 c0                	test   %eax,%eax
80105987:	0f 84 33 03 00 00    	je     80105cc0 <trap+0x370>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
8010598d:	e8 7e cf ff ff       	call   80102910 <lapiceoi>


  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105992:	e8 19 e0 ff ff       	call   801039b0 <myproc>
80105997:	85 c0                	test   %eax,%eax
80105999:	74 1d                	je     801059b8 <trap+0x68>
8010599b:	e8 10 e0 ff ff       	call   801039b0 <myproc>
801059a0:	8b 50 24             	mov    0x24(%eax),%edx
801059a3:	85 d2                	test   %edx,%edx
801059a5:	74 11                	je     801059b8 <trap+0x68>
801059a7:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801059ab:	83 e0 03             	and    $0x3,%eax
801059ae:	66 83 f8 03          	cmp    $0x3,%ax
801059b2:	0f 84 08 02 00 00    	je     80105bc0 <trap+0x270>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801059b8:	e8 f3 df ff ff       	call   801039b0 <myproc>
801059bd:	85 c0                	test   %eax,%eax
801059bf:	74 0f                	je     801059d0 <trap+0x80>
801059c1:	e8 ea df ff ff       	call   801039b0 <myproc>
801059c6:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801059ca:	0f 84 b8 00 00 00    	je     80105a88 <trap+0x138>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801059d0:	e8 db df ff ff       	call   801039b0 <myproc>
801059d5:	85 c0                	test   %eax,%eax
801059d7:	74 1d                	je     801059f6 <trap+0xa6>
801059d9:	e8 d2 df ff ff       	call   801039b0 <myproc>
801059de:	8b 40 24             	mov    0x24(%eax),%eax
801059e1:	85 c0                	test   %eax,%eax
801059e3:	74 11                	je     801059f6 <trap+0xa6>
801059e5:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801059e9:	83 e0 03             	and    $0x3,%eax
801059ec:	66 83 f8 03          	cmp    $0x3,%ax
801059f0:	0f 84 d7 00 00 00    	je     80105acd <trap+0x17d>
    exit();
}
801059f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059f9:	5b                   	pop    %ebx
801059fa:	5e                   	pop    %esi
801059fb:	5f                   	pop    %edi
801059fc:	5d                   	pop    %ebp
801059fd:	c3                   	ret    
801059fe:	66 90                	xchg   %ax,%ax
    if(myproc() == 0 || (tf->cs&3) == 0){
80105a00:	e8 ab df ff ff       	call   801039b0 <myproc>
80105a05:	85 c0                	test   %eax,%eax
80105a07:	0f 84 27 03 00 00    	je     80105d34 <trap+0x3e4>
80105a0d:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105a11:	0f 84 1d 03 00 00    	je     80105d34 <trap+0x3e4>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105a17:	0f 20 d1             	mov    %cr2,%ecx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a1a:	8b 53 38             	mov    0x38(%ebx),%edx
80105a1d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105a20:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105a23:	e8 68 df ff ff       	call   80103990 <cpuid>
80105a28:	8b 73 30             	mov    0x30(%ebx),%esi
80105a2b:	89 c7                	mov    %eax,%edi
80105a2d:	8b 43 34             	mov    0x34(%ebx),%eax
80105a30:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105a33:	e8 78 df ff ff       	call   801039b0 <myproc>
80105a38:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105a3b:	e8 70 df ff ff       	call   801039b0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a40:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105a43:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105a46:	51                   	push   %ecx
80105a47:	52                   	push   %edx
80105a48:	57                   	push   %edi
80105a49:	ff 75 e4             	push   -0x1c(%ebp)
80105a4c:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105a4d:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105a50:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a53:	56                   	push   %esi
80105a54:	ff 70 10             	push   0x10(%eax)
80105a57:	68 1c 82 10 80       	push   $0x8010821c
80105a5c:	e8 3f ac ff ff       	call   801006a0 <cprintf>
    myproc()->killed = 1;
80105a61:	83 c4 20             	add    $0x20,%esp
80105a64:	e8 47 df ff ff       	call   801039b0 <myproc>
80105a69:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a70:	e8 3b df ff ff       	call   801039b0 <myproc>
80105a75:	85 c0                	test   %eax,%eax
80105a77:	0f 85 1e ff ff ff    	jne    8010599b <trap+0x4b>
80105a7d:	e9 36 ff ff ff       	jmp    801059b8 <trap+0x68>
80105a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105a88:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105a8c:	0f 85 3e ff ff ff    	jne    801059d0 <trap+0x80>
    yield();
80105a92:	e8 99 e5 ff ff       	call   80104030 <yield>
80105a97:	e9 34 ff ff ff       	jmp    801059d0 <trap+0x80>
80105a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105aa0:	e8 0b df ff ff       	call   801039b0 <myproc>
80105aa5:	8b 70 24             	mov    0x24(%eax),%esi
80105aa8:	85 f6                	test   %esi,%esi
80105aaa:	0f 85 00 02 00 00    	jne    80105cb0 <trap+0x360>
    myproc()->tf = tf;
80105ab0:	e8 fb de ff ff       	call   801039b0 <myproc>
80105ab5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105ab8:	e8 e3 ef ff ff       	call   80104aa0 <syscall>
    if(myproc()->killed)
80105abd:	e8 ee de ff ff       	call   801039b0 <myproc>
80105ac2:	8b 48 24             	mov    0x24(%eax),%ecx
80105ac5:	85 c9                	test   %ecx,%ecx
80105ac7:	0f 84 29 ff ff ff    	je     801059f6 <trap+0xa6>
}
80105acd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ad0:	5b                   	pop    %ebx
80105ad1:	5e                   	pop    %esi
80105ad2:	5f                   	pop    %edi
80105ad3:	5d                   	pop    %ebp
      exit();
80105ad4:	e9 f7 e2 ff ff       	jmp    80103dd0 <exit>
80105ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105ae0:	8b 7b 38             	mov    0x38(%ebx),%edi
80105ae3:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105ae7:	e8 a4 de ff ff       	call   80103990 <cpuid>
80105aec:	57                   	push   %edi
80105aed:	56                   	push   %esi
80105aee:	50                   	push   %eax
80105aef:	68 c4 81 10 80       	push   $0x801081c4
80105af4:	e8 a7 ab ff ff       	call   801006a0 <cprintf>
    lapiceoi();
80105af9:	e8 12 ce ff ff       	call   80102910 <lapiceoi>
    break;
80105afe:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b01:	e8 aa de ff ff       	call   801039b0 <myproc>
80105b06:	85 c0                	test   %eax,%eax
80105b08:	0f 85 8d fe ff ff    	jne    8010599b <trap+0x4b>
80105b0e:	e9 a5 fe ff ff       	jmp    801059b8 <trap+0x68>
80105b13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b17:	90                   	nop
    kbdintr();
80105b18:	e8 b3 cc ff ff       	call   801027d0 <kbdintr>
    lapiceoi();
80105b1d:	e8 ee cd ff ff       	call   80102910 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b22:	e8 89 de ff ff       	call   801039b0 <myproc>
80105b27:	85 c0                	test   %eax,%eax
80105b29:	0f 85 6c fe ff ff    	jne    8010599b <trap+0x4b>
80105b2f:	e9 84 fe ff ff       	jmp    801059b8 <trap+0x68>
80105b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105b38:	e8 a3 03 00 00       	call   80105ee0 <uartintr>
    lapiceoi();
80105b3d:	e8 ce cd ff ff       	call   80102910 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b42:	e8 69 de ff ff       	call   801039b0 <myproc>
80105b47:	85 c0                	test   %eax,%eax
80105b49:	0f 85 4c fe ff ff    	jne    8010599b <trap+0x4b>
80105b4f:	e9 64 fe ff ff       	jmp    801059b8 <trap+0x68>
80105b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105b58:	e8 e3 c6 ff ff       	call   80102240 <ideintr>
80105b5d:	e9 2b fe ff ff       	jmp    8010598d <trap+0x3d>
80105b62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    struct proc* p = myproc();
80105b68:	e8 43 de ff ff       	call   801039b0 <myproc>
    for(int i = 0; i < 16; ++i) {
80105b6d:	31 ff                	xor    %edi,%edi
    struct proc* p = myproc();
80105b6f:	89 c6                	mov    %eax,%esi
80105b71:	89 45 d0             	mov    %eax,-0x30(%ebp)
    if(p->pgdir==0) {
80105b74:	8d 40 7c             	lea    0x7c(%eax),%eax
80105b77:	8b 56 04             	mov    0x4(%esi),%edx
80105b7a:	85 d2                	test   %edx,%edx
80105b7c:	0f 84 9e 01 00 00    	je     80105d20 <trap+0x3d0>
80105b82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105b88:	0f 20 d2             	mov    %cr2,%edx
      if (p->addr[i].va == rcr2()) {
80105b8b:	39 10                	cmp    %edx,(%eax)
80105b8d:	74 41                	je     80105bd0 <trap+0x280>
    for(int i = 0; i < 16; ++i) {
80105b8f:	83 c7 01             	add    $0x1,%edi
80105b92:	83 c0 50             	add    $0x50,%eax
80105b95:	83 ff 10             	cmp    $0x10,%edi
80105b98:	75 ee                	jne    80105b88 <trap+0x238>
      cprintf("Segmentation Fault\n");
80105b9a:	83 ec 0c             	sub    $0xc,%esp
80105b9d:	68 a8 81 10 80       	push   $0x801081a8
80105ba2:	e8 f9 aa ff ff       	call   801006a0 <cprintf>
      kill(p->pid);
80105ba7:	8b 45 d0             	mov    -0x30(%ebp),%eax
80105baa:	59                   	pop    %ecx
80105bab:	ff 70 10             	push   0x10(%eax)
80105bae:	e8 ed e5 ff ff       	call   801041a0 <kill>
80105bb3:	83 c4 10             	add    $0x10,%esp
80105bb6:	e9 d7 fd ff ff       	jmp    80105992 <trap+0x42>
80105bbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105bbf:	90                   	nop
    exit();
80105bc0:	e8 0b e2 ff ff       	call   80103dd0 <exit>
80105bc5:	e9 ee fd ff ff       	jmp    801059b8 <trap+0x68>
80105bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        int temp_length = p->addr[i].size;
80105bd0:	8d 04 bf             	lea    (%edi,%edi,4),%eax
80105bd3:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80105bd6:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105bd9:	c1 e0 04             	shl    $0x4,%eax
80105bdc:	8b b4 01 80 00 00 00 	mov    0x80(%ecx,%eax,1),%esi
80105be3:	89 75 e0             	mov    %esi,-0x20(%ebp)
        while(temp_length > 0){
80105be6:	85 f6                	test   %esi,%esi
80105be8:	0f 8e 3f 01 00 00    	jle    80105d2d <trap+0x3dd>
80105bee:	8d 46 ff             	lea    -0x1(%esi),%eax
        int j = 0;
80105bf1:	89 7d cc             	mov    %edi,-0x34(%ebp)
80105bf4:	89 cf                	mov    %ecx,%edi
80105bf6:	c1 e8 0c             	shr    $0xc,%eax
80105bf9:	89 5d c8             	mov    %ebx,-0x38(%ebp)
80105bfc:	83 c0 01             	add    $0x1,%eax
80105bff:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80105c02:	89 f0                	mov    %esi,%eax
80105c04:	31 f6                	xor    %esi,%esi
80105c06:	c1 e8 0c             	shr    $0xc,%eax
80105c09:	83 c0 01             	add    $0x1,%eax
80105c0c:	89 45 d8             	mov    %eax,-0x28(%ebp)
80105c0f:	eb 25                	jmp    80105c36 <trap+0x2e6>
80105c11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            mappages(p->pgdir, (void*)(p->addr[i].va + j * PAGE_SIZE), PAGE_SIZE, V2P(mem), PTE_W | PTE_U);
80105c18:	83 ec 0c             	sub    $0xc,%esp
80105c1b:	6a 06                	push   $0x6
80105c1d:	50                   	push   %eax
80105c1e:	68 00 10 00 00       	push   $0x1000
80105c23:	51                   	push   %ecx
80105c24:	53                   	push   %ebx
80105c25:	e8 16 0f 00 00       	call   80106b40 <mappages>
        while(temp_length > 0){
80105c2a:	83 c4 20             	add    $0x20,%esp
80105c2d:	39 75 d4             	cmp    %esi,-0x2c(%ebp)
80105c30:	0f 84 29 01 00 00    	je     80105d5f <trap+0x40f>
80105c36:	8b 55 e0             	mov    -0x20(%ebp),%edx
80105c39:	89 f0                	mov    %esi,%eax
80105c3b:	c1 e0 0c             	shl    $0xc,%eax
80105c3e:	29 c2                	sub    %eax,%edx
80105c40:	89 c3                	mov    %eax,%ebx
80105c42:	f7 db                	neg    %ebx
80105c44:	89 55 e4             	mov    %edx,-0x1c(%ebp)
          mem = kalloc();
80105c47:	e8 34 ca ff ff       	call   80102680 <kalloc>
          if(mem == 0){
80105c4c:	85 c0                	test   %eax,%eax
80105c4e:	0f 84 a4 00 00 00    	je     80105cf8 <trap+0x3a8>
            mappages(p->pgdir, (void*)(p->addr[i].va + j * PAGE_SIZE), PAGE_SIZE, V2P(mem), PTE_W | PTE_U);
80105c54:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80105c57:	05 00 00 00 80       	add    $0x80000000,%eax
          j++;
80105c5c:	83 c6 01             	add    $0x1,%esi
            mappages(p->pgdir, (void*)(p->addr[i].va + j * PAGE_SIZE), PAGE_SIZE, V2P(mem), PTE_W | PTE_U);
80105c5f:	c1 e1 04             	shl    $0x4,%ecx
80105c62:	8b 4c 0f 7c          	mov    0x7c(%edi,%ecx,1),%ecx
80105c66:	29 d9                	sub    %ebx,%ecx
80105c68:	8b 5f 04             	mov    0x4(%edi),%ebx
          if(temp_length >= 4096){
80105c6b:	39 75 d8             	cmp    %esi,-0x28(%ebp)
80105c6e:	75 a8                	jne    80105c18 <trap+0x2c8>
            mappages(p->pgdir, (void*)(p->addr[i].va + j * PAGE_SIZE), temp_length, V2P(mem), PTE_W | PTE_U);
80105c70:	83 ec 0c             	sub    $0xc,%esp
80105c73:	89 da                	mov    %ebx,%edx
80105c75:	8b 7d cc             	mov    -0x34(%ebp),%edi
80105c78:	8b 5d c8             	mov    -0x38(%ebp),%ebx
80105c7b:	6a 06                	push   $0x6
80105c7d:	50                   	push   %eax
80105c7e:	ff 75 e4             	push   -0x1c(%ebp)
80105c81:	51                   	push   %ecx
80105c82:	52                   	push   %edx
80105c83:	e8 b8 0e 00 00       	call   80106b40 <mappages>
80105c88:	83 c4 20             	add    $0x20,%esp
        cprintf("j = %d\ti = %d\n",j, i);
80105c8b:	83 ec 04             	sub    $0x4,%esp
80105c8e:	57                   	push   %edi
80105c8f:	56                   	push   %esi
80105c90:	68 99 81 10 80       	push   $0x80108199
80105c95:	e8 06 aa ff ff       	call   801006a0 <cprintf>
        p->addr[i].phys_page_used[i] = j;
80105c9a:	6b d7 54             	imul   $0x54,%edi,%edx
80105c9d:	8b 45 d0             	mov    -0x30(%ebp),%eax
80105ca0:	83 c4 10             	add    $0x10,%esp
80105ca3:	89 b4 10 8c 00 00 00 	mov    %esi,0x8c(%eax,%edx,1)
    if (!success) {
80105caa:	e9 e3 fc ff ff       	jmp    80105992 <trap+0x42>
80105caf:	90                   	nop
      exit();
80105cb0:	e8 1b e1 ff ff       	call   80103dd0 <exit>
80105cb5:	e9 f6 fd ff ff       	jmp    80105ab0 <trap+0x160>
80105cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105cc0:	83 ec 0c             	sub    $0xc,%esp
80105cc3:	68 80 8e 12 80       	push   $0x80128e80
80105cc8:	e8 13 e9 ff ff       	call   801045e0 <acquire>
      wakeup(&ticks);
80105ccd:	c7 04 24 60 8e 12 80 	movl   $0x80128e60,(%esp)
      ticks++;
80105cd4:	83 05 60 8e 12 80 01 	addl   $0x1,0x80128e60
      wakeup(&ticks);
80105cdb:	e8 60 e4 ff ff       	call   80104140 <wakeup>
      release(&tickslock);
80105ce0:	c7 04 24 80 8e 12 80 	movl   $0x80128e80,(%esp)
80105ce7:	e8 94 e8 ff ff       	call   80104580 <release>
80105cec:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105cef:	e9 99 fc ff ff       	jmp    8010598d <trap+0x3d>
80105cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            cprintf("kalloc failed\n");
80105cf8:	83 ec 0c             	sub    $0xc,%esp
80105cfb:	8b 7d cc             	mov    -0x34(%ebp),%edi
80105cfe:	8b 5d c8             	mov    -0x38(%ebp),%ebx
80105d01:	68 8a 81 10 80       	push   $0x8010818a
80105d06:	e8 95 a9 ff ff       	call   801006a0 <cprintf>
            kill(p->pid);
80105d0b:	58                   	pop    %eax
80105d0c:	8b 45 d0             	mov    -0x30(%ebp),%eax
80105d0f:	ff 70 10             	push   0x10(%eax)
80105d12:	e8 89 e4 ff ff       	call   801041a0 <kill>
            break;
80105d17:	83 c4 10             	add    $0x10,%esp
80105d1a:	e9 6c ff ff ff       	jmp    80105c8b <trap+0x33b>
80105d1f:	90                   	nop
      cprintf("Invalid page directory\n");
80105d20:	83 ec 0c             	sub    $0xc,%esp
80105d23:	68 72 81 10 80       	push   $0x80108172
80105d28:	e9 75 fe ff ff       	jmp    80105ba2 <trap+0x252>
        int j = 0;
80105d2d:	31 f6                	xor    %esi,%esi
80105d2f:	e9 57 ff ff ff       	jmp    80105c8b <trap+0x33b>
80105d34:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105d37:	8b 73 38             	mov    0x38(%ebx),%esi
80105d3a:	e8 51 dc ff ff       	call   80103990 <cpuid>
80105d3f:	83 ec 0c             	sub    $0xc,%esp
80105d42:	57                   	push   %edi
80105d43:	56                   	push   %esi
80105d44:	50                   	push   %eax
80105d45:	ff 73 30             	push   0x30(%ebx)
80105d48:	68 e8 81 10 80       	push   $0x801081e8
80105d4d:	e8 4e a9 ff ff       	call   801006a0 <cprintf>
      panic("trap");
80105d52:	83 c4 14             	add    $0x14,%esp
80105d55:	68 bc 81 10 80       	push   $0x801081bc
80105d5a:	e8 21 a6 ff ff       	call   80100380 <panic>
80105d5f:	8b 7d cc             	mov    -0x34(%ebp),%edi
80105d62:	8b 5d c8             	mov    -0x38(%ebp),%ebx
80105d65:	e9 21 ff ff ff       	jmp    80105c8b <trap+0x33b>
80105d6a:	66 90                	xchg   %ax,%ax
80105d6c:	66 90                	xchg   %ax,%ax
80105d6e:	66 90                	xchg   %ax,%ax

80105d70 <uartgetc>:
80105d70:	a1 c0 96 12 80       	mov    0x801296c0,%eax
80105d75:	85 c0                	test   %eax,%eax
80105d77:	74 17                	je     80105d90 <uartgetc+0x20>
80105d79:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d7e:	ec                   	in     (%dx),%al
80105d7f:	a8 01                	test   $0x1,%al
80105d81:	74 0d                	je     80105d90 <uartgetc+0x20>
80105d83:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d88:	ec                   	in     (%dx),%al
80105d89:	0f b6 c0             	movzbl %al,%eax
80105d8c:	c3                   	ret    
80105d8d:	8d 76 00             	lea    0x0(%esi),%esi
80105d90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d95:	c3                   	ret    
80105d96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d9d:	8d 76 00             	lea    0x0(%esi),%esi

80105da0 <uartinit>:
80105da0:	55                   	push   %ebp
80105da1:	31 c9                	xor    %ecx,%ecx
80105da3:	89 c8                	mov    %ecx,%eax
80105da5:	89 e5                	mov    %esp,%ebp
80105da7:	57                   	push   %edi
80105da8:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105dad:	56                   	push   %esi
80105dae:	89 fa                	mov    %edi,%edx
80105db0:	53                   	push   %ebx
80105db1:	83 ec 1c             	sub    $0x1c,%esp
80105db4:	ee                   	out    %al,(%dx)
80105db5:	be fb 03 00 00       	mov    $0x3fb,%esi
80105dba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105dbf:	89 f2                	mov    %esi,%edx
80105dc1:	ee                   	out    %al,(%dx)
80105dc2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105dc7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dcc:	ee                   	out    %al,(%dx)
80105dcd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105dd2:	89 c8                	mov    %ecx,%eax
80105dd4:	89 da                	mov    %ebx,%edx
80105dd6:	ee                   	out    %al,(%dx)
80105dd7:	b8 03 00 00 00       	mov    $0x3,%eax
80105ddc:	89 f2                	mov    %esi,%edx
80105dde:	ee                   	out    %al,(%dx)
80105ddf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105de4:	89 c8                	mov    %ecx,%eax
80105de6:	ee                   	out    %al,(%dx)
80105de7:	b8 01 00 00 00       	mov    $0x1,%eax
80105dec:	89 da                	mov    %ebx,%edx
80105dee:	ee                   	out    %al,(%dx)
80105def:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105df4:	ec                   	in     (%dx),%al
80105df5:	3c ff                	cmp    $0xff,%al
80105df7:	74 78                	je     80105e71 <uartinit+0xd1>
80105df9:	c7 05 c0 96 12 80 01 	movl   $0x1,0x801296c0
80105e00:	00 00 00 
80105e03:	89 fa                	mov    %edi,%edx
80105e05:	ec                   	in     (%dx),%al
80105e06:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e0b:	ec                   	in     (%dx),%al
80105e0c:	83 ec 08             	sub    $0x8,%esp
80105e0f:	bf 28 83 10 80       	mov    $0x80108328,%edi
80105e14:	be fd 03 00 00       	mov    $0x3fd,%esi
80105e19:	6a 00                	push   $0x0
80105e1b:	6a 04                	push   $0x4
80105e1d:	e8 5e c6 ff ff       	call   80102480 <ioapicenable>
80105e22:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
80105e26:	83 c4 10             	add    $0x10,%esp
80105e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e30:	a1 c0 96 12 80       	mov    0x801296c0,%eax
80105e35:	bb 80 00 00 00       	mov    $0x80,%ebx
80105e3a:	85 c0                	test   %eax,%eax
80105e3c:	75 14                	jne    80105e52 <uartinit+0xb2>
80105e3e:	eb 23                	jmp    80105e63 <uartinit+0xc3>
80105e40:	83 ec 0c             	sub    $0xc,%esp
80105e43:	6a 0a                	push   $0xa
80105e45:	e8 e6 ca ff ff       	call   80102930 <microdelay>
80105e4a:	83 c4 10             	add    $0x10,%esp
80105e4d:	83 eb 01             	sub    $0x1,%ebx
80105e50:	74 07                	je     80105e59 <uartinit+0xb9>
80105e52:	89 f2                	mov    %esi,%edx
80105e54:	ec                   	in     (%dx),%al
80105e55:	a8 20                	test   $0x20,%al
80105e57:	74 e7                	je     80105e40 <uartinit+0xa0>
80105e59:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105e5d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e62:	ee                   	out    %al,(%dx)
80105e63:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80105e67:	83 c7 01             	add    $0x1,%edi
80105e6a:	88 45 e7             	mov    %al,-0x19(%ebp)
80105e6d:	84 c0                	test   %al,%al
80105e6f:	75 bf                	jne    80105e30 <uartinit+0x90>
80105e71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e74:	5b                   	pop    %ebx
80105e75:	5e                   	pop    %esi
80105e76:	5f                   	pop    %edi
80105e77:	5d                   	pop    %ebp
80105e78:	c3                   	ret    
80105e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e80 <uartputc>:
80105e80:	a1 c0 96 12 80       	mov    0x801296c0,%eax
80105e85:	85 c0                	test   %eax,%eax
80105e87:	74 47                	je     80105ed0 <uartputc+0x50>
80105e89:	55                   	push   %ebp
80105e8a:	89 e5                	mov    %esp,%ebp
80105e8c:	56                   	push   %esi
80105e8d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105e92:	53                   	push   %ebx
80105e93:	bb 80 00 00 00       	mov    $0x80,%ebx
80105e98:	eb 18                	jmp    80105eb2 <uartputc+0x32>
80105e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105ea0:	83 ec 0c             	sub    $0xc,%esp
80105ea3:	6a 0a                	push   $0xa
80105ea5:	e8 86 ca ff ff       	call   80102930 <microdelay>
80105eaa:	83 c4 10             	add    $0x10,%esp
80105ead:	83 eb 01             	sub    $0x1,%ebx
80105eb0:	74 07                	je     80105eb9 <uartputc+0x39>
80105eb2:	89 f2                	mov    %esi,%edx
80105eb4:	ec                   	in     (%dx),%al
80105eb5:	a8 20                	test   $0x20,%al
80105eb7:	74 e7                	je     80105ea0 <uartputc+0x20>
80105eb9:	8b 45 08             	mov    0x8(%ebp),%eax
80105ebc:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105ec1:	ee                   	out    %al,(%dx)
80105ec2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105ec5:	5b                   	pop    %ebx
80105ec6:	5e                   	pop    %esi
80105ec7:	5d                   	pop    %ebp
80105ec8:	c3                   	ret    
80105ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ed0:	c3                   	ret    
80105ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ed8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105edf:	90                   	nop

80105ee0 <uartintr>:
80105ee0:	55                   	push   %ebp
80105ee1:	89 e5                	mov    %esp,%ebp
80105ee3:	83 ec 14             	sub    $0x14,%esp
80105ee6:	68 70 5d 10 80       	push   $0x80105d70
80105eeb:	e8 90 a9 ff ff       	call   80100880 <consoleintr>
80105ef0:	83 c4 10             	add    $0x10,%esp
80105ef3:	c9                   	leave  
80105ef4:	c3                   	ret    

80105ef5 <vector0>:
80105ef5:	6a 00                	push   $0x0
80105ef7:	6a 00                	push   $0x0
80105ef9:	e9 7c f9 ff ff       	jmp    8010587a <alltraps>

80105efe <vector1>:
80105efe:	6a 00                	push   $0x0
80105f00:	6a 01                	push   $0x1
80105f02:	e9 73 f9 ff ff       	jmp    8010587a <alltraps>

80105f07 <vector2>:
80105f07:	6a 00                	push   $0x0
80105f09:	6a 02                	push   $0x2
80105f0b:	e9 6a f9 ff ff       	jmp    8010587a <alltraps>

80105f10 <vector3>:
80105f10:	6a 00                	push   $0x0
80105f12:	6a 03                	push   $0x3
80105f14:	e9 61 f9 ff ff       	jmp    8010587a <alltraps>

80105f19 <vector4>:
80105f19:	6a 00                	push   $0x0
80105f1b:	6a 04                	push   $0x4
80105f1d:	e9 58 f9 ff ff       	jmp    8010587a <alltraps>

80105f22 <vector5>:
80105f22:	6a 00                	push   $0x0
80105f24:	6a 05                	push   $0x5
80105f26:	e9 4f f9 ff ff       	jmp    8010587a <alltraps>

80105f2b <vector6>:
80105f2b:	6a 00                	push   $0x0
80105f2d:	6a 06                	push   $0x6
80105f2f:	e9 46 f9 ff ff       	jmp    8010587a <alltraps>

80105f34 <vector7>:
80105f34:	6a 00                	push   $0x0
80105f36:	6a 07                	push   $0x7
80105f38:	e9 3d f9 ff ff       	jmp    8010587a <alltraps>

80105f3d <vector8>:
80105f3d:	6a 08                	push   $0x8
80105f3f:	e9 36 f9 ff ff       	jmp    8010587a <alltraps>

80105f44 <vector9>:
80105f44:	6a 00                	push   $0x0
80105f46:	6a 09                	push   $0x9
80105f48:	e9 2d f9 ff ff       	jmp    8010587a <alltraps>

80105f4d <vector10>:
80105f4d:	6a 0a                	push   $0xa
80105f4f:	e9 26 f9 ff ff       	jmp    8010587a <alltraps>

80105f54 <vector11>:
80105f54:	6a 0b                	push   $0xb
80105f56:	e9 1f f9 ff ff       	jmp    8010587a <alltraps>

80105f5b <vector12>:
80105f5b:	6a 0c                	push   $0xc
80105f5d:	e9 18 f9 ff ff       	jmp    8010587a <alltraps>

80105f62 <vector13>:
80105f62:	6a 0d                	push   $0xd
80105f64:	e9 11 f9 ff ff       	jmp    8010587a <alltraps>

80105f69 <vector14>:
80105f69:	6a 0e                	push   $0xe
80105f6b:	e9 0a f9 ff ff       	jmp    8010587a <alltraps>

80105f70 <vector15>:
80105f70:	6a 00                	push   $0x0
80105f72:	6a 0f                	push   $0xf
80105f74:	e9 01 f9 ff ff       	jmp    8010587a <alltraps>

80105f79 <vector16>:
80105f79:	6a 00                	push   $0x0
80105f7b:	6a 10                	push   $0x10
80105f7d:	e9 f8 f8 ff ff       	jmp    8010587a <alltraps>

80105f82 <vector17>:
80105f82:	6a 11                	push   $0x11
80105f84:	e9 f1 f8 ff ff       	jmp    8010587a <alltraps>

80105f89 <vector18>:
80105f89:	6a 00                	push   $0x0
80105f8b:	6a 12                	push   $0x12
80105f8d:	e9 e8 f8 ff ff       	jmp    8010587a <alltraps>

80105f92 <vector19>:
80105f92:	6a 00                	push   $0x0
80105f94:	6a 13                	push   $0x13
80105f96:	e9 df f8 ff ff       	jmp    8010587a <alltraps>

80105f9b <vector20>:
80105f9b:	6a 00                	push   $0x0
80105f9d:	6a 14                	push   $0x14
80105f9f:	e9 d6 f8 ff ff       	jmp    8010587a <alltraps>

80105fa4 <vector21>:
80105fa4:	6a 00                	push   $0x0
80105fa6:	6a 15                	push   $0x15
80105fa8:	e9 cd f8 ff ff       	jmp    8010587a <alltraps>

80105fad <vector22>:
80105fad:	6a 00                	push   $0x0
80105faf:	6a 16                	push   $0x16
80105fb1:	e9 c4 f8 ff ff       	jmp    8010587a <alltraps>

80105fb6 <vector23>:
80105fb6:	6a 00                	push   $0x0
80105fb8:	6a 17                	push   $0x17
80105fba:	e9 bb f8 ff ff       	jmp    8010587a <alltraps>

80105fbf <vector24>:
80105fbf:	6a 00                	push   $0x0
80105fc1:	6a 18                	push   $0x18
80105fc3:	e9 b2 f8 ff ff       	jmp    8010587a <alltraps>

80105fc8 <vector25>:
80105fc8:	6a 00                	push   $0x0
80105fca:	6a 19                	push   $0x19
80105fcc:	e9 a9 f8 ff ff       	jmp    8010587a <alltraps>

80105fd1 <vector26>:
80105fd1:	6a 00                	push   $0x0
80105fd3:	6a 1a                	push   $0x1a
80105fd5:	e9 a0 f8 ff ff       	jmp    8010587a <alltraps>

80105fda <vector27>:
80105fda:	6a 00                	push   $0x0
80105fdc:	6a 1b                	push   $0x1b
80105fde:	e9 97 f8 ff ff       	jmp    8010587a <alltraps>

80105fe3 <vector28>:
80105fe3:	6a 00                	push   $0x0
80105fe5:	6a 1c                	push   $0x1c
80105fe7:	e9 8e f8 ff ff       	jmp    8010587a <alltraps>

80105fec <vector29>:
80105fec:	6a 00                	push   $0x0
80105fee:	6a 1d                	push   $0x1d
80105ff0:	e9 85 f8 ff ff       	jmp    8010587a <alltraps>

80105ff5 <vector30>:
80105ff5:	6a 00                	push   $0x0
80105ff7:	6a 1e                	push   $0x1e
80105ff9:	e9 7c f8 ff ff       	jmp    8010587a <alltraps>

80105ffe <vector31>:
80105ffe:	6a 00                	push   $0x0
80106000:	6a 1f                	push   $0x1f
80106002:	e9 73 f8 ff ff       	jmp    8010587a <alltraps>

80106007 <vector32>:
80106007:	6a 00                	push   $0x0
80106009:	6a 20                	push   $0x20
8010600b:	e9 6a f8 ff ff       	jmp    8010587a <alltraps>

80106010 <vector33>:
80106010:	6a 00                	push   $0x0
80106012:	6a 21                	push   $0x21
80106014:	e9 61 f8 ff ff       	jmp    8010587a <alltraps>

80106019 <vector34>:
80106019:	6a 00                	push   $0x0
8010601b:	6a 22                	push   $0x22
8010601d:	e9 58 f8 ff ff       	jmp    8010587a <alltraps>

80106022 <vector35>:
80106022:	6a 00                	push   $0x0
80106024:	6a 23                	push   $0x23
80106026:	e9 4f f8 ff ff       	jmp    8010587a <alltraps>

8010602b <vector36>:
8010602b:	6a 00                	push   $0x0
8010602d:	6a 24                	push   $0x24
8010602f:	e9 46 f8 ff ff       	jmp    8010587a <alltraps>

80106034 <vector37>:
80106034:	6a 00                	push   $0x0
80106036:	6a 25                	push   $0x25
80106038:	e9 3d f8 ff ff       	jmp    8010587a <alltraps>

8010603d <vector38>:
8010603d:	6a 00                	push   $0x0
8010603f:	6a 26                	push   $0x26
80106041:	e9 34 f8 ff ff       	jmp    8010587a <alltraps>

80106046 <vector39>:
80106046:	6a 00                	push   $0x0
80106048:	6a 27                	push   $0x27
8010604a:	e9 2b f8 ff ff       	jmp    8010587a <alltraps>

8010604f <vector40>:
8010604f:	6a 00                	push   $0x0
80106051:	6a 28                	push   $0x28
80106053:	e9 22 f8 ff ff       	jmp    8010587a <alltraps>

80106058 <vector41>:
80106058:	6a 00                	push   $0x0
8010605a:	6a 29                	push   $0x29
8010605c:	e9 19 f8 ff ff       	jmp    8010587a <alltraps>

80106061 <vector42>:
80106061:	6a 00                	push   $0x0
80106063:	6a 2a                	push   $0x2a
80106065:	e9 10 f8 ff ff       	jmp    8010587a <alltraps>

8010606a <vector43>:
8010606a:	6a 00                	push   $0x0
8010606c:	6a 2b                	push   $0x2b
8010606e:	e9 07 f8 ff ff       	jmp    8010587a <alltraps>

80106073 <vector44>:
80106073:	6a 00                	push   $0x0
80106075:	6a 2c                	push   $0x2c
80106077:	e9 fe f7 ff ff       	jmp    8010587a <alltraps>

8010607c <vector45>:
8010607c:	6a 00                	push   $0x0
8010607e:	6a 2d                	push   $0x2d
80106080:	e9 f5 f7 ff ff       	jmp    8010587a <alltraps>

80106085 <vector46>:
80106085:	6a 00                	push   $0x0
80106087:	6a 2e                	push   $0x2e
80106089:	e9 ec f7 ff ff       	jmp    8010587a <alltraps>

8010608e <vector47>:
8010608e:	6a 00                	push   $0x0
80106090:	6a 2f                	push   $0x2f
80106092:	e9 e3 f7 ff ff       	jmp    8010587a <alltraps>

80106097 <vector48>:
80106097:	6a 00                	push   $0x0
80106099:	6a 30                	push   $0x30
8010609b:	e9 da f7 ff ff       	jmp    8010587a <alltraps>

801060a0 <vector49>:
801060a0:	6a 00                	push   $0x0
801060a2:	6a 31                	push   $0x31
801060a4:	e9 d1 f7 ff ff       	jmp    8010587a <alltraps>

801060a9 <vector50>:
801060a9:	6a 00                	push   $0x0
801060ab:	6a 32                	push   $0x32
801060ad:	e9 c8 f7 ff ff       	jmp    8010587a <alltraps>

801060b2 <vector51>:
801060b2:	6a 00                	push   $0x0
801060b4:	6a 33                	push   $0x33
801060b6:	e9 bf f7 ff ff       	jmp    8010587a <alltraps>

801060bb <vector52>:
801060bb:	6a 00                	push   $0x0
801060bd:	6a 34                	push   $0x34
801060bf:	e9 b6 f7 ff ff       	jmp    8010587a <alltraps>

801060c4 <vector53>:
801060c4:	6a 00                	push   $0x0
801060c6:	6a 35                	push   $0x35
801060c8:	e9 ad f7 ff ff       	jmp    8010587a <alltraps>

801060cd <vector54>:
801060cd:	6a 00                	push   $0x0
801060cf:	6a 36                	push   $0x36
801060d1:	e9 a4 f7 ff ff       	jmp    8010587a <alltraps>

801060d6 <vector55>:
801060d6:	6a 00                	push   $0x0
801060d8:	6a 37                	push   $0x37
801060da:	e9 9b f7 ff ff       	jmp    8010587a <alltraps>

801060df <vector56>:
801060df:	6a 00                	push   $0x0
801060e1:	6a 38                	push   $0x38
801060e3:	e9 92 f7 ff ff       	jmp    8010587a <alltraps>

801060e8 <vector57>:
801060e8:	6a 00                	push   $0x0
801060ea:	6a 39                	push   $0x39
801060ec:	e9 89 f7 ff ff       	jmp    8010587a <alltraps>

801060f1 <vector58>:
801060f1:	6a 00                	push   $0x0
801060f3:	6a 3a                	push   $0x3a
801060f5:	e9 80 f7 ff ff       	jmp    8010587a <alltraps>

801060fa <vector59>:
801060fa:	6a 00                	push   $0x0
801060fc:	6a 3b                	push   $0x3b
801060fe:	e9 77 f7 ff ff       	jmp    8010587a <alltraps>

80106103 <vector60>:
80106103:	6a 00                	push   $0x0
80106105:	6a 3c                	push   $0x3c
80106107:	e9 6e f7 ff ff       	jmp    8010587a <alltraps>

8010610c <vector61>:
8010610c:	6a 00                	push   $0x0
8010610e:	6a 3d                	push   $0x3d
80106110:	e9 65 f7 ff ff       	jmp    8010587a <alltraps>

80106115 <vector62>:
80106115:	6a 00                	push   $0x0
80106117:	6a 3e                	push   $0x3e
80106119:	e9 5c f7 ff ff       	jmp    8010587a <alltraps>

8010611e <vector63>:
8010611e:	6a 00                	push   $0x0
80106120:	6a 3f                	push   $0x3f
80106122:	e9 53 f7 ff ff       	jmp    8010587a <alltraps>

80106127 <vector64>:
80106127:	6a 00                	push   $0x0
80106129:	6a 40                	push   $0x40
8010612b:	e9 4a f7 ff ff       	jmp    8010587a <alltraps>

80106130 <vector65>:
80106130:	6a 00                	push   $0x0
80106132:	6a 41                	push   $0x41
80106134:	e9 41 f7 ff ff       	jmp    8010587a <alltraps>

80106139 <vector66>:
80106139:	6a 00                	push   $0x0
8010613b:	6a 42                	push   $0x42
8010613d:	e9 38 f7 ff ff       	jmp    8010587a <alltraps>

80106142 <vector67>:
80106142:	6a 00                	push   $0x0
80106144:	6a 43                	push   $0x43
80106146:	e9 2f f7 ff ff       	jmp    8010587a <alltraps>

8010614b <vector68>:
8010614b:	6a 00                	push   $0x0
8010614d:	6a 44                	push   $0x44
8010614f:	e9 26 f7 ff ff       	jmp    8010587a <alltraps>

80106154 <vector69>:
80106154:	6a 00                	push   $0x0
80106156:	6a 45                	push   $0x45
80106158:	e9 1d f7 ff ff       	jmp    8010587a <alltraps>

8010615d <vector70>:
8010615d:	6a 00                	push   $0x0
8010615f:	6a 46                	push   $0x46
80106161:	e9 14 f7 ff ff       	jmp    8010587a <alltraps>

80106166 <vector71>:
80106166:	6a 00                	push   $0x0
80106168:	6a 47                	push   $0x47
8010616a:	e9 0b f7 ff ff       	jmp    8010587a <alltraps>

8010616f <vector72>:
8010616f:	6a 00                	push   $0x0
80106171:	6a 48                	push   $0x48
80106173:	e9 02 f7 ff ff       	jmp    8010587a <alltraps>

80106178 <vector73>:
80106178:	6a 00                	push   $0x0
8010617a:	6a 49                	push   $0x49
8010617c:	e9 f9 f6 ff ff       	jmp    8010587a <alltraps>

80106181 <vector74>:
80106181:	6a 00                	push   $0x0
80106183:	6a 4a                	push   $0x4a
80106185:	e9 f0 f6 ff ff       	jmp    8010587a <alltraps>

8010618a <vector75>:
8010618a:	6a 00                	push   $0x0
8010618c:	6a 4b                	push   $0x4b
8010618e:	e9 e7 f6 ff ff       	jmp    8010587a <alltraps>

80106193 <vector76>:
80106193:	6a 00                	push   $0x0
80106195:	6a 4c                	push   $0x4c
80106197:	e9 de f6 ff ff       	jmp    8010587a <alltraps>

8010619c <vector77>:
8010619c:	6a 00                	push   $0x0
8010619e:	6a 4d                	push   $0x4d
801061a0:	e9 d5 f6 ff ff       	jmp    8010587a <alltraps>

801061a5 <vector78>:
801061a5:	6a 00                	push   $0x0
801061a7:	6a 4e                	push   $0x4e
801061a9:	e9 cc f6 ff ff       	jmp    8010587a <alltraps>

801061ae <vector79>:
801061ae:	6a 00                	push   $0x0
801061b0:	6a 4f                	push   $0x4f
801061b2:	e9 c3 f6 ff ff       	jmp    8010587a <alltraps>

801061b7 <vector80>:
801061b7:	6a 00                	push   $0x0
801061b9:	6a 50                	push   $0x50
801061bb:	e9 ba f6 ff ff       	jmp    8010587a <alltraps>

801061c0 <vector81>:
801061c0:	6a 00                	push   $0x0
801061c2:	6a 51                	push   $0x51
801061c4:	e9 b1 f6 ff ff       	jmp    8010587a <alltraps>

801061c9 <vector82>:
801061c9:	6a 00                	push   $0x0
801061cb:	6a 52                	push   $0x52
801061cd:	e9 a8 f6 ff ff       	jmp    8010587a <alltraps>

801061d2 <vector83>:
801061d2:	6a 00                	push   $0x0
801061d4:	6a 53                	push   $0x53
801061d6:	e9 9f f6 ff ff       	jmp    8010587a <alltraps>

801061db <vector84>:
801061db:	6a 00                	push   $0x0
801061dd:	6a 54                	push   $0x54
801061df:	e9 96 f6 ff ff       	jmp    8010587a <alltraps>

801061e4 <vector85>:
801061e4:	6a 00                	push   $0x0
801061e6:	6a 55                	push   $0x55
801061e8:	e9 8d f6 ff ff       	jmp    8010587a <alltraps>

801061ed <vector86>:
801061ed:	6a 00                	push   $0x0
801061ef:	6a 56                	push   $0x56
801061f1:	e9 84 f6 ff ff       	jmp    8010587a <alltraps>

801061f6 <vector87>:
801061f6:	6a 00                	push   $0x0
801061f8:	6a 57                	push   $0x57
801061fa:	e9 7b f6 ff ff       	jmp    8010587a <alltraps>

801061ff <vector88>:
801061ff:	6a 00                	push   $0x0
80106201:	6a 58                	push   $0x58
80106203:	e9 72 f6 ff ff       	jmp    8010587a <alltraps>

80106208 <vector89>:
80106208:	6a 00                	push   $0x0
8010620a:	6a 59                	push   $0x59
8010620c:	e9 69 f6 ff ff       	jmp    8010587a <alltraps>

80106211 <vector90>:
80106211:	6a 00                	push   $0x0
80106213:	6a 5a                	push   $0x5a
80106215:	e9 60 f6 ff ff       	jmp    8010587a <alltraps>

8010621a <vector91>:
8010621a:	6a 00                	push   $0x0
8010621c:	6a 5b                	push   $0x5b
8010621e:	e9 57 f6 ff ff       	jmp    8010587a <alltraps>

80106223 <vector92>:
80106223:	6a 00                	push   $0x0
80106225:	6a 5c                	push   $0x5c
80106227:	e9 4e f6 ff ff       	jmp    8010587a <alltraps>

8010622c <vector93>:
8010622c:	6a 00                	push   $0x0
8010622e:	6a 5d                	push   $0x5d
80106230:	e9 45 f6 ff ff       	jmp    8010587a <alltraps>

80106235 <vector94>:
80106235:	6a 00                	push   $0x0
80106237:	6a 5e                	push   $0x5e
80106239:	e9 3c f6 ff ff       	jmp    8010587a <alltraps>

8010623e <vector95>:
8010623e:	6a 00                	push   $0x0
80106240:	6a 5f                	push   $0x5f
80106242:	e9 33 f6 ff ff       	jmp    8010587a <alltraps>

80106247 <vector96>:
80106247:	6a 00                	push   $0x0
80106249:	6a 60                	push   $0x60
8010624b:	e9 2a f6 ff ff       	jmp    8010587a <alltraps>

80106250 <vector97>:
80106250:	6a 00                	push   $0x0
80106252:	6a 61                	push   $0x61
80106254:	e9 21 f6 ff ff       	jmp    8010587a <alltraps>

80106259 <vector98>:
80106259:	6a 00                	push   $0x0
8010625b:	6a 62                	push   $0x62
8010625d:	e9 18 f6 ff ff       	jmp    8010587a <alltraps>

80106262 <vector99>:
80106262:	6a 00                	push   $0x0
80106264:	6a 63                	push   $0x63
80106266:	e9 0f f6 ff ff       	jmp    8010587a <alltraps>

8010626b <vector100>:
8010626b:	6a 00                	push   $0x0
8010626d:	6a 64                	push   $0x64
8010626f:	e9 06 f6 ff ff       	jmp    8010587a <alltraps>

80106274 <vector101>:
80106274:	6a 00                	push   $0x0
80106276:	6a 65                	push   $0x65
80106278:	e9 fd f5 ff ff       	jmp    8010587a <alltraps>

8010627d <vector102>:
8010627d:	6a 00                	push   $0x0
8010627f:	6a 66                	push   $0x66
80106281:	e9 f4 f5 ff ff       	jmp    8010587a <alltraps>

80106286 <vector103>:
80106286:	6a 00                	push   $0x0
80106288:	6a 67                	push   $0x67
8010628a:	e9 eb f5 ff ff       	jmp    8010587a <alltraps>

8010628f <vector104>:
8010628f:	6a 00                	push   $0x0
80106291:	6a 68                	push   $0x68
80106293:	e9 e2 f5 ff ff       	jmp    8010587a <alltraps>

80106298 <vector105>:
80106298:	6a 00                	push   $0x0
8010629a:	6a 69                	push   $0x69
8010629c:	e9 d9 f5 ff ff       	jmp    8010587a <alltraps>

801062a1 <vector106>:
801062a1:	6a 00                	push   $0x0
801062a3:	6a 6a                	push   $0x6a
801062a5:	e9 d0 f5 ff ff       	jmp    8010587a <alltraps>

801062aa <vector107>:
801062aa:	6a 00                	push   $0x0
801062ac:	6a 6b                	push   $0x6b
801062ae:	e9 c7 f5 ff ff       	jmp    8010587a <alltraps>

801062b3 <vector108>:
801062b3:	6a 00                	push   $0x0
801062b5:	6a 6c                	push   $0x6c
801062b7:	e9 be f5 ff ff       	jmp    8010587a <alltraps>

801062bc <vector109>:
801062bc:	6a 00                	push   $0x0
801062be:	6a 6d                	push   $0x6d
801062c0:	e9 b5 f5 ff ff       	jmp    8010587a <alltraps>

801062c5 <vector110>:
801062c5:	6a 00                	push   $0x0
801062c7:	6a 6e                	push   $0x6e
801062c9:	e9 ac f5 ff ff       	jmp    8010587a <alltraps>

801062ce <vector111>:
801062ce:	6a 00                	push   $0x0
801062d0:	6a 6f                	push   $0x6f
801062d2:	e9 a3 f5 ff ff       	jmp    8010587a <alltraps>

801062d7 <vector112>:
801062d7:	6a 00                	push   $0x0
801062d9:	6a 70                	push   $0x70
801062db:	e9 9a f5 ff ff       	jmp    8010587a <alltraps>

801062e0 <vector113>:
801062e0:	6a 00                	push   $0x0
801062e2:	6a 71                	push   $0x71
801062e4:	e9 91 f5 ff ff       	jmp    8010587a <alltraps>

801062e9 <vector114>:
801062e9:	6a 00                	push   $0x0
801062eb:	6a 72                	push   $0x72
801062ed:	e9 88 f5 ff ff       	jmp    8010587a <alltraps>

801062f2 <vector115>:
801062f2:	6a 00                	push   $0x0
801062f4:	6a 73                	push   $0x73
801062f6:	e9 7f f5 ff ff       	jmp    8010587a <alltraps>

801062fb <vector116>:
801062fb:	6a 00                	push   $0x0
801062fd:	6a 74                	push   $0x74
801062ff:	e9 76 f5 ff ff       	jmp    8010587a <alltraps>

80106304 <vector117>:
80106304:	6a 00                	push   $0x0
80106306:	6a 75                	push   $0x75
80106308:	e9 6d f5 ff ff       	jmp    8010587a <alltraps>

8010630d <vector118>:
8010630d:	6a 00                	push   $0x0
8010630f:	6a 76                	push   $0x76
80106311:	e9 64 f5 ff ff       	jmp    8010587a <alltraps>

80106316 <vector119>:
80106316:	6a 00                	push   $0x0
80106318:	6a 77                	push   $0x77
8010631a:	e9 5b f5 ff ff       	jmp    8010587a <alltraps>

8010631f <vector120>:
8010631f:	6a 00                	push   $0x0
80106321:	6a 78                	push   $0x78
80106323:	e9 52 f5 ff ff       	jmp    8010587a <alltraps>

80106328 <vector121>:
80106328:	6a 00                	push   $0x0
8010632a:	6a 79                	push   $0x79
8010632c:	e9 49 f5 ff ff       	jmp    8010587a <alltraps>

80106331 <vector122>:
80106331:	6a 00                	push   $0x0
80106333:	6a 7a                	push   $0x7a
80106335:	e9 40 f5 ff ff       	jmp    8010587a <alltraps>

8010633a <vector123>:
8010633a:	6a 00                	push   $0x0
8010633c:	6a 7b                	push   $0x7b
8010633e:	e9 37 f5 ff ff       	jmp    8010587a <alltraps>

80106343 <vector124>:
80106343:	6a 00                	push   $0x0
80106345:	6a 7c                	push   $0x7c
80106347:	e9 2e f5 ff ff       	jmp    8010587a <alltraps>

8010634c <vector125>:
8010634c:	6a 00                	push   $0x0
8010634e:	6a 7d                	push   $0x7d
80106350:	e9 25 f5 ff ff       	jmp    8010587a <alltraps>

80106355 <vector126>:
80106355:	6a 00                	push   $0x0
80106357:	6a 7e                	push   $0x7e
80106359:	e9 1c f5 ff ff       	jmp    8010587a <alltraps>

8010635e <vector127>:
8010635e:	6a 00                	push   $0x0
80106360:	6a 7f                	push   $0x7f
80106362:	e9 13 f5 ff ff       	jmp    8010587a <alltraps>

80106367 <vector128>:
80106367:	6a 00                	push   $0x0
80106369:	68 80 00 00 00       	push   $0x80
8010636e:	e9 07 f5 ff ff       	jmp    8010587a <alltraps>

80106373 <vector129>:
80106373:	6a 00                	push   $0x0
80106375:	68 81 00 00 00       	push   $0x81
8010637a:	e9 fb f4 ff ff       	jmp    8010587a <alltraps>

8010637f <vector130>:
8010637f:	6a 00                	push   $0x0
80106381:	68 82 00 00 00       	push   $0x82
80106386:	e9 ef f4 ff ff       	jmp    8010587a <alltraps>

8010638b <vector131>:
8010638b:	6a 00                	push   $0x0
8010638d:	68 83 00 00 00       	push   $0x83
80106392:	e9 e3 f4 ff ff       	jmp    8010587a <alltraps>

80106397 <vector132>:
80106397:	6a 00                	push   $0x0
80106399:	68 84 00 00 00       	push   $0x84
8010639e:	e9 d7 f4 ff ff       	jmp    8010587a <alltraps>

801063a3 <vector133>:
801063a3:	6a 00                	push   $0x0
801063a5:	68 85 00 00 00       	push   $0x85
801063aa:	e9 cb f4 ff ff       	jmp    8010587a <alltraps>

801063af <vector134>:
801063af:	6a 00                	push   $0x0
801063b1:	68 86 00 00 00       	push   $0x86
801063b6:	e9 bf f4 ff ff       	jmp    8010587a <alltraps>

801063bb <vector135>:
801063bb:	6a 00                	push   $0x0
801063bd:	68 87 00 00 00       	push   $0x87
801063c2:	e9 b3 f4 ff ff       	jmp    8010587a <alltraps>

801063c7 <vector136>:
801063c7:	6a 00                	push   $0x0
801063c9:	68 88 00 00 00       	push   $0x88
801063ce:	e9 a7 f4 ff ff       	jmp    8010587a <alltraps>

801063d3 <vector137>:
801063d3:	6a 00                	push   $0x0
801063d5:	68 89 00 00 00       	push   $0x89
801063da:	e9 9b f4 ff ff       	jmp    8010587a <alltraps>

801063df <vector138>:
801063df:	6a 00                	push   $0x0
801063e1:	68 8a 00 00 00       	push   $0x8a
801063e6:	e9 8f f4 ff ff       	jmp    8010587a <alltraps>

801063eb <vector139>:
801063eb:	6a 00                	push   $0x0
801063ed:	68 8b 00 00 00       	push   $0x8b
801063f2:	e9 83 f4 ff ff       	jmp    8010587a <alltraps>

801063f7 <vector140>:
801063f7:	6a 00                	push   $0x0
801063f9:	68 8c 00 00 00       	push   $0x8c
801063fe:	e9 77 f4 ff ff       	jmp    8010587a <alltraps>

80106403 <vector141>:
80106403:	6a 00                	push   $0x0
80106405:	68 8d 00 00 00       	push   $0x8d
8010640a:	e9 6b f4 ff ff       	jmp    8010587a <alltraps>

8010640f <vector142>:
8010640f:	6a 00                	push   $0x0
80106411:	68 8e 00 00 00       	push   $0x8e
80106416:	e9 5f f4 ff ff       	jmp    8010587a <alltraps>

8010641b <vector143>:
8010641b:	6a 00                	push   $0x0
8010641d:	68 8f 00 00 00       	push   $0x8f
80106422:	e9 53 f4 ff ff       	jmp    8010587a <alltraps>

80106427 <vector144>:
80106427:	6a 00                	push   $0x0
80106429:	68 90 00 00 00       	push   $0x90
8010642e:	e9 47 f4 ff ff       	jmp    8010587a <alltraps>

80106433 <vector145>:
80106433:	6a 00                	push   $0x0
80106435:	68 91 00 00 00       	push   $0x91
8010643a:	e9 3b f4 ff ff       	jmp    8010587a <alltraps>

8010643f <vector146>:
8010643f:	6a 00                	push   $0x0
80106441:	68 92 00 00 00       	push   $0x92
80106446:	e9 2f f4 ff ff       	jmp    8010587a <alltraps>

8010644b <vector147>:
8010644b:	6a 00                	push   $0x0
8010644d:	68 93 00 00 00       	push   $0x93
80106452:	e9 23 f4 ff ff       	jmp    8010587a <alltraps>

80106457 <vector148>:
80106457:	6a 00                	push   $0x0
80106459:	68 94 00 00 00       	push   $0x94
8010645e:	e9 17 f4 ff ff       	jmp    8010587a <alltraps>

80106463 <vector149>:
80106463:	6a 00                	push   $0x0
80106465:	68 95 00 00 00       	push   $0x95
8010646a:	e9 0b f4 ff ff       	jmp    8010587a <alltraps>

8010646f <vector150>:
8010646f:	6a 00                	push   $0x0
80106471:	68 96 00 00 00       	push   $0x96
80106476:	e9 ff f3 ff ff       	jmp    8010587a <alltraps>

8010647b <vector151>:
8010647b:	6a 00                	push   $0x0
8010647d:	68 97 00 00 00       	push   $0x97
80106482:	e9 f3 f3 ff ff       	jmp    8010587a <alltraps>

80106487 <vector152>:
80106487:	6a 00                	push   $0x0
80106489:	68 98 00 00 00       	push   $0x98
8010648e:	e9 e7 f3 ff ff       	jmp    8010587a <alltraps>

80106493 <vector153>:
80106493:	6a 00                	push   $0x0
80106495:	68 99 00 00 00       	push   $0x99
8010649a:	e9 db f3 ff ff       	jmp    8010587a <alltraps>

8010649f <vector154>:
8010649f:	6a 00                	push   $0x0
801064a1:	68 9a 00 00 00       	push   $0x9a
801064a6:	e9 cf f3 ff ff       	jmp    8010587a <alltraps>

801064ab <vector155>:
801064ab:	6a 00                	push   $0x0
801064ad:	68 9b 00 00 00       	push   $0x9b
801064b2:	e9 c3 f3 ff ff       	jmp    8010587a <alltraps>

801064b7 <vector156>:
801064b7:	6a 00                	push   $0x0
801064b9:	68 9c 00 00 00       	push   $0x9c
801064be:	e9 b7 f3 ff ff       	jmp    8010587a <alltraps>

801064c3 <vector157>:
801064c3:	6a 00                	push   $0x0
801064c5:	68 9d 00 00 00       	push   $0x9d
801064ca:	e9 ab f3 ff ff       	jmp    8010587a <alltraps>

801064cf <vector158>:
801064cf:	6a 00                	push   $0x0
801064d1:	68 9e 00 00 00       	push   $0x9e
801064d6:	e9 9f f3 ff ff       	jmp    8010587a <alltraps>

801064db <vector159>:
801064db:	6a 00                	push   $0x0
801064dd:	68 9f 00 00 00       	push   $0x9f
801064e2:	e9 93 f3 ff ff       	jmp    8010587a <alltraps>

801064e7 <vector160>:
801064e7:	6a 00                	push   $0x0
801064e9:	68 a0 00 00 00       	push   $0xa0
801064ee:	e9 87 f3 ff ff       	jmp    8010587a <alltraps>

801064f3 <vector161>:
801064f3:	6a 00                	push   $0x0
801064f5:	68 a1 00 00 00       	push   $0xa1
801064fa:	e9 7b f3 ff ff       	jmp    8010587a <alltraps>

801064ff <vector162>:
801064ff:	6a 00                	push   $0x0
80106501:	68 a2 00 00 00       	push   $0xa2
80106506:	e9 6f f3 ff ff       	jmp    8010587a <alltraps>

8010650b <vector163>:
8010650b:	6a 00                	push   $0x0
8010650d:	68 a3 00 00 00       	push   $0xa3
80106512:	e9 63 f3 ff ff       	jmp    8010587a <alltraps>

80106517 <vector164>:
80106517:	6a 00                	push   $0x0
80106519:	68 a4 00 00 00       	push   $0xa4
8010651e:	e9 57 f3 ff ff       	jmp    8010587a <alltraps>

80106523 <vector165>:
80106523:	6a 00                	push   $0x0
80106525:	68 a5 00 00 00       	push   $0xa5
8010652a:	e9 4b f3 ff ff       	jmp    8010587a <alltraps>

8010652f <vector166>:
8010652f:	6a 00                	push   $0x0
80106531:	68 a6 00 00 00       	push   $0xa6
80106536:	e9 3f f3 ff ff       	jmp    8010587a <alltraps>

8010653b <vector167>:
8010653b:	6a 00                	push   $0x0
8010653d:	68 a7 00 00 00       	push   $0xa7
80106542:	e9 33 f3 ff ff       	jmp    8010587a <alltraps>

80106547 <vector168>:
80106547:	6a 00                	push   $0x0
80106549:	68 a8 00 00 00       	push   $0xa8
8010654e:	e9 27 f3 ff ff       	jmp    8010587a <alltraps>

80106553 <vector169>:
80106553:	6a 00                	push   $0x0
80106555:	68 a9 00 00 00       	push   $0xa9
8010655a:	e9 1b f3 ff ff       	jmp    8010587a <alltraps>

8010655f <vector170>:
8010655f:	6a 00                	push   $0x0
80106561:	68 aa 00 00 00       	push   $0xaa
80106566:	e9 0f f3 ff ff       	jmp    8010587a <alltraps>

8010656b <vector171>:
8010656b:	6a 00                	push   $0x0
8010656d:	68 ab 00 00 00       	push   $0xab
80106572:	e9 03 f3 ff ff       	jmp    8010587a <alltraps>

80106577 <vector172>:
80106577:	6a 00                	push   $0x0
80106579:	68 ac 00 00 00       	push   $0xac
8010657e:	e9 f7 f2 ff ff       	jmp    8010587a <alltraps>

80106583 <vector173>:
80106583:	6a 00                	push   $0x0
80106585:	68 ad 00 00 00       	push   $0xad
8010658a:	e9 eb f2 ff ff       	jmp    8010587a <alltraps>

8010658f <vector174>:
8010658f:	6a 00                	push   $0x0
80106591:	68 ae 00 00 00       	push   $0xae
80106596:	e9 df f2 ff ff       	jmp    8010587a <alltraps>

8010659b <vector175>:
8010659b:	6a 00                	push   $0x0
8010659d:	68 af 00 00 00       	push   $0xaf
801065a2:	e9 d3 f2 ff ff       	jmp    8010587a <alltraps>

801065a7 <vector176>:
801065a7:	6a 00                	push   $0x0
801065a9:	68 b0 00 00 00       	push   $0xb0
801065ae:	e9 c7 f2 ff ff       	jmp    8010587a <alltraps>

801065b3 <vector177>:
801065b3:	6a 00                	push   $0x0
801065b5:	68 b1 00 00 00       	push   $0xb1
801065ba:	e9 bb f2 ff ff       	jmp    8010587a <alltraps>

801065bf <vector178>:
801065bf:	6a 00                	push   $0x0
801065c1:	68 b2 00 00 00       	push   $0xb2
801065c6:	e9 af f2 ff ff       	jmp    8010587a <alltraps>

801065cb <vector179>:
801065cb:	6a 00                	push   $0x0
801065cd:	68 b3 00 00 00       	push   $0xb3
801065d2:	e9 a3 f2 ff ff       	jmp    8010587a <alltraps>

801065d7 <vector180>:
801065d7:	6a 00                	push   $0x0
801065d9:	68 b4 00 00 00       	push   $0xb4
801065de:	e9 97 f2 ff ff       	jmp    8010587a <alltraps>

801065e3 <vector181>:
801065e3:	6a 00                	push   $0x0
801065e5:	68 b5 00 00 00       	push   $0xb5
801065ea:	e9 8b f2 ff ff       	jmp    8010587a <alltraps>

801065ef <vector182>:
801065ef:	6a 00                	push   $0x0
801065f1:	68 b6 00 00 00       	push   $0xb6
801065f6:	e9 7f f2 ff ff       	jmp    8010587a <alltraps>

801065fb <vector183>:
801065fb:	6a 00                	push   $0x0
801065fd:	68 b7 00 00 00       	push   $0xb7
80106602:	e9 73 f2 ff ff       	jmp    8010587a <alltraps>

80106607 <vector184>:
80106607:	6a 00                	push   $0x0
80106609:	68 b8 00 00 00       	push   $0xb8
8010660e:	e9 67 f2 ff ff       	jmp    8010587a <alltraps>

80106613 <vector185>:
80106613:	6a 00                	push   $0x0
80106615:	68 b9 00 00 00       	push   $0xb9
8010661a:	e9 5b f2 ff ff       	jmp    8010587a <alltraps>

8010661f <vector186>:
8010661f:	6a 00                	push   $0x0
80106621:	68 ba 00 00 00       	push   $0xba
80106626:	e9 4f f2 ff ff       	jmp    8010587a <alltraps>

8010662b <vector187>:
8010662b:	6a 00                	push   $0x0
8010662d:	68 bb 00 00 00       	push   $0xbb
80106632:	e9 43 f2 ff ff       	jmp    8010587a <alltraps>

80106637 <vector188>:
80106637:	6a 00                	push   $0x0
80106639:	68 bc 00 00 00       	push   $0xbc
8010663e:	e9 37 f2 ff ff       	jmp    8010587a <alltraps>

80106643 <vector189>:
80106643:	6a 00                	push   $0x0
80106645:	68 bd 00 00 00       	push   $0xbd
8010664a:	e9 2b f2 ff ff       	jmp    8010587a <alltraps>

8010664f <vector190>:
8010664f:	6a 00                	push   $0x0
80106651:	68 be 00 00 00       	push   $0xbe
80106656:	e9 1f f2 ff ff       	jmp    8010587a <alltraps>

8010665b <vector191>:
8010665b:	6a 00                	push   $0x0
8010665d:	68 bf 00 00 00       	push   $0xbf
80106662:	e9 13 f2 ff ff       	jmp    8010587a <alltraps>

80106667 <vector192>:
80106667:	6a 00                	push   $0x0
80106669:	68 c0 00 00 00       	push   $0xc0
8010666e:	e9 07 f2 ff ff       	jmp    8010587a <alltraps>

80106673 <vector193>:
80106673:	6a 00                	push   $0x0
80106675:	68 c1 00 00 00       	push   $0xc1
8010667a:	e9 fb f1 ff ff       	jmp    8010587a <alltraps>

8010667f <vector194>:
8010667f:	6a 00                	push   $0x0
80106681:	68 c2 00 00 00       	push   $0xc2
80106686:	e9 ef f1 ff ff       	jmp    8010587a <alltraps>

8010668b <vector195>:
8010668b:	6a 00                	push   $0x0
8010668d:	68 c3 00 00 00       	push   $0xc3
80106692:	e9 e3 f1 ff ff       	jmp    8010587a <alltraps>

80106697 <vector196>:
80106697:	6a 00                	push   $0x0
80106699:	68 c4 00 00 00       	push   $0xc4
8010669e:	e9 d7 f1 ff ff       	jmp    8010587a <alltraps>

801066a3 <vector197>:
801066a3:	6a 00                	push   $0x0
801066a5:	68 c5 00 00 00       	push   $0xc5
801066aa:	e9 cb f1 ff ff       	jmp    8010587a <alltraps>

801066af <vector198>:
801066af:	6a 00                	push   $0x0
801066b1:	68 c6 00 00 00       	push   $0xc6
801066b6:	e9 bf f1 ff ff       	jmp    8010587a <alltraps>

801066bb <vector199>:
801066bb:	6a 00                	push   $0x0
801066bd:	68 c7 00 00 00       	push   $0xc7
801066c2:	e9 b3 f1 ff ff       	jmp    8010587a <alltraps>

801066c7 <vector200>:
801066c7:	6a 00                	push   $0x0
801066c9:	68 c8 00 00 00       	push   $0xc8
801066ce:	e9 a7 f1 ff ff       	jmp    8010587a <alltraps>

801066d3 <vector201>:
801066d3:	6a 00                	push   $0x0
801066d5:	68 c9 00 00 00       	push   $0xc9
801066da:	e9 9b f1 ff ff       	jmp    8010587a <alltraps>

801066df <vector202>:
801066df:	6a 00                	push   $0x0
801066e1:	68 ca 00 00 00       	push   $0xca
801066e6:	e9 8f f1 ff ff       	jmp    8010587a <alltraps>

801066eb <vector203>:
801066eb:	6a 00                	push   $0x0
801066ed:	68 cb 00 00 00       	push   $0xcb
801066f2:	e9 83 f1 ff ff       	jmp    8010587a <alltraps>

801066f7 <vector204>:
801066f7:	6a 00                	push   $0x0
801066f9:	68 cc 00 00 00       	push   $0xcc
801066fe:	e9 77 f1 ff ff       	jmp    8010587a <alltraps>

80106703 <vector205>:
80106703:	6a 00                	push   $0x0
80106705:	68 cd 00 00 00       	push   $0xcd
8010670a:	e9 6b f1 ff ff       	jmp    8010587a <alltraps>

8010670f <vector206>:
8010670f:	6a 00                	push   $0x0
80106711:	68 ce 00 00 00       	push   $0xce
80106716:	e9 5f f1 ff ff       	jmp    8010587a <alltraps>

8010671b <vector207>:
8010671b:	6a 00                	push   $0x0
8010671d:	68 cf 00 00 00       	push   $0xcf
80106722:	e9 53 f1 ff ff       	jmp    8010587a <alltraps>

80106727 <vector208>:
80106727:	6a 00                	push   $0x0
80106729:	68 d0 00 00 00       	push   $0xd0
8010672e:	e9 47 f1 ff ff       	jmp    8010587a <alltraps>

80106733 <vector209>:
80106733:	6a 00                	push   $0x0
80106735:	68 d1 00 00 00       	push   $0xd1
8010673a:	e9 3b f1 ff ff       	jmp    8010587a <alltraps>

8010673f <vector210>:
8010673f:	6a 00                	push   $0x0
80106741:	68 d2 00 00 00       	push   $0xd2
80106746:	e9 2f f1 ff ff       	jmp    8010587a <alltraps>

8010674b <vector211>:
8010674b:	6a 00                	push   $0x0
8010674d:	68 d3 00 00 00       	push   $0xd3
80106752:	e9 23 f1 ff ff       	jmp    8010587a <alltraps>

80106757 <vector212>:
80106757:	6a 00                	push   $0x0
80106759:	68 d4 00 00 00       	push   $0xd4
8010675e:	e9 17 f1 ff ff       	jmp    8010587a <alltraps>

80106763 <vector213>:
80106763:	6a 00                	push   $0x0
80106765:	68 d5 00 00 00       	push   $0xd5
8010676a:	e9 0b f1 ff ff       	jmp    8010587a <alltraps>

8010676f <vector214>:
8010676f:	6a 00                	push   $0x0
80106771:	68 d6 00 00 00       	push   $0xd6
80106776:	e9 ff f0 ff ff       	jmp    8010587a <alltraps>

8010677b <vector215>:
8010677b:	6a 00                	push   $0x0
8010677d:	68 d7 00 00 00       	push   $0xd7
80106782:	e9 f3 f0 ff ff       	jmp    8010587a <alltraps>

80106787 <vector216>:
80106787:	6a 00                	push   $0x0
80106789:	68 d8 00 00 00       	push   $0xd8
8010678e:	e9 e7 f0 ff ff       	jmp    8010587a <alltraps>

80106793 <vector217>:
80106793:	6a 00                	push   $0x0
80106795:	68 d9 00 00 00       	push   $0xd9
8010679a:	e9 db f0 ff ff       	jmp    8010587a <alltraps>

8010679f <vector218>:
8010679f:	6a 00                	push   $0x0
801067a1:	68 da 00 00 00       	push   $0xda
801067a6:	e9 cf f0 ff ff       	jmp    8010587a <alltraps>

801067ab <vector219>:
801067ab:	6a 00                	push   $0x0
801067ad:	68 db 00 00 00       	push   $0xdb
801067b2:	e9 c3 f0 ff ff       	jmp    8010587a <alltraps>

801067b7 <vector220>:
801067b7:	6a 00                	push   $0x0
801067b9:	68 dc 00 00 00       	push   $0xdc
801067be:	e9 b7 f0 ff ff       	jmp    8010587a <alltraps>

801067c3 <vector221>:
801067c3:	6a 00                	push   $0x0
801067c5:	68 dd 00 00 00       	push   $0xdd
801067ca:	e9 ab f0 ff ff       	jmp    8010587a <alltraps>

801067cf <vector222>:
801067cf:	6a 00                	push   $0x0
801067d1:	68 de 00 00 00       	push   $0xde
801067d6:	e9 9f f0 ff ff       	jmp    8010587a <alltraps>

801067db <vector223>:
801067db:	6a 00                	push   $0x0
801067dd:	68 df 00 00 00       	push   $0xdf
801067e2:	e9 93 f0 ff ff       	jmp    8010587a <alltraps>

801067e7 <vector224>:
801067e7:	6a 00                	push   $0x0
801067e9:	68 e0 00 00 00       	push   $0xe0
801067ee:	e9 87 f0 ff ff       	jmp    8010587a <alltraps>

801067f3 <vector225>:
801067f3:	6a 00                	push   $0x0
801067f5:	68 e1 00 00 00       	push   $0xe1
801067fa:	e9 7b f0 ff ff       	jmp    8010587a <alltraps>

801067ff <vector226>:
801067ff:	6a 00                	push   $0x0
80106801:	68 e2 00 00 00       	push   $0xe2
80106806:	e9 6f f0 ff ff       	jmp    8010587a <alltraps>

8010680b <vector227>:
8010680b:	6a 00                	push   $0x0
8010680d:	68 e3 00 00 00       	push   $0xe3
80106812:	e9 63 f0 ff ff       	jmp    8010587a <alltraps>

80106817 <vector228>:
80106817:	6a 00                	push   $0x0
80106819:	68 e4 00 00 00       	push   $0xe4
8010681e:	e9 57 f0 ff ff       	jmp    8010587a <alltraps>

80106823 <vector229>:
80106823:	6a 00                	push   $0x0
80106825:	68 e5 00 00 00       	push   $0xe5
8010682a:	e9 4b f0 ff ff       	jmp    8010587a <alltraps>

8010682f <vector230>:
8010682f:	6a 00                	push   $0x0
80106831:	68 e6 00 00 00       	push   $0xe6
80106836:	e9 3f f0 ff ff       	jmp    8010587a <alltraps>

8010683b <vector231>:
8010683b:	6a 00                	push   $0x0
8010683d:	68 e7 00 00 00       	push   $0xe7
80106842:	e9 33 f0 ff ff       	jmp    8010587a <alltraps>

80106847 <vector232>:
80106847:	6a 00                	push   $0x0
80106849:	68 e8 00 00 00       	push   $0xe8
8010684e:	e9 27 f0 ff ff       	jmp    8010587a <alltraps>

80106853 <vector233>:
80106853:	6a 00                	push   $0x0
80106855:	68 e9 00 00 00       	push   $0xe9
8010685a:	e9 1b f0 ff ff       	jmp    8010587a <alltraps>

8010685f <vector234>:
8010685f:	6a 00                	push   $0x0
80106861:	68 ea 00 00 00       	push   $0xea
80106866:	e9 0f f0 ff ff       	jmp    8010587a <alltraps>

8010686b <vector235>:
8010686b:	6a 00                	push   $0x0
8010686d:	68 eb 00 00 00       	push   $0xeb
80106872:	e9 03 f0 ff ff       	jmp    8010587a <alltraps>

80106877 <vector236>:
80106877:	6a 00                	push   $0x0
80106879:	68 ec 00 00 00       	push   $0xec
8010687e:	e9 f7 ef ff ff       	jmp    8010587a <alltraps>

80106883 <vector237>:
80106883:	6a 00                	push   $0x0
80106885:	68 ed 00 00 00       	push   $0xed
8010688a:	e9 eb ef ff ff       	jmp    8010587a <alltraps>

8010688f <vector238>:
8010688f:	6a 00                	push   $0x0
80106891:	68 ee 00 00 00       	push   $0xee
80106896:	e9 df ef ff ff       	jmp    8010587a <alltraps>

8010689b <vector239>:
8010689b:	6a 00                	push   $0x0
8010689d:	68 ef 00 00 00       	push   $0xef
801068a2:	e9 d3 ef ff ff       	jmp    8010587a <alltraps>

801068a7 <vector240>:
801068a7:	6a 00                	push   $0x0
801068a9:	68 f0 00 00 00       	push   $0xf0
801068ae:	e9 c7 ef ff ff       	jmp    8010587a <alltraps>

801068b3 <vector241>:
801068b3:	6a 00                	push   $0x0
801068b5:	68 f1 00 00 00       	push   $0xf1
801068ba:	e9 bb ef ff ff       	jmp    8010587a <alltraps>

801068bf <vector242>:
801068bf:	6a 00                	push   $0x0
801068c1:	68 f2 00 00 00       	push   $0xf2
801068c6:	e9 af ef ff ff       	jmp    8010587a <alltraps>

801068cb <vector243>:
801068cb:	6a 00                	push   $0x0
801068cd:	68 f3 00 00 00       	push   $0xf3
801068d2:	e9 a3 ef ff ff       	jmp    8010587a <alltraps>

801068d7 <vector244>:
801068d7:	6a 00                	push   $0x0
801068d9:	68 f4 00 00 00       	push   $0xf4
801068de:	e9 97 ef ff ff       	jmp    8010587a <alltraps>

801068e3 <vector245>:
801068e3:	6a 00                	push   $0x0
801068e5:	68 f5 00 00 00       	push   $0xf5
801068ea:	e9 8b ef ff ff       	jmp    8010587a <alltraps>

801068ef <vector246>:
801068ef:	6a 00                	push   $0x0
801068f1:	68 f6 00 00 00       	push   $0xf6
801068f6:	e9 7f ef ff ff       	jmp    8010587a <alltraps>

801068fb <vector247>:
801068fb:	6a 00                	push   $0x0
801068fd:	68 f7 00 00 00       	push   $0xf7
80106902:	e9 73 ef ff ff       	jmp    8010587a <alltraps>

80106907 <vector248>:
80106907:	6a 00                	push   $0x0
80106909:	68 f8 00 00 00       	push   $0xf8
8010690e:	e9 67 ef ff ff       	jmp    8010587a <alltraps>

80106913 <vector249>:
80106913:	6a 00                	push   $0x0
80106915:	68 f9 00 00 00       	push   $0xf9
8010691a:	e9 5b ef ff ff       	jmp    8010587a <alltraps>

8010691f <vector250>:
8010691f:	6a 00                	push   $0x0
80106921:	68 fa 00 00 00       	push   $0xfa
80106926:	e9 4f ef ff ff       	jmp    8010587a <alltraps>

8010692b <vector251>:
8010692b:	6a 00                	push   $0x0
8010692d:	68 fb 00 00 00       	push   $0xfb
80106932:	e9 43 ef ff ff       	jmp    8010587a <alltraps>

80106937 <vector252>:
80106937:	6a 00                	push   $0x0
80106939:	68 fc 00 00 00       	push   $0xfc
8010693e:	e9 37 ef ff ff       	jmp    8010587a <alltraps>

80106943 <vector253>:
80106943:	6a 00                	push   $0x0
80106945:	68 fd 00 00 00       	push   $0xfd
8010694a:	e9 2b ef ff ff       	jmp    8010587a <alltraps>

8010694f <vector254>:
8010694f:	6a 00                	push   $0x0
80106951:	68 fe 00 00 00       	push   $0xfe
80106956:	e9 1f ef ff ff       	jmp    8010587a <alltraps>

8010695b <vector255>:
8010695b:	6a 00                	push   $0x0
8010695d:	68 ff 00 00 00       	push   $0xff
80106962:	e9 13 ef ff ff       	jmp    8010587a <alltraps>
80106967:	66 90                	xchg   %ax,%ax
80106969:	66 90                	xchg   %ax,%ax
8010696b:	66 90                	xchg   %ax,%ax
8010696d:	66 90                	xchg   %ax,%ax
8010696f:	90                   	nop

80106970 <deallocuvm.part.0>:
80106970:	55                   	push   %ebp
80106971:	89 e5                	mov    %esp,%ebp
80106973:	57                   	push   %edi
80106974:	56                   	push   %esi
80106975:	53                   	push   %ebx
80106976:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010697c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106982:	83 ec 1c             	sub    $0x1c,%esp
80106985:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106988:	39 d3                	cmp    %edx,%ebx
8010698a:	73 49                	jae    801069d5 <deallocuvm.part.0+0x65>
8010698c:	89 c7                	mov    %eax,%edi
8010698e:	eb 0c                	jmp    8010699c <deallocuvm.part.0+0x2c>
80106990:	83 c0 01             	add    $0x1,%eax
80106993:	c1 e0 16             	shl    $0x16,%eax
80106996:	89 c3                	mov    %eax,%ebx
80106998:	39 da                	cmp    %ebx,%edx
8010699a:	76 39                	jbe    801069d5 <deallocuvm.part.0+0x65>
8010699c:	89 d8                	mov    %ebx,%eax
8010699e:	c1 e8 16             	shr    $0x16,%eax
801069a1:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
801069a4:	f6 c1 01             	test   $0x1,%cl
801069a7:	74 e7                	je     80106990 <deallocuvm.part.0+0x20>
801069a9:	89 de                	mov    %ebx,%esi
801069ab:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
801069b1:	c1 ee 0a             	shr    $0xa,%esi
801069b4:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
801069ba:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
801069c1:	85 f6                	test   %esi,%esi
801069c3:	74 cb                	je     80106990 <deallocuvm.part.0+0x20>
801069c5:	8b 06                	mov    (%esi),%eax
801069c7:	a8 01                	test   $0x1,%al
801069c9:	75 15                	jne    801069e0 <deallocuvm.part.0+0x70>
801069cb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801069d1:	39 da                	cmp    %ebx,%edx
801069d3:	77 c7                	ja     8010699c <deallocuvm.part.0+0x2c>
801069d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801069d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069db:	5b                   	pop    %ebx
801069dc:	5e                   	pop    %esi
801069dd:	5f                   	pop    %edi
801069de:	5d                   	pop    %ebp
801069df:	c3                   	ret    
801069e0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801069e5:	74 25                	je     80106a0c <deallocuvm.part.0+0x9c>
801069e7:	83 ec 0c             	sub    $0xc,%esp
801069ea:	05 00 00 00 80       	add    $0x80000000,%eax
801069ef:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801069f2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801069f8:	50                   	push   %eax
801069f9:	e8 c2 ba ff ff       	call   801024c0 <kfree>
801069fe:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80106a04:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106a07:	83 c4 10             	add    $0x10,%esp
80106a0a:	eb 8c                	jmp    80106998 <deallocuvm.part.0+0x28>
80106a0c:	83 ec 0c             	sub    $0xc,%esp
80106a0f:	68 46 7c 10 80       	push   $0x80107c46
80106a14:	e8 67 99 ff ff       	call   80100380 <panic>
80106a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a20 <seginit>:
80106a20:	55                   	push   %ebp
80106a21:	89 e5                	mov    %esp,%ebp
80106a23:	83 ec 18             	sub    $0x18,%esp
80106a26:	e8 65 cf ff ff       	call   80103990 <cpuid>
80106a2b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106a30:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106a36:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80106a3a:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
80106a41:	ff 00 00 
80106a44:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
80106a4b:	9a cf 00 
80106a4e:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
80106a55:	ff 00 00 
80106a58:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
80106a5f:	92 cf 00 
80106a62:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
80106a69:	ff 00 00 
80106a6c:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
80106a73:	fa cf 00 
80106a76:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
80106a7d:	ff 00 00 
80106a80:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
80106a87:	f2 cf 00 
80106a8a:	05 10 28 11 80       	add    $0x80112810,%eax
80106a8f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
80106a93:	c1 e8 10             	shr    $0x10,%eax
80106a96:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
80106a9a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106a9d:	0f 01 10             	lgdtl  (%eax)
80106aa0:	c9                   	leave  
80106aa1:	c3                   	ret    
80106aa2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ab0 <walkpgdir>:
80106ab0:	55                   	push   %ebp
80106ab1:	89 e5                	mov    %esp,%ebp
80106ab3:	57                   	push   %edi
80106ab4:	56                   	push   %esi
80106ab5:	53                   	push   %ebx
80106ab6:	83 ec 0c             	sub    $0xc,%esp
80106ab9:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106abc:	8b 55 08             	mov    0x8(%ebp),%edx
80106abf:	89 fe                	mov    %edi,%esi
80106ac1:	c1 ee 16             	shr    $0x16,%esi
80106ac4:	8d 34 b2             	lea    (%edx,%esi,4),%esi
80106ac7:	8b 1e                	mov    (%esi),%ebx
80106ac9:	f6 c3 01             	test   $0x1,%bl
80106acc:	74 22                	je     80106af0 <walkpgdir+0x40>
80106ace:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106ad4:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106ada:	89 f8                	mov    %edi,%eax
80106adc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106adf:	c1 e8 0a             	shr    $0xa,%eax
80106ae2:	25 fc 0f 00 00       	and    $0xffc,%eax
80106ae7:	01 d8                	add    %ebx,%eax
80106ae9:	5b                   	pop    %ebx
80106aea:	5e                   	pop    %esi
80106aeb:	5f                   	pop    %edi
80106aec:	5d                   	pop    %ebp
80106aed:	c3                   	ret    
80106aee:	66 90                	xchg   %ax,%ax
80106af0:	8b 45 10             	mov    0x10(%ebp),%eax
80106af3:	85 c0                	test   %eax,%eax
80106af5:	74 31                	je     80106b28 <walkpgdir+0x78>
80106af7:	e8 84 bb ff ff       	call   80102680 <kalloc>
80106afc:	89 c3                	mov    %eax,%ebx
80106afe:	85 c0                	test   %eax,%eax
80106b00:	74 26                	je     80106b28 <walkpgdir+0x78>
80106b02:	83 ec 04             	sub    $0x4,%esp
80106b05:	68 00 10 00 00       	push   $0x1000
80106b0a:	6a 00                	push   $0x0
80106b0c:	50                   	push   %eax
80106b0d:	e8 8e db ff ff       	call   801046a0 <memset>
80106b12:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b18:	83 c4 10             	add    $0x10,%esp
80106b1b:	83 c8 07             	or     $0x7,%eax
80106b1e:	89 06                	mov    %eax,(%esi)
80106b20:	eb b8                	jmp    80106ada <walkpgdir+0x2a>
80106b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b2b:	31 c0                	xor    %eax,%eax
80106b2d:	5b                   	pop    %ebx
80106b2e:	5e                   	pop    %esi
80106b2f:	5f                   	pop    %edi
80106b30:	5d                   	pop    %ebp
80106b31:	c3                   	ret    
80106b32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106b40 <mappages>:
80106b40:	55                   	push   %ebp
80106b41:	89 e5                	mov    %esp,%ebp
80106b43:	57                   	push   %edi
80106b44:	56                   	push   %esi
80106b45:	53                   	push   %ebx
80106b46:	83 ec 1c             	sub    $0x1c,%esp
80106b49:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b4c:	8b 55 10             	mov    0x10(%ebp),%edx
80106b4f:	89 c3                	mov    %eax,%ebx
80106b51:	8d 44 10 ff          	lea    -0x1(%eax,%edx,1),%eax
80106b55:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106b5a:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106b60:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106b63:	8b 45 14             	mov    0x14(%ebp),%eax
80106b66:	29 d8                	sub    %ebx,%eax
80106b68:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b6b:	eb 3a                	jmp    80106ba7 <mappages+0x67>
80106b6d:	8d 76 00             	lea    0x0(%esi),%esi
80106b70:	89 da                	mov    %ebx,%edx
80106b72:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106b77:	c1 ea 0a             	shr    $0xa,%edx
80106b7a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106b80:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
80106b87:	85 c0                	test   %eax,%eax
80106b89:	74 75                	je     80106c00 <mappages+0xc0>
80106b8b:	f6 00 01             	testb  $0x1,(%eax)
80106b8e:	0f 85 86 00 00 00    	jne    80106c1a <mappages+0xda>
80106b94:	0b 75 18             	or     0x18(%ebp),%esi
80106b97:	83 ce 01             	or     $0x1,%esi
80106b9a:	89 30                	mov    %esi,(%eax)
80106b9c:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80106b9f:	74 6f                	je     80106c10 <mappages+0xd0>
80106ba1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106ba7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106baa:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106bad:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80106bb0:	89 d8                	mov    %ebx,%eax
80106bb2:	c1 e8 16             	shr    $0x16,%eax
80106bb5:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
80106bb8:	8b 07                	mov    (%edi),%eax
80106bba:	a8 01                	test   $0x1,%al
80106bbc:	75 b2                	jne    80106b70 <mappages+0x30>
80106bbe:	e8 bd ba ff ff       	call   80102680 <kalloc>
80106bc3:	85 c0                	test   %eax,%eax
80106bc5:	74 39                	je     80106c00 <mappages+0xc0>
80106bc7:	83 ec 04             	sub    $0x4,%esp
80106bca:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106bcd:	68 00 10 00 00       	push   $0x1000
80106bd2:	6a 00                	push   $0x0
80106bd4:	50                   	push   %eax
80106bd5:	e8 c6 da ff ff       	call   801046a0 <memset>
80106bda:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106bdd:	83 c4 10             	add    $0x10,%esp
80106be0:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106be6:	83 c8 07             	or     $0x7,%eax
80106be9:	89 07                	mov    %eax,(%edi)
80106beb:	89 d8                	mov    %ebx,%eax
80106bed:	c1 e8 0a             	shr    $0xa,%eax
80106bf0:	25 fc 0f 00 00       	and    $0xffc,%eax
80106bf5:	01 d0                	add    %edx,%eax
80106bf7:	eb 92                	jmp    80106b8b <mappages+0x4b>
80106bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c00:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c03:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c08:	5b                   	pop    %ebx
80106c09:	5e                   	pop    %esi
80106c0a:	5f                   	pop    %edi
80106c0b:	5d                   	pop    %ebp
80106c0c:	c3                   	ret    
80106c0d:	8d 76 00             	lea    0x0(%esi),%esi
80106c10:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c13:	31 c0                	xor    %eax,%eax
80106c15:	5b                   	pop    %ebx
80106c16:	5e                   	pop    %esi
80106c17:	5f                   	pop    %edi
80106c18:	5d                   	pop    %ebp
80106c19:	c3                   	ret    
80106c1a:	83 ec 0c             	sub    $0xc,%esp
80106c1d:	68 30 83 10 80       	push   $0x80108330
80106c22:	e8 59 97 ff ff       	call   80100380 <panic>
80106c27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c2e:	66 90                	xchg   %ax,%ax

80106c30 <switchkvm>:
80106c30:	a1 c4 96 12 80       	mov    0x801296c4,%eax
80106c35:	05 00 00 00 80       	add    $0x80000000,%eax
80106c3a:	0f 22 d8             	mov    %eax,%cr3
80106c3d:	c3                   	ret    
80106c3e:	66 90                	xchg   %ax,%ax

80106c40 <switchuvm>:
80106c40:	55                   	push   %ebp
80106c41:	89 e5                	mov    %esp,%ebp
80106c43:	57                   	push   %edi
80106c44:	56                   	push   %esi
80106c45:	53                   	push   %ebx
80106c46:	83 ec 1c             	sub    $0x1c,%esp
80106c49:	8b 75 08             	mov    0x8(%ebp),%esi
80106c4c:	85 f6                	test   %esi,%esi
80106c4e:	0f 84 cb 00 00 00    	je     80106d1f <switchuvm+0xdf>
80106c54:	8b 46 08             	mov    0x8(%esi),%eax
80106c57:	85 c0                	test   %eax,%eax
80106c59:	0f 84 da 00 00 00    	je     80106d39 <switchuvm+0xf9>
80106c5f:	8b 46 04             	mov    0x4(%esi),%eax
80106c62:	85 c0                	test   %eax,%eax
80106c64:	0f 84 c2 00 00 00    	je     80106d2c <switchuvm+0xec>
80106c6a:	e8 21 d8 ff ff       	call   80104490 <pushcli>
80106c6f:	e8 bc cc ff ff       	call   80103930 <mycpu>
80106c74:	89 c3                	mov    %eax,%ebx
80106c76:	e8 b5 cc ff ff       	call   80103930 <mycpu>
80106c7b:	89 c7                	mov    %eax,%edi
80106c7d:	e8 ae cc ff ff       	call   80103930 <mycpu>
80106c82:	83 c7 08             	add    $0x8,%edi
80106c85:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106c88:	e8 a3 cc ff ff       	call   80103930 <mycpu>
80106c8d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106c90:	ba 67 00 00 00       	mov    $0x67,%edx
80106c95:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106c9c:	83 c0 08             	add    $0x8,%eax
80106c9f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106ca6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80106cab:	83 c1 08             	add    $0x8,%ecx
80106cae:	c1 e8 18             	shr    $0x18,%eax
80106cb1:	c1 e9 10             	shr    $0x10,%ecx
80106cb4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106cba:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106cc0:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106cc5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
80106ccc:	bb 10 00 00 00       	mov    $0x10,%ebx
80106cd1:	e8 5a cc ff ff       	call   80103930 <mycpu>
80106cd6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
80106cdd:	e8 4e cc ff ff       	call   80103930 <mycpu>
80106ce2:	66 89 58 10          	mov    %bx,0x10(%eax)
80106ce6:	8b 5e 08             	mov    0x8(%esi),%ebx
80106ce9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106cef:	e8 3c cc ff ff       	call   80103930 <mycpu>
80106cf4:	89 58 0c             	mov    %ebx,0xc(%eax)
80106cf7:	e8 34 cc ff ff       	call   80103930 <mycpu>
80106cfc:	66 89 78 6e          	mov    %di,0x6e(%eax)
80106d00:	b8 28 00 00 00       	mov    $0x28,%eax
80106d05:	0f 00 d8             	ltr    %ax
80106d08:	8b 46 04             	mov    0x4(%esi),%eax
80106d0b:	05 00 00 00 80       	add    $0x80000000,%eax
80106d10:	0f 22 d8             	mov    %eax,%cr3
80106d13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d16:	5b                   	pop    %ebx
80106d17:	5e                   	pop    %esi
80106d18:	5f                   	pop    %edi
80106d19:	5d                   	pop    %ebp
80106d1a:	e9 c1 d7 ff ff       	jmp    801044e0 <popcli>
80106d1f:	83 ec 0c             	sub    $0xc,%esp
80106d22:	68 36 83 10 80       	push   $0x80108336
80106d27:	e8 54 96 ff ff       	call   80100380 <panic>
80106d2c:	83 ec 0c             	sub    $0xc,%esp
80106d2f:	68 61 83 10 80       	push   $0x80108361
80106d34:	e8 47 96 ff ff       	call   80100380 <panic>
80106d39:	83 ec 0c             	sub    $0xc,%esp
80106d3c:	68 4c 83 10 80       	push   $0x8010834c
80106d41:	e8 3a 96 ff ff       	call   80100380 <panic>
80106d46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d4d:	8d 76 00             	lea    0x0(%esi),%esi

80106d50 <inituvm>:
80106d50:	55                   	push   %ebp
80106d51:	89 e5                	mov    %esp,%ebp
80106d53:	57                   	push   %edi
80106d54:	56                   	push   %esi
80106d55:	53                   	push   %ebx
80106d56:	83 ec 1c             	sub    $0x1c,%esp
80106d59:	8b 75 10             	mov    0x10(%ebp),%esi
80106d5c:	8b 55 08             	mov    0x8(%ebp),%edx
80106d5f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106d62:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106d68:	77 50                	ja     80106dba <inituvm+0x6a>
80106d6a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106d6d:	e8 0e b9 ff ff       	call   80102680 <kalloc>
80106d72:	83 ec 04             	sub    $0x4,%esp
80106d75:	68 00 10 00 00       	push   $0x1000
80106d7a:	89 c3                	mov    %eax,%ebx
80106d7c:	6a 00                	push   $0x0
80106d7e:	50                   	push   %eax
80106d7f:	e8 1c d9 ff ff       	call   801046a0 <memset>
80106d84:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106d87:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106d8d:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
80106d94:	50                   	push   %eax
80106d95:	68 00 10 00 00       	push   $0x1000
80106d9a:	6a 00                	push   $0x0
80106d9c:	52                   	push   %edx
80106d9d:	e8 9e fd ff ff       	call   80106b40 <mappages>
80106da2:	89 75 10             	mov    %esi,0x10(%ebp)
80106da5:	83 c4 20             	add    $0x20,%esp
80106da8:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106dab:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106dae:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106db1:	5b                   	pop    %ebx
80106db2:	5e                   	pop    %esi
80106db3:	5f                   	pop    %edi
80106db4:	5d                   	pop    %ebp
80106db5:	e9 86 d9 ff ff       	jmp    80104740 <memmove>
80106dba:	83 ec 0c             	sub    $0xc,%esp
80106dbd:	68 75 83 10 80       	push   $0x80108375
80106dc2:	e8 b9 95 ff ff       	call   80100380 <panic>
80106dc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106dce:	66 90                	xchg   %ax,%ax

80106dd0 <loaduvm>:
80106dd0:	55                   	push   %ebp
80106dd1:	89 e5                	mov    %esp,%ebp
80106dd3:	57                   	push   %edi
80106dd4:	56                   	push   %esi
80106dd5:	53                   	push   %ebx
80106dd6:	83 ec 1c             	sub    $0x1c,%esp
80106dd9:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ddc:	8b 75 18             	mov    0x18(%ebp),%esi
80106ddf:	a9 ff 0f 00 00       	test   $0xfff,%eax
80106de4:	0f 85 bb 00 00 00    	jne    80106ea5 <loaduvm+0xd5>
80106dea:	01 f0                	add    %esi,%eax
80106dec:	89 f3                	mov    %esi,%ebx
80106dee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106df1:	8b 45 14             	mov    0x14(%ebp),%eax
80106df4:	01 f0                	add    %esi,%eax
80106df6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106df9:	85 f6                	test   %esi,%esi
80106dfb:	0f 84 87 00 00 00    	je     80106e88 <loaduvm+0xb8>
80106e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e08:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e0b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106e0e:	29 d8                	sub    %ebx,%eax
80106e10:	89 c2                	mov    %eax,%edx
80106e12:	c1 ea 16             	shr    $0x16,%edx
80106e15:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80106e18:	f6 c2 01             	test   $0x1,%dl
80106e1b:	75 13                	jne    80106e30 <loaduvm+0x60>
80106e1d:	83 ec 0c             	sub    $0xc,%esp
80106e20:	68 8f 83 10 80       	push   $0x8010838f
80106e25:	e8 56 95 ff ff       	call   80100380 <panic>
80106e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e30:	c1 e8 0a             	shr    $0xa,%eax
80106e33:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106e39:	25 fc 0f 00 00       	and    $0xffc,%eax
80106e3e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
80106e45:	85 c0                	test   %eax,%eax
80106e47:	74 d4                	je     80106e1d <loaduvm+0x4d>
80106e49:	8b 00                	mov    (%eax),%eax
80106e4b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80106e4e:	bf 00 10 00 00       	mov    $0x1000,%edi
80106e53:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106e58:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80106e5e:	0f 46 fb             	cmovbe %ebx,%edi
80106e61:	29 d9                	sub    %ebx,%ecx
80106e63:	05 00 00 00 80       	add    $0x80000000,%eax
80106e68:	57                   	push   %edi
80106e69:	51                   	push   %ecx
80106e6a:	50                   	push   %eax
80106e6b:	ff 75 10             	push   0x10(%ebp)
80106e6e:	e8 1d ac ff ff       	call   80101a90 <readi>
80106e73:	83 c4 10             	add    $0x10,%esp
80106e76:	39 f8                	cmp    %edi,%eax
80106e78:	75 1e                	jne    80106e98 <loaduvm+0xc8>
80106e7a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80106e80:	89 f0                	mov    %esi,%eax
80106e82:	29 d8                	sub    %ebx,%eax
80106e84:	39 c6                	cmp    %eax,%esi
80106e86:	77 80                	ja     80106e08 <loaduvm+0x38>
80106e88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e8b:	31 c0                	xor    %eax,%eax
80106e8d:	5b                   	pop    %ebx
80106e8e:	5e                   	pop    %esi
80106e8f:	5f                   	pop    %edi
80106e90:	5d                   	pop    %ebp
80106e91:	c3                   	ret    
80106e92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e9b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106ea0:	5b                   	pop    %ebx
80106ea1:	5e                   	pop    %esi
80106ea2:	5f                   	pop    %edi
80106ea3:	5d                   	pop    %ebp
80106ea4:	c3                   	ret    
80106ea5:	83 ec 0c             	sub    $0xc,%esp
80106ea8:	68 30 84 10 80       	push   $0x80108430
80106ead:	e8 ce 94 ff ff       	call   80100380 <panic>
80106eb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ec0 <allocuvm>:
80106ec0:	55                   	push   %ebp
80106ec1:	89 e5                	mov    %esp,%ebp
80106ec3:	57                   	push   %edi
80106ec4:	56                   	push   %esi
80106ec5:	53                   	push   %ebx
80106ec6:	83 ec 1c             	sub    $0x1c,%esp
80106ec9:	8b 7d 10             	mov    0x10(%ebp),%edi
80106ecc:	85 ff                	test   %edi,%edi
80106ece:	0f 88 bc 00 00 00    	js     80106f90 <allocuvm+0xd0>
80106ed4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106ed7:	0f 82 a3 00 00 00    	jb     80106f80 <allocuvm+0xc0>
80106edd:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ee0:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80106ee6:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80106eec:	39 75 10             	cmp    %esi,0x10(%ebp)
80106eef:	0f 86 8e 00 00 00    	jbe    80106f83 <allocuvm+0xc3>
80106ef5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106ef8:	8b 7d 08             	mov    0x8(%ebp),%edi
80106efb:	eb 43                	jmp    80106f40 <allocuvm+0x80>
80106efd:	8d 76 00             	lea    0x0(%esi),%esi
80106f00:	83 ec 04             	sub    $0x4,%esp
80106f03:	68 00 10 00 00       	push   $0x1000
80106f08:	6a 00                	push   $0x0
80106f0a:	50                   	push   %eax
80106f0b:	e8 90 d7 ff ff       	call   801046a0 <memset>
80106f10:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106f16:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
80106f1d:	50                   	push   %eax
80106f1e:	68 00 10 00 00       	push   $0x1000
80106f23:	56                   	push   %esi
80106f24:	57                   	push   %edi
80106f25:	e8 16 fc ff ff       	call   80106b40 <mappages>
80106f2a:	83 c4 20             	add    $0x20,%esp
80106f2d:	85 c0                	test   %eax,%eax
80106f2f:	78 6f                	js     80106fa0 <allocuvm+0xe0>
80106f31:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106f37:	39 75 10             	cmp    %esi,0x10(%ebp)
80106f3a:	0f 86 a0 00 00 00    	jbe    80106fe0 <allocuvm+0x120>
80106f40:	e8 3b b7 ff ff       	call   80102680 <kalloc>
80106f45:	89 c3                	mov    %eax,%ebx
80106f47:	85 c0                	test   %eax,%eax
80106f49:	75 b5                	jne    80106f00 <allocuvm+0x40>
80106f4b:	83 ec 0c             	sub    $0xc,%esp
80106f4e:	68 ad 83 10 80       	push   $0x801083ad
80106f53:	e8 48 97 ff ff       	call   801006a0 <cprintf>
80106f58:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f5b:	83 c4 10             	add    $0x10,%esp
80106f5e:	39 45 10             	cmp    %eax,0x10(%ebp)
80106f61:	74 2d                	je     80106f90 <allocuvm+0xd0>
80106f63:	8b 55 10             	mov    0x10(%ebp),%edx
80106f66:	89 c1                	mov    %eax,%ecx
80106f68:	8b 45 08             	mov    0x8(%ebp),%eax
80106f6b:	31 ff                	xor    %edi,%edi
80106f6d:	e8 fe f9 ff ff       	call   80106970 <deallocuvm.part.0>
80106f72:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f75:	89 f8                	mov    %edi,%eax
80106f77:	5b                   	pop    %ebx
80106f78:	5e                   	pop    %esi
80106f79:	5f                   	pop    %edi
80106f7a:	5d                   	pop    %ebp
80106f7b:	c3                   	ret    
80106f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106f80:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106f83:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f86:	89 f8                	mov    %edi,%eax
80106f88:	5b                   	pop    %ebx
80106f89:	5e                   	pop    %esi
80106f8a:	5f                   	pop    %edi
80106f8b:	5d                   	pop    %ebp
80106f8c:	c3                   	ret    
80106f8d:	8d 76 00             	lea    0x0(%esi),%esi
80106f90:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f93:	31 ff                	xor    %edi,%edi
80106f95:	5b                   	pop    %ebx
80106f96:	89 f8                	mov    %edi,%eax
80106f98:	5e                   	pop    %esi
80106f99:	5f                   	pop    %edi
80106f9a:	5d                   	pop    %ebp
80106f9b:	c3                   	ret    
80106f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106fa0:	83 ec 0c             	sub    $0xc,%esp
80106fa3:	68 c5 83 10 80       	push   $0x801083c5
80106fa8:	e8 f3 96 ff ff       	call   801006a0 <cprintf>
80106fad:	8b 45 0c             	mov    0xc(%ebp),%eax
80106fb0:	83 c4 10             	add    $0x10,%esp
80106fb3:	39 45 10             	cmp    %eax,0x10(%ebp)
80106fb6:	74 0d                	je     80106fc5 <allocuvm+0x105>
80106fb8:	89 c1                	mov    %eax,%ecx
80106fba:	8b 55 10             	mov    0x10(%ebp),%edx
80106fbd:	8b 45 08             	mov    0x8(%ebp),%eax
80106fc0:	e8 ab f9 ff ff       	call   80106970 <deallocuvm.part.0>
80106fc5:	83 ec 0c             	sub    $0xc,%esp
80106fc8:	31 ff                	xor    %edi,%edi
80106fca:	53                   	push   %ebx
80106fcb:	e8 f0 b4 ff ff       	call   801024c0 <kfree>
80106fd0:	83 c4 10             	add    $0x10,%esp
80106fd3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fd6:	89 f8                	mov    %edi,%eax
80106fd8:	5b                   	pop    %ebx
80106fd9:	5e                   	pop    %esi
80106fda:	5f                   	pop    %edi
80106fdb:	5d                   	pop    %ebp
80106fdc:	c3                   	ret    
80106fdd:	8d 76 00             	lea    0x0(%esi),%esi
80106fe0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106fe3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fe6:	5b                   	pop    %ebx
80106fe7:	5e                   	pop    %esi
80106fe8:	89 f8                	mov    %edi,%eax
80106fea:	5f                   	pop    %edi
80106feb:	5d                   	pop    %ebp
80106fec:	c3                   	ret    
80106fed:	8d 76 00             	lea    0x0(%esi),%esi

80106ff0 <deallocuvm>:
80106ff0:	55                   	push   %ebp
80106ff1:	89 e5                	mov    %esp,%ebp
80106ff3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ff6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106ff9:	8b 45 08             	mov    0x8(%ebp),%eax
80106ffc:	39 d1                	cmp    %edx,%ecx
80106ffe:	73 10                	jae    80107010 <deallocuvm+0x20>
80107000:	5d                   	pop    %ebp
80107001:	e9 6a f9 ff ff       	jmp    80106970 <deallocuvm.part.0>
80107006:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010700d:	8d 76 00             	lea    0x0(%esi),%esi
80107010:	89 d0                	mov    %edx,%eax
80107012:	5d                   	pop    %ebp
80107013:	c3                   	ret    
80107014:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010701b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010701f:	90                   	nop

80107020 <freevm>:
80107020:	55                   	push   %ebp
80107021:	89 e5                	mov    %esp,%ebp
80107023:	57                   	push   %edi
80107024:	56                   	push   %esi
80107025:	53                   	push   %ebx
80107026:	83 ec 0c             	sub    $0xc,%esp
80107029:	8b 75 08             	mov    0x8(%ebp),%esi
8010702c:	85 f6                	test   %esi,%esi
8010702e:	74 59                	je     80107089 <freevm+0x69>
80107030:	31 c9                	xor    %ecx,%ecx
80107032:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107037:	89 f0                	mov    %esi,%eax
80107039:	89 f3                	mov    %esi,%ebx
8010703b:	e8 30 f9 ff ff       	call   80106970 <deallocuvm.part.0>
80107040:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107046:	eb 0f                	jmp    80107057 <freevm+0x37>
80107048:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010704f:	90                   	nop
80107050:	83 c3 04             	add    $0x4,%ebx
80107053:	39 df                	cmp    %ebx,%edi
80107055:	74 23                	je     8010707a <freevm+0x5a>
80107057:	8b 03                	mov    (%ebx),%eax
80107059:	a8 01                	test   $0x1,%al
8010705b:	74 f3                	je     80107050 <freevm+0x30>
8010705d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107062:	83 ec 0c             	sub    $0xc,%esp
80107065:	83 c3 04             	add    $0x4,%ebx
80107068:	05 00 00 00 80       	add    $0x80000000,%eax
8010706d:	50                   	push   %eax
8010706e:	e8 4d b4 ff ff       	call   801024c0 <kfree>
80107073:	83 c4 10             	add    $0x10,%esp
80107076:	39 df                	cmp    %ebx,%edi
80107078:	75 dd                	jne    80107057 <freevm+0x37>
8010707a:	89 75 08             	mov    %esi,0x8(%ebp)
8010707d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107080:	5b                   	pop    %ebx
80107081:	5e                   	pop    %esi
80107082:	5f                   	pop    %edi
80107083:	5d                   	pop    %ebp
80107084:	e9 37 b4 ff ff       	jmp    801024c0 <kfree>
80107089:	83 ec 0c             	sub    $0xc,%esp
8010708c:	68 e1 83 10 80       	push   $0x801083e1
80107091:	e8 ea 92 ff ff       	call   80100380 <panic>
80107096:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010709d:	8d 76 00             	lea    0x0(%esi),%esi

801070a0 <setupkvm>:
801070a0:	55                   	push   %ebp
801070a1:	89 e5                	mov    %esp,%ebp
801070a3:	56                   	push   %esi
801070a4:	53                   	push   %ebx
801070a5:	e8 d6 b5 ff ff       	call   80102680 <kalloc>
801070aa:	89 c6                	mov    %eax,%esi
801070ac:	85 c0                	test   %eax,%eax
801070ae:	74 42                	je     801070f2 <setupkvm+0x52>
801070b0:	83 ec 04             	sub    $0x4,%esp
801070b3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
801070b8:	68 00 10 00 00       	push   $0x1000
801070bd:	6a 00                	push   $0x0
801070bf:	50                   	push   %eax
801070c0:	e8 db d5 ff ff       	call   801046a0 <memset>
801070c5:	83 c4 10             	add    $0x10,%esp
801070c8:	8b 43 04             	mov    0x4(%ebx),%eax
801070cb:	8b 53 08             	mov    0x8(%ebx),%edx
801070ce:	83 ec 0c             	sub    $0xc,%esp
801070d1:	ff 73 0c             	push   0xc(%ebx)
801070d4:	29 c2                	sub    %eax,%edx
801070d6:	50                   	push   %eax
801070d7:	52                   	push   %edx
801070d8:	ff 33                	push   (%ebx)
801070da:	56                   	push   %esi
801070db:	e8 60 fa ff ff       	call   80106b40 <mappages>
801070e0:	83 c4 20             	add    $0x20,%esp
801070e3:	85 c0                	test   %eax,%eax
801070e5:	78 19                	js     80107100 <setupkvm+0x60>
801070e7:	83 c3 10             	add    $0x10,%ebx
801070ea:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801070f0:	75 d6                	jne    801070c8 <setupkvm+0x28>
801070f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801070f5:	89 f0                	mov    %esi,%eax
801070f7:	5b                   	pop    %ebx
801070f8:	5e                   	pop    %esi
801070f9:	5d                   	pop    %ebp
801070fa:	c3                   	ret    
801070fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801070ff:	90                   	nop
80107100:	83 ec 0c             	sub    $0xc,%esp
80107103:	56                   	push   %esi
80107104:	31 f6                	xor    %esi,%esi
80107106:	e8 15 ff ff ff       	call   80107020 <freevm>
8010710b:	83 c4 10             	add    $0x10,%esp
8010710e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107111:	89 f0                	mov    %esi,%eax
80107113:	5b                   	pop    %ebx
80107114:	5e                   	pop    %esi
80107115:	5d                   	pop    %ebp
80107116:	c3                   	ret    
80107117:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010711e:	66 90                	xchg   %ax,%ax

80107120 <kvmalloc>:
80107120:	55                   	push   %ebp
80107121:	89 e5                	mov    %esp,%ebp
80107123:	83 ec 08             	sub    $0x8,%esp
80107126:	e8 75 ff ff ff       	call   801070a0 <setupkvm>
8010712b:	a3 c4 96 12 80       	mov    %eax,0x801296c4
80107130:	05 00 00 00 80       	add    $0x80000000,%eax
80107135:	0f 22 d8             	mov    %eax,%cr3
80107138:	c9                   	leave  
80107139:	c3                   	ret    
8010713a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107140 <clearpteu>:
80107140:	55                   	push   %ebp
80107141:	89 e5                	mov    %esp,%ebp
80107143:	83 ec 08             	sub    $0x8,%esp
80107146:	8b 45 0c             	mov    0xc(%ebp),%eax
80107149:	8b 55 08             	mov    0x8(%ebp),%edx
8010714c:	89 c1                	mov    %eax,%ecx
8010714e:	c1 e9 16             	shr    $0x16,%ecx
80107151:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107154:	f6 c2 01             	test   $0x1,%dl
80107157:	75 17                	jne    80107170 <clearpteu+0x30>
80107159:	83 ec 0c             	sub    $0xc,%esp
8010715c:	68 f2 83 10 80       	push   $0x801083f2
80107161:	e8 1a 92 ff ff       	call   80100380 <panic>
80107166:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010716d:	8d 76 00             	lea    0x0(%esi),%esi
80107170:	c1 e8 0a             	shr    $0xa,%eax
80107173:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107179:	25 fc 0f 00 00       	and    $0xffc,%eax
8010717e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
80107185:	85 c0                	test   %eax,%eax
80107187:	74 d0                	je     80107159 <clearpteu+0x19>
80107189:	83 20 fb             	andl   $0xfffffffb,(%eax)
8010718c:	c9                   	leave  
8010718d:	c3                   	ret    
8010718e:	66 90                	xchg   %ax,%ax

80107190 <copyuvm>:
80107190:	55                   	push   %ebp
80107191:	89 e5                	mov    %esp,%ebp
80107193:	57                   	push   %edi
80107194:	56                   	push   %esi
80107195:	53                   	push   %ebx
80107196:	83 ec 1c             	sub    $0x1c,%esp
80107199:	e8 02 ff ff ff       	call   801070a0 <setupkvm>
8010719e:	89 45 e0             	mov    %eax,-0x20(%ebp)
801071a1:	85 c0                	test   %eax,%eax
801071a3:	0f 84 c0 00 00 00    	je     80107269 <copyuvm+0xd9>
801071a9:	8b 55 0c             	mov    0xc(%ebp),%edx
801071ac:	85 d2                	test   %edx,%edx
801071ae:	0f 84 b5 00 00 00    	je     80107269 <copyuvm+0xd9>
801071b4:	31 f6                	xor    %esi,%esi
801071b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071bd:	8d 76 00             	lea    0x0(%esi),%esi
801071c0:	8b 4d 08             	mov    0x8(%ebp),%ecx
801071c3:	89 f0                	mov    %esi,%eax
801071c5:	c1 e8 16             	shr    $0x16,%eax
801071c8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801071cb:	a8 01                	test   $0x1,%al
801071cd:	75 11                	jne    801071e0 <copyuvm+0x50>
801071cf:	83 ec 0c             	sub    $0xc,%esp
801071d2:	68 fc 83 10 80       	push   $0x801083fc
801071d7:	e8 a4 91 ff ff       	call   80100380 <panic>
801071dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801071e0:	89 f2                	mov    %esi,%edx
801071e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801071e7:	c1 ea 0a             	shr    $0xa,%edx
801071ea:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801071f0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
801071f7:	85 c0                	test   %eax,%eax
801071f9:	74 d4                	je     801071cf <copyuvm+0x3f>
801071fb:	8b 38                	mov    (%eax),%edi
801071fd:	f7 c7 01 00 00 00    	test   $0x1,%edi
80107203:	0f 84 9b 00 00 00    	je     801072a4 <copyuvm+0x114>
80107209:	89 fb                	mov    %edi,%ebx
8010720b:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
80107211:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107214:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010721a:	e8 61 b4 ff ff       	call   80102680 <kalloc>
8010721f:	89 c7                	mov    %eax,%edi
80107221:	85 c0                	test   %eax,%eax
80107223:	74 5f                	je     80107284 <copyuvm+0xf4>
80107225:	83 ec 04             	sub    $0x4,%esp
80107228:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
8010722e:	68 00 10 00 00       	push   $0x1000
80107233:	53                   	push   %ebx
80107234:	50                   	push   %eax
80107235:	e8 06 d5 ff ff       	call   80104740 <memmove>
8010723a:	58                   	pop    %eax
8010723b:	8d 87 00 00 00 80    	lea    -0x80000000(%edi),%eax
80107241:	ff 75 e4             	push   -0x1c(%ebp)
80107244:	50                   	push   %eax
80107245:	68 00 10 00 00       	push   $0x1000
8010724a:	56                   	push   %esi
8010724b:	ff 75 e0             	push   -0x20(%ebp)
8010724e:	e8 ed f8 ff ff       	call   80106b40 <mappages>
80107253:	83 c4 20             	add    $0x20,%esp
80107256:	85 c0                	test   %eax,%eax
80107258:	78 1e                	js     80107278 <copyuvm+0xe8>
8010725a:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107260:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107263:	0f 87 57 ff ff ff    	ja     801071c0 <copyuvm+0x30>
80107269:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010726c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010726f:	5b                   	pop    %ebx
80107270:	5e                   	pop    %esi
80107271:	5f                   	pop    %edi
80107272:	5d                   	pop    %ebp
80107273:	c3                   	ret    
80107274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107278:	83 ec 0c             	sub    $0xc,%esp
8010727b:	57                   	push   %edi
8010727c:	e8 3f b2 ff ff       	call   801024c0 <kfree>
80107281:	83 c4 10             	add    $0x10,%esp
80107284:	83 ec 0c             	sub    $0xc,%esp
80107287:	ff 75 e0             	push   -0x20(%ebp)
8010728a:	e8 91 fd ff ff       	call   80107020 <freevm>
8010728f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107296:	83 c4 10             	add    $0x10,%esp
80107299:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010729c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010729f:	5b                   	pop    %ebx
801072a0:	5e                   	pop    %esi
801072a1:	5f                   	pop    %edi
801072a2:	5d                   	pop    %ebp
801072a3:	c3                   	ret    
801072a4:	83 ec 0c             	sub    $0xc,%esp
801072a7:	68 16 84 10 80       	push   $0x80108416
801072ac:	e8 cf 90 ff ff       	call   80100380 <panic>
801072b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072bf:	90                   	nop

801072c0 <uva2ka>:
801072c0:	55                   	push   %ebp
801072c1:	89 e5                	mov    %esp,%ebp
801072c3:	8b 45 0c             	mov    0xc(%ebp),%eax
801072c6:	8b 55 08             	mov    0x8(%ebp),%edx
801072c9:	89 c1                	mov    %eax,%ecx
801072cb:	c1 e9 16             	shr    $0x16,%ecx
801072ce:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801072d1:	f6 c2 01             	test   $0x1,%dl
801072d4:	0f 84 00 01 00 00    	je     801073da <uva2ka.cold>
801072da:	c1 e8 0c             	shr    $0xc,%eax
801072dd:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801072e3:	5d                   	pop    %ebp
801072e4:	25 ff 03 00 00       	and    $0x3ff,%eax
801072e9:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
801072f0:	89 c2                	mov    %eax,%edx
801072f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801072f7:	83 e2 05             	and    $0x5,%edx
801072fa:	05 00 00 00 80       	add    $0x80000000,%eax
801072ff:	83 fa 05             	cmp    $0x5,%edx
80107302:	ba 00 00 00 00       	mov    $0x0,%edx
80107307:	0f 45 c2             	cmovne %edx,%eax
8010730a:	c3                   	ret    
8010730b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010730f:	90                   	nop

80107310 <copyout>:
80107310:	55                   	push   %ebp
80107311:	89 e5                	mov    %esp,%ebp
80107313:	57                   	push   %edi
80107314:	56                   	push   %esi
80107315:	53                   	push   %ebx
80107316:	83 ec 0c             	sub    $0xc,%esp
80107319:	8b 75 14             	mov    0x14(%ebp),%esi
8010731c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010731f:	8b 55 10             	mov    0x10(%ebp),%edx
80107322:	85 f6                	test   %esi,%esi
80107324:	75 51                	jne    80107377 <copyout+0x67>
80107326:	e9 a5 00 00 00       	jmp    801073d0 <copyout+0xc0>
8010732b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010732f:	90                   	nop
80107330:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107336:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
8010733c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107342:	74 75                	je     801073b9 <copyout+0xa9>
80107344:	89 fb                	mov    %edi,%ebx
80107346:	89 55 10             	mov    %edx,0x10(%ebp)
80107349:	29 c3                	sub    %eax,%ebx
8010734b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107351:	39 f3                	cmp    %esi,%ebx
80107353:	0f 47 de             	cmova  %esi,%ebx
80107356:	29 f8                	sub    %edi,%eax
80107358:	83 ec 04             	sub    $0x4,%esp
8010735b:	01 c1                	add    %eax,%ecx
8010735d:	53                   	push   %ebx
8010735e:	52                   	push   %edx
8010735f:	51                   	push   %ecx
80107360:	e8 db d3 ff ff       	call   80104740 <memmove>
80107365:	8b 55 10             	mov    0x10(%ebp),%edx
80107368:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
8010736e:	83 c4 10             	add    $0x10,%esp
80107371:	01 da                	add    %ebx,%edx
80107373:	29 de                	sub    %ebx,%esi
80107375:	74 59                	je     801073d0 <copyout+0xc0>
80107377:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010737a:	89 c1                	mov    %eax,%ecx
8010737c:	89 c7                	mov    %eax,%edi
8010737e:	c1 e9 16             	shr    $0x16,%ecx
80107381:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80107387:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010738a:	f6 c1 01             	test   $0x1,%cl
8010738d:	0f 84 4e 00 00 00    	je     801073e1 <copyout.cold>
80107393:	89 fb                	mov    %edi,%ebx
80107395:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
8010739b:	c1 eb 0c             	shr    $0xc,%ebx
8010739e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
801073a4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
801073ab:	89 d9                	mov    %ebx,%ecx
801073ad:	83 e1 05             	and    $0x5,%ecx
801073b0:	83 f9 05             	cmp    $0x5,%ecx
801073b3:	0f 84 77 ff ff ff    	je     80107330 <copyout+0x20>
801073b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801073c1:	5b                   	pop    %ebx
801073c2:	5e                   	pop    %esi
801073c3:	5f                   	pop    %edi
801073c4:	5d                   	pop    %ebp
801073c5:	c3                   	ret    
801073c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073cd:	8d 76 00             	lea    0x0(%esi),%esi
801073d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073d3:	31 c0                	xor    %eax,%eax
801073d5:	5b                   	pop    %ebx
801073d6:	5e                   	pop    %esi
801073d7:	5f                   	pop    %edi
801073d8:	5d                   	pop    %ebp
801073d9:	c3                   	ret    

801073da <uva2ka.cold>:
801073da:	a1 00 00 00 00       	mov    0x0,%eax
801073df:	0f 0b                	ud2    

801073e1 <copyout.cold>:
801073e1:	a1 00 00 00 00       	mov    0x0,%eax
801073e6:	0f 0b                	ud2    
801073e8:	66 90                	xchg   %ax,%ax
801073ea:	66 90                	xchg   %ax,%ax
801073ec:	66 90                	xchg   %ax,%ax
801073ee:	66 90                	xchg   %ax,%ax

801073f0 <sys_wmap>:
#include "mmu.h"
#include "param.h"
#include "proc.h"


uint sys_wmap(void) {
801073f0:	55                   	push   %ebp
801073f1:	89 e5                	mov    %esp,%ebp
801073f3:	57                   	push   %edi
801073f4:	56                   	push   %esi
  uint addr;
  int length;
  int flags;
  int fd;
  if(argint(0, (int*)&addr) < 0 || argint(1, &length) < 0 || argint(2, &flags) < 0 || argint(3, &fd) < 0) {
801073f5:	8d 45 d8             	lea    -0x28(%ebp),%eax
uint sys_wmap(void) {
801073f8:	53                   	push   %ebx
801073f9:	83 ec 34             	sub    $0x34,%esp
  if(argint(0, (int*)&addr) < 0 || argint(1, &length) < 0 || argint(2, &flags) < 0 || argint(3, &fd) < 0) {
801073fc:	50                   	push   %eax
801073fd:	6a 00                	push   $0x0
801073ff:	e8 5c d5 ff ff       	call   80104960 <argint>
80107404:	83 c4 10             	add    $0x10,%esp
80107407:	85 c0                	test   %eax,%eax
80107409:	0f 88 71 01 00 00    	js     80107580 <sys_wmap+0x190>
8010740f:	83 ec 08             	sub    $0x8,%esp
80107412:	8d 45 dc             	lea    -0x24(%ebp),%eax
80107415:	50                   	push   %eax
80107416:	6a 01                	push   $0x1
80107418:	e8 43 d5 ff ff       	call   80104960 <argint>
8010741d:	83 c4 10             	add    $0x10,%esp
80107420:	85 c0                	test   %eax,%eax
80107422:	0f 88 58 01 00 00    	js     80107580 <sys_wmap+0x190>
80107428:	83 ec 08             	sub    $0x8,%esp
8010742b:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010742e:	50                   	push   %eax
8010742f:	6a 02                	push   $0x2
80107431:	e8 2a d5 ff ff       	call   80104960 <argint>
80107436:	83 c4 10             	add    $0x10,%esp
80107439:	85 c0                	test   %eax,%eax
8010743b:	0f 88 3f 01 00 00    	js     80107580 <sys_wmap+0x190>
80107441:	83 ec 08             	sub    $0x8,%esp
80107444:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80107447:	50                   	push   %eax
80107448:	6a 03                	push   $0x3
8010744a:	e8 11 d5 ff ff       	call   80104960 <argint>
8010744f:	83 c4 10             	add    $0x10,%esp
80107452:	85 c0                	test   %eax,%eax
80107454:	0f 88 26 01 00 00    	js     80107580 <sys_wmap+0x190>
   return -1;
  }
  if (length <= 0) {
8010745a:	8b 75 dc             	mov    -0x24(%ebp),%esi
8010745d:	85 f6                	test   %esi,%esi
8010745f:	0f 8e e9 01 00 00    	jle    8010764e <sys_wmap+0x25e>
    cprintf("Length less or equal to 0\n");
    return -1;
  }
  struct proc* p = myproc();
80107465:	e8 46 c5 ff ff       	call   801039b0 <myproc>
  if (p->memory_used + length > 0x20000000) {
8010746a:	8b 7d dc             	mov    -0x24(%ebp),%edi
  struct proc* p = myproc();
8010746d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if (p->memory_used + length > 0x20000000) {
80107470:	8b 80 7c 05 00 00    	mov    0x57c(%eax),%eax
80107476:	01 f8                	add    %edi,%eax
80107478:	3d 00 00 00 20       	cmp    $0x20000000,%eax
8010747d:	0f 8f e5 01 00 00    	jg     80107668 <sys_wmap+0x278>
    cprintf("Not enough memory\n");
    return -1;
  }
  if (addr < 0x60000000 || addr + length - 1 >= 0x80000000){
80107483:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80107486:	81 f9 ff ff ff 5f    	cmp    $0x5fffffff,%ecx
8010748c:	0f 86 fd 00 00 00    	jbe    8010758f <sys_wmap+0x19f>
80107492:	01 cf                	add    %ecx,%edi
80107494:	89 f8                	mov    %edi,%eax
80107496:	83 e8 01             	sub    $0x1,%eax
80107499:	0f 88 f0 00 00 00    	js     8010758f <sys_wmap+0x19f>
    cprintf("Wrong address");
    return -1;
  }
  if (flags & MAP_FIXED) {
8010749f:	f6 45 e0 08          	testb  $0x8,-0x20(%ebp)
801074a3:	0f 85 90 00 00 00    	jne    80107539 <sys_wmap+0x149>
801074a9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801074ac:	83 e8 80             	sub    $0xffffff80,%eax
801074af:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
  } else {
    int valid = 0;
    while (!valid) {
      int i;
      for(i = 0; i < 16; ++i) {
801074b2:	8b 55 d0             	mov    -0x30(%ebp),%edx
801074b5:	31 db                	xor    %ebx,%ebx
801074b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074be:	66 90                	xchg   %ax,%ax
        if(p->addr[i].va == 0) {
801074c0:	8b 42 fc             	mov    -0x4(%edx),%eax
801074c3:	85 c0                	test   %eax,%eax
801074c5:	74 20                	je     801074e7 <sys_wmap+0xf7>
          continue;
        }
        if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size > addr + length)) { //checks if boundaries of mem being asked are in any of vas of maps already made
801074c7:	39 c8                	cmp    %ecx,%eax
801074c9:	77 0c                	ja     801074d7 <sys_wmap+0xe7>
801074cb:	8b 32                	mov    (%edx),%esi
801074cd:	01 c6                	add    %eax,%esi
801074cf:	39 ce                	cmp    %ecx,%esi
801074d1:	0f 87 d9 00 00 00    	ja     801075b0 <sys_wmap+0x1c0>
801074d7:	39 f8                	cmp    %edi,%eax
801074d9:	73 0c                	jae    801074e7 <sys_wmap+0xf7>
801074db:	8b 32                	mov    (%edx),%esi
801074dd:	01 c6                	add    %eax,%esi
801074df:	39 f7                	cmp    %esi,%edi
801074e1:	0f 82 c9 00 00 00    	jb     801075b0 <sys_wmap+0x1c0>
      for(i = 0; i < 16; ++i) {
801074e7:	83 c3 01             	add    $0x1,%ebx
801074ea:	83 c2 50             	add    $0x50,%edx
801074ed:	83 fb 10             	cmp    $0x10,%ebx
801074f0:	75 ce                	jne    801074c0 <sys_wmap+0xd0>
      }
      if (i == 16) {
        valid = 1;
      }
    }
    cprintf("\t-Done. Final addr 0x%x\n", addr);
801074f2:	83 ec 08             	sub    $0x8,%esp
801074f5:	51                   	push   %ecx
801074f6:	68 8f 84 10 80       	push   $0x8010848f
801074fb:	e8 a0 91 ff ff       	call   801006a0 <cprintf>
  }

  //cprintf("pid in wmap: %d\n",p->pid);
  for(int i=0; i<16; ++i){
    if(p->addr[i].va==0) {
      p->addr[i].va = addr;
80107500:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80107503:	83 c4 10             	add    $0x10,%esp
  for(int i=0; i<16; ++i){
80107506:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80107509:	8d 50 7c             	lea    0x7c(%eax),%edx
8010750c:	31 c0                	xor    %eax,%eax
8010750e:	66 90                	xchg   %ax,%ax
    if(p->addr[i].va==0) {
80107510:	8b 1a                	mov    (%edx),%ebx
80107512:	85 db                	test   %ebx,%ebx
80107514:	0f 84 00 01 00 00    	je     8010761a <sys_wmap+0x22a>
  for(int i=0; i<16; ++i){
8010751a:	83 c0 01             	add    $0x1,%eax
8010751d:	83 c2 50             	add    $0x50,%edx
80107520:	83 f8 10             	cmp    $0x10,%eax
80107523:	75 eb                	jne    80107510 <sys_wmap+0x120>
      p->addr[i].flags = flags;
      p->addr[i].fd = fd;
      break;
    }
  }
  p->n_mmaps += 1;
80107525:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80107528:	83 80 80 05 00 00 01 	addl   $0x1,0x580(%eax)
  // for(int i = 0; i < p->size_addr; ++i) {
  //   cprintf("addr[0]\nva = 0x%x\nlength = %d\nflags = %d\nfd = %d\n", p->addr[i].va, p->addr[i].size, p->addr[i].flags, p->addr[i].fd);
  // }
 // struct address* head = myproc()->head;
  return addr;
}
8010752f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107532:	89 c8                	mov    %ecx,%eax
80107534:	5b                   	pop    %ebx
80107535:	5e                   	pop    %esi
80107536:	5f                   	pop    %edi
80107537:	5d                   	pop    %ebp
80107538:	c3                   	ret    
80107539:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
8010753c:	8d 83 80 00 00 00    	lea    0x80(%ebx),%eax
80107542:	81 c3 80 05 00 00    	add    $0x580,%ebx
80107548:	eb 17                	jmp    80107561 <sys_wmap+0x171>
8010754a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size > addr + length)) {
80107550:	39 d7                	cmp    %edx,%edi
80107552:	76 06                	jbe    8010755a <sys_wmap+0x16a>
80107554:	03 10                	add    (%eax),%edx
80107556:	39 d7                	cmp    %edx,%edi
80107558:	72 16                	jb     80107570 <sys_wmap+0x180>
    for(int i = 0; i < 16; ++i) {
8010755a:	83 c0 50             	add    $0x50,%eax
8010755d:	39 d8                	cmp    %ebx,%eax
8010755f:	74 a5                	je     80107506 <sys_wmap+0x116>
      if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size > addr + length)) {
80107561:	8b 50 fc             	mov    -0x4(%eax),%edx
80107564:	39 d1                	cmp    %edx,%ecx
80107566:	72 e8                	jb     80107550 <sys_wmap+0x160>
80107568:	8b 30                	mov    (%eax),%esi
8010756a:	01 d6                	add    %edx,%esi
8010756c:	39 f1                	cmp    %esi,%ecx
8010756e:	73 e0                	jae    80107550 <sys_wmap+0x160>
        cprintf("Address suggested already in memory\n");
80107570:	83 ec 0c             	sub    $0xc,%esp
80107573:	68 d4 84 10 80       	push   $0x801084d4
80107578:	e8 23 91 ff ff       	call   801006a0 <cprintf>
        return -1;
8010757d:	83 c4 10             	add    $0x10,%esp
80107580:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
}
80107585:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107588:	89 c8                	mov    %ecx,%eax
8010758a:	5b                   	pop    %ebx
8010758b:	5e                   	pop    %esi
8010758c:	5f                   	pop    %edi
8010758d:	5d                   	pop    %ebp
8010758e:	c3                   	ret    
    cprintf("Wrong address");
8010758f:	83 ec 0c             	sub    $0xc,%esp
80107592:	68 81 84 10 80       	push   $0x80108481
80107597:	e8 04 91 ff ff       	call   801006a0 <cprintf>
    return -1;
8010759c:	83 c4 10             	add    $0x10,%esp
8010759f:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
801075a4:	eb df                	jmp    80107585 <sys_wmap+0x195>
801075a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075ad:	8d 76 00             	lea    0x0(%esi),%esi
          cprintf("\t-In if addr = 0x%x, checking against addr[%d], interval 0x%x, 0x%x\n", addr, i, p->addr[i].va, p->addr[i].va + p->addr[i].size);
801075b0:	83 ec 0c             	sub    $0xc,%esp
801075b3:	56                   	push   %esi
801075b4:	50                   	push   %eax
801075b5:	53                   	push   %ebx
801075b6:	51                   	push   %ecx
801075b7:	68 fc 84 10 80       	push   $0x801084fc
801075bc:	e8 df 90 ff ff       	call   801006a0 <cprintf>
          if (p->addr[i].va + p->addr[i].size == 0x80000000) {
801075c1:	8b 7d d4             	mov    -0x2c(%ebp),%edi
801075c4:	8d 14 9b             	lea    (%ebx,%ebx,4),%edx
801075c7:	83 c4 20             	add    $0x20,%esp
801075ca:	c1 e2 04             	shl    $0x4,%edx
801075cd:	8b 44 17 7c          	mov    0x7c(%edi,%edx,1),%eax
801075d1:	03 84 17 80 00 00 00 	add    0x80(%edi,%edx,1),%eax
801075d8:	3d 00 00 00 80       	cmp    $0x80000000,%eax
801075dd:	74 10                	je     801075ef <sys_wmap+0x1ff>
            if (addr + length > 0x80000000) {
801075df:	8b 55 dc             	mov    -0x24(%ebp),%edx
            addr = p->addr[i].va + p->addr[i].size;
801075e2:	89 45 d8             	mov    %eax,-0x28(%ebp)
            if (addr + length > 0x80000000) {
801075e5:	01 c2                	add    %eax,%edx
801075e7:	81 fa 00 00 00 80    	cmp    $0x80000000,%edx
801075ed:	76 0c                	jbe    801075fb <sys_wmap+0x20b>
            addr = 0x60000000;
801075ef:	c7 45 d8 00 00 00 60 	movl   $0x60000000,-0x28(%ebp)
801075f6:	b8 00 00 00 60       	mov    $0x60000000,%eax
          cprintf("\t-New addr after if against addr[%d] is 0x%x\n", i, addr);
801075fb:	83 ec 04             	sub    $0x4,%esp
801075fe:	50                   	push   %eax
801075ff:	53                   	push   %ebx
80107600:	68 44 85 10 80       	push   $0x80108544
80107605:	e8 96 90 ff ff       	call   801006a0 <cprintf>
        if ((p->addr[i].va <= addr && p->addr[i].va + p->addr[i].size > addr) || (p->addr[i].va < addr + length && p->addr[i].va + p->addr[i].size > addr + length)) { //checks if boundaries of mem being asked are in any of vas of maps already made
8010760a:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010760d:	8b 7d dc             	mov    -0x24(%ebp),%edi
80107610:	83 c4 10             	add    $0x10,%esp
80107613:	01 cf                	add    %ecx,%edi
80107615:	e9 98 fe ff ff       	jmp    801074b2 <sys_wmap+0xc2>
      p->addr[i].va = addr;
8010761a:	8b 7d d4             	mov    -0x2c(%ebp),%edi
8010761d:	8d 04 80             	lea    (%eax,%eax,4),%eax
      p->memory_used += length;
80107620:	8b 55 dc             	mov    -0x24(%ebp),%edx
      p->addr[i].va = addr;
80107623:	c1 e0 04             	shl    $0x4,%eax
80107626:	01 f8                	add    %edi,%eax
80107628:	89 48 7c             	mov    %ecx,0x7c(%eax)
      p->memory_used += length;
8010762b:	01 97 7c 05 00 00    	add    %edx,0x57c(%edi)
      p->addr[i].size = length;
80107631:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
      p->addr[i].flags = flags;
80107637:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010763a:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
      p->addr[i].fd = fd;
80107640:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107643:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
      break;
80107649:	e9 d7 fe ff ff       	jmp    80107525 <sys_wmap+0x135>
    cprintf("Length less or equal to 0\n");
8010764e:	83 ec 0c             	sub    $0xc,%esp
80107651:	68 53 84 10 80       	push   $0x80108453
80107656:	e8 45 90 ff ff       	call   801006a0 <cprintf>
    return -1;
8010765b:	83 c4 10             	add    $0x10,%esp
8010765e:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80107663:	e9 1d ff ff ff       	jmp    80107585 <sys_wmap+0x195>
    cprintf("Not enough memory\n");
80107668:	83 ec 0c             	sub    $0xc,%esp
8010766b:	68 6e 84 10 80       	push   $0x8010846e
80107670:	e8 2b 90 ff ff       	call   801006a0 <cprintf>
    return -1;
80107675:	83 c4 10             	add    $0x10,%esp
80107678:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
8010767d:	e9 03 ff ff ff       	jmp    80107585 <sys_wmap+0x195>
80107682:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107690 <sys_wunmap>:

int sys_wunmap(void) {
80107690:	55                   	push   %ebp
80107691:	89 e5                	mov    %esp,%ebp
80107693:	57                   	push   %edi
80107694:	56                   	push   %esi
  uint addr;
  if (argint(0, (int*)&addr) < 0) {
80107695:	8d 45 e4             	lea    -0x1c(%ebp),%eax
int sys_wunmap(void) {
80107698:	53                   	push   %ebx
80107699:	83 ec 34             	sub    $0x34,%esp
  if (argint(0, (int*)&addr) < 0) {
8010769c:	50                   	push   %eax
8010769d:	6a 00                	push   $0x0
8010769f:	e8 bc d2 ff ff       	call   80104960 <argint>
801076a4:	83 c4 10             	add    $0x10,%esp
801076a7:	85 c0                	test   %eax,%eax
801076a9:	0f 88 2a 01 00 00    	js     801077d9 <sys_wunmap+0x149>
   return -1;
  }
  struct proc* p = myproc();
801076af:	e8 fc c2 ff ff       	call   801039b0 <myproc>
  pte_t *pte;
  for(int i = 0; i < 16; ++i) {
801076b4:	31 db                	xor    %ebx,%ebx

      //PTE_P present bit && *pte to check if valid and then kfree and 0 it.

    if (p->addr[i].va == addr && p->addr[i].phys_page_used[i]>0) {
801076b6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  struct proc* p = myproc();
801076b9:	89 c6                	mov    %eax,%esi
  for(int i = 0; i < 16; ++i) {
801076bb:	eb 0f                	jmp    801076cc <sys_wunmap+0x3c>
801076bd:	8d 76 00             	lea    0x0(%esi),%esi
801076c0:	83 c3 01             	add    $0x1,%ebx
801076c3:	83 fb 10             	cmp    $0x10,%ebx
801076c6:	0f 84 b8 00 00 00    	je     80107784 <sys_wunmap+0xf4>
    if (p->addr[i].va == addr && p->addr[i].phys_page_used[i]>0) {
801076cc:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
801076cf:	c1 e0 04             	shl    $0x4,%eax
801076d2:	39 54 06 7c          	cmp    %edx,0x7c(%esi,%eax,1)
801076d6:	75 e8                	jne    801076c0 <sys_wunmap+0x30>
801076d8:	6b cb 54             	imul   $0x54,%ebx,%ecx
801076db:	8b 8c 0e 8c 00 00 00 	mov    0x8c(%esi,%ecx,1),%ecx
801076e2:	85 c9                	test   %ecx,%ecx
801076e4:	7e da                	jle    801076c0 <sys_wunmap+0x30>
      int size = p->addr[i].size;
801076e6:	8b 84 06 80 00 00 00 	mov    0x80(%esi,%eax,1),%eax
      int j = 0;
      while(size > 0){
801076ed:	85 c0                	test   %eax,%eax
801076ef:	7e 5a                	jle    8010774b <sys_wunmap+0xbb>
801076f1:	83 e8 01             	sub    $0x1,%eax
801076f4:	31 ff                	xor    %edi,%edi
801076f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801076fb:	05 00 10 00 00       	add    $0x1000,%eax
80107700:	89 45 d0             	mov    %eax,-0x30(%ebp)
80107703:	eb 06                	jmp    8010770b <sys_wunmap+0x7b>
80107705:	8d 76 00             	lea    0x0(%esi),%esi
        pte = walkpgdir(p->pgdir, (void*)addr + j*PAGE_SIZE, 0);
80107708:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010770b:	83 ec 04             	sub    $0x4,%esp
8010770e:	01 fa                	add    %edi,%edx
      while(size > 0){
80107710:	81 c7 00 10 00 00    	add    $0x1000,%edi
        pte = walkpgdir(p->pgdir, (void*)addr + j*PAGE_SIZE, 0);
80107716:	6a 00                	push   $0x0
80107718:	52                   	push   %edx
80107719:	ff 76 04             	push   0x4(%esi)
8010771c:	e8 8f f3 ff ff       	call   80106ab0 <walkpgdir>
80107721:	89 c2                	mov    %eax,%edx
        int physical_address = PTE_ADDR(*pte);
80107723:	8b 00                	mov    (%eax),%eax
80107725:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80107728:	25 00 f0 ff ff       	and    $0xfffff000,%eax
        //cprintf("pte = %x", *pte);
        kfree(P2V(physical_address));
8010772d:	05 00 00 00 80       	add    $0x80000000,%eax
80107732:	89 04 24             	mov    %eax,(%esp)
80107735:	e8 86 ad ff ff       	call   801024c0 <kfree>
        size-=PAGE_SIZE;
        ++j;
        *pte = 0;
8010773a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      while(size > 0){
8010773d:	83 c4 10             	add    $0x10,%esp
        *pte = 0;
80107740:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
      while(size > 0){
80107746:	3b 7d d0             	cmp    -0x30(%ebp),%edi
80107749:	75 bd                	jne    80107708 <sys_wunmap+0x78>
      }
      p->addr[i].va = 0;
8010774b:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
8010774e:	c1 e0 04             	shl    $0x4,%eax
80107751:	01 f0                	add    %esi,%eax
      p->addr[i].flags = 0;
      p->addr[i].fd = 0;
      p->memory_used -= p->addr[i].size;
80107753:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
      p->addr[i].va = 0;
80107759:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
      p->addr[i].flags = 0;
80107760:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%eax)
80107767:	00 00 00 
      p->addr[i].fd = 0;
8010776a:	c7 80 88 00 00 00 00 	movl   $0x0,0x88(%eax)
80107771:	00 00 00 
      p->memory_used -= p->addr[i].size;
80107774:	29 96 7c 05 00 00    	sub    %edx,0x57c(%esi)
      p->addr[i].size = 0;
8010777a:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80107781:	00 00 00 
      break;
    }
  }
  // flush TLB
  switchuvm(p);
80107784:	83 ec 0c             	sub    $0xc,%esp
80107787:	56                   	push   %esi
80107788:	e8 b3 f4 ff ff       	call   80106c40 <switchuvm>
    for(int i = 0; i < 16; ++i) {
      if (p->addr[i].va == addr) {
8010778d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107790:	8d 46 7c             	lea    0x7c(%esi),%eax
80107793:	83 c4 10             	add    $0x10,%esp
80107796:	8d 96 7c 05 00 00    	lea    0x57c(%esi),%edx
8010779c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801077a0:	39 08                	cmp    %ecx,(%eax)
801077a2:	75 24                	jne    801077c8 <sys_wunmap+0x138>

        p->addr[i].va = 0;
        p->addr[i].flags = 0;
        p->addr[i].fd = 0;
        p->memory_used -= p->addr[i].size;
801077a4:	8b 58 04             	mov    0x4(%eax),%ebx
        p->addr[i].va = 0;
801077a7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
        p->addr[i].flags = 0;
801077ad:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        p->addr[i].fd = 0;
801077b4:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->memory_used -= p->addr[i].size;
801077bb:	29 9e 7c 05 00 00    	sub    %ebx,0x57c(%esi)
        p->addr[i].size = 0;
801077c1:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    for(int i = 0; i < 16; ++i) {
801077c8:	83 c0 50             	add    $0x50,%eax
801077cb:	39 d0                	cmp    %edx,%eax
801077cd:	75 d1                	jne    801077a0 <sys_wunmap+0x110>
      }
    }
  return 0;
801077cf:	31 c0                	xor    %eax,%eax
}
801077d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077d4:	5b                   	pop    %ebx
801077d5:	5e                   	pop    %esi
801077d6:	5f                   	pop    %edi
801077d7:	5d                   	pop    %ebp
801077d8:	c3                   	ret    
   return -1;
801077d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801077de:	eb f1                	jmp    801077d1 <sys_wunmap+0x141>

801077e0 <sys_wremap>:

uint sys_wremap(void) {
801077e0:	55                   	push   %ebp
801077e1:	89 e5                	mov    %esp,%ebp
801077e3:	57                   	push   %edi
801077e4:	56                   	push   %esi
  uint oldaddr;
  int oldsize;
  int newsize;
  int flags;
  if(argint(0, (int*)&oldaddr) < 0 || argint(1, &oldsize) < 0 || argint(2, &newsize) < 0 || argint(3, &flags) < 0) {
801077e5:	8d 45 d8             	lea    -0x28(%ebp),%eax
uint sys_wremap(void) {
801077e8:	53                   	push   %ebx
801077e9:	83 ec 24             	sub    $0x24,%esp
  if(argint(0, (int*)&oldaddr) < 0 || argint(1, &oldsize) < 0 || argint(2, &newsize) < 0 || argint(3, &flags) < 0) {
801077ec:	50                   	push   %eax
801077ed:	6a 00                	push   $0x0
801077ef:	e8 6c d1 ff ff       	call   80104960 <argint>
801077f4:	83 c4 10             	add    $0x10,%esp
801077f7:	85 c0                	test   %eax,%eax
801077f9:	0f 88 f1 00 00 00    	js     801078f0 <sys_wremap+0x110>
801077ff:	83 ec 08             	sub    $0x8,%esp
80107802:	8d 45 dc             	lea    -0x24(%ebp),%eax
80107805:	50                   	push   %eax
80107806:	6a 01                	push   $0x1
80107808:	e8 53 d1 ff ff       	call   80104960 <argint>
8010780d:	83 c4 10             	add    $0x10,%esp
80107810:	85 c0                	test   %eax,%eax
80107812:	0f 88 d8 00 00 00    	js     801078f0 <sys_wremap+0x110>
80107818:	83 ec 08             	sub    $0x8,%esp
8010781b:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010781e:	50                   	push   %eax
8010781f:	6a 02                	push   $0x2
80107821:	e8 3a d1 ff ff       	call   80104960 <argint>
80107826:	83 c4 10             	add    $0x10,%esp
80107829:	85 c0                	test   %eax,%eax
8010782b:	0f 88 bf 00 00 00    	js     801078f0 <sys_wremap+0x110>
80107831:	83 ec 08             	sub    $0x8,%esp
80107834:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80107837:	50                   	push   %eax
80107838:	6a 03                	push   $0x3
8010783a:	e8 21 d1 ff ff       	call   80104960 <argint>
8010783f:	83 c4 10             	add    $0x10,%esp
80107842:	85 c0                	test   %eax,%eax
80107844:	0f 88 a6 00 00 00    	js     801078f0 <sys_wremap+0x110>
    return -1;
  }
  struct proc *p = myproc();
8010784a:	e8 61 c1 ff ff       	call   801039b0 <myproc>
  int i;
  for(i = 0; i < 16; ++i){
    if(p->addr[i].va == oldaddr && p->addr[i].size == oldsize){
8010784f:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80107852:	8b 75 dc             	mov    -0x24(%ebp),%esi
80107855:	8d 50 7c             	lea    0x7c(%eax),%edx
80107858:	8d 98 7c 05 00 00    	lea    0x57c(%eax),%ebx
8010785e:	89 d0                	mov    %edx,%eax
80107860:	eb 0d                	jmp    8010786f <sys_wremap+0x8f>
80107862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; i < 16; ++i){
80107868:	83 c0 50             	add    $0x50,%eax
8010786b:	39 d8                	cmp    %ebx,%eax
8010786d:	74 71                	je     801078e0 <sys_wremap+0x100>
    if(p->addr[i].va == oldaddr && p->addr[i].size == oldsize){
8010786f:	39 08                	cmp    %ecx,(%eax)
80107871:	75 f5                	jne    80107868 <sys_wremap+0x88>
80107873:	39 70 04             	cmp    %esi,0x4(%eax)
80107876:	75 f0                	jne    80107868 <sys_wremap+0x88>
    cprintf("Address given is not mapped by wmap\n");
    return -1;
  }
  int valid = 0;
  for (int j = 0; j < 16; ++j) {
    if (p->addr[j].va < oldaddr + newsize && p->addr[j].va + p->addr[j].size > oldaddr + newsize) {
80107878:	03 4d e0             	add    -0x20(%ebp),%ecx
8010787b:	31 f6                	xor    %esi,%esi
      continue;
    }
    valid = 1;
8010787d:	bf 01 00 00 00       	mov    $0x1,%edi
80107882:	eb 13                	jmp    80107897 <sys_wremap+0xb7>
80107884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (p->addr[j].va < oldaddr + newsize && p->addr[j].va + p->addr[j].size > oldaddr + newsize) {
80107888:	03 42 04             	add    0x4(%edx),%eax
    valid = 1;
8010788b:	39 c1                	cmp    %eax,%ecx
8010788d:	0f 43 f7             	cmovae %edi,%esi
  for (int j = 0; j < 16; ++j) {
80107890:	83 c2 50             	add    $0x50,%edx
80107893:	39 da                	cmp    %ebx,%edx
80107895:	74 12                	je     801078a9 <sys_wremap+0xc9>
    if (p->addr[j].va < oldaddr + newsize && p->addr[j].va + p->addr[j].size > oldaddr + newsize) {
80107897:	8b 02                	mov    (%edx),%eax
80107899:	39 c8                	cmp    %ecx,%eax
8010789b:	72 eb                	jb     80107888 <sys_wremap+0xa8>
  for (int j = 0; j < 16; ++j) {
8010789d:	83 c2 50             	add    $0x50,%edx
    valid = 1;
801078a0:	be 01 00 00 00       	mov    $0x1,%esi
  for (int j = 0; j < 16; ++j) {
801078a5:	39 da                	cmp    %ebx,%edx
801078a7:	75 ee                	jne    80107897 <sys_wremap+0xb7>
  }
  if (oldaddr + newsize > 0x80000000) {
    valid = 0;
  }
  if (valid == 1) {
801078a9:	81 f9 00 00 00 80    	cmp    $0x80000000,%ecx
801078af:	77 05                	ja     801078b6 <sys_wremap+0xd6>
801078b1:	83 e6 01             	and    $0x1,%esi
801078b4:	75 5e                	jne    80107914 <sys_wremap+0x134>
    cprintf("\t-Valid for in place\n");
  } else if ((valid == 0) && !(flags & MREMAP_MAYMOVE)) {
801078b6:	f6 45 e4 01          	testb  $0x1,-0x1c(%ebp)
801078ba:	74 44                	je     80107900 <sys_wremap+0x120>
    cprintf("\t-Cannot remap in place and flag specified no move. No remap\n");
  } else {
    cprintf("\t-Valid for moving\n");
801078bc:	83 ec 0c             	sub    $0xc,%esp
801078bf:	68 be 84 10 80       	push   $0x801084be
801078c4:	e8 d7 8d ff ff       	call   801006a0 <cprintf>
801078c9:	83 c4 10             	add    $0x10,%esp
    //remap by changing initial address
  }
  
  return 0;
}
801078cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801078cf:	31 c0                	xor    %eax,%eax
}
801078d1:	5b                   	pop    %ebx
801078d2:	5e                   	pop    %esi
801078d3:	5f                   	pop    %edi
801078d4:	5d                   	pop    %ebp
801078d5:	c3                   	ret    
801078d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801078dd:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("Address given is not mapped by wmap\n");
801078e0:	83 ec 0c             	sub    $0xc,%esp
801078e3:	68 b4 85 10 80       	push   $0x801085b4
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
    cprintf("\t-Cannot remap in place and flag specified no move. No remap\n");
80107900:	83 ec 0c             	sub    $0xc,%esp
80107903:	68 74 85 10 80       	push   $0x80108574
80107908:	e8 93 8d ff ff       	call   801006a0 <cprintf>
8010790d:	83 c4 10             	add    $0x10,%esp
  return 0;
80107910:	31 c0                	xor    %eax,%eax
    cprintf("\t-Cannot remap in place and flag specified no move. No remap\n");
80107912:	eb e1                	jmp    801078f5 <sys_wremap+0x115>
    cprintf("\t-Valid for in place\n");
80107914:	83 ec 0c             	sub    $0xc,%esp
80107917:	68 a8 84 10 80       	push   $0x801084a8
8010791c:	e8 7f 8d ff ff       	call   801006a0 <cprintf>
80107921:	83 c4 10             	add    $0x10,%esp
  return 0;
80107924:	31 c0                	xor    %eax,%eax
80107926:	eb cd                	jmp    801078f5 <sys_wremap+0x115>
80107928:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010792f:	90                   	nop

80107930 <sys_getpgdirinfo>:

int sys_getpgdirinfo(void) {
80107930:	55                   	push   %ebp
80107931:	89 e5                	mov    %esp,%ebp
80107933:	83 ec 1c             	sub    $0x1c,%esp
struct pgdirinfo* pdinfo;
if (argptr(0, (void*)&pdinfo, sizeof(struct pgdirinfo)) < 0) {
80107936:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107939:	68 04 01 00 00       	push   $0x104
8010793e:	50                   	push   %eax
8010793f:	6a 00                	push   $0x0
80107941:	e8 6a d0 ff ff       	call   801049b0 <argptr>
   return -1;
}

  return 0;
}
80107946:	c9                   	leave  
if (argptr(0, (void*)&pdinfo, sizeof(struct pgdirinfo)) < 0) {
80107947:	c1 f8 1f             	sar    $0x1f,%eax
}
8010794a:	c3                   	ret    
8010794b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010794f:	90                   	nop

80107950 <sys_getwmapinfo>:

int sys_getwmapinfo(void) {
80107950:	55                   	push   %ebp
80107951:	89 e5                	mov    %esp,%ebp
80107953:	56                   	push   %esi
80107954:	53                   	push   %ebx
  struct wmapinfo* wminfo;
  if (argptr(0, (void*)&wminfo, sizeof(struct wmapinfo)) < 0) {
80107955:	8d 45 f4             	lea    -0xc(%ebp),%eax
int sys_getwmapinfo(void) {
80107958:	83 ec 14             	sub    $0x14,%esp
  if (argptr(0, (void*)&wminfo, sizeof(struct wmapinfo)) < 0) {
8010795b:	68 c4 00 00 00       	push   $0xc4
80107960:	50                   	push   %eax
80107961:	6a 00                	push   $0x0
80107963:	e8 48 d0 ff ff       	call   801049b0 <argptr>
80107968:	83 c4 10             	add    $0x10,%esp
8010796b:	85 c0                	test   %eax,%eax
8010796d:	78 58                	js     801079c7 <sys_getwmapinfo+0x77>
   return -1;
  }
  struct proc *p = myproc();
8010796f:	e8 3c c0 ff ff       	call   801039b0 <myproc>
  if(wminfo == 0 || p == 0){
80107974:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107977:	85 d2                	test   %edx,%edx
80107979:	74 4c                	je     801079c7 <sys_getwmapinfo+0x77>
8010797b:	85 c0                	test   %eax,%eax
8010797d:	74 48                	je     801079c7 <sys_getwmapinfo+0x77>
    return -1;
  }
  wminfo->total_mmaps =p->n_mmaps;
8010797f:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
80107985:	8d 98 8c 00 00 00    	lea    0x8c(%eax),%ebx
8010798b:	89 0a                	mov    %ecx,(%edx)
  for(int i = 0; i < MAX_WMMAP_INFO; ++i){
8010798d:	8b 75 f4             	mov    -0xc(%ebp),%esi
80107990:	8d 48 7c             	lea    0x7c(%eax),%ecx
80107993:	8d 56 04             	lea    0x4(%esi),%edx
80107996:	8d b0 7c 05 00 00    	lea    0x57c(%eax),%esi
8010799c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wminfo->addr[i] = p->addr[i].va;
801079a0:	8b 01                	mov    (%ecx),%eax
  for(int i = 0; i < MAX_WMMAP_INFO; ++i){
801079a2:	83 c1 50             	add    $0x50,%ecx
801079a5:	83 c2 04             	add    $0x4,%edx
801079a8:	83 c3 54             	add    $0x54,%ebx
    wminfo->addr[i] = p->addr[i].va;
801079ab:	89 42 fc             	mov    %eax,-0x4(%edx)
    wminfo->length[i] = p->addr[i].size;
801079ae:	8b 41 b4             	mov    -0x4c(%ecx),%eax
801079b1:	89 42 3c             	mov    %eax,0x3c(%edx)
    wminfo->n_loaded_pages[i] = p->addr[i].phys_page_used[i];
801079b4:	8b 43 ac             	mov    -0x54(%ebx),%eax
801079b7:	89 42 7c             	mov    %eax,0x7c(%edx)
  for(int i = 0; i < MAX_WMMAP_INFO; ++i){
801079ba:	39 f1                	cmp    %esi,%ecx
801079bc:	75 e2                	jne    801079a0 <sys_getwmapinfo+0x50>
    // cprintf("loaded pages[%d]: %d\n",i, p->addr[i].phys_page_used[i]);
  }
  return 0;
801079be:	31 c0                	xor    %eax,%eax
801079c0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801079c3:	5b                   	pop    %ebx
801079c4:	5e                   	pop    %esi
801079c5:	5d                   	pop    %ebp
801079c6:	c3                   	ret    
   return -1;
801079c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801079cc:	eb f2                	jmp    801079c0 <sys_getwmapinfo+0x70>
