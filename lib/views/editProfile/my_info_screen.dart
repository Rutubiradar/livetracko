import 'dart:convert';

import 'package:cws_app/util/app_storage.dart';
import 'package:cws_app/views/editProfile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../helper/app_static.dart';
import '../../network/api_client.dart';
import '../../util/constant.dart';
import '../../widgets/constant.dart';

class MyInfoScreen extends StatefulWidget {
  MyInfoScreen({super.key});

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  RxString registerOutlet = "0".obs;

  RxString totalVisitOutlet = "0".obs;

  RxString shopClosed = "0".obs;

  RxString alreadyHaveStock = "0".obs;

  RxString generalVisit = "0".obs;

  RxString orderBooking = "0".obs;

  RxString paymentCollection = "0".obs;

  RxString productPromotion = "0".obs;

  RxString others = "0".obs;

  Future<void> getOutletData() async {
    var userId = AppStorage.getUserId();
    var body = {"emp_id": userId};

    var response = await ApiClient.post('Common/eod', body);

    if (response.statusCode == 200) {
      var data = response.body;
      var outletData = jsonDecode(data);
      registerOutlet(
          outletData["register_outlet_count"]['total_outlet'].toString());
      totalVisitOutlet(outletData["visited_outlet"]['visit_outlet'].toString());
      shopClosed(outletData["shop_closed_count"]['shop_closed'].toString());
      alreadyHaveStock(outletData["have_stock_count"]['have_stock'].toString());
      generalVisit(
          outletData["general_visit_count"]['general_visit'].toString());
      orderBooking(
          outletData["order_booking_count"]['order_booking'].toString());
      paymentCollection(outletData["payment_collection_count"]
              ['payment_collection']
          .toString());
      productPromotion(outletData["product_promotion_count"]
              ['product_promotion']
          .toString());
      others(outletData["others_count"]['others_count'].toString());
    } else {
      Get.snackbar("Error", "Failed to load data");
    }
  }

  @override
  void initState() {
    super.initState();
    getOutletData();
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = AppStorage.getUserDetails();
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(staticData.profileUrl +
                          userProfile.profileImage.toString()),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  child: IconButton(
                    icon: const Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Edit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Get.to(() => const EditProfile());
                    },
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Text(
                      userProfile.name.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      // color: Colors.grey.shade200,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        // borderRadius: BorderRadius.circular(50),
                      ),
                      child: TabBar(
                        tabAlignment: TabAlignment.center,
                        indicatorColor: appthemColor,
                        isScrollable: true,
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Colors.white,
                        labelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: appthemColor,
                            border: Border.all(color: appthemColor, width: 2)),
                        tabs: [
                          Tab(
                            child: Container(
                              // color: Colors.pink,
                              // width: double.maxFinite,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40.0, vertical: 4),
                                  child: Text("INFO"),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              // color: Colors.pink,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 4.0),
                                  child: Text("END OF DAY"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const InfoScreen(),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Today's Activity",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text("Register Outlet"),
                                const Spacer(),
                                Text(registerOutlet.value),
                              ],
                            ),
                            Divider(color: Colors.black12, height: 25),
                            Row(
                              children: [
                                const Text("Total Visit Outlet"),
                                const Spacer(),
                                Text(totalVisitOutlet.value),
                              ],
                            ),
                            Divider(color: Colors.black12, height: 25),
                            Row(
                              children: [
                                const Text("Shop closed"),
                                const Spacer(),
                                Text(shopClosed.value),
                              ],
                            ),
                            Divider(color: Colors.black12, height: 25),
                            Row(
                              children: [
                                const Text("Already have stock"),
                                const Spacer(),
                                Text(alreadyHaveStock.value),
                              ],
                            ),
                            Divider(color: Colors.black12, height: 25),
                            Row(
                              children: [
                                const Text("General visit"),
                                const Spacer(),
                                Text(generalVisit.value),
                              ],
                            ),
                            Divider(color: Colors.black12, height: 25),
                            Row(
                              children: [
                                const Text("Order Booking"),
                                const Spacer(),
                                Text(orderBooking.value),
                              ],
                            ),
                            Divider(color: Colors.black12, height: 25),
                            Row(
                              children: [
                                const Text("Payment collection"),
                                const Spacer(),
                                Text(paymentCollection.value),
                              ],
                            ),
                            Divider(color: Colors.black12, height: 25),
                            Row(
                              children: [
                                const Text("Product promotion"),
                                const Spacer(),
                                Text(productPromotion.value),
                              ],
                            ),
                            Divider(color: Colors.black12, height: 25),
                            Row(
                              children: [
                                const Text("Others"),
                                const Spacer(),
                                Text(others.value),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TransactionMyInfoScreen extends StatelessWidget {
  const TransactionMyInfoScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      padding: const EdgeInsets.all(8),
      itemCount: 5,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
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
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text("Invoice No : 123456",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade700.withOpacity(.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Completed',
                          style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.person_outline_rounded, size: 20),
                      SizedBox(width: 5),
                      Text("Kirana Store",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      Spacer(),
                      Text("₹ 5000",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.black54,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      const Text("May 20, 2024 10:20",
                          style:
                              TextStyle(color: Colors.black54, fontSize: 14)),
                      const Spacer(),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red.shade700),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text("₹ 5000 Due",
                              style: TextStyle(
                                  color: Colors.red.shade700, fontSize: 16))),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(color: Colors.black12),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Spacer(),
                      const Icon(Icons.print_rounded,
                          color: Colors.green, size: 20),
                      const SizedBox(width: 5),
                      const Text("Print",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      20.widthBox,
                      const Icon(Icons.share, color: Colors.green, size: 20),
                      const SizedBox(width: 5),
                      const Text("Share",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class InfoScreen extends StatelessWidget {
  const InfoScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProfile = AppStorage.getUserDetails();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Today Working Status',
                      style: TextStyle(color: Colors.grey.shade500)),
                  const Spacer(),
                  const Text('Official Working Day'),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Status', style: TextStyle(color: Colors.grey.shade500)),
                  const Spacer(),
                  const Text('Attendance Not Marked'),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Log Date and Time',
                      style: TextStyle(color: Colors.grey.shade500)),
                  const Spacer(),
                  const Text('NA'),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('Address', style: TextStyle(color: Colors.grey.shade500)),
                const Spacer(),
                HtmlWidget(userProfile.address.toString(),
                    textStyle: TextStyle(fontSize: 14)),
              ]),
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('Email Id', style: TextStyle(color: Colors.grey.shade500)),
                const Spacer(),
                Text(userProfile.email.toString()),
              ]),
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('Phone Number',
                    style: TextStyle(color: Colors.grey.shade500)),
                const Spacer(),
                Text(userProfile.mobile.toString()),
              ]),
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('Date of Birth',
                    style: TextStyle(color: Colors.grey.shade500)),
                const Spacer(),
                Text(userProfile.dob.toString()),
              ]),
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('Date of joining',
                    style: TextStyle(color: Colors.grey.shade500)),
                const Spacer(),
                Text(userProfile.doj.toString()),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
