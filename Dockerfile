FROM ubuntu:16.04

COPY pip.tar /pip.tar

RUN useradd pip -m -u 61781 -g 100
RUN tar xpf pip.tar && rm pip.tar
RUN dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 vim wget

ENV LOCALE en_US.UTF-8
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen $LOCALE

RUN wget -q https://launchpad.net/ubuntu/+source/icu/3.8-5/+build/460355/+files/libicu38_3.8-5_i386.deb && \
	dpkg -i libicu38_3.8-5_i386.deb && \
	rm libicu38_3.8-5_i386.deb

CMD su - pip