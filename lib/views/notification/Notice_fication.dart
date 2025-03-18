import 'dart:convert';

import 'package:cws_app/util/app_storage.dart';
import 'package:cws_app/widgets/no_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../network/api_client.dart';
import '../../util/app_utils.dart';
import '../../widgets/constant.dart';
import 'notification_details.dart';

class NoticeFication extends StatefulWidget {
  const NoticeFication({Key? key}) : super(key: key);

  @override
  State<NoticeFication> createState() => _NoticeFicationState();
}

class _NoticeFicationState extends State<NoticeFication> {
  RxList notificationList = <dynamic>[].obs;
  RxBool isLoading = false.obs;

  Future<void> getNotifications() async {
    isLoading.value = true;
    var userId = AppStorage.getUserId();
    var body = {"emp_id": userId};
    print("notification list body $body");

    var response = await ApiClient.post('Common/notification_list', body);

    if (response.statusCode == 200) {
      var data = response.body;
      notificationList(jsonDecode(data)["notification_list"] ?? []);
      // print("notification list data is ${}")
    } else {
      isLoading.value = false;
      throw Exception('Failed to load data');
    }

    // setState(() {
    isLoading.value = false;
    // });
  }

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appthemColor,
        title: Text(
          "Notification",
          style: TextStyle(color: Colors.white),
        ),
        leading: AppUtils.backButton(),
      ),
      body: Obx(() => Padding(
            padding: EdgeInsets.all(12.0),
            child: isLoading.value
                ? _buildShimmerEffect()
                : notificationList.isEmpty
                    ? Center(
                        child: NoContentScreen(),
                      )
                    : ListView.builder(
                        itemCount: notificationList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              onTap: () => Get.to(() => NotificationDetails(
                                    notificationId: notificationList[index]
                                        ["nid"],
                                  )),
                              title: Text(
                                notificationList[index]["name"],
                                style: GoogleFonts.roboto(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                notificationList[index]["msg"],
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              trailing: Text(
                                DateFormat('dd-MM-yyyy').format(DateTime.parse(
                                  notificationList[index]["created"],
                                )),
                                style: GoogleFonts.roboto(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          )),
    );
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            child: ListTile(
              title: Container(
                color: Colors.grey,
                height: 15.0.sp,
              ),
              subtitle: Container(
                color: Colors.grey,
                height: 10.0.sp,
              ),
              trailing: Container(
                color: Colors.grey,
                height: 10.0.sp,
                width: 60.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
