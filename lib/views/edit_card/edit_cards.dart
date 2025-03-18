import 'package:circle_checkbox/redev_checkbox.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cws_app/views/check_out_screens/checkbox_controller.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

import '../../util/app_utils.dart';
import 'edit_card_controller.dart';

class EditCard extends StatelessWidget {
  EditCard({Key? key}) : super(key: key);

  EditCardController _editCardController = Get.put(EditCardController());
  Checkbox1 _checkbox1 = Get.put(Checkbox1());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Edit Cards',
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: appthemColor,
          ),
        ),
        centerTitle: true,
        leading: AppUtils.backButton(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _editCardController.CheckCardform,
            child: Column(
              children: [
                //     Stack(
                //       children: [
                //         Positioned(
                //           top: 2,
                //           child: Container(
                //             height: 352,
                //             width: 352,
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               shape: BoxShape.circle,
                //             ),
                //           ),
                //
                //         )
                //       ],
                //     ),
                //
                //
                //     Container(
                //     height: 170,
                //   width: 343,
                //
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20),
                //     gradient: LinearGradient(
                //       colors: [Color(0xFF780C1C),Color(0xFFF01738)],
                //   begin: Alignment.bottomCenter,
                //   end: Alignment.topCenter,),
                //   ),
                // ),

                Image.asset(
                  'lib/assets/asset/cardpayment.png',
                  width: 343,
                  height: 170,
                ),

                5.h.heightBox,

                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name on Card',
                      style: GoogleFonts.poppins(fontSize: 10),
                    )).pSymmetric(h: 4.w),

                TextFormField(
                  validator: _editCardController.validatecard,
                  controller: _editCardController.card,
                  decoration: InputDecoration(
                    hintText: 'Visa',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                ).pSymmetric(h: 4.w),
                3.h.heightBox,

                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Card Number',
                      style: GoogleFonts.poppins(fontSize: 10),
                    )).pSymmetric(h: 4.w),

                TextFormField(
                  validator: _editCardController.validatecardnumber,
                  controller: _editCardController.cardnumber,
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Image.asset(
                        'lib/assets/asset/Icon_MasterCard.png',
                        height: 5,
                        width: 0.5.w,
                      ),
                    ),
                    hintText: '4560  5644  3224  4543',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                ).pSymmetric(h: 4.w),

                3.h.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Expiry Date',
                          style: GoogleFonts.poppins(fontSize: 10),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'CVV',
                          style: GoogleFonts.poppins(fontSize: 10),
                        )).pSymmetric(h: 36.w),
                  ],
                ).pSymmetric(h: 4.w),

                Row(
                  children: [
                    Container(
                      width: 50.w,
                      child: TextFormField(
                        validator: _editCardController.validateexpirydate,
                        controller: _editCardController.expirydate,
                        decoration: InputDecoration(
                          hintText: '09/20',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                        ),
                      ).pSymmetric(h: 4.w),
                    ),
                    Container(
                      width: 50.w,
                      child: TextFormField(
                        validator: _editCardController.validatecvv,
                        controller: _editCardController.cvv,
                        decoration: InputDecoration(
                          hintText: '467',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                        ),
                      ).pSymmetric(h: 4.w),
                    ),
                  ],
                ),

                2.h.heightBox,

                Obx(
                  () => CircleCheckboxListTile(
                    activeColor: appthemColor,
                    title: Text(
                      'Save this card details',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _checkbox1.value5.value,
                    onChanged: _checkbox1.value5,
                    //secondary: const Icon(Icons.hourglass_empty),
                  ),
                ),

                3.h.heightBox,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: Container(
                        height: 7.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: appthemColor),
                          borderRadius: BorderRadius.circular(15.sp),
                        ),
                        child: 'CANCEL'
                            .text
                            .size(10.sp)
                            .letterSpacing(1.5)
                            .bold
                            .color(appthemColor)
                            .make()
                            .centered(),
                      ).onTap(() {
                        Get.back();

                        //_signupController.CheckSignup();
                        //Get.to(()=> CheckoutScreen());
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomePage()));
                      }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: Container(
                        height: 7.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: appthemColor,
                          borderRadius: BorderRadius.circular(15.sp),
                        ),
                        child: 'SAVE'
                            .text
                            .size(10.sp)
                            .letterSpacing(1.5)
                            .bold
                            .white
                            .make()
                            .centered(),
                      ).onTap(() {
                        _editCardController.Checkcvv();
                        //Get.to(()=> CheckOutPayment());
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomePage()));
                      }),
                    ),
                  ],
                ).pSymmetric(h: 4.w),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
