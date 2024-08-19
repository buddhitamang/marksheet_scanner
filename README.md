**Mark Sheet Scanner App**
Overview
The Mark Sheet Scanner App is a Flutter application that uses Google ML Kit for text recognition to scan mark sheets and save the extracted text data into a CSV file. Users can capture images using their device's camera or choose from their gallery, and the app will process the image, extract text, and save it in CSV format.

#Features
Capture or select images of mark sheets.
Use Google ML Kit to recognize and extract text from images.
Convert recognized text into CSV format.
Save the CSV file to the device’s storage.
Share or open the CSV file directly from the app.
Libraries and Packages Used
flutter: Flutter SDK for building the app.
google_ml_kit: Provides text recognition capabilities using Google’s machine learning models.
image_picker: Allows users to pick images from the gallery or camera.
csv: Used for converting the list of rows into CSV format.
path_provider: Provides access to the device’s storage directories.
share_plus: Allows sharing files with other apps.

#Installation
Clone the Repository
git clone https://github.com/yourusername/mark_sheet_scanner_app.git
cd mark_sheet_scanner_app
Install Dependencies

Ensure you have Flutter installed. Run the following command to get the required packages:

flutter pub get
Configure Permissions

For Android, add the following permissions to your AndroidManifest.xml:
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

For iOS, add the following keys to your Info.plist:
<key>NSCameraUsageDescription</key>
<string>We need access to the camera to scan documents.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library to select images.</string>

#Running the App
Run the App

#Connect your device or start an emulator and run:
flutter run

#Using the App
Tap the floating action button to open a dialog where you can choose the image source (Camera or Gallery).
Capture or select an image of the mark sheet.
The app will process the image and display the extracted text.
The CSV file will be saved in the device’s storage, and you can share or view it using the provided options.
