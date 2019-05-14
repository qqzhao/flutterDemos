
bug重现步骤：

* 使用iPad mini（A1490）release模式编译，启动
* 再使用Xcode release模式调试
* 启动后，等待 `Please click and enter background:` 出现后立即切换到后台
* 等一会儿（10s内）就是出现crash。



```
➜  flutterDemos git:(master) flutter --version
Flutter 1.4.7 • channel unknown • unknown source
Framework • revision 1bfa2f2311 (6 weeks ago) • 2019-03-29 10:05:18 -0700
Engine • revision c4d14a0071
Tools • Dart 2.2.1 (build 2.2.1-dev.2.0 None)
```

reproduct this crash:

* compile and build project in iPad mini（A1490）in release.
* open this project in Xcode and run in release mode.
* wait for `Please click and enter background:` log in the console. Then click the home key and enter background.
* wait for a moment(in 10 seconds) and it will crash.

```
0 libGPUSupportMercury.dylib	_gpus_ReturnNotPermittedKillClient + 12
1 AGXGLDriver	gldUpdateDispatch + 7216
2 libGPUSupportMercury.dylib	gpusSubmitDataBuffers + 176
3 AGXGLDriver	gldUpdateDispatch + 12664
4 Flutter	0x00000001025f8000 + 2289676
5 Flutter	0x00000001025f8000 + 289464
6 Flutter	0x00000001025f8000 + 226372
7 Flutter	0x00000001025f8000 + 231544
8 CoreFoundation	___CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__ + 28
9 CoreFoundation	___CFRunLoopDoTimer + 864
10 CoreFoundation	___CFRunLoopDoTimers + 248
11 CoreFoundation	___CFRunLoopRun + 1880
12 CoreFoundation	CFRunLoopRunSpecific + 436
13 Flutter	0x00000001025f8000 + 231172
14 Flutter	0x00000001025f8000 + 229292
15 libsystem_pthread.dylib	__pthread_body + 128
16 libsystem_pthread.dylib	_pthread_start + 48
```