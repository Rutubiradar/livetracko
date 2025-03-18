import 'package:cws_app/views/otp_screens/phone_controller.dart';
import 'package:cws_app/views/otp_screens/time_controller.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../util/app_utils.dart';
import '../main_screen/main_screen.dart';
import 'otp_input.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key, this.phone}) : super(key: key);
  final OtpTimerController _timeController = Get.put(OtpTimerController());
  final PhoneController _phoneController = Get.put(PhoneController());
  final phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Verification",
          style: GoogleFonts.montserrat(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: AppUtils.backButton(),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _timeController.otpKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                4.h.heightBox,
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'A 4 Digit PIN has been sent to Your',
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ).p2(),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'phone no. Enter it below to continue',
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ).p1(),
                9.h.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 4; i++)
                      OtpInput(
                          validator: _timeController.otpValidator,
                          controller: _timeController.otp[i],
                          autoFocus: false),
                  ],
                ),
                10.h.heightBox,
                Container(
                  height: 52,
                  width: 320,
                  decoration: BoxDecoration(
                    color: appthemColor,
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: 'VERIFY'
                      .text
                      .size(10.sp)
                      .letterSpacing(1.5)
                      .bold
                      .white
                      .make()
                      .centered(),
                ).onInkTap(() {
                  Get.to(() => MainScreen());
                  // _timeController.otpdigits();

                  // _timeController.checkValidation(phone);
                  // _timeController.
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_timeController.result.toString())));
                  //
                }),
                Obx(() => Text(_timeController.elapsedTime.value)),
                Align(
                        alignment: Alignment.centerRight,
                        child: "Resend OTP".text.black.size(11.sp).end.make())
                    .pSymmetric(h: 8.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
