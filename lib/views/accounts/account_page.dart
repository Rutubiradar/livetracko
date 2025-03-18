import 'package:cws_app/views/check_out_screens/check_out_address.dart';
import 'package:cws_app/views/editProfile/edit_profile.dart';
import 'package:cws_app/views/edit_card/edit_cards.dart';
import 'package:cws_app/views/login/login_screens.dart';
import 'package:cws_app/views/notification/Notice_fication.dart';
import 'package:cws_app/views/orderhistory/order_history.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:cws_app/widgets/drower_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _key = GlobalKey();
    return Scaffold(
      // bottomNavigationBar: New_Bottom_Navigation_Bar(),
      backgroundColor: Colors.white,
      key: _key,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: SizedBox(
          height: 2.h,
          width: 2.w,
          child: Image.asset(
            'lib/assets/asset/menu.png',
            fit: BoxFit.fitWidth,
          ).p16().onTap(() {
            _key.currentState!.openDrawer();
          }),
        ),
        title: Text(
          'Account',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 19),
        ),
        centerTitle: true,
      ),
      drawer: const OpenDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            0.h.heightBox,
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 45,
                  child: CircleAvatar(
                    backgroundColor: Colors.greenAccent[100],
                    radius: 45,
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('lib/assets/asset/avatar.png'), //NetworkImage
                      radius: 45,
                    ), //CircleAvatar
                  ), //CircleAvatar
                ),
                10.w.widthBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jameson Dunn',
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                    0.6.h.heightBox,
                    Text(
                      'jamesonhunn@gmail.com',
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ).pSymmetric(h: 4.5.w),
            5.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(const EditProfile());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: appthemColor, borderRadius: BorderRadius.circular(6.sp)),
                          child: Image.asset(
                            'lib/assets/asset/Icon_Edit-Profile.png',
                            color: Colors.white,
                            height: 40,
                          ),
                        ),
                        4.w.widthBox,
                        Text(
                          'Edit Profile',
                          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Get.to(const EditProfile());
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )),
              ],
            ).pSymmetric(h: 4.5.w),
            1.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(CheckoutAddress());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: appthemColor, borderRadius: BorderRadius.circular(6.sp)),
                          child: Image.asset(
                            'lib/assets/asset/Icon_Location.png',
                            color: Colors.white,
                            height: 40,
                          ),
                        ),
                        4.w.widthBox,
                        Text(
                          'Shiping Address',
                          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )),
              ],
            ).pSymmetric(h: 4.5.w),
            1.h.heightBox,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       child: Row(
            //         children: [
            //           Container(
            //             decoration: BoxDecoration(
            //                 color: appthemColor,
            //                 borderRadius: BorderRadius.circular(6.sp)),
            //             child: Image.asset(
            //               'lib/assets/asset/Icon_Wishlist.png',
            //               color: Colors.white,
            //               height: 40,
            //             ),
            //           ),
            //           4.w.widthBox,
            //           Text(
            //             'Wishlist',
            //             style: GoogleFonts.poppins(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.w400,
            //                 fontSize: 15),
            //           ),
            //         ],
            //       ),
            //     ),
            //     IconButton(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.arrow_forward_ios,
            //           size: 18,
            //         )),
            //   ],
            // ).pSymmetric(h: 4.5.w),
            1.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(const OrderHistory());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: appthemColor, borderRadius: BorderRadius.circular(6.sp)),
                          child: Image.asset(
                            'lib/assets/asset/Icon_Order.png',
                            color: Colors.white,
                            height: 40,
                          ),
                        ),
                        4.w.widthBox,
                        Text(
                          'Order History',
                          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )),
              ],
            ).pSymmetric(h: 4.5.w),
            1.h.heightBox,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       child: Row(
            //         children: [
            //           Container(
            //             decoration: BoxDecoration(
            //                 color: appthemColor,
            //                 borderRadius: BorderRadius.circular(6.sp)),
            //             child: Image.asset(
            //               'lib/assets/asset/Icon_History.png',
            //               color: Colors.white,
            //               height: 40,
            //             ),
            //           ),
            //           4.w.widthBox,
            //           Text(
            //             'Order History',
            //             style: GoogleFonts.poppins(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.w400,
            //                 fontSize: 15),
            //           ),
            //         ],
            //       ),
            //     ),
            //     IconButton(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.arrow_forward_ios,
            //           size: 18,
            //         )),
            //   ],
            // ).pSymmetric(h: 4.5.w),
            1.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: appthemColor, borderRadius: BorderRadius.circular(6.sp)),
                          child: Image.asset(
                            'lib/assets/asset/Icon_Order.png',
                            color: Colors.white,
                            height: 40,
                          ),
                        ),
                        4.w.widthBox,
                        Text(
                          'Track Order',
                          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )),
              ],
            ).pSymmetric(h: 4.5.w),
            1.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(EditCard());
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: appthemColor, borderRadius: BorderRadius.circular(6.sp)),
                        child: Image.asset(
                          'lib/assets/asset/Icon_Payment.png',
                          color: Colors.white,
                          height: 40,
                        ),
                      ),
                      4.w.widthBox,
                      Text(
                        'Cards',
                        style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )),
              ],
            ).pSymmetric(h: 4.5.w),
            1.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(const NoticeFication());
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: appthemColor, borderRadius: BorderRadius.circular(6.sp)),
                        child: Image.asset(
                          'lib/assets/asset/Icon_Alert.png',
                          color: Colors.white,
                          height: 40,
                        ),
                      ),
                      4.w.widthBox,
                      Text(
                        'Notifications',
                        style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Get.to(const NoticeFication());
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )),
              ],
            ).pSymmetric(h: 4.5.w),
            1.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _logoutAccountSheet(context);
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: appthemColor, borderRadius: BorderRadius.circular(6.sp)),
                          child: Image.asset(
                            'lib/assets/asset/Icon_Exit.png',
                            color: Colors.white,
                            height: 40,
                          ),
                        ),
                        4.w.widthBox,
                        Text(
                          'Log Out',
                          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _logoutAccountSheet(context);
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )),
              ],
            ).pSymmetric(h: 4.5.w),
          ],
        ),
      ),
    );
  }

  void _logoutAccountSheet(context) {
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
                      style: GoogleFonts.poppins(fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(child: Image.asset("lib/assets/asset/cancel.png")))
                  ],
                ),
                3.h.heightBox,
                Text(
                  "Are you sure you want to\nlogout?",
                  style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                3.h.heightBox,
                InkWell(
                  onTap: () {
                    Get.to(() => CustomerLoginScreen());
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.80,
                    decoration: BoxDecoration(color: appthemColor, borderRadius: BorderRadius.circular(20)),
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
