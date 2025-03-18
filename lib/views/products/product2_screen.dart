import 'package:cws_app/views/RateProduct/rate_product.dart';
import 'package:cws_app/views/cart_screen/cart_page.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class Produt2page extends StatelessWidget {
  Produt2page({Key? key}) : super(key: key);

  List<String> indemand = [
    "lib/assets/asset/indemand1.png",
    "lib/assets/asset/indemand2.png",
    "lib/assets/asset/indemand3.png",
    "lib/assets/asset/indemand4.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'lib/assets/foodd.png',
                    fit: BoxFit.fill,
                    height: 30.h,
                  ),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.sp),
                            bottomRight: Radius.circular(20.sp))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                )),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ).pSymmetric(h: 5.w),
                      ],
                    ),
                  ),
                ],
              ),
              2.h.heightBox,
              Row(
                children: [
                  1.w.widthBox,
                  Image.asset("lib/assets/asset/starfill.png"),
                  3.w.widthBox,
                  const Text("4.2+"),
                  3.w.widthBox,
                  const Text("Reviews").text.color(appthemColor).make(),
                ],
              ).pSymmetric(h: 5.w),
              2.h.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Grocery',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ).pSymmetric(h: 5.w),
              2.h.heightBox,
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     'Description',
              //     style: GoogleFonts.poppins(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 14,
              //         color: Colors.black),
              //   ).pSymmetric(h: 5.w),
              // ),
              1.h.heightBox,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      color: Colors.black),
                ).pSymmetric(h: 5.w),
              ),
              2.h.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '₹ 699.50',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                      color: appthemColor,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        "₹ 190",
                        style: GoogleFonts.poppins(color: appthemColor),
                      ),
                      0.5.h.heightBox,
                      const Text("(include all Taxes)").text.gray700.make(),
                    ],
                  ),
                ],
              ).pSymmetric(h: 5.w),
              3.h.heightBox,
              // Text("Select size").pSymmetric(h: 5.w),
              // 2.5.h.heightBox,
              // Row(
              //   children: [
              //     Container(
              //       height: 3.h,
              //       width: 6.w,
              //       decoration: BoxDecoration(
              //           color: appthemColor,
              //           borderRadius: BorderRadius.circular(5.sp)),
              //       child: Center(child: Text("L").text.white.make()),
              //     ),
              //     4.w.widthBox,
              //     Container(
              //       height: 3.h,
              //       width: 6.w,
              //       decoration: BoxDecoration(
              //           border: Border.all(color: Colors.grey),
              //           borderRadius: BorderRadius.circular(5.sp)),
              //       child: Center(child: Text("M").text.gray800.make()),
              //     ),
              //     4.w.widthBox,
              //     Container(
              //       height: 3.h,
              //       width: 6.w,
              //       decoration: BoxDecoration(
              //           border: Border.all(color: Colors.grey),
              //           borderRadius: BorderRadius.circular(5.sp)),
              //       child: Center(child: Text("S").text.gray800.make()),
              //     )
              //   ],
              // ).pSymmetric(h: 5.w),
              2.h.heightBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Select quantity",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 4.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: appthemColor),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            Text(
                              '1',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ],
                        ).pSymmetric(h: 1.w),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: Container(
                          height: 45,
                          width: 160,
                          decoration: BoxDecoration(
                            border: Border.all(color: appthemColor),
                            //border: Border.all(color: Colors.indigo),
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          child: 'ADD TO CART'
                              .text
                              .size(11.sp)
                              .letterSpacing(1.5)
                              .bold
                              .color(appthemColor)
                              .make()
                              .centered(),
                        ).onTap(() {
                          Get.defaultDialog(
                              title: "Added",
                              content: const Text("Item added successfully."),
                              confirm: OutlinedButton(
                                onPressed: () {
                                  Get.to(const CartPage());
                                },
                                child: Text("Go to Cart",
                                    style: GoogleFonts.poppins(
                                        color: appthemColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ),
                              cancel: OutlinedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("Cancel",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16))));
                          //
                          // _signupController.CheckSignup();
                          //Get.to(()=> Produt2page());
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomePage()));
                        }),
                      ),
                    ],
                  ).pSymmetric(h: 4.w),
                ],
              ),
              1.5.h.heightBox,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'You May Also Like',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ).pSymmetric(h: 5.w),
              ),
              1.h.heightBox,
              SizedBox(
                height: 25.5.h,
                child: ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext, index) {
                    return Container(
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: const Color(0xffE3E6EF),
                            )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: 15.h,
                                      width: 42.w,
                                      child: Image.asset(
                                        "lib/assets/foodd.png",
                                        //
                                        height: 10.h,
                                        width: 40.w,
                                      ),
                                    ),
                                    Positioned(
                                      left: 10.sp,
                                      top: 10.sp,
                                      child: Container(
                                          height: 2.5.h,
                                          width: 15.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3.sp),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            children: [
                                              1.w.widthBox,
                                              Image.asset(
                                                  "lib/assets/asset/starfill.png"),
                                              1.w.widthBox,
                                              const Text("4.2+"),
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
                                  "Grocery",
                                  style: GoogleFonts.poppins(
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ).px(3),
                                1.h.heightBox,
                                // Text(
                                //   "shirt",
                                //   style: GoogleFonts.poppins(
                                //     fontSize: 10.sp,
                                //   ),
                                // ).px(3),
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
                                    Image.asset(
                                      "lib/assets/asset/basket.png",
                                      color: appthemColor,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ).pSymmetric(h: 1.w).onTap(() {
                        // Get.to(() => DiscoverPage());
                      }),
                    );
                  },
                  itemCount: indemand.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(7),
                  scrollDirection: Axis.horizontal,
                ),
              ),
              2.h.heightBox,
              InkWell(
                onTap: () {
                  Get.to(const RateProduct());
                },
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reviews',
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 12.sp),
                        ),

                        TextFormField(
                          readOnly: true,
                          onTap: () {
                            Get.to(const RateProduct());
                          },
                          decoration:
                              const InputDecoration(hintText: "Add a Comment"),
                        ),
                        1.h.heightBox,
                        // Column(
                        //   children: [
                        //     // Text(
                        //     //   "ADD YOUR COMMENT",
                        //     //   style: GoogleFonts.poppins(
                        //     //       color: appthemColor, fontSize: 13.sp),
                        //     // )
                        //   ],
                        // )
                      ],
                    ).paddingSymmetric(horizontal: 5.w),
                  ],
                ),
              ),
              0.5.heightBox,
              Container(
                height: 100.h,
                width: 100.w,
                color: Colors.white,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),

                  itemBuilder: (BuildContext, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            1.h.heightBox,

                            SizedBox(
                              height: 14.h,
                              width: 100.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 22,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.greenAccent[100],
                                      radius: 21,
                                      child: const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'lib/assets/asset/avatar.png'), //NetworkImage
                                        radius: 19,
                                      ), //CircleAvatar
                                    ), //CircleAvatar
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Ander',
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          // width: MediaQuery.of(context)
                                          //         .size
                                          //         .width -
                                          //     220,
                                          child: Text(
                                            "All Grocery Items are very good and fresh",
                                            style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        7.h.heightBox,
                                      ],
                                    ),
                                  ),
                                  4.w.widthBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      VxRating(
                                        onRatingUpdate: (value) {},
                                        count: 5,
                                        selectionColor: Colors.yellow,
                                        size: 20,
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
              2.h.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
