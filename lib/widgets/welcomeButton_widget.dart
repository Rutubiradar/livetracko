import 'package:cws_app/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeButtonWidget extends StatelessWidget {
  String? btnText;
  Callback? ontap;
  bool isloading;
  WelcomeButtonWidget(
      {Key? key, this.btnText, this.ontap, this.isloading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.89,
        decoration: BoxDecoration(
            color: appthemColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: isloading
              ? CircularProgressIndicator(color: Colors.white)
              : Text(
                  "$btnText",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
