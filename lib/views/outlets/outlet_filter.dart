import 'package:floating_tabbar/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:cws_app/widgets/constant.dart';

import '../../util/app_utils.dart';

class OutletFilterScreen extends StatelessWidget {
  const OutletFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: appthemColor,
        title: Text('Outlet Filter',
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text("Reset",
                  style: TextStyle(color: Colors.white, fontSize: 18))),
        ],
        leading: AppUtils.backButton(),
      ),
      body: Column(
        children: [
          // sort by using two radio buttons Desault and albhabetic
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Sort By", style: GoogleFonts.poppins(fontSize: 18)),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: 1,
                          groupValue: 1,
                          onChanged: (value) {},
                          activeColor: appthemColor,
                        ),
                        Text(
                          "Default",
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: 2,
                          groupValue: 1,
                          onChanged: (value) {},
                          activeColor: appthemColor,
                        ),
                        Text(
                          "Alphabetic",
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
              color: appthemColor,
              width: double.maxFinite,
              height: 45,
              child: Center(
                  child: Text("Outlet Category",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)))),
//threelist check box named a , b ,c
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("1. A", style: GoogleFonts.poppins(fontSize: 18)),
                    Spacer(),
                    Checkbox(
                        activeColor: appthemColor,
                        value: false,
                        onChanged: (value) {}),
                  ],
                ),
                Divider(height: 10.0, color: Colors.black12),
                Row(
                  children: [
                    Text("2. B", style: GoogleFonts.poppins(fontSize: 18)),
                    Spacer(),
                    Checkbox(
                        activeColor: appthemColor,
                        value: false,
                        onChanged: (value) {}),
                  ],
                ),
                Divider(height: 10.0, color: Colors.black12),
                Row(
                  children: [
                    Text("3. C", style: GoogleFonts.poppins(fontSize: 18)),
                    Spacer(),
                    Checkbox(
                        activeColor: appthemColor,
                        value: false,
                        onChanged: (value) {}),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
              color: appthemColor,
              width: double.maxFinite,
              height: 45,
              child: Center(
                  child: Text("Outlet Type",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)))),
//threelist check box named a , b ,c
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("4. Cold Drink Shop",
                        style: GoogleFonts.poppins(fontSize: 18)),
                    Spacer(),
                    Checkbox(
                        activeColor: appthemColor,
                        value: false,
                        onChanged: (value) {}),
                  ],
                ),
                Divider(height: 10.0, color: Colors.black12),
                Row(
                  children: [
                    Text("5. Direct", style: GoogleFonts.poppins(fontSize: 18)),
                    Spacer(),
                    Checkbox(
                        activeColor: appthemColor,
                        value: false,
                        onChanged: (value) {}),
                  ],
                ),
                Divider(height: 10.0, color: Colors.black12),
                Row(
                  children: [
                    Text("6. Indirect",
                        style: GoogleFonts.poppins(fontSize: 18)),
                    Spacer(),
                    Checkbox(
                        activeColor: appthemColor,
                        value: false,
                        onChanged: (value) {}),
                  ],
                ),
                Divider(height: 10.0, color: Colors.black12),
                Row(
                  children: [
                    Text("7. Super Market",
                        style: GoogleFonts.poppins(fontSize: 18)),
                    Spacer(),
                    Checkbox(
                        activeColor: appthemColor,
                        value: false,
                        onChanged: (value) {}),
                  ],
                ),
                Divider(height: 10.0, color: Colors.black12),
                Row(
                  children: [
                    Text("8. Medical Store",
                        style: GoogleFonts.poppins(fontSize: 18)),
                    Spacer(),
                    Checkbox(
                        activeColor: appthemColor,
                        value: false,
                        onChanged: (value) {}),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
