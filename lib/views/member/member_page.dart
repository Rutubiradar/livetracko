import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../util/app_utils.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: AppUtils.backButton(),
        title: Text(
          'Membership',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 19),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          1.h.heightBox,
          Container(
            height: 20.h,
            width: 100.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                image: DecorationImage(
                    image: AssetImage(
                      "lib/assets/asset/member1.png",
                    ),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                1.h.heightBox,
                Text("MEMBERSHIP FOR 1 MONTH PLAN")
                    .text
                    .size(13.sp)
                    .color(Color(0xff0084FF))
                    .make(),
                1.h.heightBox,
                Text("₹150.00")
                    .text
                    .size(13.sp)
                    .color(Color(0xff0084FF))
                    .make(),
                2.h.heightBox,
                Container(
                  height: 5.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                      color: Color(0xff0084FF),
                      borderRadius: BorderRadius.circular(20.sp)),
                  child: Center(child: Text("Try Now").text.bold.white.make()),
                )
              ],
            ).p16(),
          ),
          2.h.heightBox,
          Container(
            height: 20.h,
            width: 100.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                image: DecorationImage(
                    image: AssetImage(
                      "lib/assets/asset/member2.png",
                    ),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                1.h.heightBox,
                Text("MEMBERSHIP FOR 1 MONTH PLAN")
                    .text
                    .size(13.sp)
                    .color(Color(0xffFF7500))
                    .make(),
                1.h.heightBox,
                Text("₹150.00")
                    .text
                    .size(13.sp)
                    .color(Color(0xffFF7500))
                    .make(),
                2.h.heightBox,
                Container(
                  height: 5.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                      color: Color(0xffFF7500),
                      borderRadius: BorderRadius.circular(20.sp)),
                  child: Center(child: Text("Try Now").text.bold.white.make()),
                )
              ],
            ).p16(),
          ),
          2.h.heightBox,
          Container(
            height: 20.h,
            width: 100.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                image: DecorationImage(
                    image: AssetImage(
                      "lib/assets/asset/member3.png",
                    ),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                1.h.heightBox,
                Text("MEMBERSHIP FOR 1 MONTH PLAN")
                    .text
                    .size(13.sp)
                    .color(Color(0xffFF7500))
                    .make(),
                1.h.heightBox,
                Text("₹150.00")
                    .text
                    .size(13.sp)
                    .color(Color(0xffFF7500))
                    .make(),
                2.h.heightBox,
                Container(
                  height: 5.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                      color: Color(0xffFF7500),
                      borderRadius: BorderRadius.circular(20.sp)),
                  child: Center(child: Text("Try Now").text.bold.white.make()),
                )
              ],
            ).p16(),
          )
        ],
      ).p12(),
    );
  }
}
