import 'dart:convert';
import 'package:cws_app/helper/app_static.dart';
import 'package:cws_app/network/api_client.dart';
import 'package:cws_app/services/user_services.dart';
import 'package:cws_app/util/app_storage.dart';
import 'package:cws_app/util/app_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../main_screen/main_screen.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginform = GlobalKey();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      // username.text = '9988776643';
      // password.text = '123456';
    }
  }

  String? validatename(value) {
    if (value == '') {
      return 'Please enter Name';
    }
    return null;
  }

  CheckName() {
    var isValidate = loginform.currentState!.validate();
    if (!isValidate) {
      return;
    } else {
      //Get.to(() => OTPScreen());
    }
    loginform.currentState!.save();
  }

  String? validatepassword(value) {
    if (value == '') {
      return 'Please enter your password';
    }
    return null;
  }

  Checkpassword() {
    var isValidate = loginform.currentState!.validate();
    if (!isValidate) {
      return;
    } else {
      //Get.to(() => HomePage());
    }
    loginform.currentState!.save();
  }

  checkLogin() async {
    try {
      isLoading(true);
      var isValidate = loginform.currentState!.validate();
      if (!isValidate) {
        isLoading(false);
        return;
      } else {
        loginform.currentState!.save();

        var headers = {'X-API-KEY': 'Surplus_apikey@'};
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://livetracko.com/api/index.php/Auth/login_user'),
        );
        request.fields.addAll({
          'mobile': username.text,
          'password': password.text,
        });

        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        var res = await response.stream.bytesToString();
        print('login response is $res');

        if (response.statusCode == 200) {
          final data = jsonDecode(res);

          // Accessing the company name correctly
          String? companyName = data['profile']?['companyname'];
          print('Company name: $companyName');

          if (companyName != null && companyName.isNotEmpty) {
            AppStorage.setBaseUrl(companyName.trim());
            AppStorage.setCompanyName(companyName);
          }

          AppStorage.setUserId(
              data['profile']['data']['profile']['id'].toString());
          AppStorage.setUserDetails(data['profile']['data']['profile']);
          staticData.baseUrl = AppStorage.getBaseUrl();
          staticData.comapanyName = AppStorage().getCompanyName();

          UserServices.instance.init();
          Get.offAll(() => const MainScreen());
        } else if (response.statusCode == 400) {
          AppUtils.snackBar('${jsonDecode(res)['message']['status']}');
        } else {
          AppUtils.snackBar('${jsonDecode(res)['message']}');
        }
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Something went wrong: $e')),
      );
    }
  }
}
