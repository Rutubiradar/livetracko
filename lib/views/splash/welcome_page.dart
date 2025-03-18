import 'dart:developer';

import 'package:cws_app/util/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:cws_app/views/login/login_screens.dart';

import '../../widgets/welcomeButton_widget.dart';
import '../main_screen/main_screen.dart';

class WelcomeSplashScreen extends StatefulWidget {
  const WelcomeSplashScreen({super.key});

  @override
  State<WelcomeSplashScreen> createState() => _WelcomeSplashScreenState();
}

class _WelcomeSplashScreenState extends State<WelcomeSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Image.asset("lib/assets/asset/logo.png"),
            ),
            SizedBox(height: 2.h),
            Image.asset("lib/assets/asset/shoping.png"),
            SizedBox(height: 2.h),
            Text(
              "Welcome",
              style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2.h),
            const Center(
              child: Text(
                "Sign up to get started and experience\n great shopping deals",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 4.h),
            WelcomeButtonWidget(
              btnText: "CONTINUE",
              ontap: () {
                Get.to(CustomerLoginScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
