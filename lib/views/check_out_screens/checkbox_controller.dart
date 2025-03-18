import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Checkbox1 extends GetxController {
  Rx<bool> value1 = false.obs;
  Rx<bool> value2 = false.obs;
  Rx<bool> value3 = false.obs;
  Rx<bool> value4 = false.obs;
  Rx<bool> value5 = false.obs;
  checkbox(checkbox1Value,checkbox2Value,checkbox3Value,checkbox4Value,checkbox5Value){

    value1.value = checkbox1Value;
    value2.value = checkbox2Value;
    value3.value = checkbox3Value;
    value4.value = checkbox4Value;
    value5.value = checkbox5Value;

  }

}