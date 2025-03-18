import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:cws_app/views/discover/medicine_tabs.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:velocity_x/velocity_x.dart';

class MedicineScreen extends StatelessWidget {
  const MedicineScreen({Key? key}) : super(key: key);

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
                  15.heightBox,
                  Row(
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 17,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.download,
                              color: Colors.white,
                            ),
                          ),
                          10.widthBox,
                          const Text(
                            'Add Prescription',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                          .pSymmetric(
                            h: 20,
                            v: 8,
                          )
                          .box
                          .withRounded()
                          .border(color: Colors.blue)
                          .make(),
                      const Spacer(),
                      const CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  10.heightBox,
                  // Image.asset(
                  //   'lib/assets/banner2.png',
                  //   height: 20.h,
                  //   width: 100.w,
                  // ),
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
                          text: 'Vitamin',
                        ),
                        Tab(
                          text: 'Beta Lac',
                        ),
                        Tab(
                          text: 'Antibiotic',
                        ),
                        Tab(
                          text: 'Antacids',
                        ),
                      ],
                    ),
                  ),
                  2.h.heightBox,
                  const Expanded(
                      child: TabBarView(
                    children: [
                      Center(
                        child: MedicineTab(),
                      ),
                      Center(
                        child: MedicineTab(),
                      ),
                      Center(
                        child: MedicineTab(),
                      ),
                      Center(
                        child: MedicineTab(),
                      ),
                      Center(
                        child: MedicineTab(),
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
