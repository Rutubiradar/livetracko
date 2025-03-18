import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:cws_app/views/edit_card/edit_cards.dart';
import 'package:cws_app/views/payment/payment_controller/payments_controller.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../util/app_utils.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({Key? key}) : super(key: key);

  final CheckOutController _checkOutController = Get.put(CheckOutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: AppUtils.backButton(),
        title: Text(
          'Manage Payment',
          style: GoogleFonts.poppins(
              color: appthemColor, fontWeight: FontWeight.w400, fontSize: 19),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Stack(children: [
        SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                2.h.heightBox,
                'Wallet'.text.black.size(12.sp).make().pSymmetric(v: 1.h),
                Container(
                  /*       height: 50.h,
                                width: 90.w,*/
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey)),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio(
                            value: PaymentMethod.paytm,
                            activeColor: appthemColor,
                            groupValue:
                                _checkOutController.selecthosOption.value,
                            onChanged: _checkOutController.onchaged,
                          ).pSymmetric(h: 5.w),
                          SizedBox(
                            width: 60.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    'Paytm'
                                        .text
                                        .semiBold
                                        .black
                                        .size(12.sp)
                                        .make(),
                                    Image.asset(
                                      'lib/assets/asset/paytm.png',
                                      height: 4.h,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ],
                                ).pOnly(bottom: 0.h),
                                // 'Pay with paytm wallet or UPI on '
                                //     'JadiButi for  ₹899 or more and get '
                                //     '5000 cash back '
                                //     'points,offer ends 5th november'.text.size(8.sp).color(Color(0xFFB73535)).overflow(TextOverflow.clip).make()
                              ],
                            ),
                          )
                        ],
                      ).pSymmetric(h: 2.w, v: 1.h),
                      Divider(
                        thickness: 1,
                        height: 1.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio(
                            value: PaymentMethod.mobikwik,
                            activeColor: appthemColor,
                            groupValue:
                                _checkOutController.selecthosOption.value,
                            onChanged: _checkOutController.onchaged,
                          ).pSymmetric(h: 5.w),
                          SizedBox(
                            width: 60.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    'Mobiwik'
                                        .text
                                        .black
                                        .semiBold
                                        .size(12.sp)
                                        .make(),
                                    Image.asset(
                                      'lib/assets/asset/mobikye.png',
                                      height: 4.h,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ],
                                ).pOnly(bottom: 0.h),
                                //'Pay with Mobiwik wallet or UPI on JadiButi for ₹ 899 or more and get 5000 cash back points,offer ends 5th november'.text.size(8.sp).overflow(TextOverflow.clip).color(Color(0xFFB73535)).make()
                              ],
                            ),
                          )
                        ],
                      ).pSymmetric(h: 2.w, v: 1.h),
                      Divider(
                        thickness: 1,
                        height: 1.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio(
                            value: PaymentMethod.awazon,
                            activeColor: appthemColor,
                            groupValue:
                                _checkOutController.selecthosOption.value,
                            onChanged: _checkOutController.onchaged,
                          ).pSymmetric(h: 5.w),
                          SizedBox(
                            width: 60.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    'Amazon Pay'
                                        .text
                                        .semiBold
                                        .black
                                        .size(12.sp)
                                        .make(),
                                    Image.asset(
                                      'lib/assets/asset/amazon.png',
                                      height: 4.h,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ],
                                ).pOnly(bottom: 0.h),
                                //'Pay with Amazon Pay or UPI on JadiButi for ₹ 899 or more and get 5000 cash back points,offer ends 5th november'.text.size(8.sp).overflow(TextOverflow.clip).color(Color(0xFFB73535)).make()
                              ],
                            ),
                          )
                        ],
                      ).pSymmetric(h: 2.w, v: 1.h),
                    ],
                  ),
                ),
                'UPI'.text.black.size(12.sp).make().pSymmetric(v: 1.h),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //'Pay with paytm wallet or UPI on JadiButi for ₹ 899 or more and get 5000 cash back points,offer ends 5th november'.text.size(8.sp).overflow(TextOverflow.clip).color(Color(0xFFB73535)).make().pSymmetric(v: 1.h,h: 5.w),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio(
                            value: PaymentMethod.upi,
                            activeColor: appthemColor,
                            groupValue:
                                _checkOutController.selecthosOption.value,
                            onChanged: _checkOutController.onchaged,
                          ).pSymmetric(h: 5.w),
                          SizedBox(
                            width: 60.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    'Add new UPI ID'
                                        .text
                                        .black
                                        .size(12.sp)
                                        .make(),
                                    Image.asset(
                                      'lib/assets/asset/upi...png',
                                      height: 6.h,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ],
                                ).pOnly(bottom: 0.h),
                                'Pay using supported UPI apps'
                                    .text
                                    .black
                                    .size(10.sp)
                                    .make(),
                              ],
                            ),
                          )
                        ],
                      ).pSymmetric(h: 2.w, v: 2.h),
                    ],
                  ),
                ),
                'Net Banking & Cards'
                    .text
                    .black
                    .size(12.sp)
                    .make()
                    .pSymmetric(v: 2.h),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio(
                            value: PaymentMethod.netBanking,
                            activeColor: appthemColor,
                            groupValue:
                                _checkOutController.selecthosOption.value,
                            onChanged: _checkOutController.onchaged,
                          ).pSymmetric(h: 5.w),
                          SizedBox(
                            width: 60.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                'Net Banking'.text.black.size(12.sp).make(),
                                'Choose Bank'.text.black.size(9.sp).make(),
                              ],
                            ),
                          )
                        ],
                      ).pSymmetric(h: 2.w, v: 1.h),
                      const Divider(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio(
                            value: PaymentMethod.cards,
                            activeColor: appthemColor,
                            groupValue:
                                _checkOutController.selecthosOption.value,
                            onChanged: _checkOutController.onchaged,
                          ).pSymmetric(h: 5.w),
                          SizedBox(
                            width: 60.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                'Credit & Debit Cards'
                                    .text
                                    .black
                                    .size(12.sp)
                                    .make(),
                                'Add new card for payment'
                                    .text
                                    .black
                                    .size(9.sp)
                                    .make(),
                              ],
                            ),
                          )
                        ],
                      ).pSymmetric(h: 2.w, v: 1.h).onTap(() {
                        Get.to(() => EditCard());
                      }),
                    ],
                  ),
                ),
                8.h.heightBox,
              ],
            ).pSymmetric(h: 5.w),
          ),
        ),
        // Positioned(
        //   bottom: 3.h,
        //   left: 5.w,
        //   right: 5.w,
        //   // child: CheckoutButton(price: price+shippingFee)
        //   child: Container(
        //     height: 6.h,
        //     width: 100.w,
        //     decoration: BoxDecoration(
        //         color:Colors.grey,
        //         borderRadius: BorderRadius.all(Radius.circular(50))
        //     ),
        //     child: Row(
        //       children: [
        //         Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             "To be Paid".text.white.bold.size(12.sp).semiBold.make(),
        //             "₹ xxx.xx".text.white.bold.size(12.sp).make()
        //           ],
        //         ),
        //         3.w.widthBox,
        //         Container(
        //           margin: EdgeInsets.symmetric(vertical: 0.6.h),
        //           height: 7.h,
        //           child: VerticalDivider(
        //             color: Colors.white,
        //             thickness: 0.3.w,
        //           ),
        //         ),
        //         Spacer(),
        //         "Checkout".text.bold.white.size(14.sp).makeCentered(),
        //         // 1.w.widthBox,
        //         Icon(Icons.arrow_forward, color: Colors.white,size: 2.6.h,)
        //       ],
        //     ).px(5.w),
        //   ).onInkTap(() {
        //     //Get.to(()=> OrderPlacedScreen() );
        //   }),
        // ),
        // App_bar(Icon(Icons.arrow_back,
        //   size: 3.h,
        //   color: Colors.white,
        // ).onInkTap(() {
        //   Get.back();
        // }),
        // "Payment Details".text.white.semiBold.size(15.sp).make(),
      ])),
    );
  }
}
