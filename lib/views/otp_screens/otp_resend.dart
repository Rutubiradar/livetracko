import 'dart:async';
import 'dart:convert';

import 'package:cws_app/network/api_client.dart';
import 'package:cws_app/views/Password/create_new_password.dart';
import 'package:cws_app/views/otp_screens/phone_controller.dart';
import 'package:cws_app/views/otp_screens/time_controller.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:smart_auth/smart_auth.dart';
import '../../util/app_utils.dart';
import 'otp_input.dart';

class OtpResend extends StatefulWidget {
  OtpResend({Key? key, this.phone}) : super(key: key);
  final phone;

  @override
  State<OtpResend> createState() => _OtpResendState();
}

class _OtpResendState extends State<OtpResend> {
  final OtpTimerController _timeController = Get.put(OtpTimerController());
  final PhoneController _phoneController = Get.put(PhoneController());

  String otp = '';
  // late final SmsRetrieverImpl smsRetrieverImpl;

  Timer? _resendTimer;
  RxInt _resendCountdown = 60.obs;
  RxBool _canResendOtp = false.obs;

  Future<void> otpVerify() async {
    var response = await ApiClient.post("Common/verify_otp", {
      "mobile": widget.phone,
      "otp": otp,
    });

    print("response is ${response.body}");
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("response is 200 and ${response.body}");
      Get.to(() => CreateNewPassword(
            mobile: widget.phone,
          ));
    } else {
      AppUtils.snackBar(data['message']);
    }
  }

  Future<void> resendOtp() async {
    var response = await ApiClient.post("Common/resend_otp", {
      "mobile": widget.phone,
    });

    print("response is ${response.body}");

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print("respnse is 200 and ${response.body}");
      AppUtils.snackBar('OTP sent successfully');
      otp = '';
    } else if (response.statusCode == 500) {
      AppUtils.snackBar(data['message']);
    } else {
      AppUtils.snackBar(
        'Something went wrong',
      );
    }
  }

  void _startResendCountdown() {
    _resendCountdown.value = 60;
    _canResendOtp.value = false;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        _resendCountdown--;
      } else {
        _canResendOtp.value = true;
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    // smsRetrieverImpl = SmsRetrieverImpl(SmartAuth());
    _startResendCountdown();
    super.initState();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }

  void _resendOtp() async {
    if (_canResendOtp.value) {
      await resendOtp();
      AppUtils.snackBar("OTP resent to ${widget.phone}");
      _startResendCountdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Otp Verification",
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _timeController.otpKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                9.h.heightBox,
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'A 4 Digit PIN has been sent to Your',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ).p2(),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'phone no. Enter it below to continue',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ).p1(),
                4.h.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      length: 4,
                      keyboardType: TextInputType.number,
                      // smsRetriever: smsRetrieverImpl,
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(30, 60, 87, 1),
                            fontWeight: FontWeight.w600),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(234, 239, 243, 1)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(30, 60, 87, 1),
                            fontWeight: FontWeight.w600),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(234, 239, 243, 1)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ).copyDecorationWith(
                        border:
                            Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      submittedPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(30, 60, 87, 1),
                            fontWeight: FontWeight.w600),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(234, 239, 243, 1)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ).copyWith(
                        decoration: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(30, 60, 87, 1),
                              fontWeight: FontWeight.w600),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(234, 239, 243, 1)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ).decoration!.copyWith(
                              color: Color.fromRGBO(234, 239, 243, 1),
                            ),
                      ),
                      onChanged: (value) {
                        print(value);
                        otp = value;
                        for (int i = 0; i < value.length; i++) {
                          _timeController.otp[i].text = value[i];
                        }
                      },
                    ),
                  ],
                ),
                5.h.heightBox,
                Obx(
                  () => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Didn’t get any otp? ".text.make(),
                      5.widthBox,
                      GestureDetector(
                        onTap: _canResendOtp.value ? _resendOtp : null,
                        child: Text(
                          _canResendOtp.value
                              ? "Resend OTP"
                              : "Resend OTP in $_resendCountdown sec",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: _canResendOtp.value
                                ? appthemColor
                                : Colors.grey,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                5.h.heightBox,
                InkWell(
                    onTap: () async {
                      if (otp.length == 4) {
                        // _timeController.checkValidation(phone);
                        print("otp: $otp");
                        await otpVerify();
                      } else {
                        AppUtils.snackBar('Please enter 4 digit otp');
                      }
                      // Get.to(const CreateNewPassword());
                    },
                    child: Container(
                      height: 52,
                      width: 90.w,
                      decoration: BoxDecoration(
                        color: appthemColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: 'VERIFY'
                          .text
                          .size(10.sp)
                          .letterSpacing(1.5)
                          .bold
                          .white
                          .make()
                          .centered(),
                    )
                    // .onInkTap(() {
                    //   _timeController.otpdigits();

                    //   _timeController.checkValidation(phone);
                    //   // _timeController.
                    //   //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_timeController.result.toString())));
                    //   //
                    // }),
                    ),
                // Obx(() => Text(_timeController.elapsedTime.value)),
                // Align(
                //         alignment: Alignment.centerRight,
                //         child: "Resend OTP".text.black.size(11.sp).end.make())
                //     .pSymmetric(h: 8.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SmsRetrieverImpl implements SmsRetriever {
//   const SmsRetrieverImpl(this.smartAuth);

//   final SmartAuth smartAuth;

//   @override
//   Future<void> dispose() {
//     return smartAuth.removeSmsListener();
//   }

//   @override
//   Future<String?> getSmsCode() async {
//     final res = await smartAuth.getSmsCode(
//       useUserConsentApi: true,
//     );
//     if (res.succeed && res.codeFound) {
//       return res.code!;
//     }
//     return null;
//   }

//   @override
//   bool get listenForMultipleSms => false;
// }
