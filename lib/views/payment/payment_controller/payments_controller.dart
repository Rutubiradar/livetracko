// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';

enum PaymentMethod {paytm, mobikwik, awazon, upi, netBanking, cards}

class CheckOutController extends GetxController{
  Rx<PaymentMethod> selecthosOption = PaymentMethod.paytm.obs;
  onchaged(value){
    selecthosOption(value);
  }

}