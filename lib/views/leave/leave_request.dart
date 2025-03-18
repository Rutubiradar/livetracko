import 'dart:developer';

import 'package:cws_app/network/api_client.dart';
import 'package:cws_app/util/app_utils.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util/app_storage.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  TextEditingController rangeDate = TextEditingController();
  String leaveDays = "";
  TextEditingController leaveReason = TextEditingController();

  leaveRequest() async {
    AppUtils.showLoader();
    final days = rangeDate.text.split(' to ');
    ApiClient.post("Common/leave_request", {
      "emp_id": AppStorage.getUserId(),
      'leave_days': leaveDays,
      'start_date': days[0],
      'end_date': days[1],
      'leave_reason': leaveReason.text,
    }).then((response) {
      AppUtils.hideLoader();
      if (response.statusCode == 200) {
        AppUtils.hideLoader();
        final data = response.body;
        log(data.toString());
        AppUtils.snackBar('Leave Requested Successfully');
      } else {
        AppUtils.hideLoader();
        log('error');
      }
    }).catchError((e) {
      AppUtils.hideLoader();
      log('error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppUtils.backButton(),
        title: const Text('Leave Request',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: appthemColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Note: You can't apply for leave on the same day",
                  style: const TextStyle(fontSize: 15)),
              SizedBox(height: 30),
              Text('Select Date Range', style: const TextStyle(fontSize: 15)),
              SizedBox(height: 15),
              TextFormField(
                controller: rangeDate,
                onTap: () {
                  showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  ).then((value) {
                    leaveDays =
                        value!.end.difference(value.start).inDays.toString();
                    rangeDate.text =
                        "${value!.start.year}-${value.start.month}-${value.start.day} to ${value.end.year}-${value.end.month}-${value.end.day}";
                  });
                },
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Pick Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Leave Reason', style: const TextStyle(fontSize: 15)),
              SizedBox(height: 15),
              TextFormField(
                controller: leaveReason,
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: 'Enter Leave Reason',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: appthemColor,
                    minimumSize: const Size(double.infinity, 50)),
                onPressed: () {
                  if (leaveReason.text.isEmpty || rangeDate.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please fill all the fields')));
                  } else {
                    leaveRequest();
                  }
                },
                child: const Text('Request Leave',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
