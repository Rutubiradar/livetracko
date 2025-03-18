import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';
import 'package:cws_app/widgets/constant.dart';

import '../../util/app_utils.dart';

class RateProduct extends StatelessWidget {
  const RateProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: AppUtils.backButton(),
        title: Text(
          'Rate Product',
          style: GoogleFonts.poppins(
              color: appthemColor, fontWeight: FontWeight.w600, fontSize: 19),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Center(
              child: Text(
            "How was your experience\n with the product ?",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 15.sp, fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("lib/assets/asset/star.png"),
              SizedBox(
                width: 1.h,
              ),
              Image.asset("lib/assets/asset/star.png"),
              SizedBox(
                width: 1.h,
              ),
              Image.asset("lib/assets/asset/star.png"),
              SizedBox(
                width: 1.h,
              ),
              Image.asset("lib/assets/asset/star.png"),
              SizedBox(
                width: 1.h,
              ),
              Image.asset("lib/assets/asset/star.png"),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            height: 25.h,
            width: 80.w,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10.sp)),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Write a Comment ",
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.70,
            decoration: BoxDecoration(
                color: appthemColor, borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                "SUBMIT",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
