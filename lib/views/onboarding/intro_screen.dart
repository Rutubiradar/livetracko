import 'dart:developer';

import 'package:cws_app/util/colors.dart';
import 'package:cws_app/views/onboarding/onboarding.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../services/user_services.dart';
import '../../util/app_storage.dart';
import '../login/login_screens.dart';
import '../main_screen/main_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final userId = AppStorage.getUserId();
    log("User Id: $userId");
    if (userId.isNotEmpty) {
      UserServices.instance.init();
      Future.delayed(const Duration(milliseconds: 600), () {
        Get.offAll(() => const MainScreen());
      });
    } else {
      Get.offAll(() => CustomerLoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // const Spacer(),
          Center(
            child: Image.asset(
              "assets/main_logo.jpg",
              width: 45.w,
            ),
          ),
        ],
      ),
    );
  }
}
