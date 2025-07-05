#!/sbin/sh

# Unmount partitions (critical!)
umount /super 2>/dev/null
umount /data 2>/dev/null

# Delete existing super & userdata
/sbin/parted /dev/block/mmcblk0 rm 56
/sbin/parted /dev/block/mmcblk0 rm 55

# Recreate partitions (no gap between super and userdata)
/sbin/parted /dev/block/mmcblk0 mkpart super ext4 847MB 3532MB
/sbin/parted /dev/block/mmcblk0 mkpart userdata ext4 3532MB 15.6GB

# Assign names
/sbin/parted /dev/block/mmcblk0 name 55 super
/sbin/parted /dev/block/mmcblk0 name 56 userdata

# Format options
echo "Partition formatting options:"
echo "1. Format both super and userdata as ext4 (recommended)"
echo "2. Format only userdata as ext4"
echo "3. Skip formatting (do it manually in TWRP)"
printf "Enter choice [1]: "
read choice

case "$choice" in
  2)
    echo "Formatting only userdata..."
    /sbin/mkfs.ext4 -F /dev/block/mmcblk0p56 || echo "Warning: userdata format failed!"
    ;;
  3)
    echo "Skipping all formatting..."
    ;;
  *)
    echo "Formatting both partitions..."
    /sbin/mkfs.ext4 -F /dev/block/mmcblk0p55 || echo "Warning: super format failed!"
    /sbin/mkfs.ext4 -F /dev/block/mmcblk0p56 || echo "Warning: userdata format failed!"
    ;;
esac

echo ""
echo "Partitions restored to stock layout:"
echo "55      847MB   3532MB  2684MB               super"
echo "56      3532MB  15.6GB  12.1GB               userdata"
echo ""
if [ "$choice" -ne 3 ]; then
  echo "**Note:** If you formatted userdata, still do TWRP's 'Format Data' (type 'yes')"
fi
echo "**Flash appropriate ROM for stock partition layout**"

exit 0
