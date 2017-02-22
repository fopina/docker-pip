Docker container with FIS PIP

# Usage

### Using MTM/servers

MTM and PIP servers required non-standard shared memory settings.

You can let the container set them if you make it `--privileged`
```
$ docker run --privileged -p 61315:61315 fopina/fis-pip
```

Or, if you prefer, set them directly instead
```
$ docker run --sysctl "kernel.msgmnb=65536000" --sysctl "kernel.msgmni=512" --sysctl "kernel.msgmax=1048700" -p 61315:61315 fopina/fis-pip
```

Then just connect your local application to it (using PIP JDBC driver or anything else - like [this](https://github.com/fopina/pygtm))


### Using GTM directly
```
$ docker run -ti fopina/fis-pip su - pip
pip@933687555dbc:~$ cd pip_V02/
pip@933687555dbc:~/pip_V02$ ./dm

GTM>w $ZV
GT.M V5.4-000 Linux x86

GTM>zwr ^TBXBUILD
^TBXBUILD(0)="Fixpack|Corporate_Solutions_Dev|FrameWorkInstall|40964|||0"
^TBXBUILD(10)="PIP Framework|SCA Products|Profile_Framework_v30|PRF_FWK_v30_025|kbhaskar|61580|0"
^TBXBUILD(20)="PIP Supplement||||||0"

GTM>

```

# Build

* Download PIP v0.2 [VMDK](https://sourceforge.net/projects/pip/files/PIP/V0.2/)
* Mount it `sudo guestmount -a ubuntu_8.04_jeos_pip.vmdk -i --ro /mnt/pip`
* Create tarball `cd /mnt/pip; tar czpf $OLDPWD/pip.tgz usr/lib/fis-gtm/ home/pip/`
* Clean up tarball in a temporary docker container


```
$ docker create --name temp -t ubuntu:16.04
$ docker cp pip.tgz temp:/
$ docker start -ai temp
root@1411735e28c7:/# useradd pip -m -u 61781 -g 100
root@1411735e28c7:/# tar xpf pip.tgz && rm pip.tgz
root@1411735e28c7:/# rm -fr /home/pip/.fis-gtm
root@1411735e28c7:/# rm /home/pip/gtm_*.err
root@1411735e28c7:/# rm /home/pip/pip_V02/*.mje
root@1411735e28c7:/# rm /home/pip/pip_V02/PROFILE_ERROR.*
root@1411735e28c7:/# find /home/pip/pip_V02/?rtns/ -name \*.o -exec rm {} \;
root@1411735e28c7:/# tar czpf pip.tgz usr/lib/fis-gtm/ home/pip/
root@1411735e28c7:/# exit
$ docker cp temp:/pip.tgz .
$ docker rm temp
```

* Build image `docker build -t fopina/fis-pip .`