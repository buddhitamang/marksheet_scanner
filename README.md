# **Mark Sheet Scanner App**

## **Overview**

The **Mark Sheet Scanner App** is a Flutter-based application that utilizes **Google ML Kit** for text recognition. The app scans mark sheets and saves the extracted data into a CSV file. Users can capture images using their device's camera or select from their gallery. The app processes the image to extract text and then saves it in CSV format.

## **Features**

- **Image Capture & Selection**: Capture images with the camera or select from the gallery.
- **Text Recognition**: Extract text from images using Google ML Kit.
- **CSV Export**: Convert extracted text to CSV format and save it to device storage.
- **Share & Open**: Share or open the CSV file directly from the app.

## **Libraries and Packages**

- **flutter**: Core framework for building the app.
- **google_ml_kit**: Provides text recognition capabilities.
- **image_picker**: For selecting images from the camera or gallery.
- **csv**: Converts text data into CSV format.
- **path_provider**: Accesses device storage directories.
- **share_plus**: Enables file sharing with other apps.

## **Installation**

1. **Clone the Repository**

   git clone https://github.com/buddhitamang/marksheet_scanner
   cd mark_sheet_scanner_app

2. **Install Dependencies**

   flutter pub get

3.  **Configure Permissions**
    
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

## **Running the app**

   flutter run
