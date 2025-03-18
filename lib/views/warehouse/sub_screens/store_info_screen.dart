import 'package:cws_app/util/app_utils.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../widgets/constant.dart';
import '../../outlets/add_outlet.dart';

class InStockScreen extends StatelessWidget {
  const InStockScreen({super.key, this.warehouse});
  final dynamic warehouse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(14),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          AppUtils.launchUrlFunction('tel:${warehouse["contact_no"]}');
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.call_rounded, color: appthemColor, size: 28),
                            Text('Call', style: TextStyle(color: Colors.grey.shade800, fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 1,
                      color: Colors.black12,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          //open location usng lat long google map
                          AppUtils.launchUrlFunction(
                              'https://www.google.com/maps/search/?api=1&query=${warehouse["latitude"]},${warehouse["logitude"]}');
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on_rounded, color: appthemColor, size: 28),
                            Text('Location', style: TextStyle(color: Colors.grey.shade800, fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 1,
                      color: Colors.black12,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          AppUtils.launchUrlFunction('https://wa.me/${warehouse["contact_no"]}');
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/whatsapp.png',
                              height: 25,
                              width: 25,
                              color: appthemColor,
                            ),
                            Text('Whatsapp', style: TextStyle(color: Colors.grey.shade800, fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const SizedBox(height: 10),
            // Divider(color: Colors.grey.shade200),
            // const SizedBox(height: 5),
            // GestureDetector(
            //   onTap: () {
            //     //dropdown
            //     showBottomSheet(
            //         context: context,
            //         builder: (context) => Material(
            //               shape: const RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            //               ),
            //               color: Colors.white,
            //               child: SingleChildScrollView(
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(12.0),
            //                   child: Column(
            //                     mainAxisSize: MainAxisSize.min,
            //                     children: [
            //                       Row(
            //                         children: [
            //                           const Text('Select Distributor', style: TextStyle(color: Colors.grey, fontSize: 18)),
            //                           const Spacer(),
            //                           IconButton(
            //                             onPressed: () {
            //                               Navigator.pop(context);
            //                             },
            //                             icon: const Icon(Icons.close),
            //                           )
            //                         ],
            //                       ),
            //                       ListTile(
            //                         title: Text('NIDHI SALES'),
            //                         onTap: () {
            //                           Navigator.pop(context);
            //                         },
            //                       ),
            //                       ListTile(
            //                         title: Text('NIDHI SALES'),
            //                         onTap: () {
            //                           Navigator.pop(context);
            //                         },
            //                       ),
            //                       ListTile(
            //                         title: Text('NIDHI SALES'),
            //                         onTap: () {
            //                           Navigator.pop(context);
            //                         },
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ));
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       children: [
            //         Text('Selected Distributor', style: TextStyle(color: Colors.grey.shade500)),
            //         const Spacer(),
            //         Row(children: [Text('NIDHI SALES'), const SizedBox(width: 5), Icon(Icons.search, size: 18), const SizedBox(width: 5)])
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Warehouse Erp Id', style: TextStyle(color: Colors.grey.shade500)),
                  const Spacer(),
                  Text(warehouse["erp_id"].toString()),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Warehouse Name', style: TextStyle(color: Colors.grey.shade500)),
                  const Spacer(),
                  Text(warehouse["warehouse_name"].toString()),
                ],
              ),
            ),
            if (warehouse["address"] != null) const SizedBox(height: 5),
            if (warehouse["address"] != null) Divider(color: Colors.grey.shade200),
            if (warehouse["address"] != null) const SizedBox(height: 5),
            if (warehouse["address"] != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Warehouse Address', style: TextStyle(color: Colors.grey.shade500)),
                    const Spacer(),
                    HtmlWidget(warehouse["address"].toString()),
                  ],
                ),
              ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Warehouse Contact', style: TextStyle(color: Colors.grey.shade500)),
                  const Spacer(),
                  Text(warehouse["contact_no"]),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('GSTIN Number', style: TextStyle(color: Colors.grey.shade500)),
                const Spacer(),
                Text(warehouse["gst_number"]),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
