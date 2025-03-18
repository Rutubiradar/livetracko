import 'dart:convert';

import 'package:cws_app/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../helper/app_static.dart';
import '../../network/api_client.dart';
import '../../util/app_storage.dart';
import '../../util/app_utils.dart';
import '../../util/constant.dart';

class DaGenericDetail extends StatefulWidget {
  final String daGenericId;
  const DaGenericDetail({super.key, required this.daGenericId});

  @override
  State<DaGenericDetail> createState() => _DaGenericDetailState();
}

class _DaGenericDetailState extends State<DaGenericDetail> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController distInKmController = TextEditingController();
  TextEditingController fareRsController = TextEditingController();
  TextEditingController dailyAllowController = TextEditingController();
  TextEditingController miscAndTelRsController = TextEditingController();
  String? image;

  Future<void> getDetails() async {
    var body = {"generic_id": widget.daGenericId};

    var response = await ApiClient.post('Common/generic_details', body);

    if (response.statusCode == 200) {
      var value = jsonDecode(response.body);
      var data = value["generic_details"];
      fromController.text = data["from"];
      toController.text = data["to"];
      distInKmController.text = data["distance"];
      fareRsController.text = data["fare_rs"];
      dailyAllowController.text = data["daily_allowance"];
      miscAndTelRsController.text = data["misc"];
      image = data["image"] ?? "";

      setState(() {});
      print(data);
    } else {
      print(response.body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: appthemColor,
        centerTitle: true,
        title: const Text('Da Generic Detail',
            style: TextStyle(color: Colors.white)),
        leading: AppUtils.backButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            const SizedBox(height: 15),
            TextFormField(
              readOnly: true,
              controller: fromController,
              decoration: InputDecoration(
                labelText: 'From',
                hintText: 'From',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter from';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              readOnly: true,
              controller: toController,
              decoration: InputDecoration(
                labelText: 'To',
                hintText: 'To',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter to';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              readOnly: true,
              controller: distInKmController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Dist In Km',
                hintText: 'Dist In Km',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter distance in km';
                } else if (int.parse(value) < 0) {
                  return 'Please enter valid distance';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              readOnly: true,
              controller: fareRsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Fare Rs',
                hintText: 'Fare Rs',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter fare Rs';
                } else if (int.parse(value) < 0) {
                  return 'Please enter valid fare Rs';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              readOnly: true,
              controller: dailyAllowController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Daily Allow',
                hintText: 'Daily Allow',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter daily allow';
                } else if (int.parse(value) < 0) {
                  return 'Please enter valid daily allow';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              readOnly: true,
              controller: miscAndTelRsController,
              decoration: InputDecoration(
                labelText: 'Misc and Tel Rs',
                hintText: 'Misc and Tel Rs',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter misc and tel Rs';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            image != null
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    child:
                        Image.network(staticData.baseGenericImageUrl + image!),
                  )
                : SizedBox.shrink()
          ]),
        ),
      ),
    ));
  }
}
