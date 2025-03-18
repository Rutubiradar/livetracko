import 'dart:convert';
import 'dart:developer';

import 'package:cws_app/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../network/api_client.dart';
import '../../../util/app_utils.dart';

class StoreInfoScreen extends StatefulWidget {
  StoreInfoScreen({super.key});

  @override
  State<StoreInfoScreen> createState() => _StoreInfoScreenState();
}

class _StoreInfoScreenState extends State<StoreInfoScreen> {
  var selectedCategory = {}.obs;
  bool isloading = false;
  var selectedSubCategory = {}.obs;

  var listOfSubCategory = [].obs;
  var listOfCategory = [].obs;
  var listOfProduct = [].obs;

  getCategoryList() async {
    setState(() {
      isloading = true;
    });
    listOfCategory([]);
    try {
      final response = await ApiClient.post("Common/category_list", {});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        listOfCategory(data["data"]);

        listOfCategory(listOfCategory.reversed.toList());
        //  selectedCategory.value = listOfCategory[0];
        setState(() {
          isloading = false;
        });
      } else {
        listOfCategory.value = [];
        AppUtils.snackBar("No Category Available");
        setState(() {
          isloading = false;
        });
      }
    } catch (e) {
      listOfCategory([]);
      setState(() {
        isloading = false;
      });
      print(e);
    }
  }

  getSubCategory() async {
    setState(() {
      isloading = true;
    });
    listOfSubCategory([]);
    try {
      final response = await ApiClient.post(
          "Common/subcategory_list", {"category_id": selectedCategory["id"]});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if ((data["data"]["subcategory"] as List).isNotEmpty) {
          selectedSubCategory(data["data"]["subcategory"][0]);
          listOfSubCategory(data["data"]["subcategory"]);
        }

        if (data["data"]["product_list"].isNotEmpty) {
          listOfProduct(data["data"]["product_list"]);
        }
        setState(() {
          isloading = false;
        });
      } else {
        listOfSubCategory([]);
        setState(() {
          isloading = false;
        });
        AppUtils.snackBar("No Category Available");
      }
    } catch (e) {
      listOfSubCategory([]);
      setState(() {
        isloading = false;
      });
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                children: [
                  20.heightBox,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.grey.shade100,
                      height: 40,
                    ),
                  ),
                  10.heightBox,
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: ((context, index) => ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Colors.grey.shade100,
                                height: 80,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 20,
                                      color: Colors.grey.shade300,
                                    ),
                                    10.heightBox,
                                    Container(
                                      height: 15,
                                      color: Colors.grey.shade300,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount: 10),
                  ),
                ],
              ))
          : Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    10.widthBox,
                    //Dropdown
                    Obx(
                      () => Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton<dynamic>(
                              value: selectedCategory.isEmpty
                                  ? null
                                  : selectedCategory.value,
                              items: listOfCategory
                                  .map<DropdownMenuItem>(
                                      (item) => DropdownMenuItem(
                                            child: Text(item["name"]),
                                            value: item,
                                          ))
                                  .toList(),
                              isExpanded: true,
                              underline: const SizedBox.shrink(),
                              onChanged: (value) {
                                selectedCategory.value = value;
                                getSubCategory();
                              },
                              hint: const Text("Category",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 14))),
                        ),
                      ),
                    ),
                    10.widthBox,
                    //Dropdown sub category

                    Obx(
                      () => listOfSubCategory.isEmpty
                          ? const SizedBox.shrink()
                          : Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                child: DropdownButton<dynamic>(
                                    value: selectedSubCategory.isEmpty
                                        ? null
                                        : selectedSubCategory.value,
                                    items: listOfSubCategory
                                        .map<DropdownMenuItem>(
                                            (item) => DropdownMenuItem(
                                                  child: Text(item["name"]),
                                                  value: item,
                                                ))
                                        .toList(),
                                    isExpanded: true,
                                    underline: const SizedBox.shrink(),
                                    onChanged: (value) {
                                      selectedSubCategory.value = value;
                                    },
                                    hint: const Text("Category",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14))),
                              ),
                            ),
                    ),

                    10.widthBox,
                  ],
                ),
                const SizedBox(height: 3),
                listOfProduct.isEmpty
                    ? Expanded(
                        child: selectedCategory.isEmpty
                            ? const Center(child: Text("Select Category"))
                            : const Center(child: Text("No Product Found")))
                    : Expanded(
                        child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            padding: const EdgeInsets.all(12),
                            itemCount: listOfProduct.length,
                            itemBuilder: (context, index) {
                              final product = listOfProduct[index];
                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product["name"],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Stock",
                                              style: TextStyle(
                                                  color: Colors.grey.shade500),
                                            ),
                                            Text(product["stock"] ?? "0"),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Unit",
                                              style: TextStyle(
                                                  color: Colors.grey.shade500),
                                            ),
                                            Text(product["unit_id"] ?? "0"),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Unit Price",
                                              style: TextStyle(
                                                  color: Colors.grey.shade500),
                                            ),
                                            Text(product["special_price"]),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
              ],
            ),
    );
  }
}
