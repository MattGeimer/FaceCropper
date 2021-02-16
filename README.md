# FaceCropper
Opens all images in a directory, detects any faces in the images, and saves each face as a cropped image to an output directory

## Usage

### Launching:
Open XCode and run. Alternatively, build using the .xcodeproj and run executable generated using ./facecropper.

### Step 1:
A file dialog will pop up. Choose the directory from which you want the program to read. **WARNING**: This will attempt to read/crop __any__ photos you have in that directory.

### Step 2:
Another file dialog will pop up. Choose the directory to which you want the program to save the cropped photos tool. I recommend making a dedicated directory instead of something like the desktop because it can save a *lot* of photos depending on the number of input images and the number of faces.

### Step 3:
Program will run, wait until finished.

### Results:
Output directory will now be populated with cropped images of all faces [Apple's Vision framework](https://developer.apple.com/documentation/vision) detects.
