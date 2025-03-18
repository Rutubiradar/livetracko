import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cws_app/views/check_out_screens/check_out_address.dart';
import 'package:cws_app/views/edit_card/edit_cards.dart';

import 'check_out_payment.dart';
import 'checkout_summary.dart';

class CheckoutPaymentController extends GetxController {
  GlobalKey<FormState> Checkpaymentform = GlobalKey();

  TextEditingController card = TextEditingController();
  TextEditingController cardnumber = TextEditingController();
  TextEditingController expirydate = TextEditingController();
  TextEditingController cvv = TextEditingController();

  //................................

  @override
  void onInit() {
    super.onInit();
    card;
    cardnumber;
    expirydate;
    cvv;
  }

  String? validatecard(value) {
    if (value == '') {
      return ' please enter card name';
    }
    return null;
  }

  Checkcard() {
    var isValidate = Checkpaymentform.currentState!.validate();
    if (!isValidate) {
      return;
    } else {
      //Get.to(()=> HomePage());
    }
    Checkpaymentform.currentState!.save();
  }

  String? validatecardnumber(value) {
    if (value == '') {
      return ' please enter valid card number';
    }
    return null;
  }

  Checkcardnumber() {
    var isValidate = Checkpaymentform.currentState!.validate();
    if (!isValidate) {
      return;
    } else {
      //Get.to(()=> HomePage());
    }
    Checkpaymentform.currentState!.save();
  }

  String? validateexpirydate(value) {
    if (value == '') {
      return ' please enter your expiry date';
    }
    return null;
  }

  Checkexpirydate() {
    var isValidate = Checkpaymentform.currentState!.validate();
    if (!isValidate) {
      return;
    } else {}
    Checkpaymentform.currentState!.save();
  }

  String? validatecvv(value) {
    if (value == '') {
      return ' please enter valid mobile Country';
    }
    return null;
  }

  Checkcvv() {
    var isValidate = Checkpaymentform.currentState!.validate();
    if (!isValidate) {
      return;
    } else {
      Get.off(() => EditCard());
      //callAdduserApi();
    }
    Checkpaymentform.currentState!.save();
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
    Checkpaymentform.currentState!.dispose();
    super.dispose();
  }
}
