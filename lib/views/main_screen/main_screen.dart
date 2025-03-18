import 'dart:convert';
// import 'dart:ffi';

import 'package:cws_app/Controller/main_screen_controller.dart';
import 'package:cws_app/helper/app_static.dart';
import 'package:cws_app/network/api_client.dart';
import 'package:cws_app/services/user_services.dart';
import 'package:cws_app/util/app_storage.dart';
import 'package:cws_app/util/colors.dart';
import 'package:cws_app/util/constant.dart';
import 'package:cws_app/views/editProfile/edit_profile.dart';
import 'package:cws_app/views/hrms/hrmsScreen.dart';
import 'package:cws_app/views/items/items_screen.dart';
import 'package:cws_app/views/login/login_screens.dart';
import 'package:cws_app/views/map_history.dart';
import 'package:cws_app/views/performace/performance_screen.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:floating_tabbar/Widgets/airoll.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../Controller/location_controller.dart';
import '../../util/app_utils.dart';
import '../about_us/feedback_screen.dart';
import '../about_us/help_screen.dart';
import '../attendance/add_addendance_screen.dart';
import '../attendance/attendance_screen.dart';
import '../collateral/collateral_screen.dart';
import '../da_form/da_generic_form.dart';
import '../editProfile/my_info_screen.dart';
import '../leave/leave_request.dart';
import '../leave/leave_request_new.dart';
import '../notification/Notice_fication.dart';
import '../outlets/add_outlet.dart';
import '../outlets/outlet_pjp.dart';
import '../outlets/outlets_screen.dart';
import '../products/product_screen.dart';
import '../transaction/transaction_screeen.dart';
import '../warehouse/sub_screens/in_stock_screen.dart';
import '../warehouse/warehouse_screen.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String logo = "";
  late LocationService _locationService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () async {
      await checkAttendance();
      AppUtils.greetDialogue();
      await mainScreenController.getDailySales();
      await mainScreenController.salesVisitCount();
      getLogo();
      await checkLocationPermission();
      mainScreenController.getAppInfo();
      getAttendance();
    });
  }

  @override
  void dispose() {
    _locationService.stopLocationUpdates();

    super.dispose();
  }

  Future<void> checkLocationPermission() async {
    await AppUtils.getCurrentPosition();
  }

  Future<void> getAttendance() async {
    String userId = AppStorage.getUserId();
    var response =
        await ApiClient.post('Common/attendance_list', {'emp_id': userId});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final presentList = data['present_list'] as List<dynamic>;

      String today = DateFormat('dd/MM/yyyy').format(DateTime.now());
      for (var e in presentList) {
        print('checking ${e['check_in']} == $today');
        if (DateFormat('dd/MM/yyyy').format(DateTime.parse(e['check_in'])) ==
            today.toString()) {
          print('todays date found ${e['check_in']}');
          staticData.logInTime =
              DateFormat('HH:mm a').format(DateTime.parse(e['check_in']));
        }
      }
    }

    _locationService = LocationService(userId); // Pass employee ID here
    _locationService.startLocationUpdates();
  }

  Future<void> checkAttendance() async {
    final userId = AppStorage.getUserId();
    final response = await ApiClient.post(
      "Common/attendance_check",
      {'emp_id': userId},
    );

    print('response ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = response.body;
      print('user id $userId');

      final decodedData = jsonDecode(data);

      if (decodedData["count"]["attendance_count"] == "0" &&
          decodedData["absent_count"]["absent_count"] == "0") {
        Get.to(() => AddAttendanceScreen());
      } else if (decodedData["count"]["attendance_count"] != "0") {
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text('Attendance Already Marked')));
      } else if (decodedData["absent_count"]["absent_count"] != "0") {
        Get.dialog(
          WillPopScope(
            onWillPop: () async {
              SystemNavigator.pop(); // Close the app on back button press
              return false; // Prevent dialog from closing
            },
            child: AlertDialog(
              title: Text(
                "Absent Today",
                style: TextStyle(color: Colors.black),
              ),
              content: Text(
                "You are absent today",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              actions: [
                TextButton(
                  onPressed: () async {
                    await AppStorage.clearAll();
                    Get.offAll(() => CustomerLoginScreen());
                  },
                  child: Text("Logout"),
                ),
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop(); // Close the app
                  },
                  child: Text("Close App"),
                ),
              ],
            ),
          ),
          barrierDismissible:
              false, // Prevents dialog from closing on outside touch
        );
      } else {
        AppUtils.snackBar("Failed to check attendance, Please try again later.",
            backgroundColor: Colors.green.shade500);
      }
    } else {
      AppUtils.snackBar("Failed to check attendance, Please try again later.",
          backgroundColor: Colors.green.shade500);
    }
  }

  Future<void> checkOut() async {
    String userId = AppStorage.getUserId();
    var body = {'emp_id': userId, 'check_out': DateTime.now().toString()};

    var response = await ApiClient.post('Common/present_mark', body);
    print('checkout done response is ${response.body}');
    if (response.statusCode == 200) {
      print("closing app");
      SystemNavigator.pop();
    }
  }

  Future<void> getLogo() async {
    var headers = {'x-api-key': 'ftc_apikey@'};

    final response = await http.post(
        Uri.parse("${staticData.baseUrl}/Common/websetting"),
        headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print("logo response is 200 and got logo data ");
      if (mounted) {
        setState(() {
          logo = data['websetting_fetch']['value'];
        });
      }
    } else {
      // AppUtils.snackBar("Sales visit count not found, Please try again later.",
      //     backgroundColor: Colors.green.shade500);
    }
  }

  final MainScreenController mainScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            onPressed: () {
              Get.to(() => VisitedPlacesScreen());
            },
            child: ImageIcon(
              AssetImage('assets/location.png'),
              color: kPrimaryColor,
              size: 35,
            )),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer()),
        ),
        backgroundColor: appthemColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          "assets/logo.png",
          color: Colors.white,
          height: 23,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const NoticeFication());
            },
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
          10.widthBox,
        ],
      ),
      drawer: buildDrawer(context),
      body: Column(
        children: [
          Container(
            height: 80,
            decoration: const BoxDecoration(
                color: appthemColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: -50,
                  left: 0,
                  right: 0,
                  top: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Text(
                            "Hello, ${UserServices.instance.userDetails.value.name.toString().split(" ").first}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 5,
                            )
                          ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Expanded(
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Text('Daily Sales',
                              //           style: TextStyle(
                              //               color: Colors.grey.shade700,
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.bold)),
                              //       Text(
                              //           '₹ ${mainScreenController.dailySales.value}',
                              //           style: TextStyle(
                              //               color: appthemColor,
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.bold)),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   height: 50,
                              //   width: 1,
                              //   color: Colors.black12,
                              // ),
                              // Expanded(
                              //   child: Padding(
                              //     padding: const EdgeInsets.symmetric(
                              //         horizontal: 4.0),
                              //     child: Column(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         Text('Monthly Target',
                              //             maxLines: 1,
                              //             overflow: TextOverflow.ellipsis,
                              //             style: TextStyle(
                              //                 color: Colors.grey.shade700,
                              //                 fontSize: 16,
                              //                 fontWeight: FontWeight.bold)),
                              //         Text(
                              //             '₹ ${mainScreenController.target.value}',
                              //             style: TextStyle(
                              //                 color: appthemColor,
                              //                 fontSize: 16,
                              //                 fontWeight: FontWeight.bold)),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // Container(
                              //   height: 50,
                              //   width: 1,
                              //   color: Colors.black12,
                              // ),
                              Container(
                                alignment: Alignment.center,
                                width: 70,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Visit',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text(mainScreenController.salesVisit.value,
                                        style: TextStyle(
                                            color: appthemColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => OutletsPjpScreen());
                          },
                          child: const Card(
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.work_rounded,
                                    size: 50, color: appthemColor),
                                SizedBox(height: 10),
                                Text('Patient Detail',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.to(() => const OutletsScreen());
                        //   },
                        //   child: const Card(
                        //     elevation: 5,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Icon(Icons.store,
                        //             size: 50, color: appthemColor),
                        //         SizedBox(height: 10),
                        //         Text('Outlets',
                        //             style: TextStyle(
                        //                 color: Colors.black, fontSize: 16)),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        // GestureDetector(
                        //   onTap: () {
                        //     Get.to(() => const ItemsScreen());
                        //   },
                        //   child: Card(
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Icon(Icons.indeterminate_check_box_rounded, size: 50, color: appthemColor),
                        //         SizedBox(height: 10),
                        //         Text('Items', style: TextStyle(color: Colors.black, fontSize: 16)),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const AttendanceScreen());
                          },
                          child: const Card(
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.fingerprint_rounded,
                                    size: 50, color: appthemColor),
                                SizedBox(height: 10),
                                Text('Attendance',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.to(() => WarehouseScreen());
                        //   },
                        //   child: const Card(
                        //     elevation: 5,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Icon(Icons.warehouse_rounded,
                        //             size: 50, color: appthemColor),
                        //         SizedBox(height: 10),
                        //         Text('WareHouse',
                        //             style: TextStyle(
                        //                 color: Colors.black, fontSize: 16)),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        // GestureDetector(
                        //   onTap: () {
                        //     Get.to(() => const TransactionScreen(
                        //           allTransaction: true,
                        //           outletId: "0",
                        //         ));
                        //   },
                        //   child: const Card(
                        //     elevation: 5,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Icon(Icons.sticky_note_2_rounded,
                        //             size: 50, color: appthemColor),
                        //         SizedBox(height: 10),
                        //         Text('Transactions',
                        //             style: TextStyle(
                        //                 color: Colors.black, fontSize: 16)),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        // GestureDetector(
                        //   onTap: () {
                        //     Get.to(() => const HelpScreen());
                        //   },
                        //   child: const Card(
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Icon(Icons.help_rounded,
                        //             size: 50, color: appthemColor),
                        //         SizedBox(height: 10),
                        //         Text('Help',
                        //             style: TextStyle(
                        //                 color: Colors.black, fontSize: 16)),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.to(() => ProductsScreen());
                        //   },
                        //   child: const Card(
                        //     elevation: 5,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Icon(Icons.shopping_bag,
                        //             size: 50, color: appthemColor),
                        //         SizedBox(height: 10),
                        //         Text('All Products',
                        //             style: TextStyle(
                        //                 color: Colors.black, fontSize: 16)),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        GestureDetector(
                          onTap: () {
                            Get.to(() => hrmsScreen());
                          },
                          child: Card(
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.groups_3,
                                    size: 50, color: appthemColor),
                                SizedBox(height: 10),
                                Text('HRMS',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        // Handle button tap here
                        showCheckOutDialogue();
                        print("Checkout after marking presence");
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 17),
                        decoration: BoxDecoration(
                          color:
                              kPrimaryColor, // A professional green color for confirmation
                          borderRadius:
                              BorderRadius.circular(30), // Rounded corners
                          // border: Border.all(
                          //     color: Colors.white,
                          //     width: 0), // White border for emphasis
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26, // Shadow color
                              offset: Offset(0, 6), // Shadow position
                              blurRadius: 5, // Shadow blur
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons
                                  .personal_injury_rounded, // Presence confirmation icon
                              color: Colors.white, // Icon color
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Checkout', // Button text
                              style: TextStyle(
                                color: Colors.white, // Text color
                                fontSize: 18, // Text size
                                fontWeight: FontWeight.bold, // Text weight
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Link
                  // const Spacer(),
                  // const SizedBox(height: 10),
                  const Divider(color: Colors.black12),
                  // const SizedBox(height: 10),
                  Text("Logged in at ${staticData.logInTime}",
                      style: TextStyle(color: Colors.black54, fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    final userProfile = AppStorage.getUserDetails();
    getLogo();
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: appthemColor),
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.network(staticData.logoUrl + logo,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    )),
                          )
                        ],
                      ),
                      // const Spacer(),
                      // Image.asset("assets/logo.png",
                      //     height: 25, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 10),
                  //profile tile
                  Obx(
                    () => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.white,
                        child: UserServices.instance.userDetails.value
                                        .profileImage !=
                                    null &&
                                userProfile.profileImage != ""
                            ? CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    staticData.profileUrl +
                                        UserServices.instance.userDetails.value
                                            .profileImage
                                            .toString()),
                              )
                            : Text(
                                UserServices.instance.userDetails.value.name
                                    .toString()
                                    .split(" ")
                                    .first[0]
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: appthemColor,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold)),
                      ),
                      title: Text(
                          '${UserServices.instance.userDetails.value.name}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        "${UserServices.instance.userDetails.value.email}",
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        Get.back();
                        Get.to(() => MyInfoScreen());
                      },
                    ),
                  ),
                ],
              )),
          //menu items

          ListTile(
              leading: const Icon(Icons.money),
              title: const Text('Product Catalogue',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const CollateralScreen());
              }),

          ListTile(
              leading: const Icon(Icons.sticky_note_2_outlined),
              title: const Text('Daily Expenses',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => DAGenericFormScreen());
              }),
          ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Performance',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => PerformanceScreen());
              }),

          ListTile(
              leading: const Icon(Icons.add_business_rounded),
              title: const Text('Add Outlet',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const AddOutletScreen());
              }),
          ListTile(
              leading: const Icon(Icons.work_history_rounded),
              title: const Text('Leave Request',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const CustomTabBarDemo());
              }),
          ListTile(
              leading: const Icon(Icons.feedback_rounded),
              title: const Text('Feedback',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => FeedBackScreen());
              }),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              // GestureDetector(
              //   onTap: () {
              //     Get.back();
              //     Get.to(() => const MyInfoScreen());
              //   },
              //   child: const Column(
              //     children: [
              //       Icon(Icons.event_note_outlined),
              //       Text("My Info"),
              //     ],
              //   ),
              // ),
              // Container(
              //   height: 30,
              //   width: 1,
              //   color: Colors.black12,
              // ),
              // Expanded(
              //   child: GestureDetector(
              //     onTap: () {
              //       Get.to(() => const AddAttendanceScreen(),
              //           transition: Transition.downToUp);
              //     },
              //     child: const Column(
              //       children: [
              //         Icon(Icons.email_outlined),
              //         Text("EOD"),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),

          const SizedBox(height: 10),
          const Divider(color: Colors.black12),
          ListTile(
              // trailing: GestureDetector(
              //   onTap: () {
              //     Get.to(() => const HelpScreen());
              //   },
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       const Text('Help',
              //           style: TextStyle(color: Colors.black54, fontSize: 14)),
              //       5.widthBox,
              //       const Icon(Icons.help_outline_rounded,
              //           color: Colors.black54),
              //     ],
              //   ),
              // ),
              horizontalTitleGap: 5,
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.red.shade700,
              ),
              title: Text('Logout',
                  style: TextStyle(
                      color: Colors.red.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              onTap: () async {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.noHeader,
                  animType: AnimType.rightSlide,
                  title: 'Logout',
                  desc: 'Are you sure you want to logout?',
                  btnCancelOnPress: () {
                    Navigator.of(context).pop();
                  },
                  btnOkOnPress: () async {
                    Get.defaultDialog(
                      barrierDismissible: false,
                      onWillPop: () async {
                        await AppStorage.clearAll();
                        Get.offAll(() => CustomerLoginScreen());
                        return true;
                      },
                      title: "Have a nice day!",
                      content: Column(
                        children: [
                          Lottie.asset('assets/Animations/bye_smile.json',
                              height: 100, width: 100),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            await AppStorage.clearAll();
                            Get.offAll(() => CustomerLoginScreen());
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                ).show();
              }),
          const Divider(color: Colors.black12),
          Text("Version ${mainScreenController.appVersion.value}",
              style: TextStyle(color: Colors.black54, fontSize: 14)),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> showCheckOutDialogue() async {
    Get.dialog(
      AlertDialog(
        // backgroundColor: Colors.red.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: double.infinity,
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Check Out',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.personal_injury_sharp,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
        content: SizedBox(
          height: MediaQuery.of(Get.context!).size.height * 0.07,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Are you sure,\ndo you want to checkout?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                // style: TextButton.styleFrom(
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   backgroundColor:
                //       Colors.grey[200], // Background color for button
                // ),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'No',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              TextButton(
                // style: TextButton.styleFrom(
                //   // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   backgroundColor: Colors.redAccent
                //       .withOpacity(0.2), // Lighter red background
                // ),
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text(
                  'Close App',
                  style: TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
              ),
              TextButton(
                // style: TextButton.styleFrom(
                //   // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   backgroundColor:
                //       Colors.green.withOpacity(0.2), // Lighter green background
                // ),
                onPressed: () async {
                  await checkOut();
                },
                child: Text(
                  'Yes',
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
