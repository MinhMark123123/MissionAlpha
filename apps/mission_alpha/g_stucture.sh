# Define the folder name
assets_folder="assets"

# Check if the assets folder exists
if [ ! -d "$assets_folder" ]; then
  # Create the assets folder if it doesn't exist
  mkdir "$assets_folder"
  echo "Created folder: $assets_folder"
fi
# Define subfolder names
subfolders=("audio" "images" "tiles")

# Create subfolders within the assets folder
for folder in "${subfolders[@]}"; do
  # Create the subfolder with the full path
  mkdir "$assets_folder/$folder"
  echo "Created folder: $assets_folder/$folder"
done