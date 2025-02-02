# Setting up the development environment

## Install necessary tools

```
sudo apt-get install -y git make gcc g++ unzip rsync bc sshpass zip ncurses-dev screen
```

## Download and extract buildroot

```
wget https://buildroot.org/downloads/buildroot-2019.08.1.tar.gz
tar xvzf buildroot-2019.08.1.tar.gz
ln -s buildroot-2019.08.1 buildroot
```

## Clone the HiFiBerryOS sources

```
git clone https://github.com/hifiberry/hifiberry-os
```

## Start the first build

Now, change to the HiFiBerryOS directory, create a configuration and compile HiFiBerryOS
```
cd hifiberry-os
./build-config 3
./compile 3
```

This will take some time. Depending on your hardware and network connectivity, expect at least one hour, but it can be also much longer.

## Parallel builds

Builds for a specific platform (e.g. Pi3 or Pi4) are store in separate directories. This means you can run a parallel builds for multiple platforms. Especially for systems with a lots of cores and fast SSDs, this is usually faster than running 
them sequentially. 
