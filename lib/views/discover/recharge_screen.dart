import 'package:cws_app/views/payment/payment_screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class RechargeScreen extends StatelessWidget {
  const RechargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listOfWidget = [
      "Scan any QR",
      "Rest OTP",
      "Bank Transfer",
      "Pay Bills",
      "Electricity",
      "Credit Card bills",
      "My Wallet",
      "DTH / Cables Tv",
      "Mobile Recharge",
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            10.heightBox,
            Row(children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 26,
                  )),
              Container(
                height: 5.4.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: const Color(0xffE3E6EF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Colors.grey,
                    ),
                    hintText: 'Search products',
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 12.sp, color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18),
                                ),
                                child: Image.asset(
                                  index == 8
                                      ? "lib/assets/eae.png"
                                      : index == 6
                                          ? "lib/assets/ease.png"
                                          : index == 5
                                              ? "lib/assets/unnamed (e6).png"
                                              : index == 4
                                                  ? "assets/r.png"
                                                  : index == 1
                                                      ? "assets/y.png"
                                                      : index == 3
                                                          ? "assets/w.png"
                                                          : index == 0
                                                              ? "assets/u.png"
                                                              : index == 2
                                                                  ? "lib/assets/bank.png"
                                                                  : "lib/assets/res.png",
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Text(
                              listOfWidget[index],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.black),
                            ).p4()
                          ],
                        ),
                      ).onTap(() {
                        if (index == 6) {
                          Get.to(() => Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  leading: IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                body: Image.asset("assets/Group 9768.png"),
                              ));
                        } else if (index == 0) {
                          Get.to(() => Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  title: const Text(
                                    "Scan QR Code",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  leading: IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                body: Image.asset("assets/download (9).png")
                                    .onTap(() {
                                  Get.to(() => Scaffold(
                                        appBar: AppBar(
                                          backgroundColor: Colors.white,
                                          elevation: 0,
                                          title: const Text(
                                            "Pay with QR Code",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          leading: IconButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            icon: const Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        body: Image.asset(
                                            "assets/download (10).png"),
                                      ));
                                }),
                              ));
                        } else {
                          Get.to(() => CheckoutScreen());
                        }
                      });
                    }),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.timer_rounded,
                color: Colors.black54,
              ),
              title: Text(
                "Show Transactions History",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black54,
              ),
            ).box.border().withRounded().make().pSymmetric(
                  h: 10,
                ),
            10.heightBox,
            const ListTile(
              leading: Icon(
                Icons.balance,
                color: Colors.black54,
              ),
              title: Text(
                "Check Balance",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black54,
              ),
            ).box.border().withRounded().make().pSymmetric(
                  h: 10,
                ),
            40.heightBox,
          ],
        ),
      ),
    );
  }
}
