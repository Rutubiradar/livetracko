import 'dart:convert';

import 'package:cws_app/util/app_storage.dart';
import 'package:cws_app/views/da_form/da_generic_detail.dart';
import 'package:cws_app/widgets/no_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../network/api_client.dart';
import '../../util/app_utils.dart';
import '../../widgets/constant.dart';

class DaGenericList extends StatefulWidget {
  const DaGenericList({super.key});

  @override
  State<DaGenericList> createState() => _DaGenericListState();
}

class _DaGenericListState extends State<DaGenericList> {
  var listOfGeneric = [].obs;

  Future<List<dynamic>> getDaGenericList() async {
    var userId = AppStorage.getUserId();
    var body = {"emp_id": userId};

    var response = await ApiClient.post('Common/generic_list', body);

    if (response.statusCode == 200) {
      var data = response.body;
      return jsonDecode(data)["generic_list"] ?? [];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> deleteDaGenericList(String id) async {
    var body = {"generic_id": id};

    var response = await ApiClient.post('Common/generic_remove', body);

    if (response.statusCode == 200) {
      Get.snackbar("Deleted", "", backgroundColor: Colors.green);
      setState(() {
        getDaGenericList();
      });
    } else {
      Get.snackbar("Error", "Failed to delete", backgroundColor: Colors.green);
    }
  }

  @override
  void initState() {
    super.initState();
    getDaGenericList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appthemColor,
        centerTitle: true,
        title: Text(
          'Da Generic List',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: AppUtils.backButton(),
      ),
      body: RefreshIndicator(
        onRefresh: () => getDaGenericList(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: FutureBuilder<List<dynamic>>(
            future: getDaGenericList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildLoadingShimmer();
              } else if (snapshot.hasError) {
                return buildErrorWidget();
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return buildNoContentWidget();
              } else {
                listOfGeneric.value = snapshot.data!;
                return buildListView();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      period: const Duration(milliseconds: 2000),
      child: ListView.separated(
        itemBuilder: (context, index) => buildShimmerTile(),
        separatorBuilder: (context, index) => SizedBox(height: 10),
        itemCount: 10,
      ),
    );
  }

  Widget buildErrorWidget() {
    return const Center(
      child: Text(
        "Error occurred while getting the list",
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  Widget buildNoContentWidget() {
    return const Center(
      child: NoContentScreen(),
    );
  }

  Widget buildListView() {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemCount: listOfGeneric.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            onTap: () => Get.to(() => DaGenericDetail(
                  daGenericId: listOfGeneric[index]["id"],
                )),
            title: Text(
              listOfGeneric[index]["from"],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listOfGeneric[index]["to"],
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                Text(
                  listOfGeneric[index]["distance"],
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                showDeleteDialog(listOfGeneric[index]["id"]);
              },
              icon: const Icon(Icons.delete, color: Colors.redAccent),
            ),
          ),
        );
      },
    );
  }

  Widget buildShimmerTile() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: ListTile(
        tileColor: Colors.grey.shade200,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 30,
            color: Colors.grey.shade300,
          ),
        ),
        subtitle: Column(
          children: [
            10.heightBox,
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 20,
                color: Colors.grey.shade300,
              ),
            ),
          ],
        ),
        trailing: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 40,
            width: 40,
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  void showDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Are you sure you want to delete?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                await deleteDaGenericList(id);
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
