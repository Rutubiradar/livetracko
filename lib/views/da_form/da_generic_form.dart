import 'dart:convert';
import 'dart:io';

import 'package:cws_app/network/api_client.dart';
import 'package:cws_app/util/app_storage.dart';
import 'package:cws_app/util/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import "package:http/http.dart" as http;
import '../../helper/app_static.dart';
import '../../widgets/constant.dart';
import 'da_generic_list.dart';

class DAGenericFormScreen extends StatefulWidget {
  DAGenericFormScreen({super.key});

  @override
  State<DAGenericFormScreen> createState() => _DAGenericFormScreenState();
}

class _DAGenericFormScreenState extends State<DAGenericFormScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fromController = TextEditingController();

  TextEditingController toController = TextEditingController();

  TextEditingController distInKmController = TextEditingController();

  TextEditingController fareRsController = TextEditingController();

  TextEditingController dailyAllowController = TextEditingController();

  TextEditingController miscAndTelRsController = TextEditingController();

  File? imageFile;

  RxBool isLoading = false.obs;

  Future<void> submitForm() async {
    isLoading.value = true;
    if (_formKey.currentState!.validate()) {
      await uploadData();
      Get.to(() => DaGenericList());
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  Future<void> uploadData() async {
    final userId = AppStorage.getUserId();
    var headers = {'x-api-key': 'ftc_apikey@'};
    var body = {
      "emp_id": userId,
      "from": fromController.text,
      "to": toController.text,
      "distance": distInKmController.text,
      "fare_rs": fareRsController.text,
      // "daily_allowance": dailyAllowController.text,
      'daily_allowance': "2",
      "misc": miscAndTelRsController.text,
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('${staticData.baseUrl}/Common/generic_save'));

    print(
        "api in use for generic form ${'${staticData.baseUrl}/Common/generic_save'}");
    request.fields.addAllT(body);

    request.files.addT(await http.MultipartFile.fromPath(
        'image', imageFile == null ? '' : imageFile!.path));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    var jsonRes = jsonDecode(res);
    print("${jsonRes}");
    if (response.statusCode == 200) {
      AppUtils.snackBar('Data uploaded successfully',
          backgroundColor: Colors.green.shade500);
      fromController.clear();
      toController.clear();
      distInKmController.clear();
      fareRsController.clear();
      dailyAllowController.clear();
      miscAndTelRsController.clear();
      imageFile = null;
      setState(() {});
    } else {
      AppUtils.snackBar('${jsonRes['message']}',
          backgroundColor: Colors.green.shade500);
      Get.back();
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 20);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt_rounded),
                title: Text('Take a photo'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library_rounded),
                title: Text('Choose from gallery'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      TextInputType keyboardType = TextInputType.text,
      String? hintText,
      FormFieldValidator<String>? validator}) {
    return Card(
      elevation: 5,
      child: TextFormField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText ?? label,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: appthemColor,
        title: const Text(
          "Generic Form",
          style: TextStyle(color: Colors.white),
        ),
        leading: AppUtils.backButton(),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => DaGenericList());
            },
            icon: const Icon(Icons.view_agenda_outlined, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 15),
                _buildTextField(
                  controller: fromController,
                  label: 'From',
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter from';
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: toController,
                  label: 'To',
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter to';
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: distInKmController,
                  label: 'Distance (Km)',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter distance';
                    if (int.parse(value) < 0) return 'Enter a valid distance';
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: fareRsController,
                  label: 'Fare (Rs)',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter fare Rs';
                    if (int.parse(value) < 0) return 'Enter a valid fare';
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: miscAndTelRsController,
                  label: 'Misc and Tel Rs',
                ),
                const SizedBox(height: 20),
                if (imageFile != null)
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 5))
                          ],
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(imageFile!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: GestureDetector(
                          onTap: _showImagePicker,
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  GestureDetector(
                    onTap: _showImagePicker,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Icon(
                        Icons.add_a_photo_rounded,
                        color: Colors.grey[600],
                        size: 50,
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
                Obx(() => GestureDetector(
                      onTap: isLoading.value
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                if (imageFile == null) {
                                  AppUtils.snackBar('Image is required');
                                } else {
                                  await submitForm();
                                }
                              }
                            },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: isLoading.value
                              ? Colors.grey.shade300
                              : Colors.green.shade500,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Submit",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.send_rounded,
                                      color: Colors.white),
                                ],
                              ),
                      ),
                    )),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
