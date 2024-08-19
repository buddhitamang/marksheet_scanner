import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path_provider/path_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String scannedText = '';
  File? pickedImage;
  bool _isLoading = false; // Variable to manage loading state

  Future<void> scanMarkSheet(ImageSource source) async {
    setState(() {
      _isLoading = true;
    });

    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final inputImage = InputImage.fromFile(imageFile);

      final textRecognizer = GoogleMlKit.vision.textRecognizer();
      final RecognizedText recognizedText =
      await textRecognizer.processImage(inputImage);

      setState(() {
        scannedText = recognizedText.text;
        pickedImage = imageFile;
        _isLoading = false;
      });

      textRecognizer.close();

      // Process text into rows for saving as CSV
      final List<List<String>> rows = recognizedText.text
          .split('\n')
          .map((line) => line.split(',')) // Adjust based on how your data is separated
          .toList();

      await _saveAsCSV(rows);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveAsCSV(List<List<String>> rows) async {
    // Convert the list of rows into a CSV string
    String csvData = const ListToCsvConverter().convert(rows);

    // Get the directory for storing the file
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/scanned_data.csv';

    // Create the file
    final file = File(path);

    // Write the CSV data to the file
    await file.writeAsString(csvData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('CSV saved at $path')),
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                scanMarkSheet(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                scanMarkSheet(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Your Scanned Document'),
            Icon(Icons.settings),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showImageSourceDialog,
        child: const Icon(Icons.qr_code),
        backgroundColor: Colors.grey.shade300,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey),
              child: Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50),
                ),
              ),
            ),
            _buildDrawerItem(Icons.home, 'Home'),
            _buildDrawerItem(Icons.file_copy_sharp, 'My Documents'),
            _buildDrawerItem(Icons.settings, 'Settings'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (pickedImage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Image.file(
                    pickedImage!,
                    height: 300,
                    width: 400,
                    fit: BoxFit.cover,
                  ),
                ),
              if (scannedText.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: pickedImage == null
                      ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: Image.asset(
                          'lib/assets/file.png',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'No Data Scanned',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  )
                      : const Text(
                    'No text found in the image',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Your Scanned Text is here',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        scannedText,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
