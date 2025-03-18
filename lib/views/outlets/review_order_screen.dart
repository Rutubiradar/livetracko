import 'dart:convert';
import 'dart:developer';

import 'package:cws_app/util/app_utils.dart';
import 'package:cws_app/views/main_screen/main_screen.dart';
import 'package:cws_app/views/receipt/order_receipt.dart';
import 'package:floating_tabbar/Widgets/airoll.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Controller/new_sale_controller.dart';
import '../../network/api_client.dart';
import '../../util/app_storage.dart';
import '../../widgets/constant.dart';
import 'transaction_detail_screen.dart';

class ReviewOrderScreen extends StatefulWidget {
  const ReviewOrderScreen({super.key, required this.outletId});
  final String outletId;

  @override
  State<ReviewOrderScreen> createState() => _ReviewOrderScreenState();
}

class _ReviewOrderScreenState extends State<ReviewOrderScreen> {
  final CartController cartController = Get.find();
  String orderId = '';

  var listOfCart = [].obs;
  var isLoading = true.obs;

  double totalAmount() {
    double total = 0;
    for (var item in listOfCart) {
      total +=
          double.parse(item["new_price"] ?? "0") * double.parse(item["qty"]);
    }
    return total;
  }

  double amountQty(item) {
    //qty multiply with price
    double total = 0;

    total += double.parse(item["new_price"]) * double.parse(item["qty"]);

    return total;
  }

