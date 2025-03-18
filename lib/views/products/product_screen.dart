import 'dart:convert';
import 'dart:developer';

import 'package:cws_app/util/constant.dart';
import 'package:cws_app/views/products/subcategory_product.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:cws_app/widgets/no_content_widget.dart';
import 'package:floating_tabbar/Widgets/airoll.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../network/api_client.dart';
import '../../../util/app_utils.dart';
import '../../helper/app_static.dart';

class ProductsScreen extends StatefulWidget {
  ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  var selectedCategory = {}.obs;
  bool isloading = false;
  var selectedSubCategory = {}.obs;

  var listOfSubCategory =
      {}.obs; // Changed to Map to store subcategories per category
  var listOfCategory = [].obs;
  var listOfProduct =
      {}.obs; // Changed to Map to store products per subcategory

  final List<Color> subCategoryColors = [
    Colors.greenAccent.shade100,
    Colors.blue.shade100,
    Colors.yellow.shade100,
    Colors.red.shade100,
    Colors.purple.shade100,
    Colors.orange.shade100,
  ];

  getCategoryList() async {
    setState(() {
      isloading = true;
    });
    listOfCategory([]);
    try {
      final response = await ApiClient.post("Common/category_list", {});
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        listOfCategory(data["data"]);
        print("category data loaded --------${data}");
        // Reversed the list and set isloading to false
        listOfCategory(listOfCategory.reversed.toList());

        // Fetch subcategories for each category
        for (var category in listOfCategory) {
          await getSubCategory(category['id']);
        }

        setState(() {
          isloading = false;
        });
      } else {
        listOfCategory.value = [];
        AppUtils.snackBar("${data['message']}");
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

  getSubCategory(String categoryId) async {
    listOfSubCategory[categoryId] = [];
    try {
      final response = await ApiClient.post(
          "Common/subcategory_list", {"category_id": categoryId});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        if ((data["data"]["subcategory"] as List).isNotEmpty) {
          selectedSubCategory(data["data"]["subcategory"][0]);
          listOfSubCategory[categoryId] = data["data"]["subcategory"];
          listOfProduct[categoryId] = data["data"]["product_list"];
        } else {
          listOfProduct[categoryId] = [];
        }
      } else {
        listOfSubCategory[categoryId] = [];
        listOfProduct[categoryId] = [];
        // AppUtils.snackBar("Failed to fetch subcategory");
      }
    } catch (e) {
      listOfSubCategory[categoryId] = [];
      listOfProduct[categoryId] = [];
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
      body: isloading
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 200,
                          child: Column(
                            children: [
                              Container(
                                height: 30,
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 100, // Specify a fixed height
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: 10,
                                  ),
                                  itemCount: 5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      itemCount: 10,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: listOfCategory.isEmpty
                      ? NoContentScreen()
                      : ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 0),
                          padding: const EdgeInsets.all(12),
                          itemCount: listOfCategory.length,
                          itemBuilder: (context, index) {
                            final category = listOfCategory[index];
                            final categoryId = category['id'];

                            return Container(
                              height: screenHeight * 0.245,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(category["name"],
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                  Obx(() {
                                    var subCategories =
                                        listOfSubCategory[categoryId] ?? [];
                                    return subCategories.isEmpty
                                        ? const Text("No Subcategories")
                                        : SizedBox(
                                            height: screenHeight * 0.17,
                                            child: ListView.separated(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: subCategories.length,
                                                itemBuilder:
                                                    (context, subIndex) {
                                                  final subCategory =
                                                      subCategories[subIndex];
                                                  final color =
                                                      subCategoryColors[
                                                          subIndex %
                                                              subCategoryColors
                                                                  .length];

                                                  return Container(
                                                    decoration: BoxDecoration(),
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    width: screenWidth * 0.28,
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.to(() =>
                                                                  SubcategoryProducts(
                                                                    listOfProducts:
                                                                        listOfProduct[categoryId] ??
                                                                            [],
                                                                  ));
                                                            },
                                                            child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              color),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  color: color,
                                                                ),
                                                                height:
                                                                    screenWidth *
                                                                        0.24,
                                                                width: 100,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child: Image.network(
                                                                      "${staticData.baseSubCategoryUrl}" +
                                                                          "${subCategory['image']}",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      errorBuilder: (BuildContext context,
                                                                          Object
                                                                              exception,
                                                                          StackTrace?
                                                                              stackTrace) {
                                                                    return Image
                                                                        .asset(
                                                                      "assets/burger_sub.png",
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    );
                                                                  }, loadingBuilder: (BuildContext context,
                                                                          Widget
                                                                              child,
                                                                          ImageChunkEvent?
                                                                              loadingProgress) {
                                                                    if (loadingProgress ==
                                                                        null) {
                                                                      return child;
                                                                    } else {
                                                                      return Center(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          value: loadingProgress.expectedTotalBytes != null
                                                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                                              : null,
                                                                        ),
                                                                      );
                                                                    }
                                                                  }),
                                                                )),
                                                          ),
                                                          Text(
                                                            subCategory['name'],
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, subIndex) =>
                                                        SizedBox(
                                                          width: 10,
                                                        )),
                                          );
                                  }),
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
