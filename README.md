# Project template for stm32 Blue Pill board
This repo can be used as a quickstart template for your own project. It
contains all the necessary headers, documentation, boilerplate and an example
main.c to get started. Its purpose is to quickly get you through the "what am
I supposed to do with this piece of plastic" phase. I assume you run a 64-bit
Linux system. If you don't, use the instructions here at your own risc.

# Set up the environment
## Toolchain
For smoothest experience use [Linaro toolchain v. 5.3.0-2016.05](https://releases.linaro.org/components/toolchain/binaries/5.3-2016.05/arm-eabi/gcc-linaro-5.3.1-2016.05-x86_64_arm-eabi.tar.xz).
Other toolchain versions may require slight modification of compiler options.
Once downloaded unpack it to a known directory and modify your PATH
environment variable as following:

 `export PATH=${PATH}:/path/to/the/toolchain/bin  # mind the 'bin' in the end!`

## ISP loader
The simplest tool you can use for flashing is an ISP loader. It doesn't allow
you to debug your board with gdb, but just brings your firmware where it should
be. I personally liked [stm32loader](https://github.com/jsnyder/stm32loader).
It depends on Python and Pyserial, the latter can be easily installed with
`sudo pip install pyserial`

# Building and flashing
## Build
From the directory you've cloned this repo into just run `make`. As a result
you should get two target files: blink.elf and blink.bin. The former can be
used with GDB/OpenOCD and we will use the latter.

## Flash
To flash the device you will need a USB-Serial adapter, like one from [Sparkfun](https://www.digikey.de/product-detail/en/BOB-12731/1568-1195-ND).
Connect the adapter to the board as following:

| Adapter pin | Board pin |
| ----------- | --------- |
|     TXD     |     A9    |
|     RXD     |    A10    |
|     GND     |     G     |

Put BOOT1 jumper (the one closer to RESET button) into "1" position and reset
the board. Now flash it with

```
sudo /path/to/stm32loader.py -e -w -v -p /dev/ttyUSB0 -a 0x08000000 /path/to/stm32-bp-template/blink.bin
```

Once the flashing and verification has succeeded, return BOOT1 to "0" position
and reset the board again. You should see the LED blinking with period of one
second.

# What next?
Explore the documentation in "docs" directory to learn how to use other devices
of this MCU. Since this board is very minimalistic, you will probably need to
attach external devices (like sensors with I2C interface) to it. Explore!

