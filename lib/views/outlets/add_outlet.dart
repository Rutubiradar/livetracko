import 'package:cws_app/util/app_storage.dart';
import 'package:cws_app/util/app_utils.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../network/api_client.dart';
import '../../widgets/constant.dart';

class AddOutletScreen extends StatefulWidget {
  const AddOutletScreen(
      {super.key, this.isEdit = false, this.outlet, this.isView = false});
  final bool isEdit;
  final bool isView;
  final dynamic outlet;

  @override
  State<AddOutletScreen> createState() => _AddOutletScreenState();
}

class _AddOutletScreenState extends State<AddOutletScreen> {
  TextEditingController businessNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController gstinController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late Position? _currentPosition;
  RxBool isLoading = false.obs;
  var markers = <MarkerId, Marker>{};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEdit) {
      businessNameController.text = widget.outlet["business_name"];
      mobileController.text = widget.outlet["mobile_number"];
      emailController.text = widget.outlet["email_id"];
      gstinController.text = widget.outlet["gst_number"];
      contactPersonController.text = widget.outlet["contact_person_name"];
      addressController.text = widget.outlet["address"];
    }
  }

  Future<void> saveOutlet() async {
    // setState(() {
    isLoading.value = true;
    // });
    final userPosition = await AppUtils.getCurrentPosition();

    ApiClient.post("Common/outlet_save", {
      'emp_id': AppStorage.getUserId(),
      'business_name': businessNameController.text,
      'mobile_number': mobileController.text,
      'email_id': emailController.text,
      'gst_number': gstinController.text,
      'contact_person_name': contactPersonController.text,
      'address': addressController.text,
      'latitude': userPosition!.latitude.toString(),
      'longitude': userPosition.longitude.toString(),
    }).then((value) {
      print(value);

      // setState(() {
      isLoading.value = false;
      // });
    }).catchError((e) {
      // setState(() {
      isLoading.value = false;
      // });
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: appthemColor,
        title: Text('${widget.isEdit ? 'View' : 'Add'} Patient',
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        leading: AppUtils.backButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 150,
                    width: double.maxFinite,
                    child: GoogleMap(
                        initialCameraPosition:
                            CameraPosition(target: LatLng(0, 0), zoom: 15),
                        myLocationEnabled: true,
                        markers: markers.values.toSet(),
                        myLocationButtonEnabled: true,
                        onMapCreated: (GoogleMapController controller) async {
                          _currentPosition =
                              await AppUtils.getCurrentPosition();
                          markers[MarkerId('1')] = Marker(
                              markerId: MarkerId('1'),
                              position: widget.isView
                                  ? LatLng(
                                      double.parse(widget.outlet["latitude"]),
                                      double.parse(widget.outlet["longitude"]))
                                  : LatLng(_currentPosition!.latitude,
                                      _currentPosition!.longitude));
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: widget.isView
                                      ? LatLng(
                                          double.parse(
                                              widget.outlet["latitude"]),
                                          double.parse(
                                              widget.outlet["longitude"]))
                                      : LatLng(_currentPosition!.latitude,
                                          _currentPosition!.longitude),
                                  zoom: 16)));
                          setState(() {});
                        }),
                  )),
            ),
            // if (_currentPosition.longitude != 0 && _currentPosition.latitude != 0)
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
            //     child: Row(
            //       children: [
            //         Text('Latitude: ${_currentPosition.latitude.toStringAsFixed(5)}', style: const TextStyle(fontSize: 16)),
            //         const SizedBox(width: 15),
            //         Text('Longitude: ${_currentPosition.longitude.toStringAsFixed(5)}', style: const TextStyle(fontSize: 16)),
            //       ],
            //     ),
            //   ),
            // Container(
            //     margin: EdgeInsets.symmetric(horizontal: 22),
            //     height: 45,
            //     width: double.maxFinite,
            //     decoration: BoxDecoration(
            //       border: Border.all(color: appthemColor),
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: Center(
            //         child: const Text("Get Current Location",
            //             style: TextStyle(color: appthemColor, fontWeight: FontWeight.bold, fontSize: 15)))),
            //  const SizedBox(height: 10),
            // TextFields for business name , mobile , email , gstin, contact person , address
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6),
                      child: TextFormField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        readOnly: widget.isView,
                        controller: businessNameController,
                        decoration: InputDecoration(
                          labelText: 'Patient"s Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Patient"s Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6),
                      child: TextFormField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        controller: mobileController,
                        maxLength: 10,
                        readOnly: widget.isView,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Mobile Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          final mobileRegex = RegExp(r'^[0-9]{10}$');
                          if (!mobileRegex.hasMatch(value)) {
                            return 'Enter a valid 10-digit mobile number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6),
                      child: TextFormField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        controller: emailController,
                        readOnly: widget.isView,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          // final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          // if (!emailRegex.hasMatch(value)) {
                          //   return 'Enter a valid address';
                          // }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6),
                      child: TextFormField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        controller: gstinController,
                        readOnly: widget.isView,
                        maxLength: 15,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Land Mark',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6),
                      child: TextFormField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        controller: contactPersonController,
                        readOnly: widget.isView,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Contact Person',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }

                          return null;
                        },
                      ),
                    ),
                    widget.isEdit
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            padding: const EdgeInsets.all(8),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: HtmlWidget(
                              widget.outlet["address"],
                              textStyle: TextStyle(
                                  fontSize: 14), // Adjust font size as needed
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6),
                            child: TextFormField(
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              minLines: 3,
                              maxLines: 5,
                              controller: addressController,
                              readOnly: widget.isView,
                              decoration: InputDecoration(
                                hintText: 'Enter Address',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                    const SizedBox(height: 5),
                    if (!widget.isEdit)
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: appthemColor,
                                minimumSize: const Size(double.maxFinite, 50)),
                            onPressed: () async {
                              if (!widget.isEdit) {
                                if (_formKey.currentState!.validate()) {
                                  Get.back();
                                  await saveOutlet();
                                  AppUtils.snackBar(
                                      "Outlet added, sent for approval",
                                      backgroundColor: Colors.green);
                                }
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: isLoading.value
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white))
                                  : Text(
                                      "${widget.isEdit ? 'Update' : 'Add'} Outlet",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                            ),
                          ),
                        ),
                      )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
