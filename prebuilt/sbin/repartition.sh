#!/sbin/sh

# CAT S22 Flip Minimal Repartition Script
# ONLY modifies super (p55) and userdata (p56)

# Unmount ONLY super and userdata (if mounted)
umount /super 2>/dev/null
umount /data 2>/dev/null

# Start repartitioning using echo+pipes (no temp files)
echo "Repartitioning super (p55) and userdata (p56)..."
echo -e "print\nrm 56\nrm 55\nmkpart super ext4 847MB 4943MB\nmkpart userdata ext4 4943MB 15.6GB\nname 55 super\nname 56 userdata\nprint\nquit" | /sbin/parted /dev/block/mmcblk0

if [ $? -ne 0 ]; then
  echo "Error: Partitioning failed!"
  exit 1
fi

# Format the new partitions
echo "Formatting new partitions..."
echo "Choose super partition format:"
echo "1. ext4 (recommended)"
echo "2. Do not format super (advanced)"
printf "Enter choice [1]: "
read choice

case "$choice" in
  2)
    echo "Skipping super partition format..."
    ;;
  *)
    /sbin/mkfs.ext4 -F /dev/block/mmcblk0p55 || echo "Warning: super format failed!"
    ;;
esac

/sbin/mkfs.ext4 -F /dev/block/mmcblk0p56 || echo "Warning: userdata format failed!"

echo "Repartitioning complete!"
echo "**MANUALLY REQUIRED:**"
echo "1. Go to TWRP -> 'Format Data' (type 'yes')"
echo "2. Reboot recovery"
echo "3. Flash ROM with new partition layout"

exit 0
