import 'dart:developer';
import 'dart:io'; // Import this for File

import 'package:cws_app/util/app_storage.dart';
import 'package:cws_app/util/app_utils.dart';
import 'package:cws_app/util/constant.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import '../../helper/app_static.dart';
import '../../widgets/camera_widget.dart';
import '../../widgets/constant.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class MarkVisitScreen extends StatefulWidget {
  const MarkVisitScreen(
      {super.key,
      required this.outletId,
      required this.pjpId,
      this.manualVisit = false});
  final String outletId;
  final String pjpId;
  final bool manualVisit;

  @override
  State<MarkVisitScreen> createState() => _MarkVisitScreenState();
}

class _MarkVisitScreenState extends State<MarkVisitScreen> {
  CameraController? _cameraController;
  File? _image;
  var reason = "General Visit";
  RxBool isLoading = false.obs;
  var markers = <MarkerId, Marker>{};
  TextEditingController commentController = TextEditingController();
  late Position? _currentPosition;
  late List<CameraDescription> cameras;
  late CameraDescription frontCamera;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);

    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _cameraController?.initialize();
    setState(() {});
  }

  Future<void> _captureImage() async {
    final capturedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraPreviewScreen(
          cameraController: _cameraController!,
        ),
      ),
    );

    if (capturedImage != null) {
      setState(() {
        _image = capturedImage;
      });
    }
  }

  Future<void> markVisit() async {
    AppUtils.showLoader();
    AppUtils.snackBar("Visit marking in progress...",
        backgroundColor: Colors.grey);
    AppUtils.hideLoader();

    Get.back(result: true);
    try {
      final position = await AppUtils.getCurrentPosition();
      log({
        'pjp_id': widget.pjpId,
        'reason': reason,
        'comment': commentController.text,
        'outlet_id': widget.outletId,
        'lat': position!.latitude.toString(),
        'long': position.longitude.toString(),
        'checkin_time': DateTime.now().toString()
      }.toString());

      var headers = {'X-API-KEY': 'ftc_apikey@'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('${staticData.baseUrl}/Common/mark_visit'));

      print(
          "api in use for mark visit is ${'${staticData.baseUrl}/Common/mark_visit'}");
      request.fields.addAll({
        'pjp_id': widget.pjpId,
        'reason': reason,
        'comment': commentController.text,
        'outlet_id': widget.outletId,
        'lat': position.latitude.toString(),
        'long': position.longitude.toString(),
        'checkin_time': DateTime.now().toString()
      });
      if (_image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', _image!.path));
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final responseStr = await response.stream.bytesToString();
      log(responseStr);
      if (response.statusCode == 200) {
        AppUtils.snackBar("Visit Marked Successfully",
            backgroundColor: Colors.green);
      } else {
        AppUtils.snackBar("Failed to mark visit", backgroundColor: Colors.red);
      }
    } catch (e) {
      AppUtils.snackBar("Failed to mark visit", backgroundColor: Colors.red);
    }
  }

  Future<void> manualMarkVisit() async {
    print("---------------manual visit-------------------");
    AppUtils.showLoader();
    AppUtils.snackBar("Visit marking in progress...",
        backgroundColor: Colors.grey);
    AppUtils.hideLoader();

    Get.back(result: true);
    try {
      final position = await AppUtils.getCurrentPosition();
      String userId = AppStorage.getUserId();
      log({
        'emp_id': userId,
        'reason': reason,
        'comment': commentController.text,
        'outlet_id': widget.outletId,
        'lat': position!.latitude.toString(),
        'long': position.longitude.toString(),
        'checkin_time': DateTime.now().toString()
      }.toString());

      var headers = {'X-API-KEY': 'ftc_apikey@'};
      var request = http.MultipartRequest('POST',
          Uri.parse('${staticData.baseUrl}/Common/manually_mark_visit'));
      request.fields.addAll({
        'emp_id': userId,
        'reason': reason,
        'comment': commentController.text,
        'outlet_id': widget.outletId,
        'lat': position.latitude.toString(),
        'long': position.longitude.toString(),
        'checkin_time': DateTime.now().toString()
      });
      if (_image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', _image!.path));
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final responseStr = await response.stream.bytesToString();
      log(responseStr);
      if (response.statusCode == 200) {
        AppUtils.snackBar("Visit Marked Successfully",
            backgroundColor: Colors.green);
      } else {
        AppUtils.snackBar("Failed to mark visit", backgroundColor: Colors.red);
      }
    } catch (e) {
      AppUtils.snackBar("Failed to mark visit", backgroundColor: Colors.red);
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: appthemColor,
        title: const Text('Mark Attendence',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        leading: AppUtils.backButton(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 250,
                    width: double.maxFinite,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            0, 0), // Default to (0, 0) if no location is found
                        zoom: 15,
                      ),
                      myLocationEnabled: true,
                      markers: markers.values.toSet(),
                      myLocationButtonEnabled: true,
                      onMapCreated: (GoogleMapController controller) async {
                        try {
                          _currentPosition = await AppUtils
                              .getCurrentPosition(); // Using the timeout logic
                          markers[MarkerId('1')] = Marker(
                            markerId: MarkerId('1'),
                            position: LatLng(
                              _currentPosition!.latitude,
                              _currentPosition!.longitude,
                            ),
                          );
                          controller.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  _currentPosition!.latitude,
                                  _currentPosition!.longitude,
                                ),
                                zoom: 16,
                              ),
                            ),
                          );
                          setState(() {});
                        } catch (e) {
                          print('Error fetching location: $e');
                        }
                      },
                    ),
                  ),
                ),
              ),
              const Text("Comment",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    underline: const SizedBox.shrink(),
                    value: reason,
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    items: const [
                      DropdownMenuItem(
                          value: "General Visit", child: Text("General Visit")),
                      DropdownMenuItem(
                          value: "Shop Closed", child: Text("Shop Closed")),
                      DropdownMenuItem(
                          value: "Already Have Stock",
                          child: Text("Already Have Stock")),
                      DropdownMenuItem(
                          value: "Order Booking", child: Text("Order Booking")),
                      DropdownMenuItem(
                          value: "Payment Collection",
                          child: Text("Payment Collection")),
                      DropdownMenuItem(
                          value: "Product Promotion",
                          child: Text("Product Promotion")),
                      DropdownMenuItem(value: "Others", child: Text("Others")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        reason = value.toString();
                      });
                    }),
              ),
              if (reason == "Others") const SizedBox(height: 15),
              if (reason == "Others")
                TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: 'Enter Comment',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              const Text("Capture Image",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
              const SizedBox(height: 5),
              _image != null
                  ? Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.file(_image!, fit: BoxFit.cover),
                    )
                  : Obx(
                      () => GestureDetector(
                        onTap: () {
                          _captureImage();
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: isLoading.value
                              ? Center(child: CircularProgressIndicator())
                              : const Center(
                                  child: Icon(
                                  Icons.add_rounded,
                                  color: appthemColor,
                                  size: 40,
                                )),
                        ),
                      ),
                    ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: appthemColor,
                      minimumSize: const Size(double.maxFinite, 50)),
                  onPressed: () async {
                    if (_image == null) {
                      AppUtils.snackBar("Please Capture Image",
                          backgroundColor: Colors.red);
                    } else if (reason == "Others" &&
                        commentController.text == "") {
                      AppUtils.snackBar("Please Enter Comment",
                          backgroundColor: Colors.red);
                    } else {
                      if (widget.manualVisit) {
                        print('manual Attendence');
                        await manualMarkVisit();
                      } else {
                        print('mark Attendence');
                        await markVisit();
                      }
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text("Mark Attendence",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
