cd datasets || exit
mkdir seattle-library-collection-inventory
kaggle datasets download -d city-of-seattle/seattle-library-collection-inventory
unzip seattle-library-collection-inventory.zip
rm seattle-library-collection-inventory.zip