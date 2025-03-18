import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:cws_app/views/discover/all.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:velocity_x/velocity_x.dart';

class DiscoverPageTest extends StatelessWidget {
  const DiscoverPageTest({Key? key}) : super(key: key);

  get tabController => null;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 26,
                        )),
                    Container(
                      height: 5.4.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: const Color(0xffE3E6EF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: Colors.grey,
                          ),
                          hintText: 'Search products',
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 12.sp, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 2.w),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  2.h.heightBox,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/banner3.png",
                    ),
                  ),
                  2.h.heightBox,
                  SizedBox(
                    height: 30,
                    width: 100.w,
                    child: TabBar(
                      // padding: EdgeInsets.zero,
                      unselectedLabelColor: Colors.grey.shade500,
                      indicatorColor: appthemColor,
                      isScrollable: true,

                      labelColor: Colors.black,

                      labelPadding: const EdgeInsets.only(
                          top: 0, bottom: 3, left: 8, right: 8),
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: const [
                        Tab(
                          text: 'All',
                        ),
                        Tab(
                          text: 'Vegetable',
                        ),
                        Tab(
                          text: 'Fruits',
                        ),
                        Tab(
                          text: 'Brevages',
                        ),
                        Tab(
                          text: 'Frozen Item',
                        ),
                      ],
                    ),
                  ),
                  2.h.heightBox,
                  const Expanded(
                      child: TabBarView(
                    children: [
                      Center(
                        child: All(),
                      ),
                      Center(
                        child: All(),
                      ),
                      Center(
                        child: All(),
                      ),
                      Center(
                        child: All(),
                      ),
                      Center(
                        child: All(),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          )),
    );
  }
}
