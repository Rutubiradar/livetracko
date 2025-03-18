import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:cws_app/views/login/login_screens.dart';
import 'package:cws_app/views/otp_screens/otp_page.dart';
import 'package:cws_app/widgets/constant.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatelessWidget {
  static String route = '/splase-screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(height);
    print(width);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  //gradient: gradient1,

                  // gradient: LinearGradient(
                  //   colors: [
                  //     Colors.white,
                  //     Colors.blue,
                  //   ],
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  // ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Spacer(),
                    Container(
                      height: 60.h,
                      child:

                          //Image.asset('lib/assets/asset/Mrkit.png',height: 291,width: 291,),
                          Lottie.asset(
                              'lib/assets/asset/90016-order-food.json'),

                      //from here svg image code

                      // SvgPicture.asset(
                      //   'lib/assets/svg/Avanti-Home-1024x563-1-1 (1).svg',
                      //   // height: 20.0,
                      //   // width: 20.0,
                      //   //allowDrawingOutsideViewBox: true,
                      // ),
                    ),
                    //5.h.heightBox,
                    // Spacer(),

                    // Column(
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.only(bottom: 2.h),
                    //       child: Container(
                    //         height: 52,
                    //         width: 360,
                    //         decoration: BoxDecoration(
                    //           color: buttonColor,
                    //           border: Border.all(color: Colors.indigo),
                    //           borderRadius: BorderRadius.circular(4.sp),
                    //         ),
                    //         child: 'CONTINUE'
                    //             .text
                    //             .size(12.sp)
                    //             .letterSpacing(1.5)
                    //             .bold
                    //             .white
                    //             .make()
                    //             .centered(),
                    //       ).onTap(() {
                    //         Get.to(() => OTPScreen());
                    //         //Get.to(()=> LoginScreen());
                    //         //Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomePage()));
                    //       }),
                    //     ),
                    //   ],
                    // ),

                    // RichText(
                    //   text: TextSpan(
                    //     children: <TextSpan>[
                    //       TextSpan(
                    //           text: 'already have an account?',
                    //           style: GoogleFonts.poppins(
                    //               fontSize: 12, color: Colors.grey)),
                    //       TextSpan(
                    //           text: 'Sign in',
                    //           style: GoogleFonts.poppins(
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.bold,
                    //               color: Colors.black)),
                    //     ],
                    //   ),
                    // ).onTap(() {
                    //   Get.to(() => CustomerLoginScreen());
                    // }),
                    // 4.h.heightBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
