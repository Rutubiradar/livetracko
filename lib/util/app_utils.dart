import 'package:cws_app/util/app_storage.dart';
import 'package:floating_tabbar/Widgets/airoll.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppUtils {
  static snackBar(
    String message, {
    Color textColor = Colors.white,
    Color backgroundColor = Colors.black,
  }) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
      ),
    );
  }

  static void showLoader() {
    Get.dialog(
      PopScope(
        canPop: false,
        onPopInvoked: (value) {},
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.6),
      barrierDismissible: false,
    );
  }

  static void hideLoader() {
    Get.back();
  }

  static void showCenteredSnackbar(String title, String message, Color color) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final overlay = Overlay.of(Get.overlayContext!);
      final overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: MediaQuery.of(context).size.height / 2 - 50,
          left: 20,
          right: 20,
          child: Material(
            // color: color,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      overlay!.insert(overlayEntry);

      Future.delayed(Duration(seconds: 3), () {
        overlayEntry.remove();
      });
    });
  }

  static void warningDialogue(String content) {
    Get.dialog(
      AlertDialog(
        // title: Text(''),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              content,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       Get.back();
        //     },
        //     child: Text('No'),
        //   ),
        //   TextButton(
        //     onPressed: () {
        //       Get.back();
        //     },
        //     child: Text('Yes'),
        //   ),
        // ],
      ),
    );
  }

  static getDateTimeFormatted(String date) {
    //formated in 12 May 2021
    return "${date.split('-')[2]} ${getMonth(date.split('-')[1])} ${date.split('-')[0]}";
  }

  static getMonth(String month) {
    switch (month) {
      case '01':
        return 'Jan';
      case '02':
        return 'Feb';
      case '03':
        return 'Mar';
      case '04':
        return 'Apr';
      case '05':
        return 'May';
      case '06':
        return 'Jun';
      case '07':
        return 'Jul';
      case '08':
        return 'Aug';
      case '09':
        return 'Sep';
      case '10':
        return 'Oct';
      case '11':
        return 'Nov';
      case '12':
        return 'Dec';
      default:
        return '';
    }
  }

  static Future<void> launchUrlFunction(url) async {
    if (!await launchUrlString(url)) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<Position?> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied.
        openAppSettings();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied.
      showPermissionDeniedDialog(Get.context!);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Try to get the last known position first.
    Position? lastKnownPosition = await Geolocator.getLastKnownPosition();

    if (lastKnownPosition != null) {
      // Return last known position immediately
      return lastKnownPosition;
    } else {
      // No last known position available, get the current position with reduced accuracy
      return await Geolocator.getCurrentPosition(
        desiredAccuracy:
            LocationAccuracy.high, // Low accuracy for faster response
        timeLimit: Duration(seconds: 5), // Shorter timeout for quick response
      );
    }
  }

  static void showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permission Denied'),
          content: Text(
              'Location permissions are permanently denied. Please enable location services or grant permissions.'),
          actions: <Widget>[
            TextButton(
              child: Text('Enable Location'),
              onPressed: () {
                openLocationSettings();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Give Permission'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Close App'),
              onPressed: () {
                closeApp();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  // static void openAppSettings() async {
  //   await PermissionHandler().openAppSettings();
  // }

  static void closeApp() {
    // Show a message to close the app manually.
    // Note: Closing the app programmatically is not recommended.
    SystemNavigator.pop();
    print('Please close the app manually.');
  }

  static void greetDialogue() {
    if (greetShown) return;
    var userDetails = AppStorage.getUserDetails();
    var userName = userDetails.name ?? '';
    int hour = DateTime.now().hour;
    String greeting = _getGreeting(hour);
    String emoji = _getEmoji(hour);

    Get.defaultDialog(
      title: "$emoji $greeting $userName!",
      content: Column(
        children: [
          // Text("$emoji $greeting"),
          Text('How are you doing today?'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            greetShown = true;
          },
          child: Text('Close'),
        ),
      ],
    );
  }

  static String _getGreeting(int hour) {
    if (hour >= 0 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  static String _getEmoji(int hour) {
    if (hour >= 0 && hour < 12) {
      return '🌞'; // Sun emoji for morning
    } else if (hour >= 12 && hour < 18) {
      return '☀️'; // Sun emoji for afternoon
    } else {
      return '🌙'; // Moon emoji for evening
    }
  }

  static IconButton backButton() {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
    );
  }

  static bool greetShown = false;
}
