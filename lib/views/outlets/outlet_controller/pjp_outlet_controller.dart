import 'dart:async';
import 'dart:convert';

import 'package:cws_app/util/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:cws_app/network/api_client.dart';
import 'package:cws_app/util/app_utils.dart';

class CheckInController extends GetxController {
  RxString checkInTime = '00:00 AM'.obs;
  RxBool isCheckIn = false.obs;
  RxBool isMarkVisit = true.obs;
  RxBool isShopClosed = false.obs;
  Timer? _timer;
  RxInt count = 0.obs;
  RxDouble totalSales = 0.0.obs;
  RxString checkOutTime = 'NA'.obs;
  RxBool isCheckOutDone = false.obs;
  RxString pjpId = ''.obs;

  void startCheckInTimer(bool checkVisit, String outletId) {
    if (count.value >= 5) {
      return;
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (checkVisit) {
        checkIn(outletId);
      } else {
        manuallyCheckIn(outletId);
      }
      count++;
    });
  }

  Future<void> checkIn(String outletId) async {
    print("check in only");
    var body = {
      "pjpid": outletId,
    };

    int count = 0;

    var response = await ApiClient.post("Common/outlet_checkin", body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      count++;

      if (count <= 1) {
        print('outlet details response ${data}');
      }
      // print(
      //     'check date ${DateFormat('dd-MM-yyyy').format(DateTime.parse(data['checkin_res']['visit_date']))} and ${DateFormat('dd-MM-yyyy').format(DateTime.now())}');
      if (DateFormat('dd-MM-yyyy')
              .format(DateTime.parse(data['checkin_res']['visit_date'])) ==
          DateFormat('dd-MM-yyyy').format(DateTime.now())) {
        if (data['checkin_res']['visit_status'] == "2") {
          isCheckIn.value = true;
          isMarkVisit.value = true;
        } else {
          isMarkVisit.value = false;
        }
        if (data['checkin_res']['checkin_time'] != null) {
          DateTime visitTime =
              DateTime.parse(data['checkin_res']['checkin_time'].toString());
          checkInTime.value =
              DateFormat('hh:mm a').format(visitTime).toString();
        }

        if (data['checkin_res']['checkout_time'] != null) {
          DateTime checkOutTimeDate =
              DateTime.parse(data['checkin_res']['checkout_time'].toString());
          checkOutTime.value =
              DateFormat('hh:mm a').format(checkOutTimeDate).toString();
          isCheckOutDone.value = true;
        }

        if (data['checkin_res']['reason'] == "Shop Closed") {
          isShopClosed.value = true;
        }
      } else {
        isMarkVisit.value = false;
      }
    }
  }

  int counter = 0;

  Future<void> manuallyCheckIn(String outletId) async {
    // print('manually check in');
    var userId = AppStorage.getUserId();
    var body = {
      "emp_id": userId,
      'outlet_id': outletId,
    };
    // print('custom outlet visit body $body');
    var response = await ApiClient.post("Common/manually_checkin", body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      counter++;

      if (counter <= 1) {
        print('custom outlet details response ${data}');

        print('data is ------------------${data['status']}');
      }

      // print(
      //     'check date ${DateFormat('dd-MM-yyyy').format(DateTime.parse(data['checkin_res']['visit_date']))} and ${DateFormat('dd-MM-yyyy').format(DateTime.now())}');
      if (data['status'] == 1) {
        // print('visited--------------------------');
        pjpId.value = data['checkin_res'][0]['id'].toString();

        if (data['checkin_res'][0]['visit_status'] == "2") {
          // print('visit status is 2');
          isCheckIn.value = true;
          isMarkVisit.value = true;
        } else {
          isMarkVisit.value = false;
        }
        if (data['checkin_res'][0]['checkin_time'] != null) {
          DateTime visitTime =
              DateTime.parse(data['checkin_res'][0]['checkin_time'].toString());
          checkInTime.value =
              DateFormat('hh:mm a').format(visitTime).toString();
        }
        if (data['checkin_res'][0]['checkout_time'] != null) {
          DateTime visitTime = DateTime.parse(
              data['checkin_res'][0]['checkout_time'].toString());
          checkOutTime.value =
              DateFormat('hh:mm a').format(visitTime).toString();
          isCheckOutDone.value = true;
        }

        if (data['checkin_res'][0]['reason'] == "Shop Closed") {
          isShopClosed.value = true;
        }
      } else {
        isMarkVisit.value = false;
      }
    }
  }

  Future<void> getOutletSales(String outletId) async {
    String userId = AppStorage.getUserId();
    Map<String, dynamic> body = {'emp_id': userId, 'outlet_id': outletId};
    // print('body is ${body}')/;

    var response = await ApiClient.post('Common/outlet_total_sales', body);
    // print('outlet sales response ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      totalSales.value = double.parse(
          (data['outlet_order_amount'][0]['total_amount'] ?? '0.0').toString());
    }
  }

  Future<void> markVisitCheck(String outletId) async {
    var body = {
      "pjpid": outletId,
    };

    var response = await ApiClient.post("Common/mark_visit_check", body);

    if (response.statusCode == 500) {
      AppUtils.snackBar("Outlet Not Assigned",
          backgroundColor: Colors.grey, textColor: Colors.black);
      Get.back();
    }
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['visit_status']['checkout_time'] != null) {
        AppUtils.snackBar('You have already checkout this outlet',
            backgroundColor: Colors.grey, textColor: Colors.black);
        isCheckIn.value = true;
        isMarkVisit.value = true;
        isCheckOutDone.value = true;
        // Get.back();
      } else if (data['visit_status']['visit_status'] == "2") {
        isCheckIn.value = true;
        isMarkVisit.value = true;
        AppUtils.snackBar("You have already visited this outlet",
            backgroundColor: Colors.grey, textColor: Colors.black);
      } else {
        isMarkVisit.value = false;
      }
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
