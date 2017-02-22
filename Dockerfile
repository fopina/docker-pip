FROM fopina/fis-pip:2

RUN apt-get update && \
	apt-get -y install gcc-multilib vim-tiny libc6:i386 libc6-dev:i386 build-essential && \
	sed -i 's/-g -fpic/-g -m32 -fpic/' /home/pip/pip_V02/mtm_V2.4.5/slibrule.mk && \
	sed -i 's/) -lm/) -m32 -lm/' /home/pip/pip_V02/mtm_V2.4.5/slibrule.mk && \
	sed -i 's/-g -fpic/-g -m32 -fpic/' /home/pip/pip_V02/mtm_V2.4.5/procrule.mk && \
	sed -i 's/} -lm/} -m32 -lm/' /home/pip/pip_V02/mtm_V2.4.5/procrule.mk && \
	apt-get autoclean && apt-get clean && \
	rm -rf /var/lib/apt/lists/*

CMD bash