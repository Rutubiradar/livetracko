import 'dart:developer';

import 'package:cws_app/network/api_client.dart';
import 'package:cws_app/services/user_services.dart';
import 'package:cws_app/util/app_utils.dart';
import 'package:cws_app/util/constant.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:cws_app/widgets/constant.dart';

import '../../helper/app_static.dart';
import '../../util/app_storage.dart';
import '../../widgets/welcomeButton_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  XFile? imageProfile;
  XFile? imageCover;
  var isLoading = false.obs;
  uploadImage() async {
    final ImagePicker _picker = ImagePicker();
    _picker.pickImage(source: ImageSource.gallery).then((value) {
      setState(() {
        imageProfile = value;
      });
    });
  }

  uploadCover() async {
    final ImagePicker _picker = ImagePicker();
    _picker.pickImage(source: ImageSource.gallery).then((value) {
      setState(() {
        imageCover = value;
      });
    });
  }

  updateProfile() async {
    isLoading.value = true;
    var headers = {'X-API-KEY': 'ftc_apikey@'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${staticData.baseUrl}/Common/profile_update_save'));
    request.fields.addAll({
      'emp_id': AppStorage.getUserId(),
      'name': nameController.text,
    });

    print(
        "api in use for profile image update is ${'${staticData.baseUrl}/Common/profile_update_save'}");

    if (imageProfile != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'profile_image', imageProfile!.path));
    } else {
      request.fields.addAll({
        'profile_image': AppStorage.getUserDetails().profileImage ?? '',
      });
    }
    // else if (imageCover != null) {
    // // request.files.add(await http.MultipartFile.fromPath('cover_image', imageCover!.path));
    // }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      isLoading.value = false;
      print(await response.stream.bytesToString());
      UserServices.instance.getUserDetails();
      Get.back();
      Get.back();
    } else {
      isLoading.value = false;
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = AppStorage.getUserDetails();
    nameController.text = user.name ?? '';
    emailController.text = user.email ?? '';
    mobileController.text = user.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = AppStorage.getUserDetails();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appthemColor,
        title: const Text(
          "Edit Info",
          style: TextStyle(color: Colors.white),
        ),
        leading: AppUtils.backButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: imageCover != null
                    ? DecorationImage(
                        image: FileImage(File(imageCover!.path)),
                        fit: BoxFit.cover,
                        opacity: 0.5)
                    : null,
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              width: double.maxFinite,
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          uploadImage();
                        },
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                              child: Icon(Icons.edit,
                                  color: appthemColor, size: 26)),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      foregroundImage: userDetails.profileImage != null &&
                              userDetails.profileImage!.isNotEmpty &&
                              imageProfile == null
                          ? NetworkImage(
                              staticData.profileUrl + userDetails.profileImage!)
                          : null,
                      backgroundImage: imageProfile != null
                          ? FileImage(File(imageProfile!.path))
                          : null,
                      backgroundColor: Colors.grey.shade400,
                      radius: 55,
                      child: imageProfile != null
                          ? null
                          : const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 50,
                            ), //CircleAvatar
                    ),
                    const SizedBox(height: 10),
                    const Text("Profile Picture",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            //Cover Image button only
            // SizedBox(
            //   height: 20,
            // ),
            // TextButton(
            //   onPressed: () {
            //     uploadCover();
            //   },
            //   style: TextButton.styleFrom(
            //     backgroundColor: appthemColor,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            //   child: const Padding(
            //     padding: EdgeInsets.all(8.0),
            //     child: Text(
            //       "Upload Cover Image",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),

            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (emailController.text.isNotEmpty)
                    TextFormField(
                      readOnly: true,
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  const SizedBox(height: 15),
                  if (mobileController.text.isNotEmpty)
                    TextFormField(
                      readOnly: true,
                      controller: mobileController,
                      decoration: InputDecoration(
                        hintText: "Enter Mobile Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 40,
                  ),
                  Obx(
                    () => WelcomeButtonWidget(
                      btnText: "Update My Info",
                      isloading: isLoading.value,
                      ontap: () {
                        updateProfile();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
