
build/manux.bin:     file format elf32-i386


Disassembly of section .text:

00200000 <_start-0xc>:
  200000:	02 b0 ad 1b 03 00    	add    0x31bad(%eax),%dh
  200006:	00 00                	add    %al,(%eax)
  200008:	fb                   	sti
  200009:	4f                   	dec    %edi
  20000a:	52                   	push   %edx
  20000b:	e4                   	.byte 0xe4

0020000c <_start>:
  20000c:	fa                   	cli
  20000d:	bc 00 b0 21 00       	mov    $0x21b000,%esp
  200012:	e8 8f 04 00 00       	call   2004a6 <kernel_main>
  200017:	f4                   	hlt

00200018 <inb>:
  200018:	83 ec 14             	sub    $0x14,%esp
  20001b:	8b 44 24 18          	mov    0x18(%esp),%eax
  20001f:	66 89 04 24          	mov    %ax,(%esp)
  200023:	0f b7 04 24          	movzwl (%esp),%eax
  200027:	89 c2                	mov    %eax,%edx
  200029:	ec                   	in     (%dx),%al
  20002a:	88 44 24 13          	mov    %al,0x13(%esp)
  20002e:	0f b6 44 24 13       	movzbl 0x13(%esp),%eax
  200033:	83 c4 14             	add    $0x14,%esp
  200036:	c3                   	ret

00200037 <outb>:
  200037:	83 ec 08             	sub    $0x8,%esp
  20003a:	8b 54 24 0c          	mov    0xc(%esp),%edx
  20003e:	8b 44 24 10          	mov    0x10(%esp),%eax
  200042:	66 89 54 24 04       	mov    %dx,0x4(%esp)
  200047:	88 04 24             	mov    %al,(%esp)
  20004a:	0f b6 04 24          	movzbl (%esp),%eax
  20004e:	0f b7 54 24 04       	movzwl 0x4(%esp),%edx
  200053:	ee                   	out    %al,(%dx)
  200054:	90                   	nop
  200055:	83 c4 08             	add    $0x8,%esp
  200058:	c3                   	ret

00200059 <inw>:
  200059:	83 ec 14             	sub    $0x14,%esp
  20005c:	8b 44 24 18          	mov    0x18(%esp),%eax
  200060:	66 89 04 24          	mov    %ax,(%esp)
  200064:	0f b7 04 24          	movzwl (%esp),%eax
  200068:	89 c2                	mov    %eax,%edx
  20006a:	66 ed                	in     (%dx),%ax
  20006c:	66 89 44 24 12       	mov    %ax,0x12(%esp)
  200071:	0f b7 44 24 12       	movzwl 0x12(%esp),%eax
  200076:	83 c4 14             	add    $0x14,%esp
  200079:	c3                   	ret

0020007a <outw>:
  20007a:	83 ec 08             	sub    $0x8,%esp
  20007d:	8b 54 24 0c          	mov    0xc(%esp),%edx
  200081:	8b 44 24 10          	mov    0x10(%esp),%eax
  200085:	66 89 54 24 04       	mov    %dx,0x4(%esp)
  20008a:	66 89 04 24          	mov    %ax,(%esp)
  20008e:	0f b7 04 24          	movzwl (%esp),%eax
  200092:	0f b7 54 24 04       	movzwl 0x4(%esp),%edx
  200097:	66 ef                	out    %ax,(%dx)
  200099:	90                   	nop
  20009a:	83 c4 08             	add    $0x8,%esp
  20009d:	c3                   	ret

0020009e <ide_wait>:
  20009e:	90                   	nop
  20009f:	68 f7 01 00 00       	push   $0x1f7
  2000a4:	e8 6f ff ff ff       	call   200018 <inb>
  2000a9:	83 c4 04             	add    $0x4,%esp
  2000ac:	84 c0                	test   %al,%al
  2000ae:	78 ef                	js     20009f <ide_wait+0x1>
  2000b0:	90                   	nop
  2000b1:	68 f7 01 00 00       	push   $0x1f7
  2000b6:	e8 5d ff ff ff       	call   200018 <inb>
  2000bb:	83 c4 04             	add    $0x4,%esp
  2000be:	0f b6 c0             	movzbl %al,%eax
  2000c1:	83 e0 08             	and    $0x8,%eax
  2000c4:	85 c0                	test   %eax,%eax
  2000c6:	74 e9                	je     2000b1 <ide_wait+0x13>
  2000c8:	90                   	nop
  2000c9:	90                   	nop
  2000ca:	c3                   	ret

002000cb <ide_read_sector>:
  2000cb:	53                   	push   %ebx
  2000cc:	83 ec 10             	sub    $0x10,%esp
  2000cf:	8b 44 24 18          	mov    0x18(%esp),%eax
  2000d3:	c1 e8 18             	shr    $0x18,%eax
  2000d6:	83 e0 0f             	and    $0xf,%eax
  2000d9:	83 c8 e0             	or     $0xffffffe0,%eax
  2000dc:	0f b6 c0             	movzbl %al,%eax
  2000df:	50                   	push   %eax
  2000e0:	68 f6 01 00 00       	push   $0x1f6
  2000e5:	e8 4d ff ff ff       	call   200037 <outb>
  2000ea:	83 c4 08             	add    $0x8,%esp
  2000ed:	6a 01                	push   $0x1
  2000ef:	68 f2 01 00 00       	push   $0x1f2
  2000f4:	e8 3e ff ff ff       	call   200037 <outb>
  2000f9:	83 c4 08             	add    $0x8,%esp
  2000fc:	8b 44 24 18          	mov    0x18(%esp),%eax
  200100:	0f b6 c0             	movzbl %al,%eax
  200103:	50                   	push   %eax
  200104:	68 f3 01 00 00       	push   $0x1f3
  200109:	e8 29 ff ff ff       	call   200037 <outb>
  20010e:	83 c4 08             	add    $0x8,%esp
  200111:	8b 44 24 18          	mov    0x18(%esp),%eax
  200115:	c1 e8 08             	shr    $0x8,%eax
  200118:	0f b6 c0             	movzbl %al,%eax
  20011b:	50                   	push   %eax
  20011c:	68 f4 01 00 00       	push   $0x1f4
  200121:	e8 11 ff ff ff       	call   200037 <outb>
  200126:	83 c4 08             	add    $0x8,%esp
  200129:	8b 44 24 18          	mov    0x18(%esp),%eax
  20012d:	c1 e8 10             	shr    $0x10,%eax
  200130:	0f b6 c0             	movzbl %al,%eax
  200133:	50                   	push   %eax
  200134:	68 f5 01 00 00       	push   $0x1f5
  200139:	e8 f9 fe ff ff       	call   200037 <outb>
  20013e:	83 c4 08             	add    $0x8,%esp
  200141:	6a 20                	push   $0x20
  200143:	68 f7 01 00 00       	push   $0x1f7
  200148:	e8 ea fe ff ff       	call   200037 <outb>
  20014d:	83 c4 08             	add    $0x8,%esp
  200150:	e8 49 ff ff ff       	call   20009e <ide_wait>
  200155:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  20015c:	00 
  20015d:	eb 23                	jmp    200182 <ide_read_sector+0xb7>
  20015f:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200163:	8d 14 00             	lea    (%eax,%eax,1),%edx
  200166:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  20016a:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  20016d:	68 f0 01 00 00       	push   $0x1f0
  200172:	e8 e2 fe ff ff       	call   200059 <inw>
  200177:	83 c4 04             	add    $0x4,%esp
  20017a:	66 89 03             	mov    %ax,(%ebx)
  20017d:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
  200182:	81 7c 24 0c ff 00 00 	cmpl   $0xff,0xc(%esp)
  200189:	00 
  20018a:	7e d3                	jle    20015f <ide_read_sector+0x94>
  20018c:	90                   	nop
  20018d:	90                   	nop
  20018e:	83 c4 10             	add    $0x10,%esp
  200191:	5b                   	pop    %ebx
  200192:	c3                   	ret

00200193 <ide_write_sector>:
  200193:	83 ec 10             	sub    $0x10,%esp
  200196:	8b 44 24 14          	mov    0x14(%esp),%eax
  20019a:	c1 e8 18             	shr    $0x18,%eax
  20019d:	83 e0 0f             	and    $0xf,%eax
  2001a0:	83 c8 e0             	or     $0xffffffe0,%eax
  2001a3:	0f b6 c0             	movzbl %al,%eax
  2001a6:	50                   	push   %eax
  2001a7:	68 f6 01 00 00       	push   $0x1f6
  2001ac:	e8 86 fe ff ff       	call   200037 <outb>
  2001b1:	83 c4 08             	add    $0x8,%esp
  2001b4:	6a 01                	push   $0x1
  2001b6:	68 f2 01 00 00       	push   $0x1f2
  2001bb:	e8 77 fe ff ff       	call   200037 <outb>
  2001c0:	83 c4 08             	add    $0x8,%esp
  2001c3:	8b 44 24 14          	mov    0x14(%esp),%eax
  2001c7:	0f b6 c0             	movzbl %al,%eax
  2001ca:	50                   	push   %eax
  2001cb:	68 f3 01 00 00       	push   $0x1f3
  2001d0:	e8 62 fe ff ff       	call   200037 <outb>
  2001d5:	83 c4 08             	add    $0x8,%esp
  2001d8:	8b 44 24 14          	mov    0x14(%esp),%eax
  2001dc:	c1 e8 08             	shr    $0x8,%eax
  2001df:	0f b6 c0             	movzbl %al,%eax
  2001e2:	50                   	push   %eax
  2001e3:	68 f4 01 00 00       	push   $0x1f4
  2001e8:	e8 4a fe ff ff       	call   200037 <outb>
  2001ed:	83 c4 08             	add    $0x8,%esp
  2001f0:	8b 44 24 14          	mov    0x14(%esp),%eax
  2001f4:	c1 e8 10             	shr    $0x10,%eax
  2001f7:	0f b6 c0             	movzbl %al,%eax
  2001fa:	50                   	push   %eax
  2001fb:	68 f5 01 00 00       	push   $0x1f5
  200200:	e8 32 fe ff ff       	call   200037 <outb>
  200205:	83 c4 08             	add    $0x8,%esp
  200208:	6a 30                	push   $0x30
  20020a:	68 f7 01 00 00       	push   $0x1f7
  20020f:	e8 23 fe ff ff       	call   200037 <outb>
  200214:	83 c4 08             	add    $0x8,%esp
  200217:	e8 82 fe ff ff       	call   20009e <ide_wait>
  20021c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  200223:	00 
  200224:	eb 26                	jmp    20024c <ide_write_sector+0xb9>
  200226:	8b 44 24 0c          	mov    0xc(%esp),%eax
  20022a:	8d 14 00             	lea    (%eax,%eax,1),%edx
  20022d:	8b 44 24 18          	mov    0x18(%esp),%eax
  200231:	01 d0                	add    %edx,%eax
  200233:	0f b7 00             	movzwl (%eax),%eax
  200236:	0f b7 c0             	movzwl %ax,%eax
  200239:	50                   	push   %eax
  20023a:	68 f0 01 00 00       	push   $0x1f0
  20023f:	e8 36 fe ff ff       	call   20007a <outw>
  200244:	83 c4 08             	add    $0x8,%esp
  200247:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
  20024c:	81 7c 24 0c ff 00 00 	cmpl   $0xff,0xc(%esp)
  200253:	00 
  200254:	7e d0                	jle    200226 <ide_write_sector+0x93>
  200256:	68 e7 00 00 00       	push   $0xe7
  20025b:	68 f7 01 00 00       	push   $0x1f7
  200260:	e8 d2 fd ff ff       	call   200037 <outb>
  200265:	83 c4 08             	add    $0x8,%esp
  200268:	90                   	nop
  200269:	83 c4 10             	add    $0x10,%esp
  20026c:	c3                   	ret

0020026d <write_multiple>:
  20026d:	83 ec 14             	sub    $0x14,%esp
  200270:	8b 44 24 20          	mov    0x20(%esp),%eax
  200274:	88 04 24             	mov    %al,(%esp)
  200277:	c6 44 24 13 00       	movb   $0x0,0x13(%esp)
  20027c:	eb 31                	jmp    2002af <write_multiple+0x42>
  20027e:	0f b6 44 24 13       	movzbl 0x13(%esp),%eax
  200283:	c1 e0 09             	shl    $0x9,%eax
  200286:	89 c2                	mov    %eax,%edx
  200288:	8b 44 24 18          	mov    0x18(%esp),%eax
  20028c:	01 c2                	add    %eax,%edx
  20028e:	0f b6 4c 24 13       	movzbl 0x13(%esp),%ecx
  200293:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  200297:	01 c8                	add    %ecx,%eax
  200299:	52                   	push   %edx
  20029a:	50                   	push   %eax
  20029b:	e8 f3 fe ff ff       	call   200193 <ide_write_sector>
  2002a0:	83 c4 08             	add    $0x8,%esp
  2002a3:	0f b6 44 24 13       	movzbl 0x13(%esp),%eax
  2002a8:	83 c0 01             	add    $0x1,%eax
  2002ab:	88 44 24 13          	mov    %al,0x13(%esp)
  2002af:	0f b6 44 24 13       	movzbl 0x13(%esp),%eax
  2002b4:	3a 04 24             	cmp    (%esp),%al
  2002b7:	72 c5                	jb     20027e <write_multiple+0x11>
  2002b9:	b8 00 00 00 00       	mov    $0x0,%eax
  2002be:	83 c4 14             	add    $0x14,%esp
  2002c1:	c3                   	ret

002002c2 <read_multiple>:
  2002c2:	83 ec 14             	sub    $0x14,%esp
  2002c5:	8b 44 24 20          	mov    0x20(%esp),%eax
  2002c9:	88 04 24             	mov    %al,(%esp)
  2002cc:	c6 44 24 13 00       	movb   $0x0,0x13(%esp)
  2002d1:	eb 31                	jmp    200304 <read_multiple+0x42>
  2002d3:	0f b6 44 24 13       	movzbl 0x13(%esp),%eax
  2002d8:	c1 e0 09             	shl    $0x9,%eax
  2002db:	89 c2                	mov    %eax,%edx
  2002dd:	8b 44 24 18          	mov    0x18(%esp),%eax
  2002e1:	01 c2                	add    %eax,%edx
  2002e3:	0f b6 4c 24 13       	movzbl 0x13(%esp),%ecx
  2002e8:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2002ec:	01 c8                	add    %ecx,%eax
  2002ee:	52                   	push   %edx
  2002ef:	50                   	push   %eax
  2002f0:	e8 d6 fd ff ff       	call   2000cb <ide_read_sector>
  2002f5:	83 c4 08             	add    $0x8,%esp
  2002f8:	0f b6 44 24 13       	movzbl 0x13(%esp),%eax
  2002fd:	83 c0 01             	add    $0x1,%eax
  200300:	88 44 24 13          	mov    %al,0x13(%esp)
  200304:	0f b6 44 24 13       	movzbl 0x13(%esp),%eax
  200309:	3a 04 24             	cmp    (%esp),%al
  20030c:	72 c5                	jb     2002d3 <read_multiple+0x11>
  20030e:	b8 00 00 00 00       	mov    $0x0,%eax
  200313:	83 c4 14             	add    $0x14,%esp
  200316:	c3                   	ret

00200317 <disk_status>:
  200317:	83 ec 04             	sub    $0x4,%esp
  20031a:	8b 44 24 08          	mov    0x8(%esp),%eax
  20031e:	88 04 24             	mov    %al,(%esp)
  200321:	80 3c 24 00          	cmpb   $0x0,(%esp)
  200325:	74 07                	je     20032e <disk_status+0x17>
  200327:	b8 01 00 00 00       	mov    $0x1,%eax
  20032c:	eb 05                	jmp    200333 <disk_status+0x1c>
  20032e:	b8 00 00 00 00       	mov    $0x0,%eax
  200333:	83 c4 04             	add    $0x4,%esp
  200336:	c3                   	ret

00200337 <disk_initialize>:
  200337:	83 ec 04             	sub    $0x4,%esp
  20033a:	8b 44 24 08          	mov    0x8(%esp),%eax
  20033e:	88 04 24             	mov    %al,(%esp)
  200341:	80 3c 24 00          	cmpb   $0x0,(%esp)
  200345:	74 07                	je     20034e <disk_initialize+0x17>
  200347:	b8 01 00 00 00       	mov    $0x1,%eax
  20034c:	eb 05                	jmp    200353 <disk_initialize+0x1c>
  20034e:	b8 00 00 00 00       	mov    $0x0,%eax
  200353:	83 c4 04             	add    $0x4,%esp
  200356:	c3                   	ret

00200357 <disk_read>:
  200357:	83 ec 04             	sub    $0x4,%esp
  20035a:	8b 44 24 08          	mov    0x8(%esp),%eax
  20035e:	88 04 24             	mov    %al,(%esp)
  200361:	80 3c 24 00          	cmpb   $0x0,(%esp)
  200365:	74 07                	je     20036e <disk_read+0x17>
  200367:	b8 04 00 00 00       	mov    $0x4,%eax
  20036c:	eb 28                	jmp    200396 <disk_read+0x3f>
  20036e:	8b 44 24 14          	mov    0x14(%esp),%eax
  200372:	0f b6 c0             	movzbl %al,%eax
  200375:	50                   	push   %eax
  200376:	ff 74 24 14          	push   0x14(%esp)
  20037a:	ff 74 24 14          	push   0x14(%esp)
  20037e:	e8 3f ff ff ff       	call   2002c2 <read_multiple>
  200383:	83 c4 0c             	add    $0xc,%esp
  200386:	85 c0                	test   %eax,%eax
  200388:	74 07                	je     200391 <disk_read+0x3a>
  20038a:	b8 01 00 00 00       	mov    $0x1,%eax
  20038f:	eb 05                	jmp    200396 <disk_read+0x3f>
  200391:	b8 00 00 00 00       	mov    $0x0,%eax
  200396:	83 c4 04             	add    $0x4,%esp
  200399:	c3                   	ret

0020039a <disk_write>:
  20039a:	83 ec 04             	sub    $0x4,%esp
  20039d:	8b 44 24 08          	mov    0x8(%esp),%eax
  2003a1:	88 04 24             	mov    %al,(%esp)
  2003a4:	80 3c 24 00          	cmpb   $0x0,(%esp)
  2003a8:	74 07                	je     2003b1 <disk_write+0x17>
  2003aa:	b8 04 00 00 00       	mov    $0x4,%eax
  2003af:	eb 28                	jmp    2003d9 <disk_write+0x3f>
  2003b1:	8b 44 24 14          	mov    0x14(%esp),%eax
  2003b5:	0f b6 c0             	movzbl %al,%eax
  2003b8:	50                   	push   %eax
  2003b9:	ff 74 24 14          	push   0x14(%esp)
  2003bd:	ff 74 24 14          	push   0x14(%esp)
  2003c1:	e8 a7 fe ff ff       	call   20026d <write_multiple>
  2003c6:	83 c4 0c             	add    $0xc,%esp
  2003c9:	85 c0                	test   %eax,%eax
  2003cb:	74 07                	je     2003d4 <disk_write+0x3a>
  2003cd:	b8 01 00 00 00       	mov    $0x1,%eax
  2003d2:	eb 05                	jmp    2003d9 <disk_write+0x3f>
  2003d4:	b8 00 00 00 00       	mov    $0x0,%eax
  2003d9:	83 c4 04             	add    $0x4,%esp
  2003dc:	c3                   	ret

002003dd <disk_ioctl>:
  2003dd:	83 ec 08             	sub    $0x8,%esp
  2003e0:	8b 54 24 0c          	mov    0xc(%esp),%edx
  2003e4:	8b 44 24 10          	mov    0x10(%esp),%eax
  2003e8:	88 54 24 04          	mov    %dl,0x4(%esp)
  2003ec:	88 04 24             	mov    %al,(%esp)
  2003ef:	0f b6 04 24          	movzbl (%esp),%eax
  2003f3:	83 f8 03             	cmp    $0x3,%eax
  2003f6:	74 31                	je     200429 <disk_ioctl+0x4c>
  2003f8:	83 f8 03             	cmp    $0x3,%eax
  2003fb:	7f 4e                	jg     20044b <disk_ioctl+0x6e>
  2003fd:	83 f8 02             	cmp    $0x2,%eax
  200400:	74 17                	je     200419 <disk_ioctl+0x3c>
  200402:	83 f8 02             	cmp    $0x2,%eax
  200405:	7f 44                	jg     20044b <disk_ioctl+0x6e>
  200407:	85 c0                	test   %eax,%eax
  200409:	74 07                	je     200412 <disk_ioctl+0x35>
  20040b:	83 f8 01             	cmp    $0x1,%eax
  20040e:	74 2a                	je     20043a <disk_ioctl+0x5d>
  200410:	eb 39                	jmp    20044b <disk_ioctl+0x6e>
  200412:	b8 00 00 00 00       	mov    $0x0,%eax
  200417:	eb 37                	jmp    200450 <disk_ioctl+0x73>
  200419:	8b 44 24 14          	mov    0x14(%esp),%eax
  20041d:	66 c7 00 00 02       	movw   $0x200,(%eax)
  200422:	b8 00 00 00 00       	mov    $0x0,%eax
  200427:	eb 27                	jmp    200450 <disk_ioctl+0x73>
  200429:	8b 44 24 14          	mov    0x14(%esp),%eax
  20042d:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  200433:	b8 00 00 00 00       	mov    $0x0,%eax
  200438:	eb 16                	jmp    200450 <disk_ioctl+0x73>
  20043a:	8b 44 24 14          	mov    0x14(%esp),%eax
  20043e:	c7 00 00 f8 01 00    	movl   $0x1f800,(%eax)
  200444:	b8 00 00 00 00       	mov    $0x0,%eax
  200449:	eb 05                	jmp    200450 <disk_ioctl+0x73>
  20044b:	b8 04 00 00 00       	mov    $0x4,%eax
  200450:	83 c4 08             	add    $0x8,%esp
  200453:	c3                   	ret

00200454 <inb>:
  200454:	83 ec 14             	sub    $0x14,%esp
  200457:	8b 44 24 18          	mov    0x18(%esp),%eax
  20045b:	66 89 04 24          	mov    %ax,(%esp)
  20045f:	0f b7 04 24          	movzwl (%esp),%eax
  200463:	89 c2                	mov    %eax,%edx
  200465:	ec                   	in     (%dx),%al
  200466:	88 44 24 13          	mov    %al,0x13(%esp)
  20046a:	0f b6 44 24 13       	movzbl 0x13(%esp),%eax
  20046f:	83 c4 14             	add    $0x14,%esp
  200472:	c3                   	ret

00200473 <outb>:
  200473:	83 ec 08             	sub    $0x8,%esp
  200476:	8b 54 24 0c          	mov    0xc(%esp),%edx
  20047a:	8b 44 24 10          	mov    0x10(%esp),%eax
  20047e:	66 89 54 24 04       	mov    %dx,0x4(%esp)
  200483:	88 04 24             	mov    %al,(%esp)
  200486:	0f b6 04 24          	movzbl (%esp),%eax
  20048a:	0f b7 54 24 04       	movzwl 0x4(%esp),%edx
  20048f:	ee                   	out    %al,(%dx)
  200490:	90                   	nop
  200491:	83 c4 08             	add    $0x8,%esp
  200494:	c3                   	ret

00200495 <io_wait>:
  200495:	6a 00                	push   $0x0
  200497:	68 80 00 00 00       	push   $0x80
  20049c:	e8 d2 ff ff ff       	call   200473 <outb>
  2004a1:	83 c4 08             	add    $0x8,%esp
  2004a4:	90                   	nop
  2004a5:	c3                   	ret

002004a6 <kernel_main>:
  2004a6:	57                   	push   %edi
  2004a7:	83 ec 78             	sub    $0x78,%esp
  2004aa:	e8 be 5b 00 00       	call   20606d <video_init>
  2004af:	c7 44 24 4c 4d 61 6e 	movl   $0x756e614d,0x4c(%esp)
  2004b6:	75 
  2004b7:	c7 44 24 50 78 20 4b 	movl   $0x654b2078,0x50(%esp)
  2004be:	65 
  2004bf:	c7 44 24 54 72 6e 65 	movl   $0x6c656e72,0x54(%esp)
  2004c6:	6c 
  2004c7:	c7 44 24 58 20 00 00 	movl   $0x20,0x58(%esp)
  2004ce:	00 
  2004cf:	c7 44 24 5c 00 00 00 	movl   $0x0,0x5c(%esp)
  2004d6:	00 
  2004d7:	c7 44 24 60 00 00 00 	movl   $0x0,0x60(%esp)
  2004de:	00 
  2004df:	c7 44 24 64 00 00 00 	movl   $0x0,0x64(%esp)
  2004e6:	00 
  2004e7:	c7 44 24 68 00 00 00 	movl   $0x0,0x68(%esp)
  2004ee:	00 
  2004ef:	83 ec 08             	sub    $0x8,%esp
  2004f2:	68 00 70 20 00       	push   $0x207000
  2004f7:	8d 44 24 58          	lea    0x58(%esp),%eax
  2004fb:	50                   	push   %eax
  2004fc:	e8 2b 68 00 00       	call   206d2c <strcat>
  200501:	83 c4 10             	add    $0x10,%esp
  200504:	83 ec 08             	sub    $0x8,%esp
  200507:	68 07 70 20 00       	push   $0x207007
  20050c:	8d 44 24 58          	lea    0x58(%esp),%eax
  200510:	50                   	push   %eax
  200511:	e8 16 68 00 00       	call   206d2c <strcat>
  200516:	83 c4 10             	add    $0x10,%esp
  200519:	83 ec 0c             	sub    $0xc,%esp
  20051c:	8d 44 24 58          	lea    0x58(%esp),%eax
  200520:	50                   	push   %eax
  200521:	e8 4f 66 00 00       	call   206b75 <printk>
  200526:	83 c4 10             	add    $0x10,%esp
  200529:	e8 05 04 00 00       	call   200933 <idt_init>
  20052e:	e8 f2 02 00 00       	call   200825 <pic_remap>
  200533:	68 8e 00 00 00       	push   $0x8e
  200538:	6a 10                	push   $0x10
  20053a:	68 ca 6a 20 00       	push   $0x206aca
  20053f:	68 80 00 00 00       	push   $0x80
  200544:	e8 41 05 00 00       	call   200a8a <set_idt_gate>
  200549:	83 c4 10             	add    $0x10,%esp
  20054c:	68 8e 00 00 00       	push   $0x8e
  200551:	6a 10                	push   $0x10
  200553:	68 b4 6a 20 00       	push   $0x206ab4
  200558:	6a 21                	push   $0x21
  20055a:	e8 2b 05 00 00       	call   200a8a <set_idt_gate>
  20055f:	83 c4 10             	add    $0x10,%esp
  200562:	fb                   	sti
  200563:	83 ec 0c             	sub    $0xc,%esp
  200566:	68 09 70 20 00       	push   $0x207009
  20056b:	e8 05 66 00 00       	call   206b75 <printk>
  200570:	83 c4 10             	add    $0x10,%esp
  200573:	e8 98 65 00 00       	call   206b10 <test_syscall>
  200578:	83 ec 04             	sub    $0x4,%esp
  20057b:	6a 01                	push   $0x1
  20057d:	68 22 70 20 00       	push   $0x207022
  200582:	68 20 b8 21 00       	push   $0x21b820
  200587:	e8 16 3d 00 00       	call   2042a2 <f_mount>
  20058c:	83 c4 10             	add    $0x10,%esp
  20058f:	89 44 24 6c          	mov    %eax,0x6c(%esp)
  200593:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  200598:	74 15                	je     2005af <kernel_main+0x109>
  20059a:	83 ec 0c             	sub    $0xc,%esp
  20059d:	68 24 70 20 00       	push   $0x207024
  2005a2:	e8 ce 65 00 00       	call   206b75 <printk>
  2005a7:	83 c4 10             	add    $0x10,%esp
  2005aa:	e8 59 05 00 00       	call   200b08 <kernel_panic>
  2005af:	83 ec 0c             	sub    $0xc,%esp
  2005b2:	68 41 70 20 00       	push   $0x207041
  2005b7:	e8 b9 65 00 00       	call   206b75 <printk>
  2005bc:	83 c4 10             	add    $0x10,%esp
  2005bf:	83 ec 0c             	sub    $0xc,%esp
  2005c2:	68 54 70 20 00       	push   $0x207054
  2005c7:	e8 a9 65 00 00       	call   206b75 <printk>
  2005cc:	83 c4 10             	add    $0x10,%esp
  2005cf:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%esp)
  2005d6:	00 
  2005d7:	c7 44 24 30 00 00 00 	movl   $0x0,0x30(%esp)
  2005de:	00 
  2005df:	c7 44 24 34 00 00 00 	movl   $0x0,0x34(%esp)
  2005e6:	00 
  2005e7:	c7 44 24 38 00 00 00 	movl   $0x0,0x38(%esp)
  2005ee:	00 
  2005ef:	c7 44 24 3c 00 00 00 	movl   $0x0,0x3c(%esp)
  2005f6:	00 
  2005f7:	c7 44 24 40 00 00 00 	movl   $0x0,0x40(%esp)
  2005fe:	00 
  2005ff:	c7 44 24 44 00 00 00 	movl   $0x0,0x44(%esp)
  200606:	00 
  200607:	c7 44 24 48 00 00 00 	movl   $0x0,0x48(%esp)
  20060e:	00 
  20060f:	8d 54 24 04          	lea    0x4(%esp),%edx
  200613:	b8 00 00 00 00       	mov    $0x0,%eax
  200618:	b9 0a 00 00 00       	mov    $0xa,%ecx
  20061d:	89 d7                	mov    %edx,%edi
  20061f:	f3 ab                	rep stos %eax,%es:(%edi)
  200621:	83 ec 0c             	sub    $0xc,%esp
  200624:	68 69 70 20 00       	push   $0x207069
  200629:	e8 47 65 00 00       	call   206b75 <printk>
  20062e:	83 c4 10             	add    $0x10,%esp
  200631:	83 ec 04             	sub    $0x4,%esp
  200634:	6a 01                	push   $0x1
  200636:	68 77 70 20 00       	push   $0x207077
  20063b:	8d 44 24 10          	lea    0x10(%esp),%eax
  20063f:	50                   	push   %eax
  200640:	e8 18 3d 00 00       	call   20435d <f_open>
  200645:	83 c4 10             	add    $0x10,%esp
  200648:	89 44 24 6c          	mov    %eax,0x6c(%esp)
  20064c:	83 ec 0c             	sub    $0xc,%esp
  20064f:	68 81 70 20 00       	push   $0x207081
  200654:	e8 1c 65 00 00       	call   206b75 <printk>
  200659:	83 c4 10             	add    $0x10,%esp
  20065c:	83 ec 0c             	sub    $0xc,%esp
  20065f:	ff 74 24 78          	push   0x78(%esp)
  200663:	e8 b8 65 00 00       	call   206c20 <putlong>
  200668:	83 c4 10             	add    $0x10,%esp
  20066b:	e8 28 5a 00 00       	call   206098 <newline>
  200670:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  200675:	74 15                	je     20068c <kernel_main+0x1e6>
  200677:	83 ec 0c             	sub    $0xc,%esp
  20067a:	68 8e 70 20 00       	push   $0x20708e
  20067f:	e8 f1 64 00 00       	call   206b75 <printk>
  200684:	83 c4 10             	add    $0x10,%esp
  200687:	e8 7c 04 00 00       	call   200b08 <kernel_panic>
  20068c:	89 e0                	mov    %esp,%eax
  20068e:	50                   	push   %eax
  20068f:	6a 20                	push   $0x20
  200691:	8d 44 24 34          	lea    0x34(%esp),%eax
  200695:	50                   	push   %eax
  200696:	8d 44 24 10          	lea    0x10(%esp),%eax
  20069a:	50                   	push   %eax
  20069b:	e8 09 41 00 00       	call   2047a9 <f_read>
  2006a0:	83 c4 10             	add    $0x10,%esp
  2006a3:	89 44 24 6c          	mov    %eax,0x6c(%esp)
  2006a7:	83 ec 0c             	sub    $0xc,%esp
  2006aa:	ff 74 24 78          	push   0x78(%esp)
  2006ae:	e8 6d 65 00 00       	call   206c20 <putlong>
  2006b3:	83 c4 10             	add    $0x10,%esp
  2006b6:	e8 dd 59 00 00       	call   206098 <newline>
  2006bb:	83 ec 0c             	sub    $0xc,%esp
  2006be:	68 a9 70 20 00       	push   $0x2070a9
  2006c3:	e8 96 64 00 00       	call   206b5e <puts>
  2006c8:	83 c4 10             	add    $0x10,%esp
  2006cb:	8b 04 24             	mov    (%esp),%eax
  2006ce:	83 ec 0c             	sub    $0xc,%esp
  2006d1:	50                   	push   %eax
  2006d2:	e8 49 65 00 00       	call   206c20 <putlong>
  2006d7:	83 c4 10             	add    $0x10,%esp
  2006da:	e8 b9 59 00 00       	call   206098 <newline>
  2006df:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  2006e4:	74 15                	je     2006fb <kernel_main+0x255>
  2006e6:	83 ec 0c             	sub    $0xc,%esp
  2006e9:	68 b4 70 20 00       	push   $0x2070b4
  2006ee:	e8 82 64 00 00       	call   206b75 <printk>
  2006f3:	83 c4 10             	add    $0x10,%esp
  2006f6:	e8 0d 04 00 00       	call   200b08 <kernel_panic>
  2006fb:	83 ec 0c             	sub    $0xc,%esp
  2006fe:	8d 44 24 10          	lea    0x10(%esp),%eax
  200702:	50                   	push   %eax
  200703:	e8 08 49 00 00       	call   205010 <f_close>
  200708:	83 c4 10             	add    $0x10,%esp
  20070b:	83 ec 0c             	sub    $0xc,%esp
  20070e:	8d 44 24 38          	lea    0x38(%esp),%eax
  200712:	50                   	push   %eax
  200713:	e8 11 5a 00 00       	call   206129 <prints>
  200718:	83 c4 10             	add    $0x10,%esp
  20071b:	e8 e8 03 00 00       	call   200b08 <kernel_panic>
  200720:	90                   	nop
  200721:	83 c4 78             	add    $0x78,%esp
  200724:	5f                   	pop    %edi
  200725:	c3                   	ret

00200726 <fs_list_root>:
  200726:	81 ec 5c 01 00 00    	sub    $0x15c,%esp
  20072c:	83 ec 0c             	sub    $0xc,%esp
  20072f:	68 cf 70 20 00       	push   $0x2070cf
  200734:	e8 25 64 00 00       	call   206b5e <puts>
  200739:	83 c4 10             	add    $0x10,%esp
  20073c:	83 ec 08             	sub    $0x8,%esp
  20073f:	68 dd 70 20 00       	push   $0x2070dd
  200744:	8d 84 24 28 01 00 00 	lea    0x128(%esp),%eax
  20074b:	50                   	push   %eax
  20074c:	e8 15 4c 00 00       	call   205366 <f_opendir>
  200751:	83 c4 10             	add    $0x10,%esp
  200754:	89 84 24 4c 01 00 00 	mov    %eax,0x14c(%esp)
  20075b:	83 bc 24 4c 01 00 00 	cmpl   $0x0,0x14c(%esp)
  200762:	00 
  200763:	74 27                	je     20078c <fs_list_root+0x66>
  200765:	83 ec 0c             	sub    $0xc,%esp
  200768:	68 de 70 20 00       	push   $0x2070de
  20076d:	e8 ec 63 00 00       	call   206b5e <puts>
  200772:	83 c4 10             	add    $0x10,%esp
  200775:	83 ec 0c             	sub    $0xc,%esp
  200778:	ff b4 24 58 01 00 00 	push   0x158(%esp)
  20077f:	e8 08 64 00 00       	call   206b8c <puth>
  200784:	83 c4 10             	add    $0x10,%esp
  200787:	e9 92 00 00 00       	jmp    20081e <fs_list_root+0xf8>
  20078c:	83 ec 08             	sub    $0x8,%esp
  20078f:	8d 44 24 0c          	lea    0xc(%esp),%eax
  200793:	50                   	push   %eax
  200794:	8d 84 24 28 01 00 00 	lea    0x128(%esp),%eax
  20079b:	50                   	push   %eax
  20079c:	e8 f8 4c 00 00       	call   205499 <f_readdir>
  2007a1:	83 c4 10             	add    $0x10,%esp
  2007a4:	85 c0                	test   %eax,%eax
  2007a6:	75 53                	jne    2007fb <fs_list_root+0xd5>
  2007a8:	0f b6 44 24 1a       	movzbl 0x1a(%esp),%eax
  2007ad:	84 c0                	test   %al,%al
  2007af:	74 4a                	je     2007fb <fs_list_root+0xd5>
  2007b1:	83 ec 0c             	sub    $0xc,%esp
  2007b4:	68 f8 70 20 00       	push   $0x2070f8
  2007b9:	e8 a0 63 00 00       	call   206b5e <puts>
  2007be:	83 c4 10             	add    $0x10,%esp
  2007c1:	83 ec 0c             	sub    $0xc,%esp
  2007c4:	8d 44 24 10          	lea    0x10(%esp),%eax
  2007c8:	83 c0 16             	add    $0x16,%eax
  2007cb:	50                   	push   %eax
  2007cc:	e8 8d 63 00 00       	call   206b5e <puts>
  2007d1:	83 c4 10             	add    $0x10,%esp
  2007d4:	83 ec 0c             	sub    $0xc,%esp
  2007d7:	68 ff 70 20 00       	push   $0x2070ff
  2007dc:	e8 7d 63 00 00       	call   206b5e <puts>
  2007e1:	83 c4 10             	add    $0x10,%esp
  2007e4:	8b 44 24 04          	mov    0x4(%esp),%eax
  2007e8:	83 ec 0c             	sub    $0xc,%esp
  2007eb:	50                   	push   %eax
  2007ec:	e8 2f 64 00 00       	call   206c20 <putlong>
  2007f1:	83 c4 10             	add    $0x10,%esp
  2007f4:	e8 9f 58 00 00       	call   206098 <newline>
  2007f9:	eb 91                	jmp    20078c <fs_list_root+0x66>
  2007fb:	83 ec 0c             	sub    $0xc,%esp
  2007fe:	8d 84 24 28 01 00 00 	lea    0x128(%esp),%eax
  200805:	50                   	push   %eax
  200806:	e8 59 4c 00 00       	call   205464 <f_closedir>
  20080b:	83 c4 10             	add    $0x10,%esp
  20080e:	83 ec 0c             	sub    $0xc,%esp
  200811:	68 07 71 20 00       	push   $0x207107
  200816:	e8 43 63 00 00       	call   206b5e <puts>
  20081b:	83 c4 10             	add    $0x10,%esp
  20081e:	81 c4 5c 01 00 00    	add    $0x15c,%esp
  200824:	c3                   	ret

00200825 <pic_remap>:
  200825:	83 ec 10             	sub    $0x10,%esp
  200828:	6a 20                	push   $0x20
  20082a:	6a 20                	push   $0x20
  20082c:	e8 42 fc ff ff       	call   200473 <outb>
  200831:	83 c4 08             	add    $0x8,%esp
  200834:	e8 5c fc ff ff       	call   200495 <io_wait>
  200839:	6a 20                	push   $0x20
  20083b:	68 a0 00 00 00       	push   $0xa0
  200840:	e8 2e fc ff ff       	call   200473 <outb>
  200845:	83 c4 08             	add    $0x8,%esp
  200848:	c6 44 24 0f 20       	movb   $0x20,0xf(%esp)
  20084d:	c6 44 24 0e 28       	movb   $0x28,0xe(%esp)
  200852:	6a 21                	push   $0x21
  200854:	e8 fb fb ff ff       	call   200454 <inb>
  200859:	83 c4 04             	add    $0x4,%esp
  20085c:	88 44 24 0d          	mov    %al,0xd(%esp)
  200860:	68 a1 00 00 00       	push   $0xa1
  200865:	e8 ea fb ff ff       	call   200454 <inb>
  20086a:	83 c4 04             	add    $0x4,%esp
  20086d:	88 44 24 0c          	mov    %al,0xc(%esp)
  200871:	6a 11                	push   $0x11
  200873:	6a 20                	push   $0x20
  200875:	e8 f9 fb ff ff       	call   200473 <outb>
  20087a:	83 c4 08             	add    $0x8,%esp
  20087d:	e8 13 fc ff ff       	call   200495 <io_wait>
  200882:	6a 11                	push   $0x11
  200884:	68 a0 00 00 00       	push   $0xa0
  200889:	e8 e5 fb ff ff       	call   200473 <outb>
  20088e:	83 c4 08             	add    $0x8,%esp
  200891:	e8 ff fb ff ff       	call   200495 <io_wait>
  200896:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
  20089b:	50                   	push   %eax
  20089c:	6a 21                	push   $0x21
  20089e:	e8 d0 fb ff ff       	call   200473 <outb>
  2008a3:	83 c4 08             	add    $0x8,%esp
  2008a6:	e8 ea fb ff ff       	call   200495 <io_wait>
  2008ab:	0f b6 44 24 0e       	movzbl 0xe(%esp),%eax
  2008b0:	50                   	push   %eax
  2008b1:	68 a1 00 00 00       	push   $0xa1
  2008b6:	e8 b8 fb ff ff       	call   200473 <outb>
  2008bb:	83 c4 08             	add    $0x8,%esp
  2008be:	e8 d2 fb ff ff       	call   200495 <io_wait>
  2008c3:	6a 04                	push   $0x4
  2008c5:	6a 21                	push   $0x21
  2008c7:	e8 a7 fb ff ff       	call   200473 <outb>
  2008cc:	83 c4 08             	add    $0x8,%esp
  2008cf:	e8 c1 fb ff ff       	call   200495 <io_wait>
  2008d4:	6a 02                	push   $0x2
  2008d6:	68 a1 00 00 00       	push   $0xa1
  2008db:	e8 93 fb ff ff       	call   200473 <outb>
  2008e0:	83 c4 08             	add    $0x8,%esp
  2008e3:	e8 ad fb ff ff       	call   200495 <io_wait>
  2008e8:	6a 01                	push   $0x1
  2008ea:	6a 21                	push   $0x21
  2008ec:	e8 82 fb ff ff       	call   200473 <outb>
  2008f1:	83 c4 08             	add    $0x8,%esp
  2008f4:	e8 9c fb ff ff       	call   200495 <io_wait>
  2008f9:	6a 01                	push   $0x1
  2008fb:	68 a1 00 00 00       	push   $0xa1
  200900:	e8 6e fb ff ff       	call   200473 <outb>
  200905:	83 c4 08             	add    $0x8,%esp
  200908:	68 fd 00 00 00       	push   $0xfd
  20090d:	6a 21                	push   $0x21
  20090f:	e8 5f fb ff ff       	call   200473 <outb>
  200914:	83 c4 08             	add    $0x8,%esp
  200917:	e8 79 fb ff ff       	call   200495 <io_wait>
  20091c:	68 ff 00 00 00       	push   $0xff
  200921:	68 a1 00 00 00       	push   $0xa1
  200926:	e8 48 fb ff ff       	call   200473 <outb>
  20092b:	83 c4 08             	add    $0x8,%esp
  20092e:	90                   	nop
  20092f:	83 c4 10             	add    $0x10,%esp
  200932:	c3                   	ret

00200933 <idt_init>:
  200933:	83 ec 1c             	sub    $0x1c,%esp
  200936:	66 c7 05 00 b8 21 00 	movw   $0x7ff,0x21b800
  20093d:	ff 07 
  20093f:	b8 00 b0 21 00       	mov    $0x21b000,%eax
  200944:	a3 02 b8 21 00       	mov    %eax,0x21b802
  200949:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  200950:	00 
  200951:	eb 21                	jmp    200974 <idt_init+0x41>
  200953:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200957:	0f b6 c0             	movzbl %al,%eax
  20095a:	68 8e 00 00 00       	push   $0x8e
  20095f:	6a 10                	push   $0x10
  200961:	68 c0 6a 20 00       	push   $0x206ac0
  200966:	50                   	push   %eax
  200967:	e8 1e 01 00 00       	call   200a8a <set_idt_gate>
  20096c:	83 c4 10             	add    $0x10,%esp
  20096f:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
  200974:	81 7c 24 0c ff 00 00 	cmpl   $0xff,0xc(%esp)
  20097b:	00 
  20097c:	7e d5                	jle    200953 <idt_init+0x20>
  20097e:	68 8e 00 00 00       	push   $0x8e
  200983:	6a 10                	push   $0x10
  200985:	68 c1 6a 20 00       	push   $0x206ac1
  20098a:	6a 08                	push   $0x8
  20098c:	e8 f9 00 00 00       	call   200a8a <set_idt_gate>
  200991:	83 c4 10             	add    $0x10,%esp
  200994:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
  20099b:	00 
  20099c:	eb 21                	jmp    2009bf <idt_init+0x8c>
  20099e:	8b 44 24 08          	mov    0x8(%esp),%eax
  2009a2:	0f b6 c0             	movzbl %al,%eax
  2009a5:	68 8e 00 00 00       	push   $0x8e
  2009aa:	6a 10                	push   $0x10
  2009ac:	68 c1 6a 20 00       	push   $0x206ac1
  2009b1:	50                   	push   %eax
  2009b2:	e8 d3 00 00 00       	call   200a8a <set_idt_gate>
  2009b7:	83 c4 10             	add    $0x10,%esp
  2009ba:	83 44 24 08 01       	addl   $0x1,0x8(%esp)
  2009bf:	83 7c 24 08 0e       	cmpl   $0xe,0x8(%esp)
  2009c4:	7e d8                	jle    20099e <idt_init+0x6b>
  2009c6:	68 8e 00 00 00       	push   $0x8e
  2009cb:	6a 10                	push   $0x10
  2009cd:	68 c1 6a 20 00       	push   $0x206ac1
  2009d2:	6a 11                	push   $0x11
  2009d4:	e8 b1 00 00 00       	call   200a8a <set_idt_gate>
  2009d9:	83 c4 10             	add    $0x10,%esp
  2009dc:	68 8e 00 00 00       	push   $0x8e
  2009e1:	6a 10                	push   $0x10
  2009e3:	68 c1 6a 20 00       	push   $0x206ac1
  2009e8:	6a 15                	push   $0x15
  2009ea:	e8 9b 00 00 00       	call   200a8a <set_idt_gate>
  2009ef:	83 c4 10             	add    $0x10,%esp
  2009f2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  2009f9:	00 
  2009fa:	eb 24                	jmp    200a20 <idt_init+0xed>
  2009fc:	8b 44 24 04          	mov    0x4(%esp),%eax
  200a00:	83 c0 20             	add    $0x20,%eax
  200a03:	0f b6 c0             	movzbl %al,%eax
  200a06:	68 8e 00 00 00       	push   $0x8e
  200a0b:	6a 10                	push   $0x10
  200a0d:	68 c5 6a 20 00       	push   $0x206ac5
  200a12:	50                   	push   %eax
  200a13:	e8 72 00 00 00       	call   200a8a <set_idt_gate>
  200a18:	83 c4 10             	add    $0x10,%esp
  200a1b:	83 44 24 04 01       	addl   $0x1,0x4(%esp)
  200a20:	83 7c 24 04 0f       	cmpl   $0xf,0x4(%esp)
  200a25:	7e d5                	jle    2009fc <idt_init+0xc9>
  200a27:	0f 01 1d 00 b8 21 00 	lidtl  0x21b800
  200a2e:	83 ec 0c             	sub    $0xc,%esp
  200a31:	68 0d 71 20 00       	push   $0x20710d
  200a36:	e8 23 61 00 00       	call   206b5e <puts>
  200a3b:	83 c4 10             	add    $0x10,%esp
  200a3e:	a1 02 b8 21 00       	mov    0x21b802,%eax
  200a43:	83 ec 0c             	sub    $0xc,%esp
  200a46:	50                   	push   %eax
  200a47:	e8 40 61 00 00       	call   206b8c <puth>
  200a4c:	83 c4 10             	add    $0x10,%esp
  200a4f:	83 ec 0c             	sub    $0xc,%esp
  200a52:	68 26 71 20 00       	push   $0x207126
  200a57:	e8 02 61 00 00       	call   206b5e <puts>
  200a5c:	83 c4 10             	add    $0x10,%esp
  200a5f:	0f b7 05 00 b8 21 00 	movzwl 0x21b800,%eax
  200a66:	0f b7 c0             	movzwl %ax,%eax
  200a69:	83 ec 0c             	sub    $0xc,%esp
  200a6c:	50                   	push   %eax
  200a6d:	e8 ae 61 00 00       	call   206c20 <putlong>
  200a72:	83 c4 10             	add    $0x10,%esp
  200a75:	83 ec 0c             	sub    $0xc,%esp
  200a78:	68 32 71 20 00       	push   $0x207132
  200a7d:	e8 f3 60 00 00       	call   206b75 <printk>
  200a82:	83 c4 10             	add    $0x10,%esp
  200a85:	90                   	nop
  200a86:	83 c4 1c             	add    $0x1c,%esp
  200a89:	c3                   	ret

00200a8a <set_idt_gate>:
  200a8a:	83 ec 1c             	sub    $0x1c,%esp
  200a8d:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  200a91:	8b 54 24 28          	mov    0x28(%esp),%edx
  200a95:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  200a99:	88 4c 24 08          	mov    %cl,0x8(%esp)
  200a9d:	66 89 54 24 04       	mov    %dx,0x4(%esp)
  200aa2:	88 04 24             	mov    %al,(%esp)
  200aa5:	8b 44 24 24          	mov    0x24(%esp),%eax
  200aa9:	89 44 24 18          	mov    %eax,0x18(%esp)
  200aad:	0f b6 44 24 08       	movzbl 0x8(%esp),%eax
  200ab2:	8b 54 24 18          	mov    0x18(%esp),%edx
  200ab6:	66 89 14 c5 00 b0 21 	mov    %dx,0x21b000(,%eax,8)
  200abd:	00 
  200abe:	0f b6 44 24 08       	movzbl 0x8(%esp),%eax
  200ac3:	0f b7 54 24 04       	movzwl 0x4(%esp),%edx
  200ac8:	66 89 14 c5 02 b0 21 	mov    %dx,0x21b002(,%eax,8)
  200acf:	00 
  200ad0:	0f b6 44 24 08       	movzbl 0x8(%esp),%eax
  200ad5:	c6 04 c5 04 b0 21 00 	movb   $0x0,0x21b004(,%eax,8)
  200adc:	00 
  200add:	0f b6 44 24 08       	movzbl 0x8(%esp),%eax
  200ae2:	0f b6 14 24          	movzbl (%esp),%edx
  200ae6:	88 14 c5 05 b0 21 00 	mov    %dl,0x21b005(,%eax,8)
  200aed:	8b 44 24 18          	mov    0x18(%esp),%eax
  200af1:	c1 e8 10             	shr    $0x10,%eax
  200af4:	89 c2                	mov    %eax,%edx
  200af6:	0f b6 44 24 08       	movzbl 0x8(%esp),%eax
  200afb:	66 89 14 c5 06 b0 21 	mov    %dx,0x21b006(,%eax,8)
  200b02:	00 
  200b03:	90                   	nop
  200b04:	83 c4 1c             	add    $0x1c,%esp
  200b07:	c3                   	ret

00200b08 <kernel_panic>:
  200b08:	83 ec 4c             	sub    $0x4c,%esp
  200b0b:	83 ec 0c             	sub    $0xc,%esp
  200b0e:	68 39 71 20 00       	push   $0x207139
  200b13:	e8 46 60 00 00       	call   206b5e <puts>
  200b18:	83 c4 10             	add    $0x10,%esp
  200b1b:	89 44 24 3c          	mov    %eax,0x3c(%esp)
  200b1f:	89 4c 24 38          	mov    %ecx,0x38(%esp)
  200b23:	89 54 24 34          	mov    %edx,0x34(%esp)
  200b27:	89 5c 24 30          	mov    %ebx,0x30(%esp)
  200b2b:	89 74 24 2c          	mov    %esi,0x2c(%esp)
  200b2f:	89 7c 24 28          	mov    %edi,0x28(%esp)
  200b33:	89 64 24 24          	mov    %esp,0x24(%esp)
  200b37:	89 6c 24 20          	mov    %ebp,0x20(%esp)
  200b3b:	b8 00 00 00 00       	mov    $0x0,%eax
  200b40:	8c c0                	mov    %es,%eax
  200b42:	89 44 24 18          	mov    %eax,0x18(%esp)
  200b46:	8c d8                	mov    %ds,%eax
  200b48:	89 44 24 14          	mov    %eax,0x14(%esp)
  200b4c:	8c d0                	mov    %ss,%eax
  200b4e:	89 44 24 10          	mov    %eax,0x10(%esp)
  200b52:	8c c8                	mov    %cs,%eax
  200b54:	89 44 24 0c          	mov    %eax,0xc(%esp)
  200b58:	50                   	push   %eax
  200b59:	e8 00 00 00 00       	call   200b5e <dummy>

00200b5e <dummy>:
  200b5e:	58                   	pop    %eax
  200b5f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  200b63:	58                   	pop    %eax
  200b64:	83 ec 0c             	sub    $0xc,%esp
  200b67:	68 49 71 20 00       	push   $0x207149
  200b6c:	e8 ed 5f 00 00       	call   206b5e <puts>
  200b71:	83 c4 10             	add    $0x10,%esp
  200b74:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  200b78:	83 ec 0c             	sub    $0xc,%esp
  200b7b:	50                   	push   %eax
  200b7c:	e8 0b 60 00 00       	call   206b8c <puth>
  200b81:	83 c4 10             	add    $0x10,%esp
  200b84:	83 ec 0c             	sub    $0xc,%esp
  200b87:	68 4f 71 20 00       	push   $0x20714f
  200b8c:	e8 cd 5f 00 00       	call   206b5e <puts>
  200b91:	83 c4 10             	add    $0x10,%esp
  200b94:	8b 44 24 30          	mov    0x30(%esp),%eax
  200b98:	83 ec 0c             	sub    $0xc,%esp
  200b9b:	50                   	push   %eax
  200b9c:	e8 eb 5f 00 00       	call   206b8c <puth>
  200ba1:	83 c4 10             	add    $0x10,%esp
  200ba4:	83 ec 0c             	sub    $0xc,%esp
  200ba7:	68 56 71 20 00       	push   $0x207156
  200bac:	e8 ad 5f 00 00       	call   206b5e <puts>
  200bb1:	83 c4 10             	add    $0x10,%esp
  200bb4:	8b 44 24 38          	mov    0x38(%esp),%eax
  200bb8:	83 ec 0c             	sub    $0xc,%esp
  200bbb:	50                   	push   %eax
  200bbc:	e8 cb 5f 00 00       	call   206b8c <puth>
  200bc1:	83 c4 10             	add    $0x10,%esp
  200bc4:	83 ec 0c             	sub    $0xc,%esp
  200bc7:	68 5d 71 20 00       	push   $0x20715d
  200bcc:	e8 8d 5f 00 00       	call   206b5e <puts>
  200bd1:	83 c4 10             	add    $0x10,%esp
  200bd4:	8b 44 24 34          	mov    0x34(%esp),%eax
  200bd8:	83 ec 0c             	sub    $0xc,%esp
  200bdb:	50                   	push   %eax
  200bdc:	e8 ab 5f 00 00       	call   206b8c <puth>
  200be1:	83 c4 10             	add    $0x10,%esp
  200be4:	83 ec 0c             	sub    $0xc,%esp
  200be7:	68 64 71 20 00       	push   $0x207164
  200bec:	e8 6d 5f 00 00       	call   206b5e <puts>
  200bf1:	83 c4 10             	add    $0x10,%esp
  200bf4:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  200bf8:	83 ec 0c             	sub    $0xc,%esp
  200bfb:	50                   	push   %eax
  200bfc:	e8 8b 5f 00 00       	call   206b8c <puth>
  200c01:	83 c4 10             	add    $0x10,%esp
  200c04:	83 ec 0c             	sub    $0xc,%esp
  200c07:	68 6b 71 20 00       	push   $0x20716b
  200c0c:	e8 4d 5f 00 00       	call   206b5e <puts>
  200c11:	83 c4 10             	add    $0x10,%esp
  200c14:	8b 44 24 28          	mov    0x28(%esp),%eax
  200c18:	83 ec 0c             	sub    $0xc,%esp
  200c1b:	50                   	push   %eax
  200c1c:	e8 6b 5f 00 00       	call   206b8c <puth>
  200c21:	83 c4 10             	add    $0x10,%esp
  200c24:	83 ec 0c             	sub    $0xc,%esp
  200c27:	68 72 71 20 00       	push   $0x207172
  200c2c:	e8 2d 5f 00 00       	call   206b5e <puts>
  200c31:	83 c4 10             	add    $0x10,%esp
  200c34:	8b 44 24 24          	mov    0x24(%esp),%eax
  200c38:	83 ec 0c             	sub    $0xc,%esp
  200c3b:	50                   	push   %eax
  200c3c:	e8 4b 5f 00 00       	call   206b8c <puth>
  200c41:	83 c4 10             	add    $0x10,%esp
  200c44:	83 ec 0c             	sub    $0xc,%esp
  200c47:	68 79 71 20 00       	push   $0x207179
  200c4c:	e8 0d 5f 00 00       	call   206b5e <puts>
  200c51:	83 c4 10             	add    $0x10,%esp
  200c54:	8b 44 24 20          	mov    0x20(%esp),%eax
  200c58:	83 ec 0c             	sub    $0xc,%esp
  200c5b:	50                   	push   %eax
  200c5c:	e8 2b 5f 00 00       	call   206b8c <puth>
  200c61:	83 c4 10             	add    $0x10,%esp
  200c64:	83 ec 0c             	sub    $0xc,%esp
  200c67:	68 80 71 20 00       	push   $0x207180
  200c6c:	e8 ed 5e 00 00       	call   206b5e <puts>
  200c71:	83 c4 10             	add    $0x10,%esp
  200c74:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  200c78:	83 ec 0c             	sub    $0xc,%esp
  200c7b:	50                   	push   %eax
  200c7c:	e8 0b 5f 00 00       	call   206b8c <puth>
  200c81:	83 c4 10             	add    $0x10,%esp
  200c84:	83 ec 0c             	sub    $0xc,%esp
  200c87:	68 87 71 20 00       	push   $0x207187
  200c8c:	e8 cd 5e 00 00       	call   206b5e <puts>
  200c91:	83 c4 10             	add    $0x10,%esp
  200c94:	8b 44 24 18          	mov    0x18(%esp),%eax
  200c98:	83 ec 0c             	sub    $0xc,%esp
  200c9b:	50                   	push   %eax
  200c9c:	e8 eb 5e 00 00       	call   206b8c <puth>
  200ca1:	83 c4 10             	add    $0x10,%esp
  200ca4:	83 ec 0c             	sub    $0xc,%esp
  200ca7:	68 8d 71 20 00       	push   $0x20718d
  200cac:	e8 ad 5e 00 00       	call   206b5e <puts>
  200cb1:	83 c4 10             	add    $0x10,%esp
  200cb4:	8b 44 24 14          	mov    0x14(%esp),%eax
  200cb8:	83 ec 0c             	sub    $0xc,%esp
  200cbb:	50                   	push   %eax
  200cbc:	e8 cb 5e 00 00       	call   206b8c <puth>
  200cc1:	83 c4 10             	add    $0x10,%esp
  200cc4:	83 ec 0c             	sub    $0xc,%esp
  200cc7:	68 93 71 20 00       	push   $0x207193
  200ccc:	e8 8d 5e 00 00       	call   206b5e <puts>
  200cd1:	83 c4 10             	add    $0x10,%esp
  200cd4:	8b 44 24 10          	mov    0x10(%esp),%eax
  200cd8:	83 ec 0c             	sub    $0xc,%esp
  200cdb:	50                   	push   %eax
  200cdc:	e8 ab 5e 00 00       	call   206b8c <puth>
  200ce1:	83 c4 10             	add    $0x10,%esp
  200ce4:	83 ec 0c             	sub    $0xc,%esp
  200ce7:	68 99 71 20 00       	push   $0x207199
  200cec:	e8 6d 5e 00 00       	call   206b5e <puts>
  200cf1:	83 c4 10             	add    $0x10,%esp
  200cf4:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200cf8:	83 ec 0c             	sub    $0xc,%esp
  200cfb:	50                   	push   %eax
  200cfc:	e8 8b 5e 00 00       	call   206b8c <puth>
  200d01:	83 c4 10             	add    $0x10,%esp
  200d04:	eb fe                	jmp    200d04 <dummy+0x1a6>

00200d06 <ld_16>:
  200d06:	83 ec 10             	sub    $0x10,%esp
  200d09:	8b 44 24 14          	mov    0x14(%esp),%eax
  200d0d:	83 c0 01             	add    $0x1,%eax
  200d10:	0f b6 00             	movzbl (%eax),%eax
  200d13:	0f b6 c0             	movzbl %al,%eax
  200d16:	66 89 44 24 0e       	mov    %ax,0xe(%esp)
  200d1b:	0f b7 44 24 0e       	movzwl 0xe(%esp),%eax
  200d20:	c1 e0 08             	shl    $0x8,%eax
  200d23:	89 c2                	mov    %eax,%edx
  200d25:	8b 44 24 14          	mov    0x14(%esp),%eax
  200d29:	0f b6 00             	movzbl (%eax),%eax
  200d2c:	0f b6 c0             	movzbl %al,%eax
  200d2f:	09 d0                	or     %edx,%eax
  200d31:	66 89 44 24 0e       	mov    %ax,0xe(%esp)
  200d36:	0f b7 44 24 0e       	movzwl 0xe(%esp),%eax
  200d3b:	83 c4 10             	add    $0x10,%esp
  200d3e:	c3                   	ret

00200d3f <ld_32>:
  200d3f:	83 ec 10             	sub    $0x10,%esp
  200d42:	8b 44 24 14          	mov    0x14(%esp),%eax
  200d46:	83 c0 03             	add    $0x3,%eax
  200d49:	0f b6 00             	movzbl (%eax),%eax
  200d4c:	0f b6 c0             	movzbl %al,%eax
  200d4f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  200d53:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200d57:	c1 e0 08             	shl    $0x8,%eax
  200d5a:	89 c2                	mov    %eax,%edx
  200d5c:	8b 44 24 14          	mov    0x14(%esp),%eax
  200d60:	83 c0 02             	add    $0x2,%eax
  200d63:	0f b6 00             	movzbl (%eax),%eax
  200d66:	0f b6 c0             	movzbl %al,%eax
  200d69:	09 d0                	or     %edx,%eax
  200d6b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  200d6f:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200d73:	c1 e0 08             	shl    $0x8,%eax
  200d76:	89 c2                	mov    %eax,%edx
  200d78:	8b 44 24 14          	mov    0x14(%esp),%eax
  200d7c:	83 c0 01             	add    $0x1,%eax
  200d7f:	0f b6 00             	movzbl (%eax),%eax
  200d82:	0f b6 c0             	movzbl %al,%eax
  200d85:	09 d0                	or     %edx,%eax
  200d87:	89 44 24 0c          	mov    %eax,0xc(%esp)
  200d8b:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200d8f:	c1 e0 08             	shl    $0x8,%eax
  200d92:	89 c2                	mov    %eax,%edx
  200d94:	8b 44 24 14          	mov    0x14(%esp),%eax
  200d98:	0f b6 00             	movzbl (%eax),%eax
  200d9b:	0f b6 c0             	movzbl %al,%eax
  200d9e:	09 d0                	or     %edx,%eax
  200da0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  200da4:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200da8:	83 c4 10             	add    $0x10,%esp
  200dab:	c3                   	ret

00200dac <st_16>:
  200dac:	83 ec 04             	sub    $0x4,%esp
  200daf:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200db3:	66 89 04 24          	mov    %ax,(%esp)
  200db7:	8b 44 24 08          	mov    0x8(%esp),%eax
  200dbb:	8d 50 01             	lea    0x1(%eax),%edx
  200dbe:	89 54 24 08          	mov    %edx,0x8(%esp)
  200dc2:	0f b7 14 24          	movzwl (%esp),%edx
  200dc6:	88 10                	mov    %dl,(%eax)
  200dc8:	66 c1 2c 24 08       	shrw   $0x8,(%esp)
  200dcd:	8b 44 24 08          	mov    0x8(%esp),%eax
  200dd1:	8d 50 01             	lea    0x1(%eax),%edx
  200dd4:	89 54 24 08          	mov    %edx,0x8(%esp)
  200dd8:	0f b7 14 24          	movzwl (%esp),%edx
  200ddc:	88 10                	mov    %dl,(%eax)
  200dde:	90                   	nop
  200ddf:	83 c4 04             	add    $0x4,%esp
  200de2:	c3                   	ret

00200de3 <st_32>:
  200de3:	8b 44 24 04          	mov    0x4(%esp),%eax
  200de7:	8d 50 01             	lea    0x1(%eax),%edx
  200dea:	89 54 24 04          	mov    %edx,0x4(%esp)
  200dee:	8b 54 24 08          	mov    0x8(%esp),%edx
  200df2:	88 10                	mov    %dl,(%eax)
  200df4:	c1 6c 24 08 08       	shrl   $0x8,0x8(%esp)
  200df9:	8b 44 24 04          	mov    0x4(%esp),%eax
  200dfd:	8d 50 01             	lea    0x1(%eax),%edx
  200e00:	89 54 24 04          	mov    %edx,0x4(%esp)
  200e04:	8b 54 24 08          	mov    0x8(%esp),%edx
  200e08:	88 10                	mov    %dl,(%eax)
  200e0a:	c1 6c 24 08 08       	shrl   $0x8,0x8(%esp)
  200e0f:	8b 44 24 04          	mov    0x4(%esp),%eax
  200e13:	8d 50 01             	lea    0x1(%eax),%edx
  200e16:	89 54 24 04          	mov    %edx,0x4(%esp)
  200e1a:	8b 54 24 08          	mov    0x8(%esp),%edx
  200e1e:	88 10                	mov    %dl,(%eax)
  200e20:	c1 6c 24 08 08       	shrl   $0x8,0x8(%esp)
  200e25:	8b 44 24 04          	mov    0x4(%esp),%eax
  200e29:	8d 50 01             	lea    0x1(%eax),%edx
  200e2c:	89 54 24 04          	mov    %edx,0x4(%esp)
  200e30:	8b 54 24 08          	mov    0x8(%esp),%edx
  200e34:	88 10                	mov    %dl,(%eax)
  200e36:	90                   	nop
  200e37:	c3                   	ret

00200e38 <dbc_1st>:
  200e38:	83 ec 04             	sub    $0x4,%esp
  200e3b:	8b 44 24 08          	mov    0x8(%esp),%eax
  200e3f:	88 04 24             	mov    %al,(%esp)
  200e42:	80 3c 24 00          	cmpb   $0x0,(%esp)
  200e46:	74 07                	je     200e4f <dbc_1st+0x17>
  200e48:	b8 00 00 00 00       	mov    $0x0,%eax
  200e4d:	eb 05                	jmp    200e54 <dbc_1st+0x1c>
  200e4f:	b8 00 00 00 00       	mov    $0x0,%eax
  200e54:	83 c4 04             	add    $0x4,%esp
  200e57:	c3                   	ret

00200e58 <dbc_2nd>:
  200e58:	83 ec 04             	sub    $0x4,%esp
  200e5b:	8b 44 24 08          	mov    0x8(%esp),%eax
  200e5f:	88 04 24             	mov    %al,(%esp)
  200e62:	80 3c 24 00          	cmpb   $0x0,(%esp)
  200e66:	74 07                	je     200e6f <dbc_2nd+0x17>
  200e68:	b8 00 00 00 00       	mov    $0x0,%eax
  200e6d:	eb 05                	jmp    200e74 <dbc_2nd+0x1c>
  200e6f:	b8 00 00 00 00       	mov    $0x0,%eax
  200e74:	83 c4 04             	add    $0x4,%esp
  200e77:	c3                   	ret

00200e78 <tchar2uni>:
  200e78:	83 ec 10             	sub    $0x10,%esp
  200e7b:	8b 44 24 14          	mov    0x14(%esp),%eax
  200e7f:	8b 00                	mov    (%eax),%eax
  200e81:	89 44 24 08          	mov    %eax,0x8(%esp)
  200e85:	8b 44 24 08          	mov    0x8(%esp),%eax
  200e89:	8d 50 01             	lea    0x1(%eax),%edx
  200e8c:	89 54 24 08          	mov    %edx,0x8(%esp)
  200e90:	0f b6 00             	movzbl (%eax),%eax
  200e93:	0f b6 c0             	movzbl %al,%eax
  200e96:	89 44 24 0c          	mov    %eax,0xc(%esp)
  200e9a:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200e9e:	25 80 00 00 00       	and    $0x80,%eax
  200ea3:	85 c0                	test   %eax,%eax
  200ea5:	0f 84 14 01 00 00    	je     200fbf <tchar2uni+0x147>
  200eab:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200eaf:	25 e0 00 00 00       	and    $0xe0,%eax
  200eb4:	3d c0 00 00 00       	cmp    $0xc0,%eax
  200eb9:	75 0f                	jne    200eca <tchar2uni+0x52>
  200ebb:	83 64 24 0c 1f       	andl   $0x1f,0xc(%esp)
  200ec0:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  200ec7:	00 
  200ec8:	eb 48                	jmp    200f12 <tchar2uni+0x9a>
  200eca:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200ece:	25 f0 00 00 00       	and    $0xf0,%eax
  200ed3:	3d e0 00 00 00       	cmp    $0xe0,%eax
  200ed8:	75 0f                	jne    200ee9 <tchar2uni+0x71>
  200eda:	83 64 24 0c 0f       	andl   $0xf,0xc(%esp)
  200edf:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  200ee6:	00 
  200ee7:	eb 29                	jmp    200f12 <tchar2uni+0x9a>
  200ee9:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200eed:	25 f8 00 00 00       	and    $0xf8,%eax
  200ef2:	3d f0 00 00 00       	cmp    $0xf0,%eax
  200ef7:	75 0f                	jne    200f08 <tchar2uni+0x90>
  200ef9:	83 64 24 0c 07       	andl   $0x7,0xc(%esp)
  200efe:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  200f05:	00 
  200f06:	eb 0a                	jmp    200f12 <tchar2uni+0x9a>
  200f08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  200f0d:	e9 bb 00 00 00       	jmp    200fcd <tchar2uni+0x155>
  200f12:	8b 44 24 08          	mov    0x8(%esp),%eax
  200f16:	8d 50 01             	lea    0x1(%eax),%edx
  200f19:	89 54 24 08          	mov    %edx,0x8(%esp)
  200f1d:	0f b6 00             	movzbl (%eax),%eax
  200f20:	88 44 24 03          	mov    %al,0x3(%esp)
  200f24:	0f b6 44 24 03       	movzbl 0x3(%esp),%eax
  200f29:	25 c0 00 00 00       	and    $0xc0,%eax
  200f2e:	3d 80 00 00 00       	cmp    $0x80,%eax
  200f33:	74 0a                	je     200f3f <tchar2uni+0xc7>
  200f35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  200f3a:	e9 8e 00 00 00       	jmp    200fcd <tchar2uni+0x155>
  200f3f:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200f43:	c1 e0 06             	shl    $0x6,%eax
  200f46:	89 c2                	mov    %eax,%edx
  200f48:	0f b6 44 24 03       	movzbl 0x3(%esp),%eax
  200f4d:	83 e0 3f             	and    $0x3f,%eax
  200f50:	09 d0                	or     %edx,%eax
  200f52:	89 44 24 0c          	mov    %eax,0xc(%esp)
  200f56:	83 6c 24 04 01       	subl   $0x1,0x4(%esp)
  200f5b:	83 7c 24 04 00       	cmpl   $0x0,0x4(%esp)
  200f60:	75 b0                	jne    200f12 <tchar2uni+0x9a>
  200f62:	83 7c 24 0c 7f       	cmpl   $0x7f,0xc(%esp)
  200f67:	76 1e                	jbe    200f87 <tchar2uni+0x10f>
  200f69:	81 7c 24 0c ff d7 00 	cmpl   $0xd7ff,0xc(%esp)
  200f70:	00 
  200f71:	76 0a                	jbe    200f7d <tchar2uni+0x105>
  200f73:	81 7c 24 0c ff df 00 	cmpl   $0xdfff,0xc(%esp)
  200f7a:	00 
  200f7b:	76 0a                	jbe    200f87 <tchar2uni+0x10f>
  200f7d:	81 7c 24 0c ff ff 10 	cmpl   $0x10ffff,0xc(%esp)
  200f84:	00 
  200f85:	76 07                	jbe    200f8e <tchar2uni+0x116>
  200f87:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  200f8c:	eb 3f                	jmp    200fcd <tchar2uni+0x155>
  200f8e:	81 7c 24 0c ff ff 00 	cmpl   $0xffff,0xc(%esp)
  200f95:	00 
  200f96:	76 27                	jbe    200fbf <tchar2uni+0x147>
  200f98:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200f9c:	2d 00 00 01 00       	sub    $0x10000,%eax
  200fa1:	c1 e0 06             	shl    $0x6,%eax
  200fa4:	25 00 00 ff 03       	and    $0x3ff0000,%eax
  200fa9:	89 c2                	mov    %eax,%edx
  200fab:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200faf:	25 ff 03 00 00       	and    $0x3ff,%eax
  200fb4:	09 d0                	or     %edx,%eax
  200fb6:	0d 00 dc 00 d8       	or     $0xd800dc00,%eax
  200fbb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  200fbf:	8b 44 24 14          	mov    0x14(%esp),%eax
  200fc3:	8b 54 24 08          	mov    0x8(%esp),%edx
  200fc7:	89 10                	mov    %edx,(%eax)
  200fc9:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200fcd:	83 c4 10             	add    $0x10,%esp
  200fd0:	c3                   	ret

00200fd1 <put_utf>:
  200fd1:	83 ec 10             	sub    $0x10,%esp
  200fd4:	83 7c 24 14 7f       	cmpl   $0x7f,0x14(%esp)
  200fd9:	77 27                	ja     201002 <put_utf+0x31>
  200fdb:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  200fe0:	75 0a                	jne    200fec <put_utf+0x1b>
  200fe2:	b8 00 00 00 00       	mov    $0x0,%eax
  200fe7:	e9 e6 01 00 00       	jmp    2011d2 <put_utf+0x201>
  200fec:	8b 44 24 14          	mov    0x14(%esp),%eax
  200ff0:	89 c2                	mov    %eax,%edx
  200ff2:	8b 44 24 18          	mov    0x18(%esp),%eax
  200ff6:	88 10                	mov    %dl,(%eax)
  200ff8:	b8 01 00 00 00       	mov    $0x1,%eax
  200ffd:	e9 d0 01 00 00       	jmp    2011d2 <put_utf+0x201>
  201002:	81 7c 24 14 ff 07 00 	cmpl   $0x7ff,0x14(%esp)
  201009:	00 
  20100a:	77 54                	ja     201060 <put_utf+0x8f>
  20100c:	83 7c 24 1c 01       	cmpl   $0x1,0x1c(%esp)
  201011:	77 0a                	ja     20101d <put_utf+0x4c>
  201013:	b8 00 00 00 00       	mov    $0x0,%eax
  201018:	e9 b5 01 00 00       	jmp    2011d2 <put_utf+0x201>
  20101d:	8b 44 24 14          	mov    0x14(%esp),%eax
  201021:	c1 e8 06             	shr    $0x6,%eax
  201024:	83 e0 1f             	and    $0x1f,%eax
  201027:	83 c8 c0             	or     $0xffffffc0,%eax
  20102a:	89 c1                	mov    %eax,%ecx
  20102c:	8b 44 24 18          	mov    0x18(%esp),%eax
  201030:	8d 50 01             	lea    0x1(%eax),%edx
  201033:	89 54 24 18          	mov    %edx,0x18(%esp)
  201037:	89 ca                	mov    %ecx,%edx
  201039:	88 10                	mov    %dl,(%eax)
  20103b:	8b 44 24 14          	mov    0x14(%esp),%eax
  20103f:	83 e0 3f             	and    $0x3f,%eax
  201042:	83 c8 80             	or     $0xffffff80,%eax
  201045:	89 c1                	mov    %eax,%ecx
  201047:	8b 44 24 18          	mov    0x18(%esp),%eax
  20104b:	8d 50 01             	lea    0x1(%eax),%edx
  20104e:	89 54 24 18          	mov    %edx,0x18(%esp)
  201052:	89 ca                	mov    %ecx,%edx
  201054:	88 10                	mov    %dl,(%eax)
  201056:	b8 02 00 00 00       	mov    $0x2,%eax
  20105b:	e9 72 01 00 00       	jmp    2011d2 <put_utf+0x201>
  201060:	81 7c 24 14 ff ff 00 	cmpl   $0xffff,0x14(%esp)
  201067:	00 
  201068:	0f 87 86 00 00 00    	ja     2010f4 <put_utf+0x123>
  20106e:	83 7c 24 1c 02       	cmpl   $0x2,0x1c(%esp)
  201073:	76 14                	jbe    201089 <put_utf+0xb8>
  201075:	81 7c 24 14 ff d7 00 	cmpl   $0xd7ff,0x14(%esp)
  20107c:	00 
  20107d:	76 14                	jbe    201093 <put_utf+0xc2>
  20107f:	81 7c 24 14 ff df 00 	cmpl   $0xdfff,0x14(%esp)
  201086:	00 
  201087:	77 0a                	ja     201093 <put_utf+0xc2>
  201089:	b8 00 00 00 00       	mov    $0x0,%eax
  20108e:	e9 3f 01 00 00       	jmp    2011d2 <put_utf+0x201>
  201093:	8b 44 24 14          	mov    0x14(%esp),%eax
  201097:	c1 e8 0c             	shr    $0xc,%eax
  20109a:	83 e0 0f             	and    $0xf,%eax
  20109d:	83 c8 e0             	or     $0xffffffe0,%eax
  2010a0:	89 c1                	mov    %eax,%ecx
  2010a2:	8b 44 24 18          	mov    0x18(%esp),%eax
  2010a6:	8d 50 01             	lea    0x1(%eax),%edx
  2010a9:	89 54 24 18          	mov    %edx,0x18(%esp)
  2010ad:	89 ca                	mov    %ecx,%edx
  2010af:	88 10                	mov    %dl,(%eax)
  2010b1:	8b 44 24 14          	mov    0x14(%esp),%eax
  2010b5:	c1 e8 06             	shr    $0x6,%eax
  2010b8:	83 e0 3f             	and    $0x3f,%eax
  2010bb:	83 c8 80             	or     $0xffffff80,%eax
  2010be:	89 c1                	mov    %eax,%ecx
  2010c0:	8b 44 24 18          	mov    0x18(%esp),%eax
  2010c4:	8d 50 01             	lea    0x1(%eax),%edx
  2010c7:	89 54 24 18          	mov    %edx,0x18(%esp)
  2010cb:	89 ca                	mov    %ecx,%edx
  2010cd:	88 10                	mov    %dl,(%eax)
  2010cf:	8b 44 24 14          	mov    0x14(%esp),%eax
  2010d3:	83 e0 3f             	and    $0x3f,%eax
  2010d6:	83 c8 80             	or     $0xffffff80,%eax
  2010d9:	89 c1                	mov    %eax,%ecx
  2010db:	8b 44 24 18          	mov    0x18(%esp),%eax
  2010df:	8d 50 01             	lea    0x1(%eax),%edx
  2010e2:	89 54 24 18          	mov    %edx,0x18(%esp)
  2010e6:	89 ca                	mov    %ecx,%edx
  2010e8:	88 10                	mov    %dl,(%eax)
  2010ea:	b8 03 00 00 00       	mov    $0x3,%eax
  2010ef:	e9 de 00 00 00       	jmp    2011d2 <put_utf+0x201>
  2010f4:	83 7c 24 1c 03       	cmpl   $0x3,0x1c(%esp)
  2010f9:	77 0a                	ja     201105 <put_utf+0x134>
  2010fb:	b8 00 00 00 00       	mov    $0x0,%eax
  201100:	e9 cd 00 00 00       	jmp    2011d2 <put_utf+0x201>
  201105:	8b 44 24 14          	mov    0x14(%esp),%eax
  201109:	66 b8 00 00          	mov    $0x0,%ax
  20110d:	05 00 00 00 28       	add    $0x28000000,%eax
  201112:	c1 e8 06             	shr    $0x6,%eax
  201115:	89 44 24 0c          	mov    %eax,0xc(%esp)
  201119:	8b 44 24 14          	mov    0x14(%esp),%eax
  20111d:	0f b7 c0             	movzwl %ax,%eax
  201120:	2d 00 dc 00 00       	sub    $0xdc00,%eax
  201125:	89 44 24 14          	mov    %eax,0x14(%esp)
  201129:	81 7c 24 0c ff ff 0f 	cmpl   $0xfffff,0xc(%esp)
  201130:	00 
  201131:	77 0a                	ja     20113d <put_utf+0x16c>
  201133:	81 7c 24 14 ff 03 00 	cmpl   $0x3ff,0x14(%esp)
  20113a:	00 
  20113b:	76 0a                	jbe    201147 <put_utf+0x176>
  20113d:	b8 00 00 00 00       	mov    $0x0,%eax
  201142:	e9 8b 00 00 00       	jmp    2011d2 <put_utf+0x201>
  201147:	8b 44 24 0c          	mov    0xc(%esp),%eax
  20114b:	0b 44 24 14          	or     0x14(%esp),%eax
  20114f:	05 00 00 01 00       	add    $0x10000,%eax
  201154:	89 44 24 14          	mov    %eax,0x14(%esp)
  201158:	8b 44 24 14          	mov    0x14(%esp),%eax
  20115c:	c1 e8 12             	shr    $0x12,%eax
  20115f:	83 e0 07             	and    $0x7,%eax
  201162:	83 c8 f0             	or     $0xfffffff0,%eax
  201165:	89 c1                	mov    %eax,%ecx
  201167:	8b 44 24 18          	mov    0x18(%esp),%eax
  20116b:	8d 50 01             	lea    0x1(%eax),%edx
  20116e:	89 54 24 18          	mov    %edx,0x18(%esp)
  201172:	89 ca                	mov    %ecx,%edx
  201174:	88 10                	mov    %dl,(%eax)
  201176:	8b 44 24 14          	mov    0x14(%esp),%eax
  20117a:	c1 e8 0c             	shr    $0xc,%eax
  20117d:	83 e0 3f             	and    $0x3f,%eax
  201180:	83 c8 80             	or     $0xffffff80,%eax
  201183:	89 c1                	mov    %eax,%ecx
  201185:	8b 44 24 18          	mov    0x18(%esp),%eax
  201189:	8d 50 01             	lea    0x1(%eax),%edx
  20118c:	89 54 24 18          	mov    %edx,0x18(%esp)
  201190:	89 ca                	mov    %ecx,%edx
  201192:	88 10                	mov    %dl,(%eax)
  201194:	8b 44 24 14          	mov    0x14(%esp),%eax
  201198:	c1 e8 06             	shr    $0x6,%eax
  20119b:	83 e0 3f             	and    $0x3f,%eax
  20119e:	83 c8 80             	or     $0xffffff80,%eax
  2011a1:	89 c1                	mov    %eax,%ecx
  2011a3:	8b 44 24 18          	mov    0x18(%esp),%eax
  2011a7:	8d 50 01             	lea    0x1(%eax),%edx
  2011aa:	89 54 24 18          	mov    %edx,0x18(%esp)
  2011ae:	89 ca                	mov    %ecx,%edx
  2011b0:	88 10                	mov    %dl,(%eax)
  2011b2:	8b 44 24 14          	mov    0x14(%esp),%eax
  2011b6:	83 e0 3f             	and    $0x3f,%eax
  2011b9:	83 c8 80             	or     $0xffffff80,%eax
  2011bc:	89 c1                	mov    %eax,%ecx
  2011be:	8b 44 24 18          	mov    0x18(%esp),%eax
  2011c2:	8d 50 01             	lea    0x1(%eax),%edx
  2011c5:	89 54 24 18          	mov    %edx,0x18(%esp)
  2011c9:	89 ca                	mov    %ecx,%edx
  2011cb:	88 10                	mov    %dl,(%eax)
  2011cd:	b8 04 00 00 00       	mov    $0x4,%eax
  2011d2:	83 c4 10             	add    $0x10,%esp
  2011d5:	c3                   	ret

002011d6 <sync_window>:
  2011d6:	83 ec 1c             	sub    $0x1c,%esp
  2011d9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  2011e0:	00 
  2011e1:	8b 44 24 20          	mov    0x20(%esp),%eax
  2011e5:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  2011e9:	84 c0                	test   %al,%al
  2011eb:	0f 84 93 00 00 00    	je     201284 <sync_window+0xae>
  2011f1:	8b 44 24 20          	mov    0x20(%esp),%eax
  2011f5:	8b 50 20             	mov    0x20(%eax),%edx
  2011f8:	8b 44 24 20          	mov    0x20(%esp),%eax
  2011fc:	8d 48 34             	lea    0x34(%eax),%ecx
  2011ff:	8b 44 24 20          	mov    0x20(%esp),%eax
  201203:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  201207:	0f b6 c0             	movzbl %al,%eax
  20120a:	6a 01                	push   $0x1
  20120c:	52                   	push   %edx
  20120d:	51                   	push   %ecx
  20120e:	50                   	push   %eax
  20120f:	e8 86 f1 ff ff       	call   20039a <disk_write>
  201214:	83 c4 10             	add    $0x10,%esp
  201217:	85 c0                	test   %eax,%eax
  201219:	75 61                	jne    20127c <sync_window+0xa6>
  20121b:	8b 44 24 20          	mov    0x20(%esp),%eax
  20121f:	c6 40 04 00          	movb   $0x0,0x4(%eax)
  201223:	8b 44 24 20          	mov    0x20(%esp),%eax
  201227:	8b 50 20             	mov    0x20(%eax),%edx
  20122a:	8b 44 24 20          	mov    0x20(%esp),%eax
  20122e:	8b 40 28             	mov    0x28(%eax),%eax
  201231:	29 c2                	sub    %eax,%edx
  201233:	8b 44 24 20          	mov    0x20(%esp),%eax
  201237:	8b 40 1c             	mov    0x1c(%eax),%eax
  20123a:	39 c2                	cmp    %eax,%edx
  20123c:	73 46                	jae    201284 <sync_window+0xae>
  20123e:	8b 44 24 20          	mov    0x20(%esp),%eax
  201242:	0f b6 40 03          	movzbl 0x3(%eax),%eax
  201246:	3c 02                	cmp    $0x2,%al
  201248:	75 3a                	jne    201284 <sync_window+0xae>
  20124a:	8b 44 24 20          	mov    0x20(%esp),%eax
  20124e:	8b 50 20             	mov    0x20(%eax),%edx
  201251:	8b 44 24 20          	mov    0x20(%esp),%eax
  201255:	8b 40 1c             	mov    0x1c(%eax),%eax
  201258:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  20125b:	8b 44 24 20          	mov    0x20(%esp),%eax
  20125f:	8d 50 34             	lea    0x34(%eax),%edx
  201262:	8b 44 24 20          	mov    0x20(%esp),%eax
  201266:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  20126a:	0f b6 c0             	movzbl %al,%eax
  20126d:	6a 01                	push   $0x1
  20126f:	51                   	push   %ecx
  201270:	52                   	push   %edx
  201271:	50                   	push   %eax
  201272:	e8 23 f1 ff ff       	call   20039a <disk_write>
  201277:	83 c4 10             	add    $0x10,%esp
  20127a:	eb 08                	jmp    201284 <sync_window+0xae>
  20127c:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
  201283:	00 
  201284:	8b 44 24 0c          	mov    0xc(%esp),%eax
  201288:	83 c4 1c             	add    $0x1c,%esp
  20128b:	c3                   	ret

0020128c <move_window>:
  20128c:	83 ec 1c             	sub    $0x1c,%esp
  20128f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  201296:	00 
  201297:	8b 44 24 20          	mov    0x20(%esp),%eax
  20129b:	8b 40 20             	mov    0x20(%eax),%eax
  20129e:	39 44 24 24          	cmp    %eax,0x24(%esp)
  2012a2:	74 5b                	je     2012ff <move_window+0x73>
  2012a4:	83 ec 0c             	sub    $0xc,%esp
  2012a7:	ff 74 24 2c          	push   0x2c(%esp)
  2012ab:	e8 26 ff ff ff       	call   2011d6 <sync_window>
  2012b0:	83 c4 10             	add    $0x10,%esp
  2012b3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2012b7:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  2012bc:	75 41                	jne    2012ff <move_window+0x73>
  2012be:	8b 44 24 20          	mov    0x20(%esp),%eax
  2012c2:	8d 50 34             	lea    0x34(%eax),%edx
  2012c5:	8b 44 24 20          	mov    0x20(%esp),%eax
  2012c9:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  2012cd:	0f b6 c0             	movzbl %al,%eax
  2012d0:	6a 01                	push   $0x1
  2012d2:	ff 74 24 28          	push   0x28(%esp)
  2012d6:	52                   	push   %edx
  2012d7:	50                   	push   %eax
  2012d8:	e8 7a f0 ff ff       	call   200357 <disk_read>
  2012dd:	83 c4 10             	add    $0x10,%esp
  2012e0:	85 c0                	test   %eax,%eax
  2012e2:	74 10                	je     2012f4 <move_window+0x68>
  2012e4:	c7 44 24 24 ff ff ff 	movl   $0xffffffff,0x24(%esp)
  2012eb:	ff 
  2012ec:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
  2012f3:	00 
  2012f4:	8b 44 24 20          	mov    0x20(%esp),%eax
  2012f8:	8b 54 24 24          	mov    0x24(%esp),%edx
  2012fc:	89 50 20             	mov    %edx,0x20(%eax)
  2012ff:	8b 44 24 0c          	mov    0xc(%esp),%eax
  201303:	83 c4 1c             	add    $0x1c,%esp
  201306:	c3                   	ret

00201307 <sync_fs>:
  201307:	83 ec 1c             	sub    $0x1c,%esp
  20130a:	83 ec 0c             	sub    $0xc,%esp
  20130d:	ff 74 24 2c          	push   0x2c(%esp)
  201311:	e8 c0 fe ff ff       	call   2011d6 <sync_window>
  201316:	83 c4 10             	add    $0x10,%esp
  201319:	89 44 24 0c          	mov    %eax,0xc(%esp)
  20131d:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  201322:	0f 85 33 01 00 00    	jne    20145b <sync_fs+0x154>
  201328:	8b 44 24 20          	mov    0x20(%esp),%eax
  20132c:	0f b6 40 05          	movzbl 0x5(%eax),%eax
  201330:	3c 01                	cmp    $0x1,%al
  201332:	0f 85 fc 00 00 00    	jne    201434 <sync_fs+0x12d>
  201338:	8b 44 24 20          	mov    0x20(%esp),%eax
  20133c:	c6 40 05 00          	movb   $0x0,0x5(%eax)
  201340:	8b 44 24 20          	mov    0x20(%esp),%eax
  201344:	0f b6 00             	movzbl (%eax),%eax
  201347:	3c 03                	cmp    $0x3,%al
  201349:	0f 85 e5 00 00 00    	jne    201434 <sync_fs+0x12d>
  20134f:	8b 44 24 20          	mov    0x20(%esp),%eax
  201353:	83 c0 34             	add    $0x34,%eax
  201356:	83 ec 04             	sub    $0x4,%esp
  201359:	68 00 02 00 00       	push   $0x200
  20135e:	6a 00                	push   $0x0
  201360:	50                   	push   %eax
  201361:	e8 a9 5a 00 00       	call   206e0f <memset>
  201366:	83 c4 10             	add    $0x10,%esp
  201369:	8b 44 24 20          	mov    0x20(%esp),%eax
  20136d:	83 c0 34             	add    $0x34,%eax
  201370:	83 ec 08             	sub    $0x8,%esp
  201373:	68 52 52 61 41       	push   $0x41615252
  201378:	50                   	push   %eax
  201379:	e8 65 fa ff ff       	call   200de3 <st_32>
  20137e:	83 c4 10             	add    $0x10,%esp
  201381:	8b 44 24 20          	mov    0x20(%esp),%eax
  201385:	83 c0 34             	add    $0x34,%eax
  201388:	05 e4 01 00 00       	add    $0x1e4,%eax
  20138d:	83 ec 08             	sub    $0x8,%esp
  201390:	68 72 72 41 61       	push   $0x61417272
  201395:	50                   	push   %eax
  201396:	e8 48 fa ff ff       	call   200de3 <st_32>
  20139b:	83 c4 10             	add    $0x10,%esp
  20139e:	8b 44 24 20          	mov    0x20(%esp),%eax
  2013a2:	8b 40 14             	mov    0x14(%eax),%eax
  2013a5:	8b 54 24 20          	mov    0x20(%esp),%edx
  2013a9:	83 c2 34             	add    $0x34,%edx
  2013ac:	81 c2 e8 01 00 00    	add    $0x1e8,%edx
  2013b2:	83 ec 08             	sub    $0x8,%esp
  2013b5:	50                   	push   %eax
  2013b6:	52                   	push   %edx
  2013b7:	e8 27 fa ff ff       	call   200de3 <st_32>
  2013bc:	83 c4 10             	add    $0x10,%esp
  2013bf:	8b 44 24 20          	mov    0x20(%esp),%eax
  2013c3:	8b 40 10             	mov    0x10(%eax),%eax
  2013c6:	8b 54 24 20          	mov    0x20(%esp),%edx
  2013ca:	83 c2 34             	add    $0x34,%edx
  2013cd:	81 c2 ec 01 00 00    	add    $0x1ec,%edx
  2013d3:	83 ec 08             	sub    $0x8,%esp
  2013d6:	50                   	push   %eax
  2013d7:	52                   	push   %edx
  2013d8:	e8 06 fa ff ff       	call   200de3 <st_32>
  2013dd:	83 c4 10             	add    $0x10,%esp
  2013e0:	8b 44 24 20          	mov    0x20(%esp),%eax
  2013e4:	83 c0 34             	add    $0x34,%eax
  2013e7:	05 fc 01 00 00       	add    $0x1fc,%eax
  2013ec:	83 ec 08             	sub    $0x8,%esp
  2013ef:	68 00 00 55 aa       	push   $0xaa550000
  2013f4:	50                   	push   %eax
  2013f5:	e8 e9 f9 ff ff       	call   200de3 <st_32>
  2013fa:	83 c4 10             	add    $0x10,%esp
  2013fd:	8b 44 24 20          	mov    0x20(%esp),%eax
  201401:	8b 40 24             	mov    0x24(%eax),%eax
  201404:	8d 50 01             	lea    0x1(%eax),%edx
  201407:	8b 44 24 20          	mov    0x20(%esp),%eax
  20140b:	89 50 20             	mov    %edx,0x20(%eax)
  20140e:	8b 44 24 20          	mov    0x20(%esp),%eax
  201412:	8b 50 20             	mov    0x20(%eax),%edx
  201415:	8b 44 24 20          	mov    0x20(%esp),%eax
  201419:	8d 48 34             	lea    0x34(%eax),%ecx
  20141c:	8b 44 24 20          	mov    0x20(%esp),%eax
  201420:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  201424:	0f b6 c0             	movzbl %al,%eax
  201427:	6a 01                	push   $0x1
  201429:	52                   	push   %edx
  20142a:	51                   	push   %ecx
  20142b:	50                   	push   %eax
  20142c:	e8 69 ef ff ff       	call   20039a <disk_write>
  201431:	83 c4 10             	add    $0x10,%esp
  201434:	8b 44 24 20          	mov    0x20(%esp),%eax
  201438:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  20143c:	0f b6 c0             	movzbl %al,%eax
  20143f:	83 ec 04             	sub    $0x4,%esp
  201442:	6a 00                	push   $0x0
  201444:	6a 00                	push   $0x0
  201446:	50                   	push   %eax
  201447:	e8 91 ef ff ff       	call   2003dd <disk_ioctl>
  20144c:	83 c4 10             	add    $0x10,%esp
  20144f:	85 c0                	test   %eax,%eax
  201451:	74 08                	je     20145b <sync_fs+0x154>
  201453:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
  20145a:	00 
  20145b:	8b 44 24 0c          	mov    0xc(%esp),%eax
  20145f:	83 c4 1c             	add    $0x1c,%esp
  201462:	c3                   	ret

00201463 <clst2sect>:
  201463:	83 6c 24 08 02       	subl   $0x2,0x8(%esp)
  201468:	8b 44 24 04          	mov    0x4(%esp),%eax
  20146c:	8b 40 18             	mov    0x18(%eax),%eax
  20146f:	83 e8 02             	sub    $0x2,%eax
  201472:	39 44 24 08          	cmp    %eax,0x8(%esp)
  201476:	72 06                	jb     20147e <clst2sect+0x1b>
  201478:	b8 00 00 00 00       	mov    $0x0,%eax
  20147d:	c3                   	ret
  20147e:	8b 44 24 04          	mov    0x4(%esp),%eax
  201482:	8b 50 30             	mov    0x30(%eax),%edx
  201485:	8b 44 24 04          	mov    0x4(%esp),%eax
  201489:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  20148d:	0f b7 c0             	movzwl %ax,%eax
  201490:	0f af 44 24 08       	imul   0x8(%esp),%eax
  201495:	01 d0                	add    %edx,%eax
  201497:	c3                   	ret

00201498 <get_fat>:
  201498:	83 ec 1c             	sub    $0x1c,%esp
  20149b:	8b 44 24 20          	mov    0x20(%esp),%eax
  20149f:	8b 00                	mov    (%eax),%eax
  2014a1:	89 44 24 08          	mov    %eax,0x8(%esp)
  2014a5:	83 7c 24 24 01       	cmpl   $0x1,0x24(%esp)
  2014aa:	76 0d                	jbe    2014b9 <get_fat+0x21>
  2014ac:	8b 44 24 08          	mov    0x8(%esp),%eax
  2014b0:	8b 40 18             	mov    0x18(%eax),%eax
  2014b3:	39 44 24 24          	cmp    %eax,0x24(%esp)
  2014b7:	72 0d                	jb     2014c6 <get_fat+0x2e>
  2014b9:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
  2014c0:	00 
  2014c1:	e9 b7 01 00 00       	jmp    20167d <get_fat+0x1e5>
  2014c6:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  2014cd:	ff 
  2014ce:	8b 44 24 08          	mov    0x8(%esp),%eax
  2014d2:	0f b6 00             	movzbl (%eax),%eax
  2014d5:	0f b6 c0             	movzbl %al,%eax
  2014d8:	83 f8 03             	cmp    $0x3,%eax
  2014db:	0f 84 38 01 00 00    	je     201619 <get_fat+0x181>
  2014e1:	83 f8 03             	cmp    $0x3,%eax
  2014e4:	0f 8f 7f 01 00 00    	jg     201669 <get_fat+0x1d1>
  2014ea:	83 f8 01             	cmp    $0x1,%eax
  2014ed:	74 0e                	je     2014fd <get_fat+0x65>
  2014ef:	83 f8 02             	cmp    $0x2,%eax
  2014f2:	0f 84 d0 00 00 00    	je     2015c8 <get_fat+0x130>
  2014f8:	e9 6c 01 00 00       	jmp    201669 <get_fat+0x1d1>
  2014fd:	8b 44 24 24          	mov    0x24(%esp),%eax
  201501:	89 44 24 04          	mov    %eax,0x4(%esp)
  201505:	8b 44 24 04          	mov    0x4(%esp),%eax
  201509:	d1 e8                	shr    $1,%eax
  20150b:	01 44 24 04          	add    %eax,0x4(%esp)
  20150f:	8b 44 24 08          	mov    0x8(%esp),%eax
  201513:	8b 40 28             	mov    0x28(%eax),%eax
  201516:	8b 54 24 04          	mov    0x4(%esp),%edx
  20151a:	c1 ea 09             	shr    $0x9,%edx
  20151d:	01 d0                	add    %edx,%eax
  20151f:	83 ec 08             	sub    $0x8,%esp
  201522:	50                   	push   %eax
  201523:	ff 74 24 14          	push   0x14(%esp)
  201527:	e8 60 fd ff ff       	call   20128c <move_window>
  20152c:	83 c4 10             	add    $0x10,%esp
  20152f:	85 c0                	test   %eax,%eax
  201531:	0f 85 3c 01 00 00    	jne    201673 <get_fat+0x1db>
  201537:	8b 44 24 04          	mov    0x4(%esp),%eax
  20153b:	8d 50 01             	lea    0x1(%eax),%edx
  20153e:	89 54 24 04          	mov    %edx,0x4(%esp)
  201542:	25 ff 01 00 00       	and    $0x1ff,%eax
  201547:	89 c2                	mov    %eax,%edx
  201549:	8b 44 24 08          	mov    0x8(%esp),%eax
  20154d:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
  201552:	0f b6 c0             	movzbl %al,%eax
  201555:	89 04 24             	mov    %eax,(%esp)
  201558:	8b 44 24 08          	mov    0x8(%esp),%eax
  20155c:	8b 40 28             	mov    0x28(%eax),%eax
  20155f:	8b 54 24 04          	mov    0x4(%esp),%edx
  201563:	c1 ea 09             	shr    $0x9,%edx
  201566:	01 d0                	add    %edx,%eax
  201568:	83 ec 08             	sub    $0x8,%esp
  20156b:	50                   	push   %eax
  20156c:	ff 74 24 14          	push   0x14(%esp)
  201570:	e8 17 fd ff ff       	call   20128c <move_window>
  201575:	83 c4 10             	add    $0x10,%esp
  201578:	85 c0                	test   %eax,%eax
  20157a:	0f 85 f6 00 00 00    	jne    201676 <get_fat+0x1de>
  201580:	8b 44 24 04          	mov    0x4(%esp),%eax
  201584:	25 ff 01 00 00       	and    $0x1ff,%eax
  201589:	89 c2                	mov    %eax,%edx
  20158b:	8b 44 24 08          	mov    0x8(%esp),%eax
  20158f:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
  201594:	0f b6 c0             	movzbl %al,%eax
  201597:	c1 e0 08             	shl    $0x8,%eax
  20159a:	09 04 24             	or     %eax,(%esp)
  20159d:	8b 44 24 24          	mov    0x24(%esp),%eax
  2015a1:	83 e0 01             	and    $0x1,%eax
  2015a4:	85 c0                	test   %eax,%eax
  2015a6:	74 0f                	je     2015b7 <get_fat+0x11f>
  2015a8:	8b 04 24             	mov    (%esp),%eax
  2015ab:	c1 e8 04             	shr    $0x4,%eax
  2015ae:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2015b2:	e9 c6 00 00 00       	jmp    20167d <get_fat+0x1e5>
  2015b7:	8b 04 24             	mov    (%esp),%eax
  2015ba:	25 ff 0f 00 00       	and    $0xfff,%eax
  2015bf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2015c3:	e9 b5 00 00 00       	jmp    20167d <get_fat+0x1e5>
  2015c8:	8b 44 24 08          	mov    0x8(%esp),%eax
  2015cc:	8b 40 28             	mov    0x28(%eax),%eax
  2015cf:	8b 54 24 24          	mov    0x24(%esp),%edx
  2015d3:	c1 ea 08             	shr    $0x8,%edx
  2015d6:	01 d0                	add    %edx,%eax
  2015d8:	83 ec 08             	sub    $0x8,%esp
  2015db:	50                   	push   %eax
  2015dc:	ff 74 24 14          	push   0x14(%esp)
  2015e0:	e8 a7 fc ff ff       	call   20128c <move_window>
  2015e5:	83 c4 10             	add    $0x10,%esp
  2015e8:	85 c0                	test   %eax,%eax
  2015ea:	0f 85 89 00 00 00    	jne    201679 <get_fat+0x1e1>
  2015f0:	8b 44 24 08          	mov    0x8(%esp),%eax
  2015f4:	8d 50 34             	lea    0x34(%eax),%edx
  2015f7:	8b 44 24 24          	mov    0x24(%esp),%eax
  2015fb:	01 c0                	add    %eax,%eax
  2015fd:	25 fe 01 00 00       	and    $0x1fe,%eax
  201602:	01 d0                	add    %edx,%eax
  201604:	83 ec 0c             	sub    $0xc,%esp
  201607:	50                   	push   %eax
  201608:	e8 f9 f6 ff ff       	call   200d06 <ld_16>
  20160d:	83 c4 10             	add    $0x10,%esp
  201610:	0f b7 c0             	movzwl %ax,%eax
  201613:	89 44 24 0c          	mov    %eax,0xc(%esp)
  201617:	eb 64                	jmp    20167d <get_fat+0x1e5>
  201619:	8b 44 24 08          	mov    0x8(%esp),%eax
  20161d:	8b 40 28             	mov    0x28(%eax),%eax
  201620:	8b 54 24 24          	mov    0x24(%esp),%edx
  201624:	c1 ea 07             	shr    $0x7,%edx
  201627:	01 d0                	add    %edx,%eax
  201629:	83 ec 08             	sub    $0x8,%esp
  20162c:	50                   	push   %eax
  20162d:	ff 74 24 14          	push   0x14(%esp)
  201631:	e8 56 fc ff ff       	call   20128c <move_window>
  201636:	83 c4 10             	add    $0x10,%esp
  201639:	85 c0                	test   %eax,%eax
  20163b:	75 3f                	jne    20167c <get_fat+0x1e4>
  20163d:	8b 44 24 08          	mov    0x8(%esp),%eax
  201641:	8d 50 34             	lea    0x34(%eax),%edx
  201644:	8b 44 24 24          	mov    0x24(%esp),%eax
  201648:	c1 e0 02             	shl    $0x2,%eax
  20164b:	25 fc 01 00 00       	and    $0x1fc,%eax
  201650:	01 d0                	add    %edx,%eax
  201652:	83 ec 0c             	sub    $0xc,%esp
  201655:	50                   	push   %eax
  201656:	e8 e4 f6 ff ff       	call   200d3f <ld_32>
  20165b:	83 c4 10             	add    $0x10,%esp
  20165e:	25 ff ff ff 0f       	and    $0xfffffff,%eax
  201663:	89 44 24 0c          	mov    %eax,0xc(%esp)
  201667:	eb 14                	jmp    20167d <get_fat+0x1e5>
  201669:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
  201670:	00 
  201671:	eb 0a                	jmp    20167d <get_fat+0x1e5>
  201673:	90                   	nop
  201674:	eb 07                	jmp    20167d <get_fat+0x1e5>
  201676:	90                   	nop
  201677:	eb 04                	jmp    20167d <get_fat+0x1e5>
  201679:	90                   	nop
  20167a:	eb 01                	jmp    20167d <get_fat+0x1e5>
  20167c:	90                   	nop
  20167d:	8b 44 24 0c          	mov    0xc(%esp),%eax
  201681:	83 c4 1c             	add    $0x1c,%esp
  201684:	c3                   	ret

00201685 <put_fat>:
  201685:	53                   	push   %ebx
  201686:	83 ec 18             	sub    $0x18,%esp
  201689:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
  201690:	00 
  201691:	83 7c 24 24 01       	cmpl   $0x1,0x24(%esp)
  201696:	0f 86 5e 02 00 00    	jbe    2018fa <put_fat+0x275>
  20169c:	8b 44 24 20          	mov    0x20(%esp),%eax
  2016a0:	8b 40 18             	mov    0x18(%eax),%eax
  2016a3:	39 44 24 24          	cmp    %eax,0x24(%esp)
  2016a7:	0f 83 4d 02 00 00    	jae    2018fa <put_fat+0x275>
  2016ad:	8b 44 24 20          	mov    0x20(%esp),%eax
  2016b1:	0f b6 00             	movzbl (%eax),%eax
  2016b4:	0f b6 c0             	movzbl %al,%eax
  2016b7:	83 f8 03             	cmp    $0x3,%eax
  2016ba:	0f 84 9f 01 00 00    	je     20185f <put_fat+0x1da>
  2016c0:	83 f8 03             	cmp    $0x3,%eax
  2016c3:	0f 8f 31 02 00 00    	jg     2018fa <put_fat+0x275>
  2016c9:	83 f8 01             	cmp    $0x1,%eax
  2016cc:	74 0e                	je     2016dc <put_fat+0x57>
  2016ce:	83 f8 02             	cmp    $0x2,%eax
  2016d1:	0f 84 23 01 00 00    	je     2017fa <put_fat+0x175>
  2016d7:	e9 1e 02 00 00       	jmp    2018fa <put_fat+0x275>
  2016dc:	8b 44 24 24          	mov    0x24(%esp),%eax
  2016e0:	89 44 24 08          	mov    %eax,0x8(%esp)
  2016e4:	8b 44 24 08          	mov    0x8(%esp),%eax
  2016e8:	d1 e8                	shr    $1,%eax
  2016ea:	01 44 24 08          	add    %eax,0x8(%esp)
  2016ee:	8b 44 24 20          	mov    0x20(%esp),%eax
  2016f2:	8b 40 28             	mov    0x28(%eax),%eax
  2016f5:	8b 54 24 08          	mov    0x8(%esp),%edx
  2016f9:	c1 ea 09             	shr    $0x9,%edx
  2016fc:	01 d0                	add    %edx,%eax
  2016fe:	83 ec 08             	sub    $0x8,%esp
  201701:	50                   	push   %eax
  201702:	ff 74 24 2c          	push   0x2c(%esp)
  201706:	e8 81 fb ff ff       	call   20128c <move_window>
  20170b:	83 c4 10             	add    $0x10,%esp
  20170e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  201712:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  201717:	0f 85 d3 01 00 00    	jne    2018f0 <put_fat+0x26b>
  20171d:	8b 44 24 20          	mov    0x20(%esp),%eax
  201721:	8d 48 34             	lea    0x34(%eax),%ecx
  201724:	8b 44 24 08          	mov    0x8(%esp),%eax
  201728:	8d 50 01             	lea    0x1(%eax),%edx
  20172b:	89 54 24 08          	mov    %edx,0x8(%esp)
  20172f:	25 ff 01 00 00       	and    $0x1ff,%eax
  201734:	01 c8                	add    %ecx,%eax
  201736:	89 44 24 04          	mov    %eax,0x4(%esp)
  20173a:	8b 44 24 24          	mov    0x24(%esp),%eax
  20173e:	83 e0 01             	and    $0x1,%eax
  201741:	85 c0                	test   %eax,%eax
  201743:	74 19                	je     20175e <put_fat+0xd9>
  201745:	8b 44 24 04          	mov    0x4(%esp),%eax
  201749:	0f b6 00             	movzbl (%eax),%eax
  20174c:	83 e0 0f             	and    $0xf,%eax
  20174f:	89 c2                	mov    %eax,%edx
  201751:	8b 44 24 28          	mov    0x28(%esp),%eax
  201755:	c1 e0 04             	shl    $0x4,%eax
  201758:	09 d0                	or     %edx,%eax
  20175a:	89 c2                	mov    %eax,%edx
  20175c:	eb 06                	jmp    201764 <put_fat+0xdf>
  20175e:	8b 44 24 28          	mov    0x28(%esp),%eax
  201762:	89 c2                	mov    %eax,%edx
  201764:	8b 44 24 04          	mov    0x4(%esp),%eax
  201768:	88 10                	mov    %dl,(%eax)
  20176a:	8b 44 24 20          	mov    0x20(%esp),%eax
  20176e:	c6 40 04 01          	movb   $0x1,0x4(%eax)
  201772:	8b 44 24 20          	mov    0x20(%esp),%eax
  201776:	8b 40 28             	mov    0x28(%eax),%eax
  201779:	8b 54 24 08          	mov    0x8(%esp),%edx
  20177d:	c1 ea 09             	shr    $0x9,%edx
  201780:	01 d0                	add    %edx,%eax
  201782:	83 ec 08             	sub    $0x8,%esp
  201785:	50                   	push   %eax
  201786:	ff 74 24 2c          	push   0x2c(%esp)
  20178a:	e8 fd fa ff ff       	call   20128c <move_window>
  20178f:	83 c4 10             	add    $0x10,%esp
  201792:	89 44 24 0c          	mov    %eax,0xc(%esp)
  201796:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  20179b:	0f 85 52 01 00 00    	jne    2018f3 <put_fat+0x26e>
  2017a1:	8b 44 24 20          	mov    0x20(%esp),%eax
  2017a5:	8d 50 34             	lea    0x34(%eax),%edx
  2017a8:	8b 44 24 08          	mov    0x8(%esp),%eax
  2017ac:	25 ff 01 00 00       	and    $0x1ff,%eax
  2017b1:	01 d0                	add    %edx,%eax
  2017b3:	89 44 24 04          	mov    %eax,0x4(%esp)
  2017b7:	8b 44 24 24          	mov    0x24(%esp),%eax
  2017bb:	83 e0 01             	and    $0x1,%eax
  2017be:	85 c0                	test   %eax,%eax
  2017c0:	74 0b                	je     2017cd <put_fat+0x148>
  2017c2:	8b 44 24 28          	mov    0x28(%esp),%eax
  2017c6:	c1 e8 04             	shr    $0x4,%eax
  2017c9:	89 c2                	mov    %eax,%edx
  2017cb:	eb 1a                	jmp    2017e7 <put_fat+0x162>
  2017cd:	8b 44 24 04          	mov    0x4(%esp),%eax
  2017d1:	0f b6 00             	movzbl (%eax),%eax
  2017d4:	83 e0 f0             	and    $0xfffffff0,%eax
  2017d7:	89 c2                	mov    %eax,%edx
  2017d9:	8b 44 24 28          	mov    0x28(%esp),%eax
  2017dd:	c1 e8 08             	shr    $0x8,%eax
  2017e0:	83 e0 0f             	and    $0xf,%eax
  2017e3:	09 d0                	or     %edx,%eax
  2017e5:	89 c2                	mov    %eax,%edx
  2017e7:	8b 44 24 04          	mov    0x4(%esp),%eax
  2017eb:	88 10                	mov    %dl,(%eax)
  2017ed:	8b 44 24 20          	mov    0x20(%esp),%eax
  2017f1:	c6 40 04 01          	movb   $0x1,0x4(%eax)
  2017f5:	e9 00 01 00 00       	jmp    2018fa <put_fat+0x275>
  2017fa:	8b 44 24 20          	mov    0x20(%esp),%eax
  2017fe:	8b 40 28             	mov    0x28(%eax),%eax
  201801:	8b 54 24 24          	mov    0x24(%esp),%edx
  201805:	c1 ea 08             	shr    $0x8,%edx
  201808:	01 d0                	add    %edx,%eax
  20180a:	83 ec 08             	sub    $0x8,%esp
  20180d:	50                   	push   %eax
  20180e:	ff 74 24 2c          	push   0x2c(%esp)
  201812:	e8 75 fa ff ff       	call   20128c <move_window>
  201817:	83 c4 10             	add    $0x10,%esp
  20181a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  20181e:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  201823:	0f 85 cd 00 00 00    	jne    2018f6 <put_fat+0x271>
  201829:	8b 44 24 28          	mov    0x28(%esp),%eax
  20182d:	0f b7 c0             	movzwl %ax,%eax
  201830:	8b 54 24 20          	mov    0x20(%esp),%edx
  201834:	8d 4a 34             	lea    0x34(%edx),%ecx
  201837:	8b 54 24 24          	mov    0x24(%esp),%edx
  20183b:	01 d2                	add    %edx,%edx
  20183d:	81 e2 fe 01 00 00    	and    $0x1fe,%edx
  201843:	01 ca                	add    %ecx,%edx
  201845:	83 ec 08             	sub    $0x8,%esp
  201848:	50                   	push   %eax
  201849:	52                   	push   %edx
  20184a:	e8 5d f5 ff ff       	call   200dac <st_16>
  20184f:	83 c4 10             	add    $0x10,%esp
  201852:	8b 44 24 20          	mov    0x20(%esp),%eax
  201856:	c6 40 04 01          	movb   $0x1,0x4(%eax)
  20185a:	e9 9b 00 00 00       	jmp    2018fa <put_fat+0x275>
  20185f:	8b 44 24 20          	mov    0x20(%esp),%eax
  201863:	8b 40 28             	mov    0x28(%eax),%eax
  201866:	8b 54 24 24          	mov    0x24(%esp),%edx
  20186a:	c1 ea 07             	shr    $0x7,%edx
  20186d:	01 d0                	add    %edx,%eax
  20186f:	83 ec 08             	sub    $0x8,%esp
  201872:	50                   	push   %eax
  201873:	ff 74 24 2c          	push   0x2c(%esp)
  201877:	e8 10 fa ff ff       	call   20128c <move_window>
  20187c:	83 c4 10             	add    $0x10,%esp
  20187f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  201883:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  201888:	75 6f                	jne    2018f9 <put_fat+0x274>
  20188a:	8b 44 24 28          	mov    0x28(%esp),%eax
  20188e:	25 ff ff ff 0f       	and    $0xfffffff,%eax
  201893:	89 c3                	mov    %eax,%ebx
  201895:	8b 44 24 20          	mov    0x20(%esp),%eax
  201899:	8d 50 34             	lea    0x34(%eax),%edx
  20189c:	8b 44 24 24          	mov    0x24(%esp),%eax
  2018a0:	c1 e0 02             	shl    $0x2,%eax
  2018a3:	25 fc 01 00 00       	and    $0x1fc,%eax
  2018a8:	01 d0                	add    %edx,%eax
  2018aa:	83 ec 0c             	sub    $0xc,%esp
  2018ad:	50                   	push   %eax
  2018ae:	e8 8c f4 ff ff       	call   200d3f <ld_32>
  2018b3:	83 c4 10             	add    $0x10,%esp
  2018b6:	25 00 00 00 f0       	and    $0xf0000000,%eax
  2018bb:	09 d8                	or     %ebx,%eax
  2018bd:	89 44 24 28          	mov    %eax,0x28(%esp)
  2018c1:	8b 44 24 20          	mov    0x20(%esp),%eax
  2018c5:	8d 50 34             	lea    0x34(%eax),%edx
  2018c8:	8b 44 24 24          	mov    0x24(%esp),%eax
  2018cc:	c1 e0 02             	shl    $0x2,%eax
  2018cf:	25 fc 01 00 00       	and    $0x1fc,%eax
  2018d4:	01 d0                	add    %edx,%eax
  2018d6:	83 ec 08             	sub    $0x8,%esp
  2018d9:	ff 74 24 30          	push   0x30(%esp)
  2018dd:	50                   	push   %eax
  2018de:	e8 00 f5 ff ff       	call   200de3 <st_32>
  2018e3:	83 c4 10             	add    $0x10,%esp
  2018e6:	8b 44 24 20          	mov    0x20(%esp),%eax
  2018ea:	c6 40 04 01          	movb   $0x1,0x4(%eax)
  2018ee:	eb 0a                	jmp    2018fa <put_fat+0x275>
  2018f0:	90                   	nop
  2018f1:	eb 07                	jmp    2018fa <put_fat+0x275>
  2018f3:	90                   	nop
  2018f4:	eb 04                	jmp    2018fa <put_fat+0x275>
  2018f6:	90                   	nop
  2018f7:	eb 01                	jmp    2018fa <put_fat+0x275>
  2018f9:	90                   	nop
  2018fa:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2018fe:	83 c4 18             	add    $0x18,%esp
  201901:	5b                   	pop    %ebx
  201902:	c3                   	ret

00201903 <remove_chain>:
  201903:	83 ec 1c             	sub    $0x1c,%esp
  201906:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  20190d:	00 
  20190e:	8b 44 24 20          	mov    0x20(%esp),%eax
  201912:	8b 00                	mov    (%eax),%eax
  201914:	89 44 24 08          	mov    %eax,0x8(%esp)
  201918:	83 7c 24 24 01       	cmpl   $0x1,0x24(%esp)
  20191d:	76 0d                	jbe    20192c <remove_chain+0x29>
  20191f:	8b 44 24 08          	mov    0x8(%esp),%eax
  201923:	8b 40 18             	mov    0x18(%eax),%eax
  201926:	39 44 24 24          	cmp    %eax,0x24(%esp)
  20192a:	72 0a                	jb     201936 <remove_chain+0x33>
  20192c:	b8 02 00 00 00       	mov    $0x2,%eax
  201931:	e9 f5 00 00 00       	jmp    201a2b <remove_chain+0x128>
  201936:	83 7c 24 28 00       	cmpl   $0x0,0x28(%esp)
  20193b:	74 29                	je     201966 <remove_chain+0x63>
  20193d:	83 ec 04             	sub    $0x4,%esp
  201940:	6a ff                	push   $0xffffffff
  201942:	ff 74 24 30          	push   0x30(%esp)
  201946:	ff 74 24 14          	push   0x14(%esp)
  20194a:	e8 36 fd ff ff       	call   201685 <put_fat>
  20194f:	83 c4 10             	add    $0x10,%esp
  201952:	89 44 24 0c          	mov    %eax,0xc(%esp)
  201956:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  20195b:	74 09                	je     201966 <remove_chain+0x63>
  20195d:	8b 44 24 0c          	mov    0xc(%esp),%eax
  201961:	e9 c5 00 00 00       	jmp    201a2b <remove_chain+0x128>
  201966:	83 ec 08             	sub    $0x8,%esp
  201969:	ff 74 24 2c          	push   0x2c(%esp)
  20196d:	ff 74 24 2c          	push   0x2c(%esp)
  201971:	e8 22 fb ff ff       	call   201498 <get_fat>
  201976:	83 c4 10             	add    $0x10,%esp
  201979:	89 44 24 04          	mov    %eax,0x4(%esp)
  20197d:	83 7c 24 04 00       	cmpl   $0x0,0x4(%esp)
  201982:	0f 84 9d 00 00 00    	je     201a25 <remove_chain+0x122>
  201988:	83 7c 24 04 01       	cmpl   $0x1,0x4(%esp)
  20198d:	75 0a                	jne    201999 <remove_chain+0x96>
  20198f:	b8 02 00 00 00       	mov    $0x2,%eax
  201994:	e9 92 00 00 00       	jmp    201a2b <remove_chain+0x128>
  201999:	83 7c 24 04 ff       	cmpl   $0xffffffff,0x4(%esp)
  20199e:	75 0a                	jne    2019aa <remove_chain+0xa7>
  2019a0:	b8 01 00 00 00       	mov    $0x1,%eax
  2019a5:	e9 81 00 00 00       	jmp    201a2b <remove_chain+0x128>
  2019aa:	83 ec 04             	sub    $0x4,%esp
  2019ad:	6a 00                	push   $0x0
  2019af:	ff 74 24 2c          	push   0x2c(%esp)
  2019b3:	ff 74 24 14          	push   0x14(%esp)
  2019b7:	e8 c9 fc ff ff       	call   201685 <put_fat>
  2019bc:	83 c4 10             	add    $0x10,%esp
  2019bf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2019c3:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  2019c8:	74 06                	je     2019d0 <remove_chain+0xcd>
  2019ca:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2019ce:	eb 5b                	jmp    201a2b <remove_chain+0x128>
  2019d0:	8b 44 24 08          	mov    0x8(%esp),%eax
  2019d4:	8b 50 14             	mov    0x14(%eax),%edx
  2019d7:	8b 44 24 08          	mov    0x8(%esp),%eax
  2019db:	8b 40 18             	mov    0x18(%eax),%eax
  2019de:	83 e8 02             	sub    $0x2,%eax
  2019e1:	39 c2                	cmp    %eax,%edx
  2019e3:	73 25                	jae    201a0a <remove_chain+0x107>
  2019e5:	8b 44 24 08          	mov    0x8(%esp),%eax
  2019e9:	8b 40 14             	mov    0x14(%eax),%eax
  2019ec:	8d 50 01             	lea    0x1(%eax),%edx
  2019ef:	8b 44 24 08          	mov    0x8(%esp),%eax
  2019f3:	89 50 14             	mov    %edx,0x14(%eax)
  2019f6:	8b 44 24 08          	mov    0x8(%esp),%eax
  2019fa:	0f b6 40 05          	movzbl 0x5(%eax),%eax
  2019fe:	83 c8 01             	or     $0x1,%eax
  201a01:	89 c2                	mov    %eax,%edx
  201a03:	8b 44 24 08          	mov    0x8(%esp),%eax
  201a07:	88 50 05             	mov    %dl,0x5(%eax)
  201a0a:	8b 44 24 04          	mov    0x4(%esp),%eax
  201a0e:	89 44 24 24          	mov    %eax,0x24(%esp)
  201a12:	8b 44 24 08          	mov    0x8(%esp),%eax
  201a16:	8b 40 18             	mov    0x18(%eax),%eax
  201a19:	39 44 24 24          	cmp    %eax,0x24(%esp)
  201a1d:	0f 82 43 ff ff ff    	jb     201966 <remove_chain+0x63>
  201a23:	eb 01                	jmp    201a26 <remove_chain+0x123>
  201a25:	90                   	nop
  201a26:	b8 00 00 00 00       	mov    $0x0,%eax
  201a2b:	83 c4 1c             	add    $0x1c,%esp
  201a2e:	c3                   	ret

00201a2f <create_chain>:
  201a2f:	83 ec 2c             	sub    $0x2c,%esp
  201a32:	8b 44 24 30          	mov    0x30(%esp),%eax
  201a36:	8b 00                	mov    (%eax),%eax
  201a38:	89 44 24 10          	mov    %eax,0x10(%esp)
  201a3c:	83 7c 24 34 00       	cmpl   $0x0,0x34(%esp)
  201a41:	75 29                	jne    201a6c <create_chain+0x3d>
  201a43:	8b 44 24 10          	mov    0x10(%esp),%eax
  201a47:	8b 40 10             	mov    0x10(%eax),%eax
  201a4a:	89 44 24 18          	mov    %eax,0x18(%esp)
  201a4e:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  201a53:	74 0d                	je     201a62 <create_chain+0x33>
  201a55:	8b 44 24 10          	mov    0x10(%esp),%eax
  201a59:	8b 40 18             	mov    0x18(%eax),%eax
  201a5c:	39 44 24 18          	cmp    %eax,0x18(%esp)
  201a60:	72 60                	jb     201ac2 <create_chain+0x93>
  201a62:	c7 44 24 18 01 00 00 	movl   $0x1,0x18(%esp)
  201a69:	00 
  201a6a:	eb 56                	jmp    201ac2 <create_chain+0x93>
  201a6c:	83 ec 08             	sub    $0x8,%esp
  201a6f:	ff 74 24 3c          	push   0x3c(%esp)
  201a73:	ff 74 24 3c          	push   0x3c(%esp)
  201a77:	e8 1c fa ff ff       	call   201498 <get_fat>
  201a7c:	83 c4 10             	add    $0x10,%esp
  201a7f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  201a83:	83 7c 24 0c 01       	cmpl   $0x1,0xc(%esp)
  201a88:	77 0a                	ja     201a94 <create_chain+0x65>
  201a8a:	b8 01 00 00 00       	mov    $0x1,%eax
  201a8f:	e9 20 02 00 00       	jmp    201cb4 <create_chain+0x285>
  201a94:	83 7c 24 0c ff       	cmpl   $0xffffffff,0xc(%esp)
  201a99:	75 09                	jne    201aa4 <create_chain+0x75>
  201a9b:	8b 44 24 0c          	mov    0xc(%esp),%eax
  201a9f:	e9 10 02 00 00       	jmp    201cb4 <create_chain+0x285>
  201aa4:	8b 44 24 10          	mov    0x10(%esp),%eax
  201aa8:	8b 40 18             	mov    0x18(%eax),%eax
  201aab:	39 44 24 0c          	cmp    %eax,0xc(%esp)
  201aaf:	73 09                	jae    201aba <create_chain+0x8b>
  201ab1:	8b 44 24 0c          	mov    0xc(%esp),%eax
  201ab5:	e9 fa 01 00 00       	jmp    201cb4 <create_chain+0x285>
  201aba:	8b 44 24 34          	mov    0x34(%esp),%eax
  201abe:	89 44 24 18          	mov    %eax,0x18(%esp)
  201ac2:	8b 44 24 10          	mov    0x10(%esp),%eax
  201ac6:	8b 40 14             	mov    0x14(%eax),%eax
  201ac9:	85 c0                	test   %eax,%eax
  201acb:	75 0a                	jne    201ad7 <create_chain+0xa8>
  201acd:	b8 00 00 00 00       	mov    $0x0,%eax
  201ad2:	e9 dd 01 00 00       	jmp    201cb4 <create_chain+0x285>
  201ad7:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  201ade:	00 
  201adf:	8b 44 24 18          	mov    0x18(%esp),%eax
  201ae3:	3b 44 24 34          	cmp    0x34(%esp),%eax
  201ae7:	0f 85 84 00 00 00    	jne    201b71 <create_chain+0x142>
  201aed:	8b 44 24 18          	mov    0x18(%esp),%eax
  201af1:	83 c0 01             	add    $0x1,%eax
  201af4:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  201af8:	8b 44 24 10          	mov    0x10(%esp),%eax
  201afc:	8b 40 18             	mov    0x18(%eax),%eax
  201aff:	39 44 24 1c          	cmp    %eax,0x1c(%esp)
  201b03:	72 08                	jb     201b0d <create_chain+0xde>
  201b05:	c7 44 24 1c 02 00 00 	movl   $0x2,0x1c(%esp)
  201b0c:	00 
  201b0d:	83 ec 08             	sub    $0x8,%esp
  201b10:	ff 74 24 24          	push   0x24(%esp)
  201b14:	ff 74 24 3c          	push   0x3c(%esp)
  201b18:	e8 7b f9 ff ff       	call   201498 <get_fat>
  201b1d:	83 c4 10             	add    $0x10,%esp
  201b20:	89 44 24 0c          	mov    %eax,0xc(%esp)
  201b24:	83 7c 24 0c 01       	cmpl   $0x1,0xc(%esp)
  201b29:	74 07                	je     201b32 <create_chain+0x103>
  201b2b:	83 7c 24 0c ff       	cmpl   $0xffffffff,0xc(%esp)
  201b30:	75 09                	jne    201b3b <create_chain+0x10c>
  201b32:	8b 44 24 0c          	mov    0xc(%esp),%eax
  201b36:	e9 79 01 00 00       	jmp    201cb4 <create_chain+0x285>
  201b3b:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  201b40:	74 2f                	je     201b71 <create_chain+0x142>
  201b42:	8b 44 24 10          	mov    0x10(%esp),%eax
  201b46:	8b 40 10             	mov    0x10(%eax),%eax
  201b49:	89 44 24 0c          	mov    %eax,0xc(%esp)
  201b4d:	83 7c 24 0c 01       	cmpl   $0x1,0xc(%esp)
  201b52:	76 15                	jbe    201b69 <create_chain+0x13a>
  201b54:	8b 44 24 10          	mov    0x10(%esp),%eax
  201b58:	8b 40 18             	mov    0x18(%eax),%eax
  201b5b:	39 44 24 0c          	cmp    %eax,0xc(%esp)
  201b5f:	73 08                	jae    201b69 <create_chain+0x13a>
  201b61:	8b 44 24 0c          	mov    0xc(%esp),%eax
  201b65:	89 44 24 18          	mov    %eax,0x18(%esp)
  201b69:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  201b70:	00 
  201b71:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  201b76:	0f 85 80 00 00 00    	jne    201bfc <create_chain+0x1cd>
  201b7c:	8b 44 24 18          	mov    0x18(%esp),%eax
  201b80:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  201b84:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  201b89:	8b 44 24 10          	mov    0x10(%esp),%eax
  201b8d:	8b 40 18             	mov    0x18(%eax),%eax
  201b90:	39 44 24 1c          	cmp    %eax,0x1c(%esp)
  201b94:	72 1c                	jb     201bb2 <create_chain+0x183>
  201b96:	c7 44 24 1c 02 00 00 	movl   $0x2,0x1c(%esp)
  201b9d:	00 
  201b9e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  201ba2:	39 44 24 18          	cmp    %eax,0x18(%esp)
  201ba6:	73 0a                	jae    201bb2 <create_chain+0x183>
  201ba8:	b8 00 00 00 00       	mov    $0x0,%eax
  201bad:	e9 02 01 00 00       	jmp    201cb4 <create_chain+0x285>
  201bb2:	83 ec 08             	sub    $0x8,%esp
  201bb5:	ff 74 24 24          	push   0x24(%esp)
  201bb9:	ff 74 24 3c          	push   0x3c(%esp)
  201bbd:	e8 d6 f8 ff ff       	call   201498 <get_fat>
  201bc2:	83 c4 10             	add    $0x10,%esp
  201bc5:	89 44 24 0c          	mov    %eax,0xc(%esp)
  201bc9:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  201bce:	74 2b                	je     201bfb <create_chain+0x1cc>
  201bd0:	83 7c 24 0c 01       	cmpl   $0x1,0xc(%esp)
  201bd5:	74 07                	je     201bde <create_chain+0x1af>
  201bd7:	83 7c 24 0c ff       	cmpl   $0xffffffff,0xc(%esp)
  201bdc:	75 09                	jne    201be7 <create_chain+0x1b8>
  201bde:	8b 44 24 0c          	mov    0xc(%esp),%eax
  201be2:	e9 cd 00 00 00       	jmp    201cb4 <create_chain+0x285>
  201be7:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  201beb:	3b 44 24 18          	cmp    0x18(%esp),%eax
  201bef:	75 93                	jne    201b84 <create_chain+0x155>
  201bf1:	b8 00 00 00 00       	mov    $0x0,%eax
  201bf6:	e9 b9 00 00 00       	jmp    201cb4 <create_chain+0x285>
  201bfb:	90                   	nop
  201bfc:	83 ec 04             	sub    $0x4,%esp
  201bff:	6a ff                	push   $0xffffffff
  201c01:	ff 74 24 24          	push   0x24(%esp)
  201c05:	ff 74 24 1c          	push   0x1c(%esp)
  201c09:	e8 77 fa ff ff       	call   201685 <put_fat>
  201c0e:	83 c4 10             	add    $0x10,%esp
  201c11:	89 44 24 14          	mov    %eax,0x14(%esp)
  201c15:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  201c1a:	75 22                	jne    201c3e <create_chain+0x20f>
  201c1c:	83 7c 24 34 00       	cmpl   $0x0,0x34(%esp)
  201c21:	74 1b                	je     201c3e <create_chain+0x20f>
  201c23:	83 ec 04             	sub    $0x4,%esp
  201c26:	ff 74 24 20          	push   0x20(%esp)
  201c2a:	ff 74 24 3c          	push   0x3c(%esp)
  201c2e:	ff 74 24 1c          	push   0x1c(%esp)
  201c32:	e8 4e fa ff ff       	call   201685 <put_fat>
  201c37:	83 c4 10             	add    $0x10,%esp
  201c3a:	89 44 24 14          	mov    %eax,0x14(%esp)
  201c3e:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  201c43:	75 52                	jne    201c97 <create_chain+0x268>
  201c45:	8b 44 24 10          	mov    0x10(%esp),%eax
  201c49:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  201c4d:	89 50 10             	mov    %edx,0x10(%eax)
  201c50:	8b 44 24 10          	mov    0x10(%esp),%eax
  201c54:	8b 40 14             	mov    0x14(%eax),%eax
  201c57:	85 c0                	test   %eax,%eax
  201c59:	74 55                	je     201cb0 <create_chain+0x281>
  201c5b:	8b 44 24 10          	mov    0x10(%esp),%eax
  201c5f:	8b 40 14             	mov    0x14(%eax),%eax
  201c62:	8b 54 24 10          	mov    0x10(%esp),%edx
  201c66:	8b 52 18             	mov    0x18(%edx),%edx
  201c69:	83 ea 02             	sub    $0x2,%edx
  201c6c:	39 c2                	cmp    %eax,%edx
  201c6e:	72 40                	jb     201cb0 <create_chain+0x281>
  201c70:	8b 44 24 10          	mov    0x10(%esp),%eax
  201c74:	8b 40 14             	mov    0x14(%eax),%eax
  201c77:	8d 50 ff             	lea    -0x1(%eax),%edx
  201c7a:	8b 44 24 10          	mov    0x10(%esp),%eax
  201c7e:	89 50 14             	mov    %edx,0x14(%eax)
  201c81:	8b 44 24 10          	mov    0x10(%esp),%eax
  201c85:	0f b6 40 05          	movzbl 0x5(%eax),%eax
  201c89:	83 c8 01             	or     $0x1,%eax
  201c8c:	89 c2                	mov    %eax,%edx
  201c8e:	8b 44 24 10          	mov    0x10(%esp),%eax
  201c92:	88 50 05             	mov    %dl,0x5(%eax)
  201c95:	eb 19                	jmp    201cb0 <create_chain+0x281>
  201c97:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  201c9c:	75 0a                	jne    201ca8 <create_chain+0x279>
  201c9e:	c7 44 24 1c ff ff ff 	movl   $0xffffffff,0x1c(%esp)
  201ca5:	ff 
  201ca6:	eb 08                	jmp    201cb0 <create_chain+0x281>
  201ca8:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  201caf:	00 
  201cb0:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  201cb4:	83 c4 2c             	add    $0x2c,%esp
  201cb7:	c3                   	ret

00201cb8 <dir_clear>:
  201cb8:	83 ec 1c             	sub    $0x1c,%esp
  201cbb:	83 ec 0c             	sub    $0xc,%esp
  201cbe:	ff 74 24 2c          	push   0x2c(%esp)
  201cc2:	e8 0f f5 ff ff       	call   2011d6 <sync_window>
  201cc7:	83 c4 10             	add    $0x10,%esp
  201cca:	85 c0                	test   %eax,%eax
  201ccc:	74 0a                	je     201cd8 <dir_clear+0x20>
  201cce:	b8 01 00 00 00       	mov    $0x1,%eax
  201cd3:	e9 af 00 00 00       	jmp    201d87 <dir_clear+0xcf>
  201cd8:	83 ec 08             	sub    $0x8,%esp
  201cdb:	ff 74 24 2c          	push   0x2c(%esp)
  201cdf:	ff 74 24 2c          	push   0x2c(%esp)
  201ce3:	e8 7b f7 ff ff       	call   201463 <clst2sect>
  201ce8:	83 c4 10             	add    $0x10,%esp
  201ceb:	89 44 24 08          	mov    %eax,0x8(%esp)
  201cef:	8b 44 24 20          	mov    0x20(%esp),%eax
  201cf3:	8b 54 24 08          	mov    0x8(%esp),%edx
  201cf7:	89 50 20             	mov    %edx,0x20(%eax)
  201cfa:	8b 44 24 20          	mov    0x20(%esp),%eax
  201cfe:	83 c0 34             	add    $0x34,%eax
  201d01:	83 ec 04             	sub    $0x4,%esp
  201d04:	68 00 02 00 00       	push   $0x200
  201d09:	6a 00                	push   $0x0
  201d0b:	50                   	push   %eax
  201d0c:	e8 fe 50 00 00       	call   206e0f <memset>
  201d11:	83 c4 10             	add    $0x10,%esp
  201d14:	8b 44 24 20          	mov    0x20(%esp),%eax
  201d18:	83 c0 34             	add    $0x34,%eax
  201d1b:	89 44 24 04          	mov    %eax,0x4(%esp)
  201d1f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  201d26:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  201d2d:	00 
  201d2e:	eb 07                	jmp    201d37 <dir_clear+0x7f>
  201d30:	8b 04 24             	mov    (%esp),%eax
  201d33:	01 44 24 0c          	add    %eax,0xc(%esp)
  201d37:	8b 44 24 20          	mov    0x20(%esp),%eax
  201d3b:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  201d3f:	0f b7 c0             	movzwl %ax,%eax
  201d42:	39 44 24 0c          	cmp    %eax,0xc(%esp)
  201d46:	73 2a                	jae    201d72 <dir_clear+0xba>
  201d48:	8b 54 24 08          	mov    0x8(%esp),%edx
  201d4c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  201d50:	01 c2                	add    %eax,%edx
  201d52:	8b 44 24 20          	mov    0x20(%esp),%eax
  201d56:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  201d5a:	0f b6 c0             	movzbl %al,%eax
  201d5d:	ff 34 24             	push   (%esp)
  201d60:	52                   	push   %edx
  201d61:	ff 74 24 0c          	push   0xc(%esp)
  201d65:	50                   	push   %eax
  201d66:	e8 2f e6 ff ff       	call   20039a <disk_write>
  201d6b:	83 c4 10             	add    $0x10,%esp
  201d6e:	85 c0                	test   %eax,%eax
  201d70:	74 be                	je     201d30 <dir_clear+0x78>
  201d72:	8b 44 24 20          	mov    0x20(%esp),%eax
  201d76:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  201d7a:	0f b7 c0             	movzwl %ax,%eax
  201d7d:	39 44 24 0c          	cmp    %eax,0xc(%esp)
  201d81:	0f 95 c0             	setne  %al
  201d84:	0f b6 c0             	movzbl %al,%eax
  201d87:	83 c4 1c             	add    $0x1c,%esp
  201d8a:	c3                   	ret

00201d8b <dir_sdi>:
  201d8b:	83 ec 1c             	sub    $0x1c,%esp
  201d8e:	8b 44 24 20          	mov    0x20(%esp),%eax
  201d92:	8b 00                	mov    (%eax),%eax
  201d94:	89 44 24 08          	mov    %eax,0x8(%esp)
  201d98:	81 7c 24 24 ff ff 1f 	cmpl   $0x1fffff,0x24(%esp)
  201d9f:	00 
  201da0:	77 0b                	ja     201dad <dir_sdi+0x22>
  201da2:	8b 44 24 24          	mov    0x24(%esp),%eax
  201da6:	83 e0 1f             	and    $0x1f,%eax
  201da9:	85 c0                	test   %eax,%eax
  201dab:	74 0a                	je     201db7 <dir_sdi+0x2c>
  201dad:	b8 02 00 00 00       	mov    $0x2,%eax
  201db2:	e9 45 01 00 00       	jmp    201efc <dir_sdi+0x171>
  201db7:	8b 44 24 20          	mov    0x20(%esp),%eax
  201dbb:	8b 54 24 24          	mov    0x24(%esp),%edx
  201dbf:	89 50 10             	mov    %edx,0x10(%eax)
  201dc2:	8b 44 24 20          	mov    0x20(%esp),%eax
  201dc6:	8b 40 08             	mov    0x8(%eax),%eax
  201dc9:	89 44 24 0c          	mov    %eax,0xc(%esp)
  201dcd:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  201dd2:	75 16                	jne    201dea <dir_sdi+0x5f>
  201dd4:	8b 44 24 08          	mov    0x8(%esp),%eax
  201dd8:	0f b6 00             	movzbl (%eax),%eax
  201ddb:	3c 02                	cmp    $0x2,%al
  201ddd:	76 0b                	jbe    201dea <dir_sdi+0x5f>
  201ddf:	8b 44 24 08          	mov    0x8(%esp),%eax
  201de3:	8b 40 2c             	mov    0x2c(%eax),%eax
  201de6:	89 44 24 0c          	mov    %eax,0xc(%esp)
  201dea:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  201def:	75 35                	jne    201e26 <dir_sdi+0x9b>
  201df1:	8b 44 24 24          	mov    0x24(%esp),%eax
  201df5:	c1 e8 05             	shr    $0x5,%eax
  201df8:	89 c2                	mov    %eax,%edx
  201dfa:	8b 44 24 08          	mov    0x8(%esp),%eax
  201dfe:	0f b7 40 08          	movzwl 0x8(%eax),%eax
  201e02:	0f b7 c0             	movzwl %ax,%eax
  201e05:	39 c2                	cmp    %eax,%edx
  201e07:	72 0a                	jb     201e13 <dir_sdi+0x88>
  201e09:	b8 02 00 00 00       	mov    $0x2,%eax
  201e0e:	e9 e9 00 00 00       	jmp    201efc <dir_sdi+0x171>
  201e13:	8b 44 24 08          	mov    0x8(%esp),%eax
  201e17:	8b 50 2c             	mov    0x2c(%eax),%edx
  201e1a:	8b 44 24 20          	mov    0x20(%esp),%eax
  201e1e:	89 50 18             	mov    %edx,0x18(%eax)
  201e21:	e9 84 00 00 00       	jmp    201eaa <dir_sdi+0x11f>
  201e26:	8b 44 24 08          	mov    0x8(%esp),%eax
  201e2a:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  201e2e:	0f b7 c0             	movzwl %ax,%eax
  201e31:	c1 e0 09             	shl    $0x9,%eax
  201e34:	89 44 24 04          	mov    %eax,0x4(%esp)
  201e38:	eb 4c                	jmp    201e86 <dir_sdi+0xfb>
  201e3a:	8b 44 24 20          	mov    0x20(%esp),%eax
  201e3e:	83 ec 08             	sub    $0x8,%esp
  201e41:	ff 74 24 14          	push   0x14(%esp)
  201e45:	50                   	push   %eax
  201e46:	e8 4d f6 ff ff       	call   201498 <get_fat>
  201e4b:	83 c4 10             	add    $0x10,%esp
  201e4e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  201e52:	83 7c 24 0c ff       	cmpl   $0xffffffff,0xc(%esp)
  201e57:	75 0a                	jne    201e63 <dir_sdi+0xd8>
  201e59:	b8 01 00 00 00       	mov    $0x1,%eax
  201e5e:	e9 99 00 00 00       	jmp    201efc <dir_sdi+0x171>
  201e63:	83 7c 24 0c 01       	cmpl   $0x1,0xc(%esp)
  201e68:	76 0d                	jbe    201e77 <dir_sdi+0xec>
  201e6a:	8b 44 24 08          	mov    0x8(%esp),%eax
  201e6e:	8b 40 18             	mov    0x18(%eax),%eax
  201e71:	39 44 24 0c          	cmp    %eax,0xc(%esp)
  201e75:	72 07                	jb     201e7e <dir_sdi+0xf3>
  201e77:	b8 02 00 00 00       	mov    $0x2,%eax
  201e7c:	eb 7e                	jmp    201efc <dir_sdi+0x171>
  201e7e:	8b 44 24 04          	mov    0x4(%esp),%eax
  201e82:	29 44 24 24          	sub    %eax,0x24(%esp)
  201e86:	8b 44 24 24          	mov    0x24(%esp),%eax
  201e8a:	3b 44 24 04          	cmp    0x4(%esp),%eax
  201e8e:	73 aa                	jae    201e3a <dir_sdi+0xaf>
  201e90:	83 ec 08             	sub    $0x8,%esp
  201e93:	ff 74 24 14          	push   0x14(%esp)
  201e97:	ff 74 24 14          	push   0x14(%esp)
  201e9b:	e8 c3 f5 ff ff       	call   201463 <clst2sect>
  201ea0:	83 c4 10             	add    $0x10,%esp
  201ea3:	8b 54 24 20          	mov    0x20(%esp),%edx
  201ea7:	89 42 18             	mov    %eax,0x18(%edx)
  201eaa:	8b 44 24 20          	mov    0x20(%esp),%eax
  201eae:	8b 54 24 0c          	mov    0xc(%esp),%edx
  201eb2:	89 50 14             	mov    %edx,0x14(%eax)
  201eb5:	8b 44 24 20          	mov    0x20(%esp),%eax
  201eb9:	8b 40 18             	mov    0x18(%eax),%eax
  201ebc:	85 c0                	test   %eax,%eax
  201ebe:	75 07                	jne    201ec7 <dir_sdi+0x13c>
  201ec0:	b8 02 00 00 00       	mov    $0x2,%eax
  201ec5:	eb 35                	jmp    201efc <dir_sdi+0x171>
  201ec7:	8b 44 24 20          	mov    0x20(%esp),%eax
  201ecb:	8b 40 18             	mov    0x18(%eax),%eax
  201ece:	8b 54 24 24          	mov    0x24(%esp),%edx
  201ed2:	c1 ea 09             	shr    $0x9,%edx
  201ed5:	01 c2                	add    %eax,%edx
  201ed7:	8b 44 24 20          	mov    0x20(%esp),%eax
  201edb:	89 50 18             	mov    %edx,0x18(%eax)
  201ede:	8b 44 24 08          	mov    0x8(%esp),%eax
  201ee2:	8d 50 34             	lea    0x34(%eax),%edx
  201ee5:	8b 44 24 24          	mov    0x24(%esp),%eax
  201ee9:	25 ff 01 00 00       	and    $0x1ff,%eax
  201eee:	01 c2                	add    %eax,%edx
  201ef0:	8b 44 24 20          	mov    0x20(%esp),%eax
  201ef4:	89 50 1c             	mov    %edx,0x1c(%eax)
  201ef7:	b8 00 00 00 00       	mov    $0x0,%eax
  201efc:	83 c4 1c             	add    $0x1c,%esp
  201eff:	c3                   	ret

00201f00 <dir_next>:
  201f00:	83 ec 1c             	sub    $0x1c,%esp
  201f03:	8b 44 24 20          	mov    0x20(%esp),%eax
  201f07:	8b 00                	mov    (%eax),%eax
  201f09:	89 44 24 08          	mov    %eax,0x8(%esp)
  201f0d:	8b 44 24 20          	mov    0x20(%esp),%eax
  201f11:	8b 40 10             	mov    0x10(%eax),%eax
  201f14:	83 c0 20             	add    $0x20,%eax
  201f17:	89 44 24 04          	mov    %eax,0x4(%esp)
  201f1b:	81 7c 24 04 ff ff 1f 	cmpl   $0x1fffff,0x4(%esp)
  201f22:	00 
  201f23:	76 0b                	jbe    201f30 <dir_next+0x30>
  201f25:	8b 44 24 20          	mov    0x20(%esp),%eax
  201f29:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  201f30:	8b 44 24 20          	mov    0x20(%esp),%eax
  201f34:	8b 40 18             	mov    0x18(%eax),%eax
  201f37:	85 c0                	test   %eax,%eax
  201f39:	75 0a                	jne    201f45 <dir_next+0x45>
  201f3b:	b8 04 00 00 00       	mov    $0x4,%eax
  201f40:	e9 9f 01 00 00       	jmp    2020e4 <dir_next+0x1e4>
  201f45:	8b 44 24 04          	mov    0x4(%esp),%eax
  201f49:	25 ff 01 00 00       	and    $0x1ff,%eax
  201f4e:	85 c0                	test   %eax,%eax
  201f50:	0f 85 65 01 00 00    	jne    2020bb <dir_next+0x1bb>
  201f56:	8b 44 24 20          	mov    0x20(%esp),%eax
  201f5a:	8b 40 18             	mov    0x18(%eax),%eax
  201f5d:	8d 50 01             	lea    0x1(%eax),%edx
  201f60:	8b 44 24 20          	mov    0x20(%esp),%eax
  201f64:	89 50 18             	mov    %edx,0x18(%eax)
  201f67:	8b 44 24 20          	mov    0x20(%esp),%eax
  201f6b:	8b 40 14             	mov    0x14(%eax),%eax
  201f6e:	85 c0                	test   %eax,%eax
  201f70:	75 31                	jne    201fa3 <dir_next+0xa3>
  201f72:	8b 44 24 04          	mov    0x4(%esp),%eax
  201f76:	c1 e8 05             	shr    $0x5,%eax
  201f79:	89 c2                	mov    %eax,%edx
  201f7b:	8b 44 24 08          	mov    0x8(%esp),%eax
  201f7f:	0f b7 40 08          	movzwl 0x8(%eax),%eax
  201f83:	0f b7 c0             	movzwl %ax,%eax
  201f86:	39 c2                	cmp    %eax,%edx
  201f88:	0f 82 2d 01 00 00    	jb     2020bb <dir_next+0x1bb>
  201f8e:	8b 44 24 20          	mov    0x20(%esp),%eax
  201f92:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  201f99:	b8 04 00 00 00       	mov    $0x4,%eax
  201f9e:	e9 41 01 00 00       	jmp    2020e4 <dir_next+0x1e4>
  201fa3:	8b 44 24 04          	mov    0x4(%esp),%eax
  201fa7:	c1 e8 09             	shr    $0x9,%eax
  201faa:	89 c2                	mov    %eax,%edx
  201fac:	8b 44 24 08          	mov    0x8(%esp),%eax
  201fb0:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  201fb4:	0f b7 c0             	movzwl %ax,%eax
  201fb7:	83 e8 01             	sub    $0x1,%eax
  201fba:	21 d0                	and    %edx,%eax
  201fbc:	85 c0                	test   %eax,%eax
  201fbe:	0f 85 f7 00 00 00    	jne    2020bb <dir_next+0x1bb>
  201fc4:	8b 44 24 20          	mov    0x20(%esp),%eax
  201fc8:	8b 50 14             	mov    0x14(%eax),%edx
  201fcb:	8b 44 24 20          	mov    0x20(%esp),%eax
  201fcf:	83 ec 08             	sub    $0x8,%esp
  201fd2:	52                   	push   %edx
  201fd3:	50                   	push   %eax
  201fd4:	e8 bf f4 ff ff       	call   201498 <get_fat>
  201fd9:	83 c4 10             	add    $0x10,%esp
  201fdc:	89 44 24 0c          	mov    %eax,0xc(%esp)
  201fe0:	83 7c 24 0c 01       	cmpl   $0x1,0xc(%esp)
  201fe5:	77 0a                	ja     201ff1 <dir_next+0xf1>
  201fe7:	b8 02 00 00 00       	mov    $0x2,%eax
  201fec:	e9 f3 00 00 00       	jmp    2020e4 <dir_next+0x1e4>
  201ff1:	83 7c 24 0c ff       	cmpl   $0xffffffff,0xc(%esp)
  201ff6:	75 0a                	jne    202002 <dir_next+0x102>
  201ff8:	b8 01 00 00 00       	mov    $0x1,%eax
  201ffd:	e9 e2 00 00 00       	jmp    2020e4 <dir_next+0x1e4>
  202002:	8b 44 24 08          	mov    0x8(%esp),%eax
  202006:	8b 40 18             	mov    0x18(%eax),%eax
  202009:	39 44 24 0c          	cmp    %eax,0xc(%esp)
  20200d:	0f 82 83 00 00 00    	jb     202096 <dir_next+0x196>
  202013:	83 7c 24 24 00       	cmpl   $0x0,0x24(%esp)
  202018:	75 15                	jne    20202f <dir_next+0x12f>
  20201a:	8b 44 24 20          	mov    0x20(%esp),%eax
  20201e:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  202025:	b8 04 00 00 00       	mov    $0x4,%eax
  20202a:	e9 b5 00 00 00       	jmp    2020e4 <dir_next+0x1e4>
  20202f:	8b 44 24 20          	mov    0x20(%esp),%eax
  202033:	8b 50 14             	mov    0x14(%eax),%edx
  202036:	8b 44 24 20          	mov    0x20(%esp),%eax
  20203a:	83 ec 08             	sub    $0x8,%esp
  20203d:	52                   	push   %edx
  20203e:	50                   	push   %eax
  20203f:	e8 eb f9 ff ff       	call   201a2f <create_chain>
  202044:	83 c4 10             	add    $0x10,%esp
  202047:	89 44 24 0c          	mov    %eax,0xc(%esp)
  20204b:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  202050:	75 0a                	jne    20205c <dir_next+0x15c>
  202052:	b8 07 00 00 00       	mov    $0x7,%eax
  202057:	e9 88 00 00 00       	jmp    2020e4 <dir_next+0x1e4>
  20205c:	83 7c 24 0c 01       	cmpl   $0x1,0xc(%esp)
  202061:	75 07                	jne    20206a <dir_next+0x16a>
  202063:	b8 02 00 00 00       	mov    $0x2,%eax
  202068:	eb 7a                	jmp    2020e4 <dir_next+0x1e4>
  20206a:	83 7c 24 0c ff       	cmpl   $0xffffffff,0xc(%esp)
  20206f:	75 07                	jne    202078 <dir_next+0x178>
  202071:	b8 01 00 00 00       	mov    $0x1,%eax
  202076:	eb 6c                	jmp    2020e4 <dir_next+0x1e4>
  202078:	83 ec 08             	sub    $0x8,%esp
  20207b:	ff 74 24 14          	push   0x14(%esp)
  20207f:	ff 74 24 14          	push   0x14(%esp)
  202083:	e8 30 fc ff ff       	call   201cb8 <dir_clear>
  202088:	83 c4 10             	add    $0x10,%esp
  20208b:	85 c0                	test   %eax,%eax
  20208d:	74 07                	je     202096 <dir_next+0x196>
  20208f:	b8 01 00 00 00       	mov    $0x1,%eax
  202094:	eb 4e                	jmp    2020e4 <dir_next+0x1e4>
  202096:	8b 44 24 20          	mov    0x20(%esp),%eax
  20209a:	8b 54 24 0c          	mov    0xc(%esp),%edx
  20209e:	89 50 14             	mov    %edx,0x14(%eax)
  2020a1:	83 ec 08             	sub    $0x8,%esp
  2020a4:	ff 74 24 14          	push   0x14(%esp)
  2020a8:	ff 74 24 14          	push   0x14(%esp)
  2020ac:	e8 b2 f3 ff ff       	call   201463 <clst2sect>
  2020b1:	83 c4 10             	add    $0x10,%esp
  2020b4:	8b 54 24 20          	mov    0x20(%esp),%edx
  2020b8:	89 42 18             	mov    %eax,0x18(%edx)
  2020bb:	8b 44 24 20          	mov    0x20(%esp),%eax
  2020bf:	8b 54 24 04          	mov    0x4(%esp),%edx
  2020c3:	89 50 10             	mov    %edx,0x10(%eax)
  2020c6:	8b 44 24 08          	mov    0x8(%esp),%eax
  2020ca:	8d 50 34             	lea    0x34(%eax),%edx
  2020cd:	8b 44 24 04          	mov    0x4(%esp),%eax
  2020d1:	25 ff 01 00 00       	and    $0x1ff,%eax
  2020d6:	01 c2                	add    %eax,%edx
  2020d8:	8b 44 24 20          	mov    0x20(%esp),%eax
  2020dc:	89 50 1c             	mov    %edx,0x1c(%eax)
  2020df:	b8 00 00 00 00       	mov    $0x0,%eax
  2020e4:	83 c4 1c             	add    $0x1c,%esp
  2020e7:	c3                   	ret

002020e8 <dir_alloc>:
  2020e8:	83 ec 1c             	sub    $0x1c,%esp
  2020eb:	8b 44 24 20          	mov    0x20(%esp),%eax
  2020ef:	8b 00                	mov    (%eax),%eax
  2020f1:	89 44 24 04          	mov    %eax,0x4(%esp)
  2020f5:	83 ec 08             	sub    $0x8,%esp
  2020f8:	6a 00                	push   $0x0
  2020fa:	ff 74 24 2c          	push   0x2c(%esp)
  2020fe:	e8 88 fc ff ff       	call   201d8b <dir_sdi>
  202103:	83 c4 10             	add    $0x10,%esp
  202106:	89 44 24 0c          	mov    %eax,0xc(%esp)
  20210a:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  20210f:	75 7e                	jne    20218f <dir_alloc+0xa7>
  202111:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  202118:	00 
  202119:	8b 44 24 20          	mov    0x20(%esp),%eax
  20211d:	8b 40 18             	mov    0x18(%eax),%eax
  202120:	83 ec 08             	sub    $0x8,%esp
  202123:	50                   	push   %eax
  202124:	ff 74 24 10          	push   0x10(%esp)
  202128:	e8 5f f1 ff ff       	call   20128c <move_window>
  20212d:	83 c4 10             	add    $0x10,%esp
  202130:	89 44 24 0c          	mov    %eax,0xc(%esp)
  202134:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  202139:	75 53                	jne    20218e <dir_alloc+0xa6>
  20213b:	8b 44 24 20          	mov    0x20(%esp),%eax
  20213f:	8b 40 1c             	mov    0x1c(%eax),%eax
  202142:	0f b6 00             	movzbl (%eax),%eax
  202145:	3c e5                	cmp    $0xe5,%al
  202147:	74 0e                	je     202157 <dir_alloc+0x6f>
  202149:	8b 44 24 20          	mov    0x20(%esp),%eax
  20214d:	8b 40 1c             	mov    0x1c(%eax),%eax
  202150:	0f b6 00             	movzbl (%eax),%eax
  202153:	84 c0                	test   %al,%al
  202155:	75 11                	jne    202168 <dir_alloc+0x80>
  202157:	83 44 24 08 01       	addl   $0x1,0x8(%esp)
  20215c:	8b 44 24 08          	mov    0x8(%esp),%eax
  202160:	3b 44 24 24          	cmp    0x24(%esp),%eax
  202164:	75 0a                	jne    202170 <dir_alloc+0x88>
  202166:	eb 27                	jmp    20218f <dir_alloc+0xa7>
  202168:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  20216f:	00 
  202170:	83 ec 08             	sub    $0x8,%esp
  202173:	6a 01                	push   $0x1
  202175:	ff 74 24 2c          	push   0x2c(%esp)
  202179:	e8 82 fd ff ff       	call   201f00 <dir_next>
  20217e:	83 c4 10             	add    $0x10,%esp
  202181:	89 44 24 0c          	mov    %eax,0xc(%esp)
  202185:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  20218a:	74 8d                	je     202119 <dir_alloc+0x31>
  20218c:	eb 01                	jmp    20218f <dir_alloc+0xa7>
  20218e:	90                   	nop
  20218f:	83 7c 24 0c 04       	cmpl   $0x4,0xc(%esp)
  202194:	75 08                	jne    20219e <dir_alloc+0xb6>
  202196:	c7 44 24 0c 07 00 00 	movl   $0x7,0xc(%esp)
  20219d:	00 
  20219e:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2021a2:	83 c4 1c             	add    $0x1c,%esp
  2021a5:	c3                   	ret

002021a6 <ld_clust>:
  2021a6:	83 ec 10             	sub    $0x10,%esp
  2021a9:	8b 44 24 18          	mov    0x18(%esp),%eax
  2021ad:	83 c0 1a             	add    $0x1a,%eax
  2021b0:	50                   	push   %eax
  2021b1:	e8 50 eb ff ff       	call   200d06 <ld_16>
  2021b6:	83 c4 04             	add    $0x4,%esp
  2021b9:	0f b7 c0             	movzwl %ax,%eax
  2021bc:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2021c0:	8b 44 24 14          	mov    0x14(%esp),%eax
  2021c4:	0f b6 00             	movzbl (%eax),%eax
  2021c7:	3c 03                	cmp    $0x3,%al
  2021c9:	75 1a                	jne    2021e5 <ld_clust+0x3f>
  2021cb:	8b 44 24 18          	mov    0x18(%esp),%eax
  2021cf:	83 c0 14             	add    $0x14,%eax
  2021d2:	50                   	push   %eax
  2021d3:	e8 2e eb ff ff       	call   200d06 <ld_16>
  2021d8:	83 c4 04             	add    $0x4,%esp
  2021db:	0f b7 c0             	movzwl %ax,%eax
  2021de:	c1 e0 10             	shl    $0x10,%eax
  2021e1:	09 44 24 0c          	or     %eax,0xc(%esp)
  2021e5:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2021e9:	83 c4 10             	add    $0x10,%esp
  2021ec:	c3                   	ret

002021ed <st_clust>:
  2021ed:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2021f1:	0f b7 c0             	movzwl %ax,%eax
  2021f4:	8b 54 24 08          	mov    0x8(%esp),%edx
  2021f8:	83 c2 1a             	add    $0x1a,%edx
  2021fb:	50                   	push   %eax
  2021fc:	52                   	push   %edx
  2021fd:	e8 aa eb ff ff       	call   200dac <st_16>
  202202:	83 c4 08             	add    $0x8,%esp
  202205:	8b 44 24 04          	mov    0x4(%esp),%eax
  202209:	0f b6 00             	movzbl (%eax),%eax
  20220c:	3c 03                	cmp    $0x3,%al
  20220e:	75 1b                	jne    20222b <st_clust+0x3e>
  202210:	8b 44 24 0c          	mov    0xc(%esp),%eax
  202214:	c1 e8 10             	shr    $0x10,%eax
  202217:	0f b7 c0             	movzwl %ax,%eax
  20221a:	8b 54 24 08          	mov    0x8(%esp),%edx
  20221e:	83 c2 14             	add    $0x14,%edx
  202221:	50                   	push   %eax
  202222:	52                   	push   %edx
  202223:	e8 84 eb ff ff       	call   200dac <st_16>
  202228:	83 c4 08             	add    $0x8,%esp
  20222b:	90                   	nop
  20222c:	c3                   	ret

0020222d <cmp_lfn>:
  20222d:	53                   	push   %ebx
  20222e:	83 ec 18             	sub    $0x18,%esp
  202231:	8b 44 24 24          	mov    0x24(%esp),%eax
  202235:	83 c0 1a             	add    $0x1a,%eax
  202238:	50                   	push   %eax
  202239:	e8 c8 ea ff ff       	call   200d06 <ld_16>
  20223e:	83 c4 04             	add    $0x4,%esp
  202241:	66 85 c0             	test   %ax,%ax
  202244:	74 0a                	je     202250 <cmp_lfn+0x23>
  202246:	b8 00 00 00 00       	mov    $0x0,%eax
  20224b:	e9 13 01 00 00       	jmp    202363 <cmp_lfn+0x136>
  202250:	8b 44 24 24          	mov    0x24(%esp),%eax
  202254:	0f b6 00             	movzbl (%eax),%eax
  202257:	0f b6 c0             	movzbl %al,%eax
  20225a:	83 e0 3f             	and    $0x3f,%eax
  20225d:	83 e8 01             	sub    $0x1,%eax
  202260:	89 c2                	mov    %eax,%edx
  202262:	89 d0                	mov    %edx,%eax
  202264:	01 c0                	add    %eax,%eax
  202266:	01 d0                	add    %edx,%eax
  202268:	c1 e0 02             	shl    $0x2,%eax
  20226b:	01 d0                	add    %edx,%eax
  20226d:	89 44 24 0c          	mov    %eax,0xc(%esp)
  202271:	66 c7 44 24 06 01 00 	movw   $0x1,0x6(%esp)
  202278:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  20227f:	00 
  202280:	e9 99 00 00 00       	jmp    20231e <cmp_lfn+0xf1>
  202285:	8b 44 24 08          	mov    0x8(%esp),%eax
  202289:	05 a0 71 20 00       	add    $0x2071a0,%eax
  20228e:	0f b6 00             	movzbl (%eax),%eax
  202291:	0f b6 d0             	movzbl %al,%edx
  202294:	8b 44 24 24          	mov    0x24(%esp),%eax
  202298:	01 d0                	add    %edx,%eax
  20229a:	50                   	push   %eax
  20229b:	e8 66 ea ff ff       	call   200d06 <ld_16>
  2022a0:	83 c4 04             	add    $0x4,%esp
  2022a3:	66 89 44 24 04       	mov    %ax,0x4(%esp)
  2022a8:	66 83 7c 24 06 00    	cmpw   $0x0,0x6(%esp)
  2022ae:	74 5a                	je     20230a <cmp_lfn+0xdd>
  2022b0:	81 7c 24 0c ff 00 00 	cmpl   $0xff,0xc(%esp)
  2022b7:	00 
  2022b8:	77 3d                	ja     2022f7 <cmp_lfn+0xca>
  2022ba:	0f b7 44 24 04       	movzwl 0x4(%esp),%eax
  2022bf:	83 ec 0c             	sub    $0xc,%esp
  2022c2:	50                   	push   %eax
  2022c3:	e8 25 46 00 00       	call   2068ed <ff_wtoupper>
  2022c8:	83 c4 10             	add    $0x10,%esp
  2022cb:	89 c3                	mov    %eax,%ebx
  2022cd:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2022d1:	8d 50 01             	lea    0x1(%eax),%edx
  2022d4:	89 54 24 0c          	mov    %edx,0xc(%esp)
  2022d8:	8d 14 00             	lea    (%eax,%eax,1),%edx
  2022db:	8b 44 24 20          	mov    0x20(%esp),%eax
  2022df:	01 d0                	add    %edx,%eax
  2022e1:	0f b7 00             	movzwl (%eax),%eax
  2022e4:	0f b7 c0             	movzwl %ax,%eax
  2022e7:	83 ec 0c             	sub    $0xc,%esp
  2022ea:	50                   	push   %eax
  2022eb:	e8 fd 45 00 00       	call   2068ed <ff_wtoupper>
  2022f0:	83 c4 10             	add    $0x10,%esp
  2022f3:	39 c3                	cmp    %eax,%ebx
  2022f5:	74 07                	je     2022fe <cmp_lfn+0xd1>
  2022f7:	b8 00 00 00 00       	mov    $0x0,%eax
  2022fc:	eb 65                	jmp    202363 <cmp_lfn+0x136>
  2022fe:	0f b7 44 24 04       	movzwl 0x4(%esp),%eax
  202303:	66 89 44 24 06       	mov    %ax,0x6(%esp)
  202308:	eb 0f                	jmp    202319 <cmp_lfn+0xec>
  20230a:	66 83 7c 24 04 ff    	cmpw   $0xffff,0x4(%esp)
  202310:	74 07                	je     202319 <cmp_lfn+0xec>
  202312:	b8 00 00 00 00       	mov    $0x0,%eax
  202317:	eb 4a                	jmp    202363 <cmp_lfn+0x136>
  202319:	83 44 24 08 01       	addl   $0x1,0x8(%esp)
  20231e:	83 7c 24 08 0c       	cmpl   $0xc,0x8(%esp)
  202323:	0f 86 5c ff ff ff    	jbe    202285 <cmp_lfn+0x58>
  202329:	8b 44 24 24          	mov    0x24(%esp),%eax
  20232d:	0f b6 00             	movzbl (%eax),%eax
  202330:	0f b6 c0             	movzbl %al,%eax
  202333:	83 e0 40             	and    $0x40,%eax
  202336:	85 c0                	test   %eax,%eax
  202338:	74 24                	je     20235e <cmp_lfn+0x131>
  20233a:	66 83 7c 24 06 00    	cmpw   $0x0,0x6(%esp)
  202340:	74 1c                	je     20235e <cmp_lfn+0x131>
  202342:	8b 44 24 0c          	mov    0xc(%esp),%eax
  202346:	8d 14 00             	lea    (%eax,%eax,1),%edx
  202349:	8b 44 24 20          	mov    0x20(%esp),%eax
  20234d:	01 d0                	add    %edx,%eax
  20234f:	0f b7 00             	movzwl (%eax),%eax
  202352:	66 85 c0             	test   %ax,%ax
  202355:	74 07                	je     20235e <cmp_lfn+0x131>
  202357:	b8 00 00 00 00       	mov    $0x0,%eax
  20235c:	eb 05                	jmp    202363 <cmp_lfn+0x136>
  20235e:	b8 01 00 00 00       	mov    $0x1,%eax
  202363:	83 c4 18             	add    $0x18,%esp
  202366:	5b                   	pop    %ebx
  202367:	c3                   	ret

00202368 <pick_lfn>:
  202368:	83 ec 10             	sub    $0x10,%esp
  20236b:	8b 44 24 18          	mov    0x18(%esp),%eax
  20236f:	83 c0 1a             	add    $0x1a,%eax
  202372:	50                   	push   %eax
  202373:	e8 8e e9 ff ff       	call   200d06 <ld_16>
  202378:	83 c4 04             	add    $0x4,%esp
  20237b:	66 85 c0             	test   %ax,%ax
  20237e:	74 0a                	je     20238a <pick_lfn+0x22>
  202380:	b8 00 00 00 00       	mov    $0x0,%eax
  202385:	e9 f9 00 00 00       	jmp    202483 <pick_lfn+0x11b>
  20238a:	8b 44 24 18          	mov    0x18(%esp),%eax
  20238e:	0f b6 00             	movzbl (%eax),%eax
  202391:	0f b6 c0             	movzbl %al,%eax
  202394:	83 e0 bf             	and    $0xffffffbf,%eax
  202397:	83 e8 01             	sub    $0x1,%eax
  20239a:	89 c2                	mov    %eax,%edx
  20239c:	89 d0                	mov    %edx,%eax
  20239e:	01 c0                	add    %eax,%eax
  2023a0:	01 d0                	add    %edx,%eax
  2023a2:	c1 e0 02             	shl    $0x2,%eax
  2023a5:	01 d0                	add    %edx,%eax
  2023a7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2023ab:	66 c7 44 24 06 01 00 	movw   $0x1,0x6(%esp)
  2023b2:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  2023b9:	00 
  2023ba:	eb 7b                	jmp    202437 <pick_lfn+0xcf>
  2023bc:	8b 44 24 08          	mov    0x8(%esp),%eax
  2023c0:	05 a0 71 20 00       	add    $0x2071a0,%eax
  2023c5:	0f b6 00             	movzbl (%eax),%eax
  2023c8:	0f b6 d0             	movzbl %al,%edx
  2023cb:	8b 44 24 18          	mov    0x18(%esp),%eax
  2023cf:	01 d0                	add    %edx,%eax
  2023d1:	50                   	push   %eax
  2023d2:	e8 2f e9 ff ff       	call   200d06 <ld_16>
  2023d7:	83 c4 04             	add    $0x4,%esp
  2023da:	66 89 44 24 04       	mov    %ax,0x4(%esp)
  2023df:	66 83 7c 24 06 00    	cmpw   $0x0,0x6(%esp)
  2023e5:	74 3c                	je     202423 <pick_lfn+0xbb>
  2023e7:	81 7c 24 0c ff 00 00 	cmpl   $0xff,0xc(%esp)
  2023ee:	00 
  2023ef:	76 0a                	jbe    2023fb <pick_lfn+0x93>
  2023f1:	b8 00 00 00 00       	mov    $0x0,%eax
  2023f6:	e9 88 00 00 00       	jmp    202483 <pick_lfn+0x11b>
  2023fb:	0f b7 44 24 04       	movzwl 0x4(%esp),%eax
  202400:	66 89 44 24 06       	mov    %ax,0x6(%esp)
  202405:	8b 44 24 0c          	mov    0xc(%esp),%eax
  202409:	8d 50 01             	lea    0x1(%eax),%edx
  20240c:	89 54 24 0c          	mov    %edx,0xc(%esp)
  202410:	8d 14 00             	lea    (%eax,%eax,1),%edx
  202413:	8b 44 24 14          	mov    0x14(%esp),%eax
  202417:	01 c2                	add    %eax,%edx
  202419:	0f b7 44 24 06       	movzwl 0x6(%esp),%eax
  20241e:	66 89 02             	mov    %ax,(%edx)
  202421:	eb 0f                	jmp    202432 <pick_lfn+0xca>
  202423:	66 83 7c 24 04 ff    	cmpw   $0xffff,0x4(%esp)
  202429:	74 07                	je     202432 <pick_lfn+0xca>
  20242b:	b8 00 00 00 00       	mov    $0x0,%eax
  202430:	eb 51                	jmp    202483 <pick_lfn+0x11b>
  202432:	83 44 24 08 01       	addl   $0x1,0x8(%esp)
  202437:	83 7c 24 08 0c       	cmpl   $0xc,0x8(%esp)
  20243c:	0f 86 7a ff ff ff    	jbe    2023bc <pick_lfn+0x54>
  202442:	8b 44 24 18          	mov    0x18(%esp),%eax
  202446:	0f b6 00             	movzbl (%eax),%eax
  202449:	0f b6 c0             	movzbl %al,%eax
  20244c:	83 e0 40             	and    $0x40,%eax
  20244f:	85 c0                	test   %eax,%eax
  202451:	74 2b                	je     20247e <pick_lfn+0x116>
  202453:	66 83 7c 24 06 00    	cmpw   $0x0,0x6(%esp)
  202459:	74 23                	je     20247e <pick_lfn+0x116>
  20245b:	81 7c 24 0c ff 00 00 	cmpl   $0xff,0xc(%esp)
  202462:	00 
  202463:	76 07                	jbe    20246c <pick_lfn+0x104>
  202465:	b8 00 00 00 00       	mov    $0x0,%eax
  20246a:	eb 17                	jmp    202483 <pick_lfn+0x11b>
  20246c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  202470:	8d 14 00             	lea    (%eax,%eax,1),%edx
  202473:	8b 44 24 14          	mov    0x14(%esp),%eax
  202477:	01 d0                	add    %edx,%eax
  202479:	66 c7 00 00 00       	movw   $0x0,(%eax)
  20247e:	b8 01 00 00 00       	mov    $0x1,%eax
  202483:	83 c4 10             	add    $0x10,%esp
  202486:	c3                   	ret

00202487 <put_lfn>:
  202487:	83 ec 18             	sub    $0x18,%esp
  20248a:	8b 54 24 24          	mov    0x24(%esp),%edx
  20248e:	8b 44 24 28          	mov    0x28(%esp),%eax
  202492:	88 54 24 04          	mov    %dl,0x4(%esp)
  202496:	88 04 24             	mov    %al,(%esp)
  202499:	8b 44 24 20          	mov    0x20(%esp),%eax
  20249d:	8d 50 0d             	lea    0xd(%eax),%edx
  2024a0:	0f b6 04 24          	movzbl (%esp),%eax
  2024a4:	88 02                	mov    %al,(%edx)
  2024a6:	8b 44 24 20          	mov    0x20(%esp),%eax
  2024aa:	83 c0 0b             	add    $0xb,%eax
  2024ad:	c6 00 0f             	movb   $0xf,(%eax)
  2024b0:	8b 44 24 20          	mov    0x20(%esp),%eax
  2024b4:	83 c0 0c             	add    $0xc,%eax
  2024b7:	c6 00 00             	movb   $0x0,(%eax)
  2024ba:	8b 44 24 20          	mov    0x20(%esp),%eax
  2024be:	83 c0 1a             	add    $0x1a,%eax
  2024c1:	6a 00                	push   $0x0
  2024c3:	50                   	push   %eax
  2024c4:	e8 e3 e8 ff ff       	call   200dac <st_16>
  2024c9:	83 c4 08             	add    $0x8,%esp
  2024cc:	0f b6 44 24 04       	movzbl 0x4(%esp),%eax
  2024d1:	83 e8 01             	sub    $0x1,%eax
  2024d4:	89 c2                	mov    %eax,%edx
  2024d6:	89 d0                	mov    %edx,%eax
  2024d8:	01 c0                	add    %eax,%eax
  2024da:	01 d0                	add    %edx,%eax
  2024dc:	c1 e0 02             	shl    $0x2,%eax
  2024df:	01 d0                	add    %edx,%eax
  2024e1:	89 44 24 14          	mov    %eax,0x14(%esp)
  2024e5:	66 c7 44 24 0e 00 00 	movw   $0x0,0xe(%esp)
  2024ec:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  2024f3:	00 
  2024f4:	66 83 7c 24 0e ff    	cmpw   $0xffff,0xe(%esp)
  2024fa:	74 1c                	je     202518 <put_lfn+0x91>
  2024fc:	8b 44 24 14          	mov    0x14(%esp),%eax
  202500:	8d 50 01             	lea    0x1(%eax),%edx
  202503:	89 54 24 14          	mov    %edx,0x14(%esp)
  202507:	8d 14 00             	lea    (%eax,%eax,1),%edx
  20250a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  20250e:	01 d0                	add    %edx,%eax
  202510:	0f b7 00             	movzwl (%eax),%eax
  202513:	66 89 44 24 0e       	mov    %ax,0xe(%esp)
  202518:	0f b7 44 24 0e       	movzwl 0xe(%esp),%eax
  20251d:	8b 54 24 10          	mov    0x10(%esp),%edx
  202521:	81 c2 a0 71 20 00    	add    $0x2071a0,%edx
  202527:	0f b6 12             	movzbl (%edx),%edx
  20252a:	0f b6 ca             	movzbl %dl,%ecx
  20252d:	8b 54 24 20          	mov    0x20(%esp),%edx
  202531:	01 ca                	add    %ecx,%edx
  202533:	50                   	push   %eax
  202534:	52                   	push   %edx
  202535:	e8 72 e8 ff ff       	call   200dac <st_16>
  20253a:	83 c4 08             	add    $0x8,%esp
  20253d:	66 83 7c 24 0e 00    	cmpw   $0x0,0xe(%esp)
  202543:	75 07                	jne    20254c <put_lfn+0xc5>
  202545:	66 c7 44 24 0e ff ff 	movw   $0xffff,0xe(%esp)
  20254c:	83 44 24 10 01       	addl   $0x1,0x10(%esp)
  202551:	83 7c 24 10 0c       	cmpl   $0xc,0x10(%esp)
  202556:	76 9c                	jbe    2024f4 <put_lfn+0x6d>
  202558:	66 83 7c 24 0e ff    	cmpw   $0xffff,0xe(%esp)
  20255e:	74 15                	je     202575 <put_lfn+0xee>
  202560:	8b 44 24 14          	mov    0x14(%esp),%eax
  202564:	8d 14 00             	lea    (%eax,%eax,1),%edx
  202567:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  20256b:	01 d0                	add    %edx,%eax
  20256d:	0f b7 00             	movzwl (%eax),%eax
  202570:	66 85 c0             	test   %ax,%ax
  202573:	75 05                	jne    20257a <put_lfn+0xf3>
  202575:	80 4c 24 04 40       	orb    $0x40,0x4(%esp)
  20257a:	8b 44 24 20          	mov    0x20(%esp),%eax
  20257e:	0f b6 54 24 04       	movzbl 0x4(%esp),%edx
  202583:	88 10                	mov    %dl,(%eax)
  202585:	90                   	nop
  202586:	83 c4 18             	add    $0x18,%esp
  202589:	c3                   	ret

0020258a <gen_numname>:
  20258a:	83 ec 3c             	sub    $0x3c,%esp
  20258d:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  202591:	66 89 44 24 0c       	mov    %ax,0xc(%esp)
  202596:	83 ec 04             	sub    $0x4,%esp
  202599:	6a 0b                	push   $0xb
  20259b:	ff 74 24 4c          	push   0x4c(%esp)
  20259f:	ff 74 24 4c          	push   0x4c(%esp)
  2025a3:	e8 9b 48 00 00       	call   206e43 <memcpy>
  2025a8:	83 c4 10             	add    $0x10,%esp
  2025ab:	66 83 7c 24 0c 05    	cmpw   $0x5,0xc(%esp)
  2025b1:	76 78                	jbe    20262b <gen_numname+0xa1>
  2025b3:	0f b7 44 24 0c       	movzwl 0xc(%esp),%eax
  2025b8:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  2025bc:	eb 58                	jmp    202616 <gen_numname+0x8c>
  2025be:	8b 44 24 48          	mov    0x48(%esp),%eax
  2025c2:	8d 50 02             	lea    0x2(%eax),%edx
  2025c5:	89 54 24 48          	mov    %edx,0x48(%esp)
  2025c9:	0f b7 00             	movzwl (%eax),%eax
  2025cc:	66 89 44 24 22       	mov    %ax,0x22(%esp)
  2025d1:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  2025d8:	00 
  2025d9:	eb 34                	jmp    20260f <gen_numname+0x85>
  2025db:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2025df:	8d 14 00             	lea    (%eax,%eax,1),%edx
  2025e2:	0f b7 44 24 22       	movzwl 0x22(%esp),%eax
  2025e7:	83 e0 01             	and    $0x1,%eax
  2025ea:	01 d0                	add    %edx,%eax
  2025ec:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  2025f0:	66 d1 6c 24 22       	shrw   $1,0x22(%esp)
  2025f5:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2025f9:	25 00 00 01 00       	and    $0x10000,%eax
  2025fe:	85 c0                	test   %eax,%eax
  202600:	74 08                	je     20260a <gen_numname+0x80>
  202602:	81 74 24 1c 21 10 01 	xorl   $0x11021,0x1c(%esp)
  202609:	00 
  20260a:	83 44 24 28 01       	addl   $0x1,0x28(%esp)
  20260f:	83 7c 24 28 0f       	cmpl   $0xf,0x28(%esp)
  202614:	76 c5                	jbe    2025db <gen_numname+0x51>
  202616:	8b 44 24 48          	mov    0x48(%esp),%eax
  20261a:	0f b7 00             	movzwl (%eax),%eax
  20261d:	66 85 c0             	test   %ax,%ax
  202620:	75 9c                	jne    2025be <gen_numname+0x34>
  202622:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  202626:	66 89 44 24 0c       	mov    %ax,0xc(%esp)
  20262b:	c7 44 24 28 07 00 00 	movl   $0x7,0x28(%esp)
  202632:	00 
  202633:	0f b7 44 24 0c       	movzwl 0xc(%esp),%eax
  202638:	83 e0 0f             	and    $0xf,%eax
  20263b:	83 c0 30             	add    $0x30,%eax
  20263e:	88 44 24 2f          	mov    %al,0x2f(%esp)
  202642:	66 c1 6c 24 0c 04    	shrw   $0x4,0xc(%esp)
  202648:	80 7c 24 2f 39       	cmpb   $0x39,0x2f(%esp)
  20264d:	76 05                	jbe    202654 <gen_numname+0xca>
  20264f:	80 44 24 2f 07       	addb   $0x7,0x2f(%esp)
  202654:	8b 44 24 28          	mov    0x28(%esp),%eax
  202658:	8d 50 ff             	lea    -0x1(%eax),%edx
  20265b:	89 54 24 28          	mov    %edx,0x28(%esp)
  20265f:	0f b6 54 24 2f       	movzbl 0x2f(%esp),%edx
  202664:	88 54 04 14          	mov    %dl,0x14(%esp,%eax,1)
  202668:	83 7c 24 28 00       	cmpl   $0x0,0x28(%esp)
  20266d:	74 08                	je     202677 <gen_numname+0xed>
  20266f:	66 83 7c 24 0c 00    	cmpw   $0x0,0xc(%esp)
  202675:	75 bc                	jne    202633 <gen_numname+0xa9>
  202677:	8d 54 24 14          	lea    0x14(%esp),%edx
  20267b:	8b 44 24 28          	mov    0x28(%esp),%eax
  20267f:	01 d0                	add    %edx,%eax
  202681:	c6 00 7e             	movb   $0x7e,(%eax)
  202684:	c7 44 24 24 00 00 00 	movl   $0x0,0x24(%esp)
  20268b:	00 
  20268c:	eb 37                	jmp    2026c5 <gen_numname+0x13b>
  20268e:	8b 54 24 40          	mov    0x40(%esp),%edx
  202692:	8b 44 24 24          	mov    0x24(%esp),%eax
  202696:	01 d0                	add    %edx,%eax
  202698:	0f b6 00             	movzbl (%eax),%eax
  20269b:	0f b6 c0             	movzbl %al,%eax
  20269e:	83 ec 0c             	sub    $0xc,%esp
  2026a1:	50                   	push   %eax
  2026a2:	e8 91 e7 ff ff       	call   200e38 <dbc_1st>
  2026a7:	83 c4 10             	add    $0x10,%esp
  2026aa:	85 c0                	test   %eax,%eax
  2026ac:	74 12                	je     2026c0 <gen_numname+0x136>
  2026ae:	8b 44 24 28          	mov    0x28(%esp),%eax
  2026b2:	83 e8 01             	sub    $0x1,%eax
  2026b5:	39 44 24 24          	cmp    %eax,0x24(%esp)
  2026b9:	74 27                	je     2026e2 <gen_numname+0x158>
  2026bb:	83 44 24 24 01       	addl   $0x1,0x24(%esp)
  2026c0:	83 44 24 24 01       	addl   $0x1,0x24(%esp)
  2026c5:	8b 44 24 24          	mov    0x24(%esp),%eax
  2026c9:	3b 44 24 28          	cmp    0x28(%esp),%eax
  2026cd:	73 14                	jae    2026e3 <gen_numname+0x159>
  2026cf:	8b 54 24 40          	mov    0x40(%esp),%edx
  2026d3:	8b 44 24 24          	mov    0x24(%esp),%eax
  2026d7:	01 d0                	add    %edx,%eax
  2026d9:	0f b6 00             	movzbl (%eax),%eax
  2026dc:	3c 20                	cmp    $0x20,%al
  2026de:	75 ae                	jne    20268e <gen_numname+0x104>
  2026e0:	eb 01                	jmp    2026e3 <gen_numname+0x159>
  2026e2:	90                   	nop
  2026e3:	83 7c 24 28 07       	cmpl   $0x7,0x28(%esp)
  2026e8:	77 12                	ja     2026fc <gen_numname+0x172>
  2026ea:	8b 44 24 28          	mov    0x28(%esp),%eax
  2026ee:	8d 50 01             	lea    0x1(%eax),%edx
  2026f1:	89 54 24 28          	mov    %edx,0x28(%esp)
  2026f5:	0f b6 54 04 14       	movzbl 0x14(%esp,%eax,1),%edx
  2026fa:	eb 05                	jmp    202701 <gen_numname+0x177>
  2026fc:	ba 20 00 00 00       	mov    $0x20,%edx
  202701:	8b 44 24 24          	mov    0x24(%esp),%eax
  202705:	8d 48 01             	lea    0x1(%eax),%ecx
  202708:	89 4c 24 24          	mov    %ecx,0x24(%esp)
  20270c:	8b 4c 24 40          	mov    0x40(%esp),%ecx
  202710:	01 c8                	add    %ecx,%eax
  202712:	88 10                	mov    %dl,(%eax)
  202714:	83 7c 24 24 07       	cmpl   $0x7,0x24(%esp)
  202719:	76 c8                	jbe    2026e3 <gen_numname+0x159>
  20271b:	90                   	nop
  20271c:	90                   	nop
  20271d:	83 c4 3c             	add    $0x3c,%esp
  202720:	c3                   	ret

00202721 <sum_sfn>:
  202721:	83 ec 10             	sub    $0x10,%esp
  202724:	c6 44 24 0f 00       	movb   $0x0,0xf(%esp)
  202729:	c7 44 24 08 0b 00 00 	movl   $0xb,0x8(%esp)
  202730:	00 
  202731:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
  202736:	d0 c8                	ror    $1,%al
  202738:	89 c1                	mov    %eax,%ecx
  20273a:	8b 44 24 14          	mov    0x14(%esp),%eax
  20273e:	8d 50 01             	lea    0x1(%eax),%edx
  202741:	89 54 24 14          	mov    %edx,0x14(%esp)
  202745:	0f b6 00             	movzbl (%eax),%eax
  202748:	01 c8                	add    %ecx,%eax
  20274a:	88 44 24 0f          	mov    %al,0xf(%esp)
  20274e:	83 6c 24 08 01       	subl   $0x1,0x8(%esp)
  202753:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  202758:	75 d7                	jne    202731 <sum_sfn+0x10>
  20275a:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
  20275f:	83 c4 10             	add    $0x10,%esp
  202762:	c3                   	ret

00202763 <dir_read>:
  202763:	83 ec 1c             	sub    $0x1c,%esp
  202766:	c7 44 24 0c 04 00 00 	movl   $0x4,0xc(%esp)
  20276d:	00 
  20276e:	8b 44 24 20          	mov    0x20(%esp),%eax
  202772:	8b 00                	mov    (%eax),%eax
  202774:	89 44 24 04          	mov    %eax,0x4(%esp)
  202778:	c6 44 24 0a ff       	movb   $0xff,0xa(%esp)
  20277d:	c6 44 24 09 ff       	movb   $0xff,0x9(%esp)
  202782:	e9 6d 01 00 00       	jmp    2028f4 <dir_read+0x191>
  202787:	8b 44 24 20          	mov    0x20(%esp),%eax
  20278b:	8b 40 18             	mov    0x18(%eax),%eax
  20278e:	83 ec 08             	sub    $0x8,%esp
  202791:	50                   	push   %eax
  202792:	ff 74 24 10          	push   0x10(%esp)
  202796:	e8 f1 ea ff ff       	call   20128c <move_window>
  20279b:	83 c4 10             	add    $0x10,%esp
  20279e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2027a2:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  2027a7:	0f 85 58 01 00 00    	jne    202905 <dir_read+0x1a2>
  2027ad:	8b 44 24 20          	mov    0x20(%esp),%eax
  2027b1:	8b 40 1c             	mov    0x1c(%eax),%eax
  2027b4:	0f b6 00             	movzbl (%eax),%eax
  2027b7:	88 44 24 0b          	mov    %al,0xb(%esp)
  2027bb:	80 7c 24 0b 00       	cmpb   $0x0,0xb(%esp)
  2027c0:	75 0d                	jne    2027cf <dir_read+0x6c>
  2027c2:	c7 44 24 0c 04 00 00 	movl   $0x4,0xc(%esp)
  2027c9:	00 
  2027ca:	e9 3d 01 00 00       	jmp    20290c <dir_read+0x1a9>
  2027cf:	8b 44 24 20          	mov    0x20(%esp),%eax
  2027d3:	8b 40 1c             	mov    0x1c(%eax),%eax
  2027d6:	83 c0 0b             	add    $0xb,%eax
  2027d9:	0f b6 00             	movzbl (%eax),%eax
  2027dc:	83 e0 3f             	and    $0x3f,%eax
  2027df:	88 44 24 03          	mov    %al,0x3(%esp)
  2027e3:	8b 44 24 20          	mov    0x20(%esp),%eax
  2027e7:	0f b6 54 24 03       	movzbl 0x3(%esp),%edx
  2027ec:	88 50 06             	mov    %dl,0x6(%eax)
  2027ef:	80 7c 24 0b e5       	cmpb   $0xe5,0xb(%esp)
  2027f4:	74 1e                	je     202814 <dir_read+0xb1>
  2027f6:	80 7c 24 0b 2e       	cmpb   $0x2e,0xb(%esp)
  2027fb:	74 17                	je     202814 <dir_read+0xb1>
  2027fd:	0f b6 44 24 03       	movzbl 0x3(%esp),%eax
  202802:	83 e0 df             	and    $0xffffffdf,%eax
  202805:	83 f8 08             	cmp    $0x8,%eax
  202808:	0f 94 c0             	sete   %al
  20280b:	0f b6 c0             	movzbl %al,%eax
  20280e:	39 44 24 24          	cmp    %eax,0x24(%esp)
  202812:	74 0a                	je     20281e <dir_read+0xbb>
  202814:	c6 44 24 0a ff       	movb   $0xff,0xa(%esp)
  202819:	e9 ba 00 00 00       	jmp    2028d8 <dir_read+0x175>
  20281e:	80 7c 24 03 0f       	cmpb   $0xf,0x3(%esp)
  202823:	0f 85 82 00 00 00    	jne    2028ab <dir_read+0x148>
  202829:	0f b6 44 24 0b       	movzbl 0xb(%esp),%eax
  20282e:	83 e0 40             	and    $0x40,%eax
  202831:	85 c0                	test   %eax,%eax
  202833:	74 2b                	je     202860 <dir_read+0xfd>
  202835:	8b 44 24 20          	mov    0x20(%esp),%eax
  202839:	8b 40 1c             	mov    0x1c(%eax),%eax
  20283c:	0f b6 40 0d          	movzbl 0xd(%eax),%eax
  202840:	88 44 24 09          	mov    %al,0x9(%esp)
  202844:	80 64 24 0b bf       	andb   $0xbf,0xb(%esp)
  202849:	0f b6 44 24 0b       	movzbl 0xb(%esp),%eax
  20284e:	88 44 24 0a          	mov    %al,0xa(%esp)
  202852:	8b 44 24 20          	mov    0x20(%esp),%eax
  202856:	8b 50 10             	mov    0x10(%eax),%edx
  202859:	8b 44 24 20          	mov    0x20(%esp),%eax
  20285d:	89 50 2c             	mov    %edx,0x2c(%eax)
  202860:	0f b6 44 24 0b       	movzbl 0xb(%esp),%eax
  202865:	3a 44 24 0a          	cmp    0xa(%esp),%al
  202869:	75 39                	jne    2028a4 <dir_read+0x141>
  20286b:	8b 44 24 20          	mov    0x20(%esp),%eax
  20286f:	8b 40 1c             	mov    0x1c(%eax),%eax
  202872:	83 c0 0d             	add    $0xd,%eax
  202875:	0f b6 00             	movzbl (%eax),%eax
  202878:	38 44 24 09          	cmp    %al,0x9(%esp)
  20287c:	75 26                	jne    2028a4 <dir_read+0x141>
  20287e:	8b 44 24 20          	mov    0x20(%esp),%eax
  202882:	8b 50 1c             	mov    0x1c(%eax),%edx
  202885:	8b 44 24 04          	mov    0x4(%esp),%eax
  202889:	8b 40 0c             	mov    0xc(%eax),%eax
  20288c:	83 ec 08             	sub    $0x8,%esp
  20288f:	52                   	push   %edx
  202890:	50                   	push   %eax
  202891:	e8 d2 fa ff ff       	call   202368 <pick_lfn>
  202896:	83 c4 10             	add    $0x10,%esp
  202899:	85 c0                	test   %eax,%eax
  20289b:	74 07                	je     2028a4 <dir_read+0x141>
  20289d:	80 6c 24 0a 01       	subb   $0x1,0xa(%esp)
  2028a2:	eb 34                	jmp    2028d8 <dir_read+0x175>
  2028a4:	c6 44 24 0a ff       	movb   $0xff,0xa(%esp)
  2028a9:	eb 2d                	jmp    2028d8 <dir_read+0x175>
  2028ab:	80 7c 24 0a 00       	cmpb   $0x0,0xa(%esp)
  2028b0:	75 19                	jne    2028cb <dir_read+0x168>
  2028b2:	8b 44 24 20          	mov    0x20(%esp),%eax
  2028b6:	8b 40 1c             	mov    0x1c(%eax),%eax
  2028b9:	83 ec 0c             	sub    $0xc,%esp
  2028bc:	50                   	push   %eax
  2028bd:	e8 5f fe ff ff       	call   202721 <sum_sfn>
  2028c2:	83 c4 10             	add    $0x10,%esp
  2028c5:	38 44 24 09          	cmp    %al,0x9(%esp)
  2028c9:	74 3d                	je     202908 <dir_read+0x1a5>
  2028cb:	8b 44 24 20          	mov    0x20(%esp),%eax
  2028cf:	c7 40 2c ff ff ff ff 	movl   $0xffffffff,0x2c(%eax)
  2028d6:	eb 30                	jmp    202908 <dir_read+0x1a5>
  2028d8:	83 ec 08             	sub    $0x8,%esp
  2028db:	6a 00                	push   $0x0
  2028dd:	ff 74 24 2c          	push   0x2c(%esp)
  2028e1:	e8 1a f6 ff ff       	call   201f00 <dir_next>
  2028e6:	83 c4 10             	add    $0x10,%esp
  2028e9:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2028ed:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  2028f2:	75 17                	jne    20290b <dir_read+0x1a8>
  2028f4:	8b 44 24 20          	mov    0x20(%esp),%eax
  2028f8:	8b 40 18             	mov    0x18(%eax),%eax
  2028fb:	85 c0                	test   %eax,%eax
  2028fd:	0f 85 84 fe ff ff    	jne    202787 <dir_read+0x24>
  202903:	eb 07                	jmp    20290c <dir_read+0x1a9>
  202905:	90                   	nop
  202906:	eb 04                	jmp    20290c <dir_read+0x1a9>
  202908:	90                   	nop
  202909:	eb 01                	jmp    20290c <dir_read+0x1a9>
  20290b:	90                   	nop
  20290c:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  202911:	74 0b                	je     20291e <dir_read+0x1bb>
  202913:	8b 44 24 20          	mov    0x20(%esp),%eax
  202917:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  20291e:	8b 44 24 0c          	mov    0xc(%esp),%eax
  202922:	83 c4 1c             	add    $0x1c,%esp
  202925:	c3                   	ret

00202926 <dir_find>:
  202926:	83 ec 1c             	sub    $0x1c,%esp
  202929:	8b 44 24 20          	mov    0x20(%esp),%eax
  20292d:	8b 00                	mov    (%eax),%eax
  20292f:	89 44 24 04          	mov    %eax,0x4(%esp)
  202933:	83 ec 08             	sub    $0x8,%esp
  202936:	6a 00                	push   $0x0
  202938:	ff 74 24 2c          	push   0x2c(%esp)
  20293c:	e8 4a f4 ff ff       	call   201d8b <dir_sdi>
  202941:	83 c4 10             	add    $0x10,%esp
  202944:	89 44 24 0c          	mov    %eax,0xc(%esp)
  202948:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  20294d:	74 09                	je     202958 <dir_find+0x32>
  20294f:	8b 44 24 0c          	mov    0xc(%esp),%eax
  202953:	e9 e3 01 00 00       	jmp    202b3b <dir_find+0x215>
  202958:	c6 44 24 09 ff       	movb   $0xff,0x9(%esp)
  20295d:	0f b6 44 24 09       	movzbl 0x9(%esp),%eax
  202962:	88 44 24 0a          	mov    %al,0xa(%esp)
  202966:	8b 44 24 20          	mov    0x20(%esp),%eax
  20296a:	c7 40 2c ff ff ff ff 	movl   $0xffffffff,0x2c(%eax)
  202971:	8b 44 24 20          	mov    0x20(%esp),%eax
  202975:	8b 40 18             	mov    0x18(%eax),%eax
  202978:	83 ec 08             	sub    $0x8,%esp
  20297b:	50                   	push   %eax
  20297c:	ff 74 24 10          	push   0x10(%esp)
  202980:	e8 07 e9 ff ff       	call   20128c <move_window>
  202985:	83 c4 10             	add    $0x10,%esp
  202988:	89 44 24 0c          	mov    %eax,0xc(%esp)
  20298c:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  202991:	0f 85 99 01 00 00    	jne    202b30 <dir_find+0x20a>
  202997:	8b 44 24 20          	mov    0x20(%esp),%eax
  20299b:	8b 40 1c             	mov    0x1c(%eax),%eax
  20299e:	0f b6 00             	movzbl (%eax),%eax
  2029a1:	88 44 24 0b          	mov    %al,0xb(%esp)
  2029a5:	80 7c 24 0b 00       	cmpb   $0x0,0xb(%esp)
  2029aa:	75 0d                	jne    2029b9 <dir_find+0x93>
  2029ac:	c7 44 24 0c 04 00 00 	movl   $0x4,0xc(%esp)
  2029b3:	00 
  2029b4:	e9 7e 01 00 00       	jmp    202b37 <dir_find+0x211>
  2029b9:	8b 44 24 20          	mov    0x20(%esp),%eax
  2029bd:	8b 40 1c             	mov    0x1c(%eax),%eax
  2029c0:	83 c0 0b             	add    $0xb,%eax
  2029c3:	0f b6 00             	movzbl (%eax),%eax
  2029c6:	83 e0 3f             	and    $0x3f,%eax
  2029c9:	88 44 24 03          	mov    %al,0x3(%esp)
  2029cd:	8b 44 24 20          	mov    0x20(%esp),%eax
  2029d1:	0f b6 54 24 03       	movzbl 0x3(%esp),%edx
  2029d6:	88 50 06             	mov    %dl,0x6(%eax)
  2029d9:	80 7c 24 0b e5       	cmpb   $0xe5,0xb(%esp)
  2029de:	74 13                	je     2029f3 <dir_find+0xcd>
  2029e0:	0f b6 44 24 03       	movzbl 0x3(%esp),%eax
  2029e5:	83 e0 08             	and    $0x8,%eax
  2029e8:	85 c0                	test   %eax,%eax
  2029ea:	74 1c                	je     202a08 <dir_find+0xe2>
  2029ec:	80 7c 24 03 0f       	cmpb   $0xf,0x3(%esp)
  2029f1:	74 15                	je     202a08 <dir_find+0xe2>
  2029f3:	c6 44 24 0a ff       	movb   $0xff,0xa(%esp)
  2029f8:	8b 44 24 20          	mov    0x20(%esp),%eax
  2029fc:	c7 40 2c ff ff ff ff 	movl   $0xffffffff,0x2c(%eax)
  202a03:	e9 06 01 00 00       	jmp    202b0e <dir_find+0x1e8>
  202a08:	80 7c 24 03 0f       	cmpb   $0xf,0x3(%esp)
  202a0d:	0f 85 98 00 00 00    	jne    202aab <dir_find+0x185>
  202a13:	8b 44 24 20          	mov    0x20(%esp),%eax
  202a17:	0f b6 40 2b          	movzbl 0x2b(%eax),%eax
  202a1b:	0f b6 c0             	movzbl %al,%eax
  202a1e:	83 e0 40             	and    $0x40,%eax
  202a21:	85 c0                	test   %eax,%eax
  202a23:	0f 85 e5 00 00 00    	jne    202b0e <dir_find+0x1e8>
  202a29:	0f b6 44 24 0b       	movzbl 0xb(%esp),%eax
  202a2e:	83 e0 40             	and    $0x40,%eax
  202a31:	85 c0                	test   %eax,%eax
  202a33:	74 2b                	je     202a60 <dir_find+0x13a>
  202a35:	80 64 24 0b bf       	andb   $0xbf,0xb(%esp)
  202a3a:	0f b6 44 24 0b       	movzbl 0xb(%esp),%eax
  202a3f:	88 44 24 0a          	mov    %al,0xa(%esp)
  202a43:	8b 44 24 20          	mov    0x20(%esp),%eax
  202a47:	8b 50 10             	mov    0x10(%eax),%edx
  202a4a:	8b 44 24 20          	mov    0x20(%esp),%eax
  202a4e:	89 50 2c             	mov    %edx,0x2c(%eax)
  202a51:	8b 44 24 20          	mov    0x20(%esp),%eax
  202a55:	8b 40 1c             	mov    0x1c(%eax),%eax
  202a58:	0f b6 40 0d          	movzbl 0xd(%eax),%eax
  202a5c:	88 44 24 09          	mov    %al,0x9(%esp)
  202a60:	0f b6 44 24 0b       	movzbl 0xb(%esp),%eax
  202a65:	3a 44 24 0a          	cmp    0xa(%esp),%al
  202a69:	75 39                	jne    202aa4 <dir_find+0x17e>
  202a6b:	8b 44 24 20          	mov    0x20(%esp),%eax
  202a6f:	8b 40 1c             	mov    0x1c(%eax),%eax
  202a72:	83 c0 0d             	add    $0xd,%eax
  202a75:	0f b6 00             	movzbl (%eax),%eax
  202a78:	38 44 24 09          	cmp    %al,0x9(%esp)
  202a7c:	75 26                	jne    202aa4 <dir_find+0x17e>
  202a7e:	8b 44 24 20          	mov    0x20(%esp),%eax
  202a82:	8b 50 1c             	mov    0x1c(%eax),%edx
  202a85:	8b 44 24 04          	mov    0x4(%esp),%eax
  202a89:	8b 40 0c             	mov    0xc(%eax),%eax
  202a8c:	83 ec 08             	sub    $0x8,%esp
  202a8f:	52                   	push   %edx
  202a90:	50                   	push   %eax
  202a91:	e8 97 f7 ff ff       	call   20222d <cmp_lfn>
  202a96:	83 c4 10             	add    $0x10,%esp
  202a99:	85 c0                	test   %eax,%eax
  202a9b:	74 07                	je     202aa4 <dir_find+0x17e>
  202a9d:	80 6c 24 0a 01       	subb   $0x1,0xa(%esp)
  202aa2:	eb 6a                	jmp    202b0e <dir_find+0x1e8>
  202aa4:	c6 44 24 0a ff       	movb   $0xff,0xa(%esp)
  202aa9:	eb 63                	jmp    202b0e <dir_find+0x1e8>
  202aab:	80 7c 24 0a 00       	cmpb   $0x0,0xa(%esp)
  202ab0:	75 19                	jne    202acb <dir_find+0x1a5>
  202ab2:	8b 44 24 20          	mov    0x20(%esp),%eax
  202ab6:	8b 40 1c             	mov    0x1c(%eax),%eax
  202ab9:	83 ec 0c             	sub    $0xc,%esp
  202abc:	50                   	push   %eax
  202abd:	e8 5f fc ff ff       	call   202721 <sum_sfn>
  202ac2:	83 c4 10             	add    $0x10,%esp
  202ac5:	38 44 24 09          	cmp    %al,0x9(%esp)
  202ac9:	74 68                	je     202b33 <dir_find+0x20d>
  202acb:	8b 44 24 20          	mov    0x20(%esp),%eax
  202acf:	0f b6 40 2b          	movzbl 0x2b(%eax),%eax
  202ad3:	0f b6 c0             	movzbl %al,%eax
  202ad6:	83 e0 01             	and    $0x1,%eax
  202ad9:	85 c0                	test   %eax,%eax
  202adb:	75 21                	jne    202afe <dir_find+0x1d8>
  202add:	8b 44 24 20          	mov    0x20(%esp),%eax
  202ae1:	8d 50 20             	lea    0x20(%eax),%edx
  202ae4:	8b 44 24 20          	mov    0x20(%esp),%eax
  202ae8:	8b 40 1c             	mov    0x1c(%eax),%eax
  202aeb:	83 ec 04             	sub    $0x4,%esp
  202aee:	6a 0b                	push   $0xb
  202af0:	52                   	push   %edx
  202af1:	50                   	push   %eax
  202af2:	e8 99 43 00 00       	call   206e90 <memcmp>
  202af7:	83 c4 10             	add    $0x10,%esp
  202afa:	85 c0                	test   %eax,%eax
  202afc:	74 38                	je     202b36 <dir_find+0x210>
  202afe:	c6 44 24 0a ff       	movb   $0xff,0xa(%esp)
  202b03:	8b 44 24 20          	mov    0x20(%esp),%eax
  202b07:	c7 40 2c ff ff ff ff 	movl   $0xffffffff,0x2c(%eax)
  202b0e:	83 ec 08             	sub    $0x8,%esp
  202b11:	6a 00                	push   $0x0
  202b13:	ff 74 24 2c          	push   0x2c(%esp)
  202b17:	e8 e4 f3 ff ff       	call   201f00 <dir_next>
  202b1c:	83 c4 10             	add    $0x10,%esp
  202b1f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  202b23:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  202b28:	0f 84 43 fe ff ff    	je     202971 <dir_find+0x4b>
  202b2e:	eb 07                	jmp    202b37 <dir_find+0x211>
  202b30:	90                   	nop
  202b31:	eb 04                	jmp    202b37 <dir_find+0x211>
  202b33:	90                   	nop
  202b34:	eb 01                	jmp    202b37 <dir_find+0x211>
  202b36:	90                   	nop
  202b37:	8b 44 24 0c          	mov    0xc(%esp),%eax
  202b3b:	83 c4 1c             	add    $0x1c,%esp
  202b3e:	c3                   	ret

00202b3f <dir_register>:
  202b3f:	53                   	push   %ebx
  202b40:	83 ec 38             	sub    $0x38,%esp
  202b43:	8b 44 24 40          	mov    0x40(%esp),%eax
  202b47:	8b 00                	mov    (%eax),%eax
  202b49:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  202b4d:	8b 44 24 40          	mov    0x40(%esp),%eax
  202b51:	0f b6 40 2b          	movzbl 0x2b(%eax),%eax
  202b55:	0f b6 c0             	movzbl %al,%eax
  202b58:	25 a0 00 00 00       	and    $0xa0,%eax
  202b5d:	85 c0                	test   %eax,%eax
  202b5f:	74 0a                	je     202b6b <dir_register+0x2c>
  202b61:	b8 06 00 00 00       	mov    $0x6,%eax
  202b66:	e9 86 02 00 00       	jmp    202df1 <dir_register+0x2b2>
  202b6b:	c7 44 24 24 00 00 00 	movl   $0x0,0x24(%esp)
  202b72:	00 
  202b73:	eb 05                	jmp    202b7a <dir_register+0x3b>
  202b75:	83 44 24 24 01       	addl   $0x1,0x24(%esp)
  202b7a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  202b7e:	8b 40 0c             	mov    0xc(%eax),%eax
  202b81:	8b 54 24 24          	mov    0x24(%esp),%edx
  202b85:	01 d2                	add    %edx,%edx
  202b87:	01 d0                	add    %edx,%eax
  202b89:	0f b7 00             	movzwl (%eax),%eax
  202b8c:	66 85 c0             	test   %ax,%ax
  202b8f:	75 e4                	jne    202b75 <dir_register+0x36>
  202b91:	8b 44 24 40          	mov    0x40(%esp),%eax
  202b95:	83 c0 20             	add    $0x20,%eax
  202b98:	83 ec 04             	sub    $0x4,%esp
  202b9b:	6a 0c                	push   $0xc
  202b9d:	50                   	push   %eax
  202b9e:	8d 44 24 1b          	lea    0x1b(%esp),%eax
  202ba2:	50                   	push   %eax
  202ba3:	e8 9b 42 00 00       	call   206e43 <memcpy>
  202ba8:	83 c4 10             	add    $0x10,%esp
  202bab:	0f b6 44 24 1a       	movzbl 0x1a(%esp),%eax
  202bb0:	0f b6 c0             	movzbl %al,%eax
  202bb3:	83 e0 01             	and    $0x1,%eax
  202bb6:	85 c0                	test   %eax,%eax
  202bb8:	0f 84 8d 00 00 00    	je     202c4b <dir_register+0x10c>
  202bbe:	8b 44 24 40          	mov    0x40(%esp),%eax
  202bc2:	c6 40 2b 40          	movb   $0x40,0x2b(%eax)
  202bc6:	c7 44 24 28 01 00 00 	movl   $0x1,0x28(%esp)
  202bcd:	00 
  202bce:	eb 44                	jmp    202c14 <dir_register+0xd5>
  202bd0:	8b 44 24 28          	mov    0x28(%esp),%eax
  202bd4:	0f b7 d0             	movzwl %ax,%edx
  202bd7:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  202bdb:	8b 40 0c             	mov    0xc(%eax),%eax
  202bde:	8b 4c 24 40          	mov    0x40(%esp),%ecx
  202be2:	83 c1 20             	add    $0x20,%ecx
  202be5:	52                   	push   %edx
  202be6:	50                   	push   %eax
  202be7:	8d 44 24 17          	lea    0x17(%esp),%eax
  202beb:	50                   	push   %eax
  202bec:	51                   	push   %ecx
  202bed:	e8 98 f9 ff ff       	call   20258a <gen_numname>
  202bf2:	83 c4 10             	add    $0x10,%esp
  202bf5:	83 ec 0c             	sub    $0xc,%esp
  202bf8:	ff 74 24 4c          	push   0x4c(%esp)
  202bfc:	e8 25 fd ff ff       	call   202926 <dir_find>
  202c01:	83 c4 10             	add    $0x10,%esp
  202c04:	89 44 24 2c          	mov    %eax,0x2c(%esp)
  202c08:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
  202c0d:	75 0e                	jne    202c1d <dir_register+0xde>
  202c0f:	83 44 24 28 01       	addl   $0x1,0x28(%esp)
  202c14:	83 7c 24 28 63       	cmpl   $0x63,0x28(%esp)
  202c19:	76 b5                	jbe    202bd0 <dir_register+0x91>
  202c1b:	eb 01                	jmp    202c1e <dir_register+0xdf>
  202c1d:	90                   	nop
  202c1e:	83 7c 24 28 64       	cmpl   $0x64,0x28(%esp)
  202c23:	75 0a                	jne    202c2f <dir_register+0xf0>
  202c25:	b8 07 00 00 00       	mov    $0x7,%eax
  202c2a:	e9 c2 01 00 00       	jmp    202df1 <dir_register+0x2b2>
  202c2f:	83 7c 24 2c 04       	cmpl   $0x4,0x2c(%esp)
  202c34:	74 09                	je     202c3f <dir_register+0x100>
  202c36:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  202c3a:	e9 b2 01 00 00       	jmp    202df1 <dir_register+0x2b2>
  202c3f:	0f b6 54 24 1a       	movzbl 0x1a(%esp),%edx
  202c44:	8b 44 24 40          	mov    0x40(%esp),%eax
  202c48:	88 50 2b             	mov    %dl,0x2b(%eax)
  202c4b:	0f b6 44 24 1a       	movzbl 0x1a(%esp),%eax
  202c50:	0f b6 c0             	movzbl %al,%eax
  202c53:	83 e0 02             	and    $0x2,%eax
  202c56:	85 c0                	test   %eax,%eax
  202c58:	74 1c                	je     202c76 <dir_register+0x137>
  202c5a:	8b 44 24 24          	mov    0x24(%esp),%eax
  202c5e:	83 c0 0c             	add    $0xc,%eax
  202c61:	ba 4f ec c4 4e       	mov    $0x4ec4ec4f,%edx
  202c66:	f7 e2                	mul    %edx
  202c68:	89 d0                	mov    %edx,%eax
  202c6a:	c1 e8 02             	shr    $0x2,%eax
  202c6d:	83 c0 01             	add    $0x1,%eax
  202c70:	89 44 24 20          	mov    %eax,0x20(%esp)
  202c74:	eb 08                	jmp    202c7e <dir_register+0x13f>
  202c76:	c7 44 24 20 01 00 00 	movl   $0x1,0x20(%esp)
  202c7d:	00 
  202c7e:	83 ec 08             	sub    $0x8,%esp
  202c81:	ff 74 24 28          	push   0x28(%esp)
  202c85:	ff 74 24 4c          	push   0x4c(%esp)
  202c89:	e8 5a f4 ff ff       	call   2020e8 <dir_alloc>
  202c8e:	83 c4 10             	add    $0x10,%esp
  202c91:	89 44 24 2c          	mov    %eax,0x2c(%esp)
  202c95:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
  202c9a:	0f 85 d1 00 00 00    	jne    202d71 <dir_register+0x232>
  202ca0:	83 6c 24 20 01       	subl   $0x1,0x20(%esp)
  202ca5:	83 7c 24 20 00       	cmpl   $0x0,0x20(%esp)
  202caa:	0f 84 c1 00 00 00    	je     202d71 <dir_register+0x232>
  202cb0:	8b 44 24 40          	mov    0x40(%esp),%eax
  202cb4:	8b 40 10             	mov    0x10(%eax),%eax
  202cb7:	8b 54 24 20          	mov    0x20(%esp),%edx
  202cbb:	c1 e2 05             	shl    $0x5,%edx
  202cbe:	29 d0                	sub    %edx,%eax
  202cc0:	83 ec 08             	sub    $0x8,%esp
  202cc3:	50                   	push   %eax
  202cc4:	ff 74 24 4c          	push   0x4c(%esp)
  202cc8:	e8 be f0 ff ff       	call   201d8b <dir_sdi>
  202ccd:	83 c4 10             	add    $0x10,%esp
  202cd0:	89 44 24 2c          	mov    %eax,0x2c(%esp)
  202cd4:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
  202cd9:	0f 85 92 00 00 00    	jne    202d71 <dir_register+0x232>
  202cdf:	8b 44 24 40          	mov    0x40(%esp),%eax
  202ce3:	83 c0 20             	add    $0x20,%eax
  202ce6:	83 ec 0c             	sub    $0xc,%esp
  202ce9:	50                   	push   %eax
  202cea:	e8 32 fa ff ff       	call   202721 <sum_sfn>
  202cef:	83 c4 10             	add    $0x10,%esp
  202cf2:	88 44 24 1b          	mov    %al,0x1b(%esp)
  202cf6:	8b 44 24 40          	mov    0x40(%esp),%eax
  202cfa:	8b 40 18             	mov    0x18(%eax),%eax
  202cfd:	83 ec 08             	sub    $0x8,%esp
  202d00:	50                   	push   %eax
  202d01:	ff 74 24 28          	push   0x28(%esp)
  202d05:	e8 82 e5 ff ff       	call   20128c <move_window>
  202d0a:	83 c4 10             	add    $0x10,%esp
  202d0d:	89 44 24 2c          	mov    %eax,0x2c(%esp)
  202d11:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
  202d16:	75 58                	jne    202d70 <dir_register+0x231>
  202d18:	0f b6 5c 24 1b       	movzbl 0x1b(%esp),%ebx
  202d1d:	8b 44 24 20          	mov    0x20(%esp),%eax
  202d21:	0f b6 c8             	movzbl %al,%ecx
  202d24:	8b 44 24 40          	mov    0x40(%esp),%eax
  202d28:	8b 50 1c             	mov    0x1c(%eax),%edx
  202d2b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  202d2f:	8b 40 0c             	mov    0xc(%eax),%eax
  202d32:	53                   	push   %ebx
  202d33:	51                   	push   %ecx
  202d34:	52                   	push   %edx
  202d35:	50                   	push   %eax
  202d36:	e8 4c f7 ff ff       	call   202487 <put_lfn>
  202d3b:	83 c4 10             	add    $0x10,%esp
  202d3e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  202d42:	c6 40 04 01          	movb   $0x1,0x4(%eax)
  202d46:	83 ec 08             	sub    $0x8,%esp
  202d49:	6a 00                	push   $0x0
  202d4b:	ff 74 24 4c          	push   0x4c(%esp)
  202d4f:	e8 ac f1 ff ff       	call   201f00 <dir_next>
  202d54:	83 c4 10             	add    $0x10,%esp
  202d57:	89 44 24 2c          	mov    %eax,0x2c(%esp)
  202d5b:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
  202d60:	75 0f                	jne    202d71 <dir_register+0x232>
  202d62:	83 6c 24 20 01       	subl   $0x1,0x20(%esp)
  202d67:	83 7c 24 20 00       	cmpl   $0x0,0x20(%esp)
  202d6c:	75 88                	jne    202cf6 <dir_register+0x1b7>
  202d6e:	eb 01                	jmp    202d71 <dir_register+0x232>
  202d70:	90                   	nop
  202d71:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
  202d76:	75 75                	jne    202ded <dir_register+0x2ae>
  202d78:	8b 44 24 40          	mov    0x40(%esp),%eax
  202d7c:	8b 40 18             	mov    0x18(%eax),%eax
  202d7f:	83 ec 08             	sub    $0x8,%esp
  202d82:	50                   	push   %eax
  202d83:	ff 74 24 28          	push   0x28(%esp)
  202d87:	e8 00 e5 ff ff       	call   20128c <move_window>
  202d8c:	83 c4 10             	add    $0x10,%esp
  202d8f:	89 44 24 2c          	mov    %eax,0x2c(%esp)
  202d93:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
  202d98:	75 53                	jne    202ded <dir_register+0x2ae>
  202d9a:	8b 44 24 40          	mov    0x40(%esp),%eax
  202d9e:	8b 40 1c             	mov    0x1c(%eax),%eax
  202da1:	83 ec 04             	sub    $0x4,%esp
  202da4:	6a 20                	push   $0x20
  202da6:	6a 00                	push   $0x0
  202da8:	50                   	push   %eax
  202da9:	e8 61 40 00 00       	call   206e0f <memset>
  202dae:	83 c4 10             	add    $0x10,%esp
  202db1:	8b 44 24 40          	mov    0x40(%esp),%eax
  202db5:	8d 50 20             	lea    0x20(%eax),%edx
  202db8:	8b 44 24 40          	mov    0x40(%esp),%eax
  202dbc:	8b 40 1c             	mov    0x1c(%eax),%eax
  202dbf:	83 ec 04             	sub    $0x4,%esp
  202dc2:	6a 0b                	push   $0xb
  202dc4:	52                   	push   %edx
  202dc5:	50                   	push   %eax
  202dc6:	e8 78 40 00 00       	call   206e43 <memcpy>
  202dcb:	83 c4 10             	add    $0x10,%esp
  202dce:	8b 44 24 40          	mov    0x40(%esp),%eax
  202dd2:	0f b6 50 2b          	movzbl 0x2b(%eax),%edx
  202dd6:	8b 44 24 40          	mov    0x40(%esp),%eax
  202dda:	8b 40 1c             	mov    0x1c(%eax),%eax
  202ddd:	83 c0 0c             	add    $0xc,%eax
  202de0:	83 e2 18             	and    $0x18,%edx
  202de3:	88 10                	mov    %dl,(%eax)
  202de5:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  202de9:	c6 40 04 01          	movb   $0x1,0x4(%eax)
  202ded:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  202df1:	83 c4 38             	add    $0x38,%esp
  202df4:	5b                   	pop    %ebx
  202df5:	c3                   	ret

00202df6 <dir_remove>:
  202df6:	83 ec 1c             	sub    $0x1c,%esp
  202df9:	8b 44 24 20          	mov    0x20(%esp),%eax
  202dfd:	8b 00                	mov    (%eax),%eax
  202dff:	89 44 24 08          	mov    %eax,0x8(%esp)
  202e03:	8b 44 24 20          	mov    0x20(%esp),%eax
  202e07:	8b 40 10             	mov    0x10(%eax),%eax
  202e0a:	89 44 24 04          	mov    %eax,0x4(%esp)
  202e0e:	8b 44 24 20          	mov    0x20(%esp),%eax
  202e12:	8b 40 2c             	mov    0x2c(%eax),%eax
  202e15:	83 f8 ff             	cmp    $0xffffffff,%eax
  202e18:	74 1d                	je     202e37 <dir_remove+0x41>
  202e1a:	8b 44 24 20          	mov    0x20(%esp),%eax
  202e1e:	8b 40 2c             	mov    0x2c(%eax),%eax
  202e21:	83 ec 08             	sub    $0x8,%esp
  202e24:	50                   	push   %eax
  202e25:	ff 74 24 2c          	push   0x2c(%esp)
  202e29:	e8 5d ef ff ff       	call   201d8b <dir_sdi>
  202e2e:	83 c4 10             	add    $0x10,%esp
  202e31:	89 44 24 0c          	mov    %eax,0xc(%esp)
  202e35:	eb 08                	jmp    202e3f <dir_remove+0x49>
  202e37:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  202e3e:	00 
  202e3f:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  202e44:	75 72                	jne    202eb8 <dir_remove+0xc2>
  202e46:	8b 44 24 20          	mov    0x20(%esp),%eax
  202e4a:	8b 40 18             	mov    0x18(%eax),%eax
  202e4d:	83 ec 08             	sub    $0x8,%esp
  202e50:	50                   	push   %eax
  202e51:	ff 74 24 14          	push   0x14(%esp)
  202e55:	e8 32 e4 ff ff       	call   20128c <move_window>
  202e5a:	83 c4 10             	add    $0x10,%esp
  202e5d:	89 44 24 0c          	mov    %eax,0xc(%esp)
  202e61:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  202e66:	75 3d                	jne    202ea5 <dir_remove+0xaf>
  202e68:	8b 44 24 20          	mov    0x20(%esp),%eax
  202e6c:	8b 40 1c             	mov    0x1c(%eax),%eax
  202e6f:	c6 00 e5             	movb   $0xe5,(%eax)
  202e72:	8b 44 24 08          	mov    0x8(%esp),%eax
  202e76:	c6 40 04 01          	movb   $0x1,0x4(%eax)
  202e7a:	8b 44 24 20          	mov    0x20(%esp),%eax
  202e7e:	8b 40 10             	mov    0x10(%eax),%eax
  202e81:	3b 44 24 04          	cmp    0x4(%esp),%eax
  202e85:	73 21                	jae    202ea8 <dir_remove+0xb2>
  202e87:	83 ec 08             	sub    $0x8,%esp
  202e8a:	6a 00                	push   $0x0
  202e8c:	ff 74 24 2c          	push   0x2c(%esp)
  202e90:	e8 6b f0 ff ff       	call   201f00 <dir_next>
  202e95:	83 c4 10             	add    $0x10,%esp
  202e98:	89 44 24 0c          	mov    %eax,0xc(%esp)
  202e9c:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  202ea1:	74 a3                	je     202e46 <dir_remove+0x50>
  202ea3:	eb 04                	jmp    202ea9 <dir_remove+0xb3>
  202ea5:	90                   	nop
  202ea6:	eb 01                	jmp    202ea9 <dir_remove+0xb3>
  202ea8:	90                   	nop
  202ea9:	83 7c 24 0c 04       	cmpl   $0x4,0xc(%esp)
  202eae:	75 08                	jne    202eb8 <dir_remove+0xc2>
  202eb0:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
  202eb7:	00 
  202eb8:	8b 44 24 0c          	mov    0xc(%esp),%eax
  202ebc:	83 c4 1c             	add    $0x1c,%esp
  202ebf:	c3                   	ret

00202ec0 <get_fileinfo>:
  202ec0:	53                   	push   %ebx
  202ec1:	83 ec 28             	sub    $0x28,%esp
  202ec4:	8b 44 24 30          	mov    0x30(%esp),%eax
  202ec8:	8b 00                	mov    (%eax),%eax
  202eca:	89 44 24 0c          	mov    %eax,0xc(%esp)
  202ece:	8b 44 24 34          	mov    0x34(%esp),%eax
  202ed2:	c6 40 16 00          	movb   $0x0,0x16(%eax)
  202ed6:	8b 44 24 30          	mov    0x30(%esp),%eax
  202eda:	8b 40 18             	mov    0x18(%eax),%eax
  202edd:	85 c0                	test   %eax,%eax
  202edf:	0f 84 de 03 00 00    	je     2032c3 <get_fileinfo+0x403>
  202ee5:	8b 44 24 30          	mov    0x30(%esp),%eax
  202ee9:	8b 40 2c             	mov    0x2c(%eax),%eax
  202eec:	83 f8 ff             	cmp    $0xffffffff,%eax
  202eef:	0f 84 f4 00 00 00    	je     202fe9 <get_fileinfo+0x129>
  202ef5:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  202efc:	00 
  202efd:	8b 44 24 18          	mov    0x18(%esp),%eax
  202f01:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  202f05:	66 c7 44 24 14 00 00 	movw   $0x0,0x14(%esp)
  202f0c:	e9 9d 00 00 00       	jmp    202fae <get_fileinfo+0xee>
  202f11:	8b 44 24 0c          	mov    0xc(%esp),%eax
  202f15:	8b 48 0c             	mov    0xc(%eax),%ecx
  202f18:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  202f1c:	8d 50 01             	lea    0x1(%eax),%edx
  202f1f:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  202f23:	01 c0                	add    %eax,%eax
  202f25:	01 c8                	add    %ecx,%eax
  202f27:	0f b7 00             	movzwl (%eax),%eax
  202f2a:	66 89 44 24 16       	mov    %ax,0x16(%esp)
  202f2f:	66 83 7c 24 14 00    	cmpw   $0x0,0x14(%esp)
  202f35:	75 1e                	jne    202f55 <get_fileinfo+0x95>
  202f37:	66 81 7c 24 16 ff d7 	cmpw   $0xd7ff,0x16(%esp)
  202f3e:	76 15                	jbe    202f55 <get_fileinfo+0x95>
  202f40:	66 81 7c 24 16 ff df 	cmpw   $0xdfff,0x16(%esp)
  202f47:	77 0c                	ja     202f55 <get_fileinfo+0x95>
  202f49:	0f b7 44 24 16       	movzwl 0x16(%esp),%eax
  202f4e:	66 89 44 24 14       	mov    %ax,0x14(%esp)
  202f53:	eb 59                	jmp    202fae <get_fileinfo+0xee>
  202f55:	b8 ff 00 00 00       	mov    $0xff,%eax
  202f5a:	2b 44 24 18          	sub    0x18(%esp),%eax
  202f5e:	8b 54 24 18          	mov    0x18(%esp),%edx
  202f62:	8d 4a 10             	lea    0x10(%edx),%ecx
  202f65:	8b 54 24 34          	mov    0x34(%esp),%edx
  202f69:	01 ca                	add    %ecx,%edx
  202f6b:	8d 4a 06             	lea    0x6(%edx),%ecx
  202f6e:	0f b7 54 24 14       	movzwl 0x14(%esp),%edx
  202f73:	89 d3                	mov    %edx,%ebx
  202f75:	c1 e3 10             	shl    $0x10,%ebx
  202f78:	0f b7 54 24 16       	movzwl 0x16(%esp),%edx
  202f7d:	09 da                	or     %ebx,%edx
  202f7f:	50                   	push   %eax
  202f80:	51                   	push   %ecx
  202f81:	52                   	push   %edx
  202f82:	e8 4a e0 ff ff       	call   200fd1 <put_utf>
  202f87:	83 c4 0c             	add    $0xc,%esp
  202f8a:	89 44 24 08          	mov    %eax,0x8(%esp)
  202f8e:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  202f93:	75 0a                	jne    202f9f <get_fileinfo+0xdf>
  202f95:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  202f9c:	00 
  202f9d:	eb 2a                	jmp    202fc9 <get_fileinfo+0x109>
  202f9f:	8b 44 24 08          	mov    0x8(%esp),%eax
  202fa3:	01 44 24 18          	add    %eax,0x18(%esp)
  202fa7:	66 c7 44 24 14 00 00 	movw   $0x0,0x14(%esp)
  202fae:	8b 44 24 0c          	mov    0xc(%esp),%eax
  202fb2:	8b 40 0c             	mov    0xc(%eax),%eax
  202fb5:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  202fb9:	01 d2                	add    %edx,%edx
  202fbb:	01 d0                	add    %edx,%eax
  202fbd:	0f b7 00             	movzwl (%eax),%eax
  202fc0:	66 85 c0             	test   %ax,%ax
  202fc3:	0f 85 48 ff ff ff    	jne    202f11 <get_fileinfo+0x51>
  202fc9:	66 83 7c 24 14 00    	cmpw   $0x0,0x14(%esp)
  202fcf:	74 08                	je     202fd9 <get_fileinfo+0x119>
  202fd1:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  202fd8:	00 
  202fd9:	8b 54 24 34          	mov    0x34(%esp),%edx
  202fdd:	8b 44 24 18          	mov    0x18(%esp),%eax
  202fe1:	01 d0                	add    %edx,%eax
  202fe3:	83 c0 16             	add    $0x16,%eax
  202fe6:	c6 00 00             	movb   $0x0,(%eax)
  202fe9:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  202ff0:	00 
  202ff1:	8b 44 24 18          	mov    0x18(%esp),%eax
  202ff5:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  202ff9:	e9 40 01 00 00       	jmp    20313e <get_fileinfo+0x27e>
  202ffe:	8b 44 24 30          	mov    0x30(%esp),%eax
  203002:	8b 48 1c             	mov    0x1c(%eax),%ecx
  203005:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  203009:	8d 50 01             	lea    0x1(%eax),%edx
  20300c:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  203010:	01 c8                	add    %ecx,%eax
  203012:	0f b6 00             	movzbl (%eax),%eax
  203015:	0f b6 c0             	movzbl %al,%eax
  203018:	66 89 44 24 16       	mov    %ax,0x16(%esp)
  20301d:	66 83 7c 24 16 20    	cmpw   $0x20,0x16(%esp)
  203023:	75 05                	jne    20302a <get_fileinfo+0x16a>
  203025:	e9 14 01 00 00       	jmp    20313e <get_fileinfo+0x27e>
  20302a:	66 83 7c 24 16 05    	cmpw   $0x5,0x16(%esp)
  203030:	75 07                	jne    203039 <get_fileinfo+0x179>
  203032:	66 c7 44 24 16 e5 00 	movw   $0xe5,0x16(%esp)
  203039:	83 7c 24 1c 09       	cmpl   $0x9,0x1c(%esp)
  20303e:	75 1b                	jne    20305b <get_fileinfo+0x19b>
  203040:	83 7c 24 18 0b       	cmpl   $0xb,0x18(%esp)
  203045:	77 14                	ja     20305b <get_fileinfo+0x19b>
  203047:	8b 44 24 18          	mov    0x18(%esp),%eax
  20304b:	8d 50 01             	lea    0x1(%eax),%edx
  20304e:	89 54 24 18          	mov    %edx,0x18(%esp)
  203052:	8b 54 24 34          	mov    0x34(%esp),%edx
  203056:	c6 44 02 09 2e       	movb   $0x2e,0x9(%edx,%eax,1)
  20305b:	0f b7 44 24 16       	movzwl 0x16(%esp),%eax
  203060:	0f b6 c0             	movzbl %al,%eax
  203063:	50                   	push   %eax
  203064:	e8 cf dd ff ff       	call   200e38 <dbc_1st>
  203069:	83 c4 04             	add    $0x4,%esp
  20306c:	85 c0                	test   %eax,%eax
  20306e:	74 59                	je     2030c9 <get_fileinfo+0x209>
  203070:	83 7c 24 1c 08       	cmpl   $0x8,0x1c(%esp)
  203075:	74 52                	je     2030c9 <get_fileinfo+0x209>
  203077:	83 7c 24 1c 0b       	cmpl   $0xb,0x1c(%esp)
  20307c:	74 4b                	je     2030c9 <get_fileinfo+0x209>
  20307e:	8b 44 24 30          	mov    0x30(%esp),%eax
  203082:	8b 50 1c             	mov    0x1c(%eax),%edx
  203085:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  203089:	01 d0                	add    %edx,%eax
  20308b:	0f b6 00             	movzbl (%eax),%eax
  20308e:	0f b6 c0             	movzbl %al,%eax
  203091:	50                   	push   %eax
  203092:	e8 c1 dd ff ff       	call   200e58 <dbc_2nd>
  203097:	83 c4 04             	add    $0x4,%esp
  20309a:	85 c0                	test   %eax,%eax
  20309c:	74 2b                	je     2030c9 <get_fileinfo+0x209>
  20309e:	0f b7 44 24 16       	movzwl 0x16(%esp),%eax
  2030a3:	c1 e0 08             	shl    $0x8,%eax
  2030a6:	89 c3                	mov    %eax,%ebx
  2030a8:	8b 44 24 30          	mov    0x30(%esp),%eax
  2030ac:	8b 48 1c             	mov    0x1c(%eax),%ecx
  2030af:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2030b3:	8d 50 01             	lea    0x1(%eax),%edx
  2030b6:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  2030ba:	01 c8                	add    %ecx,%eax
  2030bc:	0f b6 00             	movzbl (%eax),%eax
  2030bf:	0f b6 c0             	movzbl %al,%eax
  2030c2:	09 d8                	or     %ebx,%eax
  2030c4:	66 89 44 24 16       	mov    %ax,0x16(%esp)
  2030c9:	0f b7 44 24 16       	movzwl 0x16(%esp),%eax
  2030ce:	83 ec 08             	sub    $0x8,%esp
  2030d1:	68 b5 01 00 00       	push   $0x1b5
  2030d6:	50                   	push   %eax
  2030d7:	e8 a5 37 00 00       	call   206881 <ff_oem2uni>
  2030dc:	83 c4 10             	add    $0x10,%esp
  2030df:	66 89 44 24 16       	mov    %ax,0x16(%esp)
  2030e4:	66 83 7c 24 16 00    	cmpw   $0x0,0x16(%esp)
  2030ea:	75 0a                	jne    2030f6 <get_fileinfo+0x236>
  2030ec:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  2030f3:	00 
  2030f4:	eb 53                	jmp    203149 <get_fileinfo+0x289>
  2030f6:	b8 0c 00 00 00       	mov    $0xc,%eax
  2030fb:	2b 44 24 18          	sub    0x18(%esp),%eax
  2030ff:	89 c2                	mov    %eax,%edx
  203101:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  203105:	8b 44 24 18          	mov    0x18(%esp),%eax
  203109:	01 c8                	add    %ecx,%eax
  20310b:	8d 48 09             	lea    0x9(%eax),%ecx
  20310e:	0f b7 44 24 16       	movzwl 0x16(%esp),%eax
  203113:	83 ec 04             	sub    $0x4,%esp
  203116:	52                   	push   %edx
  203117:	51                   	push   %ecx
  203118:	50                   	push   %eax
  203119:	e8 b3 de ff ff       	call   200fd1 <put_utf>
  20311e:	83 c4 10             	add    $0x10,%esp
  203121:	89 44 24 08          	mov    %eax,0x8(%esp)
  203125:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  20312a:	75 0a                	jne    203136 <get_fileinfo+0x276>
  20312c:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  203133:	00 
  203134:	eb 13                	jmp    203149 <get_fileinfo+0x289>
  203136:	8b 44 24 08          	mov    0x8(%esp),%eax
  20313a:	01 44 24 18          	add    %eax,0x18(%esp)
  20313e:	83 7c 24 1c 0a       	cmpl   $0xa,0x1c(%esp)
  203143:	0f 86 b5 fe ff ff    	jbe    202ffe <get_fileinfo+0x13e>
  203149:	8b 54 24 34          	mov    0x34(%esp),%edx
  20314d:	8b 44 24 18          	mov    0x18(%esp),%eax
  203151:	01 d0                	add    %edx,%eax
  203153:	83 c0 09             	add    $0x9,%eax
  203156:	c6 00 00             	movb   $0x0,(%eax)
  203159:	8b 44 24 34          	mov    0x34(%esp),%eax
  20315d:	0f b6 40 16          	movzbl 0x16(%eax),%eax
  203161:	84 c0                	test   %al,%al
  203163:	0f 85 e7 00 00 00    	jne    203250 <get_fileinfo+0x390>
  203169:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  20316e:	75 19                	jne    203189 <get_fileinfo+0x2c9>
  203170:	8b 44 24 18          	mov    0x18(%esp),%eax
  203174:	8d 50 01             	lea    0x1(%eax),%edx
  203177:	89 54 24 18          	mov    %edx,0x18(%esp)
  20317b:	8b 54 24 34          	mov    0x34(%esp),%edx
  20317f:	c6 44 02 16 3f       	movb   $0x3f,0x16(%edx,%eax,1)
  203184:	e9 9e 00 00 00       	jmp    203227 <get_fileinfo+0x367>
  203189:	c6 44 24 13 08       	movb   $0x8,0x13(%esp)
  20318e:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  203195:	00 
  203196:	8b 44 24 18          	mov    0x18(%esp),%eax
  20319a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  20319e:	eb 6f                	jmp    20320f <get_fileinfo+0x34f>
  2031a0:	8b 54 24 34          	mov    0x34(%esp),%edx
  2031a4:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2031a8:	01 d0                	add    %edx,%eax
  2031aa:	83 c0 09             	add    $0x9,%eax
  2031ad:	0f b6 00             	movzbl (%eax),%eax
  2031b0:	66 98                	cbtw
  2031b2:	66 89 44 24 16       	mov    %ax,0x16(%esp)
  2031b7:	66 83 7c 24 16 2e    	cmpw   $0x2e,0x16(%esp)
  2031bd:	75 05                	jne    2031c4 <get_fileinfo+0x304>
  2031bf:	c6 44 24 13 10       	movb   $0x10,0x13(%esp)
  2031c4:	66 83 7c 24 16 40    	cmpw   $0x40,0x16(%esp)
  2031ca:	76 23                	jbe    2031ef <get_fileinfo+0x32f>
  2031cc:	66 83 7c 24 16 5a    	cmpw   $0x5a,0x16(%esp)
  2031d2:	77 1b                	ja     2031ef <get_fileinfo+0x32f>
  2031d4:	8b 44 24 30          	mov    0x30(%esp),%eax
  2031d8:	8b 40 1c             	mov    0x1c(%eax),%eax
  2031db:	83 c0 0c             	add    $0xc,%eax
  2031de:	0f b6 00             	movzbl (%eax),%eax
  2031e1:	22 44 24 13          	and    0x13(%esp),%al
  2031e5:	84 c0                	test   %al,%al
  2031e7:	74 06                	je     2031ef <get_fileinfo+0x32f>
  2031e9:	66 83 44 24 16 20    	addw   $0x20,0x16(%esp)
  2031ef:	0f b7 44 24 16       	movzwl 0x16(%esp),%eax
  2031f4:	89 c1                	mov    %eax,%ecx
  2031f6:	8b 54 24 34          	mov    0x34(%esp),%edx
  2031fa:	8b 44 24 18          	mov    0x18(%esp),%eax
  2031fe:	01 d0                	add    %edx,%eax
  203200:	83 c0 16             	add    $0x16,%eax
  203203:	88 08                	mov    %cl,(%eax)
  203205:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  20320a:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
  20320f:	8b 54 24 34          	mov    0x34(%esp),%edx
  203213:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  203217:	01 d0                	add    %edx,%eax
  203219:	83 c0 09             	add    $0x9,%eax
  20321c:	0f b6 00             	movzbl (%eax),%eax
  20321f:	84 c0                	test   %al,%al
  203221:	0f 85 79 ff ff ff    	jne    2031a0 <get_fileinfo+0x2e0>
  203227:	8b 54 24 34          	mov    0x34(%esp),%edx
  20322b:	8b 44 24 18          	mov    0x18(%esp),%eax
  20322f:	01 d0                	add    %edx,%eax
  203231:	83 c0 16             	add    $0x16,%eax
  203234:	c6 00 00             	movb   $0x0,(%eax)
  203237:	8b 44 24 30          	mov    0x30(%esp),%eax
  20323b:	8b 40 1c             	mov    0x1c(%eax),%eax
  20323e:	83 c0 0c             	add    $0xc,%eax
  203241:	0f b6 00             	movzbl (%eax),%eax
  203244:	84 c0                	test   %al,%al
  203246:	75 08                	jne    203250 <get_fileinfo+0x390>
  203248:	8b 44 24 34          	mov    0x34(%esp),%eax
  20324c:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  203250:	8b 44 24 30          	mov    0x30(%esp),%eax
  203254:	8b 40 1c             	mov    0x1c(%eax),%eax
  203257:	83 c0 0b             	add    $0xb,%eax
  20325a:	0f b6 00             	movzbl (%eax),%eax
  20325d:	83 e0 3f             	and    $0x3f,%eax
  203260:	89 c2                	mov    %eax,%edx
  203262:	8b 44 24 34          	mov    0x34(%esp),%eax
  203266:	88 50 08             	mov    %dl,0x8(%eax)
  203269:	8b 44 24 30          	mov    0x30(%esp),%eax
  20326d:	8b 40 1c             	mov    0x1c(%eax),%eax
  203270:	83 c0 1c             	add    $0x1c,%eax
  203273:	83 ec 0c             	sub    $0xc,%esp
  203276:	50                   	push   %eax
  203277:	e8 c3 da ff ff       	call   200d3f <ld_32>
  20327c:	83 c4 10             	add    $0x10,%esp
  20327f:	8b 54 24 34          	mov    0x34(%esp),%edx
  203283:	89 02                	mov    %eax,(%edx)
  203285:	8b 44 24 30          	mov    0x30(%esp),%eax
  203289:	8b 40 1c             	mov    0x1c(%eax),%eax
  20328c:	83 c0 16             	add    $0x16,%eax
  20328f:	83 ec 0c             	sub    $0xc,%esp
  203292:	50                   	push   %eax
  203293:	e8 6e da ff ff       	call   200d06 <ld_16>
  203298:	83 c4 10             	add    $0x10,%esp
  20329b:	8b 54 24 34          	mov    0x34(%esp),%edx
  20329f:	66 89 42 06          	mov    %ax,0x6(%edx)
  2032a3:	8b 44 24 30          	mov    0x30(%esp),%eax
  2032a7:	8b 40 1c             	mov    0x1c(%eax),%eax
  2032aa:	83 c0 18             	add    $0x18,%eax
  2032ad:	83 ec 0c             	sub    $0xc,%esp
  2032b0:	50                   	push   %eax
  2032b1:	e8 50 da ff ff       	call   200d06 <ld_16>
  2032b6:	83 c4 10             	add    $0x10,%esp
  2032b9:	8b 54 24 34          	mov    0x34(%esp),%edx
  2032bd:	66 89 42 04          	mov    %ax,0x4(%edx)
  2032c1:	eb 01                	jmp    2032c4 <get_fileinfo+0x404>
  2032c3:	90                   	nop
  2032c4:	83 c4 28             	add    $0x28,%esp
  2032c7:	5b                   	pop    %ebx
  2032c8:	c3                   	ret

002032c9 <create_name>:
  2032c9:	83 ec 2c             	sub    $0x2c,%esp
  2032cc:	8b 44 24 34          	mov    0x34(%esp),%eax
  2032d0:	8b 00                	mov    (%eax),%eax
  2032d2:	89 04 24             	mov    %eax,(%esp)
  2032d5:	8b 44 24 30          	mov    0x30(%esp),%eax
  2032d9:	8b 00                	mov    (%eax),%eax
  2032db:	8b 40 0c             	mov    0xc(%eax),%eax
  2032de:	89 44 24 08          	mov    %eax,0x8(%esp)
  2032e2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  2032e9:	00 
  2032ea:	89 e0                	mov    %esp,%eax
  2032ec:	50                   	push   %eax
  2032ed:	e8 86 db ff ff       	call   200e78 <tchar2uni>
  2032f2:	83 c4 04             	add    $0x4,%esp
  2032f5:	89 44 24 04          	mov    %eax,0x4(%esp)
  2032f9:	83 7c 24 04 ff       	cmpl   $0xffffffff,0x4(%esp)
  2032fe:	75 0a                	jne    20330a <create_name+0x41>
  203300:	b8 06 00 00 00       	mov    $0x6,%eax
  203305:	e9 37 04 00 00       	jmp    203741 <create_name+0x478>
  20330a:	81 7c 24 04 ff ff 00 	cmpl   $0xffff,0x4(%esp)
  203311:	00 
  203312:	76 22                	jbe    203336 <create_name+0x6d>
  203314:	8b 44 24 04          	mov    0x4(%esp),%eax
  203318:	c1 e8 10             	shr    $0x10,%eax
  20331b:	89 c1                	mov    %eax,%ecx
  20331d:	8b 44 24 0c          	mov    0xc(%esp),%eax
  203321:	8d 50 01             	lea    0x1(%eax),%edx
  203324:	89 54 24 0c          	mov    %edx,0xc(%esp)
  203328:	8d 14 00             	lea    (%eax,%eax,1),%edx
  20332b:	8b 44 24 08          	mov    0x8(%esp),%eax
  20332f:	01 d0                	add    %edx,%eax
  203331:	89 ca                	mov    %ecx,%edx
  203333:	66 89 10             	mov    %dx,(%eax)
  203336:	8b 44 24 04          	mov    0x4(%esp),%eax
  20333a:	66 89 44 24 1c       	mov    %ax,0x1c(%esp)
  20333f:	66 83 7c 24 1c 1f    	cmpw   $0x1f,0x1c(%esp)
  203345:	76 71                	jbe    2033b8 <create_name+0xef>
  203347:	66 83 7c 24 1c 2f    	cmpw   $0x2f,0x1c(%esp)
  20334d:	74 69                	je     2033b8 <create_name+0xef>
  20334f:	66 83 7c 24 1c 5c    	cmpw   $0x5c,0x1c(%esp)
  203355:	74 61                	je     2033b8 <create_name+0xef>
  203357:	66 83 7c 24 1c 7f    	cmpw   $0x7f,0x1c(%esp)
  20335d:	77 24                	ja     203383 <create_name+0xba>
  20335f:	0f b7 44 24 1c       	movzwl 0x1c(%esp),%eax
  203364:	83 ec 08             	sub    $0x8,%esp
  203367:	50                   	push   %eax
  203368:	68 40 72 20 00       	push   $0x207240
  20336d:	e8 f0 3b 00 00       	call   206f62 <strchr>
  203372:	83 c4 10             	add    $0x10,%esp
  203375:	85 c0                	test   %eax,%eax
  203377:	74 0a                	je     203383 <create_name+0xba>
  203379:	b8 06 00 00 00       	mov    $0x6,%eax
  20337e:	e9 be 03 00 00       	jmp    203741 <create_name+0x478>
  203383:	81 7c 24 0c fe 00 00 	cmpl   $0xfe,0xc(%esp)
  20338a:	00 
  20338b:	76 0a                	jbe    203397 <create_name+0xce>
  20338d:	b8 06 00 00 00       	mov    $0x6,%eax
  203392:	e9 aa 03 00 00       	jmp    203741 <create_name+0x478>
  203397:	8b 44 24 0c          	mov    0xc(%esp),%eax
  20339b:	8d 50 01             	lea    0x1(%eax),%edx
  20339e:	89 54 24 0c          	mov    %edx,0xc(%esp)
  2033a2:	8d 14 00             	lea    (%eax,%eax,1),%edx
  2033a5:	8b 44 24 08          	mov    0x8(%esp),%eax
  2033a9:	01 c2                	add    %eax,%edx
  2033ab:	0f b7 44 24 1c       	movzwl 0x1c(%esp),%eax
  2033b0:	66 89 02             	mov    %ax,(%edx)
  2033b3:	e9 32 ff ff ff       	jmp    2032ea <create_name+0x21>
  2033b8:	66 83 7c 24 1c 1f    	cmpw   $0x1f,0x1c(%esp)
  2033be:	77 10                	ja     2033d0 <create_name+0x107>
  2033c0:	c6 44 24 1e 04       	movb   $0x4,0x1e(%esp)
  2033c5:	eb 31                	jmp    2033f8 <create_name+0x12f>
  2033c7:	8b 04 24             	mov    (%esp),%eax
  2033ca:	83 c0 01             	add    $0x1,%eax
  2033cd:	89 04 24             	mov    %eax,(%esp)
  2033d0:	8b 04 24             	mov    (%esp),%eax
  2033d3:	0f b6 00             	movzbl (%eax),%eax
  2033d6:	3c 2f                	cmp    $0x2f,%al
  2033d8:	74 ed                	je     2033c7 <create_name+0xfe>
  2033da:	8b 04 24             	mov    (%esp),%eax
  2033dd:	0f b6 00             	movzbl (%eax),%eax
  2033e0:	3c 5c                	cmp    $0x5c,%al
  2033e2:	74 e3                	je     2033c7 <create_name+0xfe>
  2033e4:	c6 44 24 1e 00       	movb   $0x0,0x1e(%esp)
  2033e9:	8b 04 24             	mov    (%esp),%eax
  2033ec:	0f b6 00             	movzbl (%eax),%eax
  2033ef:	3c 1f                	cmp    $0x1f,%al
  2033f1:	77 05                	ja     2033f8 <create_name+0x12f>
  2033f3:	c6 44 24 1e 04       	movb   $0x4,0x1e(%esp)
  2033f8:	8b 14 24             	mov    (%esp),%edx
  2033fb:	8b 44 24 34          	mov    0x34(%esp),%eax
  2033ff:	89 10                	mov    %edx,(%eax)
  203401:	eb 2f                	jmp    203432 <create_name+0x169>
  203403:	8b 44 24 0c          	mov    0xc(%esp),%eax
  203407:	05 ff ff ff 7f       	add    $0x7fffffff,%eax
  20340c:	8d 14 00             	lea    (%eax,%eax,1),%edx
  20340f:	8b 44 24 08          	mov    0x8(%esp),%eax
  203413:	01 d0                	add    %edx,%eax
  203415:	0f b7 00             	movzwl (%eax),%eax
  203418:	66 89 44 24 1c       	mov    %ax,0x1c(%esp)
  20341d:	66 83 7c 24 1c 20    	cmpw   $0x20,0x1c(%esp)
  203423:	74 08                	je     20342d <create_name+0x164>
  203425:	66 83 7c 24 1c 2e    	cmpw   $0x2e,0x1c(%esp)
  20342b:	75 0e                	jne    20343b <create_name+0x172>
  20342d:	83 6c 24 0c 01       	subl   $0x1,0xc(%esp)
  203432:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  203437:	75 ca                	jne    203403 <create_name+0x13a>
  203439:	eb 01                	jmp    20343c <create_name+0x173>
  20343b:	90                   	nop
  20343c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  203440:	8d 14 00             	lea    (%eax,%eax,1),%edx
  203443:	8b 44 24 08          	mov    0x8(%esp),%eax
  203447:	01 d0                	add    %edx,%eax
  203449:	66 c7 00 00 00       	movw   $0x0,(%eax)
  20344e:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  203453:	75 0a                	jne    20345f <create_name+0x196>
  203455:	b8 06 00 00 00       	mov    $0x6,%eax
  20345a:	e9 e2 02 00 00       	jmp    203741 <create_name+0x478>
  20345f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  203466:	00 
  203467:	eb 05                	jmp    20346e <create_name+0x1a5>
  203469:	83 44 24 10 01       	addl   $0x1,0x10(%esp)
  20346e:	8b 44 24 10          	mov    0x10(%esp),%eax
  203472:	8d 14 00             	lea    (%eax,%eax,1),%edx
  203475:	8b 44 24 08          	mov    0x8(%esp),%eax
  203479:	01 d0                	add    %edx,%eax
  20347b:	0f b7 00             	movzwl (%eax),%eax
  20347e:	66 83 f8 20          	cmp    $0x20,%ax
  203482:	74 e5                	je     203469 <create_name+0x1a0>
  203484:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  203489:	75 16                	jne    2034a1 <create_name+0x1d8>
  20348b:	8b 44 24 10          	mov    0x10(%esp),%eax
  20348f:	8d 14 00             	lea    (%eax,%eax,1),%edx
  203492:	8b 44 24 08          	mov    0x8(%esp),%eax
  203496:	01 d0                	add    %edx,%eax
  203498:	0f b7 00             	movzwl (%eax),%eax
  20349b:	66 83 f8 2e          	cmp    $0x2e,%ax
  20349f:	75 0c                	jne    2034ad <create_name+0x1e4>
  2034a1:	80 4c 24 1e 03       	orb    $0x3,0x1e(%esp)
  2034a6:	eb 05                	jmp    2034ad <create_name+0x1e4>
  2034a8:	83 6c 24 0c 01       	subl   $0x1,0xc(%esp)
  2034ad:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  2034b2:	74 1b                	je     2034cf <create_name+0x206>
  2034b4:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2034b8:	05 ff ff ff 7f       	add    $0x7fffffff,%eax
  2034bd:	8d 14 00             	lea    (%eax,%eax,1),%edx
  2034c0:	8b 44 24 08          	mov    0x8(%esp),%eax
  2034c4:	01 d0                	add    %edx,%eax
  2034c6:	0f b7 00             	movzwl (%eax),%eax
  2034c9:	66 83 f8 2e          	cmp    $0x2e,%ax
  2034cd:	75 d9                	jne    2034a8 <create_name+0x1df>
  2034cf:	8b 44 24 30          	mov    0x30(%esp),%eax
  2034d3:	83 c0 20             	add    $0x20,%eax
  2034d6:	83 ec 04             	sub    $0x4,%esp
  2034d9:	6a 0b                	push   $0xb
  2034db:	6a 20                	push   $0x20
  2034dd:	50                   	push   %eax
  2034de:	e8 2c 39 00 00       	call   206e0f <memset>
  2034e3:	83 c4 10             	add    $0x10,%esp
  2034e6:	c6 44 24 1f 00       	movb   $0x0,0x1f(%esp)
  2034eb:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  2034f2:	00 
  2034f3:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
  2034fa:	00 
  2034fb:	8b 44 24 10          	mov    0x10(%esp),%eax
  2034ff:	8d 50 01             	lea    0x1(%eax),%edx
  203502:	89 54 24 10          	mov    %edx,0x10(%esp)
  203506:	8d 14 00             	lea    (%eax,%eax,1),%edx
  203509:	8b 44 24 08          	mov    0x8(%esp),%eax
  20350d:	01 d0                	add    %edx,%eax
  20350f:	0f b7 00             	movzwl (%eax),%eax
  203512:	66 89 44 24 1c       	mov    %ax,0x1c(%esp)
  203517:	66 83 7c 24 1c 00    	cmpw   $0x0,0x1c(%esp)
  20351d:	0f 84 9c 01 00 00    	je     2036bf <create_name+0x3f6>
  203523:	66 83 7c 24 1c 20    	cmpw   $0x20,0x1c(%esp)
  203529:	74 12                	je     20353d <create_name+0x274>
  20352b:	66 83 7c 24 1c 2e    	cmpw   $0x2e,0x1c(%esp)
  203531:	75 14                	jne    203547 <create_name+0x27e>
  203533:	8b 44 24 10          	mov    0x10(%esp),%eax
  203537:	3b 44 24 0c          	cmp    0xc(%esp),%eax
  20353b:	74 0a                	je     203547 <create_name+0x27e>
  20353d:	80 4c 24 1e 03       	orb    $0x3,0x1e(%esp)
  203542:	e9 73 01 00 00       	jmp    2036ba <create_name+0x3f1>
  203547:	8b 44 24 18          	mov    0x18(%esp),%eax
  20354b:	3b 44 24 14          	cmp    0x14(%esp),%eax
  20354f:	73 0a                	jae    20355b <create_name+0x292>
  203551:	8b 44 24 10          	mov    0x10(%esp),%eax
  203555:	3b 44 24 0c          	cmp    0xc(%esp),%eax
  203559:	75 50                	jne    2035ab <create_name+0x2e2>
  20355b:	83 7c 24 14 0b       	cmpl   $0xb,0x14(%esp)
  203560:	75 0a                	jne    20356c <create_name+0x2a3>
  203562:	80 4c 24 1e 03       	orb    $0x3,0x1e(%esp)
  203567:	e9 57 01 00 00       	jmp    2036c3 <create_name+0x3fa>
  20356c:	8b 44 24 10          	mov    0x10(%esp),%eax
  203570:	3b 44 24 0c          	cmp    0xc(%esp),%eax
  203574:	74 05                	je     20357b <create_name+0x2b2>
  203576:	80 4c 24 1e 03       	orb    $0x3,0x1e(%esp)
  20357b:	8b 44 24 10          	mov    0x10(%esp),%eax
  20357f:	39 44 24 0c          	cmp    %eax,0xc(%esp)
  203583:	0f 82 39 01 00 00    	jb     2036c2 <create_name+0x3f9>
  203589:	8b 44 24 0c          	mov    0xc(%esp),%eax
  20358d:	89 44 24 10          	mov    %eax,0x10(%esp)
  203591:	c7 44 24 18 08 00 00 	movl   $0x8,0x18(%esp)
  203598:	00 
  203599:	c7 44 24 14 0b 00 00 	movl   $0xb,0x14(%esp)
  2035a0:	00 
  2035a1:	c0 64 24 1f 02       	shlb   $0x2,0x1f(%esp)
  2035a6:	e9 0f 01 00 00       	jmp    2036ba <create_name+0x3f1>
  2035ab:	66 83 7c 24 1c 7f    	cmpw   $0x7f,0x1c(%esp)
  2035b1:	76 45                	jbe    2035f8 <create_name+0x32f>
  2035b3:	80 4c 24 1e 02       	orb    $0x2,0x1e(%esp)
  2035b8:	0f b7 44 24 1c       	movzwl 0x1c(%esp),%eax
  2035bd:	83 ec 08             	sub    $0x8,%esp
  2035c0:	68 b5 01 00 00       	push   $0x1b5
  2035c5:	50                   	push   %eax
  2035c6:	e8 25 32 00 00       	call   2067f0 <ff_uni2oem>
  2035cb:	83 c4 10             	add    $0x10,%esp
  2035ce:	66 89 44 24 1c       	mov    %ax,0x1c(%esp)
  2035d3:	0f b7 44 24 1c       	movzwl 0x1c(%esp),%eax
  2035d8:	25 80 00 00 00       	and    $0x80,%eax
  2035dd:	85 c0                	test   %eax,%eax
  2035df:	74 17                	je     2035f8 <create_name+0x32f>
  2035e1:	0f b7 44 24 1c       	movzwl 0x1c(%esp),%eax
  2035e6:	83 e0 7f             	and    $0x7f,%eax
  2035e9:	0f b6 80 c0 71 20 00 	movzbl 0x2071c0(%eax),%eax
  2035f0:	0f b6 c0             	movzbl %al,%eax
  2035f3:	66 89 44 24 1c       	mov    %ax,0x1c(%esp)
  2035f8:	66 81 7c 24 1c ff 00 	cmpw   $0xff,0x1c(%esp)
  2035ff:	76 3f                	jbe    203640 <create_name+0x377>
  203601:	8b 44 24 14          	mov    0x14(%esp),%eax
  203605:	83 e8 01             	sub    $0x1,%eax
  203608:	39 44 24 18          	cmp    %eax,0x18(%esp)
  20360c:	72 12                	jb     203620 <create_name+0x357>
  20360e:	80 4c 24 1e 03       	orb    $0x3,0x1e(%esp)
  203613:	8b 44 24 14          	mov    0x14(%esp),%eax
  203617:	89 44 24 18          	mov    %eax,0x18(%esp)
  20361b:	e9 9a 00 00 00       	jmp    2036ba <create_name+0x3f1>
  203620:	0f b7 44 24 1c       	movzwl 0x1c(%esp),%eax
  203625:	66 c1 e8 08          	shr    $0x8,%ax
  203629:	89 c1                	mov    %eax,%ecx
  20362b:	8b 44 24 18          	mov    0x18(%esp),%eax
  20362f:	8d 50 01             	lea    0x1(%eax),%edx
  203632:	89 54 24 18          	mov    %edx,0x18(%esp)
  203636:	8b 54 24 30          	mov    0x30(%esp),%edx
  20363a:	88 4c 02 20          	mov    %cl,0x20(%edx,%eax,1)
  20363e:	eb 60                	jmp    2036a0 <create_name+0x3d7>
  203640:	66 83 7c 24 1c 00    	cmpw   $0x0,0x1c(%esp)
  203646:	74 1a                	je     203662 <create_name+0x399>
  203648:	0f b7 44 24 1c       	movzwl 0x1c(%esp),%eax
  20364d:	83 ec 08             	sub    $0x8,%esp
  203650:	50                   	push   %eax
  203651:	68 49 72 20 00       	push   $0x207249
  203656:	e8 07 39 00 00       	call   206f62 <strchr>
  20365b:	83 c4 10             	add    $0x10,%esp
  20365e:	85 c0                	test   %eax,%eax
  203660:	74 0e                	je     203670 <create_name+0x3a7>
  203662:	66 c7 44 24 1c 5f 00 	movw   $0x5f,0x1c(%esp)
  203669:	80 4c 24 1e 03       	orb    $0x3,0x1e(%esp)
  20366e:	eb 30                	jmp    2036a0 <create_name+0x3d7>
  203670:	66 83 7c 24 1c 40    	cmpw   $0x40,0x1c(%esp)
  203676:	76 0d                	jbe    203685 <create_name+0x3bc>
  203678:	66 83 7c 24 1c 5a    	cmpw   $0x5a,0x1c(%esp)
  20367e:	77 05                	ja     203685 <create_name+0x3bc>
  203680:	80 4c 24 1f 02       	orb    $0x2,0x1f(%esp)
  203685:	66 83 7c 24 1c 60    	cmpw   $0x60,0x1c(%esp)
  20368b:	76 13                	jbe    2036a0 <create_name+0x3d7>
  20368d:	66 83 7c 24 1c 7a    	cmpw   $0x7a,0x1c(%esp)
  203693:	77 0b                	ja     2036a0 <create_name+0x3d7>
  203695:	80 4c 24 1f 01       	orb    $0x1,0x1f(%esp)
  20369a:	66 83 6c 24 1c 20    	subw   $0x20,0x1c(%esp)
  2036a0:	8b 44 24 18          	mov    0x18(%esp),%eax
  2036a4:	8d 50 01             	lea    0x1(%eax),%edx
  2036a7:	89 54 24 18          	mov    %edx,0x18(%esp)
  2036ab:	0f b7 54 24 1c       	movzwl 0x1c(%esp),%edx
  2036b0:	89 d1                	mov    %edx,%ecx
  2036b2:	8b 54 24 30          	mov    0x30(%esp),%edx
  2036b6:	88 4c 02 20          	mov    %cl,0x20(%edx,%eax,1)
  2036ba:	e9 3c fe ff ff       	jmp    2034fb <create_name+0x232>
  2036bf:	90                   	nop
  2036c0:	eb 01                	jmp    2036c3 <create_name+0x3fa>
  2036c2:	90                   	nop
  2036c3:	8b 44 24 30          	mov    0x30(%esp),%eax
  2036c7:	0f b6 40 20          	movzbl 0x20(%eax),%eax
  2036cb:	3c e5                	cmp    $0xe5,%al
  2036cd:	75 08                	jne    2036d7 <create_name+0x40e>
  2036cf:	8b 44 24 30          	mov    0x30(%esp),%eax
  2036d3:	c6 40 20 05          	movb   $0x5,0x20(%eax)
  2036d7:	83 7c 24 14 08       	cmpl   $0x8,0x14(%esp)
  2036dc:	75 05                	jne    2036e3 <create_name+0x41a>
  2036de:	c0 64 24 1f 02       	shlb   $0x2,0x1f(%esp)
  2036e3:	0f b6 44 24 1f       	movzbl 0x1f(%esp),%eax
  2036e8:	83 e0 0c             	and    $0xc,%eax
  2036eb:	83 f8 0c             	cmp    $0xc,%eax
  2036ee:	74 0d                	je     2036fd <create_name+0x434>
  2036f0:	0f b6 44 24 1f       	movzbl 0x1f(%esp),%eax
  2036f5:	83 e0 03             	and    $0x3,%eax
  2036f8:	83 f8 03             	cmp    $0x3,%eax
  2036fb:	75 05                	jne    203702 <create_name+0x439>
  2036fd:	80 4c 24 1e 02       	orb    $0x2,0x1e(%esp)
  203702:	0f b6 44 24 1e       	movzbl 0x1e(%esp),%eax
  203707:	83 e0 02             	and    $0x2,%eax
  20370a:	85 c0                	test   %eax,%eax
  20370c:	75 22                	jne    203730 <create_name+0x467>
  20370e:	0f b6 44 24 1f       	movzbl 0x1f(%esp),%eax
  203713:	83 e0 01             	and    $0x1,%eax
  203716:	85 c0                	test   %eax,%eax
  203718:	74 05                	je     20371f <create_name+0x456>
  20371a:	80 4c 24 1e 10       	orb    $0x10,0x1e(%esp)
  20371f:	0f b6 44 24 1f       	movzbl 0x1f(%esp),%eax
  203724:	83 e0 04             	and    $0x4,%eax
  203727:	85 c0                	test   %eax,%eax
  203729:	74 05                	je     203730 <create_name+0x467>
  20372b:	80 4c 24 1e 08       	orb    $0x8,0x1e(%esp)
  203730:	8b 44 24 30          	mov    0x30(%esp),%eax
  203734:	0f b6 54 24 1e       	movzbl 0x1e(%esp),%edx
  203739:	88 50 2b             	mov    %dl,0x2b(%eax)
  20373c:	b8 00 00 00 00       	mov    $0x0,%eax
  203741:	83 c4 2c             	add    $0x2c,%esp
  203744:	c3                   	ret

00203745 <follow_path>:
  203745:	83 ec 1c             	sub    $0x1c,%esp
  203748:	8b 44 24 20          	mov    0x20(%esp),%eax
  20374c:	8b 00                	mov    (%eax),%eax
  20374e:	89 44 24 08          	mov    %eax,0x8(%esp)
  203752:	eb 0b                	jmp    20375f <follow_path+0x1a>
  203754:	8b 44 24 24          	mov    0x24(%esp),%eax
  203758:	83 c0 01             	add    $0x1,%eax
  20375b:	89 44 24 24          	mov    %eax,0x24(%esp)
  20375f:	8b 44 24 24          	mov    0x24(%esp),%eax
  203763:	0f b6 00             	movzbl (%eax),%eax
  203766:	3c 2f                	cmp    $0x2f,%al
  203768:	74 ea                	je     203754 <follow_path+0xf>
  20376a:	8b 44 24 24          	mov    0x24(%esp),%eax
  20376e:	0f b6 00             	movzbl (%eax),%eax
  203771:	3c 5c                	cmp    $0x5c,%al
  203773:	74 df                	je     203754 <follow_path+0xf>
  203775:	8b 44 24 20          	mov    0x20(%esp),%eax
  203779:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  203780:	8b 44 24 24          	mov    0x24(%esp),%eax
  203784:	0f b6 00             	movzbl (%eax),%eax
  203787:	3c 1f                	cmp    $0x1f,%al
  203789:	77 22                	ja     2037ad <follow_path+0x68>
  20378b:	8b 44 24 20          	mov    0x20(%esp),%eax
  20378f:	c6 40 2b 80          	movb   $0x80,0x2b(%eax)
  203793:	83 ec 08             	sub    $0x8,%esp
  203796:	6a 00                	push   $0x0
  203798:	ff 74 24 2c          	push   0x2c(%esp)
  20379c:	e8 ea e5 ff ff       	call   201d8b <dir_sdi>
  2037a1:	83 c4 10             	add    $0x10,%esp
  2037a4:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2037a8:	e9 c6 00 00 00       	jmp    203873 <follow_path+0x12e>
  2037ad:	83 ec 08             	sub    $0x8,%esp
  2037b0:	8d 44 24 2c          	lea    0x2c(%esp),%eax
  2037b4:	50                   	push   %eax
  2037b5:	ff 74 24 2c          	push   0x2c(%esp)
  2037b9:	e8 0b fb ff ff       	call   2032c9 <create_name>
  2037be:	83 c4 10             	add    $0x10,%esp
  2037c1:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2037c5:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  2037ca:	0f 85 9c 00 00 00    	jne    20386c <follow_path+0x127>
  2037d0:	8b 44 24 20          	mov    0x20(%esp),%eax
  2037d4:	0f b6 40 2b          	movzbl 0x2b(%eax),%eax
  2037d8:	88 44 24 07          	mov    %al,0x7(%esp)
  2037dc:	83 ec 0c             	sub    $0xc,%esp
  2037df:	ff 74 24 2c          	push   0x2c(%esp)
  2037e3:	e8 3e f1 ff ff       	call   202926 <dir_find>
  2037e8:	83 c4 10             	add    $0x10,%esp
  2037eb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2037ef:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  2037f4:	74 1d                	je     203813 <follow_path+0xce>
  2037f6:	83 7c 24 0c 04       	cmpl   $0x4,0xc(%esp)
  2037fb:	75 72                	jne    20386f <follow_path+0x12a>
  2037fd:	0f b6 44 24 07       	movzbl 0x7(%esp),%eax
  203802:	83 e0 04             	and    $0x4,%eax
  203805:	85 c0                	test   %eax,%eax
  203807:	75 66                	jne    20386f <follow_path+0x12a>
  203809:	c7 44 24 0c 05 00 00 	movl   $0x5,0xc(%esp)
  203810:	00 
  203811:	eb 5c                	jmp    20386f <follow_path+0x12a>
  203813:	0f b6 44 24 07       	movzbl 0x7(%esp),%eax
  203818:	83 e0 04             	and    $0x4,%eax
  20381b:	85 c0                	test   %eax,%eax
  20381d:	75 53                	jne    203872 <follow_path+0x12d>
  20381f:	8b 44 24 20          	mov    0x20(%esp),%eax
  203823:	0f b6 40 06          	movzbl 0x6(%eax),%eax
  203827:	0f b6 c0             	movzbl %al,%eax
  20382a:	83 e0 10             	and    $0x10,%eax
  20382d:	85 c0                	test   %eax,%eax
  20382f:	75 0a                	jne    20383b <follow_path+0xf6>
  203831:	c7 44 24 0c 05 00 00 	movl   $0x5,0xc(%esp)
  203838:	00 
  203839:	eb 38                	jmp    203873 <follow_path+0x12e>
  20383b:	8b 44 24 08          	mov    0x8(%esp),%eax
  20383f:	8d 50 34             	lea    0x34(%eax),%edx
  203842:	8b 44 24 20          	mov    0x20(%esp),%eax
  203846:	8b 40 10             	mov    0x10(%eax),%eax
  203849:	25 ff 01 00 00       	and    $0x1ff,%eax
  20384e:	01 d0                	add    %edx,%eax
  203850:	83 ec 08             	sub    $0x8,%esp
  203853:	50                   	push   %eax
  203854:	ff 74 24 14          	push   0x14(%esp)
  203858:	e8 49 e9 ff ff       	call   2021a6 <ld_clust>
  20385d:	83 c4 10             	add    $0x10,%esp
  203860:	8b 54 24 20          	mov    0x20(%esp),%edx
  203864:	89 42 08             	mov    %eax,0x8(%edx)
  203867:	e9 41 ff ff ff       	jmp    2037ad <follow_path+0x68>
  20386c:	90                   	nop
  20386d:	eb 04                	jmp    203873 <follow_path+0x12e>
  20386f:	90                   	nop
  203870:	eb 01                	jmp    203873 <follow_path+0x12e>
  203872:	90                   	nop
  203873:	8b 44 24 0c          	mov    0xc(%esp),%eax
  203877:	83 c4 1c             	add    $0x1c,%esp
  20387a:	c3                   	ret

0020387b <get_ldnumber>:
  20387b:	83 ec 10             	sub    $0x10,%esp
  20387e:	8b 44 24 14          	mov    0x14(%esp),%eax
  203882:	8b 00                	mov    (%eax),%eax
  203884:	89 44 24 04          	mov    %eax,0x4(%esp)
  203888:	8b 44 24 04          	mov    0x4(%esp),%eax
  20388c:	89 44 24 0c          	mov    %eax,0xc(%esp)
  203890:	83 7c 24 04 00       	cmpl   $0x0,0x4(%esp)
  203895:	75 0a                	jne    2038a1 <get_ldnumber+0x26>
  203897:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  20389c:	e9 88 00 00 00       	jmp    203929 <get_ldnumber+0xae>
  2038a1:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2038a5:	8d 50 01             	lea    0x1(%eax),%edx
  2038a8:	89 54 24 0c          	mov    %edx,0xc(%esp)
  2038ac:	0f b6 00             	movzbl (%eax),%eax
  2038af:	88 44 24 03          	mov    %al,0x3(%esp)
  2038b3:	0f b6 44 24 03       	movzbl 0x3(%esp),%eax
  2038b8:	3c 1f                	cmp    $0x1f,%al
  2038ba:	76 07                	jbe    2038c3 <get_ldnumber+0x48>
  2038bc:	80 7c 24 03 3a       	cmpb   $0x3a,0x3(%esp)
  2038c1:	75 de                	jne    2038a1 <get_ldnumber+0x26>
  2038c3:	80 7c 24 03 3a       	cmpb   $0x3a,0x3(%esp)
  2038c8:	75 5a                	jne    203924 <get_ldnumber+0xa9>
  2038ca:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  2038d1:	00 
  2038d2:	8b 44 24 04          	mov    0x4(%esp),%eax
  2038d6:	0f b6 00             	movzbl (%eax),%eax
  2038d9:	3c 2f                	cmp    $0x2f,%al
  2038db:	7e 29                	jle    203906 <get_ldnumber+0x8b>
  2038dd:	8b 44 24 04          	mov    0x4(%esp),%eax
  2038e1:	0f b6 00             	movzbl (%eax),%eax
  2038e4:	3c 39                	cmp    $0x39,%al
  2038e6:	7f 1e                	jg     203906 <get_ldnumber+0x8b>
  2038e8:	8b 44 24 04          	mov    0x4(%esp),%eax
  2038ec:	83 c0 02             	add    $0x2,%eax
  2038ef:	39 44 24 0c          	cmp    %eax,0xc(%esp)
  2038f3:	75 11                	jne    203906 <get_ldnumber+0x8b>
  2038f5:	8b 44 24 04          	mov    0x4(%esp),%eax
  2038f9:	0f b6 00             	movzbl (%eax),%eax
  2038fc:	0f be c0             	movsbl %al,%eax
  2038ff:	83 e8 30             	sub    $0x30,%eax
  203902:	89 44 24 08          	mov    %eax,0x8(%esp)
  203906:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  20390b:	7e 07                	jle    203914 <get_ldnumber+0x99>
  20390d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  203912:	eb 15                	jmp    203929 <get_ldnumber+0xae>
  203914:	8b 44 24 14          	mov    0x14(%esp),%eax
  203918:	8b 54 24 0c          	mov    0xc(%esp),%edx
  20391c:	89 10                	mov    %edx,(%eax)
  20391e:	8b 44 24 08          	mov    0x8(%esp),%eax
  203922:	eb 05                	jmp    203929 <get_ldnumber+0xae>
  203924:	b8 00 00 00 00       	mov    $0x0,%eax
  203929:	83 c4 10             	add    $0x10,%esp
  20392c:	c3                   	ret

0020392d <check_fs>:
  20392d:	83 ec 1c             	sub    $0x1c,%esp
  203930:	8b 44 24 20          	mov    0x20(%esp),%eax
  203934:	c6 40 04 00          	movb   $0x0,0x4(%eax)
  203938:	8b 44 24 20          	mov    0x20(%esp),%eax
  20393c:	c7 40 20 ff ff ff ff 	movl   $0xffffffff,0x20(%eax)
  203943:	83 ec 08             	sub    $0x8,%esp
  203946:	ff 74 24 2c          	push   0x2c(%esp)
  20394a:	ff 74 24 2c          	push   0x2c(%esp)
  20394e:	e8 39 d9 ff ff       	call   20128c <move_window>
  203953:	83 c4 10             	add    $0x10,%esp
  203956:	85 c0                	test   %eax,%eax
  203958:	74 0a                	je     203964 <check_fs+0x37>
  20395a:	b8 04 00 00 00       	mov    $0x4,%eax
  20395f:	e9 ad 01 00 00       	jmp    203b11 <check_fs+0x1e4>
  203964:	8b 44 24 20          	mov    0x20(%esp),%eax
  203968:	83 c0 34             	add    $0x34,%eax
  20396b:	05 fe 01 00 00       	add    $0x1fe,%eax
  203970:	83 ec 0c             	sub    $0xc,%esp
  203973:	50                   	push   %eax
  203974:	e8 8d d3 ff ff       	call   200d06 <ld_16>
  203979:	83 c4 10             	add    $0x10,%esp
  20397c:	66 89 44 24 0e       	mov    %ax,0xe(%esp)
  203981:	8b 44 24 20          	mov    0x20(%esp),%eax
  203985:	0f b6 40 34          	movzbl 0x34(%eax),%eax
  203989:	88 44 24 0d          	mov    %al,0xd(%esp)
  20398d:	80 7c 24 0d eb       	cmpb   $0xeb,0xd(%esp)
  203992:	74 12                	je     2039a6 <check_fs+0x79>
  203994:	80 7c 24 0d e9       	cmpb   $0xe9,0xd(%esp)
  203999:	74 0b                	je     2039a6 <check_fs+0x79>
  20399b:	80 7c 24 0d e8       	cmpb   $0xe8,0xd(%esp)
  2039a0:	0f 85 56 01 00 00    	jne    203afc <check_fs+0x1cf>
  2039a6:	66 81 7c 24 0e 55 aa 	cmpw   $0xaa55,0xe(%esp)
  2039ad:	75 2b                	jne    2039da <check_fs+0xad>
  2039af:	8b 44 24 20          	mov    0x20(%esp),%eax
  2039b3:	83 c0 34             	add    $0x34,%eax
  2039b6:	83 c0 52             	add    $0x52,%eax
  2039b9:	83 ec 04             	sub    $0x4,%esp
  2039bc:	6a 08                	push   $0x8
  2039be:	68 50 72 20 00       	push   $0x207250
  2039c3:	50                   	push   %eax
  2039c4:	e8 c7 34 00 00       	call   206e90 <memcmp>
  2039c9:	83 c4 10             	add    $0x10,%esp
  2039cc:	85 c0                	test   %eax,%eax
  2039ce:	75 0a                	jne    2039da <check_fs+0xad>
  2039d0:	b8 00 00 00 00       	mov    $0x0,%eax
  2039d5:	e9 37 01 00 00       	jmp    203b11 <check_fs+0x1e4>
  2039da:	8b 44 24 20          	mov    0x20(%esp),%eax
  2039de:	83 c0 34             	add    $0x34,%eax
  2039e1:	83 c0 0b             	add    $0xb,%eax
  2039e4:	83 ec 0c             	sub    $0xc,%esp
  2039e7:	50                   	push   %eax
  2039e8:	e8 19 d3 ff ff       	call   200d06 <ld_16>
  2039ed:	83 c4 10             	add    $0x10,%esp
  2039f0:	66 89 44 24 0a       	mov    %ax,0xa(%esp)
  2039f5:	8b 44 24 20          	mov    0x20(%esp),%eax
  2039f9:	0f b6 40 41          	movzbl 0x41(%eax),%eax
  2039fd:	88 44 24 0d          	mov    %al,0xd(%esp)
  203a01:	0f b7 44 24 0a       	movzwl 0xa(%esp),%eax
  203a06:	0f b7 54 24 0a       	movzwl 0xa(%esp),%edx
  203a0b:	83 ea 01             	sub    $0x1,%edx
  203a0e:	21 d0                	and    %edx,%eax
  203a10:	85 c0                	test   %eax,%eax
  203a12:	0f 85 e4 00 00 00    	jne    203afc <check_fs+0x1cf>
  203a18:	66 81 7c 24 0a ff 01 	cmpw   $0x1ff,0xa(%esp)
  203a1f:	0f 86 d7 00 00 00    	jbe    203afc <check_fs+0x1cf>
  203a25:	66 81 7c 24 0a 00 02 	cmpw   $0x200,0xa(%esp)
  203a2c:	0f 87 ca 00 00 00    	ja     203afc <check_fs+0x1cf>
  203a32:	80 7c 24 0d 00       	cmpb   $0x0,0xd(%esp)
  203a37:	0f 84 bf 00 00 00    	je     203afc <check_fs+0x1cf>
  203a3d:	0f b6 44 24 0d       	movzbl 0xd(%esp),%eax
  203a42:	0f b6 54 24 0d       	movzbl 0xd(%esp),%edx
  203a47:	83 ea 01             	sub    $0x1,%edx
  203a4a:	21 d0                	and    %edx,%eax
  203a4c:	85 c0                	test   %eax,%eax
  203a4e:	0f 85 a8 00 00 00    	jne    203afc <check_fs+0x1cf>
  203a54:	8b 44 24 20          	mov    0x20(%esp),%eax
  203a58:	83 c0 34             	add    $0x34,%eax
  203a5b:	83 c0 0e             	add    $0xe,%eax
  203a5e:	83 ec 0c             	sub    $0xc,%esp
  203a61:	50                   	push   %eax
  203a62:	e8 9f d2 ff ff       	call   200d06 <ld_16>
  203a67:	83 c4 10             	add    $0x10,%esp
  203a6a:	66 85 c0             	test   %ax,%ax
  203a6d:	0f 84 89 00 00 00    	je     203afc <check_fs+0x1cf>
  203a73:	8b 44 24 20          	mov    0x20(%esp),%eax
  203a77:	0f b6 40 44          	movzbl 0x44(%eax),%eax
  203a7b:	0f b6 c0             	movzbl %al,%eax
  203a7e:	83 e8 01             	sub    $0x1,%eax
  203a81:	83 f8 01             	cmp    $0x1,%eax
  203a84:	77 76                	ja     203afc <check_fs+0x1cf>
  203a86:	8b 44 24 20          	mov    0x20(%esp),%eax
  203a8a:	83 c0 34             	add    $0x34,%eax
  203a8d:	83 c0 11             	add    $0x11,%eax
  203a90:	83 ec 0c             	sub    $0xc,%esp
  203a93:	50                   	push   %eax
  203a94:	e8 6d d2 ff ff       	call   200d06 <ld_16>
  203a99:	83 c4 10             	add    $0x10,%esp
  203a9c:	66 85 c0             	test   %ax,%ax
  203a9f:	74 5b                	je     203afc <check_fs+0x1cf>
  203aa1:	8b 44 24 20          	mov    0x20(%esp),%eax
  203aa5:	83 c0 34             	add    $0x34,%eax
  203aa8:	83 c0 13             	add    $0x13,%eax
  203aab:	83 ec 0c             	sub    $0xc,%esp
  203aae:	50                   	push   %eax
  203aaf:	e8 52 d2 ff ff       	call   200d06 <ld_16>
  203ab4:	83 c4 10             	add    $0x10,%esp
  203ab7:	66 83 f8 7f          	cmp    $0x7f,%ax
  203abb:	77 1d                	ja     203ada <check_fs+0x1ad>
  203abd:	8b 44 24 20          	mov    0x20(%esp),%eax
  203ac1:	83 c0 34             	add    $0x34,%eax
  203ac4:	83 c0 20             	add    $0x20,%eax
  203ac7:	83 ec 0c             	sub    $0xc,%esp
  203aca:	50                   	push   %eax
  203acb:	e8 6f d2 ff ff       	call   200d3f <ld_32>
  203ad0:	83 c4 10             	add    $0x10,%esp
  203ad3:	3d ff ff 00 00       	cmp    $0xffff,%eax
  203ad8:	76 22                	jbe    203afc <check_fs+0x1cf>
  203ada:	8b 44 24 20          	mov    0x20(%esp),%eax
  203ade:	83 c0 34             	add    $0x34,%eax
  203ae1:	83 c0 16             	add    $0x16,%eax
  203ae4:	83 ec 0c             	sub    $0xc,%esp
  203ae7:	50                   	push   %eax
  203ae8:	e8 19 d2 ff ff       	call   200d06 <ld_16>
  203aed:	83 c4 10             	add    $0x10,%esp
  203af0:	66 85 c0             	test   %ax,%ax
  203af3:	74 07                	je     203afc <check_fs+0x1cf>
  203af5:	b8 00 00 00 00       	mov    $0x0,%eax
  203afa:	eb 15                	jmp    203b11 <check_fs+0x1e4>
  203afc:	66 81 7c 24 0e 55 aa 	cmpw   $0xaa55,0xe(%esp)
  203b03:	75 07                	jne    203b0c <check_fs+0x1df>
  203b05:	b8 02 00 00 00       	mov    $0x2,%eax
  203b0a:	eb 05                	jmp    203b11 <check_fs+0x1e4>
  203b0c:	b8 03 00 00 00       	mov    $0x3,%eax
  203b11:	83 c4 1c             	add    $0x1c,%esp
  203b14:	c3                   	ret

00203b15 <find_volume>:
  203b15:	83 ec 2c             	sub    $0x2c,%esp
  203b18:	83 ec 08             	sub    $0x8,%esp
  203b1b:	6a 00                	push   $0x0
  203b1d:	ff 74 24 3c          	push   0x3c(%esp)
  203b21:	e8 07 fe ff ff       	call   20392d <check_fs>
  203b26:	83 c4 10             	add    $0x10,%esp
  203b29:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  203b2d:	83 7c 24 1c 02       	cmpl   $0x2,0x1c(%esp)
  203b32:	74 17                	je     203b4b <find_volume+0x36>
  203b34:	83 7c 24 1c 02       	cmpl   $0x2,0x1c(%esp)
  203b39:	77 07                	ja     203b42 <find_volume+0x2d>
  203b3b:	83 7c 24 34 00       	cmpl   $0x0,0x34(%esp)
  203b40:	75 09                	jne    203b4b <find_volume+0x36>
  203b42:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  203b46:	e9 a6 00 00 00       	jmp    203bf1 <find_volume+0xdc>
  203b4b:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  203b52:	00 
  203b53:	eb 2e                	jmp    203b83 <find_volume+0x6e>
  203b55:	8b 44 24 30          	mov    0x30(%esp),%eax
  203b59:	8d 50 34             	lea    0x34(%eax),%edx
  203b5c:	8b 44 24 18          	mov    0x18(%esp),%eax
  203b60:	c1 e0 04             	shl    $0x4,%eax
  203b63:	05 c6 01 00 00       	add    $0x1c6,%eax
  203b68:	01 d0                	add    %edx,%eax
  203b6a:	83 ec 0c             	sub    $0xc,%esp
  203b6d:	50                   	push   %eax
  203b6e:	e8 cc d1 ff ff       	call   200d3f <ld_32>
  203b73:	83 c4 10             	add    $0x10,%esp
  203b76:	8b 54 24 18          	mov    0x18(%esp),%edx
  203b7a:	89 44 94 08          	mov    %eax,0x8(%esp,%edx,4)
  203b7e:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
  203b83:	83 7c 24 18 03       	cmpl   $0x3,0x18(%esp)
  203b88:	76 cb                	jbe    203b55 <find_volume+0x40>
  203b8a:	83 7c 24 34 00       	cmpl   $0x0,0x34(%esp)
  203b8f:	0f 95 c0             	setne  %al
  203b92:	0f b6 c0             	movzbl %al,%eax
  203b95:	89 c2                	mov    %eax,%edx
  203b97:	8b 44 24 34          	mov    0x34(%esp),%eax
  203b9b:	29 d0                	sub    %edx,%eax
  203b9d:	89 44 24 18          	mov    %eax,0x18(%esp)
  203ba1:	8b 44 24 18          	mov    0x18(%esp),%eax
  203ba5:	8b 44 84 08          	mov    0x8(%esp,%eax,4),%eax
  203ba9:	85 c0                	test   %eax,%eax
  203bab:	74 1e                	je     203bcb <find_volume+0xb6>
  203bad:	8b 44 24 18          	mov    0x18(%esp),%eax
  203bb1:	8b 44 84 08          	mov    0x8(%esp,%eax,4),%eax
  203bb5:	83 ec 08             	sub    $0x8,%esp
  203bb8:	50                   	push   %eax
  203bb9:	ff 74 24 3c          	push   0x3c(%esp)
  203bbd:	e8 6b fd ff ff       	call   20392d <check_fs>
  203bc2:	83 c4 10             	add    $0x10,%esp
  203bc5:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  203bc9:	eb 08                	jmp    203bd3 <find_volume+0xbe>
  203bcb:	c7 44 24 1c 03 00 00 	movl   $0x3,0x1c(%esp)
  203bd2:	00 
  203bd3:	83 7c 24 34 00       	cmpl   $0x0,0x34(%esp)
  203bd8:	75 13                	jne    203bed <find_volume+0xd8>
  203bda:	83 7c 24 1c 01       	cmpl   $0x1,0x1c(%esp)
  203bdf:	76 0c                	jbe    203bed <find_volume+0xd8>
  203be1:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
  203be6:	83 7c 24 18 03       	cmpl   $0x3,0x18(%esp)
  203beb:	76 b4                	jbe    203ba1 <find_volume+0x8c>
  203bed:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  203bf1:	83 c4 2c             	add    $0x2c,%esp
  203bf4:	c3                   	ret

00203bf5 <mount_volume>:
  203bf5:	83 ec 4c             	sub    $0x4c,%esp
  203bf8:	8b 44 24 58          	mov    0x58(%esp),%eax
  203bfc:	88 44 24 0c          	mov    %al,0xc(%esp)
  203c00:	8b 44 24 54          	mov    0x54(%esp),%eax
  203c04:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  203c0a:	ff 74 24 50          	push   0x50(%esp)
  203c0e:	e8 68 fc ff ff       	call   20387b <get_ldnumber>
  203c13:	83 c4 04             	add    $0x4,%esp
  203c16:	89 44 24 2c          	mov    %eax,0x2c(%esp)
  203c1a:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
  203c1f:	79 0a                	jns    203c2b <mount_volume+0x36>
  203c21:	b8 0b 00 00 00       	mov    $0xb,%eax
  203c26:	e9 e6 05 00 00       	jmp    204211 <mount_volume+0x61c>
  203c2b:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  203c2f:	8b 04 85 60 ba 21 00 	mov    0x21ba60(,%eax,4),%eax
  203c36:	89 44 24 28          	mov    %eax,0x28(%esp)
  203c3a:	83 7c 24 28 00       	cmpl   $0x0,0x28(%esp)
  203c3f:	75 0a                	jne    203c4b <mount_volume+0x56>
  203c41:	b8 0c 00 00 00       	mov    $0xc,%eax
  203c46:	e9 c6 05 00 00       	jmp    204211 <mount_volume+0x61c>
  203c4b:	8b 44 24 54          	mov    0x54(%esp),%eax
  203c4f:	8b 54 24 28          	mov    0x28(%esp),%edx
  203c53:	89 10                	mov    %edx,(%eax)
  203c55:	80 64 24 0c fe       	andb   $0xfe,0xc(%esp)
  203c5a:	8b 44 24 28          	mov    0x28(%esp),%eax
  203c5e:	0f b6 00             	movzbl (%eax),%eax
  203c61:	84 c0                	test   %al,%al
  203c63:	74 4e                	je     203cb3 <mount_volume+0xbe>
  203c65:	8b 44 24 28          	mov    0x28(%esp),%eax
  203c69:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  203c6d:	0f b6 c0             	movzbl %al,%eax
  203c70:	83 ec 0c             	sub    $0xc,%esp
  203c73:	50                   	push   %eax
  203c74:	e8 9e c6 ff ff       	call   200317 <disk_status>
  203c79:	83 c4 10             	add    $0x10,%esp
  203c7c:	88 44 24 27          	mov    %al,0x27(%esp)
  203c80:	0f b6 44 24 27       	movzbl 0x27(%esp),%eax
  203c85:	83 e0 01             	and    $0x1,%eax
  203c88:	85 c0                	test   %eax,%eax
  203c8a:	75 27                	jne    203cb3 <mount_volume+0xbe>
  203c8c:	80 7c 24 0c 00       	cmpb   $0x0,0xc(%esp)
  203c91:	74 16                	je     203ca9 <mount_volume+0xb4>
  203c93:	0f b6 44 24 27       	movzbl 0x27(%esp),%eax
  203c98:	83 e0 04             	and    $0x4,%eax
  203c9b:	85 c0                	test   %eax,%eax
  203c9d:	74 0a                	je     203ca9 <mount_volume+0xb4>
  203c9f:	b8 0a 00 00 00       	mov    $0xa,%eax
  203ca4:	e9 68 05 00 00       	jmp    204211 <mount_volume+0x61c>
  203ca9:	b8 00 00 00 00       	mov    $0x0,%eax
  203cae:	e9 5e 05 00 00       	jmp    204211 <mount_volume+0x61c>
  203cb3:	8b 44 24 28          	mov    0x28(%esp),%eax
  203cb7:	c6 00 00             	movb   $0x0,(%eax)
  203cba:	8b 44 24 28          	mov    0x28(%esp),%eax
  203cbe:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  203cc2:	0f b6 c0             	movzbl %al,%eax
  203cc5:	83 ec 0c             	sub    $0xc,%esp
  203cc8:	50                   	push   %eax
  203cc9:	e8 69 c6 ff ff       	call   200337 <disk_initialize>
  203cce:	83 c4 10             	add    $0x10,%esp
  203cd1:	88 44 24 27          	mov    %al,0x27(%esp)
  203cd5:	0f b6 44 24 27       	movzbl 0x27(%esp),%eax
  203cda:	83 e0 01             	and    $0x1,%eax
  203cdd:	85 c0                	test   %eax,%eax
  203cdf:	74 0a                	je     203ceb <mount_volume+0xf6>
  203ce1:	b8 03 00 00 00       	mov    $0x3,%eax
  203ce6:	e9 26 05 00 00       	jmp    204211 <mount_volume+0x61c>
  203ceb:	80 7c 24 0c 00       	cmpb   $0x0,0xc(%esp)
  203cf0:	74 16                	je     203d08 <mount_volume+0x113>
  203cf2:	0f b6 44 24 27       	movzbl 0x27(%esp),%eax
  203cf7:	83 e0 04             	and    $0x4,%eax
  203cfa:	85 c0                	test   %eax,%eax
  203cfc:	74 0a                	je     203d08 <mount_volume+0x113>
  203cfe:	b8 0a 00 00 00       	mov    $0xa,%eax
  203d03:	e9 09 05 00 00       	jmp    204211 <mount_volume+0x61c>
  203d08:	83 ec 08             	sub    $0x8,%esp
  203d0b:	6a 00                	push   $0x0
  203d0d:	ff 74 24 34          	push   0x34(%esp)
  203d11:	e8 ff fd ff ff       	call   203b15 <find_volume>
  203d16:	83 c4 10             	add    $0x10,%esp
  203d19:	89 44 24 3c          	mov    %eax,0x3c(%esp)
  203d1d:	83 7c 24 3c 04       	cmpl   $0x4,0x3c(%esp)
  203d22:	75 0a                	jne    203d2e <mount_volume+0x139>
  203d24:	b8 01 00 00 00       	mov    $0x1,%eax
  203d29:	e9 e3 04 00 00       	jmp    204211 <mount_volume+0x61c>
  203d2e:	83 7c 24 3c 01       	cmpl   $0x1,0x3c(%esp)
  203d33:	76 0a                	jbe    203d3f <mount_volume+0x14a>
  203d35:	b8 0d 00 00 00       	mov    $0xd,%eax
  203d3a:	e9 d2 04 00 00       	jmp    204211 <mount_volume+0x61c>
  203d3f:	8b 44 24 28          	mov    0x28(%esp),%eax
  203d43:	8b 40 20             	mov    0x20(%eax),%eax
  203d46:	89 44 24 20          	mov    %eax,0x20(%esp)
  203d4a:	8b 44 24 28          	mov    0x28(%esp),%eax
  203d4e:	83 c0 34             	add    $0x34,%eax
  203d51:	83 c0 0b             	add    $0xb,%eax
  203d54:	83 ec 0c             	sub    $0xc,%esp
  203d57:	50                   	push   %eax
  203d58:	e8 a9 cf ff ff       	call   200d06 <ld_16>
  203d5d:	83 c4 10             	add    $0x10,%esp
  203d60:	66 3d 00 02          	cmp    $0x200,%ax
  203d64:	74 0a                	je     203d70 <mount_volume+0x17b>
  203d66:	b8 0d 00 00 00       	mov    $0xd,%eax
  203d6b:	e9 a1 04 00 00       	jmp    204211 <mount_volume+0x61c>
  203d70:	8b 44 24 28          	mov    0x28(%esp),%eax
  203d74:	83 c0 34             	add    $0x34,%eax
  203d77:	83 c0 16             	add    $0x16,%eax
  203d7a:	83 ec 0c             	sub    $0xc,%esp
  203d7d:	50                   	push   %eax
  203d7e:	e8 83 cf ff ff       	call   200d06 <ld_16>
  203d83:	83 c4 10             	add    $0x10,%esp
  203d86:	0f b7 c0             	movzwl %ax,%eax
  203d89:	89 44 24 34          	mov    %eax,0x34(%esp)
  203d8d:	83 7c 24 34 00       	cmpl   $0x0,0x34(%esp)
  203d92:	75 1a                	jne    203dae <mount_volume+0x1b9>
  203d94:	8b 44 24 28          	mov    0x28(%esp),%eax
  203d98:	83 c0 34             	add    $0x34,%eax
  203d9b:	83 c0 24             	add    $0x24,%eax
  203d9e:	83 ec 0c             	sub    $0xc,%esp
  203da1:	50                   	push   %eax
  203da2:	e8 98 cf ff ff       	call   200d3f <ld_32>
  203da7:	83 c4 10             	add    $0x10,%esp
  203daa:	89 44 24 34          	mov    %eax,0x34(%esp)
  203dae:	8b 44 24 28          	mov    0x28(%esp),%eax
  203db2:	8b 54 24 34          	mov    0x34(%esp),%edx
  203db6:	89 50 1c             	mov    %edx,0x1c(%eax)
  203db9:	8b 44 24 28          	mov    0x28(%esp),%eax
  203dbd:	0f b6 50 44          	movzbl 0x44(%eax),%edx
  203dc1:	8b 44 24 28          	mov    0x28(%esp),%eax
  203dc5:	88 50 03             	mov    %dl,0x3(%eax)
  203dc8:	8b 44 24 28          	mov    0x28(%esp),%eax
  203dcc:	0f b6 40 03          	movzbl 0x3(%eax),%eax
  203dd0:	3c 01                	cmp    $0x1,%al
  203dd2:	74 16                	je     203dea <mount_volume+0x1f5>
  203dd4:	8b 44 24 28          	mov    0x28(%esp),%eax
  203dd8:	0f b6 40 03          	movzbl 0x3(%eax),%eax
  203ddc:	3c 02                	cmp    $0x2,%al
  203dde:	74 0a                	je     203dea <mount_volume+0x1f5>
  203de0:	b8 0d 00 00 00       	mov    $0xd,%eax
  203de5:	e9 27 04 00 00       	jmp    204211 <mount_volume+0x61c>
  203dea:	8b 44 24 28          	mov    0x28(%esp),%eax
  203dee:	0f b6 40 03          	movzbl 0x3(%eax),%eax
  203df2:	0f b6 c0             	movzbl %al,%eax
  203df5:	8b 54 24 34          	mov    0x34(%esp),%edx
  203df9:	0f af c2             	imul   %edx,%eax
  203dfc:	89 44 24 34          	mov    %eax,0x34(%esp)
  203e00:	8b 44 24 28          	mov    0x28(%esp),%eax
  203e04:	0f b6 40 41          	movzbl 0x41(%eax),%eax
  203e08:	0f b6 d0             	movzbl %al,%edx
  203e0b:	8b 44 24 28          	mov    0x28(%esp),%eax
  203e0f:	66 89 50 0a          	mov    %dx,0xa(%eax)
  203e13:	8b 44 24 28          	mov    0x28(%esp),%eax
  203e17:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  203e1b:	66 85 c0             	test   %ax,%ax
  203e1e:	74 1f                	je     203e3f <mount_volume+0x24a>
  203e20:	8b 44 24 28          	mov    0x28(%esp),%eax
  203e24:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  203e28:	0f b7 d0             	movzwl %ax,%edx
  203e2b:	8b 44 24 28          	mov    0x28(%esp),%eax
  203e2f:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  203e33:	0f b7 c0             	movzwl %ax,%eax
  203e36:	83 e8 01             	sub    $0x1,%eax
  203e39:	21 d0                	and    %edx,%eax
  203e3b:	85 c0                	test   %eax,%eax
  203e3d:	74 0a                	je     203e49 <mount_volume+0x254>
  203e3f:	b8 0d 00 00 00       	mov    $0xd,%eax
  203e44:	e9 c8 03 00 00       	jmp    204211 <mount_volume+0x61c>
  203e49:	8b 44 24 28          	mov    0x28(%esp),%eax
  203e4d:	83 c0 34             	add    $0x34,%eax
  203e50:	83 c0 11             	add    $0x11,%eax
  203e53:	83 ec 0c             	sub    $0xc,%esp
  203e56:	50                   	push   %eax
  203e57:	e8 aa ce ff ff       	call   200d06 <ld_16>
  203e5c:	83 c4 10             	add    $0x10,%esp
  203e5f:	8b 54 24 28          	mov    0x28(%esp),%edx
  203e63:	66 89 42 08          	mov    %ax,0x8(%edx)
  203e67:	8b 44 24 28          	mov    0x28(%esp),%eax
  203e6b:	0f b7 40 08          	movzwl 0x8(%eax),%eax
  203e6f:	83 e0 0f             	and    $0xf,%eax
  203e72:	66 85 c0             	test   %ax,%ax
  203e75:	74 0a                	je     203e81 <mount_volume+0x28c>
  203e77:	b8 0d 00 00 00       	mov    $0xd,%eax
  203e7c:	e9 90 03 00 00       	jmp    204211 <mount_volume+0x61c>
  203e81:	8b 44 24 28          	mov    0x28(%esp),%eax
  203e85:	83 c0 34             	add    $0x34,%eax
  203e88:	83 c0 13             	add    $0x13,%eax
  203e8b:	83 ec 0c             	sub    $0xc,%esp
  203e8e:	50                   	push   %eax
  203e8f:	e8 72 ce ff ff       	call   200d06 <ld_16>
  203e94:	83 c4 10             	add    $0x10,%esp
  203e97:	0f b7 c0             	movzwl %ax,%eax
  203e9a:	89 44 24 38          	mov    %eax,0x38(%esp)
  203e9e:	83 7c 24 38 00       	cmpl   $0x0,0x38(%esp)
  203ea3:	75 1a                	jne    203ebf <mount_volume+0x2ca>
  203ea5:	8b 44 24 28          	mov    0x28(%esp),%eax
  203ea9:	83 c0 34             	add    $0x34,%eax
  203eac:	83 c0 20             	add    $0x20,%eax
  203eaf:	83 ec 0c             	sub    $0xc,%esp
  203eb2:	50                   	push   %eax
  203eb3:	e8 87 ce ff ff       	call   200d3f <ld_32>
  203eb8:	83 c4 10             	add    $0x10,%esp
  203ebb:	89 44 24 38          	mov    %eax,0x38(%esp)
  203ebf:	8b 44 24 28          	mov    0x28(%esp),%eax
  203ec3:	83 c0 34             	add    $0x34,%eax
  203ec6:	83 c0 0e             	add    $0xe,%eax
  203ec9:	83 ec 0c             	sub    $0xc,%esp
  203ecc:	50                   	push   %eax
  203ecd:	e8 34 ce ff ff       	call   200d06 <ld_16>
  203ed2:	83 c4 10             	add    $0x10,%esp
  203ed5:	66 89 44 24 1e       	mov    %ax,0x1e(%esp)
  203eda:	66 83 7c 24 1e 00    	cmpw   $0x0,0x1e(%esp)
  203ee0:	75 0a                	jne    203eec <mount_volume+0x2f7>
  203ee2:	b8 0d 00 00 00       	mov    $0xd,%eax
  203ee7:	e9 25 03 00 00       	jmp    204211 <mount_volume+0x61c>
  203eec:	0f b7 54 24 1e       	movzwl 0x1e(%esp),%edx
  203ef1:	8b 44 24 34          	mov    0x34(%esp),%eax
  203ef5:	01 c2                	add    %eax,%edx
  203ef7:	8b 44 24 28          	mov    0x28(%esp),%eax
  203efb:	0f b7 40 08          	movzwl 0x8(%eax),%eax
  203eff:	66 c1 e8 04          	shr    $0x4,%ax
  203f03:	0f b7 c0             	movzwl %ax,%eax
  203f06:	01 d0                	add    %edx,%eax
  203f08:	89 44 24 18          	mov    %eax,0x18(%esp)
  203f0c:	8b 44 24 38          	mov    0x38(%esp),%eax
  203f10:	3b 44 24 18          	cmp    0x18(%esp),%eax
  203f14:	73 0a                	jae    203f20 <mount_volume+0x32b>
  203f16:	b8 0d 00 00 00       	mov    $0xd,%eax
  203f1b:	e9 f1 02 00 00       	jmp    204211 <mount_volume+0x61c>
  203f20:	8b 44 24 38          	mov    0x38(%esp),%eax
  203f24:	2b 44 24 18          	sub    0x18(%esp),%eax
  203f28:	8b 54 24 28          	mov    0x28(%esp),%edx
  203f2c:	0f b7 52 0a          	movzwl 0xa(%edx),%edx
  203f30:	0f b7 ca             	movzwl %dx,%ecx
  203f33:	ba 00 00 00 00       	mov    $0x0,%edx
  203f38:	f7 f1                	div    %ecx
  203f3a:	89 44 24 14          	mov    %eax,0x14(%esp)
  203f3e:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  203f43:	75 0a                	jne    203f4f <mount_volume+0x35a>
  203f45:	b8 0d 00 00 00       	mov    $0xd,%eax
  203f4a:	e9 c2 02 00 00       	jmp    204211 <mount_volume+0x61c>
  203f4f:	c7 44 24 3c 00 00 00 	movl   $0x0,0x3c(%esp)
  203f56:	00 
  203f57:	81 7c 24 14 f5 ff ff 	cmpl   $0xffffff5,0x14(%esp)
  203f5e:	0f 
  203f5f:	77 08                	ja     203f69 <mount_volume+0x374>
  203f61:	c7 44 24 3c 03 00 00 	movl   $0x3,0x3c(%esp)
  203f68:	00 
  203f69:	81 7c 24 14 f5 ff 00 	cmpl   $0xfff5,0x14(%esp)
  203f70:	00 
  203f71:	77 08                	ja     203f7b <mount_volume+0x386>
  203f73:	c7 44 24 3c 02 00 00 	movl   $0x2,0x3c(%esp)
  203f7a:	00 
  203f7b:	81 7c 24 14 f5 0f 00 	cmpl   $0xff5,0x14(%esp)
  203f82:	00 
  203f83:	77 08                	ja     203f8d <mount_volume+0x398>
  203f85:	c7 44 24 3c 01 00 00 	movl   $0x1,0x3c(%esp)
  203f8c:	00 
  203f8d:	83 7c 24 3c 00       	cmpl   $0x0,0x3c(%esp)
  203f92:	75 0a                	jne    203f9e <mount_volume+0x3a9>
  203f94:	b8 0d 00 00 00       	mov    $0xd,%eax
  203f99:	e9 73 02 00 00       	jmp    204211 <mount_volume+0x61c>
  203f9e:	8b 44 24 14          	mov    0x14(%esp),%eax
  203fa2:	8d 50 02             	lea    0x2(%eax),%edx
  203fa5:	8b 44 24 28          	mov    0x28(%esp),%eax
  203fa9:	89 50 18             	mov    %edx,0x18(%eax)
  203fac:	8b 44 24 28          	mov    0x28(%esp),%eax
  203fb0:	8b 54 24 20          	mov    0x20(%esp),%edx
  203fb4:	89 50 24             	mov    %edx,0x24(%eax)
  203fb7:	0f b7 54 24 1e       	movzwl 0x1e(%esp),%edx
  203fbc:	8b 44 24 20          	mov    0x20(%esp),%eax
  203fc0:	01 c2                	add    %eax,%edx
  203fc2:	8b 44 24 28          	mov    0x28(%esp),%eax
  203fc6:	89 50 28             	mov    %edx,0x28(%eax)
  203fc9:	8b 54 24 20          	mov    0x20(%esp),%edx
  203fcd:	8b 44 24 18          	mov    0x18(%esp),%eax
  203fd1:	01 c2                	add    %eax,%edx
  203fd3:	8b 44 24 28          	mov    0x28(%esp),%eax
  203fd7:	89 50 30             	mov    %edx,0x30(%eax)
  203fda:	83 7c 24 3c 03       	cmpl   $0x3,0x3c(%esp)
  203fdf:	75 69                	jne    20404a <mount_volume+0x455>
  203fe1:	8b 44 24 28          	mov    0x28(%esp),%eax
  203fe5:	83 c0 34             	add    $0x34,%eax
  203fe8:	83 c0 2a             	add    $0x2a,%eax
  203feb:	83 ec 0c             	sub    $0xc,%esp
  203fee:	50                   	push   %eax
  203fef:	e8 12 cd ff ff       	call   200d06 <ld_16>
  203ff4:	83 c4 10             	add    $0x10,%esp
  203ff7:	66 85 c0             	test   %ax,%ax
  203ffa:	74 0a                	je     204006 <mount_volume+0x411>
  203ffc:	b8 0d 00 00 00       	mov    $0xd,%eax
  204001:	e9 0b 02 00 00       	jmp    204211 <mount_volume+0x61c>
  204006:	8b 44 24 28          	mov    0x28(%esp),%eax
  20400a:	0f b7 40 08          	movzwl 0x8(%eax),%eax
  20400e:	66 85 c0             	test   %ax,%ax
  204011:	74 0a                	je     20401d <mount_volume+0x428>
  204013:	b8 0d 00 00 00       	mov    $0xd,%eax
  204018:	e9 f4 01 00 00       	jmp    204211 <mount_volume+0x61c>
  20401d:	8b 44 24 28          	mov    0x28(%esp),%eax
  204021:	83 c0 34             	add    $0x34,%eax
  204024:	83 c0 2c             	add    $0x2c,%eax
  204027:	83 ec 0c             	sub    $0xc,%esp
  20402a:	50                   	push   %eax
  20402b:	e8 0f cd ff ff       	call   200d3f <ld_32>
  204030:	83 c4 10             	add    $0x10,%esp
  204033:	8b 54 24 28          	mov    0x28(%esp),%edx
  204037:	89 42 2c             	mov    %eax,0x2c(%edx)
  20403a:	8b 44 24 28          	mov    0x28(%esp),%eax
  20403e:	8b 40 18             	mov    0x18(%eax),%eax
  204041:	c1 e0 02             	shl    $0x2,%eax
  204044:	89 44 24 30          	mov    %eax,0x30(%esp)
  204048:	eb 62                	jmp    2040ac <mount_volume+0x4b7>
  20404a:	8b 44 24 28          	mov    0x28(%esp),%eax
  20404e:	0f b7 40 08          	movzwl 0x8(%eax),%eax
  204052:	66 85 c0             	test   %ax,%ax
  204055:	75 0a                	jne    204061 <mount_volume+0x46c>
  204057:	b8 0d 00 00 00       	mov    $0xd,%eax
  20405c:	e9 b0 01 00 00       	jmp    204211 <mount_volume+0x61c>
  204061:	8b 44 24 28          	mov    0x28(%esp),%eax
  204065:	8b 50 28             	mov    0x28(%eax),%edx
  204068:	8b 44 24 34          	mov    0x34(%esp),%eax
  20406c:	01 c2                	add    %eax,%edx
  20406e:	8b 44 24 28          	mov    0x28(%esp),%eax
  204072:	89 50 2c             	mov    %edx,0x2c(%eax)
  204075:	83 7c 24 3c 02       	cmpl   $0x2,0x3c(%esp)
  20407a:	75 0f                	jne    20408b <mount_volume+0x496>
  20407c:	8b 44 24 28          	mov    0x28(%esp),%eax
  204080:	8b 40 18             	mov    0x18(%eax),%eax
  204083:	01 c0                	add    %eax,%eax
  204085:	89 44 24 30          	mov    %eax,0x30(%esp)
  204089:	eb 21                	jmp    2040ac <mount_volume+0x4b7>
  20408b:	8b 44 24 28          	mov    0x28(%esp),%eax
  20408f:	8b 50 18             	mov    0x18(%eax),%edx
  204092:	89 d0                	mov    %edx,%eax
  204094:	01 c0                	add    %eax,%eax
  204096:	01 d0                	add    %edx,%eax
  204098:	d1 e8                	shr    $1,%eax
  20409a:	89 c2                	mov    %eax,%edx
  20409c:	8b 44 24 28          	mov    0x28(%esp),%eax
  2040a0:	8b 40 18             	mov    0x18(%eax),%eax
  2040a3:	83 e0 01             	and    $0x1,%eax
  2040a6:	01 d0                	add    %edx,%eax
  2040a8:	89 44 24 30          	mov    %eax,0x30(%esp)
  2040ac:	8b 44 24 28          	mov    0x28(%esp),%eax
  2040b0:	8b 50 1c             	mov    0x1c(%eax),%edx
  2040b3:	8b 44 24 30          	mov    0x30(%esp),%eax
  2040b7:	05 ff 01 00 00       	add    $0x1ff,%eax
  2040bc:	c1 e8 09             	shr    $0x9,%eax
  2040bf:	39 c2                	cmp    %eax,%edx
  2040c1:	73 0a                	jae    2040cd <mount_volume+0x4d8>
  2040c3:	b8 0d 00 00 00       	mov    $0xd,%eax
  2040c8:	e9 44 01 00 00       	jmp    204211 <mount_volume+0x61c>
  2040cd:	8b 44 24 28          	mov    0x28(%esp),%eax
  2040d1:	c7 40 14 ff ff ff ff 	movl   $0xffffffff,0x14(%eax)
  2040d8:	8b 44 24 28          	mov    0x28(%esp),%eax
  2040dc:	8b 50 14             	mov    0x14(%eax),%edx
  2040df:	8b 44 24 28          	mov    0x28(%esp),%eax
  2040e3:	89 50 10             	mov    %edx,0x10(%eax)
  2040e6:	8b 44 24 28          	mov    0x28(%esp),%eax
  2040ea:	c6 40 05 80          	movb   $0x80,0x5(%eax)
  2040ee:	83 7c 24 3c 03       	cmpl   $0x3,0x3c(%esp)
  2040f3:	0f 85 dd 00 00 00    	jne    2041d6 <mount_volume+0x5e1>
  2040f9:	8b 44 24 28          	mov    0x28(%esp),%eax
  2040fd:	83 c0 34             	add    $0x34,%eax
  204100:	83 c0 30             	add    $0x30,%eax
  204103:	83 ec 0c             	sub    $0xc,%esp
  204106:	50                   	push   %eax
  204107:	e8 fa cb ff ff       	call   200d06 <ld_16>
  20410c:	83 c4 10             	add    $0x10,%esp
  20410f:	66 83 f8 01          	cmp    $0x1,%ax
  204113:	0f 85 bd 00 00 00    	jne    2041d6 <mount_volume+0x5e1>
  204119:	8b 44 24 20          	mov    0x20(%esp),%eax
  20411d:	83 c0 01             	add    $0x1,%eax
  204120:	83 ec 08             	sub    $0x8,%esp
  204123:	50                   	push   %eax
  204124:	ff 74 24 34          	push   0x34(%esp)
  204128:	e8 5f d1 ff ff       	call   20128c <move_window>
  20412d:	83 c4 10             	add    $0x10,%esp
  204130:	85 c0                	test   %eax,%eax
  204132:	0f 85 9e 00 00 00    	jne    2041d6 <mount_volume+0x5e1>
  204138:	8b 44 24 28          	mov    0x28(%esp),%eax
  20413c:	c6 40 05 00          	movb   $0x0,0x5(%eax)
  204140:	8b 44 24 28          	mov    0x28(%esp),%eax
  204144:	83 c0 34             	add    $0x34,%eax
  204147:	83 ec 0c             	sub    $0xc,%esp
  20414a:	50                   	push   %eax
  20414b:	e8 ef cb ff ff       	call   200d3f <ld_32>
  204150:	83 c4 10             	add    $0x10,%esp
  204153:	3d 52 52 61 41       	cmp    $0x41615252,%eax
  204158:	75 7c                	jne    2041d6 <mount_volume+0x5e1>
  20415a:	8b 44 24 28          	mov    0x28(%esp),%eax
  20415e:	83 c0 34             	add    $0x34,%eax
  204161:	05 e4 01 00 00       	add    $0x1e4,%eax
  204166:	83 ec 0c             	sub    $0xc,%esp
  204169:	50                   	push   %eax
  20416a:	e8 d0 cb ff ff       	call   200d3f <ld_32>
  20416f:	83 c4 10             	add    $0x10,%esp
  204172:	3d 72 72 41 61       	cmp    $0x61417272,%eax
  204177:	75 5d                	jne    2041d6 <mount_volume+0x5e1>
  204179:	8b 44 24 28          	mov    0x28(%esp),%eax
  20417d:	83 c0 34             	add    $0x34,%eax
  204180:	05 fc 01 00 00       	add    $0x1fc,%eax
  204185:	83 ec 0c             	sub    $0xc,%esp
  204188:	50                   	push   %eax
  204189:	e8 b1 cb ff ff       	call   200d3f <ld_32>
  20418e:	83 c4 10             	add    $0x10,%esp
  204191:	3d 00 00 55 aa       	cmp    $0xaa550000,%eax
  204196:	75 3e                	jne    2041d6 <mount_volume+0x5e1>
  204198:	8b 44 24 28          	mov    0x28(%esp),%eax
  20419c:	83 c0 34             	add    $0x34,%eax
  20419f:	05 e8 01 00 00       	add    $0x1e8,%eax
  2041a4:	83 ec 0c             	sub    $0xc,%esp
  2041a7:	50                   	push   %eax
  2041a8:	e8 92 cb ff ff       	call   200d3f <ld_32>
  2041ad:	83 c4 10             	add    $0x10,%esp
  2041b0:	8b 54 24 28          	mov    0x28(%esp),%edx
  2041b4:	89 42 14             	mov    %eax,0x14(%edx)
  2041b7:	8b 44 24 28          	mov    0x28(%esp),%eax
  2041bb:	83 c0 34             	add    $0x34,%eax
  2041be:	05 ec 01 00 00       	add    $0x1ec,%eax
  2041c3:	83 ec 0c             	sub    $0xc,%esp
  2041c6:	50                   	push   %eax
  2041c7:	e8 73 cb ff ff       	call   200d3f <ld_32>
  2041cc:	83 c4 10             	add    $0x10,%esp
  2041cf:	8b 54 24 28          	mov    0x28(%esp),%edx
  2041d3:	89 42 10             	mov    %eax,0x10(%edx)
  2041d6:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  2041da:	89 c2                	mov    %eax,%edx
  2041dc:	8b 44 24 28          	mov    0x28(%esp),%eax
  2041e0:	88 10                	mov    %dl,(%eax)
  2041e2:	0f b7 05 64 ba 21 00 	movzwl 0x21ba64,%eax
  2041e9:	83 c0 01             	add    $0x1,%eax
  2041ec:	66 a3 64 ba 21 00    	mov    %ax,0x21ba64
  2041f2:	0f b7 15 64 ba 21 00 	movzwl 0x21ba64,%edx
  2041f9:	8b 44 24 28          	mov    0x28(%esp),%eax
  2041fd:	66 89 50 06          	mov    %dx,0x6(%eax)
  204201:	8b 44 24 28          	mov    0x28(%esp),%eax
  204205:	c7 40 0c 80 ba 21 00 	movl   $0x21ba80,0xc(%eax)
  20420c:	b8 00 00 00 00       	mov    $0x0,%eax
  204211:	83 c4 4c             	add    $0x4c,%esp
  204214:	c3                   	ret

00204215 <validate>:
  204215:	83 ec 1c             	sub    $0x1c,%esp
  204218:	c7 44 24 0c 09 00 00 	movl   $0x9,0xc(%esp)
  20421f:	00 
  204220:	83 7c 24 20 00       	cmpl   $0x0,0x20(%esp)
  204225:	74 59                	je     204280 <validate+0x6b>
  204227:	8b 44 24 20          	mov    0x20(%esp),%eax
  20422b:	8b 00                	mov    (%eax),%eax
  20422d:	85 c0                	test   %eax,%eax
  20422f:	74 4f                	je     204280 <validate+0x6b>
  204231:	8b 44 24 20          	mov    0x20(%esp),%eax
  204235:	8b 00                	mov    (%eax),%eax
  204237:	0f b6 00             	movzbl (%eax),%eax
  20423a:	84 c0                	test   %al,%al
  20423c:	74 42                	je     204280 <validate+0x6b>
  20423e:	8b 44 24 20          	mov    0x20(%esp),%eax
  204242:	0f b7 50 04          	movzwl 0x4(%eax),%edx
  204246:	8b 44 24 20          	mov    0x20(%esp),%eax
  20424a:	8b 00                	mov    (%eax),%eax
  20424c:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  204250:	66 39 c2             	cmp    %ax,%dx
  204253:	75 2b                	jne    204280 <validate+0x6b>
  204255:	8b 44 24 20          	mov    0x20(%esp),%eax
  204259:	8b 00                	mov    (%eax),%eax
  20425b:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  20425f:	0f b6 c0             	movzbl %al,%eax
  204262:	83 ec 0c             	sub    $0xc,%esp
  204265:	50                   	push   %eax
  204266:	e8 ac c0 ff ff       	call   200317 <disk_status>
  20426b:	83 c4 10             	add    $0x10,%esp
  20426e:	0f b6 c0             	movzbl %al,%eax
  204271:	83 e0 01             	and    $0x1,%eax
  204274:	85 c0                	test   %eax,%eax
  204276:	75 08                	jne    204280 <validate+0x6b>
  204278:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  20427f:	00 
  204280:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  204285:	75 08                	jne    20428f <validate+0x7a>
  204287:	8b 44 24 20          	mov    0x20(%esp),%eax
  20428b:	8b 00                	mov    (%eax),%eax
  20428d:	eb 05                	jmp    204294 <validate+0x7f>
  20428f:	b8 00 00 00 00       	mov    $0x0,%eax
  204294:	8b 54 24 24          	mov    0x24(%esp),%edx
  204298:	89 02                	mov    %eax,(%edx)
  20429a:	8b 44 24 0c          	mov    0xc(%esp),%eax
  20429e:	83 c4 1c             	add    $0x1c,%esp
  2042a1:	c3                   	ret

002042a2 <f_mount>:
  2042a2:	83 ec 2c             	sub    $0x2c,%esp
  2042a5:	8b 44 24 38          	mov    0x38(%esp),%eax
  2042a9:	88 44 24 0c          	mov    %al,0xc(%esp)
  2042ad:	8b 44 24 34          	mov    0x34(%esp),%eax
  2042b1:	89 44 24 10          	mov    %eax,0x10(%esp)
  2042b5:	8d 44 24 10          	lea    0x10(%esp),%eax
  2042b9:	50                   	push   %eax
  2042ba:	e8 bc f5 ff ff       	call   20387b <get_ldnumber>
  2042bf:	83 c4 04             	add    $0x4,%esp
  2042c2:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  2042c6:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  2042cb:	79 0a                	jns    2042d7 <f_mount+0x35>
  2042cd:	b8 0b 00 00 00       	mov    $0xb,%eax
  2042d2:	e9 82 00 00 00       	jmp    204359 <f_mount+0xb7>
  2042d7:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2042db:	8b 04 85 60 ba 21 00 	mov    0x21ba60(,%eax,4),%eax
  2042e2:	89 44 24 18          	mov    %eax,0x18(%esp)
  2042e6:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  2042eb:	74 16                	je     204303 <f_mount+0x61>
  2042ed:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2042f1:	c7 04 85 60 ba 21 00 	movl   $0x0,0x21ba60(,%eax,4)
  2042f8:	00 00 00 00 
  2042fc:	8b 44 24 18          	mov    0x18(%esp),%eax
  204300:	c6 00 00             	movb   $0x0,(%eax)
  204303:	8b 44 24 30          	mov    0x30(%esp),%eax
  204307:	85 c0                	test   %eax,%eax
  204309:	74 21                	je     20432c <f_mount+0x8a>
  20430b:	8b 44 24 30          	mov    0x30(%esp),%eax
  20430f:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  204313:	88 50 01             	mov    %dl,0x1(%eax)
  204316:	8b 44 24 30          	mov    0x30(%esp),%eax
  20431a:	c6 00 00             	movb   $0x0,(%eax)
  20431d:	8b 54 24 30          	mov    0x30(%esp),%edx
  204321:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  204325:	89 14 85 60 ba 21 00 	mov    %edx,0x21ba60(,%eax,4)
  20432c:	80 7c 24 0c 00       	cmpb   $0x0,0xc(%esp)
  204331:	75 07                	jne    20433a <f_mount+0x98>
  204333:	b8 00 00 00 00       	mov    $0x0,%eax
  204338:	eb 1f                	jmp    204359 <f_mount+0xb7>
  20433a:	83 ec 04             	sub    $0x4,%esp
  20433d:	6a 00                	push   $0x0
  20433f:	8d 44 24 38          	lea    0x38(%esp),%eax
  204343:	50                   	push   %eax
  204344:	8d 44 24 40          	lea    0x40(%esp),%eax
  204348:	50                   	push   %eax
  204349:	e8 a7 f8 ff ff       	call   203bf5 <mount_volume>
  20434e:	83 c4 10             	add    $0x10,%esp
  204351:	89 44 24 14          	mov    %eax,0x14(%esp)
  204355:	8b 44 24 14          	mov    0x14(%esp),%eax
  204359:	83 c4 2c             	add    $0x2c,%esp
  20435c:	c3                   	ret

0020435d <f_open>:
  20435d:	83 ec 7c             	sub    $0x7c,%esp
  204360:	8b 84 24 88 00 00 00 	mov    0x88(%esp),%eax
  204367:	88 44 24 0c          	mov    %al,0xc(%esp)
  20436b:	83 bc 24 80 00 00 00 	cmpl   $0x0,0x80(%esp)
  204372:	00 
  204373:	75 0a                	jne    20437f <f_open+0x22>
  204375:	b8 09 00 00 00       	mov    $0x9,%eax
  20437a:	e9 26 04 00 00       	jmp    2047a5 <f_open+0x448>
  20437f:	80 64 24 0c 3f       	andb   $0x3f,0xc(%esp)
  204384:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
  204389:	83 ec 04             	sub    $0x4,%esp
  20438c:	50                   	push   %eax
  20438d:	8d 44 24 24          	lea    0x24(%esp),%eax
  204391:	50                   	push   %eax
  204392:	8d 84 24 90 00 00 00 	lea    0x90(%esp),%eax
  204399:	50                   	push   %eax
  20439a:	e8 56 f8 ff ff       	call   203bf5 <mount_volume>
  20439f:	83 c4 10             	add    $0x10,%esp
  2043a2:	89 44 24 6c          	mov    %eax,0x6c(%esp)
  2043a6:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  2043ab:	0f 85 dc 03 00 00    	jne    20478d <f_open+0x430>
  2043b1:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  2043b5:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  2043bc:	89 10                	mov    %edx,(%eax)
  2043be:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2043c2:	89 44 24 20          	mov    %eax,0x20(%esp)
  2043c6:	8b 84 24 84 00 00 00 	mov    0x84(%esp),%eax
  2043cd:	83 ec 08             	sub    $0x8,%esp
  2043d0:	50                   	push   %eax
  2043d1:	8d 44 24 2c          	lea    0x2c(%esp),%eax
  2043d5:	50                   	push   %eax
  2043d6:	e8 6a f3 ff ff       	call   203745 <follow_path>
  2043db:	83 c4 10             	add    $0x10,%esp
  2043de:	89 44 24 6c          	mov    %eax,0x6c(%esp)
  2043e2:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  2043e7:	75 11                	jne    2043fa <f_open+0x9d>
  2043e9:	0f b6 44 24 4b       	movzbl 0x4b(%esp),%eax
  2043ee:	84 c0                	test   %al,%al
  2043f0:	79 08                	jns    2043fa <f_open+0x9d>
  2043f2:	c7 44 24 6c 06 00 00 	movl   $0x6,0x6c(%esp)
  2043f9:	00 
  2043fa:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
  2043ff:	83 e0 1c             	and    $0x1c,%eax
  204402:	85 c0                	test   %eax,%eax
  204404:	0f 84 5d 01 00 00    	je     204567 <f_open+0x20a>
  20440a:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  20440f:	74 22                	je     204433 <f_open+0xd6>
  204411:	83 7c 24 6c 04       	cmpl   $0x4,0x6c(%esp)
  204416:	75 14                	jne    20442c <f_open+0xcf>
  204418:	83 ec 0c             	sub    $0xc,%esp
  20441b:	8d 44 24 2c          	lea    0x2c(%esp),%eax
  20441f:	50                   	push   %eax
  204420:	e8 1a e7 ff ff       	call   202b3f <dir_register>
  204425:	83 c4 10             	add    $0x10,%esp
  204428:	89 44 24 6c          	mov    %eax,0x6c(%esp)
  20442c:	80 4c 24 0c 08       	orb    $0x8,0xc(%esp)
  204431:	eb 2d                	jmp    204460 <f_open+0x103>
  204433:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
  204438:	83 e0 04             	and    $0x4,%eax
  20443b:	85 c0                	test   %eax,%eax
  20443d:	74 0a                	je     204449 <f_open+0xec>
  20443f:	c7 44 24 6c 08 00 00 	movl   $0x8,0x6c(%esp)
  204446:	00 
  204447:	eb 17                	jmp    204460 <f_open+0x103>
  204449:	0f b6 44 24 26       	movzbl 0x26(%esp),%eax
  20444e:	0f b6 c0             	movzbl %al,%eax
  204451:	83 e0 11             	and    $0x11,%eax
  204454:	85 c0                	test   %eax,%eax
  204456:	74 08                	je     204460 <f_open+0x103>
  204458:	c7 44 24 6c 07 00 00 	movl   $0x7,0x6c(%esp)
  20445f:	00 
  204460:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  204465:	0f 85 3f 01 00 00    	jne    2045aa <f_open+0x24d>
  20446b:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
  204470:	83 e0 08             	and    $0x8,%eax
  204473:	85 c0                	test   %eax,%eax
  204475:	0f 84 2f 01 00 00    	je     2045aa <f_open+0x24d>
  20447b:	c7 44 24 60 00 00 21 	movl   $0x5a210000,0x60(%esp)
  204482:	5a 
  204483:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  204487:	83 c0 0e             	add    $0xe,%eax
  20448a:	83 ec 08             	sub    $0x8,%esp
  20448d:	ff 74 24 68          	push   0x68(%esp)
  204491:	50                   	push   %eax
  204492:	e8 4c c9 ff ff       	call   200de3 <st_32>
  204497:	83 c4 10             	add    $0x10,%esp
  20449a:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  20449e:	83 c0 16             	add    $0x16,%eax
  2044a1:	83 ec 08             	sub    $0x8,%esp
  2044a4:	ff 74 24 68          	push   0x68(%esp)
  2044a8:	50                   	push   %eax
  2044a9:	e8 35 c9 ff ff       	call   200de3 <st_32>
  2044ae:	83 c4 10             	add    $0x10,%esp
  2044b1:	8b 54 24 3c          	mov    0x3c(%esp),%edx
  2044b5:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2044b9:	83 ec 08             	sub    $0x8,%esp
  2044bc:	52                   	push   %edx
  2044bd:	50                   	push   %eax
  2044be:	e8 e3 dc ff ff       	call   2021a6 <ld_clust>
  2044c3:	83 c4 10             	add    $0x10,%esp
  2044c6:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  2044ca:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  2044ce:	83 c0 0b             	add    $0xb,%eax
  2044d1:	c6 00 20             	movb   $0x20,(%eax)
  2044d4:	8b 54 24 3c          	mov    0x3c(%esp),%edx
  2044d8:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2044dc:	83 ec 04             	sub    $0x4,%esp
  2044df:	6a 00                	push   $0x0
  2044e1:	52                   	push   %edx
  2044e2:	50                   	push   %eax
  2044e3:	e8 05 dd ff ff       	call   2021ed <st_clust>
  2044e8:	83 c4 10             	add    $0x10,%esp
  2044eb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  2044ef:	83 c0 1c             	add    $0x1c,%eax
  2044f2:	83 ec 08             	sub    $0x8,%esp
  2044f5:	6a 00                	push   $0x0
  2044f7:	50                   	push   %eax
  2044f8:	e8 e6 c8 ff ff       	call   200de3 <st_32>
  2044fd:	83 c4 10             	add    $0x10,%esp
  204500:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  204504:	c6 40 04 01          	movb   $0x1,0x4(%eax)
  204508:	83 7c 24 5c 00       	cmpl   $0x0,0x5c(%esp)
  20450d:	0f 84 97 00 00 00    	je     2045aa <f_open+0x24d>
  204513:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  204517:	8b 40 20             	mov    0x20(%eax),%eax
  20451a:	89 44 24 58          	mov    %eax,0x58(%esp)
  20451e:	83 ec 04             	sub    $0x4,%esp
  204521:	6a 00                	push   $0x0
  204523:	ff 74 24 64          	push   0x64(%esp)
  204527:	8d 44 24 2c          	lea    0x2c(%esp),%eax
  20452b:	50                   	push   %eax
  20452c:	e8 d2 d3 ff ff       	call   201903 <remove_chain>
  204531:	83 c4 10             	add    $0x10,%esp
  204534:	89 44 24 6c          	mov    %eax,0x6c(%esp)
  204538:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  20453d:	75 6b                	jne    2045aa <f_open+0x24d>
  20453f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  204543:	83 ec 08             	sub    $0x8,%esp
  204546:	ff 74 24 60          	push   0x60(%esp)
  20454a:	50                   	push   %eax
  20454b:	e8 3c cd ff ff       	call   20128c <move_window>
  204550:	83 c4 10             	add    $0x10,%esp
  204553:	89 44 24 6c          	mov    %eax,0x6c(%esp)
  204557:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  20455b:	8b 54 24 5c          	mov    0x5c(%esp),%edx
  20455f:	83 ea 01             	sub    $0x1,%edx
  204562:	89 50 10             	mov    %edx,0x10(%eax)
  204565:	eb 43                	jmp    2045aa <f_open+0x24d>
  204567:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  20456c:	75 3c                	jne    2045aa <f_open+0x24d>
  20456e:	0f b6 44 24 26       	movzbl 0x26(%esp),%eax
  204573:	0f b6 c0             	movzbl %al,%eax
  204576:	83 e0 10             	and    $0x10,%eax
  204579:	85 c0                	test   %eax,%eax
  20457b:	74 0a                	je     204587 <f_open+0x22a>
  20457d:	c7 44 24 6c 04 00 00 	movl   $0x4,0x6c(%esp)
  204584:	00 
  204585:	eb 23                	jmp    2045aa <f_open+0x24d>
  204587:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
  20458c:	83 e0 02             	and    $0x2,%eax
  20458f:	85 c0                	test   %eax,%eax
  204591:	74 17                	je     2045aa <f_open+0x24d>
  204593:	0f b6 44 24 26       	movzbl 0x26(%esp),%eax
  204598:	0f b6 c0             	movzbl %al,%eax
  20459b:	83 e0 01             	and    $0x1,%eax
  20459e:	85 c0                	test   %eax,%eax
  2045a0:	74 08                	je     2045aa <f_open+0x24d>
  2045a2:	c7 44 24 6c 07 00 00 	movl   $0x7,0x6c(%esp)
  2045a9:	00 
  2045aa:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  2045af:	75 30                	jne    2045e1 <f_open+0x284>
  2045b1:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
  2045b6:	83 e0 08             	and    $0x8,%eax
  2045b9:	85 c0                	test   %eax,%eax
  2045bb:	74 05                	je     2045c2 <f_open+0x265>
  2045bd:	80 4c 24 0c 40       	orb    $0x40,0xc(%esp)
  2045c2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2045c6:	8b 50 20             	mov    0x20(%eax),%edx
  2045c9:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  2045d0:	89 50 20             	mov    %edx,0x20(%eax)
  2045d3:	8b 54 24 3c          	mov    0x3c(%esp),%edx
  2045d7:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  2045de:	89 50 24             	mov    %edx,0x24(%eax)
  2045e1:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  2045e6:	0f 85 a1 01 00 00    	jne    20478d <f_open+0x430>
  2045ec:	8b 54 24 3c          	mov    0x3c(%esp),%edx
  2045f0:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2045f4:	83 ec 08             	sub    $0x8,%esp
  2045f7:	52                   	push   %edx
  2045f8:	50                   	push   %eax
  2045f9:	e8 a8 db ff ff       	call   2021a6 <ld_clust>
  2045fe:	83 c4 10             	add    $0x10,%esp
  204601:	8b 94 24 80 00 00 00 	mov    0x80(%esp),%edx
  204608:	89 42 08             	mov    %eax,0x8(%edx)
  20460b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  20460f:	83 c0 1c             	add    $0x1c,%eax
  204612:	83 ec 0c             	sub    $0xc,%esp
  204615:	50                   	push   %eax
  204616:	e8 24 c7 ff ff       	call   200d3f <ld_32>
  20461b:	83 c4 10             	add    $0x10,%esp
  20461e:	8b 94 24 80 00 00 00 	mov    0x80(%esp),%edx
  204625:	89 42 0c             	mov    %eax,0xc(%edx)
  204628:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  20462c:	0f b7 50 06          	movzwl 0x6(%eax),%edx
  204630:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  204637:	66 89 50 04          	mov    %dx,0x4(%eax)
  20463b:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  204642:	0f b6 54 24 0c       	movzbl 0xc(%esp),%edx
  204647:	88 50 10             	mov    %dl,0x10(%eax)
  20464a:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  204651:	c6 40 11 00          	movb   $0x0,0x11(%eax)
  204655:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  20465c:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  204663:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  20466a:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  204671:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
  204676:	83 e0 20             	and    $0x20,%eax
  204679:	85 c0                	test   %eax,%eax
  20467b:	0f 84 0c 01 00 00    	je     20478d <f_open+0x430>
  204681:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  204688:	8b 40 0c             	mov    0xc(%eax),%eax
  20468b:	85 c0                	test   %eax,%eax
  20468d:	0f 84 fa 00 00 00    	je     20478d <f_open+0x430>
  204693:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  20469a:	8b 50 0c             	mov    0xc(%eax),%edx
  20469d:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  2046a4:	89 50 14             	mov    %edx,0x14(%eax)
  2046a7:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2046ab:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  2046af:	0f b7 c0             	movzwl %ax,%eax
  2046b2:	c1 e0 09             	shl    $0x9,%eax
  2046b5:	89 44 24 54          	mov    %eax,0x54(%esp)
  2046b9:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  2046c0:	8b 40 08             	mov    0x8(%eax),%eax
  2046c3:	89 44 24 68          	mov    %eax,0x68(%esp)
  2046c7:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  2046ce:	8b 40 0c             	mov    0xc(%eax),%eax
  2046d1:	89 44 24 64          	mov    %eax,0x64(%esp)
  2046d5:	eb 41                	jmp    204718 <f_open+0x3bb>
  2046d7:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  2046de:	83 ec 08             	sub    $0x8,%esp
  2046e1:	ff 74 24 70          	push   0x70(%esp)
  2046e5:	50                   	push   %eax
  2046e6:	e8 ad cd ff ff       	call   201498 <get_fat>
  2046eb:	83 c4 10             	add    $0x10,%esp
  2046ee:	89 44 24 68          	mov    %eax,0x68(%esp)
  2046f2:	83 7c 24 68 01       	cmpl   $0x1,0x68(%esp)
  2046f7:	77 08                	ja     204701 <f_open+0x3a4>
  2046f9:	c7 44 24 6c 02 00 00 	movl   $0x2,0x6c(%esp)
  204700:	00 
  204701:	83 7c 24 68 ff       	cmpl   $0xffffffff,0x68(%esp)
  204706:	75 08                	jne    204710 <f_open+0x3b3>
  204708:	c7 44 24 6c 01 00 00 	movl   $0x1,0x6c(%esp)
  20470f:	00 
  204710:	8b 44 24 54          	mov    0x54(%esp),%eax
  204714:	29 44 24 64          	sub    %eax,0x64(%esp)
  204718:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  20471d:	75 0a                	jne    204729 <f_open+0x3cc>
  20471f:	8b 44 24 64          	mov    0x64(%esp),%eax
  204723:	39 44 24 54          	cmp    %eax,0x54(%esp)
  204727:	72 ae                	jb     2046d7 <f_open+0x37a>
  204729:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  204730:	8b 54 24 68          	mov    0x68(%esp),%edx
  204734:	89 50 18             	mov    %edx,0x18(%eax)
  204737:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  20473c:	75 4f                	jne    20478d <f_open+0x430>
  20473e:	8b 44 24 64          	mov    0x64(%esp),%eax
  204742:	25 ff 01 00 00       	and    $0x1ff,%eax
  204747:	85 c0                	test   %eax,%eax
  204749:	74 42                	je     20478d <f_open+0x430>
  20474b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  20474f:	83 ec 08             	sub    $0x8,%esp
  204752:	ff 74 24 70          	push   0x70(%esp)
  204756:	50                   	push   %eax
  204757:	e8 07 cd ff ff       	call   201463 <clst2sect>
  20475c:	83 c4 10             	add    $0x10,%esp
  20475f:	89 44 24 50          	mov    %eax,0x50(%esp)
  204763:	83 7c 24 50 00       	cmpl   $0x0,0x50(%esp)
  204768:	75 0a                	jne    204774 <f_open+0x417>
  20476a:	c7 44 24 6c 02 00 00 	movl   $0x2,0x6c(%esp)
  204771:	00 
  204772:	eb 19                	jmp    20478d <f_open+0x430>
  204774:	8b 44 24 64          	mov    0x64(%esp),%eax
  204778:	c1 e8 09             	shr    $0x9,%eax
  20477b:	89 c2                	mov    %eax,%edx
  20477d:	8b 44 24 50          	mov    0x50(%esp),%eax
  204781:	01 c2                	add    %eax,%edx
  204783:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  20478a:	89 50 1c             	mov    %edx,0x1c(%eax)
  20478d:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  204792:	74 0d                	je     2047a1 <f_open+0x444>
  204794:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  20479b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  2047a1:	8b 44 24 6c          	mov    0x6c(%esp),%eax
  2047a5:	83 c4 7c             	add    $0x7c,%esp
  2047a8:	c3                   	ret

002047a9 <f_read>:
  2047a9:	83 ec 3c             	sub    $0x3c,%esp
  2047ac:	8b 44 24 44          	mov    0x44(%esp),%eax
  2047b0:	89 44 24 20          	mov    %eax,0x20(%esp)
  2047b4:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  2047b8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  2047be:	8b 44 24 40          	mov    0x40(%esp),%eax
  2047c2:	83 ec 08             	sub    $0x8,%esp
  2047c5:	8d 54 24 14          	lea    0x14(%esp),%edx
  2047c9:	52                   	push   %edx
  2047ca:	50                   	push   %eax
  2047cb:	e8 45 fa ff ff       	call   204215 <validate>
  2047d0:	83 c4 10             	add    $0x10,%esp
  2047d3:	89 44 24 2c          	mov    %eax,0x2c(%esp)
  2047d7:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
  2047dc:	75 16                	jne    2047f4 <f_read+0x4b>
  2047de:	8b 44 24 40          	mov    0x40(%esp),%eax
  2047e2:	0f b6 40 11          	movzbl 0x11(%eax),%eax
  2047e6:	0f b6 c0             	movzbl %al,%eax
  2047e9:	89 44 24 2c          	mov    %eax,0x2c(%esp)
  2047ed:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
  2047f2:	74 09                	je     2047fd <f_read+0x54>
  2047f4:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  2047f8:	e9 d8 02 00 00       	jmp    204ad5 <f_read+0x32c>
  2047fd:	8b 44 24 40          	mov    0x40(%esp),%eax
  204801:	0f b6 40 10          	movzbl 0x10(%eax),%eax
  204805:	0f b6 c0             	movzbl %al,%eax
  204808:	83 e0 01             	and    $0x1,%eax
  20480b:	85 c0                	test   %eax,%eax
  20480d:	75 0a                	jne    204819 <f_read+0x70>
  20480f:	b8 07 00 00 00       	mov    $0x7,%eax
  204814:	e9 bc 02 00 00       	jmp    204ad5 <f_read+0x32c>
  204819:	8b 44 24 40          	mov    0x40(%esp),%eax
  20481d:	8b 50 0c             	mov    0xc(%eax),%edx
  204820:	8b 44 24 40          	mov    0x40(%esp),%eax
  204824:	8b 40 14             	mov    0x14(%eax),%eax
  204827:	29 c2                	sub    %eax,%edx
  204829:	89 54 24 18          	mov    %edx,0x18(%esp)
  20482d:	8b 44 24 48          	mov    0x48(%esp),%eax
  204831:	39 44 24 18          	cmp    %eax,0x18(%esp)
  204835:	0f 83 8a 02 00 00    	jae    204ac5 <f_read+0x31c>
  20483b:	8b 44 24 18          	mov    0x18(%esp),%eax
  20483f:	89 44 24 48          	mov    %eax,0x48(%esp)
  204843:	e9 7d 02 00 00       	jmp    204ac5 <f_read+0x31c>
  204848:	8b 44 24 40          	mov    0x40(%esp),%eax
  20484c:	8b 40 14             	mov    0x14(%eax),%eax
  20484f:	25 ff 01 00 00       	and    $0x1ff,%eax
  204854:	85 c0                	test   %eax,%eax
  204856:	0f 85 b4 01 00 00    	jne    204a10 <f_read+0x267>
  20485c:	8b 44 24 40          	mov    0x40(%esp),%eax
  204860:	8b 40 14             	mov    0x14(%eax),%eax
  204863:	c1 e8 09             	shr    $0x9,%eax
  204866:	89 c2                	mov    %eax,%edx
  204868:	8b 44 24 0c          	mov    0xc(%esp),%eax
  20486c:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  204870:	0f b7 c0             	movzwl %ax,%eax
  204873:	83 e8 01             	sub    $0x1,%eax
  204876:	21 d0                	and    %edx,%eax
  204878:	89 44 24 14          	mov    %eax,0x14(%esp)
  20487c:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  204881:	75 71                	jne    2048f4 <f_read+0x14b>
  204883:	8b 44 24 40          	mov    0x40(%esp),%eax
  204887:	8b 40 14             	mov    0x14(%eax),%eax
  20488a:	85 c0                	test   %eax,%eax
  20488c:	75 0d                	jne    20489b <f_read+0xf2>
  20488e:	8b 44 24 40          	mov    0x40(%esp),%eax
  204892:	8b 40 08             	mov    0x8(%eax),%eax
  204895:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  204899:	eb 1c                	jmp    2048b7 <f_read+0x10e>
  20489b:	8b 44 24 40          	mov    0x40(%esp),%eax
  20489f:	8b 50 18             	mov    0x18(%eax),%edx
  2048a2:	8b 44 24 40          	mov    0x40(%esp),%eax
  2048a6:	83 ec 08             	sub    $0x8,%esp
  2048a9:	52                   	push   %edx
  2048aa:	50                   	push   %eax
  2048ab:	e8 e8 cb ff ff       	call   201498 <get_fat>
  2048b0:	83 c4 10             	add    $0x10,%esp
  2048b3:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  2048b7:	83 7c 24 1c 01       	cmpl   $0x1,0x1c(%esp)
  2048bc:	77 12                	ja     2048d0 <f_read+0x127>
  2048be:	8b 44 24 40          	mov    0x40(%esp),%eax
  2048c2:	c6 40 11 02          	movb   $0x2,0x11(%eax)
  2048c6:	b8 02 00 00 00       	mov    $0x2,%eax
  2048cb:	e9 05 02 00 00       	jmp    204ad5 <f_read+0x32c>
  2048d0:	83 7c 24 1c ff       	cmpl   $0xffffffff,0x1c(%esp)
  2048d5:	75 12                	jne    2048e9 <f_read+0x140>
  2048d7:	8b 44 24 40          	mov    0x40(%esp),%eax
  2048db:	c6 40 11 01          	movb   $0x1,0x11(%eax)
  2048df:	b8 01 00 00 00       	mov    $0x1,%eax
  2048e4:	e9 ec 01 00 00       	jmp    204ad5 <f_read+0x32c>
  2048e9:	8b 44 24 40          	mov    0x40(%esp),%eax
  2048ed:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  2048f1:	89 50 18             	mov    %edx,0x18(%eax)
  2048f4:	8b 44 24 40          	mov    0x40(%esp),%eax
  2048f8:	8b 50 18             	mov    0x18(%eax),%edx
  2048fb:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2048ff:	83 ec 08             	sub    $0x8,%esp
  204902:	52                   	push   %edx
  204903:	50                   	push   %eax
  204904:	e8 5a cb ff ff       	call   201463 <clst2sect>
  204909:	83 c4 10             	add    $0x10,%esp
  20490c:	89 44 24 10          	mov    %eax,0x10(%esp)
  204910:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  204915:	75 12                	jne    204929 <f_read+0x180>
  204917:	8b 44 24 40          	mov    0x40(%esp),%eax
  20491b:	c6 40 11 02          	movb   $0x2,0x11(%eax)
  20491f:	b8 02 00 00 00       	mov    $0x2,%eax
  204924:	e9 ac 01 00 00       	jmp    204ad5 <f_read+0x32c>
  204929:	8b 44 24 14          	mov    0x14(%esp),%eax
  20492d:	01 44 24 10          	add    %eax,0x10(%esp)
  204931:	8b 44 24 48          	mov    0x48(%esp),%eax
  204935:	c1 e8 09             	shr    $0x9,%eax
  204938:	89 44 24 24          	mov    %eax,0x24(%esp)
  20493c:	83 7c 24 24 00       	cmpl   $0x0,0x24(%esp)
  204941:	0f 84 be 00 00 00    	je     204a05 <f_read+0x25c>
  204947:	8b 54 24 14          	mov    0x14(%esp),%edx
  20494b:	8b 44 24 24          	mov    0x24(%esp),%eax
  20494f:	01 c2                	add    %eax,%edx
  204951:	8b 44 24 0c          	mov    0xc(%esp),%eax
  204955:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  204959:	0f b7 c0             	movzwl %ax,%eax
  20495c:	39 d0                	cmp    %edx,%eax
  20495e:	73 13                	jae    204973 <f_read+0x1ca>
  204960:	8b 44 24 0c          	mov    0xc(%esp),%eax
  204964:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  204968:	0f b7 c0             	movzwl %ax,%eax
  20496b:	2b 44 24 14          	sub    0x14(%esp),%eax
  20496f:	89 44 24 24          	mov    %eax,0x24(%esp)
  204973:	8b 44 24 0c          	mov    0xc(%esp),%eax
  204977:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  20497b:	0f b6 c0             	movzbl %al,%eax
  20497e:	ff 74 24 24          	push   0x24(%esp)
  204982:	ff 74 24 14          	push   0x14(%esp)
  204986:	ff 74 24 28          	push   0x28(%esp)
  20498a:	50                   	push   %eax
  20498b:	e8 c7 b9 ff ff       	call   200357 <disk_read>
  204990:	83 c4 10             	add    $0x10,%esp
  204993:	85 c0                	test   %eax,%eax
  204995:	74 12                	je     2049a9 <f_read+0x200>
  204997:	8b 44 24 40          	mov    0x40(%esp),%eax
  20499b:	c6 40 11 01          	movb   $0x1,0x11(%eax)
  20499f:	b8 01 00 00 00       	mov    $0x1,%eax
  2049a4:	e9 2c 01 00 00       	jmp    204ad5 <f_read+0x32c>
  2049a9:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2049ad:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  2049b1:	84 c0                	test   %al,%al
  2049b3:	74 40                	je     2049f5 <f_read+0x24c>
  2049b5:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2049b9:	8b 40 20             	mov    0x20(%eax),%eax
  2049bc:	2b 44 24 10          	sub    0x10(%esp),%eax
  2049c0:	3b 44 24 24          	cmp    0x24(%esp),%eax
  2049c4:	73 2f                	jae    2049f5 <f_read+0x24c>
  2049c6:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2049ca:	8d 50 34             	lea    0x34(%eax),%edx
  2049cd:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2049d1:	8b 40 20             	mov    0x20(%eax),%eax
  2049d4:	2b 44 24 10          	sub    0x10(%esp),%eax
  2049d8:	c1 e0 09             	shl    $0x9,%eax
  2049db:	89 c1                	mov    %eax,%ecx
  2049dd:	8b 44 24 20          	mov    0x20(%esp),%eax
  2049e1:	01 c8                	add    %ecx,%eax
  2049e3:	83 ec 04             	sub    $0x4,%esp
  2049e6:	68 00 02 00 00       	push   $0x200
  2049eb:	52                   	push   %edx
  2049ec:	50                   	push   %eax
  2049ed:	e8 51 24 00 00       	call   206e43 <memcpy>
  2049f2:	83 c4 10             	add    $0x10,%esp
  2049f5:	8b 44 24 24          	mov    0x24(%esp),%eax
  2049f9:	c1 e0 09             	shl    $0x9,%eax
  2049fc:	89 44 24 28          	mov    %eax,0x28(%esp)
  204a00:	e9 8a 00 00 00       	jmp    204a8f <f_read+0x2e6>
  204a05:	8b 44 24 40          	mov    0x40(%esp),%eax
  204a09:	8b 54 24 10          	mov    0x10(%esp),%edx
  204a0d:	89 50 1c             	mov    %edx,0x1c(%eax)
  204a10:	8b 44 24 40          	mov    0x40(%esp),%eax
  204a14:	8b 40 14             	mov    0x14(%eax),%eax
  204a17:	25 ff 01 00 00       	and    $0x1ff,%eax
  204a1c:	89 c2                	mov    %eax,%edx
  204a1e:	b8 00 02 00 00       	mov    $0x200,%eax
  204a23:	29 d0                	sub    %edx,%eax
  204a25:	89 44 24 28          	mov    %eax,0x28(%esp)
  204a29:	8b 44 24 28          	mov    0x28(%esp),%eax
  204a2d:	39 44 24 48          	cmp    %eax,0x48(%esp)
  204a31:	73 08                	jae    204a3b <f_read+0x292>
  204a33:	8b 44 24 48          	mov    0x48(%esp),%eax
  204a37:	89 44 24 28          	mov    %eax,0x28(%esp)
  204a3b:	8b 44 24 40          	mov    0x40(%esp),%eax
  204a3f:	8b 50 1c             	mov    0x1c(%eax),%edx
  204a42:	8b 44 24 0c          	mov    0xc(%esp),%eax
  204a46:	83 ec 08             	sub    $0x8,%esp
  204a49:	52                   	push   %edx
  204a4a:	50                   	push   %eax
  204a4b:	e8 3c c8 ff ff       	call   20128c <move_window>
  204a50:	83 c4 10             	add    $0x10,%esp
  204a53:	85 c0                	test   %eax,%eax
  204a55:	74 0f                	je     204a66 <f_read+0x2bd>
  204a57:	8b 44 24 40          	mov    0x40(%esp),%eax
  204a5b:	c6 40 11 01          	movb   $0x1,0x11(%eax)
  204a5f:	b8 01 00 00 00       	mov    $0x1,%eax
  204a64:	eb 6f                	jmp    204ad5 <f_read+0x32c>
  204a66:	8b 44 24 0c          	mov    0xc(%esp),%eax
  204a6a:	8d 50 34             	lea    0x34(%eax),%edx
  204a6d:	8b 44 24 40          	mov    0x40(%esp),%eax
  204a71:	8b 40 14             	mov    0x14(%eax),%eax
  204a74:	25 ff 01 00 00       	and    $0x1ff,%eax
  204a79:	01 d0                	add    %edx,%eax
  204a7b:	83 ec 04             	sub    $0x4,%esp
  204a7e:	ff 74 24 2c          	push   0x2c(%esp)
  204a82:	50                   	push   %eax
  204a83:	ff 74 24 2c          	push   0x2c(%esp)
  204a87:	e8 b7 23 00 00       	call   206e43 <memcpy>
  204a8c:	83 c4 10             	add    $0x10,%esp
  204a8f:	8b 44 24 28          	mov    0x28(%esp),%eax
  204a93:	29 44 24 48          	sub    %eax,0x48(%esp)
  204a97:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  204a9b:	8b 10                	mov    (%eax),%edx
  204a9d:	8b 44 24 28          	mov    0x28(%esp),%eax
  204aa1:	01 c2                	add    %eax,%edx
  204aa3:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  204aa7:	89 10                	mov    %edx,(%eax)
  204aa9:	8b 44 24 28          	mov    0x28(%esp),%eax
  204aad:	01 44 24 20          	add    %eax,0x20(%esp)
  204ab1:	8b 44 24 40          	mov    0x40(%esp),%eax
  204ab5:	8b 50 14             	mov    0x14(%eax),%edx
  204ab8:	8b 44 24 28          	mov    0x28(%esp),%eax
  204abc:	01 c2                	add    %eax,%edx
  204abe:	8b 44 24 40          	mov    0x40(%esp),%eax
  204ac2:	89 50 14             	mov    %edx,0x14(%eax)
  204ac5:	83 7c 24 48 00       	cmpl   $0x0,0x48(%esp)
  204aca:	0f 85 78 fd ff ff    	jne    204848 <f_read+0x9f>
  204ad0:	b8 00 00 00 00       	mov    $0x0,%eax
  204ad5:	83 c4 3c             	add    $0x3c,%esp
  204ad8:	c3                   	ret

00204ad9 <f_write>:
  204ad9:	83 ec 2c             	sub    $0x2c,%esp
  204adc:	8b 44 24 34          	mov    0x34(%esp),%eax
  204ae0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  204ae4:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  204ae8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  204aee:	8b 44 24 30          	mov    0x30(%esp),%eax
  204af2:	83 ec 08             	sub    $0x8,%esp
  204af5:	8d 54 24 08          	lea    0x8(%esp),%edx
  204af9:	52                   	push   %edx
  204afa:	50                   	push   %eax
  204afb:	e8 15 f7 ff ff       	call   204215 <validate>
  204b00:	83 c4 10             	add    $0x10,%esp
  204b03:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  204b07:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  204b0c:	75 16                	jne    204b24 <f_write+0x4b>
  204b0e:	8b 44 24 30          	mov    0x30(%esp),%eax
  204b12:	0f b6 40 11          	movzbl 0x11(%eax),%eax
  204b16:	0f b6 c0             	movzbl %al,%eax
  204b19:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  204b1d:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  204b22:	74 09                	je     204b2d <f_write+0x54>
  204b24:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  204b28:	e9 bc 03 00 00       	jmp    204ee9 <f_write+0x410>
  204b2d:	8b 44 24 30          	mov    0x30(%esp),%eax
  204b31:	0f b6 40 10          	movzbl 0x10(%eax),%eax
  204b35:	0f b6 c0             	movzbl %al,%eax
  204b38:	83 e0 02             	and    $0x2,%eax
  204b3b:	85 c0                	test   %eax,%eax
  204b3d:	75 0a                	jne    204b49 <f_write+0x70>
  204b3f:	b8 07 00 00 00       	mov    $0x7,%eax
  204b44:	e9 a0 03 00 00       	jmp    204ee9 <f_write+0x410>
  204b49:	8b 44 24 30          	mov    0x30(%esp),%eax
  204b4d:	8b 50 14             	mov    0x14(%eax),%edx
  204b50:	8b 44 24 38          	mov    0x38(%esp),%eax
  204b54:	01 c2                	add    %eax,%edx
  204b56:	8b 44 24 30          	mov    0x30(%esp),%eax
  204b5a:	8b 40 14             	mov    0x14(%eax),%eax
  204b5d:	39 c2                	cmp    %eax,%edx
  204b5f:	0f 83 5d 03 00 00    	jae    204ec2 <f_write+0x3e9>
  204b65:	8b 44 24 30          	mov    0x30(%esp),%eax
  204b69:	8b 40 14             	mov    0x14(%eax),%eax
  204b6c:	f7 d0                	not    %eax
  204b6e:	89 44 24 38          	mov    %eax,0x38(%esp)
  204b72:	e9 4b 03 00 00       	jmp    204ec2 <f_write+0x3e9>
  204b77:	8b 44 24 30          	mov    0x30(%esp),%eax
  204b7b:	8b 40 14             	mov    0x14(%eax),%eax
  204b7e:	25 ff 01 00 00       	and    $0x1ff,%eax
  204b83:	85 c0                	test   %eax,%eax
  204b85:	0f 85 60 02 00 00    	jne    204deb <f_write+0x312>
  204b8b:	8b 44 24 30          	mov    0x30(%esp),%eax
  204b8f:	8b 40 14             	mov    0x14(%eax),%eax
  204b92:	c1 e8 09             	shr    $0x9,%eax
  204b95:	89 c2                	mov    %eax,%edx
  204b97:	8b 04 24             	mov    (%esp),%eax
  204b9a:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  204b9e:	0f b7 c0             	movzwl %ax,%eax
  204ba1:	83 e8 01             	sub    $0x1,%eax
  204ba4:	21 d0                	and    %edx,%eax
  204ba6:	89 44 24 08          	mov    %eax,0x8(%esp)
  204baa:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  204baf:	0f 85 af 00 00 00    	jne    204c64 <f_write+0x18b>
  204bb5:	8b 44 24 30          	mov    0x30(%esp),%eax
  204bb9:	8b 40 14             	mov    0x14(%eax),%eax
  204bbc:	85 c0                	test   %eax,%eax
  204bbe:	75 2a                	jne    204bea <f_write+0x111>
  204bc0:	8b 44 24 30          	mov    0x30(%esp),%eax
  204bc4:	8b 40 08             	mov    0x8(%eax),%eax
  204bc7:	89 44 24 18          	mov    %eax,0x18(%esp)
  204bcb:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  204bd0:	75 34                	jne    204c06 <f_write+0x12d>
  204bd2:	8b 44 24 30          	mov    0x30(%esp),%eax
  204bd6:	83 ec 08             	sub    $0x8,%esp
  204bd9:	6a 00                	push   $0x0
  204bdb:	50                   	push   %eax
  204bdc:	e8 4e ce ff ff       	call   201a2f <create_chain>
  204be1:	83 c4 10             	add    $0x10,%esp
  204be4:	89 44 24 18          	mov    %eax,0x18(%esp)
  204be8:	eb 1c                	jmp    204c06 <f_write+0x12d>
  204bea:	8b 44 24 30          	mov    0x30(%esp),%eax
  204bee:	8b 50 18             	mov    0x18(%eax),%edx
  204bf1:	8b 44 24 30          	mov    0x30(%esp),%eax
  204bf5:	83 ec 08             	sub    $0x8,%esp
  204bf8:	52                   	push   %edx
  204bf9:	50                   	push   %eax
  204bfa:	e8 30 ce ff ff       	call   201a2f <create_chain>
  204bff:	83 c4 10             	add    $0x10,%esp
  204c02:	89 44 24 18          	mov    %eax,0x18(%esp)
  204c06:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  204c0b:	0f 84 be 02 00 00    	je     204ecf <f_write+0x3f6>
  204c11:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
  204c16:	75 12                	jne    204c2a <f_write+0x151>
  204c18:	8b 44 24 30          	mov    0x30(%esp),%eax
  204c1c:	c6 40 11 02          	movb   $0x2,0x11(%eax)
  204c20:	b8 02 00 00 00       	mov    $0x2,%eax
  204c25:	e9 bf 02 00 00       	jmp    204ee9 <f_write+0x410>
  204c2a:	83 7c 24 18 ff       	cmpl   $0xffffffff,0x18(%esp)
  204c2f:	75 12                	jne    204c43 <f_write+0x16a>
  204c31:	8b 44 24 30          	mov    0x30(%esp),%eax
  204c35:	c6 40 11 01          	movb   $0x1,0x11(%eax)
  204c39:	b8 01 00 00 00       	mov    $0x1,%eax
  204c3e:	e9 a6 02 00 00       	jmp    204ee9 <f_write+0x410>
  204c43:	8b 44 24 30          	mov    0x30(%esp),%eax
  204c47:	8b 54 24 18          	mov    0x18(%esp),%edx
  204c4b:	89 50 18             	mov    %edx,0x18(%eax)
  204c4e:	8b 44 24 30          	mov    0x30(%esp),%eax
  204c52:	8b 40 08             	mov    0x8(%eax),%eax
  204c55:	85 c0                	test   %eax,%eax
  204c57:	75 0b                	jne    204c64 <f_write+0x18b>
  204c59:	8b 44 24 30          	mov    0x30(%esp),%eax
  204c5d:	8b 54 24 18          	mov    0x18(%esp),%edx
  204c61:	89 50 08             	mov    %edx,0x8(%eax)
  204c64:	8b 04 24             	mov    (%esp),%eax
  204c67:	8b 50 20             	mov    0x20(%eax),%edx
  204c6a:	8b 44 24 30          	mov    0x30(%esp),%eax
  204c6e:	8b 40 1c             	mov    0x1c(%eax),%eax
  204c71:	39 c2                	cmp    %eax,%edx
  204c73:	75 25                	jne    204c9a <f_write+0x1c1>
  204c75:	8b 04 24             	mov    (%esp),%eax
  204c78:	83 ec 0c             	sub    $0xc,%esp
  204c7b:	50                   	push   %eax
  204c7c:	e8 55 c5 ff ff       	call   2011d6 <sync_window>
  204c81:	83 c4 10             	add    $0x10,%esp
  204c84:	85 c0                	test   %eax,%eax
  204c86:	74 12                	je     204c9a <f_write+0x1c1>
  204c88:	8b 44 24 30          	mov    0x30(%esp),%eax
  204c8c:	c6 40 11 01          	movb   $0x1,0x11(%eax)
  204c90:	b8 01 00 00 00       	mov    $0x1,%eax
  204c95:	e9 4f 02 00 00       	jmp    204ee9 <f_write+0x410>
  204c9a:	8b 44 24 30          	mov    0x30(%esp),%eax
  204c9e:	8b 50 18             	mov    0x18(%eax),%edx
  204ca1:	8b 04 24             	mov    (%esp),%eax
  204ca4:	83 ec 08             	sub    $0x8,%esp
  204ca7:	52                   	push   %edx
  204ca8:	50                   	push   %eax
  204ca9:	e8 b5 c7 ff ff       	call   201463 <clst2sect>
  204cae:	83 c4 10             	add    $0x10,%esp
  204cb1:	89 44 24 04          	mov    %eax,0x4(%esp)
  204cb5:	83 7c 24 04 00       	cmpl   $0x0,0x4(%esp)
  204cba:	75 12                	jne    204cce <f_write+0x1f5>
  204cbc:	8b 44 24 30          	mov    0x30(%esp),%eax
  204cc0:	c6 40 11 02          	movb   $0x2,0x11(%eax)
  204cc4:	b8 02 00 00 00       	mov    $0x2,%eax
  204cc9:	e9 1b 02 00 00       	jmp    204ee9 <f_write+0x410>
  204cce:	8b 44 24 08          	mov    0x8(%esp),%eax
  204cd2:	01 44 24 04          	add    %eax,0x4(%esp)
  204cd6:	8b 44 24 38          	mov    0x38(%esp),%eax
  204cda:	c1 e8 09             	shr    $0x9,%eax
  204cdd:	89 44 24 10          	mov    %eax,0x10(%esp)
  204ce1:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  204ce6:	0f 84 b3 00 00 00    	je     204d9f <f_write+0x2c6>
  204cec:	8b 54 24 08          	mov    0x8(%esp),%edx
  204cf0:	8b 44 24 10          	mov    0x10(%esp),%eax
  204cf4:	01 c2                	add    %eax,%edx
  204cf6:	8b 04 24             	mov    (%esp),%eax
  204cf9:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  204cfd:	0f b7 c0             	movzwl %ax,%eax
  204d00:	39 d0                	cmp    %edx,%eax
  204d02:	73 12                	jae    204d16 <f_write+0x23d>
  204d04:	8b 04 24             	mov    (%esp),%eax
  204d07:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  204d0b:	0f b7 c0             	movzwl %ax,%eax
  204d0e:	2b 44 24 08          	sub    0x8(%esp),%eax
  204d12:	89 44 24 10          	mov    %eax,0x10(%esp)
  204d16:	8b 04 24             	mov    (%esp),%eax
  204d19:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  204d1d:	0f b6 c0             	movzbl %al,%eax
  204d20:	ff 74 24 10          	push   0x10(%esp)
  204d24:	ff 74 24 08          	push   0x8(%esp)
  204d28:	ff 74 24 14          	push   0x14(%esp)
  204d2c:	50                   	push   %eax
  204d2d:	e8 68 b6 ff ff       	call   20039a <disk_write>
  204d32:	83 c4 10             	add    $0x10,%esp
  204d35:	85 c0                	test   %eax,%eax
  204d37:	74 12                	je     204d4b <f_write+0x272>
  204d39:	8b 44 24 30          	mov    0x30(%esp),%eax
  204d3d:	c6 40 11 01          	movb   $0x1,0x11(%eax)
  204d41:	b8 01 00 00 00       	mov    $0x1,%eax
  204d46:	e9 9e 01 00 00       	jmp    204ee9 <f_write+0x410>
  204d4b:	8b 04 24             	mov    (%esp),%eax
  204d4e:	8b 40 20             	mov    0x20(%eax),%eax
  204d51:	2b 44 24 04          	sub    0x4(%esp),%eax
  204d55:	3b 44 24 10          	cmp    0x10(%esp),%eax
  204d59:	73 34                	jae    204d8f <f_write+0x2b6>
  204d5b:	8b 04 24             	mov    (%esp),%eax
  204d5e:	8b 40 20             	mov    0x20(%eax),%eax
  204d61:	2b 44 24 04          	sub    0x4(%esp),%eax
  204d65:	c1 e0 09             	shl    $0x9,%eax
  204d68:	89 c2                	mov    %eax,%edx
  204d6a:	8b 44 24 0c          	mov    0xc(%esp),%eax
  204d6e:	01 c2                	add    %eax,%edx
  204d70:	8b 04 24             	mov    (%esp),%eax
  204d73:	83 c0 34             	add    $0x34,%eax
  204d76:	83 ec 04             	sub    $0x4,%esp
  204d79:	68 00 02 00 00       	push   $0x200
  204d7e:	52                   	push   %edx
  204d7f:	50                   	push   %eax
  204d80:	e8 be 20 00 00       	call   206e43 <memcpy>
  204d85:	83 c4 10             	add    $0x10,%esp
  204d88:	8b 04 24             	mov    (%esp),%eax
  204d8b:	c6 40 04 00          	movb   $0x0,0x4(%eax)
  204d8f:	8b 44 24 10          	mov    0x10(%esp),%eax
  204d93:	c1 e0 09             	shl    $0x9,%eax
  204d96:	89 44 24 14          	mov    %eax,0x14(%esp)
  204d9a:	e9 d3 00 00 00       	jmp    204e72 <f_write+0x399>
  204d9f:	8b 44 24 30          	mov    0x30(%esp),%eax
  204da3:	8b 50 14             	mov    0x14(%eax),%edx
  204da6:	8b 44 24 30          	mov    0x30(%esp),%eax
  204daa:	8b 40 0c             	mov    0xc(%eax),%eax
  204dad:	39 c2                	cmp    %eax,%edx
  204daf:	72 2f                	jb     204de0 <f_write+0x307>
  204db1:	8b 04 24             	mov    (%esp),%eax
  204db4:	83 ec 0c             	sub    $0xc,%esp
  204db7:	50                   	push   %eax
  204db8:	e8 19 c4 ff ff       	call   2011d6 <sync_window>
  204dbd:	83 c4 10             	add    $0x10,%esp
  204dc0:	85 c0                	test   %eax,%eax
  204dc2:	74 12                	je     204dd6 <f_write+0x2fd>
  204dc4:	8b 44 24 30          	mov    0x30(%esp),%eax
  204dc8:	c6 40 11 01          	movb   $0x1,0x11(%eax)
  204dcc:	b8 01 00 00 00       	mov    $0x1,%eax
  204dd1:	e9 13 01 00 00       	jmp    204ee9 <f_write+0x410>
  204dd6:	8b 04 24             	mov    (%esp),%eax
  204dd9:	8b 54 24 04          	mov    0x4(%esp),%edx
  204ddd:	89 50 20             	mov    %edx,0x20(%eax)
  204de0:	8b 44 24 30          	mov    0x30(%esp),%eax
  204de4:	8b 54 24 04          	mov    0x4(%esp),%edx
  204de8:	89 50 1c             	mov    %edx,0x1c(%eax)
  204deb:	8b 44 24 30          	mov    0x30(%esp),%eax
  204def:	8b 40 14             	mov    0x14(%eax),%eax
  204df2:	25 ff 01 00 00       	and    $0x1ff,%eax
  204df7:	89 c2                	mov    %eax,%edx
  204df9:	b8 00 02 00 00       	mov    $0x200,%eax
  204dfe:	29 d0                	sub    %edx,%eax
  204e00:	89 44 24 14          	mov    %eax,0x14(%esp)
  204e04:	8b 44 24 14          	mov    0x14(%esp),%eax
  204e08:	39 44 24 38          	cmp    %eax,0x38(%esp)
  204e0c:	73 08                	jae    204e16 <f_write+0x33d>
  204e0e:	8b 44 24 38          	mov    0x38(%esp),%eax
  204e12:	89 44 24 14          	mov    %eax,0x14(%esp)
  204e16:	8b 44 24 30          	mov    0x30(%esp),%eax
  204e1a:	8b 50 1c             	mov    0x1c(%eax),%edx
  204e1d:	8b 04 24             	mov    (%esp),%eax
  204e20:	83 ec 08             	sub    $0x8,%esp
  204e23:	52                   	push   %edx
  204e24:	50                   	push   %eax
  204e25:	e8 62 c4 ff ff       	call   20128c <move_window>
  204e2a:	83 c4 10             	add    $0x10,%esp
  204e2d:	85 c0                	test   %eax,%eax
  204e2f:	74 12                	je     204e43 <f_write+0x36a>
  204e31:	8b 44 24 30          	mov    0x30(%esp),%eax
  204e35:	c6 40 11 01          	movb   $0x1,0x11(%eax)
  204e39:	b8 01 00 00 00       	mov    $0x1,%eax
  204e3e:	e9 a6 00 00 00       	jmp    204ee9 <f_write+0x410>
  204e43:	8b 04 24             	mov    (%esp),%eax
  204e46:	8d 50 34             	lea    0x34(%eax),%edx
  204e49:	8b 44 24 30          	mov    0x30(%esp),%eax
  204e4d:	8b 40 14             	mov    0x14(%eax),%eax
  204e50:	25 ff 01 00 00       	and    $0x1ff,%eax
  204e55:	01 d0                	add    %edx,%eax
  204e57:	83 ec 04             	sub    $0x4,%esp
  204e5a:	ff 74 24 18          	push   0x18(%esp)
  204e5e:	ff 74 24 14          	push   0x14(%esp)
  204e62:	50                   	push   %eax
  204e63:	e8 db 1f 00 00       	call   206e43 <memcpy>
  204e68:	83 c4 10             	add    $0x10,%esp
  204e6b:	8b 04 24             	mov    (%esp),%eax
  204e6e:	c6 40 04 01          	movb   $0x1,0x4(%eax)
  204e72:	8b 44 24 14          	mov    0x14(%esp),%eax
  204e76:	29 44 24 38          	sub    %eax,0x38(%esp)
  204e7a:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  204e7e:	8b 10                	mov    (%eax),%edx
  204e80:	8b 44 24 14          	mov    0x14(%esp),%eax
  204e84:	01 c2                	add    %eax,%edx
  204e86:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  204e8a:	89 10                	mov    %edx,(%eax)
  204e8c:	8b 44 24 14          	mov    0x14(%esp),%eax
  204e90:	01 44 24 0c          	add    %eax,0xc(%esp)
  204e94:	8b 44 24 30          	mov    0x30(%esp),%eax
  204e98:	8b 50 14             	mov    0x14(%eax),%edx
  204e9b:	8b 44 24 14          	mov    0x14(%esp),%eax
  204e9f:	01 c2                	add    %eax,%edx
  204ea1:	8b 44 24 30          	mov    0x30(%esp),%eax
  204ea5:	89 50 14             	mov    %edx,0x14(%eax)
  204ea8:	8b 44 24 30          	mov    0x30(%esp),%eax
  204eac:	8b 50 0c             	mov    0xc(%eax),%edx
  204eaf:	8b 44 24 30          	mov    0x30(%esp),%eax
  204eb3:	8b 40 14             	mov    0x14(%eax),%eax
  204eb6:	39 c2                	cmp    %eax,%edx
  204eb8:	0f 42 d0             	cmovb  %eax,%edx
  204ebb:	8b 44 24 30          	mov    0x30(%esp),%eax
  204ebf:	89 50 0c             	mov    %edx,0xc(%eax)
  204ec2:	83 7c 24 38 00       	cmpl   $0x0,0x38(%esp)
  204ec7:	0f 85 aa fc ff ff    	jne    204b77 <f_write+0x9e>
  204ecd:	eb 01                	jmp    204ed0 <f_write+0x3f7>
  204ecf:	90                   	nop
  204ed0:	8b 44 24 30          	mov    0x30(%esp),%eax
  204ed4:	0f b6 40 10          	movzbl 0x10(%eax),%eax
  204ed8:	83 c8 40             	or     $0x40,%eax
  204edb:	89 c2                	mov    %eax,%edx
  204edd:	8b 44 24 30          	mov    0x30(%esp),%eax
  204ee1:	88 50 10             	mov    %dl,0x10(%eax)
  204ee4:	b8 00 00 00 00       	mov    $0x0,%eax
  204ee9:	83 c4 2c             	add    $0x2c,%esp
  204eec:	c3                   	ret

00204eed <f_sync>:
  204eed:	83 ec 1c             	sub    $0x1c,%esp
  204ef0:	8b 44 24 20          	mov    0x20(%esp),%eax
  204ef4:	83 ec 08             	sub    $0x8,%esp
  204ef7:	8d 54 24 0c          	lea    0xc(%esp),%edx
  204efb:	52                   	push   %edx
  204efc:	50                   	push   %eax
  204efd:	e8 13 f3 ff ff       	call   204215 <validate>
  204f02:	83 c4 10             	add    $0x10,%esp
  204f05:	89 44 24 0c          	mov    %eax,0xc(%esp)
  204f09:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  204f0e:	0f 85 f4 00 00 00    	jne    205008 <f_sync+0x11b>
  204f14:	8b 44 24 20          	mov    0x20(%esp),%eax
  204f18:	0f b6 40 10          	movzbl 0x10(%eax),%eax
  204f1c:	0f b6 c0             	movzbl %al,%eax
  204f1f:	83 e0 40             	and    $0x40,%eax
  204f22:	85 c0                	test   %eax,%eax
  204f24:	0f 84 de 00 00 00    	je     205008 <f_sync+0x11b>
  204f2a:	8b 44 24 20          	mov    0x20(%esp),%eax
  204f2e:	8b 50 20             	mov    0x20(%eax),%edx
  204f31:	8b 44 24 04          	mov    0x4(%esp),%eax
  204f35:	83 ec 08             	sub    $0x8,%esp
  204f38:	52                   	push   %edx
  204f39:	50                   	push   %eax
  204f3a:	e8 4d c3 ff ff       	call   20128c <move_window>
  204f3f:	83 c4 10             	add    $0x10,%esp
  204f42:	89 44 24 0c          	mov    %eax,0xc(%esp)
  204f46:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  204f4b:	0f 85 b7 00 00 00    	jne    205008 <f_sync+0x11b>
  204f51:	8b 44 24 20          	mov    0x20(%esp),%eax
  204f55:	8b 40 24             	mov    0x24(%eax),%eax
  204f58:	89 44 24 08          	mov    %eax,0x8(%esp)
  204f5c:	8b 44 24 08          	mov    0x8(%esp),%eax
  204f60:	83 c0 0b             	add    $0xb,%eax
  204f63:	0f b6 10             	movzbl (%eax),%edx
  204f66:	8b 44 24 08          	mov    0x8(%esp),%eax
  204f6a:	83 c0 0b             	add    $0xb,%eax
  204f6d:	83 ca 20             	or     $0x20,%edx
  204f70:	88 10                	mov    %dl,(%eax)
  204f72:	8b 44 24 20          	mov    0x20(%esp),%eax
  204f76:	8b 50 08             	mov    0x8(%eax),%edx
  204f79:	8b 44 24 20          	mov    0x20(%esp),%eax
  204f7d:	8b 00                	mov    (%eax),%eax
  204f7f:	83 ec 04             	sub    $0x4,%esp
  204f82:	52                   	push   %edx
  204f83:	ff 74 24 10          	push   0x10(%esp)
  204f87:	50                   	push   %eax
  204f88:	e8 60 d2 ff ff       	call   2021ed <st_clust>
  204f8d:	83 c4 10             	add    $0x10,%esp
  204f90:	8b 44 24 20          	mov    0x20(%esp),%eax
  204f94:	8b 40 0c             	mov    0xc(%eax),%eax
  204f97:	8b 54 24 08          	mov    0x8(%esp),%edx
  204f9b:	83 c2 1c             	add    $0x1c,%edx
  204f9e:	83 ec 08             	sub    $0x8,%esp
  204fa1:	50                   	push   %eax
  204fa2:	52                   	push   %edx
  204fa3:	e8 3b be ff ff       	call   200de3 <st_32>
  204fa8:	83 c4 10             	add    $0x10,%esp
  204fab:	8b 44 24 08          	mov    0x8(%esp),%eax
  204faf:	83 c0 16             	add    $0x16,%eax
  204fb2:	83 ec 08             	sub    $0x8,%esp
  204fb5:	68 00 00 21 5a       	push   $0x5a210000
  204fba:	50                   	push   %eax
  204fbb:	e8 23 be ff ff       	call   200de3 <st_32>
  204fc0:	83 c4 10             	add    $0x10,%esp
  204fc3:	8b 44 24 08          	mov    0x8(%esp),%eax
  204fc7:	83 c0 12             	add    $0x12,%eax
  204fca:	83 ec 08             	sub    $0x8,%esp
  204fcd:	6a 00                	push   $0x0
  204fcf:	50                   	push   %eax
  204fd0:	e8 d7 bd ff ff       	call   200dac <st_16>
  204fd5:	83 c4 10             	add    $0x10,%esp
  204fd8:	8b 44 24 04          	mov    0x4(%esp),%eax
  204fdc:	c6 40 04 01          	movb   $0x1,0x4(%eax)
  204fe0:	8b 44 24 04          	mov    0x4(%esp),%eax
  204fe4:	83 ec 0c             	sub    $0xc,%esp
  204fe7:	50                   	push   %eax
  204fe8:	e8 1a c3 ff ff       	call   201307 <sync_fs>
  204fed:	83 c4 10             	add    $0x10,%esp
  204ff0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  204ff4:	8b 44 24 20          	mov    0x20(%esp),%eax
  204ff8:	0f b6 40 10          	movzbl 0x10(%eax),%eax
  204ffc:	83 e0 bf             	and    $0xffffffbf,%eax
  204fff:	89 c2                	mov    %eax,%edx
  205001:	8b 44 24 20          	mov    0x20(%esp),%eax
  205005:	88 50 10             	mov    %dl,0x10(%eax)
  205008:	8b 44 24 0c          	mov    0xc(%esp),%eax
  20500c:	83 c4 1c             	add    $0x1c,%esp
  20500f:	c3                   	ret

00205010 <f_close>:
  205010:	83 ec 1c             	sub    $0x1c,%esp
  205013:	83 ec 0c             	sub    $0xc,%esp
  205016:	ff 74 24 2c          	push   0x2c(%esp)
  20501a:	e8 ce fe ff ff       	call   204eed <f_sync>
  20501f:	83 c4 10             	add    $0x10,%esp
  205022:	89 44 24 0c          	mov    %eax,0xc(%esp)
  205026:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  20502b:	75 2a                	jne    205057 <f_close+0x47>
  20502d:	8b 44 24 20          	mov    0x20(%esp),%eax
  205031:	83 ec 08             	sub    $0x8,%esp
  205034:	8d 54 24 10          	lea    0x10(%esp),%edx
  205038:	52                   	push   %edx
  205039:	50                   	push   %eax
  20503a:	e8 d6 f1 ff ff       	call   204215 <validate>
  20503f:	83 c4 10             	add    $0x10,%esp
  205042:	89 44 24 0c          	mov    %eax,0xc(%esp)
  205046:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  20504b:	75 0a                	jne    205057 <f_close+0x47>
  20504d:	8b 44 24 20          	mov    0x20(%esp),%eax
  205051:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  205057:	8b 44 24 0c          	mov    0xc(%esp),%eax
  20505b:	83 c4 1c             	add    $0x1c,%esp
  20505e:	c3                   	ret

0020505f <f_lseek>:
  20505f:	83 ec 2c             	sub    $0x2c,%esp
  205062:	8b 44 24 30          	mov    0x30(%esp),%eax
  205066:	83 ec 08             	sub    $0x8,%esp
  205069:	8d 54 24 10          	lea    0x10(%esp),%edx
  20506d:	52                   	push   %edx
  20506e:	50                   	push   %eax
  20506f:	e8 a1 f1 ff ff       	call   204215 <validate>
  205074:	83 c4 10             	add    $0x10,%esp
  205077:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  20507b:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  205080:	75 0f                	jne    205091 <f_lseek+0x32>
  205082:	8b 44 24 30          	mov    0x30(%esp),%eax
  205086:	0f b6 40 11          	movzbl 0x11(%eax),%eax
  20508a:	0f b6 c0             	movzbl %al,%eax
  20508d:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  205091:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  205096:	74 09                	je     2050a1 <f_lseek+0x42>
  205098:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  20509c:	e9 c1 02 00 00       	jmp    205362 <f_lseek+0x303>
  2050a1:	8b 44 24 30          	mov    0x30(%esp),%eax
  2050a5:	8b 40 0c             	mov    0xc(%eax),%eax
  2050a8:	3b 44 24 34          	cmp    0x34(%esp),%eax
  2050ac:	73 1d                	jae    2050cb <f_lseek+0x6c>
  2050ae:	8b 44 24 30          	mov    0x30(%esp),%eax
  2050b2:	0f b6 40 10          	movzbl 0x10(%eax),%eax
  2050b6:	0f b6 c0             	movzbl %al,%eax
  2050b9:	83 e0 02             	and    $0x2,%eax
  2050bc:	85 c0                	test   %eax,%eax
  2050be:	75 0b                	jne    2050cb <f_lseek+0x6c>
  2050c0:	8b 44 24 30          	mov    0x30(%esp),%eax
  2050c4:	8b 40 0c             	mov    0xc(%eax),%eax
  2050c7:	89 44 24 34          	mov    %eax,0x34(%esp)
  2050cb:	8b 44 24 30          	mov    0x30(%esp),%eax
  2050cf:	8b 40 14             	mov    0x14(%eax),%eax
  2050d2:	89 44 24 10          	mov    %eax,0x10(%esp)
  2050d6:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  2050dd:	00 
  2050de:	8b 44 24 30          	mov    0x30(%esp),%eax
  2050e2:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  2050e9:	83 7c 24 34 00       	cmpl   $0x0,0x34(%esp)
  2050ee:	0f 84 0e 02 00 00    	je     205302 <f_lseek+0x2a3>
  2050f4:	8b 44 24 08          	mov    0x8(%esp),%eax
  2050f8:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
  2050fc:	0f b7 c0             	movzwl %ax,%eax
  2050ff:	c1 e0 09             	shl    $0x9,%eax
  205102:	89 44 24 0c          	mov    %eax,0xc(%esp)
  205106:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  20510b:	74 54                	je     205161 <f_lseek+0x102>
  20510d:	8b 44 24 34          	mov    0x34(%esp),%eax
  205111:	83 e8 01             	sub    $0x1,%eax
  205114:	ba 00 00 00 00       	mov    $0x0,%edx
  205119:	f7 74 24 0c          	divl   0xc(%esp)
  20511d:	89 c1                	mov    %eax,%ecx
  20511f:	8b 44 24 10          	mov    0x10(%esp),%eax
  205123:	83 e8 01             	sub    $0x1,%eax
  205126:	ba 00 00 00 00       	mov    $0x0,%edx
  20512b:	f7 74 24 0c          	divl   0xc(%esp)
  20512f:	39 c1                	cmp    %eax,%ecx
  205131:	72 2e                	jb     205161 <f_lseek+0x102>
  205133:	8b 44 24 10          	mov    0x10(%esp),%eax
  205137:	8d 50 ff             	lea    -0x1(%eax),%edx
  20513a:	8b 44 24 0c          	mov    0xc(%esp),%eax
  20513e:	f7 d8                	neg    %eax
  205140:	21 c2                	and    %eax,%edx
  205142:	8b 44 24 30          	mov    0x30(%esp),%eax
  205146:	89 50 14             	mov    %edx,0x14(%eax)
  205149:	8b 44 24 30          	mov    0x30(%esp),%eax
  20514d:	8b 40 14             	mov    0x14(%eax),%eax
  205150:	29 44 24 34          	sub    %eax,0x34(%esp)
  205154:	8b 44 24 30          	mov    0x30(%esp),%eax
  205158:	8b 40 18             	mov    0x18(%eax),%eax
  20515b:	89 44 24 18          	mov    %eax,0x18(%esp)
  20515f:	eb 70                	jmp    2051d1 <f_lseek+0x172>
  205161:	8b 44 24 30          	mov    0x30(%esp),%eax
  205165:	8b 40 08             	mov    0x8(%eax),%eax
  205168:	89 44 24 18          	mov    %eax,0x18(%esp)
  20516c:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  205171:	75 53                	jne    2051c6 <f_lseek+0x167>
  205173:	8b 44 24 30          	mov    0x30(%esp),%eax
  205177:	83 ec 08             	sub    $0x8,%esp
  20517a:	6a 00                	push   $0x0
  20517c:	50                   	push   %eax
  20517d:	e8 ad c8 ff ff       	call   201a2f <create_chain>
  205182:	83 c4 10             	add    $0x10,%esp
  205185:	89 44 24 18          	mov    %eax,0x18(%esp)
  205189:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
  20518e:	75 12                	jne    2051a2 <f_lseek+0x143>
  205190:	8b 44 24 30          	mov    0x30(%esp),%eax
  205194:	c6 40 11 02          	movb   $0x2,0x11(%eax)
  205198:	b8 02 00 00 00       	mov    $0x2,%eax
  20519d:	e9 c0 01 00 00       	jmp    205362 <f_lseek+0x303>
  2051a2:	83 7c 24 18 ff       	cmpl   $0xffffffff,0x18(%esp)
  2051a7:	75 12                	jne    2051bb <f_lseek+0x15c>
  2051a9:	8b 44 24 30          	mov    0x30(%esp),%eax
  2051ad:	c6 40 11 01          	movb   $0x1,0x11(%eax)
  2051b1:	b8 01 00 00 00       	mov    $0x1,%eax
  2051b6:	e9 a7 01 00 00       	jmp    205362 <f_lseek+0x303>
  2051bb:	8b 44 24 30          	mov    0x30(%esp),%eax
  2051bf:	8b 54 24 18          	mov    0x18(%esp),%edx
  2051c3:	89 50 08             	mov    %edx,0x8(%eax)
  2051c6:	8b 44 24 30          	mov    0x30(%esp),%eax
  2051ca:	8b 54 24 18          	mov    0x18(%esp),%edx
  2051ce:	89 50 18             	mov    %edx,0x18(%eax)
  2051d1:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  2051d6:	0f 84 26 01 00 00    	je     205302 <f_lseek+0x2a3>
  2051dc:	e9 b9 00 00 00       	jmp    20529a <f_lseek+0x23b>
  2051e1:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2051e5:	29 44 24 34          	sub    %eax,0x34(%esp)
  2051e9:	8b 44 24 30          	mov    0x30(%esp),%eax
  2051ed:	8b 50 14             	mov    0x14(%eax),%edx
  2051f0:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2051f4:	01 c2                	add    %eax,%edx
  2051f6:	8b 44 24 30          	mov    0x30(%esp),%eax
  2051fa:	89 50 14             	mov    %edx,0x14(%eax)
  2051fd:	8b 44 24 30          	mov    0x30(%esp),%eax
  205201:	0f b6 40 10          	movzbl 0x10(%eax),%eax
  205205:	0f b6 c0             	movzbl %al,%eax
  205208:	83 e0 02             	and    $0x2,%eax
  20520b:	85 c0                	test   %eax,%eax
  20520d:	74 29                	je     205238 <f_lseek+0x1d9>
  20520f:	8b 44 24 30          	mov    0x30(%esp),%eax
  205213:	83 ec 08             	sub    $0x8,%esp
  205216:	ff 74 24 20          	push   0x20(%esp)
  20521a:	50                   	push   %eax
  20521b:	e8 0f c8 ff ff       	call   201a2f <create_chain>
  205220:	83 c4 10             	add    $0x10,%esp
  205223:	89 44 24 18          	mov    %eax,0x18(%esp)
  205227:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  20522c:	75 22                	jne    205250 <f_lseek+0x1f1>
  20522e:	c7 44 24 34 00 00 00 	movl   $0x0,0x34(%esp)
  205235:	00 
  205236:	eb 70                	jmp    2052a8 <f_lseek+0x249>
  205238:	8b 44 24 30          	mov    0x30(%esp),%eax
  20523c:	83 ec 08             	sub    $0x8,%esp
  20523f:	ff 74 24 20          	push   0x20(%esp)
  205243:	50                   	push   %eax
  205244:	e8 4f c2 ff ff       	call   201498 <get_fat>
  205249:	83 c4 10             	add    $0x10,%esp
  20524c:	89 44 24 18          	mov    %eax,0x18(%esp)
  205250:	83 7c 24 18 ff       	cmpl   $0xffffffff,0x18(%esp)
  205255:	75 12                	jne    205269 <f_lseek+0x20a>
  205257:	8b 44 24 30          	mov    0x30(%esp),%eax
  20525b:	c6 40 11 01          	movb   $0x1,0x11(%eax)
  20525f:	b8 01 00 00 00       	mov    $0x1,%eax
  205264:	e9 f9 00 00 00       	jmp    205362 <f_lseek+0x303>
  205269:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
  20526e:	76 0d                	jbe    20527d <f_lseek+0x21e>
  205270:	8b 44 24 08          	mov    0x8(%esp),%eax
  205274:	8b 40 18             	mov    0x18(%eax),%eax
  205277:	39 44 24 18          	cmp    %eax,0x18(%esp)
  20527b:	72 12                	jb     20528f <f_lseek+0x230>
  20527d:	8b 44 24 30          	mov    0x30(%esp),%eax
  205281:	c6 40 11 02          	movb   $0x2,0x11(%eax)
  205285:	b8 02 00 00 00       	mov    $0x2,%eax
  20528a:	e9 d3 00 00 00       	jmp    205362 <f_lseek+0x303>
  20528f:	8b 44 24 30          	mov    0x30(%esp),%eax
  205293:	8b 54 24 18          	mov    0x18(%esp),%edx
  205297:	89 50 18             	mov    %edx,0x18(%eax)
  20529a:	8b 44 24 34          	mov    0x34(%esp),%eax
  20529e:	39 44 24 0c          	cmp    %eax,0xc(%esp)
  2052a2:	0f 82 39 ff ff ff    	jb     2051e1 <f_lseek+0x182>
  2052a8:	8b 44 24 30          	mov    0x30(%esp),%eax
  2052ac:	8b 50 14             	mov    0x14(%eax),%edx
  2052af:	8b 44 24 34          	mov    0x34(%esp),%eax
  2052b3:	01 c2                	add    %eax,%edx
  2052b5:	8b 44 24 30          	mov    0x30(%esp),%eax
  2052b9:	89 50 14             	mov    %edx,0x14(%eax)
  2052bc:	8b 44 24 34          	mov    0x34(%esp),%eax
  2052c0:	25 ff 01 00 00       	and    $0x1ff,%eax
  2052c5:	85 c0                	test   %eax,%eax
  2052c7:	74 39                	je     205302 <f_lseek+0x2a3>
  2052c9:	8b 44 24 08          	mov    0x8(%esp),%eax
  2052cd:	83 ec 08             	sub    $0x8,%esp
  2052d0:	ff 74 24 20          	push   0x20(%esp)
  2052d4:	50                   	push   %eax
  2052d5:	e8 89 c1 ff ff       	call   201463 <clst2sect>
  2052da:	83 c4 10             	add    $0x10,%esp
  2052dd:	89 44 24 14          	mov    %eax,0x14(%esp)
  2052e1:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  2052e6:	75 0f                	jne    2052f7 <f_lseek+0x298>
  2052e8:	8b 44 24 30          	mov    0x30(%esp),%eax
  2052ec:	c6 40 11 02          	movb   $0x2,0x11(%eax)
  2052f0:	b8 02 00 00 00       	mov    $0x2,%eax
  2052f5:	eb 6b                	jmp    205362 <f_lseek+0x303>
  2052f7:	8b 44 24 34          	mov    0x34(%esp),%eax
  2052fb:	c1 e8 09             	shr    $0x9,%eax
  2052fe:	01 44 24 14          	add    %eax,0x14(%esp)
  205302:	8b 44 24 30          	mov    0x30(%esp),%eax
  205306:	8b 40 14             	mov    0x14(%eax),%eax
  205309:	8b 54 24 30          	mov    0x30(%esp),%edx
  20530d:	8b 52 0c             	mov    0xc(%edx),%edx
  205310:	39 c2                	cmp    %eax,%edx
  205312:	73 22                	jae    205336 <f_lseek+0x2d7>
  205314:	8b 44 24 30          	mov    0x30(%esp),%eax
  205318:	8b 50 14             	mov    0x14(%eax),%edx
  20531b:	8b 44 24 30          	mov    0x30(%esp),%eax
  20531f:	89 50 0c             	mov    %edx,0xc(%eax)
  205322:	8b 44 24 30          	mov    0x30(%esp),%eax
  205326:	0f b6 40 10          	movzbl 0x10(%eax),%eax
  20532a:	83 c8 40             	or     $0x40,%eax
  20532d:	89 c2                	mov    %eax,%edx
  20532f:	8b 44 24 30          	mov    0x30(%esp),%eax
  205333:	88 50 10             	mov    %dl,0x10(%eax)
  205336:	8b 44 24 30          	mov    0x30(%esp),%eax
  20533a:	8b 40 14             	mov    0x14(%eax),%eax
  20533d:	25 ff 01 00 00       	and    $0x1ff,%eax
  205342:	85 c0                	test   %eax,%eax
  205344:	74 18                	je     20535e <f_lseek+0x2ff>
  205346:	8b 44 24 30          	mov    0x30(%esp),%eax
  20534a:	8b 40 1c             	mov    0x1c(%eax),%eax
  20534d:	39 44 24 14          	cmp    %eax,0x14(%esp)
  205351:	74 0b                	je     20535e <f_lseek+0x2ff>
  205353:	8b 44 24 30          	mov    0x30(%esp),%eax
  205357:	8b 54 24 14          	mov    0x14(%esp),%edx
  20535b:	89 50 1c             	mov    %edx,0x1c(%eax)
  20535e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  205362:	83 c4 2c             	add    $0x2c,%esp
  205365:	c3                   	ret

00205366 <f_opendir>:
  205366:	83 ec 1c             	sub    $0x1c,%esp
  205369:	83 7c 24 20 00       	cmpl   $0x0,0x20(%esp)
  20536e:	75 0a                	jne    20537a <f_opendir+0x14>
  205370:	b8 09 00 00 00       	mov    $0x9,%eax
  205375:	e9 e6 00 00 00       	jmp    205460 <f_opendir+0xfa>
  20537a:	83 ec 04             	sub    $0x4,%esp
  20537d:	6a 00                	push   $0x0
  20537f:	8d 44 24 10          	lea    0x10(%esp),%eax
  205383:	50                   	push   %eax
  205384:	8d 44 24 30          	lea    0x30(%esp),%eax
  205388:	50                   	push   %eax
  205389:	e8 67 e8 ff ff       	call   203bf5 <mount_volume>
  20538e:	83 c4 10             	add    $0x10,%esp
  205391:	89 44 24 0c          	mov    %eax,0xc(%esp)
  205395:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  20539a:	0f 85 ab 00 00 00    	jne    20544b <f_opendir+0xe5>
  2053a0:	8b 54 24 08          	mov    0x8(%esp),%edx
  2053a4:	8b 44 24 20          	mov    0x20(%esp),%eax
  2053a8:	89 10                	mov    %edx,(%eax)
  2053aa:	8b 44 24 24          	mov    0x24(%esp),%eax
  2053ae:	83 ec 08             	sub    $0x8,%esp
  2053b1:	50                   	push   %eax
  2053b2:	ff 74 24 2c          	push   0x2c(%esp)
  2053b6:	e8 8a e3 ff ff       	call   203745 <follow_path>
  2053bb:	83 c4 10             	add    $0x10,%esp
  2053be:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2053c2:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  2053c7:	75 73                	jne    20543c <f_opendir+0xd6>
  2053c9:	8b 44 24 20          	mov    0x20(%esp),%eax
  2053cd:	0f b6 40 2b          	movzbl 0x2b(%eax),%eax
  2053d1:	84 c0                	test   %al,%al
  2053d3:	78 3b                	js     205410 <f_opendir+0xaa>
  2053d5:	8b 44 24 20          	mov    0x20(%esp),%eax
  2053d9:	0f b6 40 06          	movzbl 0x6(%eax),%eax
  2053dd:	0f b6 c0             	movzbl %al,%eax
  2053e0:	83 e0 10             	and    $0x10,%eax
  2053e3:	85 c0                	test   %eax,%eax
  2053e5:	74 21                	je     205408 <f_opendir+0xa2>
  2053e7:	8b 44 24 20          	mov    0x20(%esp),%eax
  2053eb:	8b 50 1c             	mov    0x1c(%eax),%edx
  2053ee:	8b 44 24 08          	mov    0x8(%esp),%eax
  2053f2:	83 ec 08             	sub    $0x8,%esp
  2053f5:	52                   	push   %edx
  2053f6:	50                   	push   %eax
  2053f7:	e8 aa cd ff ff       	call   2021a6 <ld_clust>
  2053fc:	83 c4 10             	add    $0x10,%esp
  2053ff:	8b 54 24 20          	mov    0x20(%esp),%edx
  205403:	89 42 08             	mov    %eax,0x8(%edx)
  205406:	eb 08                	jmp    205410 <f_opendir+0xaa>
  205408:	c7 44 24 0c 05 00 00 	movl   $0x5,0xc(%esp)
  20540f:	00 
  205410:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  205415:	75 25                	jne    20543c <f_opendir+0xd6>
  205417:	8b 44 24 08          	mov    0x8(%esp),%eax
  20541b:	0f b7 50 06          	movzwl 0x6(%eax),%edx
  20541f:	8b 44 24 20          	mov    0x20(%esp),%eax
  205423:	66 89 50 04          	mov    %dx,0x4(%eax)
  205427:	83 ec 08             	sub    $0x8,%esp
  20542a:	6a 00                	push   $0x0
  20542c:	ff 74 24 2c          	push   0x2c(%esp)
  205430:	e8 56 c9 ff ff       	call   201d8b <dir_sdi>
  205435:	83 c4 10             	add    $0x10,%esp
  205438:	89 44 24 0c          	mov    %eax,0xc(%esp)
  20543c:	83 7c 24 0c 04       	cmpl   $0x4,0xc(%esp)
  205441:	75 08                	jne    20544b <f_opendir+0xe5>
  205443:	c7 44 24 0c 05 00 00 	movl   $0x5,0xc(%esp)
  20544a:	00 
  20544b:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  205450:	74 0a                	je     20545c <f_opendir+0xf6>
  205452:	8b 44 24 20          	mov    0x20(%esp),%eax
  205456:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  20545c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  205460:	83 c4 1c             	add    $0x1c,%esp
  205463:	c3                   	ret

00205464 <f_closedir>:
  205464:	83 ec 1c             	sub    $0x1c,%esp
  205467:	8b 44 24 20          	mov    0x20(%esp),%eax
  20546b:	83 ec 08             	sub    $0x8,%esp
  20546e:	8d 54 24 10          	lea    0x10(%esp),%edx
  205472:	52                   	push   %edx
  205473:	50                   	push   %eax
  205474:	e8 9c ed ff ff       	call   204215 <validate>
  205479:	83 c4 10             	add    $0x10,%esp
  20547c:	89 44 24 0c          	mov    %eax,0xc(%esp)
  205480:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  205485:	75 0a                	jne    205491 <f_closedir+0x2d>
  205487:	8b 44 24 20          	mov    0x20(%esp),%eax
  20548b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  205491:	8b 44 24 0c          	mov    0xc(%esp),%eax
  205495:	83 c4 1c             	add    $0x1c,%esp
  205498:	c3                   	ret

00205499 <f_readdir>:
  205499:	83 ec 1c             	sub    $0x1c,%esp
  20549c:	8b 44 24 20          	mov    0x20(%esp),%eax
  2054a0:	83 ec 08             	sub    $0x8,%esp
  2054a3:	8d 54 24 10          	lea    0x10(%esp),%edx
  2054a7:	52                   	push   %edx
  2054a8:	50                   	push   %eax
  2054a9:	e8 67 ed ff ff       	call   204215 <validate>
  2054ae:	83 c4 10             	add    $0x10,%esp
  2054b1:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2054b5:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  2054ba:	0f 85 88 00 00 00    	jne    205548 <f_readdir+0xaf>
  2054c0:	83 7c 24 24 00       	cmpl   $0x0,0x24(%esp)
  2054c5:	75 17                	jne    2054de <f_readdir+0x45>
  2054c7:	83 ec 08             	sub    $0x8,%esp
  2054ca:	6a 00                	push   $0x0
  2054cc:	ff 74 24 2c          	push   0x2c(%esp)
  2054d0:	e8 b6 c8 ff ff       	call   201d8b <dir_sdi>
  2054d5:	83 c4 10             	add    $0x10,%esp
  2054d8:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2054dc:	eb 6a                	jmp    205548 <f_readdir+0xaf>
  2054de:	8b 44 24 24          	mov    0x24(%esp),%eax
  2054e2:	c6 40 16 00          	movb   $0x0,0x16(%eax)
  2054e6:	83 ec 08             	sub    $0x8,%esp
  2054e9:	6a 00                	push   $0x0
  2054eb:	ff 74 24 2c          	push   0x2c(%esp)
  2054ef:	e8 6f d2 ff ff       	call   202763 <dir_read>
  2054f4:	83 c4 10             	add    $0x10,%esp
  2054f7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2054fb:	83 7c 24 0c 04       	cmpl   $0x4,0xc(%esp)
  205500:	75 08                	jne    20550a <f_readdir+0x71>
  205502:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  205509:	00 
  20550a:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  20550f:	75 37                	jne    205548 <f_readdir+0xaf>
  205511:	83 ec 08             	sub    $0x8,%esp
  205514:	ff 74 24 2c          	push   0x2c(%esp)
  205518:	ff 74 24 2c          	push   0x2c(%esp)
  20551c:	e8 9f d9 ff ff       	call   202ec0 <get_fileinfo>
  205521:	83 c4 10             	add    $0x10,%esp
  205524:	83 ec 08             	sub    $0x8,%esp
  205527:	6a 00                	push   $0x0
  205529:	ff 74 24 2c          	push   0x2c(%esp)
  20552d:	e8 ce c9 ff ff       	call   201f00 <dir_next>
  205532:	83 c4 10             	add    $0x10,%esp
  205535:	89 44 24 0c          	mov    %eax,0xc(%esp)
  205539:	83 7c 24 0c 04       	cmpl   $0x4,0xc(%esp)
  20553e:	75 08                	jne    205548 <f_readdir+0xaf>
  205540:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  205547:	00 
  205548:	83 7c 24 24 00       	cmpl   $0x0,0x24(%esp)
  20554d:	74 0f                	je     20555e <f_readdir+0xc5>
  20554f:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  205554:	74 08                	je     20555e <f_readdir+0xc5>
  205556:	8b 44 24 24          	mov    0x24(%esp),%eax
  20555a:	c6 40 16 00          	movb   $0x0,0x16(%eax)
  20555e:	8b 44 24 0c          	mov    0xc(%esp),%eax
  205562:	83 c4 1c             	add    $0x1c,%esp
  205565:	c3                   	ret

00205566 <f_stat>:
  205566:	83 ec 4c             	sub    $0x4c,%esp
  205569:	83 ec 04             	sub    $0x4,%esp
  20556c:	6a 00                	push   $0x0
  20556e:	8d 44 24 14          	lea    0x14(%esp),%eax
  205572:	50                   	push   %eax
  205573:	8d 44 24 5c          	lea    0x5c(%esp),%eax
  205577:	50                   	push   %eax
  205578:	e8 78 e6 ff ff       	call   203bf5 <mount_volume>
  20557d:	83 c4 10             	add    $0x10,%esp
  205580:	89 44 24 3c          	mov    %eax,0x3c(%esp)
  205584:	83 7c 24 3c 00       	cmpl   $0x0,0x3c(%esp)
  205589:	75 4e                	jne    2055d9 <f_stat+0x73>
  20558b:	8b 44 24 50          	mov    0x50(%esp),%eax
  20558f:	83 ec 08             	sub    $0x8,%esp
  205592:	50                   	push   %eax
  205593:	8d 44 24 18          	lea    0x18(%esp),%eax
  205597:	50                   	push   %eax
  205598:	e8 a8 e1 ff ff       	call   203745 <follow_path>
  20559d:	83 c4 10             	add    $0x10,%esp
  2055a0:	89 44 24 3c          	mov    %eax,0x3c(%esp)
  2055a4:	83 7c 24 3c 00       	cmpl   $0x0,0x3c(%esp)
  2055a9:	75 2e                	jne    2055d9 <f_stat+0x73>
  2055ab:	0f b6 44 24 37       	movzbl 0x37(%esp),%eax
  2055b0:	84 c0                	test   %al,%al
  2055b2:	79 0a                	jns    2055be <f_stat+0x58>
  2055b4:	c7 44 24 3c 06 00 00 	movl   $0x6,0x3c(%esp)
  2055bb:	00 
  2055bc:	eb 1b                	jmp    2055d9 <f_stat+0x73>
  2055be:	83 7c 24 54 00       	cmpl   $0x0,0x54(%esp)
  2055c3:	74 14                	je     2055d9 <f_stat+0x73>
  2055c5:	83 ec 08             	sub    $0x8,%esp
  2055c8:	ff 74 24 5c          	push   0x5c(%esp)
  2055cc:	8d 44 24 18          	lea    0x18(%esp),%eax
  2055d0:	50                   	push   %eax
  2055d1:	e8 ea d8 ff ff       	call   202ec0 <get_fileinfo>
  2055d6:	83 c4 10             	add    $0x10,%esp
  2055d9:	83 7c 24 54 00       	cmpl   $0x0,0x54(%esp)
  2055de:	74 0f                	je     2055ef <f_stat+0x89>
  2055e0:	83 7c 24 3c 00       	cmpl   $0x0,0x3c(%esp)
  2055e5:	74 08                	je     2055ef <f_stat+0x89>
  2055e7:	8b 44 24 54          	mov    0x54(%esp),%eax
  2055eb:	c6 40 16 00          	movb   $0x0,0x16(%eax)
  2055ef:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  2055f3:	83 c4 4c             	add    $0x4c,%esp
  2055f6:	c3                   	ret

002055f7 <f_getfree>:
  2055f7:	83 ec 3c             	sub    $0x3c,%esp
  2055fa:	83 ec 04             	sub    $0x4,%esp
  2055fd:	6a 00                	push   $0x0
  2055ff:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  205603:	50                   	push   %eax
  205604:	8d 44 24 4c          	lea    0x4c(%esp),%eax
  205608:	50                   	push   %eax
  205609:	e8 e7 e5 ff ff       	call   203bf5 <mount_volume>
  20560e:	83 c4 10             	add    $0x10,%esp
  205611:	89 44 24 2c          	mov    %eax,0x2c(%esp)
  205615:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
  20561a:	0f 85 ad 01 00 00    	jne    2057cd <f_getfree+0x1d6>
  205620:	8b 54 24 14          	mov    0x14(%esp),%edx
  205624:	8b 44 24 48          	mov    0x48(%esp),%eax
  205628:	89 10                	mov    %edx,(%eax)
  20562a:	8b 44 24 14          	mov    0x14(%esp),%eax
  20562e:	8b 40 14             	mov    0x14(%eax),%eax
  205631:	8b 54 24 14          	mov    0x14(%esp),%edx
  205635:	8b 52 18             	mov    0x18(%edx),%edx
  205638:	83 ea 02             	sub    $0x2,%edx
  20563b:	39 c2                	cmp    %eax,%edx
  20563d:	72 12                	jb     205651 <f_getfree+0x5a>
  20563f:	8b 44 24 14          	mov    0x14(%esp),%eax
  205643:	8b 50 14             	mov    0x14(%eax),%edx
  205646:	8b 44 24 44          	mov    0x44(%esp),%eax
  20564a:	89 10                	mov    %edx,(%eax)
  20564c:	e9 7c 01 00 00       	jmp    2057cd <f_getfree+0x1d6>
  205651:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  205658:	00 
  205659:	8b 44 24 14          	mov    0x14(%esp),%eax
  20565d:	0f b6 00             	movzbl (%eax),%eax
  205660:	3c 01                	cmp    $0x1,%al
  205662:	75 73                	jne    2056d7 <f_getfree+0xe0>
  205664:	c7 44 24 24 02 00 00 	movl   $0x2,0x24(%esp)
  20566b:	00 
  20566c:	8b 44 24 14          	mov    0x14(%esp),%eax
  205670:	89 44 24 04          	mov    %eax,0x4(%esp)
  205674:	83 ec 08             	sub    $0x8,%esp
  205677:	ff 74 24 2c          	push   0x2c(%esp)
  20567b:	8d 44 24 10          	lea    0x10(%esp),%eax
  20567f:	50                   	push   %eax
  205680:	e8 13 be ff ff       	call   201498 <get_fat>
  205685:	83 c4 10             	add    $0x10,%esp
  205688:	89 44 24 18          	mov    %eax,0x18(%esp)
  20568c:	83 7c 24 18 ff       	cmpl   $0xffffffff,0x18(%esp)
  205691:	75 0d                	jne    2056a0 <f_getfree+0xa9>
  205693:	c7 44 24 2c 01 00 00 	movl   $0x1,0x2c(%esp)
  20569a:	00 
  20569b:	e9 ff 00 00 00       	jmp    20579f <f_getfree+0x1a8>
  2056a0:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
  2056a5:	75 0d                	jne    2056b4 <f_getfree+0xbd>
  2056a7:	c7 44 24 2c 02 00 00 	movl   $0x2,0x2c(%esp)
  2056ae:	00 
  2056af:	e9 eb 00 00 00       	jmp    20579f <f_getfree+0x1a8>
  2056b4:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  2056b9:	75 05                	jne    2056c0 <f_getfree+0xc9>
  2056bb:	83 44 24 28 01       	addl   $0x1,0x28(%esp)
  2056c0:	83 44 24 24 01       	addl   $0x1,0x24(%esp)
  2056c5:	8b 44 24 14          	mov    0x14(%esp),%eax
  2056c9:	8b 40 18             	mov    0x18(%eax),%eax
  2056cc:	39 44 24 24          	cmp    %eax,0x24(%esp)
  2056d0:	72 a2                	jb     205674 <f_getfree+0x7d>
  2056d2:	e9 c8 00 00 00       	jmp    20579f <f_getfree+0x1a8>
  2056d7:	8b 44 24 14          	mov    0x14(%esp),%eax
  2056db:	8b 40 18             	mov    0x18(%eax),%eax
  2056de:	89 44 24 24          	mov    %eax,0x24(%esp)
  2056e2:	8b 44 24 14          	mov    0x14(%esp),%eax
  2056e6:	8b 40 28             	mov    0x28(%eax),%eax
  2056e9:	89 44 24 20          	mov    %eax,0x20(%esp)
  2056ed:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  2056f4:	00 
  2056f5:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  2056fa:	75 27                	jne    205723 <f_getfree+0x12c>
  2056fc:	8b 44 24 20          	mov    0x20(%esp),%eax
  205700:	8d 50 01             	lea    0x1(%eax),%edx
  205703:	89 54 24 20          	mov    %edx,0x20(%esp)
  205707:	8b 54 24 14          	mov    0x14(%esp),%edx
  20570b:	83 ec 08             	sub    $0x8,%esp
  20570e:	50                   	push   %eax
  20570f:	52                   	push   %edx
  205710:	e8 77 bb ff ff       	call   20128c <move_window>
  205715:	83 c4 10             	add    $0x10,%esp
  205718:	89 44 24 2c          	mov    %eax,0x2c(%esp)
  20571c:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
  205721:	75 7b                	jne    20579e <f_getfree+0x1a7>
  205723:	8b 44 24 14          	mov    0x14(%esp),%eax
  205727:	0f b6 00             	movzbl (%eax),%eax
  20572a:	3c 02                	cmp    $0x2,%al
  20572c:	75 2a                	jne    205758 <f_getfree+0x161>
  20572e:	8b 44 24 14          	mov    0x14(%esp),%eax
  205732:	8d 50 34             	lea    0x34(%eax),%edx
  205735:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  205739:	01 d0                	add    %edx,%eax
  20573b:	83 ec 0c             	sub    $0xc,%esp
  20573e:	50                   	push   %eax
  20573f:	e8 c2 b5 ff ff       	call   200d06 <ld_16>
  205744:	83 c4 10             	add    $0x10,%esp
  205747:	66 85 c0             	test   %ax,%ax
  20574a:	75 05                	jne    205751 <f_getfree+0x15a>
  20574c:	83 44 24 28 01       	addl   $0x1,0x28(%esp)
  205751:	83 44 24 1c 02       	addl   $0x2,0x1c(%esp)
  205756:	eb 2c                	jmp    205784 <f_getfree+0x18d>
  205758:	8b 44 24 14          	mov    0x14(%esp),%eax
  20575c:	8d 50 34             	lea    0x34(%eax),%edx
  20575f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  205763:	01 d0                	add    %edx,%eax
  205765:	83 ec 0c             	sub    $0xc,%esp
  205768:	50                   	push   %eax
  205769:	e8 d1 b5 ff ff       	call   200d3f <ld_32>
  20576e:	83 c4 10             	add    $0x10,%esp
  205771:	25 ff ff ff 0f       	and    $0xfffffff,%eax
  205776:	85 c0                	test   %eax,%eax
  205778:	75 05                	jne    20577f <f_getfree+0x188>
  20577a:	83 44 24 28 01       	addl   $0x1,0x28(%esp)
  20577f:	83 44 24 1c 04       	addl   $0x4,0x1c(%esp)
  205784:	81 64 24 1c ff 01 00 	andl   $0x1ff,0x1c(%esp)
  20578b:	00 
  20578c:	83 6c 24 24 01       	subl   $0x1,0x24(%esp)
  205791:	83 7c 24 24 00       	cmpl   $0x0,0x24(%esp)
  205796:	0f 85 59 ff ff ff    	jne    2056f5 <f_getfree+0xfe>
  20579c:	eb 01                	jmp    20579f <f_getfree+0x1a8>
  20579e:	90                   	nop
  20579f:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
  2057a4:	75 27                	jne    2057cd <f_getfree+0x1d6>
  2057a6:	8b 44 24 44          	mov    0x44(%esp),%eax
  2057aa:	8b 54 24 28          	mov    0x28(%esp),%edx
  2057ae:	89 10                	mov    %edx,(%eax)
  2057b0:	8b 44 24 14          	mov    0x14(%esp),%eax
  2057b4:	8b 54 24 28          	mov    0x28(%esp),%edx
  2057b8:	89 50 14             	mov    %edx,0x14(%eax)
  2057bb:	8b 44 24 14          	mov    0x14(%esp),%eax
  2057bf:	0f b6 50 05          	movzbl 0x5(%eax),%edx
  2057c3:	8b 44 24 14          	mov    0x14(%esp),%eax
  2057c7:	83 ca 01             	or     $0x1,%edx
  2057ca:	88 50 05             	mov    %dl,0x5(%eax)
  2057cd:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  2057d1:	83 c4 3c             	add    $0x3c,%esp
  2057d4:	c3                   	ret

002057d5 <f_truncate>:
  2057d5:	83 ec 1c             	sub    $0x1c,%esp
  2057d8:	8b 44 24 20          	mov    0x20(%esp),%eax
  2057dc:	83 ec 08             	sub    $0x8,%esp
  2057df:	8d 54 24 0c          	lea    0xc(%esp),%edx
  2057e3:	52                   	push   %edx
  2057e4:	50                   	push   %eax
  2057e5:	e8 2b ea ff ff       	call   204215 <validate>
  2057ea:	83 c4 10             	add    $0x10,%esp
  2057ed:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2057f1:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  2057f6:	75 16                	jne    20580e <f_truncate+0x39>
  2057f8:	8b 44 24 20          	mov    0x20(%esp),%eax
  2057fc:	0f b6 40 11          	movzbl 0x11(%eax),%eax
  205800:	0f b6 c0             	movzbl %al,%eax
  205803:	89 44 24 0c          	mov    %eax,0xc(%esp)
  205807:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  20580c:	74 09                	je     205817 <f_truncate+0x42>
  20580e:	8b 44 24 0c          	mov    0xc(%esp),%eax
  205812:	e9 1e 01 00 00       	jmp    205935 <f_truncate+0x160>
  205817:	8b 44 24 20          	mov    0x20(%esp),%eax
  20581b:	0f b6 40 10          	movzbl 0x10(%eax),%eax
  20581f:	0f b6 c0             	movzbl %al,%eax
  205822:	83 e0 02             	and    $0x2,%eax
  205825:	85 c0                	test   %eax,%eax
  205827:	75 0a                	jne    205833 <f_truncate+0x5e>
  205829:	b8 07 00 00 00       	mov    $0x7,%eax
  20582e:	e9 02 01 00 00       	jmp    205935 <f_truncate+0x160>
  205833:	8b 44 24 20          	mov    0x20(%esp),%eax
  205837:	8b 50 14             	mov    0x14(%eax),%edx
  20583a:	8b 44 24 20          	mov    0x20(%esp),%eax
  20583e:	8b 40 0c             	mov    0xc(%eax),%eax
  205841:	39 c2                	cmp    %eax,%edx
  205843:	0f 83 e8 00 00 00    	jae    205931 <f_truncate+0x15c>
  205849:	8b 44 24 20          	mov    0x20(%esp),%eax
  20584d:	8b 40 14             	mov    0x14(%eax),%eax
  205850:	85 c0                	test   %eax,%eax
  205852:	75 2b                	jne    20587f <f_truncate+0xaa>
  205854:	8b 44 24 20          	mov    0x20(%esp),%eax
  205858:	8b 50 08             	mov    0x8(%eax),%edx
  20585b:	8b 44 24 20          	mov    0x20(%esp),%eax
  20585f:	83 ec 04             	sub    $0x4,%esp
  205862:	6a 00                	push   $0x0
  205864:	52                   	push   %edx
  205865:	50                   	push   %eax
  205866:	e8 98 c0 ff ff       	call   201903 <remove_chain>
  20586b:	83 c4 10             	add    $0x10,%esp
  20586e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  205872:	8b 44 24 20          	mov    0x20(%esp),%eax
  205876:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  20587d:	eb 76                	jmp    2058f5 <f_truncate+0x120>
  20587f:	8b 44 24 20          	mov    0x20(%esp),%eax
  205883:	8b 50 18             	mov    0x18(%eax),%edx
  205886:	8b 44 24 20          	mov    0x20(%esp),%eax
  20588a:	83 ec 08             	sub    $0x8,%esp
  20588d:	52                   	push   %edx
  20588e:	50                   	push   %eax
  20588f:	e8 04 bc ff ff       	call   201498 <get_fat>
  205894:	83 c4 10             	add    $0x10,%esp
  205897:	89 44 24 08          	mov    %eax,0x8(%esp)
  20589b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  2058a2:	00 
  2058a3:	83 7c 24 08 ff       	cmpl   $0xffffffff,0x8(%esp)
  2058a8:	75 08                	jne    2058b2 <f_truncate+0xdd>
  2058aa:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
  2058b1:	00 
  2058b2:	83 7c 24 08 01       	cmpl   $0x1,0x8(%esp)
  2058b7:	75 08                	jne    2058c1 <f_truncate+0xec>
  2058b9:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
  2058c0:	00 
  2058c1:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  2058c6:	75 2d                	jne    2058f5 <f_truncate+0x120>
  2058c8:	8b 44 24 04          	mov    0x4(%esp),%eax
  2058cc:	8b 40 18             	mov    0x18(%eax),%eax
  2058cf:	39 44 24 08          	cmp    %eax,0x8(%esp)
  2058d3:	73 20                	jae    2058f5 <f_truncate+0x120>
  2058d5:	8b 44 24 20          	mov    0x20(%esp),%eax
  2058d9:	8b 50 18             	mov    0x18(%eax),%edx
  2058dc:	8b 44 24 20          	mov    0x20(%esp),%eax
  2058e0:	83 ec 04             	sub    $0x4,%esp
  2058e3:	52                   	push   %edx
  2058e4:	ff 74 24 10          	push   0x10(%esp)
  2058e8:	50                   	push   %eax
  2058e9:	e8 15 c0 ff ff       	call   201903 <remove_chain>
  2058ee:	83 c4 10             	add    $0x10,%esp
  2058f1:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2058f5:	8b 44 24 20          	mov    0x20(%esp),%eax
  2058f9:	8b 50 14             	mov    0x14(%eax),%edx
  2058fc:	8b 44 24 20          	mov    0x20(%esp),%eax
  205900:	89 50 0c             	mov    %edx,0xc(%eax)
  205903:	8b 44 24 20          	mov    0x20(%esp),%eax
  205907:	0f b6 40 10          	movzbl 0x10(%eax),%eax
  20590b:	83 c8 40             	or     $0x40,%eax
  20590e:	89 c2                	mov    %eax,%edx
  205910:	8b 44 24 20          	mov    0x20(%esp),%eax
  205914:	88 50 10             	mov    %dl,0x10(%eax)
  205917:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  20591c:	74 13                	je     205931 <f_truncate+0x15c>
  20591e:	8b 44 24 0c          	mov    0xc(%esp),%eax
  205922:	89 c2                	mov    %eax,%edx
  205924:	8b 44 24 20          	mov    0x20(%esp),%eax
  205928:	88 50 11             	mov    %dl,0x11(%eax)
  20592b:	8b 44 24 0c          	mov    0xc(%esp),%eax
  20592f:	eb 04                	jmp    205935 <f_truncate+0x160>
  205931:	8b 44 24 0c          	mov    0xc(%esp),%eax
  205935:	83 c4 1c             	add    $0x1c,%esp
  205938:	c3                   	ret

00205939 <f_unlink>:
  205939:	83 ec 7c             	sub    $0x7c,%esp
  20593c:	c7 44 24 68 00 00 00 	movl   $0x0,0x68(%esp)
  205943:	00 
  205944:	83 ec 04             	sub    $0x4,%esp
  205947:	6a 02                	push   $0x2
  205949:	8d 44 24 6c          	lea    0x6c(%esp),%eax
  20594d:	50                   	push   %eax
  20594e:	8d 84 24 8c 00 00 00 	lea    0x8c(%esp),%eax
  205955:	50                   	push   %eax
  205956:	e8 9a e2 ff ff       	call   203bf5 <mount_volume>
  20595b:	83 c4 10             	add    $0x10,%esp
  20595e:	89 44 24 6c          	mov    %eax,0x6c(%esp)
  205962:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  205967:	0f 85 4f 01 00 00    	jne    205abc <f_unlink+0x183>
  20596d:	8b 44 24 64          	mov    0x64(%esp),%eax
  205971:	89 44 24 34          	mov    %eax,0x34(%esp)
  205975:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  20597c:	83 ec 08             	sub    $0x8,%esp
  20597f:	50                   	push   %eax
  205980:	8d 44 24 40          	lea    0x40(%esp),%eax
  205984:	50                   	push   %eax
  205985:	e8 bb dd ff ff       	call   203745 <follow_path>
  20598a:	83 c4 10             	add    $0x10,%esp
  20598d:	89 44 24 6c          	mov    %eax,0x6c(%esp)
  205991:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  205996:	75 32                	jne    2059ca <f_unlink+0x91>
  205998:	0f b6 44 24 5f       	movzbl 0x5f(%esp),%eax
  20599d:	0f b6 c0             	movzbl %al,%eax
  2059a0:	25 a0 00 00 00       	and    $0xa0,%eax
  2059a5:	85 c0                	test   %eax,%eax
  2059a7:	74 0a                	je     2059b3 <f_unlink+0x7a>
  2059a9:	c7 44 24 6c 06 00 00 	movl   $0x6,0x6c(%esp)
  2059b0:	00 
  2059b1:	eb 17                	jmp    2059ca <f_unlink+0x91>
  2059b3:	0f b6 44 24 3a       	movzbl 0x3a(%esp),%eax
  2059b8:	0f b6 c0             	movzbl %al,%eax
  2059bb:	83 e0 01             	and    $0x1,%eax
  2059be:	85 c0                	test   %eax,%eax
  2059c0:	74 08                	je     2059ca <f_unlink+0x91>
  2059c2:	c7 44 24 6c 07 00 00 	movl   $0x7,0x6c(%esp)
  2059c9:	00 
  2059ca:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  2059cf:	0f 85 89 00 00 00    	jne    205a5e <f_unlink+0x125>
  2059d5:	8b 54 24 50          	mov    0x50(%esp),%edx
  2059d9:	8b 44 24 64          	mov    0x64(%esp),%eax
  2059dd:	83 ec 08             	sub    $0x8,%esp
  2059e0:	52                   	push   %edx
  2059e1:	50                   	push   %eax
  2059e2:	e8 bf c7 ff ff       	call   2021a6 <ld_clust>
  2059e7:	83 c4 10             	add    $0x10,%esp
  2059ea:	89 44 24 68          	mov    %eax,0x68(%esp)
  2059ee:	0f b6 44 24 3a       	movzbl 0x3a(%esp),%eax
  2059f3:	0f b6 c0             	movzbl %al,%eax
  2059f6:	83 e0 10             	and    $0x10,%eax
  2059f9:	85 c0                	test   %eax,%eax
  2059fb:	74 61                	je     205a5e <f_unlink+0x125>
  2059fd:	8b 44 24 64          	mov    0x64(%esp),%eax
  205a01:	89 44 24 04          	mov    %eax,0x4(%esp)
  205a05:	8b 44 24 68          	mov    0x68(%esp),%eax
  205a09:	89 44 24 0c          	mov    %eax,0xc(%esp)
  205a0d:	83 ec 08             	sub    $0x8,%esp
  205a10:	6a 00                	push   $0x0
  205a12:	8d 44 24 10          	lea    0x10(%esp),%eax
  205a16:	50                   	push   %eax
  205a17:	e8 6f c3 ff ff       	call   201d8b <dir_sdi>
  205a1c:	83 c4 10             	add    $0x10,%esp
  205a1f:	89 44 24 6c          	mov    %eax,0x6c(%esp)
  205a23:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  205a28:	75 34                	jne    205a5e <f_unlink+0x125>
  205a2a:	83 ec 08             	sub    $0x8,%esp
  205a2d:	6a 00                	push   $0x0
  205a2f:	8d 44 24 10          	lea    0x10(%esp),%eax
  205a33:	50                   	push   %eax
  205a34:	e8 2a cd ff ff       	call   202763 <dir_read>
  205a39:	83 c4 10             	add    $0x10,%esp
  205a3c:	89 44 24 6c          	mov    %eax,0x6c(%esp)
  205a40:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  205a45:	75 08                	jne    205a4f <f_unlink+0x116>
  205a47:	c7 44 24 6c 07 00 00 	movl   $0x7,0x6c(%esp)
  205a4e:	00 
  205a4f:	83 7c 24 6c 04       	cmpl   $0x4,0x6c(%esp)
  205a54:	75 08                	jne    205a5e <f_unlink+0x125>
  205a56:	c7 44 24 6c 00 00 00 	movl   $0x0,0x6c(%esp)
  205a5d:	00 
  205a5e:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  205a63:	75 57                	jne    205abc <f_unlink+0x183>
  205a65:	83 ec 0c             	sub    $0xc,%esp
  205a68:	8d 44 24 40          	lea    0x40(%esp),%eax
  205a6c:	50                   	push   %eax
  205a6d:	e8 84 d3 ff ff       	call   202df6 <dir_remove>
  205a72:	83 c4 10             	add    $0x10,%esp
  205a75:	89 44 24 6c          	mov    %eax,0x6c(%esp)
  205a79:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  205a7e:	75 21                	jne    205aa1 <f_unlink+0x168>
  205a80:	83 7c 24 68 00       	cmpl   $0x0,0x68(%esp)
  205a85:	74 1a                	je     205aa1 <f_unlink+0x168>
  205a87:	83 ec 04             	sub    $0x4,%esp
  205a8a:	6a 00                	push   $0x0
  205a8c:	ff 74 24 70          	push   0x70(%esp)
  205a90:	8d 44 24 40          	lea    0x40(%esp),%eax
  205a94:	50                   	push   %eax
  205a95:	e8 69 be ff ff       	call   201903 <remove_chain>
  205a9a:	83 c4 10             	add    $0x10,%esp
  205a9d:	89 44 24 6c          	mov    %eax,0x6c(%esp)
  205aa1:	83 7c 24 6c 00       	cmpl   $0x0,0x6c(%esp)
  205aa6:	75 14                	jne    205abc <f_unlink+0x183>
  205aa8:	8b 44 24 64          	mov    0x64(%esp),%eax
  205aac:	83 ec 0c             	sub    $0xc,%esp
  205aaf:	50                   	push   %eax
  205ab0:	e8 52 b8 ff ff       	call   201307 <sync_fs>
  205ab5:	83 c4 10             	add    $0x10,%esp
  205ab8:	89 44 24 6c          	mov    %eax,0x6c(%esp)
  205abc:	8b 44 24 6c          	mov    0x6c(%esp),%eax
  205ac0:	83 c4 7c             	add    $0x7c,%esp
  205ac3:	c3                   	ret

00205ac4 <f_mkdir>:
  205ac4:	83 ec 6c             	sub    $0x6c,%esp
  205ac7:	83 ec 04             	sub    $0x4,%esp
  205aca:	6a 02                	push   $0x2
  205acc:	8d 44 24 54          	lea    0x54(%esp),%eax
  205ad0:	50                   	push   %eax
  205ad1:	8d 44 24 7c          	lea    0x7c(%esp),%eax
  205ad5:	50                   	push   %eax
  205ad6:	e8 1a e1 ff ff       	call   203bf5 <mount_volume>
  205adb:	83 c4 10             	add    $0x10,%esp
  205ade:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  205ae2:	83 7c 24 5c 00       	cmpl   $0x0,0x5c(%esp)
  205ae7:	0f 85 3a 02 00 00    	jne    205d27 <f_mkdir+0x263>
  205aed:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205af1:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  205af5:	8b 44 24 70          	mov    0x70(%esp),%eax
  205af9:	83 ec 08             	sub    $0x8,%esp
  205afc:	50                   	push   %eax
  205afd:	8d 44 24 28          	lea    0x28(%esp),%eax
  205b01:	50                   	push   %eax
  205b02:	e8 3e dc ff ff       	call   203745 <follow_path>
  205b07:	83 c4 10             	add    $0x10,%esp
  205b0a:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  205b0e:	83 7c 24 5c 00       	cmpl   $0x0,0x5c(%esp)
  205b13:	75 23                	jne    205b38 <f_mkdir+0x74>
  205b15:	0f b6 44 24 47       	movzbl 0x47(%esp),%eax
  205b1a:	0f b6 c0             	movzbl %al,%eax
  205b1d:	25 a0 00 00 00       	and    $0xa0,%eax
  205b22:	85 c0                	test   %eax,%eax
  205b24:	74 0a                	je     205b30 <f_mkdir+0x6c>
  205b26:	c7 44 24 5c 06 00 00 	movl   $0x6,0x5c(%esp)
  205b2d:	00 
  205b2e:	eb 08                	jmp    205b38 <f_mkdir+0x74>
  205b30:	c7 44 24 5c 08 00 00 	movl   $0x8,0x5c(%esp)
  205b37:	00 
  205b38:	83 7c 24 5c 04       	cmpl   $0x4,0x5c(%esp)
  205b3d:	0f 85 e4 01 00 00    	jne    205d27 <f_mkdir+0x263>
  205b43:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205b47:	89 44 24 0c          	mov    %eax,0xc(%esp)
  205b4b:	83 ec 08             	sub    $0x8,%esp
  205b4e:	6a 00                	push   $0x0
  205b50:	8d 44 24 18          	lea    0x18(%esp),%eax
  205b54:	50                   	push   %eax
  205b55:	e8 d5 be ff ff       	call   201a2f <create_chain>
  205b5a:	83 c4 10             	add    $0x10,%esp
  205b5d:	89 44 24 58          	mov    %eax,0x58(%esp)
  205b61:	c7 44 24 5c 00 00 00 	movl   $0x0,0x5c(%esp)
  205b68:	00 
  205b69:	83 7c 24 58 00       	cmpl   $0x0,0x58(%esp)
  205b6e:	75 08                	jne    205b78 <f_mkdir+0xb4>
  205b70:	c7 44 24 5c 07 00 00 	movl   $0x7,0x5c(%esp)
  205b77:	00 
  205b78:	83 7c 24 58 01       	cmpl   $0x1,0x58(%esp)
  205b7d:	75 08                	jne    205b87 <f_mkdir+0xc3>
  205b7f:	c7 44 24 5c 02 00 00 	movl   $0x2,0x5c(%esp)
  205b86:	00 
  205b87:	83 7c 24 58 ff       	cmpl   $0xffffffff,0x58(%esp)
  205b8c:	75 08                	jne    205b96 <f_mkdir+0xd2>
  205b8e:	c7 44 24 5c 01 00 00 	movl   $0x1,0x5c(%esp)
  205b95:	00 
  205b96:	c7 44 24 54 00 00 21 	movl   $0x5a210000,0x54(%esp)
  205b9d:	5a 
  205b9e:	83 7c 24 5c 00       	cmpl   $0x0,0x5c(%esp)
  205ba3:	0f 85 eb 00 00 00    	jne    205c94 <f_mkdir+0x1d0>
  205ba9:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205bad:	83 ec 08             	sub    $0x8,%esp
  205bb0:	ff 74 24 60          	push   0x60(%esp)
  205bb4:	50                   	push   %eax
  205bb5:	e8 fe c0 ff ff       	call   201cb8 <dir_clear>
  205bba:	83 c4 10             	add    $0x10,%esp
  205bbd:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  205bc1:	83 7c 24 5c 00       	cmpl   $0x0,0x5c(%esp)
  205bc6:	0f 85 c8 00 00 00    	jne    205c94 <f_mkdir+0x1d0>
  205bcc:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205bd0:	83 c0 34             	add    $0x34,%eax
  205bd3:	83 ec 04             	sub    $0x4,%esp
  205bd6:	6a 0b                	push   $0xb
  205bd8:	6a 20                	push   $0x20
  205bda:	50                   	push   %eax
  205bdb:	e8 2f 12 00 00       	call   206e0f <memset>
  205be0:	83 c4 10             	add    $0x10,%esp
  205be3:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205be7:	c6 40 34 2e          	movb   $0x2e,0x34(%eax)
  205beb:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205bef:	c6 40 3f 10          	movb   $0x10,0x3f(%eax)
  205bf3:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205bf7:	83 c0 34             	add    $0x34,%eax
  205bfa:	83 c0 16             	add    $0x16,%eax
  205bfd:	83 ec 08             	sub    $0x8,%esp
  205c00:	ff 74 24 5c          	push   0x5c(%esp)
  205c04:	50                   	push   %eax
  205c05:	e8 d9 b1 ff ff       	call   200de3 <st_32>
  205c0a:	83 c4 10             	add    $0x10,%esp
  205c0d:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205c11:	8d 50 34             	lea    0x34(%eax),%edx
  205c14:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205c18:	83 ec 04             	sub    $0x4,%esp
  205c1b:	ff 74 24 5c          	push   0x5c(%esp)
  205c1f:	52                   	push   %edx
  205c20:	50                   	push   %eax
  205c21:	e8 c7 c5 ff ff       	call   2021ed <st_clust>
  205c26:	83 c4 10             	add    $0x10,%esp
  205c29:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205c2d:	8d 50 34             	lea    0x34(%eax),%edx
  205c30:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205c34:	83 c0 34             	add    $0x34,%eax
  205c37:	83 c0 20             	add    $0x20,%eax
  205c3a:	83 ec 04             	sub    $0x4,%esp
  205c3d:	6a 20                	push   $0x20
  205c3f:	52                   	push   %edx
  205c40:	50                   	push   %eax
  205c41:	e8 fd 11 00 00       	call   206e43 <memcpy>
  205c46:	83 c4 10             	add    $0x10,%esp
  205c49:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205c4d:	c6 40 55 2e          	movb   $0x2e,0x55(%eax)
  205c51:	8b 44 24 24          	mov    0x24(%esp),%eax
  205c55:	89 44 24 50          	mov    %eax,0x50(%esp)
  205c59:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205c5d:	83 c0 34             	add    $0x34,%eax
  205c60:	8d 50 20             	lea    0x20(%eax),%edx
  205c63:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205c67:	83 ec 04             	sub    $0x4,%esp
  205c6a:	ff 74 24 54          	push   0x54(%esp)
  205c6e:	52                   	push   %edx
  205c6f:	50                   	push   %eax
  205c70:	e8 78 c5 ff ff       	call   2021ed <st_clust>
  205c75:	83 c4 10             	add    $0x10,%esp
  205c78:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205c7c:	c6 40 04 01          	movb   $0x1,0x4(%eax)
  205c80:	83 ec 0c             	sub    $0xc,%esp
  205c83:	8d 44 24 28          	lea    0x28(%esp),%eax
  205c87:	50                   	push   %eax
  205c88:	e8 b2 ce ff ff       	call   202b3f <dir_register>
  205c8d:	83 c4 10             	add    $0x10,%esp
  205c90:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  205c94:	83 7c 24 5c 00       	cmpl   $0x0,0x5c(%esp)
  205c99:	75 76                	jne    205d11 <f_mkdir+0x24d>
  205c9b:	8b 44 24 38          	mov    0x38(%esp),%eax
  205c9f:	83 c0 0e             	add    $0xe,%eax
  205ca2:	83 ec 08             	sub    $0x8,%esp
  205ca5:	ff 74 24 5c          	push   0x5c(%esp)
  205ca9:	50                   	push   %eax
  205caa:	e8 34 b1 ff ff       	call   200de3 <st_32>
  205caf:	83 c4 10             	add    $0x10,%esp
  205cb2:	8b 44 24 38          	mov    0x38(%esp),%eax
  205cb6:	83 c0 16             	add    $0x16,%eax
  205cb9:	83 ec 08             	sub    $0x8,%esp
  205cbc:	ff 74 24 5c          	push   0x5c(%esp)
  205cc0:	50                   	push   %eax
  205cc1:	e8 1d b1 ff ff       	call   200de3 <st_32>
  205cc6:	83 c4 10             	add    $0x10,%esp
  205cc9:	8b 54 24 38          	mov    0x38(%esp),%edx
  205ccd:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205cd1:	83 ec 04             	sub    $0x4,%esp
  205cd4:	ff 74 24 5c          	push   0x5c(%esp)
  205cd8:	52                   	push   %edx
  205cd9:	50                   	push   %eax
  205cda:	e8 0e c5 ff ff       	call   2021ed <st_clust>
  205cdf:	83 c4 10             	add    $0x10,%esp
  205ce2:	8b 44 24 38          	mov    0x38(%esp),%eax
  205ce6:	83 c0 0b             	add    $0xb,%eax
  205ce9:	c6 00 10             	movb   $0x10,(%eax)
  205cec:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205cf0:	c6 40 04 01          	movb   $0x1,0x4(%eax)
  205cf4:	83 7c 24 5c 00       	cmpl   $0x0,0x5c(%esp)
  205cf9:	75 2c                	jne    205d27 <f_mkdir+0x263>
  205cfb:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  205cff:	83 ec 0c             	sub    $0xc,%esp
  205d02:	50                   	push   %eax
  205d03:	e8 ff b5 ff ff       	call   201307 <sync_fs>
  205d08:	83 c4 10             	add    $0x10,%esp
  205d0b:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  205d0f:	eb 16                	jmp    205d27 <f_mkdir+0x263>
  205d11:	83 ec 04             	sub    $0x4,%esp
  205d14:	6a 00                	push   $0x0
  205d16:	ff 74 24 60          	push   0x60(%esp)
  205d1a:	8d 44 24 18          	lea    0x18(%esp),%eax
  205d1e:	50                   	push   %eax
  205d1f:	e8 df bb ff ff       	call   201903 <remove_chain>
  205d24:	83 c4 10             	add    $0x10,%esp
  205d27:	8b 44 24 5c          	mov    0x5c(%esp),%eax
  205d2b:	83 c4 6c             	add    $0x6c,%esp
  205d2e:	c3                   	ret

00205d2f <f_rename>:
  205d2f:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
  205d35:	8d 84 24 a4 00 00 00 	lea    0xa4(%esp),%eax
  205d3c:	50                   	push   %eax
  205d3d:	e8 39 db ff ff       	call   20387b <get_ldnumber>
  205d42:	83 c4 04             	add    $0x4,%esp
  205d45:	83 ec 04             	sub    $0x4,%esp
  205d48:	6a 02                	push   $0x2
  205d4a:	8d 84 24 88 00 00 00 	lea    0x88(%esp),%eax
  205d51:	50                   	push   %eax
  205d52:	8d 84 24 ac 00 00 00 	lea    0xac(%esp),%eax
  205d59:	50                   	push   %eax
  205d5a:	e8 96 de ff ff       	call   203bf5 <mount_volume>
  205d5f:	83 c4 10             	add    $0x10,%esp
  205d62:	89 84 24 8c 00 00 00 	mov    %eax,0x8c(%esp)
  205d69:	83 bc 24 8c 00 00 00 	cmpl   $0x0,0x8c(%esp)
  205d70:	00 
  205d71:	0f 85 c6 02 00 00    	jne    20603d <f_rename+0x30e>
  205d77:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  205d7e:	89 44 24 50          	mov    %eax,0x50(%esp)
  205d82:	8b 84 24 a0 00 00 00 	mov    0xa0(%esp),%eax
  205d89:	83 ec 08             	sub    $0x8,%esp
  205d8c:	50                   	push   %eax
  205d8d:	8d 44 24 5c          	lea    0x5c(%esp),%eax
  205d91:	50                   	push   %eax
  205d92:	e8 ae d9 ff ff       	call   203745 <follow_path>
  205d97:	83 c4 10             	add    $0x10,%esp
  205d9a:	89 84 24 8c 00 00 00 	mov    %eax,0x8c(%esp)
  205da1:	83 bc 24 8c 00 00 00 	cmpl   $0x0,0x8c(%esp)
  205da8:	00 
  205da9:	75 1c                	jne    205dc7 <f_rename+0x98>
  205dab:	0f b6 44 24 7b       	movzbl 0x7b(%esp),%eax
  205db0:	0f b6 c0             	movzbl %al,%eax
  205db3:	25 a0 00 00 00       	and    $0xa0,%eax
  205db8:	85 c0                	test   %eax,%eax
  205dba:	74 0b                	je     205dc7 <f_rename+0x98>
  205dbc:	c7 84 24 8c 00 00 00 	movl   $0x6,0x8c(%esp)
  205dc3:	06 00 00 00 
  205dc7:	83 bc 24 8c 00 00 00 	cmpl   $0x0,0x8c(%esp)
  205dce:	00 
  205dcf:	0f 85 68 02 00 00    	jne    20603d <f_rename+0x30e>
  205dd5:	8b 44 24 6c          	mov    0x6c(%esp),%eax
  205dd9:	83 ec 04             	sub    $0x4,%esp
  205ddc:	6a 20                	push   $0x20
  205dde:	50                   	push   %eax
  205ddf:	8d 44 24 0c          	lea    0xc(%esp),%eax
  205de3:	50                   	push   %eax
  205de4:	e8 5a 10 00 00       	call   206e43 <memcpy>
  205de9:	83 c4 10             	add    $0x10,%esp
  205dec:	83 ec 04             	sub    $0x4,%esp
  205def:	6a 30                	push   $0x30
  205df1:	8d 44 24 58          	lea    0x58(%esp),%eax
  205df5:	50                   	push   %eax
  205df6:	8d 44 24 2c          	lea    0x2c(%esp),%eax
  205dfa:	50                   	push   %eax
  205dfb:	e8 43 10 00 00       	call   206e43 <memcpy>
  205e00:	83 c4 10             	add    $0x10,%esp
  205e03:	8b 84 24 a4 00 00 00 	mov    0xa4(%esp),%eax
  205e0a:	83 ec 08             	sub    $0x8,%esp
  205e0d:	50                   	push   %eax
  205e0e:	8d 44 24 2c          	lea    0x2c(%esp),%eax
  205e12:	50                   	push   %eax
  205e13:	e8 2d d9 ff ff       	call   203745 <follow_path>
  205e18:	83 c4 10             	add    $0x10,%esp
  205e1b:	89 84 24 8c 00 00 00 	mov    %eax,0x8c(%esp)
  205e22:	83 bc 24 8c 00 00 00 	cmpl   $0x0,0x8c(%esp)
  205e29:	00 
  205e2a:	75 30                	jne    205e5c <f_rename+0x12d>
  205e2c:	8b 54 24 28          	mov    0x28(%esp),%edx
  205e30:	8b 44 24 58          	mov    0x58(%esp),%eax
  205e34:	39 c2                	cmp    %eax,%edx
  205e36:	75 19                	jne    205e51 <f_rename+0x122>
  205e38:	8b 54 24 30          	mov    0x30(%esp),%edx
  205e3c:	8b 44 24 60          	mov    0x60(%esp),%eax
  205e40:	39 c2                	cmp    %eax,%edx
  205e42:	75 0d                	jne    205e51 <f_rename+0x122>
  205e44:	c7 84 24 8c 00 00 00 	movl   $0x4,0x8c(%esp)
  205e4b:	04 00 00 00 
  205e4f:	eb 0b                	jmp    205e5c <f_rename+0x12d>
  205e51:	c7 84 24 8c 00 00 00 	movl   $0x8,0x8c(%esp)
  205e58:	08 00 00 00 
  205e5c:	83 bc 24 8c 00 00 00 	cmpl   $0x4,0x8c(%esp)
  205e63:	04 
  205e64:	0f 85 8e 01 00 00    	jne    205ff8 <f_rename+0x2c9>
  205e6a:	83 ec 0c             	sub    $0xc,%esp
  205e6d:	8d 44 24 2c          	lea    0x2c(%esp),%eax
  205e71:	50                   	push   %eax
  205e72:	e8 c8 cc ff ff       	call   202b3f <dir_register>
  205e77:	83 c4 10             	add    $0x10,%esp
  205e7a:	89 84 24 8c 00 00 00 	mov    %eax,0x8c(%esp)
  205e81:	83 bc 24 8c 00 00 00 	cmpl   $0x0,0x8c(%esp)
  205e88:	00 
  205e89:	0f 85 69 01 00 00    	jne    205ff8 <f_rename+0x2c9>
  205e8f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  205e93:	89 84 24 88 00 00 00 	mov    %eax,0x88(%esp)
  205e9a:	89 e0                	mov    %esp,%eax
  205e9c:	83 c0 0d             	add    $0xd,%eax
  205e9f:	8b 94 24 88 00 00 00 	mov    0x88(%esp),%edx
  205ea6:	83 c2 0d             	add    $0xd,%edx
  205ea9:	83 ec 04             	sub    $0x4,%esp
  205eac:	6a 13                	push   $0x13
  205eae:	50                   	push   %eax
  205eaf:	52                   	push   %edx
  205eb0:	e8 8e 0f 00 00       	call   206e43 <memcpy>
  205eb5:	83 c4 10             	add    $0x10,%esp
  205eb8:	8b 84 24 88 00 00 00 	mov    0x88(%esp),%eax
  205ebf:	8d 50 0b             	lea    0xb(%eax),%edx
  205ec2:	0f b6 44 24 0b       	movzbl 0xb(%esp),%eax
  205ec7:	88 02                	mov    %al,(%edx)
  205ec9:	8b 84 24 88 00 00 00 	mov    0x88(%esp),%eax
  205ed0:	83 c0 0b             	add    $0xb,%eax
  205ed3:	0f b6 00             	movzbl (%eax),%eax
  205ed6:	0f b6 c0             	movzbl %al,%eax
  205ed9:	83 e0 10             	and    $0x10,%eax
  205edc:	85 c0                	test   %eax,%eax
  205ede:	75 1c                	jne    205efc <f_rename+0x1cd>
  205ee0:	8b 84 24 88 00 00 00 	mov    0x88(%esp),%eax
  205ee7:	83 c0 0b             	add    $0xb,%eax
  205eea:	0f b6 10             	movzbl (%eax),%edx
  205eed:	8b 84 24 88 00 00 00 	mov    0x88(%esp),%eax
  205ef4:	83 c0 0b             	add    $0xb,%eax
  205ef7:	83 ca 20             	or     $0x20,%edx
  205efa:	88 10                	mov    %dl,(%eax)
  205efc:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  205f03:	c6 40 04 01          	movb   $0x1,0x4(%eax)
  205f07:	8b 84 24 88 00 00 00 	mov    0x88(%esp),%eax
  205f0e:	83 c0 0b             	add    $0xb,%eax
  205f11:	0f b6 00             	movzbl (%eax),%eax
  205f14:	0f b6 c0             	movzbl %al,%eax
  205f17:	83 e0 10             	and    $0x10,%eax
  205f1a:	85 c0                	test   %eax,%eax
  205f1c:	0f 84 d6 00 00 00    	je     205ff8 <f_rename+0x2c9>
  205f22:	8b 54 24 58          	mov    0x58(%esp),%edx
  205f26:	8b 44 24 28          	mov    0x28(%esp),%eax
  205f2a:	39 c2                	cmp    %eax,%edx
  205f2c:	0f 84 c6 00 00 00    	je     205ff8 <f_rename+0x2c9>
  205f32:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  205f39:	83 ec 08             	sub    $0x8,%esp
  205f3c:	ff b4 24 90 00 00 00 	push   0x90(%esp)
  205f43:	50                   	push   %eax
  205f44:	e8 5d c2 ff ff       	call   2021a6 <ld_clust>
  205f49:	83 c4 10             	add    $0x10,%esp
  205f4c:	8b 94 24 80 00 00 00 	mov    0x80(%esp),%edx
  205f53:	83 ec 08             	sub    $0x8,%esp
  205f56:	50                   	push   %eax
  205f57:	52                   	push   %edx
  205f58:	e8 06 b5 ff ff       	call   201463 <clst2sect>
  205f5d:	83 c4 10             	add    $0x10,%esp
  205f60:	89 84 24 84 00 00 00 	mov    %eax,0x84(%esp)
  205f67:	83 bc 24 84 00 00 00 	cmpl   $0x0,0x84(%esp)
  205f6e:	00 
  205f6f:	75 0d                	jne    205f7e <f_rename+0x24f>
  205f71:	c7 84 24 8c 00 00 00 	movl   $0x2,0x8c(%esp)
  205f78:	02 00 00 00 
  205f7c:	eb 7a                	jmp    205ff8 <f_rename+0x2c9>
  205f7e:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  205f85:	83 ec 08             	sub    $0x8,%esp
  205f88:	ff b4 24 8c 00 00 00 	push   0x8c(%esp)
  205f8f:	50                   	push   %eax
  205f90:	e8 f7 b2 ff ff       	call   20128c <move_window>
  205f95:	83 c4 10             	add    $0x10,%esp
  205f98:	89 84 24 8c 00 00 00 	mov    %eax,0x8c(%esp)
  205f9f:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  205fa6:	83 c0 34             	add    $0x34,%eax
  205fa9:	83 c0 20             	add    $0x20,%eax
  205fac:	89 84 24 88 00 00 00 	mov    %eax,0x88(%esp)
  205fb3:	83 bc 24 8c 00 00 00 	cmpl   $0x0,0x8c(%esp)
  205fba:	00 
  205fbb:	75 3b                	jne    205ff8 <f_rename+0x2c9>
  205fbd:	8b 84 24 88 00 00 00 	mov    0x88(%esp),%eax
  205fc4:	83 c0 01             	add    $0x1,%eax
  205fc7:	0f b6 00             	movzbl (%eax),%eax
  205fca:	3c 2e                	cmp    $0x2e,%al
  205fcc:	75 2a                	jne    205ff8 <f_rename+0x2c9>
  205fce:	8b 54 24 28          	mov    0x28(%esp),%edx
  205fd2:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  205fd9:	83 ec 04             	sub    $0x4,%esp
  205fdc:	52                   	push   %edx
  205fdd:	ff b4 24 90 00 00 00 	push   0x90(%esp)
  205fe4:	50                   	push   %eax
  205fe5:	e8 03 c2 ff ff       	call   2021ed <st_clust>
  205fea:	83 c4 10             	add    $0x10,%esp
  205fed:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  205ff4:	c6 40 04 01          	movb   $0x1,0x4(%eax)
  205ff8:	83 bc 24 8c 00 00 00 	cmpl   $0x0,0x8c(%esp)
  205fff:	00 
  206000:	75 3b                	jne    20603d <f_rename+0x30e>
  206002:	83 ec 0c             	sub    $0xc,%esp
  206005:	8d 44 24 5c          	lea    0x5c(%esp),%eax
  206009:	50                   	push   %eax
  20600a:	e8 e7 cd ff ff       	call   202df6 <dir_remove>
  20600f:	83 c4 10             	add    $0x10,%esp
  206012:	89 84 24 8c 00 00 00 	mov    %eax,0x8c(%esp)
  206019:	83 bc 24 8c 00 00 00 	cmpl   $0x0,0x8c(%esp)
  206020:	00 
  206021:	75 1a                	jne    20603d <f_rename+0x30e>
  206023:	8b 84 24 80 00 00 00 	mov    0x80(%esp),%eax
  20602a:	83 ec 0c             	sub    $0xc,%esp
  20602d:	50                   	push   %eax
  20602e:	e8 d4 b2 ff ff       	call   201307 <sync_fs>
  206033:	83 c4 10             	add    $0x10,%esp
  206036:	89 84 24 8c 00 00 00 	mov    %eax,0x8c(%esp)
  20603d:	8b 84 24 8c 00 00 00 	mov    0x8c(%esp),%eax
  206044:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  20604a:	c3                   	ret

0020604b <outb>:
  20604b:	83 ec 08             	sub    $0x8,%esp
  20604e:	8b 54 24 0c          	mov    0xc(%esp),%edx
  206052:	8b 44 24 10          	mov    0x10(%esp),%eax
  206056:	66 89 54 24 04       	mov    %dx,0x4(%esp)
  20605b:	88 04 24             	mov    %al,(%esp)
  20605e:	0f b6 04 24          	movzbl (%esp),%eax
  206062:	0f b7 54 24 04       	movzwl 0x4(%esp),%edx
  206067:	ee                   	out    %al,(%dx)
  206068:	90                   	nop
  206069:	83 c4 08             	add    $0x8,%esp
  20606c:	c3                   	ret

0020606d <video_init>:
  20606d:	83 ec 0c             	sub    $0xc,%esp
  206070:	c7 05 80 bc 21 00 00 	movl   $0x0,0x21bc80
  206077:	00 00 00 
  20607a:	c7 05 84 bc 21 00 07 	movl   $0x7,0x21bc84
  206081:	00 00 00 
  206084:	c7 05 88 bc 21 00 00 	movl   $0x100,0x21bc88
  20608b:	01 00 00 
  20608e:	e8 35 00 00 00       	call   2060c8 <clear>
  206093:	90                   	nop
  206094:	83 c4 0c             	add    $0xc,%esp
  206097:	c3                   	ret

00206098 <newline>:
  206098:	83 ec 0c             	sub    $0xc,%esp
  20609b:	a1 80 bc 21 00       	mov    0x21bc80,%eax
  2060a0:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  2060a5:	f7 e2                	mul    %edx
  2060a7:	89 d0                	mov    %edx,%eax
  2060a9:	c1 e8 07             	shr    $0x7,%eax
  2060ac:	8d 50 01             	lea    0x1(%eax),%edx
  2060af:	89 d0                	mov    %edx,%eax
  2060b1:	c1 e0 02             	shl    $0x2,%eax
  2060b4:	01 d0                	add    %edx,%eax
  2060b6:	c1 e0 05             	shl    $0x5,%eax
  2060b9:	a3 80 bc 21 00       	mov    %eax,0x21bc80
  2060be:	e8 db 03 00 00       	call   20649e <update_cursor>
  2060c3:	90                   	nop
  2060c4:	83 c4 0c             	add    $0xc,%esp
  2060c7:	c3                   	ret

002060c8 <clear>:
  2060c8:	83 ec 1c             	sub    $0x1c,%esp
  2060cb:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  2060d2:	00 
  2060d3:	eb 36                	jmp    20610b <clear+0x43>
  2060d5:	8b 15 00 a0 20 00    	mov    0x20a000,%edx
  2060db:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2060df:	01 d0                	add    %edx,%eax
  2060e1:	c6 00 20             	movb   $0x20,(%eax)
  2060e4:	a1 88 bc 21 00       	mov    0x21bc88,%eax
  2060e9:	89 c2                	mov    %eax,%edx
  2060eb:	a1 84 bc 21 00       	mov    0x21bc84,%eax
  2060f0:	89 d1                	mov    %edx,%ecx
  2060f2:	09 c1                	or     %eax,%ecx
  2060f4:	a1 00 a0 20 00       	mov    0x20a000,%eax
  2060f9:	8b 54 24 0c          	mov    0xc(%esp),%edx
  2060fd:	83 c2 01             	add    $0x1,%edx
  206100:	01 d0                	add    %edx,%eax
  206102:	89 ca                	mov    %ecx,%edx
  206104:	88 10                	mov    %dl,(%eax)
  206106:	83 44 24 0c 02       	addl   $0x2,0xc(%esp)
  20610b:	81 7c 24 0c 9f 0f 00 	cmpl   $0xf9f,0xc(%esp)
  206112:	00 
  206113:	76 c0                	jbe    2060d5 <clear+0xd>
  206115:	c7 05 80 bc 21 00 00 	movl   $0x0,0x21bc80
  20611c:	00 00 00 
  20611f:	e8 7a 03 00 00       	call   20649e <update_cursor>
  206124:	90                   	nop
  206125:	83 c4 1c             	add    $0x1c,%esp
  206128:	c3                   	ret

00206129 <prints>:
  206129:	83 ec 1c             	sub    $0x1c,%esp
  20612c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  206133:	00 
  206134:	eb 75                	jmp    2061ab <prints+0x82>
  206136:	8b 54 24 20          	mov    0x20(%esp),%edx
  20613a:	8b 44 24 0c          	mov    0xc(%esp),%eax
  20613e:	01 d0                	add    %edx,%eax
  206140:	0f b6 00             	movzbl (%eax),%eax
  206143:	3c 0a                	cmp    $0xa,%al
  206145:	75 0c                	jne    206153 <prints+0x2a>
  206147:	e8 4c ff ff ff       	call   206098 <newline>
  20614c:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
  206151:	eb 58                	jmp    2061ab <prints+0x82>
  206153:	8b 54 24 20          	mov    0x20(%esp),%edx
  206157:	8b 44 24 0c          	mov    0xc(%esp),%eax
  20615b:	01 d0                	add    %edx,%eax
  20615d:	8b 0d 00 a0 20 00    	mov    0x20a000,%ecx
  206163:	8b 15 80 bc 21 00    	mov    0x21bc80,%edx
  206169:	01 ca                	add    %ecx,%edx
  20616b:	0f b6 00             	movzbl (%eax),%eax
  20616e:	88 02                	mov    %al,(%edx)
  206170:	a1 88 bc 21 00       	mov    0x21bc88,%eax
  206175:	89 c2                	mov    %eax,%edx
  206177:	a1 84 bc 21 00       	mov    0x21bc84,%eax
  20617c:	89 d1                	mov    %edx,%ecx
  20617e:	09 c1                	or     %eax,%ecx
  206180:	a1 00 a0 20 00       	mov    0x20a000,%eax
  206185:	8b 15 80 bc 21 00    	mov    0x21bc80,%edx
  20618b:	83 c2 01             	add    $0x1,%edx
  20618e:	01 d0                	add    %edx,%eax
  206190:	89 ca                	mov    %ecx,%edx
  206192:	88 10                	mov    %dl,(%eax)
  206194:	a1 80 bc 21 00       	mov    0x21bc80,%eax
  206199:	83 c0 02             	add    $0x2,%eax
  20619c:	a3 80 bc 21 00       	mov    %eax,0x21bc80
  2061a1:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
  2061a6:	e8 f3 02 00 00       	call   20649e <update_cursor>
  2061ab:	8b 54 24 20          	mov    0x20(%esp),%edx
  2061af:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2061b3:	01 d0                	add    %edx,%eax
  2061b5:	0f b6 00             	movzbl (%eax),%eax
  2061b8:	84 c0                	test   %al,%al
  2061ba:	0f 85 76 ff ff ff    	jne    206136 <prints+0xd>
  2061c0:	90                   	nop
  2061c1:	83 c4 1c             	add    $0x1c,%esp
  2061c4:	c3                   	ret

002061c5 <printslen>:
  2061c5:	83 ec 1c             	sub    $0x1c,%esp
  2061c8:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  2061cf:	00 
  2061d0:	eb 75                	jmp    206247 <printslen+0x82>
  2061d2:	8b 54 24 20          	mov    0x20(%esp),%edx
  2061d6:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2061da:	01 d0                	add    %edx,%eax
  2061dc:	0f b6 00             	movzbl (%eax),%eax
  2061df:	3c 0a                	cmp    $0xa,%al
  2061e1:	75 0c                	jne    2061ef <printslen+0x2a>
  2061e3:	e8 b0 fe ff ff       	call   206098 <newline>
  2061e8:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
  2061ed:	eb 58                	jmp    206247 <printslen+0x82>
  2061ef:	8b 54 24 20          	mov    0x20(%esp),%edx
  2061f3:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2061f7:	01 d0                	add    %edx,%eax
  2061f9:	8b 0d 00 a0 20 00    	mov    0x20a000,%ecx
  2061ff:	8b 15 80 bc 21 00    	mov    0x21bc80,%edx
  206205:	01 ca                	add    %ecx,%edx
  206207:	0f b6 00             	movzbl (%eax),%eax
  20620a:	88 02                	mov    %al,(%edx)
  20620c:	a1 88 bc 21 00       	mov    0x21bc88,%eax
  206211:	89 c2                	mov    %eax,%edx
  206213:	a1 84 bc 21 00       	mov    0x21bc84,%eax
  206218:	89 d1                	mov    %edx,%ecx
  20621a:	09 c1                	or     %eax,%ecx
  20621c:	a1 00 a0 20 00       	mov    0x20a000,%eax
  206221:	8b 15 80 bc 21 00    	mov    0x21bc80,%edx
  206227:	83 c2 01             	add    $0x1,%edx
  20622a:	01 d0                	add    %edx,%eax
  20622c:	89 ca                	mov    %ecx,%edx
  20622e:	88 10                	mov    %dl,(%eax)
  206230:	a1 80 bc 21 00       	mov    0x21bc80,%eax
  206235:	83 c0 02             	add    $0x2,%eax
  206238:	a3 80 bc 21 00       	mov    %eax,0x21bc80
  20623d:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
  206242:	e8 57 02 00 00       	call   20649e <update_cursor>
  206247:	8b 44 24 24          	mov    0x24(%esp),%eax
  20624b:	39 44 24 0c          	cmp    %eax,0xc(%esp)
  20624f:	72 81                	jb     2061d2 <printslen+0xd>
  206251:	90                   	nop
  206252:	83 c4 1c             	add    $0x1c,%esp
  206255:	c3                   	ret

00206256 <printc>:
  206256:	83 ec 1c             	sub    $0x1c,%esp
  206259:	8b 44 24 20          	mov    0x20(%esp),%eax
  20625d:	88 44 24 0c          	mov    %al,0xc(%esp)
  206261:	80 7c 24 0c 0a       	cmpb   $0xa,0xc(%esp)
  206266:	75 07                	jne    20626f <printc+0x19>
  206268:	e8 2b fe ff ff       	call   206098 <newline>
  20626d:	eb 4b                	jmp    2062ba <printc+0x64>
  20626f:	8b 15 00 a0 20 00    	mov    0x20a000,%edx
  206275:	a1 80 bc 21 00       	mov    0x21bc80,%eax
  20627a:	01 c2                	add    %eax,%edx
  20627c:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
  206281:	88 02                	mov    %al,(%edx)
  206283:	a1 84 bc 21 00       	mov    0x21bc84,%eax
  206288:	89 c2                	mov    %eax,%edx
  20628a:	a1 88 bc 21 00       	mov    0x21bc88,%eax
  20628f:	89 d1                	mov    %edx,%ecx
  206291:	09 c1                	or     %eax,%ecx
  206293:	a1 00 a0 20 00       	mov    0x20a000,%eax
  206298:	8b 15 80 bc 21 00    	mov    0x21bc80,%edx
  20629e:	83 c2 01             	add    $0x1,%edx
  2062a1:	01 d0                	add    %edx,%eax
  2062a3:	89 ca                	mov    %ecx,%edx
  2062a5:	88 10                	mov    %dl,(%eax)
  2062a7:	a1 80 bc 21 00       	mov    0x21bc80,%eax
  2062ac:	83 c0 02             	add    $0x2,%eax
  2062af:	a3 80 bc 21 00       	mov    %eax,0x21bc80
  2062b4:	e8 e5 01 00 00       	call   20649e <update_cursor>
  2062b9:	90                   	nop
  2062ba:	83 c4 1c             	add    $0x1c,%esp
  2062bd:	c3                   	ret

002062be <printi>:
  2062be:	83 ec 1c             	sub    $0x1c,%esp
  2062c1:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  2062c8:	00 
  2062c9:	83 7c 24 20 00       	cmpl   $0x0,0x20(%esp)
  2062ce:	79 6a                	jns    20633a <printi+0x7c>
  2062d0:	83 ec 0c             	sub    $0xc,%esp
  2062d3:	6a 2d                	push   $0x2d
  2062d5:	e8 7c ff ff ff       	call   206256 <printc>
  2062da:	83 c4 10             	add    $0x10,%esp
  2062dd:	f7 5c 24 20          	negl   0x20(%esp)
  2062e1:	eb 57                	jmp    20633a <printi+0x7c>
  2062e3:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  2062e7:	ba 67 66 66 66       	mov    $0x66666667,%edx
  2062ec:	89 c8                	mov    %ecx,%eax
  2062ee:	f7 ea                	imul   %edx
  2062f0:	c1 fa 02             	sar    $0x2,%edx
  2062f3:	89 c8                	mov    %ecx,%eax
  2062f5:	c1 f8 1f             	sar    $0x1f,%eax
  2062f8:	29 c2                	sub    %eax,%edx
  2062fa:	89 d0                	mov    %edx,%eax
  2062fc:	c1 e0 02             	shl    $0x2,%eax
  2062ff:	01 d0                	add    %edx,%eax
  206301:	01 c0                	add    %eax,%eax
  206303:	29 c1                	sub    %eax,%ecx
  206305:	89 ca                	mov    %ecx,%edx
  206307:	89 d0                	mov    %edx,%eax
  206309:	8d 48 30             	lea    0x30(%eax),%ecx
  20630c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206310:	8d 50 01             	lea    0x1(%eax),%edx
  206313:	89 54 24 0c          	mov    %edx,0xc(%esp)
  206317:	89 ca                	mov    %ecx,%edx
  206319:	88 54 04 02          	mov    %dl,0x2(%esp,%eax,1)
  20631d:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  206321:	ba 67 66 66 66       	mov    $0x66666667,%edx
  206326:	89 c8                	mov    %ecx,%eax
  206328:	f7 ea                	imul   %edx
  20632a:	89 d0                	mov    %edx,%eax
  20632c:	c1 f8 02             	sar    $0x2,%eax
  20632f:	c1 f9 1f             	sar    $0x1f,%ecx
  206332:	89 ca                	mov    %ecx,%edx
  206334:	29 d0                	sub    %edx,%eax
  206336:	89 44 24 20          	mov    %eax,0x20(%esp)
  20633a:	83 7c 24 20 00       	cmpl   $0x0,0x20(%esp)
  20633f:	7f a2                	jg     2062e3 <printi+0x25>
  206341:	eb 21                	jmp    206364 <printi+0xa6>
  206343:	83 6c 24 0c 01       	subl   $0x1,0xc(%esp)
  206348:	8d 54 24 02          	lea    0x2(%esp),%edx
  20634c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206350:	01 d0                	add    %edx,%eax
  206352:	0f b6 00             	movzbl (%eax),%eax
  206355:	0f be c0             	movsbl %al,%eax
  206358:	83 ec 0c             	sub    $0xc,%esp
  20635b:	50                   	push   %eax
  20635c:	e8 f5 fe ff ff       	call   206256 <printc>
  206361:	83 c4 10             	add    $0x10,%esp
  206364:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  206369:	7f d8                	jg     206343 <printi+0x85>
  20636b:	90                   	nop
  20636c:	90                   	nop
  20636d:	83 c4 1c             	add    $0x1c,%esp
  206370:	c3                   	ret

00206371 <video_test2>:
  206371:	83 ec 10             	sub    $0x10,%esp
  206374:	c7 05 80 bc 21 00 00 	movl   $0x0,0x21bc80
  20637b:	00 00 00 
  20637e:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  206385:	00 
  206386:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  20638d:	00 
  20638e:	eb 3d                	jmp    2063cd <video_test2+0x5c>
  206390:	8b 15 00 a0 20 00    	mov    0x20a000,%edx
  206396:	a1 80 bc 21 00       	mov    0x21bc80,%eax
  20639b:	01 d0                	add    %edx,%eax
  20639d:	c6 00 41             	movb   $0x41,(%eax)
  2063a0:	a1 00 a0 20 00       	mov    0x20a000,%eax
  2063a5:	8b 15 80 bc 21 00    	mov    0x21bc80,%edx
  2063ab:	83 c2 01             	add    $0x1,%edx
  2063ae:	01 d0                	add    %edx,%eax
  2063b0:	8b 54 24 0c          	mov    0xc(%esp),%edx
  2063b4:	88 10                	mov    %dl,(%eax)
  2063b6:	a1 80 bc 21 00       	mov    0x21bc80,%eax
  2063bb:	83 c0 02             	add    $0x2,%eax
  2063be:	a3 80 bc 21 00       	mov    %eax,0x21bc80
  2063c3:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
  2063c8:	83 44 24 08 01       	addl   $0x1,0x8(%esp)
  2063cd:	81 7c 24 08 9f 0f 00 	cmpl   $0xf9f,0x8(%esp)
  2063d4:	00 
  2063d5:	7e b9                	jle    206390 <video_test2+0x1f>
  2063d7:	90                   	nop
  2063d8:	83 c4 10             	add    $0x10,%esp
  2063db:	c3                   	ret

002063dc <ccolor>:
  2063dc:	8b 44 24 04          	mov    0x4(%esp),%eax
  2063e0:	a3 84 bc 21 00       	mov    %eax,0x21bc84
  2063e5:	90                   	nop
  2063e6:	c3                   	ret

002063e7 <put_pixel>:
  2063e7:	8b 0d 00 a0 20 00    	mov    0x20a000,%ecx
  2063ed:	8b 54 24 08          	mov    0x8(%esp),%edx
  2063f1:	89 d0                	mov    %edx,%eax
  2063f3:	c1 e0 02             	shl    $0x2,%eax
  2063f6:	01 d0                	add    %edx,%eax
  2063f8:	c1 e0 05             	shl    $0x5,%eax
  2063fb:	89 c2                	mov    %eax,%edx
  2063fd:	8b 44 24 04          	mov    0x4(%esp),%eax
  206401:	01 d0                	add    %edx,%eax
  206403:	01 c8                	add    %ecx,%eax
  206405:	c6 00 20             	movb   $0x20,(%eax)
  206408:	8b 0d 00 a0 20 00    	mov    0x20a000,%ecx
  20640e:	8b 54 24 08          	mov    0x8(%esp),%edx
  206412:	89 d0                	mov    %edx,%eax
  206414:	c1 e0 02             	shl    $0x2,%eax
  206417:	01 d0                	add    %edx,%eax
  206419:	c1 e0 05             	shl    $0x5,%eax
  20641c:	89 c2                	mov    %eax,%edx
  20641e:	8b 44 24 04          	mov    0x4(%esp),%eax
  206422:	01 d0                	add    %edx,%eax
  206424:	83 c0 01             	add    $0x1,%eax
  206427:	01 c8                	add    %ecx,%eax
  206429:	8b 54 24 0c          	mov    0xc(%esp),%edx
  20642d:	88 10                	mov    %dl,(%eax)
  20642f:	90                   	nop
  206430:	c3                   	ret

00206431 <move_cursor>:
  206431:	83 ec 10             	sub    $0x10,%esp
  206434:	8b 54 24 18          	mov    0x18(%esp),%edx
  206438:	89 d0                	mov    %edx,%eax
  20643a:	c1 e0 02             	shl    $0x2,%eax
  20643d:	01 d0                	add    %edx,%eax
  20643f:	c1 e0 04             	shl    $0x4,%eax
  206442:	89 c2                	mov    %eax,%edx
  206444:	8b 44 24 14          	mov    0x14(%esp),%eax
  206448:	01 d0                	add    %edx,%eax
  20644a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  20644e:	6a 0f                	push   $0xf
  206450:	68 d4 03 00 00       	push   $0x3d4
  206455:	e8 f1 fb ff ff       	call   20604b <outb>
  20645a:	83 c4 08             	add    $0x8,%esp
  20645d:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206461:	0f b6 c0             	movzbl %al,%eax
  206464:	50                   	push   %eax
  206465:	68 d5 03 00 00       	push   $0x3d5
  20646a:	e8 dc fb ff ff       	call   20604b <outb>
  20646f:	83 c4 08             	add    $0x8,%esp
  206472:	6a 0e                	push   $0xe
  206474:	68 d4 03 00 00       	push   $0x3d4
  206479:	e8 cd fb ff ff       	call   20604b <outb>
  20647e:	83 c4 08             	add    $0x8,%esp
  206481:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206485:	c1 e8 08             	shr    $0x8,%eax
  206488:	0f b6 c0             	movzbl %al,%eax
  20648b:	50                   	push   %eax
  20648c:	68 d5 03 00 00       	push   $0x3d5
  206491:	e8 b5 fb ff ff       	call   20604b <outb>
  206496:	83 c4 08             	add    $0x8,%esp
  206499:	90                   	nop
  20649a:	83 c4 10             	add    $0x10,%esp
  20649d:	c3                   	ret

0020649e <update_cursor>:
  20649e:	83 ec 10             	sub    $0x10,%esp
  2064a1:	a1 80 bc 21 00       	mov    0x21bc80,%eax
  2064a6:	d1 e8                	shr    $1,%eax
  2064a8:	89 c1                	mov    %eax,%ecx
  2064aa:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  2064af:	89 c8                	mov    %ecx,%eax
  2064b1:	f7 e2                	mul    %edx
  2064b3:	89 d0                	mov    %edx,%eax
  2064b5:	c1 e8 06             	shr    $0x6,%eax
  2064b8:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2064bc:	8b 54 24 0c          	mov    0xc(%esp),%edx
  2064c0:	89 d0                	mov    %edx,%eax
  2064c2:	c1 e0 02             	shl    $0x2,%eax
  2064c5:	01 d0                	add    %edx,%eax
  2064c7:	c1 e0 04             	shl    $0x4,%eax
  2064ca:	29 c1                	sub    %eax,%ecx
  2064cc:	89 ca                	mov    %ecx,%edx
  2064ce:	89 54 24 0c          	mov    %edx,0xc(%esp)
  2064d2:	a1 80 bc 21 00       	mov    0x21bc80,%eax
  2064d7:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  2064dc:	f7 e2                	mul    %edx
  2064de:	89 d0                	mov    %edx,%eax
  2064e0:	c1 e8 07             	shr    $0x7,%eax
  2064e3:	89 44 24 08          	mov    %eax,0x8(%esp)
  2064e7:	ff 74 24 08          	push   0x8(%esp)
  2064eb:	ff 74 24 10          	push   0x10(%esp)
  2064ef:	e8 3d ff ff ff       	call   206431 <move_cursor>
  2064f4:	83 c4 08             	add    $0x8,%esp
  2064f7:	90                   	nop
  2064f8:	83 c4 10             	add    $0x10,%esp
  2064fb:	c3                   	ret

002064fc <backspace>:
  2064fc:	83 ec 10             	sub    $0x10,%esp
  2064ff:	a1 80 bc 21 00       	mov    0x21bc80,%eax
  206504:	85 c0                	test   %eax,%eax
  206506:	74 6d                	je     206575 <backspace+0x79>
  206508:	a1 80 bc 21 00       	mov    0x21bc80,%eax
  20650d:	d1 e8                	shr    $1,%eax
  20650f:	83 e8 01             	sub    $0x1,%eax
  206512:	89 44 24 0c          	mov    %eax,0xc(%esp)
  206516:	a1 80 bc 21 00       	mov    0x21bc80,%eax
  20651b:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  206520:	f7 e2                	mul    %edx
  206522:	89 d0                	mov    %edx,%eax
  206524:	c1 e8 07             	shr    $0x7,%eax
  206527:	89 44 24 08          	mov    %eax,0x8(%esp)
  20652b:	ff 74 24 08          	push   0x8(%esp)
  20652f:	ff 74 24 10          	push   0x10(%esp)
  206533:	e8 f9 fe ff ff       	call   206431 <move_cursor>
  206538:	83 c4 08             	add    $0x8,%esp
  20653b:	a1 00 a0 20 00       	mov    0x20a000,%eax
  206540:	8b 15 80 bc 21 00    	mov    0x21bc80,%edx
  206546:	83 ea 02             	sub    $0x2,%edx
  206549:	01 d0                	add    %edx,%eax
  20654b:	c6 00 20             	movb   $0x20,(%eax)
  20654e:	a1 00 a0 20 00       	mov    0x20a000,%eax
  206553:	8b 15 80 bc 21 00    	mov    0x21bc80,%edx
  206559:	83 ea 01             	sub    $0x1,%edx
  20655c:	01 d0                	add    %edx,%eax
  20655e:	c6 00 07             	movb   $0x7,(%eax)
  206561:	a1 80 bc 21 00       	mov    0x21bc80,%eax
  206566:	83 e8 02             	sub    $0x2,%eax
  206569:	a3 80 bc 21 00       	mov    %eax,0x21bc80
  20656e:	e8 2b ff ff ff       	call   20649e <update_cursor>
  206573:	eb 01                	jmp    206576 <backspace+0x7a>
  206575:	90                   	nop
  206576:	83 c4 10             	add    $0x10,%esp
  206579:	c3                   	ret

0020657a <background>:
  20657a:	83 ec 10             	sub    $0x10,%esp
  20657d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  206584:	00 
  206585:	eb 43                	jmp    2065ca <background+0x50>
  206587:	8b 15 00 a0 20 00    	mov    0x20a000,%edx
  20658d:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206591:	01 d0                	add    %edx,%eax
  206593:	8b 0d 00 a0 20 00    	mov    0x20a000,%ecx
  206599:	8b 54 24 0c          	mov    0xc(%esp),%edx
  20659d:	01 ca                	add    %ecx,%edx
  20659f:	0f b6 00             	movzbl (%eax),%eax
  2065a2:	88 02                	mov    %al,(%edx)
  2065a4:	8b 44 24 14          	mov    0x14(%esp),%eax
  2065a8:	89 c2                	mov    %eax,%edx
  2065aa:	a1 84 bc 21 00       	mov    0x21bc84,%eax
  2065af:	89 d1                	mov    %edx,%ecx
  2065b1:	09 c1                	or     %eax,%ecx
  2065b3:	a1 00 a0 20 00       	mov    0x20a000,%eax
  2065b8:	8b 54 24 0c          	mov    0xc(%esp),%edx
  2065bc:	83 c2 01             	add    $0x1,%edx
  2065bf:	01 d0                	add    %edx,%eax
  2065c1:	89 ca                	mov    %ecx,%edx
  2065c3:	88 10                	mov    %dl,(%eax)
  2065c5:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
  2065ca:	81 7c 24 0c 9f 0f 00 	cmpl   $0xf9f,0xc(%esp)
  2065d1:	00 
  2065d2:	7e b3                	jle    206587 <background+0xd>
  2065d4:	c7 05 80 bc 21 00 00 	movl   $0x0,0x21bc80
  2065db:	00 00 00 
  2065de:	e8 bb fe ff ff       	call   20649e <update_cursor>
  2065e3:	90                   	nop
  2065e4:	83 c4 10             	add    $0x10,%esp
  2065e7:	c3                   	ret

002065e8 <sys_write>:
  2065e8:	83 ec 1c             	sub    $0x1c,%esp
  2065eb:	8b 44 24 20          	mov    0x20(%esp),%eax
  2065ef:	88 44 24 0c          	mov    %al,0xc(%esp)
  2065f3:	80 7c 24 0c 01       	cmpb   $0x1,0xc(%esp)
  2065f8:	74 07                	je     206601 <sys_write+0x19>
  2065fa:	80 7c 24 0c 02       	cmpb   $0x2,0xc(%esp)
  2065ff:	75 1a                	jne    20661b <sys_write+0x33>
  206601:	8b 44 24 28          	mov    0x28(%esp),%eax
  206605:	83 ec 08             	sub    $0x8,%esp
  206608:	50                   	push   %eax
  206609:	ff 74 24 30          	push   0x30(%esp)
  20660d:	e8 b3 fb ff ff       	call   2061c5 <printslen>
  206612:	83 c4 10             	add    $0x10,%esp
  206615:	8b 44 24 28          	mov    0x28(%esp),%eax
  206619:	eb 05                	jmp    206620 <sys_write+0x38>
  20661b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  206620:	83 c4 1c             	add    $0x1c,%esp
  206623:	c3                   	ret

00206624 <sys_read>:
  206624:	83 ec 2c             	sub    $0x2c,%esp
  206627:	8b 44 24 30          	mov    0x30(%esp),%eax
  20662b:	88 44 24 0c          	mov    %al,0xc(%esp)
  20662f:	80 7c 24 0c 00       	cmpb   $0x0,0xc(%esp)
  206634:	75 54                	jne    20668a <sys_read+0x66>
  206636:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  20663d:	00 
  20663e:	fb                   	sti
  20663f:	eb 38                	jmp    206679 <sys_read+0x55>
  206641:	f4                   	hlt
  206642:	e8 52 01 00 00       	call   206799 <getchar>
  206647:	88 44 24 1b          	mov    %al,0x1b(%esp)
  20664b:	80 7c 24 1b 00       	cmpb   $0x0,0x1b(%esp)
  206650:	74 27                	je     206679 <sys_read+0x55>
  206652:	0f be 44 24 1b       	movsbl 0x1b(%esp),%eax
  206657:	83 ec 0c             	sub    $0xc,%esp
  20665a:	50                   	push   %eax
  20665b:	e8 f6 fb ff ff       	call   206256 <printc>
  206660:	83 c4 10             	add    $0x10,%esp
  206663:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  206667:	8b 44 24 34          	mov    0x34(%esp),%eax
  20666b:	01 c2                	add    %eax,%edx
  20666d:	0f b6 44 24 1b       	movzbl 0x1b(%esp),%eax
  206672:	88 02                	mov    %al,(%edx)
  206674:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  206679:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  20667d:	3b 44 24 38          	cmp    0x38(%esp),%eax
  206681:	72 be                	jb     206641 <sys_read+0x1d>
  206683:	fa                   	cli
  206684:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  206688:	eb 05                	jmp    20668f <sys_read+0x6b>
  20668a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  20668f:	83 c4 2c             	add    $0x2c,%esp
  206692:	c3                   	ret

00206693 <inb>:
  206693:	83 ec 14             	sub    $0x14,%esp
  206696:	8b 44 24 18          	mov    0x18(%esp),%eax
  20669a:	66 89 04 24          	mov    %ax,(%esp)
  20669e:	0f b7 04 24          	movzwl (%esp),%eax
  2066a2:	89 c2                	mov    %eax,%edx
  2066a4:	ec                   	in     (%dx),%al
  2066a5:	88 44 24 13          	mov    %al,0x13(%esp)
  2066a9:	0f b6 44 24 13       	movzbl 0x13(%esp),%eax
  2066ae:	83 c4 14             	add    $0x14,%esp
  2066b1:	c3                   	ret

002066b2 <kb_handler>:
  2066b2:	83 ec 10             	sub    $0x10,%esp
  2066b5:	c6 44 24 0f 00       	movb   $0x0,0xf(%esp)
  2066ba:	6a 60                	push   $0x60
  2066bc:	e8 d2 ff ff ff       	call   206693 <inb>
  2066c1:	83 c4 04             	add    $0x4,%esp
  2066c4:	88 44 24 0e          	mov    %al,0xe(%esp)
  2066c8:	c6 44 24 0d 00       	movb   $0x0,0xd(%esp)
  2066cd:	80 7c 24 0e 2a       	cmpb   $0x2a,0xe(%esp)
  2066d2:	74 07                	je     2066db <kb_handler+0x29>
  2066d4:	80 7c 24 0e 36       	cmpb   $0x36,0xe(%esp)
  2066d9:	75 0b                	jne    2066e6 <kb_handler+0x34>
  2066db:	0f b6 44 24 0e       	movzbl 0xe(%esp),%eax
  2066e0:	88 44 24 0f          	mov    %al,0xf(%esp)
  2066e4:	eb 0d                	jmp    2066f3 <kb_handler+0x41>
  2066e6:	0f b6 44 24 0e       	movzbl 0xe(%esp),%eax
  2066eb:	84 c0                	test   %al,%al
  2066ed:	0f 88 a1 00 00 00    	js     206794 <kb_handler+0xe2>
  2066f3:	80 7c 24 0f 2a       	cmpb   $0x2a,0xf(%esp)
  2066f8:	75 4c                	jne    206746 <kb_handler+0x94>
  2066fa:	a1 e8 bc 21 00       	mov    0x21bce8,%eax
  2066ff:	83 f8 3f             	cmp    $0x3f,%eax
  206702:	7f 42                	jg     206746 <kb_handler+0x94>
  206704:	0f b6 54 24 0e       	movzbl 0xe(%esp),%edx
  206709:	a1 e0 bc 21 00       	mov    0x21bce0,%eax
  20670e:	0f b6 92 a0 a0 20 00 	movzbl 0x20a0a0(%edx),%edx
  206715:	88 90 a0 bc 21 00    	mov    %dl,0x21bca0(%eax)
  20671b:	a1 e0 bc 21 00       	mov    0x21bce0,%eax
  206720:	8d 50 01             	lea    0x1(%eax),%edx
  206723:	89 d0                	mov    %edx,%eax
  206725:	c1 f8 1f             	sar    $0x1f,%eax
  206728:	c1 e8 1a             	shr    $0x1a,%eax
  20672b:	01 c2                	add    %eax,%edx
  20672d:	83 e2 3f             	and    $0x3f,%edx
  206730:	29 c2                	sub    %eax,%edx
  206732:	89 d0                	mov    %edx,%eax
  206734:	a3 e0 bc 21 00       	mov    %eax,0x21bce0
  206739:	a1 e8 bc 21 00       	mov    0x21bce8,%eax
  20673e:	83 c0 01             	add    $0x1,%eax
  206741:	a3 e8 bc 21 00       	mov    %eax,0x21bce8
  206746:	a1 e8 bc 21 00       	mov    0x21bce8,%eax
  20674b:	83 f8 3f             	cmp    $0x3f,%eax
  20674e:	7f 45                	jg     206795 <kb_handler+0xe3>
  206750:	0f b6 54 24 0e       	movzbl 0xe(%esp),%edx
  206755:	a1 e0 bc 21 00       	mov    0x21bce0,%eax
  20675a:	0f b6 92 20 a0 20 00 	movzbl 0x20a020(%edx),%edx
  206761:	88 90 a0 bc 21 00    	mov    %dl,0x21bca0(%eax)
  206767:	a1 e0 bc 21 00       	mov    0x21bce0,%eax
  20676c:	8d 50 01             	lea    0x1(%eax),%edx
  20676f:	89 d0                	mov    %edx,%eax
  206771:	c1 f8 1f             	sar    $0x1f,%eax
  206774:	c1 e8 1a             	shr    $0x1a,%eax
  206777:	01 c2                	add    %eax,%edx
  206779:	83 e2 3f             	and    $0x3f,%edx
  20677c:	29 c2                	sub    %eax,%edx
  20677e:	89 d0                	mov    %edx,%eax
  206780:	a3 e0 bc 21 00       	mov    %eax,0x21bce0
  206785:	a1 e8 bc 21 00       	mov    0x21bce8,%eax
  20678a:	83 c0 01             	add    $0x1,%eax
  20678d:	a3 e8 bc 21 00       	mov    %eax,0x21bce8
  206792:	eb 01                	jmp    206795 <kb_handler+0xe3>
  206794:	90                   	nop
  206795:	83 c4 10             	add    $0x10,%esp
  206798:	c3                   	ret

00206799 <getchar>:
  206799:	83 ec 10             	sub    $0x10,%esp
  20679c:	a1 e8 bc 21 00       	mov    0x21bce8,%eax
  2067a1:	85 c0                	test   %eax,%eax
  2067a3:	75 07                	jne    2067ac <getchar+0x13>
  2067a5:	b8 00 00 00 00       	mov    $0x0,%eax
  2067aa:	eb 40                	jmp    2067ec <getchar+0x53>
  2067ac:	a1 e4 bc 21 00       	mov    0x21bce4,%eax
  2067b1:	0f b6 80 a0 bc 21 00 	movzbl 0x21bca0(%eax),%eax
  2067b8:	88 44 24 0f          	mov    %al,0xf(%esp)
  2067bc:	a1 e4 bc 21 00       	mov    0x21bce4,%eax
  2067c1:	8d 50 01             	lea    0x1(%eax),%edx
  2067c4:	89 d0                	mov    %edx,%eax
  2067c6:	c1 f8 1f             	sar    $0x1f,%eax
  2067c9:	c1 e8 1a             	shr    $0x1a,%eax
  2067cc:	01 c2                	add    %eax,%edx
  2067ce:	83 e2 3f             	and    $0x3f,%edx
  2067d1:	29 c2                	sub    %eax,%edx
  2067d3:	89 d0                	mov    %edx,%eax
  2067d5:	a3 e4 bc 21 00       	mov    %eax,0x21bce4
  2067da:	a1 e8 bc 21 00       	mov    0x21bce8,%eax
  2067df:	83 e8 01             	sub    $0x1,%eax
  2067e2:	a3 e8 bc 21 00       	mov    %eax,0x21bce8
  2067e7:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
  2067ec:	83 c4 10             	add    $0x10,%esp
  2067ef:	c3                   	ret

002067f0 <ff_uni2oem>:
  2067f0:	83 ec 14             	sub    $0x14,%esp
  2067f3:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2067f7:	66 89 04 24          	mov    %ax,(%esp)
  2067fb:	66 c7 44 24 12 00 00 	movw   $0x0,0x12(%esp)
  206802:	c7 44 24 0c 60 72 20 	movl   $0x207260,0xc(%esp)
  206809:	00 
  20680a:	83 7c 24 18 7f       	cmpl   $0x7f,0x18(%esp)
  20680f:	77 0b                	ja     20681c <ff_uni2oem+0x2c>
  206811:	8b 44 24 18          	mov    0x18(%esp),%eax
  206815:	66 89 44 24 12       	mov    %ax,0x12(%esp)
  20681a:	eb 5c                	jmp    206878 <ff_uni2oem+0x88>
  20681c:	81 7c 24 18 ff ff 00 	cmpl   $0xffff,0x18(%esp)
  206823:	00 
  206824:	77 52                	ja     206878 <ff_uni2oem+0x88>
  206826:	66 81 3c 24 b5 01    	cmpw   $0x1b5,(%esp)
  20682c:	75 4a                	jne    206878 <ff_uni2oem+0x88>
  20682e:	66 c7 44 24 12 00 00 	movw   $0x0,0x12(%esp)
  206835:	eb 0d                	jmp    206844 <ff_uni2oem+0x54>
  206837:	0f b7 44 24 12       	movzwl 0x12(%esp),%eax
  20683c:	83 c0 01             	add    $0x1,%eax
  20683f:	66 89 44 24 12       	mov    %ax,0x12(%esp)
  206844:	66 83 7c 24 12 7f    	cmpw   $0x7f,0x12(%esp)
  20684a:	77 1a                	ja     206866 <ff_uni2oem+0x76>
  20684c:	0f b7 44 24 12       	movzwl 0x12(%esp),%eax
  206851:	8d 14 00             	lea    (%eax,%eax,1),%edx
  206854:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206858:	01 d0                	add    %edx,%eax
  20685a:	0f b7 00             	movzwl (%eax),%eax
  20685d:	0f b7 c0             	movzwl %ax,%eax
  206860:	39 44 24 18          	cmp    %eax,0x18(%esp)
  206864:	75 d1                	jne    206837 <ff_uni2oem+0x47>
  206866:	0f b7 44 24 12       	movzwl 0x12(%esp),%eax
  20686b:	66 83 e8 80          	sub    $0xff80,%ax
  20686f:	66 25 ff 00          	and    $0xff,%ax
  206873:	66 89 44 24 12       	mov    %ax,0x12(%esp)
  206878:	0f b7 44 24 12       	movzwl 0x12(%esp),%eax
  20687d:	83 c4 14             	add    $0x14,%esp
  206880:	c3                   	ret

00206881 <ff_oem2uni>:
  206881:	83 ec 18             	sub    $0x18,%esp
  206884:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  206888:	8b 44 24 20          	mov    0x20(%esp),%eax
  20688c:	66 89 54 24 04       	mov    %dx,0x4(%esp)
  206891:	66 89 04 24          	mov    %ax,(%esp)
  206895:	66 c7 44 24 16 00 00 	movw   $0x0,0x16(%esp)
  20689c:	c7 44 24 10 60 72 20 	movl   $0x207260,0x10(%esp)
  2068a3:	00 
  2068a4:	66 83 7c 24 04 7f    	cmpw   $0x7f,0x4(%esp)
  2068aa:	77 0c                	ja     2068b8 <ff_oem2uni+0x37>
  2068ac:	0f b7 44 24 04       	movzwl 0x4(%esp),%eax
  2068b1:	66 89 44 24 16       	mov    %ax,0x16(%esp)
  2068b6:	eb 2c                	jmp    2068e4 <ff_oem2uni+0x63>
  2068b8:	66 81 3c 24 b5 01    	cmpw   $0x1b5,(%esp)
  2068be:	75 24                	jne    2068e4 <ff_oem2uni+0x63>
  2068c0:	66 81 7c 24 04 ff 00 	cmpw   $0xff,0x4(%esp)
  2068c7:	77 1b                	ja     2068e4 <ff_oem2uni+0x63>
  2068c9:	0f b7 44 24 04       	movzwl 0x4(%esp),%eax
  2068ce:	05 80 ff ff 7f       	add    $0x7fffff80,%eax
  2068d3:	8d 14 00             	lea    (%eax,%eax,1),%edx
  2068d6:	8b 44 24 10          	mov    0x10(%esp),%eax
  2068da:	01 d0                	add    %edx,%eax
  2068dc:	0f b7 00             	movzwl (%eax),%eax
  2068df:	66 89 44 24 16       	mov    %ax,0x16(%esp)
  2068e4:	0f b7 44 24 16       	movzwl 0x16(%esp),%eax
  2068e9:	83 c4 18             	add    $0x18,%esp
  2068ec:	c3                   	ret

002068ed <ff_wtoupper>:
  2068ed:	83 ec 10             	sub    $0x10,%esp
  2068f0:	81 7c 24 14 ff ff 00 	cmpl   $0xffff,0x14(%esp)
  2068f7:	00 
  2068f8:	0f 87 ae 01 00 00    	ja     206aac <ff_wtoupper+0x1bf>
  2068fe:	8b 44 24 14          	mov    0x14(%esp),%eax
  206902:	66 89 44 24 0a       	mov    %ax,0xa(%esp)
  206907:	66 81 7c 24 0a ff 0f 	cmpw   $0xfff,0xa(%esp)
  20690e:	77 0a                	ja     20691a <ff_wtoupper+0x2d>
  206910:	c7 44 24 0c 60 73 20 	movl   $0x207360,0xc(%esp)
  206917:	00 
  206918:	eb 08                	jmp    206922 <ff_wtoupper+0x35>
  20691a:	c7 44 24 0c 60 75 20 	movl   $0x207560,0xc(%esp)
  206921:	00 
  206922:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206926:	8d 50 02             	lea    0x2(%eax),%edx
  206929:	89 54 24 0c          	mov    %edx,0xc(%esp)
  20692d:	0f b7 00             	movzwl (%eax),%eax
  206930:	66 89 44 24 08       	mov    %ax,0x8(%esp)
  206935:	66 83 7c 24 08 00    	cmpw   $0x0,0x8(%esp)
  20693b:	0f 84 62 01 00 00    	je     206aa3 <ff_wtoupper+0x1b6>
  206941:	0f b7 44 24 0a       	movzwl 0xa(%esp),%eax
  206946:	66 3b 44 24 08       	cmp    0x8(%esp),%ax
  20694b:	0f 82 52 01 00 00    	jb     206aa3 <ff_wtoupper+0x1b6>
  206951:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206955:	8d 50 02             	lea    0x2(%eax),%edx
  206958:	89 54 24 0c          	mov    %edx,0xc(%esp)
  20695c:	0f b7 00             	movzwl (%eax),%eax
  20695f:	66 89 44 24 06       	mov    %ax,0x6(%esp)
  206964:	0f b7 44 24 06       	movzwl 0x6(%esp),%eax
  206969:	66 c1 e8 08          	shr    $0x8,%ax
  20696d:	66 89 44 24 04       	mov    %ax,0x4(%esp)
  206972:	66 81 64 24 06 ff 00 	andw   $0xff,0x6(%esp)
  206979:	0f b7 54 24 0a       	movzwl 0xa(%esp),%edx
  20697e:	0f b7 4c 24 08       	movzwl 0x8(%esp),%ecx
  206983:	0f b7 44 24 06       	movzwl 0x6(%esp),%eax
  206988:	01 c8                	add    %ecx,%eax
  20698a:	39 c2                	cmp    %eax,%edx
  20698c:	0f 8d f4 00 00 00    	jge    206a86 <ff_wtoupper+0x199>
  206992:	0f b7 44 24 04       	movzwl 0x4(%esp),%eax
  206997:	83 f8 08             	cmp    $0x8,%eax
  20699a:	0f 84 dc 00 00 00    	je     206a7c <ff_wtoupper+0x18f>
  2069a0:	83 f8 08             	cmp    $0x8,%eax
  2069a3:	0f 8f f9 00 00 00    	jg     206aa2 <ff_wtoupper+0x1b5>
  2069a9:	83 f8 07             	cmp    $0x7,%eax
  2069ac:	0f 84 c2 00 00 00    	je     206a74 <ff_wtoupper+0x187>
  2069b2:	83 f8 07             	cmp    $0x7,%eax
  2069b5:	0f 8f e7 00 00 00    	jg     206aa2 <ff_wtoupper+0x1b5>
  2069bb:	83 f8 06             	cmp    $0x6,%eax
  2069be:	0f 84 a8 00 00 00    	je     206a6c <ff_wtoupper+0x17f>
  2069c4:	83 f8 06             	cmp    $0x6,%eax
  2069c7:	0f 8f d5 00 00 00    	jg     206aa2 <ff_wtoupper+0x1b5>
  2069cd:	83 f8 05             	cmp    $0x5,%eax
  2069d0:	0f 84 8e 00 00 00    	je     206a64 <ff_wtoupper+0x177>
  2069d6:	83 f8 05             	cmp    $0x5,%eax
  2069d9:	0f 8f c3 00 00 00    	jg     206aa2 <ff_wtoupper+0x1b5>
  2069df:	83 f8 04             	cmp    $0x4,%eax
  2069e2:	74 78                	je     206a5c <ff_wtoupper+0x16f>
  2069e4:	83 f8 04             	cmp    $0x4,%eax
  2069e7:	0f 8f b5 00 00 00    	jg     206aa2 <ff_wtoupper+0x1b5>
  2069ed:	83 f8 03             	cmp    $0x3,%eax
  2069f0:	74 62                	je     206a54 <ff_wtoupper+0x167>
  2069f2:	83 f8 03             	cmp    $0x3,%eax
  2069f5:	0f 8f a7 00 00 00    	jg     206aa2 <ff_wtoupper+0x1b5>
  2069fb:	83 f8 02             	cmp    $0x2,%eax
  2069fe:	74 4c                	je     206a4c <ff_wtoupper+0x15f>
  206a00:	83 f8 02             	cmp    $0x2,%eax
  206a03:	0f 8f 99 00 00 00    	jg     206aa2 <ff_wtoupper+0x1b5>
  206a09:	85 c0                	test   %eax,%eax
  206a0b:	74 0a                	je     206a17 <ff_wtoupper+0x12a>
  206a0d:	83 f8 01             	cmp    $0x1,%eax
  206a10:	74 26                	je     206a38 <ff_wtoupper+0x14b>
  206a12:	e9 8b 00 00 00       	jmp    206aa2 <ff_wtoupper+0x1b5>
  206a17:	0f b7 54 24 0a       	movzwl 0xa(%esp),%edx
  206a1c:	0f b7 44 24 08       	movzwl 0x8(%esp),%eax
  206a21:	29 c2                	sub    %eax,%edx
  206a23:	89 d0                	mov    %edx,%eax
  206a25:	8d 14 00             	lea    (%eax,%eax,1),%edx
  206a28:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206a2c:	01 d0                	add    %edx,%eax
  206a2e:	0f b7 00             	movzwl (%eax),%eax
  206a31:	66 89 44 24 0a       	mov    %ax,0xa(%esp)
  206a36:	eb 4c                	jmp    206a84 <ff_wtoupper+0x197>
  206a38:	0f b7 44 24 0a       	movzwl 0xa(%esp),%eax
  206a3d:	66 2b 44 24 08       	sub    0x8(%esp),%ax
  206a42:	83 e0 01             	and    $0x1,%eax
  206a45:	66 29 44 24 0a       	sub    %ax,0xa(%esp)
  206a4a:	eb 38                	jmp    206a84 <ff_wtoupper+0x197>
  206a4c:	66 83 6c 24 0a 10    	subw   $0x10,0xa(%esp)
  206a52:	eb 30                	jmp    206a84 <ff_wtoupper+0x197>
  206a54:	66 83 6c 24 0a 20    	subw   $0x20,0xa(%esp)
  206a5a:	eb 28                	jmp    206a84 <ff_wtoupper+0x197>
  206a5c:	66 83 6c 24 0a 30    	subw   $0x30,0xa(%esp)
  206a62:	eb 20                	jmp    206a84 <ff_wtoupper+0x197>
  206a64:	66 83 6c 24 0a 1a    	subw   $0x1a,0xa(%esp)
  206a6a:	eb 18                	jmp    206a84 <ff_wtoupper+0x197>
  206a6c:	66 83 44 24 0a 08    	addw   $0x8,0xa(%esp)
  206a72:	eb 10                	jmp    206a84 <ff_wtoupper+0x197>
  206a74:	66 83 6c 24 0a 50    	subw   $0x50,0xa(%esp)
  206a7a:	eb 08                	jmp    206a84 <ff_wtoupper+0x197>
  206a7c:	66 81 6c 24 0a 60 1c 	subw   $0x1c60,0xa(%esp)
  206a83:	90                   	nop
  206a84:	eb 1c                	jmp    206aa2 <ff_wtoupper+0x1b5>
  206a86:	66 83 7c 24 04 00    	cmpw   $0x0,0x4(%esp)
  206a8c:	0f 85 90 fe ff ff    	jne    206922 <ff_wtoupper+0x35>
  206a92:	0f b7 44 24 06       	movzwl 0x6(%esp),%eax
  206a97:	01 c0                	add    %eax,%eax
  206a99:	01 44 24 0c          	add    %eax,0xc(%esp)
  206a9d:	e9 80 fe ff ff       	jmp    206922 <ff_wtoupper+0x35>
  206aa2:	90                   	nop
  206aa3:	0f b7 44 24 0a       	movzwl 0xa(%esp),%eax
  206aa8:	89 44 24 14          	mov    %eax,0x14(%esp)
  206aac:	8b 44 24 14          	mov    0x14(%esp),%eax
  206ab0:	83 c4 10             	add    $0x10,%esp
  206ab3:	c3                   	ret

00206ab4 <kb_isr>:
  206ab4:	60                   	pusha
  206ab5:	e8 f8 fb ff ff       	call   2066b2 <kb_handler>
  206aba:	b0 20                	mov    $0x20,%al
  206abc:	e6 20                	out    %al,$0x20
  206abe:	61                   	popa
  206abf:	cf                   	iret

00206ac0 <default_isr>:
  206ac0:	cf                   	iret

00206ac1 <default_isr_code>:
  206ac1:	83 c4 04             	add    $0x4,%esp
  206ac4:	cf                   	iret

00206ac5 <default_irq>:
  206ac5:	b0 20                	mov    $0x20,%al
  206ac7:	e6 20                	out    %al,$0x20
  206ac9:	cf                   	iret

00206aca <syscall_dispatch>:
  206aca:	60                   	pusha
  206acb:	89 c7                	mov    %eax,%edi
  206acd:	d1 e7                	shl    $1,%edi
  206acf:	d1 e7                	shl    $1,%edi
  206ad1:	81 c7 db 6a 20 00    	add    $0x206adb,%edi
  206ad7:	ff 17                	call   *(%edi)
  206ad9:	61                   	popa
  206ada:	cf                   	iret

00206adb <syscall_table>:
  206adb:	f7 6a 20             	imull  0x20(%edx)
  206ade:	00 f8                	add    %bh,%al
  206ae0:	6a 20                	push   $0x20
  206ae2:	00 04 6b             	add    %al,(%ebx,%ebp,2)
  206ae5:	20 00                	and    %al,(%eax)
  206ae7:	f7 6a 20             	imull  0x20(%edx)
  206aea:	00 f7                	add    %dh,%bh
  206aec:	6a 20                	push   $0x20
  206aee:	00 f7                	add    %dh,%bh
  206af0:	6a 20                	push   $0x20
  206af2:	00 f7                	add    %dh,%bh
  206af4:	6a 20                	push   $0x20
	...

00206af7 <scall_stub>:
  206af7:	c3                   	ret

00206af8 <swrite>:
  206af8:	51                   	push   %ecx
  206af9:	53                   	push   %ebx
  206afa:	52                   	push   %edx
  206afb:	e8 e8 fa ff ff       	call   2065e8 <sys_write>
  206b00:	83 c4 0c             	add    $0xc,%esp
  206b03:	c3                   	ret

00206b04 <sread>:
  206b04:	51                   	push   %ecx
  206b05:	53                   	push   %ebx
  206b06:	52                   	push   %edx
  206b07:	e8 18 fb ff ff       	call   206624 <sys_read>
  206b0c:	83 c4 0c             	add    $0xc,%esp
  206b0f:	c3                   	ret

00206b10 <test_syscall>:
  206b10:	b8 01 00 00 00       	mov    $0x1,%eax
  206b15:	bb 20 a1 20 00       	mov    $0x20a120,%ebx
  206b1a:	b9 05 00 00 00       	mov    $0x5,%ecx
  206b1f:	ba 01 00 00 00       	mov    $0x1,%edx
  206b24:	cd 80                	int    $0x80
  206b26:	b8 02 00 00 00       	mov    $0x2,%eax
  206b2b:	bb ec bc 21 00       	mov    $0x21bcec,%ebx
  206b30:	b9 20 00 00 00       	mov    $0x20,%ecx
  206b35:	ba 00 00 00 00       	mov    $0x0,%edx
  206b3a:	cd 80                	int    $0x80
  206b3c:	c3                   	ret

00206b3d <putc>:
  206b3d:	83 ec 1c             	sub    $0x1c,%esp
  206b40:	8b 44 24 20          	mov    0x20(%esp),%eax
  206b44:	88 44 24 0c          	mov    %al,0xc(%esp)
  206b48:	0f be 44 24 0c       	movsbl 0xc(%esp),%eax
  206b4d:	83 ec 0c             	sub    $0xc,%esp
  206b50:	50                   	push   %eax
  206b51:	e8 00 f7 ff ff       	call   206256 <printc>
  206b56:	83 c4 10             	add    $0x10,%esp
  206b59:	90                   	nop
  206b5a:	83 c4 1c             	add    $0x1c,%esp
  206b5d:	c3                   	ret

00206b5e <puts>:
  206b5e:	83 ec 0c             	sub    $0xc,%esp
  206b61:	83 ec 0c             	sub    $0xc,%esp
  206b64:	ff 74 24 1c          	push   0x1c(%esp)
  206b68:	e8 bc f5 ff ff       	call   206129 <prints>
  206b6d:	83 c4 10             	add    $0x10,%esp
  206b70:	90                   	nop
  206b71:	83 c4 0c             	add    $0xc,%esp
  206b74:	c3                   	ret

00206b75 <printk>:
  206b75:	83 ec 0c             	sub    $0xc,%esp
  206b78:	83 ec 0c             	sub    $0xc,%esp
  206b7b:	ff 74 24 1c          	push   0x1c(%esp)
  206b7f:	e8 a5 f5 ff ff       	call   206129 <prints>
  206b84:	83 c4 10             	add    $0x10,%esp
  206b87:	90                   	nop
  206b88:	83 c4 0c             	add    $0xc,%esp
  206b8b:	c3                   	ret

00206b8c <puth>:
  206b8c:	83 ec 1c             	sub    $0x1c,%esp
  206b8f:	c6 44 24 0d 00       	movb   $0x0,0xd(%esp)
  206b94:	66 c7 44 24 0e 1c 00 	movw   $0x1c,0xe(%esp)
  206b9b:	eb 75                	jmp    206c12 <puth+0x86>
  206b9d:	0f bf 44 24 0e       	movswl 0xe(%esp),%eax
  206ba2:	8b 54 24 20          	mov    0x20(%esp),%edx
  206ba6:	89 c1                	mov    %eax,%ecx
  206ba8:	d3 ea                	shr    %cl,%edx
  206baa:	89 d0                	mov    %edx,%eax
  206bac:	83 e0 0f             	and    $0xf,%eax
  206baf:	88 44 24 0c          	mov    %al,0xc(%esp)
  206bb3:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
  206bb8:	84 c0                	test   %al,%al
  206bba:	7f 11                	jg     206bcd <puth+0x41>
  206bbc:	0f b6 44 24 0d       	movzbl 0xd(%esp),%eax
  206bc1:	84 c0                	test   %al,%al
  206bc3:	75 08                	jne    206bcd <puth+0x41>
  206bc5:	66 83 7c 24 0e 00    	cmpw   $0x0,0xe(%esp)
  206bcb:	75 38                	jne    206c05 <puth+0x79>
  206bcd:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
  206bd2:	3c 09                	cmp    $0x9,%al
  206bd4:	7f 0a                	jg     206be0 <puth+0x54>
  206bd6:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
  206bdb:	83 c0 30             	add    $0x30,%eax
  206bde:	eb 08                	jmp    206be8 <puth+0x5c>
  206be0:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
  206be5:	83 c0 37             	add    $0x37,%eax
  206be8:	88 44 24 0b          	mov    %al,0xb(%esp)
  206bec:	0f b6 44 24 0b       	movzbl 0xb(%esp),%eax
  206bf1:	0f be c0             	movsbl %al,%eax
  206bf4:	83 ec 0c             	sub    $0xc,%esp
  206bf7:	50                   	push   %eax
  206bf8:	e8 40 ff ff ff       	call   206b3d <putc>
  206bfd:	83 c4 10             	add    $0x10,%esp
  206c00:	c6 44 24 0d 01       	movb   $0x1,0xd(%esp)
  206c05:	0f b7 44 24 0e       	movzwl 0xe(%esp),%eax
  206c0a:	83 e8 04             	sub    $0x4,%eax
  206c0d:	66 89 44 24 0e       	mov    %ax,0xe(%esp)
  206c12:	66 83 7c 24 0e 00    	cmpw   $0x0,0xe(%esp)
  206c18:	79 83                	jns    206b9d <puth+0x11>
  206c1a:	90                   	nop
  206c1b:	90                   	nop
  206c1c:	83 c4 1c             	add    $0x1c,%esp
  206c1f:	c3                   	ret

00206c20 <putlong>:
  206c20:	83 ec 1c             	sub    $0x1c,%esp
  206c23:	66 c7 44 24 0e 00 00 	movw   $0x0,0xe(%esp)
  206c2a:	c6 44 24 0d 00       	movb   $0x0,0xd(%esp)
  206c2f:	eb 7b                	jmp    206cac <putlong+0x8c>
  206c31:	c6 44 24 0c 00       	movb   $0x0,0xc(%esp)
  206c36:	eb 1c                	jmp    206c54 <putlong+0x34>
  206c38:	0f be 44 24 0d       	movsbl 0xd(%esp),%eax
  206c3d:	8b 04 85 40 a1 20 00 	mov    0x20a140(,%eax,4),%eax
  206c44:	29 44 24 20          	sub    %eax,0x20(%esp)
  206c48:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
  206c4d:	83 c0 01             	add    $0x1,%eax
  206c50:	88 44 24 0c          	mov    %al,0xc(%esp)
  206c54:	0f be 44 24 0d       	movsbl 0xd(%esp),%eax
  206c59:	8b 04 85 40 a1 20 00 	mov    0x20a140(,%eax,4),%eax
  206c60:	39 44 24 20          	cmp    %eax,0x20(%esp)
  206c64:	73 d2                	jae    206c38 <putlong+0x18>
  206c66:	80 7c 24 0c 00       	cmpb   $0x0,0xc(%esp)
  206c6b:	7f 0f                	jg     206c7c <putlong+0x5c>
  206c6d:	66 83 7c 24 0e 00    	cmpw   $0x0,0xe(%esp)
  206c73:	75 07                	jne    206c7c <putlong+0x5c>
  206c75:	80 7c 24 0d 09       	cmpb   $0x9,0xd(%esp)
  206c7a:	75 24                	jne    206ca0 <putlong+0x80>
  206c7c:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
  206c81:	83 c0 30             	add    $0x30,%eax
  206c84:	88 44 24 0b          	mov    %al,0xb(%esp)
  206c88:	0f be 44 24 0b       	movsbl 0xb(%esp),%eax
  206c8d:	83 ec 0c             	sub    $0xc,%esp
  206c90:	50                   	push   %eax
  206c91:	e8 a7 fe ff ff       	call   206b3d <putc>
  206c96:	83 c4 10             	add    $0x10,%esp
  206c99:	66 c7 44 24 0e 01 00 	movw   $0x1,0xe(%esp)
  206ca0:	0f b6 44 24 0d       	movzbl 0xd(%esp),%eax
  206ca5:	83 c0 01             	add    $0x1,%eax
  206ca8:	88 44 24 0d          	mov    %al,0xd(%esp)
  206cac:	80 7c 24 0d 09       	cmpb   $0x9,0xd(%esp)
  206cb1:	0f 8e 7a ff ff ff    	jle    206c31 <putlong+0x11>
  206cb7:	90                   	nop
  206cb8:	90                   	nop
  206cb9:	83 c4 1c             	add    $0x1c,%esp
  206cbc:	c3                   	ret

00206cbd <strcmp>:
  206cbd:	eb 0a                	jmp    206cc9 <strcmp+0xc>
  206cbf:	83 44 24 04 01       	addl   $0x1,0x4(%esp)
  206cc4:	83 44 24 08 01       	addl   $0x1,0x8(%esp)
  206cc9:	8b 44 24 04          	mov    0x4(%esp),%eax
  206ccd:	0f b6 00             	movzbl (%eax),%eax
  206cd0:	84 c0                	test   %al,%al
  206cd2:	74 12                	je     206ce6 <strcmp+0x29>
  206cd4:	8b 44 24 04          	mov    0x4(%esp),%eax
  206cd8:	0f b6 10             	movzbl (%eax),%edx
  206cdb:	8b 44 24 08          	mov    0x8(%esp),%eax
  206cdf:	0f b6 00             	movzbl (%eax),%eax
  206ce2:	38 c2                	cmp    %al,%dl
  206ce4:	74 d9                	je     206cbf <strcmp+0x2>
  206ce6:	8b 44 24 04          	mov    0x4(%esp),%eax
  206cea:	0f b6 00             	movzbl (%eax),%eax
  206ced:	66 0f be d0          	movsbw %al,%dx
  206cf1:	8b 44 24 08          	mov    0x8(%esp),%eax
  206cf5:	0f b6 00             	movzbl (%eax),%eax
  206cf8:	66 98                	cbtw
  206cfa:	29 c2                	sub    %eax,%edx
  206cfc:	89 d0                	mov    %edx,%eax
  206cfe:	c3                   	ret

00206cff <strcpy>:
  206cff:	eb 0a                	jmp    206d0b <strcpy+0xc>
  206d01:	83 44 24 04 01       	addl   $0x1,0x4(%esp)
  206d06:	83 44 24 08 01       	addl   $0x1,0x8(%esp)
  206d0b:	8b 44 24 08          	mov    0x8(%esp),%eax
  206d0f:	0f b6 10             	movzbl (%eax),%edx
  206d12:	8b 44 24 04          	mov    0x4(%esp),%eax
  206d16:	88 10                	mov    %dl,(%eax)
  206d18:	8b 44 24 04          	mov    0x4(%esp),%eax
  206d1c:	0f b6 00             	movzbl (%eax),%eax
  206d1f:	84 c0                	test   %al,%al
  206d21:	75 de                	jne    206d01 <strcpy+0x2>
  206d23:	8b 44 24 04          	mov    0x4(%esp),%eax
  206d27:	c6 00 00             	movb   $0x0,(%eax)
  206d2a:	90                   	nop
  206d2b:	c3                   	ret

00206d2c <strcat>:
  206d2c:	eb 05                	jmp    206d33 <strcat+0x7>
  206d2e:	83 44 24 04 01       	addl   $0x1,0x4(%esp)
  206d33:	8b 44 24 04          	mov    0x4(%esp),%eax
  206d37:	0f b6 00             	movzbl (%eax),%eax
  206d3a:	84 c0                	test   %al,%al
  206d3c:	75 f0                	jne    206d2e <strcat+0x2>
  206d3e:	ff 74 24 08          	push   0x8(%esp)
  206d42:	ff 74 24 08          	push   0x8(%esp)
  206d46:	e8 b4 ff ff ff       	call   206cff <strcpy>
  206d4b:	83 c4 08             	add    $0x8,%esp
  206d4e:	90                   	nop
  206d4f:	c3                   	ret

00206d50 <strlen>:
  206d50:	83 ec 10             	sub    $0x10,%esp
  206d53:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  206d5a:	00 
  206d5b:	eb 05                	jmp    206d62 <strlen+0x12>
  206d5d:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
  206d62:	8b 54 24 14          	mov    0x14(%esp),%edx
  206d66:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206d6a:	01 d0                	add    %edx,%eax
  206d6c:	0f b6 00             	movzbl (%eax),%eax
  206d6f:	84 c0                	test   %al,%al
  206d71:	75 ea                	jne    206d5d <strlen+0xd>
  206d73:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206d77:	83 c4 10             	add    $0x10,%esp
  206d7a:	c3                   	ret

00206d7b <startsWith>:
  206d7b:	eb 0a                	jmp    206d87 <startsWith+0xc>
  206d7d:	83 44 24 04 01       	addl   $0x1,0x4(%esp)
  206d82:	83 44 24 08 01       	addl   $0x1,0x8(%esp)
  206d87:	8b 44 24 08          	mov    0x8(%esp),%eax
  206d8b:	0f b6 00             	movzbl (%eax),%eax
  206d8e:	84 c0                	test   %al,%al
  206d90:	74 12                	je     206da4 <startsWith+0x29>
  206d92:	8b 44 24 04          	mov    0x4(%esp),%eax
  206d96:	0f b6 10             	movzbl (%eax),%edx
  206d99:	8b 44 24 08          	mov    0x8(%esp),%eax
  206d9d:	0f b6 00             	movzbl (%eax),%eax
  206da0:	38 c2                	cmp    %al,%dl
  206da2:	74 d9                	je     206d7d <startsWith+0x2>
  206da4:	8b 44 24 08          	mov    0x8(%esp),%eax
  206da8:	0f b6 00             	movzbl (%eax),%eax
  206dab:	84 c0                	test   %al,%al
  206dad:	0f 95 c0             	setne  %al
  206db0:	0f b6 c0             	movzbl %al,%eax
  206db3:	c3                   	ret

00206db4 <strncpy>:
  206db4:	83 ec 10             	sub    $0x10,%esp
  206db7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  206dbe:	00 
  206dbf:	eb 1e                	jmp    206ddf <strncpy+0x2b>
  206dc1:	8b 54 24 0c          	mov    0xc(%esp),%edx
  206dc5:	8b 44 24 18          	mov    0x18(%esp),%eax
  206dc9:	01 d0                	add    %edx,%eax
  206dcb:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  206dcf:	8b 54 24 14          	mov    0x14(%esp),%edx
  206dd3:	01 ca                	add    %ecx,%edx
  206dd5:	0f b6 00             	movzbl (%eax),%eax
  206dd8:	88 02                	mov    %al,(%edx)
  206dda:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
  206ddf:	8b 54 24 0c          	mov    0xc(%esp),%edx
  206de3:	8b 44 24 18          	mov    0x18(%esp),%eax
  206de7:	01 d0                	add    %edx,%eax
  206de9:	0f b6 00             	movzbl (%eax),%eax
  206dec:	84 c0                	test   %al,%al
  206dee:	74 0a                	je     206dfa <strncpy+0x46>
  206df0:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206df4:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
  206df8:	7c c7                	jl     206dc1 <strncpy+0xd>
  206dfa:	8b 54 24 0c          	mov    0xc(%esp),%edx
  206dfe:	8b 44 24 14          	mov    0x14(%esp),%eax
  206e02:	01 d0                	add    %edx,%eax
  206e04:	c6 00 00             	movb   $0x0,(%eax)
  206e07:	8b 44 24 14          	mov    0x14(%esp),%eax
  206e0b:	83 c4 10             	add    $0x10,%esp
  206e0e:	c3                   	ret

00206e0f <memset>:
  206e0f:	83 ec 10             	sub    $0x10,%esp
  206e12:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  206e19:	00 
  206e1a:	eb 15                	jmp    206e31 <memset+0x22>
  206e1c:	8b 54 24 14          	mov    0x14(%esp),%edx
  206e20:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206e24:	01 d0                	add    %edx,%eax
  206e26:	8b 54 24 18          	mov    0x18(%esp),%edx
  206e2a:	88 10                	mov    %dl,(%eax)
  206e2c:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
  206e31:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206e35:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
  206e39:	72 e1                	jb     206e1c <memset+0xd>
  206e3b:	8b 44 24 14          	mov    0x14(%esp),%eax
  206e3f:	83 c4 10             	add    $0x10,%esp
  206e42:	c3                   	ret

00206e43 <memcpy>:
  206e43:	83 ec 10             	sub    $0x10,%esp
  206e46:	8b 44 24 14          	mov    0x14(%esp),%eax
  206e4a:	89 44 24 08          	mov    %eax,0x8(%esp)
  206e4e:	8b 44 24 18          	mov    0x18(%esp),%eax
  206e52:	89 44 24 04          	mov    %eax,0x4(%esp)
  206e56:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  206e5d:	00 
  206e5e:	eb 1e                	jmp    206e7e <memcpy+0x3b>
  206e60:	8b 54 24 04          	mov    0x4(%esp),%edx
  206e64:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206e68:	01 d0                	add    %edx,%eax
  206e6a:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  206e6e:	8b 54 24 0c          	mov    0xc(%esp),%edx
  206e72:	01 ca                	add    %ecx,%edx
  206e74:	0f b6 00             	movzbl (%eax),%eax
  206e77:	88 02                	mov    %al,(%edx)
  206e79:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
  206e7e:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206e82:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
  206e86:	72 d8                	jb     206e60 <memcpy+0x1d>
  206e88:	8b 44 24 14          	mov    0x14(%esp),%eax
  206e8c:	83 c4 10             	add    $0x10,%esp
  206e8f:	c3                   	ret

00206e90 <memcmp>:
  206e90:	83 ec 10             	sub    $0x10,%esp
  206e93:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  206e9a:	00 
  206e9b:	eb 47                	jmp    206ee4 <memcmp+0x54>
  206e9d:	8b 54 24 14          	mov    0x14(%esp),%edx
  206ea1:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206ea5:	01 d0                	add    %edx,%eax
  206ea7:	0f b6 10             	movzbl (%eax),%edx
  206eaa:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  206eae:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206eb2:	01 c8                	add    %ecx,%eax
  206eb4:	0f b6 00             	movzbl (%eax),%eax
  206eb7:	38 c2                	cmp    %al,%dl
  206eb9:	74 24                	je     206edf <memcmp+0x4f>
  206ebb:	8b 54 24 14          	mov    0x14(%esp),%edx
  206ebf:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206ec3:	01 d0                	add    %edx,%eax
  206ec5:	0f b6 00             	movzbl (%eax),%eax
  206ec8:	0f be d0             	movsbl %al,%edx
  206ecb:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  206ecf:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206ed3:	01 c8                	add    %ecx,%eax
  206ed5:	0f b6 00             	movzbl (%eax),%eax
  206ed8:	0f be c0             	movsbl %al,%eax
  206edb:	29 c2                	sub    %eax,%edx
  206edd:	eb 14                	jmp    206ef3 <memcmp+0x63>
  206edf:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
  206ee4:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206ee8:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
  206eec:	72 af                	jb     206e9d <memcmp+0xd>
  206eee:	ba 00 00 00 00       	mov    $0x0,%edx
  206ef3:	89 d0                	mov    %edx,%eax
  206ef5:	83 c4 10             	add    $0x10,%esp
  206ef8:	c3                   	ret

00206ef9 <strncmp>:
  206ef9:	83 ec 10             	sub    $0x10,%esp
  206efc:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  206f03:	00 
  206f04:	eb 47                	jmp    206f4d <strncmp+0x54>
  206f06:	8b 54 24 14          	mov    0x14(%esp),%edx
  206f0a:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206f0e:	01 d0                	add    %edx,%eax
  206f10:	0f b6 10             	movzbl (%eax),%edx
  206f13:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  206f17:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206f1b:	01 c8                	add    %ecx,%eax
  206f1d:	0f b6 00             	movzbl (%eax),%eax
  206f20:	38 c2                	cmp    %al,%dl
  206f22:	74 24                	je     206f48 <strncmp+0x4f>
  206f24:	8b 54 24 14          	mov    0x14(%esp),%edx
  206f28:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206f2c:	01 d0                	add    %edx,%eax
  206f2e:	0f b6 00             	movzbl (%eax),%eax
  206f31:	0f be d0             	movsbl %al,%edx
  206f34:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  206f38:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206f3c:	01 c8                	add    %ecx,%eax
  206f3e:	0f b6 00             	movzbl (%eax),%eax
  206f41:	0f be c0             	movsbl %al,%eax
  206f44:	29 c2                	sub    %eax,%edx
  206f46:	eb 14                	jmp    206f5c <strncmp+0x63>
  206f48:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
  206f4d:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206f51:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
  206f55:	72 af                	jb     206f06 <strncmp+0xd>
  206f57:	ba 00 00 00 00       	mov    $0x0,%edx
  206f5c:	89 d0                	mov    %edx,%eax
  206f5e:	83 c4 10             	add    $0x10,%esp
  206f61:	c3                   	ret

00206f62 <strchr>:
  206f62:	eb 1a                	jmp    206f7e <strchr+0x1c>
  206f64:	8b 44 24 04          	mov    0x4(%esp),%eax
  206f68:	0f b6 00             	movzbl (%eax),%eax
  206f6b:	0f be c0             	movsbl %al,%eax
  206f6e:	39 44 24 08          	cmp    %eax,0x8(%esp)
  206f72:	75 05                	jne    206f79 <strchr+0x17>
  206f74:	8b 44 24 04          	mov    0x4(%esp),%eax
  206f78:	c3                   	ret
  206f79:	83 44 24 04 01       	addl   $0x1,0x4(%esp)
  206f7e:	8b 44 24 04          	mov    0x4(%esp),%eax
  206f82:	0f b6 00             	movzbl (%eax),%eax
  206f85:	84 c0                	test   %al,%al
  206f87:	75 db                	jne    206f64 <strchr+0x2>
  206f89:	b8 00 00 00 00       	mov    $0x0,%eax
  206f8e:	c3                   	ret

00206f8f <atoi>:
  206f8f:	83 ec 10             	sub    $0x10,%esp
  206f92:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  206f99:	00 
  206f9a:	eb 27                	jmp    206fc3 <atoi+0x34>
  206f9c:	8b 54 24 0c          	mov    0xc(%esp),%edx
  206fa0:	89 d0                	mov    %edx,%eax
  206fa2:	c1 e0 02             	shl    $0x2,%eax
  206fa5:	01 d0                	add    %edx,%eax
  206fa7:	01 c0                	add    %eax,%eax
  206fa9:	89 c2                	mov    %eax,%edx
  206fab:	8b 44 24 14          	mov    0x14(%esp),%eax
  206faf:	0f b6 00             	movzbl (%eax),%eax
  206fb2:	0f be c0             	movsbl %al,%eax
  206fb5:	83 e8 30             	sub    $0x30,%eax
  206fb8:	01 d0                	add    %edx,%eax
  206fba:	89 44 24 0c          	mov    %eax,0xc(%esp)
  206fbe:	83 44 24 14 01       	addl   $0x1,0x14(%esp)
  206fc3:	8b 44 24 14          	mov    0x14(%esp),%eax
  206fc7:	0f b6 00             	movzbl (%eax),%eax
  206fca:	84 c0                	test   %al,%al
  206fcc:	75 ce                	jne    206f9c <atoi+0xd>
  206fce:	8b 44 24 0c          	mov    0xc(%esp),%eax
  206fd2:	83 c4 10             	add    $0x10,%esp
  206fd5:	c3                   	ret
