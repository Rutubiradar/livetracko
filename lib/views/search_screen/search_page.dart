import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

import '../../util/app_utils.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  List<String> baner11 = [
    "lib/assets/asset/all.png",
    "lib/assets/asset/all.png",
    "lib/assets/asset/all.png",
  ];

  List<String> banner11text1 = [
    'All',
    'Man',
    'Women',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: PhysicalModel(
          color: Colors.white,
          elevation: 3,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 4.4.h,
            width: 55.w,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.grey,
                ),
                hintText: 'Search..',
                hintStyle:
                    GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        leading: AppUtils.backButton(),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.filter_alt_outlined,
                color: Colors.grey,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            2.h.heightBox,
            Container(
              height: 21.h,
              width: 100.w,
              color: Colors.white,
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),

                itemBuilder: (BuildContext, index) {
                  return Column(
                    children: [
                      1.h.heightBox,

                      Container(
                        height: 20.h,
                        width: 34.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 16.h,
                              width: 32.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                              ),

                              child: Image.asset(
                                baner11[index],
                                fit: BoxFit.fill,
                              ),
                              //Image.asset(baner1[index],fit: BoxFit.fill,)),
                            ),
                            Text(
                              banner11text1[index],
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ).pSymmetric(h: 1.w),
                      )

                      //Image.asset('lib/assets/asset/sale1.png',fit: BoxFit.fill,)),
                      //AssetImage(images[index]),
                      //Text("This is title",style: GoogleFonts.poppins(fontSize: 10,),),
                    ],
                  ).paddingSymmetric(horizontal: 2.w);
                },
                itemCount: 3,
                shrinkWrap: true,
                //padding: EdgeInsets.all(2),
                scrollDirection: Axis.horizontal,
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Result',
                  style: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '15 Item Found',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500,
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: 5.w),
            2.h.heightBox,
            Container(
              height: 73.h,
              width: 100.w,
              color: Colors.white,
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),

                itemBuilder: (BuildContext, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          1.h.heightBox,

                          Container(
                            height: 16.h,
                            width: 100.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 16.h,
                                  width: 32.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Image.asset(
                                    'lib/assets/asset/bg.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'White Shoes',
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Men',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    3.h.heightBox,
                                    Container(
                                      height: 5.h,
                                      width: 16.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.shopping_bag,
                                            color: appthemColor,
                                            size: 22,
                                          ),
                                          Icon(Icons.favorite_outline_rounded,
                                              color: Colors.black, size: 22),
                                        ],
                                        //Icon(Icons.shopping_bag)
                                      ),
                                    ),
                                  ],
                                ),
                                4.w.widthBox,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '₹699',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: appthemColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ).pSymmetric(h: 5.w),
                          )

                          //Image.asset('lib/assets/asset/sale1.png',fit: BoxFit.fill,)),
                          //AssetImage(images[index]),
                          //Text("This is title",style: GoogleFonts.poppins(fontSize: 10,),),
                        ],
                      ),
                    ],
                  );
                },
                itemCount: 5,
                shrinkWrap: true,
                //padding: EdgeInsets.all(5),
                //scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
