import 'dart:convert';

import 'package:cws_app/views/warehouse/warehouse_detail_screen.dart';
import 'package:cws_app/widgets/no_content_widget.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../network/api_client.dart';
import '../../util/app_utils.dart';
import '../../widgets/constant.dart';

class WarehouseScreen extends StatefulWidget {
  WarehouseScreen({super.key});

  @override
  State<WarehouseScreen> createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends State<WarehouseScreen> {
  var listOfProduct = [].obs;
  var listOfSearch = [].obs;
  var isLoading = false.obs;
  TextEditingController searchController = TextEditingController();
  getWarehouse() async {
    isLoading(true);
    listOfProduct([]);
    try {
      final response = await ApiClient.post("Service/warehouse_list", {});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        listOfProduct(data["data"]);
        isLoading(false);
      } else {
        isLoading(false);

        listOfProduct([]);
      }
    } catch (e) {
      isLoading(false);

      listOfProduct([]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWarehouse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: appthemColor,
          title: const Text('Warehouse',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          leading: AppUtils.backButton(),
        ),
        body: Column(children: [
          const SizedBox(height: 3),
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  listOfSearch.clear();
                  for (var i = 0; i < listOfProduct.length; i++) {
                    if (listOfProduct[i]["warehouse_name"]
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase())) {
                      listOfSearch.add(listOfProduct[i]);
                    }
                  }
                },
                decoration: InputDecoration(
                  suffix: searchController.text.isNotEmpty ||
                          listOfSearch.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            listOfSearch.clear();
                            searchController.clear();
                          },
                          child: Icon(Icons.clear),
                        )
                      : null,
                  hintText: 'Search Warehouse',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => isLoading.value
                ? Expanded(
                    child: Shimmer.fromColors(
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
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                )),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount: 10),
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100),
                  )
                : Expanded(
                    child: listOfProduct.isEmpty
                        ? NoContentScreen()
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 15),
                            padding: const EdgeInsets.all(12),
                            itemCount: listOfSearch.isNotEmpty
                                ? listOfSearch.length
                                : listOfProduct.length,
                            itemBuilder: (context, index) {
                              final warehouse = listOfSearch.isNotEmpty
                                  ? listOfSearch[index]
                                  : listOfProduct[index];
                              return ListTile(
                                onTap: () {
                                  Get.to(() => WarehouseDetailScreen(
                                      warehouse: warehouse));
                                },
                                tileColor: Colors.grey.shade200,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                title: Text(warehouse["warehouse_name"]),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (warehouse["address"] != null)
                                      HtmlWidget(warehouse["address"] ?? ''),
                                    Text(warehouse["latitude"] +
                                        " " +
                                        warehouse["logitude"]),
                                  ],
                                ),
                                trailing: const Icon(Icons.arrow_forward_ios),
                              );
                            }),
                  ),
          ),
        ]));
  }
}
