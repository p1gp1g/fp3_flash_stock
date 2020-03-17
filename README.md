# fp3_flash_stock
This script flash the partitions of the non-active slot. You need stock ROM images (e.g. [A.105](https://www.androidfilehost.com/?fid=4349826312261719146)).

Flashing the non-active slot is a way to ensure that there is always a working bootloader.

## Guide
1. Your device must have an unlocked bootloader ;
2. You need to boot to bootloader and ensure that you device is detectable by your computer with `fastboot devices` ;
3. You need to have the images in the working directory ;
4. Run `./flash.sh` .

You may need : 
- to run it as root `sudo ./flash`
- to run it twice to flash slots a and b
- to erase userdata `fastboot -w` after the flashs 

## Troubleshooting Tips

### 30 secs warning : Your device is corrupted
If you see the warning that shuts down the phone after the 30 seconds, do not forget to **press the power button** to boot.
To get rid of this warning, run `adb reboot "dm-verity enforcing"`
