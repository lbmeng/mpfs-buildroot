# Use Ubuntu 20.04
FROM ubuntu:focal
LABEL Description="Building buildroot SDK for Microchip PolarFire SoC"

# Make sure apt is happy
ENV DEBIAN_FRONTEND=noninteractive

# Update and install prerequisite packages
RUN apt update && apt install -y \
	autoconf \
	automake \
	autotools-dev \
	bc \
	bison \
	build-essential \
	cpio \
	curl \
	device-tree-compiler \
	dosfstools \
	flex \
	gawk \
	gdisk \
	git \
	gperf \
	libblkid-dev \
	libelf-dev \
	libexpat1-dev \
	libglib2.0-dev \
	libgmp-dev \
	libmpc-dev \
	libmpfr-dev \
	libncurses-dev \
	libpixman-1-dev \
	libssl-dev \
	libtool \
	libyaml-dev \
	linux-firmware \
	mtools \
	patchutils \
	python \
	python3 \
	python3-pip \
	rsync \
	screen \
	texinfo \
	unzip \
	wget \
	xxd \
	zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/*

# Install the python library kconfiglib for HSS build
RUN pip3 install kconfiglib

# Build buildroot SDK
RUN git clone https://github.com/polarfire-soc/polarfire-soc-buildroot-sdk.git /tmp/mpfs-buildroot && \
	cd /tmp/mpfs-buildroot && \
	git checkout -b v2021.04 v2021.04 \
	git submodule sync && \
	git submodule update --init --recursive && \
	unset RISCV \
	make -j$(nproc) all DEVKIT=icicle-kit-es
