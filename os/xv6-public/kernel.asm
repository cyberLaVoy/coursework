
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc e0 c5 10 80       	mov    $0x8010c5e0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 30 32 10 80       	mov    $0x80103230,%eax
  jmp *%eax
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
80100044:	bb 14 c6 10 80       	mov    $0x8010c614,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 a0 7b 10 80       	push   $0x80107ba0
80100051:	68 e0 c5 10 80       	push   $0x8010c5e0
80100056:	e8 75 4d 00 00       	call   80104dd0 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	ba dc 0c 11 80       	mov    $0x80110cdc,%edx
  bcache.head.prev = &bcache.head;
80100063:	c7 05 2c 0d 11 80 dc 	movl   $0x80110cdc,0x80110d2c
8010006a:	0c 11 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 30 0d 11 80 dc 	movl   $0x80110cdc,0x80110d30
80100074:	0c 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	83 ec 08             	sub    $0x8,%esp
80100085:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 dc 0c 11 80 	movl   $0x80110cdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 a7 7b 10 80       	push   $0x80107ba7
80100097:	50                   	push   %eax
80100098:	e8 03 4c 00 00       	call   80104ca0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 30 0d 11 80       	mov    0x80110d30,%eax
801000a2:	89 da                	mov    %ebx,%edx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a4:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 30 0d 11 80    	mov    %ebx,0x80110d30
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d dc 0c 11 80       	cmp    $0x80110cdc,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

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
801000d9:	8b 7d 08             	mov    0x8(%ebp),%edi
801000dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&bcache.lock);
801000df:	68 e0 c5 10 80       	push   $0x8010c5e0
801000e4:	e8 47 4e 00 00       	call   80104f30 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 30 0d 11 80    	mov    0x80110d30,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 7b 04             	cmp    0x4(%ebx),%edi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 73 08             	cmp    0x8(%ebx),%esi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 2c 0d 11 80    	mov    0x80110d2c,%ebx
80100126:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
80100139:	74 65                	je     801001a0 <bread+0xd0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 7b 04             	mov    %edi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 73 08             	mov    %esi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 e0 c5 10 80       	push   $0x8010c5e0
80100162:	e8 89 4e 00 00       	call   80104ff0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 6e 4b 00 00       	call   80104ce0 <acquiresleep>
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
8010018c:	e8 6f 20 00 00       	call   80102200 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	66 90                	xchg   %ax,%ax
  panic("bget: no buffers");
801001a0:	83 ec 0c             	sub    $0xc,%esp
801001a3:	68 ae 7b 10 80       	push   $0x80107bae
801001a8:	e8 e3 01 00 00       	call   80100390 <panic>
801001ad:	8d 76 00             	lea    0x0(%esi),%esi

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
801001be:	e8 bd 4b 00 00       	call   80104d80 <holdingsleep>
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
801001d4:	e9 27 20 00 00       	jmp    80102200 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 bf 7b 10 80       	push   $0x80107bbf
801001e1:	e8 aa 01 00 00       	call   80100390 <panic>
801001e6:	8d 76 00             	lea    0x0(%esi),%esi
801001e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

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
801001ff:	e8 7c 4b 00 00       	call   80104d80 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 2c 4b 00 00       	call   80104d40 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 e0 c5 10 80 	movl   $0x8010c5e0,(%esp)
8010021b:	e8 10 4d 00 00       	call   80104f30 <acquire>
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
80100242:	a1 30 0d 11 80       	mov    0x80110d30,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 dc 0c 11 80 	movl   $0x80110cdc,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 30 0d 11 80       	mov    0x80110d30,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 30 0d 11 80    	mov    %ebx,0x80110d30
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 e0 c5 10 80 	movl   $0x8010c5e0,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 7f 4d 00 00       	jmp    80104ff0 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 c6 7b 10 80       	push   $0x80107bc6
80100279:	e8 12 01 00 00       	call   80100390 <panic>
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
80100286:	83 ec 28             	sub    $0x28,%esp
  uint target;
  int c;

  iunlock(ip);
80100289:	ff 75 08             	pushl  0x8(%ebp)
{
8010028c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010028f:	e8 6c 15 00 00       	call   80101800 <iunlock>
  target = n;
  acquire(&cons.lock);
80100294:	c7 04 24 40 b5 10 80 	movl   $0x8010b540,(%esp)
8010029b:	e8 90 4c 00 00       	call   80104f30 <acquire>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002a0:	8b 7d 0c             	mov    0xc(%ebp),%edi
  while(n > 0){
801002a3:	83 c4 10             	add    $0x10,%esp
801002a6:	31 c0                	xor    %eax,%eax
    *dst++ = c;
801002a8:	01 f7                	add    %esi,%edi
  while(n > 0){
801002aa:	85 f6                	test   %esi,%esi
801002ac:	0f 8e a0 00 00 00    	jle    80100352 <consoleread+0xd2>
801002b2:	89 f3                	mov    %esi,%ebx
    while(input.r == input.w){
801002b4:	8b 15 c0 0f 11 80    	mov    0x80110fc0,%edx
801002ba:	39 15 c4 0f 11 80    	cmp    %edx,0x80110fc4
801002c0:	74 29                	je     801002eb <consoleread+0x6b>
801002c2:	eb 5c                	jmp    80100320 <consoleread+0xa0>
801002c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      sleep(&input.r, &cons.lock);
801002c8:	83 ec 08             	sub    $0x8,%esp
801002cb:	68 40 b5 10 80       	push   $0x8010b540
801002d0:	68 c0 0f 11 80       	push   $0x80110fc0
801002d5:	e8 56 46 00 00       	call   80104930 <sleep>
    while(input.r == input.w){
801002da:	8b 15 c0 0f 11 80    	mov    0x80110fc0,%edx
801002e0:	83 c4 10             	add    $0x10,%esp
801002e3:	3b 15 c4 0f 11 80    	cmp    0x80110fc4,%edx
801002e9:	75 35                	jne    80100320 <consoleread+0xa0>
      if(myproc()->killed){
801002eb:	e8 b0 39 00 00       	call   80103ca0 <myproc>
801002f0:	8b 48 24             	mov    0x24(%eax),%ecx
801002f3:	85 c9                	test   %ecx,%ecx
801002f5:	74 d1                	je     801002c8 <consoleread+0x48>
        release(&cons.lock);
801002f7:	83 ec 0c             	sub    $0xc,%esp
801002fa:	68 40 b5 10 80       	push   $0x8010b540
801002ff:	e8 ec 4c 00 00       	call   80104ff0 <release>
        ilock(ip);
80100304:	5a                   	pop    %edx
80100305:	ff 75 08             	pushl  0x8(%ebp)
80100308:	e8 13 14 00 00       	call   80101720 <ilock>
        return -1;
8010030d:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100310:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100313:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100318:	5b                   	pop    %ebx
80100319:	5e                   	pop    %esi
8010031a:	5f                   	pop    %edi
8010031b:	5d                   	pop    %ebp
8010031c:	c3                   	ret    
8010031d:	8d 76 00             	lea    0x0(%esi),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100320:	8d 42 01             	lea    0x1(%edx),%eax
80100323:	a3 c0 0f 11 80       	mov    %eax,0x80110fc0
80100328:	89 d0                	mov    %edx,%eax
8010032a:	83 e0 7f             	and    $0x7f,%eax
8010032d:	0f be 80 40 0f 11 80 	movsbl -0x7feef0c0(%eax),%eax
    if(c == C('D')){  // EOF
80100334:	83 f8 04             	cmp    $0x4,%eax
80100337:	74 46                	je     8010037f <consoleread+0xff>
    *dst++ = c;
80100339:	89 da                	mov    %ebx,%edx
    --n;
8010033b:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
8010033e:	f7 da                	neg    %edx
80100340:	88 04 17             	mov    %al,(%edi,%edx,1)
    if(c == '\n')
80100343:	83 f8 0a             	cmp    $0xa,%eax
80100346:	74 31                	je     80100379 <consoleread+0xf9>
  while(n > 0){
80100348:	85 db                	test   %ebx,%ebx
8010034a:	0f 85 64 ff ff ff    	jne    801002b4 <consoleread+0x34>
80100350:	89 f0                	mov    %esi,%eax
  release(&cons.lock);
80100352:	83 ec 0c             	sub    $0xc,%esp
80100355:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100358:	68 40 b5 10 80       	push   $0x8010b540
8010035d:	e8 8e 4c 00 00       	call   80104ff0 <release>
  ilock(ip);
80100362:	58                   	pop    %eax
80100363:	ff 75 08             	pushl  0x8(%ebp)
80100366:	e8 b5 13 00 00       	call   80101720 <ilock>
  return target - n;
8010036b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010036e:	83 c4 10             	add    $0x10,%esp
}
80100371:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100374:	5b                   	pop    %ebx
80100375:	5e                   	pop    %esi
80100376:	5f                   	pop    %edi
80100377:	5d                   	pop    %ebp
80100378:	c3                   	ret    
80100379:	89 f0                	mov    %esi,%eax
8010037b:	29 d8                	sub    %ebx,%eax
8010037d:	eb d3                	jmp    80100352 <consoleread+0xd2>
      if(n < target){
8010037f:	89 f0                	mov    %esi,%eax
80100381:	29 d8                	sub    %ebx,%eax
80100383:	39 f3                	cmp    %esi,%ebx
80100385:	73 cb                	jae    80100352 <consoleread+0xd2>
        input.r--;
80100387:	89 15 c0 0f 11 80    	mov    %edx,0x80110fc0
8010038d:	eb c3                	jmp    80100352 <consoleread+0xd2>
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 74 b5 10 80 00 	movl   $0x0,0x8010b574
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 02 27 00 00       	call   80102ab0 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 cd 7b 10 80       	push   $0x80107bcd
801003b7:	e8 f4 02 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 eb 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 27 86 10 80 	movl   $0x80108627,(%esp)
801003cc:	e8 df 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	8d 45 08             	lea    0x8(%ebp),%eax
801003d4:	5a                   	pop    %edx
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 13 4a 00 00       	call   80104df0 <getcallerpcs>
  for(i=0; i<10; i++)
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 e1 7b 10 80       	push   $0x80107be1
801003ed:	e8 be 02 00 00       	call   801006b0 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 78 b5 10 80 01 	movl   $0x1,0x8010b578
80100400:	00 00 00 
    ;
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc.part.0>:
consputc(int c)
80100410:	55                   	push   %ebp
80100411:	89 e5                	mov    %esp,%ebp
80100413:	57                   	push   %edi
80100414:	56                   	push   %esi
80100415:	53                   	push   %ebx
80100416:	89 c3                	mov    %eax,%ebx
80100418:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010041b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100420:	0f 84 ea 00 00 00    	je     80100510 <consputc.part.0+0x100>
    uartputc(c);
80100426:	83 ec 0c             	sub    $0xc,%esp
80100429:	50                   	push   %eax
8010042a:	e8 71 62 00 00       	call   801066a0 <uartputc>
8010042f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100432:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100437:	b8 0e 00 00 00       	mov    $0xe,%eax
8010043c:	89 fa                	mov    %edi,%edx
8010043e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010043f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100444:	89 ca                	mov    %ecx,%edx
80100446:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100447:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010044a:	89 fa                	mov    %edi,%edx
8010044c:	c1 e0 08             	shl    $0x8,%eax
8010044f:	89 c6                	mov    %eax,%esi
80100451:	b8 0f 00 00 00       	mov    $0xf,%eax
80100456:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100457:	89 ca                	mov    %ecx,%edx
80100459:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010045a:	0f b6 c0             	movzbl %al,%eax
8010045d:	09 f0                	or     %esi,%eax
  if(c == '\n')
8010045f:	83 fb 0a             	cmp    $0xa,%ebx
80100462:	0f 84 90 00 00 00    	je     801004f8 <consputc.part.0+0xe8>
  else if(c == BACKSPACE){
80100468:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010046e:	74 70                	je     801004e0 <consputc.part.0+0xd0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100470:	0f b6 db             	movzbl %bl,%ebx
80100473:	8d 70 01             	lea    0x1(%eax),%esi
80100476:	80 cf 07             	or     $0x7,%bh
80100479:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
80100480:	80 
  if(pos < 0 || pos > 25*80)
80100481:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100487:	0f 8f f9 00 00 00    	jg     80100586 <consputc.part.0+0x176>
  if((pos/80) >= 24){  // Scroll up.
8010048d:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100493:	0f 8f a7 00 00 00    	jg     80100540 <consputc.part.0+0x130>
80100499:	89 f0                	mov    %esi,%eax
8010049b:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
801004a2:	88 45 e7             	mov    %al,-0x19(%ebp)
801004a5:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004a8:	bb d4 03 00 00       	mov    $0x3d4,%ebx
801004ad:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b2:	89 da                	mov    %ebx,%edx
801004b4:	ee                   	out    %al,(%dx)
801004b5:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004ba:	89 f8                	mov    %edi,%eax
801004bc:	89 ca                	mov    %ecx,%edx
801004be:	ee                   	out    %al,(%dx)
801004bf:	b8 0f 00 00 00       	mov    $0xf,%eax
801004c4:	89 da                	mov    %ebx,%edx
801004c6:	ee                   	out    %al,(%dx)
801004c7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004cb:	89 ca                	mov    %ecx,%edx
801004cd:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004ce:	b8 20 07 00 00       	mov    $0x720,%eax
801004d3:	66 89 06             	mov    %ax,(%esi)
}
801004d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004d9:	5b                   	pop    %ebx
801004da:	5e                   	pop    %esi
801004db:	5f                   	pop    %edi
801004dc:	5d                   	pop    %ebp
801004dd:	c3                   	ret    
801004de:	66 90                	xchg   %ax,%ax
    if(pos > 0) --pos;
801004e0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004e3:	85 c0                	test   %eax,%eax
801004e5:	75 9a                	jne    80100481 <consputc.part.0+0x71>
801004e7:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004ec:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004f0:	31 ff                	xor    %edi,%edi
801004f2:	eb b4                	jmp    801004a8 <consputc.part.0+0x98>
801004f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004f8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004fd:	f7 e2                	mul    %edx
801004ff:	c1 ea 06             	shr    $0x6,%edx
80100502:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100505:	c1 e0 04             	shl    $0x4,%eax
80100508:	8d 70 50             	lea    0x50(%eax),%esi
8010050b:	e9 71 ff ff ff       	jmp    80100481 <consputc.part.0+0x71>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100510:	83 ec 0c             	sub    $0xc,%esp
80100513:	6a 08                	push   $0x8
80100515:	e8 86 61 00 00       	call   801066a0 <uartputc>
8010051a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100521:	e8 7a 61 00 00       	call   801066a0 <uartputc>
80100526:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010052d:	e8 6e 61 00 00       	call   801066a0 <uartputc>
80100532:	83 c4 10             	add    $0x10,%esp
80100535:	e9 f8 fe ff ff       	jmp    80100432 <consputc.part.0+0x22>
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100540:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100543:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100546:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010054b:	68 60 0e 00 00       	push   $0xe60
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100550:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100557:	68 a0 80 0b 80       	push   $0x800b80a0
8010055c:	68 00 80 0b 80       	push   $0x800b8000
80100561:	e8 7a 4b 00 00       	call   801050e0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 c5 4a 00 00       	call   80105040 <memset>
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 22 ff ff ff       	jmp    801004a8 <consputc.part.0+0x98>
    panic("pos under/overflow");
80100586:	83 ec 0c             	sub    $0xc,%esp
80100589:	68 e5 7b 10 80       	push   $0x80107be5
8010058e:	e8 fd fd ff ff       	call   80100390 <panic>
80100593:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801005a0 <printint>:
{
801005a0:	55                   	push   %ebp
801005a1:	89 e5                	mov    %esp,%ebp
801005a3:	57                   	push   %edi
801005a4:	56                   	push   %esi
801005a5:	53                   	push   %ebx
801005a6:	83 ec 2c             	sub    $0x2c,%esp
801005a9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
801005ac:	85 c9                	test   %ecx,%ecx
801005ae:	74 04                	je     801005b4 <printint+0x14>
801005b0:	85 c0                	test   %eax,%eax
801005b2:	78 68                	js     8010061c <printint+0x7c>
    x = xx;
801005b4:	89 c1                	mov    %eax,%ecx
801005b6:	31 f6                	xor    %esi,%esi
  i = 0;
801005b8:	31 db                	xor    %ebx,%ebx
801005ba:	eb 04                	jmp    801005c0 <printint+0x20>
  }while((x /= base) != 0);
801005bc:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
801005be:	89 fb                	mov    %edi,%ebx
801005c0:	89 c8                	mov    %ecx,%eax
801005c2:	31 d2                	xor    %edx,%edx
801005c4:	8d 7b 01             	lea    0x1(%ebx),%edi
801005c7:	f7 75 d4             	divl   -0x2c(%ebp)
801005ca:	0f b6 92 10 7c 10 80 	movzbl -0x7fef83f0(%edx),%edx
801005d1:	88 54 3d d7          	mov    %dl,-0x29(%ebp,%edi,1)
  }while((x /= base) != 0);
801005d5:	39 4d d4             	cmp    %ecx,-0x2c(%ebp)
801005d8:	76 e2                	jbe    801005bc <printint+0x1c>
  if(sign)
801005da:	85 f6                	test   %esi,%esi
801005dc:	75 32                	jne    80100610 <printint+0x70>
801005de:	0f be c2             	movsbl %dl,%eax
801005e1:	89 df                	mov    %ebx,%edi
  if(panicked){
801005e3:	8b 0d 78 b5 10 80    	mov    0x8010b578,%ecx
801005e9:	85 c9                	test   %ecx,%ecx
801005eb:	75 20                	jne    8010060d <printint+0x6d>
801005ed:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005f1:	e8 1a fe ff ff       	call   80100410 <consputc.part.0>
  while(--i >= 0)
801005f6:	8d 45 d7             	lea    -0x29(%ebp),%eax
801005f9:	39 d8                	cmp    %ebx,%eax
801005fb:	74 27                	je     80100624 <printint+0x84>
  if(panicked){
801005fd:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
    consputc(buf[i]);
80100603:	0f be 03             	movsbl (%ebx),%eax
  if(panicked){
80100606:	83 eb 01             	sub    $0x1,%ebx
80100609:	85 d2                	test   %edx,%edx
8010060b:	74 e4                	je     801005f1 <printint+0x51>
  asm volatile("cli");
8010060d:	fa                   	cli    
      ;
8010060e:	eb fe                	jmp    8010060e <printint+0x6e>
    buf[i++] = '-';
80100610:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
80100615:	b8 2d 00 00 00       	mov    $0x2d,%eax
8010061a:	eb c7                	jmp    801005e3 <printint+0x43>
    x = -xx;
8010061c:	f7 d8                	neg    %eax
8010061e:	89 ce                	mov    %ecx,%esi
80100620:	89 c1                	mov    %eax,%ecx
80100622:	eb 94                	jmp    801005b8 <printint+0x18>
}
80100624:	83 c4 2c             	add    $0x2c,%esp
80100627:	5b                   	pop    %ebx
80100628:	5e                   	pop    %esi
80100629:	5f                   	pop    %edi
8010062a:	5d                   	pop    %ebp
8010062b:	c3                   	ret    
8010062c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100630 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100630:	55                   	push   %ebp
80100631:	89 e5                	mov    %esp,%ebp
80100633:	57                   	push   %edi
80100634:	56                   	push   %esi
80100635:	53                   	push   %ebx
80100636:	83 ec 18             	sub    $0x18,%esp
80100639:	8b 7d 10             	mov    0x10(%ebp),%edi
8010063c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int i;

  iunlock(ip);
8010063f:	ff 75 08             	pushl  0x8(%ebp)
80100642:	e8 b9 11 00 00       	call   80101800 <iunlock>
  acquire(&cons.lock);
80100647:	c7 04 24 40 b5 10 80 	movl   $0x8010b540,(%esp)
8010064e:	e8 dd 48 00 00       	call   80104f30 <acquire>
  for(i = 0; i < n; i++)
80100653:	83 c4 10             	add    $0x10,%esp
80100656:	85 ff                	test   %edi,%edi
80100658:	7e 36                	jle    80100690 <consolewrite+0x60>
  if(panicked){
8010065a:	8b 0d 78 b5 10 80    	mov    0x8010b578,%ecx
80100660:	85 c9                	test   %ecx,%ecx
80100662:	75 21                	jne    80100685 <consolewrite+0x55>
    consputc(buf[i] & 0xff);
80100664:	0f b6 03             	movzbl (%ebx),%eax
80100667:	8d 73 01             	lea    0x1(%ebx),%esi
8010066a:	01 fb                	add    %edi,%ebx
8010066c:	e8 9f fd ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; i < n; i++)
80100671:	39 de                	cmp    %ebx,%esi
80100673:	74 1b                	je     80100690 <consolewrite+0x60>
  if(panicked){
80100675:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
    consputc(buf[i] & 0xff);
8010067b:	0f b6 06             	movzbl (%esi),%eax
  if(panicked){
8010067e:	83 c6 01             	add    $0x1,%esi
80100681:	85 d2                	test   %edx,%edx
80100683:	74 e7                	je     8010066c <consolewrite+0x3c>
80100685:	fa                   	cli    
      ;
80100686:	eb fe                	jmp    80100686 <consolewrite+0x56>
80100688:	90                   	nop
80100689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100690:	83 ec 0c             	sub    $0xc,%esp
80100693:	68 40 b5 10 80       	push   $0x8010b540
80100698:	e8 53 49 00 00       	call   80104ff0 <release>
  ilock(ip);
8010069d:	58                   	pop    %eax
8010069e:	ff 75 08             	pushl  0x8(%ebp)
801006a1:	e8 7a 10 00 00       	call   80101720 <ilock>

  return n;
}
801006a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006a9:	89 f8                	mov    %edi,%eax
801006ab:	5b                   	pop    %ebx
801006ac:	5e                   	pop    %esi
801006ad:	5f                   	pop    %edi
801006ae:	5d                   	pop    %ebp
801006af:	c3                   	ret    

801006b0 <cprintf>:
{
801006b0:	55                   	push   %ebp
801006b1:	89 e5                	mov    %esp,%ebp
801006b3:	57                   	push   %edi
801006b4:	56                   	push   %esi
801006b5:	53                   	push   %ebx
801006b6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006b9:	a1 74 b5 10 80       	mov    0x8010b574,%eax
801006be:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
801006c1:	85 c0                	test   %eax,%eax
801006c3:	0f 85 df 00 00 00    	jne    801007a8 <cprintf+0xf8>
  if (fmt == 0)
801006c9:	8b 45 08             	mov    0x8(%ebp),%eax
801006cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006cf:	85 c0                	test   %eax,%eax
801006d1:	0f 84 5e 01 00 00    	je     80100835 <cprintf+0x185>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d7:	0f b6 00             	movzbl (%eax),%eax
801006da:	85 c0                	test   %eax,%eax
801006dc:	74 32                	je     80100710 <cprintf+0x60>
  argp = (uint*)(void*)(&fmt + 1);
801006de:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e1:	31 f6                	xor    %esi,%esi
    if(c != '%'){
801006e3:	83 f8 25             	cmp    $0x25,%eax
801006e6:	74 40                	je     80100728 <cprintf+0x78>
  if(panicked){
801006e8:	8b 0d 78 b5 10 80    	mov    0x8010b578,%ecx
801006ee:	85 c9                	test   %ecx,%ecx
801006f0:	74 0b                	je     801006fd <cprintf+0x4d>
801006f2:	fa                   	cli    
      ;
801006f3:	eb fe                	jmp    801006f3 <cprintf+0x43>
801006f5:	8d 76 00             	lea    0x0(%esi),%esi
801006f8:	b8 25 00 00 00       	mov    $0x25,%eax
801006fd:	e8 0e fd ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100702:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100705:	83 c6 01             	add    $0x1,%esi
80100708:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
8010070c:	85 c0                	test   %eax,%eax
8010070e:	75 d3                	jne    801006e3 <cprintf+0x33>
  if(locking)
80100710:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100713:	85 db                	test   %ebx,%ebx
80100715:	0f 85 05 01 00 00    	jne    80100820 <cprintf+0x170>
}
8010071b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010071e:	5b                   	pop    %ebx
8010071f:	5e                   	pop    %esi
80100720:	5f                   	pop    %edi
80100721:	5d                   	pop    %ebp
80100722:	c3                   	ret    
80100723:	90                   	nop
80100724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[++i] & 0xff;
80100728:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010072b:	83 c6 01             	add    $0x1,%esi
8010072e:	0f b6 3c 30          	movzbl (%eax,%esi,1),%edi
    if(c == 0)
80100732:	85 ff                	test   %edi,%edi
80100734:	74 da                	je     80100710 <cprintf+0x60>
    switch(c){
80100736:	83 ff 70             	cmp    $0x70,%edi
80100739:	0f 84 7e 00 00 00    	je     801007bd <cprintf+0x10d>
8010073f:	7f 26                	jg     80100767 <cprintf+0xb7>
80100741:	83 ff 25             	cmp    $0x25,%edi
80100744:	0f 84 be 00 00 00    	je     80100808 <cprintf+0x158>
8010074a:	83 ff 64             	cmp    $0x64,%edi
8010074d:	75 46                	jne    80100795 <cprintf+0xe5>
      printint(*argp++, 10, 1);
8010074f:	8b 03                	mov    (%ebx),%eax
80100751:	8d 7b 04             	lea    0x4(%ebx),%edi
80100754:	b9 01 00 00 00       	mov    $0x1,%ecx
80100759:	ba 0a 00 00 00       	mov    $0xa,%edx
8010075e:	89 fb                	mov    %edi,%ebx
80100760:	e8 3b fe ff ff       	call   801005a0 <printint>
      break;
80100765:	eb 9b                	jmp    80100702 <cprintf+0x52>
80100767:	83 ff 73             	cmp    $0x73,%edi
8010076a:	75 24                	jne    80100790 <cprintf+0xe0>
      if((s = (char*)*argp++) == 0)
8010076c:	8d 7b 04             	lea    0x4(%ebx),%edi
8010076f:	8b 1b                	mov    (%ebx),%ebx
80100771:	85 db                	test   %ebx,%ebx
80100773:	75 68                	jne    801007dd <cprintf+0x12d>
80100775:	b8 28 00 00 00       	mov    $0x28,%eax
        s = "(null)";
8010077a:	bb f8 7b 10 80       	mov    $0x80107bf8,%ebx
  if(panicked){
8010077f:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
80100785:	85 d2                	test   %edx,%edx
80100787:	74 4c                	je     801007d5 <cprintf+0x125>
80100789:	fa                   	cli    
      ;
8010078a:	eb fe                	jmp    8010078a <cprintf+0xda>
8010078c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100790:	83 ff 78             	cmp    $0x78,%edi
80100793:	74 28                	je     801007bd <cprintf+0x10d>
  if(panicked){
80100795:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
8010079b:	85 d2                	test   %edx,%edx
8010079d:	74 4c                	je     801007eb <cprintf+0x13b>
8010079f:	fa                   	cli    
      ;
801007a0:	eb fe                	jmp    801007a0 <cprintf+0xf0>
801007a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&cons.lock);
801007a8:	83 ec 0c             	sub    $0xc,%esp
801007ab:	68 40 b5 10 80       	push   $0x8010b540
801007b0:	e8 7b 47 00 00       	call   80104f30 <acquire>
801007b5:	83 c4 10             	add    $0x10,%esp
801007b8:	e9 0c ff ff ff       	jmp    801006c9 <cprintf+0x19>
      printint(*argp++, 16, 0);
801007bd:	8b 03                	mov    (%ebx),%eax
801007bf:	8d 7b 04             	lea    0x4(%ebx),%edi
801007c2:	31 c9                	xor    %ecx,%ecx
801007c4:	ba 10 00 00 00       	mov    $0x10,%edx
801007c9:	89 fb                	mov    %edi,%ebx
801007cb:	e8 d0 fd ff ff       	call   801005a0 <printint>
      break;
801007d0:	e9 2d ff ff ff       	jmp    80100702 <cprintf+0x52>
801007d5:	e8 36 fc ff ff       	call   80100410 <consputc.part.0>
      for(; *s; s++)
801007da:	83 c3 01             	add    $0x1,%ebx
801007dd:	0f be 03             	movsbl (%ebx),%eax
801007e0:	84 c0                	test   %al,%al
801007e2:	75 9b                	jne    8010077f <cprintf+0xcf>
      if((s = (char*)*argp++) == 0)
801007e4:	89 fb                	mov    %edi,%ebx
801007e6:	e9 17 ff ff ff       	jmp    80100702 <cprintf+0x52>
801007eb:	b8 25 00 00 00       	mov    $0x25,%eax
801007f0:	e8 1b fc ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
801007f5:	a1 78 b5 10 80       	mov    0x8010b578,%eax
801007fa:	85 c0                	test   %eax,%eax
801007fc:	74 4a                	je     80100848 <cprintf+0x198>
801007fe:	fa                   	cli    
      ;
801007ff:	eb fe                	jmp    801007ff <cprintf+0x14f>
80100801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
80100808:	8b 0d 78 b5 10 80    	mov    0x8010b578,%ecx
8010080e:	85 c9                	test   %ecx,%ecx
80100810:	0f 84 e2 fe ff ff    	je     801006f8 <cprintf+0x48>
80100816:	fa                   	cli    
      ;
80100817:	eb fe                	jmp    80100817 <cprintf+0x167>
80100819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&cons.lock);
80100820:	83 ec 0c             	sub    $0xc,%esp
80100823:	68 40 b5 10 80       	push   $0x8010b540
80100828:	e8 c3 47 00 00       	call   80104ff0 <release>
8010082d:	83 c4 10             	add    $0x10,%esp
}
80100830:	e9 e6 fe ff ff       	jmp    8010071b <cprintf+0x6b>
    panic("null fmt");
80100835:	83 ec 0c             	sub    $0xc,%esp
80100838:	68 ff 7b 10 80       	push   $0x80107bff
8010083d:	e8 4e fb ff ff       	call   80100390 <panic>
80100842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100848:	89 f8                	mov    %edi,%eax
8010084a:	e8 c1 fb ff ff       	call   80100410 <consputc.part.0>
8010084f:	e9 ae fe ff ff       	jmp    80100702 <cprintf+0x52>
80100854:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010085a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100860 <consoleintr>:
{
80100860:	55                   	push   %ebp
80100861:	89 e5                	mov    %esp,%ebp
80100863:	57                   	push   %edi
80100864:	56                   	push   %esi
  int c, doprocdump = 0;
80100865:	31 f6                	xor    %esi,%esi
{
80100867:	53                   	push   %ebx
80100868:	83 ec 18             	sub    $0x18,%esp
8010086b:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
8010086e:	68 40 b5 10 80       	push   $0x8010b540
80100873:	e8 b8 46 00 00       	call   80104f30 <acquire>
  while((c = getc()) >= 0){
80100878:	83 c4 10             	add    $0x10,%esp
8010087b:	ff d7                	call   *%edi
8010087d:	89 c3                	mov    %eax,%ebx
8010087f:	85 c0                	test   %eax,%eax
80100881:	0f 88 38 01 00 00    	js     801009bf <consoleintr+0x15f>
    switch(c){
80100887:	83 fb 10             	cmp    $0x10,%ebx
8010088a:	0f 84 f0 00 00 00    	je     80100980 <consoleintr+0x120>
80100890:	0f 8e ba 00 00 00    	jle    80100950 <consoleintr+0xf0>
80100896:	83 fb 15             	cmp    $0x15,%ebx
80100899:	75 35                	jne    801008d0 <consoleintr+0x70>
      while(input.e != input.w &&
8010089b:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
801008a0:	39 05 c4 0f 11 80    	cmp    %eax,0x80110fc4
801008a6:	74 d3                	je     8010087b <consoleintr+0x1b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008a8:	83 e8 01             	sub    $0x1,%eax
801008ab:	89 c2                	mov    %eax,%edx
801008ad:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
801008b0:	80 ba 40 0f 11 80 0a 	cmpb   $0xa,-0x7feef0c0(%edx)
801008b7:	74 c2                	je     8010087b <consoleintr+0x1b>
  if(panicked){
801008b9:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
        input.e--;
801008bf:	a3 c8 0f 11 80       	mov    %eax,0x80110fc8
  if(panicked){
801008c4:	85 d2                	test   %edx,%edx
801008c6:	0f 84 be 00 00 00    	je     8010098a <consoleintr+0x12a>
801008cc:	fa                   	cli    
      ;
801008cd:	eb fe                	jmp    801008cd <consoleintr+0x6d>
801008cf:	90                   	nop
801008d0:	83 fb 7f             	cmp    $0x7f,%ebx
801008d3:	0f 84 7c 00 00 00    	je     80100955 <consoleintr+0xf5>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008d9:	85 db                	test   %ebx,%ebx
801008db:	74 9e                	je     8010087b <consoleintr+0x1b>
801008dd:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
801008e2:	89 c2                	mov    %eax,%edx
801008e4:	2b 15 c0 0f 11 80    	sub    0x80110fc0,%edx
801008ea:	83 fa 7f             	cmp    $0x7f,%edx
801008ed:	77 8c                	ja     8010087b <consoleintr+0x1b>
        c = (c == '\r') ? '\n' : c;
801008ef:	8d 48 01             	lea    0x1(%eax),%ecx
801008f2:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
801008f8:	83 e0 7f             	and    $0x7f,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
801008fb:	89 0d c8 0f 11 80    	mov    %ecx,0x80110fc8
        c = (c == '\r') ? '\n' : c;
80100901:	83 fb 0d             	cmp    $0xd,%ebx
80100904:	0f 84 d1 00 00 00    	je     801009db <consoleintr+0x17b>
        input.buf[input.e++ % INPUT_BUF] = c;
8010090a:	88 98 40 0f 11 80    	mov    %bl,-0x7feef0c0(%eax)
  if(panicked){
80100910:	85 d2                	test   %edx,%edx
80100912:	0f 85 ce 00 00 00    	jne    801009e6 <consoleintr+0x186>
80100918:	89 d8                	mov    %ebx,%eax
8010091a:	e8 f1 fa ff ff       	call   80100410 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
8010091f:	83 fb 0a             	cmp    $0xa,%ebx
80100922:	0f 84 d2 00 00 00    	je     801009fa <consoleintr+0x19a>
80100928:	83 fb 04             	cmp    $0x4,%ebx
8010092b:	0f 84 c9 00 00 00    	je     801009fa <consoleintr+0x19a>
80100931:	a1 c0 0f 11 80       	mov    0x80110fc0,%eax
80100936:	83 e8 80             	sub    $0xffffff80,%eax
80100939:	39 05 c8 0f 11 80    	cmp    %eax,0x80110fc8
8010093f:	0f 85 36 ff ff ff    	jne    8010087b <consoleintr+0x1b>
80100945:	e9 b5 00 00 00       	jmp    801009ff <consoleintr+0x19f>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100950:	83 fb 08             	cmp    $0x8,%ebx
80100953:	75 84                	jne    801008d9 <consoleintr+0x79>
      if(input.e != input.w){
80100955:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
8010095a:	3b 05 c4 0f 11 80    	cmp    0x80110fc4,%eax
80100960:	0f 84 15 ff ff ff    	je     8010087b <consoleintr+0x1b>
        input.e--;
80100966:	83 e8 01             	sub    $0x1,%eax
80100969:	a3 c8 0f 11 80       	mov    %eax,0x80110fc8
  if(panicked){
8010096e:	a1 78 b5 10 80       	mov    0x8010b578,%eax
80100973:	85 c0                	test   %eax,%eax
80100975:	74 39                	je     801009b0 <consoleintr+0x150>
80100977:	fa                   	cli    
      ;
80100978:	eb fe                	jmp    80100978 <consoleintr+0x118>
8010097a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      doprocdump = 1;
80100980:	be 01 00 00 00       	mov    $0x1,%esi
80100985:	e9 f1 fe ff ff       	jmp    8010087b <consoleintr+0x1b>
8010098a:	b8 00 01 00 00       	mov    $0x100,%eax
8010098f:	e8 7c fa ff ff       	call   80100410 <consputc.part.0>
      while(input.e != input.w &&
80100994:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
80100999:	3b 05 c4 0f 11 80    	cmp    0x80110fc4,%eax
8010099f:	0f 85 03 ff ff ff    	jne    801008a8 <consoleintr+0x48>
801009a5:	e9 d1 fe ff ff       	jmp    8010087b <consoleintr+0x1b>
801009aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801009b0:	b8 00 01 00 00       	mov    $0x100,%eax
801009b5:	e8 56 fa ff ff       	call   80100410 <consputc.part.0>
801009ba:	e9 bc fe ff ff       	jmp    8010087b <consoleintr+0x1b>
  release(&cons.lock);
801009bf:	83 ec 0c             	sub    $0xc,%esp
801009c2:	68 40 b5 10 80       	push   $0x8010b540
801009c7:	e8 24 46 00 00       	call   80104ff0 <release>
  if(doprocdump) {
801009cc:	83 c4 10             	add    $0x10,%esp
801009cf:	85 f6                	test   %esi,%esi
801009d1:	75 46                	jne    80100a19 <consoleintr+0x1b9>
}
801009d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009d6:	5b                   	pop    %ebx
801009d7:	5e                   	pop    %esi
801009d8:	5f                   	pop    %edi
801009d9:	5d                   	pop    %ebp
801009da:	c3                   	ret    
        input.buf[input.e++ % INPUT_BUF] = c;
801009db:	c6 80 40 0f 11 80 0a 	movb   $0xa,-0x7feef0c0(%eax)
  if(panicked){
801009e2:	85 d2                	test   %edx,%edx
801009e4:	74 0a                	je     801009f0 <consoleintr+0x190>
801009e6:	fa                   	cli    
      ;
801009e7:	eb fe                	jmp    801009e7 <consoleintr+0x187>
801009e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801009f0:	b8 0a 00 00 00       	mov    $0xa,%eax
801009f5:	e8 16 fa ff ff       	call   80100410 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009fa:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
          wakeup(&input.r);
801009ff:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a02:	a3 c4 0f 11 80       	mov    %eax,0x80110fc4
          wakeup(&input.r);
80100a07:	68 c0 0f 11 80       	push   $0x80110fc0
80100a0c:	e8 df 40 00 00       	call   80104af0 <wakeup>
80100a11:	83 c4 10             	add    $0x10,%esp
80100a14:	e9 62 fe ff ff       	jmp    8010087b <consoleintr+0x1b>
}
80100a19:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a1c:	5b                   	pop    %ebx
80100a1d:	5e                   	pop    %esi
80100a1e:	5f                   	pop    %edi
80100a1f:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a20:	e9 bb 41 00 00       	jmp    80104be0 <procdump>
80100a25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100a30 <consoleinit>:

void
consoleinit(void)
{
80100a30:	55                   	push   %ebp
80100a31:	89 e5                	mov    %esp,%ebp
80100a33:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a36:	68 08 7c 10 80       	push   $0x80107c08
80100a3b:	68 40 b5 10 80       	push   $0x8010b540
80100a40:	e8 8b 43 00 00       	call   80104dd0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a45:	58                   	pop    %eax
80100a46:	5a                   	pop    %edx
80100a47:	6a 00                	push   $0x0
80100a49:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a4b:	c7 05 8c 19 11 80 30 	movl   $0x80100630,0x8011198c
80100a52:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100a55:	c7 05 88 19 11 80 80 	movl   $0x80100280,0x80111988
80100a5c:	02 10 80 
  cons.locking = 1;
80100a5f:	c7 05 74 b5 10 80 01 	movl   $0x1,0x8010b574
80100a66:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100a69:	e8 42 19 00 00       	call   801023b0 <ioapicenable>
}
80100a6e:	83 c4 10             	add    $0x10,%esp
80100a71:	c9                   	leave  
80100a72:	c3                   	ret    
80100a73:	66 90                	xchg   %ax,%ax
80100a75:	66 90                	xchg   %ax,%ax
80100a77:	66 90                	xchg   %ax,%ax
80100a79:	66 90                	xchg   %ax,%ax
80100a7b:	66 90                	xchg   %ax,%ax
80100a7d:	66 90                	xchg   %ax,%ax
80100a7f:	90                   	nop

80100a80 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a80:	55                   	push   %ebp
80100a81:	89 e5                	mov    %esp,%ebp
80100a83:	57                   	push   %edi
80100a84:	56                   	push   %esi
80100a85:	53                   	push   %ebx
80100a86:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a8c:	e8 0f 32 00 00       	call   80103ca0 <myproc>
80100a91:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100a97:	e8 84 24 00 00       	call   80102f20 <begin_op>

  if((ip = namei(path)) == 0){
80100a9c:	83 ec 0c             	sub    $0xc,%esp
80100a9f:	ff 75 08             	pushl  0x8(%ebp)
80100aa2:	e8 19 15 00 00       	call   80101fc0 <namei>
80100aa7:	83 c4 10             	add    $0x10,%esp
80100aaa:	85 c0                	test   %eax,%eax
80100aac:	0f 84 02 03 00 00    	je     80100db4 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ab2:	83 ec 0c             	sub    $0xc,%esp
80100ab5:	89 c3                	mov    %eax,%ebx
80100ab7:	50                   	push   %eax
80100ab8:	e8 63 0c 00 00       	call   80101720 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100abd:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100ac3:	6a 34                	push   $0x34
80100ac5:	6a 00                	push   $0x0
80100ac7:	50                   	push   %eax
80100ac8:	53                   	push   %ebx
80100ac9:	e8 32 0f 00 00       	call   80101a00 <readi>
80100ace:	83 c4 20             	add    $0x20,%esp
80100ad1:	83 f8 34             	cmp    $0x34,%eax
80100ad4:	74 22                	je     80100af8 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100ad6:	83 ec 0c             	sub    $0xc,%esp
80100ad9:	53                   	push   %ebx
80100ada:	e8 d1 0e 00 00       	call   801019b0 <iunlockput>
    end_op();
80100adf:	e8 ac 24 00 00       	call   80102f90 <end_op>
80100ae4:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100ae7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100aec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100aef:	5b                   	pop    %ebx
80100af0:	5e                   	pop    %esi
80100af1:	5f                   	pop    %edi
80100af2:	5d                   	pop    %ebp
80100af3:	c3                   	ret    
80100af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100af8:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100aff:	45 4c 46 
80100b02:	75 d2                	jne    80100ad6 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100b04:	e8 e7 6c 00 00       	call   801077f0 <setupkvm>
80100b09:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b0f:	85 c0                	test   %eax,%eax
80100b11:	74 c3                	je     80100ad6 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b13:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b1a:	00 
80100b1b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b21:	0f 84 ac 02 00 00    	je     80100dd3 <exec+0x353>
  sz = 0;
80100b27:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b2e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b31:	31 ff                	xor    %edi,%edi
80100b33:	e9 8e 00 00 00       	jmp    80100bc6 <exec+0x146>
80100b38:	90                   	nop
80100b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100b40:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b47:	75 6c                	jne    80100bb5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100b49:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b4f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b55:	0f 82 87 00 00 00    	jb     80100be2 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b5b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b61:	72 7f                	jb     80100be2 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b63:	83 ec 04             	sub    $0x4,%esp
80100b66:	50                   	push   %eax
80100b67:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b6d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b73:	e8 98 6a 00 00       	call   80107610 <allocuvm>
80100b78:	83 c4 10             	add    $0x10,%esp
80100b7b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b81:	85 c0                	test   %eax,%eax
80100b83:	74 5d                	je     80100be2 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100b85:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b8b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b90:	75 50                	jne    80100be2 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b92:	83 ec 0c             	sub    $0xc,%esp
80100b95:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b9b:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100ba1:	53                   	push   %ebx
80100ba2:	50                   	push   %eax
80100ba3:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ba9:	e8 a2 69 00 00       	call   80107550 <loaduvm>
80100bae:	83 c4 20             	add    $0x20,%esp
80100bb1:	85 c0                	test   %eax,%eax
80100bb3:	78 2d                	js     80100be2 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bb5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bbc:	83 c7 01             	add    $0x1,%edi
80100bbf:	83 c6 20             	add    $0x20,%esi
80100bc2:	39 f8                	cmp    %edi,%eax
80100bc4:	7e 3a                	jle    80100c00 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bc6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bcc:	6a 20                	push   $0x20
80100bce:	56                   	push   %esi
80100bcf:	50                   	push   %eax
80100bd0:	53                   	push   %ebx
80100bd1:	e8 2a 0e 00 00       	call   80101a00 <readi>
80100bd6:	83 c4 10             	add    $0x10,%esp
80100bd9:	83 f8 20             	cmp    $0x20,%eax
80100bdc:	0f 84 5e ff ff ff    	je     80100b40 <exec+0xc0>
    freevm(pgdir);
80100be2:	83 ec 0c             	sub    $0xc,%esp
80100be5:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100beb:	e8 80 6b 00 00       	call   80107770 <freevm>
  if(ip){
80100bf0:	83 c4 10             	add    $0x10,%esp
80100bf3:	e9 de fe ff ff       	jmp    80100ad6 <exec+0x56>
80100bf8:	90                   	nop
80100bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c00:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100c06:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100c0c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100c12:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c18:	83 ec 0c             	sub    $0xc,%esp
80100c1b:	53                   	push   %ebx
80100c1c:	e8 8f 0d 00 00       	call   801019b0 <iunlockput>
  end_op();
80100c21:	e8 6a 23 00 00       	call   80102f90 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c26:	83 c4 0c             	add    $0xc,%esp
80100c29:	56                   	push   %esi
80100c2a:	57                   	push   %edi
80100c2b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c31:	57                   	push   %edi
80100c32:	e8 d9 69 00 00       	call   80107610 <allocuvm>
80100c37:	83 c4 10             	add    $0x10,%esp
80100c3a:	89 c6                	mov    %eax,%esi
80100c3c:	85 c0                	test   %eax,%eax
80100c3e:	0f 84 94 00 00 00    	je     80100cd8 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c44:	83 ec 08             	sub    $0x8,%esp
80100c47:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100c4d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c4f:	50                   	push   %eax
80100c50:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100c51:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c53:	e8 38 6c 00 00       	call   80107890 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c58:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c5b:	83 c4 10             	add    $0x10,%esp
80100c5e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c64:	8b 00                	mov    (%eax),%eax
80100c66:	85 c0                	test   %eax,%eax
80100c68:	0f 84 8b 00 00 00    	je     80100cf9 <exec+0x279>
80100c6e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100c74:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c7a:	eb 23                	jmp    80100c9f <exec+0x21f>
80100c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c80:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c83:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c8a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c8d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c93:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c96:	85 c0                	test   %eax,%eax
80100c98:	74 59                	je     80100cf3 <exec+0x273>
    if(argc >= MAXARG)
80100c9a:	83 ff 20             	cmp    $0x20,%edi
80100c9d:	74 39                	je     80100cd8 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c9f:	83 ec 0c             	sub    $0xc,%esp
80100ca2:	50                   	push   %eax
80100ca3:	e8 a8 45 00 00       	call   80105250 <strlen>
80100ca8:	f7 d0                	not    %eax
80100caa:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cac:	58                   	pop    %eax
80100cad:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cb0:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cb3:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cb6:	e8 95 45 00 00       	call   80105250 <strlen>
80100cbb:	83 c0 01             	add    $0x1,%eax
80100cbe:	50                   	push   %eax
80100cbf:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cc2:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cc5:	53                   	push   %ebx
80100cc6:	56                   	push   %esi
80100cc7:	e8 04 6d 00 00       	call   801079d0 <copyout>
80100ccc:	83 c4 20             	add    $0x20,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	79 ad                	jns    80100c80 <exec+0x200>
80100cd3:	90                   	nop
80100cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80100cd8:	83 ec 0c             	sub    $0xc,%esp
80100cdb:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ce1:	e8 8a 6a 00 00       	call   80107770 <freevm>
80100ce6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100ce9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cee:	e9 f9 fd ff ff       	jmp    80100aec <exec+0x6c>
80100cf3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cf9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100d00:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100d02:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100d09:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d0d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d0f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100d12:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100d18:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d1a:	50                   	push   %eax
80100d1b:	52                   	push   %edx
80100d1c:	53                   	push   %ebx
80100d1d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100d23:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d2a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d2d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d33:	e8 98 6c 00 00       	call   801079d0 <copyout>
80100d38:	83 c4 10             	add    $0x10,%esp
80100d3b:	85 c0                	test   %eax,%eax
80100d3d:	78 99                	js     80100cd8 <exec+0x258>
  for(last=s=path; *s; s++)
80100d3f:	8b 45 08             	mov    0x8(%ebp),%eax
80100d42:	8b 55 08             	mov    0x8(%ebp),%edx
80100d45:	0f b6 00             	movzbl (%eax),%eax
80100d48:	84 c0                	test   %al,%al
80100d4a:	74 13                	je     80100d5f <exec+0x2df>
80100d4c:	89 d1                	mov    %edx,%ecx
80100d4e:	66 90                	xchg   %ax,%ax
    if(*s == '/')
80100d50:	83 c1 01             	add    $0x1,%ecx
80100d53:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d55:	0f b6 01             	movzbl (%ecx),%eax
    if(*s == '/')
80100d58:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d5b:	84 c0                	test   %al,%al
80100d5d:	75 f1                	jne    80100d50 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d5f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100d65:	83 ec 04             	sub    $0x4,%esp
80100d68:	6a 10                	push   $0x10
80100d6a:	89 f8                	mov    %edi,%eax
80100d6c:	52                   	push   %edx
80100d6d:	83 c0 6c             	add    $0x6c,%eax
80100d70:	50                   	push   %eax
80100d71:	e8 9a 44 00 00       	call   80105210 <safestrcpy>
  curproc->pgdir = pgdir;
80100d76:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100d7c:	89 f8                	mov    %edi,%eax
80100d7e:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100d81:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80100d83:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100d86:	89 c1                	mov    %eax,%ecx
80100d88:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d8e:	8b 40 18             	mov    0x18(%eax),%eax
80100d91:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d94:	8b 41 18             	mov    0x18(%ecx),%eax
80100d97:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d9a:	89 0c 24             	mov    %ecx,(%esp)
80100d9d:	e8 1e 66 00 00       	call   801073c0 <switchuvm>
  freevm(oldpgdir);
80100da2:	89 3c 24             	mov    %edi,(%esp)
80100da5:	e8 c6 69 00 00       	call   80107770 <freevm>
  return 0;
80100daa:	83 c4 10             	add    $0x10,%esp
80100dad:	31 c0                	xor    %eax,%eax
80100daf:	e9 38 fd ff ff       	jmp    80100aec <exec+0x6c>
    end_op();
80100db4:	e8 d7 21 00 00       	call   80102f90 <end_op>
    cprintf("exec: fail\n");
80100db9:	83 ec 0c             	sub    $0xc,%esp
80100dbc:	68 21 7c 10 80       	push   $0x80107c21
80100dc1:	e8 ea f8 ff ff       	call   801006b0 <cprintf>
    return -1;
80100dc6:	83 c4 10             	add    $0x10,%esp
80100dc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100dce:	e9 19 fd ff ff       	jmp    80100aec <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100dd3:	31 ff                	xor    %edi,%edi
80100dd5:	be 00 20 00 00       	mov    $0x2000,%esi
80100dda:	e9 39 fe ff ff       	jmp    80100c18 <exec+0x198>
80100ddf:	90                   	nop

80100de0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100de6:	68 2d 7c 10 80       	push   $0x80107c2d
80100deb:	68 e0 0f 11 80       	push   $0x80110fe0
80100df0:	e8 db 3f 00 00       	call   80104dd0 <initlock>
}
80100df5:	83 c4 10             	add    $0x10,%esp
80100df8:	c9                   	leave  
80100df9:	c3                   	ret    
80100dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e00 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e00:	55                   	push   %ebp
80100e01:	89 e5                	mov    %esp,%ebp
80100e03:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e04:	bb 14 10 11 80       	mov    $0x80111014,%ebx
{
80100e09:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e0c:	68 e0 0f 11 80       	push   $0x80110fe0
80100e11:	e8 1a 41 00 00       	call   80104f30 <acquire>
80100e16:	83 c4 10             	add    $0x10,%esp
80100e19:	eb 10                	jmp    80100e2b <filealloc+0x2b>
80100e1b:	90                   	nop
80100e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e20:	83 c3 18             	add    $0x18,%ebx
80100e23:	81 fb 74 19 11 80    	cmp    $0x80111974,%ebx
80100e29:	74 25                	je     80100e50 <filealloc+0x50>
    if(f->ref == 0){
80100e2b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e2e:	85 c0                	test   %eax,%eax
80100e30:	75 ee                	jne    80100e20 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e32:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e35:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e3c:	68 e0 0f 11 80       	push   $0x80110fe0
80100e41:	e8 aa 41 00 00       	call   80104ff0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e46:	89 d8                	mov    %ebx,%eax
      return f;
80100e48:	83 c4 10             	add    $0x10,%esp
}
80100e4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e4e:	c9                   	leave  
80100e4f:	c3                   	ret    
  release(&ftable.lock);
80100e50:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e53:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e55:	68 e0 0f 11 80       	push   $0x80110fe0
80100e5a:	e8 91 41 00 00       	call   80104ff0 <release>
}
80100e5f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e61:	83 c4 10             	add    $0x10,%esp
}
80100e64:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e67:	c9                   	leave  
80100e68:	c3                   	ret    
80100e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e70 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e70:	55                   	push   %ebp
80100e71:	89 e5                	mov    %esp,%ebp
80100e73:	53                   	push   %ebx
80100e74:	83 ec 10             	sub    $0x10,%esp
80100e77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e7a:	68 e0 0f 11 80       	push   $0x80110fe0
80100e7f:	e8 ac 40 00 00       	call   80104f30 <acquire>
  if(f->ref < 1)
80100e84:	8b 43 04             	mov    0x4(%ebx),%eax
80100e87:	83 c4 10             	add    $0x10,%esp
80100e8a:	85 c0                	test   %eax,%eax
80100e8c:	7e 1a                	jle    80100ea8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e8e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e91:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e94:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e97:	68 e0 0f 11 80       	push   $0x80110fe0
80100e9c:	e8 4f 41 00 00       	call   80104ff0 <release>
  return f;
}
80100ea1:	89 d8                	mov    %ebx,%eax
80100ea3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ea6:	c9                   	leave  
80100ea7:	c3                   	ret    
    panic("filedup");
80100ea8:	83 ec 0c             	sub    $0xc,%esp
80100eab:	68 34 7c 10 80       	push   $0x80107c34
80100eb0:	e8 db f4 ff ff       	call   80100390 <panic>
80100eb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100ec0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100ec0:	55                   	push   %ebp
80100ec1:	89 e5                	mov    %esp,%ebp
80100ec3:	57                   	push   %edi
80100ec4:	56                   	push   %esi
80100ec5:	53                   	push   %ebx
80100ec6:	83 ec 28             	sub    $0x28,%esp
80100ec9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100ecc:	68 e0 0f 11 80       	push   $0x80110fe0
80100ed1:	e8 5a 40 00 00       	call   80104f30 <acquire>
  if(f->ref < 1)
80100ed6:	8b 43 04             	mov    0x4(%ebx),%eax
80100ed9:	83 c4 10             	add    $0x10,%esp
80100edc:	85 c0                	test   %eax,%eax
80100ede:	0f 8e a3 00 00 00    	jle    80100f87 <fileclose+0xc7>
    panic("fileclose");
  if(--f->ref > 0){
80100ee4:	83 e8 01             	sub    $0x1,%eax
80100ee7:	89 43 04             	mov    %eax,0x4(%ebx)
80100eea:	75 44                	jne    80100f30 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100eec:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100ef0:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100ef3:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100ef5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100efb:	8b 73 0c             	mov    0xc(%ebx),%esi
80100efe:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f01:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f04:	68 e0 0f 11 80       	push   $0x80110fe0
  ff = *f;
80100f09:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f0c:	e8 df 40 00 00       	call   80104ff0 <release>

  if(ff.type == FD_PIPE)
80100f11:	83 c4 10             	add    $0x10,%esp
80100f14:	83 ff 01             	cmp    $0x1,%edi
80100f17:	74 2f                	je     80100f48 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f19:	83 ff 02             	cmp    $0x2,%edi
80100f1c:	74 4a                	je     80100f68 <fileclose+0xa8>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f21:	5b                   	pop    %ebx
80100f22:	5e                   	pop    %esi
80100f23:	5f                   	pop    %edi
80100f24:	5d                   	pop    %ebp
80100f25:	c3                   	ret    
80100f26:	8d 76 00             	lea    0x0(%esi),%esi
80100f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    release(&ftable.lock);
80100f30:	c7 45 08 e0 0f 11 80 	movl   $0x80110fe0,0x8(%ebp)
}
80100f37:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f3a:	5b                   	pop    %ebx
80100f3b:	5e                   	pop    %esi
80100f3c:	5f                   	pop    %edi
80100f3d:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f3e:	e9 ad 40 00 00       	jmp    80104ff0 <release>
80100f43:	90                   	nop
80100f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pipeclose(ff.pipe, ff.writable);
80100f48:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f4c:	83 ec 08             	sub    $0x8,%esp
80100f4f:	53                   	push   %ebx
80100f50:	56                   	push   %esi
80100f51:	e8 7a 27 00 00       	call   801036d0 <pipeclose>
80100f56:	83 c4 10             	add    $0x10,%esp
}
80100f59:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f5c:	5b                   	pop    %ebx
80100f5d:	5e                   	pop    %esi
80100f5e:	5f                   	pop    %edi
80100f5f:	5d                   	pop    %ebp
80100f60:	c3                   	ret    
80100f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100f68:	e8 b3 1f 00 00       	call   80102f20 <begin_op>
    iput(ff.ip);
80100f6d:	83 ec 0c             	sub    $0xc,%esp
80100f70:	ff 75 e0             	pushl  -0x20(%ebp)
80100f73:	e8 d8 08 00 00       	call   80101850 <iput>
    end_op();
80100f78:	83 c4 10             	add    $0x10,%esp
}
80100f7b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f7e:	5b                   	pop    %ebx
80100f7f:	5e                   	pop    %esi
80100f80:	5f                   	pop    %edi
80100f81:	5d                   	pop    %ebp
    end_op();
80100f82:	e9 09 20 00 00       	jmp    80102f90 <end_op>
    panic("fileclose");
80100f87:	83 ec 0c             	sub    $0xc,%esp
80100f8a:	68 3c 7c 10 80       	push   $0x80107c3c
80100f8f:	e8 fc f3 ff ff       	call   80100390 <panic>
80100f94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100f9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100fa0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fa0:	55                   	push   %ebp
80100fa1:	89 e5                	mov    %esp,%ebp
80100fa3:	53                   	push   %ebx
80100fa4:	83 ec 04             	sub    $0x4,%esp
80100fa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100faa:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fad:	75 31                	jne    80100fe0 <filestat+0x40>
    ilock(f->ip);
80100faf:	83 ec 0c             	sub    $0xc,%esp
80100fb2:	ff 73 10             	pushl  0x10(%ebx)
80100fb5:	e8 66 07 00 00       	call   80101720 <ilock>
    stati(f->ip, st);
80100fba:	58                   	pop    %eax
80100fbb:	5a                   	pop    %edx
80100fbc:	ff 75 0c             	pushl  0xc(%ebp)
80100fbf:	ff 73 10             	pushl  0x10(%ebx)
80100fc2:	e8 09 0a 00 00       	call   801019d0 <stati>
    iunlock(f->ip);
80100fc7:	59                   	pop    %ecx
80100fc8:	ff 73 10             	pushl  0x10(%ebx)
80100fcb:	e8 30 08 00 00       	call   80101800 <iunlock>
    return 0;
80100fd0:	83 c4 10             	add    $0x10,%esp
80100fd3:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100fd5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fd8:	c9                   	leave  
80100fd9:	c3                   	ret    
80100fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100fe0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100fe5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fe8:	c9                   	leave  
80100fe9:	c3                   	ret    
80100fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ff0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 0c             	sub    $0xc,%esp
80100ff9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100ffc:	8b 75 0c             	mov    0xc(%ebp),%esi
80100fff:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101002:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101006:	74 60                	je     80101068 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101008:	8b 03                	mov    (%ebx),%eax
8010100a:	83 f8 01             	cmp    $0x1,%eax
8010100d:	74 41                	je     80101050 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010100f:	83 f8 02             	cmp    $0x2,%eax
80101012:	75 5b                	jne    8010106f <fileread+0x7f>
    ilock(f->ip);
80101014:	83 ec 0c             	sub    $0xc,%esp
80101017:	ff 73 10             	pushl  0x10(%ebx)
8010101a:	e8 01 07 00 00       	call   80101720 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010101f:	57                   	push   %edi
80101020:	ff 73 14             	pushl  0x14(%ebx)
80101023:	56                   	push   %esi
80101024:	ff 73 10             	pushl  0x10(%ebx)
80101027:	e8 d4 09 00 00       	call   80101a00 <readi>
8010102c:	83 c4 20             	add    $0x20,%esp
8010102f:	89 c6                	mov    %eax,%esi
80101031:	85 c0                	test   %eax,%eax
80101033:	7e 03                	jle    80101038 <fileread+0x48>
      f->off += r;
80101035:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101038:	83 ec 0c             	sub    $0xc,%esp
8010103b:	ff 73 10             	pushl  0x10(%ebx)
8010103e:	e8 bd 07 00 00       	call   80101800 <iunlock>
    return r;
80101043:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101046:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101049:	89 f0                	mov    %esi,%eax
8010104b:	5b                   	pop    %ebx
8010104c:	5e                   	pop    %esi
8010104d:	5f                   	pop    %edi
8010104e:	5d                   	pop    %ebp
8010104f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101050:	8b 43 0c             	mov    0xc(%ebx),%eax
80101053:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101056:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101059:	5b                   	pop    %ebx
8010105a:	5e                   	pop    %esi
8010105b:	5f                   	pop    %edi
8010105c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010105d:	e9 1e 28 00 00       	jmp    80103880 <piperead>
80101062:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101068:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010106d:	eb d7                	jmp    80101046 <fileread+0x56>
  panic("fileread");
8010106f:	83 ec 0c             	sub    $0xc,%esp
80101072:	68 46 7c 10 80       	push   $0x80107c46
80101077:	e8 14 f3 ff ff       	call   80100390 <panic>
8010107c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101080 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101080:	55                   	push   %ebp
80101081:	89 e5                	mov    %esp,%ebp
80101083:	57                   	push   %edi
80101084:	56                   	push   %esi
80101085:	53                   	push   %ebx
80101086:	83 ec 1c             	sub    $0x1c,%esp
80101089:	8b 45 0c             	mov    0xc(%ebp),%eax
8010108c:	8b 75 08             	mov    0x8(%ebp),%esi
8010108f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101092:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101095:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101099:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010109c:	0f 84 bb 00 00 00    	je     8010115d <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
801010a2:	8b 06                	mov    (%esi),%eax
801010a4:	83 f8 01             	cmp    $0x1,%eax
801010a7:	0f 84 bf 00 00 00    	je     8010116c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010ad:	83 f8 02             	cmp    $0x2,%eax
801010b0:	0f 85 c8 00 00 00    	jne    8010117e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801010b9:	31 ff                	xor    %edi,%edi
    while(i < n){
801010bb:	85 c0                	test   %eax,%eax
801010bd:	7f 30                	jg     801010ef <filewrite+0x6f>
801010bf:	e9 94 00 00 00       	jmp    80101158 <filewrite+0xd8>
801010c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801010c8:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
801010cb:	83 ec 0c             	sub    $0xc,%esp
801010ce:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
801010d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801010d4:	e8 27 07 00 00       	call   80101800 <iunlock>
      end_op();
801010d9:	e8 b2 1e 00 00       	call   80102f90 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801010de:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010e1:	83 c4 10             	add    $0x10,%esp
801010e4:	39 c3                	cmp    %eax,%ebx
801010e6:	75 60                	jne    80101148 <filewrite+0xc8>
        panic("short filewrite");
      i += r;
801010e8:	01 df                	add    %ebx,%edi
    while(i < n){
801010ea:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010ed:	7e 69                	jle    80101158 <filewrite+0xd8>
      int n1 = n - i;
801010ef:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801010f2:	b8 00 06 00 00       	mov    $0x600,%eax
801010f7:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
801010f9:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801010ff:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101102:	e8 19 1e 00 00       	call   80102f20 <begin_op>
      ilock(f->ip);
80101107:	83 ec 0c             	sub    $0xc,%esp
8010110a:	ff 76 10             	pushl  0x10(%esi)
8010110d:	e8 0e 06 00 00       	call   80101720 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101112:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101115:	53                   	push   %ebx
80101116:	ff 76 14             	pushl  0x14(%esi)
80101119:	01 f8                	add    %edi,%eax
8010111b:	50                   	push   %eax
8010111c:	ff 76 10             	pushl  0x10(%esi)
8010111f:	e8 dc 09 00 00       	call   80101b00 <writei>
80101124:	83 c4 20             	add    $0x20,%esp
80101127:	85 c0                	test   %eax,%eax
80101129:	7f 9d                	jg     801010c8 <filewrite+0x48>
      iunlock(f->ip);
8010112b:	83 ec 0c             	sub    $0xc,%esp
8010112e:	ff 76 10             	pushl  0x10(%esi)
80101131:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101134:	e8 c7 06 00 00       	call   80101800 <iunlock>
      end_op();
80101139:	e8 52 1e 00 00       	call   80102f90 <end_op>
      if(r < 0)
8010113e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101141:	83 c4 10             	add    $0x10,%esp
80101144:	85 c0                	test   %eax,%eax
80101146:	75 15                	jne    8010115d <filewrite+0xdd>
        panic("short filewrite");
80101148:	83 ec 0c             	sub    $0xc,%esp
8010114b:	68 4f 7c 10 80       	push   $0x80107c4f
80101150:	e8 3b f2 ff ff       	call   80100390 <panic>
80101155:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
80101158:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
8010115b:	74 05                	je     80101162 <filewrite+0xe2>
    return -1;
8010115d:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  }
  panic("filewrite");
}
80101162:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101165:	89 f8                	mov    %edi,%eax
80101167:	5b                   	pop    %ebx
80101168:	5e                   	pop    %esi
80101169:	5f                   	pop    %edi
8010116a:	5d                   	pop    %ebp
8010116b:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
8010116c:	8b 46 0c             	mov    0xc(%esi),%eax
8010116f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101172:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101175:	5b                   	pop    %ebx
80101176:	5e                   	pop    %esi
80101177:	5f                   	pop    %edi
80101178:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101179:	e9 f2 25 00 00       	jmp    80103770 <pipewrite>
  panic("filewrite");
8010117e:	83 ec 0c             	sub    $0xc,%esp
80101181:	68 55 7c 10 80       	push   $0x80107c55
80101186:	e8 05 f2 ff ff       	call   80100390 <panic>
8010118b:	66 90                	xchg   %ax,%ax
8010118d:	66 90                	xchg   %ax,%ax
8010118f:	90                   	nop

80101190 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101190:	55                   	push   %ebp
80101191:	89 e5                	mov    %esp,%ebp
80101193:	57                   	push   %edi
80101194:	56                   	push   %esi
80101195:	53                   	push   %ebx
80101196:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101199:	8b 0d e0 19 11 80    	mov    0x801119e0,%ecx
{
8010119f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801011a2:	85 c9                	test   %ecx,%ecx
801011a4:	0f 84 87 00 00 00    	je     80101231 <balloc+0xa1>
801011aa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011b1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011b4:	83 ec 08             	sub    $0x8,%esp
801011b7:	89 f0                	mov    %esi,%eax
801011b9:	c1 f8 0c             	sar    $0xc,%eax
801011bc:	03 05 f8 19 11 80    	add    0x801119f8,%eax
801011c2:	50                   	push   %eax
801011c3:	ff 75 d8             	pushl  -0x28(%ebp)
801011c6:	e8 05 ef ff ff       	call   801000d0 <bread>
801011cb:	83 c4 10             	add    $0x10,%esp
801011ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011d1:	a1 e0 19 11 80       	mov    0x801119e0,%eax
801011d6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011d9:	31 c0                	xor    %eax,%eax
801011db:	eb 2f                	jmp    8010120c <balloc+0x7c>
801011dd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011e0:	89 c1                	mov    %eax,%ecx
801011e2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011e7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801011ea:	83 e1 07             	and    $0x7,%ecx
801011ed:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011ef:	89 c1                	mov    %eax,%ecx
801011f1:	c1 f9 03             	sar    $0x3,%ecx
801011f4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801011f9:	89 fa                	mov    %edi,%edx
801011fb:	85 df                	test   %ebx,%edi
801011fd:	74 41                	je     80101240 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011ff:	83 c0 01             	add    $0x1,%eax
80101202:	83 c6 01             	add    $0x1,%esi
80101205:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010120a:	74 05                	je     80101211 <balloc+0x81>
8010120c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010120f:	77 cf                	ja     801011e0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101211:	83 ec 0c             	sub    $0xc,%esp
80101214:	ff 75 e4             	pushl  -0x1c(%ebp)
80101217:	e8 d4 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010121c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101223:	83 c4 10             	add    $0x10,%esp
80101226:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101229:	39 05 e0 19 11 80    	cmp    %eax,0x801119e0
8010122f:	77 80                	ja     801011b1 <balloc+0x21>
  }
  panic("balloc: out of blocks");
80101231:	83 ec 0c             	sub    $0xc,%esp
80101234:	68 5f 7c 10 80       	push   $0x80107c5f
80101239:	e8 52 f1 ff ff       	call   80100390 <panic>
8010123e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101240:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101243:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101246:	09 da                	or     %ebx,%edx
80101248:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010124c:	57                   	push   %edi
8010124d:	e8 ae 1e 00 00       	call   80103100 <log_write>
        brelse(bp);
80101252:	89 3c 24             	mov    %edi,(%esp)
80101255:	e8 96 ef ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010125a:	58                   	pop    %eax
8010125b:	5a                   	pop    %edx
8010125c:	56                   	push   %esi
8010125d:	ff 75 d8             	pushl  -0x28(%ebp)
80101260:	e8 6b ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101265:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101268:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010126a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010126d:	68 00 02 00 00       	push   $0x200
80101272:	6a 00                	push   $0x0
80101274:	50                   	push   %eax
80101275:	e8 c6 3d 00 00       	call   80105040 <memset>
  log_write(bp);
8010127a:	89 1c 24             	mov    %ebx,(%esp)
8010127d:	e8 7e 1e 00 00       	call   80103100 <log_write>
  brelse(bp);
80101282:	89 1c 24             	mov    %ebx,(%esp)
80101285:	e8 66 ef ff ff       	call   801001f0 <brelse>
}
8010128a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010128d:	89 f0                	mov    %esi,%eax
8010128f:	5b                   	pop    %ebx
80101290:	5e                   	pop    %esi
80101291:	5f                   	pop    %edi
80101292:	5d                   	pop    %ebp
80101293:	c3                   	ret    
80101294:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010129a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801012a0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012a0:	55                   	push   %ebp
801012a1:	89 e5                	mov    %esp,%ebp
801012a3:	57                   	push   %edi
801012a4:	89 c7                	mov    %eax,%edi
801012a6:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012a7:	31 f6                	xor    %esi,%esi
{
801012a9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012aa:	bb 34 1a 11 80       	mov    $0x80111a34,%ebx
{
801012af:	83 ec 28             	sub    $0x28,%esp
801012b2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012b5:	68 00 1a 11 80       	push   $0x80111a00
801012ba:	e8 71 3c 00 00       	call   80104f30 <acquire>
801012bf:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012c2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012c5:	eb 1b                	jmp    801012e2 <iget+0x42>
801012c7:	89 f6                	mov    %esi,%esi
801012c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012d0:	39 3b                	cmp    %edi,(%ebx)
801012d2:	74 6c                	je     80101340 <iget+0xa0>
801012d4:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012da:	81 fb 54 36 11 80    	cmp    $0x80113654,%ebx
801012e0:	73 26                	jae    80101308 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012e2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012e5:	85 c9                	test   %ecx,%ecx
801012e7:	7f e7                	jg     801012d0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012e9:	85 f6                	test   %esi,%esi
801012eb:	75 e7                	jne    801012d4 <iget+0x34>
801012ed:	8d 83 90 00 00 00    	lea    0x90(%ebx),%eax
801012f3:	85 c9                	test   %ecx,%ecx
801012f5:	75 70                	jne    80101367 <iget+0xc7>
801012f7:	89 de                	mov    %ebx,%esi
801012f9:	89 c3                	mov    %eax,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012fb:	81 fb 54 36 11 80    	cmp    $0x80113654,%ebx
80101301:	72 df                	jb     801012e2 <iget+0x42>
80101303:	90                   	nop
80101304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101308:	85 f6                	test   %esi,%esi
8010130a:	74 74                	je     80101380 <iget+0xe0>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010130c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010130f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101311:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101314:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
8010131b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101322:	68 00 1a 11 80       	push   $0x80111a00
80101327:	e8 c4 3c 00 00       	call   80104ff0 <release>

  return ip;
8010132c:	83 c4 10             	add    $0x10,%esp
}
8010132f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101332:	89 f0                	mov    %esi,%eax
80101334:	5b                   	pop    %ebx
80101335:	5e                   	pop    %esi
80101336:	5f                   	pop    %edi
80101337:	5d                   	pop    %ebp
80101338:	c3                   	ret    
80101339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101340:	39 53 04             	cmp    %edx,0x4(%ebx)
80101343:	75 8f                	jne    801012d4 <iget+0x34>
      release(&icache.lock);
80101345:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101348:	83 c1 01             	add    $0x1,%ecx
      return ip;
8010134b:	89 de                	mov    %ebx,%esi
      ip->ref++;
8010134d:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101350:	68 00 1a 11 80       	push   $0x80111a00
80101355:	e8 96 3c 00 00       	call   80104ff0 <release>
      return ip;
8010135a:	83 c4 10             	add    $0x10,%esp
}
8010135d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101360:	89 f0                	mov    %esi,%eax
80101362:	5b                   	pop    %ebx
80101363:	5e                   	pop    %esi
80101364:	5f                   	pop    %edi
80101365:	5d                   	pop    %ebp
80101366:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101367:	3d 54 36 11 80       	cmp    $0x80113654,%eax
8010136c:	73 12                	jae    80101380 <iget+0xe0>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010136e:	8b 48 08             	mov    0x8(%eax),%ecx
80101371:	89 c3                	mov    %eax,%ebx
80101373:	85 c9                	test   %ecx,%ecx
80101375:	0f 8f 55 ff ff ff    	jg     801012d0 <iget+0x30>
8010137b:	e9 6d ff ff ff       	jmp    801012ed <iget+0x4d>
    panic("iget: no inodes");
80101380:	83 ec 0c             	sub    $0xc,%esp
80101383:	68 75 7c 10 80       	push   $0x80107c75
80101388:	e8 03 f0 ff ff       	call   80100390 <panic>
8010138d:	8d 76 00             	lea    0x0(%esi),%esi

80101390 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101390:	55                   	push   %ebp
80101391:	89 e5                	mov    %esp,%ebp
80101393:	57                   	push   %edi
80101394:	56                   	push   %esi
80101395:	89 c6                	mov    %eax,%esi
80101397:	53                   	push   %ebx
80101398:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010139b:	83 fa 0b             	cmp    $0xb,%edx
8010139e:	0f 86 84 00 00 00    	jbe    80101428 <bmap+0x98>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801013a4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801013a7:	83 fb 7f             	cmp    $0x7f,%ebx
801013aa:	0f 87 98 00 00 00    	ja     80101448 <bmap+0xb8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801013b0:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801013b6:	8b 00                	mov    (%eax),%eax
801013b8:	85 d2                	test   %edx,%edx
801013ba:	74 54                	je     80101410 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801013bc:	83 ec 08             	sub    $0x8,%esp
801013bf:	52                   	push   %edx
801013c0:	50                   	push   %eax
801013c1:	e8 0a ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801013c6:	83 c4 10             	add    $0x10,%esp
801013c9:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
801013cd:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801013cf:	8b 1a                	mov    (%edx),%ebx
801013d1:	85 db                	test   %ebx,%ebx
801013d3:	74 1b                	je     801013f0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801013d5:	83 ec 0c             	sub    $0xc,%esp
801013d8:	57                   	push   %edi
801013d9:	e8 12 ee ff ff       	call   801001f0 <brelse>
    return addr;
801013de:	83 c4 10             	add    $0x10,%esp
  }

  panic("bmap: out of range");
}
801013e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e4:	89 d8                	mov    %ebx,%eax
801013e6:	5b                   	pop    %ebx
801013e7:	5e                   	pop    %esi
801013e8:	5f                   	pop    %edi
801013e9:	5d                   	pop    %ebp
801013ea:	c3                   	ret    
801013eb:	90                   	nop
801013ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      a[bn] = addr = balloc(ip->dev);
801013f0:	8b 06                	mov    (%esi),%eax
801013f2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013f5:	e8 96 fd ff ff       	call   80101190 <balloc>
801013fa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801013fd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101400:	89 c3                	mov    %eax,%ebx
80101402:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101404:	57                   	push   %edi
80101405:	e8 f6 1c 00 00       	call   80103100 <log_write>
8010140a:	83 c4 10             	add    $0x10,%esp
8010140d:	eb c6                	jmp    801013d5 <bmap+0x45>
8010140f:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101410:	e8 7b fd ff ff       	call   80101190 <balloc>
80101415:	89 c2                	mov    %eax,%edx
80101417:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010141d:	8b 06                	mov    (%esi),%eax
8010141f:	eb 9b                	jmp    801013bc <bmap+0x2c>
80101421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
80101428:	8d 3c 90             	lea    (%eax,%edx,4),%edi
8010142b:	8b 5f 5c             	mov    0x5c(%edi),%ebx
8010142e:	85 db                	test   %ebx,%ebx
80101430:	75 af                	jne    801013e1 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101432:	8b 00                	mov    (%eax),%eax
80101434:	e8 57 fd ff ff       	call   80101190 <balloc>
80101439:	89 47 5c             	mov    %eax,0x5c(%edi)
8010143c:	89 c3                	mov    %eax,%ebx
}
8010143e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101441:	89 d8                	mov    %ebx,%eax
80101443:	5b                   	pop    %ebx
80101444:	5e                   	pop    %esi
80101445:	5f                   	pop    %edi
80101446:	5d                   	pop    %ebp
80101447:	c3                   	ret    
  panic("bmap: out of range");
80101448:	83 ec 0c             	sub    $0xc,%esp
8010144b:	68 85 7c 10 80       	push   $0x80107c85
80101450:	e8 3b ef ff ff       	call   80100390 <panic>
80101455:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101460 <readsb>:
{
80101460:	55                   	push   %ebp
80101461:	89 e5                	mov    %esp,%ebp
80101463:	56                   	push   %esi
80101464:	53                   	push   %ebx
80101465:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101468:	83 ec 08             	sub    $0x8,%esp
8010146b:	6a 01                	push   $0x1
8010146d:	ff 75 08             	pushl  0x8(%ebp)
80101470:	e8 5b ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101475:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101478:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010147a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010147d:	6a 1c                	push   $0x1c
8010147f:	50                   	push   %eax
80101480:	56                   	push   %esi
80101481:	e8 5a 3c 00 00       	call   801050e0 <memmove>
  brelse(bp);
80101486:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101489:	83 c4 10             	add    $0x10,%esp
}
8010148c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010148f:	5b                   	pop    %ebx
80101490:	5e                   	pop    %esi
80101491:	5d                   	pop    %ebp
  brelse(bp);
80101492:	e9 59 ed ff ff       	jmp    801001f0 <brelse>
80101497:	89 f6                	mov    %esi,%esi
80101499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014a0 <bfree>:
{
801014a0:	55                   	push   %ebp
801014a1:	89 e5                	mov    %esp,%ebp
801014a3:	56                   	push   %esi
801014a4:	89 c6                	mov    %eax,%esi
801014a6:	53                   	push   %ebx
801014a7:	89 d3                	mov    %edx,%ebx
  readsb(dev, &sb);
801014a9:	83 ec 08             	sub    $0x8,%esp
801014ac:	68 e0 19 11 80       	push   $0x801119e0
801014b1:	50                   	push   %eax
801014b2:	e8 a9 ff ff ff       	call   80101460 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801014b7:	58                   	pop    %eax
801014b8:	5a                   	pop    %edx
801014b9:	89 da                	mov    %ebx,%edx
801014bb:	c1 ea 0c             	shr    $0xc,%edx
801014be:	03 15 f8 19 11 80    	add    0x801119f8,%edx
801014c4:	52                   	push   %edx
801014c5:	56                   	push   %esi
801014c6:	e8 05 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801014cb:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801014cd:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
801014d0:	ba 01 00 00 00       	mov    $0x1,%edx
801014d5:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801014d8:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801014de:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
801014e1:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801014e3:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801014e8:	85 d1                	test   %edx,%ecx
801014ea:	74 25                	je     80101511 <bfree+0x71>
  bp->data[bi/8] &= ~m;
801014ec:	f7 d2                	not    %edx
801014ee:	89 c6                	mov    %eax,%esi
  log_write(bp);
801014f0:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801014f3:	21 ca                	and    %ecx,%edx
801014f5:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
801014f9:	56                   	push   %esi
801014fa:	e8 01 1c 00 00       	call   80103100 <log_write>
  brelse(bp);
801014ff:	89 34 24             	mov    %esi,(%esp)
80101502:	e8 e9 ec ff ff       	call   801001f0 <brelse>
}
80101507:	83 c4 10             	add    $0x10,%esp
8010150a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010150d:	5b                   	pop    %ebx
8010150e:	5e                   	pop    %esi
8010150f:	5d                   	pop    %ebp
80101510:	c3                   	ret    
    panic("freeing free block");
80101511:	83 ec 0c             	sub    $0xc,%esp
80101514:	68 98 7c 10 80       	push   $0x80107c98
80101519:	e8 72 ee ff ff       	call   80100390 <panic>
8010151e:	66 90                	xchg   %ax,%ax

80101520 <iinit>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	53                   	push   %ebx
80101524:	bb 40 1a 11 80       	mov    $0x80111a40,%ebx
80101529:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010152c:	68 ab 7c 10 80       	push   $0x80107cab
80101531:	68 00 1a 11 80       	push   $0x80111a00
80101536:	e8 95 38 00 00       	call   80104dd0 <initlock>
  for(i = 0; i < NINODE; i++) {
8010153b:	83 c4 10             	add    $0x10,%esp
8010153e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101540:	83 ec 08             	sub    $0x8,%esp
80101543:	68 b2 7c 10 80       	push   $0x80107cb2
80101548:	53                   	push   %ebx
80101549:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010154f:	e8 4c 37 00 00       	call   80104ca0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101554:	83 c4 10             	add    $0x10,%esp
80101557:	81 fb 60 36 11 80    	cmp    $0x80113660,%ebx
8010155d:	75 e1                	jne    80101540 <iinit+0x20>
  readsb(dev, &sb);
8010155f:	83 ec 08             	sub    $0x8,%esp
80101562:	68 e0 19 11 80       	push   $0x801119e0
80101567:	ff 75 08             	pushl  0x8(%ebp)
8010156a:	e8 f1 fe ff ff       	call   80101460 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010156f:	ff 35 f8 19 11 80    	pushl  0x801119f8
80101575:	ff 35 f4 19 11 80    	pushl  0x801119f4
8010157b:	ff 35 f0 19 11 80    	pushl  0x801119f0
80101581:	ff 35 ec 19 11 80    	pushl  0x801119ec
80101587:	ff 35 e8 19 11 80    	pushl  0x801119e8
8010158d:	ff 35 e4 19 11 80    	pushl  0x801119e4
80101593:	ff 35 e0 19 11 80    	pushl  0x801119e0
80101599:	68 18 7d 10 80       	push   $0x80107d18
8010159e:	e8 0d f1 ff ff       	call   801006b0 <cprintf>
}
801015a3:	83 c4 30             	add    $0x30,%esp
801015a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015a9:	c9                   	leave  
801015aa:	c3                   	ret    
801015ab:	90                   	nop
801015ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801015b0 <ialloc>:
{
801015b0:	55                   	push   %ebp
801015b1:	89 e5                	mov    %esp,%ebp
801015b3:	57                   	push   %edi
801015b4:	56                   	push   %esi
801015b5:	53                   	push   %ebx
801015b6:	83 ec 1c             	sub    $0x1c,%esp
801015b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
801015bc:	83 3d e8 19 11 80 01 	cmpl   $0x1,0x801119e8
{
801015c3:	8b 75 08             	mov    0x8(%ebp),%esi
801015c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801015c9:	0f 86 91 00 00 00    	jbe    80101660 <ialloc+0xb0>
801015cf:	bb 01 00 00 00       	mov    $0x1,%ebx
801015d4:	eb 21                	jmp    801015f7 <ialloc+0x47>
801015d6:	8d 76 00             	lea    0x0(%esi),%esi
801015d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
801015e0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801015e3:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
801015e6:	57                   	push   %edi
801015e7:	e8 04 ec ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801015ec:	83 c4 10             	add    $0x10,%esp
801015ef:	3b 1d e8 19 11 80    	cmp    0x801119e8,%ebx
801015f5:	73 69                	jae    80101660 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801015f7:	89 d8                	mov    %ebx,%eax
801015f9:	83 ec 08             	sub    $0x8,%esp
801015fc:	c1 e8 03             	shr    $0x3,%eax
801015ff:	03 05 f4 19 11 80    	add    0x801119f4,%eax
80101605:	50                   	push   %eax
80101606:	56                   	push   %esi
80101607:	e8 c4 ea ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010160c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010160f:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
80101611:	89 d8                	mov    %ebx,%eax
80101613:	83 e0 07             	and    $0x7,%eax
80101616:	c1 e0 06             	shl    $0x6,%eax
80101619:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010161d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101621:	75 bd                	jne    801015e0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101623:	83 ec 04             	sub    $0x4,%esp
80101626:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101629:	6a 40                	push   $0x40
8010162b:	6a 00                	push   $0x0
8010162d:	51                   	push   %ecx
8010162e:	e8 0d 3a 00 00       	call   80105040 <memset>
      dip->type = type;
80101633:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101637:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010163a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010163d:	89 3c 24             	mov    %edi,(%esp)
80101640:	e8 bb 1a 00 00       	call   80103100 <log_write>
      brelse(bp);
80101645:	89 3c 24             	mov    %edi,(%esp)
80101648:	e8 a3 eb ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010164d:	83 c4 10             	add    $0x10,%esp
}
80101650:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101653:	89 da                	mov    %ebx,%edx
80101655:	89 f0                	mov    %esi,%eax
}
80101657:	5b                   	pop    %ebx
80101658:	5e                   	pop    %esi
80101659:	5f                   	pop    %edi
8010165a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010165b:	e9 40 fc ff ff       	jmp    801012a0 <iget>
  panic("ialloc: no inodes");
80101660:	83 ec 0c             	sub    $0xc,%esp
80101663:	68 b8 7c 10 80       	push   $0x80107cb8
80101668:	e8 23 ed ff ff       	call   80100390 <panic>
8010166d:	8d 76 00             	lea    0x0(%esi),%esi

80101670 <iupdate>:
{
80101670:	55                   	push   %ebp
80101671:	89 e5                	mov    %esp,%ebp
80101673:	56                   	push   %esi
80101674:	53                   	push   %ebx
80101675:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101678:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010167b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010167e:	83 ec 08             	sub    $0x8,%esp
80101681:	c1 e8 03             	shr    $0x3,%eax
80101684:	03 05 f4 19 11 80    	add    0x801119f4,%eax
8010168a:	50                   	push   %eax
8010168b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010168e:	e8 3d ea ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101693:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101697:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010169a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010169c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010169f:	83 e0 07             	and    $0x7,%eax
801016a2:	c1 e0 06             	shl    $0x6,%eax
801016a5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801016a9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801016ac:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016b0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801016b3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801016b7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801016bb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801016bf:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801016c3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801016c7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801016ca:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016cd:	6a 34                	push   $0x34
801016cf:	53                   	push   %ebx
801016d0:	50                   	push   %eax
801016d1:	e8 0a 3a 00 00       	call   801050e0 <memmove>
  log_write(bp);
801016d6:	89 34 24             	mov    %esi,(%esp)
801016d9:	e8 22 1a 00 00       	call   80103100 <log_write>
  brelse(bp);
801016de:	89 75 08             	mov    %esi,0x8(%ebp)
801016e1:	83 c4 10             	add    $0x10,%esp
}
801016e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016e7:	5b                   	pop    %ebx
801016e8:	5e                   	pop    %esi
801016e9:	5d                   	pop    %ebp
  brelse(bp);
801016ea:	e9 01 eb ff ff       	jmp    801001f0 <brelse>
801016ef:	90                   	nop

801016f0 <idup>:
{
801016f0:	55                   	push   %ebp
801016f1:	89 e5                	mov    %esp,%ebp
801016f3:	53                   	push   %ebx
801016f4:	83 ec 10             	sub    $0x10,%esp
801016f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801016fa:	68 00 1a 11 80       	push   $0x80111a00
801016ff:	e8 2c 38 00 00       	call   80104f30 <acquire>
  ip->ref++;
80101704:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101708:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
8010170f:	e8 dc 38 00 00       	call   80104ff0 <release>
}
80101714:	89 d8                	mov    %ebx,%eax
80101716:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101719:	c9                   	leave  
8010171a:	c3                   	ret    
8010171b:	90                   	nop
8010171c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101720 <ilock>:
{
80101720:	55                   	push   %ebp
80101721:	89 e5                	mov    %esp,%ebp
80101723:	56                   	push   %esi
80101724:	53                   	push   %ebx
80101725:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101728:	85 db                	test   %ebx,%ebx
8010172a:	0f 84 b7 00 00 00    	je     801017e7 <ilock+0xc7>
80101730:	8b 53 08             	mov    0x8(%ebx),%edx
80101733:	85 d2                	test   %edx,%edx
80101735:	0f 8e ac 00 00 00    	jle    801017e7 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010173b:	83 ec 0c             	sub    $0xc,%esp
8010173e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101741:	50                   	push   %eax
80101742:	e8 99 35 00 00       	call   80104ce0 <acquiresleep>
  if(ip->valid == 0){
80101747:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010174a:	83 c4 10             	add    $0x10,%esp
8010174d:	85 c0                	test   %eax,%eax
8010174f:	74 0f                	je     80101760 <ilock+0x40>
}
80101751:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101754:	5b                   	pop    %ebx
80101755:	5e                   	pop    %esi
80101756:	5d                   	pop    %ebp
80101757:	c3                   	ret    
80101758:	90                   	nop
80101759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101760:	8b 43 04             	mov    0x4(%ebx),%eax
80101763:	83 ec 08             	sub    $0x8,%esp
80101766:	c1 e8 03             	shr    $0x3,%eax
80101769:	03 05 f4 19 11 80    	add    0x801119f4,%eax
8010176f:	50                   	push   %eax
80101770:	ff 33                	pushl  (%ebx)
80101772:	e8 59 e9 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101777:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010177a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010177c:	8b 43 04             	mov    0x4(%ebx),%eax
8010177f:	83 e0 07             	and    $0x7,%eax
80101782:	c1 e0 06             	shl    $0x6,%eax
80101785:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101789:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010178c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010178f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101793:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101797:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010179b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010179f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801017a3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801017a7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801017ab:	8b 50 fc             	mov    -0x4(%eax),%edx
801017ae:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017b1:	6a 34                	push   $0x34
801017b3:	50                   	push   %eax
801017b4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801017b7:	50                   	push   %eax
801017b8:	e8 23 39 00 00       	call   801050e0 <memmove>
    brelse(bp);
801017bd:	89 34 24             	mov    %esi,(%esp)
801017c0:	e8 2b ea ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
801017c5:	83 c4 10             	add    $0x10,%esp
801017c8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
801017cd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801017d4:	0f 85 77 ff ff ff    	jne    80101751 <ilock+0x31>
      panic("ilock: no type");
801017da:	83 ec 0c             	sub    $0xc,%esp
801017dd:	68 d0 7c 10 80       	push   $0x80107cd0
801017e2:	e8 a9 eb ff ff       	call   80100390 <panic>
    panic("ilock");
801017e7:	83 ec 0c             	sub    $0xc,%esp
801017ea:	68 ca 7c 10 80       	push   $0x80107cca
801017ef:	e8 9c eb ff ff       	call   80100390 <panic>
801017f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801017fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101800 <iunlock>:
{
80101800:	55                   	push   %ebp
80101801:	89 e5                	mov    %esp,%ebp
80101803:	56                   	push   %esi
80101804:	53                   	push   %ebx
80101805:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101808:	85 db                	test   %ebx,%ebx
8010180a:	74 28                	je     80101834 <iunlock+0x34>
8010180c:	83 ec 0c             	sub    $0xc,%esp
8010180f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101812:	56                   	push   %esi
80101813:	e8 68 35 00 00       	call   80104d80 <holdingsleep>
80101818:	83 c4 10             	add    $0x10,%esp
8010181b:	85 c0                	test   %eax,%eax
8010181d:	74 15                	je     80101834 <iunlock+0x34>
8010181f:	8b 43 08             	mov    0x8(%ebx),%eax
80101822:	85 c0                	test   %eax,%eax
80101824:	7e 0e                	jle    80101834 <iunlock+0x34>
  releasesleep(&ip->lock);
80101826:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101829:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010182c:	5b                   	pop    %ebx
8010182d:	5e                   	pop    %esi
8010182e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010182f:	e9 0c 35 00 00       	jmp    80104d40 <releasesleep>
    panic("iunlock");
80101834:	83 ec 0c             	sub    $0xc,%esp
80101837:	68 df 7c 10 80       	push   $0x80107cdf
8010183c:	e8 4f eb ff ff       	call   80100390 <panic>
80101841:	eb 0d                	jmp    80101850 <iput>
80101843:	90                   	nop
80101844:	90                   	nop
80101845:	90                   	nop
80101846:	90                   	nop
80101847:	90                   	nop
80101848:	90                   	nop
80101849:	90                   	nop
8010184a:	90                   	nop
8010184b:	90                   	nop
8010184c:	90                   	nop
8010184d:	90                   	nop
8010184e:	90                   	nop
8010184f:	90                   	nop

80101850 <iput>:
{
80101850:	55                   	push   %ebp
80101851:	89 e5                	mov    %esp,%ebp
80101853:	57                   	push   %edi
80101854:	56                   	push   %esi
80101855:	53                   	push   %ebx
80101856:	83 ec 28             	sub    $0x28,%esp
80101859:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010185c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010185f:	57                   	push   %edi
80101860:	e8 7b 34 00 00       	call   80104ce0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101865:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101868:	83 c4 10             	add    $0x10,%esp
8010186b:	85 d2                	test   %edx,%edx
8010186d:	74 07                	je     80101876 <iput+0x26>
8010186f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101874:	74 32                	je     801018a8 <iput+0x58>
  releasesleep(&ip->lock);
80101876:	83 ec 0c             	sub    $0xc,%esp
80101879:	57                   	push   %edi
8010187a:	e8 c1 34 00 00       	call   80104d40 <releasesleep>
  acquire(&icache.lock);
8010187f:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
80101886:	e8 a5 36 00 00       	call   80104f30 <acquire>
  ip->ref--;
8010188b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010188f:	83 c4 10             	add    $0x10,%esp
80101892:	c7 45 08 00 1a 11 80 	movl   $0x80111a00,0x8(%ebp)
}
80101899:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010189c:	5b                   	pop    %ebx
8010189d:	5e                   	pop    %esi
8010189e:	5f                   	pop    %edi
8010189f:	5d                   	pop    %ebp
  release(&icache.lock);
801018a0:	e9 4b 37 00 00       	jmp    80104ff0 <release>
801018a5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801018a8:	83 ec 0c             	sub    $0xc,%esp
801018ab:	68 00 1a 11 80       	push   $0x80111a00
801018b0:	e8 7b 36 00 00       	call   80104f30 <acquire>
    int r = ip->ref;
801018b5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801018b8:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
801018bf:	e8 2c 37 00 00       	call   80104ff0 <release>
    if(r == 1){
801018c4:	83 c4 10             	add    $0x10,%esp
801018c7:	83 fe 01             	cmp    $0x1,%esi
801018ca:	75 aa                	jne    80101876 <iput+0x26>
801018cc:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801018d2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801018d5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801018d8:	89 cf                	mov    %ecx,%edi
801018da:	eb 0b                	jmp    801018e7 <iput+0x97>
801018dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018e0:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801018e3:	39 fe                	cmp    %edi,%esi
801018e5:	74 19                	je     80101900 <iput+0xb0>
    if(ip->addrs[i]){
801018e7:	8b 16                	mov    (%esi),%edx
801018e9:	85 d2                	test   %edx,%edx
801018eb:	74 f3                	je     801018e0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801018ed:	8b 03                	mov    (%ebx),%eax
801018ef:	e8 ac fb ff ff       	call   801014a0 <bfree>
      ip->addrs[i] = 0;
801018f4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801018fa:	eb e4                	jmp    801018e0 <iput+0x90>
801018fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101900:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101906:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101909:	85 c0                	test   %eax,%eax
8010190b:	75 33                	jne    80101940 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010190d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101910:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101917:	53                   	push   %ebx
80101918:	e8 53 fd ff ff       	call   80101670 <iupdate>
      ip->type = 0;
8010191d:	31 c0                	xor    %eax,%eax
8010191f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101923:	89 1c 24             	mov    %ebx,(%esp)
80101926:	e8 45 fd ff ff       	call   80101670 <iupdate>
      ip->valid = 0;
8010192b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101932:	83 c4 10             	add    $0x10,%esp
80101935:	e9 3c ff ff ff       	jmp    80101876 <iput+0x26>
8010193a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101940:	83 ec 08             	sub    $0x8,%esp
80101943:	50                   	push   %eax
80101944:	ff 33                	pushl  (%ebx)
80101946:	e8 85 e7 ff ff       	call   801000d0 <bread>
8010194b:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010194e:	83 c4 10             	add    $0x10,%esp
80101951:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101957:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
8010195a:	8d 70 5c             	lea    0x5c(%eax),%esi
8010195d:	89 cf                	mov    %ecx,%edi
8010195f:	eb 0e                	jmp    8010196f <iput+0x11f>
80101961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101968:	83 c6 04             	add    $0x4,%esi
8010196b:	39 f7                	cmp    %esi,%edi
8010196d:	74 11                	je     80101980 <iput+0x130>
      if(a[j])
8010196f:	8b 16                	mov    (%esi),%edx
80101971:	85 d2                	test   %edx,%edx
80101973:	74 f3                	je     80101968 <iput+0x118>
        bfree(ip->dev, a[j]);
80101975:	8b 03                	mov    (%ebx),%eax
80101977:	e8 24 fb ff ff       	call   801014a0 <bfree>
8010197c:	eb ea                	jmp    80101968 <iput+0x118>
8010197e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101980:	83 ec 0c             	sub    $0xc,%esp
80101983:	ff 75 e4             	pushl  -0x1c(%ebp)
80101986:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101989:	e8 62 e8 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010198e:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101994:	8b 03                	mov    (%ebx),%eax
80101996:	e8 05 fb ff ff       	call   801014a0 <bfree>
    ip->addrs[NDIRECT] = 0;
8010199b:	83 c4 10             	add    $0x10,%esp
8010199e:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801019a5:	00 00 00 
801019a8:	e9 60 ff ff ff       	jmp    8010190d <iput+0xbd>
801019ad:	8d 76 00             	lea    0x0(%esi),%esi

801019b0 <iunlockput>:
{
801019b0:	55                   	push   %ebp
801019b1:	89 e5                	mov    %esp,%ebp
801019b3:	53                   	push   %ebx
801019b4:	83 ec 10             	sub    $0x10,%esp
801019b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801019ba:	53                   	push   %ebx
801019bb:	e8 40 fe ff ff       	call   80101800 <iunlock>
  iput(ip);
801019c0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801019c3:	83 c4 10             	add    $0x10,%esp
}
801019c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019c9:	c9                   	leave  
  iput(ip);
801019ca:	e9 81 fe ff ff       	jmp    80101850 <iput>
801019cf:	90                   	nop

801019d0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
801019d0:	55                   	push   %ebp
801019d1:	89 e5                	mov    %esp,%ebp
801019d3:	8b 55 08             	mov    0x8(%ebp),%edx
801019d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801019d9:	8b 0a                	mov    (%edx),%ecx
801019db:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801019de:	8b 4a 04             	mov    0x4(%edx),%ecx
801019e1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801019e4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801019e8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801019eb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801019ef:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801019f3:	8b 52 58             	mov    0x58(%edx),%edx
801019f6:	89 50 10             	mov    %edx,0x10(%eax)
}
801019f9:	5d                   	pop    %ebp
801019fa:	c3                   	ret    
801019fb:	90                   	nop
801019fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a00 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a00:	55                   	push   %ebp
80101a01:	89 e5                	mov    %esp,%ebp
80101a03:	57                   	push   %edi
80101a04:	56                   	push   %esi
80101a05:	53                   	push   %ebx
80101a06:	83 ec 1c             	sub    $0x1c,%esp
80101a09:	8b 45 08             	mov    0x8(%ebp),%eax
80101a0c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a0f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a12:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a17:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101a1a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a1d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a20:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101a23:	0f 84 a7 00 00 00    	je     80101ad0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a29:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a2c:	8b 40 58             	mov    0x58(%eax),%eax
80101a2f:	39 c6                	cmp    %eax,%esi
80101a31:	0f 87 ba 00 00 00    	ja     80101af1 <readi+0xf1>
80101a37:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a3a:	89 f9                	mov    %edi,%ecx
80101a3c:	01 f1                	add    %esi,%ecx
80101a3e:	0f 82 ad 00 00 00    	jb     80101af1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a44:	89 c2                	mov    %eax,%edx
80101a46:	29 f2                	sub    %esi,%edx
80101a48:	39 c8                	cmp    %ecx,%eax
80101a4a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a4d:	31 ff                	xor    %edi,%edi
    n = ip->size - off;
80101a4f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a52:	85 d2                	test   %edx,%edx
80101a54:	74 6c                	je     80101ac2 <readi+0xc2>
80101a56:	8d 76 00             	lea    0x0(%esi),%esi
80101a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a60:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101a63:	89 f2                	mov    %esi,%edx
80101a65:	c1 ea 09             	shr    $0x9,%edx
80101a68:	89 d8                	mov    %ebx,%eax
80101a6a:	e8 21 f9 ff ff       	call   80101390 <bmap>
80101a6f:	83 ec 08             	sub    $0x8,%esp
80101a72:	50                   	push   %eax
80101a73:	ff 33                	pushl  (%ebx)
80101a75:	e8 56 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a7a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101a7d:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a82:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a85:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a87:	89 f0                	mov    %esi,%eax
80101a89:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a8e:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a90:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a93:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a95:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101a99:	39 d9                	cmp    %ebx,%ecx
80101a9b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a9e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a9f:	01 df                	add    %ebx,%edi
80101aa1:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101aa3:	50                   	push   %eax
80101aa4:	ff 75 e0             	pushl  -0x20(%ebp)
80101aa7:	e8 34 36 00 00       	call   801050e0 <memmove>
    brelse(bp);
80101aac:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101aaf:	89 14 24             	mov    %edx,(%esp)
80101ab2:	e8 39 e7 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ab7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101aba:	83 c4 10             	add    $0x10,%esp
80101abd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101ac0:	77 9e                	ja     80101a60 <readi+0x60>
  }
  return n;
80101ac2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101ac5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ac8:	5b                   	pop    %ebx
80101ac9:	5e                   	pop    %esi
80101aca:	5f                   	pop    %edi
80101acb:	5d                   	pop    %ebp
80101acc:	c3                   	ret    
80101acd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ad0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ad4:	66 83 f8 09          	cmp    $0x9,%ax
80101ad8:	77 17                	ja     80101af1 <readi+0xf1>
80101ada:	8b 04 c5 80 19 11 80 	mov    -0x7feee680(,%eax,8),%eax
80101ae1:	85 c0                	test   %eax,%eax
80101ae3:	74 0c                	je     80101af1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101ae5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101ae8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101aeb:	5b                   	pop    %ebx
80101aec:	5e                   	pop    %esi
80101aed:	5f                   	pop    %edi
80101aee:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101aef:	ff e0                	jmp    *%eax
      return -1;
80101af1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101af6:	eb cd                	jmp    80101ac5 <readi+0xc5>
80101af8:	90                   	nop
80101af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101b00 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b00:	55                   	push   %ebp
80101b01:	89 e5                	mov    %esp,%ebp
80101b03:	57                   	push   %edi
80101b04:	56                   	push   %esi
80101b05:	53                   	push   %ebx
80101b06:	83 ec 1c             	sub    $0x1c,%esp
80101b09:	8b 45 08             	mov    0x8(%ebp),%eax
80101b0c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b0f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b12:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101b17:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b1a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b1d:	8b 75 10             	mov    0x10(%ebp),%esi
80101b20:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b23:	0f 84 b7 00 00 00    	je     80101be0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b29:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b2c:	39 70 58             	cmp    %esi,0x58(%eax)
80101b2f:	0f 82 e7 00 00 00    	jb     80101c1c <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b35:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b38:	89 f8                	mov    %edi,%eax
80101b3a:	01 f0                	add    %esi,%eax
80101b3c:	0f 82 da 00 00 00    	jb     80101c1c <writei+0x11c>
80101b42:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b47:	0f 87 cf 00 00 00    	ja     80101c1c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b4d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b54:	85 ff                	test   %edi,%edi
80101b56:	74 79                	je     80101bd1 <writei+0xd1>
80101b58:	90                   	nop
80101b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b60:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101b63:	89 f2                	mov    %esi,%edx
80101b65:	c1 ea 09             	shr    $0x9,%edx
80101b68:	89 f8                	mov    %edi,%eax
80101b6a:	e8 21 f8 ff ff       	call   80101390 <bmap>
80101b6f:	83 ec 08             	sub    $0x8,%esp
80101b72:	50                   	push   %eax
80101b73:	ff 37                	pushl  (%edi)
80101b75:	e8 56 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b7a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b7f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101b82:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b85:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b87:	89 f0                	mov    %esi,%eax
80101b89:	83 c4 0c             	add    $0xc,%esp
80101b8c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b91:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b93:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b97:	39 d9                	cmp    %ebx,%ecx
80101b99:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b9c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b9d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b9f:	ff 75 dc             	pushl  -0x24(%ebp)
80101ba2:	50                   	push   %eax
80101ba3:	e8 38 35 00 00       	call   801050e0 <memmove>
    log_write(bp);
80101ba8:	89 3c 24             	mov    %edi,(%esp)
80101bab:	e8 50 15 00 00       	call   80103100 <log_write>
    brelse(bp);
80101bb0:	89 3c 24             	mov    %edi,(%esp)
80101bb3:	e8 38 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bb8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101bbb:	83 c4 10             	add    $0x10,%esp
80101bbe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bc1:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101bc4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101bc7:	77 97                	ja     80101b60 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101bc9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bcc:	3b 70 58             	cmp    0x58(%eax),%esi
80101bcf:	77 37                	ja     80101c08 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101bd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101bd4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bd7:	5b                   	pop    %ebx
80101bd8:	5e                   	pop    %esi
80101bd9:	5f                   	pop    %edi
80101bda:	5d                   	pop    %ebp
80101bdb:	c3                   	ret    
80101bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101be0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101be4:	66 83 f8 09          	cmp    $0x9,%ax
80101be8:	77 32                	ja     80101c1c <writei+0x11c>
80101bea:	8b 04 c5 84 19 11 80 	mov    -0x7feee67c(,%eax,8),%eax
80101bf1:	85 c0                	test   %eax,%eax
80101bf3:	74 27                	je     80101c1c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101bf5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101bf8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bfb:	5b                   	pop    %ebx
80101bfc:	5e                   	pop    %esi
80101bfd:	5f                   	pop    %edi
80101bfe:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101bff:	ff e0                	jmp    *%eax
80101c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c08:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c0b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101c0e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101c11:	50                   	push   %eax
80101c12:	e8 59 fa ff ff       	call   80101670 <iupdate>
80101c17:	83 c4 10             	add    $0x10,%esp
80101c1a:	eb b5                	jmp    80101bd1 <writei+0xd1>
      return -1;
80101c1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c21:	eb b1                	jmp    80101bd4 <writei+0xd4>
80101c23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c30 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c30:	55                   	push   %ebp
80101c31:	89 e5                	mov    %esp,%ebp
80101c33:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101c36:	6a 0e                	push   $0xe
80101c38:	ff 75 0c             	pushl  0xc(%ebp)
80101c3b:	ff 75 08             	pushl  0x8(%ebp)
80101c3e:	e8 0d 35 00 00       	call   80105150 <strncmp>
}
80101c43:	c9                   	leave  
80101c44:	c3                   	ret    
80101c45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c50 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	57                   	push   %edi
80101c54:	56                   	push   %esi
80101c55:	53                   	push   %ebx
80101c56:	83 ec 1c             	sub    $0x1c,%esp
80101c59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c5c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c61:	0f 85 85 00 00 00    	jne    80101cec <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c67:	8b 53 58             	mov    0x58(%ebx),%edx
80101c6a:	31 ff                	xor    %edi,%edi
80101c6c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c6f:	85 d2                	test   %edx,%edx
80101c71:	74 3e                	je     80101cb1 <dirlookup+0x61>
80101c73:	90                   	nop
80101c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c78:	6a 10                	push   $0x10
80101c7a:	57                   	push   %edi
80101c7b:	56                   	push   %esi
80101c7c:	53                   	push   %ebx
80101c7d:	e8 7e fd ff ff       	call   80101a00 <readi>
80101c82:	83 c4 10             	add    $0x10,%esp
80101c85:	83 f8 10             	cmp    $0x10,%eax
80101c88:	75 55                	jne    80101cdf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101c8a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c8f:	74 18                	je     80101ca9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c91:	83 ec 04             	sub    $0x4,%esp
80101c94:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c97:	6a 0e                	push   $0xe
80101c99:	50                   	push   %eax
80101c9a:	ff 75 0c             	pushl  0xc(%ebp)
80101c9d:	e8 ae 34 00 00       	call   80105150 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101ca2:	83 c4 10             	add    $0x10,%esp
80101ca5:	85 c0                	test   %eax,%eax
80101ca7:	74 17                	je     80101cc0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101ca9:	83 c7 10             	add    $0x10,%edi
80101cac:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101caf:	72 c7                	jb     80101c78 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101cb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101cb4:	31 c0                	xor    %eax,%eax
}
80101cb6:	5b                   	pop    %ebx
80101cb7:	5e                   	pop    %esi
80101cb8:	5f                   	pop    %edi
80101cb9:	5d                   	pop    %ebp
80101cba:	c3                   	ret    
80101cbb:	90                   	nop
80101cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101cc0:	8b 45 10             	mov    0x10(%ebp),%eax
80101cc3:	85 c0                	test   %eax,%eax
80101cc5:	74 05                	je     80101ccc <dirlookup+0x7c>
        *poff = off;
80101cc7:	8b 45 10             	mov    0x10(%ebp),%eax
80101cca:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101ccc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101cd0:	8b 03                	mov    (%ebx),%eax
80101cd2:	e8 c9 f5 ff ff       	call   801012a0 <iget>
}
80101cd7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cda:	5b                   	pop    %ebx
80101cdb:	5e                   	pop    %esi
80101cdc:	5f                   	pop    %edi
80101cdd:	5d                   	pop    %ebp
80101cde:	c3                   	ret    
      panic("dirlookup read");
80101cdf:	83 ec 0c             	sub    $0xc,%esp
80101ce2:	68 f9 7c 10 80       	push   $0x80107cf9
80101ce7:	e8 a4 e6 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101cec:	83 ec 0c             	sub    $0xc,%esp
80101cef:	68 e7 7c 10 80       	push   $0x80107ce7
80101cf4:	e8 97 e6 ff ff       	call   80100390 <panic>
80101cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d00 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d00:	55                   	push   %ebp
80101d01:	89 e5                	mov    %esp,%ebp
80101d03:	57                   	push   %edi
80101d04:	56                   	push   %esi
80101d05:	53                   	push   %ebx
80101d06:	89 c3                	mov    %eax,%ebx
80101d08:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d0b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d0e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101d11:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101d14:	0f 84 86 01 00 00    	je     80101ea0 <namex+0x1a0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d1a:	e8 81 1f 00 00       	call   80103ca0 <myproc>
  acquire(&icache.lock);
80101d1f:	83 ec 0c             	sub    $0xc,%esp
80101d22:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
80101d24:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d27:	68 00 1a 11 80       	push   $0x80111a00
80101d2c:	e8 ff 31 00 00       	call   80104f30 <acquire>
  ip->ref++;
80101d31:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d35:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
80101d3c:	e8 af 32 00 00       	call   80104ff0 <release>
80101d41:	83 c4 10             	add    $0x10,%esp
80101d44:	eb 0d                	jmp    80101d53 <namex+0x53>
80101d46:	8d 76 00             	lea    0x0(%esi),%esi
80101d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d50:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101d53:	0f b6 07             	movzbl (%edi),%eax
80101d56:	3c 2f                	cmp    $0x2f,%al
80101d58:	74 f6                	je     80101d50 <namex+0x50>
  if(*path == 0)
80101d5a:	84 c0                	test   %al,%al
80101d5c:	0f 84 ee 00 00 00    	je     80101e50 <namex+0x150>
  while(*path != '/' && *path != 0)
80101d62:	0f b6 07             	movzbl (%edi),%eax
80101d65:	3c 2f                	cmp    $0x2f,%al
80101d67:	0f 84 fb 00 00 00    	je     80101e68 <namex+0x168>
80101d6d:	89 fb                	mov    %edi,%ebx
80101d6f:	84 c0                	test   %al,%al
80101d71:	0f 84 f1 00 00 00    	je     80101e68 <namex+0x168>
80101d77:	89 f6                	mov    %esi,%esi
80101d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d80:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
80101d83:	0f b6 03             	movzbl (%ebx),%eax
80101d86:	3c 2f                	cmp    $0x2f,%al
80101d88:	74 04                	je     80101d8e <namex+0x8e>
80101d8a:	84 c0                	test   %al,%al
80101d8c:	75 f2                	jne    80101d80 <namex+0x80>
  len = path - s;
80101d8e:	89 d8                	mov    %ebx,%eax
80101d90:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
80101d92:	83 f8 0d             	cmp    $0xd,%eax
80101d95:	0f 8e 85 00 00 00    	jle    80101e20 <namex+0x120>
    memmove(name, s, DIRSIZ);
80101d9b:	83 ec 04             	sub    $0x4,%esp
80101d9e:	6a 0e                	push   $0xe
80101da0:	57                   	push   %edi
    path++;
80101da1:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
80101da3:	ff 75 e4             	pushl  -0x1c(%ebp)
80101da6:	e8 35 33 00 00       	call   801050e0 <memmove>
80101dab:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101dae:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101db1:	75 0d                	jne    80101dc0 <namex+0xc0>
80101db3:	90                   	nop
80101db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101db8:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101dbb:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101dbe:	74 f8                	je     80101db8 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101dc0:	83 ec 0c             	sub    $0xc,%esp
80101dc3:	56                   	push   %esi
80101dc4:	e8 57 f9 ff ff       	call   80101720 <ilock>
    if(ip->type != T_DIR){
80101dc9:	83 c4 10             	add    $0x10,%esp
80101dcc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101dd1:	0f 85 a1 00 00 00    	jne    80101e78 <namex+0x178>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101dd7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101dda:	85 d2                	test   %edx,%edx
80101ddc:	74 09                	je     80101de7 <namex+0xe7>
80101dde:	80 3f 00             	cmpb   $0x0,(%edi)
80101de1:	0f 84 d9 00 00 00    	je     80101ec0 <namex+0x1c0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101de7:	83 ec 04             	sub    $0x4,%esp
80101dea:	6a 00                	push   $0x0
80101dec:	ff 75 e4             	pushl  -0x1c(%ebp)
80101def:	56                   	push   %esi
80101df0:	e8 5b fe ff ff       	call   80101c50 <dirlookup>
80101df5:	83 c4 10             	add    $0x10,%esp
80101df8:	89 c3                	mov    %eax,%ebx
80101dfa:	85 c0                	test   %eax,%eax
80101dfc:	74 7a                	je     80101e78 <namex+0x178>
  iunlock(ip);
80101dfe:	83 ec 0c             	sub    $0xc,%esp
80101e01:	56                   	push   %esi
80101e02:	e8 f9 f9 ff ff       	call   80101800 <iunlock>
  iput(ip);
80101e07:	89 34 24             	mov    %esi,(%esp)
80101e0a:	89 de                	mov    %ebx,%esi
80101e0c:	e8 3f fa ff ff       	call   80101850 <iput>
  while(*path == '/')
80101e11:	83 c4 10             	add    $0x10,%esp
80101e14:	e9 3a ff ff ff       	jmp    80101d53 <namex+0x53>
80101e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e20:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101e23:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80101e26:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
80101e29:	83 ec 04             	sub    $0x4,%esp
80101e2c:	50                   	push   %eax
80101e2d:	57                   	push   %edi
    name[len] = 0;
80101e2e:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
80101e30:	ff 75 e4             	pushl  -0x1c(%ebp)
80101e33:	e8 a8 32 00 00       	call   801050e0 <memmove>
    name[len] = 0;
80101e38:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e3b:	83 c4 10             	add    $0x10,%esp
80101e3e:	c6 00 00             	movb   $0x0,(%eax)
80101e41:	e9 68 ff ff ff       	jmp    80101dae <namex+0xae>
80101e46:	8d 76 00             	lea    0x0(%esi),%esi
80101e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e50:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e53:	85 c0                	test   %eax,%eax
80101e55:	0f 85 85 00 00 00    	jne    80101ee0 <namex+0x1e0>
    iput(ip);
    return 0;
  }
  return ip;
}
80101e5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e5e:	89 f0                	mov    %esi,%eax
80101e60:	5b                   	pop    %ebx
80101e61:	5e                   	pop    %esi
80101e62:	5f                   	pop    %edi
80101e63:	5d                   	pop    %ebp
80101e64:	c3                   	ret    
80101e65:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
80101e68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e6b:	89 fb                	mov    %edi,%ebx
80101e6d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101e70:	31 c0                	xor    %eax,%eax
80101e72:	eb b5                	jmp    80101e29 <namex+0x129>
80101e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101e78:	83 ec 0c             	sub    $0xc,%esp
80101e7b:	56                   	push   %esi
80101e7c:	e8 7f f9 ff ff       	call   80101800 <iunlock>
  iput(ip);
80101e81:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101e84:	31 f6                	xor    %esi,%esi
  iput(ip);
80101e86:	e8 c5 f9 ff ff       	call   80101850 <iput>
      return 0;
80101e8b:	83 c4 10             	add    $0x10,%esp
}
80101e8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e91:	89 f0                	mov    %esi,%eax
80101e93:	5b                   	pop    %ebx
80101e94:	5e                   	pop    %esi
80101e95:	5f                   	pop    %edi
80101e96:	5d                   	pop    %ebp
80101e97:	c3                   	ret    
80101e98:	90                   	nop
80101e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip = iget(ROOTDEV, ROOTINO);
80101ea0:	ba 01 00 00 00       	mov    $0x1,%edx
80101ea5:	b8 01 00 00 00       	mov    $0x1,%eax
80101eaa:	89 df                	mov    %ebx,%edi
80101eac:	e8 ef f3 ff ff       	call   801012a0 <iget>
80101eb1:	89 c6                	mov    %eax,%esi
80101eb3:	e9 9b fe ff ff       	jmp    80101d53 <namex+0x53>
80101eb8:	90                   	nop
80101eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      iunlock(ip);
80101ec0:	83 ec 0c             	sub    $0xc,%esp
80101ec3:	56                   	push   %esi
80101ec4:	e8 37 f9 ff ff       	call   80101800 <iunlock>
      return ip;
80101ec9:	83 c4 10             	add    $0x10,%esp
}
80101ecc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ecf:	89 f0                	mov    %esi,%eax
80101ed1:	5b                   	pop    %ebx
80101ed2:	5e                   	pop    %esi
80101ed3:	5f                   	pop    %edi
80101ed4:	5d                   	pop    %ebp
80101ed5:	c3                   	ret    
80101ed6:	8d 76 00             	lea    0x0(%esi),%esi
80101ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iput(ip);
80101ee0:	83 ec 0c             	sub    $0xc,%esp
80101ee3:	56                   	push   %esi
    return 0;
80101ee4:	31 f6                	xor    %esi,%esi
    iput(ip);
80101ee6:	e8 65 f9 ff ff       	call   80101850 <iput>
    return 0;
80101eeb:	83 c4 10             	add    $0x10,%esp
80101eee:	e9 68 ff ff ff       	jmp    80101e5b <namex+0x15b>
80101ef3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f00 <dirlink>:
{
80101f00:	55                   	push   %ebp
80101f01:	89 e5                	mov    %esp,%ebp
80101f03:	57                   	push   %edi
80101f04:	56                   	push   %esi
80101f05:	53                   	push   %ebx
80101f06:	83 ec 20             	sub    $0x20,%esp
80101f09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101f0c:	6a 00                	push   $0x0
80101f0e:	ff 75 0c             	pushl  0xc(%ebp)
80101f11:	53                   	push   %ebx
80101f12:	e8 39 fd ff ff       	call   80101c50 <dirlookup>
80101f17:	83 c4 10             	add    $0x10,%esp
80101f1a:	85 c0                	test   %eax,%eax
80101f1c:	75 67                	jne    80101f85 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f1e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101f21:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f24:	85 ff                	test   %edi,%edi
80101f26:	74 29                	je     80101f51 <dirlink+0x51>
80101f28:	31 ff                	xor    %edi,%edi
80101f2a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f2d:	eb 09                	jmp    80101f38 <dirlink+0x38>
80101f2f:	90                   	nop
80101f30:	83 c7 10             	add    $0x10,%edi
80101f33:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101f36:	73 19                	jae    80101f51 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f38:	6a 10                	push   $0x10
80101f3a:	57                   	push   %edi
80101f3b:	56                   	push   %esi
80101f3c:	53                   	push   %ebx
80101f3d:	e8 be fa ff ff       	call   80101a00 <readi>
80101f42:	83 c4 10             	add    $0x10,%esp
80101f45:	83 f8 10             	cmp    $0x10,%eax
80101f48:	75 4e                	jne    80101f98 <dirlink+0x98>
    if(de.inum == 0)
80101f4a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f4f:	75 df                	jne    80101f30 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101f51:	83 ec 04             	sub    $0x4,%esp
80101f54:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f57:	6a 0e                	push   $0xe
80101f59:	ff 75 0c             	pushl  0xc(%ebp)
80101f5c:	50                   	push   %eax
80101f5d:	e8 4e 32 00 00       	call   801051b0 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f62:	6a 10                	push   $0x10
  de.inum = inum;
80101f64:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f67:	57                   	push   %edi
80101f68:	56                   	push   %esi
80101f69:	53                   	push   %ebx
  de.inum = inum;
80101f6a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f6e:	e8 8d fb ff ff       	call   80101b00 <writei>
80101f73:	83 c4 20             	add    $0x20,%esp
80101f76:	83 f8 10             	cmp    $0x10,%eax
80101f79:	75 2a                	jne    80101fa5 <dirlink+0xa5>
  return 0;
80101f7b:	31 c0                	xor    %eax,%eax
}
80101f7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f80:	5b                   	pop    %ebx
80101f81:	5e                   	pop    %esi
80101f82:	5f                   	pop    %edi
80101f83:	5d                   	pop    %ebp
80101f84:	c3                   	ret    
    iput(ip);
80101f85:	83 ec 0c             	sub    $0xc,%esp
80101f88:	50                   	push   %eax
80101f89:	e8 c2 f8 ff ff       	call   80101850 <iput>
    return -1;
80101f8e:	83 c4 10             	add    $0x10,%esp
80101f91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f96:	eb e5                	jmp    80101f7d <dirlink+0x7d>
      panic("dirlink read");
80101f98:	83 ec 0c             	sub    $0xc,%esp
80101f9b:	68 08 7d 10 80       	push   $0x80107d08
80101fa0:	e8 eb e3 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101fa5:	83 ec 0c             	sub    $0xc,%esp
80101fa8:	68 c6 83 10 80       	push   $0x801083c6
80101fad:	e8 de e3 ff ff       	call   80100390 <panic>
80101fb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fc0 <namei>:

struct inode*
namei(char *path)
{
80101fc0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101fc1:	31 d2                	xor    %edx,%edx
{
80101fc3:	89 e5                	mov    %esp,%ebp
80101fc5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101fc8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fcb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101fce:	e8 2d fd ff ff       	call   80101d00 <namex>
}
80101fd3:	c9                   	leave  
80101fd4:	c3                   	ret    
80101fd5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fe0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101fe0:	55                   	push   %ebp
  return namex(path, 1, name);
80101fe1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101fe6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101fe8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101feb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101fee:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101fef:	e9 0c fd ff ff       	jmp    80101d00 <namex>
80101ff4:	66 90                	xchg   %ax,%ax
80101ff6:	66 90                	xchg   %ax,%ax
80101ff8:	66 90                	xchg   %ax,%ax
80101ffa:	66 90                	xchg   %ax,%ax
80101ffc:	66 90                	xchg   %ax,%ax
80101ffe:	66 90                	xchg   %ax,%ax

80102000 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102000:	55                   	push   %ebp
80102001:	89 e5                	mov    %esp,%ebp
80102003:	57                   	push   %edi
80102004:	56                   	push   %esi
80102005:	53                   	push   %ebx
80102006:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102009:	85 c0                	test   %eax,%eax
8010200b:	0f 84 b4 00 00 00    	je     801020c5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102011:	8b 70 08             	mov    0x8(%eax),%esi
80102014:	89 c3                	mov    %eax,%ebx
80102016:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010201c:	0f 87 96 00 00 00    	ja     801020b8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102022:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102027:	89 f6                	mov    %esi,%esi
80102029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102030:	89 ca                	mov    %ecx,%edx
80102032:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102033:	83 e0 c0             	and    $0xffffffc0,%eax
80102036:	3c 40                	cmp    $0x40,%al
80102038:	75 f6                	jne    80102030 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010203a:	31 ff                	xor    %edi,%edi
8010203c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102041:	89 f8                	mov    %edi,%eax
80102043:	ee                   	out    %al,(%dx)
80102044:	b8 01 00 00 00       	mov    $0x1,%eax
80102049:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010204e:	ee                   	out    %al,(%dx)
8010204f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102054:	89 f0                	mov    %esi,%eax
80102056:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102057:	89 f0                	mov    %esi,%eax
80102059:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010205e:	c1 f8 08             	sar    $0x8,%eax
80102061:	ee                   	out    %al,(%dx)
80102062:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102067:	89 f8                	mov    %edi,%eax
80102069:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010206a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010206e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102073:	c1 e0 04             	shl    $0x4,%eax
80102076:	83 e0 10             	and    $0x10,%eax
80102079:	83 c8 e0             	or     $0xffffffe0,%eax
8010207c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010207d:	f6 03 04             	testb  $0x4,(%ebx)
80102080:	75 16                	jne    80102098 <idestart+0x98>
80102082:	b8 20 00 00 00       	mov    $0x20,%eax
80102087:	89 ca                	mov    %ecx,%edx
80102089:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010208a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010208d:	5b                   	pop    %ebx
8010208e:	5e                   	pop    %esi
8010208f:	5f                   	pop    %edi
80102090:	5d                   	pop    %ebp
80102091:	c3                   	ret    
80102092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102098:	b8 30 00 00 00       	mov    $0x30,%eax
8010209d:	89 ca                	mov    %ecx,%edx
8010209f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801020a0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801020a5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801020a8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020ad:	fc                   	cld    
801020ae:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801020b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020b3:	5b                   	pop    %ebx
801020b4:	5e                   	pop    %esi
801020b5:	5f                   	pop    %edi
801020b6:	5d                   	pop    %ebp
801020b7:	c3                   	ret    
    panic("incorrect blockno");
801020b8:	83 ec 0c             	sub    $0xc,%esp
801020bb:	68 74 7d 10 80       	push   $0x80107d74
801020c0:	e8 cb e2 ff ff       	call   80100390 <panic>
    panic("idestart");
801020c5:	83 ec 0c             	sub    $0xc,%esp
801020c8:	68 6b 7d 10 80       	push   $0x80107d6b
801020cd:	e8 be e2 ff ff       	call   80100390 <panic>
801020d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020e0 <ideinit>:
{
801020e0:	55                   	push   %ebp
801020e1:	89 e5                	mov    %esp,%ebp
801020e3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801020e6:	68 86 7d 10 80       	push   $0x80107d86
801020eb:	68 a0 b5 10 80       	push   $0x8010b5a0
801020f0:	e8 db 2c 00 00       	call   80104dd0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020f5:	58                   	pop    %eax
801020f6:	a1 40 bd 14 80       	mov    0x8014bd40,%eax
801020fb:	5a                   	pop    %edx
801020fc:	83 e8 01             	sub    $0x1,%eax
801020ff:	50                   	push   %eax
80102100:	6a 0e                	push   $0xe
80102102:	e8 a9 02 00 00       	call   801023b0 <ioapicenable>
80102107:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010210a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010210f:	90                   	nop
80102110:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102111:	83 e0 c0             	and    $0xffffffc0,%eax
80102114:	3c 40                	cmp    $0x40,%al
80102116:	75 f8                	jne    80102110 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102118:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010211d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102122:	ee                   	out    %al,(%dx)
80102123:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102128:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010212d:	eb 06                	jmp    80102135 <ideinit+0x55>
8010212f:	90                   	nop
  for(i=0; i<1000; i++){
80102130:	83 e9 01             	sub    $0x1,%ecx
80102133:	74 0f                	je     80102144 <ideinit+0x64>
80102135:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102136:	84 c0                	test   %al,%al
80102138:	74 f6                	je     80102130 <ideinit+0x50>
      havedisk1 = 1;
8010213a:	c7 05 80 b5 10 80 01 	movl   $0x1,0x8010b580
80102141:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102144:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102149:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010214e:	ee                   	out    %al,(%dx)
}
8010214f:	c9                   	leave  
80102150:	c3                   	ret    
80102151:	eb 0d                	jmp    80102160 <ideintr>
80102153:	90                   	nop
80102154:	90                   	nop
80102155:	90                   	nop
80102156:	90                   	nop
80102157:	90                   	nop
80102158:	90                   	nop
80102159:	90                   	nop
8010215a:	90                   	nop
8010215b:	90                   	nop
8010215c:	90                   	nop
8010215d:	90                   	nop
8010215e:	90                   	nop
8010215f:	90                   	nop

80102160 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102160:	55                   	push   %ebp
80102161:	89 e5                	mov    %esp,%ebp
80102163:	57                   	push   %edi
80102164:	56                   	push   %esi
80102165:	53                   	push   %ebx
80102166:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102169:	68 a0 b5 10 80       	push   $0x8010b5a0
8010216e:	e8 bd 2d 00 00       	call   80104f30 <acquire>

  if((b = idequeue) == 0){
80102173:	8b 1d 84 b5 10 80    	mov    0x8010b584,%ebx
80102179:	83 c4 10             	add    $0x10,%esp
8010217c:	85 db                	test   %ebx,%ebx
8010217e:	74 63                	je     801021e3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102180:	8b 43 58             	mov    0x58(%ebx),%eax
80102183:	a3 84 b5 10 80       	mov    %eax,0x8010b584

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102188:	8b 33                	mov    (%ebx),%esi
8010218a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102190:	75 2f                	jne    801021c1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102192:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102197:	89 f6                	mov    %esi,%esi
80102199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801021a0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021a1:	89 c1                	mov    %eax,%ecx
801021a3:	83 e1 c0             	and    $0xffffffc0,%ecx
801021a6:	80 f9 40             	cmp    $0x40,%cl
801021a9:	75 f5                	jne    801021a0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801021ab:	a8 21                	test   $0x21,%al
801021ad:	75 12                	jne    801021c1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
801021af:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801021b2:	b9 80 00 00 00       	mov    $0x80,%ecx
801021b7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021bc:	fc                   	cld    
801021bd:	f3 6d                	rep insl (%dx),%es:(%edi)
801021bf:	8b 33                	mov    (%ebx),%esi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801021c1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801021c4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801021c7:	83 ce 02             	or     $0x2,%esi
801021ca:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801021cc:	53                   	push   %ebx
801021cd:	e8 1e 29 00 00       	call   80104af0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021d2:	a1 84 b5 10 80       	mov    0x8010b584,%eax
801021d7:	83 c4 10             	add    $0x10,%esp
801021da:	85 c0                	test   %eax,%eax
801021dc:	74 05                	je     801021e3 <ideintr+0x83>
    idestart(idequeue);
801021de:	e8 1d fe ff ff       	call   80102000 <idestart>
    release(&idelock);
801021e3:	83 ec 0c             	sub    $0xc,%esp
801021e6:	68 a0 b5 10 80       	push   $0x8010b5a0
801021eb:	e8 00 2e 00 00       	call   80104ff0 <release>

  release(&idelock);
}
801021f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021f3:	5b                   	pop    %ebx
801021f4:	5e                   	pop    %esi
801021f5:	5f                   	pop    %edi
801021f6:	5d                   	pop    %ebp
801021f7:	c3                   	ret    
801021f8:	90                   	nop
801021f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102200 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102200:	55                   	push   %ebp
80102201:	89 e5                	mov    %esp,%ebp
80102203:	53                   	push   %ebx
80102204:	83 ec 10             	sub    $0x10,%esp
80102207:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010220a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010220d:	50                   	push   %eax
8010220e:	e8 6d 2b 00 00       	call   80104d80 <holdingsleep>
80102213:	83 c4 10             	add    $0x10,%esp
80102216:	85 c0                	test   %eax,%eax
80102218:	0f 84 d3 00 00 00    	je     801022f1 <iderw+0xf1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010221e:	8b 03                	mov    (%ebx),%eax
80102220:	83 e0 06             	and    $0x6,%eax
80102223:	83 f8 02             	cmp    $0x2,%eax
80102226:	0f 84 b8 00 00 00    	je     801022e4 <iderw+0xe4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010222c:	8b 53 04             	mov    0x4(%ebx),%edx
8010222f:	85 d2                	test   %edx,%edx
80102231:	74 0d                	je     80102240 <iderw+0x40>
80102233:	a1 80 b5 10 80       	mov    0x8010b580,%eax
80102238:	85 c0                	test   %eax,%eax
8010223a:	0f 84 97 00 00 00    	je     801022d7 <iderw+0xd7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102240:	83 ec 0c             	sub    $0xc,%esp
80102243:	68 a0 b5 10 80       	push   $0x8010b5a0
80102248:	e8 e3 2c 00 00       	call   80104f30 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010224d:	8b 15 84 b5 10 80    	mov    0x8010b584,%edx
  b->qnext = 0;
80102253:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010225a:	83 c4 10             	add    $0x10,%esp
8010225d:	85 d2                	test   %edx,%edx
8010225f:	75 09                	jne    8010226a <iderw+0x6a>
80102261:	eb 6d                	jmp    801022d0 <iderw+0xd0>
80102263:	90                   	nop
80102264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102268:	89 c2                	mov    %eax,%edx
8010226a:	8b 42 58             	mov    0x58(%edx),%eax
8010226d:	85 c0                	test   %eax,%eax
8010226f:	75 f7                	jne    80102268 <iderw+0x68>
80102271:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102274:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102276:	39 1d 84 b5 10 80    	cmp    %ebx,0x8010b584
8010227c:	74 42                	je     801022c0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010227e:	8b 03                	mov    (%ebx),%eax
80102280:	83 e0 06             	and    $0x6,%eax
80102283:	83 f8 02             	cmp    $0x2,%eax
80102286:	74 23                	je     801022ab <iderw+0xab>
80102288:	90                   	nop
80102289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102290:	83 ec 08             	sub    $0x8,%esp
80102293:	68 a0 b5 10 80       	push   $0x8010b5a0
80102298:	53                   	push   %ebx
80102299:	e8 92 26 00 00       	call   80104930 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010229e:	8b 03                	mov    (%ebx),%eax
801022a0:	83 c4 10             	add    $0x10,%esp
801022a3:	83 e0 06             	and    $0x6,%eax
801022a6:	83 f8 02             	cmp    $0x2,%eax
801022a9:	75 e5                	jne    80102290 <iderw+0x90>
  }


  release(&idelock);
801022ab:	c7 45 08 a0 b5 10 80 	movl   $0x8010b5a0,0x8(%ebp)
}
801022b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801022b5:	c9                   	leave  
  release(&idelock);
801022b6:	e9 35 2d 00 00       	jmp    80104ff0 <release>
801022bb:	90                   	nop
801022bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801022c0:	89 d8                	mov    %ebx,%eax
801022c2:	e8 39 fd ff ff       	call   80102000 <idestart>
801022c7:	eb b5                	jmp    8010227e <iderw+0x7e>
801022c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022d0:	ba 84 b5 10 80       	mov    $0x8010b584,%edx
801022d5:	eb 9d                	jmp    80102274 <iderw+0x74>
    panic("iderw: ide disk 1 not present");
801022d7:	83 ec 0c             	sub    $0xc,%esp
801022da:	68 b5 7d 10 80       	push   $0x80107db5
801022df:	e8 ac e0 ff ff       	call   80100390 <panic>
    panic("iderw: nothing to do");
801022e4:	83 ec 0c             	sub    $0xc,%esp
801022e7:	68 a0 7d 10 80       	push   $0x80107da0
801022ec:	e8 9f e0 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
801022f1:	83 ec 0c             	sub    $0xc,%esp
801022f4:	68 8a 7d 10 80       	push   $0x80107d8a
801022f9:	e8 92 e0 ff ff       	call   80100390 <panic>
801022fe:	66 90                	xchg   %ax,%ax

80102300 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102300:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102301:	c7 05 54 36 11 80 00 	movl   $0xfec00000,0x80113654
80102308:	00 c0 fe 
{
8010230b:	89 e5                	mov    %esp,%ebp
8010230d:	56                   	push   %esi
8010230e:	53                   	push   %ebx
  ioapic->reg = reg;
8010230f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102316:	00 00 00 
  return ioapic->data;
80102319:	8b 15 54 36 11 80    	mov    0x80113654,%edx
8010231f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102322:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102328:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010232e:	0f b6 15 a0 b7 14 80 	movzbl 0x8014b7a0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102335:	c1 ee 10             	shr    $0x10,%esi
80102338:	89 f0                	mov    %esi,%eax
8010233a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010233d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102340:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102343:	39 c2                	cmp    %eax,%edx
80102345:	74 16                	je     8010235d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102347:	83 ec 0c             	sub    $0xc,%esp
8010234a:	68 d4 7d 10 80       	push   $0x80107dd4
8010234f:	e8 5c e3 ff ff       	call   801006b0 <cprintf>
80102354:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
8010235a:	83 c4 10             	add    $0x10,%esp
8010235d:	83 c6 21             	add    $0x21,%esi
{
80102360:	ba 10 00 00 00       	mov    $0x10,%edx
80102365:	b8 20 00 00 00       	mov    $0x20,%eax
8010236a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102370:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102372:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102374:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
8010237a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010237d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102383:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102386:	8d 5a 01             	lea    0x1(%edx),%ebx
80102389:	83 c2 02             	add    $0x2,%edx
8010238c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010238e:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
80102394:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010239b:	39 f0                	cmp    %esi,%eax
8010239d:	75 d1                	jne    80102370 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010239f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023a2:	5b                   	pop    %ebx
801023a3:	5e                   	pop    %esi
801023a4:	5d                   	pop    %ebp
801023a5:	c3                   	ret    
801023a6:	8d 76 00             	lea    0x0(%esi),%esi
801023a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801023b0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801023b0:	55                   	push   %ebp
  ioapic->reg = reg;
801023b1:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
{
801023b7:	89 e5                	mov    %esp,%ebp
801023b9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801023bc:	8d 50 20             	lea    0x20(%eax),%edx
801023bf:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801023c3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023c5:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023cb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801023ce:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801023d4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023d6:	a1 54 36 11 80       	mov    0x80113654,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023db:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801023de:	89 50 10             	mov    %edx,0x10(%eax)
}
801023e1:	5d                   	pop    %ebp
801023e2:	c3                   	ret    
801023e3:	66 90                	xchg   %ax,%ax
801023e5:	66 90                	xchg   %ax,%ax
801023e7:	66 90                	xchg   %ax,%ax
801023e9:	66 90                	xchg   %ax,%ax
801023eb:	66 90                	xchg   %ax,%ax
801023ed:	66 90                	xchg   %ax,%ax
801023ef:	90                   	nop

801023f0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	56                   	push   %esi
801023f4:	8b 75 08             	mov    0x8(%ebp),%esi
801023f7:	53                   	push   %ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801023f8:	f7 c6 ff 0f 00 00    	test   $0xfff,%esi
801023fe:	0f 85 b9 00 00 00    	jne    801024bd <kfree+0xcd>
80102404:	81 fe 08 e9 14 80    	cmp    $0x8014e908,%esi
8010240a:	0f 82 ad 00 00 00    	jb     801024bd <kfree+0xcd>
80102410:	8d 9e 00 00 00 80    	lea    -0x80000000(%esi),%ebx
80102416:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
8010241c:	0f 87 9b 00 00 00    	ja     801024bd <kfree+0xcd>
    panic("kfree");

  if(kmem.use_lock)
80102422:	8b 15 94 36 11 80    	mov    0x80113694,%edx
80102428:	85 d2                	test   %edx,%edx
8010242a:	75 7c                	jne    801024a8 <kfree+0xb8>
    acquire(&kmem.lock);
  r = (struct run*)v;
  // decrement page reference count upon freeing initially
  if (kmem.pageRefCount[V2P(v) >> PGSHIFT] > 0)
8010242c:	c1 eb 0c             	shr    $0xc,%ebx
8010242f:	83 c3 10             	add    $0x10,%ebx
80102432:	8b 04 9d 60 36 11 80 	mov    -0x7feec9a0(,%ebx,4),%eax
80102439:	85 c0                	test   %eax,%eax
8010243b:	74 23                	je     80102460 <kfree+0x70>
    kmem.pageRefCount[V2P(v) >> PGSHIFT]--;
8010243d:	83 e8 01             	sub    $0x1,%eax
80102440:	89 04 9d 60 36 11 80 	mov    %eax,-0x7feec9a0(,%ebx,4)
  // free physical page if nothing references it
  if (kmem.pageRefCount[V2P(v) >> PGSHIFT] == 0) {
80102447:	74 17                	je     80102460 <kfree+0x70>
    memset(v, 1, PGSIZE); // Fill with junk to catch dangling refs.
    r->next = kmem.freelist;
    kmem.freelist = r;
    kmem.numFreePages++;
  }
  if(kmem.use_lock)
80102449:	a1 94 36 11 80       	mov    0x80113694,%eax
8010244e:	85 c0                	test   %eax,%eax
80102450:	75 3e                	jne    80102490 <kfree+0xa0>
    release(&kmem.lock);
}
80102452:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102455:	5b                   	pop    %ebx
80102456:	5e                   	pop    %esi
80102457:	5d                   	pop    %ebp
80102458:	c3                   	ret    
80102459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    memset(v, 1, PGSIZE); // Fill with junk to catch dangling refs.
80102460:	83 ec 04             	sub    $0x4,%esp
80102463:	68 00 10 00 00       	push   $0x1000
80102468:	6a 01                	push   $0x1
8010246a:	56                   	push   %esi
8010246b:	e8 d0 2b 00 00       	call   80105040 <memset>
    r->next = kmem.freelist;
80102470:	a1 98 36 11 80       	mov    0x80113698,%eax
    kmem.numFreePages++;
80102475:	83 c4 10             	add    $0x10,%esp
    r->next = kmem.freelist;
80102478:	89 06                	mov    %eax,(%esi)
  if(kmem.use_lock)
8010247a:	a1 94 36 11 80       	mov    0x80113694,%eax
    kmem.freelist = r;
8010247f:	89 35 98 36 11 80    	mov    %esi,0x80113698
    kmem.numFreePages++;
80102485:	83 05 9c 36 11 80 01 	addl   $0x1,0x8011369c
  if(kmem.use_lock)
8010248c:	85 c0                	test   %eax,%eax
8010248e:	74 c2                	je     80102452 <kfree+0x62>
    release(&kmem.lock);
80102490:	c7 45 08 60 36 11 80 	movl   $0x80113660,0x8(%ebp)
}
80102497:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010249a:	5b                   	pop    %ebx
8010249b:	5e                   	pop    %esi
8010249c:	5d                   	pop    %ebp
    release(&kmem.lock);
8010249d:	e9 4e 2b 00 00       	jmp    80104ff0 <release>
801024a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
801024a8:	83 ec 0c             	sub    $0xc,%esp
801024ab:	68 60 36 11 80       	push   $0x80113660
801024b0:	e8 7b 2a 00 00       	call   80104f30 <acquire>
801024b5:	83 c4 10             	add    $0x10,%esp
801024b8:	e9 6f ff ff ff       	jmp    8010242c <kfree+0x3c>
    panic("kfree");
801024bd:	83 ec 0c             	sub    $0xc,%esp
801024c0:	68 06 7e 10 80       	push   $0x80107e06
801024c5:	e8 c6 de ff ff       	call   80100390 <panic>
801024ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801024d0 <freerange>:
{
801024d0:	55                   	push   %ebp
801024d1:	89 e5                	mov    %esp,%ebp
801024d3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801024d4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801024d7:	8b 75 0c             	mov    0xc(%ebp),%esi
801024da:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801024db:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024e1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE) {
801024e7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024ed:	39 de                	cmp    %ebx,%esi
801024ef:	72 37                	jb     80102528 <freerange+0x58>
801024f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kmem.pageRefCount[V2P(p) >> PGSHIFT] = 0;
801024f8:	8d 83 00 f0 ff 7f    	lea    0x7ffff000(%ebx),%eax
    kfree(p);
801024fe:	83 ec 0c             	sub    $0xc,%esp
    kmem.pageRefCount[V2P(p) >> PGSHIFT] = 0;
80102501:	c1 e8 0c             	shr    $0xc,%eax
80102504:	c7 04 85 a0 36 11 80 	movl   $0x0,-0x7feec960(,%eax,4)
8010250b:	00 00 00 00 
    kfree(p);
8010250f:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE) {
80102515:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010251b:	50                   	push   %eax
8010251c:	e8 cf fe ff ff       	call   801023f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE) {
80102521:	83 c4 10             	add    $0x10,%esp
80102524:	39 f3                	cmp    %esi,%ebx
80102526:	76 d0                	jbe    801024f8 <freerange+0x28>
}
80102528:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010252b:	5b                   	pop    %ebx
8010252c:	5e                   	pop    %esi
8010252d:	5d                   	pop    %ebp
8010252e:	c3                   	ret    
8010252f:	90                   	nop

80102530 <kinit1>:
{
80102530:	55                   	push   %ebp
80102531:	89 e5                	mov    %esp,%ebp
80102533:	56                   	push   %esi
80102534:	53                   	push   %ebx
80102535:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102538:	83 ec 08             	sub    $0x8,%esp
8010253b:	68 0c 7e 10 80       	push   $0x80107e0c
80102540:	68 60 36 11 80       	push   $0x80113660
80102545:	e8 86 28 00 00       	call   80104dd0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010254a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE) {
8010254d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102550:	c7 05 94 36 11 80 00 	movl   $0x0,0x80113694
80102557:	00 00 00 
  kmem.numFreePages = 0;
8010255a:	c7 05 9c 36 11 80 00 	movl   $0x0,0x8011369c
80102561:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102564:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
8010256a:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE) {
80102570:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102576:	39 de                	cmp    %ebx,%esi
80102578:	72 36                	jb     801025b0 <kinit1+0x80>
8010257a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    kmem.pageRefCount[V2P(p) >> PGSHIFT] = 0;
80102580:	8d 83 00 f0 ff 7f    	lea    0x7ffff000(%ebx),%eax
    kfree(p);
80102586:	83 ec 0c             	sub    $0xc,%esp
    kmem.pageRefCount[V2P(p) >> PGSHIFT] = 0;
80102589:	c1 e8 0c             	shr    $0xc,%eax
8010258c:	c7 04 85 a0 36 11 80 	movl   $0x0,-0x7feec960(,%eax,4)
80102593:	00 00 00 00 
    kfree(p);
80102597:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE) {
8010259d:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025a3:	50                   	push   %eax
801025a4:	e8 47 fe ff ff       	call   801023f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE) {
801025a9:	83 c4 10             	add    $0x10,%esp
801025ac:	39 de                	cmp    %ebx,%esi
801025ae:	73 d0                	jae    80102580 <kinit1+0x50>
}
801025b0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025b3:	5b                   	pop    %ebx
801025b4:	5e                   	pop    %esi
801025b5:	5d                   	pop    %ebp
801025b6:	c3                   	ret    
801025b7:	89 f6                	mov    %esi,%esi
801025b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025c0 <kinit2>:
{
801025c0:	55                   	push   %ebp
801025c1:	89 e5                	mov    %esp,%ebp
801025c3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801025c4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025c7:	8b 75 0c             	mov    0xc(%ebp),%esi
801025ca:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE) {
801025d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025dd:	39 de                	cmp    %ebx,%esi
801025df:	72 37                	jb     80102618 <kinit2+0x58>
801025e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kmem.pageRefCount[V2P(p) >> PGSHIFT] = 0;
801025e8:	8d 83 00 f0 ff 7f    	lea    0x7ffff000(%ebx),%eax
    kfree(p);
801025ee:	83 ec 0c             	sub    $0xc,%esp
    kmem.pageRefCount[V2P(p) >> PGSHIFT] = 0;
801025f1:	c1 e8 0c             	shr    $0xc,%eax
801025f4:	c7 04 85 a0 36 11 80 	movl   $0x0,-0x7feec960(,%eax,4)
801025fb:	00 00 00 00 
    kfree(p);
801025ff:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE) {
80102605:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010260b:	50                   	push   %eax
8010260c:	e8 df fd ff ff       	call   801023f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE) {
80102611:	83 c4 10             	add    $0x10,%esp
80102614:	39 de                	cmp    %ebx,%esi
80102616:	73 d0                	jae    801025e8 <kinit2+0x28>
  kmem.use_lock = 1;
80102618:	c7 05 94 36 11 80 01 	movl   $0x1,0x80113694
8010261f:	00 00 00 
}
80102622:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102625:	5b                   	pop    %ebx
80102626:	5e                   	pop    %esi
80102627:	5d                   	pop    %ebp
80102628:	c3                   	ret    
80102629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102630 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	53                   	push   %ebx
80102634:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102637:	a1 94 36 11 80       	mov    0x80113694,%eax
8010263c:	85 c0                	test   %eax,%eax
8010263e:	75 60                	jne    801026a0 <kalloc+0x70>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102640:	8b 1d 98 36 11 80    	mov    0x80113698,%ebx
  if(r) {
80102646:	85 db                	test   %ebx,%ebx
80102648:	74 27                	je     80102671 <kalloc+0x41>
    kmem.freelist = r->next;
8010264a:	8b 13                	mov    (%ebx),%edx
    kmem.pageRefCount[V2P((char*)r) >> PGSHIFT] = 1;
    kmem.numFreePages--;
8010264c:	83 2d 9c 36 11 80 01 	subl   $0x1,0x8011369c
    kmem.freelist = r->next;
80102653:	89 15 98 36 11 80    	mov    %edx,0x80113698
    kmem.pageRefCount[V2P((char*)r) >> PGSHIFT] = 1;
80102659:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
8010265f:	c1 ea 0c             	shr    $0xc,%edx
80102662:	c7 04 95 a0 36 11 80 	movl   $0x1,-0x7feec960(,%edx,4)
80102669:	01 00 00 00 
  }
  if(kmem.use_lock)
8010266d:	85 c0                	test   %eax,%eax
8010266f:	75 0f                	jne    80102680 <kalloc+0x50>
    release(&kmem.lock);
  return (char*)r;
}
80102671:	89 d8                	mov    %ebx,%eax
80102673:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102676:	c9                   	leave  
80102677:	c3                   	ret    
80102678:	90                   	nop
80102679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&kmem.lock);
80102680:	83 ec 0c             	sub    $0xc,%esp
80102683:	68 60 36 11 80       	push   $0x80113660
80102688:	e8 63 29 00 00       	call   80104ff0 <release>
}
8010268d:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
8010268f:	83 c4 10             	add    $0x10,%esp
}
80102692:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102695:	c9                   	leave  
80102696:	c3                   	ret    
80102697:	89 f6                	mov    %esi,%esi
80102699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    acquire(&kmem.lock);
801026a0:	83 ec 0c             	sub    $0xc,%esp
801026a3:	68 60 36 11 80       	push   $0x80113660
801026a8:	e8 83 28 00 00       	call   80104f30 <acquire>
  r = kmem.freelist;
801026ad:	8b 1d 98 36 11 80    	mov    0x80113698,%ebx
  if(r) {
801026b3:	83 c4 10             	add    $0x10,%esp
801026b6:	a1 94 36 11 80       	mov    0x80113694,%eax
801026bb:	85 db                	test   %ebx,%ebx
801026bd:	75 8b                	jne    8010264a <kalloc+0x1a>
801026bf:	eb ac                	jmp    8010266d <kalloc+0x3d>
801026c1:	eb 0d                	jmp    801026d0 <incref>
801026c3:	90                   	nop
801026c4:	90                   	nop
801026c5:	90                   	nop
801026c6:	90                   	nop
801026c7:	90                   	nop
801026c8:	90                   	nop
801026c9:	90                   	nop
801026ca:	90                   	nop
801026cb:	90                   	nop
801026cc:	90                   	nop
801026cd:	90                   	nop
801026ce:	90                   	nop
801026cf:	90                   	nop

801026d0 <incref>:

void incref(uint pa) {
801026d0:	55                   	push   %ebp
801026d1:	89 e5                	mov    %esp,%ebp
801026d3:	53                   	push   %ebx
801026d4:	83 ec 04             	sub    $0x4,%esp
801026d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (pa >= PHYSTOP || pa < (uint)V2P(end))
801026da:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
801026e0:	77 5a                	ja     8010273c <incref+0x6c>
801026e2:	81 fb 08 e9 14 00    	cmp    $0x14e908,%ebx
801026e8:	72 52                	jb     8010273c <incref+0x6c>
    panic("incref: invalid physical address");

  if(kmem.use_lock)
801026ea:	8b 15 94 36 11 80    	mov    0x80113694,%edx
801026f0:	85 d2                	test   %edx,%edx
801026f2:	75 14                	jne    80102708 <incref+0x38>
    acquire(&kmem.lock);
  kmem.pageRefCount[pa >> PGSHIFT]++;
801026f4:	c1 eb 0c             	shr    $0xc,%ebx
801026f7:	83 04 9d a0 36 11 80 	addl   $0x1,-0x7feec960(,%ebx,4)
801026fe:	01 
  if(kmem.use_lock)
    release(&kmem.lock);
}
801026ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102702:	c9                   	leave  
80102703:	c3                   	ret    
80102704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102708:	83 ec 0c             	sub    $0xc,%esp
  kmem.pageRefCount[pa >> PGSHIFT]++;
8010270b:	c1 eb 0c             	shr    $0xc,%ebx
    acquire(&kmem.lock);
8010270e:	68 60 36 11 80       	push   $0x80113660
80102713:	e8 18 28 00 00       	call   80104f30 <acquire>
  if(kmem.use_lock)
80102718:	a1 94 36 11 80       	mov    0x80113694,%eax
  kmem.pageRefCount[pa >> PGSHIFT]++;
8010271d:	83 04 9d a0 36 11 80 	addl   $0x1,-0x7feec960(,%ebx,4)
80102724:	01 
  if(kmem.use_lock)
80102725:	83 c4 10             	add    $0x10,%esp
80102728:	85 c0                	test   %eax,%eax
8010272a:	74 d3                	je     801026ff <incref+0x2f>
    release(&kmem.lock);
8010272c:	c7 45 08 60 36 11 80 	movl   $0x80113660,0x8(%ebp)
}
80102733:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102736:	c9                   	leave  
    release(&kmem.lock);
80102737:	e9 b4 28 00 00       	jmp    80104ff0 <release>
    panic("incref: invalid physical address");
8010273c:	83 ec 0c             	sub    $0xc,%esp
8010273f:	68 14 7e 10 80       	push   $0x80107e14
80102744:	e8 47 dc ff ff       	call   80100390 <panic>
80102749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102750 <decref>:
void decref(uint pa) {
80102750:	55                   	push   %ebp
80102751:	89 e5                	mov    %esp,%ebp
80102753:	53                   	push   %ebx
80102754:	83 ec 04             	sub    $0x4,%esp
80102757:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (pa >= PHYSTOP || pa < (uint)V2P(end))
8010275a:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102760:	77 5a                	ja     801027bc <decref+0x6c>
80102762:	81 fb 08 e9 14 00    	cmp    $0x14e908,%ebx
80102768:	72 52                	jb     801027bc <decref+0x6c>
    panic("decref: invalid physical address");

  if(kmem.use_lock)
8010276a:	8b 15 94 36 11 80    	mov    0x80113694,%edx
80102770:	85 d2                	test   %edx,%edx
80102772:	75 14                	jne    80102788 <decref+0x38>
    acquire(&kmem.lock);
  kmem.pageRefCount[pa >> PGSHIFT]--;
80102774:	c1 eb 0c             	shr    $0xc,%ebx
80102777:	83 2c 9d a0 36 11 80 	subl   $0x1,-0x7feec960(,%ebx,4)
8010277e:	01 
  if(kmem.use_lock)
    release(&kmem.lock);
}
8010277f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102782:	c9                   	leave  
80102783:	c3                   	ret    
80102784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102788:	83 ec 0c             	sub    $0xc,%esp
  kmem.pageRefCount[pa >> PGSHIFT]--;
8010278b:	c1 eb 0c             	shr    $0xc,%ebx
    acquire(&kmem.lock);
8010278e:	68 60 36 11 80       	push   $0x80113660
80102793:	e8 98 27 00 00       	call   80104f30 <acquire>
  if(kmem.use_lock)
80102798:	a1 94 36 11 80       	mov    0x80113694,%eax
  kmem.pageRefCount[pa >> PGSHIFT]--;
8010279d:	83 2c 9d a0 36 11 80 	subl   $0x1,-0x7feec960(,%ebx,4)
801027a4:	01 
  if(kmem.use_lock)
801027a5:	83 c4 10             	add    $0x10,%esp
801027a8:	85 c0                	test   %eax,%eax
801027aa:	74 d3                	je     8010277f <decref+0x2f>
    release(&kmem.lock);
801027ac:	c7 45 08 60 36 11 80 	movl   $0x80113660,0x8(%ebp)
}
801027b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027b6:	c9                   	leave  
    release(&kmem.lock);
801027b7:	e9 34 28 00 00       	jmp    80104ff0 <release>
    panic("decref: invalid physical address");
801027bc:	83 ec 0c             	sub    $0xc,%esp
801027bf:	68 38 7e 10 80       	push   $0x80107e38
801027c4:	e8 c7 db ff ff       	call   80100390 <panic>
801027c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801027d0 <getRefCount>:
uint getRefCount(uint pa) {
801027d0:	55                   	push   %ebp
801027d1:	89 e5                	mov    %esp,%ebp
801027d3:	53                   	push   %ebx
801027d4:	83 ec 04             	sub    $0x4,%esp
801027d7:	8b 45 08             	mov    0x8(%ebp),%eax
  if (pa >= PHYSTOP || pa < (uint)V2P(end))
801027da:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801027df:	77 5e                	ja     8010283f <getRefCount+0x6f>
801027e1:	3d 08 e9 14 00       	cmp    $0x14e908,%eax
801027e6:	72 57                	jb     8010283f <getRefCount+0x6f>
    panic("getRefCount: invalid physical address");

  uint count;
  if(kmem.use_lock)
801027e8:	8b 15 94 36 11 80    	mov    0x80113694,%edx
801027ee:	c1 e8 0c             	shr    $0xc,%eax
801027f1:	89 c3                	mov    %eax,%ebx
801027f3:	85 d2                	test   %edx,%edx
801027f5:	75 11                	jne    80102808 <getRefCount+0x38>
    acquire(&kmem.lock);
  count = kmem.pageRefCount[pa >> PGSHIFT];
801027f7:	8b 1c 85 a0 36 11 80 	mov    -0x7feec960(,%eax,4),%ebx
  if(kmem.use_lock)
    release(&kmem.lock);
  return count;
}
801027fe:	89 d8                	mov    %ebx,%eax
80102800:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102803:	c9                   	leave  
80102804:	c3                   	ret    
80102805:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
80102808:	83 ec 0c             	sub    $0xc,%esp
8010280b:	68 60 36 11 80       	push   $0x80113660
80102810:	e8 1b 27 00 00       	call   80104f30 <acquire>
  if(kmem.use_lock)
80102815:	a1 94 36 11 80       	mov    0x80113694,%eax
  count = kmem.pageRefCount[pa >> PGSHIFT];
8010281a:	8b 1c 9d a0 36 11 80 	mov    -0x7feec960(,%ebx,4),%ebx
  if(kmem.use_lock)
80102821:	83 c4 10             	add    $0x10,%esp
80102824:	85 c0                	test   %eax,%eax
80102826:	74 d6                	je     801027fe <getRefCount+0x2e>
    release(&kmem.lock);
80102828:	83 ec 0c             	sub    $0xc,%esp
8010282b:	68 60 36 11 80       	push   $0x80113660
80102830:	e8 bb 27 00 00       	call   80104ff0 <release>
}
80102835:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
80102837:	83 c4 10             	add    $0x10,%esp
}
8010283a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010283d:	c9                   	leave  
8010283e:	c3                   	ret    
    panic("getRefCount: invalid physical address");
8010283f:	83 ec 0c             	sub    $0xc,%esp
80102842:	68 5c 7e 10 80       	push   $0x80107e5c
80102847:	e8 44 db ff ff       	call   80100390 <panic>
8010284c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102850 <numFreePages>:

int numFreePages() {
80102850:	55                   	push   %ebp
80102851:	89 e5                	mov    %esp,%ebp
80102853:	53                   	push   %ebx
80102854:	83 ec 04             	sub    $0x4,%esp
  int num;
  if(kmem.use_lock)
80102857:	8b 15 94 36 11 80    	mov    0x80113694,%edx
    acquire(&kmem.lock);
  num = kmem.numFreePages;
8010285d:	8b 1d 9c 36 11 80    	mov    0x8011369c,%ebx
  if(kmem.use_lock)
80102863:	85 d2                	test   %edx,%edx
80102865:	75 09                	jne    80102870 <numFreePages+0x20>
  if(kmem.use_lock)
    release(&kmem.lock);
  return num;
}
80102867:	89 d8                	mov    %ebx,%eax
80102869:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010286c:	c9                   	leave  
8010286d:	c3                   	ret    
8010286e:	66 90                	xchg   %ax,%ax
    acquire(&kmem.lock);
80102870:	83 ec 0c             	sub    $0xc,%esp
80102873:	68 60 36 11 80       	push   $0x80113660
80102878:	e8 b3 26 00 00       	call   80104f30 <acquire>
  if(kmem.use_lock)
8010287d:	a1 94 36 11 80       	mov    0x80113694,%eax
  num = kmem.numFreePages;
80102882:	8b 1d 9c 36 11 80    	mov    0x8011369c,%ebx
  if(kmem.use_lock)
80102888:	83 c4 10             	add    $0x10,%esp
8010288b:	85 c0                	test   %eax,%eax
8010288d:	74 d8                	je     80102867 <numFreePages+0x17>
    release(&kmem.lock);
8010288f:	83 ec 0c             	sub    $0xc,%esp
80102892:	68 60 36 11 80       	push   $0x80113660
80102897:	e8 54 27 00 00       	call   80104ff0 <release>
}
8010289c:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
8010289e:	83 c4 10             	add    $0x10,%esp
}
801028a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028a4:	c9                   	leave  
801028a5:	c3                   	ret    
801028a6:	66 90                	xchg   %ax,%ax
801028a8:	66 90                	xchg   %ax,%ax
801028aa:	66 90                	xchg   %ax,%ax
801028ac:	66 90                	xchg   %ax,%ax
801028ae:	66 90                	xchg   %ax,%ax

801028b0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028b0:	ba 64 00 00 00       	mov    $0x64,%edx
801028b5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801028b6:	a8 01                	test   $0x1,%al
801028b8:	0f 84 c2 00 00 00    	je     80102980 <kbdgetc+0xd0>
{
801028be:	55                   	push   %ebp
801028bf:	ba 60 00 00 00       	mov    $0x60,%edx
801028c4:	89 e5                	mov    %esp,%ebp
801028c6:	53                   	push   %ebx
801028c7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801028c8:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
801028cb:	8b 1d d4 b5 10 80    	mov    0x8010b5d4,%ebx
801028d1:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801028d7:	74 57                	je     80102930 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801028d9:	89 d9                	mov    %ebx,%ecx
801028db:	83 e1 40             	and    $0x40,%ecx
801028de:	84 c0                	test   %al,%al
801028e0:	78 5e                	js     80102940 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801028e2:	85 c9                	test   %ecx,%ecx
801028e4:	74 09                	je     801028ef <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801028e6:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801028e9:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
801028ec:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
801028ef:	0f b6 8a c0 7f 10 80 	movzbl -0x7fef8040(%edx),%ecx
  shift ^= togglecode[data];
801028f6:	0f b6 82 c0 7e 10 80 	movzbl -0x7fef8140(%edx),%eax
  shift |= shiftcode[data];
801028fd:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
801028ff:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102901:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102903:	89 0d d4 b5 10 80    	mov    %ecx,0x8010b5d4
  c = charcode[shift & (CTL | SHIFT)][data];
80102909:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010290c:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
8010290f:	8b 04 85 a0 7e 10 80 	mov    -0x7fef8160(,%eax,4),%eax
80102916:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010291a:	74 0b                	je     80102927 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
8010291c:	8d 50 9f             	lea    -0x61(%eax),%edx
8010291f:	83 fa 19             	cmp    $0x19,%edx
80102922:	77 44                	ja     80102968 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102924:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102927:	5b                   	pop    %ebx
80102928:	5d                   	pop    %ebp
80102929:	c3                   	ret    
8010292a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    shift |= E0ESC;
80102930:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102933:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102935:	89 1d d4 b5 10 80    	mov    %ebx,0x8010b5d4
}
8010293b:	5b                   	pop    %ebx
8010293c:	5d                   	pop    %ebp
8010293d:	c3                   	ret    
8010293e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102940:	83 e0 7f             	and    $0x7f,%eax
80102943:	85 c9                	test   %ecx,%ecx
80102945:	0f 44 d0             	cmove  %eax,%edx
    return 0;
80102948:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010294a:	0f b6 8a c0 7f 10 80 	movzbl -0x7fef8040(%edx),%ecx
80102951:	83 c9 40             	or     $0x40,%ecx
80102954:	0f b6 c9             	movzbl %cl,%ecx
80102957:	f7 d1                	not    %ecx
80102959:	21 d9                	and    %ebx,%ecx
}
8010295b:	5b                   	pop    %ebx
8010295c:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
8010295d:	89 0d d4 b5 10 80    	mov    %ecx,0x8010b5d4
}
80102963:	c3                   	ret    
80102964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102968:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010296b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010296e:	5b                   	pop    %ebx
8010296f:	5d                   	pop    %ebp
      c += 'a' - 'A';
80102970:	83 f9 1a             	cmp    $0x1a,%ecx
80102973:	0f 42 c2             	cmovb  %edx,%eax
}
80102976:	c3                   	ret    
80102977:	89 f6                	mov    %esi,%esi
80102979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102980:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102985:	c3                   	ret    
80102986:	8d 76 00             	lea    0x0(%esi),%esi
80102989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102990 <kbdintr>:

void
kbdintr(void)
{
80102990:	55                   	push   %ebp
80102991:	89 e5                	mov    %esp,%ebp
80102993:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102996:	68 b0 28 10 80       	push   $0x801028b0
8010299b:	e8 c0 de ff ff       	call   80100860 <consoleintr>
}
801029a0:	83 c4 10             	add    $0x10,%esp
801029a3:	c9                   	leave  
801029a4:	c3                   	ret    
801029a5:	66 90                	xchg   %ax,%ax
801029a7:	66 90                	xchg   %ax,%ax
801029a9:	66 90                	xchg   %ax,%ax
801029ab:	66 90                	xchg   %ax,%ax
801029ad:	66 90                	xchg   %ax,%ax
801029af:	90                   	nop

801029b0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801029b0:	a1 a0 b6 14 80       	mov    0x8014b6a0,%eax
801029b5:	85 c0                	test   %eax,%eax
801029b7:	0f 84 cb 00 00 00    	je     80102a88 <lapicinit+0xd8>
  lapic[index] = value;
801029bd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801029c4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029c7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029ca:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801029d1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029d4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029d7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801029de:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801029e1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029e4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801029eb:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801029ee:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029f1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801029f8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801029fb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029fe:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102a05:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a08:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102a0b:	8b 50 30             	mov    0x30(%eax),%edx
80102a0e:	c1 ea 10             	shr    $0x10,%edx
80102a11:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102a17:	75 77                	jne    80102a90 <lapicinit+0xe0>
  lapic[index] = value;
80102a19:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102a20:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a23:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a26:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a2d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a30:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a33:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a3a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a3d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a40:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102a47:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a4a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a4d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102a54:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a57:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a5a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102a61:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102a64:	8b 50 20             	mov    0x20(%eax),%edx
80102a67:	89 f6                	mov    %esi,%esi
80102a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102a70:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102a76:	80 e6 10             	and    $0x10,%dh
80102a79:	75 f5                	jne    80102a70 <lapicinit+0xc0>
  lapic[index] = value;
80102a7b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102a82:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a85:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102a88:	c3                   	ret    
80102a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102a90:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102a97:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a9a:	8b 50 20             	mov    0x20(%eax),%edx
80102a9d:	e9 77 ff ff ff       	jmp    80102a19 <lapicinit+0x69>
80102aa2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ab0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102ab0:	a1 a0 b6 14 80       	mov    0x8014b6a0,%eax
80102ab5:	85 c0                	test   %eax,%eax
80102ab7:	74 07                	je     80102ac0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102ab9:	8b 40 20             	mov    0x20(%eax),%eax
80102abc:	c1 e8 18             	shr    $0x18,%eax
80102abf:	c3                   	ret    
    return 0;
80102ac0:	31 c0                	xor    %eax,%eax
}
80102ac2:	c3                   	ret    
80102ac3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ad0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102ad0:	a1 a0 b6 14 80       	mov    0x8014b6a0,%eax
80102ad5:	85 c0                	test   %eax,%eax
80102ad7:	74 0d                	je     80102ae6 <lapiceoi+0x16>
  lapic[index] = value;
80102ad9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102ae0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ae3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102ae6:	c3                   	ret    
80102ae7:	89 f6                	mov    %esi,%esi
80102ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102af0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102af0:	c3                   	ret    
80102af1:	eb 0d                	jmp    80102b00 <lapicstartap>
80102af3:	90                   	nop
80102af4:	90                   	nop
80102af5:	90                   	nop
80102af6:	90                   	nop
80102af7:	90                   	nop
80102af8:	90                   	nop
80102af9:	90                   	nop
80102afa:	90                   	nop
80102afb:	90                   	nop
80102afc:	90                   	nop
80102afd:	90                   	nop
80102afe:	90                   	nop
80102aff:	90                   	nop

80102b00 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102b00:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b01:	b8 0f 00 00 00       	mov    $0xf,%eax
80102b06:	ba 70 00 00 00       	mov    $0x70,%edx
80102b0b:	89 e5                	mov    %esp,%ebp
80102b0d:	53                   	push   %ebx
80102b0e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102b11:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102b14:	ee                   	out    %al,(%dx)
80102b15:	b8 0a 00 00 00       	mov    $0xa,%eax
80102b1a:	ba 71 00 00 00       	mov    $0x71,%edx
80102b1f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102b20:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102b22:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102b25:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102b2b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b2d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102b30:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102b32:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b35:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102b38:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102b3e:	a1 a0 b6 14 80       	mov    0x8014b6a0,%eax
80102b43:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b49:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b4c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102b53:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b56:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b59:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102b60:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b63:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b66:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b6c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b6f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b75:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b78:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b7e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b81:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
    microdelay(200);
  }
}
80102b87:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102b88:	8b 40 20             	mov    0x20(%eax),%eax
}
80102b8b:	5d                   	pop    %ebp
80102b8c:	c3                   	ret    
80102b8d:	8d 76 00             	lea    0x0(%esi),%esi

80102b90 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102b90:	55                   	push   %ebp
80102b91:	b8 0b 00 00 00       	mov    $0xb,%eax
80102b96:	ba 70 00 00 00       	mov    $0x70,%edx
80102b9b:	89 e5                	mov    %esp,%ebp
80102b9d:	57                   	push   %edi
80102b9e:	56                   	push   %esi
80102b9f:	53                   	push   %ebx
80102ba0:	83 ec 4c             	sub    $0x4c,%esp
80102ba3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ba4:	ba 71 00 00 00       	mov    $0x71,%edx
80102ba9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102baa:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bad:	bb 70 00 00 00       	mov    $0x70,%ebx
80102bb2:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102bb5:	8d 76 00             	lea    0x0(%esi),%esi
80102bb8:	31 c0                	xor    %eax,%eax
80102bba:	89 da                	mov    %ebx,%edx
80102bbc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bbd:	b9 71 00 00 00       	mov    $0x71,%ecx
80102bc2:	89 ca                	mov    %ecx,%edx
80102bc4:	ec                   	in     (%dx),%al
80102bc5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bc8:	89 da                	mov    %ebx,%edx
80102bca:	b8 02 00 00 00       	mov    $0x2,%eax
80102bcf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bd0:	89 ca                	mov    %ecx,%edx
80102bd2:	ec                   	in     (%dx),%al
80102bd3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bd6:	89 da                	mov    %ebx,%edx
80102bd8:	b8 04 00 00 00       	mov    $0x4,%eax
80102bdd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bde:	89 ca                	mov    %ecx,%edx
80102be0:	ec                   	in     (%dx),%al
80102be1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102be4:	89 da                	mov    %ebx,%edx
80102be6:	b8 07 00 00 00       	mov    $0x7,%eax
80102beb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bec:	89 ca                	mov    %ecx,%edx
80102bee:	ec                   	in     (%dx),%al
80102bef:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bf2:	89 da                	mov    %ebx,%edx
80102bf4:	b8 08 00 00 00       	mov    $0x8,%eax
80102bf9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bfa:	89 ca                	mov    %ecx,%edx
80102bfc:	ec                   	in     (%dx),%al
80102bfd:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bff:	89 da                	mov    %ebx,%edx
80102c01:	b8 09 00 00 00       	mov    $0x9,%eax
80102c06:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c07:	89 ca                	mov    %ecx,%edx
80102c09:	ec                   	in     (%dx),%al
80102c0a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c0c:	89 da                	mov    %ebx,%edx
80102c0e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102c13:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c14:	89 ca                	mov    %ecx,%edx
80102c16:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102c17:	84 c0                	test   %al,%al
80102c19:	78 9d                	js     80102bb8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102c1b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102c1f:	89 fa                	mov    %edi,%edx
80102c21:	0f b6 fa             	movzbl %dl,%edi
80102c24:	89 f2                	mov    %esi,%edx
80102c26:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102c29:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102c2d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c30:	89 da                	mov    %ebx,%edx
80102c32:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102c35:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102c38:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102c3c:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102c3f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102c42:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102c46:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102c49:	31 c0                	xor    %eax,%eax
80102c4b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c4c:	89 ca                	mov    %ecx,%edx
80102c4e:	ec                   	in     (%dx),%al
80102c4f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c52:	89 da                	mov    %ebx,%edx
80102c54:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102c57:	b8 02 00 00 00       	mov    $0x2,%eax
80102c5c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c5d:	89 ca                	mov    %ecx,%edx
80102c5f:	ec                   	in     (%dx),%al
80102c60:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c63:	89 da                	mov    %ebx,%edx
80102c65:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102c68:	b8 04 00 00 00       	mov    $0x4,%eax
80102c6d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c6e:	89 ca                	mov    %ecx,%edx
80102c70:	ec                   	in     (%dx),%al
80102c71:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c74:	89 da                	mov    %ebx,%edx
80102c76:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102c79:	b8 07 00 00 00       	mov    $0x7,%eax
80102c7e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c7f:	89 ca                	mov    %ecx,%edx
80102c81:	ec                   	in     (%dx),%al
80102c82:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c85:	89 da                	mov    %ebx,%edx
80102c87:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102c8a:	b8 08 00 00 00       	mov    $0x8,%eax
80102c8f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c90:	89 ca                	mov    %ecx,%edx
80102c92:	ec                   	in     (%dx),%al
80102c93:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c96:	89 da                	mov    %ebx,%edx
80102c98:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102c9b:	b8 09 00 00 00       	mov    $0x9,%eax
80102ca0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ca1:	89 ca                	mov    %ecx,%edx
80102ca3:	ec                   	in     (%dx),%al
80102ca4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ca7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102caa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102cad:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102cb0:	6a 18                	push   $0x18
80102cb2:	50                   	push   %eax
80102cb3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102cb6:	50                   	push   %eax
80102cb7:	e8 d4 23 00 00       	call   80105090 <memcmp>
80102cbc:	83 c4 10             	add    $0x10,%esp
80102cbf:	85 c0                	test   %eax,%eax
80102cc1:	0f 85 f1 fe ff ff    	jne    80102bb8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102cc7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102ccb:	75 78                	jne    80102d45 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102ccd:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102cd0:	89 c2                	mov    %eax,%edx
80102cd2:	83 e0 0f             	and    $0xf,%eax
80102cd5:	c1 ea 04             	shr    $0x4,%edx
80102cd8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cdb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cde:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102ce1:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ce4:	89 c2                	mov    %eax,%edx
80102ce6:	83 e0 0f             	and    $0xf,%eax
80102ce9:	c1 ea 04             	shr    $0x4,%edx
80102cec:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cef:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cf2:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102cf5:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102cf8:	89 c2                	mov    %eax,%edx
80102cfa:	83 e0 0f             	and    $0xf,%eax
80102cfd:	c1 ea 04             	shr    $0x4,%edx
80102d00:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d03:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d06:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102d09:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102d0c:	89 c2                	mov    %eax,%edx
80102d0e:	83 e0 0f             	and    $0xf,%eax
80102d11:	c1 ea 04             	shr    $0x4,%edx
80102d14:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d17:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d1a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102d1d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d20:	89 c2                	mov    %eax,%edx
80102d22:	83 e0 0f             	and    $0xf,%eax
80102d25:	c1 ea 04             	shr    $0x4,%edx
80102d28:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d2b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d2e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102d31:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d34:	89 c2                	mov    %eax,%edx
80102d36:	83 e0 0f             	and    $0xf,%eax
80102d39:	c1 ea 04             	shr    $0x4,%edx
80102d3c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d3f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d42:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102d45:	8b 75 08             	mov    0x8(%ebp),%esi
80102d48:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102d4b:	89 06                	mov    %eax,(%esi)
80102d4d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102d50:	89 46 04             	mov    %eax,0x4(%esi)
80102d53:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102d56:	89 46 08             	mov    %eax,0x8(%esi)
80102d59:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102d5c:	89 46 0c             	mov    %eax,0xc(%esi)
80102d5f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d62:	89 46 10             	mov    %eax,0x10(%esi)
80102d65:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d68:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102d6b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102d72:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d75:	5b                   	pop    %ebx
80102d76:	5e                   	pop    %esi
80102d77:	5f                   	pop    %edi
80102d78:	5d                   	pop    %ebp
80102d79:	c3                   	ret    
80102d7a:	66 90                	xchg   %ax,%ax
80102d7c:	66 90                	xchg   %ax,%ax
80102d7e:	66 90                	xchg   %ax,%ax

80102d80 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d80:	8b 0d 08 b7 14 80    	mov    0x8014b708,%ecx
80102d86:	85 c9                	test   %ecx,%ecx
80102d88:	0f 8e 8a 00 00 00    	jle    80102e18 <install_trans+0x98>
{
80102d8e:	55                   	push   %ebp
80102d8f:	89 e5                	mov    %esp,%ebp
80102d91:	57                   	push   %edi
80102d92:	56                   	push   %esi
80102d93:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102d94:	31 db                	xor    %ebx,%ebx
{
80102d96:	83 ec 0c             	sub    $0xc,%esp
80102d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102da0:	a1 f4 b6 14 80       	mov    0x8014b6f4,%eax
80102da5:	83 ec 08             	sub    $0x8,%esp
80102da8:	01 d8                	add    %ebx,%eax
80102daa:	83 c0 01             	add    $0x1,%eax
80102dad:	50                   	push   %eax
80102dae:	ff 35 04 b7 14 80    	pushl  0x8014b704
80102db4:	e8 17 d3 ff ff       	call   801000d0 <bread>
80102db9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dbb:	58                   	pop    %eax
80102dbc:	5a                   	pop    %edx
80102dbd:	ff 34 9d 0c b7 14 80 	pushl  -0x7feb48f4(,%ebx,4)
80102dc4:	ff 35 04 b7 14 80    	pushl  0x8014b704
  for (tail = 0; tail < log.lh.n; tail++) {
80102dca:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dcd:	e8 fe d2 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102dd2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dd5:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102dd7:	8d 47 5c             	lea    0x5c(%edi),%eax
80102dda:	68 00 02 00 00       	push   $0x200
80102ddf:	50                   	push   %eax
80102de0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102de3:	50                   	push   %eax
80102de4:	e8 f7 22 00 00       	call   801050e0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102de9:	89 34 24             	mov    %esi,(%esp)
80102dec:	e8 bf d3 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102df1:	89 3c 24             	mov    %edi,(%esp)
80102df4:	e8 f7 d3 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102df9:	89 34 24             	mov    %esi,(%esp)
80102dfc:	e8 ef d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102e01:	83 c4 10             	add    $0x10,%esp
80102e04:	39 1d 08 b7 14 80    	cmp    %ebx,0x8014b708
80102e0a:	7f 94                	jg     80102da0 <install_trans+0x20>
  }
}
80102e0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e0f:	5b                   	pop    %ebx
80102e10:	5e                   	pop    %esi
80102e11:	5f                   	pop    %edi
80102e12:	5d                   	pop    %ebp
80102e13:	c3                   	ret    
80102e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e18:	c3                   	ret    
80102e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e20 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102e20:	55                   	push   %ebp
80102e21:	89 e5                	mov    %esp,%ebp
80102e23:	53                   	push   %ebx
80102e24:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102e27:	ff 35 f4 b6 14 80    	pushl  0x8014b6f4
80102e2d:	ff 35 04 b7 14 80    	pushl  0x8014b704
80102e33:	e8 98 d2 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102e38:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102e3b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102e3d:	a1 08 b7 14 80       	mov    0x8014b708,%eax
80102e42:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102e45:	85 c0                	test   %eax,%eax
80102e47:	7e 19                	jle    80102e62 <write_head+0x42>
80102e49:	31 d2                	xor    %edx,%edx
80102e4b:	90                   	nop
80102e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102e50:	8b 0c 95 0c b7 14 80 	mov    -0x7feb48f4(,%edx,4),%ecx
80102e57:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102e5b:	83 c2 01             	add    $0x1,%edx
80102e5e:	39 d0                	cmp    %edx,%eax
80102e60:	75 ee                	jne    80102e50 <write_head+0x30>
  }
  bwrite(buf);
80102e62:	83 ec 0c             	sub    $0xc,%esp
80102e65:	53                   	push   %ebx
80102e66:	e8 45 d3 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102e6b:	89 1c 24             	mov    %ebx,(%esp)
80102e6e:	e8 7d d3 ff ff       	call   801001f0 <brelse>
}
80102e73:	83 c4 10             	add    $0x10,%esp
80102e76:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e79:	c9                   	leave  
80102e7a:	c3                   	ret    
80102e7b:	90                   	nop
80102e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102e80 <initlog>:
{
80102e80:	55                   	push   %ebp
80102e81:	89 e5                	mov    %esp,%ebp
80102e83:	53                   	push   %ebx
80102e84:	83 ec 2c             	sub    $0x2c,%esp
80102e87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102e8a:	68 c0 80 10 80       	push   $0x801080c0
80102e8f:	68 c0 b6 14 80       	push   $0x8014b6c0
80102e94:	e8 37 1f 00 00       	call   80104dd0 <initlock>
  readsb(dev, &sb);
80102e99:	58                   	pop    %eax
80102e9a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102e9d:	5a                   	pop    %edx
80102e9e:	50                   	push   %eax
80102e9f:	53                   	push   %ebx
80102ea0:	e8 bb e5 ff ff       	call   80101460 <readsb>
  log.start = sb.logstart;
80102ea5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102ea8:	59                   	pop    %ecx
  log.dev = dev;
80102ea9:	89 1d 04 b7 14 80    	mov    %ebx,0x8014b704
  log.size = sb.nlog;
80102eaf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102eb2:	a3 f4 b6 14 80       	mov    %eax,0x8014b6f4
  log.size = sb.nlog;
80102eb7:	89 15 f8 b6 14 80    	mov    %edx,0x8014b6f8
  struct buf *buf = bread(log.dev, log.start);
80102ebd:	5a                   	pop    %edx
80102ebe:	50                   	push   %eax
80102ebf:	53                   	push   %ebx
80102ec0:	e8 0b d2 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102ec5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102ec8:	8b 48 5c             	mov    0x5c(%eax),%ecx
80102ecb:	89 0d 08 b7 14 80    	mov    %ecx,0x8014b708
  for (i = 0; i < log.lh.n; i++) {
80102ed1:	85 c9                	test   %ecx,%ecx
80102ed3:	7e 1d                	jle    80102ef2 <initlog+0x72>
80102ed5:	31 d2                	xor    %edx,%edx
80102ed7:	89 f6                	mov    %esi,%esi
80102ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.lh.block[i] = lh->block[i];
80102ee0:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
80102ee4:	89 1c 95 0c b7 14 80 	mov    %ebx,-0x7feb48f4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102eeb:	83 c2 01             	add    $0x1,%edx
80102eee:	39 d1                	cmp    %edx,%ecx
80102ef0:	75 ee                	jne    80102ee0 <initlog+0x60>
  brelse(buf);
80102ef2:	83 ec 0c             	sub    $0xc,%esp
80102ef5:	50                   	push   %eax
80102ef6:	e8 f5 d2 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102efb:	e8 80 fe ff ff       	call   80102d80 <install_trans>
  log.lh.n = 0;
80102f00:	c7 05 08 b7 14 80 00 	movl   $0x0,0x8014b708
80102f07:	00 00 00 
  write_head(); // clear the log
80102f0a:	e8 11 ff ff ff       	call   80102e20 <write_head>
}
80102f0f:	83 c4 10             	add    $0x10,%esp
80102f12:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f15:	c9                   	leave  
80102f16:	c3                   	ret    
80102f17:	89 f6                	mov    %esi,%esi
80102f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f20 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102f26:	68 c0 b6 14 80       	push   $0x8014b6c0
80102f2b:	e8 00 20 00 00       	call   80104f30 <acquire>
80102f30:	83 c4 10             	add    $0x10,%esp
80102f33:	eb 18                	jmp    80102f4d <begin_op+0x2d>
80102f35:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102f38:	83 ec 08             	sub    $0x8,%esp
80102f3b:	68 c0 b6 14 80       	push   $0x8014b6c0
80102f40:	68 c0 b6 14 80       	push   $0x8014b6c0
80102f45:	e8 e6 19 00 00       	call   80104930 <sleep>
80102f4a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102f4d:	a1 00 b7 14 80       	mov    0x8014b700,%eax
80102f52:	85 c0                	test   %eax,%eax
80102f54:	75 e2                	jne    80102f38 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102f56:	a1 fc b6 14 80       	mov    0x8014b6fc,%eax
80102f5b:	8b 15 08 b7 14 80    	mov    0x8014b708,%edx
80102f61:	83 c0 01             	add    $0x1,%eax
80102f64:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102f67:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102f6a:	83 fa 1e             	cmp    $0x1e,%edx
80102f6d:	7f c9                	jg     80102f38 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102f6f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102f72:	a3 fc b6 14 80       	mov    %eax,0x8014b6fc
      release(&log.lock);
80102f77:	68 c0 b6 14 80       	push   $0x8014b6c0
80102f7c:	e8 6f 20 00 00       	call   80104ff0 <release>
      break;
    }
  }
}
80102f81:	83 c4 10             	add    $0x10,%esp
80102f84:	c9                   	leave  
80102f85:	c3                   	ret    
80102f86:	8d 76 00             	lea    0x0(%esi),%esi
80102f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f90 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102f90:	55                   	push   %ebp
80102f91:	89 e5                	mov    %esp,%ebp
80102f93:	57                   	push   %edi
80102f94:	56                   	push   %esi
80102f95:	53                   	push   %ebx
80102f96:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102f99:	68 c0 b6 14 80       	push   $0x8014b6c0
80102f9e:	e8 8d 1f 00 00       	call   80104f30 <acquire>
  log.outstanding -= 1;
80102fa3:	a1 fc b6 14 80       	mov    0x8014b6fc,%eax
  if(log.committing)
80102fa8:	8b 35 00 b7 14 80    	mov    0x8014b700,%esi
80102fae:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102fb1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102fb4:	89 1d fc b6 14 80    	mov    %ebx,0x8014b6fc
  if(log.committing)
80102fba:	85 f6                	test   %esi,%esi
80102fbc:	0f 85 22 01 00 00    	jne    801030e4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102fc2:	85 db                	test   %ebx,%ebx
80102fc4:	0f 85 f6 00 00 00    	jne    801030c0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102fca:	c7 05 00 b7 14 80 01 	movl   $0x1,0x8014b700
80102fd1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102fd4:	83 ec 0c             	sub    $0xc,%esp
80102fd7:	68 c0 b6 14 80       	push   $0x8014b6c0
80102fdc:	e8 0f 20 00 00       	call   80104ff0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102fe1:	8b 0d 08 b7 14 80    	mov    0x8014b708,%ecx
80102fe7:	83 c4 10             	add    $0x10,%esp
80102fea:	85 c9                	test   %ecx,%ecx
80102fec:	7f 42                	jg     80103030 <end_op+0xa0>
    acquire(&log.lock);
80102fee:	83 ec 0c             	sub    $0xc,%esp
80102ff1:	68 c0 b6 14 80       	push   $0x8014b6c0
80102ff6:	e8 35 1f 00 00       	call   80104f30 <acquire>
    wakeup(&log);
80102ffb:	c7 04 24 c0 b6 14 80 	movl   $0x8014b6c0,(%esp)
    log.committing = 0;
80103002:	c7 05 00 b7 14 80 00 	movl   $0x0,0x8014b700
80103009:	00 00 00 
    wakeup(&log);
8010300c:	e8 df 1a 00 00       	call   80104af0 <wakeup>
    release(&log.lock);
80103011:	c7 04 24 c0 b6 14 80 	movl   $0x8014b6c0,(%esp)
80103018:	e8 d3 1f 00 00       	call   80104ff0 <release>
8010301d:	83 c4 10             	add    $0x10,%esp
}
80103020:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103023:	5b                   	pop    %ebx
80103024:	5e                   	pop    %esi
80103025:	5f                   	pop    %edi
80103026:	5d                   	pop    %ebp
80103027:	c3                   	ret    
80103028:	90                   	nop
80103029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103030:	a1 f4 b6 14 80       	mov    0x8014b6f4,%eax
80103035:	83 ec 08             	sub    $0x8,%esp
80103038:	01 d8                	add    %ebx,%eax
8010303a:	83 c0 01             	add    $0x1,%eax
8010303d:	50                   	push   %eax
8010303e:	ff 35 04 b7 14 80    	pushl  0x8014b704
80103044:	e8 87 d0 ff ff       	call   801000d0 <bread>
80103049:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010304b:	58                   	pop    %eax
8010304c:	5a                   	pop    %edx
8010304d:	ff 34 9d 0c b7 14 80 	pushl  -0x7feb48f4(,%ebx,4)
80103054:	ff 35 04 b7 14 80    	pushl  0x8014b704
  for (tail = 0; tail < log.lh.n; tail++) {
8010305a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010305d:	e8 6e d0 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103062:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103065:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103067:	8d 40 5c             	lea    0x5c(%eax),%eax
8010306a:	68 00 02 00 00       	push   $0x200
8010306f:	50                   	push   %eax
80103070:	8d 46 5c             	lea    0x5c(%esi),%eax
80103073:	50                   	push   %eax
80103074:	e8 67 20 00 00       	call   801050e0 <memmove>
    bwrite(to);  // write the log
80103079:	89 34 24             	mov    %esi,(%esp)
8010307c:	e8 2f d1 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103081:	89 3c 24             	mov    %edi,(%esp)
80103084:	e8 67 d1 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103089:	89 34 24             	mov    %esi,(%esp)
8010308c:	e8 5f d1 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103091:	83 c4 10             	add    $0x10,%esp
80103094:	3b 1d 08 b7 14 80    	cmp    0x8014b708,%ebx
8010309a:	7c 94                	jl     80103030 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010309c:	e8 7f fd ff ff       	call   80102e20 <write_head>
    install_trans(); // Now install writes to home locations
801030a1:	e8 da fc ff ff       	call   80102d80 <install_trans>
    log.lh.n = 0;
801030a6:	c7 05 08 b7 14 80 00 	movl   $0x0,0x8014b708
801030ad:	00 00 00 
    write_head();    // Erase the transaction from the log
801030b0:	e8 6b fd ff ff       	call   80102e20 <write_head>
801030b5:	e9 34 ff ff ff       	jmp    80102fee <end_op+0x5e>
801030ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
801030c0:	83 ec 0c             	sub    $0xc,%esp
801030c3:	68 c0 b6 14 80       	push   $0x8014b6c0
801030c8:	e8 23 1a 00 00       	call   80104af0 <wakeup>
  release(&log.lock);
801030cd:	c7 04 24 c0 b6 14 80 	movl   $0x8014b6c0,(%esp)
801030d4:	e8 17 1f 00 00       	call   80104ff0 <release>
801030d9:	83 c4 10             	add    $0x10,%esp
}
801030dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030df:	5b                   	pop    %ebx
801030e0:	5e                   	pop    %esi
801030e1:	5f                   	pop    %edi
801030e2:	5d                   	pop    %ebp
801030e3:	c3                   	ret    
    panic("log.committing");
801030e4:	83 ec 0c             	sub    $0xc,%esp
801030e7:	68 c4 80 10 80       	push   $0x801080c4
801030ec:	e8 9f d2 ff ff       	call   80100390 <panic>
801030f1:	eb 0d                	jmp    80103100 <log_write>
801030f3:	90                   	nop
801030f4:	90                   	nop
801030f5:	90                   	nop
801030f6:	90                   	nop
801030f7:	90                   	nop
801030f8:	90                   	nop
801030f9:	90                   	nop
801030fa:	90                   	nop
801030fb:	90                   	nop
801030fc:	90                   	nop
801030fd:	90                   	nop
801030fe:	90                   	nop
801030ff:	90                   	nop

80103100 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103100:	55                   	push   %ebp
80103101:	89 e5                	mov    %esp,%ebp
80103103:	53                   	push   %ebx
80103104:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103107:	8b 15 08 b7 14 80    	mov    0x8014b708,%edx
{
8010310d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103110:	83 fa 1d             	cmp    $0x1d,%edx
80103113:	0f 8f 94 00 00 00    	jg     801031ad <log_write+0xad>
80103119:	a1 f8 b6 14 80       	mov    0x8014b6f8,%eax
8010311e:	83 e8 01             	sub    $0x1,%eax
80103121:	39 c2                	cmp    %eax,%edx
80103123:	0f 8d 84 00 00 00    	jge    801031ad <log_write+0xad>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103129:	a1 fc b6 14 80       	mov    0x8014b6fc,%eax
8010312e:	85 c0                	test   %eax,%eax
80103130:	0f 8e 84 00 00 00    	jle    801031ba <log_write+0xba>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103136:	83 ec 0c             	sub    $0xc,%esp
80103139:	68 c0 b6 14 80       	push   $0x8014b6c0
8010313e:	e8 ed 1d 00 00       	call   80104f30 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103143:	8b 15 08 b7 14 80    	mov    0x8014b708,%edx
80103149:	83 c4 10             	add    $0x10,%esp
8010314c:	85 d2                	test   %edx,%edx
8010314e:	7e 51                	jle    801031a1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103150:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103153:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103155:	3b 0d 0c b7 14 80    	cmp    0x8014b70c,%ecx
8010315b:	75 0c                	jne    80103169 <log_write+0x69>
8010315d:	eb 39                	jmp    80103198 <log_write+0x98>
8010315f:	90                   	nop
80103160:	39 0c 85 0c b7 14 80 	cmp    %ecx,-0x7feb48f4(,%eax,4)
80103167:	74 2f                	je     80103198 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80103169:	83 c0 01             	add    $0x1,%eax
8010316c:	39 c2                	cmp    %eax,%edx
8010316e:	75 f0                	jne    80103160 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80103170:	89 0c 95 0c b7 14 80 	mov    %ecx,-0x7feb48f4(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80103177:	83 c2 01             	add    $0x1,%edx
8010317a:	89 15 08 b7 14 80    	mov    %edx,0x8014b708
  b->flags |= B_DIRTY; // prevent eviction
80103180:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80103183:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103186:	c7 45 08 c0 b6 14 80 	movl   $0x8014b6c0,0x8(%ebp)
}
8010318d:	c9                   	leave  
  release(&log.lock);
8010318e:	e9 5d 1e 00 00       	jmp    80104ff0 <release>
80103193:	90                   	nop
80103194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  log.lh.block[i] = b->blockno;
80103198:	89 0c 85 0c b7 14 80 	mov    %ecx,-0x7feb48f4(,%eax,4)
  if (i == log.lh.n)
8010319f:	eb df                	jmp    80103180 <log_write+0x80>
  log.lh.block[i] = b->blockno;
801031a1:	8b 43 08             	mov    0x8(%ebx),%eax
801031a4:	a3 0c b7 14 80       	mov    %eax,0x8014b70c
  if (i == log.lh.n)
801031a9:	75 d5                	jne    80103180 <log_write+0x80>
801031ab:	eb ca                	jmp    80103177 <log_write+0x77>
    panic("too big a transaction");
801031ad:	83 ec 0c             	sub    $0xc,%esp
801031b0:	68 d3 80 10 80       	push   $0x801080d3
801031b5:	e8 d6 d1 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
801031ba:	83 ec 0c             	sub    $0xc,%esp
801031bd:	68 e9 80 10 80       	push   $0x801080e9
801031c2:	e8 c9 d1 ff ff       	call   80100390 <panic>
801031c7:	66 90                	xchg   %ax,%ax
801031c9:	66 90                	xchg   %ax,%ax
801031cb:	66 90                	xchg   %ax,%ax
801031cd:	66 90                	xchg   %ax,%ax
801031cf:	90                   	nop

801031d0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801031d0:	55                   	push   %ebp
801031d1:	89 e5                	mov    %esp,%ebp
801031d3:	53                   	push   %ebx
801031d4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801031d7:	e8 a4 0a 00 00       	call   80103c80 <cpuid>
801031dc:	89 c3                	mov    %eax,%ebx
801031de:	e8 9d 0a 00 00       	call   80103c80 <cpuid>
801031e3:	83 ec 04             	sub    $0x4,%esp
801031e6:	53                   	push   %ebx
801031e7:	50                   	push   %eax
801031e8:	68 04 81 10 80       	push   $0x80108104
801031ed:	e8 be d4 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
801031f2:	e8 99 30 00 00       	call   80106290 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801031f7:	e8 04 0a 00 00       	call   80103c00 <mycpu>
801031fc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801031fe:	b8 01 00 00 00       	mov    $0x1,%eax
80103203:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010320a:	e8 d1 11 00 00       	call   801043e0 <scheduler>
8010320f:	90                   	nop

80103210 <mpenter>:
{
80103210:	55                   	push   %ebp
80103211:	89 e5                	mov    %esp,%ebp
80103213:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103216:	e8 95 41 00 00       	call   801073b0 <switchkvm>
  seginit();
8010321b:	e8 00 41 00 00       	call   80107320 <seginit>
  lapicinit();
80103220:	e8 8b f7 ff ff       	call   801029b0 <lapicinit>
  mpmain();
80103225:	e8 a6 ff ff ff       	call   801031d0 <mpmain>
8010322a:	66 90                	xchg   %ax,%ax
8010322c:	66 90                	xchg   %ax,%ax
8010322e:	66 90                	xchg   %ax,%ax

80103230 <main>:
{
80103230:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103234:	83 e4 f0             	and    $0xfffffff0,%esp
80103237:	ff 71 fc             	pushl  -0x4(%ecx)
8010323a:	55                   	push   %ebp
8010323b:	89 e5                	mov    %esp,%ebp
8010323d:	53                   	push   %ebx
8010323e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010323f:	83 ec 08             	sub    $0x8,%esp
80103242:	68 00 00 40 80       	push   $0x80400000
80103247:	68 08 e9 14 80       	push   $0x8014e908
8010324c:	e8 df f2 ff ff       	call   80102530 <kinit1>
  kvmalloc();      // kernel page table
80103251:	e8 1a 46 00 00       	call   80107870 <kvmalloc>
  mpinit();        // detect other processors
80103256:	e8 85 01 00 00       	call   801033e0 <mpinit>
  lapicinit();     // interrupt controller
8010325b:	e8 50 f7 ff ff       	call   801029b0 <lapicinit>
  seginit();       // segment descriptors
80103260:	e8 bb 40 00 00       	call   80107320 <seginit>
  picinit();       // disable pic
80103265:	e8 46 03 00 00       	call   801035b0 <picinit>
  ioapicinit();    // another interrupt controller
8010326a:	e8 91 f0 ff ff       	call   80102300 <ioapicinit>
  consoleinit();   // console hardware
8010326f:	e8 bc d7 ff ff       	call   80100a30 <consoleinit>
  uartinit();      // serial port
80103274:	e8 67 33 00 00       	call   801065e0 <uartinit>
  pinit();         // process table
80103279:	e8 22 09 00 00       	call   80103ba0 <pinit>
  tvinit();        // trap vectors
8010327e:	e8 8d 2f 00 00       	call   80106210 <tvinit>
  binit();         // buffer cache
80103283:	e8 b8 cd ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103288:	e8 53 db ff ff       	call   80100de0 <fileinit>
  ideinit();       // disk 
8010328d:	e8 4e ee ff ff       	call   801020e0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103292:	83 c4 0c             	add    $0xc,%esp
80103295:	68 8a 00 00 00       	push   $0x8a
8010329a:	68 ac b4 10 80       	push   $0x8010b4ac
8010329f:	68 00 70 00 80       	push   $0x80007000
801032a4:	e8 37 1e 00 00       	call   801050e0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801032a9:	83 c4 10             	add    $0x10,%esp
801032ac:	69 05 40 bd 14 80 b0 	imul   $0xb0,0x8014bd40,%eax
801032b3:	00 00 00 
801032b6:	05 c0 b7 14 80       	add    $0x8014b7c0,%eax
801032bb:	3d c0 b7 14 80       	cmp    $0x8014b7c0,%eax
801032c0:	76 7e                	jbe    80103340 <main+0x110>
801032c2:	bb c0 b7 14 80       	mov    $0x8014b7c0,%ebx
801032c7:	eb 20                	jmp    801032e9 <main+0xb9>
801032c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032d0:	69 05 40 bd 14 80 b0 	imul   $0xb0,0x8014bd40,%eax
801032d7:	00 00 00 
801032da:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801032e0:	05 c0 b7 14 80       	add    $0x8014b7c0,%eax
801032e5:	39 c3                	cmp    %eax,%ebx
801032e7:	73 57                	jae    80103340 <main+0x110>
    if(c == mycpu())  // We've started already.
801032e9:	e8 12 09 00 00       	call   80103c00 <mycpu>
801032ee:	39 d8                	cmp    %ebx,%eax
801032f0:	74 de                	je     801032d0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801032f2:	e8 39 f3 ff ff       	call   80102630 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801032f7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
801032fa:	c7 05 f8 6f 00 80 10 	movl   $0x80103210,0x80006ff8
80103301:	32 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103304:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010330b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010330e:	05 00 10 00 00       	add    $0x1000,%eax
80103313:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103318:	0f b6 03             	movzbl (%ebx),%eax
8010331b:	68 00 70 00 00       	push   $0x7000
80103320:	50                   	push   %eax
80103321:	e8 da f7 ff ff       	call   80102b00 <lapicstartap>
80103326:	83 c4 10             	add    $0x10,%esp
80103329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103330:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103336:	85 c0                	test   %eax,%eax
80103338:	74 f6                	je     80103330 <main+0x100>
8010333a:	eb 94                	jmp    801032d0 <main+0xa0>
8010333c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103340:	83 ec 08             	sub    $0x8,%esp
80103343:	68 00 00 00 8e       	push   $0x8e000000
80103348:	68 00 00 40 80       	push   $0x80400000
8010334d:	e8 6e f2 ff ff       	call   801025c0 <kinit2>
  userinit();      // first user process
80103352:	e8 79 09 00 00       	call   80103cd0 <userinit>
  mpmain();        // finish this processor's setup
80103357:	e8 74 fe ff ff       	call   801031d0 <mpmain>
8010335c:	66 90                	xchg   %ax,%ax
8010335e:	66 90                	xchg   %ax,%ax

80103360 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103360:	55                   	push   %ebp
80103361:	89 e5                	mov    %esp,%ebp
80103363:	57                   	push   %edi
80103364:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103365:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010336b:	53                   	push   %ebx
  e = addr+len;
8010336c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010336f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103372:	39 de                	cmp    %ebx,%esi
80103374:	72 10                	jb     80103386 <mpsearch1+0x26>
80103376:	eb 50                	jmp    801033c8 <mpsearch1+0x68>
80103378:	90                   	nop
80103379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103380:	89 fe                	mov    %edi,%esi
80103382:	39 fb                	cmp    %edi,%ebx
80103384:	76 42                	jbe    801033c8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103386:	83 ec 04             	sub    $0x4,%esp
80103389:	8d 7e 10             	lea    0x10(%esi),%edi
8010338c:	6a 04                	push   $0x4
8010338e:	68 18 81 10 80       	push   $0x80108118
80103393:	56                   	push   %esi
80103394:	e8 f7 1c 00 00       	call   80105090 <memcmp>
80103399:	83 c4 10             	add    $0x10,%esp
8010339c:	85 c0                	test   %eax,%eax
8010339e:	75 e0                	jne    80103380 <mpsearch1+0x20>
801033a0:	89 f1                	mov    %esi,%ecx
801033a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801033a8:	0f b6 11             	movzbl (%ecx),%edx
801033ab:	83 c1 01             	add    $0x1,%ecx
801033ae:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
801033b0:	39 f9                	cmp    %edi,%ecx
801033b2:	75 f4                	jne    801033a8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033b4:	84 c0                	test   %al,%al
801033b6:	75 c8                	jne    80103380 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801033b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033bb:	89 f0                	mov    %esi,%eax
801033bd:	5b                   	pop    %ebx
801033be:	5e                   	pop    %esi
801033bf:	5f                   	pop    %edi
801033c0:	5d                   	pop    %ebp
801033c1:	c3                   	ret    
801033c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801033c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801033cb:	31 f6                	xor    %esi,%esi
}
801033cd:	5b                   	pop    %ebx
801033ce:	89 f0                	mov    %esi,%eax
801033d0:	5e                   	pop    %esi
801033d1:	5f                   	pop    %edi
801033d2:	5d                   	pop    %ebp
801033d3:	c3                   	ret    
801033d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801033da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801033e0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	57                   	push   %edi
801033e4:	56                   	push   %esi
801033e5:	53                   	push   %ebx
801033e6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801033e9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801033f0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801033f7:	c1 e0 08             	shl    $0x8,%eax
801033fa:	09 d0                	or     %edx,%eax
801033fc:	c1 e0 04             	shl    $0x4,%eax
801033ff:	75 1b                	jne    8010341c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103401:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103408:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010340f:	c1 e0 08             	shl    $0x8,%eax
80103412:	09 d0                	or     %edx,%eax
80103414:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103417:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010341c:	ba 00 04 00 00       	mov    $0x400,%edx
80103421:	e8 3a ff ff ff       	call   80103360 <mpsearch1>
80103426:	89 c7                	mov    %eax,%edi
80103428:	85 c0                	test   %eax,%eax
8010342a:	0f 84 c0 00 00 00    	je     801034f0 <mpinit+0x110>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103430:	8b 5f 04             	mov    0x4(%edi),%ebx
80103433:	85 db                	test   %ebx,%ebx
80103435:	0f 84 d5 00 00 00    	je     80103510 <mpinit+0x130>
  if(memcmp(conf, "PCMP", 4) != 0)
8010343b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010343e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103444:	6a 04                	push   $0x4
80103446:	68 35 81 10 80       	push   $0x80108135
8010344b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010344c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010344f:	e8 3c 1c 00 00       	call   80105090 <memcmp>
80103454:	83 c4 10             	add    $0x10,%esp
80103457:	85 c0                	test   %eax,%eax
80103459:	0f 85 b1 00 00 00    	jne    80103510 <mpinit+0x130>
  if(conf->version != 1 && conf->version != 4)
8010345f:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103466:	3c 01                	cmp    $0x1,%al
80103468:	0f 95 c2             	setne  %dl
8010346b:	3c 04                	cmp    $0x4,%al
8010346d:	0f 95 c0             	setne  %al
80103470:	20 c2                	and    %al,%dl
80103472:	0f 85 98 00 00 00    	jne    80103510 <mpinit+0x130>
  if(sum((uchar*)conf, conf->length) != 0)
80103478:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
  for(i=0; i<len; i++)
8010347f:	66 85 c9             	test   %cx,%cx
80103482:	74 21                	je     801034a5 <mpinit+0xc5>
80103484:	89 d8                	mov    %ebx,%eax
80103486:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
  sum = 0;
80103489:	31 d2                	xor    %edx,%edx
8010348b:	90                   	nop
8010348c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103490:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103497:	83 c0 01             	add    $0x1,%eax
8010349a:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
8010349c:	39 c6                	cmp    %eax,%esi
8010349e:	75 f0                	jne    80103490 <mpinit+0xb0>
801034a0:	84 d2                	test   %dl,%dl
801034a2:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801034a5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801034a8:	85 c9                	test   %ecx,%ecx
801034aa:	74 64                	je     80103510 <mpinit+0x130>
801034ac:	84 d2                	test   %dl,%dl
801034ae:	75 60                	jne    80103510 <mpinit+0x130>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801034b0:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801034b6:	a3 a0 b6 14 80       	mov    %eax,0x8014b6a0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034bb:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801034c2:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
801034c8:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034cd:	01 d1                	add    %edx,%ecx
801034cf:	89 ce                	mov    %ecx,%esi
801034d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034d8:	39 c6                	cmp    %eax,%esi
801034da:	76 4b                	jbe    80103527 <mpinit+0x147>
    switch(*p){
801034dc:	0f b6 10             	movzbl (%eax),%edx
801034df:	80 fa 04             	cmp    $0x4,%dl
801034e2:	0f 87 bf 00 00 00    	ja     801035a7 <mpinit+0x1c7>
801034e8:	ff 24 95 5c 81 10 80 	jmp    *-0x7fef7ea4(,%edx,4)
801034ef:	90                   	nop
  return mpsearch1(0xF0000, 0x10000);
801034f0:	ba 00 00 01 00       	mov    $0x10000,%edx
801034f5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801034fa:	e8 61 fe ff ff       	call   80103360 <mpsearch1>
801034ff:	89 c7                	mov    %eax,%edi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103501:	85 c0                	test   %eax,%eax
80103503:	0f 85 27 ff ff ff    	jne    80103430 <mpinit+0x50>
80103509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103510:	83 ec 0c             	sub    $0xc,%esp
80103513:	68 1d 81 10 80       	push   $0x8010811d
80103518:	e8 73 ce ff ff       	call   80100390 <panic>
8010351d:	8d 76 00             	lea    0x0(%esi),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103520:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103523:	39 c6                	cmp    %eax,%esi
80103525:	77 b5                	ja     801034dc <mpinit+0xfc>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103527:	85 db                	test   %ebx,%ebx
80103529:	74 6f                	je     8010359a <mpinit+0x1ba>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010352b:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
8010352f:	74 15                	je     80103546 <mpinit+0x166>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103531:	b8 70 00 00 00       	mov    $0x70,%eax
80103536:	ba 22 00 00 00       	mov    $0x22,%edx
8010353b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010353c:	ba 23 00 00 00       	mov    $0x23,%edx
80103541:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103542:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103545:	ee                   	out    %al,(%dx)
  }
}
80103546:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103549:	5b                   	pop    %ebx
8010354a:	5e                   	pop    %esi
8010354b:	5f                   	pop    %edi
8010354c:	5d                   	pop    %ebp
8010354d:	c3                   	ret    
8010354e:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
80103550:	8b 15 40 bd 14 80    	mov    0x8014bd40,%edx
80103556:	83 fa 07             	cmp    $0x7,%edx
80103559:	7f 1f                	jg     8010357a <mpinit+0x19a>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010355b:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103561:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103564:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103568:	88 91 c0 b7 14 80    	mov    %dl,-0x7feb4840(%ecx)
        ncpu++;
8010356e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103571:	83 c2 01             	add    $0x1,%edx
80103574:	89 15 40 bd 14 80    	mov    %edx,0x8014bd40
      p += sizeof(struct mpproc);
8010357a:	83 c0 14             	add    $0x14,%eax
      continue;
8010357d:	e9 56 ff ff ff       	jmp    801034d8 <mpinit+0xf8>
80103582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ioapicid = ioapic->apicno;
80103588:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010358c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010358f:	88 15 a0 b7 14 80    	mov    %dl,0x8014b7a0
      continue;
80103595:	e9 3e ff ff ff       	jmp    801034d8 <mpinit+0xf8>
    panic("Didn't find a suitable machine");
8010359a:	83 ec 0c             	sub    $0xc,%esp
8010359d:	68 3c 81 10 80       	push   $0x8010813c
801035a2:	e8 e9 cd ff ff       	call   80100390 <panic>
      ismp = 0;
801035a7:	31 db                	xor    %ebx,%ebx
801035a9:	e9 31 ff ff ff       	jmp    801034df <mpinit+0xff>
801035ae:	66 90                	xchg   %ax,%ax

801035b0 <picinit>:
801035b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801035b5:	ba 21 00 00 00       	mov    $0x21,%edx
801035ba:	ee                   	out    %al,(%dx)
801035bb:	ba a1 00 00 00       	mov    $0xa1,%edx
801035c0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801035c1:	c3                   	ret    
801035c2:	66 90                	xchg   %ax,%ax
801035c4:	66 90                	xchg   %ax,%ax
801035c6:	66 90                	xchg   %ax,%ax
801035c8:	66 90                	xchg   %ax,%ax
801035ca:	66 90                	xchg   %ax,%ax
801035cc:	66 90                	xchg   %ax,%ax
801035ce:	66 90                	xchg   %ax,%ax

801035d0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801035d0:	55                   	push   %ebp
801035d1:	89 e5                	mov    %esp,%ebp
801035d3:	57                   	push   %edi
801035d4:	56                   	push   %esi
801035d5:	53                   	push   %ebx
801035d6:	83 ec 0c             	sub    $0xc,%esp
801035d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801035dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801035df:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801035e5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801035eb:	e8 10 d8 ff ff       	call   80100e00 <filealloc>
801035f0:	89 03                	mov    %eax,(%ebx)
801035f2:	85 c0                	test   %eax,%eax
801035f4:	0f 84 a8 00 00 00    	je     801036a2 <pipealloc+0xd2>
801035fa:	e8 01 d8 ff ff       	call   80100e00 <filealloc>
801035ff:	89 06                	mov    %eax,(%esi)
80103601:	85 c0                	test   %eax,%eax
80103603:	0f 84 87 00 00 00    	je     80103690 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103609:	e8 22 f0 ff ff       	call   80102630 <kalloc>
8010360e:	89 c7                	mov    %eax,%edi
80103610:	85 c0                	test   %eax,%eax
80103612:	0f 84 b0 00 00 00    	je     801036c8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80103618:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010361f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103622:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103625:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010362c:	00 00 00 
  p->nwrite = 0;
8010362f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103636:	00 00 00 
  p->nread = 0;
80103639:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103640:	00 00 00 
  initlock(&p->lock, "pipe");
80103643:	68 70 81 10 80       	push   $0x80108170
80103648:	50                   	push   %eax
80103649:	e8 82 17 00 00       	call   80104dd0 <initlock>
  (*f0)->type = FD_PIPE;
8010364e:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103650:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103653:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103659:	8b 03                	mov    (%ebx),%eax
8010365b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010365f:	8b 03                	mov    (%ebx),%eax
80103661:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103665:	8b 03                	mov    (%ebx),%eax
80103667:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010366a:	8b 06                	mov    (%esi),%eax
8010366c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103672:	8b 06                	mov    (%esi),%eax
80103674:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103678:	8b 06                	mov    (%esi),%eax
8010367a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010367e:	8b 06                	mov    (%esi),%eax
80103680:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103683:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103686:	31 c0                	xor    %eax,%eax
}
80103688:	5b                   	pop    %ebx
80103689:	5e                   	pop    %esi
8010368a:	5f                   	pop    %edi
8010368b:	5d                   	pop    %ebp
8010368c:	c3                   	ret    
8010368d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80103690:	8b 03                	mov    (%ebx),%eax
80103692:	85 c0                	test   %eax,%eax
80103694:	74 1e                	je     801036b4 <pipealloc+0xe4>
    fileclose(*f0);
80103696:	83 ec 0c             	sub    $0xc,%esp
80103699:	50                   	push   %eax
8010369a:	e8 21 d8 ff ff       	call   80100ec0 <fileclose>
8010369f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801036a2:	8b 06                	mov    (%esi),%eax
801036a4:	85 c0                	test   %eax,%eax
801036a6:	74 0c                	je     801036b4 <pipealloc+0xe4>
    fileclose(*f1);
801036a8:	83 ec 0c             	sub    $0xc,%esp
801036ab:	50                   	push   %eax
801036ac:	e8 0f d8 ff ff       	call   80100ec0 <fileclose>
801036b1:	83 c4 10             	add    $0x10,%esp
}
801036b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801036b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801036bc:	5b                   	pop    %ebx
801036bd:	5e                   	pop    %esi
801036be:	5f                   	pop    %edi
801036bf:	5d                   	pop    %ebp
801036c0:	c3                   	ret    
801036c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801036c8:	8b 03                	mov    (%ebx),%eax
801036ca:	85 c0                	test   %eax,%eax
801036cc:	75 c8                	jne    80103696 <pipealloc+0xc6>
801036ce:	eb d2                	jmp    801036a2 <pipealloc+0xd2>

801036d0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	56                   	push   %esi
801036d4:	53                   	push   %ebx
801036d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801036d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801036db:	83 ec 0c             	sub    $0xc,%esp
801036de:	53                   	push   %ebx
801036df:	e8 4c 18 00 00       	call   80104f30 <acquire>
  if(writable){
801036e4:	83 c4 10             	add    $0x10,%esp
801036e7:	85 f6                	test   %esi,%esi
801036e9:	74 65                	je     80103750 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
801036eb:	83 ec 0c             	sub    $0xc,%esp
801036ee:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801036f4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801036fb:	00 00 00 
    wakeup(&p->nread);
801036fe:	50                   	push   %eax
801036ff:	e8 ec 13 00 00       	call   80104af0 <wakeup>
80103704:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103707:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010370d:	85 d2                	test   %edx,%edx
8010370f:	75 0a                	jne    8010371b <pipeclose+0x4b>
80103711:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103717:	85 c0                	test   %eax,%eax
80103719:	74 15                	je     80103730 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010371b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010371e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103721:	5b                   	pop    %ebx
80103722:	5e                   	pop    %esi
80103723:	5d                   	pop    %ebp
    release(&p->lock);
80103724:	e9 c7 18 00 00       	jmp    80104ff0 <release>
80103729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103730:	83 ec 0c             	sub    $0xc,%esp
80103733:	53                   	push   %ebx
80103734:	e8 b7 18 00 00       	call   80104ff0 <release>
    kfree((char*)p);
80103739:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010373c:	83 c4 10             	add    $0x10,%esp
}
8010373f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103742:	5b                   	pop    %ebx
80103743:	5e                   	pop    %esi
80103744:	5d                   	pop    %ebp
    kfree((char*)p);
80103745:	e9 a6 ec ff ff       	jmp    801023f0 <kfree>
8010374a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103750:	83 ec 0c             	sub    $0xc,%esp
80103753:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103759:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103760:	00 00 00 
    wakeup(&p->nwrite);
80103763:	50                   	push   %eax
80103764:	e8 87 13 00 00       	call   80104af0 <wakeup>
80103769:	83 c4 10             	add    $0x10,%esp
8010376c:	eb 99                	jmp    80103707 <pipeclose+0x37>
8010376e:	66 90                	xchg   %ax,%ax

80103770 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	57                   	push   %edi
80103774:	56                   	push   %esi
80103775:	53                   	push   %ebx
80103776:	83 ec 28             	sub    $0x28,%esp
80103779:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010377c:	53                   	push   %ebx
8010377d:	e8 ae 17 00 00       	call   80104f30 <acquire>
  for(i = 0; i < n; i++){
80103782:	8b 45 10             	mov    0x10(%ebp),%eax
80103785:	83 c4 10             	add    $0x10,%esp
80103788:	85 c0                	test   %eax,%eax
8010378a:	0f 8e c8 00 00 00    	jle    80103858 <pipewrite+0xe8>
80103790:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103793:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103799:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010379f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801037a2:	03 4d 10             	add    0x10(%ebp),%ecx
801037a5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037a8:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801037ae:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801037b4:	39 d0                	cmp    %edx,%eax
801037b6:	75 71                	jne    80103829 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
801037b8:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801037be:	85 c0                	test   %eax,%eax
801037c0:	74 4e                	je     80103810 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801037c2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801037c8:	eb 3a                	jmp    80103804 <pipewrite+0x94>
801037ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
801037d0:	83 ec 0c             	sub    $0xc,%esp
801037d3:	57                   	push   %edi
801037d4:	e8 17 13 00 00       	call   80104af0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801037d9:	5a                   	pop    %edx
801037da:	59                   	pop    %ecx
801037db:	53                   	push   %ebx
801037dc:	56                   	push   %esi
801037dd:	e8 4e 11 00 00       	call   80104930 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037e2:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801037e8:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801037ee:	83 c4 10             	add    $0x10,%esp
801037f1:	05 00 02 00 00       	add    $0x200,%eax
801037f6:	39 c2                	cmp    %eax,%edx
801037f8:	75 36                	jne    80103830 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801037fa:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103800:	85 c0                	test   %eax,%eax
80103802:	74 0c                	je     80103810 <pipewrite+0xa0>
80103804:	e8 97 04 00 00       	call   80103ca0 <myproc>
80103809:	8b 40 24             	mov    0x24(%eax),%eax
8010380c:	85 c0                	test   %eax,%eax
8010380e:	74 c0                	je     801037d0 <pipewrite+0x60>
        release(&p->lock);
80103810:	83 ec 0c             	sub    $0xc,%esp
80103813:	53                   	push   %ebx
80103814:	e8 d7 17 00 00       	call   80104ff0 <release>
        return -1;
80103819:	83 c4 10             	add    $0x10,%esp
8010381c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103821:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103824:	5b                   	pop    %ebx
80103825:	5e                   	pop    %esi
80103826:	5f                   	pop    %edi
80103827:	5d                   	pop    %ebp
80103828:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103829:	89 c2                	mov    %eax,%edx
8010382b:	90                   	nop
8010382c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103830:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103833:	8d 42 01             	lea    0x1(%edx),%eax
80103836:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010383c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103842:	0f b6 0e             	movzbl (%esi),%ecx
80103845:	83 c6 01             	add    $0x1,%esi
80103848:	89 75 e4             	mov    %esi,-0x1c(%ebp)
8010384b:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
8010384f:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103852:	0f 85 50 ff ff ff    	jne    801037a8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103858:	83 ec 0c             	sub    $0xc,%esp
8010385b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103861:	50                   	push   %eax
80103862:	e8 89 12 00 00       	call   80104af0 <wakeup>
  release(&p->lock);
80103867:	89 1c 24             	mov    %ebx,(%esp)
8010386a:	e8 81 17 00 00       	call   80104ff0 <release>
  return n;
8010386f:	83 c4 10             	add    $0x10,%esp
80103872:	8b 45 10             	mov    0x10(%ebp),%eax
80103875:	eb aa                	jmp    80103821 <pipewrite+0xb1>
80103877:	89 f6                	mov    %esi,%esi
80103879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103880 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	57                   	push   %edi
80103884:	56                   	push   %esi
80103885:	53                   	push   %ebx
80103886:	83 ec 18             	sub    $0x18,%esp
80103889:	8b 75 08             	mov    0x8(%ebp),%esi
8010388c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010388f:	56                   	push   %esi
80103890:	e8 9b 16 00 00       	call   80104f30 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103895:	83 c4 10             	add    $0x10,%esp
80103898:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010389e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801038a4:	75 6a                	jne    80103910 <piperead+0x90>
801038a6:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
801038ac:	85 db                	test   %ebx,%ebx
801038ae:	0f 84 c4 00 00 00    	je     80103978 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801038b4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801038ba:	eb 2d                	jmp    801038e9 <piperead+0x69>
801038bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038c0:	83 ec 08             	sub    $0x8,%esp
801038c3:	56                   	push   %esi
801038c4:	53                   	push   %ebx
801038c5:	e8 66 10 00 00       	call   80104930 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801038ca:	83 c4 10             	add    $0x10,%esp
801038cd:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801038d3:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801038d9:	75 35                	jne    80103910 <piperead+0x90>
801038db:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801038e1:	85 d2                	test   %edx,%edx
801038e3:	0f 84 8f 00 00 00    	je     80103978 <piperead+0xf8>
    if(myproc()->killed){
801038e9:	e8 b2 03 00 00       	call   80103ca0 <myproc>
801038ee:	8b 48 24             	mov    0x24(%eax),%ecx
801038f1:	85 c9                	test   %ecx,%ecx
801038f3:	74 cb                	je     801038c0 <piperead+0x40>
      release(&p->lock);
801038f5:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801038f8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801038fd:	56                   	push   %esi
801038fe:	e8 ed 16 00 00       	call   80104ff0 <release>
      return -1;
80103903:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103906:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103909:	89 d8                	mov    %ebx,%eax
8010390b:	5b                   	pop    %ebx
8010390c:	5e                   	pop    %esi
8010390d:	5f                   	pop    %edi
8010390e:	5d                   	pop    %ebp
8010390f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103910:	8b 45 10             	mov    0x10(%ebp),%eax
80103913:	85 c0                	test   %eax,%eax
80103915:	7e 61                	jle    80103978 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103917:	31 db                	xor    %ebx,%ebx
80103919:	eb 13                	jmp    8010392e <piperead+0xae>
8010391b:	90                   	nop
8010391c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103920:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103926:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010392c:	74 1f                	je     8010394d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010392e:	8d 41 01             	lea    0x1(%ecx),%eax
80103931:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103937:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010393d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103942:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103945:	83 c3 01             	add    $0x1,%ebx
80103948:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010394b:	75 d3                	jne    80103920 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010394d:	83 ec 0c             	sub    $0xc,%esp
80103950:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103956:	50                   	push   %eax
80103957:	e8 94 11 00 00       	call   80104af0 <wakeup>
  release(&p->lock);
8010395c:	89 34 24             	mov    %esi,(%esp)
8010395f:	e8 8c 16 00 00       	call   80104ff0 <release>
  return i;
80103964:	83 c4 10             	add    $0x10,%esp
}
80103967:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010396a:	89 d8                	mov    %ebx,%eax
8010396c:	5b                   	pop    %ebx
8010396d:	5e                   	pop    %esi
8010396e:	5f                   	pop    %edi
8010396f:	5d                   	pop    %ebp
80103970:	c3                   	ret    
80103971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p->nread == p->nwrite)
80103978:	31 db                	xor    %ebx,%ebx
8010397a:	eb d1                	jmp    8010394d <piperead+0xcd>
8010397c:	66 90                	xchg   %ax,%ax
8010397e:	66 90                	xchg   %ax,%ax

80103980 <wakeup1>:
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103980:	ba 98 bd 14 80       	mov    $0x8014bd98,%edx
80103985:	eb 17                	jmp    8010399e <wakeup1+0x1e>
80103987:	89 f6                	mov    %esi,%esi
80103989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80103990:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80103996:	81 fa 98 e0 14 80    	cmp    $0x8014e098,%edx
8010399c:	74 5e                	je     801039fc <wakeup1+0x7c>
    if(p->state == SLEEPING && p->chan == chan) {
8010399e:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
801039a2:	75 ec                	jne    80103990 <wakeup1+0x10>
801039a4:	39 42 20             	cmp    %eax,0x20(%edx)
801039a7:	75 e7                	jne    80103990 <wakeup1+0x10>
      p->state = RUNNABLE;
801039a9:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  p->whichQueue = placementQueue;
801039b0:	c7 82 84 00 00 00 00 	movl   $0x0,0x84(%edx)
801039b7:	00 00 00 
  p->prev = NULL;
801039ba:	c7 82 80 00 00 00 00 	movl   $0x0,0x80(%edx)
801039c1:	00 00 00 
  p->next = NULL;
801039c4:	c7 42 7c 00 00 00 00 	movl   $0x0,0x7c(%edx)
  p->pticks = 0;
801039cb:	c7 82 88 00 00 00 00 	movl   $0x0,0x88(%edx)
801039d2:	00 00 00 
  if (ptable.queues[placementQueue] == NULL) {
801039d5:	8b 0d 9c e0 14 80    	mov    0x8014e09c,%ecx
801039db:	85 c9                	test   %ecx,%ecx
801039dd:	74 09                	je     801039e8 <wakeup1+0x68>
    p->next = ptable.queues[placementQueue];
801039df:	89 4a 7c             	mov    %ecx,0x7c(%edx)
    ptable.queues[placementQueue]->prev = p;
801039e2:	89 91 80 00 00 00    	mov    %edx,0x80(%ecx)
    ptable.queues[placementQueue] = p;
801039e8:	89 15 9c e0 14 80    	mov    %edx,0x8014e09c
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039ee:	81 c2 8c 00 00 00    	add    $0x8c,%edx
801039f4:	81 fa 98 e0 14 80    	cmp    $0x8014e098,%edx
801039fa:	75 a2                	jne    8010399e <wakeup1+0x1e>
      queueProc(p, 0);
    }
}
801039fc:	c3                   	ret    
801039fd:	8d 76 00             	lea    0x0(%esi),%esi

80103a00 <allocproc>:
{
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a04:	bb 98 bd 14 80       	mov    $0x8014bd98,%ebx
{
80103a09:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103a0c:	68 64 bd 14 80       	push   $0x8014bd64
80103a11:	e8 1a 15 00 00       	call   80104f30 <acquire>
80103a16:	83 c4 10             	add    $0x10,%esp
80103a19:	eb 13                	jmp    80103a2e <allocproc+0x2e>
80103a1b:	90                   	nop
80103a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a20:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103a26:	81 fb 98 e0 14 80    	cmp    $0x8014e098,%ebx
80103a2c:	74 7a                	je     80103aa8 <allocproc+0xa8>
    if(p->state == UNUSED)
80103a2e:	8b 43 0c             	mov    0xc(%ebx),%eax
80103a31:	85 c0                	test   %eax,%eax
80103a33:	75 eb                	jne    80103a20 <allocproc+0x20>
  p->pid = nextpid++;
80103a35:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  release(&ptable.lock);
80103a3a:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103a3d:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103a44:	89 43 10             	mov    %eax,0x10(%ebx)
80103a47:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103a4a:	68 64 bd 14 80       	push   $0x8014bd64
  p->pid = nextpid++;
80103a4f:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103a55:	e8 96 15 00 00       	call   80104ff0 <release>
  if((p->kstack = kalloc()) == 0){
80103a5a:	e8 d1 eb ff ff       	call   80102630 <kalloc>
80103a5f:	83 c4 10             	add    $0x10,%esp
80103a62:	89 43 08             	mov    %eax,0x8(%ebx)
80103a65:	85 c0                	test   %eax,%eax
80103a67:	74 58                	je     80103ac1 <allocproc+0xc1>
  sp -= sizeof *p->tf;
80103a69:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  memset(p->context, 0, sizeof *p->context);
80103a6f:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103a72:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103a77:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103a7a:	c7 40 14 02 62 10 80 	movl   $0x80106202,0x14(%eax)
  p->context = (struct context*)sp;
80103a81:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103a84:	6a 14                	push   $0x14
80103a86:	6a 00                	push   $0x0
80103a88:	50                   	push   %eax
80103a89:	e8 b2 15 00 00       	call   80105040 <memset>
  p->context->eip = (uint)forkret;
80103a8e:	8b 43 1c             	mov    0x1c(%ebx),%eax
  return p;
80103a91:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103a94:	c7 40 10 e0 3a 10 80 	movl   $0x80103ae0,0x10(%eax)
}
80103a9b:	89 d8                	mov    %ebx,%eax
80103a9d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103aa0:	c9                   	leave  
80103aa1:	c3                   	ret    
80103aa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103aa8:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103aab:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103aad:	68 64 bd 14 80       	push   $0x8014bd64
80103ab2:	e8 39 15 00 00       	call   80104ff0 <release>
}
80103ab7:	89 d8                	mov    %ebx,%eax
  return 0;
80103ab9:	83 c4 10             	add    $0x10,%esp
}
80103abc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103abf:	c9                   	leave  
80103ac0:	c3                   	ret    
    p->state = UNUSED;
80103ac1:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103ac8:	31 db                	xor    %ebx,%ebx
}
80103aca:	89 d8                	mov    %ebx,%eax
80103acc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103acf:	c9                   	leave  
80103ad0:	c3                   	ret    
80103ad1:	eb 0d                	jmp    80103ae0 <forkret>
80103ad3:	90                   	nop
80103ad4:	90                   	nop
80103ad5:	90                   	nop
80103ad6:	90                   	nop
80103ad7:	90                   	nop
80103ad8:	90                   	nop
80103ad9:	90                   	nop
80103ada:	90                   	nop
80103adb:	90                   	nop
80103adc:	90                   	nop
80103add:	90                   	nop
80103ade:	90                   	nop
80103adf:	90                   	nop

80103ae0 <forkret>:
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	83 ec 14             	sub    $0x14,%esp
  release(&ptable.lock);
80103ae6:	68 64 bd 14 80       	push   $0x8014bd64
80103aeb:	e8 00 15 00 00       	call   80104ff0 <release>
  if (first) {
80103af0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103af5:	83 c4 10             	add    $0x10,%esp
80103af8:	85 c0                	test   %eax,%eax
80103afa:	75 04                	jne    80103b00 <forkret+0x20>
}
80103afc:	c9                   	leave  
80103afd:	c3                   	ret    
80103afe:	66 90                	xchg   %ax,%ax
    first = 0;
80103b00:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103b07:	00 00 00 
    iinit(ROOTDEV);
80103b0a:	83 ec 0c             	sub    $0xc,%esp
80103b0d:	6a 01                	push   $0x1
80103b0f:	e8 0c da ff ff       	call   80101520 <iinit>
    initlog(ROOTDEV);
80103b14:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103b1b:	e8 60 f3 ff ff       	call   80102e80 <initlog>
80103b20:	83 c4 10             	add    $0x10,%esp
}
80103b23:	c9                   	leave  
80103b24:	c3                   	ret    
80103b25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b30 <rand>:
  return rseed = (rseed * 1103515245 + 17666) % 999999999;
80103b30:	69 0d 08 b0 10 80 6d 	imul   $0x41c64e6d,0x8010b008,%ecx
80103b37:	4e c6 41 
80103b3a:	ba d1 17 5c 22       	mov    $0x225c17d1,%edx
80103b3f:	81 c1 02 45 00 00    	add    $0x4502,%ecx
80103b45:	89 c8                	mov    %ecx,%eax
80103b47:	f7 e2                	mul    %edx
80103b49:	89 d0                	mov    %edx,%eax
80103b4b:	c1 e8 1b             	shr    $0x1b,%eax
80103b4e:	69 c0 ff c9 9a 3b    	imul   $0x3b9ac9ff,%eax,%eax
80103b54:	29 c1                	sub    %eax,%ecx
80103b56:	89 c8                	mov    %ecx,%eax
80103b58:	89 0d 08 b0 10 80    	mov    %ecx,0x8010b008
}
80103b5e:	c3                   	ret    
80103b5f:	90                   	nop

80103b60 <getRandomIndex>:
  return rseed = (rseed * 1103515245 + 17666) % 999999999;
80103b60:	69 0d 08 b0 10 80 6d 	imul   $0x41c64e6d,0x8010b008,%ecx
80103b67:	4e c6 41 
80103b6a:	ba d1 17 5c 22       	mov    $0x225c17d1,%edx
uint getRandomIndex(uint maxIndex) {
80103b6f:	55                   	push   %ebp
  return rseed = (rseed * 1103515245 + 17666) % 999999999;
80103b70:	81 c1 02 45 00 00    	add    $0x4502,%ecx
uint getRandomIndex(uint maxIndex) {
80103b76:	89 e5                	mov    %esp,%ebp
  return rseed = (rseed * 1103515245 + 17666) % 999999999;
80103b78:	89 c8                	mov    %ecx,%eax
80103b7a:	f7 e2                	mul    %edx
80103b7c:	89 d0                	mov    %edx,%eax
    return rand() % (maxIndex+1);
80103b7e:	8b 55 08             	mov    0x8(%ebp),%edx
}
80103b81:	5d                   	pop    %ebp
  return rseed = (rseed * 1103515245 + 17666) % 999999999;
80103b82:	c1 e8 1b             	shr    $0x1b,%eax
80103b85:	69 c0 ff c9 9a 3b    	imul   $0x3b9ac9ff,%eax,%eax
80103b8b:	29 c1                	sub    %eax,%ecx
80103b8d:	89 c8                	mov    %ecx,%eax
80103b8f:	89 0d 08 b0 10 80    	mov    %ecx,0x8010b008
    return rand() % (maxIndex+1);
80103b95:	8d 4a 01             	lea    0x1(%edx),%ecx
80103b98:	31 d2                	xor    %edx,%edx
80103b9a:	f7 f1                	div    %ecx
}
80103b9c:	89 d0                	mov    %edx,%eax
80103b9e:	c3                   	ret    
80103b9f:	90                   	nop

80103ba0 <pinit>:
{
80103ba0:	55                   	push   %ebp
80103ba1:	89 e5                	mov    %esp,%ebp
80103ba3:	83 ec 10             	sub    $0x10,%esp
  ptable.whichScheduler = 2;
80103ba6:	c7 05 60 bd 14 80 02 	movl   $0x2,0x8014bd60
80103bad:	00 00 00 
  initlock(&ptable.lock, "ptable");
80103bb0:	68 75 81 10 80       	push   $0x80108175
80103bb5:	68 64 bd 14 80       	push   $0x8014bd64
  ptable.totalCurrentTicks = 0;
80103bba:	c7 05 98 e0 14 80 00 	movl   $0x0,0x8014e098
80103bc1:	00 00 00 
  ptable.queues[0] = NULL;
80103bc4:	c7 05 9c e0 14 80 00 	movl   $0x0,0x8014e09c
80103bcb:	00 00 00 
  ptable.queues[1] = NULL;
80103bce:	c7 05 a0 e0 14 80 00 	movl   $0x0,0x8014e0a0
80103bd5:	00 00 00 
  ptable.queues[2] = NULL;
80103bd8:	c7 05 a4 e0 14 80 00 	movl   $0x0,0x8014e0a4
80103bdf:	00 00 00 
  ptable.queues[3] = NULL;
80103be2:	c7 05 a8 e0 14 80 00 	movl   $0x0,0x8014e0a8
80103be9:	00 00 00 
  initlock(&ptable.lock, "ptable");
80103bec:	e8 df 11 00 00       	call   80104dd0 <initlock>
}
80103bf1:	83 c4 10             	add    $0x10,%esp
80103bf4:	c9                   	leave  
80103bf5:	c3                   	ret    
80103bf6:	8d 76 00             	lea    0x0(%esi),%esi
80103bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c00 <mycpu>:
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	56                   	push   %esi
80103c04:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c05:	9c                   	pushf  
80103c06:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103c07:	f6 c4 02             	test   $0x2,%ah
80103c0a:	75 5d                	jne    80103c69 <mycpu+0x69>
  apicid = lapicid();
80103c0c:	e8 9f ee ff ff       	call   80102ab0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103c11:	8b 35 40 bd 14 80    	mov    0x8014bd40,%esi
80103c17:	85 f6                	test   %esi,%esi
80103c19:	7e 41                	jle    80103c5c <mycpu+0x5c>
    if (cpus[i].apicid == apicid)
80103c1b:	0f b6 15 c0 b7 14 80 	movzbl 0x8014b7c0,%edx
80103c22:	39 d0                	cmp    %edx,%eax
80103c24:	74 2f                	je     80103c55 <mycpu+0x55>
  for (i = 0; i < ncpu; ++i) {
80103c26:	31 d2                	xor    %edx,%edx
80103c28:	90                   	nop
80103c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c30:	83 c2 01             	add    $0x1,%edx
80103c33:	39 f2                	cmp    %esi,%edx
80103c35:	74 25                	je     80103c5c <mycpu+0x5c>
    if (cpus[i].apicid == apicid)
80103c37:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103c3d:	0f b6 99 c0 b7 14 80 	movzbl -0x7feb4840(%ecx),%ebx
80103c44:	39 c3                	cmp    %eax,%ebx
80103c46:	75 e8                	jne    80103c30 <mycpu+0x30>
80103c48:	8d 81 c0 b7 14 80    	lea    -0x7feb4840(%ecx),%eax
}
80103c4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c51:	5b                   	pop    %ebx
80103c52:	5e                   	pop    %esi
80103c53:	5d                   	pop    %ebp
80103c54:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103c55:	b8 c0 b7 14 80       	mov    $0x8014b7c0,%eax
      return &cpus[i];
80103c5a:	eb f2                	jmp    80103c4e <mycpu+0x4e>
  panic("unknown apicid\n");
80103c5c:	83 ec 0c             	sub    $0xc,%esp
80103c5f:	68 7c 81 10 80       	push   $0x8010817c
80103c64:	e8 27 c7 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103c69:	83 ec 0c             	sub    $0xc,%esp
80103c6c:	68 74 82 10 80       	push   $0x80108274
80103c71:	e8 1a c7 ff ff       	call   80100390 <panic>
80103c76:	8d 76 00             	lea    0x0(%esi),%esi
80103c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c80 <cpuid>:
cpuid() {
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103c86:	e8 75 ff ff ff       	call   80103c00 <mycpu>
}
80103c8b:	c9                   	leave  
  return mycpu()-cpus;
80103c8c:	2d c0 b7 14 80       	sub    $0x8014b7c0,%eax
80103c91:	c1 f8 04             	sar    $0x4,%eax
80103c94:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103c9a:	c3                   	ret    
80103c9b:	90                   	nop
80103c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ca0 <myproc>:
myproc(void) {
80103ca0:	55                   	push   %ebp
80103ca1:	89 e5                	mov    %esp,%ebp
80103ca3:	53                   	push   %ebx
80103ca4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103ca7:	e8 94 11 00 00       	call   80104e40 <pushcli>
  c = mycpu();
80103cac:	e8 4f ff ff ff       	call   80103c00 <mycpu>
  p = c->proc;
80103cb1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cb7:	e8 d4 11 00 00       	call   80104e90 <popcli>
}
80103cbc:	83 c4 04             	add    $0x4,%esp
80103cbf:	89 d8                	mov    %ebx,%eax
80103cc1:	5b                   	pop    %ebx
80103cc2:	5d                   	pop    %ebp
80103cc3:	c3                   	ret    
80103cc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103cca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103cd0 <userinit>:
{
80103cd0:	55                   	push   %ebp
80103cd1:	89 e5                	mov    %esp,%ebp
80103cd3:	53                   	push   %ebx
80103cd4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103cd7:	e8 24 fd ff ff       	call   80103a00 <allocproc>
80103cdc:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103cde:	a3 d8 b5 10 80       	mov    %eax,0x8010b5d8
  if((p->pgdir = setupkvm()) == 0)
80103ce3:	e8 08 3b 00 00       	call   801077f0 <setupkvm>
80103ce8:	89 43 04             	mov    %eax,0x4(%ebx)
80103ceb:	85 c0                	test   %eax,%eax
80103ced:	0f 84 fe 00 00 00    	je     80103df1 <userinit+0x121>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103cf3:	83 ec 04             	sub    $0x4,%esp
80103cf6:	68 2c 00 00 00       	push   $0x2c
80103cfb:	68 80 b4 10 80       	push   $0x8010b480
80103d00:	50                   	push   %eax
80103d01:	e8 ca 37 00 00       	call   801074d0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103d06:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103d09:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103d0f:	6a 4c                	push   $0x4c
80103d11:	6a 00                	push   $0x0
80103d13:	ff 73 18             	pushl  0x18(%ebx)
80103d16:	e8 25 13 00 00       	call   80105040 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103d1b:	8b 43 18             	mov    0x18(%ebx),%eax
80103d1e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103d23:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103d26:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103d2b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103d2f:	8b 43 18             	mov    0x18(%ebx),%eax
80103d32:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103d36:	8b 43 18             	mov    0x18(%ebx),%eax
80103d39:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103d3d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103d41:	8b 43 18             	mov    0x18(%ebx),%eax
80103d44:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103d48:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103d4c:	8b 43 18             	mov    0x18(%ebx),%eax
80103d4f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103d56:	8b 43 18             	mov    0x18(%ebx),%eax
80103d59:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103d60:	8b 43 18             	mov    0x18(%ebx),%eax
80103d63:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103d6a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103d6d:	6a 10                	push   $0x10
80103d6f:	68 a5 81 10 80       	push   $0x801081a5
80103d74:	50                   	push   %eax
80103d75:	e8 96 14 00 00       	call   80105210 <safestrcpy>
  p->cwd = namei("/");
80103d7a:	c7 04 24 ae 81 10 80 	movl   $0x801081ae,(%esp)
80103d81:	e8 3a e2 ff ff       	call   80101fc0 <namei>
80103d86:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103d89:	c7 04 24 64 bd 14 80 	movl   $0x8014bd64,(%esp)
80103d90:	e8 9b 11 00 00       	call   80104f30 <acquire>
  p->state = RUNNABLE;
80103d95:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  if (ptable.queues[placementQueue] == NULL) {
80103d9c:	83 c4 10             	add    $0x10,%esp
  p->whichQueue = placementQueue;
80103d9f:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103da6:	00 00 00 
  p->prev = NULL;
80103da9:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103db0:	00 00 00 
  p->next = NULL;
80103db3:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
  p->pticks = 0;
80103dba:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103dc1:	00 00 00 
  if (ptable.queues[placementQueue] == NULL) {
80103dc4:	a1 9c e0 14 80       	mov    0x8014e09c,%eax
80103dc9:	85 c0                	test   %eax,%eax
80103dcb:	74 09                	je     80103dd6 <userinit+0x106>
    p->next = ptable.queues[placementQueue];
80103dcd:	89 43 7c             	mov    %eax,0x7c(%ebx)
    ptable.queues[placementQueue]->prev = p;
80103dd0:	89 98 80 00 00 00    	mov    %ebx,0x80(%eax)
  release(&ptable.lock);
80103dd6:	83 ec 0c             	sub    $0xc,%esp
    ptable.queues[placementQueue] = p;
80103dd9:	89 1d 9c e0 14 80    	mov    %ebx,0x8014e09c
  release(&ptable.lock);
80103ddf:	68 64 bd 14 80       	push   $0x8014bd64
80103de4:	e8 07 12 00 00       	call   80104ff0 <release>
}
80103de9:	83 c4 10             	add    $0x10,%esp
80103dec:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103def:	c9                   	leave  
80103df0:	c3                   	ret    
    panic("userinit: out of memory?");
80103df1:	83 ec 0c             	sub    $0xc,%esp
80103df4:	68 8c 81 10 80       	push   $0x8010818c
80103df9:	e8 92 c5 ff ff       	call   80100390 <panic>
80103dfe:	66 90                	xchg   %ax,%ax

80103e00 <growproc>:
{
80103e00:	55                   	push   %ebp
80103e01:	89 e5                	mov    %esp,%ebp
80103e03:	56                   	push   %esi
80103e04:	53                   	push   %ebx
80103e05:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103e08:	e8 33 10 00 00       	call   80104e40 <pushcli>
  c = mycpu();
80103e0d:	e8 ee fd ff ff       	call   80103c00 <mycpu>
  p = c->proc;
80103e12:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e18:	e8 73 10 00 00       	call   80104e90 <popcli>
  sz = curproc->sz;
80103e1d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103e1f:	85 f6                	test   %esi,%esi
80103e21:	7f 1d                	jg     80103e40 <growproc+0x40>
  } else if(n < 0){
80103e23:	75 3b                	jne    80103e60 <growproc+0x60>
  switchuvm(curproc);
80103e25:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103e28:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103e2a:	53                   	push   %ebx
80103e2b:	e8 90 35 00 00       	call   801073c0 <switchuvm>
  return 0;
80103e30:	83 c4 10             	add    $0x10,%esp
80103e33:	31 c0                	xor    %eax,%eax
}
80103e35:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e38:	5b                   	pop    %ebx
80103e39:	5e                   	pop    %esi
80103e3a:	5d                   	pop    %ebp
80103e3b:	c3                   	ret    
80103e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103e40:	83 ec 04             	sub    $0x4,%esp
80103e43:	01 c6                	add    %eax,%esi
80103e45:	56                   	push   %esi
80103e46:	50                   	push   %eax
80103e47:	ff 73 04             	pushl  0x4(%ebx)
80103e4a:	e8 c1 37 00 00       	call   80107610 <allocuvm>
80103e4f:	83 c4 10             	add    $0x10,%esp
80103e52:	85 c0                	test   %eax,%eax
80103e54:	75 cf                	jne    80103e25 <growproc+0x25>
      return -1;
80103e56:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e5b:	eb d8                	jmp    80103e35 <growproc+0x35>
80103e5d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103e60:	83 ec 04             	sub    $0x4,%esp
80103e63:	01 c6                	add    %eax,%esi
80103e65:	56                   	push   %esi
80103e66:	50                   	push   %eax
80103e67:	ff 73 04             	pushl  0x4(%ebx)
80103e6a:	e8 d1 38 00 00       	call   80107740 <deallocuvm>
80103e6f:	83 c4 10             	add    $0x10,%esp
80103e72:	85 c0                	test   %eax,%eax
80103e74:	75 af                	jne    80103e25 <growproc+0x25>
80103e76:	eb de                	jmp    80103e56 <growproc+0x56>
80103e78:	90                   	nop
80103e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103e80 <fork>:
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	57                   	push   %edi
80103e84:	56                   	push   %esi
80103e85:	53                   	push   %ebx
80103e86:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103e89:	e8 b2 0f 00 00       	call   80104e40 <pushcli>
  c = mycpu();
80103e8e:	e8 6d fd ff ff       	call   80103c00 <mycpu>
  p = c->proc;
80103e93:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80103e99:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  popcli();
80103e9c:	e8 ef 0f 00 00       	call   80104e90 <popcli>
  if((np = allocproc()) == 0){
80103ea1:	e8 5a fb ff ff       	call   80103a00 <allocproc>
80103ea6:	85 c0                	test   %eax,%eax
80103ea8:	0f 84 06 01 00 00    	je     80103fb4 <fork+0x134>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103eae:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103eb1:	83 ec 08             	sub    $0x8,%esp
80103eb4:	89 c3                	mov    %eax,%ebx
80103eb6:	ff 32                	pushl  (%edx)
80103eb8:	ff 72 04             	pushl  0x4(%edx)
80103ebb:	e8 00 3a 00 00       	call   801078c0 <copyuvm>
80103ec0:	83 c4 10             	add    $0x10,%esp
80103ec3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ec6:	85 c0                	test   %eax,%eax
80103ec8:	89 43 04             	mov    %eax,0x4(%ebx)
80103ecb:	0f 84 ea 00 00 00    	je     80103fbb <fork+0x13b>
  np->sz = curproc->sz;
80103ed1:	8b 02                	mov    (%edx),%eax
  *np->tf = *curproc->tf;
80103ed3:	8b 7b 18             	mov    0x18(%ebx),%edi
  np->parent = curproc;
80103ed6:	89 53 14             	mov    %edx,0x14(%ebx)
  *np->tf = *curproc->tf;
80103ed9:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
80103ede:	89 03                	mov    %eax,(%ebx)
  *np->tf = *curproc->tf;
80103ee0:	8b 72 18             	mov    0x18(%edx),%esi
80103ee3:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103ee5:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103ee7:	8b 43 18             	mov    0x18(%ebx),%eax
80103eea:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103ef1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103ef8:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
80103efc:	85 c0                	test   %eax,%eax
80103efe:	74 16                	je     80103f16 <fork+0x96>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103f00:	83 ec 0c             	sub    $0xc,%esp
80103f03:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103f06:	50                   	push   %eax
80103f07:	e8 64 cf ff ff       	call   80100e70 <filedup>
80103f0c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103f0f:	83 c4 10             	add    $0x10,%esp
80103f12:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103f16:	83 c6 01             	add    $0x1,%esi
80103f19:	83 fe 10             	cmp    $0x10,%esi
80103f1c:	75 da                	jne    80103ef8 <fork+0x78>
  np->cwd = idup(curproc->cwd);
80103f1e:	83 ec 0c             	sub    $0xc,%esp
80103f21:	ff 72 68             	pushl  0x68(%edx)
80103f24:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103f27:	e8 c4 d7 ff ff       	call   801016f0 <idup>
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103f2c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103f2f:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103f32:	89 43 68             	mov    %eax,0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103f35:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103f38:	83 c2 6c             	add    $0x6c,%edx
80103f3b:	6a 10                	push   $0x10
80103f3d:	52                   	push   %edx
80103f3e:	50                   	push   %eax
80103f3f:	e8 cc 12 00 00       	call   80105210 <safestrcpy>
  pid = np->pid;
80103f44:	8b 73 10             	mov    0x10(%ebx),%esi
  acquire(&ptable.lock);
80103f47:	c7 04 24 64 bd 14 80 	movl   $0x8014bd64,(%esp)
80103f4e:	e8 dd 0f 00 00       	call   80104f30 <acquire>
  np->state = RUNNABLE;
80103f53:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  if (ptable.queues[placementQueue] == NULL) {
80103f5a:	83 c4 10             	add    $0x10,%esp
  p->whichQueue = placementQueue;
80103f5d:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103f64:	00 00 00 
  p->prev = NULL;
80103f67:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103f6e:	00 00 00 
  p->next = NULL;
80103f71:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
  p->pticks = 0;
80103f78:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103f7f:	00 00 00 
  if (ptable.queues[placementQueue] == NULL) {
80103f82:	a1 9c e0 14 80       	mov    0x8014e09c,%eax
80103f87:	85 c0                	test   %eax,%eax
80103f89:	74 09                	je     80103f94 <fork+0x114>
    p->next = ptable.queues[placementQueue];
80103f8b:	89 43 7c             	mov    %eax,0x7c(%ebx)
    ptable.queues[placementQueue]->prev = p;
80103f8e:	89 98 80 00 00 00    	mov    %ebx,0x80(%eax)
  release(&ptable.lock);
80103f94:	83 ec 0c             	sub    $0xc,%esp
    ptable.queues[placementQueue] = p;
80103f97:	89 1d 9c e0 14 80    	mov    %ebx,0x8014e09c
  release(&ptable.lock);
80103f9d:	68 64 bd 14 80       	push   $0x8014bd64
80103fa2:	e8 49 10 00 00       	call   80104ff0 <release>
  return pid;
80103fa7:	83 c4 10             	add    $0x10,%esp
}
80103faa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103fad:	89 f0                	mov    %esi,%eax
80103faf:	5b                   	pop    %ebx
80103fb0:	5e                   	pop    %esi
80103fb1:	5f                   	pop    %edi
80103fb2:	5d                   	pop    %ebp
80103fb3:	c3                   	ret    
    return -1;
80103fb4:	be ff ff ff ff       	mov    $0xffffffff,%esi
80103fb9:	eb ef                	jmp    80103faa <fork+0x12a>
    kfree(np->kstack);
80103fbb:	83 ec 0c             	sub    $0xc,%esp
80103fbe:	ff 73 08             	pushl  0x8(%ebx)
    return -1;
80103fc1:	be ff ff ff ff       	mov    $0xffffffff,%esi
    kfree(np->kstack);
80103fc6:	e8 25 e4 ff ff       	call   801023f0 <kfree>
    np->kstack = 0;
80103fcb:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103fd2:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103fd5:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103fdc:	eb cc                	jmp    80103faa <fork+0x12a>
80103fde:	66 90                	xchg   %ax,%ax

80103fe0 <changeScheduler>:
int changeScheduler() {
80103fe0:	55                   	push   %ebp
80103fe1:	89 e5                	mov    %esp,%ebp
80103fe3:	53                   	push   %ebx
80103fe4:	83 ec 10             	sub    $0x10,%esp
    acquire(&ptable.lock);
80103fe7:	68 64 bd 14 80       	push   $0x8014bd64
80103fec:	e8 3f 0f 00 00       	call   80104f30 <acquire>
    ptable.whichScheduler = (ptable.whichScheduler + 1) % 3;
80103ff1:	a1 60 bd 14 80       	mov    0x8014bd60,%eax
80103ff6:	ba 56 55 55 55       	mov    $0x55555556,%edx
    release(&ptable.lock);
80103ffb:	c7 04 24 64 bd 14 80 	movl   $0x8014bd64,(%esp)
    ptable.whichScheduler = (ptable.whichScheduler + 1) % 3;
80104002:	8d 48 01             	lea    0x1(%eax),%ecx
80104005:	89 c8                	mov    %ecx,%eax
80104007:	f7 ea                	imul   %edx
80104009:	89 c8                	mov    %ecx,%eax
8010400b:	c1 f8 1f             	sar    $0x1f,%eax
8010400e:	29 c2                	sub    %eax,%edx
80104010:	8d 04 52             	lea    (%edx,%edx,2),%eax
80104013:	29 c1                	sub    %eax,%ecx
80104015:	89 cb                	mov    %ecx,%ebx
80104017:	89 0d 60 bd 14 80    	mov    %ecx,0x8014bd60
    release(&ptable.lock);
8010401d:	e8 ce 0f 00 00       	call   80104ff0 <release>
}
80104022:	89 d8                	mov    %ebx,%eax
80104024:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104027:	c9                   	leave  
80104028:	c3                   	ret    
80104029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104030 <getRandomRunnableProccess>:
struct proc* getRandomRunnableProccess() {
80104030:	55                   	push   %ebp
  uint totalRunnableProcesses = 0;
80104031:	31 d2                	xor    %edx,%edx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104033:	b8 98 bd 14 80       	mov    $0x8014bd98,%eax
struct proc* getRandomRunnableProccess() {
80104038:	89 e5                	mov    %esp,%ebp
8010403a:	53                   	push   %ebx
8010403b:	81 ec 00 01 00 00    	sub    $0x100,%esp
80104041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == RUNNABLE) {
80104048:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
8010404c:	75 0c                	jne    8010405a <getRandomRunnableProccess+0x2a>
      runnableProccess[maxIndex] = p;
8010404e:	89 84 95 fc fe ff ff 	mov    %eax,-0x104(%ebp,%edx,4)
      totalRunnableProcesses++;
80104055:	89 d1                	mov    %edx,%ecx
80104057:	83 c2 01             	add    $0x1,%edx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010405a:	05 8c 00 00 00       	add    $0x8c,%eax
8010405f:	3d 98 e0 14 80       	cmp    $0x8014e098,%eax
80104064:	75 e2                	jne    80104048 <getRandomRunnableProccess+0x18>
    return (struct proc*)-1;
80104066:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if (totalRunnableProcesses == 0) {
8010406b:	85 d2                	test   %edx,%edx
8010406d:	75 09                	jne    80104078 <getRandomRunnableProccess+0x48>
}
8010406f:	81 c4 00 01 00 00    	add    $0x100,%esp
80104075:	5b                   	pop    %ebx
80104076:	5d                   	pop    %ebp
80104077:	c3                   	ret    
  return rseed = (rseed * 1103515245 + 17666) % 999999999;
80104078:	69 1d 08 b0 10 80 6d 	imul   $0x41c64e6d,0x8010b008,%ebx
8010407f:	4e c6 41 
80104082:	ba d1 17 5c 22       	mov    $0x225c17d1,%edx
    return rand() % (maxIndex+1);
80104087:	83 c1 01             	add    $0x1,%ecx
  return rseed = (rseed * 1103515245 + 17666) % 999999999;
8010408a:	81 c3 02 45 00 00    	add    $0x4502,%ebx
80104090:	89 d8                	mov    %ebx,%eax
80104092:	f7 e2                	mul    %edx
80104094:	89 d0                	mov    %edx,%eax
    return rand() % (maxIndex+1);
80104096:	31 d2                	xor    %edx,%edx
  return rseed = (rseed * 1103515245 + 17666) % 999999999;
80104098:	c1 e8 1b             	shr    $0x1b,%eax
8010409b:	69 c0 ff c9 9a 3b    	imul   $0x3b9ac9ff,%eax,%eax
801040a1:	29 c3                	sub    %eax,%ebx
801040a3:	89 d8                	mov    %ebx,%eax
801040a5:	89 1d 08 b0 10 80    	mov    %ebx,0x8010b008
    return rand() % (maxIndex+1);
801040ab:	f7 f1                	div    %ecx
    return runnableProccess[randomIndex];
801040ad:	8b 84 95 fc fe ff ff 	mov    -0x104(%ebp,%edx,4),%eax
}
801040b4:	81 c4 00 01 00 00    	add    $0x100,%esp
801040ba:	5b                   	pop    %ebx
801040bb:	5d                   	pop    %ebp
801040bc:	c3                   	ret    
801040bd:	8d 76 00             	lea    0x0(%esi),%esi

801040c0 <MLFQrunnableProc>:
struct proc* MLFQrunnableProc() {
801040c0:	55                   	push   %ebp
801040c1:	89 e5                	mov    %esp,%ebp
801040c3:	53                   	push   %ebx
  for(int i = 0; i < totalQs; i++) {
801040c4:	31 db                	xor    %ebx,%ebx
struct proc* MLFQrunnableProc() {
801040c6:	83 ec 04             	sub    $0x4,%esp
    for (p = ptable.queues[i]; p != NULL; p = p->next) {
801040c9:	8b 04 9d 9c e0 14 80 	mov    -0x7feb1f64(,%ebx,4),%eax
801040d0:	85 c0                	test   %eax,%eax
801040d2:	75 13                	jne    801040e7 <MLFQrunnableProc+0x27>
801040d4:	eb 2a                	jmp    80104100 <MLFQrunnableProc+0x40>
801040d6:	8d 76 00             	lea    0x0(%esi),%esi
801040d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801040e0:	8b 40 7c             	mov    0x7c(%eax),%eax
801040e3:	85 c0                	test   %eax,%eax
801040e5:	74 19                	je     80104100 <MLFQrunnableProc+0x40>
      if (p->state != RUNNABLE && p->state != RUNNING)
801040e7:	8b 50 0c             	mov    0xc(%eax),%edx
801040ea:	8d 4a fd             	lea    -0x3(%edx),%ecx
801040ed:	83 f9 01             	cmp    $0x1,%ecx
801040f0:	77 1d                	ja     8010410f <MLFQrunnableProc+0x4f>
      if (p->state == RUNNABLE)
801040f2:	83 fa 03             	cmp    $0x3,%edx
801040f5:	75 e9                	jne    801040e0 <MLFQrunnableProc+0x20>
}
801040f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040fa:	c9                   	leave  
801040fb:	c3                   	ret    
801040fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(int i = 0; i < totalQs; i++) {
80104100:	83 c3 01             	add    $0x1,%ebx
80104103:	83 fb 04             	cmp    $0x4,%ebx
80104106:	75 c1                	jne    801040c9 <MLFQrunnableProc+0x9>
  return NULL;
80104108:	31 c0                	xor    %eax,%eax
}
8010410a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010410d:	c9                   	leave  
8010410e:	c3                   	ret    
        panic("MLFQrunnableProc: invalid process in queue\n");
8010410f:	83 ec 0c             	sub    $0xc,%esp
80104112:	68 9c 82 10 80       	push   $0x8010829c
80104117:	e8 74 c2 ff ff       	call   80100390 <panic>
8010411c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104120 <dequeueProc>:
void dequeueProc(struct proc* p) {
80104120:	55                   	push   %ebp
80104121:	89 e5                	mov    %esp,%ebp
80104123:	8b 45 08             	mov    0x8(%ebp),%eax
  if (p == ptable.queues[p->whichQueue]) {
80104126:	8b 90 84 00 00 00    	mov    0x84(%eax),%edx
8010412c:	8b 48 7c             	mov    0x7c(%eax),%ecx
8010412f:	81 c2 cc 08 00 00    	add    $0x8cc,%edx
80104135:	39 04 95 6c bd 14 80 	cmp    %eax,-0x7feb4294(,%edx,4)
8010413c:	74 42                	je     80104180 <dequeueProc+0x60>
    p->prev->next = p->next;
8010413e:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
80104144:	89 4a 7c             	mov    %ecx,0x7c(%edx)
    if (p->next != NULL) 
80104147:	85 c9                	test   %ecx,%ecx
80104149:	74 0c                	je     80104157 <dequeueProc+0x37>
      p->next->prev = p->prev;
8010414b:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
80104151:	89 91 80 00 00 00    	mov    %edx,0x80(%ecx)
  p->whichQueue = -1;
80104157:	c7 80 84 00 00 00 ff 	movl   $0xffffffff,0x84(%eax)
8010415e:	ff ff ff 
  p->prev = NULL;
80104161:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80104168:	00 00 00 
  p->next = NULL;
8010416b:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
  p->pticks = 0;
80104172:	c7 80 88 00 00 00 00 	movl   $0x0,0x88(%eax)
80104179:	00 00 00 
}
8010417c:	5d                   	pop    %ebp
8010417d:	c3                   	ret    
8010417e:	66 90                	xchg   %ax,%ax
    if (p->next == NULL){
80104180:	85 c9                	test   %ecx,%ecx
80104182:	74 1c                	je     801041a0 <dequeueProc+0x80>
      p->next->prev = NULL;
80104184:	c7 81 80 00 00 00 00 	movl   $0x0,0x80(%ecx)
8010418b:	00 00 00 
      ptable.queues[p->whichQueue] = p->next;
8010418e:	8b 90 84 00 00 00    	mov    0x84(%eax),%edx
80104194:	8b 48 7c             	mov    0x7c(%eax),%ecx
80104197:	89 0c 95 9c e0 14 80 	mov    %ecx,-0x7feb1f64(,%edx,4)
8010419e:	eb b7                	jmp    80104157 <dequeueProc+0x37>
      ptable.queues[p->whichQueue] = NULL;
801041a0:	c7 04 95 6c bd 14 80 	movl   $0x0,-0x7feb4294(,%edx,4)
801041a7:	00 00 00 00 
801041ab:	eb aa                	jmp    80104157 <dequeueProc+0x37>
801041ad:	8d 76 00             	lea    0x0(%esi),%esi

801041b0 <roundRobbinScheduler>:
void roundRobbinScheduler() {
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	57                   	push   %edi
801041b4:	56                   	push   %esi
801041b5:	53                   	push   %ebx
801041b6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
801041b9:	e8 42 fa ff ff       	call   80103c00 <mycpu>
  c->proc = 0;
801041be:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801041c5:	00 00 00 
  struct cpu *c = mycpu();
801041c8:	89 c6                	mov    %eax,%esi
  c->proc = 0;
801041ca:	8d 78 04             	lea    0x4(%eax),%edi
  asm volatile("sti");
801041cd:	fb                   	sti    
    acquire(&ptable.lock);
801041ce:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041d1:	bb 98 bd 14 80       	mov    $0x8014bd98,%ebx
    acquire(&ptable.lock);
801041d6:	68 64 bd 14 80       	push   $0x8014bd64
801041db:	e8 50 0d 00 00       	call   80104f30 <acquire>
801041e0:	83 c4 10             	add    $0x10,%esp
801041e3:	eb 11                	jmp    801041f6 <roundRobbinScheduler+0x46>
801041e5:	8d 76 00             	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041e8:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
801041ee:	81 fb 98 e0 14 80    	cmp    $0x8014e098,%ebx
801041f4:	74 6a                	je     80104260 <roundRobbinScheduler+0xb0>
      if(p->state != RUNNABLE)
801041f6:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801041fa:	75 ec                	jne    801041e8 <roundRobbinScheduler+0x38>
      switchuvm(p);
801041fc:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
801041ff:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80104205:	53                   	push   %ebx
80104206:	e8 b5 31 00 00       	call   801073c0 <switchuvm>
      swtch(&(c->scheduler), p->context);
8010420b:	5a                   	pop    %edx
8010420c:	59                   	pop    %ecx
8010420d:	ff 73 1c             	pushl  0x1c(%ebx)
80104210:	57                   	push   %edi
      p->state = RUNNING;
80104211:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104218:	e8 4e 10 00 00       	call   8010526b <swtch>
      switchkvm();
8010421d:	e8 8e 31 00 00       	call   801073b0 <switchkvm>
      if(p->state != RUNNABLE) {
80104222:	83 c4 10             	add    $0x10,%esp
      c->proc = 0;
80104225:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
8010422c:	00 00 00 
      if(p->state != RUNNABLE) {
8010422f:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104233:	74 0c                	je     80104241 <roundRobbinScheduler+0x91>
        dequeueProc(p); // used for MLFQ scheduler
80104235:	83 ec 0c             	sub    $0xc,%esp
80104238:	53                   	push   %ebx
80104239:	e8 e2 fe ff ff       	call   80104120 <dequeueProc>
8010423e:	83 c4 10             	add    $0x10,%esp
      if (ptable.whichScheduler != 0) {
80104241:	a1 60 bd 14 80       	mov    0x8014bd60,%eax
80104246:	85 c0                	test   %eax,%eax
80104248:	74 9e                	je     801041e8 <roundRobbinScheduler+0x38>
        release(&ptable.lock);
8010424a:	83 ec 0c             	sub    $0xc,%esp
8010424d:	68 64 bd 14 80       	push   $0x8014bd64
80104252:	e8 99 0d 00 00       	call   80104ff0 <release>
}
80104257:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010425a:	5b                   	pop    %ebx
8010425b:	5e                   	pop    %esi
8010425c:	5f                   	pop    %edi
8010425d:	5d                   	pop    %ebp
8010425e:	c3                   	ret    
8010425f:	90                   	nop
    release(&ptable.lock);
80104260:	83 ec 0c             	sub    $0xc,%esp
80104263:	68 64 bd 14 80       	push   $0x8014bd64
80104268:	e8 83 0d 00 00       	call   80104ff0 <release>
    sti();
8010426d:	83 c4 10             	add    $0x10,%esp
80104270:	e9 58 ff ff ff       	jmp    801041cd <roundRobbinScheduler+0x1d>
80104275:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104280 <randomScheduler>:
void randomScheduler() {
80104280:	55                   	push   %ebp
80104281:	89 e5                	mov    %esp,%ebp
80104283:	57                   	push   %edi
80104284:	56                   	push   %esi
80104285:	53                   	push   %ebx
80104286:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104289:	e8 72 f9 ff ff       	call   80103c00 <mycpu>
  c->proc = 0;
8010428e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104295:	00 00 00 
  struct cpu *c = mycpu();
80104298:	89 c6                	mov    %eax,%esi
      swtch(&(c->scheduler), p->context);
8010429a:	8d 78 04             	lea    0x4(%eax),%edi
8010429d:	eb 11                	jmp    801042b0 <randomScheduler+0x30>
8010429f:	90                   	nop
    release(&ptable.lock);
801042a0:	83 ec 0c             	sub    $0xc,%esp
801042a3:	68 64 bd 14 80       	push   $0x8014bd64
801042a8:	e8 43 0d 00 00       	call   80104ff0 <release>
    sti();
801042ad:	83 c4 10             	add    $0x10,%esp
801042b0:	fb                   	sti    
    acquire(&ptable.lock);
801042b1:	83 ec 0c             	sub    $0xc,%esp
801042b4:	68 64 bd 14 80       	push   $0x8014bd64
801042b9:	e8 72 0c 00 00       	call   80104f30 <acquire>
    if ((p = getRandomRunnableProccess()) != (struct proc*)-1) {
801042be:	e8 6d fd ff ff       	call   80104030 <getRandomRunnableProccess>
801042c3:	83 c4 10             	add    $0x10,%esp
801042c6:	89 c3                	mov    %eax,%ebx
801042c8:	83 f8 ff             	cmp    $0xffffffff,%eax
801042cb:	74 45                	je     80104312 <randomScheduler+0x92>
      switchuvm(p);
801042cd:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
801042d0:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
      switchuvm(p);
801042d6:	50                   	push   %eax
801042d7:	e8 e4 30 00 00       	call   801073c0 <switchuvm>
      p->state = RUNNING;
801042dc:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
801042e3:	58                   	pop    %eax
801042e4:	5a                   	pop    %edx
801042e5:	ff 73 1c             	pushl  0x1c(%ebx)
801042e8:	57                   	push   %edi
801042e9:	e8 7d 0f 00 00       	call   8010526b <swtch>
      switchkvm();
801042ee:	e8 bd 30 00 00       	call   801073b0 <switchkvm>
      if(p->state != RUNNABLE) {
801042f3:	83 c4 10             	add    $0x10,%esp
      c->proc = 0;
801042f6:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801042fd:	00 00 00 
      if(p->state != RUNNABLE) {
80104300:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104304:	74 0c                	je     80104312 <randomScheduler+0x92>
        dequeueProc(p); // used for MLFQ scheduler
80104306:	83 ec 0c             	sub    $0xc,%esp
80104309:	53                   	push   %ebx
8010430a:	e8 11 fe ff ff       	call   80104120 <dequeueProc>
8010430f:	83 c4 10             	add    $0x10,%esp
    if (ptable.whichScheduler != 1) {
80104312:	83 3d 60 bd 14 80 01 	cmpl   $0x1,0x8014bd60
80104319:	74 85                	je     801042a0 <randomScheduler+0x20>
      release(&ptable.lock);
8010431b:	83 ec 0c             	sub    $0xc,%esp
8010431e:	68 64 bd 14 80       	push   $0x8014bd64
80104323:	e8 c8 0c 00 00       	call   80104ff0 <release>
}
80104328:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010432b:	5b                   	pop    %ebx
8010432c:	5e                   	pop    %esi
8010432d:	5f                   	pop    %edi
8010432e:	5d                   	pop    %ebp
8010432f:	c3                   	ret    

80104330 <MLFQscheduler>:
void MLFQscheduler() {
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	57                   	push   %edi
80104334:	56                   	push   %esi
80104335:	53                   	push   %ebx
80104336:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104339:	e8 c2 f8 ff ff       	call   80103c00 <mycpu>
  c->proc = 0;
8010433e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104345:	00 00 00 
  struct cpu *c = mycpu();
80104348:	89 c6                	mov    %eax,%esi
      swtch(&(c->scheduler), p->context);
8010434a:	8d 78 04             	lea    0x4(%eax),%edi
8010434d:	eb 11                	jmp    80104360 <MLFQscheduler+0x30>
8010434f:	90                   	nop
    release(&ptable.lock);
80104350:	83 ec 0c             	sub    $0xc,%esp
80104353:	68 64 bd 14 80       	push   $0x8014bd64
80104358:	e8 93 0c 00 00       	call   80104ff0 <release>
    sti();
8010435d:	83 c4 10             	add    $0x10,%esp
80104360:	fb                   	sti    
    acquire(&ptable.lock);
80104361:	83 ec 0c             	sub    $0xc,%esp
80104364:	68 64 bd 14 80       	push   $0x8014bd64
80104369:	e8 c2 0b 00 00       	call   80104f30 <acquire>
    if((p = MLFQrunnableProc()) != NULL) {
8010436e:	e8 4d fd ff ff       	call   801040c0 <MLFQrunnableProc>
80104373:	83 c4 10             	add    $0x10,%esp
80104376:	89 c3                	mov    %eax,%ebx
80104378:	85 c0                	test   %eax,%eax
8010437a:	74 45                	je     801043c1 <MLFQscheduler+0x91>
      switchuvm(p);
8010437c:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
8010437f:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
      switchuvm(p);
80104385:	50                   	push   %eax
80104386:	e8 35 30 00 00       	call   801073c0 <switchuvm>
      p->state = RUNNING;
8010438b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104392:	58                   	pop    %eax
80104393:	5a                   	pop    %edx
80104394:	ff 73 1c             	pushl  0x1c(%ebx)
80104397:	57                   	push   %edi
80104398:	e8 ce 0e 00 00       	call   8010526b <swtch>
      switchkvm();
8010439d:	e8 0e 30 00 00       	call   801073b0 <switchkvm>
      if(p->state != RUNNABLE) {
801043a2:	83 c4 10             	add    $0x10,%esp
      c->proc = 0;
801043a5:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801043ac:	00 00 00 
      if(p->state != RUNNABLE) {
801043af:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801043b3:	74 0c                	je     801043c1 <MLFQscheduler+0x91>
        dequeueProc(p); // used for MLFQ scheduler
801043b5:	83 ec 0c             	sub    $0xc,%esp
801043b8:	53                   	push   %ebx
801043b9:	e8 62 fd ff ff       	call   80104120 <dequeueProc>
801043be:	83 c4 10             	add    $0x10,%esp
    if (ptable.whichScheduler != 2) {
801043c1:	83 3d 60 bd 14 80 02 	cmpl   $0x2,0x8014bd60
801043c8:	74 86                	je     80104350 <MLFQscheduler+0x20>
      release(&ptable.lock);
801043ca:	83 ec 0c             	sub    $0xc,%esp
801043cd:	68 64 bd 14 80       	push   $0x8014bd64
801043d2:	e8 19 0c 00 00       	call   80104ff0 <release>
}
801043d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043da:	5b                   	pop    %ebx
801043db:	5e                   	pop    %esi
801043dc:	5f                   	pop    %edi
801043dd:	5d                   	pop    %ebp
801043de:	c3                   	ret    
801043df:	90                   	nop

801043e0 <scheduler>:
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	83 ec 08             	sub    $0x8,%esp
801043e6:	eb 28                	jmp    80104410 <scheduler+0x30>
801043e8:	90                   	nop
801043e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    else if (ptable.whichScheduler == 1) {
801043f0:	83 f8 01             	cmp    $0x1,%eax
801043f3:	74 4b                	je     80104440 <scheduler+0x60>
    else if (ptable.whichScheduler == 2) {
801043f5:	83 f8 02             	cmp    $0x2,%eax
801043f8:	75 66                	jne    80104460 <scheduler+0x80>
      release(&ptable.lock);
801043fa:	83 ec 0c             	sub    $0xc,%esp
801043fd:	68 64 bd 14 80       	push   $0x8014bd64
80104402:	e8 e9 0b 00 00       	call   80104ff0 <release>
      MLFQscheduler();
80104407:	e8 24 ff ff ff       	call   80104330 <MLFQscheduler>
8010440c:	83 c4 10             	add    $0x10,%esp
  asm volatile("cli");
8010440f:	fa                   	cli    
    acquire(&ptable.lock);
80104410:	83 ec 0c             	sub    $0xc,%esp
80104413:	68 64 bd 14 80       	push   $0x8014bd64
80104418:	e8 13 0b 00 00       	call   80104f30 <acquire>
    if (ptable.whichScheduler == 0) {
8010441d:	a1 60 bd 14 80       	mov    0x8014bd60,%eax
80104422:	83 c4 10             	add    $0x10,%esp
80104425:	85 c0                	test   %eax,%eax
80104427:	75 c7                	jne    801043f0 <scheduler+0x10>
      release(&ptable.lock);
80104429:	83 ec 0c             	sub    $0xc,%esp
8010442c:	68 64 bd 14 80       	push   $0x8014bd64
80104431:	e8 ba 0b 00 00       	call   80104ff0 <release>
      roundRobbinScheduler();
80104436:	e8 75 fd ff ff       	call   801041b0 <roundRobbinScheduler>
8010443b:	83 c4 10             	add    $0x10,%esp
8010443e:	eb cf                	jmp    8010440f <scheduler+0x2f>
      release(&ptable.lock);
80104440:	83 ec 0c             	sub    $0xc,%esp
80104443:	68 64 bd 14 80       	push   $0x8014bd64
80104448:	e8 a3 0b 00 00       	call   80104ff0 <release>
      randomScheduler();
8010444d:	e8 2e fe ff ff       	call   80104280 <randomScheduler>
80104452:	83 c4 10             	add    $0x10,%esp
80104455:	eb b8                	jmp    8010440f <scheduler+0x2f>
80104457:	89 f6                	mov    %esi,%esi
80104459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&ptable.lock);
80104460:	83 ec 0c             	sub    $0xc,%esp
80104463:	68 64 bd 14 80       	push   $0x8014bd64
80104468:	e8 83 0b 00 00       	call   80104ff0 <release>
      panic("Unknown scheduler opiton.");
8010446d:	c7 04 24 b0 81 10 80 	movl   $0x801081b0,(%esp)
80104474:	e8 17 bf ff ff       	call   80100390 <panic>
80104479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104480 <queueProc>:
void queueProc(struct proc* p, int placementQueue) {
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	8b 45 08             	mov    0x8(%ebp),%eax
80104486:	8b 55 0c             	mov    0xc(%ebp),%edx
  p->whichQueue = placementQueue;
80104489:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
  if (ptable.queues[placementQueue] == NULL) {
8010448f:	81 c2 cc 08 00 00    	add    $0x8cc,%edx
  p->prev = NULL;
80104495:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010449c:	00 00 00 
  p->next = NULL;
8010449f:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
  p->pticks = 0;
801044a6:	c7 80 88 00 00 00 00 	movl   $0x0,0x88(%eax)
801044ad:	00 00 00 
  if (ptable.queues[placementQueue] == NULL) {
801044b0:	8b 0c 95 6c bd 14 80 	mov    -0x7feb4294(,%edx,4),%ecx
801044b7:	85 c9                	test   %ecx,%ecx
801044b9:	74 09                	je     801044c4 <queueProc+0x44>
    p->next = ptable.queues[placementQueue];
801044bb:	89 48 7c             	mov    %ecx,0x7c(%eax)
    ptable.queues[placementQueue]->prev = p;
801044be:	89 81 80 00 00 00    	mov    %eax,0x80(%ecx)
    ptable.queues[placementQueue] = p;
801044c4:	89 04 95 6c bd 14 80 	mov    %eax,-0x7feb4294(,%edx,4)
}
801044cb:	5d                   	pop    %ebp
801044cc:	c3                   	ret    
801044cd:	8d 76 00             	lea    0x0(%esi),%esi

801044d0 <promoteProcs>:
void promoteProcs() {
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	57                   	push   %edi
  for (int i = 1; i < totalQs; i++) {
801044d4:	bf 01 00 00 00       	mov    $0x1,%edi
void promoteProcs() {
801044d9:	56                   	push   %esi
801044da:	53                   	push   %ebx
801044db:	83 ec 0c             	sub    $0xc,%esp
    p = ptable.queues[i];
801044de:	8b 1c bd 9c e0 14 80 	mov    -0x7feb1f64(,%edi,4),%ebx
    while (p != NULL) {
801044e5:	85 db                	test   %ebx,%ebx
801044e7:	74 59                	je     80104542 <promoteProcs+0x72>
801044e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      dequeueProc(p);
801044f0:	83 ec 0c             	sub    $0xc,%esp
      temp = p->next;
801044f3:	8b 73 7c             	mov    0x7c(%ebx),%esi
      dequeueProc(p);
801044f6:	53                   	push   %ebx
801044f7:	e8 24 fc ff ff       	call   80104120 <dequeueProc>
  p->next = NULL;
801044fc:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
  if (ptable.queues[placementQueue] == NULL) {
80104503:	83 c4 10             	add    $0x10,%esp
  p->whichQueue = placementQueue;
80104506:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
8010450d:	00 00 00 
  p->prev = NULL;
80104510:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80104517:	00 00 00 
  p->pticks = 0;
8010451a:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80104521:	00 00 00 
  if (ptable.queues[placementQueue] == NULL) {
80104524:	a1 9c e0 14 80       	mov    0x8014e09c,%eax
80104529:	85 c0                	test   %eax,%eax
8010452b:	74 09                	je     80104536 <promoteProcs+0x66>
    p->next = ptable.queues[placementQueue];
8010452d:	89 43 7c             	mov    %eax,0x7c(%ebx)
    ptable.queues[placementQueue]->prev = p;
80104530:	89 98 80 00 00 00    	mov    %ebx,0x80(%eax)
    ptable.queues[placementQueue] = p;
80104536:	89 1d 9c e0 14 80    	mov    %ebx,0x8014e09c
8010453c:	89 f3                	mov    %esi,%ebx
    while (p != NULL) {
8010453e:	85 f6                	test   %esi,%esi
80104540:	75 ae                	jne    801044f0 <promoteProcs+0x20>
  for (int i = 1; i < totalQs; i++) {
80104542:	83 c7 01             	add    $0x1,%edi
80104545:	83 ff 04             	cmp    $0x4,%edi
80104548:	75 94                	jne    801044de <promoteProcs+0xe>
}
8010454a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010454d:	5b                   	pop    %ebx
8010454e:	5e                   	pop    %esi
8010454f:	5f                   	pop    %edi
80104550:	5d                   	pop    %ebp
80104551:	c3                   	ret    
80104552:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104560 <devalueProc>:
void devalueProc(struct proc* p) {
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	57                   	push   %edi
80104564:	56                   	push   %esi
80104565:	53                   	push   %ebx
80104566:	83 ec 0c             	sub    $0xc,%esp
80104569:	8b 5d 08             	mov    0x8(%ebp),%ebx
  p->pticks = 0;
8010456c:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80104573:	00 00 00 
  if (p->whichQueue != totalQs-1) {
80104576:	8b b3 84 00 00 00    	mov    0x84(%ebx),%esi
8010457c:	83 fe 03             	cmp    $0x3,%esi
8010457f:	75 0f                	jne    80104590 <devalueProc+0x30>
}
80104581:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104584:	5b                   	pop    %ebx
80104585:	5e                   	pop    %esi
80104586:	5f                   	pop    %edi
80104587:	5d                   	pop    %ebp
80104588:	c3                   	ret    
80104589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dequeueProc(p);
80104590:	83 ec 0c             	sub    $0xc,%esp
    int placementQueue = p->whichQueue+1;
80104593:	8d 7e 01             	lea    0x1(%esi),%edi
  if (ptable.queues[placementQueue] == NULL) {
80104596:	81 c6 cd 08 00 00    	add    $0x8cd,%esi
    dequeueProc(p);
8010459c:	53                   	push   %ebx
8010459d:	e8 7e fb ff ff       	call   80104120 <dequeueProc>
  p->whichQueue = placementQueue;
801045a2:	89 bb 84 00 00 00    	mov    %edi,0x84(%ebx)
  if (ptable.queues[placementQueue] == NULL) {
801045a8:	83 c4 10             	add    $0x10,%esp
  p->prev = NULL;
801045ab:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
801045b2:	00 00 00 
  p->next = NULL;
801045b5:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
  p->pticks = 0;
801045bc:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
801045c3:	00 00 00 
  if (ptable.queues[placementQueue] == NULL) {
801045c6:	8b 04 b5 6c bd 14 80 	mov    -0x7feb4294(,%esi,4),%eax
801045cd:	85 c0                	test   %eax,%eax
801045cf:	74 09                	je     801045da <devalueProc+0x7a>
    p->next = ptable.queues[placementQueue];
801045d1:	89 43 7c             	mov    %eax,0x7c(%ebx)
    ptable.queues[placementQueue]->prev = p;
801045d4:	89 98 80 00 00 00    	mov    %ebx,0x80(%eax)
    ptable.queues[placementQueue] = p;
801045da:	89 1c b5 6c bd 14 80 	mov    %ebx,-0x7feb4294(,%esi,4)
}
801045e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045e4:	5b                   	pop    %ebx
801045e5:	5e                   	pop    %esi
801045e6:	5f                   	pop    %edi
801045e7:	5d                   	pop    %ebp
801045e8:	c3                   	ret    
801045e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801045f0 <sched>:
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	56                   	push   %esi
801045f4:	53                   	push   %ebx
  pushcli();
801045f5:	e8 46 08 00 00       	call   80104e40 <pushcli>
  c = mycpu();
801045fa:	e8 01 f6 ff ff       	call   80103c00 <mycpu>
  p = c->proc;
801045ff:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104605:	e8 86 08 00 00       	call   80104e90 <popcli>
  if(!holding(&ptable.lock))
8010460a:	83 ec 0c             	sub    $0xc,%esp
8010460d:	68 64 bd 14 80       	push   $0x8014bd64
80104612:	e8 d9 08 00 00       	call   80104ef0 <holding>
80104617:	83 c4 10             	add    $0x10,%esp
8010461a:	85 c0                	test   %eax,%eax
8010461c:	74 4f                	je     8010466d <sched+0x7d>
  if(mycpu()->ncli != 1)
8010461e:	e8 dd f5 ff ff       	call   80103c00 <mycpu>
80104623:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010462a:	75 68                	jne    80104694 <sched+0xa4>
  if(p->state == RUNNING)
8010462c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104630:	74 55                	je     80104687 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104632:	9c                   	pushf  
80104633:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104634:	f6 c4 02             	test   $0x2,%ah
80104637:	75 41                	jne    8010467a <sched+0x8a>
  intena = mycpu()->intena;
80104639:	e8 c2 f5 ff ff       	call   80103c00 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010463e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104641:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104647:	e8 b4 f5 ff ff       	call   80103c00 <mycpu>
8010464c:	83 ec 08             	sub    $0x8,%esp
8010464f:	ff 70 04             	pushl  0x4(%eax)
80104652:	53                   	push   %ebx
80104653:	e8 13 0c 00 00       	call   8010526b <swtch>
  mycpu()->intena = intena;
80104658:	e8 a3 f5 ff ff       	call   80103c00 <mycpu>
}
8010465d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104660:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104666:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104669:	5b                   	pop    %ebx
8010466a:	5e                   	pop    %esi
8010466b:	5d                   	pop    %ebp
8010466c:	c3                   	ret    
    panic("sched ptable.lock");
8010466d:	83 ec 0c             	sub    $0xc,%esp
80104670:	68 ca 81 10 80       	push   $0x801081ca
80104675:	e8 16 bd ff ff       	call   80100390 <panic>
    panic("sched interruptible");
8010467a:	83 ec 0c             	sub    $0xc,%esp
8010467d:	68 f6 81 10 80       	push   $0x801081f6
80104682:	e8 09 bd ff ff       	call   80100390 <panic>
    panic("sched running");
80104687:	83 ec 0c             	sub    $0xc,%esp
8010468a:	68 e8 81 10 80       	push   $0x801081e8
8010468f:	e8 fc bc ff ff       	call   80100390 <panic>
    panic("sched locks");
80104694:	83 ec 0c             	sub    $0xc,%esp
80104697:	68 dc 81 10 80       	push   $0x801081dc
8010469c:	e8 ef bc ff ff       	call   80100390 <panic>
801046a1:	eb 0d                	jmp    801046b0 <exit>
801046a3:	90                   	nop
801046a4:	90                   	nop
801046a5:	90                   	nop
801046a6:	90                   	nop
801046a7:	90                   	nop
801046a8:	90                   	nop
801046a9:	90                   	nop
801046aa:	90                   	nop
801046ab:	90                   	nop
801046ac:	90                   	nop
801046ad:	90                   	nop
801046ae:	90                   	nop
801046af:	90                   	nop

801046b0 <exit>:
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	57                   	push   %edi
801046b4:	56                   	push   %esi
801046b5:	53                   	push   %ebx
801046b6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
801046b9:	e8 82 07 00 00       	call   80104e40 <pushcli>
  c = mycpu();
801046be:	e8 3d f5 ff ff       	call   80103c00 <mycpu>
  p = c->proc;
801046c3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801046c9:	e8 c2 07 00 00       	call   80104e90 <popcli>
  if(curproc == initproc)
801046ce:	8d 5e 28             	lea    0x28(%esi),%ebx
801046d1:	8d 7e 68             	lea    0x68(%esi),%edi
801046d4:	39 35 d8 b5 10 80    	cmp    %esi,0x8010b5d8
801046da:	0f 84 b1 00 00 00    	je     80104791 <exit+0xe1>
    if(curproc->ofile[fd]){
801046e0:	8b 03                	mov    (%ebx),%eax
801046e2:	85 c0                	test   %eax,%eax
801046e4:	74 12                	je     801046f8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
801046e6:	83 ec 0c             	sub    $0xc,%esp
801046e9:	50                   	push   %eax
801046ea:	e8 d1 c7 ff ff       	call   80100ec0 <fileclose>
      curproc->ofile[fd] = 0;
801046ef:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801046f5:	83 c4 10             	add    $0x10,%esp
801046f8:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
801046fb:	39 fb                	cmp    %edi,%ebx
801046fd:	75 e1                	jne    801046e0 <exit+0x30>
  begin_op();
801046ff:	e8 1c e8 ff ff       	call   80102f20 <begin_op>
  iput(curproc->cwd);
80104704:	83 ec 0c             	sub    $0xc,%esp
80104707:	ff 76 68             	pushl  0x68(%esi)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010470a:	bb 98 bd 14 80       	mov    $0x8014bd98,%ebx
  iput(curproc->cwd);
8010470f:	e8 3c d1 ff ff       	call   80101850 <iput>
  end_op();
80104714:	e8 77 e8 ff ff       	call   80102f90 <end_op>
  curproc->cwd = 0;
80104719:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80104720:	c7 04 24 64 bd 14 80 	movl   $0x8014bd64,(%esp)
80104727:	e8 04 08 00 00       	call   80104f30 <acquire>
  wakeup1(curproc->parent);
8010472c:	8b 46 14             	mov    0x14(%esi),%eax
8010472f:	e8 4c f2 ff ff       	call   80103980 <wakeup1>
80104734:	83 c4 10             	add    $0x10,%esp
80104737:	eb 15                	jmp    8010474e <exit+0x9e>
80104739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104740:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80104746:	81 fb 98 e0 14 80    	cmp    $0x8014e098,%ebx
8010474c:	74 2a                	je     80104778 <exit+0xc8>
    if(p->parent == curproc){
8010474e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104751:	75 ed                	jne    80104740 <exit+0x90>
      p->parent = initproc;
80104753:	a1 d8 b5 10 80       	mov    0x8010b5d8,%eax
      if(p->state == ZOMBIE)
80104758:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
      p->parent = initproc;
8010475c:	89 43 14             	mov    %eax,0x14(%ebx)
      if(p->state == ZOMBIE)
8010475f:	75 df                	jne    80104740 <exit+0x90>
        wakeup1(initproc);
80104761:	e8 1a f2 ff ff       	call   80103980 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104766:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
8010476c:	81 fb 98 e0 14 80    	cmp    $0x8014e098,%ebx
80104772:	75 da                	jne    8010474e <exit+0x9e>
80104774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  curproc->state = ZOMBIE;
80104778:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
8010477f:	e8 6c fe ff ff       	call   801045f0 <sched>
  panic("zombie exit");
80104784:	83 ec 0c             	sub    $0xc,%esp
80104787:	68 17 82 10 80       	push   $0x80108217
8010478c:	e8 ff bb ff ff       	call   80100390 <panic>
    panic("init exiting");
80104791:	83 ec 0c             	sub    $0xc,%esp
80104794:	68 0a 82 10 80       	push   $0x8010820a
80104799:	e8 f2 bb ff ff       	call   80100390 <panic>
8010479e:	66 90                	xchg   %ax,%ax

801047a0 <yield>:
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	53                   	push   %ebx
801047a4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801047a7:	e8 94 06 00 00       	call   80104e40 <pushcli>
  c = mycpu();
801047ac:	e8 4f f4 ff ff       	call   80103c00 <mycpu>
  p = c->proc;
801047b1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801047b7:	e8 d4 06 00 00       	call   80104e90 <popcli>
  myproc()->state = RUNNABLE;
801047bc:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
}
801047c3:	83 c4 04             	add    $0x4,%esp
801047c6:	5b                   	pop    %ebx
801047c7:	5d                   	pop    %ebp
  sched();
801047c8:	e9 23 fe ff ff       	jmp    801045f0 <sched>
801047cd:	8d 76 00             	lea    0x0(%esi),%esi

801047d0 <handleTimerInterupt>:
void handleTimerInterupt() {
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	56                   	push   %esi
801047d4:	53                   	push   %ebx
  acquire(&ptable.lock);
801047d5:	83 ec 0c             	sub    $0xc,%esp
801047d8:	68 64 bd 14 80       	push   $0x8014bd64
801047dd:	e8 4e 07 00 00       	call   80104f30 <acquire>
  if (ptable.whichScheduler != 2) {
801047e2:	83 c4 10             	add    $0x10,%esp
801047e5:	83 3d 60 bd 14 80 02 	cmpl   $0x2,0x8014bd60
801047ec:	74 22                	je     80104810 <handleTimerInterupt+0x40>
    yield();
801047ee:	e8 ad ff ff ff       	call   801047a0 <yield>
  release(&ptable.lock);
801047f3:	83 ec 0c             	sub    $0xc,%esp
801047f6:	68 64 bd 14 80       	push   $0x8014bd64
801047fb:	e8 f0 07 00 00       	call   80104ff0 <release>
}
80104800:	83 c4 10             	add    $0x10,%esp
80104803:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104806:	5b                   	pop    %ebx
80104807:	5e                   	pop    %esi
80104808:	5d                   	pop    %ebp
80104809:	c3                   	ret    
8010480a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mycpu()-cpus;
80104810:	e8 eb f3 ff ff       	call   80103c00 <mycpu>
    if (cpuid() == 0) {
80104815:	3d c0 b7 14 80       	cmp    $0x8014b7c0,%eax
8010481a:	0f 84 d0 00 00 00    	je     801048f0 <handleTimerInterupt+0x120>
  pushcli();
80104820:	e8 1b 06 00 00       	call   80104e40 <pushcli>
  c = mycpu();
80104825:	e8 d6 f3 ff ff       	call   80103c00 <mycpu>
  p = c->proc;
8010482a:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104830:	e8 5b 06 00 00       	call   80104e90 <popcli>
    myproc()->pticks++;
80104835:	83 83 88 00 00 00 01 	addl   $0x1,0x88(%ebx)
  pushcli();
8010483c:	e8 ff 05 00 00       	call   80104e40 <pushcli>
  c = mycpu();
80104841:	e8 ba f3 ff ff       	call   80103c00 <mycpu>
  p = c->proc;
80104846:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010484c:	e8 3f 06 00 00       	call   80104e90 <popcli>
    if (myproc()->pticks == allowedQuanta[myproc()->whichQueue]) {
80104851:	8b 9b 88 00 00 00    	mov    0x88(%ebx),%ebx
  pushcli();
80104857:	e8 e4 05 00 00       	call   80104e40 <pushcli>
  c = mycpu();
8010485c:	e8 9f f3 ff ff       	call   80103c00 <mycpu>
  p = c->proc;
80104861:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104867:	e8 24 06 00 00       	call   80104e90 <popcli>
    if (myproc()->pticks == allowedQuanta[myproc()->whichQueue]) {
8010486c:	8b 86 84 00 00 00    	mov    0x84(%esi),%eax
80104872:	3b 1c 85 0c b0 10 80 	cmp    -0x7fef4ff4(,%eax,4),%ebx
80104879:	0f 84 6f ff ff ff    	je     801047ee <handleTimerInterupt+0x1e>
  pushcli();
8010487f:	e8 bc 05 00 00       	call   80104e40 <pushcli>
  c = mycpu();
80104884:	e8 77 f3 ff ff       	call   80103c00 <mycpu>
  p = c->proc;
80104889:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010488f:	e8 fc 05 00 00       	call   80104e90 <popcli>
    else if (myproc()->pticks == maxTicks[myproc()->whichQueue]) {
80104894:	8b 9b 88 00 00 00    	mov    0x88(%ebx),%ebx
  pushcli();
8010489a:	e8 a1 05 00 00       	call   80104e40 <pushcli>
  c = mycpu();
8010489f:	e8 5c f3 ff ff       	call   80103c00 <mycpu>
  p = c->proc;
801048a4:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801048aa:	e8 e1 05 00 00       	call   80104e90 <popcli>
    else if (myproc()->pticks == maxTicks[myproc()->whichQueue]) {
801048af:	8b 86 84 00 00 00    	mov    0x84(%esi),%eax
801048b5:	3b 1c 85 1c b0 10 80 	cmp    -0x7fef4fe4(,%eax,4),%ebx
801048bc:	0f 85 31 ff ff ff    	jne    801047f3 <handleTimerInterupt+0x23>
  pushcli();
801048c2:	e8 79 05 00 00       	call   80104e40 <pushcli>
  c = mycpu();
801048c7:	e8 34 f3 ff ff       	call   80103c00 <mycpu>
  p = c->proc;
801048cc:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801048d2:	e8 b9 05 00 00       	call   80104e90 <popcli>
      devalueProc(myproc());
801048d7:	83 ec 0c             	sub    $0xc,%esp
801048da:	53                   	push   %ebx
801048db:	e8 80 fc ff ff       	call   80104560 <devalueProc>
      yield();
801048e0:	e8 bb fe ff ff       	call   801047a0 <yield>
801048e5:	83 c4 10             	add    $0x10,%esp
801048e8:	e9 06 ff ff ff       	jmp    801047f3 <handleTimerInterupt+0x23>
801048ed:	8d 76 00             	lea    0x0(%esi),%esi
      ptable.totalCurrentTicks++;
801048f0:	a1 98 e0 14 80       	mov    0x8014e098,%eax
801048f5:	83 c0 01             	add    $0x1,%eax
      if (ptable.totalCurrentTicks == S) {
801048f8:	3d 00 02 00 00       	cmp    $0x200,%eax
801048fd:	74 11                	je     80104910 <handleTimerInterupt+0x140>
      ptable.totalCurrentTicks++;
801048ff:	a3 98 e0 14 80       	mov    %eax,0x8014e098
80104904:	e9 17 ff ff ff       	jmp    80104820 <handleTimerInterupt+0x50>
80104909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        ptable.totalCurrentTicks = 0;
80104910:	c7 05 98 e0 14 80 00 	movl   $0x0,0x8014e098
80104917:	00 00 00 
        promoteProcs();
8010491a:	e8 b1 fb ff ff       	call   801044d0 <promoteProcs>
8010491f:	e9 fc fe ff ff       	jmp    80104820 <handleTimerInterupt+0x50>
80104924:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010492a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104930 <sleep>:
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	57                   	push   %edi
80104934:	56                   	push   %esi
80104935:	53                   	push   %ebx
80104936:	83 ec 0c             	sub    $0xc,%esp
80104939:	8b 7d 08             	mov    0x8(%ebp),%edi
8010493c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010493f:	e8 fc 04 00 00       	call   80104e40 <pushcli>
  c = mycpu();
80104944:	e8 b7 f2 ff ff       	call   80103c00 <mycpu>
  p = c->proc;
80104949:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010494f:	e8 3c 05 00 00       	call   80104e90 <popcli>
  if(p == 0)
80104954:	85 db                	test   %ebx,%ebx
80104956:	0f 84 87 00 00 00    	je     801049e3 <sleep+0xb3>
  if(lk == 0)
8010495c:	85 f6                	test   %esi,%esi
8010495e:	74 76                	je     801049d6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104960:	81 fe 64 bd 14 80    	cmp    $0x8014bd64,%esi
80104966:	74 50                	je     801049b8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104968:	83 ec 0c             	sub    $0xc,%esp
8010496b:	68 64 bd 14 80       	push   $0x8014bd64
80104970:	e8 bb 05 00 00       	call   80104f30 <acquire>
    release(lk);
80104975:	89 34 24             	mov    %esi,(%esp)
80104978:	e8 73 06 00 00       	call   80104ff0 <release>
  p->chan = chan;
8010497d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104980:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104987:	e8 64 fc ff ff       	call   801045f0 <sched>
  p->chan = 0;
8010498c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104993:	c7 04 24 64 bd 14 80 	movl   $0x8014bd64,(%esp)
8010499a:	e8 51 06 00 00       	call   80104ff0 <release>
    acquire(lk);
8010499f:	89 75 08             	mov    %esi,0x8(%ebp)
801049a2:	83 c4 10             	add    $0x10,%esp
}
801049a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049a8:	5b                   	pop    %ebx
801049a9:	5e                   	pop    %esi
801049aa:	5f                   	pop    %edi
801049ab:	5d                   	pop    %ebp
    acquire(lk);
801049ac:	e9 7f 05 00 00       	jmp    80104f30 <acquire>
801049b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801049b8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801049bb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801049c2:	e8 29 fc ff ff       	call   801045f0 <sched>
  p->chan = 0;
801049c7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801049ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049d1:	5b                   	pop    %ebx
801049d2:	5e                   	pop    %esi
801049d3:	5f                   	pop    %edi
801049d4:	5d                   	pop    %ebp
801049d5:	c3                   	ret    
    panic("sleep without lk");
801049d6:	83 ec 0c             	sub    $0xc,%esp
801049d9:	68 29 82 10 80       	push   $0x80108229
801049de:	e8 ad b9 ff ff       	call   80100390 <panic>
    panic("sleep");
801049e3:	83 ec 0c             	sub    $0xc,%esp
801049e6:	68 23 82 10 80       	push   $0x80108223
801049eb:	e8 a0 b9 ff ff       	call   80100390 <panic>

801049f0 <wait>:
{
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	56                   	push   %esi
801049f4:	53                   	push   %ebx
  pushcli();
801049f5:	e8 46 04 00 00       	call   80104e40 <pushcli>
  c = mycpu();
801049fa:	e8 01 f2 ff ff       	call   80103c00 <mycpu>
  p = c->proc;
801049ff:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104a05:	e8 86 04 00 00       	call   80104e90 <popcli>
  acquire(&ptable.lock);
80104a0a:	83 ec 0c             	sub    $0xc,%esp
80104a0d:	68 64 bd 14 80       	push   $0x8014bd64
80104a12:	e8 19 05 00 00       	call   80104f30 <acquire>
80104a17:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104a1a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a1c:	bb 98 bd 14 80       	mov    $0x8014bd98,%ebx
80104a21:	eb 13                	jmp    80104a36 <wait+0x46>
80104a23:	90                   	nop
80104a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a28:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80104a2e:	81 fb 98 e0 14 80    	cmp    $0x8014e098,%ebx
80104a34:	74 1e                	je     80104a54 <wait+0x64>
      if(p->parent != curproc)
80104a36:	39 73 14             	cmp    %esi,0x14(%ebx)
80104a39:	75 ed                	jne    80104a28 <wait+0x38>
      if(p->state == ZOMBIE){
80104a3b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104a3f:	74 37                	je     80104a78 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a41:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
      havekids = 1;
80104a47:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a4c:	81 fb 98 e0 14 80    	cmp    $0x8014e098,%ebx
80104a52:	75 e2                	jne    80104a36 <wait+0x46>
    if(!havekids || curproc->killed){
80104a54:	85 c0                	test   %eax,%eax
80104a56:	74 76                	je     80104ace <wait+0xde>
80104a58:	8b 46 24             	mov    0x24(%esi),%eax
80104a5b:	85 c0                	test   %eax,%eax
80104a5d:	75 6f                	jne    80104ace <wait+0xde>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104a5f:	83 ec 08             	sub    $0x8,%esp
80104a62:	68 64 bd 14 80       	push   $0x8014bd64
80104a67:	56                   	push   %esi
80104a68:	e8 c3 fe ff ff       	call   80104930 <sleep>
    havekids = 0;
80104a6d:	83 c4 10             	add    $0x10,%esp
80104a70:	eb a8                	jmp    80104a1a <wait+0x2a>
80104a72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104a78:	83 ec 0c             	sub    $0xc,%esp
80104a7b:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80104a7e:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104a81:	e8 6a d9 ff ff       	call   801023f0 <kfree>
        freevm(p->pgdir);
80104a86:	5a                   	pop    %edx
80104a87:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104a8a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104a91:	e8 da 2c 00 00       	call   80107770 <freevm>
        release(&ptable.lock);
80104a96:	c7 04 24 64 bd 14 80 	movl   $0x8014bd64,(%esp)
        p->pid = 0;
80104a9d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104aa4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104aab:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104aaf:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104ab6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104abd:	e8 2e 05 00 00       	call   80104ff0 <release>
        return pid;
80104ac2:	83 c4 10             	add    $0x10,%esp
}
80104ac5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ac8:	89 f0                	mov    %esi,%eax
80104aca:	5b                   	pop    %ebx
80104acb:	5e                   	pop    %esi
80104acc:	5d                   	pop    %ebp
80104acd:	c3                   	ret    
      release(&ptable.lock);
80104ace:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104ad1:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104ad6:	68 64 bd 14 80       	push   $0x8014bd64
80104adb:	e8 10 05 00 00       	call   80104ff0 <release>
      return -1;
80104ae0:	83 c4 10             	add    $0x10,%esp
80104ae3:	eb e0                	jmp    80104ac5 <wait+0xd5>
80104ae5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104af0 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104af0:	55                   	push   %ebp
80104af1:	89 e5                	mov    %esp,%ebp
80104af3:	53                   	push   %ebx
80104af4:	83 ec 10             	sub    $0x10,%esp
80104af7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104afa:	68 64 bd 14 80       	push   $0x8014bd64
80104aff:	e8 2c 04 00 00       	call   80104f30 <acquire>
  wakeup1(chan);
80104b04:	89 d8                	mov    %ebx,%eax
80104b06:	e8 75 ee ff ff       	call   80103980 <wakeup1>
  release(&ptable.lock);
80104b0b:	83 c4 10             	add    $0x10,%esp
80104b0e:	c7 45 08 64 bd 14 80 	movl   $0x8014bd64,0x8(%ebp)
}
80104b15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b18:	c9                   	leave  
  release(&ptable.lock);
80104b19:	e9 d2 04 00 00       	jmp    80104ff0 <release>
80104b1e:	66 90                	xchg   %ax,%ax

80104b20 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
80104b23:	53                   	push   %ebx
80104b24:	83 ec 10             	sub    $0x10,%esp
80104b27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104b2a:	68 64 bd 14 80       	push   $0x8014bd64
80104b2f:	e8 fc 03 00 00       	call   80104f30 <acquire>
80104b34:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b37:	b8 98 bd 14 80       	mov    $0x8014bd98,%eax
80104b3c:	eb 0e                	jmp    80104b4c <kill+0x2c>
80104b3e:	66 90                	xchg   %ax,%ax
80104b40:	05 8c 00 00 00       	add    $0x8c,%eax
80104b45:	3d 98 e0 14 80       	cmp    $0x8014e098,%eax
80104b4a:	74 74                	je     80104bc0 <kill+0xa0>
    if(p->pid == pid){
80104b4c:	39 58 10             	cmp    %ebx,0x10(%eax)
80104b4f:	75 ef                	jne    80104b40 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING) {
80104b51:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104b55:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING) {
80104b5c:	74 1a                	je     80104b78 <kill+0x58>
        p->state = RUNNABLE;
        queueProc(p, 0);
      }
      release(&ptable.lock);
80104b5e:	83 ec 0c             	sub    $0xc,%esp
80104b61:	68 64 bd 14 80       	push   $0x8014bd64
80104b66:	e8 85 04 00 00       	call   80104ff0 <release>
      return 0;
80104b6b:	83 c4 10             	add    $0x10,%esp
80104b6e:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104b70:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b73:	c9                   	leave  
80104b74:	c3                   	ret    
80104b75:	8d 76 00             	lea    0x0(%esi),%esi
        p->state = RUNNABLE;
80104b78:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  p->whichQueue = placementQueue;
80104b7f:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%eax)
80104b86:	00 00 00 
  p->prev = NULL;
80104b89:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80104b90:	00 00 00 
  p->next = NULL;
80104b93:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
  p->pticks = 0;
80104b9a:	c7 80 88 00 00 00 00 	movl   $0x0,0x88(%eax)
80104ba1:	00 00 00 
  if (ptable.queues[placementQueue] == NULL) {
80104ba4:	8b 15 9c e0 14 80    	mov    0x8014e09c,%edx
80104baa:	85 d2                	test   %edx,%edx
80104bac:	74 09                	je     80104bb7 <kill+0x97>
    p->next = ptable.queues[placementQueue];
80104bae:	89 50 7c             	mov    %edx,0x7c(%eax)
    ptable.queues[placementQueue]->prev = p;
80104bb1:	89 82 80 00 00 00    	mov    %eax,0x80(%edx)
    ptable.queues[placementQueue] = p;
80104bb7:	a3 9c e0 14 80       	mov    %eax,0x8014e09c
80104bbc:	eb a0                	jmp    80104b5e <kill+0x3e>
80104bbe:	66 90                	xchg   %ax,%ax
  release(&ptable.lock);
80104bc0:	83 ec 0c             	sub    $0xc,%esp
80104bc3:	68 64 bd 14 80       	push   $0x8014bd64
80104bc8:	e8 23 04 00 00       	call   80104ff0 <release>
  return -1;
80104bcd:	83 c4 10             	add    $0x10,%esp
80104bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104bd5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bd8:	c9                   	leave  
80104bd9:	c3                   	ret    
80104bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104be0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	57                   	push   %edi
80104be4:	56                   	push   %esi
80104be5:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104be8:	53                   	push   %ebx
80104be9:	bb 04 be 14 80       	mov    $0x8014be04,%ebx
80104bee:	83 ec 3c             	sub    $0x3c,%esp
80104bf1:	eb 27                	jmp    80104c1a <procdump+0x3a>
80104bf3:	90                   	nop
80104bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104bf8:	83 ec 0c             	sub    $0xc,%esp
80104bfb:	68 27 86 10 80       	push   $0x80108627
80104c00:	e8 ab ba ff ff       	call   801006b0 <cprintf>
80104c05:	83 c4 10             	add    $0x10,%esp
80104c08:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c0e:	81 fb 04 e1 14 80    	cmp    $0x8014e104,%ebx
80104c14:	0f 84 7e 00 00 00    	je     80104c98 <procdump+0xb8>
    if(p->state == UNUSED)
80104c1a:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104c1d:	85 c0                	test   %eax,%eax
80104c1f:	74 e7                	je     80104c08 <procdump+0x28>
      state = "???";
80104c21:	ba 3a 82 10 80       	mov    $0x8010823a,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104c26:	83 f8 05             	cmp    $0x5,%eax
80104c29:	77 11                	ja     80104c3c <procdump+0x5c>
80104c2b:	8b 14 85 c8 82 10 80 	mov    -0x7fef7d38(,%eax,4),%edx
      state = "???";
80104c32:	b8 3a 82 10 80       	mov    $0x8010823a,%eax
80104c37:	85 d2                	test   %edx,%edx
80104c39:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104c3c:	53                   	push   %ebx
80104c3d:	52                   	push   %edx
80104c3e:	ff 73 a4             	pushl  -0x5c(%ebx)
80104c41:	68 3e 82 10 80       	push   $0x8010823e
80104c46:	e8 65 ba ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
80104c4b:	83 c4 10             	add    $0x10,%esp
80104c4e:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104c52:	75 a4                	jne    80104bf8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104c54:	83 ec 08             	sub    $0x8,%esp
80104c57:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104c5a:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104c5d:	50                   	push   %eax
80104c5e:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104c61:	8b 40 0c             	mov    0xc(%eax),%eax
80104c64:	83 c0 08             	add    $0x8,%eax
80104c67:	50                   	push   %eax
80104c68:	e8 83 01 00 00       	call   80104df0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104c6d:	83 c4 10             	add    $0x10,%esp
80104c70:	8b 17                	mov    (%edi),%edx
80104c72:	85 d2                	test   %edx,%edx
80104c74:	74 82                	je     80104bf8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104c76:	83 ec 08             	sub    $0x8,%esp
80104c79:	83 c7 04             	add    $0x4,%edi
80104c7c:	52                   	push   %edx
80104c7d:	68 e1 7b 10 80       	push   $0x80107be1
80104c82:	e8 29 ba ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104c87:	83 c4 10             	add    $0x10,%esp
80104c8a:	39 fe                	cmp    %edi,%esi
80104c8c:	75 e2                	jne    80104c70 <procdump+0x90>
80104c8e:	e9 65 ff ff ff       	jmp    80104bf8 <procdump+0x18>
80104c93:	90                   	nop
80104c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
}
80104c98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c9b:	5b                   	pop    %ebx
80104c9c:	5e                   	pop    %esi
80104c9d:	5f                   	pop    %edi
80104c9e:	5d                   	pop    %ebp
80104c9f:	c3                   	ret    

80104ca0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	53                   	push   %ebx
80104ca4:	83 ec 0c             	sub    $0xc,%esp
80104ca7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104caa:	68 e0 82 10 80       	push   $0x801082e0
80104caf:	8d 43 04             	lea    0x4(%ebx),%eax
80104cb2:	50                   	push   %eax
80104cb3:	e8 18 01 00 00       	call   80104dd0 <initlock>
  lk->name = name;
80104cb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104cbb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104cc1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104cc4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104ccb:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104cce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cd1:	c9                   	leave  
80104cd2:	c3                   	ret    
80104cd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ce0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	56                   	push   %esi
80104ce4:	53                   	push   %ebx
80104ce5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104ce8:	8d 73 04             	lea    0x4(%ebx),%esi
80104ceb:	83 ec 0c             	sub    $0xc,%esp
80104cee:	56                   	push   %esi
80104cef:	e8 3c 02 00 00       	call   80104f30 <acquire>
  while (lk->locked) {
80104cf4:	8b 13                	mov    (%ebx),%edx
80104cf6:	83 c4 10             	add    $0x10,%esp
80104cf9:	85 d2                	test   %edx,%edx
80104cfb:	74 16                	je     80104d13 <acquiresleep+0x33>
80104cfd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104d00:	83 ec 08             	sub    $0x8,%esp
80104d03:	56                   	push   %esi
80104d04:	53                   	push   %ebx
80104d05:	e8 26 fc ff ff       	call   80104930 <sleep>
  while (lk->locked) {
80104d0a:	8b 03                	mov    (%ebx),%eax
80104d0c:	83 c4 10             	add    $0x10,%esp
80104d0f:	85 c0                	test   %eax,%eax
80104d11:	75 ed                	jne    80104d00 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104d13:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104d19:	e8 82 ef ff ff       	call   80103ca0 <myproc>
80104d1e:	8b 40 10             	mov    0x10(%eax),%eax
80104d21:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104d24:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104d27:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d2a:	5b                   	pop    %ebx
80104d2b:	5e                   	pop    %esi
80104d2c:	5d                   	pop    %ebp
  release(&lk->lk);
80104d2d:	e9 be 02 00 00       	jmp    80104ff0 <release>
80104d32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d40 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	56                   	push   %esi
80104d44:	53                   	push   %ebx
80104d45:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104d48:	8d 73 04             	lea    0x4(%ebx),%esi
80104d4b:	83 ec 0c             	sub    $0xc,%esp
80104d4e:	56                   	push   %esi
80104d4f:	e8 dc 01 00 00       	call   80104f30 <acquire>
  lk->locked = 0;
80104d54:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104d5a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104d61:	89 1c 24             	mov    %ebx,(%esp)
80104d64:	e8 87 fd ff ff       	call   80104af0 <wakeup>
  release(&lk->lk);
80104d69:	89 75 08             	mov    %esi,0x8(%ebp)
80104d6c:	83 c4 10             	add    $0x10,%esp
}
80104d6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d72:	5b                   	pop    %ebx
80104d73:	5e                   	pop    %esi
80104d74:	5d                   	pop    %ebp
  release(&lk->lk);
80104d75:	e9 76 02 00 00       	jmp    80104ff0 <release>
80104d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104d80 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104d80:	55                   	push   %ebp
80104d81:	89 e5                	mov    %esp,%ebp
80104d83:	57                   	push   %edi
80104d84:	31 ff                	xor    %edi,%edi
80104d86:	56                   	push   %esi
80104d87:	53                   	push   %ebx
80104d88:	83 ec 18             	sub    $0x18,%esp
80104d8b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104d8e:	8d 73 04             	lea    0x4(%ebx),%esi
80104d91:	56                   	push   %esi
80104d92:	e8 99 01 00 00       	call   80104f30 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104d97:	8b 03                	mov    (%ebx),%eax
80104d99:	83 c4 10             	add    $0x10,%esp
80104d9c:	85 c0                	test   %eax,%eax
80104d9e:	75 18                	jne    80104db8 <holdingsleep+0x38>
  release(&lk->lk);
80104da0:	83 ec 0c             	sub    $0xc,%esp
80104da3:	56                   	push   %esi
80104da4:	e8 47 02 00 00       	call   80104ff0 <release>
  return r;
}
80104da9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104dac:	89 f8                	mov    %edi,%eax
80104dae:	5b                   	pop    %ebx
80104daf:	5e                   	pop    %esi
80104db0:	5f                   	pop    %edi
80104db1:	5d                   	pop    %ebp
80104db2:	c3                   	ret    
80104db3:	90                   	nop
80104db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80104db8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104dbb:	e8 e0 ee ff ff       	call   80103ca0 <myproc>
80104dc0:	39 58 10             	cmp    %ebx,0x10(%eax)
80104dc3:	0f 94 c0             	sete   %al
80104dc6:	0f b6 c0             	movzbl %al,%eax
80104dc9:	89 c7                	mov    %eax,%edi
80104dcb:	eb d3                	jmp    80104da0 <holdingsleep+0x20>
80104dcd:	66 90                	xchg   %ax,%ax
80104dcf:	90                   	nop

80104dd0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104dd0:	55                   	push   %ebp
80104dd1:	89 e5                	mov    %esp,%ebp
80104dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104dd6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104dd9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104ddf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104de2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104de9:	5d                   	pop    %ebp
80104dea:	c3                   	ret    
80104deb:	90                   	nop
80104dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104df0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104df0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104df1:	31 d2                	xor    %edx,%edx
{
80104df3:	89 e5                	mov    %esp,%ebp
80104df5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104df6:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104df9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104dfc:	83 e8 08             	sub    $0x8,%eax
80104dff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104e00:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104e06:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104e0c:	77 1a                	ja     80104e28 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104e0e:	8b 58 04             	mov    0x4(%eax),%ebx
80104e11:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104e14:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104e17:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104e19:	83 fa 0a             	cmp    $0xa,%edx
80104e1c:	75 e2                	jne    80104e00 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104e1e:	5b                   	pop    %ebx
80104e1f:	5d                   	pop    %ebp
80104e20:	c3                   	ret    
80104e21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e28:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104e2b:	8d 51 28             	lea    0x28(%ecx),%edx
80104e2e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104e30:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104e36:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104e39:	39 c2                	cmp    %eax,%edx
80104e3b:	75 f3                	jne    80104e30 <getcallerpcs+0x40>
}
80104e3d:	5b                   	pop    %ebx
80104e3e:	5d                   	pop    %ebp
80104e3f:	c3                   	ret    

80104e40 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	53                   	push   %ebx
80104e44:	83 ec 04             	sub    $0x4,%esp
80104e47:	9c                   	pushf  
80104e48:	5b                   	pop    %ebx
  asm volatile("cli");
80104e49:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104e4a:	e8 b1 ed ff ff       	call   80103c00 <mycpu>
80104e4f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104e55:	85 c0                	test   %eax,%eax
80104e57:	74 17                	je     80104e70 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104e59:	e8 a2 ed ff ff       	call   80103c00 <mycpu>
80104e5e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104e65:	83 c4 04             	add    $0x4,%esp
80104e68:	5b                   	pop    %ebx
80104e69:	5d                   	pop    %ebp
80104e6a:	c3                   	ret    
80104e6b:	90                   	nop
80104e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    mycpu()->intena = eflags & FL_IF;
80104e70:	e8 8b ed ff ff       	call   80103c00 <mycpu>
80104e75:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104e7b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104e81:	eb d6                	jmp    80104e59 <pushcli+0x19>
80104e83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e90 <popcli>:

void
popcli(void)
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104e96:	9c                   	pushf  
80104e97:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104e98:	f6 c4 02             	test   $0x2,%ah
80104e9b:	75 35                	jne    80104ed2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104e9d:	e8 5e ed ff ff       	call   80103c00 <mycpu>
80104ea2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104ea9:	78 34                	js     80104edf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104eab:	e8 50 ed ff ff       	call   80103c00 <mycpu>
80104eb0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104eb6:	85 d2                	test   %edx,%edx
80104eb8:	74 06                	je     80104ec0 <popcli+0x30>
    sti();
}
80104eba:	c9                   	leave  
80104ebb:	c3                   	ret    
80104ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104ec0:	e8 3b ed ff ff       	call   80103c00 <mycpu>
80104ec5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104ecb:	85 c0                	test   %eax,%eax
80104ecd:	74 eb                	je     80104eba <popcli+0x2a>
  asm volatile("sti");
80104ecf:	fb                   	sti    
}
80104ed0:	c9                   	leave  
80104ed1:	c3                   	ret    
    panic("popcli - interruptible");
80104ed2:	83 ec 0c             	sub    $0xc,%esp
80104ed5:	68 eb 82 10 80       	push   $0x801082eb
80104eda:	e8 b1 b4 ff ff       	call   80100390 <panic>
    panic("popcli");
80104edf:	83 ec 0c             	sub    $0xc,%esp
80104ee2:	68 02 83 10 80       	push   $0x80108302
80104ee7:	e8 a4 b4 ff ff       	call   80100390 <panic>
80104eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ef0 <holding>:
{
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	56                   	push   %esi
80104ef4:	53                   	push   %ebx
80104ef5:	8b 75 08             	mov    0x8(%ebp),%esi
80104ef8:	31 db                	xor    %ebx,%ebx
  pushcli();
80104efa:	e8 41 ff ff ff       	call   80104e40 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104eff:	8b 06                	mov    (%esi),%eax
80104f01:	85 c0                	test   %eax,%eax
80104f03:	75 0b                	jne    80104f10 <holding+0x20>
  popcli();
80104f05:	e8 86 ff ff ff       	call   80104e90 <popcli>
}
80104f0a:	89 d8                	mov    %ebx,%eax
80104f0c:	5b                   	pop    %ebx
80104f0d:	5e                   	pop    %esi
80104f0e:	5d                   	pop    %ebp
80104f0f:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80104f10:	8b 5e 08             	mov    0x8(%esi),%ebx
80104f13:	e8 e8 ec ff ff       	call   80103c00 <mycpu>
80104f18:	39 c3                	cmp    %eax,%ebx
80104f1a:	0f 94 c3             	sete   %bl
  popcli();
80104f1d:	e8 6e ff ff ff       	call   80104e90 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104f22:	0f b6 db             	movzbl %bl,%ebx
}
80104f25:	89 d8                	mov    %ebx,%eax
80104f27:	5b                   	pop    %ebx
80104f28:	5e                   	pop    %esi
80104f29:	5d                   	pop    %ebp
80104f2a:	c3                   	ret    
80104f2b:	90                   	nop
80104f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f30 <acquire>:
{
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	56                   	push   %esi
80104f34:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104f35:	e8 06 ff ff ff       	call   80104e40 <pushcli>
  if(holding(lk))
80104f3a:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104f3d:	83 ec 0c             	sub    $0xc,%esp
80104f40:	53                   	push   %ebx
80104f41:	e8 aa ff ff ff       	call   80104ef0 <holding>
80104f46:	83 c4 10             	add    $0x10,%esp
80104f49:	85 c0                	test   %eax,%eax
80104f4b:	0f 85 83 00 00 00    	jne    80104fd4 <acquire+0xa4>
80104f51:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104f53:	ba 01 00 00 00       	mov    $0x1,%edx
80104f58:	eb 09                	jmp    80104f63 <acquire+0x33>
80104f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f60:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104f63:	89 d0                	mov    %edx,%eax
80104f65:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104f68:	85 c0                	test   %eax,%eax
80104f6a:	75 f4                	jne    80104f60 <acquire+0x30>
  __sync_synchronize();
80104f6c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104f71:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104f74:	e8 87 ec ff ff       	call   80103c00 <mycpu>
80104f79:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104f7c:	89 e8                	mov    %ebp,%eax
80104f7e:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f80:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80104f86:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
80104f8c:	77 22                	ja     80104fb0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104f8e:	8b 50 04             	mov    0x4(%eax),%edx
80104f91:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
  for(i = 0; i < 10; i++){
80104f95:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104f98:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104f9a:	83 fe 0a             	cmp    $0xa,%esi
80104f9d:	75 e1                	jne    80104f80 <acquire+0x50>
}
80104f9f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104fa2:	5b                   	pop    %ebx
80104fa3:	5e                   	pop    %esi
80104fa4:	5d                   	pop    %ebp
80104fa5:	c3                   	ret    
80104fa6:	8d 76 00             	lea    0x0(%esi),%esi
80104fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104fb0:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80104fb4:	83 c3 34             	add    $0x34,%ebx
80104fb7:	89 f6                	mov    %esi,%esi
80104fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104fc0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104fc6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104fc9:	39 d8                	cmp    %ebx,%eax
80104fcb:	75 f3                	jne    80104fc0 <acquire+0x90>
}
80104fcd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104fd0:	5b                   	pop    %ebx
80104fd1:	5e                   	pop    %esi
80104fd2:	5d                   	pop    %ebp
80104fd3:	c3                   	ret    
    panic("acquire");
80104fd4:	83 ec 0c             	sub    $0xc,%esp
80104fd7:	68 09 83 10 80       	push   $0x80108309
80104fdc:	e8 af b3 ff ff       	call   80100390 <panic>
80104fe1:	eb 0d                	jmp    80104ff0 <release>
80104fe3:	90                   	nop
80104fe4:	90                   	nop
80104fe5:	90                   	nop
80104fe6:	90                   	nop
80104fe7:	90                   	nop
80104fe8:	90                   	nop
80104fe9:	90                   	nop
80104fea:	90                   	nop
80104feb:	90                   	nop
80104fec:	90                   	nop
80104fed:	90                   	nop
80104fee:	90                   	nop
80104fef:	90                   	nop

80104ff0 <release>:
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	53                   	push   %ebx
80104ff4:	83 ec 10             	sub    $0x10,%esp
80104ff7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104ffa:	53                   	push   %ebx
80104ffb:	e8 f0 fe ff ff       	call   80104ef0 <holding>
80105000:	83 c4 10             	add    $0x10,%esp
80105003:	85 c0                	test   %eax,%eax
80105005:	74 22                	je     80105029 <release+0x39>
  lk->pcs[0] = 0;
80105007:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010500e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105015:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010501a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105020:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105023:	c9                   	leave  
  popcli();
80105024:	e9 67 fe ff ff       	jmp    80104e90 <popcli>
    panic("release");
80105029:	83 ec 0c             	sub    $0xc,%esp
8010502c:	68 11 83 10 80       	push   $0x80108311
80105031:	e8 5a b3 ff ff       	call   80100390 <panic>
80105036:	66 90                	xchg   %ax,%ax
80105038:	66 90                	xchg   %ax,%ax
8010503a:	66 90                	xchg   %ax,%ax
8010503c:	66 90                	xchg   %ax,%ax
8010503e:	66 90                	xchg   %ax,%ax

80105040 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105040:	55                   	push   %ebp
80105041:	89 e5                	mov    %esp,%ebp
80105043:	57                   	push   %edi
80105044:	8b 55 08             	mov    0x8(%ebp),%edx
80105047:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010504a:	53                   	push   %ebx
  if ((int)dst%4 == 0 && n%4 == 0){
8010504b:	89 d0                	mov    %edx,%eax
8010504d:	09 c8                	or     %ecx,%eax
8010504f:	a8 03                	test   $0x3,%al
80105051:	75 2d                	jne    80105080 <memset+0x40>
    c &= 0xFF;
80105053:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105057:	c1 e9 02             	shr    $0x2,%ecx
8010505a:	89 f8                	mov    %edi,%eax
8010505c:	89 fb                	mov    %edi,%ebx
8010505e:	c1 e0 18             	shl    $0x18,%eax
80105061:	c1 e3 10             	shl    $0x10,%ebx
80105064:	09 d8                	or     %ebx,%eax
80105066:	09 f8                	or     %edi,%eax
80105068:	c1 e7 08             	shl    $0x8,%edi
8010506b:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
8010506d:	89 d7                	mov    %edx,%edi
8010506f:	fc                   	cld    
80105070:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80105072:	5b                   	pop    %ebx
80105073:	89 d0                	mov    %edx,%eax
80105075:	5f                   	pop    %edi
80105076:	5d                   	pop    %ebp
80105077:	c3                   	ret    
80105078:	90                   	nop
80105079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80105080:	89 d7                	mov    %edx,%edi
80105082:	8b 45 0c             	mov    0xc(%ebp),%eax
80105085:	fc                   	cld    
80105086:	f3 aa                	rep stos %al,%es:(%edi)
80105088:	5b                   	pop    %ebx
80105089:	89 d0                	mov    %edx,%eax
8010508b:	5f                   	pop    %edi
8010508c:	5d                   	pop    %ebp
8010508d:	c3                   	ret    
8010508e:	66 90                	xchg   %ax,%ax

80105090 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105090:	55                   	push   %ebp
80105091:	89 e5                	mov    %esp,%ebp
80105093:	56                   	push   %esi
80105094:	8b 75 10             	mov    0x10(%ebp),%esi
80105097:	8b 45 08             	mov    0x8(%ebp),%eax
8010509a:	53                   	push   %ebx
8010509b:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010509e:	85 f6                	test   %esi,%esi
801050a0:	74 22                	je     801050c4 <memcmp+0x34>
    if(*s1 != *s2)
801050a2:	0f b6 08             	movzbl (%eax),%ecx
801050a5:	0f b6 1a             	movzbl (%edx),%ebx
801050a8:	01 c6                	add    %eax,%esi
801050aa:	38 cb                	cmp    %cl,%bl
801050ac:	74 0c                	je     801050ba <memcmp+0x2a>
801050ae:	eb 20                	jmp    801050d0 <memcmp+0x40>
801050b0:	0f b6 08             	movzbl (%eax),%ecx
801050b3:	0f b6 1a             	movzbl (%edx),%ebx
801050b6:	38 d9                	cmp    %bl,%cl
801050b8:	75 16                	jne    801050d0 <memcmp+0x40>
      return *s1 - *s2;
    s1++, s2++;
801050ba:	83 c0 01             	add    $0x1,%eax
801050bd:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
801050c0:	39 c6                	cmp    %eax,%esi
801050c2:	75 ec                	jne    801050b0 <memcmp+0x20>
  }

  return 0;
}
801050c4:	5b                   	pop    %ebx
  return 0;
801050c5:	31 c0                	xor    %eax,%eax
}
801050c7:	5e                   	pop    %esi
801050c8:	5d                   	pop    %ebp
801050c9:	c3                   	ret    
801050ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      return *s1 - *s2;
801050d0:	0f b6 c1             	movzbl %cl,%eax
801050d3:	29 d8                	sub    %ebx,%eax
}
801050d5:	5b                   	pop    %ebx
801050d6:	5e                   	pop    %esi
801050d7:	5d                   	pop    %ebp
801050d8:	c3                   	ret    
801050d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801050e0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801050e0:	55                   	push   %ebp
801050e1:	89 e5                	mov    %esp,%ebp
801050e3:	57                   	push   %edi
801050e4:	8b 45 08             	mov    0x8(%ebp),%eax
801050e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801050ea:	56                   	push   %esi
801050eb:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801050ee:	39 c6                	cmp    %eax,%esi
801050f0:	73 26                	jae    80105118 <memmove+0x38>
801050f2:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
801050f5:	39 f8                	cmp    %edi,%eax
801050f7:	73 1f                	jae    80105118 <memmove+0x38>
801050f9:	8d 51 ff             	lea    -0x1(%ecx),%edx
    s += n;
    d += n;
    while(n-- > 0)
801050fc:	85 c9                	test   %ecx,%ecx
801050fe:	74 0f                	je     8010510f <memmove+0x2f>
      *--d = *--s;
80105100:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80105104:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105107:	83 ea 01             	sub    $0x1,%edx
8010510a:	83 fa ff             	cmp    $0xffffffff,%edx
8010510d:	75 f1                	jne    80105100 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010510f:	5e                   	pop    %esi
80105110:	5f                   	pop    %edi
80105111:	5d                   	pop    %ebp
80105112:	c3                   	ret    
80105113:	90                   	nop
80105114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105118:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
    while(n-- > 0)
8010511b:	89 c7                	mov    %eax,%edi
8010511d:	85 c9                	test   %ecx,%ecx
8010511f:	74 ee                	je     8010510f <memmove+0x2f>
80105121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80105128:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80105129:	39 d6                	cmp    %edx,%esi
8010512b:	75 fb                	jne    80105128 <memmove+0x48>
}
8010512d:	5e                   	pop    %esi
8010512e:	5f                   	pop    %edi
8010512f:	5d                   	pop    %ebp
80105130:	c3                   	ret    
80105131:	eb 0d                	jmp    80105140 <memcpy>
80105133:	90                   	nop
80105134:	90                   	nop
80105135:	90                   	nop
80105136:	90                   	nop
80105137:	90                   	nop
80105138:	90                   	nop
80105139:	90                   	nop
8010513a:	90                   	nop
8010513b:	90                   	nop
8010513c:	90                   	nop
8010513d:	90                   	nop
8010513e:	90                   	nop
8010513f:	90                   	nop

80105140 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80105140:	eb 9e                	jmp    801050e0 <memmove>
80105142:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105150 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	57                   	push   %edi
80105154:	8b 7d 10             	mov    0x10(%ebp),%edi
80105157:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010515a:	56                   	push   %esi
8010515b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010515e:	53                   	push   %ebx
  while(n > 0 && *p && *p == *q)
8010515f:	85 ff                	test   %edi,%edi
80105161:	74 2f                	je     80105192 <strncmp+0x42>
80105163:	0f b6 11             	movzbl (%ecx),%edx
80105166:	0f b6 1e             	movzbl (%esi),%ebx
80105169:	84 d2                	test   %dl,%dl
8010516b:	74 37                	je     801051a4 <strncmp+0x54>
8010516d:	38 da                	cmp    %bl,%dl
8010516f:	75 33                	jne    801051a4 <strncmp+0x54>
80105171:	01 f7                	add    %esi,%edi
80105173:	eb 13                	jmp    80105188 <strncmp+0x38>
80105175:	8d 76 00             	lea    0x0(%esi),%esi
80105178:	0f b6 11             	movzbl (%ecx),%edx
8010517b:	84 d2                	test   %dl,%dl
8010517d:	74 21                	je     801051a0 <strncmp+0x50>
8010517f:	0f b6 18             	movzbl (%eax),%ebx
80105182:	89 c6                	mov    %eax,%esi
80105184:	38 da                	cmp    %bl,%dl
80105186:	75 1c                	jne    801051a4 <strncmp+0x54>
    n--, p++, q++;
80105188:	8d 46 01             	lea    0x1(%esi),%eax
8010518b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010518e:	39 f8                	cmp    %edi,%eax
80105190:	75 e6                	jne    80105178 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105192:	5b                   	pop    %ebx
    return 0;
80105193:	31 c0                	xor    %eax,%eax
}
80105195:	5e                   	pop    %esi
80105196:	5f                   	pop    %edi
80105197:	5d                   	pop    %ebp
80105198:	c3                   	ret    
80105199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051a0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
801051a4:	0f b6 c2             	movzbl %dl,%eax
801051a7:	29 d8                	sub    %ebx,%eax
}
801051a9:	5b                   	pop    %ebx
801051aa:	5e                   	pop    %esi
801051ab:	5f                   	pop    %edi
801051ac:	5d                   	pop    %ebp
801051ad:	c3                   	ret    
801051ae:	66 90                	xchg   %ax,%ax

801051b0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801051b0:	55                   	push   %ebp
801051b1:	89 e5                	mov    %esp,%ebp
801051b3:	57                   	push   %edi
801051b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801051b7:	8b 4d 08             	mov    0x8(%ebp),%ecx
{
801051ba:	56                   	push   %esi
801051bb:	53                   	push   %ebx
801051bc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  while(n-- > 0 && (*s++ = *t++) != 0)
801051bf:	eb 1a                	jmp    801051db <strncpy+0x2b>
801051c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051c8:	83 c2 01             	add    $0x1,%edx
801051cb:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
801051cf:	83 c1 01             	add    $0x1,%ecx
801051d2:	88 41 ff             	mov    %al,-0x1(%ecx)
801051d5:	84 c0                	test   %al,%al
801051d7:	74 09                	je     801051e2 <strncpy+0x32>
801051d9:	89 fb                	mov    %edi,%ebx
801051db:	8d 7b ff             	lea    -0x1(%ebx),%edi
801051de:	85 db                	test   %ebx,%ebx
801051e0:	7f e6                	jg     801051c8 <strncpy+0x18>
    ;
  while(n-- > 0)
801051e2:	89 ce                	mov    %ecx,%esi
801051e4:	85 ff                	test   %edi,%edi
801051e6:	7e 1b                	jle    80105203 <strncpy+0x53>
801051e8:	90                   	nop
801051e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801051f0:	83 c6 01             	add    $0x1,%esi
801051f3:	c6 46 ff 00          	movb   $0x0,-0x1(%esi)
801051f7:	89 f2                	mov    %esi,%edx
801051f9:	f7 d2                	not    %edx
801051fb:	01 ca                	add    %ecx,%edx
801051fd:	01 da                	add    %ebx,%edx
  while(n-- > 0)
801051ff:	85 d2                	test   %edx,%edx
80105201:	7f ed                	jg     801051f0 <strncpy+0x40>
  return os;
}
80105203:	5b                   	pop    %ebx
80105204:	8b 45 08             	mov    0x8(%ebp),%eax
80105207:	5e                   	pop    %esi
80105208:	5f                   	pop    %edi
80105209:	5d                   	pop    %ebp
8010520a:	c3                   	ret    
8010520b:	90                   	nop
8010520c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105210 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105210:	55                   	push   %ebp
80105211:	89 e5                	mov    %esp,%ebp
80105213:	56                   	push   %esi
80105214:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105217:	8b 45 08             	mov    0x8(%ebp),%eax
8010521a:	53                   	push   %ebx
8010521b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010521e:	85 c9                	test   %ecx,%ecx
80105220:	7e 26                	jle    80105248 <safestrcpy+0x38>
80105222:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105226:	89 c1                	mov    %eax,%ecx
80105228:	eb 17                	jmp    80105241 <safestrcpy+0x31>
8010522a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105230:	83 c2 01             	add    $0x1,%edx
80105233:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105237:	83 c1 01             	add    $0x1,%ecx
8010523a:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010523d:	84 db                	test   %bl,%bl
8010523f:	74 04                	je     80105245 <safestrcpy+0x35>
80105241:	39 f2                	cmp    %esi,%edx
80105243:	75 eb                	jne    80105230 <safestrcpy+0x20>
    ;
  *s = 0;
80105245:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105248:	5b                   	pop    %ebx
80105249:	5e                   	pop    %esi
8010524a:	5d                   	pop    %ebp
8010524b:	c3                   	ret    
8010524c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105250 <strlen>:

int
strlen(const char *s)
{
80105250:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105251:	31 c0                	xor    %eax,%eax
{
80105253:	89 e5                	mov    %esp,%ebp
80105255:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105258:	80 3a 00             	cmpb   $0x0,(%edx)
8010525b:	74 0c                	je     80105269 <strlen+0x19>
8010525d:	8d 76 00             	lea    0x0(%esi),%esi
80105260:	83 c0 01             	add    $0x1,%eax
80105263:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105267:	75 f7                	jne    80105260 <strlen+0x10>
    ;
  return n;
}
80105269:	5d                   	pop    %ebp
8010526a:	c3                   	ret    

8010526b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010526b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010526f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105273:	55                   	push   %ebp
  pushl %ebx
80105274:	53                   	push   %ebx
  pushl %esi
80105275:	56                   	push   %esi
  pushl %edi
80105276:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105277:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105279:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010527b:	5f                   	pop    %edi
  popl %esi
8010527c:	5e                   	pop    %esi
  popl %ebx
8010527d:	5b                   	pop    %ebx
  popl %ebp
8010527e:	5d                   	pop    %ebp
  ret
8010527f:	c3                   	ret    

80105280 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105280:	55                   	push   %ebp
80105281:	89 e5                	mov    %esp,%ebp
80105283:	53                   	push   %ebx
80105284:	83 ec 04             	sub    $0x4,%esp
80105287:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010528a:	e8 11 ea ff ff       	call   80103ca0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010528f:	8b 00                	mov    (%eax),%eax
80105291:	39 d8                	cmp    %ebx,%eax
80105293:	76 1b                	jbe    801052b0 <fetchint+0x30>
80105295:	8d 53 04             	lea    0x4(%ebx),%edx
80105298:	39 d0                	cmp    %edx,%eax
8010529a:	72 14                	jb     801052b0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010529c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010529f:	8b 13                	mov    (%ebx),%edx
801052a1:	89 10                	mov    %edx,(%eax)
  return 0;
801052a3:	31 c0                	xor    %eax,%eax
}
801052a5:	83 c4 04             	add    $0x4,%esp
801052a8:	5b                   	pop    %ebx
801052a9:	5d                   	pop    %ebp
801052aa:	c3                   	ret    
801052ab:	90                   	nop
801052ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801052b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052b5:	eb ee                	jmp    801052a5 <fetchint+0x25>
801052b7:	89 f6                	mov    %esi,%esi
801052b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052c0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
801052c3:	53                   	push   %ebx
801052c4:	83 ec 04             	sub    $0x4,%esp
801052c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801052ca:	e8 d1 e9 ff ff       	call   80103ca0 <myproc>

  if(addr >= curproc->sz)
801052cf:	39 18                	cmp    %ebx,(%eax)
801052d1:	76 29                	jbe    801052fc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801052d3:	8b 55 0c             	mov    0xc(%ebp),%edx
801052d6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801052d8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801052da:	39 d3                	cmp    %edx,%ebx
801052dc:	73 1e                	jae    801052fc <fetchstr+0x3c>
    if(*s == 0)
801052de:	80 3b 00             	cmpb   $0x0,(%ebx)
801052e1:	74 35                	je     80105318 <fetchstr+0x58>
801052e3:	89 d8                	mov    %ebx,%eax
801052e5:	eb 0e                	jmp    801052f5 <fetchstr+0x35>
801052e7:	89 f6                	mov    %esi,%esi
801052e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801052f0:	80 38 00             	cmpb   $0x0,(%eax)
801052f3:	74 1b                	je     80105310 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
801052f5:	83 c0 01             	add    $0x1,%eax
801052f8:	39 c2                	cmp    %eax,%edx
801052fa:	77 f4                	ja     801052f0 <fetchstr+0x30>
    return -1;
801052fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105301:	83 c4 04             	add    $0x4,%esp
80105304:	5b                   	pop    %ebx
80105305:	5d                   	pop    %ebp
80105306:	c3                   	ret    
80105307:	89 f6                	mov    %esi,%esi
80105309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105310:	83 c4 04             	add    $0x4,%esp
80105313:	29 d8                	sub    %ebx,%eax
80105315:	5b                   	pop    %ebx
80105316:	5d                   	pop    %ebp
80105317:	c3                   	ret    
    if(*s == 0)
80105318:	31 c0                	xor    %eax,%eax
      return s - *pp;
8010531a:	eb e5                	jmp    80105301 <fetchstr+0x41>
8010531c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105320 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	56                   	push   %esi
80105324:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105325:	e8 76 e9 ff ff       	call   80103ca0 <myproc>
8010532a:	8b 55 08             	mov    0x8(%ebp),%edx
8010532d:	8b 40 18             	mov    0x18(%eax),%eax
80105330:	8b 40 44             	mov    0x44(%eax),%eax
80105333:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105336:	e8 65 e9 ff ff       	call   80103ca0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010533b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010533e:	8b 00                	mov    (%eax),%eax
80105340:	39 c6                	cmp    %eax,%esi
80105342:	73 1c                	jae    80105360 <argint+0x40>
80105344:	8d 53 08             	lea    0x8(%ebx),%edx
80105347:	39 d0                	cmp    %edx,%eax
80105349:	72 15                	jb     80105360 <argint+0x40>
  *ip = *(int*)(addr);
8010534b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010534e:	8b 53 04             	mov    0x4(%ebx),%edx
80105351:	89 10                	mov    %edx,(%eax)
  return 0;
80105353:	31 c0                	xor    %eax,%eax
}
80105355:	5b                   	pop    %ebx
80105356:	5e                   	pop    %esi
80105357:	5d                   	pop    %ebp
80105358:	c3                   	ret    
80105359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105360:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105365:	eb ee                	jmp    80105355 <argint+0x35>
80105367:	89 f6                	mov    %esi,%esi
80105369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105370 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	56                   	push   %esi
80105374:	53                   	push   %ebx
80105375:	83 ec 10             	sub    $0x10,%esp
80105378:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010537b:	e8 20 e9 ff ff       	call   80103ca0 <myproc>
 
  if(argint(n, &i) < 0)
80105380:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
80105383:	89 c6                	mov    %eax,%esi
  if(argint(n, &i) < 0)
80105385:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105388:	50                   	push   %eax
80105389:	ff 75 08             	pushl  0x8(%ebp)
8010538c:	e8 8f ff ff ff       	call   80105320 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105391:	83 c4 10             	add    $0x10,%esp
80105394:	85 c0                	test   %eax,%eax
80105396:	78 28                	js     801053c0 <argptr+0x50>
80105398:	85 db                	test   %ebx,%ebx
8010539a:	78 24                	js     801053c0 <argptr+0x50>
8010539c:	8b 16                	mov    (%esi),%edx
8010539e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053a1:	39 c2                	cmp    %eax,%edx
801053a3:	76 1b                	jbe    801053c0 <argptr+0x50>
801053a5:	01 c3                	add    %eax,%ebx
801053a7:	39 da                	cmp    %ebx,%edx
801053a9:	72 15                	jb     801053c0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801053ab:	8b 55 0c             	mov    0xc(%ebp),%edx
801053ae:	89 02                	mov    %eax,(%edx)
  return 0;
801053b0:	31 c0                	xor    %eax,%eax
}
801053b2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053b5:	5b                   	pop    %ebx
801053b6:	5e                   	pop    %esi
801053b7:	5d                   	pop    %ebp
801053b8:	c3                   	ret    
801053b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801053c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053c5:	eb eb                	jmp    801053b2 <argptr+0x42>
801053c7:	89 f6                	mov    %esi,%esi
801053c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053d0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
801053d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053d9:	50                   	push   %eax
801053da:	ff 75 08             	pushl  0x8(%ebp)
801053dd:	e8 3e ff ff ff       	call   80105320 <argint>
801053e2:	83 c4 10             	add    $0x10,%esp
801053e5:	85 c0                	test   %eax,%eax
801053e7:	78 17                	js     80105400 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801053e9:	83 ec 08             	sub    $0x8,%esp
801053ec:	ff 75 0c             	pushl  0xc(%ebp)
801053ef:	ff 75 f4             	pushl  -0xc(%ebp)
801053f2:	e8 c9 fe ff ff       	call   801052c0 <fetchstr>
801053f7:	83 c4 10             	add    $0x10,%esp
}
801053fa:	c9                   	leave  
801053fb:	c3                   	ret    
801053fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105400:	c9                   	leave  
    return -1;
80105401:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105406:	c3                   	ret    
80105407:	89 f6                	mov    %esi,%esi
80105409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105410 <syscall>:
[SYS_changeScheduler]   sys_changeScheduler
};

void
syscall(void)
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	53                   	push   %ebx
80105414:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105417:	e8 84 e8 ff ff       	call   80103ca0 <myproc>
8010541c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010541e:	8b 40 18             	mov    0x18(%eax),%eax
80105421:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105424:	8d 50 ff             	lea    -0x1(%eax),%edx
80105427:	83 fa 16             	cmp    $0x16,%edx
8010542a:	77 1c                	ja     80105448 <syscall+0x38>
8010542c:	8b 14 85 40 83 10 80 	mov    -0x7fef7cc0(,%eax,4),%edx
80105433:	85 d2                	test   %edx,%edx
80105435:	74 11                	je     80105448 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80105437:	ff d2                	call   *%edx
80105439:	8b 53 18             	mov    0x18(%ebx),%edx
8010543c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010543f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105442:	c9                   	leave  
80105443:	c3                   	ret    
80105444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105448:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105449:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
8010544c:	50                   	push   %eax
8010544d:	ff 73 10             	pushl  0x10(%ebx)
80105450:	68 19 83 10 80       	push   $0x80108319
80105455:	e8 56 b2 ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
8010545a:	8b 43 18             	mov    0x18(%ebx),%eax
8010545d:	83 c4 10             	add    $0x10,%esp
80105460:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80105467:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010546a:	c9                   	leave  
8010546b:	c3                   	ret    
8010546c:	66 90                	xchg   %ax,%ax
8010546e:	66 90                	xchg   %ax,%ax

80105470 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
80105473:	57                   	push   %edi
80105474:	56                   	push   %esi
80105475:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105476:	8d 5d da             	lea    -0x26(%ebp),%ebx
{
80105479:	83 ec 44             	sub    $0x44,%esp
8010547c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010547f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105482:	53                   	push   %ebx
80105483:	50                   	push   %eax
{
80105484:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105487:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010548a:	e8 51 cb ff ff       	call   80101fe0 <nameiparent>
8010548f:	83 c4 10             	add    $0x10,%esp
80105492:	85 c0                	test   %eax,%eax
80105494:	0f 84 46 01 00 00    	je     801055e0 <create+0x170>
    return 0;
  ilock(dp);
8010549a:	83 ec 0c             	sub    $0xc,%esp
8010549d:	89 c6                	mov    %eax,%esi
8010549f:	50                   	push   %eax
801054a0:	e8 7b c2 ff ff       	call   80101720 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801054a5:	83 c4 0c             	add    $0xc,%esp
801054a8:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801054ab:	50                   	push   %eax
801054ac:	53                   	push   %ebx
801054ad:	56                   	push   %esi
801054ae:	e8 9d c7 ff ff       	call   80101c50 <dirlookup>
801054b3:	83 c4 10             	add    $0x10,%esp
801054b6:	89 c7                	mov    %eax,%edi
801054b8:	85 c0                	test   %eax,%eax
801054ba:	74 54                	je     80105510 <create+0xa0>
    iunlockput(dp);
801054bc:	83 ec 0c             	sub    $0xc,%esp
801054bf:	56                   	push   %esi
801054c0:	e8 eb c4 ff ff       	call   801019b0 <iunlockput>
    ilock(ip);
801054c5:	89 3c 24             	mov    %edi,(%esp)
801054c8:	e8 53 c2 ff ff       	call   80101720 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801054cd:	83 c4 10             	add    $0x10,%esp
801054d0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
801054d5:	75 19                	jne    801054f0 <create+0x80>
801054d7:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
801054dc:	75 12                	jne    801054f0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801054de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054e1:	89 f8                	mov    %edi,%eax
801054e3:	5b                   	pop    %ebx
801054e4:	5e                   	pop    %esi
801054e5:	5f                   	pop    %edi
801054e6:	5d                   	pop    %ebp
801054e7:	c3                   	ret    
801054e8:	90                   	nop
801054e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
801054f0:	83 ec 0c             	sub    $0xc,%esp
801054f3:	57                   	push   %edi
    return 0;
801054f4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
801054f6:	e8 b5 c4 ff ff       	call   801019b0 <iunlockput>
    return 0;
801054fb:	83 c4 10             	add    $0x10,%esp
}
801054fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105501:	89 f8                	mov    %edi,%eax
80105503:	5b                   	pop    %ebx
80105504:	5e                   	pop    %esi
80105505:	5f                   	pop    %edi
80105506:	5d                   	pop    %ebp
80105507:	c3                   	ret    
80105508:	90                   	nop
80105509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = ialloc(dp->dev, type)) == 0)
80105510:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80105514:	83 ec 08             	sub    $0x8,%esp
80105517:	50                   	push   %eax
80105518:	ff 36                	pushl  (%esi)
8010551a:	e8 91 c0 ff ff       	call   801015b0 <ialloc>
8010551f:	83 c4 10             	add    $0x10,%esp
80105522:	89 c7                	mov    %eax,%edi
80105524:	85 c0                	test   %eax,%eax
80105526:	0f 84 cd 00 00 00    	je     801055f9 <create+0x189>
  ilock(ip);
8010552c:	83 ec 0c             	sub    $0xc,%esp
8010552f:	50                   	push   %eax
80105530:	e8 eb c1 ff ff       	call   80101720 <ilock>
  ip->major = major;
80105535:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80105539:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
8010553d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80105541:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105545:	b8 01 00 00 00       	mov    $0x1,%eax
8010554a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010554e:	89 3c 24             	mov    %edi,(%esp)
80105551:	e8 1a c1 ff ff       	call   80101670 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105556:	83 c4 10             	add    $0x10,%esp
80105559:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
8010555e:	74 30                	je     80105590 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105560:	83 ec 04             	sub    $0x4,%esp
80105563:	ff 77 04             	pushl  0x4(%edi)
80105566:	53                   	push   %ebx
80105567:	56                   	push   %esi
80105568:	e8 93 c9 ff ff       	call   80101f00 <dirlink>
8010556d:	83 c4 10             	add    $0x10,%esp
80105570:	85 c0                	test   %eax,%eax
80105572:	78 78                	js     801055ec <create+0x17c>
  iunlockput(dp);
80105574:	83 ec 0c             	sub    $0xc,%esp
80105577:	56                   	push   %esi
80105578:	e8 33 c4 ff ff       	call   801019b0 <iunlockput>
  return ip;
8010557d:	83 c4 10             	add    $0x10,%esp
}
80105580:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105583:	89 f8                	mov    %edi,%eax
80105585:	5b                   	pop    %ebx
80105586:	5e                   	pop    %esi
80105587:	5f                   	pop    %edi
80105588:	5d                   	pop    %ebp
80105589:	c3                   	ret    
8010558a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105590:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105593:	66 83 46 56 01       	addw   $0x1,0x56(%esi)
    iupdate(dp);
80105598:	56                   	push   %esi
80105599:	e8 d2 c0 ff ff       	call   80101670 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010559e:	83 c4 0c             	add    $0xc,%esp
801055a1:	ff 77 04             	pushl  0x4(%edi)
801055a4:	68 bc 83 10 80       	push   $0x801083bc
801055a9:	57                   	push   %edi
801055aa:	e8 51 c9 ff ff       	call   80101f00 <dirlink>
801055af:	83 c4 10             	add    $0x10,%esp
801055b2:	85 c0                	test   %eax,%eax
801055b4:	78 18                	js     801055ce <create+0x15e>
801055b6:	83 ec 04             	sub    $0x4,%esp
801055b9:	ff 76 04             	pushl  0x4(%esi)
801055bc:	68 bb 83 10 80       	push   $0x801083bb
801055c1:	57                   	push   %edi
801055c2:	e8 39 c9 ff ff       	call   80101f00 <dirlink>
801055c7:	83 c4 10             	add    $0x10,%esp
801055ca:	85 c0                	test   %eax,%eax
801055cc:	79 92                	jns    80105560 <create+0xf0>
      panic("create dots");
801055ce:	83 ec 0c             	sub    $0xc,%esp
801055d1:	68 af 83 10 80       	push   $0x801083af
801055d6:	e8 b5 ad ff ff       	call   80100390 <panic>
801055db:	90                   	nop
801055dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
801055e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801055e3:	31 ff                	xor    %edi,%edi
}
801055e5:	5b                   	pop    %ebx
801055e6:	89 f8                	mov    %edi,%eax
801055e8:	5e                   	pop    %esi
801055e9:	5f                   	pop    %edi
801055ea:	5d                   	pop    %ebp
801055eb:	c3                   	ret    
    panic("create: dirlink");
801055ec:	83 ec 0c             	sub    $0xc,%esp
801055ef:	68 be 83 10 80       	push   $0x801083be
801055f4:	e8 97 ad ff ff       	call   80100390 <panic>
    panic("create: ialloc");
801055f9:	83 ec 0c             	sub    $0xc,%esp
801055fc:	68 a0 83 10 80       	push   $0x801083a0
80105601:	e8 8a ad ff ff       	call   80100390 <panic>
80105606:	8d 76 00             	lea    0x0(%esi),%esi
80105609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105610 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	56                   	push   %esi
80105614:	89 d6                	mov    %edx,%esi
80105616:	53                   	push   %ebx
80105617:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80105619:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010561c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010561f:	50                   	push   %eax
80105620:	6a 00                	push   $0x0
80105622:	e8 f9 fc ff ff       	call   80105320 <argint>
80105627:	83 c4 10             	add    $0x10,%esp
8010562a:	85 c0                	test   %eax,%eax
8010562c:	78 2a                	js     80105658 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010562e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105632:	77 24                	ja     80105658 <argfd.constprop.0+0x48>
80105634:	e8 67 e6 ff ff       	call   80103ca0 <myproc>
80105639:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010563c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105640:	85 c0                	test   %eax,%eax
80105642:	74 14                	je     80105658 <argfd.constprop.0+0x48>
  if(pfd)
80105644:	85 db                	test   %ebx,%ebx
80105646:	74 02                	je     8010564a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105648:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010564a:	89 06                	mov    %eax,(%esi)
  return 0;
8010564c:	31 c0                	xor    %eax,%eax
}
8010564e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105651:	5b                   	pop    %ebx
80105652:	5e                   	pop    %esi
80105653:	5d                   	pop    %ebp
80105654:	c3                   	ret    
80105655:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105658:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010565d:	eb ef                	jmp    8010564e <argfd.constprop.0+0x3e>
8010565f:	90                   	nop

80105660 <sys_dup>:
{
80105660:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80105661:	31 c0                	xor    %eax,%eax
{
80105663:	89 e5                	mov    %esp,%ebp
80105665:	56                   	push   %esi
80105666:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80105667:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010566a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
8010566d:	e8 9e ff ff ff       	call   80105610 <argfd.constprop.0>
80105672:	85 c0                	test   %eax,%eax
80105674:	78 1a                	js     80105690 <sys_dup+0x30>
  if((fd=fdalloc(f)) < 0)
80105676:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105679:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010567b:	e8 20 e6 ff ff       	call   80103ca0 <myproc>
    if(curproc->ofile[fd] == 0){
80105680:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105684:	85 d2                	test   %edx,%edx
80105686:	74 18                	je     801056a0 <sys_dup+0x40>
  for(fd = 0; fd < NOFILE; fd++){
80105688:	83 c3 01             	add    $0x1,%ebx
8010568b:	83 fb 10             	cmp    $0x10,%ebx
8010568e:	75 f0                	jne    80105680 <sys_dup+0x20>
}
80105690:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105693:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105698:	89 d8                	mov    %ebx,%eax
8010569a:	5b                   	pop    %ebx
8010569b:	5e                   	pop    %esi
8010569c:	5d                   	pop    %ebp
8010569d:	c3                   	ret    
8010569e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801056a0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801056a4:	83 ec 0c             	sub    $0xc,%esp
801056a7:	ff 75 f4             	pushl  -0xc(%ebp)
801056aa:	e8 c1 b7 ff ff       	call   80100e70 <filedup>
  return fd;
801056af:	83 c4 10             	add    $0x10,%esp
}
801056b2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801056b5:	89 d8                	mov    %ebx,%eax
801056b7:	5b                   	pop    %ebx
801056b8:	5e                   	pop    %esi
801056b9:	5d                   	pop    %ebp
801056ba:	c3                   	ret    
801056bb:	90                   	nop
801056bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056c0 <sys_read>:
{
801056c0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801056c1:	31 c0                	xor    %eax,%eax
{
801056c3:	89 e5                	mov    %esp,%ebp
801056c5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801056c8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801056cb:	e8 40 ff ff ff       	call   80105610 <argfd.constprop.0>
801056d0:	85 c0                	test   %eax,%eax
801056d2:	78 4c                	js     80105720 <sys_read+0x60>
801056d4:	83 ec 08             	sub    $0x8,%esp
801056d7:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056da:	50                   	push   %eax
801056db:	6a 02                	push   $0x2
801056dd:	e8 3e fc ff ff       	call   80105320 <argint>
801056e2:	83 c4 10             	add    $0x10,%esp
801056e5:	85 c0                	test   %eax,%eax
801056e7:	78 37                	js     80105720 <sys_read+0x60>
801056e9:	83 ec 04             	sub    $0x4,%esp
801056ec:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056ef:	ff 75 f0             	pushl  -0x10(%ebp)
801056f2:	50                   	push   %eax
801056f3:	6a 01                	push   $0x1
801056f5:	e8 76 fc ff ff       	call   80105370 <argptr>
801056fa:	83 c4 10             	add    $0x10,%esp
801056fd:	85 c0                	test   %eax,%eax
801056ff:	78 1f                	js     80105720 <sys_read+0x60>
  return fileread(f, p, n);
80105701:	83 ec 04             	sub    $0x4,%esp
80105704:	ff 75 f0             	pushl  -0x10(%ebp)
80105707:	ff 75 f4             	pushl  -0xc(%ebp)
8010570a:	ff 75 ec             	pushl  -0x14(%ebp)
8010570d:	e8 de b8 ff ff       	call   80100ff0 <fileread>
80105712:	83 c4 10             	add    $0x10,%esp
}
80105715:	c9                   	leave  
80105716:	c3                   	ret    
80105717:	89 f6                	mov    %esi,%esi
80105719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105720:	c9                   	leave  
    return -1;
80105721:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105726:	c3                   	ret    
80105727:	89 f6                	mov    %esi,%esi
80105729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105730 <sys_write>:
{
80105730:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105731:	31 c0                	xor    %eax,%eax
{
80105733:	89 e5                	mov    %esp,%ebp
80105735:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105738:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010573b:	e8 d0 fe ff ff       	call   80105610 <argfd.constprop.0>
80105740:	85 c0                	test   %eax,%eax
80105742:	78 4c                	js     80105790 <sys_write+0x60>
80105744:	83 ec 08             	sub    $0x8,%esp
80105747:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010574a:	50                   	push   %eax
8010574b:	6a 02                	push   $0x2
8010574d:	e8 ce fb ff ff       	call   80105320 <argint>
80105752:	83 c4 10             	add    $0x10,%esp
80105755:	85 c0                	test   %eax,%eax
80105757:	78 37                	js     80105790 <sys_write+0x60>
80105759:	83 ec 04             	sub    $0x4,%esp
8010575c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010575f:	ff 75 f0             	pushl  -0x10(%ebp)
80105762:	50                   	push   %eax
80105763:	6a 01                	push   $0x1
80105765:	e8 06 fc ff ff       	call   80105370 <argptr>
8010576a:	83 c4 10             	add    $0x10,%esp
8010576d:	85 c0                	test   %eax,%eax
8010576f:	78 1f                	js     80105790 <sys_write+0x60>
  return filewrite(f, p, n);
80105771:	83 ec 04             	sub    $0x4,%esp
80105774:	ff 75 f0             	pushl  -0x10(%ebp)
80105777:	ff 75 f4             	pushl  -0xc(%ebp)
8010577a:	ff 75 ec             	pushl  -0x14(%ebp)
8010577d:	e8 fe b8 ff ff       	call   80101080 <filewrite>
80105782:	83 c4 10             	add    $0x10,%esp
}
80105785:	c9                   	leave  
80105786:	c3                   	ret    
80105787:	89 f6                	mov    %esi,%esi
80105789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105790:	c9                   	leave  
    return -1;
80105791:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105796:	c3                   	ret    
80105797:	89 f6                	mov    %esi,%esi
80105799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057a0 <sys_close>:
{
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
801057a6:	8d 55 f4             	lea    -0xc(%ebp),%edx
801057a9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057ac:	e8 5f fe ff ff       	call   80105610 <argfd.constprop.0>
801057b1:	85 c0                	test   %eax,%eax
801057b3:	78 2b                	js     801057e0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
801057b5:	e8 e6 e4 ff ff       	call   80103ca0 <myproc>
801057ba:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
801057bd:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801057c0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
801057c7:	00 
  fileclose(f);
801057c8:	ff 75 f4             	pushl  -0xc(%ebp)
801057cb:	e8 f0 b6 ff ff       	call   80100ec0 <fileclose>
  return 0;
801057d0:	83 c4 10             	add    $0x10,%esp
801057d3:	31 c0                	xor    %eax,%eax
}
801057d5:	c9                   	leave  
801057d6:	c3                   	ret    
801057d7:	89 f6                	mov    %esi,%esi
801057d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801057e0:	c9                   	leave  
    return -1;
801057e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057e6:	c3                   	ret    
801057e7:	89 f6                	mov    %esi,%esi
801057e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057f0 <sys_fstat>:
{
801057f0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801057f1:	31 c0                	xor    %eax,%eax
{
801057f3:	89 e5                	mov    %esp,%ebp
801057f5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801057f8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801057fb:	e8 10 fe ff ff       	call   80105610 <argfd.constprop.0>
80105800:	85 c0                	test   %eax,%eax
80105802:	78 2c                	js     80105830 <sys_fstat+0x40>
80105804:	83 ec 04             	sub    $0x4,%esp
80105807:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010580a:	6a 14                	push   $0x14
8010580c:	50                   	push   %eax
8010580d:	6a 01                	push   $0x1
8010580f:	e8 5c fb ff ff       	call   80105370 <argptr>
80105814:	83 c4 10             	add    $0x10,%esp
80105817:	85 c0                	test   %eax,%eax
80105819:	78 15                	js     80105830 <sys_fstat+0x40>
  return filestat(f, st);
8010581b:	83 ec 08             	sub    $0x8,%esp
8010581e:	ff 75 f4             	pushl  -0xc(%ebp)
80105821:	ff 75 f0             	pushl  -0x10(%ebp)
80105824:	e8 77 b7 ff ff       	call   80100fa0 <filestat>
80105829:	83 c4 10             	add    $0x10,%esp
}
8010582c:	c9                   	leave  
8010582d:	c3                   	ret    
8010582e:	66 90                	xchg   %ax,%ax
80105830:	c9                   	leave  
    return -1;
80105831:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105836:	c3                   	ret    
80105837:	89 f6                	mov    %esi,%esi
80105839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105840 <sys_link>:
{
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
80105843:	57                   	push   %edi
80105844:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105845:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105848:	53                   	push   %ebx
80105849:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010584c:	50                   	push   %eax
8010584d:	6a 00                	push   $0x0
8010584f:	e8 7c fb ff ff       	call   801053d0 <argstr>
80105854:	83 c4 10             	add    $0x10,%esp
80105857:	85 c0                	test   %eax,%eax
80105859:	0f 88 fb 00 00 00    	js     8010595a <sys_link+0x11a>
8010585f:	83 ec 08             	sub    $0x8,%esp
80105862:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105865:	50                   	push   %eax
80105866:	6a 01                	push   $0x1
80105868:	e8 63 fb ff ff       	call   801053d0 <argstr>
8010586d:	83 c4 10             	add    $0x10,%esp
80105870:	85 c0                	test   %eax,%eax
80105872:	0f 88 e2 00 00 00    	js     8010595a <sys_link+0x11a>
  begin_op();
80105878:	e8 a3 d6 ff ff       	call   80102f20 <begin_op>
  if((ip = namei(old)) == 0){
8010587d:	83 ec 0c             	sub    $0xc,%esp
80105880:	ff 75 d4             	pushl  -0x2c(%ebp)
80105883:	e8 38 c7 ff ff       	call   80101fc0 <namei>
80105888:	83 c4 10             	add    $0x10,%esp
8010588b:	89 c3                	mov    %eax,%ebx
8010588d:	85 c0                	test   %eax,%eax
8010588f:	0f 84 e4 00 00 00    	je     80105979 <sys_link+0x139>
  ilock(ip);
80105895:	83 ec 0c             	sub    $0xc,%esp
80105898:	50                   	push   %eax
80105899:	e8 82 be ff ff       	call   80101720 <ilock>
  if(ip->type == T_DIR){
8010589e:	83 c4 10             	add    $0x10,%esp
801058a1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801058a6:	0f 84 b5 00 00 00    	je     80105961 <sys_link+0x121>
  iupdate(ip);
801058ac:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801058af:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801058b4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801058b7:	53                   	push   %ebx
801058b8:	e8 b3 bd ff ff       	call   80101670 <iupdate>
  iunlock(ip);
801058bd:	89 1c 24             	mov    %ebx,(%esp)
801058c0:	e8 3b bf ff ff       	call   80101800 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801058c5:	58                   	pop    %eax
801058c6:	5a                   	pop    %edx
801058c7:	57                   	push   %edi
801058c8:	ff 75 d0             	pushl  -0x30(%ebp)
801058cb:	e8 10 c7 ff ff       	call   80101fe0 <nameiparent>
801058d0:	83 c4 10             	add    $0x10,%esp
801058d3:	89 c6                	mov    %eax,%esi
801058d5:	85 c0                	test   %eax,%eax
801058d7:	74 5b                	je     80105934 <sys_link+0xf4>
  ilock(dp);
801058d9:	83 ec 0c             	sub    $0xc,%esp
801058dc:	50                   	push   %eax
801058dd:	e8 3e be ff ff       	call   80101720 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801058e2:	83 c4 10             	add    $0x10,%esp
801058e5:	8b 03                	mov    (%ebx),%eax
801058e7:	39 06                	cmp    %eax,(%esi)
801058e9:	75 3d                	jne    80105928 <sys_link+0xe8>
801058eb:	83 ec 04             	sub    $0x4,%esp
801058ee:	ff 73 04             	pushl  0x4(%ebx)
801058f1:	57                   	push   %edi
801058f2:	56                   	push   %esi
801058f3:	e8 08 c6 ff ff       	call   80101f00 <dirlink>
801058f8:	83 c4 10             	add    $0x10,%esp
801058fb:	85 c0                	test   %eax,%eax
801058fd:	78 29                	js     80105928 <sys_link+0xe8>
  iunlockput(dp);
801058ff:	83 ec 0c             	sub    $0xc,%esp
80105902:	56                   	push   %esi
80105903:	e8 a8 c0 ff ff       	call   801019b0 <iunlockput>
  iput(ip);
80105908:	89 1c 24             	mov    %ebx,(%esp)
8010590b:	e8 40 bf ff ff       	call   80101850 <iput>
  end_op();
80105910:	e8 7b d6 ff ff       	call   80102f90 <end_op>
  return 0;
80105915:	83 c4 10             	add    $0x10,%esp
80105918:	31 c0                	xor    %eax,%eax
}
8010591a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010591d:	5b                   	pop    %ebx
8010591e:	5e                   	pop    %esi
8010591f:	5f                   	pop    %edi
80105920:	5d                   	pop    %ebp
80105921:	c3                   	ret    
80105922:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105928:	83 ec 0c             	sub    $0xc,%esp
8010592b:	56                   	push   %esi
8010592c:	e8 7f c0 ff ff       	call   801019b0 <iunlockput>
    goto bad;
80105931:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105934:	83 ec 0c             	sub    $0xc,%esp
80105937:	53                   	push   %ebx
80105938:	e8 e3 bd ff ff       	call   80101720 <ilock>
  ip->nlink--;
8010593d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105942:	89 1c 24             	mov    %ebx,(%esp)
80105945:	e8 26 bd ff ff       	call   80101670 <iupdate>
  iunlockput(ip);
8010594a:	89 1c 24             	mov    %ebx,(%esp)
8010594d:	e8 5e c0 ff ff       	call   801019b0 <iunlockput>
  end_op();
80105952:	e8 39 d6 ff ff       	call   80102f90 <end_op>
  return -1;
80105957:	83 c4 10             	add    $0x10,%esp
8010595a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010595f:	eb b9                	jmp    8010591a <sys_link+0xda>
    iunlockput(ip);
80105961:	83 ec 0c             	sub    $0xc,%esp
80105964:	53                   	push   %ebx
80105965:	e8 46 c0 ff ff       	call   801019b0 <iunlockput>
    end_op();
8010596a:	e8 21 d6 ff ff       	call   80102f90 <end_op>
    return -1;
8010596f:	83 c4 10             	add    $0x10,%esp
80105972:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105977:	eb a1                	jmp    8010591a <sys_link+0xda>
    end_op();
80105979:	e8 12 d6 ff ff       	call   80102f90 <end_op>
    return -1;
8010597e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105983:	eb 95                	jmp    8010591a <sys_link+0xda>
80105985:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105990 <sys_unlink>:
{
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
80105993:	57                   	push   %edi
80105994:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105995:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105998:	53                   	push   %ebx
80105999:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010599c:	50                   	push   %eax
8010599d:	6a 00                	push   $0x0
8010599f:	e8 2c fa ff ff       	call   801053d0 <argstr>
801059a4:	83 c4 10             	add    $0x10,%esp
801059a7:	85 c0                	test   %eax,%eax
801059a9:	0f 88 91 01 00 00    	js     80105b40 <sys_unlink+0x1b0>
  begin_op();
801059af:	e8 6c d5 ff ff       	call   80102f20 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801059b4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801059b7:	83 ec 08             	sub    $0x8,%esp
801059ba:	53                   	push   %ebx
801059bb:	ff 75 c0             	pushl  -0x40(%ebp)
801059be:	e8 1d c6 ff ff       	call   80101fe0 <nameiparent>
801059c3:	83 c4 10             	add    $0x10,%esp
801059c6:	89 c6                	mov    %eax,%esi
801059c8:	85 c0                	test   %eax,%eax
801059ca:	0f 84 7a 01 00 00    	je     80105b4a <sys_unlink+0x1ba>
  ilock(dp);
801059d0:	83 ec 0c             	sub    $0xc,%esp
801059d3:	50                   	push   %eax
801059d4:	e8 47 bd ff ff       	call   80101720 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801059d9:	58                   	pop    %eax
801059da:	5a                   	pop    %edx
801059db:	68 bc 83 10 80       	push   $0x801083bc
801059e0:	53                   	push   %ebx
801059e1:	e8 4a c2 ff ff       	call   80101c30 <namecmp>
801059e6:	83 c4 10             	add    $0x10,%esp
801059e9:	85 c0                	test   %eax,%eax
801059eb:	0f 84 0f 01 00 00    	je     80105b00 <sys_unlink+0x170>
801059f1:	83 ec 08             	sub    $0x8,%esp
801059f4:	68 bb 83 10 80       	push   $0x801083bb
801059f9:	53                   	push   %ebx
801059fa:	e8 31 c2 ff ff       	call   80101c30 <namecmp>
801059ff:	83 c4 10             	add    $0x10,%esp
80105a02:	85 c0                	test   %eax,%eax
80105a04:	0f 84 f6 00 00 00    	je     80105b00 <sys_unlink+0x170>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105a0a:	83 ec 04             	sub    $0x4,%esp
80105a0d:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105a10:	50                   	push   %eax
80105a11:	53                   	push   %ebx
80105a12:	56                   	push   %esi
80105a13:	e8 38 c2 ff ff       	call   80101c50 <dirlookup>
80105a18:	83 c4 10             	add    $0x10,%esp
80105a1b:	89 c3                	mov    %eax,%ebx
80105a1d:	85 c0                	test   %eax,%eax
80105a1f:	0f 84 db 00 00 00    	je     80105b00 <sys_unlink+0x170>
  ilock(ip);
80105a25:	83 ec 0c             	sub    $0xc,%esp
80105a28:	50                   	push   %eax
80105a29:	e8 f2 bc ff ff       	call   80101720 <ilock>
  if(ip->nlink < 1)
80105a2e:	83 c4 10             	add    $0x10,%esp
80105a31:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105a36:	0f 8e 37 01 00 00    	jle    80105b73 <sys_unlink+0x1e3>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105a3c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a41:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105a44:	74 6a                	je     80105ab0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105a46:	83 ec 04             	sub    $0x4,%esp
80105a49:	6a 10                	push   $0x10
80105a4b:	6a 00                	push   $0x0
80105a4d:	57                   	push   %edi
80105a4e:	e8 ed f5 ff ff       	call   80105040 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105a53:	6a 10                	push   $0x10
80105a55:	ff 75 c4             	pushl  -0x3c(%ebp)
80105a58:	57                   	push   %edi
80105a59:	56                   	push   %esi
80105a5a:	e8 a1 c0 ff ff       	call   80101b00 <writei>
80105a5f:	83 c4 20             	add    $0x20,%esp
80105a62:	83 f8 10             	cmp    $0x10,%eax
80105a65:	0f 85 fb 00 00 00    	jne    80105b66 <sys_unlink+0x1d6>
  if(ip->type == T_DIR){
80105a6b:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a70:	0f 84 aa 00 00 00    	je     80105b20 <sys_unlink+0x190>
  iunlockput(dp);
80105a76:	83 ec 0c             	sub    $0xc,%esp
80105a79:	56                   	push   %esi
80105a7a:	e8 31 bf ff ff       	call   801019b0 <iunlockput>
  ip->nlink--;
80105a7f:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105a84:	89 1c 24             	mov    %ebx,(%esp)
80105a87:	e8 e4 bb ff ff       	call   80101670 <iupdate>
  iunlockput(ip);
80105a8c:	89 1c 24             	mov    %ebx,(%esp)
80105a8f:	e8 1c bf ff ff       	call   801019b0 <iunlockput>
  end_op();
80105a94:	e8 f7 d4 ff ff       	call   80102f90 <end_op>
  return 0;
80105a99:	83 c4 10             	add    $0x10,%esp
80105a9c:	31 c0                	xor    %eax,%eax
}
80105a9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105aa1:	5b                   	pop    %ebx
80105aa2:	5e                   	pop    %esi
80105aa3:	5f                   	pop    %edi
80105aa4:	5d                   	pop    %ebp
80105aa5:	c3                   	ret    
80105aa6:	8d 76 00             	lea    0x0(%esi),%esi
80105aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105ab0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105ab4:	76 90                	jbe    80105a46 <sys_unlink+0xb6>
80105ab6:	ba 20 00 00 00       	mov    $0x20,%edx
80105abb:	eb 0f                	jmp    80105acc <sys_unlink+0x13c>
80105abd:	8d 76 00             	lea    0x0(%esi),%esi
80105ac0:	83 c2 10             	add    $0x10,%edx
80105ac3:	39 53 58             	cmp    %edx,0x58(%ebx)
80105ac6:	0f 86 7a ff ff ff    	jbe    80105a46 <sys_unlink+0xb6>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105acc:	6a 10                	push   $0x10
80105ace:	52                   	push   %edx
80105acf:	57                   	push   %edi
80105ad0:	53                   	push   %ebx
80105ad1:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105ad4:	e8 27 bf ff ff       	call   80101a00 <readi>
80105ad9:	83 c4 10             	add    $0x10,%esp
80105adc:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80105adf:	83 f8 10             	cmp    $0x10,%eax
80105ae2:	75 75                	jne    80105b59 <sys_unlink+0x1c9>
    if(de.inum != 0)
80105ae4:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105ae9:	74 d5                	je     80105ac0 <sys_unlink+0x130>
    iunlockput(ip);
80105aeb:	83 ec 0c             	sub    $0xc,%esp
80105aee:	53                   	push   %ebx
80105aef:	e8 bc be ff ff       	call   801019b0 <iunlockput>
    goto bad;
80105af4:	83 c4 10             	add    $0x10,%esp
80105af7:	89 f6                	mov    %esi,%esi
80105af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  iunlockput(dp);
80105b00:	83 ec 0c             	sub    $0xc,%esp
80105b03:	56                   	push   %esi
80105b04:	e8 a7 be ff ff       	call   801019b0 <iunlockput>
  end_op();
80105b09:	e8 82 d4 ff ff       	call   80102f90 <end_op>
  return -1;
80105b0e:	83 c4 10             	add    $0x10,%esp
80105b11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b16:	eb 86                	jmp    80105a9e <sys_unlink+0x10e>
80105b18:	90                   	nop
80105b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(dp);
80105b20:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105b23:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105b28:	56                   	push   %esi
80105b29:	e8 42 bb ff ff       	call   80101670 <iupdate>
80105b2e:	83 c4 10             	add    $0x10,%esp
80105b31:	e9 40 ff ff ff       	jmp    80105a76 <sys_unlink+0xe6>
80105b36:	8d 76 00             	lea    0x0(%esi),%esi
80105b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b45:	e9 54 ff ff ff       	jmp    80105a9e <sys_unlink+0x10e>
    end_op();
80105b4a:	e8 41 d4 ff ff       	call   80102f90 <end_op>
    return -1;
80105b4f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b54:	e9 45 ff ff ff       	jmp    80105a9e <sys_unlink+0x10e>
      panic("isdirempty: readi");
80105b59:	83 ec 0c             	sub    $0xc,%esp
80105b5c:	68 e0 83 10 80       	push   $0x801083e0
80105b61:	e8 2a a8 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105b66:	83 ec 0c             	sub    $0xc,%esp
80105b69:	68 f2 83 10 80       	push   $0x801083f2
80105b6e:	e8 1d a8 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105b73:	83 ec 0c             	sub    $0xc,%esp
80105b76:	68 ce 83 10 80       	push   $0x801083ce
80105b7b:	e8 10 a8 ff ff       	call   80100390 <panic>

80105b80 <sys_open>:

int
sys_open(void)
{
80105b80:	55                   	push   %ebp
80105b81:	89 e5                	mov    %esp,%ebp
80105b83:	57                   	push   %edi
80105b84:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105b85:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105b88:	53                   	push   %ebx
80105b89:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105b8c:	50                   	push   %eax
80105b8d:	6a 00                	push   $0x0
80105b8f:	e8 3c f8 ff ff       	call   801053d0 <argstr>
80105b94:	83 c4 10             	add    $0x10,%esp
80105b97:	85 c0                	test   %eax,%eax
80105b99:	0f 88 8e 00 00 00    	js     80105c2d <sys_open+0xad>
80105b9f:	83 ec 08             	sub    $0x8,%esp
80105ba2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105ba5:	50                   	push   %eax
80105ba6:	6a 01                	push   $0x1
80105ba8:	e8 73 f7 ff ff       	call   80105320 <argint>
80105bad:	83 c4 10             	add    $0x10,%esp
80105bb0:	85 c0                	test   %eax,%eax
80105bb2:	78 79                	js     80105c2d <sys_open+0xad>
    return -1;

  begin_op();
80105bb4:	e8 67 d3 ff ff       	call   80102f20 <begin_op>

  if(omode & O_CREATE){
80105bb9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105bbd:	75 79                	jne    80105c38 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105bbf:	83 ec 0c             	sub    $0xc,%esp
80105bc2:	ff 75 e0             	pushl  -0x20(%ebp)
80105bc5:	e8 f6 c3 ff ff       	call   80101fc0 <namei>
80105bca:	83 c4 10             	add    $0x10,%esp
80105bcd:	89 c6                	mov    %eax,%esi
80105bcf:	85 c0                	test   %eax,%eax
80105bd1:	0f 84 7e 00 00 00    	je     80105c55 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105bd7:	83 ec 0c             	sub    $0xc,%esp
80105bda:	50                   	push   %eax
80105bdb:	e8 40 bb ff ff       	call   80101720 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105be0:	83 c4 10             	add    $0x10,%esp
80105be3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105be8:	0f 84 c2 00 00 00    	je     80105cb0 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105bee:	e8 0d b2 ff ff       	call   80100e00 <filealloc>
80105bf3:	89 c7                	mov    %eax,%edi
80105bf5:	85 c0                	test   %eax,%eax
80105bf7:	74 23                	je     80105c1c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105bf9:	e8 a2 e0 ff ff       	call   80103ca0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105bfe:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105c00:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105c04:	85 d2                	test   %edx,%edx
80105c06:	74 60                	je     80105c68 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105c08:	83 c3 01             	add    $0x1,%ebx
80105c0b:	83 fb 10             	cmp    $0x10,%ebx
80105c0e:	75 f0                	jne    80105c00 <sys_open+0x80>
    if(f)
      fileclose(f);
80105c10:	83 ec 0c             	sub    $0xc,%esp
80105c13:	57                   	push   %edi
80105c14:	e8 a7 b2 ff ff       	call   80100ec0 <fileclose>
80105c19:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105c1c:	83 ec 0c             	sub    $0xc,%esp
80105c1f:	56                   	push   %esi
80105c20:	e8 8b bd ff ff       	call   801019b0 <iunlockput>
    end_op();
80105c25:	e8 66 d3 ff ff       	call   80102f90 <end_op>
    return -1;
80105c2a:	83 c4 10             	add    $0x10,%esp
80105c2d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105c32:	eb 6d                	jmp    80105ca1 <sys_open+0x121>
80105c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105c38:	83 ec 0c             	sub    $0xc,%esp
80105c3b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105c3e:	31 c9                	xor    %ecx,%ecx
80105c40:	ba 02 00 00 00       	mov    $0x2,%edx
80105c45:	6a 00                	push   $0x0
80105c47:	e8 24 f8 ff ff       	call   80105470 <create>
    if(ip == 0){
80105c4c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105c4f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105c51:	85 c0                	test   %eax,%eax
80105c53:	75 99                	jne    80105bee <sys_open+0x6e>
      end_op();
80105c55:	e8 36 d3 ff ff       	call   80102f90 <end_op>
      return -1;
80105c5a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105c5f:	eb 40                	jmp    80105ca1 <sys_open+0x121>
80105c61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105c68:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105c6b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105c6f:	56                   	push   %esi
80105c70:	e8 8b bb ff ff       	call   80101800 <iunlock>
  end_op();
80105c75:	e8 16 d3 ff ff       	call   80102f90 <end_op>

  f->type = FD_INODE;
80105c7a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105c80:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105c83:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105c86:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105c89:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105c8b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105c92:	f7 d0                	not    %eax
80105c94:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105c97:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105c9a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105c9d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105ca1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ca4:	89 d8                	mov    %ebx,%eax
80105ca6:	5b                   	pop    %ebx
80105ca7:	5e                   	pop    %esi
80105ca8:	5f                   	pop    %edi
80105ca9:	5d                   	pop    %ebp
80105caa:	c3                   	ret    
80105cab:	90                   	nop
80105cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105cb0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105cb3:	85 c9                	test   %ecx,%ecx
80105cb5:	0f 84 33 ff ff ff    	je     80105bee <sys_open+0x6e>
80105cbb:	e9 5c ff ff ff       	jmp    80105c1c <sys_open+0x9c>

80105cc0 <sys_mkdir>:

int
sys_mkdir(void)
{
80105cc0:	55                   	push   %ebp
80105cc1:	89 e5                	mov    %esp,%ebp
80105cc3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105cc6:	e8 55 d2 ff ff       	call   80102f20 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105ccb:	83 ec 08             	sub    $0x8,%esp
80105cce:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105cd1:	50                   	push   %eax
80105cd2:	6a 00                	push   $0x0
80105cd4:	e8 f7 f6 ff ff       	call   801053d0 <argstr>
80105cd9:	83 c4 10             	add    $0x10,%esp
80105cdc:	85 c0                	test   %eax,%eax
80105cde:	78 30                	js     80105d10 <sys_mkdir+0x50>
80105ce0:	83 ec 0c             	sub    $0xc,%esp
80105ce3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ce6:	31 c9                	xor    %ecx,%ecx
80105ce8:	ba 01 00 00 00       	mov    $0x1,%edx
80105ced:	6a 00                	push   $0x0
80105cef:	e8 7c f7 ff ff       	call   80105470 <create>
80105cf4:	83 c4 10             	add    $0x10,%esp
80105cf7:	85 c0                	test   %eax,%eax
80105cf9:	74 15                	je     80105d10 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105cfb:	83 ec 0c             	sub    $0xc,%esp
80105cfe:	50                   	push   %eax
80105cff:	e8 ac bc ff ff       	call   801019b0 <iunlockput>
  end_op();
80105d04:	e8 87 d2 ff ff       	call   80102f90 <end_op>
  return 0;
80105d09:	83 c4 10             	add    $0x10,%esp
80105d0c:	31 c0                	xor    %eax,%eax
}
80105d0e:	c9                   	leave  
80105d0f:	c3                   	ret    
    end_op();
80105d10:	e8 7b d2 ff ff       	call   80102f90 <end_op>
    return -1;
80105d15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d1a:	c9                   	leave  
80105d1b:	c3                   	ret    
80105d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d20 <sys_mknod>:

int
sys_mknod(void)
{
80105d20:	55                   	push   %ebp
80105d21:	89 e5                	mov    %esp,%ebp
80105d23:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105d26:	e8 f5 d1 ff ff       	call   80102f20 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105d2b:	83 ec 08             	sub    $0x8,%esp
80105d2e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105d31:	50                   	push   %eax
80105d32:	6a 00                	push   $0x0
80105d34:	e8 97 f6 ff ff       	call   801053d0 <argstr>
80105d39:	83 c4 10             	add    $0x10,%esp
80105d3c:	85 c0                	test   %eax,%eax
80105d3e:	78 60                	js     80105da0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105d40:	83 ec 08             	sub    $0x8,%esp
80105d43:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105d46:	50                   	push   %eax
80105d47:	6a 01                	push   $0x1
80105d49:	e8 d2 f5 ff ff       	call   80105320 <argint>
  if((argstr(0, &path)) < 0 ||
80105d4e:	83 c4 10             	add    $0x10,%esp
80105d51:	85 c0                	test   %eax,%eax
80105d53:	78 4b                	js     80105da0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105d55:	83 ec 08             	sub    $0x8,%esp
80105d58:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d5b:	50                   	push   %eax
80105d5c:	6a 02                	push   $0x2
80105d5e:	e8 bd f5 ff ff       	call   80105320 <argint>
     argint(1, &major) < 0 ||
80105d63:	83 c4 10             	add    $0x10,%esp
80105d66:	85 c0                	test   %eax,%eax
80105d68:	78 36                	js     80105da0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105d6a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105d6e:	83 ec 0c             	sub    $0xc,%esp
80105d71:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105d75:	ba 03 00 00 00       	mov    $0x3,%edx
80105d7a:	50                   	push   %eax
80105d7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105d7e:	e8 ed f6 ff ff       	call   80105470 <create>
     argint(2, &minor) < 0 ||
80105d83:	83 c4 10             	add    $0x10,%esp
80105d86:	85 c0                	test   %eax,%eax
80105d88:	74 16                	je     80105da0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105d8a:	83 ec 0c             	sub    $0xc,%esp
80105d8d:	50                   	push   %eax
80105d8e:	e8 1d bc ff ff       	call   801019b0 <iunlockput>
  end_op();
80105d93:	e8 f8 d1 ff ff       	call   80102f90 <end_op>
  return 0;
80105d98:	83 c4 10             	add    $0x10,%esp
80105d9b:	31 c0                	xor    %eax,%eax
}
80105d9d:	c9                   	leave  
80105d9e:	c3                   	ret    
80105d9f:	90                   	nop
    end_op();
80105da0:	e8 eb d1 ff ff       	call   80102f90 <end_op>
    return -1;
80105da5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105daa:	c9                   	leave  
80105dab:	c3                   	ret    
80105dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105db0 <sys_chdir>:

int
sys_chdir(void)
{
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	56                   	push   %esi
80105db4:	53                   	push   %ebx
80105db5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105db8:	e8 e3 de ff ff       	call   80103ca0 <myproc>
80105dbd:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105dbf:	e8 5c d1 ff ff       	call   80102f20 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105dc4:	83 ec 08             	sub    $0x8,%esp
80105dc7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105dca:	50                   	push   %eax
80105dcb:	6a 00                	push   $0x0
80105dcd:	e8 fe f5 ff ff       	call   801053d0 <argstr>
80105dd2:	83 c4 10             	add    $0x10,%esp
80105dd5:	85 c0                	test   %eax,%eax
80105dd7:	78 77                	js     80105e50 <sys_chdir+0xa0>
80105dd9:	83 ec 0c             	sub    $0xc,%esp
80105ddc:	ff 75 f4             	pushl  -0xc(%ebp)
80105ddf:	e8 dc c1 ff ff       	call   80101fc0 <namei>
80105de4:	83 c4 10             	add    $0x10,%esp
80105de7:	89 c3                	mov    %eax,%ebx
80105de9:	85 c0                	test   %eax,%eax
80105deb:	74 63                	je     80105e50 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105ded:	83 ec 0c             	sub    $0xc,%esp
80105df0:	50                   	push   %eax
80105df1:	e8 2a b9 ff ff       	call   80101720 <ilock>
  if(ip->type != T_DIR){
80105df6:	83 c4 10             	add    $0x10,%esp
80105df9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105dfe:	75 30                	jne    80105e30 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105e00:	83 ec 0c             	sub    $0xc,%esp
80105e03:	53                   	push   %ebx
80105e04:	e8 f7 b9 ff ff       	call   80101800 <iunlock>
  iput(curproc->cwd);
80105e09:	58                   	pop    %eax
80105e0a:	ff 76 68             	pushl  0x68(%esi)
80105e0d:	e8 3e ba ff ff       	call   80101850 <iput>
  end_op();
80105e12:	e8 79 d1 ff ff       	call   80102f90 <end_op>
  curproc->cwd = ip;
80105e17:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105e1a:	83 c4 10             	add    $0x10,%esp
80105e1d:	31 c0                	xor    %eax,%eax
}
80105e1f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105e22:	5b                   	pop    %ebx
80105e23:	5e                   	pop    %esi
80105e24:	5d                   	pop    %ebp
80105e25:	c3                   	ret    
80105e26:	8d 76 00             	lea    0x0(%esi),%esi
80105e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105e30:	83 ec 0c             	sub    $0xc,%esp
80105e33:	53                   	push   %ebx
80105e34:	e8 77 bb ff ff       	call   801019b0 <iunlockput>
    end_op();
80105e39:	e8 52 d1 ff ff       	call   80102f90 <end_op>
    return -1;
80105e3e:	83 c4 10             	add    $0x10,%esp
80105e41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e46:	eb d7                	jmp    80105e1f <sys_chdir+0x6f>
80105e48:	90                   	nop
80105e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105e50:	e8 3b d1 ff ff       	call   80102f90 <end_op>
    return -1;
80105e55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e5a:	eb c3                	jmp    80105e1f <sys_chdir+0x6f>
80105e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e60 <sys_exec>:

int
sys_exec(void)
{
80105e60:	55                   	push   %ebp
80105e61:	89 e5                	mov    %esp,%ebp
80105e63:	57                   	push   %edi
80105e64:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105e65:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105e6b:	53                   	push   %ebx
80105e6c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105e72:	50                   	push   %eax
80105e73:	6a 00                	push   $0x0
80105e75:	e8 56 f5 ff ff       	call   801053d0 <argstr>
80105e7a:	83 c4 10             	add    $0x10,%esp
80105e7d:	85 c0                	test   %eax,%eax
80105e7f:	0f 88 87 00 00 00    	js     80105f0c <sys_exec+0xac>
80105e85:	83 ec 08             	sub    $0x8,%esp
80105e88:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105e8e:	50                   	push   %eax
80105e8f:	6a 01                	push   $0x1
80105e91:	e8 8a f4 ff ff       	call   80105320 <argint>
80105e96:	83 c4 10             	add    $0x10,%esp
80105e99:	85 c0                	test   %eax,%eax
80105e9b:	78 6f                	js     80105f0c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105e9d:	83 ec 04             	sub    $0x4,%esp
80105ea0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80105ea6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105ea8:	68 80 00 00 00       	push   $0x80
80105ead:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105eb3:	6a 00                	push   $0x0
80105eb5:	50                   	push   %eax
80105eb6:	e8 85 f1 ff ff       	call   80105040 <memset>
80105ebb:	83 c4 10             	add    $0x10,%esp
80105ebe:	66 90                	xchg   %ax,%ax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105ec0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105ec6:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105ecd:	83 ec 08             	sub    $0x8,%esp
80105ed0:	57                   	push   %edi
80105ed1:	01 f0                	add    %esi,%eax
80105ed3:	50                   	push   %eax
80105ed4:	e8 a7 f3 ff ff       	call   80105280 <fetchint>
80105ed9:	83 c4 10             	add    $0x10,%esp
80105edc:	85 c0                	test   %eax,%eax
80105ede:	78 2c                	js     80105f0c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105ee0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105ee6:	85 c0                	test   %eax,%eax
80105ee8:	74 36                	je     80105f20 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105eea:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105ef0:	83 ec 08             	sub    $0x8,%esp
80105ef3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105ef6:	52                   	push   %edx
80105ef7:	50                   	push   %eax
80105ef8:	e8 c3 f3 ff ff       	call   801052c0 <fetchstr>
80105efd:	83 c4 10             	add    $0x10,%esp
80105f00:	85 c0                	test   %eax,%eax
80105f02:	78 08                	js     80105f0c <sys_exec+0xac>
  for(i=0;; i++){
80105f04:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105f07:	83 fb 20             	cmp    $0x20,%ebx
80105f0a:	75 b4                	jne    80105ec0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105f0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105f0f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f14:	5b                   	pop    %ebx
80105f15:	5e                   	pop    %esi
80105f16:	5f                   	pop    %edi
80105f17:	5d                   	pop    %ebp
80105f18:	c3                   	ret    
80105f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105f20:	83 ec 08             	sub    $0x8,%esp
80105f23:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
80105f29:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105f30:	00 00 00 00 
  return exec(path, argv);
80105f34:	50                   	push   %eax
80105f35:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105f3b:	e8 40 ab ff ff       	call   80100a80 <exec>
80105f40:	83 c4 10             	add    $0x10,%esp
}
80105f43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f46:	5b                   	pop    %ebx
80105f47:	5e                   	pop    %esi
80105f48:	5f                   	pop    %edi
80105f49:	5d                   	pop    %ebp
80105f4a:	c3                   	ret    
80105f4b:	90                   	nop
80105f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f50 <sys_pipe>:

int
sys_pipe(void)
{
80105f50:	55                   	push   %ebp
80105f51:	89 e5                	mov    %esp,%ebp
80105f53:	57                   	push   %edi
80105f54:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105f55:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105f58:	53                   	push   %ebx
80105f59:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105f5c:	6a 08                	push   $0x8
80105f5e:	50                   	push   %eax
80105f5f:	6a 00                	push   $0x0
80105f61:	e8 0a f4 ff ff       	call   80105370 <argptr>
80105f66:	83 c4 10             	add    $0x10,%esp
80105f69:	85 c0                	test   %eax,%eax
80105f6b:	78 4a                	js     80105fb7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105f6d:	83 ec 08             	sub    $0x8,%esp
80105f70:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f73:	50                   	push   %eax
80105f74:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105f77:	50                   	push   %eax
80105f78:	e8 53 d6 ff ff       	call   801035d0 <pipealloc>
80105f7d:	83 c4 10             	add    $0x10,%esp
80105f80:	85 c0                	test   %eax,%eax
80105f82:	78 33                	js     80105fb7 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105f84:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105f87:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105f89:	e8 12 dd ff ff       	call   80103ca0 <myproc>
80105f8e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105f90:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105f94:	85 f6                	test   %esi,%esi
80105f96:	74 28                	je     80105fc0 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80105f98:	83 c3 01             	add    $0x1,%ebx
80105f9b:	83 fb 10             	cmp    $0x10,%ebx
80105f9e:	75 f0                	jne    80105f90 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105fa0:	83 ec 0c             	sub    $0xc,%esp
80105fa3:	ff 75 e0             	pushl  -0x20(%ebp)
80105fa6:	e8 15 af ff ff       	call   80100ec0 <fileclose>
    fileclose(wf);
80105fab:	58                   	pop    %eax
80105fac:	ff 75 e4             	pushl  -0x1c(%ebp)
80105faf:	e8 0c af ff ff       	call   80100ec0 <fileclose>
    return -1;
80105fb4:	83 c4 10             	add    $0x10,%esp
80105fb7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fbc:	eb 53                	jmp    80106011 <sys_pipe+0xc1>
80105fbe:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105fc0:	8d 73 08             	lea    0x8(%ebx),%esi
80105fc3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105fc7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105fca:	e8 d1 dc ff ff       	call   80103ca0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105fcf:	31 d2                	xor    %edx,%edx
80105fd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105fd8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105fdc:	85 c9                	test   %ecx,%ecx
80105fde:	74 20                	je     80106000 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80105fe0:	83 c2 01             	add    $0x1,%edx
80105fe3:	83 fa 10             	cmp    $0x10,%edx
80105fe6:	75 f0                	jne    80105fd8 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
80105fe8:	e8 b3 dc ff ff       	call   80103ca0 <myproc>
80105fed:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105ff4:	00 
80105ff5:	eb a9                	jmp    80105fa0 <sys_pipe+0x50>
80105ff7:	89 f6                	mov    %esi,%esi
80105ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      curproc->ofile[fd] = f;
80106000:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80106004:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106007:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106009:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010600c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010600f:	31 c0                	xor    %eax,%eax
}
80106011:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106014:	5b                   	pop    %ebx
80106015:	5e                   	pop    %esi
80106016:	5f                   	pop    %edi
80106017:	5d                   	pop    %ebp
80106018:	c3                   	ret    
80106019:	66 90                	xchg   %ax,%ax
8010601b:	66 90                	xchg   %ax,%ax
8010601d:	66 90                	xchg   %ax,%ax
8010601f:	90                   	nop

80106020 <sys_changeScheduler>:
#include "proc.h"

int
sys_changeScheduler(void)
{
  return changeScheduler();
80106020:	e9 bb df ff ff       	jmp    80103fe0 <changeScheduler>
80106025:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106030 <sys_numFreePages>:
}

int
sys_numFreePages(void)
{
  return numFreePages();
80106030:	e9 1b c8 ff ff       	jmp    80102850 <numFreePages>
80106035:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106040 <sys_fork>:
}

int
sys_fork(void)
{
  return fork();
80106040:	e9 3b de ff ff       	jmp    80103e80 <fork>
80106045:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106050 <sys_exit>:
}

int
sys_exit(void)
{
80106050:	55                   	push   %ebp
80106051:	89 e5                	mov    %esp,%ebp
80106053:	83 ec 08             	sub    $0x8,%esp
  exit();
80106056:	e8 55 e6 ff ff       	call   801046b0 <exit>
  return 0;  // not reached
}
8010605b:	31 c0                	xor    %eax,%eax
8010605d:	c9                   	leave  
8010605e:	c3                   	ret    
8010605f:	90                   	nop

80106060 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80106060:	e9 8b e9 ff ff       	jmp    801049f0 <wait>
80106065:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106070 <sys_kill>:
}

int
sys_kill(void)
{
80106070:	55                   	push   %ebp
80106071:	89 e5                	mov    %esp,%ebp
80106073:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106076:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106079:	50                   	push   %eax
8010607a:	6a 00                	push   $0x0
8010607c:	e8 9f f2 ff ff       	call   80105320 <argint>
80106081:	83 c4 10             	add    $0x10,%esp
80106084:	85 c0                	test   %eax,%eax
80106086:	78 18                	js     801060a0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106088:	83 ec 0c             	sub    $0xc,%esp
8010608b:	ff 75 f4             	pushl  -0xc(%ebp)
8010608e:	e8 8d ea ff ff       	call   80104b20 <kill>
80106093:	83 c4 10             	add    $0x10,%esp
}
80106096:	c9                   	leave  
80106097:	c3                   	ret    
80106098:	90                   	nop
80106099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060a0:	c9                   	leave  
    return -1;
801060a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060a6:	c3                   	ret    
801060a7:	89 f6                	mov    %esi,%esi
801060a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801060b0 <sys_getpid>:

int
sys_getpid(void)
{
801060b0:	55                   	push   %ebp
801060b1:	89 e5                	mov    %esp,%ebp
801060b3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801060b6:	e8 e5 db ff ff       	call   80103ca0 <myproc>
801060bb:	8b 40 10             	mov    0x10(%eax),%eax
}
801060be:	c9                   	leave  
801060bf:	c3                   	ret    

801060c0 <sys_sbrk>:

int
sys_sbrk(void)
{
801060c0:	55                   	push   %ebp
801060c1:	89 e5                	mov    %esp,%ebp
801060c3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801060c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801060c7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801060ca:	50                   	push   %eax
801060cb:	6a 00                	push   $0x0
801060cd:	e8 4e f2 ff ff       	call   80105320 <argint>
801060d2:	83 c4 10             	add    $0x10,%esp
801060d5:	85 c0                	test   %eax,%eax
801060d7:	78 27                	js     80106100 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801060d9:	e8 c2 db ff ff       	call   80103ca0 <myproc>
  if(growproc(n) < 0)
801060de:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801060e1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801060e3:	ff 75 f4             	pushl  -0xc(%ebp)
801060e6:	e8 15 dd ff ff       	call   80103e00 <growproc>
801060eb:	83 c4 10             	add    $0x10,%esp
801060ee:	85 c0                	test   %eax,%eax
801060f0:	78 0e                	js     80106100 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801060f2:	89 d8                	mov    %ebx,%eax
801060f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801060f7:	c9                   	leave  
801060f8:	c3                   	ret    
801060f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106100:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106105:	eb eb                	jmp    801060f2 <sys_sbrk+0x32>
80106107:	89 f6                	mov    %esi,%esi
80106109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106110 <sys_sleep>:

int
sys_sleep(void)
{
80106110:	55                   	push   %ebp
80106111:	89 e5                	mov    %esp,%ebp
80106113:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106114:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106117:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010611a:	50                   	push   %eax
8010611b:	6a 00                	push   $0x0
8010611d:	e8 fe f1 ff ff       	call   80105320 <argint>
80106122:	83 c4 10             	add    $0x10,%esp
80106125:	85 c0                	test   %eax,%eax
80106127:	0f 88 8a 00 00 00    	js     801061b7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010612d:	83 ec 0c             	sub    $0xc,%esp
80106130:	68 c0 e0 14 80       	push   $0x8014e0c0
80106135:	e8 f6 ed ff ff       	call   80104f30 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010613a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
8010613d:	8b 1d 00 e9 14 80    	mov    0x8014e900,%ebx
  while(ticks - ticks0 < n){
80106143:	83 c4 10             	add    $0x10,%esp
80106146:	85 d2                	test   %edx,%edx
80106148:	75 27                	jne    80106171 <sys_sleep+0x61>
8010614a:	eb 54                	jmp    801061a0 <sys_sleep+0x90>
8010614c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106150:	83 ec 08             	sub    $0x8,%esp
80106153:	68 c0 e0 14 80       	push   $0x8014e0c0
80106158:	68 00 e9 14 80       	push   $0x8014e900
8010615d:	e8 ce e7 ff ff       	call   80104930 <sleep>
  while(ticks - ticks0 < n){
80106162:	a1 00 e9 14 80       	mov    0x8014e900,%eax
80106167:	83 c4 10             	add    $0x10,%esp
8010616a:	29 d8                	sub    %ebx,%eax
8010616c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010616f:	73 2f                	jae    801061a0 <sys_sleep+0x90>
    if(myproc()->killed){
80106171:	e8 2a db ff ff       	call   80103ca0 <myproc>
80106176:	8b 40 24             	mov    0x24(%eax),%eax
80106179:	85 c0                	test   %eax,%eax
8010617b:	74 d3                	je     80106150 <sys_sleep+0x40>
      release(&tickslock);
8010617d:	83 ec 0c             	sub    $0xc,%esp
80106180:	68 c0 e0 14 80       	push   $0x8014e0c0
80106185:	e8 66 ee ff ff       	call   80104ff0 <release>
      return -1;
8010618a:	83 c4 10             	add    $0x10,%esp
8010618d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80106192:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106195:	c9                   	leave  
80106196:	c3                   	ret    
80106197:	89 f6                	mov    %esi,%esi
80106199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
801061a0:	83 ec 0c             	sub    $0xc,%esp
801061a3:	68 c0 e0 14 80       	push   $0x8014e0c0
801061a8:	e8 43 ee ff ff       	call   80104ff0 <release>
  return 0;
801061ad:	83 c4 10             	add    $0x10,%esp
801061b0:	31 c0                	xor    %eax,%eax
}
801061b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801061b5:	c9                   	leave  
801061b6:	c3                   	ret    
    return -1;
801061b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061bc:	eb f4                	jmp    801061b2 <sys_sleep+0xa2>
801061be:	66 90                	xchg   %ax,%ax

801061c0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801061c0:	55                   	push   %ebp
801061c1:	89 e5                	mov    %esp,%ebp
801061c3:	53                   	push   %ebx
801061c4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801061c7:	68 c0 e0 14 80       	push   $0x8014e0c0
801061cc:	e8 5f ed ff ff       	call   80104f30 <acquire>
  xticks = ticks;
801061d1:	8b 1d 00 e9 14 80    	mov    0x8014e900,%ebx
  release(&tickslock);
801061d7:	c7 04 24 c0 e0 14 80 	movl   $0x8014e0c0,(%esp)
801061de:	e8 0d ee ff ff       	call   80104ff0 <release>
  return xticks;
}
801061e3:	89 d8                	mov    %ebx,%eax
801061e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801061e8:	c9                   	leave  
801061e9:	c3                   	ret    

801061ea <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801061ea:	1e                   	push   %ds
  pushl %es
801061eb:	06                   	push   %es
  pushl %fs
801061ec:	0f a0                	push   %fs
  pushl %gs
801061ee:	0f a8                	push   %gs
  pushal
801061f0:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801061f1:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801061f5:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801061f7:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801061f9:	54                   	push   %esp
  call trap
801061fa:	e8 c1 00 00 00       	call   801062c0 <trap>
  addl $4, %esp
801061ff:	83 c4 04             	add    $0x4,%esp

80106202 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106202:	61                   	popa   
  popl %gs
80106203:	0f a9                	pop    %gs
  popl %fs
80106205:	0f a1                	pop    %fs
  popl %es
80106207:	07                   	pop    %es
  popl %ds
80106208:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106209:	83 c4 08             	add    $0x8,%esp
  iret
8010620c:	cf                   	iret   
8010620d:	66 90                	xchg   %ax,%ax
8010620f:	90                   	nop

80106210 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106210:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106211:	31 c0                	xor    %eax,%eax
{
80106213:	89 e5                	mov    %esp,%ebp
80106215:	83 ec 08             	sub    $0x8,%esp
80106218:	90                   	nop
80106219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106220:	8b 14 85 2c b0 10 80 	mov    -0x7fef4fd4(,%eax,4),%edx
80106227:	c7 04 c5 02 e1 14 80 	movl   $0x8e000008,-0x7feb1efe(,%eax,8)
8010622e:	08 00 00 8e 
80106232:	66 89 14 c5 00 e1 14 	mov    %dx,-0x7feb1f00(,%eax,8)
80106239:	80 
8010623a:	c1 ea 10             	shr    $0x10,%edx
8010623d:	66 89 14 c5 06 e1 14 	mov    %dx,-0x7feb1efa(,%eax,8)
80106244:	80 
  for(i = 0; i < 256; i++)
80106245:	83 c0 01             	add    $0x1,%eax
80106248:	3d 00 01 00 00       	cmp    $0x100,%eax
8010624d:	75 d1                	jne    80106220 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010624f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106252:	a1 2c b1 10 80       	mov    0x8010b12c,%eax
80106257:	c7 05 02 e3 14 80 08 	movl   $0xef000008,0x8014e302
8010625e:	00 00 ef 
  initlock(&tickslock, "time");
80106261:	68 01 84 10 80       	push   $0x80108401
80106266:	68 c0 e0 14 80       	push   $0x8014e0c0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010626b:	66 a3 00 e3 14 80    	mov    %ax,0x8014e300
80106271:	c1 e8 10             	shr    $0x10,%eax
80106274:	66 a3 06 e3 14 80    	mov    %ax,0x8014e306
  initlock(&tickslock, "time");
8010627a:	e8 51 eb ff ff       	call   80104dd0 <initlock>
}
8010627f:	83 c4 10             	add    $0x10,%esp
80106282:	c9                   	leave  
80106283:	c3                   	ret    
80106284:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010628a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106290 <idtinit>:

void
idtinit(void)
{
80106290:	55                   	push   %ebp
  pd[0] = size-1;
80106291:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106296:	89 e5                	mov    %esp,%ebp
80106298:	83 ec 10             	sub    $0x10,%esp
8010629b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010629f:	b8 00 e1 14 80       	mov    $0x8014e100,%eax
801062a4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801062a8:	c1 e8 10             	shr    $0x10,%eax
801062ab:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801062af:	8d 45 fa             	lea    -0x6(%ebp),%eax
801062b2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801062b5:	c9                   	leave  
801062b6:	c3                   	ret    
801062b7:	89 f6                	mov    %esi,%esi
801062b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801062c0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801062c0:	55                   	push   %ebp
801062c1:	89 e5                	mov    %esp,%ebp
801062c3:	57                   	push   %edi
801062c4:	56                   	push   %esi
801062c5:	53                   	push   %ebx
801062c6:	83 ec 1c             	sub    $0x1c,%esp
801062c9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801062cc:	8b 47 30             	mov    0x30(%edi),%eax
801062cf:	83 f8 40             	cmp    $0x40,%eax
801062d2:	0f 84 d8 01 00 00    	je     801064b0 <trap+0x1f0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801062d8:	83 e8 0e             	sub    $0xe,%eax
801062db:	83 f8 31             	cmp    $0x31,%eax
801062de:	77 10                	ja     801062f0 <trap+0x30>
801062e0:	ff 24 85 a8 84 10 80 	jmp    *-0x7fef7b58(,%eax,4)
801062e7:	89 f6                	mov    %esi,%esi
801062e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801062f0:	e8 ab d9 ff ff       	call   80103ca0 <myproc>
801062f5:	8b 5f 38             	mov    0x38(%edi),%ebx
801062f8:	85 c0                	test   %eax,%eax
801062fa:	0f 84 34 02 00 00    	je     80106534 <trap+0x274>
80106300:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80106304:	0f 84 2a 02 00 00    	je     80106534 <trap+0x274>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010630a:	0f 20 d1             	mov    %cr2,%ecx
8010630d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106310:	e8 6b d9 ff ff       	call   80103c80 <cpuid>
80106315:	8b 77 30             	mov    0x30(%edi),%esi
80106318:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010631b:	8b 47 34             	mov    0x34(%edi),%eax
8010631e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106321:	e8 7a d9 ff ff       	call   80103ca0 <myproc>
80106326:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106329:	e8 72 d9 ff ff       	call   80103ca0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010632e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106331:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106334:	51                   	push   %ecx
80106335:	53                   	push   %ebx
80106336:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80106337:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010633a:	ff 75 e4             	pushl  -0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
8010633d:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106340:	56                   	push   %esi
80106341:	52                   	push   %edx
80106342:	ff 70 10             	pushl  0x10(%eax)
80106345:	68 64 84 10 80       	push   $0x80108464
8010634a:	e8 61 a3 ff ff       	call   801006b0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010634f:	83 c4 20             	add    $0x20,%esp
80106352:	e8 49 d9 ff ff       	call   80103ca0 <myproc>
80106357:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010635e:	e8 3d d9 ff ff       	call   80103ca0 <myproc>
80106363:	85 c0                	test   %eax,%eax
80106365:	74 1d                	je     80106384 <trap+0xc4>
80106367:	e8 34 d9 ff ff       	call   80103ca0 <myproc>
8010636c:	8b 50 24             	mov    0x24(%eax),%edx
8010636f:	85 d2                	test   %edx,%edx
80106371:	74 11                	je     80106384 <trap+0xc4>
80106373:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106377:	83 e0 03             	and    $0x3,%eax
8010637a:	66 83 f8 03          	cmp    $0x3,%ax
8010637e:	0f 84 64 01 00 00    	je     801064e8 <trap+0x228>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106384:	e8 17 d9 ff ff       	call   80103ca0 <myproc>
80106389:	85 c0                	test   %eax,%eax
8010638b:	74 0b                	je     80106398 <trap+0xd8>
8010638d:	e8 0e d9 ff ff       	call   80103ca0 <myproc>
80106392:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106396:	74 38                	je     801063d0 <trap+0x110>
     tf->trapno == T_IRQ0+IRQ_TIMER)
     handleTimerInterupt();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106398:	e8 03 d9 ff ff       	call   80103ca0 <myproc>
8010639d:	85 c0                	test   %eax,%eax
8010639f:	74 1d                	je     801063be <trap+0xfe>
801063a1:	e8 fa d8 ff ff       	call   80103ca0 <myproc>
801063a6:	8b 40 24             	mov    0x24(%eax),%eax
801063a9:	85 c0                	test   %eax,%eax
801063ab:	74 11                	je     801063be <trap+0xfe>
801063ad:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801063b1:	83 e0 03             	and    $0x3,%eax
801063b4:	66 83 f8 03          	cmp    $0x3,%ax
801063b8:	0f 84 1b 01 00 00    	je     801064d9 <trap+0x219>
    exit();
}
801063be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801063c1:	5b                   	pop    %ebx
801063c2:	5e                   	pop    %esi
801063c3:	5f                   	pop    %edi
801063c4:	5d                   	pop    %ebp
801063c5:	c3                   	ret    
801063c6:	8d 76 00             	lea    0x0(%esi),%esi
801063c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(myproc() && myproc()->state == RUNNING &&
801063d0:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
801063d4:	75 c2                	jne    80106398 <trap+0xd8>
     handleTimerInterupt();
801063d6:	e8 f5 e3 ff ff       	call   801047d0 <handleTimerInterupt>
801063db:	eb bb                	jmp    80106398 <trap+0xd8>
801063dd:	8d 76 00             	lea    0x0(%esi),%esi
    handlePageFault(tf->err);
801063e0:	83 ec 0c             	sub    $0xc,%esp
801063e3:	ff 77 34             	pushl  0x34(%edi)
801063e6:	e8 75 16 00 00       	call   80107a60 <handlePageFault>
    break;
801063eb:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801063ee:	e8 ad d8 ff ff       	call   80103ca0 <myproc>
801063f3:	85 c0                	test   %eax,%eax
801063f5:	0f 85 6c ff ff ff    	jne    80106367 <trap+0xa7>
801063fb:	eb 87                	jmp    80106384 <trap+0xc4>
801063fd:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80106400:	e8 7b d8 ff ff       	call   80103c80 <cpuid>
80106405:	85 c0                	test   %eax,%eax
80106407:	0f 84 f3 00 00 00    	je     80106500 <trap+0x240>
    lapiceoi();
8010640d:	e8 be c6 ff ff       	call   80102ad0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106412:	e8 89 d8 ff ff       	call   80103ca0 <myproc>
80106417:	85 c0                	test   %eax,%eax
80106419:	0f 85 48 ff ff ff    	jne    80106367 <trap+0xa7>
8010641f:	e9 60 ff ff ff       	jmp    80106384 <trap+0xc4>
80106424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106428:	e8 63 c5 ff ff       	call   80102990 <kbdintr>
    lapiceoi();
8010642d:	e8 9e c6 ff ff       	call   80102ad0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106432:	e8 69 d8 ff ff       	call   80103ca0 <myproc>
80106437:	85 c0                	test   %eax,%eax
80106439:	0f 85 28 ff ff ff    	jne    80106367 <trap+0xa7>
8010643f:	e9 40 ff ff ff       	jmp    80106384 <trap+0xc4>
80106444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106448:	e8 83 02 00 00       	call   801066d0 <uartintr>
    lapiceoi();
8010644d:	e8 7e c6 ff ff       	call   80102ad0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106452:	e8 49 d8 ff ff       	call   80103ca0 <myproc>
80106457:	85 c0                	test   %eax,%eax
80106459:	0f 85 08 ff ff ff    	jne    80106367 <trap+0xa7>
8010645f:	e9 20 ff ff ff       	jmp    80106384 <trap+0xc4>
80106464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106468:	8b 77 38             	mov    0x38(%edi),%esi
8010646b:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
8010646f:	e8 0c d8 ff ff       	call   80103c80 <cpuid>
80106474:	56                   	push   %esi
80106475:	53                   	push   %ebx
80106476:	50                   	push   %eax
80106477:	68 0c 84 10 80       	push   $0x8010840c
8010647c:	e8 2f a2 ff ff       	call   801006b0 <cprintf>
    lapiceoi();
80106481:	e8 4a c6 ff ff       	call   80102ad0 <lapiceoi>
    break;
80106486:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106489:	e8 12 d8 ff ff       	call   80103ca0 <myproc>
8010648e:	85 c0                	test   %eax,%eax
80106490:	0f 85 d1 fe ff ff    	jne    80106367 <trap+0xa7>
80106496:	e9 e9 fe ff ff       	jmp    80106384 <trap+0xc4>
8010649b:	90                   	nop
8010649c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
801064a0:	e8 bb bc ff ff       	call   80102160 <ideintr>
801064a5:	e9 63 ff ff ff       	jmp    8010640d <trap+0x14d>
801064aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
801064b0:	e8 eb d7 ff ff       	call   80103ca0 <myproc>
801064b5:	8b 58 24             	mov    0x24(%eax),%ebx
801064b8:	85 db                	test   %ebx,%ebx
801064ba:	75 3c                	jne    801064f8 <trap+0x238>
    myproc()->tf = tf;
801064bc:	e8 df d7 ff ff       	call   80103ca0 <myproc>
801064c1:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
801064c4:	e8 47 ef ff ff       	call   80105410 <syscall>
    if(myproc()->killed)
801064c9:	e8 d2 d7 ff ff       	call   80103ca0 <myproc>
801064ce:	8b 48 24             	mov    0x24(%eax),%ecx
801064d1:	85 c9                	test   %ecx,%ecx
801064d3:	0f 84 e5 fe ff ff    	je     801063be <trap+0xfe>
}
801064d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064dc:	5b                   	pop    %ebx
801064dd:	5e                   	pop    %esi
801064de:	5f                   	pop    %edi
801064df:	5d                   	pop    %ebp
      exit();
801064e0:	e9 cb e1 ff ff       	jmp    801046b0 <exit>
801064e5:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
801064e8:	e8 c3 e1 ff ff       	call   801046b0 <exit>
801064ed:	e9 92 fe ff ff       	jmp    80106384 <trap+0xc4>
801064f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801064f8:	e8 b3 e1 ff ff       	call   801046b0 <exit>
801064fd:	eb bd                	jmp    801064bc <trap+0x1fc>
801064ff:	90                   	nop
      acquire(&tickslock);
80106500:	83 ec 0c             	sub    $0xc,%esp
80106503:	68 c0 e0 14 80       	push   $0x8014e0c0
80106508:	e8 23 ea ff ff       	call   80104f30 <acquire>
      wakeup(&ticks);
8010650d:	c7 04 24 00 e9 14 80 	movl   $0x8014e900,(%esp)
      ticks++;
80106514:	83 05 00 e9 14 80 01 	addl   $0x1,0x8014e900
      wakeup(&ticks);
8010651b:	e8 d0 e5 ff ff       	call   80104af0 <wakeup>
      release(&tickslock);
80106520:	c7 04 24 c0 e0 14 80 	movl   $0x8014e0c0,(%esp)
80106527:	e8 c4 ea ff ff       	call   80104ff0 <release>
8010652c:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010652f:	e9 d9 fe ff ff       	jmp    8010640d <trap+0x14d>
80106534:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106537:	e8 44 d7 ff ff       	call   80103c80 <cpuid>
8010653c:	83 ec 0c             	sub    $0xc,%esp
8010653f:	56                   	push   %esi
80106540:	53                   	push   %ebx
80106541:	50                   	push   %eax
80106542:	ff 77 30             	pushl  0x30(%edi)
80106545:	68 30 84 10 80       	push   $0x80108430
8010654a:	e8 61 a1 ff ff       	call   801006b0 <cprintf>
      panic("trap");
8010654f:	83 c4 14             	add    $0x14,%esp
80106552:	68 06 84 10 80       	push   $0x80108406
80106557:	e8 34 9e ff ff       	call   80100390 <panic>
8010655c:	66 90                	xchg   %ax,%ax
8010655e:	66 90                	xchg   %ax,%ax

80106560 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106560:	a1 dc b5 10 80       	mov    0x8010b5dc,%eax
80106565:	85 c0                	test   %eax,%eax
80106567:	74 17                	je     80106580 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106569:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010656e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010656f:	a8 01                	test   $0x1,%al
80106571:	74 0d                	je     80106580 <uartgetc+0x20>
80106573:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106578:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106579:	0f b6 c0             	movzbl %al,%eax
8010657c:	c3                   	ret    
8010657d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106580:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106585:	c3                   	ret    
80106586:	8d 76 00             	lea    0x0(%esi),%esi
80106589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106590 <uartputc.part.0>:
uartputc(int c)
80106590:	55                   	push   %ebp
80106591:	89 e5                	mov    %esp,%ebp
80106593:	57                   	push   %edi
80106594:	89 c7                	mov    %eax,%edi
80106596:	56                   	push   %esi
80106597:	be fd 03 00 00       	mov    $0x3fd,%esi
8010659c:	53                   	push   %ebx
8010659d:	bb 80 00 00 00       	mov    $0x80,%ebx
801065a2:	83 ec 0c             	sub    $0xc,%esp
801065a5:	eb 1b                	jmp    801065c2 <uartputc.part.0+0x32>
801065a7:	89 f6                	mov    %esi,%esi
801065a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
801065b0:	83 ec 0c             	sub    $0xc,%esp
801065b3:	6a 0a                	push   $0xa
801065b5:	e8 36 c5 ff ff       	call   80102af0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801065ba:	83 c4 10             	add    $0x10,%esp
801065bd:	83 eb 01             	sub    $0x1,%ebx
801065c0:	74 07                	je     801065c9 <uartputc.part.0+0x39>
801065c2:	89 f2                	mov    %esi,%edx
801065c4:	ec                   	in     (%dx),%al
801065c5:	a8 20                	test   $0x20,%al
801065c7:	74 e7                	je     801065b0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801065c9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801065ce:	89 f8                	mov    %edi,%eax
801065d0:	ee                   	out    %al,(%dx)
}
801065d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801065d4:	5b                   	pop    %ebx
801065d5:	5e                   	pop    %esi
801065d6:	5f                   	pop    %edi
801065d7:	5d                   	pop    %ebp
801065d8:	c3                   	ret    
801065d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801065e0 <uartinit>:
{
801065e0:	55                   	push   %ebp
801065e1:	31 c9                	xor    %ecx,%ecx
801065e3:	89 c8                	mov    %ecx,%eax
801065e5:	89 e5                	mov    %esp,%ebp
801065e7:	57                   	push   %edi
801065e8:	56                   	push   %esi
801065e9:	53                   	push   %ebx
801065ea:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801065ef:	89 da                	mov    %ebx,%edx
801065f1:	83 ec 0c             	sub    $0xc,%esp
801065f4:	ee                   	out    %al,(%dx)
801065f5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801065fa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801065ff:	89 fa                	mov    %edi,%edx
80106601:	ee                   	out    %al,(%dx)
80106602:	b8 0c 00 00 00       	mov    $0xc,%eax
80106607:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010660c:	ee                   	out    %al,(%dx)
8010660d:	be f9 03 00 00       	mov    $0x3f9,%esi
80106612:	89 c8                	mov    %ecx,%eax
80106614:	89 f2                	mov    %esi,%edx
80106616:	ee                   	out    %al,(%dx)
80106617:	b8 03 00 00 00       	mov    $0x3,%eax
8010661c:	89 fa                	mov    %edi,%edx
8010661e:	ee                   	out    %al,(%dx)
8010661f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106624:	89 c8                	mov    %ecx,%eax
80106626:	ee                   	out    %al,(%dx)
80106627:	b8 01 00 00 00       	mov    $0x1,%eax
8010662c:	89 f2                	mov    %esi,%edx
8010662e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010662f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106634:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106635:	3c ff                	cmp    $0xff,%al
80106637:	74 56                	je     8010668f <uartinit+0xaf>
  uart = 1;
80106639:	c7 05 dc b5 10 80 01 	movl   $0x1,0x8010b5dc
80106640:	00 00 00 
80106643:	89 da                	mov    %ebx,%edx
80106645:	ec                   	in     (%dx),%al
80106646:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010664b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010664c:	83 ec 08             	sub    $0x8,%esp
8010664f:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
80106654:	bb 70 85 10 80       	mov    $0x80108570,%ebx
  ioapicenable(IRQ_COM1, 0);
80106659:	6a 00                	push   $0x0
8010665b:	6a 04                	push   $0x4
8010665d:	e8 4e bd ff ff       	call   801023b0 <ioapicenable>
80106662:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106665:	b8 78 00 00 00       	mov    $0x78,%eax
8010666a:	eb 08                	jmp    80106674 <uartinit+0x94>
8010666c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106670:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
80106674:	8b 15 dc b5 10 80    	mov    0x8010b5dc,%edx
8010667a:	85 d2                	test   %edx,%edx
8010667c:	74 08                	je     80106686 <uartinit+0xa6>
    uartputc(*p);
8010667e:	0f be c0             	movsbl %al,%eax
80106681:	e8 0a ff ff ff       	call   80106590 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
80106686:	89 f0                	mov    %esi,%eax
80106688:	83 c3 01             	add    $0x1,%ebx
8010668b:	84 c0                	test   %al,%al
8010668d:	75 e1                	jne    80106670 <uartinit+0x90>
}
8010668f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106692:	5b                   	pop    %ebx
80106693:	5e                   	pop    %esi
80106694:	5f                   	pop    %edi
80106695:	5d                   	pop    %ebp
80106696:	c3                   	ret    
80106697:	89 f6                	mov    %esi,%esi
80106699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801066a0 <uartputc>:
{
801066a0:	55                   	push   %ebp
  if(!uart)
801066a1:	8b 15 dc b5 10 80    	mov    0x8010b5dc,%edx
{
801066a7:	89 e5                	mov    %esp,%ebp
801066a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801066ac:	85 d2                	test   %edx,%edx
801066ae:	74 10                	je     801066c0 <uartputc+0x20>
}
801066b0:	5d                   	pop    %ebp
801066b1:	e9 da fe ff ff       	jmp    80106590 <uartputc.part.0>
801066b6:	8d 76 00             	lea    0x0(%esi),%esi
801066b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801066c0:	5d                   	pop    %ebp
801066c1:	c3                   	ret    
801066c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801066d0 <uartintr>:

void
uartintr(void)
{
801066d0:	55                   	push   %ebp
801066d1:	89 e5                	mov    %esp,%ebp
801066d3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801066d6:	68 60 65 10 80       	push   $0x80106560
801066db:	e8 80 a1 ff ff       	call   80100860 <consoleintr>
}
801066e0:	83 c4 10             	add    $0x10,%esp
801066e3:	c9                   	leave  
801066e4:	c3                   	ret    

801066e5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801066e5:	6a 00                	push   $0x0
  pushl $0
801066e7:	6a 00                	push   $0x0
  jmp alltraps
801066e9:	e9 fc fa ff ff       	jmp    801061ea <alltraps>

801066ee <vector1>:
.globl vector1
vector1:
  pushl $0
801066ee:	6a 00                	push   $0x0
  pushl $1
801066f0:	6a 01                	push   $0x1
  jmp alltraps
801066f2:	e9 f3 fa ff ff       	jmp    801061ea <alltraps>

801066f7 <vector2>:
.globl vector2
vector2:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $2
801066f9:	6a 02                	push   $0x2
  jmp alltraps
801066fb:	e9 ea fa ff ff       	jmp    801061ea <alltraps>

80106700 <vector3>:
.globl vector3
vector3:
  pushl $0
80106700:	6a 00                	push   $0x0
  pushl $3
80106702:	6a 03                	push   $0x3
  jmp alltraps
80106704:	e9 e1 fa ff ff       	jmp    801061ea <alltraps>

80106709 <vector4>:
.globl vector4
vector4:
  pushl $0
80106709:	6a 00                	push   $0x0
  pushl $4
8010670b:	6a 04                	push   $0x4
  jmp alltraps
8010670d:	e9 d8 fa ff ff       	jmp    801061ea <alltraps>

80106712 <vector5>:
.globl vector5
vector5:
  pushl $0
80106712:	6a 00                	push   $0x0
  pushl $5
80106714:	6a 05                	push   $0x5
  jmp alltraps
80106716:	e9 cf fa ff ff       	jmp    801061ea <alltraps>

8010671b <vector6>:
.globl vector6
vector6:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $6
8010671d:	6a 06                	push   $0x6
  jmp alltraps
8010671f:	e9 c6 fa ff ff       	jmp    801061ea <alltraps>

80106724 <vector7>:
.globl vector7
vector7:
  pushl $0
80106724:	6a 00                	push   $0x0
  pushl $7
80106726:	6a 07                	push   $0x7
  jmp alltraps
80106728:	e9 bd fa ff ff       	jmp    801061ea <alltraps>

8010672d <vector8>:
.globl vector8
vector8:
  pushl $8
8010672d:	6a 08                	push   $0x8
  jmp alltraps
8010672f:	e9 b6 fa ff ff       	jmp    801061ea <alltraps>

80106734 <vector9>:
.globl vector9
vector9:
  pushl $0
80106734:	6a 00                	push   $0x0
  pushl $9
80106736:	6a 09                	push   $0x9
  jmp alltraps
80106738:	e9 ad fa ff ff       	jmp    801061ea <alltraps>

8010673d <vector10>:
.globl vector10
vector10:
  pushl $10
8010673d:	6a 0a                	push   $0xa
  jmp alltraps
8010673f:	e9 a6 fa ff ff       	jmp    801061ea <alltraps>

80106744 <vector11>:
.globl vector11
vector11:
  pushl $11
80106744:	6a 0b                	push   $0xb
  jmp alltraps
80106746:	e9 9f fa ff ff       	jmp    801061ea <alltraps>

8010674b <vector12>:
.globl vector12
vector12:
  pushl $12
8010674b:	6a 0c                	push   $0xc
  jmp alltraps
8010674d:	e9 98 fa ff ff       	jmp    801061ea <alltraps>

80106752 <vector13>:
.globl vector13
vector13:
  pushl $13
80106752:	6a 0d                	push   $0xd
  jmp alltraps
80106754:	e9 91 fa ff ff       	jmp    801061ea <alltraps>

80106759 <vector14>:
.globl vector14
vector14:
  pushl $14
80106759:	6a 0e                	push   $0xe
  jmp alltraps
8010675b:	e9 8a fa ff ff       	jmp    801061ea <alltraps>

80106760 <vector15>:
.globl vector15
vector15:
  pushl $0
80106760:	6a 00                	push   $0x0
  pushl $15
80106762:	6a 0f                	push   $0xf
  jmp alltraps
80106764:	e9 81 fa ff ff       	jmp    801061ea <alltraps>

80106769 <vector16>:
.globl vector16
vector16:
  pushl $0
80106769:	6a 00                	push   $0x0
  pushl $16
8010676b:	6a 10                	push   $0x10
  jmp alltraps
8010676d:	e9 78 fa ff ff       	jmp    801061ea <alltraps>

80106772 <vector17>:
.globl vector17
vector17:
  pushl $17
80106772:	6a 11                	push   $0x11
  jmp alltraps
80106774:	e9 71 fa ff ff       	jmp    801061ea <alltraps>

80106779 <vector18>:
.globl vector18
vector18:
  pushl $0
80106779:	6a 00                	push   $0x0
  pushl $18
8010677b:	6a 12                	push   $0x12
  jmp alltraps
8010677d:	e9 68 fa ff ff       	jmp    801061ea <alltraps>

80106782 <vector19>:
.globl vector19
vector19:
  pushl $0
80106782:	6a 00                	push   $0x0
  pushl $19
80106784:	6a 13                	push   $0x13
  jmp alltraps
80106786:	e9 5f fa ff ff       	jmp    801061ea <alltraps>

8010678b <vector20>:
.globl vector20
vector20:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $20
8010678d:	6a 14                	push   $0x14
  jmp alltraps
8010678f:	e9 56 fa ff ff       	jmp    801061ea <alltraps>

80106794 <vector21>:
.globl vector21
vector21:
  pushl $0
80106794:	6a 00                	push   $0x0
  pushl $21
80106796:	6a 15                	push   $0x15
  jmp alltraps
80106798:	e9 4d fa ff ff       	jmp    801061ea <alltraps>

8010679d <vector22>:
.globl vector22
vector22:
  pushl $0
8010679d:	6a 00                	push   $0x0
  pushl $22
8010679f:	6a 16                	push   $0x16
  jmp alltraps
801067a1:	e9 44 fa ff ff       	jmp    801061ea <alltraps>

801067a6 <vector23>:
.globl vector23
vector23:
  pushl $0
801067a6:	6a 00                	push   $0x0
  pushl $23
801067a8:	6a 17                	push   $0x17
  jmp alltraps
801067aa:	e9 3b fa ff ff       	jmp    801061ea <alltraps>

801067af <vector24>:
.globl vector24
vector24:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $24
801067b1:	6a 18                	push   $0x18
  jmp alltraps
801067b3:	e9 32 fa ff ff       	jmp    801061ea <alltraps>

801067b8 <vector25>:
.globl vector25
vector25:
  pushl $0
801067b8:	6a 00                	push   $0x0
  pushl $25
801067ba:	6a 19                	push   $0x19
  jmp alltraps
801067bc:	e9 29 fa ff ff       	jmp    801061ea <alltraps>

801067c1 <vector26>:
.globl vector26
vector26:
  pushl $0
801067c1:	6a 00                	push   $0x0
  pushl $26
801067c3:	6a 1a                	push   $0x1a
  jmp alltraps
801067c5:	e9 20 fa ff ff       	jmp    801061ea <alltraps>

801067ca <vector27>:
.globl vector27
vector27:
  pushl $0
801067ca:	6a 00                	push   $0x0
  pushl $27
801067cc:	6a 1b                	push   $0x1b
  jmp alltraps
801067ce:	e9 17 fa ff ff       	jmp    801061ea <alltraps>

801067d3 <vector28>:
.globl vector28
vector28:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $28
801067d5:	6a 1c                	push   $0x1c
  jmp alltraps
801067d7:	e9 0e fa ff ff       	jmp    801061ea <alltraps>

801067dc <vector29>:
.globl vector29
vector29:
  pushl $0
801067dc:	6a 00                	push   $0x0
  pushl $29
801067de:	6a 1d                	push   $0x1d
  jmp alltraps
801067e0:	e9 05 fa ff ff       	jmp    801061ea <alltraps>

801067e5 <vector30>:
.globl vector30
vector30:
  pushl $0
801067e5:	6a 00                	push   $0x0
  pushl $30
801067e7:	6a 1e                	push   $0x1e
  jmp alltraps
801067e9:	e9 fc f9 ff ff       	jmp    801061ea <alltraps>

801067ee <vector31>:
.globl vector31
vector31:
  pushl $0
801067ee:	6a 00                	push   $0x0
  pushl $31
801067f0:	6a 1f                	push   $0x1f
  jmp alltraps
801067f2:	e9 f3 f9 ff ff       	jmp    801061ea <alltraps>

801067f7 <vector32>:
.globl vector32
vector32:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $32
801067f9:	6a 20                	push   $0x20
  jmp alltraps
801067fb:	e9 ea f9 ff ff       	jmp    801061ea <alltraps>

80106800 <vector33>:
.globl vector33
vector33:
  pushl $0
80106800:	6a 00                	push   $0x0
  pushl $33
80106802:	6a 21                	push   $0x21
  jmp alltraps
80106804:	e9 e1 f9 ff ff       	jmp    801061ea <alltraps>

80106809 <vector34>:
.globl vector34
vector34:
  pushl $0
80106809:	6a 00                	push   $0x0
  pushl $34
8010680b:	6a 22                	push   $0x22
  jmp alltraps
8010680d:	e9 d8 f9 ff ff       	jmp    801061ea <alltraps>

80106812 <vector35>:
.globl vector35
vector35:
  pushl $0
80106812:	6a 00                	push   $0x0
  pushl $35
80106814:	6a 23                	push   $0x23
  jmp alltraps
80106816:	e9 cf f9 ff ff       	jmp    801061ea <alltraps>

8010681b <vector36>:
.globl vector36
vector36:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $36
8010681d:	6a 24                	push   $0x24
  jmp alltraps
8010681f:	e9 c6 f9 ff ff       	jmp    801061ea <alltraps>

80106824 <vector37>:
.globl vector37
vector37:
  pushl $0
80106824:	6a 00                	push   $0x0
  pushl $37
80106826:	6a 25                	push   $0x25
  jmp alltraps
80106828:	e9 bd f9 ff ff       	jmp    801061ea <alltraps>

8010682d <vector38>:
.globl vector38
vector38:
  pushl $0
8010682d:	6a 00                	push   $0x0
  pushl $38
8010682f:	6a 26                	push   $0x26
  jmp alltraps
80106831:	e9 b4 f9 ff ff       	jmp    801061ea <alltraps>

80106836 <vector39>:
.globl vector39
vector39:
  pushl $0
80106836:	6a 00                	push   $0x0
  pushl $39
80106838:	6a 27                	push   $0x27
  jmp alltraps
8010683a:	e9 ab f9 ff ff       	jmp    801061ea <alltraps>

8010683f <vector40>:
.globl vector40
vector40:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $40
80106841:	6a 28                	push   $0x28
  jmp alltraps
80106843:	e9 a2 f9 ff ff       	jmp    801061ea <alltraps>

80106848 <vector41>:
.globl vector41
vector41:
  pushl $0
80106848:	6a 00                	push   $0x0
  pushl $41
8010684a:	6a 29                	push   $0x29
  jmp alltraps
8010684c:	e9 99 f9 ff ff       	jmp    801061ea <alltraps>

80106851 <vector42>:
.globl vector42
vector42:
  pushl $0
80106851:	6a 00                	push   $0x0
  pushl $42
80106853:	6a 2a                	push   $0x2a
  jmp alltraps
80106855:	e9 90 f9 ff ff       	jmp    801061ea <alltraps>

8010685a <vector43>:
.globl vector43
vector43:
  pushl $0
8010685a:	6a 00                	push   $0x0
  pushl $43
8010685c:	6a 2b                	push   $0x2b
  jmp alltraps
8010685e:	e9 87 f9 ff ff       	jmp    801061ea <alltraps>

80106863 <vector44>:
.globl vector44
vector44:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $44
80106865:	6a 2c                	push   $0x2c
  jmp alltraps
80106867:	e9 7e f9 ff ff       	jmp    801061ea <alltraps>

8010686c <vector45>:
.globl vector45
vector45:
  pushl $0
8010686c:	6a 00                	push   $0x0
  pushl $45
8010686e:	6a 2d                	push   $0x2d
  jmp alltraps
80106870:	e9 75 f9 ff ff       	jmp    801061ea <alltraps>

80106875 <vector46>:
.globl vector46
vector46:
  pushl $0
80106875:	6a 00                	push   $0x0
  pushl $46
80106877:	6a 2e                	push   $0x2e
  jmp alltraps
80106879:	e9 6c f9 ff ff       	jmp    801061ea <alltraps>

8010687e <vector47>:
.globl vector47
vector47:
  pushl $0
8010687e:	6a 00                	push   $0x0
  pushl $47
80106880:	6a 2f                	push   $0x2f
  jmp alltraps
80106882:	e9 63 f9 ff ff       	jmp    801061ea <alltraps>

80106887 <vector48>:
.globl vector48
vector48:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $48
80106889:	6a 30                	push   $0x30
  jmp alltraps
8010688b:	e9 5a f9 ff ff       	jmp    801061ea <alltraps>

80106890 <vector49>:
.globl vector49
vector49:
  pushl $0
80106890:	6a 00                	push   $0x0
  pushl $49
80106892:	6a 31                	push   $0x31
  jmp alltraps
80106894:	e9 51 f9 ff ff       	jmp    801061ea <alltraps>

80106899 <vector50>:
.globl vector50
vector50:
  pushl $0
80106899:	6a 00                	push   $0x0
  pushl $50
8010689b:	6a 32                	push   $0x32
  jmp alltraps
8010689d:	e9 48 f9 ff ff       	jmp    801061ea <alltraps>

801068a2 <vector51>:
.globl vector51
vector51:
  pushl $0
801068a2:	6a 00                	push   $0x0
  pushl $51
801068a4:	6a 33                	push   $0x33
  jmp alltraps
801068a6:	e9 3f f9 ff ff       	jmp    801061ea <alltraps>

801068ab <vector52>:
.globl vector52
vector52:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $52
801068ad:	6a 34                	push   $0x34
  jmp alltraps
801068af:	e9 36 f9 ff ff       	jmp    801061ea <alltraps>

801068b4 <vector53>:
.globl vector53
vector53:
  pushl $0
801068b4:	6a 00                	push   $0x0
  pushl $53
801068b6:	6a 35                	push   $0x35
  jmp alltraps
801068b8:	e9 2d f9 ff ff       	jmp    801061ea <alltraps>

801068bd <vector54>:
.globl vector54
vector54:
  pushl $0
801068bd:	6a 00                	push   $0x0
  pushl $54
801068bf:	6a 36                	push   $0x36
  jmp alltraps
801068c1:	e9 24 f9 ff ff       	jmp    801061ea <alltraps>

801068c6 <vector55>:
.globl vector55
vector55:
  pushl $0
801068c6:	6a 00                	push   $0x0
  pushl $55
801068c8:	6a 37                	push   $0x37
  jmp alltraps
801068ca:	e9 1b f9 ff ff       	jmp    801061ea <alltraps>

801068cf <vector56>:
.globl vector56
vector56:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $56
801068d1:	6a 38                	push   $0x38
  jmp alltraps
801068d3:	e9 12 f9 ff ff       	jmp    801061ea <alltraps>

801068d8 <vector57>:
.globl vector57
vector57:
  pushl $0
801068d8:	6a 00                	push   $0x0
  pushl $57
801068da:	6a 39                	push   $0x39
  jmp alltraps
801068dc:	e9 09 f9 ff ff       	jmp    801061ea <alltraps>

801068e1 <vector58>:
.globl vector58
vector58:
  pushl $0
801068e1:	6a 00                	push   $0x0
  pushl $58
801068e3:	6a 3a                	push   $0x3a
  jmp alltraps
801068e5:	e9 00 f9 ff ff       	jmp    801061ea <alltraps>

801068ea <vector59>:
.globl vector59
vector59:
  pushl $0
801068ea:	6a 00                	push   $0x0
  pushl $59
801068ec:	6a 3b                	push   $0x3b
  jmp alltraps
801068ee:	e9 f7 f8 ff ff       	jmp    801061ea <alltraps>

801068f3 <vector60>:
.globl vector60
vector60:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $60
801068f5:	6a 3c                	push   $0x3c
  jmp alltraps
801068f7:	e9 ee f8 ff ff       	jmp    801061ea <alltraps>

801068fc <vector61>:
.globl vector61
vector61:
  pushl $0
801068fc:	6a 00                	push   $0x0
  pushl $61
801068fe:	6a 3d                	push   $0x3d
  jmp alltraps
80106900:	e9 e5 f8 ff ff       	jmp    801061ea <alltraps>

80106905 <vector62>:
.globl vector62
vector62:
  pushl $0
80106905:	6a 00                	push   $0x0
  pushl $62
80106907:	6a 3e                	push   $0x3e
  jmp alltraps
80106909:	e9 dc f8 ff ff       	jmp    801061ea <alltraps>

8010690e <vector63>:
.globl vector63
vector63:
  pushl $0
8010690e:	6a 00                	push   $0x0
  pushl $63
80106910:	6a 3f                	push   $0x3f
  jmp alltraps
80106912:	e9 d3 f8 ff ff       	jmp    801061ea <alltraps>

80106917 <vector64>:
.globl vector64
vector64:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $64
80106919:	6a 40                	push   $0x40
  jmp alltraps
8010691b:	e9 ca f8 ff ff       	jmp    801061ea <alltraps>

80106920 <vector65>:
.globl vector65
vector65:
  pushl $0
80106920:	6a 00                	push   $0x0
  pushl $65
80106922:	6a 41                	push   $0x41
  jmp alltraps
80106924:	e9 c1 f8 ff ff       	jmp    801061ea <alltraps>

80106929 <vector66>:
.globl vector66
vector66:
  pushl $0
80106929:	6a 00                	push   $0x0
  pushl $66
8010692b:	6a 42                	push   $0x42
  jmp alltraps
8010692d:	e9 b8 f8 ff ff       	jmp    801061ea <alltraps>

80106932 <vector67>:
.globl vector67
vector67:
  pushl $0
80106932:	6a 00                	push   $0x0
  pushl $67
80106934:	6a 43                	push   $0x43
  jmp alltraps
80106936:	e9 af f8 ff ff       	jmp    801061ea <alltraps>

8010693b <vector68>:
.globl vector68
vector68:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $68
8010693d:	6a 44                	push   $0x44
  jmp alltraps
8010693f:	e9 a6 f8 ff ff       	jmp    801061ea <alltraps>

80106944 <vector69>:
.globl vector69
vector69:
  pushl $0
80106944:	6a 00                	push   $0x0
  pushl $69
80106946:	6a 45                	push   $0x45
  jmp alltraps
80106948:	e9 9d f8 ff ff       	jmp    801061ea <alltraps>

8010694d <vector70>:
.globl vector70
vector70:
  pushl $0
8010694d:	6a 00                	push   $0x0
  pushl $70
8010694f:	6a 46                	push   $0x46
  jmp alltraps
80106951:	e9 94 f8 ff ff       	jmp    801061ea <alltraps>

80106956 <vector71>:
.globl vector71
vector71:
  pushl $0
80106956:	6a 00                	push   $0x0
  pushl $71
80106958:	6a 47                	push   $0x47
  jmp alltraps
8010695a:	e9 8b f8 ff ff       	jmp    801061ea <alltraps>

8010695f <vector72>:
.globl vector72
vector72:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $72
80106961:	6a 48                	push   $0x48
  jmp alltraps
80106963:	e9 82 f8 ff ff       	jmp    801061ea <alltraps>

80106968 <vector73>:
.globl vector73
vector73:
  pushl $0
80106968:	6a 00                	push   $0x0
  pushl $73
8010696a:	6a 49                	push   $0x49
  jmp alltraps
8010696c:	e9 79 f8 ff ff       	jmp    801061ea <alltraps>

80106971 <vector74>:
.globl vector74
vector74:
  pushl $0
80106971:	6a 00                	push   $0x0
  pushl $74
80106973:	6a 4a                	push   $0x4a
  jmp alltraps
80106975:	e9 70 f8 ff ff       	jmp    801061ea <alltraps>

8010697a <vector75>:
.globl vector75
vector75:
  pushl $0
8010697a:	6a 00                	push   $0x0
  pushl $75
8010697c:	6a 4b                	push   $0x4b
  jmp alltraps
8010697e:	e9 67 f8 ff ff       	jmp    801061ea <alltraps>

80106983 <vector76>:
.globl vector76
vector76:
  pushl $0
80106983:	6a 00                	push   $0x0
  pushl $76
80106985:	6a 4c                	push   $0x4c
  jmp alltraps
80106987:	e9 5e f8 ff ff       	jmp    801061ea <alltraps>

8010698c <vector77>:
.globl vector77
vector77:
  pushl $0
8010698c:	6a 00                	push   $0x0
  pushl $77
8010698e:	6a 4d                	push   $0x4d
  jmp alltraps
80106990:	e9 55 f8 ff ff       	jmp    801061ea <alltraps>

80106995 <vector78>:
.globl vector78
vector78:
  pushl $0
80106995:	6a 00                	push   $0x0
  pushl $78
80106997:	6a 4e                	push   $0x4e
  jmp alltraps
80106999:	e9 4c f8 ff ff       	jmp    801061ea <alltraps>

8010699e <vector79>:
.globl vector79
vector79:
  pushl $0
8010699e:	6a 00                	push   $0x0
  pushl $79
801069a0:	6a 4f                	push   $0x4f
  jmp alltraps
801069a2:	e9 43 f8 ff ff       	jmp    801061ea <alltraps>

801069a7 <vector80>:
.globl vector80
vector80:
  pushl $0
801069a7:	6a 00                	push   $0x0
  pushl $80
801069a9:	6a 50                	push   $0x50
  jmp alltraps
801069ab:	e9 3a f8 ff ff       	jmp    801061ea <alltraps>

801069b0 <vector81>:
.globl vector81
vector81:
  pushl $0
801069b0:	6a 00                	push   $0x0
  pushl $81
801069b2:	6a 51                	push   $0x51
  jmp alltraps
801069b4:	e9 31 f8 ff ff       	jmp    801061ea <alltraps>

801069b9 <vector82>:
.globl vector82
vector82:
  pushl $0
801069b9:	6a 00                	push   $0x0
  pushl $82
801069bb:	6a 52                	push   $0x52
  jmp alltraps
801069bd:	e9 28 f8 ff ff       	jmp    801061ea <alltraps>

801069c2 <vector83>:
.globl vector83
vector83:
  pushl $0
801069c2:	6a 00                	push   $0x0
  pushl $83
801069c4:	6a 53                	push   $0x53
  jmp alltraps
801069c6:	e9 1f f8 ff ff       	jmp    801061ea <alltraps>

801069cb <vector84>:
.globl vector84
vector84:
  pushl $0
801069cb:	6a 00                	push   $0x0
  pushl $84
801069cd:	6a 54                	push   $0x54
  jmp alltraps
801069cf:	e9 16 f8 ff ff       	jmp    801061ea <alltraps>

801069d4 <vector85>:
.globl vector85
vector85:
  pushl $0
801069d4:	6a 00                	push   $0x0
  pushl $85
801069d6:	6a 55                	push   $0x55
  jmp alltraps
801069d8:	e9 0d f8 ff ff       	jmp    801061ea <alltraps>

801069dd <vector86>:
.globl vector86
vector86:
  pushl $0
801069dd:	6a 00                	push   $0x0
  pushl $86
801069df:	6a 56                	push   $0x56
  jmp alltraps
801069e1:	e9 04 f8 ff ff       	jmp    801061ea <alltraps>

801069e6 <vector87>:
.globl vector87
vector87:
  pushl $0
801069e6:	6a 00                	push   $0x0
  pushl $87
801069e8:	6a 57                	push   $0x57
  jmp alltraps
801069ea:	e9 fb f7 ff ff       	jmp    801061ea <alltraps>

801069ef <vector88>:
.globl vector88
vector88:
  pushl $0
801069ef:	6a 00                	push   $0x0
  pushl $88
801069f1:	6a 58                	push   $0x58
  jmp alltraps
801069f3:	e9 f2 f7 ff ff       	jmp    801061ea <alltraps>

801069f8 <vector89>:
.globl vector89
vector89:
  pushl $0
801069f8:	6a 00                	push   $0x0
  pushl $89
801069fa:	6a 59                	push   $0x59
  jmp alltraps
801069fc:	e9 e9 f7 ff ff       	jmp    801061ea <alltraps>

80106a01 <vector90>:
.globl vector90
vector90:
  pushl $0
80106a01:	6a 00                	push   $0x0
  pushl $90
80106a03:	6a 5a                	push   $0x5a
  jmp alltraps
80106a05:	e9 e0 f7 ff ff       	jmp    801061ea <alltraps>

80106a0a <vector91>:
.globl vector91
vector91:
  pushl $0
80106a0a:	6a 00                	push   $0x0
  pushl $91
80106a0c:	6a 5b                	push   $0x5b
  jmp alltraps
80106a0e:	e9 d7 f7 ff ff       	jmp    801061ea <alltraps>

80106a13 <vector92>:
.globl vector92
vector92:
  pushl $0
80106a13:	6a 00                	push   $0x0
  pushl $92
80106a15:	6a 5c                	push   $0x5c
  jmp alltraps
80106a17:	e9 ce f7 ff ff       	jmp    801061ea <alltraps>

80106a1c <vector93>:
.globl vector93
vector93:
  pushl $0
80106a1c:	6a 00                	push   $0x0
  pushl $93
80106a1e:	6a 5d                	push   $0x5d
  jmp alltraps
80106a20:	e9 c5 f7 ff ff       	jmp    801061ea <alltraps>

80106a25 <vector94>:
.globl vector94
vector94:
  pushl $0
80106a25:	6a 00                	push   $0x0
  pushl $94
80106a27:	6a 5e                	push   $0x5e
  jmp alltraps
80106a29:	e9 bc f7 ff ff       	jmp    801061ea <alltraps>

80106a2e <vector95>:
.globl vector95
vector95:
  pushl $0
80106a2e:	6a 00                	push   $0x0
  pushl $95
80106a30:	6a 5f                	push   $0x5f
  jmp alltraps
80106a32:	e9 b3 f7 ff ff       	jmp    801061ea <alltraps>

80106a37 <vector96>:
.globl vector96
vector96:
  pushl $0
80106a37:	6a 00                	push   $0x0
  pushl $96
80106a39:	6a 60                	push   $0x60
  jmp alltraps
80106a3b:	e9 aa f7 ff ff       	jmp    801061ea <alltraps>

80106a40 <vector97>:
.globl vector97
vector97:
  pushl $0
80106a40:	6a 00                	push   $0x0
  pushl $97
80106a42:	6a 61                	push   $0x61
  jmp alltraps
80106a44:	e9 a1 f7 ff ff       	jmp    801061ea <alltraps>

80106a49 <vector98>:
.globl vector98
vector98:
  pushl $0
80106a49:	6a 00                	push   $0x0
  pushl $98
80106a4b:	6a 62                	push   $0x62
  jmp alltraps
80106a4d:	e9 98 f7 ff ff       	jmp    801061ea <alltraps>

80106a52 <vector99>:
.globl vector99
vector99:
  pushl $0
80106a52:	6a 00                	push   $0x0
  pushl $99
80106a54:	6a 63                	push   $0x63
  jmp alltraps
80106a56:	e9 8f f7 ff ff       	jmp    801061ea <alltraps>

80106a5b <vector100>:
.globl vector100
vector100:
  pushl $0
80106a5b:	6a 00                	push   $0x0
  pushl $100
80106a5d:	6a 64                	push   $0x64
  jmp alltraps
80106a5f:	e9 86 f7 ff ff       	jmp    801061ea <alltraps>

80106a64 <vector101>:
.globl vector101
vector101:
  pushl $0
80106a64:	6a 00                	push   $0x0
  pushl $101
80106a66:	6a 65                	push   $0x65
  jmp alltraps
80106a68:	e9 7d f7 ff ff       	jmp    801061ea <alltraps>

80106a6d <vector102>:
.globl vector102
vector102:
  pushl $0
80106a6d:	6a 00                	push   $0x0
  pushl $102
80106a6f:	6a 66                	push   $0x66
  jmp alltraps
80106a71:	e9 74 f7 ff ff       	jmp    801061ea <alltraps>

80106a76 <vector103>:
.globl vector103
vector103:
  pushl $0
80106a76:	6a 00                	push   $0x0
  pushl $103
80106a78:	6a 67                	push   $0x67
  jmp alltraps
80106a7a:	e9 6b f7 ff ff       	jmp    801061ea <alltraps>

80106a7f <vector104>:
.globl vector104
vector104:
  pushl $0
80106a7f:	6a 00                	push   $0x0
  pushl $104
80106a81:	6a 68                	push   $0x68
  jmp alltraps
80106a83:	e9 62 f7 ff ff       	jmp    801061ea <alltraps>

80106a88 <vector105>:
.globl vector105
vector105:
  pushl $0
80106a88:	6a 00                	push   $0x0
  pushl $105
80106a8a:	6a 69                	push   $0x69
  jmp alltraps
80106a8c:	e9 59 f7 ff ff       	jmp    801061ea <alltraps>

80106a91 <vector106>:
.globl vector106
vector106:
  pushl $0
80106a91:	6a 00                	push   $0x0
  pushl $106
80106a93:	6a 6a                	push   $0x6a
  jmp alltraps
80106a95:	e9 50 f7 ff ff       	jmp    801061ea <alltraps>

80106a9a <vector107>:
.globl vector107
vector107:
  pushl $0
80106a9a:	6a 00                	push   $0x0
  pushl $107
80106a9c:	6a 6b                	push   $0x6b
  jmp alltraps
80106a9e:	e9 47 f7 ff ff       	jmp    801061ea <alltraps>

80106aa3 <vector108>:
.globl vector108
vector108:
  pushl $0
80106aa3:	6a 00                	push   $0x0
  pushl $108
80106aa5:	6a 6c                	push   $0x6c
  jmp alltraps
80106aa7:	e9 3e f7 ff ff       	jmp    801061ea <alltraps>

80106aac <vector109>:
.globl vector109
vector109:
  pushl $0
80106aac:	6a 00                	push   $0x0
  pushl $109
80106aae:	6a 6d                	push   $0x6d
  jmp alltraps
80106ab0:	e9 35 f7 ff ff       	jmp    801061ea <alltraps>

80106ab5 <vector110>:
.globl vector110
vector110:
  pushl $0
80106ab5:	6a 00                	push   $0x0
  pushl $110
80106ab7:	6a 6e                	push   $0x6e
  jmp alltraps
80106ab9:	e9 2c f7 ff ff       	jmp    801061ea <alltraps>

80106abe <vector111>:
.globl vector111
vector111:
  pushl $0
80106abe:	6a 00                	push   $0x0
  pushl $111
80106ac0:	6a 6f                	push   $0x6f
  jmp alltraps
80106ac2:	e9 23 f7 ff ff       	jmp    801061ea <alltraps>

80106ac7 <vector112>:
.globl vector112
vector112:
  pushl $0
80106ac7:	6a 00                	push   $0x0
  pushl $112
80106ac9:	6a 70                	push   $0x70
  jmp alltraps
80106acb:	e9 1a f7 ff ff       	jmp    801061ea <alltraps>

80106ad0 <vector113>:
.globl vector113
vector113:
  pushl $0
80106ad0:	6a 00                	push   $0x0
  pushl $113
80106ad2:	6a 71                	push   $0x71
  jmp alltraps
80106ad4:	e9 11 f7 ff ff       	jmp    801061ea <alltraps>

80106ad9 <vector114>:
.globl vector114
vector114:
  pushl $0
80106ad9:	6a 00                	push   $0x0
  pushl $114
80106adb:	6a 72                	push   $0x72
  jmp alltraps
80106add:	e9 08 f7 ff ff       	jmp    801061ea <alltraps>

80106ae2 <vector115>:
.globl vector115
vector115:
  pushl $0
80106ae2:	6a 00                	push   $0x0
  pushl $115
80106ae4:	6a 73                	push   $0x73
  jmp alltraps
80106ae6:	e9 ff f6 ff ff       	jmp    801061ea <alltraps>

80106aeb <vector116>:
.globl vector116
vector116:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $116
80106aed:	6a 74                	push   $0x74
  jmp alltraps
80106aef:	e9 f6 f6 ff ff       	jmp    801061ea <alltraps>

80106af4 <vector117>:
.globl vector117
vector117:
  pushl $0
80106af4:	6a 00                	push   $0x0
  pushl $117
80106af6:	6a 75                	push   $0x75
  jmp alltraps
80106af8:	e9 ed f6 ff ff       	jmp    801061ea <alltraps>

80106afd <vector118>:
.globl vector118
vector118:
  pushl $0
80106afd:	6a 00                	push   $0x0
  pushl $118
80106aff:	6a 76                	push   $0x76
  jmp alltraps
80106b01:	e9 e4 f6 ff ff       	jmp    801061ea <alltraps>

80106b06 <vector119>:
.globl vector119
vector119:
  pushl $0
80106b06:	6a 00                	push   $0x0
  pushl $119
80106b08:	6a 77                	push   $0x77
  jmp alltraps
80106b0a:	e9 db f6 ff ff       	jmp    801061ea <alltraps>

80106b0f <vector120>:
.globl vector120
vector120:
  pushl $0
80106b0f:	6a 00                	push   $0x0
  pushl $120
80106b11:	6a 78                	push   $0x78
  jmp alltraps
80106b13:	e9 d2 f6 ff ff       	jmp    801061ea <alltraps>

80106b18 <vector121>:
.globl vector121
vector121:
  pushl $0
80106b18:	6a 00                	push   $0x0
  pushl $121
80106b1a:	6a 79                	push   $0x79
  jmp alltraps
80106b1c:	e9 c9 f6 ff ff       	jmp    801061ea <alltraps>

80106b21 <vector122>:
.globl vector122
vector122:
  pushl $0
80106b21:	6a 00                	push   $0x0
  pushl $122
80106b23:	6a 7a                	push   $0x7a
  jmp alltraps
80106b25:	e9 c0 f6 ff ff       	jmp    801061ea <alltraps>

80106b2a <vector123>:
.globl vector123
vector123:
  pushl $0
80106b2a:	6a 00                	push   $0x0
  pushl $123
80106b2c:	6a 7b                	push   $0x7b
  jmp alltraps
80106b2e:	e9 b7 f6 ff ff       	jmp    801061ea <alltraps>

80106b33 <vector124>:
.globl vector124
vector124:
  pushl $0
80106b33:	6a 00                	push   $0x0
  pushl $124
80106b35:	6a 7c                	push   $0x7c
  jmp alltraps
80106b37:	e9 ae f6 ff ff       	jmp    801061ea <alltraps>

80106b3c <vector125>:
.globl vector125
vector125:
  pushl $0
80106b3c:	6a 00                	push   $0x0
  pushl $125
80106b3e:	6a 7d                	push   $0x7d
  jmp alltraps
80106b40:	e9 a5 f6 ff ff       	jmp    801061ea <alltraps>

80106b45 <vector126>:
.globl vector126
vector126:
  pushl $0
80106b45:	6a 00                	push   $0x0
  pushl $126
80106b47:	6a 7e                	push   $0x7e
  jmp alltraps
80106b49:	e9 9c f6 ff ff       	jmp    801061ea <alltraps>

80106b4e <vector127>:
.globl vector127
vector127:
  pushl $0
80106b4e:	6a 00                	push   $0x0
  pushl $127
80106b50:	6a 7f                	push   $0x7f
  jmp alltraps
80106b52:	e9 93 f6 ff ff       	jmp    801061ea <alltraps>

80106b57 <vector128>:
.globl vector128
vector128:
  pushl $0
80106b57:	6a 00                	push   $0x0
  pushl $128
80106b59:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106b5e:	e9 87 f6 ff ff       	jmp    801061ea <alltraps>

80106b63 <vector129>:
.globl vector129
vector129:
  pushl $0
80106b63:	6a 00                	push   $0x0
  pushl $129
80106b65:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106b6a:	e9 7b f6 ff ff       	jmp    801061ea <alltraps>

80106b6f <vector130>:
.globl vector130
vector130:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $130
80106b71:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106b76:	e9 6f f6 ff ff       	jmp    801061ea <alltraps>

80106b7b <vector131>:
.globl vector131
vector131:
  pushl $0
80106b7b:	6a 00                	push   $0x0
  pushl $131
80106b7d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106b82:	e9 63 f6 ff ff       	jmp    801061ea <alltraps>

80106b87 <vector132>:
.globl vector132
vector132:
  pushl $0
80106b87:	6a 00                	push   $0x0
  pushl $132
80106b89:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106b8e:	e9 57 f6 ff ff       	jmp    801061ea <alltraps>

80106b93 <vector133>:
.globl vector133
vector133:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $133
80106b95:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106b9a:	e9 4b f6 ff ff       	jmp    801061ea <alltraps>

80106b9f <vector134>:
.globl vector134
vector134:
  pushl $0
80106b9f:	6a 00                	push   $0x0
  pushl $134
80106ba1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106ba6:	e9 3f f6 ff ff       	jmp    801061ea <alltraps>

80106bab <vector135>:
.globl vector135
vector135:
  pushl $0
80106bab:	6a 00                	push   $0x0
  pushl $135
80106bad:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106bb2:	e9 33 f6 ff ff       	jmp    801061ea <alltraps>

80106bb7 <vector136>:
.globl vector136
vector136:
  pushl $0
80106bb7:	6a 00                	push   $0x0
  pushl $136
80106bb9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106bbe:	e9 27 f6 ff ff       	jmp    801061ea <alltraps>

80106bc3 <vector137>:
.globl vector137
vector137:
  pushl $0
80106bc3:	6a 00                	push   $0x0
  pushl $137
80106bc5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106bca:	e9 1b f6 ff ff       	jmp    801061ea <alltraps>

80106bcf <vector138>:
.globl vector138
vector138:
  pushl $0
80106bcf:	6a 00                	push   $0x0
  pushl $138
80106bd1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106bd6:	e9 0f f6 ff ff       	jmp    801061ea <alltraps>

80106bdb <vector139>:
.globl vector139
vector139:
  pushl $0
80106bdb:	6a 00                	push   $0x0
  pushl $139
80106bdd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106be2:	e9 03 f6 ff ff       	jmp    801061ea <alltraps>

80106be7 <vector140>:
.globl vector140
vector140:
  pushl $0
80106be7:	6a 00                	push   $0x0
  pushl $140
80106be9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106bee:	e9 f7 f5 ff ff       	jmp    801061ea <alltraps>

80106bf3 <vector141>:
.globl vector141
vector141:
  pushl $0
80106bf3:	6a 00                	push   $0x0
  pushl $141
80106bf5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106bfa:	e9 eb f5 ff ff       	jmp    801061ea <alltraps>

80106bff <vector142>:
.globl vector142
vector142:
  pushl $0
80106bff:	6a 00                	push   $0x0
  pushl $142
80106c01:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106c06:	e9 df f5 ff ff       	jmp    801061ea <alltraps>

80106c0b <vector143>:
.globl vector143
vector143:
  pushl $0
80106c0b:	6a 00                	push   $0x0
  pushl $143
80106c0d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106c12:	e9 d3 f5 ff ff       	jmp    801061ea <alltraps>

80106c17 <vector144>:
.globl vector144
vector144:
  pushl $0
80106c17:	6a 00                	push   $0x0
  pushl $144
80106c19:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106c1e:	e9 c7 f5 ff ff       	jmp    801061ea <alltraps>

80106c23 <vector145>:
.globl vector145
vector145:
  pushl $0
80106c23:	6a 00                	push   $0x0
  pushl $145
80106c25:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106c2a:	e9 bb f5 ff ff       	jmp    801061ea <alltraps>

80106c2f <vector146>:
.globl vector146
vector146:
  pushl $0
80106c2f:	6a 00                	push   $0x0
  pushl $146
80106c31:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106c36:	e9 af f5 ff ff       	jmp    801061ea <alltraps>

80106c3b <vector147>:
.globl vector147
vector147:
  pushl $0
80106c3b:	6a 00                	push   $0x0
  pushl $147
80106c3d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106c42:	e9 a3 f5 ff ff       	jmp    801061ea <alltraps>

80106c47 <vector148>:
.globl vector148
vector148:
  pushl $0
80106c47:	6a 00                	push   $0x0
  pushl $148
80106c49:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106c4e:	e9 97 f5 ff ff       	jmp    801061ea <alltraps>

80106c53 <vector149>:
.globl vector149
vector149:
  pushl $0
80106c53:	6a 00                	push   $0x0
  pushl $149
80106c55:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106c5a:	e9 8b f5 ff ff       	jmp    801061ea <alltraps>

80106c5f <vector150>:
.globl vector150
vector150:
  pushl $0
80106c5f:	6a 00                	push   $0x0
  pushl $150
80106c61:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106c66:	e9 7f f5 ff ff       	jmp    801061ea <alltraps>

80106c6b <vector151>:
.globl vector151
vector151:
  pushl $0
80106c6b:	6a 00                	push   $0x0
  pushl $151
80106c6d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106c72:	e9 73 f5 ff ff       	jmp    801061ea <alltraps>

80106c77 <vector152>:
.globl vector152
vector152:
  pushl $0
80106c77:	6a 00                	push   $0x0
  pushl $152
80106c79:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106c7e:	e9 67 f5 ff ff       	jmp    801061ea <alltraps>

80106c83 <vector153>:
.globl vector153
vector153:
  pushl $0
80106c83:	6a 00                	push   $0x0
  pushl $153
80106c85:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106c8a:	e9 5b f5 ff ff       	jmp    801061ea <alltraps>

80106c8f <vector154>:
.globl vector154
vector154:
  pushl $0
80106c8f:	6a 00                	push   $0x0
  pushl $154
80106c91:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106c96:	e9 4f f5 ff ff       	jmp    801061ea <alltraps>

80106c9b <vector155>:
.globl vector155
vector155:
  pushl $0
80106c9b:	6a 00                	push   $0x0
  pushl $155
80106c9d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106ca2:	e9 43 f5 ff ff       	jmp    801061ea <alltraps>

80106ca7 <vector156>:
.globl vector156
vector156:
  pushl $0
80106ca7:	6a 00                	push   $0x0
  pushl $156
80106ca9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106cae:	e9 37 f5 ff ff       	jmp    801061ea <alltraps>

80106cb3 <vector157>:
.globl vector157
vector157:
  pushl $0
80106cb3:	6a 00                	push   $0x0
  pushl $157
80106cb5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106cba:	e9 2b f5 ff ff       	jmp    801061ea <alltraps>

80106cbf <vector158>:
.globl vector158
vector158:
  pushl $0
80106cbf:	6a 00                	push   $0x0
  pushl $158
80106cc1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106cc6:	e9 1f f5 ff ff       	jmp    801061ea <alltraps>

80106ccb <vector159>:
.globl vector159
vector159:
  pushl $0
80106ccb:	6a 00                	push   $0x0
  pushl $159
80106ccd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106cd2:	e9 13 f5 ff ff       	jmp    801061ea <alltraps>

80106cd7 <vector160>:
.globl vector160
vector160:
  pushl $0
80106cd7:	6a 00                	push   $0x0
  pushl $160
80106cd9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106cde:	e9 07 f5 ff ff       	jmp    801061ea <alltraps>

80106ce3 <vector161>:
.globl vector161
vector161:
  pushl $0
80106ce3:	6a 00                	push   $0x0
  pushl $161
80106ce5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106cea:	e9 fb f4 ff ff       	jmp    801061ea <alltraps>

80106cef <vector162>:
.globl vector162
vector162:
  pushl $0
80106cef:	6a 00                	push   $0x0
  pushl $162
80106cf1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106cf6:	e9 ef f4 ff ff       	jmp    801061ea <alltraps>

80106cfb <vector163>:
.globl vector163
vector163:
  pushl $0
80106cfb:	6a 00                	push   $0x0
  pushl $163
80106cfd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106d02:	e9 e3 f4 ff ff       	jmp    801061ea <alltraps>

80106d07 <vector164>:
.globl vector164
vector164:
  pushl $0
80106d07:	6a 00                	push   $0x0
  pushl $164
80106d09:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106d0e:	e9 d7 f4 ff ff       	jmp    801061ea <alltraps>

80106d13 <vector165>:
.globl vector165
vector165:
  pushl $0
80106d13:	6a 00                	push   $0x0
  pushl $165
80106d15:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106d1a:	e9 cb f4 ff ff       	jmp    801061ea <alltraps>

80106d1f <vector166>:
.globl vector166
vector166:
  pushl $0
80106d1f:	6a 00                	push   $0x0
  pushl $166
80106d21:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106d26:	e9 bf f4 ff ff       	jmp    801061ea <alltraps>

80106d2b <vector167>:
.globl vector167
vector167:
  pushl $0
80106d2b:	6a 00                	push   $0x0
  pushl $167
80106d2d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106d32:	e9 b3 f4 ff ff       	jmp    801061ea <alltraps>

80106d37 <vector168>:
.globl vector168
vector168:
  pushl $0
80106d37:	6a 00                	push   $0x0
  pushl $168
80106d39:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106d3e:	e9 a7 f4 ff ff       	jmp    801061ea <alltraps>

80106d43 <vector169>:
.globl vector169
vector169:
  pushl $0
80106d43:	6a 00                	push   $0x0
  pushl $169
80106d45:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106d4a:	e9 9b f4 ff ff       	jmp    801061ea <alltraps>

80106d4f <vector170>:
.globl vector170
vector170:
  pushl $0
80106d4f:	6a 00                	push   $0x0
  pushl $170
80106d51:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106d56:	e9 8f f4 ff ff       	jmp    801061ea <alltraps>

80106d5b <vector171>:
.globl vector171
vector171:
  pushl $0
80106d5b:	6a 00                	push   $0x0
  pushl $171
80106d5d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106d62:	e9 83 f4 ff ff       	jmp    801061ea <alltraps>

80106d67 <vector172>:
.globl vector172
vector172:
  pushl $0
80106d67:	6a 00                	push   $0x0
  pushl $172
80106d69:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106d6e:	e9 77 f4 ff ff       	jmp    801061ea <alltraps>

80106d73 <vector173>:
.globl vector173
vector173:
  pushl $0
80106d73:	6a 00                	push   $0x0
  pushl $173
80106d75:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106d7a:	e9 6b f4 ff ff       	jmp    801061ea <alltraps>

80106d7f <vector174>:
.globl vector174
vector174:
  pushl $0
80106d7f:	6a 00                	push   $0x0
  pushl $174
80106d81:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106d86:	e9 5f f4 ff ff       	jmp    801061ea <alltraps>

80106d8b <vector175>:
.globl vector175
vector175:
  pushl $0
80106d8b:	6a 00                	push   $0x0
  pushl $175
80106d8d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106d92:	e9 53 f4 ff ff       	jmp    801061ea <alltraps>

80106d97 <vector176>:
.globl vector176
vector176:
  pushl $0
80106d97:	6a 00                	push   $0x0
  pushl $176
80106d99:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106d9e:	e9 47 f4 ff ff       	jmp    801061ea <alltraps>

80106da3 <vector177>:
.globl vector177
vector177:
  pushl $0
80106da3:	6a 00                	push   $0x0
  pushl $177
80106da5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106daa:	e9 3b f4 ff ff       	jmp    801061ea <alltraps>

80106daf <vector178>:
.globl vector178
vector178:
  pushl $0
80106daf:	6a 00                	push   $0x0
  pushl $178
80106db1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106db6:	e9 2f f4 ff ff       	jmp    801061ea <alltraps>

80106dbb <vector179>:
.globl vector179
vector179:
  pushl $0
80106dbb:	6a 00                	push   $0x0
  pushl $179
80106dbd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106dc2:	e9 23 f4 ff ff       	jmp    801061ea <alltraps>

80106dc7 <vector180>:
.globl vector180
vector180:
  pushl $0
80106dc7:	6a 00                	push   $0x0
  pushl $180
80106dc9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106dce:	e9 17 f4 ff ff       	jmp    801061ea <alltraps>

80106dd3 <vector181>:
.globl vector181
vector181:
  pushl $0
80106dd3:	6a 00                	push   $0x0
  pushl $181
80106dd5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106dda:	e9 0b f4 ff ff       	jmp    801061ea <alltraps>

80106ddf <vector182>:
.globl vector182
vector182:
  pushl $0
80106ddf:	6a 00                	push   $0x0
  pushl $182
80106de1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106de6:	e9 ff f3 ff ff       	jmp    801061ea <alltraps>

80106deb <vector183>:
.globl vector183
vector183:
  pushl $0
80106deb:	6a 00                	push   $0x0
  pushl $183
80106ded:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106df2:	e9 f3 f3 ff ff       	jmp    801061ea <alltraps>

80106df7 <vector184>:
.globl vector184
vector184:
  pushl $0
80106df7:	6a 00                	push   $0x0
  pushl $184
80106df9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106dfe:	e9 e7 f3 ff ff       	jmp    801061ea <alltraps>

80106e03 <vector185>:
.globl vector185
vector185:
  pushl $0
80106e03:	6a 00                	push   $0x0
  pushl $185
80106e05:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106e0a:	e9 db f3 ff ff       	jmp    801061ea <alltraps>

80106e0f <vector186>:
.globl vector186
vector186:
  pushl $0
80106e0f:	6a 00                	push   $0x0
  pushl $186
80106e11:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106e16:	e9 cf f3 ff ff       	jmp    801061ea <alltraps>

80106e1b <vector187>:
.globl vector187
vector187:
  pushl $0
80106e1b:	6a 00                	push   $0x0
  pushl $187
80106e1d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106e22:	e9 c3 f3 ff ff       	jmp    801061ea <alltraps>

80106e27 <vector188>:
.globl vector188
vector188:
  pushl $0
80106e27:	6a 00                	push   $0x0
  pushl $188
80106e29:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106e2e:	e9 b7 f3 ff ff       	jmp    801061ea <alltraps>

80106e33 <vector189>:
.globl vector189
vector189:
  pushl $0
80106e33:	6a 00                	push   $0x0
  pushl $189
80106e35:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106e3a:	e9 ab f3 ff ff       	jmp    801061ea <alltraps>

80106e3f <vector190>:
.globl vector190
vector190:
  pushl $0
80106e3f:	6a 00                	push   $0x0
  pushl $190
80106e41:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106e46:	e9 9f f3 ff ff       	jmp    801061ea <alltraps>

80106e4b <vector191>:
.globl vector191
vector191:
  pushl $0
80106e4b:	6a 00                	push   $0x0
  pushl $191
80106e4d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106e52:	e9 93 f3 ff ff       	jmp    801061ea <alltraps>

80106e57 <vector192>:
.globl vector192
vector192:
  pushl $0
80106e57:	6a 00                	push   $0x0
  pushl $192
80106e59:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106e5e:	e9 87 f3 ff ff       	jmp    801061ea <alltraps>

80106e63 <vector193>:
.globl vector193
vector193:
  pushl $0
80106e63:	6a 00                	push   $0x0
  pushl $193
80106e65:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106e6a:	e9 7b f3 ff ff       	jmp    801061ea <alltraps>

80106e6f <vector194>:
.globl vector194
vector194:
  pushl $0
80106e6f:	6a 00                	push   $0x0
  pushl $194
80106e71:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106e76:	e9 6f f3 ff ff       	jmp    801061ea <alltraps>

80106e7b <vector195>:
.globl vector195
vector195:
  pushl $0
80106e7b:	6a 00                	push   $0x0
  pushl $195
80106e7d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106e82:	e9 63 f3 ff ff       	jmp    801061ea <alltraps>

80106e87 <vector196>:
.globl vector196
vector196:
  pushl $0
80106e87:	6a 00                	push   $0x0
  pushl $196
80106e89:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106e8e:	e9 57 f3 ff ff       	jmp    801061ea <alltraps>

80106e93 <vector197>:
.globl vector197
vector197:
  pushl $0
80106e93:	6a 00                	push   $0x0
  pushl $197
80106e95:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106e9a:	e9 4b f3 ff ff       	jmp    801061ea <alltraps>

80106e9f <vector198>:
.globl vector198
vector198:
  pushl $0
80106e9f:	6a 00                	push   $0x0
  pushl $198
80106ea1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106ea6:	e9 3f f3 ff ff       	jmp    801061ea <alltraps>

80106eab <vector199>:
.globl vector199
vector199:
  pushl $0
80106eab:	6a 00                	push   $0x0
  pushl $199
80106ead:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106eb2:	e9 33 f3 ff ff       	jmp    801061ea <alltraps>

80106eb7 <vector200>:
.globl vector200
vector200:
  pushl $0
80106eb7:	6a 00                	push   $0x0
  pushl $200
80106eb9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106ebe:	e9 27 f3 ff ff       	jmp    801061ea <alltraps>

80106ec3 <vector201>:
.globl vector201
vector201:
  pushl $0
80106ec3:	6a 00                	push   $0x0
  pushl $201
80106ec5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106eca:	e9 1b f3 ff ff       	jmp    801061ea <alltraps>

80106ecf <vector202>:
.globl vector202
vector202:
  pushl $0
80106ecf:	6a 00                	push   $0x0
  pushl $202
80106ed1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106ed6:	e9 0f f3 ff ff       	jmp    801061ea <alltraps>

80106edb <vector203>:
.globl vector203
vector203:
  pushl $0
80106edb:	6a 00                	push   $0x0
  pushl $203
80106edd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106ee2:	e9 03 f3 ff ff       	jmp    801061ea <alltraps>

80106ee7 <vector204>:
.globl vector204
vector204:
  pushl $0
80106ee7:	6a 00                	push   $0x0
  pushl $204
80106ee9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106eee:	e9 f7 f2 ff ff       	jmp    801061ea <alltraps>

80106ef3 <vector205>:
.globl vector205
vector205:
  pushl $0
80106ef3:	6a 00                	push   $0x0
  pushl $205
80106ef5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106efa:	e9 eb f2 ff ff       	jmp    801061ea <alltraps>

80106eff <vector206>:
.globl vector206
vector206:
  pushl $0
80106eff:	6a 00                	push   $0x0
  pushl $206
80106f01:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106f06:	e9 df f2 ff ff       	jmp    801061ea <alltraps>

80106f0b <vector207>:
.globl vector207
vector207:
  pushl $0
80106f0b:	6a 00                	push   $0x0
  pushl $207
80106f0d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106f12:	e9 d3 f2 ff ff       	jmp    801061ea <alltraps>

80106f17 <vector208>:
.globl vector208
vector208:
  pushl $0
80106f17:	6a 00                	push   $0x0
  pushl $208
80106f19:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106f1e:	e9 c7 f2 ff ff       	jmp    801061ea <alltraps>

80106f23 <vector209>:
.globl vector209
vector209:
  pushl $0
80106f23:	6a 00                	push   $0x0
  pushl $209
80106f25:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106f2a:	e9 bb f2 ff ff       	jmp    801061ea <alltraps>

80106f2f <vector210>:
.globl vector210
vector210:
  pushl $0
80106f2f:	6a 00                	push   $0x0
  pushl $210
80106f31:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106f36:	e9 af f2 ff ff       	jmp    801061ea <alltraps>

80106f3b <vector211>:
.globl vector211
vector211:
  pushl $0
80106f3b:	6a 00                	push   $0x0
  pushl $211
80106f3d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106f42:	e9 a3 f2 ff ff       	jmp    801061ea <alltraps>

80106f47 <vector212>:
.globl vector212
vector212:
  pushl $0
80106f47:	6a 00                	push   $0x0
  pushl $212
80106f49:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106f4e:	e9 97 f2 ff ff       	jmp    801061ea <alltraps>

80106f53 <vector213>:
.globl vector213
vector213:
  pushl $0
80106f53:	6a 00                	push   $0x0
  pushl $213
80106f55:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106f5a:	e9 8b f2 ff ff       	jmp    801061ea <alltraps>

80106f5f <vector214>:
.globl vector214
vector214:
  pushl $0
80106f5f:	6a 00                	push   $0x0
  pushl $214
80106f61:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106f66:	e9 7f f2 ff ff       	jmp    801061ea <alltraps>

80106f6b <vector215>:
.globl vector215
vector215:
  pushl $0
80106f6b:	6a 00                	push   $0x0
  pushl $215
80106f6d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106f72:	e9 73 f2 ff ff       	jmp    801061ea <alltraps>

80106f77 <vector216>:
.globl vector216
vector216:
  pushl $0
80106f77:	6a 00                	push   $0x0
  pushl $216
80106f79:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106f7e:	e9 67 f2 ff ff       	jmp    801061ea <alltraps>

80106f83 <vector217>:
.globl vector217
vector217:
  pushl $0
80106f83:	6a 00                	push   $0x0
  pushl $217
80106f85:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106f8a:	e9 5b f2 ff ff       	jmp    801061ea <alltraps>

80106f8f <vector218>:
.globl vector218
vector218:
  pushl $0
80106f8f:	6a 00                	push   $0x0
  pushl $218
80106f91:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106f96:	e9 4f f2 ff ff       	jmp    801061ea <alltraps>

80106f9b <vector219>:
.globl vector219
vector219:
  pushl $0
80106f9b:	6a 00                	push   $0x0
  pushl $219
80106f9d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106fa2:	e9 43 f2 ff ff       	jmp    801061ea <alltraps>

80106fa7 <vector220>:
.globl vector220
vector220:
  pushl $0
80106fa7:	6a 00                	push   $0x0
  pushl $220
80106fa9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106fae:	e9 37 f2 ff ff       	jmp    801061ea <alltraps>

80106fb3 <vector221>:
.globl vector221
vector221:
  pushl $0
80106fb3:	6a 00                	push   $0x0
  pushl $221
80106fb5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106fba:	e9 2b f2 ff ff       	jmp    801061ea <alltraps>

80106fbf <vector222>:
.globl vector222
vector222:
  pushl $0
80106fbf:	6a 00                	push   $0x0
  pushl $222
80106fc1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106fc6:	e9 1f f2 ff ff       	jmp    801061ea <alltraps>

80106fcb <vector223>:
.globl vector223
vector223:
  pushl $0
80106fcb:	6a 00                	push   $0x0
  pushl $223
80106fcd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106fd2:	e9 13 f2 ff ff       	jmp    801061ea <alltraps>

80106fd7 <vector224>:
.globl vector224
vector224:
  pushl $0
80106fd7:	6a 00                	push   $0x0
  pushl $224
80106fd9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106fde:	e9 07 f2 ff ff       	jmp    801061ea <alltraps>

80106fe3 <vector225>:
.globl vector225
vector225:
  pushl $0
80106fe3:	6a 00                	push   $0x0
  pushl $225
80106fe5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106fea:	e9 fb f1 ff ff       	jmp    801061ea <alltraps>

80106fef <vector226>:
.globl vector226
vector226:
  pushl $0
80106fef:	6a 00                	push   $0x0
  pushl $226
80106ff1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106ff6:	e9 ef f1 ff ff       	jmp    801061ea <alltraps>

80106ffb <vector227>:
.globl vector227
vector227:
  pushl $0
80106ffb:	6a 00                	push   $0x0
  pushl $227
80106ffd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107002:	e9 e3 f1 ff ff       	jmp    801061ea <alltraps>

80107007 <vector228>:
.globl vector228
vector228:
  pushl $0
80107007:	6a 00                	push   $0x0
  pushl $228
80107009:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010700e:	e9 d7 f1 ff ff       	jmp    801061ea <alltraps>

80107013 <vector229>:
.globl vector229
vector229:
  pushl $0
80107013:	6a 00                	push   $0x0
  pushl $229
80107015:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010701a:	e9 cb f1 ff ff       	jmp    801061ea <alltraps>

8010701f <vector230>:
.globl vector230
vector230:
  pushl $0
8010701f:	6a 00                	push   $0x0
  pushl $230
80107021:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107026:	e9 bf f1 ff ff       	jmp    801061ea <alltraps>

8010702b <vector231>:
.globl vector231
vector231:
  pushl $0
8010702b:	6a 00                	push   $0x0
  pushl $231
8010702d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107032:	e9 b3 f1 ff ff       	jmp    801061ea <alltraps>

80107037 <vector232>:
.globl vector232
vector232:
  pushl $0
80107037:	6a 00                	push   $0x0
  pushl $232
80107039:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010703e:	e9 a7 f1 ff ff       	jmp    801061ea <alltraps>

80107043 <vector233>:
.globl vector233
vector233:
  pushl $0
80107043:	6a 00                	push   $0x0
  pushl $233
80107045:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010704a:	e9 9b f1 ff ff       	jmp    801061ea <alltraps>

8010704f <vector234>:
.globl vector234
vector234:
  pushl $0
8010704f:	6a 00                	push   $0x0
  pushl $234
80107051:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107056:	e9 8f f1 ff ff       	jmp    801061ea <alltraps>

8010705b <vector235>:
.globl vector235
vector235:
  pushl $0
8010705b:	6a 00                	push   $0x0
  pushl $235
8010705d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107062:	e9 83 f1 ff ff       	jmp    801061ea <alltraps>

80107067 <vector236>:
.globl vector236
vector236:
  pushl $0
80107067:	6a 00                	push   $0x0
  pushl $236
80107069:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010706e:	e9 77 f1 ff ff       	jmp    801061ea <alltraps>

80107073 <vector237>:
.globl vector237
vector237:
  pushl $0
80107073:	6a 00                	push   $0x0
  pushl $237
80107075:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010707a:	e9 6b f1 ff ff       	jmp    801061ea <alltraps>

8010707f <vector238>:
.globl vector238
vector238:
  pushl $0
8010707f:	6a 00                	push   $0x0
  pushl $238
80107081:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107086:	e9 5f f1 ff ff       	jmp    801061ea <alltraps>

8010708b <vector239>:
.globl vector239
vector239:
  pushl $0
8010708b:	6a 00                	push   $0x0
  pushl $239
8010708d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107092:	e9 53 f1 ff ff       	jmp    801061ea <alltraps>

80107097 <vector240>:
.globl vector240
vector240:
  pushl $0
80107097:	6a 00                	push   $0x0
  pushl $240
80107099:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010709e:	e9 47 f1 ff ff       	jmp    801061ea <alltraps>

801070a3 <vector241>:
.globl vector241
vector241:
  pushl $0
801070a3:	6a 00                	push   $0x0
  pushl $241
801070a5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801070aa:	e9 3b f1 ff ff       	jmp    801061ea <alltraps>

801070af <vector242>:
.globl vector242
vector242:
  pushl $0
801070af:	6a 00                	push   $0x0
  pushl $242
801070b1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801070b6:	e9 2f f1 ff ff       	jmp    801061ea <alltraps>

801070bb <vector243>:
.globl vector243
vector243:
  pushl $0
801070bb:	6a 00                	push   $0x0
  pushl $243
801070bd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801070c2:	e9 23 f1 ff ff       	jmp    801061ea <alltraps>

801070c7 <vector244>:
.globl vector244
vector244:
  pushl $0
801070c7:	6a 00                	push   $0x0
  pushl $244
801070c9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801070ce:	e9 17 f1 ff ff       	jmp    801061ea <alltraps>

801070d3 <vector245>:
.globl vector245
vector245:
  pushl $0
801070d3:	6a 00                	push   $0x0
  pushl $245
801070d5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801070da:	e9 0b f1 ff ff       	jmp    801061ea <alltraps>

801070df <vector246>:
.globl vector246
vector246:
  pushl $0
801070df:	6a 00                	push   $0x0
  pushl $246
801070e1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801070e6:	e9 ff f0 ff ff       	jmp    801061ea <alltraps>

801070eb <vector247>:
.globl vector247
vector247:
  pushl $0
801070eb:	6a 00                	push   $0x0
  pushl $247
801070ed:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801070f2:	e9 f3 f0 ff ff       	jmp    801061ea <alltraps>

801070f7 <vector248>:
.globl vector248
vector248:
  pushl $0
801070f7:	6a 00                	push   $0x0
  pushl $248
801070f9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801070fe:	e9 e7 f0 ff ff       	jmp    801061ea <alltraps>

80107103 <vector249>:
.globl vector249
vector249:
  pushl $0
80107103:	6a 00                	push   $0x0
  pushl $249
80107105:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010710a:	e9 db f0 ff ff       	jmp    801061ea <alltraps>

8010710f <vector250>:
.globl vector250
vector250:
  pushl $0
8010710f:	6a 00                	push   $0x0
  pushl $250
80107111:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107116:	e9 cf f0 ff ff       	jmp    801061ea <alltraps>

8010711b <vector251>:
.globl vector251
vector251:
  pushl $0
8010711b:	6a 00                	push   $0x0
  pushl $251
8010711d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107122:	e9 c3 f0 ff ff       	jmp    801061ea <alltraps>

80107127 <vector252>:
.globl vector252
vector252:
  pushl $0
80107127:	6a 00                	push   $0x0
  pushl $252
80107129:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010712e:	e9 b7 f0 ff ff       	jmp    801061ea <alltraps>

80107133 <vector253>:
.globl vector253
vector253:
  pushl $0
80107133:	6a 00                	push   $0x0
  pushl $253
80107135:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010713a:	e9 ab f0 ff ff       	jmp    801061ea <alltraps>

8010713f <vector254>:
.globl vector254
vector254:
  pushl $0
8010713f:	6a 00                	push   $0x0
  pushl $254
80107141:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107146:	e9 9f f0 ff ff       	jmp    801061ea <alltraps>

8010714b <vector255>:
.globl vector255
vector255:
  pushl $0
8010714b:	6a 00                	push   $0x0
  pushl $255
8010714d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107152:	e9 93 f0 ff ff       	jmp    801061ea <alltraps>
80107157:	66 90                	xchg   %ax,%ax
80107159:	66 90                	xchg   %ax,%ax
8010715b:	66 90                	xchg   %ax,%ax
8010715d:	66 90                	xchg   %ax,%ax
8010715f:	90                   	nop

80107160 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107160:	55                   	push   %ebp
80107161:	89 e5                	mov    %esp,%ebp
80107163:	57                   	push   %edi
80107164:	56                   	push   %esi
80107165:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107167:	c1 ea 16             	shr    $0x16,%edx
{
8010716a:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
8010716b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
8010716e:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107171:	8b 07                	mov    (%edi),%eax
80107173:	a8 01                	test   $0x1,%al
80107175:	74 29                	je     801071a0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107177:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010717c:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107182:	c1 ee 0a             	shr    $0xa,%esi
}
80107185:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80107188:	89 f2                	mov    %esi,%edx
8010718a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107190:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107193:	5b                   	pop    %ebx
80107194:	5e                   	pop    %esi
80107195:	5f                   	pop    %edi
80107196:	5d                   	pop    %ebp
80107197:	c3                   	ret    
80107198:	90                   	nop
80107199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801071a0:	85 c9                	test   %ecx,%ecx
801071a2:	74 2c                	je     801071d0 <walkpgdir+0x70>
801071a4:	e8 87 b4 ff ff       	call   80102630 <kalloc>
801071a9:	89 c3                	mov    %eax,%ebx
801071ab:	85 c0                	test   %eax,%eax
801071ad:	74 21                	je     801071d0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801071af:	83 ec 04             	sub    $0x4,%esp
801071b2:	68 00 10 00 00       	push   $0x1000
801071b7:	6a 00                	push   $0x0
801071b9:	50                   	push   %eax
801071ba:	e8 81 de ff ff       	call   80105040 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801071bf:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801071c5:	83 c4 10             	add    $0x10,%esp
801071c8:	83 c8 07             	or     $0x7,%eax
801071cb:	89 07                	mov    %eax,(%edi)
801071cd:	eb b3                	jmp    80107182 <walkpgdir+0x22>
801071cf:	90                   	nop
}
801071d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801071d3:	31 c0                	xor    %eax,%eax
}
801071d5:	5b                   	pop    %ebx
801071d6:	5e                   	pop    %esi
801071d7:	5f                   	pop    %edi
801071d8:	5d                   	pop    %ebp
801071d9:	c3                   	ret    
801071da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801071e0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801071e0:	55                   	push   %ebp
801071e1:	89 e5                	mov    %esp,%ebp
801071e3:	57                   	push   %edi
801071e4:	56                   	push   %esi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801071e5:	89 d6                	mov    %edx,%esi
{
801071e7:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
801071e8:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
801071ee:	83 ec 1c             	sub    $0x1c,%esp
801071f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801071f4:	8b 7d 08             	mov    0x8(%ebp),%edi
801071f7:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801071fb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107200:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107203:	29 f7                	sub    %esi,%edi
80107205:	eb 21                	jmp    80107228 <mappages+0x48>
80107207:	89 f6                	mov    %esi,%esi
80107209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80107210:	f6 00 01             	testb  $0x1,(%eax)
80107213:	75 45                	jne    8010725a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80107215:	0b 5d 0c             	or     0xc(%ebp),%ebx
80107218:	83 cb 01             	or     $0x1,%ebx
8010721b:	89 18                	mov    %ebx,(%eax)
    if(a == last)
8010721d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80107220:	74 2e                	je     80107250 <mappages+0x70>
      break;
    a += PGSIZE;
80107222:	81 c6 00 10 00 00    	add    $0x1000,%esi
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107228:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010722b:	b9 01 00 00 00       	mov    $0x1,%ecx
80107230:	89 f2                	mov    %esi,%edx
80107232:	8d 1c 3e             	lea    (%esi,%edi,1),%ebx
80107235:	e8 26 ff ff ff       	call   80107160 <walkpgdir>
8010723a:	85 c0                	test   %eax,%eax
8010723c:	75 d2                	jne    80107210 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010723e:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107241:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107246:	5b                   	pop    %ebx
80107247:	5e                   	pop    %esi
80107248:	5f                   	pop    %edi
80107249:	5d                   	pop    %ebp
8010724a:	c3                   	ret    
8010724b:	90                   	nop
8010724c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107250:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107253:	31 c0                	xor    %eax,%eax
}
80107255:	5b                   	pop    %ebx
80107256:	5e                   	pop    %esi
80107257:	5f                   	pop    %edi
80107258:	5d                   	pop    %ebp
80107259:	c3                   	ret    
      panic("remap");
8010725a:	83 ec 0c             	sub    $0xc,%esp
8010725d:	68 78 85 10 80       	push   $0x80108578
80107262:	e8 29 91 ff ff       	call   80100390 <panic>
80107267:	89 f6                	mov    %esi,%esi
80107269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107270 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107270:	55                   	push   %ebp
80107271:	89 e5                	mov    %esp,%ebp
80107273:	57                   	push   %edi
80107274:	89 c7                	mov    %eax,%edi
80107276:	56                   	push   %esi
80107277:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107278:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010727e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107284:	83 ec 1c             	sub    $0x1c,%esp
80107287:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010728a:	39 d3                	cmp    %edx,%ebx
8010728c:	73 5a                	jae    801072e8 <deallocuvm.part.0+0x78>
8010728e:	89 d6                	mov    %edx,%esi
80107290:	eb 10                	jmp    801072a2 <deallocuvm.part.0+0x32>
80107292:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107298:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010729e:	39 de                	cmp    %ebx,%esi
801072a0:	76 46                	jbe    801072e8 <deallocuvm.part.0+0x78>
    pte = walkpgdir(pgdir, (char*)a, 0);
801072a2:	31 c9                	xor    %ecx,%ecx
801072a4:	89 da                	mov    %ebx,%edx
801072a6:	89 f8                	mov    %edi,%eax
801072a8:	e8 b3 fe ff ff       	call   80107160 <walkpgdir>
    if(!pte)
801072ad:	85 c0                	test   %eax,%eax
801072af:	74 47                	je     801072f8 <deallocuvm.part.0+0x88>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801072b1:	8b 10                	mov    (%eax),%edx
801072b3:	f6 c2 01             	test   $0x1,%dl
801072b6:	74 e0                	je     80107298 <deallocuvm.part.0+0x28>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801072b8:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801072be:	74 46                	je     80107306 <deallocuvm.part.0+0x96>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801072c0:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801072c3:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801072c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
801072cc:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801072d2:	52                   	push   %edx
801072d3:	e8 18 b1 ff ff       	call   801023f0 <kfree>
      *pte = 0;
801072d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801072db:	83 c4 10             	add    $0x10,%esp
801072de:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801072e4:	39 de                	cmp    %ebx,%esi
801072e6:	77 ba                	ja     801072a2 <deallocuvm.part.0+0x32>
    }
  }
  return newsz;
}
801072e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801072eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072ee:	5b                   	pop    %ebx
801072ef:	5e                   	pop    %esi
801072f0:	5f                   	pop    %edi
801072f1:	5d                   	pop    %ebp
801072f2:	c3                   	ret    
801072f3:	90                   	nop
801072f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801072f8:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801072fe:	81 c3 00 00 40 00    	add    $0x400000,%ebx
80107304:	eb 98                	jmp    8010729e <deallocuvm.part.0+0x2e>
        panic("kfree");
80107306:	83 ec 0c             	sub    $0xc,%esp
80107309:	68 06 7e 10 80       	push   $0x80107e06
8010730e:	e8 7d 90 ff ff       	call   80100390 <panic>
80107313:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107320 <seginit>:
{
80107320:	55                   	push   %ebp
80107321:	89 e5                	mov    %esp,%ebp
80107323:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107326:	e8 55 c9 ff ff       	call   80103c80 <cpuid>
  pd[0] = size-1;
8010732b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107330:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107336:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010733a:	c7 80 38 b8 14 80 ff 	movl   $0xffff,-0x7feb47c8(%eax)
80107341:	ff 00 00 
80107344:	c7 80 3c b8 14 80 00 	movl   $0xcf9a00,-0x7feb47c4(%eax)
8010734b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010734e:	c7 80 40 b8 14 80 ff 	movl   $0xffff,-0x7feb47c0(%eax)
80107355:	ff 00 00 
80107358:	c7 80 44 b8 14 80 00 	movl   $0xcf9200,-0x7feb47bc(%eax)
8010735f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107362:	c7 80 48 b8 14 80 ff 	movl   $0xffff,-0x7feb47b8(%eax)
80107369:	ff 00 00 
8010736c:	c7 80 4c b8 14 80 00 	movl   $0xcffa00,-0x7feb47b4(%eax)
80107373:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107376:	c7 80 50 b8 14 80 ff 	movl   $0xffff,-0x7feb47b0(%eax)
8010737d:	ff 00 00 
80107380:	c7 80 54 b8 14 80 00 	movl   $0xcff200,-0x7feb47ac(%eax)
80107387:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010738a:	05 30 b8 14 80       	add    $0x8014b830,%eax
  pd[1] = (uint)p;
8010738f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107393:	c1 e8 10             	shr    $0x10,%eax
80107396:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010739a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010739d:	0f 01 10             	lgdtl  (%eax)
}
801073a0:	c9                   	leave  
801073a1:	c3                   	ret    
801073a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801073b0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801073b0:	a1 04 e9 14 80       	mov    0x8014e904,%eax
801073b5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801073ba:	0f 22 d8             	mov    %eax,%cr3
}
801073bd:	c3                   	ret    
801073be:	66 90                	xchg   %ax,%ax

801073c0 <switchuvm>:
{
801073c0:	55                   	push   %ebp
801073c1:	89 e5                	mov    %esp,%ebp
801073c3:	57                   	push   %edi
801073c4:	56                   	push   %esi
801073c5:	53                   	push   %ebx
801073c6:	83 ec 1c             	sub    $0x1c,%esp
801073c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801073cc:	85 db                	test   %ebx,%ebx
801073ce:	0f 84 cb 00 00 00    	je     8010749f <switchuvm+0xdf>
  if(p->kstack == 0)
801073d4:	8b 43 08             	mov    0x8(%ebx),%eax
801073d7:	85 c0                	test   %eax,%eax
801073d9:	0f 84 da 00 00 00    	je     801074b9 <switchuvm+0xf9>
  if(p->pgdir == 0)
801073df:	8b 43 04             	mov    0x4(%ebx),%eax
801073e2:	85 c0                	test   %eax,%eax
801073e4:	0f 84 c2 00 00 00    	je     801074ac <switchuvm+0xec>
  pushcli();
801073ea:	e8 51 da ff ff       	call   80104e40 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801073ef:	e8 0c c8 ff ff       	call   80103c00 <mycpu>
801073f4:	89 c6                	mov    %eax,%esi
801073f6:	e8 05 c8 ff ff       	call   80103c00 <mycpu>
801073fb:	89 c7                	mov    %eax,%edi
801073fd:	e8 fe c7 ff ff       	call   80103c00 <mycpu>
80107402:	83 c7 08             	add    $0x8,%edi
80107405:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107408:	e8 f3 c7 ff ff       	call   80103c00 <mycpu>
8010740d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107410:	ba 67 00 00 00       	mov    $0x67,%edx
80107415:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
8010741c:	83 c0 08             	add    $0x8,%eax
8010741f:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107426:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010742b:	83 c1 08             	add    $0x8,%ecx
8010742e:	c1 e8 18             	shr    $0x18,%eax
80107431:	c1 e9 10             	shr    $0x10,%ecx
80107434:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
8010743a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80107440:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107445:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010744c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80107451:	e8 aa c7 ff ff       	call   80103c00 <mycpu>
80107456:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010745d:	e8 9e c7 ff ff       	call   80103c00 <mycpu>
80107462:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107466:	8b 73 08             	mov    0x8(%ebx),%esi
80107469:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010746f:	e8 8c c7 ff ff       	call   80103c00 <mycpu>
80107474:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107477:	e8 84 c7 ff ff       	call   80103c00 <mycpu>
8010747c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107480:	b8 28 00 00 00       	mov    $0x28,%eax
80107485:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107488:	8b 43 04             	mov    0x4(%ebx),%eax
8010748b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107490:	0f 22 d8             	mov    %eax,%cr3
}
80107493:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107496:	5b                   	pop    %ebx
80107497:	5e                   	pop    %esi
80107498:	5f                   	pop    %edi
80107499:	5d                   	pop    %ebp
  popcli();
8010749a:	e9 f1 d9 ff ff       	jmp    80104e90 <popcli>
    panic("switchuvm: no process");
8010749f:	83 ec 0c             	sub    $0xc,%esp
801074a2:	68 7e 85 10 80       	push   $0x8010857e
801074a7:	e8 e4 8e ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
801074ac:	83 ec 0c             	sub    $0xc,%esp
801074af:	68 a9 85 10 80       	push   $0x801085a9
801074b4:	e8 d7 8e ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801074b9:	83 ec 0c             	sub    $0xc,%esp
801074bc:	68 94 85 10 80       	push   $0x80108594
801074c1:	e8 ca 8e ff ff       	call   80100390 <panic>
801074c6:	8d 76 00             	lea    0x0(%esi),%esi
801074c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801074d0 <inituvm>:
{
801074d0:	55                   	push   %ebp
801074d1:	89 e5                	mov    %esp,%ebp
801074d3:	57                   	push   %edi
801074d4:	56                   	push   %esi
801074d5:	53                   	push   %ebx
801074d6:	83 ec 1c             	sub    $0x1c,%esp
801074d9:	8b 45 08             	mov    0x8(%ebp),%eax
801074dc:	8b 75 10             	mov    0x10(%ebp),%esi
801074df:	8b 7d 0c             	mov    0xc(%ebp),%edi
801074e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801074e5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801074eb:	77 49                	ja     80107536 <inituvm+0x66>
  mem = kalloc();
801074ed:	e8 3e b1 ff ff       	call   80102630 <kalloc>
  memset(mem, 0, PGSIZE);
801074f2:	83 ec 04             	sub    $0x4,%esp
801074f5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
801074fa:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801074fc:	6a 00                	push   $0x0
801074fe:	50                   	push   %eax
801074ff:	e8 3c db ff ff       	call   80105040 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107504:	58                   	pop    %eax
80107505:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010750b:	5a                   	pop    %edx
8010750c:	6a 06                	push   $0x6
8010750e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107513:	31 d2                	xor    %edx,%edx
80107515:	50                   	push   %eax
80107516:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107519:	e8 c2 fc ff ff       	call   801071e0 <mappages>
  memmove(mem, init, sz);
8010751e:	89 75 10             	mov    %esi,0x10(%ebp)
80107521:	83 c4 10             	add    $0x10,%esp
80107524:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107527:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010752a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010752d:	5b                   	pop    %ebx
8010752e:	5e                   	pop    %esi
8010752f:	5f                   	pop    %edi
80107530:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107531:	e9 aa db ff ff       	jmp    801050e0 <memmove>
    panic("inituvm: more than a page");
80107536:	83 ec 0c             	sub    $0xc,%esp
80107539:	68 bd 85 10 80       	push   $0x801085bd
8010753e:	e8 4d 8e ff ff       	call   80100390 <panic>
80107543:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107550 <loaduvm>:
{
80107550:	55                   	push   %ebp
80107551:	89 e5                	mov    %esp,%ebp
80107553:	57                   	push   %edi
80107554:	56                   	push   %esi
80107555:	53                   	push   %ebx
80107556:	83 ec 1c             	sub    $0x1c,%esp
80107559:	8b 45 0c             	mov    0xc(%ebp),%eax
8010755c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
8010755f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80107564:	0f 85 8d 00 00 00    	jne    801075f7 <loaduvm+0xa7>
8010756a:	01 f0                	add    %esi,%eax
  for(i = 0; i < sz; i += PGSIZE){
8010756c:	89 f3                	mov    %esi,%ebx
8010756e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107571:	8b 45 14             	mov    0x14(%ebp),%eax
80107574:	01 f0                	add    %esi,%eax
80107576:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80107579:	85 f6                	test   %esi,%esi
8010757b:	75 11                	jne    8010758e <loaduvm+0x3e>
8010757d:	eb 61                	jmp    801075e0 <loaduvm+0x90>
8010757f:	90                   	nop
80107580:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107586:	89 f0                	mov    %esi,%eax
80107588:	29 d8                	sub    %ebx,%eax
8010758a:	39 c6                	cmp    %eax,%esi
8010758c:	76 52                	jbe    801075e0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010758e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107591:	8b 45 08             	mov    0x8(%ebp),%eax
80107594:	31 c9                	xor    %ecx,%ecx
80107596:	29 da                	sub    %ebx,%edx
80107598:	e8 c3 fb ff ff       	call   80107160 <walkpgdir>
8010759d:	85 c0                	test   %eax,%eax
8010759f:	74 49                	je     801075ea <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
801075a1:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801075a3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
801075a6:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801075ab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801075b0:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
801075b6:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801075b9:	29 d9                	sub    %ebx,%ecx
801075bb:	05 00 00 00 80       	add    $0x80000000,%eax
801075c0:	57                   	push   %edi
801075c1:	51                   	push   %ecx
801075c2:	50                   	push   %eax
801075c3:	ff 75 10             	pushl  0x10(%ebp)
801075c6:	e8 35 a4 ff ff       	call   80101a00 <readi>
801075cb:	83 c4 10             	add    $0x10,%esp
801075ce:	39 f8                	cmp    %edi,%eax
801075d0:	74 ae                	je     80107580 <loaduvm+0x30>
}
801075d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801075d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801075da:	5b                   	pop    %ebx
801075db:	5e                   	pop    %esi
801075dc:	5f                   	pop    %edi
801075dd:	5d                   	pop    %ebp
801075de:	c3                   	ret    
801075df:	90                   	nop
801075e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801075e3:	31 c0                	xor    %eax,%eax
}
801075e5:	5b                   	pop    %ebx
801075e6:	5e                   	pop    %esi
801075e7:	5f                   	pop    %edi
801075e8:	5d                   	pop    %ebp
801075e9:	c3                   	ret    
      panic("loaduvm: address should exist");
801075ea:	83 ec 0c             	sub    $0xc,%esp
801075ed:	68 d7 85 10 80       	push   $0x801085d7
801075f2:	e8 99 8d ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
801075f7:	83 ec 0c             	sub    $0xc,%esp
801075fa:	68 78 86 10 80       	push   $0x80108678
801075ff:	e8 8c 8d ff ff       	call   80100390 <panic>
80107604:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010760a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107610 <allocuvm>:
{
80107610:	55                   	push   %ebp
80107611:	89 e5                	mov    %esp,%ebp
80107613:	57                   	push   %edi
80107614:	56                   	push   %esi
80107615:	53                   	push   %ebx
80107616:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107619:	8b 7d 10             	mov    0x10(%ebp),%edi
8010761c:	85 ff                	test   %edi,%edi
8010761e:	0f 88 bc 00 00 00    	js     801076e0 <allocuvm+0xd0>
  if(newsz < oldsz)
80107624:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107627:	0f 82 a3 00 00 00    	jb     801076d0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010762d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107630:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107636:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010763c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010763f:	0f 86 8e 00 00 00    	jbe    801076d3 <allocuvm+0xc3>
80107645:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107648:	8b 7d 08             	mov    0x8(%ebp),%edi
8010764b:	eb 42                	jmp    8010768f <allocuvm+0x7f>
8010764d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80107650:	83 ec 04             	sub    $0x4,%esp
80107653:	68 00 10 00 00       	push   $0x1000
80107658:	6a 00                	push   $0x0
8010765a:	50                   	push   %eax
8010765b:	e8 e0 d9 ff ff       	call   80105040 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107660:	58                   	pop    %eax
80107661:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107667:	5a                   	pop    %edx
80107668:	6a 06                	push   $0x6
8010766a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010766f:	89 da                	mov    %ebx,%edx
80107671:	50                   	push   %eax
80107672:	89 f8                	mov    %edi,%eax
80107674:	e8 67 fb ff ff       	call   801071e0 <mappages>
80107679:	83 c4 10             	add    $0x10,%esp
8010767c:	85 c0                	test   %eax,%eax
8010767e:	78 70                	js     801076f0 <allocuvm+0xe0>
  for(; a < newsz; a += PGSIZE){
80107680:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107686:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107689:	0f 86 a1 00 00 00    	jbe    80107730 <allocuvm+0x120>
    mem = kalloc();
8010768f:	e8 9c af ff ff       	call   80102630 <kalloc>
80107694:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80107696:	85 c0                	test   %eax,%eax
80107698:	75 b6                	jne    80107650 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010769a:	83 ec 0c             	sub    $0xc,%esp
8010769d:	68 f5 85 10 80       	push   $0x801085f5
801076a2:	e8 09 90 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
801076a7:	83 c4 10             	add    $0x10,%esp
801076aa:	8b 45 0c             	mov    0xc(%ebp),%eax
801076ad:	39 45 10             	cmp    %eax,0x10(%ebp)
801076b0:	74 2e                	je     801076e0 <allocuvm+0xd0>
801076b2:	89 c1                	mov    %eax,%ecx
801076b4:	8b 55 10             	mov    0x10(%ebp),%edx
801076b7:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
801076ba:	31 ff                	xor    %edi,%edi
801076bc:	e8 af fb ff ff       	call   80107270 <deallocuvm.part.0>
}
801076c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076c4:	89 f8                	mov    %edi,%eax
801076c6:	5b                   	pop    %ebx
801076c7:	5e                   	pop    %esi
801076c8:	5f                   	pop    %edi
801076c9:	5d                   	pop    %ebp
801076ca:	c3                   	ret    
801076cb:	90                   	nop
801076cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
801076d0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
801076d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076d6:	89 f8                	mov    %edi,%eax
801076d8:	5b                   	pop    %ebx
801076d9:	5e                   	pop    %esi
801076da:	5f                   	pop    %edi
801076db:	5d                   	pop    %ebp
801076dc:	c3                   	ret    
801076dd:	8d 76 00             	lea    0x0(%esi),%esi
801076e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801076e3:	31 ff                	xor    %edi,%edi
}
801076e5:	5b                   	pop    %ebx
801076e6:	89 f8                	mov    %edi,%eax
801076e8:	5e                   	pop    %esi
801076e9:	5f                   	pop    %edi
801076ea:	5d                   	pop    %ebp
801076eb:	c3                   	ret    
801076ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("allocuvm out of memory (2)\n");
801076f0:	83 ec 0c             	sub    $0xc,%esp
801076f3:	68 0d 86 10 80       	push   $0x8010860d
801076f8:	e8 b3 8f ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
801076fd:	83 c4 10             	add    $0x10,%esp
80107700:	8b 45 0c             	mov    0xc(%ebp),%eax
80107703:	39 45 10             	cmp    %eax,0x10(%ebp)
80107706:	74 0d                	je     80107715 <allocuvm+0x105>
80107708:	89 c1                	mov    %eax,%ecx
8010770a:	8b 55 10             	mov    0x10(%ebp),%edx
8010770d:	8b 45 08             	mov    0x8(%ebp),%eax
80107710:	e8 5b fb ff ff       	call   80107270 <deallocuvm.part.0>
      kfree(mem);
80107715:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80107718:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010771a:	56                   	push   %esi
8010771b:	e8 d0 ac ff ff       	call   801023f0 <kfree>
      return 0;
80107720:	83 c4 10             	add    $0x10,%esp
}
80107723:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107726:	89 f8                	mov    %edi,%eax
80107728:	5b                   	pop    %ebx
80107729:	5e                   	pop    %esi
8010772a:	5f                   	pop    %edi
8010772b:	5d                   	pop    %ebp
8010772c:	c3                   	ret    
8010772d:	8d 76 00             	lea    0x0(%esi),%esi
80107730:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107733:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107736:	5b                   	pop    %ebx
80107737:	5e                   	pop    %esi
80107738:	89 f8                	mov    %edi,%eax
8010773a:	5f                   	pop    %edi
8010773b:	5d                   	pop    %ebp
8010773c:	c3                   	ret    
8010773d:	8d 76 00             	lea    0x0(%esi),%esi

80107740 <deallocuvm>:
{
80107740:	55                   	push   %ebp
80107741:	89 e5                	mov    %esp,%ebp
80107743:	8b 55 0c             	mov    0xc(%ebp),%edx
80107746:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107749:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010774c:	39 d1                	cmp    %edx,%ecx
8010774e:	73 10                	jae    80107760 <deallocuvm+0x20>
}
80107750:	5d                   	pop    %ebp
80107751:	e9 1a fb ff ff       	jmp    80107270 <deallocuvm.part.0>
80107756:	8d 76 00             	lea    0x0(%esi),%esi
80107759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107760:	89 d0                	mov    %edx,%eax
80107762:	5d                   	pop    %ebp
80107763:	c3                   	ret    
80107764:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010776a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107770 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107770:	55                   	push   %ebp
80107771:	89 e5                	mov    %esp,%ebp
80107773:	57                   	push   %edi
80107774:	56                   	push   %esi
80107775:	53                   	push   %ebx
80107776:	83 ec 0c             	sub    $0xc,%esp
80107779:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010777c:	85 f6                	test   %esi,%esi
8010777e:	74 59                	je     801077d9 <freevm+0x69>
  if(newsz >= oldsz)
80107780:	31 c9                	xor    %ecx,%ecx
80107782:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107787:	89 f0                	mov    %esi,%eax
80107789:	89 f3                	mov    %esi,%ebx
8010778b:	e8 e0 fa ff ff       	call   80107270 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107790:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107796:	eb 0f                	jmp    801077a7 <freevm+0x37>
80107798:	90                   	nop
80107799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077a0:	83 c3 04             	add    $0x4,%ebx
801077a3:	39 df                	cmp    %ebx,%edi
801077a5:	74 23                	je     801077ca <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801077a7:	8b 03                	mov    (%ebx),%eax
801077a9:	a8 01                	test   $0x1,%al
801077ab:	74 f3                	je     801077a0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801077ad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801077b2:	83 ec 0c             	sub    $0xc,%esp
801077b5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801077b8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801077bd:	50                   	push   %eax
801077be:	e8 2d ac ff ff       	call   801023f0 <kfree>
801077c3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801077c6:	39 df                	cmp    %ebx,%edi
801077c8:	75 dd                	jne    801077a7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801077ca:	89 75 08             	mov    %esi,0x8(%ebp)
}
801077cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077d0:	5b                   	pop    %ebx
801077d1:	5e                   	pop    %esi
801077d2:	5f                   	pop    %edi
801077d3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801077d4:	e9 17 ac ff ff       	jmp    801023f0 <kfree>
    panic("freevm: no pgdir");
801077d9:	83 ec 0c             	sub    $0xc,%esp
801077dc:	68 29 86 10 80       	push   $0x80108629
801077e1:	e8 aa 8b ff ff       	call   80100390 <panic>
801077e6:	8d 76 00             	lea    0x0(%esi),%esi
801077e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801077f0 <setupkvm>:
{
801077f0:	55                   	push   %ebp
801077f1:	89 e5                	mov    %esp,%ebp
801077f3:	56                   	push   %esi
801077f4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801077f5:	e8 36 ae ff ff       	call   80102630 <kalloc>
801077fa:	89 c6                	mov    %eax,%esi
801077fc:	85 c0                	test   %eax,%eax
801077fe:	74 42                	je     80107842 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107800:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107803:	bb 40 b4 10 80       	mov    $0x8010b440,%ebx
  memset(pgdir, 0, PGSIZE);
80107808:	68 00 10 00 00       	push   $0x1000
8010780d:	6a 00                	push   $0x0
8010780f:	50                   	push   %eax
80107810:	e8 2b d8 ff ff       	call   80105040 <memset>
80107815:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107818:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010781b:	83 ec 08             	sub    $0x8,%esp
8010781e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107821:	ff 73 0c             	pushl  0xc(%ebx)
80107824:	8b 13                	mov    (%ebx),%edx
80107826:	50                   	push   %eax
80107827:	29 c1                	sub    %eax,%ecx
80107829:	89 f0                	mov    %esi,%eax
8010782b:	e8 b0 f9 ff ff       	call   801071e0 <mappages>
80107830:	83 c4 10             	add    $0x10,%esp
80107833:	85 c0                	test   %eax,%eax
80107835:	78 19                	js     80107850 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107837:	83 c3 10             	add    $0x10,%ebx
8010783a:	81 fb 80 b4 10 80    	cmp    $0x8010b480,%ebx
80107840:	75 d6                	jne    80107818 <setupkvm+0x28>
}
80107842:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107845:	89 f0                	mov    %esi,%eax
80107847:	5b                   	pop    %ebx
80107848:	5e                   	pop    %esi
80107849:	5d                   	pop    %ebp
8010784a:	c3                   	ret    
8010784b:	90                   	nop
8010784c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107850:	83 ec 0c             	sub    $0xc,%esp
80107853:	56                   	push   %esi
      return 0;
80107854:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107856:	e8 15 ff ff ff       	call   80107770 <freevm>
      return 0;
8010785b:	83 c4 10             	add    $0x10,%esp
}
8010785e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107861:	89 f0                	mov    %esi,%eax
80107863:	5b                   	pop    %ebx
80107864:	5e                   	pop    %esi
80107865:	5d                   	pop    %ebp
80107866:	c3                   	ret    
80107867:	89 f6                	mov    %esi,%esi
80107869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107870 <kvmalloc>:
{
80107870:	55                   	push   %ebp
80107871:	89 e5                	mov    %esp,%ebp
80107873:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107876:	e8 75 ff ff ff       	call   801077f0 <setupkvm>
8010787b:	a3 04 e9 14 80       	mov    %eax,0x8014e904
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107880:	05 00 00 00 80       	add    $0x80000000,%eax
80107885:	0f 22 d8             	mov    %eax,%cr3
}
80107888:	c9                   	leave  
80107889:	c3                   	ret    
8010788a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107890 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107890:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107891:	31 c9                	xor    %ecx,%ecx
{
80107893:	89 e5                	mov    %esp,%ebp
80107895:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107898:	8b 55 0c             	mov    0xc(%ebp),%edx
8010789b:	8b 45 08             	mov    0x8(%ebp),%eax
8010789e:	e8 bd f8 ff ff       	call   80107160 <walkpgdir>
  if(pte == 0)
801078a3:	85 c0                	test   %eax,%eax
801078a5:	74 05                	je     801078ac <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801078a7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801078aa:	c9                   	leave  
801078ab:	c3                   	ret    
    panic("clearpteu");
801078ac:	83 ec 0c             	sub    $0xc,%esp
801078af:	68 3a 86 10 80       	push   $0x8010863a
801078b4:	e8 d7 8a ff ff       	call   80100390 <panic>
801078b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801078c0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801078c0:	55                   	push   %ebp
801078c1:	89 e5                	mov    %esp,%ebp
801078c3:	57                   	push   %edi
801078c4:	56                   	push   %esi
801078c5:	53                   	push   %ebx
801078c6:	83 ec 0c             	sub    $0xc,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;

  if((d = setupkvm()) == 0)
801078c9:	e8 22 ff ff ff       	call   801077f0 <setupkvm>
801078ce:	89 c7                	mov    %eax,%edi
801078d0:	85 c0                	test   %eax,%eax
801078d2:	74 77                	je     8010794b <copyuvm+0x8b>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801078d4:	8b 45 0c             	mov    0xc(%ebp),%eax
801078d7:	85 c0                	test   %eax,%eax
801078d9:	74 7d                	je     80107958 <copyuvm+0x98>
801078db:	31 db                	xor    %ebx,%ebx
801078dd:	eb 18                	jmp    801078f7 <copyuvm+0x37>
801078df:	90                   	nop
    *pte &= ~PTE_W;
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
      goto bad;
    incref(pa); // Increment reference count for the physical address that the child's pte points to
801078e0:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < sz; i += PGSIZE){
801078e3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    incref(pa); // Increment reference count for the physical address that the child's pte points to
801078e9:	56                   	push   %esi
801078ea:	e8 e1 ad ff ff       	call   801026d0 <incref>
  for(i = 0; i < sz; i += PGSIZE){
801078ef:	83 c4 10             	add    $0x10,%esp
801078f2:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
801078f5:	76 61                	jbe    80107958 <copyuvm+0x98>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801078f7:	8b 45 08             	mov    0x8(%ebp),%eax
801078fa:	31 c9                	xor    %ecx,%ecx
801078fc:	89 da                	mov    %ebx,%edx
801078fe:	e8 5d f8 ff ff       	call   80107160 <walkpgdir>
80107903:	85 c0                	test   %eax,%eax
80107905:	74 73                	je     8010797a <copyuvm+0xba>
    if(!(*pte & PTE_P))
80107907:	8b 10                	mov    (%eax),%edx
80107909:	f6 c2 01             	test   $0x1,%dl
8010790c:	74 5f                	je     8010796d <copyuvm+0xad>
    *pte &= ~PTE_W;
8010790e:	89 d1                	mov    %edx,%ecx
    pa = PTE_ADDR(*pte);
80107910:	89 d6                	mov    %edx,%esi
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
80107912:	83 ec 08             	sub    $0x8,%esp
    flags = PTE_FLAGS(*pte);
80107915:	81 e2 fd 0f 00 00    	and    $0xffd,%edx
    *pte &= ~PTE_W;
8010791b:	83 e1 fd             	and    $0xfffffffd,%ecx
    pa = PTE_ADDR(*pte);
8010791e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    *pte &= ~PTE_W;
80107924:	89 08                	mov    %ecx,(%eax)
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
80107926:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010792b:	89 f8                	mov    %edi,%eax
8010792d:	52                   	push   %edx
8010792e:	89 da                	mov    %ebx,%edx
80107930:	56                   	push   %esi
80107931:	e8 aa f8 ff ff       	call   801071e0 <mappages>
80107936:	83 c4 10             	add    $0x10,%esp
80107939:	85 c0                	test   %eax,%eax
8010793b:	79 a3                	jns    801078e0 <copyuvm+0x20>
  }
  lcr3(V2P(pgdir));
  return d;

bad:
  freevm(d);
8010793d:	83 ec 0c             	sub    $0xc,%esp
80107940:	57                   	push   %edi
  return 0;
80107941:	31 ff                	xor    %edi,%edi
  freevm(d);
80107943:	e8 28 fe ff ff       	call   80107770 <freevm>
  return 0;
80107948:	83 c4 10             	add    $0x10,%esp
}
8010794b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010794e:	89 f8                	mov    %edi,%eax
80107950:	5b                   	pop    %ebx
80107951:	5e                   	pop    %esi
80107952:	5f                   	pop    %edi
80107953:	5d                   	pop    %ebp
80107954:	c3                   	ret    
80107955:	8d 76 00             	lea    0x0(%esi),%esi
  lcr3(V2P(pgdir));
80107958:	8b 45 08             	mov    0x8(%ebp),%eax
8010795b:	05 00 00 00 80       	add    $0x80000000,%eax
80107960:	0f 22 d8             	mov    %eax,%cr3
}
80107963:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107966:	89 f8                	mov    %edi,%eax
80107968:	5b                   	pop    %ebx
80107969:	5e                   	pop    %esi
8010796a:	5f                   	pop    %edi
8010796b:	5d                   	pop    %ebp
8010796c:	c3                   	ret    
      panic("copyuvm: page not present");
8010796d:	83 ec 0c             	sub    $0xc,%esp
80107970:	68 5e 86 10 80       	push   $0x8010865e
80107975:	e8 16 8a ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
8010797a:	83 ec 0c             	sub    $0xc,%esp
8010797d:	68 44 86 10 80       	push   $0x80108644
80107982:	e8 09 8a ff ff       	call   80100390 <panic>
80107987:	89 f6                	mov    %esi,%esi
80107989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107990 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107990:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107991:	31 c9                	xor    %ecx,%ecx
{
80107993:	89 e5                	mov    %esp,%ebp
80107995:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107998:	8b 55 0c             	mov    0xc(%ebp),%edx
8010799b:	8b 45 08             	mov    0x8(%ebp),%eax
8010799e:	e8 bd f7 ff ff       	call   80107160 <walkpgdir>
  if((*pte & PTE_P) == 0)
801079a3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801079a5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
801079a6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801079a8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801079ad:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801079b0:	05 00 00 00 80       	add    $0x80000000,%eax
801079b5:	83 fa 05             	cmp    $0x5,%edx
801079b8:	ba 00 00 00 00       	mov    $0x0,%edx
801079bd:	0f 45 c2             	cmovne %edx,%eax
}
801079c0:	c3                   	ret    
801079c1:	eb 0d                	jmp    801079d0 <copyout>
801079c3:	90                   	nop
801079c4:	90                   	nop
801079c5:	90                   	nop
801079c6:	90                   	nop
801079c7:	90                   	nop
801079c8:	90                   	nop
801079c9:	90                   	nop
801079ca:	90                   	nop
801079cb:	90                   	nop
801079cc:	90                   	nop
801079cd:	90                   	nop
801079ce:	90                   	nop
801079cf:	90                   	nop

801079d0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801079d0:	55                   	push   %ebp
801079d1:	89 e5                	mov    %esp,%ebp
801079d3:	57                   	push   %edi
801079d4:	56                   	push   %esi
801079d5:	53                   	push   %ebx
801079d6:	83 ec 0c             	sub    $0xc,%esp
801079d9:	8b 75 14             	mov    0x14(%ebp),%esi
801079dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801079df:	85 f6                	test   %esi,%esi
801079e1:	75 38                	jne    80107a1b <copyout+0x4b>
801079e3:	eb 6b                	jmp    80107a50 <copyout+0x80>
801079e5:	8d 76 00             	lea    0x0(%esi),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801079e8:	8b 55 0c             	mov    0xc(%ebp),%edx
801079eb:	89 fb                	mov    %edi,%ebx
801079ed:	29 d3                	sub    %edx,%ebx
801079ef:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
801079f5:	39 f3                	cmp    %esi,%ebx
801079f7:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801079fa:	29 fa                	sub    %edi,%edx
801079fc:	83 ec 04             	sub    $0x4,%esp
801079ff:	01 c2                	add    %eax,%edx
80107a01:	53                   	push   %ebx
80107a02:	ff 75 10             	pushl  0x10(%ebp)
80107a05:	52                   	push   %edx
80107a06:	e8 d5 d6 ff ff       	call   801050e0 <memmove>
    len -= n;
    buf += n;
80107a0b:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
80107a0e:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
80107a14:	83 c4 10             	add    $0x10,%esp
80107a17:	29 de                	sub    %ebx,%esi
80107a19:	74 35                	je     80107a50 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
80107a1b:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107a1d:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107a20:	89 55 0c             	mov    %edx,0xc(%ebp)
80107a23:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107a29:	57                   	push   %edi
80107a2a:	ff 75 08             	pushl  0x8(%ebp)
80107a2d:	e8 5e ff ff ff       	call   80107990 <uva2ka>
    if(pa0 == 0)
80107a32:	83 c4 10             	add    $0x10,%esp
80107a35:	85 c0                	test   %eax,%eax
80107a37:	75 af                	jne    801079e8 <copyout+0x18>
  }
  return 0;
}
80107a39:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107a3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107a41:	5b                   	pop    %ebx
80107a42:	5e                   	pop    %esi
80107a43:	5f                   	pop    %edi
80107a44:	5d                   	pop    %ebp
80107a45:	c3                   	ret    
80107a46:	8d 76 00             	lea    0x0(%esi),%esi
80107a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107a50:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107a53:	31 c0                	xor    %eax,%eax
}
80107a55:	5b                   	pop    %ebx
80107a56:	5e                   	pop    %esi
80107a57:	5f                   	pop    %edi
80107a58:	5d                   	pop    %ebp
80107a59:	c3                   	ret    
80107a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107a60 <handlePageFault>:


void handlePageFault(uint e) {
80107a60:	55                   	push   %ebp
80107a61:	89 e5                	mov    %esp,%ebp
80107a63:	57                   	push   %edi
80107a64:	56                   	push   %esi
80107a65:	53                   	push   %ebx
80107a66:	83 ec 0c             	sub    $0xc,%esp
  asm volatile("movl %%cr2,%0" : "=r" (val));
80107a69:	0f 20 d3             	mov    %cr2,%ebx
  uint fa = rcr2();
  pte_t* pte;

  if ((pte = walkpgdir(myproc()->pgdir,(char*)fa,0)) == 0 || !(*pte & PTE_P)) {
80107a6c:	e8 2f c2 ff ff       	call   80103ca0 <myproc>
80107a71:	31 c9                	xor    %ecx,%ecx
80107a73:	89 da                	mov    %ebx,%edx
80107a75:	8b 40 04             	mov    0x4(%eax),%eax
80107a78:	e8 e3 f6 ff ff       	call   80107160 <walkpgdir>
80107a7d:	85 c0                	test   %eax,%eax
80107a7f:	74 77                	je     80107af8 <handlePageFault+0x98>
80107a81:	89 c6                	mov    %eax,%esi
80107a83:	8b 00                	mov    (%eax),%eax
80107a85:	a8 01                	test   $0x1,%al
80107a87:	74 6f                	je     80107af8 <handlePageFault+0x98>
    cprintf("handlePageFault: page table entry for faulting address is not present.\n");
    myproc()->killed = 1;
    return;
  } 
  if (fa >= KERNBASE || !(*pte & PTE_U)) {
80107a89:	85 db                	test   %ebx,%ebx
80107a8b:	78 43                	js     80107ad0 <handlePageFault+0x70>
80107a8d:	a8 04                	test   $0x4,%al
80107a8f:	74 3f                	je     80107ad0 <handlePageFault+0x70>
    cprintf("handlePageFault: faulting address is owned by Kernal space memory.\n");
    myproc()->killed = 1;
    return;
  } 

  if (*pte & PTE_W) {
80107a91:	a8 02                	test   $0x2,%al
80107a93:	0f 85 e8 00 00 00    	jne    80107b81 <handlePageFault+0x121>
    panic("handlePageFault: page is already writable.\n");
  }

  uint pa = PTE_ADDR(*pte);
80107a99:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  uint refCount = getRefCount(pa);
80107a9e:	83 ec 0c             	sub    $0xc,%esp
80107aa1:	50                   	push   %eax
  uint pa = PTE_ADDR(*pte);
80107aa2:	89 c3                	mov    %eax,%ebx
  uint refCount = getRefCount(pa);
80107aa4:	e8 27 ad ff ff       	call   801027d0 <getRefCount>

  if (refCount == 1) {
80107aa9:	83 c4 10             	add    $0x10,%esp
80107aac:	83 f8 01             	cmp    $0x1,%eax
80107aaf:	0f 84 ab 00 00 00    	je     80107b60 <handlePageFault+0x100>
    *pte |= PTE_W;
  }
  else if (refCount > 1){
80107ab5:	77 69                	ja     80107b20 <handlePageFault+0xc0>
    }
    memmove(mem,(char*)P2V(pa),PGSIZE);
    *pte = (uint)P2V(mem) | PTE_P | PTE_U | PTE_W;
    decref(pa);
  }
  lcr3(V2P(myproc()->pgdir));
80107ab7:	e8 e4 c1 ff ff       	call   80103ca0 <myproc>
80107abc:	8b 40 04             	mov    0x4(%eax),%eax
80107abf:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107ac4:	0f 22 d8             	mov    %eax,%cr3
}
80107ac7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107aca:	5b                   	pop    %ebx
80107acb:	5e                   	pop    %esi
80107acc:	5f                   	pop    %edi
80107acd:	5d                   	pop    %ebp
80107ace:	c3                   	ret    
80107acf:	90                   	nop
    cprintf("handlePageFault: faulting address is owned by Kernal space memory.\n");
80107ad0:	83 ec 0c             	sub    $0xc,%esp
80107ad3:	68 e4 86 10 80       	push   $0x801086e4
80107ad8:	e8 d3 8b ff ff       	call   801006b0 <cprintf>
    myproc()->killed = 1;
80107add:	e8 be c1 ff ff       	call   80103ca0 <myproc>
    return;
80107ae2:	83 c4 10             	add    $0x10,%esp
    myproc()->killed = 1;
80107ae5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
}
80107aec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107aef:	5b                   	pop    %ebx
80107af0:	5e                   	pop    %esi
80107af1:	5f                   	pop    %edi
80107af2:	5d                   	pop    %ebp
80107af3:	c3                   	ret    
80107af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("handlePageFault: page table entry for faulting address is not present.\n");
80107af8:	83 ec 0c             	sub    $0xc,%esp
80107afb:	68 9c 86 10 80       	push   $0x8010869c
80107b00:	e8 ab 8b ff ff       	call   801006b0 <cprintf>
    myproc()->killed = 1;
80107b05:	e8 96 c1 ff ff       	call   80103ca0 <myproc>
    return;
80107b0a:	83 c4 10             	add    $0x10,%esp
    myproc()->killed = 1;
80107b0d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
}
80107b14:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b17:	5b                   	pop    %ebx
80107b18:	5e                   	pop    %esi
80107b19:	5f                   	pop    %edi
80107b1a:	5d                   	pop    %ebp
80107b1b:	c3                   	ret    
80107b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if ((mem = kalloc()) == 0) {
80107b20:	e8 0b ab ff ff       	call   80102630 <kalloc>
80107b25:	89 c7                	mov    %eax,%edi
80107b27:	85 c0                	test   %eax,%eax
80107b29:	74 45                	je     80107b70 <handlePageFault+0x110>
    memmove(mem,(char*)P2V(pa),PGSIZE);
80107b2b:	83 ec 04             	sub    $0x4,%esp
80107b2e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107b34:	68 00 10 00 00       	push   $0x1000
80107b39:	50                   	push   %eax
80107b3a:	57                   	push   %edi
    *pte = (uint)P2V(mem) | PTE_P | PTE_U | PTE_W;
80107b3b:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107b41:	83 cf 07             	or     $0x7,%edi
    memmove(mem,(char*)P2V(pa),PGSIZE);
80107b44:	e8 97 d5 ff ff       	call   801050e0 <memmove>
    *pte = (uint)P2V(mem) | PTE_P | PTE_U | PTE_W;
80107b49:	89 3e                	mov    %edi,(%esi)
    decref(pa);
80107b4b:	89 1c 24             	mov    %ebx,(%esp)
80107b4e:	e8 fd ab ff ff       	call   80102750 <decref>
80107b53:	83 c4 10             	add    $0x10,%esp
80107b56:	e9 5c ff ff ff       	jmp    80107ab7 <handlePageFault+0x57>
80107b5b:	90                   	nop
80107b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *pte |= PTE_W;
80107b60:	83 0e 02             	orl    $0x2,(%esi)
80107b63:	e9 4f ff ff ff       	jmp    80107ab7 <handlePageFault+0x57>
80107b68:	90                   	nop
80107b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->killed = 1;
80107b70:	e8 2b c1 ff ff       	call   80103ca0 <myproc>
80107b75:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      return;
80107b7c:	e9 6b ff ff ff       	jmp    80107aec <handlePageFault+0x8c>
    panic("handlePageFault: page is already writable.\n");
80107b81:	83 ec 0c             	sub    $0xc,%esp
80107b84:	68 28 87 10 80       	push   $0x80108728
80107b89:	e8 02 88 ff ff       	call   80100390 <panic>
