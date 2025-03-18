import 'package:cws_app/views/onboarding/intro.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../util/colors.dart';
import '../login/login_screens.dart';

class Onbording extends StatefulWidget {
  const Onbording({Key? key}) : super(key: key);

  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currtpage = 0;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);

    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: contents.length,
        onPageChanged: (int index) {
          setState(() {
            currtpage = index;
          });
        },
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/circle.png'),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(contents[i].image!, height: 200),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(contents[i].title!,
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        color: const Color.fromARGB(255, 0, 7, 111),
                        fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  contents[i].description!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0XFF7D7D7D),
                  ),
                ).pSymmetric(h: 10, v: 10),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: const CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    radius: 30,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ).onTap(() {
                    _controller?.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                    if (currtpage == 2) {
                      Get.to(() => CustomerLoginScreen());
                    }
                  }),
                ),
                const Spacer(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        contents.length, (index) => buildDot(index, context))),
              ],
            ),
          );
        },
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currtpage == index ? 10 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currtpage == index ? appthemColor : const Color(0xff979797),
      ),
    );
  }
}
