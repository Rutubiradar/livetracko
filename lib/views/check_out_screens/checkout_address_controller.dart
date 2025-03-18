import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cws_app/views/check_out_screens/check_out_address.dart';

import 'check_out_payment.dart';

class CheckoutAddressController extends GetxController {
  GlobalKey<FormState> Checkaddressform = GlobalKey();

  TextEditingController Street1 = TextEditingController();
  TextEditingController street2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController Country = TextEditingController();

  //................................

  @override
  void onInit() {
    super.onInit();
    Street1;
    street2;
    city;
    state;
    Country;
  }

  String? validatestreet1(value) {
    if (value == '') {
      return ' please enter street';
    }
    return null;
  }

  CheckStreet1() {
    var isValidate = Checkaddressform.currentState!.validate();
    if (!isValidate) {
      return;
    } else {
      //Get.to(()=> HomePage());
    }
    Checkaddressform.currentState!.save();
  }

  String? validatestreet2(value) {
    if (value == '') {
      return ' please enter valid Street2';
    }
    return null;
  }

  Checkstreet2() {
    var isValidate = Checkaddressform.currentState!.validate();
    if (!isValidate) {
      return;
    } else {
      //Get.to(()=> HomePage());
    }
    Checkaddressform.currentState!.save();
  }

  String? validatecity(value) {
    if (value == '') {
      return ' please enter your city';
    }
    return null;
  }

  Checkcity() {
    var isValidate = Checkaddressform.currentState!.validate();
    if (!isValidate) {
      return;
    } else {}
    Checkaddressform.currentState!.save();
  }

  String? validatestate(value) {
    if (value == '') {
      return ' please enter your state';
    }
    return null;
  }

  Checkstate() {
    var isValidate = Checkaddressform.currentState!.validate();
    if (!isValidate) {
      return;
    } else {}
    Checkaddressform.currentState!.save();
  }

  String? validateCountry(value) {
    if (value == '') {
      return ' please enter valid mobile Country';
    }
    return null;
  }

  CheckoutAddress() {
    var isValidate = Checkaddressform.currentState!.validate();
    if (!isValidate) {
      return;
    } else {
      //if you will take dispose method then you have to use in place of to is off
      Get.off(() => CheckOutPayment());
      //callAdduserApi();
    }
    Checkaddressform.currentState!.save();
  }
// void callAdduserApi() async {
//   http.Response r = await ApiProvider.addUser(name.text,email.text,age.text,mobile.text);
//   if(r.statusCode==200){
//     Get.to(()=> HomePage());
//   }
// }

  //here dispose method.............

  @override
  void dispose() {
    Checkaddressform.currentState!.dispose();
    super.dispose();
  }
}
