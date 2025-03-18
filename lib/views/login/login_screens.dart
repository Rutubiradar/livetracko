import 'package:animate_do/animate_do.dart';
import 'package:cws_app/util/app_utils.dart';
import 'package:cws_app/views/Password/forget_password.dart';
import 'package:cws_app/widgets/welcomeButton_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main_screen/main_screen.dart';
import 'controller/login_controller.dart';

class CustomerLoginScreen extends StatelessWidget {
  CustomerLoginScreen({super.key});

  final LoginController _loginController = Get.put(LoginController());

  RxBool showPass = false.obs;
  Future<void> _launchUrl(String _url) async {
    launchUrl(Uri.parse(_url));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FadeIn(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _loginController.loginform,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(7),
              child: Column(
                children: [
                  5.h.heightBox,
                  Center(
                    child: Image.asset(
                      "assets/main_logo.jpg",
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 1,
                    width: MediaQuery.of(context).size.height * 0.94,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 2.h,
                      ),

                      2.h.heightBox,
                      TextFormField(
                        validator: (value) {
                          if (value == '') {
                            return 'Please enter Mobile No';
                          }
                          return null;
                        },
                        maxLength: 10,
                        controller: _loginController.username,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Mobile Number',
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8), // Adjust padding
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('🇮🇳 +91',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black26, width: 0.5),
                          ),
                        ),
                      ).pSymmetric(h: 4.w),

                      15.heightBox,
                      Obx(
                        () => TextFormField(
                          obscureText: showPass.value ? false : true,
                          validator: _loginController.validatepassword,
                          controller: _loginController.password,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  showPass.value = !showPass.value;
                                },
                                icon: !showPass.value
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                            border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 0.5),
                            ),
                          ),
                        ).pSymmetric(h: 4.w),
                      ),
                      5.h.heightBox,
                      Obx(
                        () => WelcomeButtonWidget(
                          isloading: _loginController.isLoading.value,
                          btnText: "SIGN IN",
                          ontap: () {
                            _loginController.checkLogin();
                          },
                        ),
                      ),
                      2.h.heightBox,
                      InkWell(
                        onTap: () {
                          Get.dialog(AlertDialog(
                            title: const Center(child: Text('Alert')),
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: const Center(
                                child: Text(
                                    'Please contact your Manager for Assistant'),
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('Ok'))
                            ],
                          ));
                        },
                        child: Text(
                          "Forget Password?",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 0, 5, 69)),
                        ),
                      ).px12(),
                      16.h.heightBox,
                      // Spacer(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: TextButton(
                onPressed: () {
                  _launchUrl('http://livetracko.com/');
                },
                child: const Text('www.livetracko.com'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
