
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
      11:	68 22 53 00 00       	push   $0x5322
      16:	6a 01                	push   $0x1
      18:	e8 c3 3e 00 00       	call   3ee0 <printf>

  copyOnWriteTest();
      1d:	e8 7e 2e 00 00       	call   2ea0 <copyOnWriteTest>
  schedulerTest();
      22:	e8 69 3a 00 00       	call   3a90 <schedulerTest>

  if(open("usertests.ran", 0) >= 0){
      27:	59                   	pop    %ecx
      28:	58                   	pop    %eax
      29:	6a 00                	push   $0x0
      2b:	68 36 53 00 00       	push   $0x5336
      30:	e8 6c 3d 00 00       	call   3da1 <open>
      35:	83 c4 10             	add    $0x10,%esp
      38:	85 c0                	test   %eax,%eax
      3a:	78 13                	js     4f <main+0x4f>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      3c:	52                   	push   %edx
      3d:	52                   	push   %edx
      3e:	68 88 5d 00 00       	push   $0x5d88
      43:	6a 01                	push   $0x1
      45:	e8 96 3e 00 00       	call   3ee0 <printf>
    exit();
      4a:	e8 12 3d 00 00       	call   3d61 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      4f:	50                   	push   %eax
      50:	50                   	push   %eax
      51:	68 00 02 00 00       	push   $0x200
      56:	68 36 53 00 00       	push   $0x5336
      5b:	e8 41 3d 00 00       	call   3da1 <open>
      60:	89 04 24             	mov    %eax,(%esp)
      63:	e8 21 3d 00 00       	call   3d89 <close>

  argptest();
      68:	e8 53 38 00 00       	call   38c0 <argptest>
  createdelete();
      6d:	e8 ae 11 00 00       	call   1220 <createdelete>
  linkunlink();
      72:	e8 69 1a 00 00       	call   1ae0 <linkunlink>
  concreate();
      77:	e8 64 17 00 00       	call   17e0 <concreate>
  fourfiles();
      7c:	e8 9f 0f 00 00       	call   1020 <fourfiles>
  sharedfd();
      81:	e8 da 0d 00 00       	call   e60 <sharedfd>

  bigargtest();
      86:	e8 f5 34 00 00       	call   3580 <bigargtest>
  bigwrite();
      8b:	e8 70 23 00 00       	call   2400 <bigwrite>
  bigargtest();
      90:	e8 eb 34 00 00       	call   3580 <bigargtest>
  bsstest();
      95:	e8 66 34 00 00       	call   3500 <bsstest>
  sbrktest();
      9a:	e8 71 2f 00 00       	call   3010 <sbrktest>
  validatetest();
      9f:	e8 ac 33 00 00       	call   3450 <validatetest>

  opentest();
      a4:	e8 57 03 00 00       	call   400 <opentest>
  writetest();
      a9:	e8 e2 03 00 00       	call   490 <writetest>
  writetest1();
      ae:	e8 bd 05 00 00       	call   670 <writetest1>
  createtest();
      b3:	e8 88 07 00 00       	call   840 <createtest>

  openiputtest();
      b8:	e8 43 02 00 00       	call   300 <openiputtest>
  exitiputtest();
      bd:	e8 3e 01 00 00       	call   200 <exitiputtest>
  iputtest();
      c2:	e8 59 00 00 00       	call   120 <iputtest>

  mem();
      c7:	e8 c4 0c 00 00       	call   d90 <mem>
  pipe1();
      cc:	e8 4f 09 00 00       	call   a20 <pipe1>
  preempt();
      d1:	e8 da 0a 00 00       	call   bb0 <preempt>
  exitwait();
      d6:	e8 35 0c 00 00       	call   d10 <exitwait>

  rmdot();
      db:	e8 10 27 00 00       	call   27f0 <rmdot>
  fourteen();
      e0:	e8 cb 25 00 00       	call   26b0 <fourteen>
  bigfile();
      e5:	e8 f6 23 00 00       	call   24e0 <bigfile>
  subdir();
      ea:	e8 31 1c 00 00       	call   1d20 <subdir>
  linktest();
      ef:	e8 dc 14 00 00       	call   15d0 <linktest>
  unlinkread();
      f4:	e8 47 13 00 00       	call   1440 <unlinkread>
  dirfile();
      f9:	e8 72 28 00 00       	call   2970 <dirfile>
  iref();
      fe:	e8 6d 2a 00 00       	call   2b70 <iref>
  forktest();
     103:	e8 58 2e 00 00       	call   2f60 <forktest>
  bigdir(); // slow
     108:	e8 e3 1a 00 00       	call   1bf0 <bigdir>

  uio();
     10d:	e8 3e 37 00 00       	call   3850 <uio>

  exectest();
     112:	e8 b9 08 00 00       	call   9d0 <exectest>

  exit();
     117:	e8 45 3c 00 00       	call   3d61 <exit>
     11c:	66 90                	xchg   %ax,%ax
     11e:	66 90                	xchg   %ax,%ax

00000120 <iputtest>:
{
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
     126:	68 dc 42 00 00       	push   $0x42dc
     12b:	ff 35 d4 67 00 00    	pushl  0x67d4
     131:	e8 aa 3d 00 00       	call   3ee0 <printf>
  if(mkdir("iputdir") < 0){
     136:	c7 04 24 6f 42 00 00 	movl   $0x426f,(%esp)
     13d:	e8 87 3c 00 00       	call   3dc9 <mkdir>
     142:	83 c4 10             	add    $0x10,%esp
     145:	85 c0                	test   %eax,%eax
     147:	78 58                	js     1a1 <iputtest+0x81>
  if(chdir("iputdir") < 0){
     149:	83 ec 0c             	sub    $0xc,%esp
     14c:	68 6f 42 00 00       	push   $0x426f
     151:	e8 7b 3c 00 00       	call   3dd1 <chdir>
     156:	83 c4 10             	add    $0x10,%esp
     159:	85 c0                	test   %eax,%eax
     15b:	0f 88 85 00 00 00    	js     1e6 <iputtest+0xc6>
  if(unlink("../iputdir") < 0){
     161:	83 ec 0c             	sub    $0xc,%esp
     164:	68 6c 42 00 00       	push   $0x426c
     169:	e8 43 3c 00 00       	call   3db1 <unlink>
     16e:	83 c4 10             	add    $0x10,%esp
     171:	85 c0                	test   %eax,%eax
     173:	78 5a                	js     1cf <iputtest+0xaf>
  if(chdir("/") < 0){
     175:	83 ec 0c             	sub    $0xc,%esp
     178:	68 91 42 00 00       	push   $0x4291
     17d:	e8 4f 3c 00 00       	call   3dd1 <chdir>
     182:	83 c4 10             	add    $0x10,%esp
     185:	85 c0                	test   %eax,%eax
     187:	78 2f                	js     1b8 <iputtest+0x98>
  printf(stdout, "iput test ok\n");
     189:	83 ec 08             	sub    $0x8,%esp
     18c:	68 14 43 00 00       	push   $0x4314
     191:	ff 35 d4 67 00 00    	pushl  0x67d4
     197:	e8 44 3d 00 00       	call   3ee0 <printf>
}
     19c:	83 c4 10             	add    $0x10,%esp
     19f:	c9                   	leave  
     1a0:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     1a1:	50                   	push   %eax
     1a2:	50                   	push   %eax
     1a3:	68 48 42 00 00       	push   $0x4248
     1a8:	ff 35 d4 67 00 00    	pushl  0x67d4
     1ae:	e8 2d 3d 00 00       	call   3ee0 <printf>
    exit();
     1b3:	e8 a9 3b 00 00       	call   3d61 <exit>
    printf(stdout, "chdir / failed\n");
     1b8:	50                   	push   %eax
     1b9:	50                   	push   %eax
     1ba:	68 93 42 00 00       	push   $0x4293
     1bf:	ff 35 d4 67 00 00    	pushl  0x67d4
     1c5:	e8 16 3d 00 00       	call   3ee0 <printf>
    exit();
     1ca:	e8 92 3b 00 00       	call   3d61 <exit>
    printf(stdout, "unlink ../iputdir failed\n");
     1cf:	52                   	push   %edx
     1d0:	52                   	push   %edx
     1d1:	68 77 42 00 00       	push   $0x4277
     1d6:	ff 35 d4 67 00 00    	pushl  0x67d4
     1dc:	e8 ff 3c 00 00       	call   3ee0 <printf>
    exit();
     1e1:	e8 7b 3b 00 00       	call   3d61 <exit>
    printf(stdout, "chdir iputdir failed\n");
     1e6:	51                   	push   %ecx
     1e7:	51                   	push   %ecx
     1e8:	68 56 42 00 00       	push   $0x4256
     1ed:	ff 35 d4 67 00 00    	pushl  0x67d4
     1f3:	e8 e8 3c 00 00       	call   3ee0 <printf>
    exit();
     1f8:	e8 64 3b 00 00       	call   3d61 <exit>
     1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <exitiputtest>:
{
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exitiput test\n");
     206:	68 a3 42 00 00       	push   $0x42a3
     20b:	ff 35 d4 67 00 00    	pushl  0x67d4
     211:	e8 ca 3c 00 00       	call   3ee0 <printf>
  pid = fork();
     216:	e8 3e 3b 00 00       	call   3d59 <fork>
  if(pid < 0){
     21b:	83 c4 10             	add    $0x10,%esp
     21e:	85 c0                	test   %eax,%eax
     220:	0f 88 8a 00 00 00    	js     2b0 <exitiputtest+0xb0>
  if(pid == 0){
     226:	75 50                	jne    278 <exitiputtest+0x78>
    if(mkdir("iputdir") < 0){
     228:	83 ec 0c             	sub    $0xc,%esp
     22b:	68 6f 42 00 00       	push   $0x426f
     230:	e8 94 3b 00 00       	call   3dc9 <mkdir>
     235:	83 c4 10             	add    $0x10,%esp
     238:	85 c0                	test   %eax,%eax
     23a:	0f 88 87 00 00 00    	js     2c7 <exitiputtest+0xc7>
    if(chdir("iputdir") < 0){
     240:	83 ec 0c             	sub    $0xc,%esp
     243:	68 6f 42 00 00       	push   $0x426f
     248:	e8 84 3b 00 00       	call   3dd1 <chdir>
     24d:	83 c4 10             	add    $0x10,%esp
     250:	85 c0                	test   %eax,%eax
     252:	0f 88 86 00 00 00    	js     2de <exitiputtest+0xde>
    if(unlink("../iputdir") < 0){
     258:	83 ec 0c             	sub    $0xc,%esp
     25b:	68 6c 42 00 00       	push   $0x426c
     260:	e8 4c 3b 00 00       	call   3db1 <unlink>
     265:	83 c4 10             	add    $0x10,%esp
     268:	85 c0                	test   %eax,%eax
     26a:	78 2c                	js     298 <exitiputtest+0x98>
    exit();
     26c:	e8 f0 3a 00 00       	call   3d61 <exit>
     271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  wait();
     278:	e8 ec 3a 00 00       	call   3d69 <wait>
  printf(stdout, "exitiput test ok\n");
     27d:	83 ec 08             	sub    $0x8,%esp
     280:	68 c6 42 00 00       	push   $0x42c6
     285:	ff 35 d4 67 00 00    	pushl  0x67d4
     28b:	e8 50 3c 00 00       	call   3ee0 <printf>
}
     290:	83 c4 10             	add    $0x10,%esp
     293:	c9                   	leave  
     294:	c3                   	ret    
     295:	8d 76 00             	lea    0x0(%esi),%esi
      printf(stdout, "unlink ../iputdir failed\n");
     298:	83 ec 08             	sub    $0x8,%esp
     29b:	68 77 42 00 00       	push   $0x4277
     2a0:	ff 35 d4 67 00 00    	pushl  0x67d4
     2a6:	e8 35 3c 00 00       	call   3ee0 <printf>
      exit();
     2ab:	e8 b1 3a 00 00       	call   3d61 <exit>
    printf(stdout, "fork failed\n");
     2b0:	51                   	push   %ecx
     2b1:	51                   	push   %ecx
     2b2:	68 42 52 00 00       	push   $0x5242
     2b7:	ff 35 d4 67 00 00    	pushl  0x67d4
     2bd:	e8 1e 3c 00 00       	call   3ee0 <printf>
    exit();
     2c2:	e8 9a 3a 00 00       	call   3d61 <exit>
      printf(stdout, "mkdir failed\n");
     2c7:	52                   	push   %edx
     2c8:	52                   	push   %edx
     2c9:	68 48 42 00 00       	push   $0x4248
     2ce:	ff 35 d4 67 00 00    	pushl  0x67d4
     2d4:	e8 07 3c 00 00       	call   3ee0 <printf>
      exit();
     2d9:	e8 83 3a 00 00       	call   3d61 <exit>
      printf(stdout, "child chdir failed\n");
     2de:	50                   	push   %eax
     2df:	50                   	push   %eax
     2e0:	68 b2 42 00 00       	push   $0x42b2
     2e5:	ff 35 d4 67 00 00    	pushl  0x67d4
     2eb:	e8 f0 3b 00 00       	call   3ee0 <printf>
      exit();
     2f0:	e8 6c 3a 00 00       	call   3d61 <exit>
     2f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000300 <openiputtest>:
{
     300:	55                   	push   %ebp
     301:	89 e5                	mov    %esp,%ebp
     303:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "openiput test\n");
     306:	68 d8 42 00 00       	push   $0x42d8
     30b:	ff 35 d4 67 00 00    	pushl  0x67d4
     311:	e8 ca 3b 00 00       	call   3ee0 <printf>
  if(mkdir("oidir") < 0){
     316:	c7 04 24 e7 42 00 00 	movl   $0x42e7,(%esp)
     31d:	e8 a7 3a 00 00       	call   3dc9 <mkdir>
     322:	83 c4 10             	add    $0x10,%esp
     325:	85 c0                	test   %eax,%eax
     327:	0f 88 9f 00 00 00    	js     3cc <openiputtest+0xcc>
  pid = fork();
     32d:	e8 27 3a 00 00       	call   3d59 <fork>
  if(pid < 0){
     332:	85 c0                	test   %eax,%eax
     334:	78 7f                	js     3b5 <openiputtest+0xb5>
  if(pid == 0){
     336:	75 38                	jne    370 <openiputtest+0x70>
    int fd = open("oidir", O_RDWR);
     338:	83 ec 08             	sub    $0x8,%esp
     33b:	6a 02                	push   $0x2
     33d:	68 e7 42 00 00       	push   $0x42e7
     342:	e8 5a 3a 00 00       	call   3da1 <open>
    if(fd >= 0){
     347:	83 c4 10             	add    $0x10,%esp
     34a:	85 c0                	test   %eax,%eax
     34c:	78 62                	js     3b0 <openiputtest+0xb0>
      printf(stdout, "open directory for write succeeded\n");
     34e:	83 ec 08             	sub    $0x8,%esp
     351:	68 58 53 00 00       	push   $0x5358
     356:	ff 35 d4 67 00 00    	pushl  0x67d4
     35c:	e8 7f 3b 00 00       	call   3ee0 <printf>
      exit();
     361:	e8 fb 39 00 00       	call   3d61 <exit>
     366:	8d 76 00             	lea    0x0(%esi),%esi
     369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  sleep(1);
     370:	83 ec 0c             	sub    $0xc,%esp
     373:	6a 01                	push   $0x1
     375:	e8 77 3a 00 00       	call   3df1 <sleep>
  if(unlink("oidir") != 0){
     37a:	c7 04 24 e7 42 00 00 	movl   $0x42e7,(%esp)
     381:	e8 2b 3a 00 00       	call   3db1 <unlink>
     386:	83 c4 10             	add    $0x10,%esp
     389:	85 c0                	test   %eax,%eax
     38b:	75 56                	jne    3e3 <openiputtest+0xe3>
  wait();
     38d:	e8 d7 39 00 00       	call   3d69 <wait>
  printf(stdout, "openiput test ok\n");
     392:	83 ec 08             	sub    $0x8,%esp
     395:	68 10 43 00 00       	push   $0x4310
     39a:	ff 35 d4 67 00 00    	pushl  0x67d4
     3a0:	e8 3b 3b 00 00       	call   3ee0 <printf>
     3a5:	83 c4 10             	add    $0x10,%esp
}
     3a8:	c9                   	leave  
     3a9:	c3                   	ret    
     3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
     3b0:	e8 ac 39 00 00       	call   3d61 <exit>
    printf(stdout, "fork failed\n");
     3b5:	52                   	push   %edx
     3b6:	52                   	push   %edx
     3b7:	68 42 52 00 00       	push   $0x5242
     3bc:	ff 35 d4 67 00 00    	pushl  0x67d4
     3c2:	e8 19 3b 00 00       	call   3ee0 <printf>
    exit();
     3c7:	e8 95 39 00 00       	call   3d61 <exit>
    printf(stdout, "mkdir oidir failed\n");
     3cc:	51                   	push   %ecx
     3cd:	51                   	push   %ecx
     3ce:	68 ed 42 00 00       	push   $0x42ed
     3d3:	ff 35 d4 67 00 00    	pushl  0x67d4
     3d9:	e8 02 3b 00 00       	call   3ee0 <printf>
    exit();
     3de:	e8 7e 39 00 00       	call   3d61 <exit>
    printf(stdout, "unlink failed\n");
     3e3:	50                   	push   %eax
     3e4:	50                   	push   %eax
     3e5:	68 01 43 00 00       	push   $0x4301
     3ea:	ff 35 d4 67 00 00    	pushl  0x67d4
     3f0:	e8 eb 3a 00 00       	call   3ee0 <printf>
    exit();
     3f5:	e8 67 39 00 00       	call   3d61 <exit>
     3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000400 <opentest>:
{
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "open test\n");
     406:	68 22 43 00 00       	push   $0x4322
     40b:	ff 35 d4 67 00 00    	pushl  0x67d4
     411:	e8 ca 3a 00 00       	call   3ee0 <printf>
  fd = open("echo", 0);
     416:	58                   	pop    %eax
     417:	5a                   	pop    %edx
     418:	6a 00                	push   $0x0
     41a:	68 2d 43 00 00       	push   $0x432d
     41f:	e8 7d 39 00 00       	call   3da1 <open>
  if(fd < 0){
     424:	83 c4 10             	add    $0x10,%esp
     427:	85 c0                	test   %eax,%eax
     429:	78 36                	js     461 <opentest+0x61>
  close(fd);
     42b:	83 ec 0c             	sub    $0xc,%esp
     42e:	50                   	push   %eax
     42f:	e8 55 39 00 00       	call   3d89 <close>
  fd = open("doesnotexist", 0);
     434:	5a                   	pop    %edx
     435:	59                   	pop    %ecx
     436:	6a 00                	push   $0x0
     438:	68 45 43 00 00       	push   $0x4345
     43d:	e8 5f 39 00 00       	call   3da1 <open>
  if(fd >= 0){
     442:	83 c4 10             	add    $0x10,%esp
     445:	85 c0                	test   %eax,%eax
     447:	79 2f                	jns    478 <opentest+0x78>
  printf(stdout, "open test ok\n");
     449:	83 ec 08             	sub    $0x8,%esp
     44c:	68 70 43 00 00       	push   $0x4370
     451:	ff 35 d4 67 00 00    	pushl  0x67d4
     457:	e8 84 3a 00 00       	call   3ee0 <printf>
}
     45c:	83 c4 10             	add    $0x10,%esp
     45f:	c9                   	leave  
     460:	c3                   	ret    
    printf(stdout, "open echo failed!\n");
     461:	50                   	push   %eax
     462:	50                   	push   %eax
     463:	68 32 43 00 00       	push   $0x4332
     468:	ff 35 d4 67 00 00    	pushl  0x67d4
     46e:	e8 6d 3a 00 00       	call   3ee0 <printf>
    exit();
     473:	e8 e9 38 00 00       	call   3d61 <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     478:	50                   	push   %eax
     479:	50                   	push   %eax
     47a:	68 52 43 00 00       	push   $0x4352
     47f:	ff 35 d4 67 00 00    	pushl  0x67d4
     485:	e8 56 3a 00 00       	call   3ee0 <printf>
    exit();
     48a:	e8 d2 38 00 00       	call   3d61 <exit>
     48f:	90                   	nop

00000490 <writetest>:
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	56                   	push   %esi
     494:	53                   	push   %ebx
  printf(stdout, "small file test\n");
     495:	83 ec 08             	sub    $0x8,%esp
     498:	68 7e 43 00 00       	push   $0x437e
     49d:	ff 35 d4 67 00 00    	pushl  0x67d4
     4a3:	e8 38 3a 00 00       	call   3ee0 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     4a8:	58                   	pop    %eax
     4a9:	5a                   	pop    %edx
     4aa:	68 02 02 00 00       	push   $0x202
     4af:	68 8f 43 00 00       	push   $0x438f
     4b4:	e8 e8 38 00 00       	call   3da1 <open>
  if(fd >= 0){
     4b9:	83 c4 10             	add    $0x10,%esp
     4bc:	85 c0                	test   %eax,%eax
     4be:	0f 88 88 01 00 00    	js     64c <writetest+0x1bc>
    printf(stdout, "creat small succeeded; ok\n");
     4c4:	83 ec 08             	sub    $0x8,%esp
     4c7:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 100; i++){
     4c9:	31 db                	xor    %ebx,%ebx
    printf(stdout, "creat small succeeded; ok\n");
     4cb:	68 95 43 00 00       	push   $0x4395
     4d0:	ff 35 d4 67 00 00    	pushl  0x67d4
     4d6:	e8 05 3a 00 00       	call   3ee0 <printf>
     4db:	83 c4 10             	add    $0x10,%esp
     4de:	66 90                	xchg   %ax,%ax
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4e0:	83 ec 04             	sub    $0x4,%esp
     4e3:	6a 0a                	push   $0xa
     4e5:	68 cc 43 00 00       	push   $0x43cc
     4ea:	56                   	push   %esi
     4eb:	e8 91 38 00 00       	call   3d81 <write>
     4f0:	83 c4 10             	add    $0x10,%esp
     4f3:	83 f8 0a             	cmp    $0xa,%eax
     4f6:	0f 85 d9 00 00 00    	jne    5d5 <writetest+0x145>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4fc:	83 ec 04             	sub    $0x4,%esp
     4ff:	6a 0a                	push   $0xa
     501:	68 d7 43 00 00       	push   $0x43d7
     506:	56                   	push   %esi
     507:	e8 75 38 00 00       	call   3d81 <write>
     50c:	83 c4 10             	add    $0x10,%esp
     50f:	83 f8 0a             	cmp    $0xa,%eax
     512:	0f 85 d6 00 00 00    	jne    5ee <writetest+0x15e>
  for(i = 0; i < 100; i++){
     518:	83 c3 01             	add    $0x1,%ebx
     51b:	83 fb 64             	cmp    $0x64,%ebx
     51e:	75 c0                	jne    4e0 <writetest+0x50>
  printf(stdout, "writes ok\n");
     520:	83 ec 08             	sub    $0x8,%esp
     523:	68 e2 43 00 00       	push   $0x43e2
     528:	ff 35 d4 67 00 00    	pushl  0x67d4
     52e:	e8 ad 39 00 00       	call   3ee0 <printf>
  close(fd);
     533:	89 34 24             	mov    %esi,(%esp)
     536:	e8 4e 38 00 00       	call   3d89 <close>
  fd = open("small", O_RDONLY);
     53b:	5b                   	pop    %ebx
     53c:	5e                   	pop    %esi
     53d:	6a 00                	push   $0x0
     53f:	68 8f 43 00 00       	push   $0x438f
     544:	e8 58 38 00 00       	call   3da1 <open>
  if(fd >= 0){
     549:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     54c:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     54e:	85 c0                	test   %eax,%eax
     550:	0f 88 b1 00 00 00    	js     607 <writetest+0x177>
    printf(stdout, "open small succeeded ok\n");
     556:	83 ec 08             	sub    $0x8,%esp
     559:	68 ed 43 00 00       	push   $0x43ed
     55e:	ff 35 d4 67 00 00    	pushl  0x67d4
     564:	e8 77 39 00 00       	call   3ee0 <printf>
  i = read(fd, buf, 2000);
     569:	83 c4 0c             	add    $0xc,%esp
     56c:	68 d0 07 00 00       	push   $0x7d0
     571:	68 e0 5f 01 00       	push   $0x15fe0
     576:	53                   	push   %ebx
     577:	e8 fd 37 00 00       	call   3d79 <read>
  if(i == 2000){
     57c:	83 c4 10             	add    $0x10,%esp
     57f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     584:	0f 85 94 00 00 00    	jne    61e <writetest+0x18e>
    printf(stdout, "read succeeded ok\n");
     58a:	83 ec 08             	sub    $0x8,%esp
     58d:	68 21 44 00 00       	push   $0x4421
     592:	ff 35 d4 67 00 00    	pushl  0x67d4
     598:	e8 43 39 00 00       	call   3ee0 <printf>
  close(fd);
     59d:	89 1c 24             	mov    %ebx,(%esp)
     5a0:	e8 e4 37 00 00       	call   3d89 <close>
  if(unlink("small") < 0){
     5a5:	c7 04 24 8f 43 00 00 	movl   $0x438f,(%esp)
     5ac:	e8 00 38 00 00       	call   3db1 <unlink>
     5b1:	83 c4 10             	add    $0x10,%esp
     5b4:	85 c0                	test   %eax,%eax
     5b6:	78 7d                	js     635 <writetest+0x1a5>
  printf(stdout, "small file test ok\n");
     5b8:	83 ec 08             	sub    $0x8,%esp
     5bb:	68 49 44 00 00       	push   $0x4449
     5c0:	ff 35 d4 67 00 00    	pushl  0x67d4
     5c6:	e8 15 39 00 00       	call   3ee0 <printf>
}
     5cb:	83 c4 10             	add    $0x10,%esp
     5ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5d1:	5b                   	pop    %ebx
     5d2:	5e                   	pop    %esi
     5d3:	5d                   	pop    %ebp
     5d4:	c3                   	ret    
      printf(stdout, "error: write aa %d new file failed\n", i);
     5d5:	83 ec 04             	sub    $0x4,%esp
     5d8:	53                   	push   %ebx
     5d9:	68 7c 53 00 00       	push   $0x537c
     5de:	ff 35 d4 67 00 00    	pushl  0x67d4
     5e4:	e8 f7 38 00 00       	call   3ee0 <printf>
      exit();
     5e9:	e8 73 37 00 00       	call   3d61 <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     5ee:	83 ec 04             	sub    $0x4,%esp
     5f1:	53                   	push   %ebx
     5f2:	68 a0 53 00 00       	push   $0x53a0
     5f7:	ff 35 d4 67 00 00    	pushl  0x67d4
     5fd:	e8 de 38 00 00       	call   3ee0 <printf>
      exit();
     602:	e8 5a 37 00 00       	call   3d61 <exit>
    printf(stdout, "error: open small failed!\n");
     607:	51                   	push   %ecx
     608:	51                   	push   %ecx
     609:	68 06 44 00 00       	push   $0x4406
     60e:	ff 35 d4 67 00 00    	pushl  0x67d4
     614:	e8 c7 38 00 00       	call   3ee0 <printf>
    exit();
     619:	e8 43 37 00 00       	call   3d61 <exit>
    printf(stdout, "read failed\n");
     61e:	52                   	push   %edx
     61f:	52                   	push   %edx
     620:	68 4d 47 00 00       	push   $0x474d
     625:	ff 35 d4 67 00 00    	pushl  0x67d4
     62b:	e8 b0 38 00 00       	call   3ee0 <printf>
    exit();
     630:	e8 2c 37 00 00       	call   3d61 <exit>
    printf(stdout, "unlink small failed\n");
     635:	50                   	push   %eax
     636:	50                   	push   %eax
     637:	68 34 44 00 00       	push   $0x4434
     63c:	ff 35 d4 67 00 00    	pushl  0x67d4
     642:	e8 99 38 00 00       	call   3ee0 <printf>
    exit();
     647:	e8 15 37 00 00       	call   3d61 <exit>
    printf(stdout, "error: creat small failed!\n");
     64c:	50                   	push   %eax
     64d:	50                   	push   %eax
     64e:	68 b0 43 00 00       	push   $0x43b0
     653:	ff 35 d4 67 00 00    	pushl  0x67d4
     659:	e8 82 38 00 00       	call   3ee0 <printf>
    exit();
     65e:	e8 fe 36 00 00       	call   3d61 <exit>
     663:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000670 <writetest1>:
{
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	56                   	push   %esi
     674:	53                   	push   %ebx
  printf(stdout, "big files test\n");
     675:	83 ec 08             	sub    $0x8,%esp
     678:	68 5d 44 00 00       	push   $0x445d
     67d:	ff 35 d4 67 00 00    	pushl  0x67d4
     683:	e8 58 38 00 00       	call   3ee0 <printf>
  fd = open("big", O_CREATE|O_RDWR);
     688:	58                   	pop    %eax
     689:	5a                   	pop    %edx
     68a:	68 02 02 00 00       	push   $0x202
     68f:	68 d7 44 00 00       	push   $0x44d7
     694:	e8 08 37 00 00       	call   3da1 <open>
  if(fd < 0){
     699:	83 c4 10             	add    $0x10,%esp
     69c:	85 c0                	test   %eax,%eax
     69e:	0f 88 61 01 00 00    	js     805 <writetest1+0x195>
     6a4:	89 c6                	mov    %eax,%esi
  for(i = 0; i < MAXFILE; i++){
     6a6:	31 db                	xor    %ebx,%ebx
     6a8:	90                   	nop
     6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(write(fd, buf, 512) != 512){
     6b0:	83 ec 04             	sub    $0x4,%esp
    ((int*)buf)[0] = i;
     6b3:	89 1d e0 5f 01 00    	mov    %ebx,0x15fe0
    if(write(fd, buf, 512) != 512){
     6b9:	68 00 02 00 00       	push   $0x200
     6be:	68 e0 5f 01 00       	push   $0x15fe0
     6c3:	56                   	push   %esi
     6c4:	e8 b8 36 00 00       	call   3d81 <write>
     6c9:	83 c4 10             	add    $0x10,%esp
     6cc:	3d 00 02 00 00       	cmp    $0x200,%eax
     6d1:	0f 85 b3 00 00 00    	jne    78a <writetest1+0x11a>
  for(i = 0; i < MAXFILE; i++){
     6d7:	83 c3 01             	add    $0x1,%ebx
     6da:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6e0:	75 ce                	jne    6b0 <writetest1+0x40>
  close(fd);
     6e2:	83 ec 0c             	sub    $0xc,%esp
     6e5:	56                   	push   %esi
     6e6:	e8 9e 36 00 00       	call   3d89 <close>
  fd = open("big", O_RDONLY);
     6eb:	5b                   	pop    %ebx
     6ec:	5e                   	pop    %esi
     6ed:	6a 00                	push   $0x0
     6ef:	68 d7 44 00 00       	push   $0x44d7
     6f4:	e8 a8 36 00 00       	call   3da1 <open>
  if(fd < 0){
     6f9:	83 c4 10             	add    $0x10,%esp
  fd = open("big", O_RDONLY);
     6fc:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     6fe:	85 c0                	test   %eax,%eax
     700:	0f 88 e8 00 00 00    	js     7ee <writetest1+0x17e>
  n = 0;
     706:	31 db                	xor    %ebx,%ebx
     708:	eb 1d                	jmp    727 <writetest1+0xb7>
     70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(i != 512){
     710:	3d 00 02 00 00       	cmp    $0x200,%eax
     715:	0f 85 9f 00 00 00    	jne    7ba <writetest1+0x14a>
    if(((int*)buf)[0] != n){
     71b:	a1 e0 5f 01 00       	mov    0x15fe0,%eax
     720:	39 d8                	cmp    %ebx,%eax
     722:	75 7f                	jne    7a3 <writetest1+0x133>
    n++;
     724:	83 c3 01             	add    $0x1,%ebx
    i = read(fd, buf, 512);
     727:	83 ec 04             	sub    $0x4,%esp
     72a:	68 00 02 00 00       	push   $0x200
     72f:	68 e0 5f 01 00       	push   $0x15fe0
     734:	56                   	push   %esi
     735:	e8 3f 36 00 00       	call   3d79 <read>
    if(i == 0){
     73a:	83 c4 10             	add    $0x10,%esp
     73d:	85 c0                	test   %eax,%eax
     73f:	75 cf                	jne    710 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     741:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     747:	0f 84 86 00 00 00    	je     7d3 <writetest1+0x163>
  close(fd);
     74d:	83 ec 0c             	sub    $0xc,%esp
     750:	56                   	push   %esi
     751:	e8 33 36 00 00       	call   3d89 <close>
  if(unlink("big") < 0){
     756:	c7 04 24 d7 44 00 00 	movl   $0x44d7,(%esp)
     75d:	e8 4f 36 00 00       	call   3db1 <unlink>
     762:	83 c4 10             	add    $0x10,%esp
     765:	85 c0                	test   %eax,%eax
     767:	0f 88 af 00 00 00    	js     81c <writetest1+0x1ac>
  printf(stdout, "big files ok\n");
     76d:	83 ec 08             	sub    $0x8,%esp
     770:	68 fe 44 00 00       	push   $0x44fe
     775:	ff 35 d4 67 00 00    	pushl  0x67d4
     77b:	e8 60 37 00 00       	call   3ee0 <printf>
}
     780:	83 c4 10             	add    $0x10,%esp
     783:	8d 65 f8             	lea    -0x8(%ebp),%esp
     786:	5b                   	pop    %ebx
     787:	5e                   	pop    %esi
     788:	5d                   	pop    %ebp
     789:	c3                   	ret    
      printf(stdout, "error: write big file failed\n", i);
     78a:	83 ec 04             	sub    $0x4,%esp
     78d:	53                   	push   %ebx
     78e:	68 87 44 00 00       	push   $0x4487
     793:	ff 35 d4 67 00 00    	pushl  0x67d4
     799:	e8 42 37 00 00       	call   3ee0 <printf>
      exit();
     79e:	e8 be 35 00 00       	call   3d61 <exit>
      printf(stdout, "read content of block %d is %d\n",
     7a3:	50                   	push   %eax
     7a4:	53                   	push   %ebx
     7a5:	68 c4 53 00 00       	push   $0x53c4
     7aa:	ff 35 d4 67 00 00    	pushl  0x67d4
     7b0:	e8 2b 37 00 00       	call   3ee0 <printf>
      exit();
     7b5:	e8 a7 35 00 00       	call   3d61 <exit>
      printf(stdout, "read failed %d\n", i);
     7ba:	83 ec 04             	sub    $0x4,%esp
     7bd:	50                   	push   %eax
     7be:	68 db 44 00 00       	push   $0x44db
     7c3:	ff 35 d4 67 00 00    	pushl  0x67d4
     7c9:	e8 12 37 00 00       	call   3ee0 <printf>
      exit();
     7ce:	e8 8e 35 00 00       	call   3d61 <exit>
        printf(stdout, "read only %d blocks from big", n);
     7d3:	52                   	push   %edx
     7d4:	68 8b 00 00 00       	push   $0x8b
     7d9:	68 be 44 00 00       	push   $0x44be
     7de:	ff 35 d4 67 00 00    	pushl  0x67d4
     7e4:	e8 f7 36 00 00       	call   3ee0 <printf>
        exit();
     7e9:	e8 73 35 00 00       	call   3d61 <exit>
    printf(stdout, "error: open big failed!\n");
     7ee:	51                   	push   %ecx
     7ef:	51                   	push   %ecx
     7f0:	68 a5 44 00 00       	push   $0x44a5
     7f5:	ff 35 d4 67 00 00    	pushl  0x67d4
     7fb:	e8 e0 36 00 00       	call   3ee0 <printf>
    exit();
     800:	e8 5c 35 00 00       	call   3d61 <exit>
    printf(stdout, "error: creat big failed!\n");
     805:	50                   	push   %eax
     806:	50                   	push   %eax
     807:	68 6d 44 00 00       	push   $0x446d
     80c:	ff 35 d4 67 00 00    	pushl  0x67d4
     812:	e8 c9 36 00 00       	call   3ee0 <printf>
    exit();
     817:	e8 45 35 00 00       	call   3d61 <exit>
    printf(stdout, "unlink big failed\n");
     81c:	50                   	push   %eax
     81d:	50                   	push   %eax
     81e:	68 eb 44 00 00       	push   $0x44eb
     823:	ff 35 d4 67 00 00    	pushl  0x67d4
     829:	e8 b2 36 00 00       	call   3ee0 <printf>
    exit();
     82e:	e8 2e 35 00 00       	call   3d61 <exit>
     833:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000840 <createtest>:
{
     840:	55                   	push   %ebp
     841:	89 e5                	mov    %esp,%ebp
     843:	53                   	push   %ebx
  name[2] = '\0';
     844:	bb 30 00 00 00       	mov    $0x30,%ebx
{
     849:	83 ec 0c             	sub    $0xc,%esp
  printf(stdout, "many creates, followed by unlink test\n");
     84c:	68 e4 53 00 00       	push   $0x53e4
     851:	ff 35 d4 67 00 00    	pushl  0x67d4
     857:	e8 84 36 00 00       	call   3ee0 <printf>
  name[0] = 'a';
     85c:	c6 05 e0 7f 01 00 61 	movb   $0x61,0x17fe0
  name[2] = '\0';
     863:	83 c4 10             	add    $0x10,%esp
     866:	c6 05 e2 7f 01 00 00 	movb   $0x0,0x17fe2
     86d:	8d 76 00             	lea    0x0(%esi),%esi
    fd = open(name, O_CREATE|O_RDWR);
     870:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + i;
     873:	88 1d e1 7f 01 00    	mov    %bl,0x17fe1
    fd = open(name, O_CREATE|O_RDWR);
     879:	83 c3 01             	add    $0x1,%ebx
     87c:	68 02 02 00 00       	push   $0x202
     881:	68 e0 7f 01 00       	push   $0x17fe0
     886:	e8 16 35 00 00       	call   3da1 <open>
    close(fd);
     88b:	89 04 24             	mov    %eax,(%esp)
     88e:	e8 f6 34 00 00       	call   3d89 <close>
  for(i = 0; i < 52; i++){
     893:	83 c4 10             	add    $0x10,%esp
     896:	80 fb 64             	cmp    $0x64,%bl
     899:	75 d5                	jne    870 <createtest+0x30>
  name[0] = 'a';
     89b:	c6 05 e0 7f 01 00 61 	movb   $0x61,0x17fe0
  name[2] = '\0';
     8a2:	bb 30 00 00 00       	mov    $0x30,%ebx
     8a7:	c6 05 e2 7f 01 00 00 	movb   $0x0,0x17fe2
     8ae:	66 90                	xchg   %ax,%ax
    unlink(name);
     8b0:	83 ec 0c             	sub    $0xc,%esp
    name[1] = '0' + i;
     8b3:	88 1d e1 7f 01 00    	mov    %bl,0x17fe1
    unlink(name);
     8b9:	83 c3 01             	add    $0x1,%ebx
     8bc:	68 e0 7f 01 00       	push   $0x17fe0
     8c1:	e8 eb 34 00 00       	call   3db1 <unlink>
  for(i = 0; i < 52; i++){
     8c6:	83 c4 10             	add    $0x10,%esp
     8c9:	80 fb 64             	cmp    $0x64,%bl
     8cc:	75 e2                	jne    8b0 <createtest+0x70>
  printf(stdout, "many creates, followed by unlink; ok\n");
     8ce:	83 ec 08             	sub    $0x8,%esp
     8d1:	68 0c 54 00 00       	push   $0x540c
     8d6:	ff 35 d4 67 00 00    	pushl  0x67d4
     8dc:	e8 ff 35 00 00       	call   3ee0 <printf>
}
     8e1:	83 c4 10             	add    $0x10,%esp
     8e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8e7:	c9                   	leave  
     8e8:	c3                   	ret    
     8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008f0 <dirtest>:
{
     8f0:	55                   	push   %ebp
     8f1:	89 e5                	mov    %esp,%ebp
     8f3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     8f6:	68 0c 45 00 00       	push   $0x450c
     8fb:	ff 35 d4 67 00 00    	pushl  0x67d4
     901:	e8 da 35 00 00       	call   3ee0 <printf>
  if(mkdir("dir0") < 0){
     906:	c7 04 24 18 45 00 00 	movl   $0x4518,(%esp)
     90d:	e8 b7 34 00 00       	call   3dc9 <mkdir>
     912:	83 c4 10             	add    $0x10,%esp
     915:	85 c0                	test   %eax,%eax
     917:	78 58                	js     971 <dirtest+0x81>
  if(chdir("dir0") < 0){
     919:	83 ec 0c             	sub    $0xc,%esp
     91c:	68 18 45 00 00       	push   $0x4518
     921:	e8 ab 34 00 00       	call   3dd1 <chdir>
     926:	83 c4 10             	add    $0x10,%esp
     929:	85 c0                	test   %eax,%eax
     92b:	0f 88 85 00 00 00    	js     9b6 <dirtest+0xc6>
  if(chdir("..") < 0){
     931:	83 ec 0c             	sub    $0xc,%esp
     934:	68 bd 4a 00 00       	push   $0x4abd
     939:	e8 93 34 00 00       	call   3dd1 <chdir>
     93e:	83 c4 10             	add    $0x10,%esp
     941:	85 c0                	test   %eax,%eax
     943:	78 5a                	js     99f <dirtest+0xaf>
  if(unlink("dir0") < 0){
     945:	83 ec 0c             	sub    $0xc,%esp
     948:	68 18 45 00 00       	push   $0x4518
     94d:	e8 5f 34 00 00       	call   3db1 <unlink>
     952:	83 c4 10             	add    $0x10,%esp
     955:	85 c0                	test   %eax,%eax
     957:	78 2f                	js     988 <dirtest+0x98>
  printf(stdout, "mkdir test ok\n");
     959:	83 ec 08             	sub    $0x8,%esp
     95c:	68 55 45 00 00       	push   $0x4555
     961:	ff 35 d4 67 00 00    	pushl  0x67d4
     967:	e8 74 35 00 00       	call   3ee0 <printf>
}
     96c:	83 c4 10             	add    $0x10,%esp
     96f:	c9                   	leave  
     970:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     971:	50                   	push   %eax
     972:	50                   	push   %eax
     973:	68 48 42 00 00       	push   $0x4248
     978:	ff 35 d4 67 00 00    	pushl  0x67d4
     97e:	e8 5d 35 00 00       	call   3ee0 <printf>
    exit();
     983:	e8 d9 33 00 00       	call   3d61 <exit>
    printf(stdout, "unlink dir0 failed\n");
     988:	50                   	push   %eax
     989:	50                   	push   %eax
     98a:	68 41 45 00 00       	push   $0x4541
     98f:	ff 35 d4 67 00 00    	pushl  0x67d4
     995:	e8 46 35 00 00       	call   3ee0 <printf>
    exit();
     99a:	e8 c2 33 00 00       	call   3d61 <exit>
    printf(stdout, "chdir .. failed\n");
     99f:	52                   	push   %edx
     9a0:	52                   	push   %edx
     9a1:	68 30 45 00 00       	push   $0x4530
     9a6:	ff 35 d4 67 00 00    	pushl  0x67d4
     9ac:	e8 2f 35 00 00       	call   3ee0 <printf>
    exit();
     9b1:	e8 ab 33 00 00       	call   3d61 <exit>
    printf(stdout, "chdir dir0 failed\n");
     9b6:	51                   	push   %ecx
     9b7:	51                   	push   %ecx
     9b8:	68 1d 45 00 00       	push   $0x451d
     9bd:	ff 35 d4 67 00 00    	pushl  0x67d4
     9c3:	e8 18 35 00 00       	call   3ee0 <printf>
    exit();
     9c8:	e8 94 33 00 00       	call   3d61 <exit>
     9cd:	8d 76 00             	lea    0x0(%esi),%esi

000009d0 <exectest>:
{
     9d0:	55                   	push   %ebp
     9d1:	89 e5                	mov    %esp,%ebp
     9d3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     9d6:	68 64 45 00 00       	push   $0x4564
     9db:	ff 35 d4 67 00 00    	pushl  0x67d4
     9e1:	e8 fa 34 00 00       	call   3ee0 <printf>
  if(exec("echo", echoargv) < 0){
     9e6:	5a                   	pop    %edx
     9e7:	59                   	pop    %ecx
     9e8:	68 d8 67 00 00       	push   $0x67d8
     9ed:	68 2d 43 00 00       	push   $0x432d
     9f2:	e8 a2 33 00 00       	call   3d99 <exec>
     9f7:	83 c4 10             	add    $0x10,%esp
     9fa:	85 c0                	test   %eax,%eax
     9fc:	78 02                	js     a00 <exectest+0x30>
}
     9fe:	c9                   	leave  
     9ff:	c3                   	ret    
    printf(stdout, "exec echo failed\n");
     a00:	50                   	push   %eax
     a01:	50                   	push   %eax
     a02:	68 6f 45 00 00       	push   $0x456f
     a07:	ff 35 d4 67 00 00    	pushl  0x67d4
     a0d:	e8 ce 34 00 00       	call   3ee0 <printf>
    exit();
     a12:	e8 4a 33 00 00       	call   3d61 <exit>
     a17:	89 f6                	mov    %esi,%esi
     a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a20 <pipe1>:
{
     a20:	55                   	push   %ebp
     a21:	89 e5                	mov    %esp,%ebp
     a23:	57                   	push   %edi
     a24:	56                   	push   %esi
  if(pipe(fds) != 0){
     a25:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
     a28:	53                   	push   %ebx
     a29:	83 ec 38             	sub    $0x38,%esp
  if(pipe(fds) != 0){
     a2c:	50                   	push   %eax
     a2d:	e8 3f 33 00 00       	call   3d71 <pipe>
     a32:	83 c4 10             	add    $0x10,%esp
     a35:	85 c0                	test   %eax,%eax
     a37:	0f 85 34 01 00 00    	jne    b71 <pipe1+0x151>
  pid = fork();
     a3d:	e8 17 33 00 00       	call   3d59 <fork>
  if(pid == 0){
     a42:	85 c0                	test   %eax,%eax
     a44:	0f 84 89 00 00 00    	je     ad3 <pipe1+0xb3>
  } else if(pid > 0){
     a4a:	0f 8e 34 01 00 00    	jle    b84 <pipe1+0x164>
    close(fds[1]);
     a50:	83 ec 0c             	sub    $0xc,%esp
     a53:	ff 75 e4             	pushl  -0x1c(%ebp)
  seq = 0;
     a56:	31 db                	xor    %ebx,%ebx
    cc = 1;
     a58:	bf 01 00 00 00       	mov    $0x1,%edi
    close(fds[1]);
     a5d:	e8 27 33 00 00       	call   3d89 <close>
    total = 0;
     a62:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     a69:	83 c4 10             	add    $0x10,%esp
     a6c:	83 ec 04             	sub    $0x4,%esp
     a6f:	57                   	push   %edi
     a70:	68 e0 5f 01 00       	push   $0x15fe0
     a75:	ff 75 e0             	pushl  -0x20(%ebp)
     a78:	e8 fc 32 00 00       	call   3d79 <read>
     a7d:	83 c4 10             	add    $0x10,%esp
     a80:	85 c0                	test   %eax,%eax
     a82:	0f 8e a5 00 00 00    	jle    b2d <pipe1+0x10d>
     a88:	8d 34 03             	lea    (%ebx,%eax,1),%esi
      for(i = 0; i < n; i++){
     a8b:	31 d2                	xor    %edx,%edx
     a8d:	8d 76 00             	lea    0x0(%esi),%esi
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a90:	8d 4b 01             	lea    0x1(%ebx),%ecx
     a93:	38 9a e0 5f 01 00    	cmp    %bl,0x15fe0(%edx)
     a99:	75 1e                	jne    ab9 <pipe1+0x99>
      for(i = 0; i < n; i++){
     a9b:	83 c2 01             	add    $0x1,%edx
     a9e:	89 cb                	mov    %ecx,%ebx
     aa0:	39 f1                	cmp    %esi,%ecx
     aa2:	75 ec                	jne    a90 <pipe1+0x70>
      cc = cc * 2;
     aa4:	01 ff                	add    %edi,%edi
      total += n;
     aa6:	01 45 d4             	add    %eax,-0x2c(%ebp)
     aa9:	b8 00 20 00 00       	mov    $0x2000,%eax
     aae:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     ab4:	0f 4f f8             	cmovg  %eax,%edi
     ab7:	eb b3                	jmp    a6c <pipe1+0x4c>
          printf(1, "pipe1 oops 2\n");
     ab9:	83 ec 08             	sub    $0x8,%esp
     abc:	68 9e 45 00 00       	push   $0x459e
     ac1:	6a 01                	push   $0x1
     ac3:	e8 18 34 00 00       	call   3ee0 <printf>
          return;
     ac8:	83 c4 10             	add    $0x10,%esp
}
     acb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ace:	5b                   	pop    %ebx
     acf:	5e                   	pop    %esi
     ad0:	5f                   	pop    %edi
     ad1:	5d                   	pop    %ebp
     ad2:	c3                   	ret    
    close(fds[0]);
     ad3:	83 ec 0c             	sub    $0xc,%esp
     ad6:	ff 75 e0             	pushl  -0x20(%ebp)
  seq = 0;
     ad9:	31 db                	xor    %ebx,%ebx
    close(fds[0]);
     adb:	e8 a9 32 00 00       	call   3d89 <close>
     ae0:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 1033; i++)
     ae3:	31 c0                	xor    %eax,%eax
     ae5:	8d 76 00             	lea    0x0(%esi),%esi
        buf[i] = seq++;
     ae8:	8d 14 18             	lea    (%eax,%ebx,1),%edx
      for(i = 0; i < 1033; i++)
     aeb:	83 c0 01             	add    $0x1,%eax
        buf[i] = seq++;
     aee:	88 90 df 5f 01 00    	mov    %dl,0x15fdf(%eax)
      for(i = 0; i < 1033; i++)
     af4:	3d 09 04 00 00       	cmp    $0x409,%eax
     af9:	75 ed                	jne    ae8 <pipe1+0xc8>
      if(write(fds[1], buf, 1033) != 1033){
     afb:	83 ec 04             	sub    $0x4,%esp
     afe:	81 c3 09 04 00 00    	add    $0x409,%ebx
     b04:	68 09 04 00 00       	push   $0x409
     b09:	68 e0 5f 01 00       	push   $0x15fe0
     b0e:	ff 75 e4             	pushl  -0x1c(%ebp)
     b11:	e8 6b 32 00 00       	call   3d81 <write>
     b16:	83 c4 10             	add    $0x10,%esp
     b19:	3d 09 04 00 00       	cmp    $0x409,%eax
     b1e:	75 77                	jne    b97 <pipe1+0x177>
    for(n = 0; n < 5; n++){
     b20:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     b26:	75 bb                	jne    ae3 <pipe1+0xc3>
    exit();
     b28:	e8 34 32 00 00       	call   3d61 <exit>
    if(total != 5 * 1033){
     b2d:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b34:	75 26                	jne    b5c <pipe1+0x13c>
    close(fds[0]);
     b36:	83 ec 0c             	sub    $0xc,%esp
     b39:	ff 75 e0             	pushl  -0x20(%ebp)
     b3c:	e8 48 32 00 00       	call   3d89 <close>
    wait();
     b41:	e8 23 32 00 00       	call   3d69 <wait>
  printf(1, "pipe1 ok\n");
     b46:	5a                   	pop    %edx
     b47:	59                   	pop    %ecx
     b48:	68 c3 45 00 00       	push   $0x45c3
     b4d:	6a 01                	push   $0x1
     b4f:	e8 8c 33 00 00       	call   3ee0 <printf>
     b54:	83 c4 10             	add    $0x10,%esp
     b57:	e9 6f ff ff ff       	jmp    acb <pipe1+0xab>
      printf(1, "pipe1 oops 3 total %d\n", total);
     b5c:	53                   	push   %ebx
     b5d:	ff 75 d4             	pushl  -0x2c(%ebp)
     b60:	68 ac 45 00 00       	push   $0x45ac
     b65:	6a 01                	push   $0x1
     b67:	e8 74 33 00 00       	call   3ee0 <printf>
      exit();
     b6c:	e8 f0 31 00 00       	call   3d61 <exit>
    printf(1, "pipe() failed\n");
     b71:	57                   	push   %edi
     b72:	57                   	push   %edi
     b73:	68 81 45 00 00       	push   $0x4581
     b78:	6a 01                	push   $0x1
     b7a:	e8 61 33 00 00       	call   3ee0 <printf>
    exit();
     b7f:	e8 dd 31 00 00       	call   3d61 <exit>
    printf(1, "fork() failed\n");
     b84:	50                   	push   %eax
     b85:	50                   	push   %eax
     b86:	68 cd 45 00 00       	push   $0x45cd
     b8b:	6a 01                	push   $0x1
     b8d:	e8 4e 33 00 00       	call   3ee0 <printf>
    exit();
     b92:	e8 ca 31 00 00       	call   3d61 <exit>
        printf(1, "pipe1 oops 1\n");
     b97:	56                   	push   %esi
     b98:	56                   	push   %esi
     b99:	68 90 45 00 00       	push   $0x4590
     b9e:	6a 01                	push   $0x1
     ba0:	e8 3b 33 00 00       	call   3ee0 <printf>
        exit();
     ba5:	e8 b7 31 00 00       	call   3d61 <exit>
     baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000bb0 <preempt>:
{
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	57                   	push   %edi
     bb4:	56                   	push   %esi
     bb5:	53                   	push   %ebx
     bb6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "preempt: ");
     bb9:	68 dc 45 00 00       	push   $0x45dc
     bbe:	6a 01                	push   $0x1
     bc0:	e8 1b 33 00 00       	call   3ee0 <printf>
  pid1 = fork();
     bc5:	e8 8f 31 00 00       	call   3d59 <fork>
  if(pid1 == 0)
     bca:	83 c4 10             	add    $0x10,%esp
     bcd:	85 c0                	test   %eax,%eax
     bcf:	75 07                	jne    bd8 <preempt+0x28>
      ;
     bd1:	eb fe                	jmp    bd1 <preempt+0x21>
     bd3:	90                   	nop
     bd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bd8:	89 c7                	mov    %eax,%edi
  pid2 = fork();
     bda:	e8 7a 31 00 00       	call   3d59 <fork>
     bdf:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     be1:	85 c0                	test   %eax,%eax
     be3:	75 0b                	jne    bf0 <preempt+0x40>
      ;
     be5:	eb fe                	jmp    be5 <preempt+0x35>
     be7:	89 f6                	mov    %esi,%esi
     be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  pipe(pfds);
     bf0:	83 ec 0c             	sub    $0xc,%esp
     bf3:	8d 45 e0             	lea    -0x20(%ebp),%eax
     bf6:	50                   	push   %eax
     bf7:	e8 75 31 00 00       	call   3d71 <pipe>
  pid3 = fork();
     bfc:	e8 58 31 00 00       	call   3d59 <fork>
  if(pid3 == 0){
     c01:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
     c04:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     c06:	85 c0                	test   %eax,%eax
     c08:	75 3e                	jne    c48 <preempt+0x98>
    close(pfds[0]);
     c0a:	83 ec 0c             	sub    $0xc,%esp
     c0d:	ff 75 e0             	pushl  -0x20(%ebp)
     c10:	e8 74 31 00 00       	call   3d89 <close>
    if(write(pfds[1], "x", 1) != 1)
     c15:	83 c4 0c             	add    $0xc,%esp
     c18:	6a 01                	push   $0x1
     c1a:	68 a1 4b 00 00       	push   $0x4ba1
     c1f:	ff 75 e4             	pushl  -0x1c(%ebp)
     c22:	e8 5a 31 00 00       	call   3d81 <write>
     c27:	83 c4 10             	add    $0x10,%esp
     c2a:	83 f8 01             	cmp    $0x1,%eax
     c2d:	0f 85 a4 00 00 00    	jne    cd7 <preempt+0x127>
    close(pfds[1]);
     c33:	83 ec 0c             	sub    $0xc,%esp
     c36:	ff 75 e4             	pushl  -0x1c(%ebp)
     c39:	e8 4b 31 00 00       	call   3d89 <close>
     c3e:	83 c4 10             	add    $0x10,%esp
      ;
     c41:	eb fe                	jmp    c41 <preempt+0x91>
     c43:	90                   	nop
     c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  close(pfds[1]);
     c48:	83 ec 0c             	sub    $0xc,%esp
     c4b:	ff 75 e4             	pushl  -0x1c(%ebp)
     c4e:	e8 36 31 00 00       	call   3d89 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c53:	83 c4 0c             	add    $0xc,%esp
     c56:	68 00 20 00 00       	push   $0x2000
     c5b:	68 e0 5f 01 00       	push   $0x15fe0
     c60:	ff 75 e0             	pushl  -0x20(%ebp)
     c63:	e8 11 31 00 00       	call   3d79 <read>
     c68:	83 c4 10             	add    $0x10,%esp
     c6b:	83 f8 01             	cmp    $0x1,%eax
     c6e:	75 7e                	jne    cee <preempt+0x13e>
  close(pfds[0]);
     c70:	83 ec 0c             	sub    $0xc,%esp
     c73:	ff 75 e0             	pushl  -0x20(%ebp)
     c76:	e8 0e 31 00 00       	call   3d89 <close>
  printf(1, "kill... ");
     c7b:	58                   	pop    %eax
     c7c:	5a                   	pop    %edx
     c7d:	68 0d 46 00 00       	push   $0x460d
     c82:	6a 01                	push   $0x1
     c84:	e8 57 32 00 00       	call   3ee0 <printf>
  kill(pid1);
     c89:	89 3c 24             	mov    %edi,(%esp)
     c8c:	e8 00 31 00 00       	call   3d91 <kill>
  kill(pid2);
     c91:	89 34 24             	mov    %esi,(%esp)
     c94:	e8 f8 30 00 00       	call   3d91 <kill>
  kill(pid3);
     c99:	89 1c 24             	mov    %ebx,(%esp)
     c9c:	e8 f0 30 00 00       	call   3d91 <kill>
  printf(1, "wait... ");
     ca1:	59                   	pop    %ecx
     ca2:	5b                   	pop    %ebx
     ca3:	68 16 46 00 00       	push   $0x4616
     ca8:	6a 01                	push   $0x1
     caa:	e8 31 32 00 00       	call   3ee0 <printf>
  wait();
     caf:	e8 b5 30 00 00       	call   3d69 <wait>
  wait();
     cb4:	e8 b0 30 00 00       	call   3d69 <wait>
  wait();
     cb9:	e8 ab 30 00 00       	call   3d69 <wait>
  printf(1, "preempt ok\n");
     cbe:	5e                   	pop    %esi
     cbf:	5f                   	pop    %edi
     cc0:	68 1f 46 00 00       	push   $0x461f
     cc5:	6a 01                	push   $0x1
     cc7:	e8 14 32 00 00       	call   3ee0 <printf>
     ccc:	83 c4 10             	add    $0x10,%esp
}
     ccf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cd2:	5b                   	pop    %ebx
     cd3:	5e                   	pop    %esi
     cd4:	5f                   	pop    %edi
     cd5:	5d                   	pop    %ebp
     cd6:	c3                   	ret    
      printf(1, "preempt write error");
     cd7:	83 ec 08             	sub    $0x8,%esp
     cda:	68 e6 45 00 00       	push   $0x45e6
     cdf:	6a 01                	push   $0x1
     ce1:	e8 fa 31 00 00       	call   3ee0 <printf>
     ce6:	83 c4 10             	add    $0x10,%esp
     ce9:	e9 45 ff ff ff       	jmp    c33 <preempt+0x83>
    printf(1, "preempt read error");
     cee:	83 ec 08             	sub    $0x8,%esp
     cf1:	68 fa 45 00 00       	push   $0x45fa
     cf6:	6a 01                	push   $0x1
     cf8:	e8 e3 31 00 00       	call   3ee0 <printf>
    return;
     cfd:	83 c4 10             	add    $0x10,%esp
     d00:	eb cd                	jmp    ccf <preempt+0x11f>
     d02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d10 <exitwait>:
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	56                   	push   %esi
     d14:	be 64 00 00 00       	mov    $0x64,%esi
     d19:	53                   	push   %ebx
     d1a:	eb 14                	jmp    d30 <exitwait+0x20>
     d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid){
     d20:	74 68                	je     d8a <exitwait+0x7a>
      if(wait() != pid){
     d22:	e8 42 30 00 00       	call   3d69 <wait>
     d27:	39 d8                	cmp    %ebx,%eax
     d29:	75 2d                	jne    d58 <exitwait+0x48>
  for(i = 0; i < 100; i++){
     d2b:	83 ee 01             	sub    $0x1,%esi
     d2e:	74 41                	je     d71 <exitwait+0x61>
    pid = fork();
     d30:	e8 24 30 00 00       	call   3d59 <fork>
     d35:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     d37:	85 c0                	test   %eax,%eax
     d39:	79 e5                	jns    d20 <exitwait+0x10>
      printf(1, "fork failed\n");
     d3b:	83 ec 08             	sub    $0x8,%esp
     d3e:	68 42 52 00 00       	push   $0x5242
     d43:	6a 01                	push   $0x1
     d45:	e8 96 31 00 00       	call   3ee0 <printf>
      return;
     d4a:	83 c4 10             	add    $0x10,%esp
}
     d4d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d50:	5b                   	pop    %ebx
     d51:	5e                   	pop    %esi
     d52:	5d                   	pop    %ebp
     d53:	c3                   	ret    
     d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "wait wrong pid\n");
     d58:	83 ec 08             	sub    $0x8,%esp
     d5b:	68 2b 46 00 00       	push   $0x462b
     d60:	6a 01                	push   $0x1
     d62:	e8 79 31 00 00       	call   3ee0 <printf>
        return;
     d67:	83 c4 10             	add    $0x10,%esp
}
     d6a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d6d:	5b                   	pop    %ebx
     d6e:	5e                   	pop    %esi
     d6f:	5d                   	pop    %ebp
     d70:	c3                   	ret    
  printf(1, "exitwait ok\n");
     d71:	83 ec 08             	sub    $0x8,%esp
     d74:	68 3b 46 00 00       	push   $0x463b
     d79:	6a 01                	push   $0x1
     d7b:	e8 60 31 00 00       	call   3ee0 <printf>
     d80:	83 c4 10             	add    $0x10,%esp
}
     d83:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d86:	5b                   	pop    %ebx
     d87:	5e                   	pop    %esi
     d88:	5d                   	pop    %ebp
     d89:	c3                   	ret    
      exit();
     d8a:	e8 d2 2f 00 00       	call   3d61 <exit>
     d8f:	90                   	nop

00000d90 <mem>:
{
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	57                   	push   %edi
     d94:	56                   	push   %esi
     d95:	53                   	push   %ebx
     d96:	31 db                	xor    %ebx,%ebx
     d98:	83 ec 14             	sub    $0x14,%esp
  printf(1, "mem test\n");
     d9b:	68 48 46 00 00       	push   $0x4648
     da0:	6a 01                	push   $0x1
     da2:	e8 39 31 00 00       	call   3ee0 <printf>
  ppid = getpid();
     da7:	e8 35 30 00 00       	call   3de1 <getpid>
     dac:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
     dae:	e8 a6 2f 00 00       	call   3d59 <fork>
     db3:	83 c4 10             	add    $0x10,%esp
     db6:	85 c0                	test   %eax,%eax
     db8:	74 0a                	je     dc4 <mem+0x34>
     dba:	e9 89 00 00 00       	jmp    e48 <mem+0xb8>
     dbf:	90                   	nop
      *(char**)m2 = m1;
     dc0:	89 18                	mov    %ebx,(%eax)
     dc2:	89 c3                	mov    %eax,%ebx
    while((m2 = malloc(10001)) != 0){
     dc4:	83 ec 0c             	sub    $0xc,%esp
     dc7:	68 11 27 00 00       	push   $0x2711
     dcc:	e8 6f 33 00 00       	call   4140 <malloc>
     dd1:	83 c4 10             	add    $0x10,%esp
     dd4:	85 c0                	test   %eax,%eax
     dd6:	75 e8                	jne    dc0 <mem+0x30>
    while(m1){
     dd8:	85 db                	test   %ebx,%ebx
     dda:	74 18                	je     df4 <mem+0x64>
     ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      free(m1);
     de0:	83 ec 0c             	sub    $0xc,%esp
      m2 = *(char**)m1;
     de3:	8b 3b                	mov    (%ebx),%edi
      free(m1);
     de5:	53                   	push   %ebx
     de6:	89 fb                	mov    %edi,%ebx
     de8:	e8 c3 32 00 00       	call   40b0 <free>
    while(m1){
     ded:	83 c4 10             	add    $0x10,%esp
     df0:	85 db                	test   %ebx,%ebx
     df2:	75 ec                	jne    de0 <mem+0x50>
    m1 = malloc(1024*20);
     df4:	83 ec 0c             	sub    $0xc,%esp
     df7:	68 00 50 00 00       	push   $0x5000
     dfc:	e8 3f 33 00 00       	call   4140 <malloc>
    if(m1 == 0){
     e01:	83 c4 10             	add    $0x10,%esp
     e04:	85 c0                	test   %eax,%eax
     e06:	74 20                	je     e28 <mem+0x98>
    free(m1);
     e08:	83 ec 0c             	sub    $0xc,%esp
     e0b:	50                   	push   %eax
     e0c:	e8 9f 32 00 00       	call   40b0 <free>
    printf(1, "mem ok\n");
     e11:	58                   	pop    %eax
     e12:	5a                   	pop    %edx
     e13:	68 6c 46 00 00       	push   $0x466c
     e18:	6a 01                	push   $0x1
     e1a:	e8 c1 30 00 00       	call   3ee0 <printf>
    exit();
     e1f:	e8 3d 2f 00 00       	call   3d61 <exit>
     e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "couldn't allocate mem?!!\n");
     e28:	83 ec 08             	sub    $0x8,%esp
     e2b:	68 52 46 00 00       	push   $0x4652
     e30:	6a 01                	push   $0x1
     e32:	e8 a9 30 00 00       	call   3ee0 <printf>
      kill(ppid);
     e37:	89 34 24             	mov    %esi,(%esp)
     e3a:	e8 52 2f 00 00       	call   3d91 <kill>
      exit();
     e3f:	e8 1d 2f 00 00       	call   3d61 <exit>
     e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
     e48:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e4b:	5b                   	pop    %ebx
     e4c:	5e                   	pop    %esi
     e4d:	5f                   	pop    %edi
     e4e:	5d                   	pop    %ebp
    wait();
     e4f:	e9 15 2f 00 00       	jmp    3d69 <wait>
     e54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000e60 <sharedfd>:
{
     e60:	55                   	push   %ebp
     e61:	89 e5                	mov    %esp,%ebp
     e63:	57                   	push   %edi
     e64:	56                   	push   %esi
     e65:	53                   	push   %ebx
     e66:	83 ec 34             	sub    $0x34,%esp
  printf(1, "sharedfd test\n");
     e69:	68 74 46 00 00       	push   $0x4674
     e6e:	6a 01                	push   $0x1
     e70:	e8 6b 30 00 00       	call   3ee0 <printf>
  unlink("sharedfd");
     e75:	c7 04 24 83 46 00 00 	movl   $0x4683,(%esp)
     e7c:	e8 30 2f 00 00       	call   3db1 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e81:	5b                   	pop    %ebx
     e82:	5e                   	pop    %esi
     e83:	68 02 02 00 00       	push   $0x202
     e88:	68 83 46 00 00       	push   $0x4683
     e8d:	e8 0f 2f 00 00       	call   3da1 <open>
  if(fd < 0){
     e92:	83 c4 10             	add    $0x10,%esp
     e95:	85 c0                	test   %eax,%eax
     e97:	0f 88 2a 01 00 00    	js     fc7 <sharedfd+0x167>
     e9d:	89 c7                	mov    %eax,%edi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e9f:	8d 75 de             	lea    -0x22(%ebp),%esi
     ea2:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  pid = fork();
     ea7:	e8 ad 2e 00 00       	call   3d59 <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     eac:	83 f8 01             	cmp    $0x1,%eax
  pid = fork();
     eaf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     eb2:	19 c0                	sbb    %eax,%eax
     eb4:	83 ec 04             	sub    $0x4,%esp
     eb7:	83 e0 f3             	and    $0xfffffff3,%eax
     eba:	6a 0a                	push   $0xa
     ebc:	83 c0 70             	add    $0x70,%eax
     ebf:	50                   	push   %eax
     ec0:	56                   	push   %esi
     ec1:	e8 fa 2c 00 00       	call   3bc0 <memset>
     ec6:	83 c4 10             	add    $0x10,%esp
     ec9:	eb 0a                	jmp    ed5 <sharedfd+0x75>
     ecb:	90                   	nop
     ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 1000; i++){
     ed0:	83 eb 01             	sub    $0x1,%ebx
     ed3:	74 26                	je     efb <sharedfd+0x9b>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     ed5:	83 ec 04             	sub    $0x4,%esp
     ed8:	6a 0a                	push   $0xa
     eda:	56                   	push   %esi
     edb:	57                   	push   %edi
     edc:	e8 a0 2e 00 00       	call   3d81 <write>
     ee1:	83 c4 10             	add    $0x10,%esp
     ee4:	83 f8 0a             	cmp    $0xa,%eax
     ee7:	74 e7                	je     ed0 <sharedfd+0x70>
      printf(1, "fstests: write sharedfd failed\n");
     ee9:	83 ec 08             	sub    $0x8,%esp
     eec:	68 60 54 00 00       	push   $0x5460
     ef1:	6a 01                	push   $0x1
     ef3:	e8 e8 2f 00 00       	call   3ee0 <printf>
      break;
     ef8:	83 c4 10             	add    $0x10,%esp
  if(pid == 0)
     efb:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     efe:	85 c9                	test   %ecx,%ecx
     f00:	0f 84 f5 00 00 00    	je     ffb <sharedfd+0x19b>
    wait();
     f06:	e8 5e 2e 00 00       	call   3d69 <wait>
  close(fd);
     f0b:	83 ec 0c             	sub    $0xc,%esp
  nc = np = 0;
     f0e:	31 db                	xor    %ebx,%ebx
  close(fd);
     f10:	57                   	push   %edi
     f11:	8d 7d e8             	lea    -0x18(%ebp),%edi
     f14:	e8 70 2e 00 00       	call   3d89 <close>
  fd = open("sharedfd", 0);
     f19:	58                   	pop    %eax
     f1a:	5a                   	pop    %edx
     f1b:	6a 00                	push   $0x0
     f1d:	68 83 46 00 00       	push   $0x4683
     f22:	e8 7a 2e 00 00       	call   3da1 <open>
  if(fd < 0){
     f27:	83 c4 10             	add    $0x10,%esp
  nc = np = 0;
     f2a:	31 d2                	xor    %edx,%edx
  fd = open("sharedfd", 0);
     f2c:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
     f2f:	85 c0                	test   %eax,%eax
     f31:	0f 88 aa 00 00 00    	js     fe1 <sharedfd+0x181>
     f37:	89 f6                	mov    %esi,%esi
     f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f40:	83 ec 04             	sub    $0x4,%esp
     f43:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     f46:	6a 0a                	push   $0xa
     f48:	56                   	push   %esi
     f49:	ff 75 d0             	pushl  -0x30(%ebp)
     f4c:	e8 28 2e 00 00       	call   3d79 <read>
     f51:	83 c4 10             	add    $0x10,%esp
     f54:	85 c0                	test   %eax,%eax
     f56:	7e 28                	jle    f80 <sharedfd+0x120>
     f58:	89 f0                	mov    %esi,%eax
     f5a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f5d:	eb 13                	jmp    f72 <sharedfd+0x112>
     f5f:	90                   	nop
        np++;
     f60:	80 f9 70             	cmp    $0x70,%cl
     f63:	0f 94 c1             	sete   %cl
     f66:	0f b6 c9             	movzbl %cl,%ecx
     f69:	01 cb                	add    %ecx,%ebx
     f6b:	83 c0 01             	add    $0x1,%eax
    for(i = 0; i < sizeof(buf); i++){
     f6e:	39 f8                	cmp    %edi,%eax
     f70:	74 ce                	je     f40 <sharedfd+0xe0>
      if(buf[i] == 'c')
     f72:	0f b6 08             	movzbl (%eax),%ecx
     f75:	80 f9 63             	cmp    $0x63,%cl
     f78:	75 e6                	jne    f60 <sharedfd+0x100>
        nc++;
     f7a:	83 c2 01             	add    $0x1,%edx
      if(buf[i] == 'p')
     f7d:	eb ec                	jmp    f6b <sharedfd+0x10b>
     f7f:	90                   	nop
  close(fd);
     f80:	83 ec 0c             	sub    $0xc,%esp
     f83:	ff 75 d0             	pushl  -0x30(%ebp)
     f86:	e8 fe 2d 00 00       	call   3d89 <close>
  unlink("sharedfd");
     f8b:	c7 04 24 83 46 00 00 	movl   $0x4683,(%esp)
     f92:	e8 1a 2e 00 00       	call   3db1 <unlink>
  if(nc == 10000 && np == 10000){
     f97:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f9a:	83 c4 10             	add    $0x10,%esp
     f9d:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     fa3:	75 5b                	jne    1000 <sharedfd+0x1a0>
     fa5:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     fab:	75 53                	jne    1000 <sharedfd+0x1a0>
    printf(1, "sharedfd ok\n");
     fad:	83 ec 08             	sub    $0x8,%esp
     fb0:	68 8c 46 00 00       	push   $0x468c
     fb5:	6a 01                	push   $0x1
     fb7:	e8 24 2f 00 00       	call   3ee0 <printf>
     fbc:	83 c4 10             	add    $0x10,%esp
}
     fbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fc2:	5b                   	pop    %ebx
     fc3:	5e                   	pop    %esi
     fc4:	5f                   	pop    %edi
     fc5:	5d                   	pop    %ebp
     fc6:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for writing");
     fc7:	83 ec 08             	sub    $0x8,%esp
     fca:	68 34 54 00 00       	push   $0x5434
     fcf:	6a 01                	push   $0x1
     fd1:	e8 0a 2f 00 00       	call   3ee0 <printf>
    return;
     fd6:	83 c4 10             	add    $0x10,%esp
}
     fd9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fdc:	5b                   	pop    %ebx
     fdd:	5e                   	pop    %esi
     fde:	5f                   	pop    %edi
     fdf:	5d                   	pop    %ebp
     fe0:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for reading\n");
     fe1:	83 ec 08             	sub    $0x8,%esp
     fe4:	68 80 54 00 00       	push   $0x5480
     fe9:	6a 01                	push   $0x1
     feb:	e8 f0 2e 00 00       	call   3ee0 <printf>
    return;
     ff0:	83 c4 10             	add    $0x10,%esp
}
     ff3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ff6:	5b                   	pop    %ebx
     ff7:	5e                   	pop    %esi
     ff8:	5f                   	pop    %edi
     ff9:	5d                   	pop    %ebp
     ffa:	c3                   	ret    
    exit();
     ffb:	e8 61 2d 00 00       	call   3d61 <exit>
    printf(1, "sharedfd oops %d %d\n", nc, np);
    1000:	53                   	push   %ebx
    1001:	52                   	push   %edx
    1002:	68 99 46 00 00       	push   $0x4699
    1007:	6a 01                	push   $0x1
    1009:	e8 d2 2e 00 00       	call   3ee0 <printf>
    exit();
    100e:	e8 4e 2d 00 00       	call   3d61 <exit>
    1013:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001020 <fourfiles>:
{
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	57                   	push   %edi
    1024:	56                   	push   %esi
  printf(1, "fourfiles test\n");
    1025:	be ae 46 00 00       	mov    $0x46ae,%esi
{
    102a:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    102b:	31 db                	xor    %ebx,%ebx
{
    102d:	83 ec 34             	sub    $0x34,%esp
  char *names[] = { "f0", "f1", "f2", "f3" };
    1030:	c7 45 d8 ae 46 00 00 	movl   $0x46ae,-0x28(%ebp)
  printf(1, "fourfiles test\n");
    1037:	68 b4 46 00 00       	push   $0x46b4
    103c:	6a 01                	push   $0x1
  char *names[] = { "f0", "f1", "f2", "f3" };
    103e:	c7 45 dc f7 47 00 00 	movl   $0x47f7,-0x24(%ebp)
    1045:	c7 45 e0 fb 47 00 00 	movl   $0x47fb,-0x20(%ebp)
    104c:	c7 45 e4 b1 46 00 00 	movl   $0x46b1,-0x1c(%ebp)
  printf(1, "fourfiles test\n");
    1053:	e8 88 2e 00 00       	call   3ee0 <printf>
    1058:	83 c4 10             	add    $0x10,%esp
    unlink(fname);
    105b:	83 ec 0c             	sub    $0xc,%esp
    105e:	56                   	push   %esi
    105f:	e8 4d 2d 00 00       	call   3db1 <unlink>
    pid = fork();
    1064:	e8 f0 2c 00 00       	call   3d59 <fork>
    if(pid < 0){
    1069:	83 c4 10             	add    $0x10,%esp
    106c:	85 c0                	test   %eax,%eax
    106e:	0f 88 6c 01 00 00    	js     11e0 <fourfiles+0x1c0>
    if(pid == 0){
    1074:	0f 84 ef 00 00 00    	je     1169 <fourfiles+0x149>
  for(pi = 0; pi < 4; pi++){
    107a:	83 c3 01             	add    $0x1,%ebx
    107d:	83 fb 04             	cmp    $0x4,%ebx
    1080:	74 06                	je     1088 <fourfiles+0x68>
    1082:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1086:	eb d3                	jmp    105b <fourfiles+0x3b>
    wait();
    1088:	e8 dc 2c 00 00       	call   3d69 <wait>
  for(i = 0; i < 2; i++){
    108d:	31 ff                	xor    %edi,%edi
    wait();
    108f:	e8 d5 2c 00 00       	call   3d69 <wait>
    1094:	e8 d0 2c 00 00       	call   3d69 <wait>
    1099:	e8 cb 2c 00 00       	call   3d69 <wait>
    109e:	c7 45 d0 ae 46 00 00 	movl   $0x46ae,-0x30(%ebp)
    fd = open(fname, 0);
    10a5:	83 ec 08             	sub    $0x8,%esp
    total = 0;
    10a8:	31 db                	xor    %ebx,%ebx
    fd = open(fname, 0);
    10aa:	6a 00                	push   $0x0
    10ac:	ff 75 d0             	pushl  -0x30(%ebp)
    10af:	e8 ed 2c 00 00       	call   3da1 <open>
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10b4:	83 c4 10             	add    $0x10,%esp
    fd = open(fname, 0);
    10b7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    total = 0;
    10ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10c0:	83 ec 04             	sub    $0x4,%esp
    10c3:	68 00 20 00 00       	push   $0x2000
    10c8:	68 e0 5f 01 00       	push   $0x15fe0
    10cd:	ff 75 d4             	pushl  -0x2c(%ebp)
    10d0:	e8 a4 2c 00 00       	call   3d79 <read>
    10d5:	83 c4 10             	add    $0x10,%esp
    10d8:	85 c0                	test   %eax,%eax
    10da:	7e 22                	jle    10fe <fourfiles+0xde>
      for(j = 0; j < n; j++){
    10dc:	31 d2                	xor    %edx,%edx
    10de:	66 90                	xchg   %ax,%ax
        if(buf[j] != '0'+i){
    10e0:	83 ff 01             	cmp    $0x1,%edi
    10e3:	0f be b2 e0 5f 01 00 	movsbl 0x15fe0(%edx),%esi
    10ea:	19 c9                	sbb    %ecx,%ecx
    10ec:	83 c1 31             	add    $0x31,%ecx
    10ef:	39 ce                	cmp    %ecx,%esi
    10f1:	75 62                	jne    1155 <fourfiles+0x135>
      for(j = 0; j < n; j++){
    10f3:	83 c2 01             	add    $0x1,%edx
    10f6:	39 d0                	cmp    %edx,%eax
    10f8:	75 e6                	jne    10e0 <fourfiles+0xc0>
      total += n;
    10fa:	01 c3                	add    %eax,%ebx
    10fc:	eb c2                	jmp    10c0 <fourfiles+0xa0>
    close(fd);
    10fe:	83 ec 0c             	sub    $0xc,%esp
    1101:	ff 75 d4             	pushl  -0x2c(%ebp)
    1104:	e8 80 2c 00 00       	call   3d89 <close>
    if(total != 12*500){
    1109:	83 c4 10             	add    $0x10,%esp
    110c:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    1112:	0f 85 dc 00 00 00    	jne    11f4 <fourfiles+0x1d4>
    unlink(fname);
    1118:	83 ec 0c             	sub    $0xc,%esp
    111b:	ff 75 d0             	pushl  -0x30(%ebp)
    111e:	e8 8e 2c 00 00       	call   3db1 <unlink>
  for(i = 0; i < 2; i++){
    1123:	83 c4 10             	add    $0x10,%esp
    1126:	83 ff 01             	cmp    $0x1,%edi
    1129:	75 1a                	jne    1145 <fourfiles+0x125>
  printf(1, "fourfiles ok\n");
    112b:	83 ec 08             	sub    $0x8,%esp
    112e:	68 f2 46 00 00       	push   $0x46f2
    1133:	6a 01                	push   $0x1
    1135:	e8 a6 2d 00 00       	call   3ee0 <printf>
}
    113a:	83 c4 10             	add    $0x10,%esp
    113d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1140:	5b                   	pop    %ebx
    1141:	5e                   	pop    %esi
    1142:	5f                   	pop    %edi
    1143:	5d                   	pop    %ebp
    1144:	c3                   	ret    
    1145:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1148:	bf 01 00 00 00       	mov    $0x1,%edi
    114d:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1150:	e9 50 ff ff ff       	jmp    10a5 <fourfiles+0x85>
          printf(1, "wrong char\n");
    1155:	83 ec 08             	sub    $0x8,%esp
    1158:	68 d5 46 00 00       	push   $0x46d5
    115d:	6a 01                	push   $0x1
    115f:	e8 7c 2d 00 00       	call   3ee0 <printf>
          exit();
    1164:	e8 f8 2b 00 00       	call   3d61 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    1169:	83 ec 08             	sub    $0x8,%esp
    116c:	68 02 02 00 00       	push   $0x202
    1171:	56                   	push   %esi
    1172:	e8 2a 2c 00 00       	call   3da1 <open>
      if(fd < 0){
    1177:	83 c4 10             	add    $0x10,%esp
      fd = open(fname, O_CREATE | O_RDWR);
    117a:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    117c:	85 c0                	test   %eax,%eax
    117e:	78 45                	js     11c5 <fourfiles+0x1a5>
      memset(buf, '0'+pi, 512);
    1180:	83 ec 04             	sub    $0x4,%esp
    1183:	83 c3 30             	add    $0x30,%ebx
    1186:	68 00 02 00 00       	push   $0x200
    118b:	53                   	push   %ebx
    118c:	bb 0c 00 00 00       	mov    $0xc,%ebx
    1191:	68 e0 5f 01 00       	push   $0x15fe0
    1196:	e8 25 2a 00 00       	call   3bc0 <memset>
    119b:	83 c4 10             	add    $0x10,%esp
        if((n = write(fd, buf, 500)) != 500){
    119e:	83 ec 04             	sub    $0x4,%esp
    11a1:	68 f4 01 00 00       	push   $0x1f4
    11a6:	68 e0 5f 01 00       	push   $0x15fe0
    11ab:	56                   	push   %esi
    11ac:	e8 d0 2b 00 00       	call   3d81 <write>
    11b1:	83 c4 10             	add    $0x10,%esp
    11b4:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    11b9:	75 4c                	jne    1207 <fourfiles+0x1e7>
      for(i = 0; i < 12; i++){
    11bb:	83 eb 01             	sub    $0x1,%ebx
    11be:	75 de                	jne    119e <fourfiles+0x17e>
      exit();
    11c0:	e8 9c 2b 00 00       	call   3d61 <exit>
        printf(1, "create failed\n");
    11c5:	51                   	push   %ecx
    11c6:	51                   	push   %ecx
    11c7:	68 4f 49 00 00       	push   $0x494f
    11cc:	6a 01                	push   $0x1
    11ce:	e8 0d 2d 00 00       	call   3ee0 <printf>
        exit();
    11d3:	e8 89 2b 00 00       	call   3d61 <exit>
    11d8:	90                   	nop
    11d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "fork failed\n");
    11e0:	83 ec 08             	sub    $0x8,%esp
    11e3:	68 42 52 00 00       	push   $0x5242
    11e8:	6a 01                	push   $0x1
    11ea:	e8 f1 2c 00 00       	call   3ee0 <printf>
      exit();
    11ef:	e8 6d 2b 00 00       	call   3d61 <exit>
      printf(1, "wrong length %d\n", total);
    11f4:	50                   	push   %eax
    11f5:	53                   	push   %ebx
    11f6:	68 e1 46 00 00       	push   $0x46e1
    11fb:	6a 01                	push   $0x1
    11fd:	e8 de 2c 00 00       	call   3ee0 <printf>
      exit();
    1202:	e8 5a 2b 00 00       	call   3d61 <exit>
          printf(1, "write failed %d\n", n);
    1207:	52                   	push   %edx
    1208:	50                   	push   %eax
    1209:	68 c4 46 00 00       	push   $0x46c4
    120e:	6a 01                	push   $0x1
    1210:	e8 cb 2c 00 00       	call   3ee0 <printf>
          exit();
    1215:	e8 47 2b 00 00       	call   3d61 <exit>
    121a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001220 <createdelete>:
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	57                   	push   %edi
    1224:	56                   	push   %esi
    1225:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    1226:	31 db                	xor    %ebx,%ebx
{
    1228:	83 ec 44             	sub    $0x44,%esp
  printf(1, "createdelete test\n");
    122b:	68 00 47 00 00       	push   $0x4700
    1230:	6a 01                	push   $0x1
    1232:	e8 a9 2c 00 00       	call   3ee0 <printf>
    1237:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    123a:	e8 1a 2b 00 00       	call   3d59 <fork>
    if(pid < 0){
    123f:	85 c0                	test   %eax,%eax
    1241:	0f 88 bf 01 00 00    	js     1406 <createdelete+0x1e6>
    if(pid == 0){
    1247:	0f 84 0b 01 00 00    	je     1358 <createdelete+0x138>
  for(pi = 0; pi < 4; pi++){
    124d:	83 c3 01             	add    $0x1,%ebx
    1250:	83 fb 04             	cmp    $0x4,%ebx
    1253:	75 e5                	jne    123a <createdelete+0x1a>
    wait();
    1255:	e8 0f 2b 00 00       	call   3d69 <wait>
  name[0] = name[1] = name[2] = 0;
    125a:	be ff ff ff ff       	mov    $0xffffffff,%esi
    125f:	8d 7d c8             	lea    -0x38(%ebp),%edi
    wait();
    1262:	e8 02 2b 00 00       	call   3d69 <wait>
    1267:	e8 fd 2a 00 00       	call   3d69 <wait>
    126c:	e8 f8 2a 00 00       	call   3d69 <wait>
  name[0] = name[1] = name[2] = 0;
    1271:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1275:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < N; i++){
    1278:	8d 46 31             	lea    0x31(%esi),%eax
    127b:	88 45 c7             	mov    %al,-0x39(%ebp)
    127e:	8d 46 01             	lea    0x1(%esi),%eax
    1281:	83 f8 09             	cmp    $0x9,%eax
    1284:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1287:	0f 9f c3             	setg   %bl
    128a:	85 c0                	test   %eax,%eax
    128c:	0f 94 c0             	sete   %al
    128f:	09 c3                	or     %eax,%ebx
    1291:	88 5d c6             	mov    %bl,-0x3a(%ebp)
      name[2] = '\0';
    1294:	bb 70 00 00 00       	mov    $0x70,%ebx
      fd = open(name, 0);
    1299:	83 ec 08             	sub    $0x8,%esp
      name[1] = '0' + i;
    129c:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      name[0] = 'p' + pi;
    12a0:	88 5d c8             	mov    %bl,-0x38(%ebp)
      fd = open(name, 0);
    12a3:	6a 00                	push   $0x0
    12a5:	57                   	push   %edi
      name[1] = '0' + i;
    12a6:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    12a9:	e8 f3 2a 00 00       	call   3da1 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    12ae:	83 c4 10             	add    $0x10,%esp
    12b1:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    12b5:	0f 84 85 00 00 00    	je     1340 <createdelete+0x120>
    12bb:	85 c0                	test   %eax,%eax
    12bd:	0f 88 1a 01 00 00    	js     13dd <createdelete+0x1bd>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    12c3:	83 fe 08             	cmp    $0x8,%esi
    12c6:	0f 86 56 01 00 00    	jbe    1422 <createdelete+0x202>
        close(fd);
    12cc:	83 ec 0c             	sub    $0xc,%esp
    12cf:	50                   	push   %eax
    12d0:	e8 b4 2a 00 00       	call   3d89 <close>
    12d5:	83 c4 10             	add    $0x10,%esp
    12d8:	83 c3 01             	add    $0x1,%ebx
    for(pi = 0; pi < 4; pi++){
    12db:	80 fb 74             	cmp    $0x74,%bl
    12de:	75 b9                	jne    1299 <createdelete+0x79>
    12e0:	8b 75 c0             	mov    -0x40(%ebp),%esi
  for(i = 0; i < N; i++){
    12e3:	83 fe 13             	cmp    $0x13,%esi
    12e6:	75 90                	jne    1278 <createdelete+0x58>
    12e8:	be 70 00 00 00       	mov    $0x70,%esi
    12ed:	8d 76 00             	lea    0x0(%esi),%esi
    12f0:	8d 46 c0             	lea    -0x40(%esi),%eax
  name[0] = name[1] = name[2] = 0;
    12f3:	bb 04 00 00 00       	mov    $0x4,%ebx
    12f8:	88 45 c7             	mov    %al,-0x39(%ebp)
      unlink(name);
    12fb:	83 ec 0c             	sub    $0xc,%esp
      name[0] = 'p' + i;
    12fe:	89 f0                	mov    %esi,%eax
      unlink(name);
    1300:	57                   	push   %edi
      name[0] = 'p' + i;
    1301:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    1304:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    1308:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    130b:	e8 a1 2a 00 00       	call   3db1 <unlink>
    for(pi = 0; pi < 4; pi++){
    1310:	83 c4 10             	add    $0x10,%esp
    1313:	83 eb 01             	sub    $0x1,%ebx
    1316:	75 e3                	jne    12fb <createdelete+0xdb>
    1318:	83 c6 01             	add    $0x1,%esi
  for(i = 0; i < N; i++){
    131b:	89 f0                	mov    %esi,%eax
    131d:	3c 84                	cmp    $0x84,%al
    131f:	75 cf                	jne    12f0 <createdelete+0xd0>
  printf(1, "createdelete ok\n");
    1321:	83 ec 08             	sub    $0x8,%esp
    1324:	68 13 47 00 00       	push   $0x4713
    1329:	6a 01                	push   $0x1
    132b:	e8 b0 2b 00 00       	call   3ee0 <printf>
}
    1330:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1333:	5b                   	pop    %ebx
    1334:	5e                   	pop    %esi
    1335:	5f                   	pop    %edi
    1336:	5d                   	pop    %ebp
    1337:	c3                   	ret    
    1338:	90                   	nop
    1339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1340:	83 fe 08             	cmp    $0x8,%esi
    1343:	0f 86 d1 00 00 00    	jbe    141a <createdelete+0x1fa>
      if(fd >= 0)
    1349:	85 c0                	test   %eax,%eax
    134b:	78 8b                	js     12d8 <createdelete+0xb8>
    134d:	e9 7a ff ff ff       	jmp    12cc <createdelete+0xac>
    1352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      name[0] = 'p' + pi;
    1358:	83 c3 70             	add    $0x70,%ebx
      name[2] = '\0';
    135b:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    135f:	8d 7d c8             	lea    -0x38(%ebp),%edi
      name[0] = 'p' + pi;
    1362:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[2] = '\0';
    1365:	31 db                	xor    %ebx,%ebx
    1367:	eb 0f                	jmp    1378 <createdelete+0x158>
    1369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < N; i++){
    1370:	83 fb 13             	cmp    $0x13,%ebx
    1373:	74 63                	je     13d8 <createdelete+0x1b8>
    1375:	83 c3 01             	add    $0x1,%ebx
        fd = open(name, O_CREATE | O_RDWR);
    1378:	83 ec 08             	sub    $0x8,%esp
        name[1] = '0' + i;
    137b:	8d 43 30             	lea    0x30(%ebx),%eax
        fd = open(name, O_CREATE | O_RDWR);
    137e:	68 02 02 00 00       	push   $0x202
    1383:	57                   	push   %edi
        name[1] = '0' + i;
    1384:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1387:	e8 15 2a 00 00       	call   3da1 <open>
        if(fd < 0){
    138c:	83 c4 10             	add    $0x10,%esp
    138f:	85 c0                	test   %eax,%eax
    1391:	78 5f                	js     13f2 <createdelete+0x1d2>
        close(fd);
    1393:	83 ec 0c             	sub    $0xc,%esp
    1396:	50                   	push   %eax
    1397:	e8 ed 29 00 00       	call   3d89 <close>
        if(i > 0 && (i % 2 ) == 0){
    139c:	83 c4 10             	add    $0x10,%esp
    139f:	85 db                	test   %ebx,%ebx
    13a1:	74 d2                	je     1375 <createdelete+0x155>
    13a3:	f6 c3 01             	test   $0x1,%bl
    13a6:	75 c8                	jne    1370 <createdelete+0x150>
          if(unlink(name) < 0){
    13a8:	83 ec 0c             	sub    $0xc,%esp
          name[1] = '0' + (i / 2);
    13ab:	89 d8                	mov    %ebx,%eax
          if(unlink(name) < 0){
    13ad:	57                   	push   %edi
          name[1] = '0' + (i / 2);
    13ae:	d1 f8                	sar    %eax
    13b0:	83 c0 30             	add    $0x30,%eax
    13b3:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    13b6:	e8 f6 29 00 00       	call   3db1 <unlink>
    13bb:	83 c4 10             	add    $0x10,%esp
    13be:	85 c0                	test   %eax,%eax
    13c0:	79 ae                	jns    1370 <createdelete+0x150>
            printf(1, "unlink failed\n");
    13c2:	52                   	push   %edx
    13c3:	52                   	push   %edx
    13c4:	68 01 43 00 00       	push   $0x4301
    13c9:	6a 01                	push   $0x1
    13cb:	e8 10 2b 00 00       	call   3ee0 <printf>
            exit();
    13d0:	e8 8c 29 00 00       	call   3d61 <exit>
    13d5:	8d 76 00             	lea    0x0(%esi),%esi
      exit();
    13d8:	e8 84 29 00 00       	call   3d61 <exit>
        printf(1, "oops createdelete %s didn't exist\n", name);
    13dd:	83 ec 04             	sub    $0x4,%esp
    13e0:	57                   	push   %edi
    13e1:	68 ac 54 00 00       	push   $0x54ac
    13e6:	6a 01                	push   $0x1
    13e8:	e8 f3 2a 00 00       	call   3ee0 <printf>
        exit();
    13ed:	e8 6f 29 00 00       	call   3d61 <exit>
          printf(1, "create failed\n");
    13f2:	83 ec 08             	sub    $0x8,%esp
    13f5:	68 4f 49 00 00       	push   $0x494f
    13fa:	6a 01                	push   $0x1
    13fc:	e8 df 2a 00 00       	call   3ee0 <printf>
          exit();
    1401:	e8 5b 29 00 00       	call   3d61 <exit>
      printf(1, "fork failed\n");
    1406:	83 ec 08             	sub    $0x8,%esp
    1409:	68 42 52 00 00       	push   $0x5242
    140e:	6a 01                	push   $0x1
    1410:	e8 cb 2a 00 00       	call   3ee0 <printf>
      exit();
    1415:	e8 47 29 00 00       	call   3d61 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    141a:	85 c0                	test   %eax,%eax
    141c:	0f 88 b6 fe ff ff    	js     12d8 <createdelete+0xb8>
        printf(1, "oops createdelete %s did exist\n", name);
    1422:	50                   	push   %eax
    1423:	57                   	push   %edi
    1424:	68 d0 54 00 00       	push   $0x54d0
    1429:	6a 01                	push   $0x1
    142b:	e8 b0 2a 00 00       	call   3ee0 <printf>
        exit();
    1430:	e8 2c 29 00 00       	call   3d61 <exit>
    1435:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001440 <unlinkread>:
{
    1440:	55                   	push   %ebp
    1441:	89 e5                	mov    %esp,%ebp
    1443:	56                   	push   %esi
    1444:	53                   	push   %ebx
  printf(1, "unlinkread test\n");
    1445:	83 ec 08             	sub    $0x8,%esp
    1448:	68 24 47 00 00       	push   $0x4724
    144d:	6a 01                	push   $0x1
    144f:	e8 8c 2a 00 00       	call   3ee0 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1454:	5b                   	pop    %ebx
    1455:	5e                   	pop    %esi
    1456:	68 02 02 00 00       	push   $0x202
    145b:	68 35 47 00 00       	push   $0x4735
    1460:	e8 3c 29 00 00       	call   3da1 <open>
  if(fd < 0){
    1465:	83 c4 10             	add    $0x10,%esp
    1468:	85 c0                	test   %eax,%eax
    146a:	0f 88 e6 00 00 00    	js     1556 <unlinkread+0x116>
  write(fd, "hello", 5);
    1470:	83 ec 04             	sub    $0x4,%esp
    1473:	89 c3                	mov    %eax,%ebx
    1475:	6a 05                	push   $0x5
    1477:	68 5a 47 00 00       	push   $0x475a
    147c:	50                   	push   %eax
    147d:	e8 ff 28 00 00       	call   3d81 <write>
  close(fd);
    1482:	89 1c 24             	mov    %ebx,(%esp)
    1485:	e8 ff 28 00 00       	call   3d89 <close>
  fd = open("unlinkread", O_RDWR);
    148a:	58                   	pop    %eax
    148b:	5a                   	pop    %edx
    148c:	6a 02                	push   $0x2
    148e:	68 35 47 00 00       	push   $0x4735
    1493:	e8 09 29 00 00       	call   3da1 <open>
  if(fd < 0){
    1498:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_RDWR);
    149b:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    149d:	85 c0                	test   %eax,%eax
    149f:	0f 88 10 01 00 00    	js     15b5 <unlinkread+0x175>
  if(unlink("unlinkread") != 0){
    14a5:	83 ec 0c             	sub    $0xc,%esp
    14a8:	68 35 47 00 00       	push   $0x4735
    14ad:	e8 ff 28 00 00       	call   3db1 <unlink>
    14b2:	83 c4 10             	add    $0x10,%esp
    14b5:	85 c0                	test   %eax,%eax
    14b7:	0f 85 e5 00 00 00    	jne    15a2 <unlinkread+0x162>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14bd:	83 ec 08             	sub    $0x8,%esp
    14c0:	68 02 02 00 00       	push   $0x202
    14c5:	68 35 47 00 00       	push   $0x4735
    14ca:	e8 d2 28 00 00       	call   3da1 <open>
  write(fd1, "yyy", 3);
    14cf:	83 c4 0c             	add    $0xc,%esp
    14d2:	6a 03                	push   $0x3
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14d4:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    14d6:	68 92 47 00 00       	push   $0x4792
    14db:	50                   	push   %eax
    14dc:	e8 a0 28 00 00       	call   3d81 <write>
  close(fd1);
    14e1:	89 34 24             	mov    %esi,(%esp)
    14e4:	e8 a0 28 00 00       	call   3d89 <close>
  if(read(fd, buf, sizeof(buf)) != 5){
    14e9:	83 c4 0c             	add    $0xc,%esp
    14ec:	68 00 20 00 00       	push   $0x2000
    14f1:	68 e0 5f 01 00       	push   $0x15fe0
    14f6:	53                   	push   %ebx
    14f7:	e8 7d 28 00 00       	call   3d79 <read>
    14fc:	83 c4 10             	add    $0x10,%esp
    14ff:	83 f8 05             	cmp    $0x5,%eax
    1502:	0f 85 87 00 00 00    	jne    158f <unlinkread+0x14f>
  if(buf[0] != 'h'){
    1508:	80 3d e0 5f 01 00 68 	cmpb   $0x68,0x15fe0
    150f:	75 6b                	jne    157c <unlinkread+0x13c>
  if(write(fd, buf, 10) != 10){
    1511:	83 ec 04             	sub    $0x4,%esp
    1514:	6a 0a                	push   $0xa
    1516:	68 e0 5f 01 00       	push   $0x15fe0
    151b:	53                   	push   %ebx
    151c:	e8 60 28 00 00       	call   3d81 <write>
    1521:	83 c4 10             	add    $0x10,%esp
    1524:	83 f8 0a             	cmp    $0xa,%eax
    1527:	75 40                	jne    1569 <unlinkread+0x129>
  close(fd);
    1529:	83 ec 0c             	sub    $0xc,%esp
    152c:	53                   	push   %ebx
    152d:	e8 57 28 00 00       	call   3d89 <close>
  unlink("unlinkread");
    1532:	c7 04 24 35 47 00 00 	movl   $0x4735,(%esp)
    1539:	e8 73 28 00 00       	call   3db1 <unlink>
  printf(1, "unlinkread ok\n");
    153e:	58                   	pop    %eax
    153f:	5a                   	pop    %edx
    1540:	68 dd 47 00 00       	push   $0x47dd
    1545:	6a 01                	push   $0x1
    1547:	e8 94 29 00 00       	call   3ee0 <printf>
}
    154c:	83 c4 10             	add    $0x10,%esp
    154f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1552:	5b                   	pop    %ebx
    1553:	5e                   	pop    %esi
    1554:	5d                   	pop    %ebp
    1555:	c3                   	ret    
    printf(1, "create unlinkread failed\n");
    1556:	51                   	push   %ecx
    1557:	51                   	push   %ecx
    1558:	68 40 47 00 00       	push   $0x4740
    155d:	6a 01                	push   $0x1
    155f:	e8 7c 29 00 00       	call   3ee0 <printf>
    exit();
    1564:	e8 f8 27 00 00       	call   3d61 <exit>
    printf(1, "unlinkread write failed\n");
    1569:	51                   	push   %ecx
    156a:	51                   	push   %ecx
    156b:	68 c4 47 00 00       	push   $0x47c4
    1570:	6a 01                	push   $0x1
    1572:	e8 69 29 00 00       	call   3ee0 <printf>
    exit();
    1577:	e8 e5 27 00 00       	call   3d61 <exit>
    printf(1, "unlinkread wrong data\n");
    157c:	53                   	push   %ebx
    157d:	53                   	push   %ebx
    157e:	68 ad 47 00 00       	push   $0x47ad
    1583:	6a 01                	push   $0x1
    1585:	e8 56 29 00 00       	call   3ee0 <printf>
    exit();
    158a:	e8 d2 27 00 00       	call   3d61 <exit>
    printf(1, "unlinkread read failed");
    158f:	56                   	push   %esi
    1590:	56                   	push   %esi
    1591:	68 96 47 00 00       	push   $0x4796
    1596:	6a 01                	push   $0x1
    1598:	e8 43 29 00 00       	call   3ee0 <printf>
    exit();
    159d:	e8 bf 27 00 00       	call   3d61 <exit>
    printf(1, "unlink unlinkread failed\n");
    15a2:	50                   	push   %eax
    15a3:	50                   	push   %eax
    15a4:	68 78 47 00 00       	push   $0x4778
    15a9:	6a 01                	push   $0x1
    15ab:	e8 30 29 00 00       	call   3ee0 <printf>
    exit();
    15b0:	e8 ac 27 00 00       	call   3d61 <exit>
    printf(1, "open unlinkread failed\n");
    15b5:	50                   	push   %eax
    15b6:	50                   	push   %eax
    15b7:	68 60 47 00 00       	push   $0x4760
    15bc:	6a 01                	push   $0x1
    15be:	e8 1d 29 00 00       	call   3ee0 <printf>
    exit();
    15c3:	e8 99 27 00 00       	call   3d61 <exit>
    15c8:	90                   	nop
    15c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000015d0 <linktest>:
{
    15d0:	55                   	push   %ebp
    15d1:	89 e5                	mov    %esp,%ebp
    15d3:	53                   	push   %ebx
    15d4:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "linktest\n");
    15d7:	68 ec 47 00 00       	push   $0x47ec
    15dc:	6a 01                	push   $0x1
    15de:	e8 fd 28 00 00       	call   3ee0 <printf>
  unlink("lf1");
    15e3:	c7 04 24 f6 47 00 00 	movl   $0x47f6,(%esp)
    15ea:	e8 c2 27 00 00       	call   3db1 <unlink>
  unlink("lf2");
    15ef:	c7 04 24 fa 47 00 00 	movl   $0x47fa,(%esp)
    15f6:	e8 b6 27 00 00       	call   3db1 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    15fb:	58                   	pop    %eax
    15fc:	5a                   	pop    %edx
    15fd:	68 02 02 00 00       	push   $0x202
    1602:	68 f6 47 00 00       	push   $0x47f6
    1607:	e8 95 27 00 00       	call   3da1 <open>
  if(fd < 0){
    160c:	83 c4 10             	add    $0x10,%esp
    160f:	85 c0                	test   %eax,%eax
    1611:	0f 88 1e 01 00 00    	js     1735 <linktest+0x165>
  if(write(fd, "hello", 5) != 5){
    1617:	83 ec 04             	sub    $0x4,%esp
    161a:	89 c3                	mov    %eax,%ebx
    161c:	6a 05                	push   $0x5
    161e:	68 5a 47 00 00       	push   $0x475a
    1623:	50                   	push   %eax
    1624:	e8 58 27 00 00       	call   3d81 <write>
    1629:	83 c4 10             	add    $0x10,%esp
    162c:	83 f8 05             	cmp    $0x5,%eax
    162f:	0f 85 98 01 00 00    	jne    17cd <linktest+0x1fd>
  close(fd);
    1635:	83 ec 0c             	sub    $0xc,%esp
    1638:	53                   	push   %ebx
    1639:	e8 4b 27 00 00       	call   3d89 <close>
  if(link("lf1", "lf2") < 0){
    163e:	5b                   	pop    %ebx
    163f:	58                   	pop    %eax
    1640:	68 fa 47 00 00       	push   $0x47fa
    1645:	68 f6 47 00 00       	push   $0x47f6
    164a:	e8 72 27 00 00       	call   3dc1 <link>
    164f:	83 c4 10             	add    $0x10,%esp
    1652:	85 c0                	test   %eax,%eax
    1654:	0f 88 60 01 00 00    	js     17ba <linktest+0x1ea>
  unlink("lf1");
    165a:	83 ec 0c             	sub    $0xc,%esp
    165d:	68 f6 47 00 00       	push   $0x47f6
    1662:	e8 4a 27 00 00       	call   3db1 <unlink>
  if(open("lf1", 0) >= 0){
    1667:	58                   	pop    %eax
    1668:	5a                   	pop    %edx
    1669:	6a 00                	push   $0x0
    166b:	68 f6 47 00 00       	push   $0x47f6
    1670:	e8 2c 27 00 00       	call   3da1 <open>
    1675:	83 c4 10             	add    $0x10,%esp
    1678:	85 c0                	test   %eax,%eax
    167a:	0f 89 27 01 00 00    	jns    17a7 <linktest+0x1d7>
  fd = open("lf2", 0);
    1680:	83 ec 08             	sub    $0x8,%esp
    1683:	6a 00                	push   $0x0
    1685:	68 fa 47 00 00       	push   $0x47fa
    168a:	e8 12 27 00 00       	call   3da1 <open>
  if(fd < 0){
    168f:	83 c4 10             	add    $0x10,%esp
  fd = open("lf2", 0);
    1692:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1694:	85 c0                	test   %eax,%eax
    1696:	0f 88 f8 00 00 00    	js     1794 <linktest+0x1c4>
  if(read(fd, buf, sizeof(buf)) != 5){
    169c:	83 ec 04             	sub    $0x4,%esp
    169f:	68 00 20 00 00       	push   $0x2000
    16a4:	68 e0 5f 01 00       	push   $0x15fe0
    16a9:	50                   	push   %eax
    16aa:	e8 ca 26 00 00       	call   3d79 <read>
    16af:	83 c4 10             	add    $0x10,%esp
    16b2:	83 f8 05             	cmp    $0x5,%eax
    16b5:	0f 85 c6 00 00 00    	jne    1781 <linktest+0x1b1>
  close(fd);
    16bb:	83 ec 0c             	sub    $0xc,%esp
    16be:	53                   	push   %ebx
    16bf:	e8 c5 26 00 00       	call   3d89 <close>
  if(link("lf2", "lf2") >= 0){
    16c4:	58                   	pop    %eax
    16c5:	5a                   	pop    %edx
    16c6:	68 fa 47 00 00       	push   $0x47fa
    16cb:	68 fa 47 00 00       	push   $0x47fa
    16d0:	e8 ec 26 00 00       	call   3dc1 <link>
    16d5:	83 c4 10             	add    $0x10,%esp
    16d8:	85 c0                	test   %eax,%eax
    16da:	0f 89 8e 00 00 00    	jns    176e <linktest+0x19e>
  unlink("lf2");
    16e0:	83 ec 0c             	sub    $0xc,%esp
    16e3:	68 fa 47 00 00       	push   $0x47fa
    16e8:	e8 c4 26 00 00       	call   3db1 <unlink>
  if(link("lf2", "lf1") >= 0){
    16ed:	59                   	pop    %ecx
    16ee:	5b                   	pop    %ebx
    16ef:	68 f6 47 00 00       	push   $0x47f6
    16f4:	68 fa 47 00 00       	push   $0x47fa
    16f9:	e8 c3 26 00 00       	call   3dc1 <link>
    16fe:	83 c4 10             	add    $0x10,%esp
    1701:	85 c0                	test   %eax,%eax
    1703:	79 56                	jns    175b <linktest+0x18b>
  if(link(".", "lf1") >= 0){
    1705:	83 ec 08             	sub    $0x8,%esp
    1708:	68 f6 47 00 00       	push   $0x47f6
    170d:	68 be 4a 00 00       	push   $0x4abe
    1712:	e8 aa 26 00 00       	call   3dc1 <link>
    1717:	83 c4 10             	add    $0x10,%esp
    171a:	85 c0                	test   %eax,%eax
    171c:	79 2a                	jns    1748 <linktest+0x178>
  printf(1, "linktest ok\n");
    171e:	83 ec 08             	sub    $0x8,%esp
    1721:	68 94 48 00 00       	push   $0x4894
    1726:	6a 01                	push   $0x1
    1728:	e8 b3 27 00 00       	call   3ee0 <printf>
}
    172d:	83 c4 10             	add    $0x10,%esp
    1730:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1733:	c9                   	leave  
    1734:	c3                   	ret    
    printf(1, "create lf1 failed\n");
    1735:	50                   	push   %eax
    1736:	50                   	push   %eax
    1737:	68 fe 47 00 00       	push   $0x47fe
    173c:	6a 01                	push   $0x1
    173e:	e8 9d 27 00 00       	call   3ee0 <printf>
    exit();
    1743:	e8 19 26 00 00       	call   3d61 <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    1748:	50                   	push   %eax
    1749:	50                   	push   %eax
    174a:	68 78 48 00 00       	push   $0x4878
    174f:	6a 01                	push   $0x1
    1751:	e8 8a 27 00 00       	call   3ee0 <printf>
    exit();
    1756:	e8 06 26 00 00       	call   3d61 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    175b:	52                   	push   %edx
    175c:	52                   	push   %edx
    175d:	68 18 55 00 00       	push   $0x5518
    1762:	6a 01                	push   $0x1
    1764:	e8 77 27 00 00       	call   3ee0 <printf>
    exit();
    1769:	e8 f3 25 00 00       	call   3d61 <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    176e:	50                   	push   %eax
    176f:	50                   	push   %eax
    1770:	68 5a 48 00 00       	push   $0x485a
    1775:	6a 01                	push   $0x1
    1777:	e8 64 27 00 00       	call   3ee0 <printf>
    exit();
    177c:	e8 e0 25 00 00       	call   3d61 <exit>
    printf(1, "read lf2 failed\n");
    1781:	51                   	push   %ecx
    1782:	51                   	push   %ecx
    1783:	68 49 48 00 00       	push   $0x4849
    1788:	6a 01                	push   $0x1
    178a:	e8 51 27 00 00       	call   3ee0 <printf>
    exit();
    178f:	e8 cd 25 00 00       	call   3d61 <exit>
    printf(1, "open lf2 failed\n");
    1794:	53                   	push   %ebx
    1795:	53                   	push   %ebx
    1796:	68 38 48 00 00       	push   $0x4838
    179b:	6a 01                	push   $0x1
    179d:	e8 3e 27 00 00       	call   3ee0 <printf>
    exit();
    17a2:	e8 ba 25 00 00       	call   3d61 <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    17a7:	50                   	push   %eax
    17a8:	50                   	push   %eax
    17a9:	68 f0 54 00 00       	push   $0x54f0
    17ae:	6a 01                	push   $0x1
    17b0:	e8 2b 27 00 00       	call   3ee0 <printf>
    exit();
    17b5:	e8 a7 25 00 00       	call   3d61 <exit>
    printf(1, "link lf1 lf2 failed\n");
    17ba:	51                   	push   %ecx
    17bb:	51                   	push   %ecx
    17bc:	68 23 48 00 00       	push   $0x4823
    17c1:	6a 01                	push   $0x1
    17c3:	e8 18 27 00 00       	call   3ee0 <printf>
    exit();
    17c8:	e8 94 25 00 00       	call   3d61 <exit>
    printf(1, "write lf1 failed\n");
    17cd:	50                   	push   %eax
    17ce:	50                   	push   %eax
    17cf:	68 11 48 00 00       	push   $0x4811
    17d4:	6a 01                	push   $0x1
    17d6:	e8 05 27 00 00       	call   3ee0 <printf>
    exit();
    17db:	e8 81 25 00 00       	call   3d61 <exit>

000017e0 <concreate>:
{
    17e0:	55                   	push   %ebp
    17e1:	89 e5                	mov    %esp,%ebp
    17e3:	57                   	push   %edi
    if(pid && (i % 3) == 1){
    17e4:	bf ab aa aa aa       	mov    $0xaaaaaaab,%edi
{
    17e9:	56                   	push   %esi
  for(i = 0; i < 40; i++){
    17ea:	31 f6                	xor    %esi,%esi
{
    17ec:	53                   	push   %ebx
    17ed:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    17f0:	83 ec 64             	sub    $0x64,%esp
  printf(1, "concreate test\n");
    17f3:	68 a1 48 00 00       	push   $0x48a1
    17f8:	6a 01                	push   $0x1
    17fa:	e8 e1 26 00 00       	call   3ee0 <printf>
  file[0] = 'C';
    17ff:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    1803:	83 c4 10             	add    $0x10,%esp
    1806:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
  for(i = 0; i < 40; i++){
    180a:	eb 4c                	jmp    1858 <concreate+0x78>
    180c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid && (i % 3) == 1){
    1810:	89 f0                	mov    %esi,%eax
    1812:	89 f1                	mov    %esi,%ecx
    1814:	f7 e7                	mul    %edi
    1816:	d1 ea                	shr    %edx
    1818:	8d 04 52             	lea    (%edx,%edx,2),%eax
    181b:	29 c1                	sub    %eax,%ecx
    181d:	83 f9 01             	cmp    $0x1,%ecx
    1820:	0f 84 ba 00 00 00    	je     18e0 <concreate+0x100>
      fd = open(file, O_CREATE | O_RDWR);
    1826:	83 ec 08             	sub    $0x8,%esp
    1829:	68 02 02 00 00       	push   $0x202
    182e:	53                   	push   %ebx
    182f:	e8 6d 25 00 00       	call   3da1 <open>
      if(fd < 0){
    1834:	83 c4 10             	add    $0x10,%esp
    1837:	85 c0                	test   %eax,%eax
    1839:	78 67                	js     18a2 <concreate+0xc2>
      close(fd);
    183b:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 40; i++){
    183e:	83 c6 01             	add    $0x1,%esi
      close(fd);
    1841:	50                   	push   %eax
    1842:	e8 42 25 00 00       	call   3d89 <close>
    1847:	83 c4 10             	add    $0x10,%esp
      wait();
    184a:	e8 1a 25 00 00       	call   3d69 <wait>
  for(i = 0; i < 40; i++){
    184f:	83 fe 28             	cmp    $0x28,%esi
    1852:	0f 84 aa 00 00 00    	je     1902 <concreate+0x122>
    unlink(file);
    1858:	83 ec 0c             	sub    $0xc,%esp
    file[1] = '0' + i;
    185b:	8d 46 30             	lea    0x30(%esi),%eax
    unlink(file);
    185e:	53                   	push   %ebx
    file[1] = '0' + i;
    185f:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    1862:	e8 4a 25 00 00       	call   3db1 <unlink>
    pid = fork();
    1867:	e8 ed 24 00 00       	call   3d59 <fork>
    if(pid && (i % 3) == 1){
    186c:	83 c4 10             	add    $0x10,%esp
    186f:	85 c0                	test   %eax,%eax
    1871:	75 9d                	jne    1810 <concreate+0x30>
    } else if(pid == 0 && (i % 5) == 1){
    1873:	89 f0                	mov    %esi,%eax
    1875:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    187a:	f7 e2                	mul    %edx
    187c:	c1 ea 02             	shr    $0x2,%edx
    187f:	8d 04 92             	lea    (%edx,%edx,4),%eax
    1882:	29 c6                	sub    %eax,%esi
    1884:	83 fe 01             	cmp    $0x1,%esi
    1887:	74 37                	je     18c0 <concreate+0xe0>
      fd = open(file, O_CREATE | O_RDWR);
    1889:	83 ec 08             	sub    $0x8,%esp
    188c:	68 02 02 00 00       	push   $0x202
    1891:	53                   	push   %ebx
    1892:	e8 0a 25 00 00       	call   3da1 <open>
      if(fd < 0){
    1897:	83 c4 10             	add    $0x10,%esp
    189a:	85 c0                	test   %eax,%eax
    189c:	0f 89 2c 02 00 00    	jns    1ace <concreate+0x2ee>
        printf(1, "concreate create %s failed\n", file);
    18a2:	83 ec 04             	sub    $0x4,%esp
    18a5:	53                   	push   %ebx
    18a6:	68 b4 48 00 00       	push   $0x48b4
    18ab:	6a 01                	push   $0x1
    18ad:	e8 2e 26 00 00       	call   3ee0 <printf>
        exit();
    18b2:	e8 aa 24 00 00       	call   3d61 <exit>
    18b7:	89 f6                	mov    %esi,%esi
    18b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      link("C0", file);
    18c0:	83 ec 08             	sub    $0x8,%esp
    18c3:	53                   	push   %ebx
    18c4:	68 b1 48 00 00       	push   $0x48b1
    18c9:	e8 f3 24 00 00       	call   3dc1 <link>
    18ce:	83 c4 10             	add    $0x10,%esp
      exit();
    18d1:	e8 8b 24 00 00       	call   3d61 <exit>
    18d6:	8d 76 00             	lea    0x0(%esi),%esi
    18d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      link("C0", file);
    18e0:	83 ec 08             	sub    $0x8,%esp
  for(i = 0; i < 40; i++){
    18e3:	83 c6 01             	add    $0x1,%esi
      link("C0", file);
    18e6:	53                   	push   %ebx
    18e7:	68 b1 48 00 00       	push   $0x48b1
    18ec:	e8 d0 24 00 00       	call   3dc1 <link>
    18f1:	83 c4 10             	add    $0x10,%esp
      wait();
    18f4:	e8 70 24 00 00       	call   3d69 <wait>
  for(i = 0; i < 40; i++){
    18f9:	83 fe 28             	cmp    $0x28,%esi
    18fc:	0f 85 56 ff ff ff    	jne    1858 <concreate+0x78>
  memset(fa, 0, sizeof(fa));
    1902:	83 ec 04             	sub    $0x4,%esp
    1905:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1908:	6a 28                	push   $0x28
    190a:	6a 00                	push   $0x0
    190c:	50                   	push   %eax
    190d:	e8 ae 22 00 00       	call   3bc0 <memset>
  fd = open(".", 0);
    1912:	5e                   	pop    %esi
    1913:	5f                   	pop    %edi
    1914:	6a 00                	push   $0x0
    1916:	68 be 4a 00 00       	push   $0x4abe
    191b:	8d 7d b0             	lea    -0x50(%ebp),%edi
    191e:	e8 7e 24 00 00       	call   3da1 <open>
  n = 0;
    1923:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    192a:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    192d:	89 c6                	mov    %eax,%esi
  n = 0;
    192f:	90                   	nop
  while(read(fd, &de, sizeof(de)) > 0){
    1930:	83 ec 04             	sub    $0x4,%esp
    1933:	6a 10                	push   $0x10
    1935:	57                   	push   %edi
    1936:	56                   	push   %esi
    1937:	e8 3d 24 00 00       	call   3d79 <read>
    193c:	83 c4 10             	add    $0x10,%esp
    193f:	85 c0                	test   %eax,%eax
    1941:	7e 3d                	jle    1980 <concreate+0x1a0>
    if(de.inum == 0)
    1943:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1948:	74 e6                	je     1930 <concreate+0x150>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    194a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    194e:	75 e0                	jne    1930 <concreate+0x150>
    1950:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1954:	75 da                	jne    1930 <concreate+0x150>
      i = de.name[1] - '0';
    1956:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    195a:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    195d:	83 f8 27             	cmp    $0x27,%eax
    1960:	0f 87 50 01 00 00    	ja     1ab6 <concreate+0x2d6>
      if(fa[i]){
    1966:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    196b:	0f 85 2d 01 00 00    	jne    1a9e <concreate+0x2be>
      fa[i] = 1;
    1971:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    1976:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    197a:	eb b4                	jmp    1930 <concreate+0x150>
    197c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  close(fd);
    1980:	83 ec 0c             	sub    $0xc,%esp
    1983:	56                   	push   %esi
    1984:	e8 00 24 00 00       	call   3d89 <close>
  if(n != 40){
    1989:	83 c4 10             	add    $0x10,%esp
    198c:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1990:	0f 85 f5 00 00 00    	jne    1a8b <concreate+0x2ab>
  for(i = 0; i < 40; i++){
    1996:	31 f6                	xor    %esi,%esi
    1998:	eb 48                	jmp    19e2 <concreate+0x202>
    199a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
       ((i % 3) == 1 && pid != 0)){
    19a0:	85 ff                	test   %edi,%edi
    19a2:	74 05                	je     19a9 <concreate+0x1c9>
    19a4:	83 fa 01             	cmp    $0x1,%edx
    19a7:	74 64                	je     1a0d <concreate+0x22d>
      unlink(file);
    19a9:	83 ec 0c             	sub    $0xc,%esp
    19ac:	53                   	push   %ebx
    19ad:	e8 ff 23 00 00       	call   3db1 <unlink>
      unlink(file);
    19b2:	89 1c 24             	mov    %ebx,(%esp)
    19b5:	e8 f7 23 00 00       	call   3db1 <unlink>
      unlink(file);
    19ba:	89 1c 24             	mov    %ebx,(%esp)
    19bd:	e8 ef 23 00 00       	call   3db1 <unlink>
      unlink(file);
    19c2:	89 1c 24             	mov    %ebx,(%esp)
    19c5:	e8 e7 23 00 00       	call   3db1 <unlink>
    19ca:	83 c4 10             	add    $0x10,%esp
    if(pid == 0)
    19cd:	85 ff                	test   %edi,%edi
    19cf:	0f 84 fc fe ff ff    	je     18d1 <concreate+0xf1>
      wait();
    19d5:	e8 8f 23 00 00       	call   3d69 <wait>
  for(i = 0; i < 40; i++){
    19da:	83 c6 01             	add    $0x1,%esi
    19dd:	83 fe 28             	cmp    $0x28,%esi
    19e0:	74 7e                	je     1a60 <concreate+0x280>
    file[1] = '0' + i;
    19e2:	8d 46 30             	lea    0x30(%esi),%eax
    19e5:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork();
    19e8:	e8 6c 23 00 00       	call   3d59 <fork>
    19ed:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    19ef:	85 c0                	test   %eax,%eax
    19f1:	0f 88 80 00 00 00    	js     1a77 <concreate+0x297>
    if(((i % 3) == 0 && pid == 0) ||
    19f7:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    19fc:	f7 e6                	mul    %esi
    19fe:	d1 ea                	shr    %edx
    1a00:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1a03:	89 f2                	mov    %esi,%edx
    1a05:	29 c2                	sub    %eax,%edx
    1a07:	89 d0                	mov    %edx,%eax
    1a09:	09 f8                	or     %edi,%eax
    1a0b:	75 93                	jne    19a0 <concreate+0x1c0>
      close(open(file, 0));
    1a0d:	83 ec 08             	sub    $0x8,%esp
    1a10:	6a 00                	push   $0x0
    1a12:	53                   	push   %ebx
    1a13:	e8 89 23 00 00       	call   3da1 <open>
    1a18:	89 04 24             	mov    %eax,(%esp)
    1a1b:	e8 69 23 00 00       	call   3d89 <close>
      close(open(file, 0));
    1a20:	58                   	pop    %eax
    1a21:	5a                   	pop    %edx
    1a22:	6a 00                	push   $0x0
    1a24:	53                   	push   %ebx
    1a25:	e8 77 23 00 00       	call   3da1 <open>
    1a2a:	89 04 24             	mov    %eax,(%esp)
    1a2d:	e8 57 23 00 00       	call   3d89 <close>
      close(open(file, 0));
    1a32:	59                   	pop    %ecx
    1a33:	58                   	pop    %eax
    1a34:	6a 00                	push   $0x0
    1a36:	53                   	push   %ebx
    1a37:	e8 65 23 00 00       	call   3da1 <open>
    1a3c:	89 04 24             	mov    %eax,(%esp)
    1a3f:	e8 45 23 00 00       	call   3d89 <close>
      close(open(file, 0));
    1a44:	58                   	pop    %eax
    1a45:	5a                   	pop    %edx
    1a46:	6a 00                	push   $0x0
    1a48:	53                   	push   %ebx
    1a49:	e8 53 23 00 00       	call   3da1 <open>
    1a4e:	89 04 24             	mov    %eax,(%esp)
    1a51:	e8 33 23 00 00       	call   3d89 <close>
    1a56:	83 c4 10             	add    $0x10,%esp
    1a59:	e9 6f ff ff ff       	jmp    19cd <concreate+0x1ed>
    1a5e:	66 90                	xchg   %ax,%ax
  printf(1, "concreate ok\n");
    1a60:	83 ec 08             	sub    $0x8,%esp
    1a63:	68 06 49 00 00       	push   $0x4906
    1a68:	6a 01                	push   $0x1
    1a6a:	e8 71 24 00 00       	call   3ee0 <printf>
}
    1a6f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a72:	5b                   	pop    %ebx
    1a73:	5e                   	pop    %esi
    1a74:	5f                   	pop    %edi
    1a75:	5d                   	pop    %ebp
    1a76:	c3                   	ret    
      printf(1, "fork failed\n");
    1a77:	83 ec 08             	sub    $0x8,%esp
    1a7a:	68 42 52 00 00       	push   $0x5242
    1a7f:	6a 01                	push   $0x1
    1a81:	e8 5a 24 00 00       	call   3ee0 <printf>
      exit();
    1a86:	e8 d6 22 00 00       	call   3d61 <exit>
    printf(1, "concreate not enough files in directory listing\n");
    1a8b:	51                   	push   %ecx
    1a8c:	51                   	push   %ecx
    1a8d:	68 3c 55 00 00       	push   $0x553c
    1a92:	6a 01                	push   $0x1
    1a94:	e8 47 24 00 00       	call   3ee0 <printf>
    exit();
    1a99:	e8 c3 22 00 00       	call   3d61 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    1a9e:	83 ec 04             	sub    $0x4,%esp
    1aa1:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1aa4:	50                   	push   %eax
    1aa5:	68 e9 48 00 00       	push   $0x48e9
    1aaa:	6a 01                	push   $0x1
    1aac:	e8 2f 24 00 00       	call   3ee0 <printf>
        exit();
    1ab1:	e8 ab 22 00 00       	call   3d61 <exit>
        printf(1, "concreate weird file %s\n", de.name);
    1ab6:	83 ec 04             	sub    $0x4,%esp
    1ab9:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1abc:	50                   	push   %eax
    1abd:	68 d0 48 00 00       	push   $0x48d0
    1ac2:	6a 01                	push   $0x1
    1ac4:	e8 17 24 00 00       	call   3ee0 <printf>
        exit();
    1ac9:	e8 93 22 00 00       	call   3d61 <exit>
      close(fd);
    1ace:	83 ec 0c             	sub    $0xc,%esp
    1ad1:	50                   	push   %eax
    1ad2:	e8 b2 22 00 00       	call   3d89 <close>
    1ad7:	83 c4 10             	add    $0x10,%esp
    1ada:	e9 f2 fd ff ff       	jmp    18d1 <concreate+0xf1>
    1adf:	90                   	nop

00001ae0 <linkunlink>:
{
    1ae0:	55                   	push   %ebp
    1ae1:	89 e5                	mov    %esp,%ebp
    1ae3:	57                   	push   %edi
    1ae4:	56                   	push   %esi
    1ae5:	53                   	push   %ebx
    1ae6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "linkunlink test\n");
    1ae9:	68 14 49 00 00       	push   $0x4914
    1aee:	6a 01                	push   $0x1
    1af0:	e8 eb 23 00 00       	call   3ee0 <printf>
  unlink("x");
    1af5:	c7 04 24 a1 4b 00 00 	movl   $0x4ba1,(%esp)
    1afc:	e8 b0 22 00 00       	call   3db1 <unlink>
  pid = fork();
    1b01:	e8 53 22 00 00       	call   3d59 <fork>
  if(pid < 0){
    1b06:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    1b09:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1b0c:	85 c0                	test   %eax,%eax
    1b0e:	0f 88 b6 00 00 00    	js     1bca <linkunlink+0xea>
  unsigned int x = (pid ? 1 : 97);
    1b14:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1b18:	bb 64 00 00 00       	mov    $0x64,%ebx
    if((x % 3) == 0){
    1b1d:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  unsigned int x = (pid ? 1 : 97);
    1b22:	19 ff                	sbb    %edi,%edi
    1b24:	83 e7 60             	and    $0x60,%edi
    1b27:	83 c7 01             	add    $0x1,%edi
    1b2a:	eb 1e                	jmp    1b4a <linkunlink+0x6a>
    1b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if((x % 3) == 1){
    1b30:	83 fa 01             	cmp    $0x1,%edx
    1b33:	74 7b                	je     1bb0 <linkunlink+0xd0>
      unlink("x");
    1b35:	83 ec 0c             	sub    $0xc,%esp
    1b38:	68 a1 4b 00 00       	push   $0x4ba1
    1b3d:	e8 6f 22 00 00       	call   3db1 <unlink>
    1b42:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b45:	83 eb 01             	sub    $0x1,%ebx
    1b48:	74 3d                	je     1b87 <linkunlink+0xa7>
    x = x * 1103515245 + 12345;
    1b4a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1b50:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    1b56:	89 f8                	mov    %edi,%eax
    1b58:	f7 e6                	mul    %esi
    1b5a:	d1 ea                	shr    %edx
    1b5c:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1b5f:	89 fa                	mov    %edi,%edx
    1b61:	29 c2                	sub    %eax,%edx
    1b63:	75 cb                	jne    1b30 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    1b65:	83 ec 08             	sub    $0x8,%esp
    1b68:	68 02 02 00 00       	push   $0x202
    1b6d:	68 a1 4b 00 00       	push   $0x4ba1
    1b72:	e8 2a 22 00 00       	call   3da1 <open>
    1b77:	89 04 24             	mov    %eax,(%esp)
    1b7a:	e8 0a 22 00 00       	call   3d89 <close>
    1b7f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b82:	83 eb 01             	sub    $0x1,%ebx
    1b85:	75 c3                	jne    1b4a <linkunlink+0x6a>
  if(pid)
    1b87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b8a:	85 c0                	test   %eax,%eax
    1b8c:	74 4f                	je     1bdd <linkunlink+0xfd>
    wait();
    1b8e:	e8 d6 21 00 00       	call   3d69 <wait>
  printf(1, "linkunlink ok\n");
    1b93:	83 ec 08             	sub    $0x8,%esp
    1b96:	68 29 49 00 00       	push   $0x4929
    1b9b:	6a 01                	push   $0x1
    1b9d:	e8 3e 23 00 00       	call   3ee0 <printf>
}
    1ba2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1ba5:	5b                   	pop    %ebx
    1ba6:	5e                   	pop    %esi
    1ba7:	5f                   	pop    %edi
    1ba8:	5d                   	pop    %ebp
    1ba9:	c3                   	ret    
    1baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      link("cat", "x");
    1bb0:	83 ec 08             	sub    $0x8,%esp
    1bb3:	68 a1 4b 00 00       	push   $0x4ba1
    1bb8:	68 25 49 00 00       	push   $0x4925
    1bbd:	e8 ff 21 00 00       	call   3dc1 <link>
    1bc2:	83 c4 10             	add    $0x10,%esp
    1bc5:	e9 7b ff ff ff       	jmp    1b45 <linkunlink+0x65>
    printf(1, "fork failed\n");
    1bca:	52                   	push   %edx
    1bcb:	52                   	push   %edx
    1bcc:	68 42 52 00 00       	push   $0x5242
    1bd1:	6a 01                	push   $0x1
    1bd3:	e8 08 23 00 00       	call   3ee0 <printf>
    exit();
    1bd8:	e8 84 21 00 00       	call   3d61 <exit>
    exit();
    1bdd:	e8 7f 21 00 00       	call   3d61 <exit>
    1be2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001bf0 <bigdir>:
{
    1bf0:	55                   	push   %ebp
    1bf1:	89 e5                	mov    %esp,%ebp
    1bf3:	57                   	push   %edi
    1bf4:	56                   	push   %esi
    1bf5:	53                   	push   %ebx
    1bf6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "bigdir test\n");
    1bf9:	68 38 49 00 00       	push   $0x4938
    1bfe:	6a 01                	push   $0x1
    1c00:	e8 db 22 00 00       	call   3ee0 <printf>
  unlink("bd");
    1c05:	c7 04 24 45 49 00 00 	movl   $0x4945,(%esp)
    1c0c:	e8 a0 21 00 00       	call   3db1 <unlink>
  fd = open("bd", O_CREATE);
    1c11:	5a                   	pop    %edx
    1c12:	59                   	pop    %ecx
    1c13:	68 00 02 00 00       	push   $0x200
    1c18:	68 45 49 00 00       	push   $0x4945
    1c1d:	e8 7f 21 00 00       	call   3da1 <open>
  if(fd < 0){
    1c22:	83 c4 10             	add    $0x10,%esp
    1c25:	85 c0                	test   %eax,%eax
    1c27:	0f 88 de 00 00 00    	js     1d0b <bigdir+0x11b>
  close(fd);
    1c2d:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 500; i++){
    1c30:	31 f6                	xor    %esi,%esi
    1c32:	8d 7d de             	lea    -0x22(%ebp),%edi
  close(fd);
    1c35:	50                   	push   %eax
    1c36:	e8 4e 21 00 00       	call   3d89 <close>
    1c3b:	83 c4 10             	add    $0x10,%esp
    1c3e:	66 90                	xchg   %ax,%ax
    name[1] = '0' + (i / 64);
    1c40:	89 f0                	mov    %esi,%eax
    if(link("bd", name) != 0){
    1c42:	83 ec 08             	sub    $0x8,%esp
    name[0] = 'x';
    1c45:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1c49:	c1 f8 06             	sar    $0x6,%eax
    if(link("bd", name) != 0){
    1c4c:	57                   	push   %edi
    name[1] = '0' + (i / 64);
    1c4d:	83 c0 30             	add    $0x30,%eax
    if(link("bd", name) != 0){
    1c50:	68 45 49 00 00       	push   $0x4945
    name[1] = '0' + (i / 64);
    1c55:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1c58:	89 f0                	mov    %esi,%eax
    1c5a:	83 e0 3f             	and    $0x3f,%eax
    name[3] = '\0';
    1c5d:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[2] = '0' + (i % 64);
    1c61:	83 c0 30             	add    $0x30,%eax
    1c64:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(link("bd", name) != 0){
    1c67:	e8 55 21 00 00       	call   3dc1 <link>
    1c6c:	83 c4 10             	add    $0x10,%esp
    1c6f:	89 c3                	mov    %eax,%ebx
    1c71:	85 c0                	test   %eax,%eax
    1c73:	75 6e                	jne    1ce3 <bigdir+0xf3>
  for(i = 0; i < 500; i++){
    1c75:	83 c6 01             	add    $0x1,%esi
    1c78:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1c7e:	75 c0                	jne    1c40 <bigdir+0x50>
  unlink("bd");
    1c80:	83 ec 0c             	sub    $0xc,%esp
    1c83:	68 45 49 00 00       	push   $0x4945
    1c88:	e8 24 21 00 00       	call   3db1 <unlink>
    1c8d:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + (i / 64);
    1c90:	89 d8                	mov    %ebx,%eax
    if(unlink(name) != 0){
    1c92:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'x';
    1c95:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1c99:	c1 f8 06             	sar    $0x6,%eax
    if(unlink(name) != 0){
    1c9c:	57                   	push   %edi
    name[1] = '0' + (i / 64);
    1c9d:	83 c0 30             	add    $0x30,%eax
    name[3] = '\0';
    1ca0:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[1] = '0' + (i / 64);
    1ca4:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1ca7:	89 d8                	mov    %ebx,%eax
    1ca9:	83 e0 3f             	and    $0x3f,%eax
    1cac:	83 c0 30             	add    $0x30,%eax
    1caf:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(unlink(name) != 0){
    1cb2:	e8 fa 20 00 00       	call   3db1 <unlink>
    1cb7:	83 c4 10             	add    $0x10,%esp
    1cba:	85 c0                	test   %eax,%eax
    1cbc:	75 39                	jne    1cf7 <bigdir+0x107>
  for(i = 0; i < 500; i++){
    1cbe:	83 c3 01             	add    $0x1,%ebx
    1cc1:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1cc7:	75 c7                	jne    1c90 <bigdir+0xa0>
  printf(1, "bigdir ok\n");
    1cc9:	83 ec 08             	sub    $0x8,%esp
    1ccc:	68 87 49 00 00       	push   $0x4987
    1cd1:	6a 01                	push   $0x1
    1cd3:	e8 08 22 00 00       	call   3ee0 <printf>
    1cd8:	83 c4 10             	add    $0x10,%esp
}
    1cdb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1cde:	5b                   	pop    %ebx
    1cdf:	5e                   	pop    %esi
    1ce0:	5f                   	pop    %edi
    1ce1:	5d                   	pop    %ebp
    1ce2:	c3                   	ret    
      printf(1, "bigdir link failed\n");
    1ce3:	83 ec 08             	sub    $0x8,%esp
    1ce6:	68 5e 49 00 00       	push   $0x495e
    1ceb:	6a 01                	push   $0x1
    1ced:	e8 ee 21 00 00       	call   3ee0 <printf>
      exit();
    1cf2:	e8 6a 20 00 00       	call   3d61 <exit>
      printf(1, "bigdir unlink failed");
    1cf7:	83 ec 08             	sub    $0x8,%esp
    1cfa:	68 72 49 00 00       	push   $0x4972
    1cff:	6a 01                	push   $0x1
    1d01:	e8 da 21 00 00       	call   3ee0 <printf>
      exit();
    1d06:	e8 56 20 00 00       	call   3d61 <exit>
    printf(1, "bigdir create failed\n");
    1d0b:	50                   	push   %eax
    1d0c:	50                   	push   %eax
    1d0d:	68 48 49 00 00       	push   $0x4948
    1d12:	6a 01                	push   $0x1
    1d14:	e8 c7 21 00 00       	call   3ee0 <printf>
    exit();
    1d19:	e8 43 20 00 00       	call   3d61 <exit>
    1d1e:	66 90                	xchg   %ax,%ax

00001d20 <subdir>:
{
    1d20:	55                   	push   %ebp
    1d21:	89 e5                	mov    %esp,%ebp
    1d23:	53                   	push   %ebx
    1d24:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "subdir test\n");
    1d27:	68 92 49 00 00       	push   $0x4992
    1d2c:	6a 01                	push   $0x1
    1d2e:	e8 ad 21 00 00       	call   3ee0 <printf>
  unlink("ff");
    1d33:	c7 04 24 1b 4a 00 00 	movl   $0x4a1b,(%esp)
    1d3a:	e8 72 20 00 00       	call   3db1 <unlink>
  if(mkdir("dd") != 0){
    1d3f:	c7 04 24 b8 4a 00 00 	movl   $0x4ab8,(%esp)
    1d46:	e8 7e 20 00 00       	call   3dc9 <mkdir>
    1d4b:	83 c4 10             	add    $0x10,%esp
    1d4e:	85 c0                	test   %eax,%eax
    1d50:	0f 85 b3 05 00 00    	jne    2309 <subdir+0x5e9>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d56:	83 ec 08             	sub    $0x8,%esp
    1d59:	68 02 02 00 00       	push   $0x202
    1d5e:	68 f1 49 00 00       	push   $0x49f1
    1d63:	e8 39 20 00 00       	call   3da1 <open>
  if(fd < 0){
    1d68:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d6b:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d6d:	85 c0                	test   %eax,%eax
    1d6f:	0f 88 81 05 00 00    	js     22f6 <subdir+0x5d6>
  write(fd, "ff", 2);
    1d75:	83 ec 04             	sub    $0x4,%esp
    1d78:	6a 02                	push   $0x2
    1d7a:	68 1b 4a 00 00       	push   $0x4a1b
    1d7f:	50                   	push   %eax
    1d80:	e8 fc 1f 00 00       	call   3d81 <write>
  close(fd);
    1d85:	89 1c 24             	mov    %ebx,(%esp)
    1d88:	e8 fc 1f 00 00       	call   3d89 <close>
  if(unlink("dd") >= 0){
    1d8d:	c7 04 24 b8 4a 00 00 	movl   $0x4ab8,(%esp)
    1d94:	e8 18 20 00 00       	call   3db1 <unlink>
    1d99:	83 c4 10             	add    $0x10,%esp
    1d9c:	85 c0                	test   %eax,%eax
    1d9e:	0f 89 3f 05 00 00    	jns    22e3 <subdir+0x5c3>
  if(mkdir("/dd/dd") != 0){
    1da4:	83 ec 0c             	sub    $0xc,%esp
    1da7:	68 cc 49 00 00       	push   $0x49cc
    1dac:	e8 18 20 00 00       	call   3dc9 <mkdir>
    1db1:	83 c4 10             	add    $0x10,%esp
    1db4:	85 c0                	test   %eax,%eax
    1db6:	0f 85 14 05 00 00    	jne    22d0 <subdir+0x5b0>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1dbc:	83 ec 08             	sub    $0x8,%esp
    1dbf:	68 02 02 00 00       	push   $0x202
    1dc4:	68 ee 49 00 00       	push   $0x49ee
    1dc9:	e8 d3 1f 00 00       	call   3da1 <open>
  if(fd < 0){
    1dce:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1dd1:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1dd3:	85 c0                	test   %eax,%eax
    1dd5:	0f 88 24 04 00 00    	js     21ff <subdir+0x4df>
  write(fd, "FF", 2);
    1ddb:	83 ec 04             	sub    $0x4,%esp
    1dde:	6a 02                	push   $0x2
    1de0:	68 0f 4a 00 00       	push   $0x4a0f
    1de5:	50                   	push   %eax
    1de6:	e8 96 1f 00 00       	call   3d81 <write>
  close(fd);
    1deb:	89 1c 24             	mov    %ebx,(%esp)
    1dee:	e8 96 1f 00 00       	call   3d89 <close>
  fd = open("dd/dd/../ff", 0);
    1df3:	58                   	pop    %eax
    1df4:	5a                   	pop    %edx
    1df5:	6a 00                	push   $0x0
    1df7:	68 12 4a 00 00       	push   $0x4a12
    1dfc:	e8 a0 1f 00 00       	call   3da1 <open>
  if(fd < 0){
    1e01:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/../ff", 0);
    1e04:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1e06:	85 c0                	test   %eax,%eax
    1e08:	0f 88 de 03 00 00    	js     21ec <subdir+0x4cc>
  cc = read(fd, buf, sizeof(buf));
    1e0e:	83 ec 04             	sub    $0x4,%esp
    1e11:	68 00 20 00 00       	push   $0x2000
    1e16:	68 e0 5f 01 00       	push   $0x15fe0
    1e1b:	50                   	push   %eax
    1e1c:	e8 58 1f 00 00       	call   3d79 <read>
  if(cc != 2 || buf[0] != 'f'){
    1e21:	83 c4 10             	add    $0x10,%esp
    1e24:	83 f8 02             	cmp    $0x2,%eax
    1e27:	0f 85 3a 03 00 00    	jne    2167 <subdir+0x447>
    1e2d:	80 3d e0 5f 01 00 66 	cmpb   $0x66,0x15fe0
    1e34:	0f 85 2d 03 00 00    	jne    2167 <subdir+0x447>
  close(fd);
    1e3a:	83 ec 0c             	sub    $0xc,%esp
    1e3d:	53                   	push   %ebx
    1e3e:	e8 46 1f 00 00       	call   3d89 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1e43:	5b                   	pop    %ebx
    1e44:	58                   	pop    %eax
    1e45:	68 52 4a 00 00       	push   $0x4a52
    1e4a:	68 ee 49 00 00       	push   $0x49ee
    1e4f:	e8 6d 1f 00 00       	call   3dc1 <link>
    1e54:	83 c4 10             	add    $0x10,%esp
    1e57:	85 c0                	test   %eax,%eax
    1e59:	0f 85 c6 03 00 00    	jne    2225 <subdir+0x505>
  if(unlink("dd/dd/ff") != 0){
    1e5f:	83 ec 0c             	sub    $0xc,%esp
    1e62:	68 ee 49 00 00       	push   $0x49ee
    1e67:	e8 45 1f 00 00       	call   3db1 <unlink>
    1e6c:	83 c4 10             	add    $0x10,%esp
    1e6f:	85 c0                	test   %eax,%eax
    1e71:	0f 85 16 03 00 00    	jne    218d <subdir+0x46d>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1e77:	83 ec 08             	sub    $0x8,%esp
    1e7a:	6a 00                	push   $0x0
    1e7c:	68 ee 49 00 00       	push   $0x49ee
    1e81:	e8 1b 1f 00 00       	call   3da1 <open>
    1e86:	83 c4 10             	add    $0x10,%esp
    1e89:	85 c0                	test   %eax,%eax
    1e8b:	0f 89 2c 04 00 00    	jns    22bd <subdir+0x59d>
  if(chdir("dd") != 0){
    1e91:	83 ec 0c             	sub    $0xc,%esp
    1e94:	68 b8 4a 00 00       	push   $0x4ab8
    1e99:	e8 33 1f 00 00       	call   3dd1 <chdir>
    1e9e:	83 c4 10             	add    $0x10,%esp
    1ea1:	85 c0                	test   %eax,%eax
    1ea3:	0f 85 01 04 00 00    	jne    22aa <subdir+0x58a>
  if(chdir("dd/../../dd") != 0){
    1ea9:	83 ec 0c             	sub    $0xc,%esp
    1eac:	68 86 4a 00 00       	push   $0x4a86
    1eb1:	e8 1b 1f 00 00       	call   3dd1 <chdir>
    1eb6:	83 c4 10             	add    $0x10,%esp
    1eb9:	85 c0                	test   %eax,%eax
    1ebb:	0f 85 b9 02 00 00    	jne    217a <subdir+0x45a>
  if(chdir("dd/../../../dd") != 0){
    1ec1:	83 ec 0c             	sub    $0xc,%esp
    1ec4:	68 ac 4a 00 00       	push   $0x4aac
    1ec9:	e8 03 1f 00 00       	call   3dd1 <chdir>
    1ece:	83 c4 10             	add    $0x10,%esp
    1ed1:	85 c0                	test   %eax,%eax
    1ed3:	0f 85 a1 02 00 00    	jne    217a <subdir+0x45a>
  if(chdir("./..") != 0){
    1ed9:	83 ec 0c             	sub    $0xc,%esp
    1edc:	68 bb 4a 00 00       	push   $0x4abb
    1ee1:	e8 eb 1e 00 00       	call   3dd1 <chdir>
    1ee6:	83 c4 10             	add    $0x10,%esp
    1ee9:	85 c0                	test   %eax,%eax
    1eeb:	0f 85 21 03 00 00    	jne    2212 <subdir+0x4f2>
  fd = open("dd/dd/ffff", 0);
    1ef1:	83 ec 08             	sub    $0x8,%esp
    1ef4:	6a 00                	push   $0x0
    1ef6:	68 52 4a 00 00       	push   $0x4a52
    1efb:	e8 a1 1e 00 00       	call   3da1 <open>
  if(fd < 0){
    1f00:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/ffff", 0);
    1f03:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1f05:	85 c0                	test   %eax,%eax
    1f07:	0f 88 e0 04 00 00    	js     23ed <subdir+0x6cd>
  if(read(fd, buf, sizeof(buf)) != 2){
    1f0d:	83 ec 04             	sub    $0x4,%esp
    1f10:	68 00 20 00 00       	push   $0x2000
    1f15:	68 e0 5f 01 00       	push   $0x15fe0
    1f1a:	50                   	push   %eax
    1f1b:	e8 59 1e 00 00       	call   3d79 <read>
    1f20:	83 c4 10             	add    $0x10,%esp
    1f23:	83 f8 02             	cmp    $0x2,%eax
    1f26:	0f 85 ae 04 00 00    	jne    23da <subdir+0x6ba>
  close(fd);
    1f2c:	83 ec 0c             	sub    $0xc,%esp
    1f2f:	53                   	push   %ebx
    1f30:	e8 54 1e 00 00       	call   3d89 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1f35:	59                   	pop    %ecx
    1f36:	5b                   	pop    %ebx
    1f37:	6a 00                	push   $0x0
    1f39:	68 ee 49 00 00       	push   $0x49ee
    1f3e:	e8 5e 1e 00 00       	call   3da1 <open>
    1f43:	83 c4 10             	add    $0x10,%esp
    1f46:	85 c0                	test   %eax,%eax
    1f48:	0f 89 65 02 00 00    	jns    21b3 <subdir+0x493>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1f4e:	83 ec 08             	sub    $0x8,%esp
    1f51:	68 02 02 00 00       	push   $0x202
    1f56:	68 06 4b 00 00       	push   $0x4b06
    1f5b:	e8 41 1e 00 00       	call   3da1 <open>
    1f60:	83 c4 10             	add    $0x10,%esp
    1f63:	85 c0                	test   %eax,%eax
    1f65:	0f 89 35 02 00 00    	jns    21a0 <subdir+0x480>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1f6b:	83 ec 08             	sub    $0x8,%esp
    1f6e:	68 02 02 00 00       	push   $0x202
    1f73:	68 2b 4b 00 00       	push   $0x4b2b
    1f78:	e8 24 1e 00 00       	call   3da1 <open>
    1f7d:	83 c4 10             	add    $0x10,%esp
    1f80:	85 c0                	test   %eax,%eax
    1f82:	0f 89 0f 03 00 00    	jns    2297 <subdir+0x577>
  if(open("dd", O_CREATE) >= 0){
    1f88:	83 ec 08             	sub    $0x8,%esp
    1f8b:	68 00 02 00 00       	push   $0x200
    1f90:	68 b8 4a 00 00       	push   $0x4ab8
    1f95:	e8 07 1e 00 00       	call   3da1 <open>
    1f9a:	83 c4 10             	add    $0x10,%esp
    1f9d:	85 c0                	test   %eax,%eax
    1f9f:	0f 89 df 02 00 00    	jns    2284 <subdir+0x564>
  if(open("dd", O_RDWR) >= 0){
    1fa5:	83 ec 08             	sub    $0x8,%esp
    1fa8:	6a 02                	push   $0x2
    1faa:	68 b8 4a 00 00       	push   $0x4ab8
    1faf:	e8 ed 1d 00 00       	call   3da1 <open>
    1fb4:	83 c4 10             	add    $0x10,%esp
    1fb7:	85 c0                	test   %eax,%eax
    1fb9:	0f 89 b2 02 00 00    	jns    2271 <subdir+0x551>
  if(open("dd", O_WRONLY) >= 0){
    1fbf:	83 ec 08             	sub    $0x8,%esp
    1fc2:	6a 01                	push   $0x1
    1fc4:	68 b8 4a 00 00       	push   $0x4ab8
    1fc9:	e8 d3 1d 00 00       	call   3da1 <open>
    1fce:	83 c4 10             	add    $0x10,%esp
    1fd1:	85 c0                	test   %eax,%eax
    1fd3:	0f 89 85 02 00 00    	jns    225e <subdir+0x53e>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1fd9:	83 ec 08             	sub    $0x8,%esp
    1fdc:	68 9a 4b 00 00       	push   $0x4b9a
    1fe1:	68 06 4b 00 00       	push   $0x4b06
    1fe6:	e8 d6 1d 00 00       	call   3dc1 <link>
    1feb:	83 c4 10             	add    $0x10,%esp
    1fee:	85 c0                	test   %eax,%eax
    1ff0:	0f 84 55 02 00 00    	je     224b <subdir+0x52b>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    1ff6:	83 ec 08             	sub    $0x8,%esp
    1ff9:	68 9a 4b 00 00       	push   $0x4b9a
    1ffe:	68 2b 4b 00 00       	push   $0x4b2b
    2003:	e8 b9 1d 00 00       	call   3dc1 <link>
    2008:	83 c4 10             	add    $0x10,%esp
    200b:	85 c0                	test   %eax,%eax
    200d:	0f 84 25 02 00 00    	je     2238 <subdir+0x518>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2013:	83 ec 08             	sub    $0x8,%esp
    2016:	68 52 4a 00 00       	push   $0x4a52
    201b:	68 f1 49 00 00       	push   $0x49f1
    2020:	e8 9c 1d 00 00       	call   3dc1 <link>
    2025:	83 c4 10             	add    $0x10,%esp
    2028:	85 c0                	test   %eax,%eax
    202a:	0f 84 a9 01 00 00    	je     21d9 <subdir+0x4b9>
  if(mkdir("dd/ff/ff") == 0){
    2030:	83 ec 0c             	sub    $0xc,%esp
    2033:	68 06 4b 00 00       	push   $0x4b06
    2038:	e8 8c 1d 00 00       	call   3dc9 <mkdir>
    203d:	83 c4 10             	add    $0x10,%esp
    2040:	85 c0                	test   %eax,%eax
    2042:	0f 84 7e 01 00 00    	je     21c6 <subdir+0x4a6>
  if(mkdir("dd/xx/ff") == 0){
    2048:	83 ec 0c             	sub    $0xc,%esp
    204b:	68 2b 4b 00 00       	push   $0x4b2b
    2050:	e8 74 1d 00 00       	call   3dc9 <mkdir>
    2055:	83 c4 10             	add    $0x10,%esp
    2058:	85 c0                	test   %eax,%eax
    205a:	0f 84 67 03 00 00    	je     23c7 <subdir+0x6a7>
  if(mkdir("dd/dd/ffff") == 0){
    2060:	83 ec 0c             	sub    $0xc,%esp
    2063:	68 52 4a 00 00       	push   $0x4a52
    2068:	e8 5c 1d 00 00       	call   3dc9 <mkdir>
    206d:	83 c4 10             	add    $0x10,%esp
    2070:	85 c0                	test   %eax,%eax
    2072:	0f 84 3c 03 00 00    	je     23b4 <subdir+0x694>
  if(unlink("dd/xx/ff") == 0){
    2078:	83 ec 0c             	sub    $0xc,%esp
    207b:	68 2b 4b 00 00       	push   $0x4b2b
    2080:	e8 2c 1d 00 00       	call   3db1 <unlink>
    2085:	83 c4 10             	add    $0x10,%esp
    2088:	85 c0                	test   %eax,%eax
    208a:	0f 84 11 03 00 00    	je     23a1 <subdir+0x681>
  if(unlink("dd/ff/ff") == 0){
    2090:	83 ec 0c             	sub    $0xc,%esp
    2093:	68 06 4b 00 00       	push   $0x4b06
    2098:	e8 14 1d 00 00       	call   3db1 <unlink>
    209d:	83 c4 10             	add    $0x10,%esp
    20a0:	85 c0                	test   %eax,%eax
    20a2:	0f 84 e6 02 00 00    	je     238e <subdir+0x66e>
  if(chdir("dd/ff") == 0){
    20a8:	83 ec 0c             	sub    $0xc,%esp
    20ab:	68 f1 49 00 00       	push   $0x49f1
    20b0:	e8 1c 1d 00 00       	call   3dd1 <chdir>
    20b5:	83 c4 10             	add    $0x10,%esp
    20b8:	85 c0                	test   %eax,%eax
    20ba:	0f 84 bb 02 00 00    	je     237b <subdir+0x65b>
  if(chdir("dd/xx") == 0){
    20c0:	83 ec 0c             	sub    $0xc,%esp
    20c3:	68 9d 4b 00 00       	push   $0x4b9d
    20c8:	e8 04 1d 00 00       	call   3dd1 <chdir>
    20cd:	83 c4 10             	add    $0x10,%esp
    20d0:	85 c0                	test   %eax,%eax
    20d2:	0f 84 90 02 00 00    	je     2368 <subdir+0x648>
  if(unlink("dd/dd/ffff") != 0){
    20d8:	83 ec 0c             	sub    $0xc,%esp
    20db:	68 52 4a 00 00       	push   $0x4a52
    20e0:	e8 cc 1c 00 00       	call   3db1 <unlink>
    20e5:	83 c4 10             	add    $0x10,%esp
    20e8:	85 c0                	test   %eax,%eax
    20ea:	0f 85 9d 00 00 00    	jne    218d <subdir+0x46d>
  if(unlink("dd/ff") != 0){
    20f0:	83 ec 0c             	sub    $0xc,%esp
    20f3:	68 f1 49 00 00       	push   $0x49f1
    20f8:	e8 b4 1c 00 00       	call   3db1 <unlink>
    20fd:	83 c4 10             	add    $0x10,%esp
    2100:	85 c0                	test   %eax,%eax
    2102:	0f 85 4d 02 00 00    	jne    2355 <subdir+0x635>
  if(unlink("dd") == 0){
    2108:	83 ec 0c             	sub    $0xc,%esp
    210b:	68 b8 4a 00 00       	push   $0x4ab8
    2110:	e8 9c 1c 00 00       	call   3db1 <unlink>
    2115:	83 c4 10             	add    $0x10,%esp
    2118:	85 c0                	test   %eax,%eax
    211a:	0f 84 22 02 00 00    	je     2342 <subdir+0x622>
  if(unlink("dd/dd") < 0){
    2120:	83 ec 0c             	sub    $0xc,%esp
    2123:	68 cd 49 00 00       	push   $0x49cd
    2128:	e8 84 1c 00 00       	call   3db1 <unlink>
    212d:	83 c4 10             	add    $0x10,%esp
    2130:	85 c0                	test   %eax,%eax
    2132:	0f 88 f7 01 00 00    	js     232f <subdir+0x60f>
  if(unlink("dd") < 0){
    2138:	83 ec 0c             	sub    $0xc,%esp
    213b:	68 b8 4a 00 00       	push   $0x4ab8
    2140:	e8 6c 1c 00 00       	call   3db1 <unlink>
    2145:	83 c4 10             	add    $0x10,%esp
    2148:	85 c0                	test   %eax,%eax
    214a:	0f 88 cc 01 00 00    	js     231c <subdir+0x5fc>
  printf(1, "subdir ok\n");
    2150:	83 ec 08             	sub    $0x8,%esp
    2153:	68 9a 4c 00 00       	push   $0x4c9a
    2158:	6a 01                	push   $0x1
    215a:	e8 81 1d 00 00       	call   3ee0 <printf>
}
    215f:	83 c4 10             	add    $0x10,%esp
    2162:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2165:	c9                   	leave  
    2166:	c3                   	ret    
    printf(1, "dd/dd/../ff wrong content\n");
    2167:	50                   	push   %eax
    2168:	50                   	push   %eax
    2169:	68 37 4a 00 00       	push   $0x4a37
    216e:	6a 01                	push   $0x1
    2170:	e8 6b 1d 00 00       	call   3ee0 <printf>
    exit();
    2175:	e8 e7 1b 00 00       	call   3d61 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    217a:	50                   	push   %eax
    217b:	50                   	push   %eax
    217c:	68 92 4a 00 00       	push   $0x4a92
    2181:	6a 01                	push   $0x1
    2183:	e8 58 1d 00 00       	call   3ee0 <printf>
    exit();
    2188:	e8 d4 1b 00 00       	call   3d61 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    218d:	52                   	push   %edx
    218e:	52                   	push   %edx
    218f:	68 5d 4a 00 00       	push   $0x4a5d
    2194:	6a 01                	push   $0x1
    2196:	e8 45 1d 00 00       	call   3ee0 <printf>
    exit();
    219b:	e8 c1 1b 00 00       	call   3d61 <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    21a0:	50                   	push   %eax
    21a1:	50                   	push   %eax
    21a2:	68 0f 4b 00 00       	push   $0x4b0f
    21a7:	6a 01                	push   $0x1
    21a9:	e8 32 1d 00 00       	call   3ee0 <printf>
    exit();
    21ae:	e8 ae 1b 00 00       	call   3d61 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    21b3:	52                   	push   %edx
    21b4:	52                   	push   %edx
    21b5:	68 e0 55 00 00       	push   $0x55e0
    21ba:	6a 01                	push   $0x1
    21bc:	e8 1f 1d 00 00       	call   3ee0 <printf>
    exit();
    21c1:	e8 9b 1b 00 00       	call   3d61 <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    21c6:	52                   	push   %edx
    21c7:	52                   	push   %edx
    21c8:	68 a3 4b 00 00       	push   $0x4ba3
    21cd:	6a 01                	push   $0x1
    21cf:	e8 0c 1d 00 00       	call   3ee0 <printf>
    exit();
    21d4:	e8 88 1b 00 00       	call   3d61 <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    21d9:	51                   	push   %ecx
    21da:	51                   	push   %ecx
    21db:	68 50 56 00 00       	push   $0x5650
    21e0:	6a 01                	push   $0x1
    21e2:	e8 f9 1c 00 00       	call   3ee0 <printf>
    exit();
    21e7:	e8 75 1b 00 00       	call   3d61 <exit>
    printf(1, "open dd/dd/../ff failed\n");
    21ec:	50                   	push   %eax
    21ed:	50                   	push   %eax
    21ee:	68 1e 4a 00 00       	push   $0x4a1e
    21f3:	6a 01                	push   $0x1
    21f5:	e8 e6 1c 00 00       	call   3ee0 <printf>
    exit();
    21fa:	e8 62 1b 00 00       	call   3d61 <exit>
    printf(1, "create dd/dd/ff failed\n");
    21ff:	51                   	push   %ecx
    2200:	51                   	push   %ecx
    2201:	68 f7 49 00 00       	push   $0x49f7
    2206:	6a 01                	push   $0x1
    2208:	e8 d3 1c 00 00       	call   3ee0 <printf>
    exit();
    220d:	e8 4f 1b 00 00       	call   3d61 <exit>
    printf(1, "chdir ./.. failed\n");
    2212:	50                   	push   %eax
    2213:	50                   	push   %eax
    2214:	68 c0 4a 00 00       	push   $0x4ac0
    2219:	6a 01                	push   $0x1
    221b:	e8 c0 1c 00 00       	call   3ee0 <printf>
    exit();
    2220:	e8 3c 1b 00 00       	call   3d61 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2225:	51                   	push   %ecx
    2226:	51                   	push   %ecx
    2227:	68 98 55 00 00       	push   $0x5598
    222c:	6a 01                	push   $0x1
    222e:	e8 ad 1c 00 00       	call   3ee0 <printf>
    exit();
    2233:	e8 29 1b 00 00       	call   3d61 <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2238:	53                   	push   %ebx
    2239:	53                   	push   %ebx
    223a:	68 2c 56 00 00       	push   $0x562c
    223f:	6a 01                	push   $0x1
    2241:	e8 9a 1c 00 00       	call   3ee0 <printf>
    exit();
    2246:	e8 16 1b 00 00       	call   3d61 <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    224b:	50                   	push   %eax
    224c:	50                   	push   %eax
    224d:	68 08 56 00 00       	push   $0x5608
    2252:	6a 01                	push   $0x1
    2254:	e8 87 1c 00 00       	call   3ee0 <printf>
    exit();
    2259:	e8 03 1b 00 00       	call   3d61 <exit>
    printf(1, "open dd wronly succeeded!\n");
    225e:	50                   	push   %eax
    225f:	50                   	push   %eax
    2260:	68 7f 4b 00 00       	push   $0x4b7f
    2265:	6a 01                	push   $0x1
    2267:	e8 74 1c 00 00       	call   3ee0 <printf>
    exit();
    226c:	e8 f0 1a 00 00       	call   3d61 <exit>
    printf(1, "open dd rdwr succeeded!\n");
    2271:	50                   	push   %eax
    2272:	50                   	push   %eax
    2273:	68 66 4b 00 00       	push   $0x4b66
    2278:	6a 01                	push   $0x1
    227a:	e8 61 1c 00 00       	call   3ee0 <printf>
    exit();
    227f:	e8 dd 1a 00 00       	call   3d61 <exit>
    printf(1, "create dd succeeded!\n");
    2284:	50                   	push   %eax
    2285:	50                   	push   %eax
    2286:	68 50 4b 00 00       	push   $0x4b50
    228b:	6a 01                	push   $0x1
    228d:	e8 4e 1c 00 00       	call   3ee0 <printf>
    exit();
    2292:	e8 ca 1a 00 00       	call   3d61 <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    2297:	50                   	push   %eax
    2298:	50                   	push   %eax
    2299:	68 34 4b 00 00       	push   $0x4b34
    229e:	6a 01                	push   $0x1
    22a0:	e8 3b 1c 00 00       	call   3ee0 <printf>
    exit();
    22a5:	e8 b7 1a 00 00       	call   3d61 <exit>
    printf(1, "chdir dd failed\n");
    22aa:	50                   	push   %eax
    22ab:	50                   	push   %eax
    22ac:	68 75 4a 00 00       	push   $0x4a75
    22b1:	6a 01                	push   $0x1
    22b3:	e8 28 1c 00 00       	call   3ee0 <printf>
    exit();
    22b8:	e8 a4 1a 00 00       	call   3d61 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    22bd:	50                   	push   %eax
    22be:	50                   	push   %eax
    22bf:	68 bc 55 00 00       	push   $0x55bc
    22c4:	6a 01                	push   $0x1
    22c6:	e8 15 1c 00 00       	call   3ee0 <printf>
    exit();
    22cb:	e8 91 1a 00 00       	call   3d61 <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    22d0:	53                   	push   %ebx
    22d1:	53                   	push   %ebx
    22d2:	68 d3 49 00 00       	push   $0x49d3
    22d7:	6a 01                	push   $0x1
    22d9:	e8 02 1c 00 00       	call   3ee0 <printf>
    exit();
    22de:	e8 7e 1a 00 00       	call   3d61 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    22e3:	50                   	push   %eax
    22e4:	50                   	push   %eax
    22e5:	68 70 55 00 00       	push   $0x5570
    22ea:	6a 01                	push   $0x1
    22ec:	e8 ef 1b 00 00       	call   3ee0 <printf>
    exit();
    22f1:	e8 6b 1a 00 00       	call   3d61 <exit>
    printf(1, "create dd/ff failed\n");
    22f6:	50                   	push   %eax
    22f7:	50                   	push   %eax
    22f8:	68 b7 49 00 00       	push   $0x49b7
    22fd:	6a 01                	push   $0x1
    22ff:	e8 dc 1b 00 00       	call   3ee0 <printf>
    exit();
    2304:	e8 58 1a 00 00       	call   3d61 <exit>
    printf(1, "subdir mkdir dd failed\n");
    2309:	50                   	push   %eax
    230a:	50                   	push   %eax
    230b:	68 9f 49 00 00       	push   $0x499f
    2310:	6a 01                	push   $0x1
    2312:	e8 c9 1b 00 00       	call   3ee0 <printf>
    exit();
    2317:	e8 45 1a 00 00       	call   3d61 <exit>
    printf(1, "unlink dd failed\n");
    231c:	50                   	push   %eax
    231d:	50                   	push   %eax
    231e:	68 88 4c 00 00       	push   $0x4c88
    2323:	6a 01                	push   $0x1
    2325:	e8 b6 1b 00 00       	call   3ee0 <printf>
    exit();
    232a:	e8 32 1a 00 00       	call   3d61 <exit>
    printf(1, "unlink dd/dd failed\n");
    232f:	52                   	push   %edx
    2330:	52                   	push   %edx
    2331:	68 73 4c 00 00       	push   $0x4c73
    2336:	6a 01                	push   $0x1
    2338:	e8 a3 1b 00 00       	call   3ee0 <printf>
    exit();
    233d:	e8 1f 1a 00 00       	call   3d61 <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    2342:	51                   	push   %ecx
    2343:	51                   	push   %ecx
    2344:	68 74 56 00 00       	push   $0x5674
    2349:	6a 01                	push   $0x1
    234b:	e8 90 1b 00 00       	call   3ee0 <printf>
    exit();
    2350:	e8 0c 1a 00 00       	call   3d61 <exit>
    printf(1, "unlink dd/ff failed\n");
    2355:	53                   	push   %ebx
    2356:	53                   	push   %ebx
    2357:	68 5e 4c 00 00       	push   $0x4c5e
    235c:	6a 01                	push   $0x1
    235e:	e8 7d 1b 00 00       	call   3ee0 <printf>
    exit();
    2363:	e8 f9 19 00 00       	call   3d61 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    2368:	50                   	push   %eax
    2369:	50                   	push   %eax
    236a:	68 46 4c 00 00       	push   $0x4c46
    236f:	6a 01                	push   $0x1
    2371:	e8 6a 1b 00 00       	call   3ee0 <printf>
    exit();
    2376:	e8 e6 19 00 00       	call   3d61 <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    237b:	50                   	push   %eax
    237c:	50                   	push   %eax
    237d:	68 2e 4c 00 00       	push   $0x4c2e
    2382:	6a 01                	push   $0x1
    2384:	e8 57 1b 00 00       	call   3ee0 <printf>
    exit();
    2389:	e8 d3 19 00 00       	call   3d61 <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    238e:	50                   	push   %eax
    238f:	50                   	push   %eax
    2390:	68 12 4c 00 00       	push   $0x4c12
    2395:	6a 01                	push   $0x1
    2397:	e8 44 1b 00 00       	call   3ee0 <printf>
    exit();
    239c:	e8 c0 19 00 00       	call   3d61 <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    23a1:	50                   	push   %eax
    23a2:	50                   	push   %eax
    23a3:	68 f6 4b 00 00       	push   $0x4bf6
    23a8:	6a 01                	push   $0x1
    23aa:	e8 31 1b 00 00       	call   3ee0 <printf>
    exit();
    23af:	e8 ad 19 00 00       	call   3d61 <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    23b4:	50                   	push   %eax
    23b5:	50                   	push   %eax
    23b6:	68 d9 4b 00 00       	push   $0x4bd9
    23bb:	6a 01                	push   $0x1
    23bd:	e8 1e 1b 00 00       	call   3ee0 <printf>
    exit();
    23c2:	e8 9a 19 00 00       	call   3d61 <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    23c7:	50                   	push   %eax
    23c8:	50                   	push   %eax
    23c9:	68 be 4b 00 00       	push   $0x4bbe
    23ce:	6a 01                	push   $0x1
    23d0:	e8 0b 1b 00 00       	call   3ee0 <printf>
    exit();
    23d5:	e8 87 19 00 00       	call   3d61 <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    23da:	50                   	push   %eax
    23db:	50                   	push   %eax
    23dc:	68 eb 4a 00 00       	push   $0x4aeb
    23e1:	6a 01                	push   $0x1
    23e3:	e8 f8 1a 00 00       	call   3ee0 <printf>
    exit();
    23e8:	e8 74 19 00 00       	call   3d61 <exit>
    printf(1, "open dd/dd/ffff failed\n");
    23ed:	50                   	push   %eax
    23ee:	50                   	push   %eax
    23ef:	68 d3 4a 00 00       	push   $0x4ad3
    23f4:	6a 01                	push   $0x1
    23f6:	e8 e5 1a 00 00       	call   3ee0 <printf>
    exit();
    23fb:	e8 61 19 00 00       	call   3d61 <exit>

00002400 <bigwrite>:
{
    2400:	55                   	push   %ebp
    2401:	89 e5                	mov    %esp,%ebp
    2403:	56                   	push   %esi
    2404:	53                   	push   %ebx
  for(sz = 499; sz < 12*512; sz += 471){
    2405:	bb f3 01 00 00       	mov    $0x1f3,%ebx
  printf(1, "bigwrite test\n");
    240a:	83 ec 08             	sub    $0x8,%esp
    240d:	68 a5 4c 00 00       	push   $0x4ca5
    2412:	6a 01                	push   $0x1
    2414:	e8 c7 1a 00 00       	call   3ee0 <printf>
  unlink("bigwrite");
    2419:	c7 04 24 b4 4c 00 00 	movl   $0x4cb4,(%esp)
    2420:	e8 8c 19 00 00       	call   3db1 <unlink>
    2425:	83 c4 10             	add    $0x10,%esp
    2428:	90                   	nop
    2429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2430:	83 ec 08             	sub    $0x8,%esp
    2433:	68 02 02 00 00       	push   $0x202
    2438:	68 b4 4c 00 00       	push   $0x4cb4
    243d:	e8 5f 19 00 00       	call   3da1 <open>
    if(fd < 0){
    2442:	83 c4 10             	add    $0x10,%esp
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2445:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2447:	85 c0                	test   %eax,%eax
    2449:	78 7e                	js     24c9 <bigwrite+0xc9>
      int cc = write(fd, buf, sz);
    244b:	83 ec 04             	sub    $0x4,%esp
    244e:	53                   	push   %ebx
    244f:	68 e0 5f 01 00       	push   $0x15fe0
    2454:	50                   	push   %eax
    2455:	e8 27 19 00 00       	call   3d81 <write>
      if(cc != sz){
    245a:	83 c4 10             	add    $0x10,%esp
    245d:	39 d8                	cmp    %ebx,%eax
    245f:	75 55                	jne    24b6 <bigwrite+0xb6>
      int cc = write(fd, buf, sz);
    2461:	83 ec 04             	sub    $0x4,%esp
    2464:	53                   	push   %ebx
    2465:	68 e0 5f 01 00       	push   $0x15fe0
    246a:	56                   	push   %esi
    246b:	e8 11 19 00 00       	call   3d81 <write>
      if(cc != sz){
    2470:	83 c4 10             	add    $0x10,%esp
    2473:	39 d8                	cmp    %ebx,%eax
    2475:	75 3f                	jne    24b6 <bigwrite+0xb6>
    close(fd);
    2477:	83 ec 0c             	sub    $0xc,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    247a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    close(fd);
    2480:	56                   	push   %esi
    2481:	e8 03 19 00 00       	call   3d89 <close>
    unlink("bigwrite");
    2486:	c7 04 24 b4 4c 00 00 	movl   $0x4cb4,(%esp)
    248d:	e8 1f 19 00 00       	call   3db1 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    2492:	83 c4 10             	add    $0x10,%esp
    2495:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    249b:	75 93                	jne    2430 <bigwrite+0x30>
  printf(1, "bigwrite ok\n");
    249d:	83 ec 08             	sub    $0x8,%esp
    24a0:	68 e7 4c 00 00       	push   $0x4ce7
    24a5:	6a 01                	push   $0x1
    24a7:	e8 34 1a 00 00       	call   3ee0 <printf>
}
    24ac:	83 c4 10             	add    $0x10,%esp
    24af:	8d 65 f8             	lea    -0x8(%ebp),%esp
    24b2:	5b                   	pop    %ebx
    24b3:	5e                   	pop    %esi
    24b4:	5d                   	pop    %ebp
    24b5:	c3                   	ret    
        printf(1, "write(%d) ret %d\n", sz, cc);
    24b6:	50                   	push   %eax
    24b7:	53                   	push   %ebx
    24b8:	68 d5 4c 00 00       	push   $0x4cd5
    24bd:	6a 01                	push   $0x1
    24bf:	e8 1c 1a 00 00       	call   3ee0 <printf>
        exit();
    24c4:	e8 98 18 00 00       	call   3d61 <exit>
      printf(1, "cannot create bigwrite\n");
    24c9:	83 ec 08             	sub    $0x8,%esp
    24cc:	68 bd 4c 00 00       	push   $0x4cbd
    24d1:	6a 01                	push   $0x1
    24d3:	e8 08 1a 00 00       	call   3ee0 <printf>
      exit();
    24d8:	e8 84 18 00 00       	call   3d61 <exit>
    24dd:	8d 76 00             	lea    0x0(%esi),%esi

000024e0 <bigfile>:
{
    24e0:	55                   	push   %ebp
    24e1:	89 e5                	mov    %esp,%ebp
    24e3:	57                   	push   %edi
    24e4:	56                   	push   %esi
    24e5:	53                   	push   %ebx
    24e6:	83 ec 14             	sub    $0x14,%esp
  printf(1, "bigfile test\n");
    24e9:	68 f4 4c 00 00       	push   $0x4cf4
    24ee:	6a 01                	push   $0x1
    24f0:	e8 eb 19 00 00       	call   3ee0 <printf>
  unlink("bigfile");
    24f5:	c7 04 24 10 4d 00 00 	movl   $0x4d10,(%esp)
    24fc:	e8 b0 18 00 00       	call   3db1 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2501:	58                   	pop    %eax
    2502:	5a                   	pop    %edx
    2503:	68 02 02 00 00       	push   $0x202
    2508:	68 10 4d 00 00       	push   $0x4d10
    250d:	e8 8f 18 00 00       	call   3da1 <open>
  if(fd < 0){
    2512:	83 c4 10             	add    $0x10,%esp
    2515:	85 c0                	test   %eax,%eax
    2517:	0f 88 5e 01 00 00    	js     267b <bigfile+0x19b>
    251d:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++){
    251f:	31 db                	xor    %ebx,%ebx
    2521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    memset(buf, i, 600);
    2528:	83 ec 04             	sub    $0x4,%esp
    252b:	68 58 02 00 00       	push   $0x258
    2530:	53                   	push   %ebx
    2531:	68 e0 5f 01 00       	push   $0x15fe0
    2536:	e8 85 16 00 00       	call   3bc0 <memset>
    if(write(fd, buf, 600) != 600){
    253b:	83 c4 0c             	add    $0xc,%esp
    253e:	68 58 02 00 00       	push   $0x258
    2543:	68 e0 5f 01 00       	push   $0x15fe0
    2548:	56                   	push   %esi
    2549:	e8 33 18 00 00       	call   3d81 <write>
    254e:	83 c4 10             	add    $0x10,%esp
    2551:	3d 58 02 00 00       	cmp    $0x258,%eax
    2556:	0f 85 f8 00 00 00    	jne    2654 <bigfile+0x174>
  for(i = 0; i < 20; i++){
    255c:	83 c3 01             	add    $0x1,%ebx
    255f:	83 fb 14             	cmp    $0x14,%ebx
    2562:	75 c4                	jne    2528 <bigfile+0x48>
  close(fd);
    2564:	83 ec 0c             	sub    $0xc,%esp
    2567:	56                   	push   %esi
    2568:	e8 1c 18 00 00       	call   3d89 <close>
  fd = open("bigfile", 0);
    256d:	5e                   	pop    %esi
    256e:	5f                   	pop    %edi
    256f:	6a 00                	push   $0x0
    2571:	68 10 4d 00 00       	push   $0x4d10
    2576:	e8 26 18 00 00       	call   3da1 <open>
  if(fd < 0){
    257b:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", 0);
    257e:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2580:	85 c0                	test   %eax,%eax
    2582:	0f 88 e0 00 00 00    	js     2668 <bigfile+0x188>
  total = 0;
    2588:	31 db                	xor    %ebx,%ebx
  for(i = 0; ; i++){
    258a:	31 ff                	xor    %edi,%edi
    258c:	eb 30                	jmp    25be <bigfile+0xde>
    258e:	66 90                	xchg   %ax,%ax
    if(cc != 300){
    2590:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2595:	0f 85 91 00 00 00    	jne    262c <bigfile+0x14c>
    if(buf[0] != i/2 || buf[299] != i/2){
    259b:	89 fa                	mov    %edi,%edx
    259d:	0f be 05 e0 5f 01 00 	movsbl 0x15fe0,%eax
    25a4:	d1 fa                	sar    %edx
    25a6:	39 d0                	cmp    %edx,%eax
    25a8:	75 6e                	jne    2618 <bigfile+0x138>
    25aa:	0f be 15 0b 61 01 00 	movsbl 0x1610b,%edx
    25b1:	39 d0                	cmp    %edx,%eax
    25b3:	75 63                	jne    2618 <bigfile+0x138>
    total += cc;
    25b5:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  for(i = 0; ; i++){
    25bb:	83 c7 01             	add    $0x1,%edi
    cc = read(fd, buf, 300);
    25be:	83 ec 04             	sub    $0x4,%esp
    25c1:	68 2c 01 00 00       	push   $0x12c
    25c6:	68 e0 5f 01 00       	push   $0x15fe0
    25cb:	56                   	push   %esi
    25cc:	e8 a8 17 00 00       	call   3d79 <read>
    if(cc < 0){
    25d1:	83 c4 10             	add    $0x10,%esp
    25d4:	85 c0                	test   %eax,%eax
    25d6:	78 68                	js     2640 <bigfile+0x160>
    if(cc == 0)
    25d8:	75 b6                	jne    2590 <bigfile+0xb0>
  close(fd);
    25da:	83 ec 0c             	sub    $0xc,%esp
    25dd:	56                   	push   %esi
    25de:	e8 a6 17 00 00       	call   3d89 <close>
  if(total != 20*600){
    25e3:	83 c4 10             	add    $0x10,%esp
    25e6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    25ec:	0f 85 9c 00 00 00    	jne    268e <bigfile+0x1ae>
  unlink("bigfile");
    25f2:	83 ec 0c             	sub    $0xc,%esp
    25f5:	68 10 4d 00 00       	push   $0x4d10
    25fa:	e8 b2 17 00 00       	call   3db1 <unlink>
  printf(1, "bigfile test ok\n");
    25ff:	58                   	pop    %eax
    2600:	5a                   	pop    %edx
    2601:	68 9f 4d 00 00       	push   $0x4d9f
    2606:	6a 01                	push   $0x1
    2608:	e8 d3 18 00 00       	call   3ee0 <printf>
}
    260d:	83 c4 10             	add    $0x10,%esp
    2610:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2613:	5b                   	pop    %ebx
    2614:	5e                   	pop    %esi
    2615:	5f                   	pop    %edi
    2616:	5d                   	pop    %ebp
    2617:	c3                   	ret    
      printf(1, "read bigfile wrong data\n");
    2618:	83 ec 08             	sub    $0x8,%esp
    261b:	68 6c 4d 00 00       	push   $0x4d6c
    2620:	6a 01                	push   $0x1
    2622:	e8 b9 18 00 00       	call   3ee0 <printf>
      exit();
    2627:	e8 35 17 00 00       	call   3d61 <exit>
      printf(1, "short read bigfile\n");
    262c:	83 ec 08             	sub    $0x8,%esp
    262f:	68 58 4d 00 00       	push   $0x4d58
    2634:	6a 01                	push   $0x1
    2636:	e8 a5 18 00 00       	call   3ee0 <printf>
      exit();
    263b:	e8 21 17 00 00       	call   3d61 <exit>
      printf(1, "read bigfile failed\n");
    2640:	83 ec 08             	sub    $0x8,%esp
    2643:	68 43 4d 00 00       	push   $0x4d43
    2648:	6a 01                	push   $0x1
    264a:	e8 91 18 00 00       	call   3ee0 <printf>
      exit();
    264f:	e8 0d 17 00 00       	call   3d61 <exit>
      printf(1, "write bigfile failed\n");
    2654:	83 ec 08             	sub    $0x8,%esp
    2657:	68 18 4d 00 00       	push   $0x4d18
    265c:	6a 01                	push   $0x1
    265e:	e8 7d 18 00 00       	call   3ee0 <printf>
      exit();
    2663:	e8 f9 16 00 00       	call   3d61 <exit>
    printf(1, "cannot open bigfile\n");
    2668:	53                   	push   %ebx
    2669:	53                   	push   %ebx
    266a:	68 2e 4d 00 00       	push   $0x4d2e
    266f:	6a 01                	push   $0x1
    2671:	e8 6a 18 00 00       	call   3ee0 <printf>
    exit();
    2676:	e8 e6 16 00 00       	call   3d61 <exit>
    printf(1, "cannot create bigfile");
    267b:	50                   	push   %eax
    267c:	50                   	push   %eax
    267d:	68 02 4d 00 00       	push   $0x4d02
    2682:	6a 01                	push   $0x1
    2684:	e8 57 18 00 00       	call   3ee0 <printf>
    exit();
    2689:	e8 d3 16 00 00       	call   3d61 <exit>
    printf(1, "read bigfile wrong total\n");
    268e:	51                   	push   %ecx
    268f:	51                   	push   %ecx
    2690:	68 85 4d 00 00       	push   $0x4d85
    2695:	6a 01                	push   $0x1
    2697:	e8 44 18 00 00       	call   3ee0 <printf>
    exit();
    269c:	e8 c0 16 00 00       	call   3d61 <exit>
    26a1:	eb 0d                	jmp    26b0 <fourteen>
    26a3:	90                   	nop
    26a4:	90                   	nop
    26a5:	90                   	nop
    26a6:	90                   	nop
    26a7:	90                   	nop
    26a8:	90                   	nop
    26a9:	90                   	nop
    26aa:	90                   	nop
    26ab:	90                   	nop
    26ac:	90                   	nop
    26ad:	90                   	nop
    26ae:	90                   	nop
    26af:	90                   	nop

000026b0 <fourteen>:
{
    26b0:	55                   	push   %ebp
    26b1:	89 e5                	mov    %esp,%ebp
    26b3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "fourteen test\n");
    26b6:	68 b0 4d 00 00       	push   $0x4db0
    26bb:	6a 01                	push   $0x1
    26bd:	e8 1e 18 00 00       	call   3ee0 <printf>
  if(mkdir("12345678901234") != 0){
    26c2:	c7 04 24 eb 4d 00 00 	movl   $0x4deb,(%esp)
    26c9:	e8 fb 16 00 00       	call   3dc9 <mkdir>
    26ce:	83 c4 10             	add    $0x10,%esp
    26d1:	85 c0                	test   %eax,%eax
    26d3:	0f 85 97 00 00 00    	jne    2770 <fourteen+0xc0>
  if(mkdir("12345678901234/123456789012345") != 0){
    26d9:	83 ec 0c             	sub    $0xc,%esp
    26dc:	68 94 56 00 00       	push   $0x5694
    26e1:	e8 e3 16 00 00       	call   3dc9 <mkdir>
    26e6:	83 c4 10             	add    $0x10,%esp
    26e9:	85 c0                	test   %eax,%eax
    26eb:	0f 85 de 00 00 00    	jne    27cf <fourteen+0x11f>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    26f1:	83 ec 08             	sub    $0x8,%esp
    26f4:	68 00 02 00 00       	push   $0x200
    26f9:	68 e4 56 00 00       	push   $0x56e4
    26fe:	e8 9e 16 00 00       	call   3da1 <open>
  if(fd < 0){
    2703:	83 c4 10             	add    $0x10,%esp
    2706:	85 c0                	test   %eax,%eax
    2708:	0f 88 ae 00 00 00    	js     27bc <fourteen+0x10c>
  close(fd);
    270e:	83 ec 0c             	sub    $0xc,%esp
    2711:	50                   	push   %eax
    2712:	e8 72 16 00 00       	call   3d89 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2717:	58                   	pop    %eax
    2718:	5a                   	pop    %edx
    2719:	6a 00                	push   $0x0
    271b:	68 54 57 00 00       	push   $0x5754
    2720:	e8 7c 16 00 00       	call   3da1 <open>
  if(fd < 0){
    2725:	83 c4 10             	add    $0x10,%esp
    2728:	85 c0                	test   %eax,%eax
    272a:	78 7d                	js     27a9 <fourteen+0xf9>
  close(fd);
    272c:	83 ec 0c             	sub    $0xc,%esp
    272f:	50                   	push   %eax
    2730:	e8 54 16 00 00       	call   3d89 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2735:	c7 04 24 dc 4d 00 00 	movl   $0x4ddc,(%esp)
    273c:	e8 88 16 00 00       	call   3dc9 <mkdir>
    2741:	83 c4 10             	add    $0x10,%esp
    2744:	85 c0                	test   %eax,%eax
    2746:	74 4e                	je     2796 <fourteen+0xe6>
  if(mkdir("123456789012345/12345678901234") == 0){
    2748:	83 ec 0c             	sub    $0xc,%esp
    274b:	68 f0 57 00 00       	push   $0x57f0
    2750:	e8 74 16 00 00       	call   3dc9 <mkdir>
    2755:	83 c4 10             	add    $0x10,%esp
    2758:	85 c0                	test   %eax,%eax
    275a:	74 27                	je     2783 <fourteen+0xd3>
  printf(1, "fourteen ok\n");
    275c:	83 ec 08             	sub    $0x8,%esp
    275f:	68 fa 4d 00 00       	push   $0x4dfa
    2764:	6a 01                	push   $0x1
    2766:	e8 75 17 00 00       	call   3ee0 <printf>
}
    276b:	83 c4 10             	add    $0x10,%esp
    276e:	c9                   	leave  
    276f:	c3                   	ret    
    printf(1, "mkdir 12345678901234 failed\n");
    2770:	50                   	push   %eax
    2771:	50                   	push   %eax
    2772:	68 bf 4d 00 00       	push   $0x4dbf
    2777:	6a 01                	push   $0x1
    2779:	e8 62 17 00 00       	call   3ee0 <printf>
    exit();
    277e:	e8 de 15 00 00       	call   3d61 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2783:	50                   	push   %eax
    2784:	50                   	push   %eax
    2785:	68 10 58 00 00       	push   $0x5810
    278a:	6a 01                	push   $0x1
    278c:	e8 4f 17 00 00       	call   3ee0 <printf>
    exit();
    2791:	e8 cb 15 00 00       	call   3d61 <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2796:	52                   	push   %edx
    2797:	52                   	push   %edx
    2798:	68 c0 57 00 00       	push   $0x57c0
    279d:	6a 01                	push   $0x1
    279f:	e8 3c 17 00 00       	call   3ee0 <printf>
    exit();
    27a4:	e8 b8 15 00 00       	call   3d61 <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    27a9:	51                   	push   %ecx
    27aa:	51                   	push   %ecx
    27ab:	68 84 57 00 00       	push   $0x5784
    27b0:	6a 01                	push   $0x1
    27b2:	e8 29 17 00 00       	call   3ee0 <printf>
    exit();
    27b7:	e8 a5 15 00 00       	call   3d61 <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    27bc:	51                   	push   %ecx
    27bd:	51                   	push   %ecx
    27be:	68 14 57 00 00       	push   $0x5714
    27c3:	6a 01                	push   $0x1
    27c5:	e8 16 17 00 00       	call   3ee0 <printf>
    exit();
    27ca:	e8 92 15 00 00       	call   3d61 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    27cf:	50                   	push   %eax
    27d0:	50                   	push   %eax
    27d1:	68 b4 56 00 00       	push   $0x56b4
    27d6:	6a 01                	push   $0x1
    27d8:	e8 03 17 00 00       	call   3ee0 <printf>
    exit();
    27dd:	e8 7f 15 00 00       	call   3d61 <exit>
    27e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    27e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000027f0 <rmdot>:
{
    27f0:	55                   	push   %ebp
    27f1:	89 e5                	mov    %esp,%ebp
    27f3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    27f6:	68 07 4e 00 00       	push   $0x4e07
    27fb:	6a 01                	push   $0x1
    27fd:	e8 de 16 00 00       	call   3ee0 <printf>
  if(mkdir("dots") != 0){
    2802:	c7 04 24 13 4e 00 00 	movl   $0x4e13,(%esp)
    2809:	e8 bb 15 00 00       	call   3dc9 <mkdir>
    280e:	83 c4 10             	add    $0x10,%esp
    2811:	85 c0                	test   %eax,%eax
    2813:	0f 85 b0 00 00 00    	jne    28c9 <rmdot+0xd9>
  if(chdir("dots") != 0){
    2819:	83 ec 0c             	sub    $0xc,%esp
    281c:	68 13 4e 00 00       	push   $0x4e13
    2821:	e8 ab 15 00 00       	call   3dd1 <chdir>
    2826:	83 c4 10             	add    $0x10,%esp
    2829:	85 c0                	test   %eax,%eax
    282b:	0f 85 1d 01 00 00    	jne    294e <rmdot+0x15e>
  if(unlink(".") == 0){
    2831:	83 ec 0c             	sub    $0xc,%esp
    2834:	68 be 4a 00 00       	push   $0x4abe
    2839:	e8 73 15 00 00       	call   3db1 <unlink>
    283e:	83 c4 10             	add    $0x10,%esp
    2841:	85 c0                	test   %eax,%eax
    2843:	0f 84 f2 00 00 00    	je     293b <rmdot+0x14b>
  if(unlink("..") == 0){
    2849:	83 ec 0c             	sub    $0xc,%esp
    284c:	68 bd 4a 00 00       	push   $0x4abd
    2851:	e8 5b 15 00 00       	call   3db1 <unlink>
    2856:	83 c4 10             	add    $0x10,%esp
    2859:	85 c0                	test   %eax,%eax
    285b:	0f 84 c7 00 00 00    	je     2928 <rmdot+0x138>
  if(chdir("/") != 0){
    2861:	83 ec 0c             	sub    $0xc,%esp
    2864:	68 91 42 00 00       	push   $0x4291
    2869:	e8 63 15 00 00       	call   3dd1 <chdir>
    286e:	83 c4 10             	add    $0x10,%esp
    2871:	85 c0                	test   %eax,%eax
    2873:	0f 85 9c 00 00 00    	jne    2915 <rmdot+0x125>
  if(unlink("dots/.") == 0){
    2879:	83 ec 0c             	sub    $0xc,%esp
    287c:	68 5b 4e 00 00       	push   $0x4e5b
    2881:	e8 2b 15 00 00       	call   3db1 <unlink>
    2886:	83 c4 10             	add    $0x10,%esp
    2889:	85 c0                	test   %eax,%eax
    288b:	74 75                	je     2902 <rmdot+0x112>
  if(unlink("dots/..") == 0){
    288d:	83 ec 0c             	sub    $0xc,%esp
    2890:	68 79 4e 00 00       	push   $0x4e79
    2895:	e8 17 15 00 00       	call   3db1 <unlink>
    289a:	83 c4 10             	add    $0x10,%esp
    289d:	85 c0                	test   %eax,%eax
    289f:	74 4e                	je     28ef <rmdot+0xff>
  if(unlink("dots") != 0){
    28a1:	83 ec 0c             	sub    $0xc,%esp
    28a4:	68 13 4e 00 00       	push   $0x4e13
    28a9:	e8 03 15 00 00       	call   3db1 <unlink>
    28ae:	83 c4 10             	add    $0x10,%esp
    28b1:	85 c0                	test   %eax,%eax
    28b3:	75 27                	jne    28dc <rmdot+0xec>
  printf(1, "rmdot ok\n");
    28b5:	83 ec 08             	sub    $0x8,%esp
    28b8:	68 ae 4e 00 00       	push   $0x4eae
    28bd:	6a 01                	push   $0x1
    28bf:	e8 1c 16 00 00       	call   3ee0 <printf>
}
    28c4:	83 c4 10             	add    $0x10,%esp
    28c7:	c9                   	leave  
    28c8:	c3                   	ret    
    printf(1, "mkdir dots failed\n");
    28c9:	50                   	push   %eax
    28ca:	50                   	push   %eax
    28cb:	68 18 4e 00 00       	push   $0x4e18
    28d0:	6a 01                	push   $0x1
    28d2:	e8 09 16 00 00       	call   3ee0 <printf>
    exit();
    28d7:	e8 85 14 00 00       	call   3d61 <exit>
    printf(1, "unlink dots failed!\n");
    28dc:	50                   	push   %eax
    28dd:	50                   	push   %eax
    28de:	68 99 4e 00 00       	push   $0x4e99
    28e3:	6a 01                	push   $0x1
    28e5:	e8 f6 15 00 00       	call   3ee0 <printf>
    exit();
    28ea:	e8 72 14 00 00       	call   3d61 <exit>
    printf(1, "unlink dots/.. worked!\n");
    28ef:	52                   	push   %edx
    28f0:	52                   	push   %edx
    28f1:	68 81 4e 00 00       	push   $0x4e81
    28f6:	6a 01                	push   $0x1
    28f8:	e8 e3 15 00 00       	call   3ee0 <printf>
    exit();
    28fd:	e8 5f 14 00 00       	call   3d61 <exit>
    printf(1, "unlink dots/. worked!\n");
    2902:	51                   	push   %ecx
    2903:	51                   	push   %ecx
    2904:	68 62 4e 00 00       	push   $0x4e62
    2909:	6a 01                	push   $0x1
    290b:	e8 d0 15 00 00       	call   3ee0 <printf>
    exit();
    2910:	e8 4c 14 00 00       	call   3d61 <exit>
    printf(1, "chdir / failed\n");
    2915:	50                   	push   %eax
    2916:	50                   	push   %eax
    2917:	68 93 42 00 00       	push   $0x4293
    291c:	6a 01                	push   $0x1
    291e:	e8 bd 15 00 00       	call   3ee0 <printf>
    exit();
    2923:	e8 39 14 00 00       	call   3d61 <exit>
    printf(1, "rm .. worked!\n");
    2928:	50                   	push   %eax
    2929:	50                   	push   %eax
    292a:	68 4c 4e 00 00       	push   $0x4e4c
    292f:	6a 01                	push   $0x1
    2931:	e8 aa 15 00 00       	call   3ee0 <printf>
    exit();
    2936:	e8 26 14 00 00       	call   3d61 <exit>
    printf(1, "rm . worked!\n");
    293b:	50                   	push   %eax
    293c:	50                   	push   %eax
    293d:	68 3e 4e 00 00       	push   $0x4e3e
    2942:	6a 01                	push   $0x1
    2944:	e8 97 15 00 00       	call   3ee0 <printf>
    exit();
    2949:	e8 13 14 00 00       	call   3d61 <exit>
    printf(1, "chdir dots failed\n");
    294e:	50                   	push   %eax
    294f:	50                   	push   %eax
    2950:	68 2b 4e 00 00       	push   $0x4e2b
    2955:	6a 01                	push   $0x1
    2957:	e8 84 15 00 00       	call   3ee0 <printf>
    exit();
    295c:	e8 00 14 00 00       	call   3d61 <exit>
    2961:	eb 0d                	jmp    2970 <dirfile>
    2963:	90                   	nop
    2964:	90                   	nop
    2965:	90                   	nop
    2966:	90                   	nop
    2967:	90                   	nop
    2968:	90                   	nop
    2969:	90                   	nop
    296a:	90                   	nop
    296b:	90                   	nop
    296c:	90                   	nop
    296d:	90                   	nop
    296e:	90                   	nop
    296f:	90                   	nop

00002970 <dirfile>:
{
    2970:	55                   	push   %ebp
    2971:	89 e5                	mov    %esp,%ebp
    2973:	53                   	push   %ebx
    2974:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "dir vs file\n");
    2977:	68 b8 4e 00 00       	push   $0x4eb8
    297c:	6a 01                	push   $0x1
    297e:	e8 5d 15 00 00       	call   3ee0 <printf>
  fd = open("dirfile", O_CREATE);
    2983:	59                   	pop    %ecx
    2984:	5b                   	pop    %ebx
    2985:	68 00 02 00 00       	push   $0x200
    298a:	68 c5 4e 00 00       	push   $0x4ec5
    298f:	e8 0d 14 00 00       	call   3da1 <open>
  if(fd < 0){
    2994:	83 c4 10             	add    $0x10,%esp
    2997:	85 c0                	test   %eax,%eax
    2999:	0f 88 43 01 00 00    	js     2ae2 <dirfile+0x172>
  close(fd);
    299f:	83 ec 0c             	sub    $0xc,%esp
    29a2:	50                   	push   %eax
    29a3:	e8 e1 13 00 00       	call   3d89 <close>
  if(chdir("dirfile") == 0){
    29a8:	c7 04 24 c5 4e 00 00 	movl   $0x4ec5,(%esp)
    29af:	e8 1d 14 00 00       	call   3dd1 <chdir>
    29b4:	83 c4 10             	add    $0x10,%esp
    29b7:	85 c0                	test   %eax,%eax
    29b9:	0f 84 10 01 00 00    	je     2acf <dirfile+0x15f>
  fd = open("dirfile/xx", 0);
    29bf:	83 ec 08             	sub    $0x8,%esp
    29c2:	6a 00                	push   $0x0
    29c4:	68 fe 4e 00 00       	push   $0x4efe
    29c9:	e8 d3 13 00 00       	call   3da1 <open>
  if(fd >= 0){
    29ce:	83 c4 10             	add    $0x10,%esp
    29d1:	85 c0                	test   %eax,%eax
    29d3:	0f 89 e3 00 00 00    	jns    2abc <dirfile+0x14c>
  fd = open("dirfile/xx", O_CREATE);
    29d9:	83 ec 08             	sub    $0x8,%esp
    29dc:	68 00 02 00 00       	push   $0x200
    29e1:	68 fe 4e 00 00       	push   $0x4efe
    29e6:	e8 b6 13 00 00       	call   3da1 <open>
  if(fd >= 0){
    29eb:	83 c4 10             	add    $0x10,%esp
    29ee:	85 c0                	test   %eax,%eax
    29f0:	0f 89 c6 00 00 00    	jns    2abc <dirfile+0x14c>
  if(mkdir("dirfile/xx") == 0){
    29f6:	83 ec 0c             	sub    $0xc,%esp
    29f9:	68 fe 4e 00 00       	push   $0x4efe
    29fe:	e8 c6 13 00 00       	call   3dc9 <mkdir>
    2a03:	83 c4 10             	add    $0x10,%esp
    2a06:	85 c0                	test   %eax,%eax
    2a08:	0f 84 46 01 00 00    	je     2b54 <dirfile+0x1e4>
  if(unlink("dirfile/xx") == 0){
    2a0e:	83 ec 0c             	sub    $0xc,%esp
    2a11:	68 fe 4e 00 00       	push   $0x4efe
    2a16:	e8 96 13 00 00       	call   3db1 <unlink>
    2a1b:	83 c4 10             	add    $0x10,%esp
    2a1e:	85 c0                	test   %eax,%eax
    2a20:	0f 84 1b 01 00 00    	je     2b41 <dirfile+0x1d1>
  if(link("README", "dirfile/xx") == 0){
    2a26:	83 ec 08             	sub    $0x8,%esp
    2a29:	68 fe 4e 00 00       	push   $0x4efe
    2a2e:	68 62 4f 00 00       	push   $0x4f62
    2a33:	e8 89 13 00 00       	call   3dc1 <link>
    2a38:	83 c4 10             	add    $0x10,%esp
    2a3b:	85 c0                	test   %eax,%eax
    2a3d:	0f 84 eb 00 00 00    	je     2b2e <dirfile+0x1be>
  if(unlink("dirfile") != 0){
    2a43:	83 ec 0c             	sub    $0xc,%esp
    2a46:	68 c5 4e 00 00       	push   $0x4ec5
    2a4b:	e8 61 13 00 00       	call   3db1 <unlink>
    2a50:	83 c4 10             	add    $0x10,%esp
    2a53:	85 c0                	test   %eax,%eax
    2a55:	0f 85 c0 00 00 00    	jne    2b1b <dirfile+0x1ab>
  fd = open(".", O_RDWR);
    2a5b:	83 ec 08             	sub    $0x8,%esp
    2a5e:	6a 02                	push   $0x2
    2a60:	68 be 4a 00 00       	push   $0x4abe
    2a65:	e8 37 13 00 00       	call   3da1 <open>
  if(fd >= 0){
    2a6a:	83 c4 10             	add    $0x10,%esp
    2a6d:	85 c0                	test   %eax,%eax
    2a6f:	0f 89 93 00 00 00    	jns    2b08 <dirfile+0x198>
  fd = open(".", 0);
    2a75:	83 ec 08             	sub    $0x8,%esp
    2a78:	6a 00                	push   $0x0
    2a7a:	68 be 4a 00 00       	push   $0x4abe
    2a7f:	e8 1d 13 00 00       	call   3da1 <open>
  if(write(fd, "x", 1) > 0){
    2a84:	83 c4 0c             	add    $0xc,%esp
    2a87:	6a 01                	push   $0x1
  fd = open(".", 0);
    2a89:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2a8b:	68 a1 4b 00 00       	push   $0x4ba1
    2a90:	50                   	push   %eax
    2a91:	e8 eb 12 00 00       	call   3d81 <write>
    2a96:	83 c4 10             	add    $0x10,%esp
    2a99:	85 c0                	test   %eax,%eax
    2a9b:	7f 58                	jg     2af5 <dirfile+0x185>
  close(fd);
    2a9d:	83 ec 0c             	sub    $0xc,%esp
    2aa0:	53                   	push   %ebx
    2aa1:	e8 e3 12 00 00       	call   3d89 <close>
  printf(1, "dir vs file OK\n");
    2aa6:	58                   	pop    %eax
    2aa7:	5a                   	pop    %edx
    2aa8:	68 95 4f 00 00       	push   $0x4f95
    2aad:	6a 01                	push   $0x1
    2aaf:	e8 2c 14 00 00       	call   3ee0 <printf>
}
    2ab4:	83 c4 10             	add    $0x10,%esp
    2ab7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2aba:	c9                   	leave  
    2abb:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    2abc:	50                   	push   %eax
    2abd:	50                   	push   %eax
    2abe:	68 09 4f 00 00       	push   $0x4f09
    2ac3:	6a 01                	push   $0x1
    2ac5:	e8 16 14 00 00       	call   3ee0 <printf>
    exit();
    2aca:	e8 92 12 00 00       	call   3d61 <exit>
    printf(1, "chdir dirfile succeeded!\n");
    2acf:	50                   	push   %eax
    2ad0:	50                   	push   %eax
    2ad1:	68 e4 4e 00 00       	push   $0x4ee4
    2ad6:	6a 01                	push   $0x1
    2ad8:	e8 03 14 00 00       	call   3ee0 <printf>
    exit();
    2add:	e8 7f 12 00 00       	call   3d61 <exit>
    printf(1, "create dirfile failed\n");
    2ae2:	52                   	push   %edx
    2ae3:	52                   	push   %edx
    2ae4:	68 cd 4e 00 00       	push   $0x4ecd
    2ae9:	6a 01                	push   $0x1
    2aeb:	e8 f0 13 00 00       	call   3ee0 <printf>
    exit();
    2af0:	e8 6c 12 00 00       	call   3d61 <exit>
    printf(1, "write . succeeded!\n");
    2af5:	51                   	push   %ecx
    2af6:	51                   	push   %ecx
    2af7:	68 81 4f 00 00       	push   $0x4f81
    2afc:	6a 01                	push   $0x1
    2afe:	e8 dd 13 00 00       	call   3ee0 <printf>
    exit();
    2b03:	e8 59 12 00 00       	call   3d61 <exit>
    printf(1, "open . for writing succeeded!\n");
    2b08:	53                   	push   %ebx
    2b09:	53                   	push   %ebx
    2b0a:	68 64 58 00 00       	push   $0x5864
    2b0f:	6a 01                	push   $0x1
    2b11:	e8 ca 13 00 00       	call   3ee0 <printf>
    exit();
    2b16:	e8 46 12 00 00       	call   3d61 <exit>
    printf(1, "unlink dirfile failed!\n");
    2b1b:	50                   	push   %eax
    2b1c:	50                   	push   %eax
    2b1d:	68 69 4f 00 00       	push   $0x4f69
    2b22:	6a 01                	push   $0x1
    2b24:	e8 b7 13 00 00       	call   3ee0 <printf>
    exit();
    2b29:	e8 33 12 00 00       	call   3d61 <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    2b2e:	50                   	push   %eax
    2b2f:	50                   	push   %eax
    2b30:	68 44 58 00 00       	push   $0x5844
    2b35:	6a 01                	push   $0x1
    2b37:	e8 a4 13 00 00       	call   3ee0 <printf>
    exit();
    2b3c:	e8 20 12 00 00       	call   3d61 <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2b41:	50                   	push   %eax
    2b42:	50                   	push   %eax
    2b43:	68 44 4f 00 00       	push   $0x4f44
    2b48:	6a 01                	push   $0x1
    2b4a:	e8 91 13 00 00       	call   3ee0 <printf>
    exit();
    2b4f:	e8 0d 12 00 00       	call   3d61 <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2b54:	50                   	push   %eax
    2b55:	50                   	push   %eax
    2b56:	68 27 4f 00 00       	push   $0x4f27
    2b5b:	6a 01                	push   $0x1
    2b5d:	e8 7e 13 00 00       	call   3ee0 <printf>
    exit();
    2b62:	e8 fa 11 00 00       	call   3d61 <exit>
    2b67:	89 f6                	mov    %esi,%esi
    2b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002b70 <iref>:
{
    2b70:	55                   	push   %ebp
    2b71:	89 e5                	mov    %esp,%ebp
    2b73:	53                   	push   %ebx
  printf(1, "empty file name\n");
    2b74:	bb 33 00 00 00       	mov    $0x33,%ebx
{
    2b79:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "empty file name\n");
    2b7c:	68 a5 4f 00 00       	push   $0x4fa5
    2b81:	6a 01                	push   $0x1
    2b83:	e8 58 13 00 00       	call   3ee0 <printf>
    2b88:	83 c4 10             	add    $0x10,%esp
    2b8b:	90                   	nop
    2b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(mkdir("irefd") != 0){
    2b90:	83 ec 0c             	sub    $0xc,%esp
    2b93:	68 b6 4f 00 00       	push   $0x4fb6
    2b98:	e8 2c 12 00 00       	call   3dc9 <mkdir>
    2b9d:	83 c4 10             	add    $0x10,%esp
    2ba0:	85 c0                	test   %eax,%eax
    2ba2:	0f 85 bb 00 00 00    	jne    2c63 <iref+0xf3>
    if(chdir("irefd") != 0){
    2ba8:	83 ec 0c             	sub    $0xc,%esp
    2bab:	68 b6 4f 00 00       	push   $0x4fb6
    2bb0:	e8 1c 12 00 00       	call   3dd1 <chdir>
    2bb5:	83 c4 10             	add    $0x10,%esp
    2bb8:	85 c0                	test   %eax,%eax
    2bba:	0f 85 b7 00 00 00    	jne    2c77 <iref+0x107>
    mkdir("");
    2bc0:	83 ec 0c             	sub    $0xc,%esp
    2bc3:	68 6b 46 00 00       	push   $0x466b
    2bc8:	e8 fc 11 00 00       	call   3dc9 <mkdir>
    link("README", "");
    2bcd:	59                   	pop    %ecx
    2bce:	58                   	pop    %eax
    2bcf:	68 6b 46 00 00       	push   $0x466b
    2bd4:	68 62 4f 00 00       	push   $0x4f62
    2bd9:	e8 e3 11 00 00       	call   3dc1 <link>
    fd = open("", O_CREATE);
    2bde:	58                   	pop    %eax
    2bdf:	5a                   	pop    %edx
    2be0:	68 00 02 00 00       	push   $0x200
    2be5:	68 6b 46 00 00       	push   $0x466b
    2bea:	e8 b2 11 00 00       	call   3da1 <open>
    if(fd >= 0)
    2bef:	83 c4 10             	add    $0x10,%esp
    2bf2:	85 c0                	test   %eax,%eax
    2bf4:	78 0c                	js     2c02 <iref+0x92>
      close(fd);
    2bf6:	83 ec 0c             	sub    $0xc,%esp
    2bf9:	50                   	push   %eax
    2bfa:	e8 8a 11 00 00       	call   3d89 <close>
    2bff:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2c02:	83 ec 08             	sub    $0x8,%esp
    2c05:	68 00 02 00 00       	push   $0x200
    2c0a:	68 a0 4b 00 00       	push   $0x4ba0
    2c0f:	e8 8d 11 00 00       	call   3da1 <open>
    if(fd >= 0)
    2c14:	83 c4 10             	add    $0x10,%esp
    2c17:	85 c0                	test   %eax,%eax
    2c19:	78 0c                	js     2c27 <iref+0xb7>
      close(fd);
    2c1b:	83 ec 0c             	sub    $0xc,%esp
    2c1e:	50                   	push   %eax
    2c1f:	e8 65 11 00 00       	call   3d89 <close>
    2c24:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2c27:	83 ec 0c             	sub    $0xc,%esp
    2c2a:	68 a0 4b 00 00       	push   $0x4ba0
    2c2f:	e8 7d 11 00 00       	call   3db1 <unlink>
  for(i = 0; i < 50 + 1; i++){
    2c34:	83 c4 10             	add    $0x10,%esp
    2c37:	83 eb 01             	sub    $0x1,%ebx
    2c3a:	0f 85 50 ff ff ff    	jne    2b90 <iref+0x20>
  chdir("/");
    2c40:	83 ec 0c             	sub    $0xc,%esp
    2c43:	68 91 42 00 00       	push   $0x4291
    2c48:	e8 84 11 00 00       	call   3dd1 <chdir>
  printf(1, "empty file name OK\n");
    2c4d:	58                   	pop    %eax
    2c4e:	5a                   	pop    %edx
    2c4f:	68 e4 4f 00 00       	push   $0x4fe4
    2c54:	6a 01                	push   $0x1
    2c56:	e8 85 12 00 00       	call   3ee0 <printf>
}
    2c5b:	83 c4 10             	add    $0x10,%esp
    2c5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c61:	c9                   	leave  
    2c62:	c3                   	ret    
      printf(1, "mkdir irefd failed\n");
    2c63:	83 ec 08             	sub    $0x8,%esp
    2c66:	68 bc 4f 00 00       	push   $0x4fbc
    2c6b:	6a 01                	push   $0x1
    2c6d:	e8 6e 12 00 00       	call   3ee0 <printf>
      exit();
    2c72:	e8 ea 10 00 00       	call   3d61 <exit>
      printf(1, "chdir irefd failed\n");
    2c77:	83 ec 08             	sub    $0x8,%esp
    2c7a:	68 d0 4f 00 00       	push   $0x4fd0
    2c7f:	6a 01                	push   $0x1
    2c81:	e8 5a 12 00 00       	call   3ee0 <printf>
      exit();
    2c86:	e8 d6 10 00 00       	call   3d61 <exit>
    2c8b:	90                   	nop
    2c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002c90 <childTest>:
void childTest() {
    2c90:	55                   	push   %ebp
    2c91:	89 e5                	mov    %esp,%ebp
    2c93:	83 ec 08             	sub    $0x8,%esp
    printf(1,"PARENT: Free pages before fork: %d\n",numFreePages());
    2c96:	e8 66 11 00 00       	call   3e01 <numFreePages>
    2c9b:	83 ec 04             	sub    $0x4,%esp
    2c9e:	50                   	push   %eax
    2c9f:	68 84 58 00 00       	push   $0x5884
    2ca4:	6a 01                	push   $0x1
    2ca6:	e8 35 12 00 00       	call   3ee0 <printf>
    if(fork() == 0) {
    2cab:	e8 a9 10 00 00       	call   3d59 <fork>
    2cb0:	83 c4 10             	add    $0x10,%esp
    2cb3:	85 c0                	test   %eax,%eax
    2cb5:	74 1f                	je     2cd6 <childTest+0x46>
    wait();
    2cb7:	e8 ad 10 00 00       	call   3d69 <wait>
    printf(1,"PARENT: Total free pages after child exits: %d\n",numFreePages());
    2cbc:	e8 40 11 00 00       	call   3e01 <numFreePages>
    2cc1:	83 ec 04             	sub    $0x4,%esp
    2cc4:	50                   	push   %eax
    2cc5:	68 bc 59 00 00       	push   $0x59bc
    2cca:	6a 01                	push   $0x1
    2ccc:	e8 0f 12 00 00       	call   3ee0 <printf>
    return ;
    2cd1:	83 c4 10             	add    $0x10,%esp
}
    2cd4:	c9                   	leave  
    2cd5:	c3                   	ret    
        printf(1,"CHILD: Free pages after fork: %d\n",numFreePages());
    2cd6:	e8 26 11 00 00       	call   3e01 <numFreePages>
    2cdb:	52                   	push   %edx
    2cdc:	50                   	push   %eax
    2cdd:	68 a8 58 00 00       	push   $0x58a8
    2ce2:	6a 01                	push   $0x1
    2ce4:	e8 f7 11 00 00       	call   3ee0 <printf>
        printf(1,"CHILD: Note this is less than before fork because we are copying one page directory, and all page tables, for the the child.\n");
    2ce9:	59                   	pop    %ecx
    2cea:	58                   	pop    %eax
    2ceb:	68 cc 58 00 00       	push   $0x58cc
    2cf0:	6a 01                	push   $0x1
    2cf2:	e8 e9 11 00 00       	call   3ee0 <printf>
        printf(1,"CHILD: Free pages before shared variable change: %d\n",numFreePages());
    2cf7:	e8 05 11 00 00       	call   3e01 <numFreePages>
    2cfc:	83 c4 0c             	add    $0xc,%esp
    2cff:	50                   	push   %eax
    2d00:	68 4c 59 00 00       	push   $0x594c
    2d05:	6a 01                	push   $0x1
    2d07:	e8 d4 11 00 00       	call   3ee0 <printf>
        sharedVariable = 2;
    2d0c:	c7 05 00 68 00 00 02 	movl   $0x2,0x6800
    2d13:	00 00 00 
        printf(1,"CHILD: Free pages after changing shared variable: %d\n",numFreePages());
    2d16:	e8 e6 10 00 00       	call   3e01 <numFreePages>
    2d1b:	83 c4 0c             	add    $0xc,%esp
    2d1e:	50                   	push   %eax
    2d1f:	68 84 59 00 00       	push   $0x5984
    2d24:	6a 01                	push   $0x1
    2d26:	e8 b5 11 00 00       	call   3ee0 <printf>
        exit();
    2d2b:	e8 31 10 00 00       	call   3d61 <exit>

00002d30 <grandchildTest>:
void grandchildTest() {
    2d30:	55                   	push   %ebp
    2d31:	89 e5                	mov    %esp,%ebp
    2d33:	83 ec 08             	sub    $0x8,%esp
    printf(1,"PARENT: Free pages before fork: %d\n",numFreePages());
    2d36:	e8 c6 10 00 00       	call   3e01 <numFreePages>
    2d3b:	83 ec 04             	sub    $0x4,%esp
    2d3e:	50                   	push   %eax
    2d3f:	68 84 58 00 00       	push   $0x5884
    2d44:	6a 01                	push   $0x1
    2d46:	e8 95 11 00 00       	call   3ee0 <printf>
    if(fork() == 0) {
    2d4b:	e8 09 10 00 00       	call   3d59 <fork>
    2d50:	83 c4 10             	add    $0x10,%esp
    2d53:	85 c0                	test   %eax,%eax
    2d55:	0f 85 85 00 00 00    	jne    2de0 <grandchildTest+0xb0>
        printf(1,"CHILD: Free pages after fork: %d\n",numFreePages());
    2d5b:	e8 a1 10 00 00       	call   3e01 <numFreePages>
    2d60:	83 ec 04             	sub    $0x4,%esp
    2d63:	50                   	push   %eax
    2d64:	68 a8 58 00 00       	push   $0x58a8
    2d69:	6a 01                	push   $0x1
    2d6b:	e8 70 11 00 00       	call   3ee0 <printf>
        if(fork() == 0) {
    2d70:	e8 e4 0f 00 00       	call   3d59 <fork>
    2d75:	83 c4 10             	add    $0x10,%esp
    2d78:	85 c0                	test   %eax,%eax
    2d7a:	75 3c                	jne    2db8 <grandchildTest+0x88>
            printf(1,"GRANDCHILD: Free pages before shared variable change: %d\n",numFreePages());
    2d7c:	e8 80 10 00 00       	call   3e01 <numFreePages>
    2d81:	83 ec 04             	sub    $0x4,%esp
    2d84:	50                   	push   %eax
    2d85:	68 ec 59 00 00       	push   $0x59ec
    2d8a:	6a 01                	push   $0x1
    2d8c:	e8 4f 11 00 00       	call   3ee0 <printf>
            sharedVariable = 5;
    2d91:	c7 05 00 68 00 00 05 	movl   $0x5,0x6800
    2d98:	00 00 00 
            printf(1,"GRANDCHILD: Free pages after shared variable change: %d\n",numFreePages());
    2d9b:	e8 61 10 00 00       	call   3e01 <numFreePages>
    2da0:	83 c4 0c             	add    $0xc,%esp
    2da3:	50                   	push   %eax
    2da4:	68 28 5a 00 00       	push   $0x5a28
    2da9:	6a 01                	push   $0x1
    2dab:	e8 30 11 00 00       	call   3ee0 <printf>
            exit();
    2db0:	e8 ac 0f 00 00       	call   3d61 <exit>
    2db5:	8d 76 00             	lea    0x0(%esi),%esi
        wait();
    2db8:	e8 ac 0f 00 00       	call   3d69 <wait>
        printf(1,"CHILD: Free pages after GRANDCHILD exits: %d\n",numFreePages());
    2dbd:	e8 3f 10 00 00       	call   3e01 <numFreePages>
    2dc2:	83 ec 04             	sub    $0x4,%esp
    2dc5:	50                   	push   %eax
    2dc6:	68 64 5a 00 00       	push   $0x5a64
    2dcb:	6a 01                	push   $0x1
    2dcd:	e8 0e 11 00 00       	call   3ee0 <printf>
        exit();
    2dd2:	e8 8a 0f 00 00       	call   3d61 <exit>
    2dd7:	89 f6                	mov    %esi,%esi
    2dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    wait();
    2de0:	e8 84 0f 00 00       	call   3d69 <wait>
    printf(1,"PARENT: Free pages after CHILD exits: %d\n",numFreePages());
    2de5:	e8 17 10 00 00       	call   3e01 <numFreePages>
    2dea:	83 ec 04             	sub    $0x4,%esp
    2ded:	50                   	push   %eax
    2dee:	68 94 5a 00 00       	push   $0x5a94
    2df3:	6a 01                	push   $0x1
    2df5:	e8 e6 10 00 00       	call   3ee0 <printf>
    return ;
    2dfa:	83 c4 10             	add    $0x10,%esp
}
    2dfd:	c9                   	leave  
    2dfe:	c3                   	ret    
    2dff:	90                   	nop

00002e00 <multiplePageWriteTest>:
void multiplePageWriteTest() {
    2e00:	55                   	push   %ebp
    2e01:	89 e5                	mov    %esp,%ebp
    2e03:	53                   	push   %ebx
    2e04:	83 ec 04             	sub    $0x4,%esp
  printf(1,"PARENT: Free pages before fork: %d\n", numFreePages());
    2e07:	e8 f5 0f 00 00       	call   3e01 <numFreePages>
    2e0c:	83 ec 04             	sub    $0x4,%esp
    2e0f:	50                   	push   %eax
    2e10:	68 84 58 00 00       	push   $0x5884
    2e15:	6a 01                	push   $0x1
    2e17:	e8 c4 10 00 00       	call   3ee0 <printf>
  if (fork() == 0) {
    2e1c:	e8 38 0f 00 00       	call   3d59 <fork>
    2e21:	83 c4 10             	add    $0x10,%esp
    2e24:	85 c0                	test   %eax,%eax
    2e26:	74 28                	je     2e50 <multiplePageWriteTest+0x50>
  wait();
    2e28:	e8 3c 0f 00 00       	call   3d69 <wait>
  printf(1,"PARENT: Free pages after CHILD exits: %d\n", numFreePages());
    2e2d:	e8 cf 0f 00 00       	call   3e01 <numFreePages>
    2e32:	83 ec 04             	sub    $0x4,%esp
    2e35:	50                   	push   %eax
    2e36:	68 94 5a 00 00       	push   $0x5a94
    2e3b:	6a 01                	push   $0x1
    2e3d:	e8 9e 10 00 00       	call   3ee0 <printf>
  contiguousArray[0] += contiguousArray[0];
    2e42:	d1 25 e0 8f 00 00    	shll   0x8fe0
}
    2e48:	83 c4 10             	add    $0x10,%esp
    2e4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2e4e:	c9                   	leave  
    2e4f:	c3                   	ret    
    2e50:	89 c3                	mov    %eax,%ebx
    printf(1,"CHILD: Free pages after fork: %d\n", numFreePages());
    2e52:	e8 aa 0f 00 00       	call   3e01 <numFreePages>
    2e57:	52                   	push   %edx
    2e58:	50                   	push   %eax
    2e59:	68 a8 58 00 00       	push   $0x58a8
    2e5e:	6a 01                	push   $0x1
    2e60:	e8 7b 10 00 00       	call   3ee0 <printf>
    2e65:	83 c4 10             	add    $0x10,%esp
      contiguousArray[i] = 42; 
    2e68:	c7 04 9d e0 8f 00 00 	movl   $0x2a,0x8fe0(,%ebx,4)
    2e6f:	2a 00 00 00 
    for (int i = 0; i < sizeOfArray; i += numIntsOnPage) {
    2e73:	81 c3 00 04 00 00    	add    $0x400,%ebx
      printf(1,"CHILD: Free pages after page write: %d\n", numFreePages());
    2e79:	e8 83 0f 00 00       	call   3e01 <numFreePages>
    2e7e:	83 ec 04             	sub    $0x4,%esp
    2e81:	50                   	push   %eax
    2e82:	68 c0 5a 00 00       	push   $0x5ac0
    2e87:	6a 01                	push   $0x1
    2e89:	e8 52 10 00 00       	call   3ee0 <printf>
    for (int i = 0; i < sizeOfArray; i += numIntsOnPage) {
    2e8e:	83 c4 10             	add    $0x10,%esp
    2e91:	81 fb 00 34 00 00    	cmp    $0x3400,%ebx
    2e97:	75 cf                	jne    2e68 <multiplePageWriteTest+0x68>
    exit();
    2e99:	e8 c3 0e 00 00       	call   3d61 <exit>
    2e9e:	66 90                	xchg   %ax,%ax

00002ea0 <copyOnWriteTest>:
void copyOnWriteTest() {
    2ea0:	55                   	push   %ebp
    2ea1:	89 e5                	mov    %esp,%ebp
    2ea3:	83 ec 10             	sub    $0x10,%esp
  printf(1,"Begin copy-on-write test.\n");
    2ea6:	68 f8 4f 00 00       	push   $0x4ff8
    2eab:	6a 01                	push   $0x1
    2ead:	e8 2e 10 00 00       	call   3ee0 <printf>
  printf(1,"*******************\n");
    2eb2:	58                   	pop    %eax
    2eb3:	5a                   	pop    %edx
    2eb4:	68 13 50 00 00       	push   $0x5013
    2eb9:	6a 01                	push   $0x1
    2ebb:	e8 20 10 00 00       	call   3ee0 <printf>
  printf(1,"Begin child test.\n");
    2ec0:	59                   	pop    %ecx
    2ec1:	58                   	pop    %eax
    2ec2:	68 28 50 00 00       	push   $0x5028
    2ec7:	6a 01                	push   $0x1
    2ec9:	e8 12 10 00 00       	call   3ee0 <printf>
  childTest();
    2ece:	e8 bd fd ff ff       	call   2c90 <childTest>
  printf(1,"End child test.\n");
    2ed3:	58                   	pop    %eax
    2ed4:	5a                   	pop    %edx
    2ed5:	68 3b 50 00 00       	push   $0x503b
    2eda:	6a 01                	push   $0x1
    2edc:	e8 ff 0f 00 00       	call   3ee0 <printf>
  printf(1,"*******************\n");
    2ee1:	59                   	pop    %ecx
    2ee2:	58                   	pop    %eax
    2ee3:	68 13 50 00 00       	push   $0x5013
    2ee8:	6a 01                	push   $0x1
    2eea:	e8 f1 0f 00 00       	call   3ee0 <printf>
  printf(1,"Begin grandchild test.\n");
    2eef:	58                   	pop    %eax
    2ef0:	5a                   	pop    %edx
    2ef1:	68 4c 50 00 00       	push   $0x504c
    2ef6:	6a 01                	push   $0x1
    2ef8:	e8 e3 0f 00 00       	call   3ee0 <printf>
  grandchildTest();
    2efd:	e8 2e fe ff ff       	call   2d30 <grandchildTest>
  printf(1,"End grandchild test.\n");
    2f02:	59                   	pop    %ecx
    2f03:	58                   	pop    %eax
    2f04:	68 64 50 00 00       	push   $0x5064
    2f09:	6a 01                	push   $0x1
    2f0b:	e8 d0 0f 00 00       	call   3ee0 <printf>
  printf(1,"*******************\n");
    2f10:	58                   	pop    %eax
    2f11:	5a                   	pop    %edx
    2f12:	68 13 50 00 00       	push   $0x5013
    2f17:	6a 01                	push   $0x1
    2f19:	e8 c2 0f 00 00       	call   3ee0 <printf>
  printf(1,"Begin mutiple page write test.\n");
    2f1e:	59                   	pop    %ecx
    2f1f:	58                   	pop    %eax
    2f20:	68 e8 5a 00 00       	push   $0x5ae8
    2f25:	6a 01                	push   $0x1
    2f27:	e8 b4 0f 00 00       	call   3ee0 <printf>
  multiplePageWriteTest();
    2f2c:	e8 cf fe ff ff       	call   2e00 <multiplePageWriteTest>
  printf(1,"End mutiple page write test.\n");
    2f31:	58                   	pop    %eax
    2f32:	5a                   	pop    %edx
    2f33:	68 7a 50 00 00       	push   $0x507a
    2f38:	6a 01                	push   $0x1
    2f3a:	e8 a1 0f 00 00       	call   3ee0 <printf>
  printf(1,"*******************\n");
    2f3f:	59                   	pop    %ecx
    2f40:	58                   	pop    %eax
    2f41:	68 13 50 00 00       	push   $0x5013
    2f46:	6a 01                	push   $0x1
    2f48:	e8 93 0f 00 00       	call   3ee0 <printf>
  printf(1,"End copy-on-write test.\n");
    2f4d:	58                   	pop    %eax
    2f4e:	5a                   	pop    %edx
    2f4f:	68 98 50 00 00       	push   $0x5098
    2f54:	6a 01                	push   $0x1
    2f56:	e8 85 0f 00 00       	call   3ee0 <printf>
}
    2f5b:	83 c4 10             	add    $0x10,%esp
    2f5e:	c9                   	leave  
    2f5f:	c3                   	ret    

00002f60 <forktest>:
{
    2f60:	55                   	push   %ebp
    2f61:	89 e5                	mov    %esp,%ebp
    2f63:	53                   	push   %ebx
  for(n=0; n<1000; n++){
    2f64:	31 db                	xor    %ebx,%ebx
{
    2f66:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "fork test\n");
    2f69:	68 b1 50 00 00       	push   $0x50b1
    2f6e:	6a 01                	push   $0x1
    2f70:	e8 6b 0f 00 00       	call   3ee0 <printf>
    2f75:	83 c4 10             	add    $0x10,%esp
    2f78:	eb 13                	jmp    2f8d <forktest+0x2d>
    2f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pid == 0)
    2f80:	74 4a                	je     2fcc <forktest+0x6c>
  for(n=0; n<1000; n++){
    2f82:	83 c3 01             	add    $0x1,%ebx
    2f85:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2f8b:	74 6b                	je     2ff8 <forktest+0x98>
    pid = fork();
    2f8d:	e8 c7 0d 00 00       	call   3d59 <fork>
    if(pid < 0)
    2f92:	85 c0                	test   %eax,%eax
    2f94:	79 ea                	jns    2f80 <forktest+0x20>
  for(; n > 0; n--){
    2f96:	85 db                	test   %ebx,%ebx
    2f98:	74 14                	je     2fae <forktest+0x4e>
    2f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait() < 0){
    2fa0:	e8 c4 0d 00 00       	call   3d69 <wait>
    2fa5:	85 c0                	test   %eax,%eax
    2fa7:	78 28                	js     2fd1 <forktest+0x71>
  for(; n > 0; n--){
    2fa9:	83 eb 01             	sub    $0x1,%ebx
    2fac:	75 f2                	jne    2fa0 <forktest+0x40>
  if(wait() != -1){
    2fae:	e8 b6 0d 00 00       	call   3d69 <wait>
    2fb3:	83 f8 ff             	cmp    $0xffffffff,%eax
    2fb6:	75 2d                	jne    2fe5 <forktest+0x85>
  printf(1, "fork test OK\n");
    2fb8:	83 ec 08             	sub    $0x8,%esp
    2fbb:	68 e3 50 00 00       	push   $0x50e3
    2fc0:	6a 01                	push   $0x1
    2fc2:	e8 19 0f 00 00       	call   3ee0 <printf>
}
    2fc7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2fca:	c9                   	leave  
    2fcb:	c3                   	ret    
      exit();
    2fcc:	e8 90 0d 00 00       	call   3d61 <exit>
      printf(1, "wait stopped early\n");
    2fd1:	83 ec 08             	sub    $0x8,%esp
    2fd4:	68 bc 50 00 00       	push   $0x50bc
    2fd9:	6a 01                	push   $0x1
    2fdb:	e8 00 0f 00 00       	call   3ee0 <printf>
      exit();
    2fe0:	e8 7c 0d 00 00       	call   3d61 <exit>
    printf(1, "wait got too many\n");
    2fe5:	52                   	push   %edx
    2fe6:	52                   	push   %edx
    2fe7:	68 d0 50 00 00       	push   $0x50d0
    2fec:	6a 01                	push   $0x1
    2fee:	e8 ed 0e 00 00       	call   3ee0 <printf>
    exit();
    2ff3:	e8 69 0d 00 00       	call   3d61 <exit>
    printf(1, "fork claimed to work 1000 times!\n");
    2ff8:	50                   	push   %eax
    2ff9:	50                   	push   %eax
    2ffa:	68 08 5b 00 00       	push   $0x5b08
    2fff:	6a 01                	push   $0x1
    3001:	e8 da 0e 00 00       	call   3ee0 <printf>
    exit();
    3006:	e8 56 0d 00 00       	call   3d61 <exit>
    300b:	90                   	nop
    300c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003010 <sbrktest>:
{
    3010:	55                   	push   %ebp
    3011:	89 e5                	mov    %esp,%ebp
    3013:	57                   	push   %edi
  for(i = 0; i < 5000; i++){
    3014:	31 ff                	xor    %edi,%edi
{
    3016:	56                   	push   %esi
    3017:	53                   	push   %ebx
    3018:	83 ec 54             	sub    $0x54,%esp
  printf(stdout, "sbrk test\n");
    301b:	68 f1 50 00 00       	push   $0x50f1
    3020:	ff 35 d4 67 00 00    	pushl  0x67d4
    3026:	e8 b5 0e 00 00       	call   3ee0 <printf>
  oldbrk = sbrk(0);
    302b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3032:	e8 b2 0d 00 00       	call   3de9 <sbrk>
  a = sbrk(0);
    3037:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  oldbrk = sbrk(0);
    303e:	89 c3                	mov    %eax,%ebx
  a = sbrk(0);
    3040:	e8 a4 0d 00 00       	call   3de9 <sbrk>
    3045:	83 c4 10             	add    $0x10,%esp
    3048:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 5000; i++){
    304a:	eb 06                	jmp    3052 <sbrktest+0x42>
    304c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    a = b + 1;
    3050:	89 c6                	mov    %eax,%esi
    b = sbrk(1);
    3052:	83 ec 0c             	sub    $0xc,%esp
    3055:	6a 01                	push   $0x1
    3057:	e8 8d 0d 00 00       	call   3de9 <sbrk>
    if(b != a){
    305c:	83 c4 10             	add    $0x10,%esp
    305f:	39 f0                	cmp    %esi,%eax
    3061:	0f 85 94 02 00 00    	jne    32fb <sbrktest+0x2eb>
  for(i = 0; i < 5000; i++){
    3067:	83 c7 01             	add    $0x1,%edi
    *b = 1;
    306a:	c6 06 01             	movb   $0x1,(%esi)
    a = b + 1;
    306d:	8d 46 01             	lea    0x1(%esi),%eax
  for(i = 0; i < 5000; i++){
    3070:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    3076:	75 d8                	jne    3050 <sbrktest+0x40>
  pid = fork();
    3078:	e8 dc 0c 00 00       	call   3d59 <fork>
    307d:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    307f:	85 c0                	test   %eax,%eax
    3081:	0f 88 a1 03 00 00    	js     3428 <sbrktest+0x418>
  c = sbrk(1);
    3087:	83 ec 0c             	sub    $0xc,%esp
  if(c != a + 1){
    308a:	83 c6 02             	add    $0x2,%esi
  c = sbrk(1);
    308d:	6a 01                	push   $0x1
    308f:	e8 55 0d 00 00       	call   3de9 <sbrk>
  c = sbrk(1);
    3094:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    309b:	e8 49 0d 00 00       	call   3de9 <sbrk>
  if(c != a + 1){
    30a0:	83 c4 10             	add    $0x10,%esp
    30a3:	39 f0                	cmp    %esi,%eax
    30a5:	0f 85 66 03 00 00    	jne    3411 <sbrktest+0x401>
  if(pid == 0)
    30ab:	85 ff                	test   %edi,%edi
    30ad:	0f 84 59 03 00 00    	je     340c <sbrktest+0x3fc>
  wait();
    30b3:	e8 b1 0c 00 00       	call   3d69 <wait>
  a = sbrk(0);
    30b8:	83 ec 0c             	sub    $0xc,%esp
    30bb:	6a 00                	push   $0x0
    30bd:	e8 27 0d 00 00       	call   3de9 <sbrk>
    30c2:	89 c6                	mov    %eax,%esi
  amt = (BIG) - (uint)a;
    30c4:	b8 00 00 40 06       	mov    $0x6400000,%eax
    30c9:	29 f0                	sub    %esi,%eax
  p = sbrk(amt);
    30cb:	89 04 24             	mov    %eax,(%esp)
    30ce:	e8 16 0d 00 00       	call   3de9 <sbrk>
  if (p != a) {
    30d3:	83 c4 10             	add    $0x10,%esp
    30d6:	39 c6                	cmp    %eax,%esi
    30d8:	0f 85 17 03 00 00    	jne    33f5 <sbrktest+0x3e5>
  a = sbrk(0);
    30de:	83 ec 0c             	sub    $0xc,%esp
  *lastaddr = 99;
    30e1:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
  a = sbrk(0);
    30e8:	6a 00                	push   $0x0
    30ea:	e8 fa 0c 00 00       	call   3de9 <sbrk>
  c = sbrk(-4096);
    30ef:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  a = sbrk(0);
    30f6:	89 c6                	mov    %eax,%esi
  c = sbrk(-4096);
    30f8:	e8 ec 0c 00 00       	call   3de9 <sbrk>
  if(c == (char*)0xffffffff){
    30fd:	83 c4 10             	add    $0x10,%esp
    3100:	83 f8 ff             	cmp    $0xffffffff,%eax
    3103:	0f 84 d5 02 00 00    	je     33de <sbrktest+0x3ce>
  c = sbrk(0);
    3109:	83 ec 0c             	sub    $0xc,%esp
    310c:	6a 00                	push   $0x0
    310e:	e8 d6 0c 00 00       	call   3de9 <sbrk>
  if(c != a - 4096){
    3113:	8d 96 00 f0 ff ff    	lea    -0x1000(%esi),%edx
    3119:	83 c4 10             	add    $0x10,%esp
    311c:	39 d0                	cmp    %edx,%eax
    311e:	0f 85 a3 02 00 00    	jne    33c7 <sbrktest+0x3b7>
  a = sbrk(0);
    3124:	83 ec 0c             	sub    $0xc,%esp
    3127:	6a 00                	push   $0x0
    3129:	e8 bb 0c 00 00       	call   3de9 <sbrk>
  c = sbrk(4096);
    312e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  a = sbrk(0);
    3135:	89 c6                	mov    %eax,%esi
  c = sbrk(4096);
    3137:	e8 ad 0c 00 00       	call   3de9 <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    313c:	83 c4 10             	add    $0x10,%esp
  c = sbrk(4096);
    313f:	89 c7                	mov    %eax,%edi
  if(c != a || sbrk(0) != a + 4096){
    3141:	39 c6                	cmp    %eax,%esi
    3143:	0f 85 67 02 00 00    	jne    33b0 <sbrktest+0x3a0>
    3149:	83 ec 0c             	sub    $0xc,%esp
    314c:	6a 00                	push   $0x0
    314e:	e8 96 0c 00 00       	call   3de9 <sbrk>
    3153:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    3159:	83 c4 10             	add    $0x10,%esp
    315c:	39 d0                	cmp    %edx,%eax
    315e:	0f 85 4c 02 00 00    	jne    33b0 <sbrktest+0x3a0>
  if(*lastaddr == 99){
    3164:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    316b:	0f 84 28 02 00 00    	je     3399 <sbrktest+0x389>
  a = sbrk(0);
    3171:	83 ec 0c             	sub    $0xc,%esp
    3174:	6a 00                	push   $0x0
    3176:	e8 6e 0c 00 00       	call   3de9 <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    317b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  a = sbrk(0);
    3182:	89 c6                	mov    %eax,%esi
  c = sbrk(-(sbrk(0) - oldbrk));
    3184:	e8 60 0c 00 00       	call   3de9 <sbrk>
    3189:	89 d9                	mov    %ebx,%ecx
    318b:	29 c1                	sub    %eax,%ecx
    318d:	89 0c 24             	mov    %ecx,(%esp)
    3190:	e8 54 0c 00 00       	call   3de9 <sbrk>
  if(c != a){
    3195:	83 c4 10             	add    $0x10,%esp
    3198:	39 c6                	cmp    %eax,%esi
    319a:	0f 85 e2 01 00 00    	jne    3382 <sbrktest+0x372>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    31a0:	be 00 00 00 80       	mov    $0x80000000,%esi
    31a5:	8d 76 00             	lea    0x0(%esi),%esi
    ppid = getpid();
    31a8:	e8 34 0c 00 00       	call   3de1 <getpid>
    31ad:	89 c7                	mov    %eax,%edi
    pid = fork();
    31af:	e8 a5 0b 00 00       	call   3d59 <fork>
    if(pid < 0){
    31b4:	85 c0                	test   %eax,%eax
    31b6:	0f 88 ae 01 00 00    	js     336a <sbrktest+0x35a>
    if(pid == 0){
    31bc:	0f 84 86 01 00 00    	je     3348 <sbrktest+0x338>
    wait();
    31c2:	e8 a2 0b 00 00       	call   3d69 <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    31c7:	81 c6 50 c3 00 00    	add    $0xc350,%esi
    31cd:	81 fe 80 84 1e 80    	cmp    $0x801e8480,%esi
    31d3:	75 d3                	jne    31a8 <sbrktest+0x198>
  printf(stdout, "Finish: Attempting to read the kernel's memory.\n");
    31d5:	83 ec 08             	sub    $0x8,%esp
    31d8:	68 20 5c 00 00       	push   $0x5c20
    31dd:	ff 35 d4 67 00 00    	pushl  0x67d4
    31e3:	e8 f8 0c 00 00       	call   3ee0 <printf>
  if(pipe(fds) != 0){
    31e8:	8d 45 b8             	lea    -0x48(%ebp),%eax
    31eb:	89 04 24             	mov    %eax,(%esp)
    31ee:	e8 7e 0b 00 00       	call   3d71 <pipe>
    31f3:	83 c4 10             	add    $0x10,%esp
    31f6:	85 c0                	test   %eax,%eax
    31f8:	0f 85 32 01 00 00    	jne    3330 <sbrktest+0x320>
    31fe:	8d 75 c0             	lea    -0x40(%ebp),%esi
    3201:	89 f7                	mov    %esi,%edi
    if((pids[i] = fork()) == 0){
    3203:	e8 51 0b 00 00       	call   3d59 <fork>
    3208:	89 07                	mov    %eax,(%edi)
    320a:	85 c0                	test   %eax,%eax
    320c:	0f 84 8f 00 00 00    	je     32a1 <sbrktest+0x291>
    if(pids[i] != -1)
    3212:	83 f8 ff             	cmp    $0xffffffff,%eax
    3215:	74 14                	je     322b <sbrktest+0x21b>
      read(fds[0], &scratch, 1);
    3217:	83 ec 04             	sub    $0x4,%esp
    321a:	8d 45 b7             	lea    -0x49(%ebp),%eax
    321d:	6a 01                	push   $0x1
    321f:	50                   	push   %eax
    3220:	ff 75 b8             	pushl  -0x48(%ebp)
    3223:	e8 51 0b 00 00       	call   3d79 <read>
    3228:	83 c4 10             	add    $0x10,%esp
    322b:	83 c7 04             	add    $0x4,%edi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    322e:	8d 45 e8             	lea    -0x18(%ebp),%eax
    3231:	39 c7                	cmp    %eax,%edi
    3233:	75 ce                	jne    3203 <sbrktest+0x1f3>
  c = sbrk(4096);
    3235:	83 ec 0c             	sub    $0xc,%esp
    3238:	68 00 10 00 00       	push   $0x1000
    323d:	e8 a7 0b 00 00       	call   3de9 <sbrk>
    3242:	83 c4 10             	add    $0x10,%esp
    3245:	89 c7                	mov    %eax,%edi
    if(pids[i] == -1)
    3247:	8b 06                	mov    (%esi),%eax
    3249:	83 f8 ff             	cmp    $0xffffffff,%eax
    324c:	74 11                	je     325f <sbrktest+0x24f>
    kill(pids[i]);
    324e:	83 ec 0c             	sub    $0xc,%esp
    3251:	50                   	push   %eax
    3252:	e8 3a 0b 00 00       	call   3d91 <kill>
    wait();
    3257:	e8 0d 0b 00 00       	call   3d69 <wait>
    325c:	83 c4 10             	add    $0x10,%esp
    325f:	83 c6 04             	add    $0x4,%esi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3262:	8d 45 e8             	lea    -0x18(%ebp),%eax
    3265:	39 c6                	cmp    %eax,%esi
    3267:	75 de                	jne    3247 <sbrktest+0x237>
  if(c == (char*)0xffffffff){
    3269:	83 ff ff             	cmp    $0xffffffff,%edi
    326c:	0f 84 a7 00 00 00    	je     3319 <sbrktest+0x309>
  if(sbrk(0) > oldbrk)
    3272:	83 ec 0c             	sub    $0xc,%esp
    3275:	6a 00                	push   $0x0
    3277:	e8 6d 0b 00 00       	call   3de9 <sbrk>
    327c:	83 c4 10             	add    $0x10,%esp
    327f:	39 d8                	cmp    %ebx,%eax
    3281:	77 5f                	ja     32e2 <sbrktest+0x2d2>
  printf(stdout, "sbrk test OK\n");
    3283:	83 ec 08             	sub    $0x8,%esp
    3286:	68 99 51 00 00       	push   $0x5199
    328b:	ff 35 d4 67 00 00    	pushl  0x67d4
    3291:	e8 4a 0c 00 00       	call   3ee0 <printf>
}
    3296:	83 c4 10             	add    $0x10,%esp
    3299:	8d 65 f4             	lea    -0xc(%ebp),%esp
    329c:	5b                   	pop    %ebx
    329d:	5e                   	pop    %esi
    329e:	5f                   	pop    %edi
    329f:	5d                   	pop    %ebp
    32a0:	c3                   	ret    
      sbrk(BIG - (uint)sbrk(0));
    32a1:	83 ec 0c             	sub    $0xc,%esp
    32a4:	6a 00                	push   $0x0
    32a6:	e8 3e 0b 00 00       	call   3de9 <sbrk>
    32ab:	ba 00 00 40 06       	mov    $0x6400000,%edx
    32b0:	29 c2                	sub    %eax,%edx
    32b2:	89 14 24             	mov    %edx,(%esp)
    32b5:	e8 2f 0b 00 00       	call   3de9 <sbrk>
      write(fds[1], "x", 1);
    32ba:	83 c4 0c             	add    $0xc,%esp
    32bd:	6a 01                	push   $0x1
    32bf:	68 a1 4b 00 00       	push   $0x4ba1
    32c4:	ff 75 bc             	pushl  -0x44(%ebp)
    32c7:	e8 b5 0a 00 00       	call   3d81 <write>
    32cc:	83 c4 10             	add    $0x10,%esp
    32cf:	90                   	nop
      for(;;) sleep(1000);
    32d0:	83 ec 0c             	sub    $0xc,%esp
    32d3:	68 e8 03 00 00       	push   $0x3e8
    32d8:	e8 14 0b 00 00       	call   3df1 <sleep>
    32dd:	83 c4 10             	add    $0x10,%esp
    32e0:	eb ee                	jmp    32d0 <sbrktest+0x2c0>
    sbrk(-(sbrk(0) - oldbrk));
    32e2:	83 ec 0c             	sub    $0xc,%esp
    32e5:	6a 00                	push   $0x0
    32e7:	e8 fd 0a 00 00       	call   3de9 <sbrk>
    32ec:	29 c3                	sub    %eax,%ebx
    32ee:	89 1c 24             	mov    %ebx,(%esp)
    32f1:	e8 f3 0a 00 00       	call   3de9 <sbrk>
    32f6:	83 c4 10             	add    $0x10,%esp
    32f9:	eb 88                	jmp    3283 <sbrktest+0x273>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    32fb:	83 ec 0c             	sub    $0xc,%esp
    32fe:	50                   	push   %eax
    32ff:	56                   	push   %esi
    3300:	57                   	push   %edi
    3301:	68 fc 50 00 00       	push   $0x50fc
    3306:	ff 35 d4 67 00 00    	pushl  0x67d4
    330c:	e8 cf 0b 00 00       	call   3ee0 <printf>
      exit();
    3311:	83 c4 20             	add    $0x20,%esp
    3314:	e8 48 0a 00 00       	call   3d61 <exit>
    printf(stdout, "failed sbrk leaked memory\n");
    3319:	50                   	push   %eax
    331a:	50                   	push   %eax
    331b:	68 7e 51 00 00       	push   $0x517e
    3320:	ff 35 d4 67 00 00    	pushl  0x67d4
    3326:	e8 b5 0b 00 00       	call   3ee0 <printf>
    exit();
    332b:	e8 31 0a 00 00       	call   3d61 <exit>
    printf(1, "pipe() failed\n");
    3330:	52                   	push   %edx
    3331:	52                   	push   %edx
    3332:	68 81 45 00 00       	push   $0x4581
    3337:	6a 01                	push   $0x1
    3339:	e8 a2 0b 00 00       	call   3ee0 <printf>
    exit();
    333e:	e8 1e 0a 00 00       	call   3d61 <exit>
    3343:	90                   	nop
    3344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(stdout, "oops could read %x = %x\n", a, *a);
    3348:	0f be 06             	movsbl (%esi),%eax
    334b:	50                   	push   %eax
    334c:	56                   	push   %esi
    334d:	68 65 51 00 00       	push   $0x5165
    3352:	ff 35 d4 67 00 00    	pushl  0x67d4
    3358:	e8 83 0b 00 00       	call   3ee0 <printf>
      kill(ppid);
    335d:	89 3c 24             	mov    %edi,(%esp)
    3360:	e8 2c 0a 00 00       	call   3d91 <kill>
      exit();
    3365:	e8 f7 09 00 00       	call   3d61 <exit>
      printf(stdout, "fork failed\n");
    336a:	83 ec 08             	sub    $0x8,%esp
    336d:	68 42 52 00 00       	push   $0x5242
    3372:	ff 35 d4 67 00 00    	pushl  0x67d4
    3378:	e8 63 0b 00 00       	call   3ee0 <printf>
      exit();
    337d:	e8 df 09 00 00       	call   3d61 <exit>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    3382:	50                   	push   %eax
    3383:	56                   	push   %esi
    3384:	68 fc 5b 00 00       	push   $0x5bfc
    3389:	ff 35 d4 67 00 00    	pushl  0x67d4
    338f:	e8 4c 0b 00 00       	call   3ee0 <printf>
    exit();
    3394:	e8 c8 09 00 00       	call   3d61 <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    3399:	51                   	push   %ecx
    339a:	51                   	push   %ecx
    339b:	68 cc 5b 00 00       	push   $0x5bcc
    33a0:	ff 35 d4 67 00 00    	pushl  0x67d4
    33a6:	e8 35 0b 00 00       	call   3ee0 <printf>
    exit();
    33ab:	e8 b1 09 00 00       	call   3d61 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    33b0:	57                   	push   %edi
    33b1:	56                   	push   %esi
    33b2:	68 a4 5b 00 00       	push   $0x5ba4
    33b7:	ff 35 d4 67 00 00    	pushl  0x67d4
    33bd:	e8 1e 0b 00 00       	call   3ee0 <printf>
    exit();
    33c2:	e8 9a 09 00 00       	call   3d61 <exit>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    33c7:	50                   	push   %eax
    33c8:	56                   	push   %esi
    33c9:	68 6c 5b 00 00       	push   $0x5b6c
    33ce:	ff 35 d4 67 00 00    	pushl  0x67d4
    33d4:	e8 07 0b 00 00       	call   3ee0 <printf>
    exit();
    33d9:	e8 83 09 00 00       	call   3d61 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    33de:	53                   	push   %ebx
    33df:	53                   	push   %ebx
    33e0:	68 4a 51 00 00       	push   $0x514a
    33e5:	ff 35 d4 67 00 00    	pushl  0x67d4
    33eb:	e8 f0 0a 00 00       	call   3ee0 <printf>
    exit();
    33f0:	e8 6c 09 00 00       	call   3d61 <exit>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    33f5:	56                   	push   %esi
    33f6:	56                   	push   %esi
    33f7:	68 2c 5b 00 00       	push   $0x5b2c
    33fc:	ff 35 d4 67 00 00    	pushl  0x67d4
    3402:	e8 d9 0a 00 00       	call   3ee0 <printf>
    exit();
    3407:	e8 55 09 00 00       	call   3d61 <exit>
    exit();
    340c:	e8 50 09 00 00       	call   3d61 <exit>
    printf(stdout, "sbrk test failed post-fork\n");
    3411:	57                   	push   %edi
    3412:	57                   	push   %edi
    3413:	68 2e 51 00 00       	push   $0x512e
    3418:	ff 35 d4 67 00 00    	pushl  0x67d4
    341e:	e8 bd 0a 00 00       	call   3ee0 <printf>
    exit();
    3423:	e8 39 09 00 00       	call   3d61 <exit>
    printf(stdout, "sbrk test fork failed\n");
    3428:	50                   	push   %eax
    3429:	50                   	push   %eax
    342a:	68 17 51 00 00       	push   $0x5117
    342f:	ff 35 d4 67 00 00    	pushl  0x67d4
    3435:	e8 a6 0a 00 00       	call   3ee0 <printf>
    exit();
    343a:	e8 22 09 00 00       	call   3d61 <exit>
    343f:	90                   	nop

00003440 <validateint>:
}
    3440:	c3                   	ret    
    3441:	eb 0d                	jmp    3450 <validatetest>
    3443:	90                   	nop
    3444:	90                   	nop
    3445:	90                   	nop
    3446:	90                   	nop
    3447:	90                   	nop
    3448:	90                   	nop
    3449:	90                   	nop
    344a:	90                   	nop
    344b:	90                   	nop
    344c:	90                   	nop
    344d:	90                   	nop
    344e:	90                   	nop
    344f:	90                   	nop

00003450 <validatetest>:
{
    3450:	55                   	push   %ebp
    3451:	89 e5                	mov    %esp,%ebp
    3453:	56                   	push   %esi
    3454:	53                   	push   %ebx
  for(p = 0; p <= (uint)hi; p += 4096){
    3455:	31 db                	xor    %ebx,%ebx
  printf(stdout, "validate test\n");
    3457:	83 ec 08             	sub    $0x8,%esp
    345a:	68 a7 51 00 00       	push   $0x51a7
    345f:	ff 35 d4 67 00 00    	pushl  0x67d4
    3465:	e8 76 0a 00 00       	call   3ee0 <printf>
    346a:	83 c4 10             	add    $0x10,%esp
    346d:	8d 76 00             	lea    0x0(%esi),%esi
    if((pid = fork()) == 0){
    3470:	e8 e4 08 00 00       	call   3d59 <fork>
    3475:	89 c6                	mov    %eax,%esi
    3477:	85 c0                	test   %eax,%eax
    3479:	74 63                	je     34de <validatetest+0x8e>
    sleep(0);
    347b:	83 ec 0c             	sub    $0xc,%esp
    347e:	6a 00                	push   $0x0
    3480:	e8 6c 09 00 00       	call   3df1 <sleep>
    sleep(0);
    3485:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    348c:	e8 60 09 00 00       	call   3df1 <sleep>
    kill(pid);
    3491:	89 34 24             	mov    %esi,(%esp)
    3494:	e8 f8 08 00 00       	call   3d91 <kill>
    wait();
    3499:	e8 cb 08 00 00       	call   3d69 <wait>
    if(link("nosuchfile", (char*)p) != -1){
    349e:	58                   	pop    %eax
    349f:	5a                   	pop    %edx
    34a0:	53                   	push   %ebx
    34a1:	68 b6 51 00 00       	push   $0x51b6
    34a6:	e8 16 09 00 00       	call   3dc1 <link>
    34ab:	83 c4 10             	add    $0x10,%esp
    34ae:	83 f8 ff             	cmp    $0xffffffff,%eax
    34b1:	75 30                	jne    34e3 <validatetest+0x93>
  for(p = 0; p <= (uint)hi; p += 4096){
    34b3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    34b9:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    34bf:	75 af                	jne    3470 <validatetest+0x20>
  printf(stdout, "validate ok\n");
    34c1:	83 ec 08             	sub    $0x8,%esp
    34c4:	68 da 51 00 00       	push   $0x51da
    34c9:	ff 35 d4 67 00 00    	pushl  0x67d4
    34cf:	e8 0c 0a 00 00       	call   3ee0 <printf>
}
    34d4:	83 c4 10             	add    $0x10,%esp
    34d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    34da:	5b                   	pop    %ebx
    34db:	5e                   	pop    %esi
    34dc:	5d                   	pop    %ebp
    34dd:	c3                   	ret    
      exit();
    34de:	e8 7e 08 00 00       	call   3d61 <exit>
      printf(stdout, "link should not succeed\n");
    34e3:	83 ec 08             	sub    $0x8,%esp
    34e6:	68 c1 51 00 00       	push   $0x51c1
    34eb:	ff 35 d4 67 00 00    	pushl  0x67d4
    34f1:	e8 ea 09 00 00       	call   3ee0 <printf>
      exit();
    34f6:	e8 66 08 00 00       	call   3d61 <exit>
    34fb:	90                   	nop
    34fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003500 <bsstest>:
{
    3500:	55                   	push   %ebp
    3501:	89 e5                	mov    %esp,%ebp
    3503:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "bss test\n");
    3506:	68 e7 51 00 00       	push   $0x51e7
    350b:	ff 35 d4 67 00 00    	pushl  0x67d4
    3511:	e8 ca 09 00 00       	call   3ee0 <printf>
    if(uninit[i] != '\0'){
    3516:	83 c4 10             	add    $0x10,%esp
    3519:	80 3d c0 68 00 00 00 	cmpb   $0x0,0x68c0
    3520:	75 39                	jne    355b <bsstest+0x5b>
  for(i = 0; i < sizeof(uninit); i++){
    3522:	b8 01 00 00 00       	mov    $0x1,%eax
    3527:	89 f6                	mov    %esi,%esi
    3529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(uninit[i] != '\0'){
    3530:	80 b8 c0 68 00 00 00 	cmpb   $0x0,0x68c0(%eax)
    3537:	75 22                	jne    355b <bsstest+0x5b>
  for(i = 0; i < sizeof(uninit); i++){
    3539:	83 c0 01             	add    $0x1,%eax
    353c:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3541:	75 ed                	jne    3530 <bsstest+0x30>
  printf(stdout, "bss test ok\n");
    3543:	83 ec 08             	sub    $0x8,%esp
    3546:	68 02 52 00 00       	push   $0x5202
    354b:	ff 35 d4 67 00 00    	pushl  0x67d4
    3551:	e8 8a 09 00 00       	call   3ee0 <printf>
}
    3556:	83 c4 10             	add    $0x10,%esp
    3559:	c9                   	leave  
    355a:	c3                   	ret    
      printf(stdout, "bss test failed\n");
    355b:	83 ec 08             	sub    $0x8,%esp
    355e:	68 f1 51 00 00       	push   $0x51f1
    3563:	ff 35 d4 67 00 00    	pushl  0x67d4
    3569:	e8 72 09 00 00       	call   3ee0 <printf>
      exit();
    356e:	e8 ee 07 00 00       	call   3d61 <exit>
    3573:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003580 <bigargtest>:
{
    3580:	55                   	push   %ebp
    3581:	89 e5                	mov    %esp,%ebp
    3583:	83 ec 14             	sub    $0x14,%esp
  unlink("bigarg-ok");
    3586:	68 0f 52 00 00       	push   $0x520f
    358b:	e8 21 08 00 00       	call   3db1 <unlink>
  pid = fork();
    3590:	e8 c4 07 00 00       	call   3d59 <fork>
  if(pid == 0){
    3595:	83 c4 10             	add    $0x10,%esp
    3598:	85 c0                	test   %eax,%eax
    359a:	74 44                	je     35e0 <bigargtest+0x60>
  } else if(pid < 0){
    359c:	0f 88 c5 00 00 00    	js     3667 <bigargtest+0xe7>
  wait();
    35a2:	e8 c2 07 00 00       	call   3d69 <wait>
  fd = open("bigarg-ok", 0);
    35a7:	83 ec 08             	sub    $0x8,%esp
    35aa:	6a 00                	push   $0x0
    35ac:	68 0f 52 00 00       	push   $0x520f
    35b1:	e8 eb 07 00 00       	call   3da1 <open>
  if(fd < 0){
    35b6:	83 c4 10             	add    $0x10,%esp
    35b9:	85 c0                	test   %eax,%eax
    35bb:	0f 88 8f 00 00 00    	js     3650 <bigargtest+0xd0>
  close(fd);
    35c1:	83 ec 0c             	sub    $0xc,%esp
    35c4:	50                   	push   %eax
    35c5:	e8 bf 07 00 00       	call   3d89 <close>
  unlink("bigarg-ok");
    35ca:	c7 04 24 0f 52 00 00 	movl   $0x520f,(%esp)
    35d1:	e8 db 07 00 00       	call   3db1 <unlink>
}
    35d6:	83 c4 10             	add    $0x10,%esp
    35d9:	c9                   	leave  
    35da:	c3                   	ret    
    35db:	90                   	nop
    35dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    35e0:	c7 04 85 20 68 00 00 	movl   $0x5c54,0x6820(,%eax,4)
    35e7:	54 5c 00 00 
    for(i = 0; i < MAXARG-1; i++)
    35eb:	83 c0 01             	add    $0x1,%eax
    35ee:	83 f8 1f             	cmp    $0x1f,%eax
    35f1:	75 ed                	jne    35e0 <bigargtest+0x60>
    printf(stdout, "bigarg test\n");
    35f3:	51                   	push   %ecx
    35f4:	51                   	push   %ecx
    35f5:	68 19 52 00 00       	push   $0x5219
    35fa:	ff 35 d4 67 00 00    	pushl  0x67d4
    args[MAXARG-1] = 0;
    3600:	c7 05 9c 68 00 00 00 	movl   $0x0,0x689c
    3607:	00 00 00 
    printf(stdout, "bigarg test\n");
    360a:	e8 d1 08 00 00       	call   3ee0 <printf>
    exec("echo", args);
    360f:	58                   	pop    %eax
    3610:	5a                   	pop    %edx
    3611:	68 20 68 00 00       	push   $0x6820
    3616:	68 2d 43 00 00       	push   $0x432d
    361b:	e8 79 07 00 00       	call   3d99 <exec>
    printf(stdout, "bigarg test ok\n");
    3620:	59                   	pop    %ecx
    3621:	58                   	pop    %eax
    3622:	68 26 52 00 00       	push   $0x5226
    3627:	ff 35 d4 67 00 00    	pushl  0x67d4
    362d:	e8 ae 08 00 00       	call   3ee0 <printf>
    fd = open("bigarg-ok", O_CREATE);
    3632:	58                   	pop    %eax
    3633:	5a                   	pop    %edx
    3634:	68 00 02 00 00       	push   $0x200
    3639:	68 0f 52 00 00       	push   $0x520f
    363e:	e8 5e 07 00 00       	call   3da1 <open>
    close(fd);
    3643:	89 04 24             	mov    %eax,(%esp)
    3646:	e8 3e 07 00 00       	call   3d89 <close>
    exit();
    364b:	e8 11 07 00 00       	call   3d61 <exit>
    printf(stdout, "bigarg test failed!\n");
    3650:	50                   	push   %eax
    3651:	50                   	push   %eax
    3652:	68 4f 52 00 00       	push   $0x524f
    3657:	ff 35 d4 67 00 00    	pushl  0x67d4
    365d:	e8 7e 08 00 00       	call   3ee0 <printf>
    exit();
    3662:	e8 fa 06 00 00       	call   3d61 <exit>
    printf(stdout, "bigargtest: fork failed\n");
    3667:	52                   	push   %edx
    3668:	52                   	push   %edx
    3669:	68 36 52 00 00       	push   $0x5236
    366e:	ff 35 d4 67 00 00    	pushl  0x67d4
    3674:	e8 67 08 00 00       	call   3ee0 <printf>
    exit();
    3679:	e8 e3 06 00 00       	call   3d61 <exit>
    367e:	66 90                	xchg   %ax,%ax

00003680 <fsfull>:
{
    3680:	55                   	push   %ebp
    3681:	89 e5                	mov    %esp,%ebp
    3683:	57                   	push   %edi
    3684:	56                   	push   %esi
  for(nfiles = 0; ; nfiles++){
    3685:	31 f6                	xor    %esi,%esi
{
    3687:	53                   	push   %ebx
    3688:	83 ec 54             	sub    $0x54,%esp
  printf(1, "fsfull test\n");
    368b:	68 64 52 00 00       	push   $0x5264
    3690:	6a 01                	push   $0x1
    3692:	e8 49 08 00 00       	call   3ee0 <printf>
    3697:	83 c4 10             	add    $0x10,%esp
    369a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    name[1] = '0' + nfiles / 1000;
    36a0:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    36a5:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    printf(1, "writing %s\n", name);
    36aa:	83 ec 04             	sub    $0x4,%esp
    name[0] = 'f';
    36ad:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    36b1:	f7 e6                	mul    %esi
    name[5] = '\0';
    36b3:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    36b7:	c1 ea 06             	shr    $0x6,%edx
    36ba:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    36bd:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    name[1] = '0' + nfiles / 1000;
    36c3:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    36c6:	89 f0                	mov    %esi,%eax
    36c8:	29 d0                	sub    %edx,%eax
    36ca:	89 c2                	mov    %eax,%edx
    36cc:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    36d1:	f7 e2                	mul    %edx
    name[3] = '0' + (nfiles % 100) / 10;
    36d3:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    36d8:	c1 ea 05             	shr    $0x5,%edx
    36db:	83 c2 30             	add    $0x30,%edx
    36de:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    36e1:	f7 e6                	mul    %esi
    36e3:	89 f0                	mov    %esi,%eax
    36e5:	c1 ea 05             	shr    $0x5,%edx
    36e8:	6b d2 64             	imul   $0x64,%edx,%edx
    36eb:	29 d0                	sub    %edx,%eax
    36ed:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    36ef:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    36f1:	c1 ea 03             	shr    $0x3,%edx
    36f4:	83 c2 30             	add    $0x30,%edx
    36f7:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    36fa:	f7 e1                	mul    %ecx
    36fc:	89 f1                	mov    %esi,%ecx
    36fe:	c1 ea 03             	shr    $0x3,%edx
    3701:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3704:	01 c0                	add    %eax,%eax
    3706:	29 c1                	sub    %eax,%ecx
    3708:	89 c8                	mov    %ecx,%eax
    370a:	83 c0 30             	add    $0x30,%eax
    370d:	88 45 ac             	mov    %al,-0x54(%ebp)
    printf(1, "writing %s\n", name);
    3710:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3713:	50                   	push   %eax
    3714:	68 71 52 00 00       	push   $0x5271
    3719:	6a 01                	push   $0x1
    371b:	e8 c0 07 00 00       	call   3ee0 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    3720:	58                   	pop    %eax
    3721:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3724:	5a                   	pop    %edx
    3725:	68 02 02 00 00       	push   $0x202
    372a:	50                   	push   %eax
    372b:	e8 71 06 00 00       	call   3da1 <open>
    if(fd < 0){
    3730:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    3733:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    3735:	85 c0                	test   %eax,%eax
    3737:	78 4d                	js     3786 <fsfull+0x106>
    int total = 0;
    3739:	31 db                	xor    %ebx,%ebx
    373b:	eb 05                	jmp    3742 <fsfull+0xc2>
    373d:	8d 76 00             	lea    0x0(%esi),%esi
      total += cc;
    3740:	01 c3                	add    %eax,%ebx
      int cc = write(fd, buf, 512);
    3742:	83 ec 04             	sub    $0x4,%esp
    3745:	68 00 02 00 00       	push   $0x200
    374a:	68 e0 5f 01 00       	push   $0x15fe0
    374f:	57                   	push   %edi
    3750:	e8 2c 06 00 00       	call   3d81 <write>
      if(cc < 512)
    3755:	83 c4 10             	add    $0x10,%esp
    3758:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    375d:	7f e1                	jg     3740 <fsfull+0xc0>
    printf(1, "wrote %d bytes\n", total);
    375f:	83 ec 04             	sub    $0x4,%esp
    3762:	53                   	push   %ebx
    3763:	68 8d 52 00 00       	push   $0x528d
    3768:	6a 01                	push   $0x1
    376a:	e8 71 07 00 00       	call   3ee0 <printf>
    close(fd);
    376f:	89 3c 24             	mov    %edi,(%esp)
    3772:	e8 12 06 00 00       	call   3d89 <close>
    if(total == 0)
    3777:	83 c4 10             	add    $0x10,%esp
    377a:	85 db                	test   %ebx,%ebx
    377c:	74 1e                	je     379c <fsfull+0x11c>
  for(nfiles = 0; ; nfiles++){
    377e:	83 c6 01             	add    $0x1,%esi
    3781:	e9 1a ff ff ff       	jmp    36a0 <fsfull+0x20>
      printf(1, "open %s failed\n", name);
    3786:	83 ec 04             	sub    $0x4,%esp
    3789:	8d 45 a8             	lea    -0x58(%ebp),%eax
    378c:	50                   	push   %eax
    378d:	68 7d 52 00 00       	push   $0x527d
    3792:	6a 01                	push   $0x1
    3794:	e8 47 07 00 00       	call   3ee0 <printf>
      break;
    3799:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + nfiles / 1000;
    379c:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    name[2] = '0' + (nfiles % 1000) / 100;
    37a1:	bb 1f 85 eb 51       	mov    $0x51eb851f,%ebx
    37a6:	8d 76 00             	lea    0x0(%esi),%esi
    37a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    name[1] = '0' + nfiles / 1000;
    37b0:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    37b2:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    unlink(name);
    37b7:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'f';
    37ba:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    37be:	f7 e7                	mul    %edi
    name[5] = '\0';
    37c0:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    37c4:	c1 ea 06             	shr    $0x6,%edx
    37c7:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    37ca:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    name[1] = '0' + nfiles / 1000;
    37d0:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    37d3:	89 f0                	mov    %esi,%eax
    37d5:	29 d0                	sub    %edx,%eax
    37d7:	f7 e3                	mul    %ebx
    name[3] = '0' + (nfiles % 100) / 10;
    37d9:	89 f0                	mov    %esi,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    37db:	c1 ea 05             	shr    $0x5,%edx
    37de:	83 c2 30             	add    $0x30,%edx
    37e1:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    37e4:	f7 e3                	mul    %ebx
    37e6:	89 f0                	mov    %esi,%eax
    37e8:	c1 ea 05             	shr    $0x5,%edx
    37eb:	6b d2 64             	imul   $0x64,%edx,%edx
    37ee:	29 d0                	sub    %edx,%eax
    37f0:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    37f2:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    37f4:	c1 ea 03             	shr    $0x3,%edx
    37f7:	83 c2 30             	add    $0x30,%edx
    37fa:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    37fd:	f7 e1                	mul    %ecx
    37ff:	89 f1                	mov    %esi,%ecx
    nfiles--;
    3801:	83 ee 01             	sub    $0x1,%esi
    name[4] = '0' + (nfiles % 10);
    3804:	c1 ea 03             	shr    $0x3,%edx
    3807:	8d 04 92             	lea    (%edx,%edx,4),%eax
    380a:	01 c0                	add    %eax,%eax
    380c:	29 c1                	sub    %eax,%ecx
    380e:	89 c8                	mov    %ecx,%eax
    3810:	83 c0 30             	add    $0x30,%eax
    3813:	88 45 ac             	mov    %al,-0x54(%ebp)
    unlink(name);
    3816:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3819:	50                   	push   %eax
    381a:	e8 92 05 00 00       	call   3db1 <unlink>
  while(nfiles >= 0){
    381f:	83 c4 10             	add    $0x10,%esp
    3822:	83 fe ff             	cmp    $0xffffffff,%esi
    3825:	75 89                	jne    37b0 <fsfull+0x130>
  printf(1, "fsfull test finished\n");
    3827:	83 ec 08             	sub    $0x8,%esp
    382a:	68 9d 52 00 00       	push   $0x529d
    382f:	6a 01                	push   $0x1
    3831:	e8 aa 06 00 00       	call   3ee0 <printf>
}
    3836:	83 c4 10             	add    $0x10,%esp
    3839:	8d 65 f4             	lea    -0xc(%ebp),%esp
    383c:	5b                   	pop    %ebx
    383d:	5e                   	pop    %esi
    383e:	5f                   	pop    %edi
    383f:	5d                   	pop    %ebp
    3840:	c3                   	ret    
    3841:	eb 0d                	jmp    3850 <uio>
    3843:	90                   	nop
    3844:	90                   	nop
    3845:	90                   	nop
    3846:	90                   	nop
    3847:	90                   	nop
    3848:	90                   	nop
    3849:	90                   	nop
    384a:	90                   	nop
    384b:	90                   	nop
    384c:	90                   	nop
    384d:	90                   	nop
    384e:	90                   	nop
    384f:	90                   	nop

00003850 <uio>:
{
    3850:	55                   	push   %ebp
    3851:	89 e5                	mov    %esp,%ebp
    3853:	83 ec 10             	sub    $0x10,%esp
  printf(1, "uio test\n");
    3856:	68 b3 52 00 00       	push   $0x52b3
    385b:	6a 01                	push   $0x1
    385d:	e8 7e 06 00 00       	call   3ee0 <printf>
  pid = fork();
    3862:	e8 f2 04 00 00       	call   3d59 <fork>
  if(pid == 0){
    3867:	83 c4 10             	add    $0x10,%esp
    386a:	85 c0                	test   %eax,%eax
    386c:	74 1b                	je     3889 <uio+0x39>
  } else if(pid < 0){
    386e:	78 3d                	js     38ad <uio+0x5d>
  wait();
    3870:	e8 f4 04 00 00       	call   3d69 <wait>
  printf(1, "uio test done\n");
    3875:	83 ec 08             	sub    $0x8,%esp
    3878:	68 bd 52 00 00       	push   $0x52bd
    387d:	6a 01                	push   $0x1
    387f:	e8 5c 06 00 00       	call   3ee0 <printf>
}
    3884:	83 c4 10             	add    $0x10,%esp
    3887:	c9                   	leave  
    3888:	c3                   	ret    
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    3889:	b8 09 00 00 00       	mov    $0x9,%eax
    388e:	ba 70 00 00 00       	mov    $0x70,%edx
    3893:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    3894:	ba 71 00 00 00       	mov    $0x71,%edx
    3899:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    389a:	52                   	push   %edx
    389b:	52                   	push   %edx
    389c:	68 34 5d 00 00       	push   $0x5d34
    38a1:	6a 01                	push   $0x1
    38a3:	e8 38 06 00 00       	call   3ee0 <printf>
    exit();
    38a8:	e8 b4 04 00 00       	call   3d61 <exit>
    printf (1, "fork failed\n");
    38ad:	50                   	push   %eax
    38ae:	50                   	push   %eax
    38af:	68 42 52 00 00       	push   $0x5242
    38b4:	6a 01                	push   $0x1
    38b6:	e8 25 06 00 00       	call   3ee0 <printf>
    exit();
    38bb:	e8 a1 04 00 00       	call   3d61 <exit>

000038c0 <argptest>:
{
    38c0:	55                   	push   %ebp
    38c1:	89 e5                	mov    %esp,%ebp
    38c3:	53                   	push   %ebx
    38c4:	83 ec 0c             	sub    $0xc,%esp
  fd = open("init", O_RDONLY);
    38c7:	6a 00                	push   $0x0
    38c9:	68 cc 52 00 00       	push   $0x52cc
    38ce:	e8 ce 04 00 00       	call   3da1 <open>
  if (fd < 0) {
    38d3:	83 c4 10             	add    $0x10,%esp
    38d6:	85 c0                	test   %eax,%eax
    38d8:	78 39                	js     3913 <argptest+0x53>
  read(fd, sbrk(0) - 1, -1);
    38da:	83 ec 0c             	sub    $0xc,%esp
    38dd:	89 c3                	mov    %eax,%ebx
    38df:	6a 00                	push   $0x0
    38e1:	e8 03 05 00 00       	call   3de9 <sbrk>
    38e6:	83 c4 0c             	add    $0xc,%esp
    38e9:	83 e8 01             	sub    $0x1,%eax
    38ec:	6a ff                	push   $0xffffffff
    38ee:	50                   	push   %eax
    38ef:	53                   	push   %ebx
    38f0:	e8 84 04 00 00       	call   3d79 <read>
  close(fd);
    38f5:	89 1c 24             	mov    %ebx,(%esp)
    38f8:	e8 8c 04 00 00       	call   3d89 <close>
  printf(1, "arg test passed\n");
    38fd:	58                   	pop    %eax
    38fe:	5a                   	pop    %edx
    38ff:	68 de 52 00 00       	push   $0x52de
    3904:	6a 01                	push   $0x1
    3906:	e8 d5 05 00 00       	call   3ee0 <printf>
}
    390b:	83 c4 10             	add    $0x10,%esp
    390e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3911:	c9                   	leave  
    3912:	c3                   	ret    
    printf(2, "open failed\n");
    3913:	51                   	push   %ecx
    3914:	51                   	push   %ecx
    3915:	68 d1 52 00 00       	push   $0x52d1
    391a:	6a 02                	push   $0x2
    391c:	e8 bf 05 00 00       	call   3ee0 <printf>
    exit();
    3921:	e8 3b 04 00 00       	call   3d61 <exit>
    3926:	8d 76 00             	lea    0x0(%esi),%esi
    3929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003930 <fib>:
int fib(int n) {
    3930:	55                   	push   %ebp
  if (n == 0 || n == 1)
    3931:	b8 01 00 00 00       	mov    $0x1,%eax
int fib(int n) {
    3936:	89 e5                	mov    %esp,%ebp
    3938:	56                   	push   %esi
    3939:	53                   	push   %ebx
    393a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (n == 0 || n == 1)
    393d:	83 fb 01             	cmp    $0x1,%ebx
    3940:	76 1e                	jbe    3960 <fib+0x30>
    3942:	31 f6                	xor    %esi,%esi
  return fib(n-1) + fib(n-2);
    3944:	83 ec 0c             	sub    $0xc,%esp
    3947:	8d 43 ff             	lea    -0x1(%ebx),%eax
    394a:	83 eb 02             	sub    $0x2,%ebx
    394d:	50                   	push   %eax
    394e:	e8 dd ff ff ff       	call   3930 <fib>
    3953:	83 c4 10             	add    $0x10,%esp
    3956:	01 c6                	add    %eax,%esi
  if (n == 0 || n == 1)
    3958:	83 fb 01             	cmp    $0x1,%ebx
    395b:	77 e7                	ja     3944 <fib+0x14>
    395d:	8d 46 01             	lea    0x1(%esi),%eax
}
    3960:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3963:	5b                   	pop    %ebx
    3964:	5e                   	pop    %esi
    3965:	5d                   	pop    %ebp
    3966:	c3                   	ret    
    3967:	89 f6                	mov    %esi,%esi
    3969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003970 <takeTime>:
void takeTime(int howLong) {
    3970:	55                   	push   %ebp
    3971:	89 e5                	mov    %esp,%ebp
    3973:	83 ec 08             	sub    $0x8,%esp
    3976:	8b 55 08             	mov    0x8(%ebp),%edx
  if (n == 0 || n == 1)
    3979:	83 fa 01             	cmp    $0x1,%edx
    397c:	76 17                	jbe    3995 <takeTime+0x25>
  return fib(n-1) + fib(n-2);
    397e:	83 ec 0c             	sub    $0xc,%esp
    3981:	8d 42 ff             	lea    -0x1(%edx),%eax
    3984:	50                   	push   %eax
    3985:	e8 a6 ff ff ff       	call   3930 <fib>
    398a:	83 c4 10             	add    $0x10,%esp
    398d:	83 ea 02             	sub    $0x2,%edx
  if (n == 0 || n == 1)
    3990:	83 fa 01             	cmp    $0x1,%edx
    3993:	77 e9                	ja     397e <takeTime+0xe>
}
    3995:	c9                   	leave  
    3996:	c3                   	ret    
    3997:	89 f6                	mov    %esi,%esi
    3999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000039a0 <ellusiveDot>:
void ellusiveDot() {
    39a0:	55                   	push   %ebp
    39a1:	89 e5                	mov    %esp,%ebp
    39a3:	56                   	push   %esi
    39a4:	53                   	push   %ebx
  printf(1,"PARENT: pid = %d\n", getpid());
    39a5:	bb 64 00 00 00       	mov    $0x64,%ebx
    39aa:	e8 32 04 00 00       	call   3de1 <getpid>
    39af:	83 ec 04             	sub    $0x4,%esp
    39b2:	50                   	push   %eax
    39b3:	68 ef 52 00 00       	push   $0x52ef
    39b8:	6a 01                	push   $0x1
    39ba:	e8 21 05 00 00       	call   3ee0 <printf>
    39bf:	83 c4 10             	add    $0x10,%esp
    39c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(fork() == 0) {
    39c8:	e8 8c 03 00 00       	call   3d59 <fork>
    39cd:	85 c0                	test   %eax,%eax
    39cf:	0f 84 87 00 00 00    	je     3a5c <ellusiveDot+0xbc>
  for(int n = 0; n < numProcs; n++){
    39d5:	83 eb 01             	sub    $0x1,%ebx
    39d8:	75 ee                	jne    39c8 <ellusiveDot+0x28>
  for (int i = 0; i < numDots; i++) {
    39da:	31 db                	xor    %ebx,%ebx
      if (i % 3 == 0) {
    39dc:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
    39e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    39e8:	89 d8                	mov    %ebx,%eax
    39ea:	f7 e6                	mul    %esi
    39ec:	d1 ea                	shr    %edx
    39ee:	8d 04 52             	lea    (%edx,%edx,2),%eax
    39f1:	39 c3                	cmp    %eax,%ebx
    39f3:	74 53                	je     3a48 <ellusiveDot+0xa8>
      printf(1, ".\n");
    39f5:	83 ec 08             	sub    $0x8,%esp
    39f8:	68 1f 53 00 00       	push   $0x531f
    39fd:	6a 01                	push   $0x1
    39ff:	e8 dc 04 00 00       	call   3ee0 <printf>
    3a04:	83 c4 10             	add    $0x10,%esp
    3a07:	ba 1b 00 00 00       	mov    $0x1b,%edx
  return fib(n-1) + fib(n-2);
    3a0c:	83 ec 0c             	sub    $0xc,%esp
    3a0f:	52                   	push   %edx
    3a10:	e8 1b ff ff ff       	call   3930 <fib>
    3a15:	83 c4 10             	add    $0x10,%esp
  if (n == 0 || n == 1)
    3a18:	83 ea 02             	sub    $0x2,%edx
    3a1b:	83 fa ff             	cmp    $0xffffffff,%edx
    3a1e:	75 ec                	jne    3a0c <ellusiveDot+0x6c>
  for (int i = 0; i < numDots; i++) {
    3a20:	83 c3 01             	add    $0x1,%ebx
    3a23:	83 fb 21             	cmp    $0x21,%ebx
    3a26:	75 c0                	jne    39e8 <ellusiveDot+0x48>
    3a28:	bb 64 00 00 00       	mov    $0x64,%ebx
    3a2d:	8d 76 00             	lea    0x0(%esi),%esi
    wait();
    3a30:	e8 34 03 00 00       	call   3d69 <wait>
  for(int n = 0; n < numProcs; n++){
    3a35:	83 eb 01             	sub    $0x1,%ebx
    3a38:	75 f6                	jne    3a30 <ellusiveDot+0x90>
}
    3a3a:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3a3d:	5b                   	pop    %ebx
    3a3e:	5e                   	pop    %esi
    3a3f:	5d                   	pop    %ebp
    3a40:	c3                   	ret    
    3a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"SPACE.\n");
    3a48:	83 ec 08             	sub    $0x8,%esp
    3a4b:	68 1a 53 00 00       	push   $0x531a
    3a50:	6a 01                	push   $0x1
    3a52:	e8 89 04 00 00       	call   3ee0 <printf>
    3a57:	83 c4 10             	add    $0x10,%esp
    3a5a:	eb 99                	jmp    39f5 <ellusiveDot+0x55>
    3a5c:	ba 24 00 00 00       	mov    $0x24,%edx
  return fib(n-1) + fib(n-2);
    3a61:	83 ec 0c             	sub    $0xc,%esp
    3a64:	52                   	push   %edx
    3a65:	e8 c6 fe ff ff       	call   3930 <fib>
    3a6a:	83 c4 10             	add    $0x10,%esp
  if (n == 0 || n == 1)
    3a6d:	83 ea 02             	sub    $0x2,%edx
    3a70:	75 ef                	jne    3a61 <ellusiveDot+0xc1>
      printf(1,"Child %d about to exit.\n", getpid());
    3a72:	e8 6a 03 00 00       	call   3de1 <getpid>
    3a77:	83 ec 04             	sub    $0x4,%esp
    3a7a:	50                   	push   %eax
    3a7b:	68 01 53 00 00       	push   $0x5301
    3a80:	6a 01                	push   $0x1
    3a82:	e8 59 04 00 00       	call   3ee0 <printf>
      exit();
    3a87:	e8 d5 02 00 00       	call   3d61 <exit>
    3a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003a90 <schedulerTest>:
void schedulerTest() {
    3a90:	55                   	push   %ebp
    3a91:	89 e5                	mov    %esp,%ebp
    3a93:	83 ec 08             	sub    $0x8,%esp
  ellusiveDot();
    3a96:	e8 05 ff ff ff       	call   39a0 <ellusiveDot>
  printf(1,"schedulerTest: changed to scheduler option %d\n", changeScheduler());
    3a9b:	e8 69 03 00 00       	call   3e09 <changeScheduler>
    3aa0:	83 ec 04             	sub    $0x4,%esp
    3aa3:	50                   	push   %eax
    3aa4:	68 58 5d 00 00       	push   $0x5d58
    3aa9:	6a 01                	push   $0x1
    3aab:	e8 30 04 00 00       	call   3ee0 <printf>
  ellusiveDot();
    3ab0:	e8 eb fe ff ff       	call   39a0 <ellusiveDot>
  printf(1,"schedulerTest: changed to scheduler option %d\n", changeScheduler());
    3ab5:	e8 4f 03 00 00       	call   3e09 <changeScheduler>
    3aba:	83 c4 0c             	add    $0xc,%esp
    3abd:	50                   	push   %eax
    3abe:	68 58 5d 00 00       	push   $0x5d58
    3ac3:	6a 01                	push   $0x1
    3ac5:	e8 16 04 00 00       	call   3ee0 <printf>
  ellusiveDot();
    3aca:	e8 d1 fe ff ff       	call   39a0 <ellusiveDot>
  printf(1,"schedulerTest: changed to scheduler option %d\n", changeScheduler());
    3acf:	e8 35 03 00 00       	call   3e09 <changeScheduler>
    3ad4:	83 c4 0c             	add    $0xc,%esp
    3ad7:	50                   	push   %eax
    3ad8:	68 58 5d 00 00       	push   $0x5d58
    3add:	6a 01                	push   $0x1
    3adf:	e8 fc 03 00 00       	call   3ee0 <printf>
  ellusiveDot();
    3ae4:	83 c4 10             	add    $0x10,%esp
}
    3ae7:	c9                   	leave  
  ellusiveDot();
    3ae8:	e9 b3 fe ff ff       	jmp    39a0 <ellusiveDot>
    3aed:	8d 76 00             	lea    0x0(%esi),%esi

00003af0 <rand>:
  randstate = randstate * 1664525 + 1013904223;
    3af0:	69 05 d0 67 00 00 0d 	imul   $0x19660d,0x67d0,%eax
    3af7:	66 19 00 
    3afa:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3aff:	a3 d0 67 00 00       	mov    %eax,0x67d0
}
    3b04:	c3                   	ret    
    3b05:	66 90                	xchg   %ax,%ax
    3b07:	66 90                	xchg   %ax,%ax
    3b09:	66 90                	xchg   %ax,%ax
    3b0b:	66 90                	xchg   %ax,%ax
    3b0d:	66 90                	xchg   %ax,%ax
    3b0f:	90                   	nop

00003b10 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3b10:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3b11:	31 d2                	xor    %edx,%edx
{
    3b13:	89 e5                	mov    %esp,%ebp
    3b15:	53                   	push   %ebx
    3b16:	8b 45 08             	mov    0x8(%ebp),%eax
    3b19:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    3b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3b20:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    3b24:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    3b27:	83 c2 01             	add    $0x1,%edx
    3b2a:	84 c9                	test   %cl,%cl
    3b2c:	75 f2                	jne    3b20 <strcpy+0x10>
    ;
  return os;
}
    3b2e:	5b                   	pop    %ebx
    3b2f:	5d                   	pop    %ebp
    3b30:	c3                   	ret    
    3b31:	eb 0d                	jmp    3b40 <strcmp>
    3b33:	90                   	nop
    3b34:	90                   	nop
    3b35:	90                   	nop
    3b36:	90                   	nop
    3b37:	90                   	nop
    3b38:	90                   	nop
    3b39:	90                   	nop
    3b3a:	90                   	nop
    3b3b:	90                   	nop
    3b3c:	90                   	nop
    3b3d:	90                   	nop
    3b3e:	90                   	nop
    3b3f:	90                   	nop

00003b40 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3b40:	55                   	push   %ebp
    3b41:	89 e5                	mov    %esp,%ebp
    3b43:	56                   	push   %esi
    3b44:	53                   	push   %ebx
    3b45:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3b48:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
    3b4b:	0f b6 13             	movzbl (%ebx),%edx
    3b4e:	0f b6 0e             	movzbl (%esi),%ecx
    3b51:	84 d2                	test   %dl,%dl
    3b53:	74 1e                	je     3b73 <strcmp+0x33>
    3b55:	b8 01 00 00 00       	mov    $0x1,%eax
    3b5a:	38 ca                	cmp    %cl,%dl
    3b5c:	74 09                	je     3b67 <strcmp+0x27>
    3b5e:	eb 20                	jmp    3b80 <strcmp+0x40>
    3b60:	83 c0 01             	add    $0x1,%eax
    3b63:	38 ca                	cmp    %cl,%dl
    3b65:	75 19                	jne    3b80 <strcmp+0x40>
    3b67:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3b6b:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
    3b6f:	84 d2                	test   %dl,%dl
    3b71:	75 ed                	jne    3b60 <strcmp+0x20>
    3b73:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    3b75:	5b                   	pop    %ebx
    3b76:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
    3b77:	29 c8                	sub    %ecx,%eax
}
    3b79:	5d                   	pop    %ebp
    3b7a:	c3                   	ret    
    3b7b:	90                   	nop
    3b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3b80:	0f b6 c2             	movzbl %dl,%eax
    3b83:	5b                   	pop    %ebx
    3b84:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
    3b85:	29 c8                	sub    %ecx,%eax
}
    3b87:	5d                   	pop    %ebp
    3b88:	c3                   	ret    
    3b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003b90 <strlen>:

uint
strlen(const char *s)
{
    3b90:	55                   	push   %ebp
    3b91:	89 e5                	mov    %esp,%ebp
    3b93:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    3b96:	80 39 00             	cmpb   $0x0,(%ecx)
    3b99:	74 15                	je     3bb0 <strlen+0x20>
    3b9b:	31 d2                	xor    %edx,%edx
    3b9d:	8d 76 00             	lea    0x0(%esi),%esi
    3ba0:	83 c2 01             	add    $0x1,%edx
    3ba3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    3ba7:	89 d0                	mov    %edx,%eax
    3ba9:	75 f5                	jne    3ba0 <strlen+0x10>
    ;
  return n;
}
    3bab:	5d                   	pop    %ebp
    3bac:	c3                   	ret    
    3bad:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    3bb0:	31 c0                	xor    %eax,%eax
}
    3bb2:	5d                   	pop    %ebp
    3bb3:	c3                   	ret    
    3bb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3bba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003bc0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3bc0:	55                   	push   %ebp
    3bc1:	89 e5                	mov    %esp,%ebp
    3bc3:	57                   	push   %edi
    3bc4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3bc7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3bca:	8b 45 0c             	mov    0xc(%ebp),%eax
    3bcd:	89 d7                	mov    %edx,%edi
    3bcf:	fc                   	cld    
    3bd0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3bd2:	89 d0                	mov    %edx,%eax
    3bd4:	5f                   	pop    %edi
    3bd5:	5d                   	pop    %ebp
    3bd6:	c3                   	ret    
    3bd7:	89 f6                	mov    %esi,%esi
    3bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003be0 <strchr>:

char*
strchr(const char *s, char c)
{
    3be0:	55                   	push   %ebp
    3be1:	89 e5                	mov    %esp,%ebp
    3be3:	53                   	push   %ebx
    3be4:	8b 45 08             	mov    0x8(%ebp),%eax
    3be7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
    3bea:	0f b6 18             	movzbl (%eax),%ebx
    3bed:	84 db                	test   %bl,%bl
    3bef:	74 1d                	je     3c0e <strchr+0x2e>
    3bf1:	89 d1                	mov    %edx,%ecx
    if(*s == c)
    3bf3:	38 d3                	cmp    %dl,%bl
    3bf5:	75 0d                	jne    3c04 <strchr+0x24>
    3bf7:	eb 17                	jmp    3c10 <strchr+0x30>
    3bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3c00:	38 ca                	cmp    %cl,%dl
    3c02:	74 0c                	je     3c10 <strchr+0x30>
  for(; *s; s++)
    3c04:	83 c0 01             	add    $0x1,%eax
    3c07:	0f b6 10             	movzbl (%eax),%edx
    3c0a:	84 d2                	test   %dl,%dl
    3c0c:	75 f2                	jne    3c00 <strchr+0x20>
      return (char*)s;
  return 0;
    3c0e:	31 c0                	xor    %eax,%eax
}
    3c10:	5b                   	pop    %ebx
    3c11:	5d                   	pop    %ebp
    3c12:	c3                   	ret    
    3c13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003c20 <gets>:

char*
gets(char *buf, int max)
{
    3c20:	55                   	push   %ebp
    3c21:	89 e5                	mov    %esp,%ebp
    3c23:	57                   	push   %edi
    3c24:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3c25:	31 f6                	xor    %esi,%esi
{
    3c27:	53                   	push   %ebx
    3c28:	89 f3                	mov    %esi,%ebx
    3c2a:	83 ec 1c             	sub    $0x1c,%esp
    3c2d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    3c30:	eb 2f                	jmp    3c61 <gets+0x41>
    3c32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    3c38:	83 ec 04             	sub    $0x4,%esp
    3c3b:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3c3e:	6a 01                	push   $0x1
    3c40:	50                   	push   %eax
    3c41:	6a 00                	push   $0x0
    3c43:	e8 31 01 00 00       	call   3d79 <read>
    if(cc < 1)
    3c48:	83 c4 10             	add    $0x10,%esp
    3c4b:	85 c0                	test   %eax,%eax
    3c4d:	7e 1c                	jle    3c6b <gets+0x4b>
      break;
    buf[i++] = c;
    3c4f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3c53:	83 c7 01             	add    $0x1,%edi
    3c56:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    3c59:	3c 0a                	cmp    $0xa,%al
    3c5b:	74 23                	je     3c80 <gets+0x60>
    3c5d:	3c 0d                	cmp    $0xd,%al
    3c5f:	74 1f                	je     3c80 <gets+0x60>
  for(i=0; i+1 < max; ){
    3c61:	83 c3 01             	add    $0x1,%ebx
    3c64:	89 fe                	mov    %edi,%esi
    3c66:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    3c69:	7c cd                	jl     3c38 <gets+0x18>
    3c6b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    3c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    3c70:	c6 03 00             	movb   $0x0,(%ebx)
}
    3c73:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3c76:	5b                   	pop    %ebx
    3c77:	5e                   	pop    %esi
    3c78:	5f                   	pop    %edi
    3c79:	5d                   	pop    %ebp
    3c7a:	c3                   	ret    
    3c7b:	90                   	nop
    3c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3c80:	8b 75 08             	mov    0x8(%ebp),%esi
    3c83:	8b 45 08             	mov    0x8(%ebp),%eax
    3c86:	01 de                	add    %ebx,%esi
    3c88:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    3c8a:	c6 03 00             	movb   $0x0,(%ebx)
}
    3c8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3c90:	5b                   	pop    %ebx
    3c91:	5e                   	pop    %esi
    3c92:	5f                   	pop    %edi
    3c93:	5d                   	pop    %ebp
    3c94:	c3                   	ret    
    3c95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003ca0 <stat>:

int
stat(const char *n, struct stat *st)
{
    3ca0:	55                   	push   %ebp
    3ca1:	89 e5                	mov    %esp,%ebp
    3ca3:	56                   	push   %esi
    3ca4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3ca5:	83 ec 08             	sub    $0x8,%esp
    3ca8:	6a 00                	push   $0x0
    3caa:	ff 75 08             	pushl  0x8(%ebp)
    3cad:	e8 ef 00 00 00       	call   3da1 <open>
  if(fd < 0)
    3cb2:	83 c4 10             	add    $0x10,%esp
    3cb5:	85 c0                	test   %eax,%eax
    3cb7:	78 27                	js     3ce0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3cb9:	83 ec 08             	sub    $0x8,%esp
    3cbc:	ff 75 0c             	pushl  0xc(%ebp)
    3cbf:	89 c3                	mov    %eax,%ebx
    3cc1:	50                   	push   %eax
    3cc2:	e8 f2 00 00 00       	call   3db9 <fstat>
  close(fd);
    3cc7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    3cca:	89 c6                	mov    %eax,%esi
  close(fd);
    3ccc:	e8 b8 00 00 00       	call   3d89 <close>
  return r;
    3cd1:	83 c4 10             	add    $0x10,%esp
}
    3cd4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3cd7:	89 f0                	mov    %esi,%eax
    3cd9:	5b                   	pop    %ebx
    3cda:	5e                   	pop    %esi
    3cdb:	5d                   	pop    %ebp
    3cdc:	c3                   	ret    
    3cdd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3ce0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3ce5:	eb ed                	jmp    3cd4 <stat+0x34>
    3ce7:	89 f6                	mov    %esi,%esi
    3ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003cf0 <atoi>:

int
atoi(const char *s)
{
    3cf0:	55                   	push   %ebp
    3cf1:	89 e5                	mov    %esp,%ebp
    3cf3:	53                   	push   %ebx
    3cf4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3cf7:	0f be 11             	movsbl (%ecx),%edx
    3cfa:	8d 42 d0             	lea    -0x30(%edx),%eax
    3cfd:	3c 09                	cmp    $0x9,%al
  n = 0;
    3cff:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    3d04:	77 1f                	ja     3d25 <atoi+0x35>
    3d06:	8d 76 00             	lea    0x0(%esi),%esi
    3d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    3d10:	83 c1 01             	add    $0x1,%ecx
    3d13:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3d16:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    3d1a:	0f be 11             	movsbl (%ecx),%edx
    3d1d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    3d20:	80 fb 09             	cmp    $0x9,%bl
    3d23:	76 eb                	jbe    3d10 <atoi+0x20>
  return n;
}
    3d25:	5b                   	pop    %ebx
    3d26:	5d                   	pop    %ebp
    3d27:	c3                   	ret    
    3d28:	90                   	nop
    3d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003d30 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3d30:	55                   	push   %ebp
    3d31:	89 e5                	mov    %esp,%ebp
    3d33:	57                   	push   %edi
    3d34:	8b 55 10             	mov    0x10(%ebp),%edx
    3d37:	8b 45 08             	mov    0x8(%ebp),%eax
    3d3a:	56                   	push   %esi
    3d3b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3d3e:	85 d2                	test   %edx,%edx
    3d40:	7e 13                	jle    3d55 <memmove+0x25>
    3d42:	01 c2                	add    %eax,%edx
  dst = vdst;
    3d44:	89 c7                	mov    %eax,%edi
    3d46:	8d 76 00             	lea    0x0(%esi),%esi
    3d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    *dst++ = *src++;
    3d50:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    3d51:	39 fa                	cmp    %edi,%edx
    3d53:	75 fb                	jne    3d50 <memmove+0x20>
  return vdst;
}
    3d55:	5e                   	pop    %esi
    3d56:	5f                   	pop    %edi
    3d57:	5d                   	pop    %ebp
    3d58:	c3                   	ret    

00003d59 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3d59:	b8 01 00 00 00       	mov    $0x1,%eax
    3d5e:	cd 40                	int    $0x40
    3d60:	c3                   	ret    

00003d61 <exit>:
SYSCALL(exit)
    3d61:	b8 02 00 00 00       	mov    $0x2,%eax
    3d66:	cd 40                	int    $0x40
    3d68:	c3                   	ret    

00003d69 <wait>:
SYSCALL(wait)
    3d69:	b8 03 00 00 00       	mov    $0x3,%eax
    3d6e:	cd 40                	int    $0x40
    3d70:	c3                   	ret    

00003d71 <pipe>:
SYSCALL(pipe)
    3d71:	b8 04 00 00 00       	mov    $0x4,%eax
    3d76:	cd 40                	int    $0x40
    3d78:	c3                   	ret    

00003d79 <read>:
SYSCALL(read)
    3d79:	b8 05 00 00 00       	mov    $0x5,%eax
    3d7e:	cd 40                	int    $0x40
    3d80:	c3                   	ret    

00003d81 <write>:
SYSCALL(write)
    3d81:	b8 10 00 00 00       	mov    $0x10,%eax
    3d86:	cd 40                	int    $0x40
    3d88:	c3                   	ret    

00003d89 <close>:
SYSCALL(close)
    3d89:	b8 15 00 00 00       	mov    $0x15,%eax
    3d8e:	cd 40                	int    $0x40
    3d90:	c3                   	ret    

00003d91 <kill>:
SYSCALL(kill)
    3d91:	b8 06 00 00 00       	mov    $0x6,%eax
    3d96:	cd 40                	int    $0x40
    3d98:	c3                   	ret    

00003d99 <exec>:
SYSCALL(exec)
    3d99:	b8 07 00 00 00       	mov    $0x7,%eax
    3d9e:	cd 40                	int    $0x40
    3da0:	c3                   	ret    

00003da1 <open>:
SYSCALL(open)
    3da1:	b8 0f 00 00 00       	mov    $0xf,%eax
    3da6:	cd 40                	int    $0x40
    3da8:	c3                   	ret    

00003da9 <mknod>:
SYSCALL(mknod)
    3da9:	b8 11 00 00 00       	mov    $0x11,%eax
    3dae:	cd 40                	int    $0x40
    3db0:	c3                   	ret    

00003db1 <unlink>:
SYSCALL(unlink)
    3db1:	b8 12 00 00 00       	mov    $0x12,%eax
    3db6:	cd 40                	int    $0x40
    3db8:	c3                   	ret    

00003db9 <fstat>:
SYSCALL(fstat)
    3db9:	b8 08 00 00 00       	mov    $0x8,%eax
    3dbe:	cd 40                	int    $0x40
    3dc0:	c3                   	ret    

00003dc1 <link>:
SYSCALL(link)
    3dc1:	b8 13 00 00 00       	mov    $0x13,%eax
    3dc6:	cd 40                	int    $0x40
    3dc8:	c3                   	ret    

00003dc9 <mkdir>:
SYSCALL(mkdir)
    3dc9:	b8 14 00 00 00       	mov    $0x14,%eax
    3dce:	cd 40                	int    $0x40
    3dd0:	c3                   	ret    

00003dd1 <chdir>:
SYSCALL(chdir)
    3dd1:	b8 09 00 00 00       	mov    $0x9,%eax
    3dd6:	cd 40                	int    $0x40
    3dd8:	c3                   	ret    

00003dd9 <dup>:
SYSCALL(dup)
    3dd9:	b8 0a 00 00 00       	mov    $0xa,%eax
    3dde:	cd 40                	int    $0x40
    3de0:	c3                   	ret    

00003de1 <getpid>:
SYSCALL(getpid)
    3de1:	b8 0b 00 00 00       	mov    $0xb,%eax
    3de6:	cd 40                	int    $0x40
    3de8:	c3                   	ret    

00003de9 <sbrk>:
SYSCALL(sbrk)
    3de9:	b8 0c 00 00 00       	mov    $0xc,%eax
    3dee:	cd 40                	int    $0x40
    3df0:	c3                   	ret    

00003df1 <sleep>:
SYSCALL(sleep)
    3df1:	b8 0d 00 00 00       	mov    $0xd,%eax
    3df6:	cd 40                	int    $0x40
    3df8:	c3                   	ret    

00003df9 <uptime>:
SYSCALL(uptime)
    3df9:	b8 0e 00 00 00       	mov    $0xe,%eax
    3dfe:	cd 40                	int    $0x40
    3e00:	c3                   	ret    

00003e01 <numFreePages>:
SYSCALL(numFreePages)
    3e01:	b8 16 00 00 00       	mov    $0x16,%eax
    3e06:	cd 40                	int    $0x40
    3e08:	c3                   	ret    

00003e09 <changeScheduler>:
SYSCALL(changeScheduler)
    3e09:	b8 17 00 00 00       	mov    $0x17,%eax
    3e0e:	cd 40                	int    $0x40
    3e10:	c3                   	ret    
    3e11:	66 90                	xchg   %ax,%ax
    3e13:	66 90                	xchg   %ax,%ax
    3e15:	66 90                	xchg   %ax,%ax
    3e17:	66 90                	xchg   %ax,%ax
    3e19:	66 90                	xchg   %ax,%ax
    3e1b:	66 90                	xchg   %ax,%ax
    3e1d:	66 90                	xchg   %ax,%ax
    3e1f:	90                   	nop

00003e20 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3e20:	55                   	push   %ebp
    3e21:	89 e5                	mov    %esp,%ebp
    3e23:	57                   	push   %edi
    3e24:	56                   	push   %esi
    3e25:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    3e26:	89 d3                	mov    %edx,%ebx
{
    3e28:	83 ec 3c             	sub    $0x3c,%esp
    3e2b:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
    3e2e:	85 d2                	test   %edx,%edx
    3e30:	0f 89 92 00 00 00    	jns    3ec8 <printint+0xa8>
    3e36:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    3e3a:	0f 84 88 00 00 00    	je     3ec8 <printint+0xa8>
    neg = 1;
    3e40:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
    3e47:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
    3e49:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    3e50:	8d 75 d7             	lea    -0x29(%ebp),%esi
    3e53:	eb 08                	jmp    3e5d <printint+0x3d>
    3e55:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3e58:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
    3e5b:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
    3e5d:	89 d8                	mov    %ebx,%eax
    3e5f:	31 d2                	xor    %edx,%edx
    3e61:	8b 7d c4             	mov    -0x3c(%ebp),%edi
    3e64:	f7 f1                	div    %ecx
    3e66:	83 c7 01             	add    $0x1,%edi
    3e69:	0f b6 92 bc 5d 00 00 	movzbl 0x5dbc(%edx),%edx
    3e70:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
    3e73:	39 d9                	cmp    %ebx,%ecx
    3e75:	76 e1                	jbe    3e58 <printint+0x38>
  if(neg)
    3e77:	8b 45 c0             	mov    -0x40(%ebp),%eax
    3e7a:	85 c0                	test   %eax,%eax
    3e7c:	74 0d                	je     3e8b <printint+0x6b>
    buf[i++] = '-';
    3e7e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    3e83:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
    3e88:	89 7d c4             	mov    %edi,-0x3c(%ebp)
    3e8b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    3e8e:	8b 7d bc             	mov    -0x44(%ebp),%edi
    3e91:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    3e95:	eb 0f                	jmp    3ea6 <printint+0x86>
    3e97:	89 f6                	mov    %esi,%esi
    3e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3ea0:	0f b6 13             	movzbl (%ebx),%edx
    3ea3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3ea6:	83 ec 04             	sub    $0x4,%esp
    3ea9:	88 55 d7             	mov    %dl,-0x29(%ebp)
    3eac:	6a 01                	push   $0x1
    3eae:	56                   	push   %esi
    3eaf:	57                   	push   %edi
    3eb0:	e8 cc fe ff ff       	call   3d81 <write>

  while(--i >= 0)
    3eb5:	83 c4 10             	add    $0x10,%esp
    3eb8:	39 de                	cmp    %ebx,%esi
    3eba:	75 e4                	jne    3ea0 <printint+0x80>
    putc(fd, buf[i]);
}
    3ebc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3ebf:	5b                   	pop    %ebx
    3ec0:	5e                   	pop    %esi
    3ec1:	5f                   	pop    %edi
    3ec2:	5d                   	pop    %ebp
    3ec3:	c3                   	ret    
    3ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3ec8:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    3ecf:	e9 75 ff ff ff       	jmp    3e49 <printint+0x29>
    3ed4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3eda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003ee0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3ee0:	55                   	push   %ebp
    3ee1:	89 e5                	mov    %esp,%ebp
    3ee3:	57                   	push   %edi
    3ee4:	56                   	push   %esi
    3ee5:	53                   	push   %ebx
    3ee6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3ee9:	8b 75 0c             	mov    0xc(%ebp),%esi
    3eec:	0f b6 1e             	movzbl (%esi),%ebx
    3eef:	84 db                	test   %bl,%bl
    3ef1:	0f 84 b9 00 00 00    	je     3fb0 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
    3ef7:	8d 45 10             	lea    0x10(%ebp),%eax
    3efa:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    3efd:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    3f00:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    3f02:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3f05:	eb 38                	jmp    3f3f <printf+0x5f>
    3f07:	89 f6                	mov    %esi,%esi
    3f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3f10:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3f13:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    3f18:	83 f8 25             	cmp    $0x25,%eax
    3f1b:	74 17                	je     3f34 <printf+0x54>
  write(fd, &c, 1);
    3f1d:	83 ec 04             	sub    $0x4,%esp
    3f20:	88 5d e7             	mov    %bl,-0x19(%ebp)
    3f23:	6a 01                	push   $0x1
    3f25:	57                   	push   %edi
    3f26:	ff 75 08             	pushl  0x8(%ebp)
    3f29:	e8 53 fe ff ff       	call   3d81 <write>
    3f2e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    3f31:	83 c4 10             	add    $0x10,%esp
    3f34:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    3f37:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    3f3b:	84 db                	test   %bl,%bl
    3f3d:	74 71                	je     3fb0 <printf+0xd0>
    c = fmt[i] & 0xff;
    3f3f:	0f be cb             	movsbl %bl,%ecx
    3f42:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    3f45:	85 d2                	test   %edx,%edx
    3f47:	74 c7                	je     3f10 <printf+0x30>
      }
    } else if(state == '%'){
    3f49:	83 fa 25             	cmp    $0x25,%edx
    3f4c:	75 e6                	jne    3f34 <printf+0x54>
      if(c == 'd'){
    3f4e:	83 f8 64             	cmp    $0x64,%eax
    3f51:	0f 84 99 00 00 00    	je     3ff0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3f57:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    3f5d:	83 f9 70             	cmp    $0x70,%ecx
    3f60:	74 5e                	je     3fc0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3f62:	83 f8 73             	cmp    $0x73,%eax
    3f65:	0f 84 d5 00 00 00    	je     4040 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3f6b:	83 f8 63             	cmp    $0x63,%eax
    3f6e:	0f 84 8c 00 00 00    	je     4000 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3f74:	83 f8 25             	cmp    $0x25,%eax
    3f77:	0f 84 b3 00 00 00    	je     4030 <printf+0x150>
  write(fd, &c, 1);
    3f7d:	83 ec 04             	sub    $0x4,%esp
    3f80:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3f84:	6a 01                	push   $0x1
    3f86:	57                   	push   %edi
    3f87:	ff 75 08             	pushl  0x8(%ebp)
    3f8a:	e8 f2 fd ff ff       	call   3d81 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    3f8f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    3f92:	83 c4 0c             	add    $0xc,%esp
    3f95:	6a 01                	push   $0x1
    3f97:	83 c6 01             	add    $0x1,%esi
    3f9a:	57                   	push   %edi
    3f9b:	ff 75 08             	pushl  0x8(%ebp)
    3f9e:	e8 de fd ff ff       	call   3d81 <write>
  for(i = 0; fmt[i]; i++){
    3fa3:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    3fa7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    3faa:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    3fac:	84 db                	test   %bl,%bl
    3fae:	75 8f                	jne    3f3f <printf+0x5f>
    }
  }
}
    3fb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3fb3:	5b                   	pop    %ebx
    3fb4:	5e                   	pop    %esi
    3fb5:	5f                   	pop    %edi
    3fb6:	5d                   	pop    %ebp
    3fb7:	c3                   	ret    
    3fb8:	90                   	nop
    3fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
    3fc0:	83 ec 0c             	sub    $0xc,%esp
    3fc3:	b9 10 00 00 00       	mov    $0x10,%ecx
    3fc8:	6a 00                	push   $0x0
    3fca:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    3fcd:	8b 45 08             	mov    0x8(%ebp),%eax
    3fd0:	8b 13                	mov    (%ebx),%edx
    3fd2:	e8 49 fe ff ff       	call   3e20 <printint>
        ap++;
    3fd7:	89 d8                	mov    %ebx,%eax
    3fd9:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3fdc:	31 d2                	xor    %edx,%edx
        ap++;
    3fde:	83 c0 04             	add    $0x4,%eax
    3fe1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3fe4:	e9 4b ff ff ff       	jmp    3f34 <printf+0x54>
    3fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    3ff0:	83 ec 0c             	sub    $0xc,%esp
    3ff3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3ff8:	6a 01                	push   $0x1
    3ffa:	eb ce                	jmp    3fca <printf+0xea>
    3ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    4000:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    4003:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    4006:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    4008:	6a 01                	push   $0x1
        ap++;
    400a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    400d:	57                   	push   %edi
    400e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    4011:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    4014:	e8 68 fd ff ff       	call   3d81 <write>
        ap++;
    4019:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    401c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    401f:	31 d2                	xor    %edx,%edx
    4021:	e9 0e ff ff ff       	jmp    3f34 <printf+0x54>
    4026:	8d 76 00             	lea    0x0(%esi),%esi
    4029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        putc(fd, c);
    4030:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    4033:	83 ec 04             	sub    $0x4,%esp
    4036:	e9 5a ff ff ff       	jmp    3f95 <printf+0xb5>
    403b:	90                   	nop
    403c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    4040:	8b 45 d0             	mov    -0x30(%ebp),%eax
    4043:	8b 18                	mov    (%eax),%ebx
        ap++;
    4045:	83 c0 04             	add    $0x4,%eax
    4048:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    404b:	85 db                	test   %ebx,%ebx
    404d:	74 17                	je     4066 <printf+0x186>
        while(*s != 0){
    404f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    4052:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    4054:	84 c0                	test   %al,%al
    4056:	0f 84 d8 fe ff ff    	je     3f34 <printf+0x54>
    405c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    405f:	89 de                	mov    %ebx,%esi
    4061:	8b 5d 08             	mov    0x8(%ebp),%ebx
    4064:	eb 1a                	jmp    4080 <printf+0x1a0>
          s = "(null)";
    4066:	bb b4 5d 00 00       	mov    $0x5db4,%ebx
        while(*s != 0){
    406b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    406e:	b8 28 00 00 00       	mov    $0x28,%eax
    4073:	89 de                	mov    %ebx,%esi
    4075:	8b 5d 08             	mov    0x8(%ebp),%ebx
    4078:	90                   	nop
    4079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    4080:	83 ec 04             	sub    $0x4,%esp
          s++;
    4083:	83 c6 01             	add    $0x1,%esi
    4086:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    4089:	6a 01                	push   $0x1
    408b:	57                   	push   %edi
    408c:	53                   	push   %ebx
    408d:	e8 ef fc ff ff       	call   3d81 <write>
        while(*s != 0){
    4092:	0f b6 06             	movzbl (%esi),%eax
    4095:	83 c4 10             	add    $0x10,%esp
    4098:	84 c0                	test   %al,%al
    409a:	75 e4                	jne    4080 <printf+0x1a0>
    409c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
    409f:	31 d2                	xor    %edx,%edx
    40a1:	e9 8e fe ff ff       	jmp    3f34 <printf+0x54>
    40a6:	66 90                	xchg   %ax,%ax
    40a8:	66 90                	xchg   %ax,%ax
    40aa:	66 90                	xchg   %ax,%ax
    40ac:	66 90                	xchg   %ax,%ax
    40ae:	66 90                	xchg   %ax,%ax

000040b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    40b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    40b1:	a1 a0 68 00 00       	mov    0x68a0,%eax
{
    40b6:	89 e5                	mov    %esp,%ebp
    40b8:	57                   	push   %edi
    40b9:	56                   	push   %esi
    40ba:	53                   	push   %ebx
    40bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    40be:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
    40c0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    40c3:	39 c8                	cmp    %ecx,%eax
    40c5:	73 19                	jae    40e0 <free+0x30>
    40c7:	89 f6                	mov    %esi,%esi
    40c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    40d0:	39 d1                	cmp    %edx,%ecx
    40d2:	72 14                	jb     40e8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    40d4:	39 d0                	cmp    %edx,%eax
    40d6:	73 10                	jae    40e8 <free+0x38>
{
    40d8:	89 d0                	mov    %edx,%eax
    40da:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    40dc:	39 c8                	cmp    %ecx,%eax
    40de:	72 f0                	jb     40d0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    40e0:	39 d0                	cmp    %edx,%eax
    40e2:	72 f4                	jb     40d8 <free+0x28>
    40e4:	39 d1                	cmp    %edx,%ecx
    40e6:	73 f0                	jae    40d8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
    40e8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    40eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    40ee:	39 fa                	cmp    %edi,%edx
    40f0:	74 1e                	je     4110 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    40f2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    40f5:	8b 50 04             	mov    0x4(%eax),%edx
    40f8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    40fb:	39 f1                	cmp    %esi,%ecx
    40fd:	74 28                	je     4127 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    40ff:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    4101:	5b                   	pop    %ebx
  freep = p;
    4102:	a3 a0 68 00 00       	mov    %eax,0x68a0
}
    4107:	5e                   	pop    %esi
    4108:	5f                   	pop    %edi
    4109:	5d                   	pop    %ebp
    410a:	c3                   	ret    
    410b:	90                   	nop
    410c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    4110:	03 72 04             	add    0x4(%edx),%esi
    4113:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    4116:	8b 10                	mov    (%eax),%edx
    4118:	8b 12                	mov    (%edx),%edx
    411a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    411d:	8b 50 04             	mov    0x4(%eax),%edx
    4120:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    4123:	39 f1                	cmp    %esi,%ecx
    4125:	75 d8                	jne    40ff <free+0x4f>
    p->s.size += bp->s.size;
    4127:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    412a:	a3 a0 68 00 00       	mov    %eax,0x68a0
    p->s.size += bp->s.size;
    412f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    4132:	8b 53 f8             	mov    -0x8(%ebx),%edx
    4135:	89 10                	mov    %edx,(%eax)
}
    4137:	5b                   	pop    %ebx
    4138:	5e                   	pop    %esi
    4139:	5f                   	pop    %edi
    413a:	5d                   	pop    %ebp
    413b:	c3                   	ret    
    413c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00004140 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    4140:	55                   	push   %ebp
    4141:	89 e5                	mov    %esp,%ebp
    4143:	57                   	push   %edi
    4144:	56                   	push   %esi
    4145:	53                   	push   %ebx
    4146:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4149:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    414c:	8b 3d a0 68 00 00    	mov    0x68a0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4152:	8d 70 07             	lea    0x7(%eax),%esi
    4155:	c1 ee 03             	shr    $0x3,%esi
    4158:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    415b:	85 ff                	test   %edi,%edi
    415d:	0f 84 ad 00 00 00    	je     4210 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4163:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    4165:	8b 4a 04             	mov    0x4(%edx),%ecx
    4168:	39 ce                	cmp    %ecx,%esi
    416a:	76 72                	jbe    41de <malloc+0x9e>
    416c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    4172:	bb 00 10 00 00       	mov    $0x1000,%ebx
    4177:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    417a:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    4181:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    4184:	eb 1b                	jmp    41a1 <malloc+0x61>
    4186:	8d 76 00             	lea    0x0(%esi),%esi
    4189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4190:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    4192:	8b 48 04             	mov    0x4(%eax),%ecx
    4195:	39 f1                	cmp    %esi,%ecx
    4197:	73 4f                	jae    41e8 <malloc+0xa8>
    4199:	8b 3d a0 68 00 00    	mov    0x68a0,%edi
    419f:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    41a1:	39 d7                	cmp    %edx,%edi
    41a3:	75 eb                	jne    4190 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    41a5:	83 ec 0c             	sub    $0xc,%esp
    41a8:	ff 75 e4             	pushl  -0x1c(%ebp)
    41ab:	e8 39 fc ff ff       	call   3de9 <sbrk>
  if(p == (char*)-1)
    41b0:	83 c4 10             	add    $0x10,%esp
    41b3:	83 f8 ff             	cmp    $0xffffffff,%eax
    41b6:	74 1c                	je     41d4 <malloc+0x94>
  hp->s.size = nu;
    41b8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    41bb:	83 ec 0c             	sub    $0xc,%esp
    41be:	83 c0 08             	add    $0x8,%eax
    41c1:	50                   	push   %eax
    41c2:	e8 e9 fe ff ff       	call   40b0 <free>
  return freep;
    41c7:	8b 15 a0 68 00 00    	mov    0x68a0,%edx
      if((p = morecore(nunits)) == 0)
    41cd:	83 c4 10             	add    $0x10,%esp
    41d0:	85 d2                	test   %edx,%edx
    41d2:	75 bc                	jne    4190 <malloc+0x50>
        return 0;
  }
}
    41d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    41d7:	31 c0                	xor    %eax,%eax
}
    41d9:	5b                   	pop    %ebx
    41da:	5e                   	pop    %esi
    41db:	5f                   	pop    %edi
    41dc:	5d                   	pop    %ebp
    41dd:	c3                   	ret    
    if(p->s.size >= nunits){
    41de:	89 d0                	mov    %edx,%eax
    41e0:	89 fa                	mov    %edi,%edx
    41e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    41e8:	39 ce                	cmp    %ecx,%esi
    41ea:	74 54                	je     4240 <malloc+0x100>
        p->s.size -= nunits;
    41ec:	29 f1                	sub    %esi,%ecx
    41ee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    41f1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    41f4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    41f7:	89 15 a0 68 00 00    	mov    %edx,0x68a0
}
    41fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    4200:	83 c0 08             	add    $0x8,%eax
}
    4203:	5b                   	pop    %ebx
    4204:	5e                   	pop    %esi
    4205:	5f                   	pop    %edi
    4206:	5d                   	pop    %ebp
    4207:	c3                   	ret    
    4208:	90                   	nop
    4209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    4210:	c7 05 a0 68 00 00 a4 	movl   $0x68a4,0x68a0
    4217:	68 00 00 
    base.s.size = 0;
    421a:	bf a4 68 00 00       	mov    $0x68a4,%edi
    base.s.ptr = freep = prevp = &base;
    421f:	c7 05 a4 68 00 00 a4 	movl   $0x68a4,0x68a4
    4226:	68 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4229:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    422b:	c7 05 a8 68 00 00 00 	movl   $0x0,0x68a8
    4232:	00 00 00 
    if(p->s.size >= nunits){
    4235:	e9 32 ff ff ff       	jmp    416c <malloc+0x2c>
    423a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    4240:	8b 08                	mov    (%eax),%ecx
    4242:	89 0a                	mov    %ecx,(%edx)
    4244:	eb b1                	jmp    41f7 <malloc+0xb7>
