import 'dart:convert';

import 'package:cws_app/network/api_client.dart';
import 'package:cws_app/util/app_storage.dart';
import 'package:cws_app/views/attendance/add_addendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../util/app_utils.dart';
import '../../widgets/constant.dart';
import '../../widgets/no_content_widget.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  var isLoading = false;
  List<Map<String, dynamic>> _attendanceData = [];
  List<Map<String, dynamic>> _leaveData = [];

  Future<void> getHistory() async {
    setState(() {
      isLoading = true;
    });

    try {
      String userId = await AppStorage.getUserId();
      var response =
          await ApiClient.post('Common/attendance_list', {'emp_id': userId});

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final presentList = data['present_list'] as List<dynamic>;
        final absentList = data['absent_list'] as List<dynamic>;

        _attendanceData = presentList.map((item) {
          return {
            'check_in': item['check_in'],
            'check_out': item['check_out'],
            'notes': item['notes'] ?? '',
          };
        }).toList();

        _leaveData = absentList.map((item) {
          return {
            'leave_day': item['leave_day'],
            'leave_type': item['leave_type'],
            'start_date': item['start_date'],
            'end_date': item['end_date'],
            'leave_reason': item['leave_reason'],
          };
        }).toList();
      } else {
        _attendanceData = [];
        _leaveData = [];
      }
    } catch (e) {
      print("Error fetching attendance/leave data: $e");
      _attendanceData = [];
      _leaveData = [];
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String _formatDate(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return 'NA';
    final date = DateTime.tryParse(dateTime);
    if (date == null) return 'NA';
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return 'NA';
    final time = DateTime.tryParse(dateTime)?.toLocal();
    if (time == null) return 'NA';
    final formattedTime = DateFormat('h:mm a').format(time);
    return formattedTime;
  }

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appthemColor,
        title: const Text('Attendance & Leave History',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        leading: AppUtils.backButton(),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _attendanceData.isEmpty && _leaveData.isEmpty
              ? NoContentScreen(
                  message: 'No attendance or leave data available.')
              : ListView.separated(
                  itemCount: _attendanceData.length + _leaveData.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
                  itemBuilder: (context, index) {
                    if (index < _attendanceData.length) {
                      final attendance = _attendanceData[index];
                      final checkIn = attendance['check_in'] as String?;
                      final checkOut = attendance['check_out'] as String?;
                      final notes = attendance['notes'] as String? ?? '';

                      final checkInDate = _formatDate(checkIn);
                      final checkInTime = _formatTime(checkIn);
                      final checkOutTime = _formatTime(checkOut);

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.grey.shade100,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  checkInDate,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Divider(
                                indent: 10,
                                endIndent: 10,
                                color: Colors.grey.shade300,
                                height: 2,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Check In',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.green,
                                          ),
                                        ),
                                        Text(
                                          checkInTime,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Check Out',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Text(
                                          checkOutTime.isEmpty
                                              ? 'N/A'
                                              : checkOutTime,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Notes: $notes',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      final leaveIndex = index - _attendanceData.length;
                      final leave = _leaveData[leaveIndex];
                      final leaveType = leave['leave_type'] as String?;
                      final startDate = leave['start_date'] as String?;
                      final endDate = leave['end_date'] as String?;
                      final leaveReason = leave['leave_reason'] as String?;

                      final formattedStartDate = _formatDate(startDate);
                      final formattedEndDate = _formatDate(endDate);

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.yellow.shade100,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Leave',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Divider(
                                indent: 10,
                                endIndent: 10,
                                color: Colors.grey.shade300,
                                height: 2,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Type',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.brown,
                                          ),
                                        ),
                                        Text(
                                          leaveType ?? 'N/A',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Period',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.brown,
                                          ),
                                        ),
                                        Text(
                                          '$formattedStartDate to $formattedEndDate',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Reason: $leaveReason',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
    );
  }
}
