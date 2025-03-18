import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:cws_app/views/check_out_screens/check_out_address.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../util/app_utils.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: New_Bottom_Navigation_Bar(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: AppUtils.backButton(),
        title: Text(
          'Shopping Cart',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 19),
        ),
        actions: [
          "Delete".text.black.bold.make().pOnly(top: 20, right: 10),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                height: 45.h,
                child: ListView.builder(
                  itemCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        width: 100.w,
                        height: 13.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 28.w,
                              decoration: BoxDecoration(
                                // border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.asset(
                                'assets/Grocery-Transparent-Background (1) 1 (1).png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            2.w.widthBox,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // 1.h.heightBox,
                                Text(
                                  'Grocery',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.sp),
                                ),
                                1.h.heightBox,
                                Text(
                                  '₹565.0',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.sp),
                                ),
                                // 0.5.h.heightBox,
                                Row(
                                  children: [
                                    const Text(""),
                                    30.w.widthBox,
                                    Container(
                                      height: 3.h,
                                      width: 19.w,
                                      decoration: BoxDecoration(
                                        color: appthemColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 17,
                                          ),
                                          Text(
                                            '1',
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                          ),
                                          const Icon(Icons.add,
                                              color: Colors.white, size: 17),
                                        ],
                                      ).p2(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ).p8(),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Totals',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 19),
                ),
              ).p16(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sub Total',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp),
                  ),
                  Text(
                    '   .......................................       ',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                  Text(
                    '₹699.00',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp),
                  ),
                ],
              ).pSymmetric(h: 4.w),
              1.h.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp),
                  ),
                  Text(
                    '   .................................       ',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp),
                  ),
                  Text(
                    '₹0',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp),
                  ),
                ],
              ).pSymmetric(h: 4.w),
              2.h.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio(
                    value: false,
                    groupValue: true,
                    onChanged: (v) {},
                  ),
                  "Do you want to subscribe for all this items.".text.make(),
                ],
              ).onTap(() {
                Get.bottomSheet(
                  Image.asset(
                    'assets/download (6).png',
                    fit: BoxFit.fitWidth,
                    width: 100.w,
                    height: 500,
                  ),
                );
              }),
              2.h.heightBox,
              "Or Select from the cart"
                  .text
                  .xl
                  .bold
                  .color(appthemColor)
                  .make()
                  .onTap(() {
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
                              size: 15,
                            )),
                        title: Text(
                          'Shopping Cart',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 19),
                        ),
                        centerTitle: true,
                      ),
                      body: Column(
                        children: [
                          Image.asset(
                            'assets/download (5).png',
                            fit: BoxFit.fitWidth,
                            width: 100.w,
                          ),
                          Expanded(
                            child: Image.asset(
                              'assets/download (4).png',
                              fit: BoxFit.fitWidth,
                              width: 100.w,
                            ).onTap(() {
                              Get.bottomSheet(
                                Image.asset(
                                  'assets/download (6).png',
                                  fit: BoxFit.fitWidth,
                                  width: 100.w,
                                  height: 500,
                                ).onTap(() {
                                  Get.back();
                                  Get.bottomSheet(Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/download (8).png',
                                      fit: BoxFit.fitWidth,
                                      width: 100.w,
                                      height: 500,
                                    ),
                                  ));
                                }),
                              );
                            }),
                          ),
                        ],
                      ),
                    ));
              }),
              2.h.heightBox,
              Container(
                height: 6.h,
                width: 92.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 5.h,
                      width: 49.w,
                      child: Center(
                        child: TextField(
                          textAlign: TextAlign.start,
                          //controller: someTextXontroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Enter Voucher Code',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.all(10),
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "APPLY",
                      style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ).px16(),
              ),
              4.h.heightBox,
              Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: Container(
                  height: 52,
                  width: 180,
                  decoration: BoxDecoration(
                    color: appthemColor,
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: 'CHECKOUT'
                      .text
                      .size(10.sp)
                      .letterSpacing(1.5)
                      .bold
                      .white
                      .make()
                      .centered(),
                ).onTap(() {
                  //_signupController.CheckSignup();
                  Get.to(() => CheckoutAddress());
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomePage()));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
