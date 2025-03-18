import 'package:floating_tabbar/lib.dart';
import 'package:flutter/material.dart';

import '../../util/app_utils.dart';
import '../../widgets/constant.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appthemColor,
        centerTitle: true,
        title: const Text('Help',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        )),
        leading: AppUtils.backButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: appthemColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset("assets/logo.png",
                                    height: 30,
                                    width: 50,
                                    color: Colors.white)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('App Name',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 10),
                                  const Text('v1.0.0',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //Office Address
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: appthemColor,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Office Address',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text('Street, City, State, Country',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            ListTile(
              leading: const Icon(Icons.call),
              title: const Text('Call Us'),
              subtitle: const Text('1234567890'),
            ),
            ListTile(
                leading: const Icon(Icons.email_rounded),
                title: const Text('Email Us'),
                subtitle: const Text('support@gmail.com')),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Frequently Asked Questions",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold))),
                    ),
                    ListTile(
                      title: const Text('How to mark visit?'),
                      subtitle: const Text(
                          'To mark visit, go to the outlet details and click on mark visit button.'),
                    ),
                    Divider(color: Colors.black.withOpacity(.05)),
                    ListTile(
                      title: const Text('How to add new outlet?'),
                      subtitle: const Text(
                          'To add new outlet, go to the outlets screen and click on add outlet button.'),
                    ),
                    Divider(color: Colors.black.withOpacity(.05)),
                    ListTile(
                      title: const Text('How to add new item?'),
                      subtitle: const Text(
                          'To add new item, go to the items screen and click on add item button.'),
                    ),
                    Divider(color: Colors.black.withOpacity(.05)),
                    ListTile(
                      title: const Text('How to add new sales?'),
                      subtitle: const Text(
                          'To add new sales, go to the outlet details and click on add sales button.'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 140),
          ],
        ),
      ),
    );
  }
}
