import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cws_app/views/main_screen/main_screen.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import 'Controller/main_screen_controller.dart';
import 'Controller/new_sale_controller.dart';
import 'helper/app_static.dart';
import 'services/user_services.dart';
import 'util/app_storage.dart';
import 'views/login/login_screens.dart';

void main() async {
  await GetStorage.init("CWS");

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    Get.put(CartController());
    Get.put(MainScreenController());

    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final connectivity = Connectivity();
  // final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CWS',
        theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.blue,
            primaryColor: Colors.white,
            dialogBackgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white),
        // home: WelcomeSplashScreen(),
        home: PlaceholderScreen(),
        // builder: (context, child) {
        //   return StreamBuilder<List<ConnectivityResult>>(
        //     stream: connectivity.onConnectivityChanged,
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         var hasConnection = snapshot.data != null &&
        //                 snapshot.data!.contains(ConnectivityResult.mobile) ||
        //             snapshot.data!.contains(ConnectivityResult.wifi);
        //         return Stack(
        //           children: [
        //             if (child != null)
        //               Positioned(
        //                 top: 0,
        //                 left: 0,
        //                 right: 0,
        //                 bottom: 0,
        //                 child: child,
        //               ),
        //             if (!hasConnection)
        //               const Positioned(
        //                 top: 0,
        //                 left: 0,
        //                 right: 0,
        //                 bottom: 0,
        //                 child: NoInternetWidget(),
        //               ),
        //           ],
        //         );
        //       }
        //       return Scaffold(
        //         backgroundColor: Colors.white,
        //         body: Center(
        //           child: FadeIn(child: Image.asset('assets/main_logo.jpg')),
        //         ),
        //       );
        //     },
        //   );
        // },
      );
    });
  }
}

class PlaceholderScreen extends StatefulWidget {
  const PlaceholderScreen({super.key});

  @override
  State<PlaceholderScreen> createState() => _PlaceholderScreenState();
}

class _PlaceholderScreenState extends State<PlaceholderScreen> {
  var userId = ''.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  void checkUser() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final storedUserId = AppStorage.getUserId();
        staticData.baseUrl = AppStorage.getBaseUrl();
        staticData.comapanyName = AppStorage().getCompanyName();

        log("User Id: $storedUserId");
        if (storedUserId.isNotEmpty) {
          UserServices.instance.init();
          userId.value = storedUserId;
          Get.offAll(() => const MainScreen());
        } else {
          Get.offAll(() => CustomerLoginScreen());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Center(
        //   child: FadeIn(child: Image.asset('assets/main_logo.jpg')),
        // ),
        );
  }
}

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          color: Colors.white,
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/no_internet.png"),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "No Network",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "It’s look like you are not connected to \ninternet. Check your network.",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: appthemColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fixedSize: Size(context.width * 0.9, 54)),
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh, color: Colors.white),
                    SizedBox(width: 10),
                    Text("Try Again"),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
