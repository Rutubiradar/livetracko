import 'package:cws_app/views/items/add_item.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/app_utils.dart';
import '../../widgets/constant.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appthemColor,
        title: const Text('Items',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        )),
        leading: AppUtils.backButton(),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: Icon(Icons.search_rounded, color: Colors.white, size: 30),
          ),
          IconButton(
            padding: EdgeInsets.only(right: 12),
            onPressed: () {
              Get.to(() => AddItemScreen());
            },
            icon: Icon(Icons.add_box_rounded, color: Colors.white, size: 30),
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 20),
        padding: const EdgeInsets.all(8),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLie01F5KNjL7u-Cig9hHublWjyw_RqgdRiFrwaJk3Q9n1DL8eT9skI-5P8xk8FoXaqE0&usqp=CAU'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lemon Soap',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          Text("Net Weight : 100g",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14)),
                          Divider(
                            height: 5,
                            color: Colors.black.withOpacity(.05),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('MRP ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                    Text('50.0',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('Rate ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                    Text('100.0',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('Margin ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                    //margin in percentage
                                    Text('50%',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          );
        },
      ),
    );
  }
}
