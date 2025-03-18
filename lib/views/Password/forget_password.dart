import 'dart:convert';

import 'package:cws_app/network/api_client.dart';
import 'package:cws_app/views/otp_screens/otp_resend.dart';
import 'package:cws_app/widgets/welcomeButton_widget.dart';
import 'package:floating_tabbar/Widgets/airoll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../util/app_utils.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();

  Future<void> getOtp() async {
    var response = await ApiClient.post("Common/send_otp", {
      "mobile": _phoneController.text.trim(),
    });

    print("response is ${response.body}");
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print("respnse is 200 and ${response.body}");
      Get.to(() => OtpResend(
            phone: _phoneController.text,
          ));
    } else if (response.statusCode == 500) {
      AppUtils.snackBar(data['message']);
    } else {
      AppUtils.snackBar(
        'Something went wrong',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Forget Password ",
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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              Center(
                  child: Text(
                "Enter your registered mobile number.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 13.sp),
              )),
              SizedBox(
                height: 5.h,
              ),
              TextFormField(
                validator: (value) {
                  if (value == '') {
                    return ' please enter Mobile No';
                  }
                  return null;
                },
                controller: _phoneController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Mobile No',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26, width: 0.5),
                  ),
                ),
              ),
              15.heightBox,
              // TextFormField(
              //   obscureText: true,
              //   // validator: _loginController.validatepassword,
              //   // controller: _loginController.password,
              //   decoration: const InputDecoration(
              //     hintText: 'Password',
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black26, width: 0.5),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black26, width: 0.5),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 5.h,
              ),
              WelcomeButtonWidget(
                btnText: "Get OTP",
                ontap: () async {
                  if (_formKey.currentState!.validate()) {
                    await getOtp();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
