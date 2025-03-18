import 'package:flutter/material.dart';

class NoContentScreen extends StatelessWidget {
  final String message;
  final String imagePath;

  const NoContentScreen({
    Key? key,
    this.message = "No Content Available",
    this.imagePath = 'assets/no_content.jpg', // Path to your image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 200.0,
                width: 200.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24.0),
              Text(
                message,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
