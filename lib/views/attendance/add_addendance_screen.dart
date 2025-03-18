import 'package:camera/camera.dart';
import 'package:cws_app/helper/app_static.dart';
import 'package:cws_app/network/api_client.dart';
import 'package:cws_app/util/app_storage.dart';
import 'package:cws_app/views/main_screen/main_screen.dart';
import 'package:cws_app/widgets/camera_widget.dart';
import 'package:floating_tabbar/Widgets/airoll.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../util/app_utils.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;
import 'package:cws_app/widgets/constant.dart';
import 'package:permission_handler/permission_handler.dart';
import '../login/login_screens.dart';

class AddAttendanceScreen extends StatefulWidget {
  AddAttendanceScreen({super.key});

  @override
  State<AddAttendanceScreen> createState() => _AddAttendanceScreenState();
}

class _AddAttendanceScreenState extends State<AddAttendanceScreen> {
  File? _selfie;

  CameraController? _cameraController;
  late List<CameraDescription> cameras;
  late CameraDescription frontCamera;
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;

  Future<void> _initializeCamera() async {
    // Check and request camera permission
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
      if (!status.isGranted) {
        // If permission is denied, show a message and return
        AppUtils.snackBar("Camera permission is required to capture images.",
            backgroundColor: Colors.red);
        return;
      }
    }

    // If permission is granted, proceed to initialize the camera
    try {
      cameras = await availableCameras();
      frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front);

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _cameraController?.initialize();
      setState(
        () {},
      );
    } catch (e) {
      // Handle errors in camera initialization
      AppUtils.snackBar("Failed to initialize camera: $e",
          backgroundColor: Colors.red);
    }
  }

  Future<void> _captureSelfie() async {
    if (_cameraController == null) {
      _initializeCamera();
      return;
    }
    final selfie = await Get.to(
        () => CameraPreviewScreen(cameraController: _cameraController!));
    if (selfie != null) {
      setState(() {
        _selfie = selfie;
      });
    }
  }

  presentAttendance(BuildContext context, note) async {
    AppUtils.showLoader();
    try {
      final userId = AppStorage.getUserId();
      var headers = {'x-api-key': 'ftc_apikey@'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('${staticData.baseUrl}/Common/present_mark'));
      request.fields.addAll(
        {
          'emp_id': userId,
          'check_in': DateTime.now().toString(),
          'check_out': '',
          'notes': note,
          'latitude': lat.value.toString(),
          'longitude': lng.value.toString()
        },
      );
      request.files
          .add(await http.MultipartFile.fromPath('selfie', _selfie!.path));
      request.headers.addAll(headers);

      print(
          'api in use for add attendance is ${'${staticData.baseUrl}/Common/present_mark'}');

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        AppUtils.hideLoader();
        Get.back();
        Get.back();
        staticData.logInTime =
            DateFormat('HH:mm a').format(DateTime.now()).toString();
        showDialog(
          context: (context),
          builder: (context) => AlertDialog(
            // backgroundColor: Color(0xffFFE839),
            // title: Center(child: const Text("Attendance Marked")),
            content: Container(
              decoration: BoxDecoration(
                // color: Colors.yellow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset("assets/Animations/success.json",
                      height: 100, width: 100),
                  Center(
                    child: const Text(
                      "Attendance Marked",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.6,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(appthemColor)),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "Okay",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      } else {
        AppUtils.hideLoader();
        AppUtils.snackBar("Failed to mark attendance");
      }
    } catch (e) {
      AppUtils.hideLoader();
      Get.snackbar("Error", e.toString());
    }
  }

  absentAttendance(reason) async {
    AppUtils.showLoader();
    try {
      final userId = AppStorage.getUserId();
      final response = await ApiClient.post(
        "Common/absent_mark",
        {
          'emp_id': userId,
          'start_date': DateTime.now().toString().split(" ").first,
          'leave_reason': reason
        },
      );
      if (response.statusCode == 200) {
        AppUtils.hideLoader();
        Get.back();
        Get.back();

        // Get.to(() => const AttendanceScreen());
        AppUtils.snackBar("Absent Marked Successfully",
            backgroundColor: Colors.red.shade700);
        SystemNavigator.pop();
      } else {
        AppUtils.hideLoader();
        AppUtils.snackBar("Failed to mark attendance");
      }
    } catch (e) {
      AppUtils.hideLoader();
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }
  }

  Future<void> getLocation() async {
    var position = await AppUtils.getCurrentPosition();
    lat.value = position!.latitude;
    lng.value = position.longitude;
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = AppStorage.getUserDetails();
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          automaticallyImplyLeading: false,
          backgroundColor: appthemColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
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
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            )
          ],
          title: const Text('Attendance',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //Get.back();

                    if (_selfie == null) {
                      AppUtils.snackBar('please capture selfie');
                    } else if (lat.value == 0.0 || lng.value == 0.0) {
                      AppUtils.snackBar('Refresh the current location');
                    } else {
                      presentAttendance(context, "");
                    }
                    // showDialog(context: context, builder: (context) => presentDialog());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade500,
                      borderRadius: BorderRadius.circular(36),
                    ),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("PRESENT",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        15.widthBox,
                        const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //   Get.back();
                    showDialog(
                        context: context, builder: (context) => absentDialog());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red.shade700,
                      borderRadius: BorderRadius.circular(36),
                    ),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("ABSENT",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        15.widthBox,
                        const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        userDetails.name.toString().capitalize ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "User ID: ${userDetails.employeeCode}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              // Address Section
              _buildDetailRow(
                  "Address", HtmlWidget(userDetails.address.toString())),
              const Divider(color: Colors.black12),
              const SizedBox(height: 10),

              // Phone Section
              _buildDetailRow("Phone", Text(userDetails.mobile.toString())),
              const Divider(color: Colors.black12),
              const SizedBox(height: 10),

              // Email Section
              // _buildDetailRow("Email", Text(userDetails.email.toString())),
              // const Divider(color: Colors.black12),
              // const SizedBox(height: 20),

              // Capture Selfie Button

              const SizedBox(height: 20),

              // Display Captured Selfie
              if (_selfie != null)
                Center(
                  child: ClipOval(
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.5, // Diameter of the CircleAvatar
                      height: MediaQuery.of(context).size.height *
                          0.25, // Diameter of the CircleAvatar
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.file(_selfie!),
                      ),
                    ),
                  ),
                ),

              SizedBox(
                height: 20,
              ),

              Center(
                child: GestureDetector(
                  onTap: _captureSelfie,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      color: appthemColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _selfie != null ? "Capture Again" : 'Capture Selfie',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_searching, color: Colors.red),
                            SizedBox(width: 8.0),
                            Obx(
                              () => Text(
                                'Lat: ${lat.value}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 8.0),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_searching, color: Colors.red),
                            SizedBox(width: 8.0),
                            Obx(() => Text(
                                  'Lng: ${lng.value}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            SizedBox(width: 8.0),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        getLocation();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, Widget detail) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
        const Spacer(),
        Expanded(
          child: detail,
        ),
      ],
    );
  }

  Widget absentDialog() {
    String reason = "";
    return AlertDialog(
      title: const Text("Absent Reason"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Please enter the reason for being absent",
              style: TextStyle(fontSize: 16)),
          10.heightBox,
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Enter Reason",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              reason = value;
            },
          ),
          20.heightBox,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
                backgroundColor: Colors.red.shade700),
            onPressed: () {
              absentAttendance(reason);
            },
            child: const Text("Mark Absent",
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
