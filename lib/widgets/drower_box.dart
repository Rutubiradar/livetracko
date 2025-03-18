import 'dart:ui';

import 'package:cws_app/views/about_us/feedback_screen.dart';
import 'package:cws_app/views/about_us/help_screen.dart';

import 'package:cws_app/views/login/login_screens.dart';
import 'package:cws_app/views/wishlist/wishlist.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../views/main_screen/main_screen.dart';

class OpenDrawer extends StatefulWidget {
  const OpenDrawer({Key? key}) : super(key: key);

  @override
  _OpenDrawerState createState() => _OpenDrawerState();
}

class _OpenDrawerState extends State<OpenDrawer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50, top: 50),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
        child: SizedBox(
          // alignment: Alignment.topLeft,
          height: MediaQuery.of(context).size.height - 220,
          child: Drawer(
            backgroundColor: Colors.white,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(),
                    child: Column(
                      children: [
                        2.h.heightBox,
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            radius: 20,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  'lib/assets/asset/avatar.png'), //NetworkImage
                              radius: 20,
                            ), //CircleAvatar
                          ),
                        ).px32(),
                        1.h.heightBox,

                        //Image.asset('lib/assets/asset/avatar.png'),

                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Jameson Donn',
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                            ).px32(),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Get.bottomSheet(Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              "Reset".text.bold.red500.make(),
                                              const Spacer(),
                                              "Filter".text.bold.make(),
                                              const Spacer(),
                                              const Icon(
                                                Icons.close,
                                                color: Colors.black54,
                                                size: 26,
                                              ).onTap(() {
                                                Get.back();
                                              }),
                                            ],
                                          ),
                                          2.h.heightBox,
                                          "Price".text.xl.make(),
                                          1.h.heightBox,
                                          const Divider(),
                                          "Special Offers".text.xl.make(),
                                          1.h.heightBox,
                                          const Divider(),
                                          "Brand".text.xl.bold.make(),
                                          RadioListTile(
                                              value: false,
                                              title: "Uniliver".text.make(),
                                              groupValue: true,
                                              onChanged: (v) {}),
                                          RadioListTile(
                                              value: false,
                                              title: "Reliance".text.make(),
                                              groupValue: true,
                                              onChanged: (v) {}),
                                          const Divider(),
                                          const Divider(),
                                          2.h.heightBox,
                                        ],
                                      ),
                                    ),
                                  ));
                                },
                                icon: const Icon(
                                  Icons.filter_alt_outlined,
                                  color: Colors.black54,
                                  size: 26,
                                )),
                          ],
                        ),
                        1.h.heightBox,

                        //Image.asset('lib/assets/asset/avatar.png'),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '@johndonee',
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 11,
                            ),
                          ),
                        ).px32(),
                      ],
                    ),
                  ),
                  2.h.heightBox,
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: ListView(
                        padding: const EdgeInsets.all(0.0),
                        children: [
                          Container(
                            child: ListTile(
                              leading: Image.asset(
                                'lib/assets/asset/home.png',
                                height: 25,
                                width: 30,
                              ),
                              //Icon(FontAwesomeIcons.calendarCheck,color: Colors.black,),
                              title: Text(
                                'Home',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.black),
                              ),
                              //PersonalDetails
                            ),
                          ).onTap(() {
                            // Get.to(() => MyDashBoard());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreen()));
                          }),

                          // Container(
                          //   child: ListTile(
                          //     leading: Image.asset(
                          //       'lib/assets/asset/Icon_Catalog.png',
                          //       height: 25,
                          //       width: 30,
                          //     ),
                          //     //Icon(Icons.supervised_user_circle,color: Colors.black,),
                          //     title: Text(
                          //       'Catalog',
                          //       style: GoogleFonts.poppins(
                          //           fontSize: 16, color: Colors.black),
                          //     ),
                          //     //PersonalDetails
                          //   ),
                          // ).onTap(() {
                          //   Get.to(() => const DiscoverPage());

                          //   //Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderPage()));
                          // }),

                          Container(
                            child: ListTile(
                              leading: Image.asset(
                                'lib/assets/asset/category.png',
                                height: 25,
                                width: 30,
                              ),
                              //Icon(Icons.supervised_user_circle,color: Colors.black,),
                              title: Text(
                                'Category',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.black),
                              ),
                              //PersonalDetails
                            ),
                          ).onTap(() {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>GoogleFit()));
                          }),
                          Container(
                            child: ListTile(
                              leading: Image.asset(
                                'lib/assets/asset/heart.png',
                                height: 25,
                                width: 30,
                              ),
                              //Icon(Icons.supervised_user_circle,color: Colors.black,),
                              title: Text(
                                'Wishlist',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.black),
                              ),
                              //PersonalDetails
                            ),
                          ).onTap(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Wishlist()));
                          }), //ShrareDetails

                          Container(
                            child: ListTile(
                              leading: const Icon(
                                Icons.percent_rounded,
                                color: Colors.black45,
                              ),
                              //Icon(Icons.supervised_user_circle,color: Colors.black,),
                              title: Text(
                                'Discount',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.black),
                              ),
                              //PersonalDetails
                            ),
                          ).onTap(() {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const MemberPage()));
                          }),
                          Container(
                            child: ListTile(
                              leading: const Icon(
                                Icons.local_offer,
                                color: Colors.black45,
                              ),
                              title: Text(
                                'Offer',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.black),
                              ),
                              //PersonalDetails
                            ),
                          ).onTap(() {
                            // Get.to(() => const Faq());

                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>UserComments()));
                          }),
                          Container(
                            child: ListTile(
                              leading: Image.asset(
                                'lib/assets/asset/faq.png',
                                height: 25,
                                width: 30,
                              ),
                              //Icon(Icons.supervised_user_circle,color: Colors.black,),
                              title: Text(
                                'Faq\'s',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.black),
                              ),
                              //PersonalDetails
                            ),
                          ).onTap(() {
                            Get.to(() => FeedBackScreen());

                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>UserComments()));
                          }),

                          Padding(
                            padding: const EdgeInsets.only(left: 30, top: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HelpScreen()));
                                  },
                                  child: Text(
                                    "About Us",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        color: const Color(0xFF2B2B2B)),
                                  ),
                                ),
                                1.h.heightBox,
                                Text(
                                  "Disclaimer",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: const Color(0xFF2B2B2B)),
                                ),
                                1.h.heightBox,
                                InkWell(
                                  onTap: () {
                                    _logoutBottomSheet(context);
                                  },
                                  child: Text(
                                    "Log Out",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          )
                          // Container(
                          //   child: ListTile(
                          //     leading: Icon(
                          //       Icons.account_box_outlined,
                          //       size: 20,
                          //     ),
                          //     //Icon(Icons.supervised_user_circle,color: Colors.black,),
                          //     title: Text(
                          //       'Aboutus',
                          //       style: GoogleFonts.poppins(color: Colors.black),
                          //     ),
                          //     //PersonalDetails
                          //   ),
                          // ).px16().onTap(() {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => AboutUs()));
                          // }),

                          // Container(
                          //   child: ListTile(
                          //     leading: Icon(
                          //       Icons.logout,
                          //       size: 20,
                          //     ),
                          //     //Icon(Icons.supervised_user_circle,color: Colors.black,),
                          //     title: Text(
                          //       'Logout',
                          //       style: GoogleFonts.poppins(color: Colors.black),
                          //     ),
                          //     //PersonalDetails
                          //   ),
                          // ).px16().onTap(() {
                          //   //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAppointment()));

                          // _logoutBottomSheet(context);
                          // }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _logoutBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "LOGOUT",
                      style: GoogleFonts.poppins(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            child: Image.asset("lib/assets/asset/cancel.png")))
                  ],
                ),
                3.h.heightBox,
                Text(
                  "Are you sure you want to\nlogout?",
                  style: GoogleFonts.poppins(
                      fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                3.h.heightBox,
                InkWell(
                  onTap: () {
                    Get.to(CustomerLoginScreen());
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.80,
                    decoration: BoxDecoration(
                        color: appthemColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "YES",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
