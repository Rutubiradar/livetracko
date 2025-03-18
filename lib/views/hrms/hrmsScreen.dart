import 'package:cws_app/util/app_utils.dart';
import 'package:cws_app/views/attendance/attendance_screen.dart';
import 'package:cws_app/views/leave/leave_request_new.dart';
import 'package:cws_app/views/outlets/add_outlet.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:flutter/material.dart';

class hrmsScreen extends StatefulWidget {
  const hrmsScreen({super.key});

  @override
  State<hrmsScreen> createState() => _hrmsScreenState();
}

class _hrmsScreenState extends State<hrmsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appthemColor,
        centerTitle: true,
        title: const Text('HRMS',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        )),
        leading: AppUtils.backButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AttendanceScreen()));
              },
              child: Card(
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.fingerprint_rounded,
                          size: 50, color: appthemColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Attendence',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomTabBarDemo(),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.groups_3, size: 50, color: appthemColor),
                    SizedBox(height: 10),
                    Text('HRMS',
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ],
                ),
              ),

              //  Card(
              //   child: Padding(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Icon(Icons.work_history_rounded,
              //             size: 50, color: appthemColor),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text(
              //           'Leave Request',
              //           style: TextStyle(
              //             fontSize: 16,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            )
          ],
        ),
      ),
    );
  }
}
