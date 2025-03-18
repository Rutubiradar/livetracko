import 'dart:convert';

import 'package:cws_app/network/api_client.dart';
import 'package:cws_app/util/app_storage.dart';
import 'package:cws_app/widgets/no_content_widget.dart';
import 'package:floating_tabbar/Widgets/airoll.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

import '../../util/app_utils.dart';
import '../../widgets/constant.dart';
import '../outlets/transaction_detail_screen.dart';
import '../receipt/order_receipt.dart';

class TransactionScreen extends StatefulWidget {
  final bool allTransaction;
  final String outletId;

  const TransactionScreen(
      {super.key, required this.allTransaction, required this.outletId});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  RxList<dynamic> orderList = <dynamic>[].obs;
  RxString searchValue = ''.obs;
  late Future<List<dynamic>> _transactionFuture;

  @override
  void initState() {
    super.initState();
    _transactionFuture = getTransaction();
  }

  Future<List<dynamic>> getTransaction() async {
    var userId = AppStorage.getUserId();

    print("User ID: ${widget.outletId}");

    var response = widget.allTransaction
        ? await ApiClient.post("Common/order_list", {
            "emp_id": userId,
          })
        : await ApiClient.post("Common/outlet_orders_list", {
            "emp_id": userId,
            "outlet_id": widget.outletId,
          });

    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      orderList.clear();

      if (searchValue.value.isNotEmpty) {
        print('searched ${searchValue.value}');
        orderList.value = widget.allTransaction
            ? data['order_list']
                .where((element) =>
                    element['order_no']
                        .toString()
                        .toLowerCase()
                        .contains(searchValue.value.toLowerCase()) ||
                    element['business_name']
                        .toString()
                        .toLowerCase()
                        .isCaseInsensitiveContainsAny(
                            searchValue.value.toLowerCase()))
                .toList()
            : data['outlet_order_list']
                .where((element) =>
                    element['order_no']
                        .toString()
                        .toLowerCase()
                        .contains(searchValue.value.toLowerCase()) ||
                    element['business_name']
                        .toString()
                        .toLowerCase()
                        .contains(searchValue.value.toLowerCase()))
                .toList();
      } else {
        orderList.value = widget.allTransaction
            ? data['order_list']
            : data['outlet_order_list'];
      }
    }

    return orderList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appthemColor,
        title: const Text('Transaction',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        leading: AppUtils.backButton(),
      ),
      body: Column(
        children: [
          SizedBox(height: 3),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(2),
                hintText: 'Search Transaction',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                searchValue.value = value;
                setState(() {
                  _transactionFuture = getTransaction();
                });
              },
            ),
          ),
          SizedBox(height: 4),
          // Additional UI elements...
          Expanded(
              child: FutureBuilder(
            future: _transactionFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: NoContentScreen(
                    message: 'No Transactions',
                  ),
                );
              }

              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 20),
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => TransactionDetailScreen(
                            orderId: snapshot.data![index]['order_id'],
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ],
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("${snapshot.data![index]["order_no"]}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.person_outline_rounded, size: 20),
                                SizedBox(width: 5),
                                Text(
                                    snapshot.data![index]['business_name'] ??
                                        "Name",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                Spacer(),
                                Text("₹ ${snapshot.data![index]['amount']}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_rounded,
                                  color: Colors.black54,
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                    DateFormat('dd-MM-yyyy HH:mm').format(
                                        DateTime.parse(snapshot.data![index]
                                            ['order_date'])),
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14)),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(color: Colors.black12),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => ReceiptScreen());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.green, width: 2),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 2.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.print_rounded,
                                              color: Colors.green, size: 20),
                                          SizedBox(width: 5),
                                          Text("Print",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                20.widthBox,
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => ReceiptScreen(
                                          isShare: true,
                                        ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blue, width: 2),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 2.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.share_rounded,
                                              color: Colors.blue, size: 20),
                                          SizedBox(width: 5),
                                          Text("Share",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )),
        ],
      ),
    );
  }
}
