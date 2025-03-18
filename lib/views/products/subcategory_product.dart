import 'package:cws_app/widgets/no_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../helper/app_static.dart';
import '../../util/app_utils.dart';
import '../../util/constant.dart';
import '../../widgets/constant.dart';

class SubcategoryProducts extends StatefulWidget {
  const SubcategoryProducts({super.key, required this.listOfProducts});
  final List listOfProducts;

  @override
  State<SubcategoryProducts> createState() => _SubcategoryProductsState();
}

class _SubcategoryProductsState extends State<SubcategoryProducts> {
  RxList<dynamic> listOfProduct = <dynamic>[].obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listOfProduct(widget.listOfProducts);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: appthemColor,
        centerTitle: true,
        title: const Text('All Products',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        )),
        leading: AppUtils.backButton(),
      ),
      body: Column(
        children: [
          Expanded(
            child: listOfProduct.isEmpty
                ? NoContentScreen(
                    message: 'No Products Available',
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 120),
                    itemCount: listOfProduct.length,
                    itemBuilder: (context, index) {
                      // final product = listOfSearch.isNotEmpty
                      //     ? listOfSearch[index]
                      //     : listOfProduct[index];
                      // final productId = product["id"];

                      // int? stock = int.tryParse(product["stock"]);
                      // int stock2 = stock ?? 0;
                      final productList = listOfProduct;

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

                      // Combine in-stock and out-of-stock products
                      final combinedProductList = [
                        ...inStockProducts,
                        ...outOfStockProducts
                      ];

                      final product = combinedProductList[index];

                      final productId = product["id"];

                      int? stock = int.tryParse(product["stock"]);
                      int stock2 = stock ?? 0;

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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Text(
                                              //     'Margin : ${getMargin(product["price"], product["special_price"]).toStringAsFixed(1)}%',
                                              //     style: TextStyle(
                                              //         color: Colors.green,
                                              //         fontSize: 14))
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
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    const Text('Rate ',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14)),
                                                    Text(
                                                        product[
                                                            "special_price"],
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
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    const Text('stock ',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14)),
                                                    //margin in percentage
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
                            const SizedBox(height: 15),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    ));
  }
}
