import 'dart:convert';

import 'package:cws_app/views/outlets/outlet_filter.dart';
import 'package:cws_app/widgets/no_content_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../network/api_client.dart';
import '../../util/app_storage.dart';
import '../../util/app_utils.dart';
import '../../widgets/constant.dart';
import '../../widgets/filter_box.dart';
import 'add_outlet.dart';
import 'outlet_detail_screen.dart';

class OutletsPjpScreen extends StatefulWidget {
  OutletsPjpScreen({super.key});

  @override
  State<OutletsPjpScreen> createState() => _OutletsPjpScreenState();
}

class _OutletsPjpScreenState extends State<OutletsPjpScreen> {
  var listOfOutlets = [].obs;
  var isLoading = false.obs;
  var listOfDates = <String>[];
  var currentIndex = 0;
  getOutlets() async {
    isLoading(true);
    final userId = AppStorage.getUserId();
    ApiClient.post("Common/outlet_list", {"emp_id": userId}).then((response) {
      print('outlet list response ${response.body}');
      if (response.statusCode == 200) {
        final data = response.body;
        print(data);
        listOfOutlets(jsonDecode(data)["outlet_list"]);
        listOfOutlets.forEach((element) {
          listOfDates.add(element["visit_date"]);
        });
        listOfDates = listOfDates.toSet().toList();
        listOfDates.sort((a, b) => a.compareTo(b));
        listOfDates = listOfDates.toList();
        print("list date ${listOfDates[0]}");

        final today = DateTime.now();
        final todayStr =
            "${today.year}-${today.month.toString().padLeft(2, "0")}-${today.day.toString().padLeft(2, "0")}";
        currentIndex = listOfDates.indexOf(todayStr);
        print(currentIndex);
        print("Today: $todayStr");

        if (currentIndex == -1) {
          currentIndex = listOfDates.length - 1;
        }

        setState(() {});
      } else {
        listOfOutlets([]);
        isLoading(false);
      }
      isLoading(false);
    }).catchError((e) {
      isLoading(false);

      listOfOutlets([]);
      Get.snackbar("Error", e.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOutlets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appthemColor,
        centerTitle: true,
        title: const Text('Patient List',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        )),
        leading: AppUtils.backButton(),
      ),
      body: Obx(
        () => isLoading.value
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: ListTile(
                                      tileColor: Colors.grey.shade100,
                                      title: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          color: Colors.grey.shade300,
                                          height: 20,
                                        ),
                                      ),
                                      subtitle: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          color: Colors.grey.shade300,
                                          height: 15,
                                          width: 100,
                                        ),
                                      ),
                                      trailing: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          color: Colors.grey.shade300,
                                          height: 20,
                                          width: 50,
                                        ),
                                      ),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.grey.shade300,
                                        radius: 30,
                                      )),
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount: 10),
                      ),
                    ],
                  ),
                ))
            : DefaultTabController(
                length: listOfDates.length,
                initialIndex: currentIndex,
                child: Column(
                  children: [
                    TabBar(
                        onTap: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        isScrollable: true,
                        labelColor: appthemColor,
                        indicatorColor: appthemColor,
                        tabAlignment: TabAlignment.start,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          ...listOfDates.map((e) =>
                              Tab(text: AppUtils.getDateTimeFormatted(e))),
                        ]),
                    const SizedBox(height: 4),
                    Expanded(
                      child: listOfOutlets.isEmpty
                          ? NoContentScreen()
                          : ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount: listOfOutlets.length,
                              itemBuilder: (context, index) {
                                final outlet = listOfOutlets[index];
                                if (outlet["visit_date"] !=
                                    listOfDates[currentIndex]) {
                                  return const SizedBox.shrink();
                                }
                                return Card(
                                  child: ListTile(
                                    onTap: () => Get.to(() =>
                                        OutletDetailsScreen(outlet: outlet)),
                                    leading: CircleAvatar(
                                        backgroundColor: appthemColor,
                                        child: Text(
                                            '${outlet["business_name"][0]}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20))),
                                    title: Text(outlet["business_name"]),
                                    subtitle: Text(
                                        'Lat:${outlet["latitude"]} Long:${outlet["longitude"]}'),
                                    //ruppee symbol
                                    trailing: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Text('₹ ${outlet['amount'] ?? '0'}',
                                        //     style: const TextStyle(
                                        //         color: Colors.black,
                                        //         fontSize: 14)),
                                        // const SizedBox(height: 2),
                                        outlet['visit_status'] == '2'
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    color:
                                                        outlet['visit_status'] ==
                                                                '2'
                                                            ? Colors.green
                                                            : Colors.red,
                                                    //    border: Border.all(color: index.isEven ? Colors.green : Colors.red),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                    outlet['visit_status'] ==
                                                            '2'
                                                        ? 'Visited'
                                                        : 'Not Visited',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12)))
                                            : SizedBox.shrink()
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
