import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/user_model.dart';

class AppStorage {
  static final box = GetStorage("CWS");

  static setUserId(String id) {
    box.write("user_id", id);
  }

  static String getUserId() {
    if (box.read("user_id") == null) {
      return "";
    }
    return box.read("user_id");
  }

  static UserDetail getUserDetails() {
    if (box.read("user_details") == null) {
      return UserDetail();
    }
    // print('user_details: ${box.read("user_details")}');
    return UserDetail.fromJson(box.read("user_details"));
  }

  static setUserDetails(var userDetail) {
    box.write("user_details", userDetail);
  }

  static setCompanyName(String companyName) {
    box.write('companyName', companyName);
  }

  String getCompanyName() {
    if (box.read('companyName') == null) {
      return "";
    }
    return box.read('companyName');
  }

  static setBaseUrl(String name) {
    box.write('baseUrl', 'https://livetracko.com/$name/api/index.php');
  }

  static String getBaseUrl() {
    if (box.read("baseUrl") == null) {
      return "";
    }
    return box.read("baseUrl");
  }

  static clearAll() {
    box.erase();
  }
}
