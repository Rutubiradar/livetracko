import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewScreen extends StatelessWidget {
  final CameraController cameraController;

  const CameraPreviewScreen({super.key, required this.cameraController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Capture Selfie'),
      ),
      body: Stack(
        children: [
          // Full-screen camera preview
          Positioned.fill(
            child: CameraPreview(cameraController),
          ),
          // Capture button
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  backgroundColor:
                      Colors.red, // Background color of the capture button
                ),
                onPressed: () async {
                  try {
                    final XFile imageFile =
                        await cameraController.takePicture();
                    final imagePath = imageFile.path;
                    Navigator.pop(context, File(imagePath));
                  } catch (e) {
                    print('Error capturing image: $e');
                    // Optionally, show an error message to the user
                  }
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
          // Back button
        ],
      ),
    );
  }
}
