import 'dart:convert';

import 'package:cws_app/network/api_client.dart';
import 'package:cws_app/widgets/welcomeButton_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../util/app_utils.dart';
import '../login/login_screens.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({Key? key, required this.mobile}) : super(key: key);

  final mobile;
  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  RxBool showPass = false.obs;

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> resetPassword() async {
    var response = await ApiClient.post("Common/password_set", {
      "mobile": widget.mobile,
      "password": _passwordController.text,
    });

    print("response is ${response.body}");
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print("response is 200 and ${response.body}");
      AppUtils.snackBar('Password reset successfully');
      Get.offAll(() => CustomerLoginScreen());
    } else if (response.statusCode == 500) {
      AppUtils.snackBar(data['message']);
    } else {
      AppUtils.snackBar('Something went wrong');
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
          "Reset Password",
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
          child: Obx(
            () => Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "New Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          showPass.value = !showPass.value;
                        },
                        icon: Icon(Icons.remove_red_eye)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                  ),
                  obscureText: showPass.value ? false : true,
                  validator: _validatePassword,
                ),
                SizedBox(
                  height: 3.h,
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          showPass.value = !showPass.value;
                        },
                        icon: Icon(Icons.remove_red_eye)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                  ),
                  obscureText: showPass.value ? false : true,
                  validator: _validateConfirmPassword,
                ),
                SizedBox(
                  height: 10.h,
                ),
                WelcomeButtonWidget(
                  btnText: "Confirm",
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      // Proceed to the next screen or perform any action
                      // Get.to(New_Bottom_Navigation_Bar());
                      resetPassword();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
