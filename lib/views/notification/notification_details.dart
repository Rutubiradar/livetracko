import 'dart:convert';

import 'package:cws_app/widgets/constant.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';

import '../../network/api_client.dart';
import '../../util/app_storage.dart';
import '../../util/app_utils.dart';

class NotificationDetails extends StatefulWidget {
  String notificationId;
  NotificationDetails({super.key, required this.notificationId});

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  String title = '';
  String description = '';
  RxBool isLoading = false.obs;

  Future<void> getNotificationDetails() async {
    isLoading.value = true;
    var body = {"notification_id": widget.notificationId};
    print('Notification data $body');

    var response = await ApiClient.post('Common/notification_details', body);

    var data = jsonDecode(response.body);
    title = data['notification_details']['name'];
    description = data['notification_details']['msg'];
    setState(() {});
    print("response: ${response.body}");
    isLoading.value = false;
  }

  @override
  void initState() {
    super.initState();
    getNotificationDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appthemColor,
        leading: AppUtils.backButton(),
        title: Text(
          'Notification',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() => isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(description,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ],
                ),
              ),
            )),
    ));
  }
}
