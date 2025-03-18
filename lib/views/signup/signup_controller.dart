import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

class SignupController extends GetxController {
  GlobalKey<FormState> signupform = GlobalKey();



  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController Gender = TextEditingController();


  //................................

  @override
  void onInit() {
    super.onInit();
    name;
    email;
    age;
    mobile;
    Gender;
  }

  String ? validatename(value) {
    if (value == '') {
      return ' please enter Name';
    }
    return null;
  }
  CheckName () {
    var isValidate = signupform.currentState!.validate();
    if (!isValidate) {
      return;
    }
    else {
      //Get.to(()=> HomePage());
    }
    signupform.currentState!.save();
  }


  String ? validateEmail(value) {
    if (value == '') {
      return ' please enter valid email';
    }
    return null;
  }
  CheckEmail () {
    var isValidate = signupform.currentState!.validate();
    if (!isValidate) {
      return;
    }
    else {
      //Get.to(()=> HomePage());
    }
    signupform.currentState!.save();
  }



  String ? validateAge(value) {
    if (value == '') {
      return ' please enter your age';
    }
    return null;
  }
  CheckAge () {
    var isValidate = signupform.currentState!.validate();
    if (!isValidate) {
      return;
    }
    else {

    }
    signupform.currentState!.save();
  }

  String ? validategender(value) {
    if (value == '') {
      return ' please enter your age';
    }
    return null;
  }
  CheckGender () {
    var isValidate = signupform.currentState!.validate();
    if (!isValidate) {
      return;
    }
    else {

    }
    signupform.currentState!.save();
  }



  String ? validateMobile(value) {
    if (value == '') {
      return ' please enter valid mobile number';
    }
    return null;
  }

  CheckSignup () {
    var isValidate = signupform.currentState!.validate();
    if (!isValidate) {
      return;
    }
    else {
      //Get.to(()=> HomePage());
      //callAdduserApi();
    }
    signupform.currentState!.save();
  }
  // void callAdduserApi() async {
  //   http.Response r = await ApiProvider.addUser(name.text,email.text,age.text,mobile.text);
  //   if(r.statusCode==200){
  //     Get.to(()=> HomePage());
  //   }
  // }
}