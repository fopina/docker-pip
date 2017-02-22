This is a branch with a Dockerfile ready to build and tinker with MTM code.

```
$ docker build -t fis-pip-mtm .
$ docker run -ti fis-pip-mtm
root@228c942e3634:/# cd home/pip/pip_V02/mtm_V2.4.5/
root@228c942e3634:/home/pip/pip_V02/mtm_V2.4.5# make
rm -f *.o
rm -f mtm
...
/usr/bin/gcc mtmcntrl.o mtmclnt.o mtmmain.o mtmserver.o mtmcomm.o mtmutils.o utils.o sca_wrapper.o socket_utils.o alarm_utils.o msg_utils.o -o mtm -m32 -lm
chmod 775 mtm
make[1]: Leaving directory '/home/pip/pip_V02/mtm_V2.4.5'
```
