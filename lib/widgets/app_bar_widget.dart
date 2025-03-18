import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class App_bar extends StatelessWidget implements PreferredSizeWidget {
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(100.w, 6.h);

  App_bar(
      {Key? key, required this.start, required this.middle, required this.end})
      : super(key: key);
  Widget start;
  Widget middle;
  Widget end;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        5.h.heightBox,
        Container(
          height: 4.h,
          width: 100.w,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Row(
            children: [start, Spacer(), middle, Spacer(), end],
          ).px(3.w),
        ),
      ],
    );
  }
}
