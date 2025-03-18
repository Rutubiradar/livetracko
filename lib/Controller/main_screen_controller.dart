import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../network/api_client.dart';
import '../util/app_storage.dart';
import '../util/app_utils.dart';

class MainScreenController extends GetxController {
  RxString appVersion = '1.0.0'.obs;
  RxString target = '0.00'.obs;
  RxString dailySales = '0.00'.obs;
  RxString salesVisit = '0.00'.obs;

  Future<void> getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
  }

  Future<void> getDailySales() async {
    final userId = AppStorage.getUserId();
    final userData = AppStorage.getUserDetails();
    double temptarget = double.parse((userData.target ?? 0).toString());
    target.value = temptarget.toStringAsFixed(2);
    final response = await ApiClient.post(
      "Common/daily_sales_amount",
      {'emp_id': userId},
    );
    print('response ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('daily sales data ${data['daily_sales_amount']['today_sales']}');
      // setState(() {
      dailySales.value =
          (data['daily_sales_amount']['today_sales'] ?? "0").toString();
      // });
    } else {
      AppUtils.snackBar("Failed to check attendance, Please try again later.",
          backgroundColor: Colors.red.shade500);
    }
  }

  Future<void> salesVisitCount() async {
    final userId = AppStorage.getUserId();
    final response = await ApiClient.post(
      "Common/sales_visit_count",
      {'emp_id': userId},
    );
    print('response ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('daily sales data ${data['sales_visit_count']}');
      // setState(() {
      salesVisit.value = (data['sales_visit_count'] ?? "0").toString();
      // });
    } else if (response.statusCode == 500) {
      // setState(() {
      salesVisit.value = "0.00";
      // });
    } else {
      AppUtils.snackBar("Sales visit count not found, Please try again later.",
          backgroundColor: Colors.red.shade500);
    }
  }
}
