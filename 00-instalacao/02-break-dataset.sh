cd datasets || exit
mkdir seattle-library-collection-inventory/small-files
split -d -l 100000 library-collection-inventory.csv seattle-library-collection-inventory/small-files/inventory.part.
sed -i '$d' small-files/inventory.part.00
cd seattle-library-collection-inventory/small-files || exit
for i in $(seq 11 99)
do
  rm -f inventory.part."${i}"
done