FROM ubuntu:16.04

COPY pip.tgz /pip.tgz
COPY entrypoint.sh /entrypoint.sh

ENV LOCALE en_US.UTF-8
RUN useradd pip -m -u 61781 -g 100 && \
	tar xpf pip.tgz && rm pip.tgz && \
	dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get -y install --no-install-recommends libc6:i386 libncurses5:i386 \
											   libstdc++6:i386 vim-tiny netbase \
											   wget ca-certificates && \
	echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen $LOCALE && \
	wget -q https://launchpad.net/ubuntu/+source/icu/3.8-5/+build/460355/+files/libicu38_3.8-5_i386.deb && \
	dpkg -i libicu38_3.8-5_i386.deb && \
	rm libicu38_3.8-5_i386.deb && \
	apt-get -y purge wget ca-certificates && \
	apt-get -y autoremove && \
	apt-get autoclean && apt-get clean && \
	rm -rf /var/lib/apt/lists/*

CMD /entrypoint.sh