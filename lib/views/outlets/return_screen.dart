import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../helper/app_static.dart';
import '../../network/api_client.dart';
import '../../util/app_storage.dart';
import '../../util/app_utils.dart';
import '../../util/constant.dart';
import '../../widgets/constant.dart';
import 'review_order_screen.dart';

class ReturnScreen extends StatefulWidget {
  const ReturnScreen({super.key, required this.outletId});
  final String outletId;

  @override
  State<ReturnScreen> createState() => _ReturnScreenState();
}

class _ReturnScreenState extends State<ReturnScreen> {
  var listOfProduct = [].obs;
  var listOfSearch = [].obs;
  var listOfCart = [].obs;
  var isLoading = false.obs;
  TextEditingController searchController = TextEditingController();
  getProducts() async {
    isLoading(true);
    listOfProduct([]);
    try {
      final response = await ApiClient.post("Service/productfetch", {});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        listOfProduct(data["data"]);
        listOfProduct(listOfProduct.reversed.toList());
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

  addToCart(
      {required String outletId,
      required String prodId,
      required String qty}) async {
    try {
      isLoading(true);
      final response = await ApiClient.post("Service/addtocart", {
        'emp_id': AppStorage.getUserId(),
        'outlet_id': outletId,
        'product_id': prodId,
        'qty': qty,
      });
      if (response.statusCode == 200) {
        isLoading(false);
        getCartList();
      } else {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
    }
  }

  removeCart(String cartId) async {
    try {
      isLoading(true);
      final response =
          await ApiClient.post("Service/cartremove", {'cart_id': cartId});
      if (response.statusCode == 200) {
        isLoading(false);
        getCartList();
      } else {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
    }
  }

  getCartList() async {
    try {
      isLoading(true);
      final response = await ApiClient.post(
          "Service/return_request_list", {'emp_id': AppStorage.getUserId()});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        listOfCart(data["data"]);
        isLoading(false);
        Future.delayed(const Duration(milliseconds: 600), () {
          setState(() {});
        });
      } else {
        isLoading(false);
        listOfCart([]);
      }
    } catch (e) {
      isLoading(false);
      listOfCart([]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
    getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appthemColor,
        centerTitle: true,
        title: const Text('Return',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        )),
        leading: AppUtils.backButton(),
      ),
      body: Obx(
        () => Column(
          children: [
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(2),
                  hintText: 'Search Product',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            searchController.clear();
                            listOfSearch.clear();
                            setState(() {});
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : const SizedBox(),
                ),
                onChanged: (value) {
                  listOfSearch.clear();
                  for (var i = 0; i < listOfProduct.length; i++) {
                    if (listOfProduct[i]["name"]
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase())) {
                      listOfSearch.add(listOfProduct[i]);
                    }
                  }
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 4),
            isLoading.value
                // ? const LinearProgressIndicator(valueColor: AlwaysStoppedAnimation(appthemColor), backgroundColor: Colors.white)
                ? SizedBox.shrink()
                : !isLoading.value && listOfProduct.isEmpty
                    ? const Center(child: Text('No Product Found'))
                    : const SizedBox(),
            if (listOfProduct.isNotEmpty ||
                listOfSearch.isNotEmpty && !isLoading.value)
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 120),
                  itemCount: listOfSearch.isNotEmpty
                      ? listOfSearch.length
                      : listOfProduct.length,
                  itemBuilder: (context, index) {
                    final product = listOfSearch.isNotEmpty
                        ? listOfSearch[index]
                        : listOfProduct[index];
                    bool isAdd = listOfCart.any(
                        (element) => element["product_id"] == product["id"]);

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 100,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.network(
                                        staticData.baseMenuUrl +
                                            product["image"].split(",").first,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Image.asset(
                                              "assets/logo.png",
                                              color: Colors.grey.shade300,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(product["name"],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        const Text("Net Weight : NA",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14)),
                                        Divider(
                                          height: 5,
                                          color: Colors.black.withOpacity(.05),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text('MRP ',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14)),
                                                  Text(product["special_price"],
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  const Text('Rate ',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14)),
                                                  Text(product["price"],
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  const Text('stock ',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14)),
                                                  //margin in percentage
                                                  Text(product["stock"] ?? "0",
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Row(
                              children: [
                                if (product["stock"] == "0" &&
                                    product["stock"] == null)
                                  const Spacer(),
                                product["stock"] != "0" &&
                                        product["stock"] != null
                                    ? const SizedBox.shrink()
                                    : Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Text('Stock out',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ),
                                if (product["stock"] != "0" &&
                                    product["stock"] != null)
                                  const Spacer(),
                                if (product["stock"] != "0" &&
                                    product["stock"] != null)
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: appthemColor),
                                    ),
                                    child: Row(
                                      children: [
                                        //add and remove button with count
                                        GestureDetector(
                                          onTap: () {
                                            if (isAdd) {
                                              removeCart(listOfCart.firstWhere(
                                                  (element) =>
                                                      element["product_id"] ==
                                                      product["id"])["id"]);
                                            }
                                          },
                                          child: SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: Icon(Icons.delete,
                                                color: isAdd
                                                    ? appthemColor
                                                    : Colors.black45,
                                                size: 20),
                                          ),
                                        ),
                                        //divider container
                                        Container(
                                          height: 30,
                                          width: 1,
                                          color: appthemColor,
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                            isAdd
                                                ? listOfCart
                                                    .firstWhere((element) =>
                                                        element["product_id"] ==
                                                        product["id"])["qty"]
                                                    .toString()
                                                : "0",
                                            style: TextStyle(
                                                color: isAdd
                                                    ? appthemColor
                                                    : Colors.black45,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(width: 15),
                                        Container(
                                          height: 30,
                                          width: 1,
                                          color: appthemColor,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (isAdd) {
                                              int qty = int.parse(listOfCart
                                                  .firstWhere((element) =>
                                                      element["product_id"] ==
                                                      product["id"])["qty"]);
                                              addToCart(
                                                  outletId: widget.outletId,
                                                  prodId: product["id"],
                                                  qty: (qty + 1).toString());
                                            } else {
                                              addToCart(
                                                  outletId: widget.outletId,
                                                  prodId: product["id"],
                                                  qty: "1");
                                            }
                                          },
                                          child: const SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: Icon(Icons.add,
                                                color: appthemColor, size: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          // Get.to(() => const ReviewOrderScreen(
          //       outletId: "",
          //     ));
        },
        child: Theme(
          data: ThemeData(
              bottomSheetTheme:
                  const BottomSheetThemeData(backgroundColor: Colors.white)),
          child: Material(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 50,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: appthemColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      //0 item | 0 Qty
                      Text(
                          listOfCart.isNotEmpty
                              ? "${listOfCart.length} item | ${listOfCart.map((e) => e["qty"]).reduce((value, element) => int.parse(value) + int.parse(element)).toString()}"
                              : "0 item | 0 Qty",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),

                      const Spacer(),
                      const Text('View Cart',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      10.widthBox,
                      const Icon(Icons.shopping_cart_rounded,
                          color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
