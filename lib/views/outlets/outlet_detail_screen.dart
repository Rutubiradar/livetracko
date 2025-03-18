import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cws_app/Controller/main_screen_controller.dart';
import 'package:cws_app/network/api_client.dart';
import 'package:cws_app/util/app_storage.dart';
import 'package:cws_app/views/outlets/payment_in_screen.dart';
import 'package:cws_app/views/outlets/return_screen.dart';
import 'package:cws_app/views/transaction/transaction_screeen.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

import '../../util/app_utils.dart';
import '../../widgets/constant.dart';
import '../map_history.dart';
import 'add_outlet.dart';
import 'mark_visit.dart';
import 'new_sales.dart';
import 'outlet_controller/pjp_outlet_controller.dart';

class OutletDetailsScreen extends StatefulWidget {
  const OutletDetailsScreen(
      {super.key, required this.outlet, this.checkVisit = true});
  final Map outlet;
  final bool checkVisit;

  @override
  State<OutletDetailsScreen> createState() => _OutletDetailsScreenState();
}

class _OutletDetailsScreenState extends State<OutletDetailsScreen> {
  RxBool isLoading = false.obs;

  Future<void> checkOut(String pjpId) async {
    var outletId = pjpId;
    isLoading.value = true;

    var body = {"pjpid": outletId, 'checkout_time': DateTime.now().toString()};

    print("body is $body");

    var response = await ApiClient.post("Common/outlet_checkout", body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      AppUtils.snackBar("Outlet checked out successfully",
          backgroundColor: Colors.green, textColor: Colors.black);
      print('data $data');
      Get.back();
    }
    isLoading.value = false;
  }

  final CheckInController checkInController = Get.put(CheckInController());

  @override
  void initState() {
    super.initState();
    if (widget.checkVisit) {
      checkInController.markVisitCheck(widget.outlet["id"]);
    }
    if (widget.checkVisit) {
      checkInController.checkIn(widget.outlet["id"]);
    } else {
      checkInController.manuallyCheckIn(widget.outlet['id']);
    }
    checkInController.startCheckInTimer(widget.checkVisit, widget.outlet["id"]);
    checkInController
        .getOutletSales(widget.outlet['outlet_id'] ?? widget.outlet['id']);
  }

