import 'dart:convert';

import 'package:cws_app/views/outlets/outlet_filter.dart';
import 'package:cws_app/widgets/no_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../network/api_client.dart';
import '../../util/app_storage.dart';
import '../../util/app_utils.dart';
import '../../widgets/constant.dart';
import '../../widgets/filter_box.dart';
import 'add_outlet.dart';
import 'outlet_detail_screen.dart';

class OutletsScreen extends StatefulWidget {
  const OutletsScreen({super.key});

  @override
  State<OutletsScreen> createState() => _OutletsScreenState();
}

class _OutletsScreenState extends State<OutletsScreen> {
  var listOfOutlets = [].obs;
  var listOfSearch = [].obs;
  var isLoading = false.obs;

  TextEditingController searchController = TextEditingController();

  getOutlets() async {
    isLoading(true);
    final userId = AppStorage.getUserId();
    print('user id $userId');
    ApiClient.post("Common/sales_outlet_list", {"emp_id": userId})
        .then((response) {
      if (response.statusCode == 200) {
        final data = response.body;
        print('data $data');
        listOfOutlets(jsonDecode(data)["sales_outlet_list"]);
        listOfOutlets(listOfOutlets.reversed.toList());
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
    super.initState();
    getOutlets();
    searchController.addListener(() {
      final searchQuery = searchController.text.toLowerCase();
      if (searchQuery.isEmpty) {
        listOfSearch.clear();
      } else {
        listOfSearch.value = listOfOutlets
            .where((outlet) =>
                outlet["business_name"]
                    .toString()
                    .toLowerCase()
                    .contains(searchQuery) ||
                outlet['address']
                    .toString()
                    .toLowerCase()
                    .contains(searchQuery))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appthemColor,
        centerTitle: true,
        title: const Text('Outlets',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        )),
        leading: AppUtils.backButton(),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const AddOutletScreen());
            },
            icon: const Icon(Icons.add_business_rounded, color: Colors.white),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => getOutlets(),
        child: Obx(
          () => isLoading.value
              ? Shimmer.fromColors(
                  child: ListView.separated(
                      itemBuilder: ((context, index) => ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ListTile(
                              tileColor: Colors.grey.shade100,
                              title: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 20,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              subtitle: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 15,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey.shade300,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          )),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: 10),
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100)
              : Column(
                  children: [
                    const SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(2),
                          hintText: 'Search Outlet',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    searchController.clear();
                                    listOfSearch.clear();
                                  },
                                  icon: const Icon(Icons.clear),
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: listOfOutlets.isEmpty
                          ? const NoContentScreen()
                          : ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount: listOfSearch.isEmpty
                                  ? listOfOutlets.length
                                  : listOfSearch.length,
                              itemBuilder: (context, index) {
                                final outlet = listOfSearch.isEmpty
                                    ? listOfOutlets[index]
                                    : listOfSearch[index];

                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 8.0),
                                    child: ListTile(
                                      // onTap: () =>,
                                      leading: CircleAvatar(
                                          backgroundColor: appthemColor,
                                          child: Text(
                                              outlet["business_name"][0]
                                                  .toString()
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20))),
                                      title: Text(outlet["business_name"]),
                                      // subtitle: Text(outlet["status"] == '2'
                                      //     ? 'Visited'
                                      //     : ""),
                                      //                             subtitle: HtmlWidget(outlet["address"],
                                      //                             style: {
                                      //   "p": Style(
                                      //     margin: EdgeInsets.zero, // Removes any default margin
                                      //     maxLines: 1, // Limits to one line
                                      //     textOverflow: TextOverflow.ellipsis, // Adds ellipsis for overflow
                                      //   ),
                                      // },
                                      //                             ),
                                      trailing: SizedBox(
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Get.to(() => AddOutletScreen(
                                                        isEdit: true,
                                                        outlet: outlet,
                                                        isView: true,
                                                      ));
                                                },
                                                icon: const Icon(Icons
                                                    .info_outline_rounded)),
                                            // const Spacer(),
                                            IconButton(
                                                onPressed: () {
                                                  Get.to(
                                                      () => OutletDetailsScreen(
                                                            outlet: outlet,
                                                            checkVisit: false,
                                                          ));
                                                },
                                                icon: const Icon(Icons
                                                    .arrow_forward_ios_rounded))
                                          ],
                                        ),
                                      ),
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
