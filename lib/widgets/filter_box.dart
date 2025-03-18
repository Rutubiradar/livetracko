import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:cws_app/widgets/constant.dart';

class Filter_Box extends StatelessWidget {
  const Filter_Box({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reset",
                      style: GoogleFonts.poppins(fontSize: 18, color: appthemColor),
                    ),
                    Text(
                      "Filter",
                      style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
                    ),
                    Icon(
                      Icons.cancel_outlined,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              SizedBox(height: 150.0),
              ListTile(
                title: Text(
                  "Price",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                ),
              ),
              Divider(
                height: 1.0,
              ),
              ListTile(
                title: Text(
                  "Special Price",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                ),
              ),
              Divider(
                height: 1.0,
              ),
              ListTile(
                title: Text(
                  "Brand",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.black,
                ),
              ),
              RadioListTile(
                value: null,
                groupValue: null,
                onChanged: null,
                title: Text(
                  "Somany",
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                ),
              ),
              RadioListTile(
                value: null,
                groupValue: null,
                onChanged: null,
                title: Text(
                  "Yellow Verandha",
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
