import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:cws_app/views/cart_screen/cart_page.dart';
import 'package:cws_app/views/discover/medicine_screen.dart';
import 'package:cws_app/views/discover/recharge_screen.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:cws_app/widgets/drower_box.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../util/app_utils.dart';
import '../discover/discover_screens.dart';
import '../discover/discover_screens_test.dart';

GlobalKey<ScaffoldState> _key = GlobalKey();

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "lib/assets/asset/jeans.png",
      "lib/assets/asset/paint.png",
      "lib/assets/asset/googles.png",
      "lib/assets/asset/blue frock.png",
      "lib/assets/asset/gloubs.png",
      "lib/assets/asset/phone.png",
      "lib/assets/asset/shooes.png",
      "lib/assets/asset/watches.png",
      "lib/assets/asset/earphone.png",
      "lib/assets/asset/paint.png",
    ];

    List<String> baner1 = [
      "lib/assets/asset/slide-1.png",
      "lib/assets/asset/slide2.png",
      "lib/assets/asset/slide3.png",
    ];

    List<String> baner2 = [
      "lib/assets/asset/shoeshop.png",
      "lib/assets/asset/menshop.png",
      "lib/assets/asset/womenshop.png",
      "lib/assets/asset/kidshop.png",
      "lib/assets/asset/mobileshop.png",
    ];
    List<String> indemand = [
      "lib/assets/asset/indemand1.png",
      "lib/assets/asset/indemand2.png",
      "lib/assets/asset/indemand3.png",
      "lib/assets/asset/indemand4.png",
    ];

    List<String> baner3 = [
      "lib/assets/asset/trading_girl.png",
      "lib/assets/asset/trading_legshoes.png",
      "lib/assets/asset/trading_shirts.png",
      "lib/assets/asset/trading_watches.png",
    ];

    List<String> baner4 = [
      "lib/assets/asset/iwatch.png",
      "lib/assets/asset/ipodeear.png",
      "lib/assets/asset/shirt.png",
      "lib/assets/asset/shoes.png",
    ];

    List<String> baner5 = [
      "lib/assets/asset/lakme.png",
      "lib/assets/asset/lakme3.png",
      "lib/assets/asset/face-cream-oil.png",
      "lib/assets/asset/lakme2.png",
    ];

    List<String> baner6 = [
      "lib/assets/asset/pouch-amul-original-.png",
      "lib/assets/asset/amul-original-ih.png",
      "lib/assets/asset/300-dark-hazelnut-chocolate.png",
      "lib/assets/asset/cheese-spread-yummy.png",
    ];

    List<String> baner7 = [
      "lib/assets/asset/7-8-years-blueshrug.png",
      "lib/assets/asset/blackscuit.png",
      "lib/assets/asset/bluefrock2.png",
      "lib/assets/asset/girlstyle.png",
    ];

    List<String> baner8 = [
      "lib/assets/asset/yes-semi-stitched-amira-red-.png",
      "lib/assets/asset/yes-unstitched.png",
      "lib/assets/asset/fabwomen-unstitched-.png",
      "lib/assets/asset/buke-yellow-combo-tashvir.png",
    ];

    List<String> baner9 = [
      "lib/assets/asset/cream-original-t.png",
      "lib/assets/asset/sandel.png",
      "lib/assets/asset/jorden33.png",
      "lib/assets/asset/shoesking.png",
    ];

    List<String> baner10 = [
      "lib/assets/asset/apple-iphone-12.png",
      "lib/assets/asset/g60-phone.png",
    ];

    List<String> banner2text1 = [
      'Sale',
      'Men',
      'Women',
      'kids',
      'Mobiles',
    ];
    List<String> banner3text1 = ['Redfrock', 'Legshoes', 'Shirts', 'watches'];
    List<String> text = [
      'Women',
      'Glasses',
      'Exclusive',
      'Dresses',
      'Pants',
      'New',
      'Short',
      'Gloves',
      'Winter',
      '50% OFF',
    ];

    List<String> banner2text2 = [
      'Extra 30 % Off',
      'Extra 30 % Off',
      'Extra 30 % Off',
      'Extra 30 % Off',
      'Extra 30 % Off',
      'Extra 30 % Off',
    ];
    List<String> banner3text2 = ['50% OFF', '30% OFF', '20% OFF', '35% OFF'];

    List<String> banner4text1 = [
      'Smart Watch',
      'Bluetooth',
      'Casual Shirt',
      'Running Shoes'
    ];
    List<String> banner4text2 = [
      'Min.70% OFF',
      'Min.60% OFF',
      'Min.50% OFF',
      'Min.70% OFF'
    ];
    List<String> banner4text3 = [
      'IP68 Bluetooth 4.0 ios 8.0+\n Android 4.4+live',
      'Lidht Weighted  Noice\n Cancellation Earphione\n Bluetooth',
      'Man Slim Fit Checkered\n Cut Away Coller Casual Shirt',
      'Buy Oora  Grey Running Shoes\n'
          'for Men Online at a Discounted\n'
          'price'
    ];
    List<String> banner5text1 = [
      'lakme Rose Face',
      'DPMD mekup kit combo',
      'WOW SKIN SCIENCE',
      'Ricerca Makeup Beauty'
    ];
    List<String> banner5text2 = [
      'Power Compact',
      'SET OF 27 COMPLETE\n'
          'MAKUP PRODUCTS',
      'Vitamin C Face Cream',
      'Black Waterproof Kajal'
    ];

    List<String> banner5text3 = [
      '₹152 10% off',
      '₹1,058 10% off',
      '₹509 15% off',
      '₹239 29% off'
    ];

    List<String> banner6text1 = [
      'Amul Ghee 500 ml Pouch',
      'Amul Pasteurised Salted\n'
          'Butter(100g)',
      'Amul DARK + HAZELNUT\n'
          'CHOCOLATE',
      'Amul Plain Cheese\n'
          'Spread (200g)'
    ];
    List<String> banner6text2 = ['₹305', '₹46', '₹372', '₹80'];

    List<String> banner7text1 = ['From', 'From', 'From', 'From'];

    List<String> banner7text2 = ['₹305', '₹46', '₹372', '₹80'];

    List<String> banner8text1 = [
      'Cotton Graphic Print',
      'Satish Embraidered',
      'Printed Mysore Art',
      'Women Float Print'
    ];

    List<String> banner8text2 = [
      'Floral Print',
      'Embelished Cown',
      'Silk Sarees(pink)',
      'Crepe Straight Kurta'
    ];

    List<String> banner8text3 = [
      '₹999  84% 0ff',
      '₹299  85% 0ff',
      '₹254  84% 0ff',
      '₹254  84% 0ff'
    ];

    List<String> banner9text1 = [
      'Women Off White \n'
          'Fluts Serial',
      'Women Blue Flates Sandel',
      'Shoes For Women',
      'Women Tan Flats Sandel'
    ];

    List<String> banner9text2 = [
      '₹999  84% 0ff',
      '₹299  85% 0ff',
      '₹254  84% 0ff',
      '₹254  84% 0ff'
    ];

    List<String> banner10text1 = [
      'iPhone 12 mini',
      'moto g60 at ₹15,999',
    ];

    List<String> banner10text2 = [
      'Powerfully Packed',
      'Poco X3 From ₹16,999',
    ];

    List<String> banner10text3 = [
      'From ₹62,999  84% 0ff',
      'Explore Details',
    ];

    int pageIndex = 0;

    return Scaffold(
      // bottomNavigationBar: New_Bottom_Navigation_Bar(),
      key: _key,
      // appBar: App_bar(
      //     start: Image.asset(
      //       'lib/assets/asset/menu.png',
      //       height: 12,
      //     ).onTap(() {
      //       _key.currentState!.openDrawer();
      //     }),
      //     // "Location".text.size(13.sp).semiBold.black.make(),

      //     middle: Text(
      //       'Home',
      //       style: GoogleFonts.poppins(
      //         fontSize: 19,
      //         color: Colors.black,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //     end: CircleAvatar(
      //         radius: (20),
      //         backgroundColor: Colors.white,
      //         child: ClipRRect(
      //           borderRadius: BorderRadius.circular(10.sp),
      //           child: Image.asset("lib/assets/asset/indemand1.png"),
      //         )).onTap(() {
      //       Get.to(AcoountPage());
      //     })),
      drawer: const OpenDrawer(),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100.h,
            width: 100.w,
            decoration: const BoxDecoration(color: Colors.white
                //gradient: gradient2,
                ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  1.h.heightBox,
                  Row(children: [
                    Container(
                      height: 5.4.h,
                      width: 75.w,
                      decoration: BoxDecoration(
                        color: const Color(0xffE3E6EF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        readOnly: true,
                        onTap: () {
                          Get.to(() => Scaffold(
                                appBar: AppBar(
                                  leading: AppUtils.backButton(),
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  title: const Text(
                                    'Search',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                body: Image.asset("assets/download (12).png"),
                              ));
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: Colors.grey,
                          ),
                          fillColor: const Color(0xffffffff),
                          filled: true,
                          hintText: 'Search products',
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 12.sp, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 2.w),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      'lib/assets/asset/menu.png',
                      height: 16,
                    ).onTap(() {
                      _key.currentState!.openDrawer();
                    })
                  ]),
                  10.heightBox,
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset("lib/assets/banner.png"),
                      )),
                  10.heightBox,
                  "Categories".text.xl3.semiBold.black.make(),
                  30.heightBox,
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 140,
                              decoration: BoxDecoration(
                                color: const Color(0xffEE595E),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Positioned(
                                left: 0,
                                right: 0,
                                bottom: 10,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "lib/assets/grocery.png",
                                    ),
                                    "Grocery".text.bold.xl.white.make(),
                                  ],
                                ))
                          ],
                        ).onTap(() {
                          Get.to(() => const DiscoverPage());
                        }),
                      ),
                      20.widthBox,
                      Expanded(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 140,
                              decoration: BoxDecoration(
                                color: const Color(0xff7E39C2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Positioned(
                                left: 0,
                                right: 0,
                                bottom: 10,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "lib/assets/unnamed (3).png",
                                      height: 145,
                                    ),
                                    "Recharge".text.bold.xl.white.make(),
                                  ],
                                )),
                          ],
                        ).onTap(() {
                          Get.to(() => const RechargeScreen());
                        }),
                      ),
                    ],
                  ),
                  30.heightBox,
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 140,
                              decoration: BoxDecoration(
                                color: const Color(0xff912D76),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Positioned(
                                left: 0,
                                right: 0,
                                bottom: 10,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "lib/assets/unnamed (2).png",
                                    ),
                                    "Medicine".text.bold.xl.white.make(),
                                  ],
                                )),
                          ],
                        ).onTap(() {
                          Get.to(() => const MedicineScreen());
                        }),
                      ),
                      20.widthBox,
                      Expanded(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 140,
                              decoration: BoxDecoration(
                                color: const Color(0xffE17200),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Positioned(
                                left: 0,
                                right: 0,
                                bottom: 10,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "lib/assets/unnamed (1).png",
                                      height: 145,
                                    ),
                                    "Food".text.bold.xl.white.make(),
                                  ],
                                )),
                          ],
                        ).onTap(() {
                          Get.to(() => const DiscoverPageTest());
                        }),
                      ),
                    ],
                  ),
                  30.heightBox,
                  Stack(
                    children: [
                      Container(
                        width: 100.w,
                        height: 140,
                        decoration: BoxDecoration(
                          color: const Color(0xffFB295B),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "My Basket".text.bold.xl.white.make(),
                              const Spacer(),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: "2".text.bold.xl.black.make(),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: "".text.bold.xl.black.make(),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: "".text.bold.xl.black.make(),
                                  ),
                                  const CircleAvatar(
                                    backgroundColor: themeColor,
                                    child: Icon(Icons.add),
                                  ),
                                ],
                              ),
                              10.heightBox,
                            ],
                          ),
                        ),
                      ).onTap(() {
                        Get.to(() => const CartPage());
                      }),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Image.asset(
                          "lib/assets/unnamed (5).png",
                          height: 175,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
