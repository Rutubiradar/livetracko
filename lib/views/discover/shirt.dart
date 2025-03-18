import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:cws_app/views/discover/discover_screens.dart';
import 'package:velocity_x/velocity_x.dart';

class Shirt extends StatelessWidget {
  const Shirt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 90.h,
        child: GridView.builder(
            // physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              //childAspectRatio: 4/ 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 20,
              mainAxisExtent: 205,
            ),
            itemCount: 10,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          border: Border.all(
                            color: Color(0xffE3E6EF),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 15.h,
                                width: 39.w,
                                child: Image.asset(
                                  "lib/assets/home2.png",
                                  //
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                left: 10.sp,
                                top: 10.sp,
                                child: Container(
                                    height: 2.5.h,
                                    width: 15.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.sp),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      children: [
                                        1.w.widthBox,
                                        Image.asset(
                                            "lib/assets/asset/starfill.png"),
                                        1.w.widthBox,
                                        Text("4.2+"),
                                      ],
                                    )),
                              ),
                              Positioned(
                                left: 100.sp,
                                top: 10.sp,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "lib/assets/asset/heart.png",
                                      height: 1.5.h,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          1.h.heightBox,
                          Text(
                            "Paints & Andhesives",
                            style: GoogleFonts.poppins(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ).px(3),
                          1.h.heightBox,
                          // Text(
                          //   "shirt",
                          //   style: GoogleFonts.poppins(
                          //     fontSize: 10.sp,
                          //   ),
                          // ).px(3),
                          // 1.h.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "\$ 565",
                                style: GoogleFonts.poppins(
                                  fontSize: 10.sp,
                                ),
                              ).px(3),
                              22.w.widthBox,
                              Image.asset("lib/assets/asset/basket.png")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ).pSymmetric(h: 1.w).onTap(() {
                  Get.to(() => DiscoverPage());
                }),
              ).pSymmetric(h: 2.w);
            }),
      ),
    );
  }
}
