import 'dart:convert';
import 'dart:math';

import 'package:cws_app/network/api_client.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../util/app_storage.dart';
import '../../util/app_utils.dart';
import '../../widgets/constant.dart';

class PerformanceScreen extends StatefulWidget {
  PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  RxString totalDays = "0".obs;
  RxString workingDays = "0".obs;
  RxString presentDay = "0".obs;
  RxString absentDay = "0".obs;
  RxString paidLeaveDay = "0".obs;
  RxString visitedOutlet = "0".obs;
  RxString totalSales = "0".obs;
  RxString totalOrder = "0".obs;
  RxString totalOutlet = "0".obs;
  RxList topFiveOutlet = <dynamic>[].obs;

  final List<DataItem> _graphData = List.generate(
      30,
      (index) => DataItem(
          x: index,
          y1: Random().nextInt(20) + Random().nextDouble(),
          y2: Random().nextInt(20) + Random().nextDouble(),
          y3: Random().nextInt(20) + Random().nextDouble()));

  Future<void> getData() async {
    var userId = AppStorage.getUserId();
    var attendanceResponse =
        await ApiClient.post("Common/attendance_report", {"emp_id": userId});

    if (attendanceResponse.statusCode == 200) {
      var data = jsonDecode(attendanceResponse.body);
      totalDays.value = data["totalDays"].toString();
      workingDays.value = data["workingDays"].toString();
      presentDay.value = data["present_days"]['present_count'] ?? "0";
      absentDay.value = data["absent_days"]['absent_count'] ?? "0";
      paidLeaveDay.value = data["paidleave_days"]['paidleave_count'] ?? "0";
      print(data);
    } else {
      print("Failed to load data");
    }
    var performanceResponse =
        await ApiClient.post("Common/perfomance", {"emp_id": userId});

    if (performanceResponse.statusCode == 200) {
      var data = jsonDecode(performanceResponse.body);
      visitedOutlet.value = data["visited_outlet"].toString();
      totalSales.value = data["total_sales_amount"]['total_sales'] ?? '0';
      totalOrder.value = data["total_order"]['total_order'] ?? "0";
      totalOutlet.value = data["total_outlet"]['total_outlet'] ?? "0";
      print(data);
    } else {
      print("Failed to load performance data");
    }
    var topFiveOutletResponse =
        await ApiClient.post("Common/top5outlet", {"emp_id": userId});

    if (topFiveOutletResponse.statusCode == 200) {
      var data = jsonDecode(topFiveOutletResponse.body);
      topFiveOutlet(data["top5outlet"]);
      print(data);
    } else {
      print("Failed to load top five outlet data");
    }
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.attach_money; // Icon for sales or revenue
      case 1:
        return Icons.shopping_cart; // Icon for number of products sold
      case 2:
        return Icons.star; // Icon for customer ratings or reviews
      case 3:
        return Icons.trending_up; // Icon for performance or growth
      default:
        return Icons.info; // Default icon
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appthemColor,
        title: const Text('Performance',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        leading: AppUtils.backButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100),
              child: BarChart(BarChartData(
                  borderData: FlBorderData(
                      border: Border(
                    top: BorderSide.none,
                    right: BorderSide(width: 1),
                    left: BorderSide.none,
                    bottom: BorderSide(width: 1),
                  )),
                  groupsSpace: 10,
                  barGroups: [
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(
                          fromY: 0, toY: 10, width: 15, color: Colors.amber)
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(
                          fromY: 0, toY: 15, width: 15, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 3, barRods: [
                      BarChartRodData(
                          fromY: 0, toY: 20, width: 15, color: Colors.red)
                    ]),
                    BarChartGroupData(x: 4, barRods: [
                      BarChartRodData(
                          fromY: 0, toY: 25, width: 15, color: Colors.green)
                    ]),
                  ])),
            ),
            const SizedBox(height: 15),
            const Divider(color: Colors.black54, height: 1),
            const SizedBox(height: 15),
            ListTile(
              tileColor: appthemColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text("Attendance Summary",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            const SizedBox(height: 10),

            const SizedBox(height: 10),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: const Offset(0, 1),
                              ),
                            ]),
                        child: Column(
                          children: [
                            Text(presentDay.value,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            Text("Present",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.red.shade600,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: const Offset(0, 1),
                              ),
                            ]),
                        child: Column(
                          children: [
                            Text(absentDay.value,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            Text("Absent",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Add spacing between containers
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade600,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: const Offset(0, 1),
                              ),
                            ]),
                        child: Column(
                          children: [
                            Text(paidLeaveDay.value,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            Text("Leave",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),

                    // SizedBox(width: 10), // Add spacing between containers
                    // Expanded(
                    //   child: Container(
                    //     padding: const EdgeInsets.all(10),
                    //     decoration: BoxDecoration(
                    //         color: Colors.blue.shade600,
                    //         borderRadius: BorderRadius.circular(12),
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.grey.shade300,
                    //             blurRadius: 5,
                    //             spreadRadius: 1,
                    //             offset: const Offset(0, 1),
                    //           ),
                    //         ]),
                    //     child: Column(
                    //       children: [
                    //         Text(totalDays.value,
                    //             style: TextStyle(
                    //                 fontSize: 18, color: Colors.white)),
                    //         Text("Total Days",
                    //             maxLines: 1,
                    //             overflow: TextOverflow.ellipsis,
                    //             style: TextStyle(color: Colors.white)),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                )),

            const SizedBox(height: 25),
            Obx(
              () => Text("Total Working Days: ${workingDays.value}",
                  style: TextStyle(fontSize: 16)),
            ),
            // const SizedBox(height: 15),
            // const Text("Average Time Spent in Market: NA",
            //     style: TextStyle(fontSize: 16)),
            const SizedBox(height: 15),
            const Divider(color: Colors.black54, height: 1),
            const SizedBox(height: 25),
            ListTile(
              tileColor: appthemColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              leading:
                  const Icon(Icons.sticky_note_2_outlined, color: Colors.white),
              title: const Text(
                "Summary",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * 0.325,
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: (3 / 2),
                ),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle tap for interactive effect
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [appthemColor, Colors.blueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _getIcon(
                                index), // Add a method to return an icon based on index
                            size: 30,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _getTitle(index),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Obx(() => Text(
                                _getValue(index),
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),
            const Divider(color: Colors.black54, height: 1),
            const SizedBox(height: 35),
            ListTile(
              tileColor: appthemColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              leading:
                  const Icon(Icons.sticky_note_2_outlined, color: Colors.white),
              title: const Text("Top 5 Outlet",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            const SizedBox(height: 15),
            Obx(() => ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: topFiveOutlet.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: ListTile(
                          title: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                      maxLines: 1,
                                      topFiveOutlet[index]["business_name"],
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 18)),
                                ),
                                // Spacer(),
                                Flexible(
                                  child: SizedBox(
                                    child: Text(
                                        maxLines: 1,
                                        "Amout: ${topFiveOutlet[index]["amount"]}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 16)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return "Total Outlet";
      case 1:
        return "Visited Outlet";
      case 2:
        return "Total Sales";
      case 3:
        return "Total Order";
      default:
        return "";
    }
  }

  String _getValue(int index) {
    switch (index) {
      case 0:
        return totalOutlet.value;
      case 1:
        return visitedOutlet.value;
      case 2:
        return totalSales.value;
      case 3:
        return totalOrder.value;
      default:
        return "";
    }
  }
}

class DataItem {
  int x;
  double y1;
  double y2;
  double y3;

  DataItem(
      {required this.x, required this.y1, required this.y2, required this.y3});
}
