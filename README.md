# fp3_flash_stock
This script flash the partitions of the non-active slot. You need stock ROM images (link coming).

Flashing the non-active slot is a way to ensure that there is always a working bootloader.

## Guide
1. Your device must have an unlocked bootloader ;
2. You need to boot to bootloader and ensure that you device is detectable by your computer with `fastboot device` ;
3. You need to have the images in the working directory ;
4. Run `./flash.sh` .

You may need to run it as root `sudo ./flash`