  checkOut() async {
    try {
      isLoading(true);
      final response = await ApiClient.post("Service/checkoutorder", {
        'emp_id': AppStorage.getUserId(),
        'outlet_id': widget.outletId,
      });
      print('response: ${response.body}');
      if (response.statusCode == 200) {
        isLoading(false);
        cartController.cartItems.clear();
        // orderId =
        print("order id is ${jsonDecode(response.body)['order_id']}");
        print("showing dialogue box");
        orderId = jsonDecode(response.body)['order_id'].toString();

        print("showing dialogue box");

        await showDialogue();
        print("dialogue box closing");
      } else {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
    }
  }

  Future<void> showDialogue() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset("assets/Animations/success.json",
                  repeat: false, height: 100, width: 100),
              Text("Sales invoice created successfully.",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Divider(color: Colors.black12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => ReceiptScreen());
                      },
                      child: Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.print, color: appthemColor),
                            SizedBox(height: 10),
                            const Text("Print"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.black12,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => TransactionDetailScreen(
                              orderId: orderId,
                            ));
                        print(orderId);
                        print('transation tapped');
                      },
                      child: Container(
                        width: double.infinity,
                        color: Colors
                            .transparent, // Make entire container tappable
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_red_eye, color: appthemColor),
                            SizedBox(height: 10),
                            const Text("View"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    ).then((value) => Get.offAll(() => MainScreen()));
  }

  getCartList() async {
    isLoading(true);
    try {
      final response = await ApiClient.post("Service/getcartbyoutlet", {
        'emp_id': AppStorage.getUserId(),
        'outlet_id': widget.outletId,
      });
      print('outlet id ${widget.outletId}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        listOfCart(data["data"]);
        log('listOfCart: $listOfCart');
        for (var item in listOfCart) {
          final productId = item["product_id"];
          cartController.modifyQty(int.parse(item['qty']), productId);
        }
        isLoading(false);
        // Future.delayed(const Duration(milliseconds: 600), () {
        //   setState(() {});
        // });
      } else {
        isLoading(false);
        listOfCart([]);
      }
    } catch (e) {
      isLoading(false);
      listOfCart([]);
    }
  }

  addToCart(String productId, String outletId) async {
    var userId = AppStorage.getUserId();
    var body = {
      'emp_id': userId,
      'outlet_id': outletId,
      'product_id': productId,
      'new_price': cartController.getPrice(productId),
      'qty': cartController.getQuantity(productId).toString(),
    };

    try {
      final response = await ApiClient.post("Service/addtocart", body);

      print('response: ${response.body}');
      setState(() {
        getCartList();
      });

      if (response.statusCode != 200) {
        throw Exception('Failed to update cart');
      }
    } catch (e) {
      isLoading(false);
      print('error: $e');
      listOfCart([]);
    }
  }

  removeFromCart(String cartId) async {
    var body = {
      'cart_id': cartId,
    };

    try {
      final response = await ApiClient.post("Service/cartremove", body);

      print(' cart delete response: ${response.body}');
      setState(() {
        getCartList();
      });

      if (response.statusCode != 200) {
        throw Exception('Failed to update cart');
      }
    } catch (e) {
      isLoading(false);
      print('error: $e');
      listOfCart([]);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 600), () async {
      await getCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          listOfCart.clear();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: appthemColor,
            centerTitle: true,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Review Order',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Obx(
                  () => Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.shopping_bag,
                              color: Colors.yellow, size: 18),
                        ),
                        TextSpan(
                          text: " ${cartController.totalItems} ",
                          style: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: "item ",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "| ",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(Icons.shopping_cart,
                              color: Colors.yellow, size: 18),
                        ),
                        TextSpan(
                          text: " ${cartController.totalQuantity} ",
                          style: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: "qty",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            )),
            leading: AppUtils.backButton(),
          ),
          body: Obx(
            () => Column(
              children: [
                // isLoading.value
                //     ? LinearProgressIndicator(color: appthemColor)
                //     : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Items",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.67,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          shrinkWrap: true,
                          itemCount: listOfCart.length,
                          itemBuilder: (context, index) {
                            final item = listOfCart[index];

                            final productId = item["product_id"];

                            return Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item["name"],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16)),
                                          Text("₹ ${item["new_price"]}/pcs",
                                              style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16)),
                                        ],
                                      ),
                                      const Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: cartController.getQuantity(
                                                          productId) ==
                                                      0
                                                  ? null
                                                  : () {
                                                      print(
                                                          'cart id is --------->>>${item['id']}');
                                                      cartController
                                                          .removeFromCart(
                                                              productId);
                                                      if (cartController
                                                                  .getQuantity(
                                                                      productId) +
                                                              1 ==
                                                          1) {
                                                        removeFromCart(
                                                            item['id']);
                                                      } else {
                                                        addToCart(productId,
                                                            item['outlet_id']);
                                                      }
                                                    },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(0, 3),
                                                      )
                                                    ]),
                                                child: CircleAvatar(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: Colors
                                                            .grey.shade100),
                                                    height: 40,
                                                    width: 40,
                                                    child: Obx(() {
                                                      int qty = cartController
                                                          .getQuantity(
                                                              productId);
                                                      return Icon(
                                                        qty == 1
                                                            ? Icons.delete
                                                            : Icons.remove,
                                                        color: qty > 0
                                                            ? appthemColor
                                                            : Colors.black45,
                                                        size: 25,
                                                      );
                                                    }),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Container(
                                            //   height: 40,
                                            //   width: 2,
                                            //   color: appthemColor,
                                            // ),
                                            // const SizedBox(width: 15),
                                            Container(
                                              height: 40,
                                              width: 60,
                                              decoration: BoxDecoration(),
                                              child: Center(
                                                child: Obx(() {
                                                  int qty = cartController
                                                      .getQuantity(productId);
                                                  return Text(
                                                    "$qty",
                                                    style: TextStyle(
                                                      color: qty > 0
                                                          ? appthemColor
                                                          : Colors.black45,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                            // const SizedBox(width: 15),
                                            // Container(
                                            //   height: 40,
                                            //   width: 2,
                                            //   color: appthemColor,
                                            // ),
                                            GestureDetector(
                                              onTap: () async {
                                                print('productId: $productId');
                                                cartController
                                                    .addToCart(productId);
                                                print(
                                                    "cartController.getQuantity(productId): ${cartController.getQuantity(productId)}");
                                                await addToCart(productId,
                                                    item['outlet_id']);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(0, 3),
                                                      )
                                                    ]),
                                                child: CircleAvatar(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color:
                                                          Colors.grey.shade100,
                                                    ),
                                                    height: 40,
                                                    width: 40,
                                                    child: Icon(Icons.add,
                                                        color: appthemColor,
                                                        size: 25),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("₹ ${amountQty(item)}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Obx(
            () => SizedBox(
              height: 70,
              width: double.maxFinite,
              child: Material(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Total Amount",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              Text("₹ ${totalAmount()}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Obx(
                        () => GestureDetector(
                          onTap: isLoading.value ||
                                  cartController.cartItems.isEmpty
                              ? null
                              : () {
                                  if (isLoading.value == false) {
                                    if (cartController.cartItems.isEmpty ||
                                        cartController.cartItems.length == 0) {
                                      AppUtils.snackBar("Cart is empty");
                                      return;
                                    }
                                    checkOut();
                                  } else {
                                    AppUtils.snackBar("Please wait...");
                                  }
                                },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: isLoading.value ||
                                      cartController.cartItems.isEmpty
                                  ? Colors.grey
                                  : appthemColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 2),
                              child: Center(
                                child: Text(
                                  "Place Order",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

// const SizedBox(height: 20),
// Card(
// child: Padding(
// padding: const EdgeInsets.all(12.0),
// child: Column(
// children: [
// const Row(
// children: [
// Text(
// "Payment Details",
// style: TextStyle(
// fontSize: 18,
// fontWeight: FontWeight.bold,
// ),
// ),
// Spacer(),
// ],
// ),
// const SizedBox(height: 10),
// const Row(
// children: [
// Text("Tax Amount", style: TextStyle(color: Colors.black, fontSize: 16)),
// Spacer(),
// Text("₹ 500", style: TextStyle(color: Colors.black, fontSize: 16)),
// ],
// ),
// const SizedBox(height: 10),
// const Row(
// children: [
// Text("CGST", style: TextStyle(color: Colors.black, fontSize: 16)),
// Spacer(),
// Text("₹ 0", style: TextStyle(color: Colors.black, fontSize: 16)),
// ],
// ),
// const SizedBox(height: 10),
// const Row(
// children: [
// Text("SGST", style: TextStyle(color: Colors.black, fontSize: 16)),
// Spacer(),
// Text("₹ 0", style: TextStyle(color: Colors.black, fontSize: 16)),
// ],
// ),
// const SizedBox(height: 10),
// Row(
// children: [
// const Text("Discount", style: TextStyle(color: Colors.black, fontSize: 16)),
// const Spacer(),
// const Text("₹ ", style: TextStyle(color: Colors.black, fontSize: 16)),
// SizedBox(
// width: 50,
// height: 40,
// child: TextField(
// decoration: InputDecoration(
// hintText: '0',
// contentPadding: const EdgeInsets.symmetric(horizontal: 10),
// border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
// ),
// ),
// )
// ],
// ),
// const SizedBox(height: 10),
// const Row(
// children: [
// Text("Total", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
// Spacer(),
// Text("₹ 500", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
// ],
// ),
// const SizedBox(height: 10),
// ],
// ),
// ),
// ),
