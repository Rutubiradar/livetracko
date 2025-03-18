import 'package:cws_app/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class OtpInput extends StatelessWidget {
  const OtpInput(
      {Key? key,
      required this.controller,
      required this.autoFocus,
      required this.validator})
      : super(key: key);
  final bool autoFocus;
  final TextEditingController controller;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        width: 13.w,
        child: Container(
          height: 14.h,
          width: 18.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.black12,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                hintText: '0',
                hintStyle:
                    GoogleFonts.poppins(fontSize: 20.0, color: Colors.black),
                counterText: '',
                focusColor: appthemColor,
              ),
              autofocus: autoFocus,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: controller,
              validator: validator,
              maxLength: 1,
              onChanged: (value) {
                // if (value.length == 1) {
                //   FocusScope.of(context).nextFocus();
                // }
              },
            ),
          ),
        ),
      ),
    );
  }
}
