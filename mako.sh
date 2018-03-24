# Define variables
Kernel_Dir="/home/quangduc/SINAI-N4"
KERNEL="/home/quangduc/SINAI-N4/arch/arm/boot/zImage"

#!/bin/bash
BUILD_START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=../TC/bin/arm-QUVNTNM_TOOLCHAIN-linux-musleabihf-
export KBUILD_BUILD_USER="quangduc"
export KBUILD_BUILD_HOST="quangduc"
echo -e "$cyan***********************************************"
echo "          Compiling Mako kernel          "
echo -e "***********************************************$nocol"
echo -e " Initialized mako defconfig! "
make sudokamikaze_mako_defconfig
echo -e " Building kernel"
make -j16

if [ -a $KERNEL ];
then
echo -e " Converting the output into a flashable zip"
cp arch/arm/boot/zImage flash_zip/
rm -f ~/Kernel.zip
cd flash_zip
zip -r ~/Kernel.zip ./
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
else
echo "Compilation failed! Fix the errors!"
fi
