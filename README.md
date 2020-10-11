# vcs-hello
Hello World for Atari VCS/2600

![Screencap from Stella Emulator](hello_world_stella.png)

To build, you need to install [cc65](https://github.com/cc65/cc65), with the
executables on your path.

Then run **build.sh** from bash, or just run the build directly on the command line:

```
cl65 -t atari2600 -o hello.bin -l hello.list hello.asm
```

You can then load hello.bin into the VCS/2600 emulator of your choice. It has been
tested on Linux using Stella. If you have an issue with any other emulator or
host environment, please post an issue to this repo. Thanks!

See the video on YouTube:

[![Hello, 2600!](http://img.youtube.com/vi/iyzehlHJZ7w/0.jpg)](https://youtu.be/iyzehlHJZ7w)
