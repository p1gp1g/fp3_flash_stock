#!/bin/sh

_exit(){
  echo $1
  exit 1
}

## CHECK THE FILES
[ -f product.img ] && _exit "Couldn't find ./product.img"
[ -f keymaster.img ] && _exit "Couldn't find ./keymaster.img"
[ -f cmnlib64.img ] && _exit "Couldn't find ./cmnlib64.img"
[ -f cmnlib.img ] && _exit "Couldn't find ./cmnlib.img"
[ -f lksecapp.img ] && _exit "Couldn't find ./lksecapp.img"
[ -f mdtp.img ] && _exit "Couldn't find ./mdtp.img"
[ -f vendor.img ] && _exit "Couldn't find ./vendor.img"
[ -f system.img ] && _exit "Couldn't find ./system.img"
[ -f boot.img ] && _exit "Couldn't find ./boot.img"
[ -f vbmeta.img ] && _exit "Couldn't find ./vbmeta.img"
[ -f dtbo.img ] && _exit "Couldn't find ./dtbo.img"
[ -f dsp.img ] && _exit "Couldn't find ./dsp.img"
[ -f devcfg.img ] && _exit "Couldn't find ./devcfg.img"
[ -f tz.img ] && _exit "Couldn't find ./tz.img"
[ -f rpm.img ] && _exit "Couldn't find ./rpm.img"
[ -f sbl1.img ] && _exit "Couldn't find ./sbl1.img"
[ -f modem.img ] && _exit "Couldn't find ./modem.img"
[ -f aboot.img ] && _exit "Couldn't find ./aboot.img"

## GET THE SLOTS
fastboot getvar current-slot 2>&1 | grep "current-slot: a" >/dev/null
if [ $? -eq 0 ]; then
  CURRENT_SLOT="a"
  FLASH_SLOT="b"
else
  CURRENT_SLOT="b"
  FLASH_SLOT="a"
fi
echo "CURRENT SLOT: $CURRENT_SLOT"
echo "FLASHING SLOT: $FLASH_SLOT"

exit 0
## FLASH THE OTHER SLOT PARTITIONS
fastboot flash product_$FLASH_SLOT product.img -S 522239K || _exit "problem while flashing product"
fastboot flash keymaster_$FLASH_SLOT keymaster.img || _exit "problem while flashing keymaster"
fastboot flash cmnlib64_$FLASH_SLOT cmnlib64.img || _exit "problem while flashing cmnlib64"
fastboot flash cmnlib_$FLASH_SLOT cmnlib.img || _exit "problem while flashing cmnlib"
fastboot flash lksecapp_$FLASH_SLOT lksecapp.img || _exit "problem while flashing lksecapp"
fastboot flash mdtp_$FLASH_SLOT mdtp.img || _exit "problem while flashing mdtp"
fastboot flash vendor_$FLASH_SLOT vendor.img -S 522239K || _exit "problem while flashing vendor"
fastboot flash system_$FLASH_SLOT system.img -S 522239K || _exit "problem while flashing system"
fastboot flash boot_$FLASH_SLOT boot.img || _exit "problem while flashing boot"
fastboot flash vbmeta_$FLASH_SLOT vbmeta.img || _exit "problem while flashing vbmeta"
fastboot flash dtbo_$FLASH_SLOT dtbo.img || _exit "problem while flashing dtbo"
fastboot flash dsp_$FLASH_SLOT dsp.img || _exit "problem while flashing dsp"
fastboot flash devcfg_$FLASH_SLOT devcfg.img || _exit "problem while flashing devcfg"
fastboot flash tz_$FLASH_SLOT tz.img || _exit "problem while flashing tz"
fastboot flash rpm_$FLASH_SLOT rpm.img || _exit "problem while flashing rpm"
fastboot flash sbl1_$FLASH_SLOT sbl1.img || _exit "problem while flashing sbl1"
fastboot flash modem_$FLASH_SLOT modem.img || _exit "problem while flashing modem"
fastboot flash aboot_$FLASH_SLOT aboot.img || _exit "problem while flashing aboot"

# Test the flashed bootloader
fastboot --set-active=$FLASH_SLOT
fastboot reboot bootloader
fastboot getvar current-slot 2>&1 | grep "current-slot: $FLASH_SLOT"  || _exit "/\!\\ Couldn't reboot to slot $FLASH_SLOT"
echo "Slot $FLASH_SLOT was successfully flashed."
