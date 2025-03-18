import 'dart:convert';

import 'package:cws_app/widgets/no_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Controller/new_sale_controller.dart';
import '../../helper/app_static.dart';
import '../../network/api_client.dart';
import '../../util/app_storage.dart';
import '../../util/app_utils.dart';
import '../../util/constant.dart';
import '../../widgets/constant.dart';
import 'review_order_screen.dart';

class NewSalesScreen extends StatefulWidget {
  const NewSalesScreen({super.key, required this.outletId});
  final String outletId;

  @override
  State<NewSalesScreen> createState() => _NewSalesScreenState();
}

class _NewSalesScreenState extends State<NewSalesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var listOfProduct = [].obs;
  var listOfSearch = [].obs;
  var listOfCart = [].obs;

  var isLoading = false.obs;
  TextEditingController searchController = TextEditingController();

  final CartController cartController = Get.find();

  double getMargin(String mrp, String rate) {
    double mrpInt = double.parse(mrp);
    double rateInt = double.parse(rate);
    double margin = ((mrpInt - rateInt) / mrpInt * 100).toDouble();

    return margin;
  }

  getProducts() async {
    isLoading(true);
    listOfProduct([]);
    try {
      final response = await ApiClient.post("Service/productfetch", {});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Product Data: ${data["data"]}");
        listOfProduct(data["data"]);
        listOfProduct(listOfProduct.reversed.toList());
        for (var product in listOfProduct) {
          cartController.updatePrice(
              product['id'], double.parse(product['special_price']));
        }

        getCartList();
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

  getCartList() async {
    try {
      // isLoading(true);
      final response = await ApiClient.post("Service/getcartbyoutlet", {
        'emp_id': AppStorage.getUserId(),
        'outlet_id': widget.outletId,
      });
      print('cart response is ${response.statusCode}');
      if (response.statusCode == 200) {
        print('got status success');
        final data = jsonDecode(response.body);
        listOfCart(data["data"]);
        for (var item in listOfCart) {
          final productId = item["product_id"];
          print('product id is $productId');
          cartController.updatePrice(
              productId, double.parse(item['new_price'] ?? "0.0"));
          print('cart price modified');
          cartController.modifyQty(int.parse(item['qty']), productId);
          print('cart modified');
          print(
              'got cart items updating price $productId price is is ${item['new_price']}');
        }
        // isLoading(false);
        // Future.delayed(const Duration(milliseconds: 600), () {
        //   setState(() {});
        // });
      } else {
        print('error');
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
      // setState(() {
      getCartList();
      // });

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
    getProducts();
    // getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          cartController.clearCart();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appthemColor,
          centerTitle: true,
          title: const Text('New Sales',
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
                  ? Expanded(
                      child: SizedBox(
                        // height: MediaQuery.of(context).size.height * 0.5,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ListTile(
                                  tileColor: Colors.grey.shade100,
                                  title: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 40,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 20,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 150,
                                      width: 90,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : !isLoading.value && listOfProduct.isEmpty
                      ? Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: NoContentScreen()))
                      : const SizedBox(),
              if (listOfProduct.isNotEmpty ||
                  listOfSearch.isNotEmpty && !isLoading.value)
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 120),
                    itemCount: listOfSearch.isNotEmpty
                        ? listOfSearch.length
                        : listOfProduct.length,
                    itemBuilder: (context, index) {
                      final productList = listOfSearch.isNotEmpty
                          ? listOfSearch
                          : listOfProduct;

                      // Separate products based on stock
                      List<dynamic> inStockProducts =
                          productList.where((product) {
                        int? stock = int.tryParse(product["stock"]);
                        return stock != null && stock > 0;
                      }).toList();

                      List<dynamic> outOfStockProducts =
                          productList.where((product) {
                        int? stock = int.tryParse(product["stock"]);
                        return stock != null && stock <= 0;
                      }).toList();

                      final combinedProductList = [
                        ...inStockProducts,
                        ...outOfStockProducts
                      ];

                      final product = combinedProductList[index];

                      final productId = product["id"];
                      // cartController.updatePrice(productId,
                      //     double.parse(product["special_price"] ?? '0.0'));

                      int? stock = int.tryParse(product["stock"]);
                      int stock2 = stock ?? 0;

                      return Container(
                        padding: const EdgeInsets.all(8),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.network(
                                          staticData.baseMenuUrl +
                                              product["image"].split(",").first,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                  'Margin : ${getMargin(product["price"], product["special_price"]).toStringAsFixed(1)}%',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 14))
                                            ],
                                          ),
                                          Divider(
                                            height: 5,
                                            color:
                                                Colors.black.withOpacity(.05),
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
                                                    Text(product["price"],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Obx(() => Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        showPriceUpdateDialog(
                                                            context,
                                                            productId,
                                                            cartController);
                                                      },
                                                      child: Column(
                                                        children: [
                                                          const Text('Rate ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14)),
                                                          Text(
                                                              cartController
                                                                  .getPrice(
                                                                      productId),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    const Text('stock ',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14)),
                                                    Text(
                                                        "${stock == null ? "0" : stock < 0 ? "0" : stock}",
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
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
                                  product["stock"] != "0" &&
                                          product["stock"] != null
                                      ? const SizedBox.shrink()
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 2),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Text('Stock out',
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                        ),
                                  const Spacer(),
                                  if (product["stock"] != "0" &&
                                      product["stock"] != null)
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              cartController
                                                  .removeFromCart(productId);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
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
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.2),
                                                          spreadRadius: 2,
                                                          blurRadius: 5,
                                                          offset: Offset(0, 3),
                                                        )
                                                      ],
                                                      color:
                                                          Colors.grey.shade100),
                                                  height: 40,
                                                  width: 40,
                                                  child: Obx(() {
                                                    int qty = cartController
                                                        .getQuantity(productId);
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
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: product["stock"] == "0" &&
                                                    product["stock"] == null
                                                ? null
                                                : () {
                                                    if (stock == null) {
                                                      return;
                                                    }
                                                    if (stock < 0) {
                                                      return;
                                                    }
                                                    if (stock2 >
                                                        cartController
                                                            .getQuantity(
                                                                productId)) {
                                                      cartController
                                                          .addToCart(productId);
                                                    } else {
                                                      AppUtils.warningDialogue(
                                                          "Order limit exceed");
                                                    }
                                                  },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
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
                                                    color: Colors.grey.shade100,
                                                  ),
                                                  height: 40,
                                                  width: 40,
                                                  child: Icon(Icons.add,
                                                      color: stock2 < 0
                                                          ? Colors.grey
                                                          : appthemColor,
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
          onTap: () async {
            if (cartController.cartItems.isEmpty) {
              AppUtils.snackBar("Please add some product to cart");
              return;
            }

            await updateCartOnServer();
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
                        Obx(() {
                          return Text(
                            "${cartController.totalItems} item | ${cartController.totalQuantity} Qty",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
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
      ),
    );
  }

  Future<void> updateCartOnServer() async {
    final cartItems = cartController.cartItems;

    try {
      AppUtils.showLoader();
      for (var entry in cartItems.entries) {
        final response = await ApiClient.post("Service/addtocart", {
          'emp_id': AppStorage.getUserId(),
          'outlet_id': widget.outletId,
          'product_id': entry.key,
          'new_price': cartController.getPrice(entry.key),
          'qty': entry.value.toString(),
        });

        print("${AppStorage.getUserId()} && outlet id is ${widget.outletId}");

        print("respnce is --------->${response.body}");
        if (response.statusCode != 200) {
          AppUtils.snackBar("Failed to update cart");
          throw Exception('Failed to update cart');
        }
      }
      AppUtils.hideLoader();
      Get.to(() => ReviewOrderScreen(outletId: widget.outletId));
      cartController.clearCart();
      // Navigator.pop(context);
    } catch (e) {
      AppUtils.hideLoader();

      AppUtils.snackBar("Failed to update cart: ${e.toString()}");
    }
  }

  void showPriceUpdateDialog(
      BuildContext context, String productId, CartController cartController) {
    double? newPrice;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Price for Product'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                newPrice = double.tryParse(value);
              },
              decoration: InputDecoration(
                labelText: 'New Price',
                hintText: 'Enter new price',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter price';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (newPrice != null) {
                    cartController.updatePrice(productId, newPrice!);

                    Navigator.of(context).pop();
                  } else {
                    // Optionally, show an error message if the input is invalid
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please enter a valid price'),
                    ));
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
