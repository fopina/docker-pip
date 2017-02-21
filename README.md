Docker container with FIS PIP

# Usage

```
$ docker run -ti fopina/fis-pip
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
* Create tarball `cd /mnt/pip; tar czpf $OLDPWD/pip.tar usr/lib/fis-gtm/ home/pip/`
* Build image `docker build -t fopina/fis-pip .`

# TODO

* Get MTM working (using `--sysctl "kernel.msgmnb=65536000" --sysctl "kernel.msgmni=512" --sysctl "kernel.msgmax=1048700"` as is in PIP VM */etc/sysctl.conf*)
