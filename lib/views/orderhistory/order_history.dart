import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../util/app_utils.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appthemColor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: AppUtils.backButton(),
        title: Text(
          'Order History',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 19),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            1.h.heightBox,
            Container(
              padding: EdgeInsets.all(8.sp),
              height: 100.h,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(6.sp),
                    child: Container(
                      width: 100.w,
                      height: 16.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.sp),
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
                            child: Center(
                                child: Image.asset(
                              'assets/Grocery-Transparent-Background (1) 1 (1).png',
                              fit: BoxFit.fill,
                            )),
                          ),
                          3.w.widthBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              1.h.heightBox,
                              Text(
                                'Vegetables',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.sp),
                              ),
                              2.h.heightBox,
                              Text(
                                '₹565.0',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.sp),
                              ),
                              // 2.h.heightBox,
                              // Row(
                              //   children: [
                              //     Text(""),
                              //     30.w.widthBox,
                              //     Container(
                              //       height: 3.h,
                              //       width: 19.w,
                              //       decoration: BoxDecoration(
                              //         color: appthemColor,
                              //         borderRadius: BorderRadius.circular(20),
                              //       ),
                              //       child: Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Icon(
                              //             Icons.add,
                              //             color: Colors.white,
                              //             size: 17,
                              //           ),
                              //           Text(
                              //             '1',
                              //             style: GoogleFonts.poppins(
                              //                 color: Colors.white,
                              //                 fontWeight: FontWeight.w400,
                              //                 fontSize: 13),
                              //           ),
                              //           Icon(Icons.remove,
                              //               color: Colors.white, size: 17),
                              //         ],
                              //       ).p2(),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ],
                      ).p8(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