  @override
  Widget build(BuildContext context) {
    print("visit status is ${widget.checkVisit}");
    return Scaffold(
      appBar: AppBar(
        leading: AppUtils.backButton(),
        backgroundColor: appthemColor,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.outlet["business_name"],
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Container(
            height: 90,
            decoration: const BoxDecoration(
                color: appthemColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              clipBehavior: Clip.none,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Text('₹ ${checkInController.totalSales.value} ',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                      )
                      // Text('NA', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(14),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                AppUtils.launchUrlFunction(
                                    'tel:${widget.outlet["mobile_number"]}');
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                color: Colors.white10,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.call_rounded,
                                        color: appthemColor, size: 28),
                                    Text('Call',
                                        style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
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
                                AppUtils.launchUrlFunction(
                                    'https://www.google.com/maps/search/?api=1&query=${widget.outlet["latitude"]},${widget.outlet["longitude"]}');
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                color: Colors.white10,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.location_on_rounded,
                                        color: appthemColor, size: 28),
                                    Text('Location',
                                        style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
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
                                Get.to(() => AddOutletScreen(
                                      isEdit: true,
                                      outlet: widget.outlet,
                                      isView: true,
                                    ));
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                color: Colors.white10,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.remove_red_eye,
                                        color: appthemColor, size: 28),
                                    Text('Patient Detail',
                                        style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
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
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text("Check In Time",
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                  const SizedBox(height: 5),
                  Obx(
                    () => Text("${checkInController.checkInTime.value}",
                        style: const TextStyle(
                            color: appthemColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                  Obx(
                    () => InkWell(
                      onTap: () async {
                        final bool? result = await Get.to(() => MarkVisitScreen(
                              outletId: widget.checkVisit
                                  ? widget.outlet["outlet_id"]
                                  : widget.outlet['id'],
                              pjpId: widget.outlet["id"],
                              manualVisit: widget.checkVisit ? false : true,
                            ));

                        if (result == true) {
                          if (widget.checkVisit) {
                            checkInController.checkIn(widget.outlet["id"]);
                          } else {
                            checkInController
                                .manuallyCheckIn(widget.outlet['id']);
                          }
                        } else {
                          if (widget.checkVisit) {
                            checkInController.checkIn(widget.outlet["id"]);
                          } else {
                            checkInController
                                .manuallyCheckIn(widget.outlet['id']);
                          }
                        }
                        if (widget.checkVisit) {
                          checkInController.checkIn(widget.outlet["id"]);
                        } else {
                          checkInController
                              .manuallyCheckIn(widget.outlet['id']);
                        }
                        if (widget.checkVisit) {
                          checkInController.markVisitCheck(widget.outlet["id"]);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: checkInController.isCheckIn.value
                              ? const Color(0xAA008001)
                              : appthemColor,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Center(
                            child: Text(
                                checkInController.isCheckIn.value
                                    ? "Checked in"
                                    : "  Check In",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(width: 1, height: 70, color: Colors.grey.shade200),
              Obx(
                () => Column(
                  children: [
                    const Text("Check Out Time",
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                    const SizedBox(height: 5),
                    Text(checkInController.checkOutTime.value.toString(),
                        style: TextStyle(
                            color: appthemColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    InkWell(
                      onTap: !checkInController.isCheckIn.value
                          ? null
                          : checkInController.isCheckOutDone.value
                              ? null
                              : () async {
                                  if (widget.checkVisit) {
                                    checkOut(widget.outlet["id"]);
                                  } else {
                                    checkOut(
                                        checkInController.pjpId.toString());
                                  }
                                },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: checkInController.isCheckOutDone.value
                              ? const Color(0xAA008001)
                              : checkInController.isCheckIn.value
                                  ? appthemColor
                                  : Colors.grey,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Obx(() => Center(
                              child: isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Text(
                                      checkInController.isCheckOutDone.value
                                          ? "Checked Out"
                                          : "Check Out",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                            )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          15.heightBox,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: GridView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  // crossAxisSpacing: ,
                  // mainAxisSpacing: 12,
                ),
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: checkInController.isMarkVisit.value
                          ? null
                          : () async {
                              final bool? result =
                                  await Get.to(() => MarkVisitScreen(
                                        outletId: widget.checkVisit
                                            ? widget.outlet["outlet_id"]
                                            : widget.outlet['id'],
                                        pjpId: widget.outlet["id"],
                                        manualVisit:
                                            widget.checkVisit ? false : true,
                                      ));

                              if (result == true) {
                                if (widget.checkVisit) {
                                  checkInController
                                      .checkIn(widget.outlet["id"]);
                                } else {
                                  checkInController
                                      .manuallyCheckIn(widget.outlet['id']);
                                }
                              } else {
                                if (widget.checkVisit) {
                                  checkInController
                                      .checkIn(widget.outlet["id"]);
                                } else {
                                  checkInController
                                      .manuallyCheckIn(widget.outlet['id']);
                                }
                              }
                              if (widget.checkVisit) {
                                checkInController.checkIn(widget.outlet["id"]);
                              } else {
                                checkInController
                                    .manuallyCheckIn(widget.outlet['id']);
                              }
                              if (widget.checkVisit) {
                                checkInController
                                    .markVisitCheck(widget.outlet["id"]);
                              }

                              final MainScreenController mainScreenController =
                                  Get.find();
                              mainScreenController.salesVisitCount();

                              mainScreenController.getDailySales();
                            },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.settings_accessibility_rounded,
                                size: 80,
                                color: checkInController.isMarkVisit.value
                                    ? Colors.green
                                    : appthemColor),
                            const SizedBox(height: 10),
                            const Text('Mark Visit',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 21)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Obx(
                  //   () => GestureDetector(
                  //     onTap: () {
                  //       if (checkInController.isShopClosed.value) {
                  //         AppUtils.snackBar("Shop is closed",
                  //             backgroundColor: Colors.grey,
                  //             textColor: Colors.black);
                  //         return;
                  //       } else if (checkInController.isCheckIn.value == false) {
                  //         AppUtils.snackBar("Please mark visit first",
                  //             backgroundColor: Colors.grey,
                  //             textColor: Colors.black);
                  //         return;
                  //       } else if (checkInController.isCheckOutDone.value) {
                  //         AppUtils.snackBar("This outlet is checked out",
                  //             backgroundColor: Colors.grey,
                  //             textColor: Colors.black);
                  //         return;
                  //       } else {
                  //         Get.to(() => NewSalesScreen(
                  //               outletId: widget.checkVisit
                  //                   ? widget.outlet["outlet_id"]
                  //                   : widget.outlet['id'],
                  //             ));
                  //       }
                  //     },
                  //     child: Card(
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Icon(Icons.assignment,
                  //               size: 50,
                  //               color: checkInController.isShopClosed.value ||
                  //                       checkInController.isCheckOutDone.value
                  //                   ? Colors.red
                  //                   : appthemColor),
                  //           const SizedBox(height: 10),
                  //           const Text('New Sale',
                  //               style: TextStyle(
                  //                   color: Colors.black, fontSize: 16)),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.to(() => TransactionScreen(
                  //           allTransaction: false,
                  //           outletId: widget.checkVisit
                  //               ? widget.outlet["outlet_id"]
                  //               : widget.outlet['id'],
                  //         ));
                  //   },
                  //   child: const Card(
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Icon(Icons.currency_rupee_outlined,
                  //             size: 50, color: appthemColor),
                  //         SizedBox(height: 10),
                  //         Text('Transactions',
                  //             style:
                  //                 TextStyle(color: Colors.black, fontSize: 16)),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.to(() => ReturnScreen(outletId: widget.outlet["id"]));
                  //   },
                  //   child: const Card(
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Icon(Icons.assignment_return_rounded,
                  //             size: 50, color: appthemColor),
                  //         SizedBox(height: 10),
                  //         Text('Return',
                  //             style:
                  //                 TextStyle(color: Colors.black, fontSize: 16)),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
