import 'dart:convert';

import 'package:cws_app/util/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import '../../network/api_client.dart';
import '../../util/app_storage.dart';
import '../../widgets/constant.dart';

class FeedBackScreen extends StatefulWidget {
  FeedBackScreen({Key? key}) : super(key: key);

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  int rating = 5;

  TextEditingController feedbackController = TextEditingController();

  Future<void> submitFeedback() async {
    if (rating == 0) {
      Get.snackbar("Error", "Please provide rating",
          animationDuration: Duration(milliseconds: 2),
          // duration: Duration(microseconds: 3),
          backgroundColor: Colors.red);
      return;
    } else if (feedbackController.text.isEmpty ||
        feedbackController.text == "") {
      Get.snackbar("Error", "Please provide feedback",
          animationDuration: Duration(milliseconds: 1),
          // duration: Duration(milliseconds: 1),
          backgroundColor: Colors.red);
      return;
    } else {
      print("submitting feedback");
      var userId = AppStorage.getUserId();
      var body = {
        "emp_id": userId,
        "rating": rating.toString(),
        "feedback": feedbackController.text,
      };

      var response = await ApiClient.post('Common/feedback_save', body);
      print("feedback response ${response.statusCode}");
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Feedback submitted successfully",
            backgroundColor: Colors.green);

        feedbackController.clear();
        rating = 2;
        print("navigating back");
        Get.back();
      } else {
        Get.snackbar("Error", "Failed to submit feedback",
            backgroundColor: Colors.red);
      }
    }
  }

  Future<void> fetchFeedback() async {
    var userId = AppStorage.getUserId();
    var body = {"emp_id": userId};

    var response = await ApiClient.post('Common/feedback_fetch', body);

    print("Response: ${response.body}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      int ratingdata = int.parse(data["feedback_fetch"]['rating'] ?? '5');
      setState(() {
        rating = ratingdata;
        feedbackController.text = data["feedback_fetch"]['feedback'] ?? "";
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFeedback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: appthemColor,
        title: const Text(
          "Feedback",
          style: TextStyle(color: Colors.white),
        ),
        leading: AppUtils.backButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Please provide feedback for your Experience",
                style: TextStyle(
                    color: appthemColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    height: 1.1),
              ),
              const SizedBox(height: 20),
              Text("Do you have any suggestions or feedback for us?",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
              const SizedBox(height: 2),
              Text("You're feedback matters to us!",
                  style: TextStyle(color: Colors.green, fontSize: 16)),
              const SizedBox(height: 20),
              EmojiFeedback(
                initialRating: 4,
                emojiPreset: flatEmojiPreset,
                labelTextStyle: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w400),
                onChanged: (value) {
                  // setState(() {
                  //   rating = value;
                  // });
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                maxLines: 5,
                controller: feedbackController,
                decoration: InputDecoration(
                  hintText: 'Write your feedback here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  await submitFeedback();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: appthemColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
