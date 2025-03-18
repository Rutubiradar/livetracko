import 'package:cws_app/widgets/constant.dart';
import 'package:cws_app/widgets/drower_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool notifiy = false;
  bool popups = false;
  bool order = false;

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> key = GlobalKey();
    return Scaffold(
      key: key,
      // bottomNavigationBar: New_Bottom_Navigation_Bar(),
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
            key.currentState!.openDrawer();
          }),
        ),
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 19),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      drawer: const OpenDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          5.h.heightBox,
          Text(
            'Your App Settings',
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
          ),
          3.h.heightBox,
          Text(
            'Notifications',
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          1.h.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Receive notifications on latest offers\n'
                'and store updates',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              Switch(
                value: notifiy,
                onChanged: (value) {
                  setState(() {
                    notifiy = value;
                    print(notifiy);
                  });
                },
                activeTrackColor: Colors.white,
                activeColor: appthemColor,
                inactiveThumbColor: Colors.grey,
              ),
            ],
          ),
          3.h.heightBox,
          Text(
            'Popups',
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          1.h.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Disable all popups and adverts from\n'
                'third party Vendors',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              Switch(
                value: popups,
                onChanged: (value) {
                  setState(() {
                    popups = value;
                    print(popups);
                  });
                },
                activeTrackColor: Colors.white,
                activeColor: appthemColor,
                inactiveThumbColor: Colors.grey,
              ),
            ],
          ),
          3.h.heightBox,
          Text(
            'Order History',
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          1.h.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Keep your order history on the app\n'
                'unles manually removed',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              Switch(
                value: order,
                onChanged: (value) {
                  setState(() {
                    order = value;
                    print(order);
                  });
                },
                activeTrackColor: Colors.white,
                activeColor: appthemColor,
                inactiveThumbColor: Colors.grey,
                //inactiveTrackColor: Colors.white,
              ),
            ],
          ),
          5.h.heightBox,
          Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: Container(
              height: 52,
              width: 360,
              decoration: BoxDecoration(
                color: appthemColor,
                borderRadius: BorderRadius.circular(20.sp),
              ),
              child: 'UPDATE SETTINGS'
                  .text
                  .size(10.sp)
                  .letterSpacing(1.5)
                  .bold
                  .white
                  .make()
                  .centered(),
            ).onTap(() {
              //_signupController.CheckSignup();
              //Get.to(()=> LoginScreen());
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomePage()));
            }),
          ),
        ],
      ).pSymmetric(h: 4.5.w),
    );
  }
}
