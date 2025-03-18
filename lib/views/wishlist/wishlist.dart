import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:cws_app/views/products/product2_screen.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../util/app_utils.dart';
import '../cart_screen/cart_page.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: AppUtils.backButton(),
        title: Text(
          'WishList',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 19),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          1.5.h.heightBox,
          SizedBox(
            height: 100.h,
            child: GridView.builder(
                // physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  //childAspectRatio: 4/ 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 260,
                ),
                itemCount: 10,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                      height: 18.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1),

                        //borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 19.h,
                              width: 45.w,
                              child: Column(
                                children: [
                                  // Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: Text(
                                  //     'Shoes',
                                  //     style: GoogleFonts.poppins(
                                  //         fontSize: 13.sp,
                                  //         color: Colors.black,
                                  //         fontWeight: FontWeight.bold),
                                  //   ).px(3),
                                  // ),
                                  1.h.heightBox,
                                  SizedBox(
                                    child: Image.asset(
                                      'assets/Grocery-Transparent-Background (1) 1.png',
                                      fit: BoxFit.cover,
                                      height: 160,
                                    ),
                                  ),
                                ],
                              )),
                          const Spacer(),
                          Container(
                            height: 8.h,
                            // color: Color(0xFFE3E6EF),
                            color: appthemColor,
                            width: 45.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('₹ 699',
                                        style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    2.h.heightBox,
                                    Container(
                                      height: 2.5.h,
                                      width: 17.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: const Color(0xFF7D84B2)),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Buy Now',
                                        style: GoogleFonts.poppins(
                                            fontSize: 11, color: appthemColor),
                                      ).px(3)),
                                    ).onTap(() {
                                      Get.to(() => Produt2page());
                                    }),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    "add to cart"
                                        .text
                                        .make()
                                        .p2()
                                        .box
                                        .withRounded()
                                        .white
                                        .border()
                                        .make()
                                        .onTap(() {
                                      Get.to(() => const CartPage());
                                    }),
                                    2.h.heightBox,
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 30.0,
                                    ),
                                  ],
                                ),
                              ],
                            ).pSymmetric(h: 3.w),
                          ),
                        ],
                      )).pSymmetric(h: 2.w);
                }),
          ),
        ]),
      ),
    );
  }
}
