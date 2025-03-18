import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:cws_app/views/otp_screens/otp_page.dart';
import 'package:cws_app/views/signup/signup_controller.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../util/app_utils.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final SignupController _signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: AppUtils.backButton(),
        centerTitle: true,
        title: Text(
          'Create Account',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: buttonColor,
          ),
        ),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _signupController.signupform,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2.h.heightBox,
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: IconButton(
                //       onPressed: () {
                //         Get.back();

                //       },
                //       icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.black,)
                //   ),
                // ).p8(),

                // 4.h.heightBox,
                // Align(
                //   alignment: Alignment.center,
                //   child: Text(
                //     'SIGNUP',
                //     style: GoogleFonts.poppins(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: buttonColor,
                //     ),
                //   ),
                // ).p8(),

                // Align(
                //   alignment: Alignment.center,
                //   child: Text(
                //     'SignUp in to get started and experience',
                //     style: GoogleFonts.poppins(
                //       fontSize: 12,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.grey,
                //     ),
                //   ),
                // ).p2(),

                11.h.heightBox,
                Text(
                  "User Name",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ).pSymmetric(h: 4.w),
                1.h.heightBox,
                TextFormField(
                  //  validator: _signupController.validatename,
                  controller: _signupController.name,
                  decoration: InputDecoration(
                      constraints:
                          const BoxConstraints(maxHeight: 50, minHeight: 50),
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      hintText: 'Enter Your Name',
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 14, color: const Color(0xFFC8C1C1)),
                      // enabledBorder: UnderlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.black),
                      // ),
                      // focusedBorder: UnderlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.black, width: 0.5),
                      // ),
                      errorBorder: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0)))),
                ).pSymmetric(h: 4.w),
                2.h.heightBox,
                Text(
                  "Mobile Number",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ).pSymmetric(h: 4.w),
                1.h.heightBox,
                TextFormField(
                  //obscureText: true,
                  // validator: _signupController.validateEmail,
                  controller: _signupController.email,

                  decoration: InputDecoration(
                    // prefix: Text("+91",
                    //     style:
                    //         GoogleFonts.poppins(fontSize: 14, color: Color(0xFFC8C1C1))),
                    // prefixText: "+91",
                    // prefixStyle:
                    //     GoogleFonts.poppins(fontSize: 14, color: Color(0xFFC8C1C1)),
                    hintText: 'Enter Your Mobile Number',
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 14, color: const Color(0xFFC8C1C1)),
                    constraints: const BoxConstraints(maxHeight: 50),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    // enabledBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black),
                    // ),
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black, width: 0.5),
                    // ),
                  ),
                ).pSymmetric(h: 4.w),
                2.h.heightBox,
                Text(
                  "Password",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ).pSymmetric(h: 4.w),
                1.h.heightBox,
                TextFormField(
                  //obscureText: true,
                  //  validator: _signupController.validateAge,
                  controller: _signupController.age,

                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 14, color: const Color(0xFFC8C1C1)),
                    constraints: const BoxConstraints(maxHeight: 50),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    // enabledBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black),
                    // ),
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black, width: 0.5),
                    // ),
                  ),
                ).pSymmetric(h: 4.w),
                0.5.h.heightBox,

                // TextFormField(
                //   //obscureText: true,
                //   validator: _signupController.validateMobile,
                //   controller: _signupController.mobile,

                //   decoration: InputDecoration(
                //     hintText: 'Mobile',
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.black),
                //     ),
                //     focusedBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.black, width: 0.5),
                //     ),
                //   ),
                // ).pSymmetric(h: 4.w),
                0.5.h.heightBox,

                // TextFormField(
                //   //obscureText: true,
                //   validator: _signupController.validategender,
                //   controller: _signupController.Gender,

                //   decoration: InputDecoration(
                //     hintText: 'Gender',
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.black),
                //     ),
                //     focusedBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.black, width: 0.5),
                //     ),
                //   ),
                // ).pSymmetric(h: 4.w),

                7.h.heightBox,

                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Center(
                    child: Container(
                      height: 52,
                      width: 360,
                      decoration: BoxDecoration(
                        color: appthemColor,
                        // border: Border.all(color: Colors.indigo),
                        borderRadius: BorderRadius.circular(30.sp),
                      ),
                      child: 'NEXT'
                          .text
                          .size(10.sp)
                          .letterSpacing(1.5)
                          .bold
                          .white
                          .make()
                          .centered(),
                    ).onTap(() {
                      _signupController.CheckSignup();
                      Get.to(() => OTPScreen());
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomePage()));
                    }),
                  ),
                ),
                3.h.heightBox,

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Align(
                //       alignment: Alignment.center,
                //       child: Text(
                //         'You have an account ?',
                //         style: GoogleFonts.poppins(
                //           fontSize: 11,
                //           fontWeight: FontWeight.w600,
                //           color: Colors.grey,
                //         ),
                //       ),
                //     ),
                //     6.h.heightBox,
                //     Align(
                //       alignment: Alignment.center,
                //       child: Text(
                //         'LOGIN',
                //         style: GoogleFonts.poppins(
                //           fontSize: 12,
                //           fontWeight: FontWeight.w500,
                //           color: buttonColor,
                //         ),
                //       ),
                //     ).px8().onTap(() {
                //       Get.to(() => SignUpScreen());
                //     }),
                //   ],
                // ),

                5.h.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
