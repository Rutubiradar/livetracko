import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart'as http;
class PhoneController extends GetxController{
  final GlobalKey<FormState> phone_numberform = GlobalKey<FormState>();

  // void forgotApi() async {
  //   http.Response r = await ApiProvider.forgotpasswordApi(phone_number.text,);
  //   if(r.statusCode==200){
  //     Get.to(()=>VerifyOtp(
  //         phone: phone_number.text
  //     ));
  //     Get.offAll(()=> BottomBarScreen(i: 0,));
  //   }
  // }


  TextEditingController phone_number = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    phone_number;
  }
  @override
  void dispose() {
    phone_number;
    super.dispose();
  }

  String ? validateNumber(value){
    if (value == '') {
      return "Provide a valid Number".toString();
    }
    return null;
  }

  void checkEmail(){
    final isvalidate = phone_numberform.currentState!.validate();
    if(!isvalidate){
      return ;
    }
    else{
     // forgotApi();
    }
    phone_numberform.currentState!.save();
  }
}