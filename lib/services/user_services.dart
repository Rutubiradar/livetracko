import 'dart:convert';
import 'dart:developer';

import 'package:cws_app/network/api_client.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';
import '../util/app_storage.dart';

class UserServices {
  //Singleton only on instance of UserServices
  UserServices._();

  static final UserServices _instance = UserServices._();

  static UserServices get instance => _instance;
  var userDetails = UserDetail().obs;

  init() {
    if (AppStorage.getUserId().isNotEmpty) {
      getUserDetails();
    }
    userDetails.value = AppStorage.getUserDetails();
  }

  getUserDetails() async {
    ApiClient.post("Common/profile_fetch", {"emp_id": AppStorage.getUserId()}).then((response) {
      if (response.statusCode == 200) {
        final data = response.body;
        final userJson = jsonDecode(data)["profile_dt"][0];
        AppStorage.setUserDetails(userJson);
        userDetails.value = UserDetail.fromJson(userJson);
        log(data.toString());
      } else {
        AppStorage.setUserDetails({});
      }
    }).catchError((e) {
      AppStorage.setUserDetails({});
    });
  }
}
