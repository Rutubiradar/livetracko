import 'dart:convert';

import 'package:cws_app/network/api_client.dart';
import 'package:cws_app/views/warehouse/sub_screens/in_stock_screen.dart';
import 'package:cws_app/views/warehouse/sub_screens/store_info_screen.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../util/app_utils.dart';
import '../../widgets/constant.dart';

class WarehouseDetailScreen extends StatelessWidget {
  const WarehouseDetailScreen({super.key, this.warehouse});
  final dynamic warehouse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appthemColor,
          title: Text(warehouse["warehouse_name"],
              style: TextStyle(color: Colors.white, fontSize: 20)),
          leading: AppUtils.backButton(),
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(children: [
            Tab(
              child: Container(
                height: 50,
                width: double.maxFinite,
                color: Colors.grey.shade200,
                child: const TabBar(
                  tabAlignment: TabAlignment.start,
                  indicatorColor: appthemColor,
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 12),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  labelColor: appthemColor,
                  tabs: [
                    Tab(text: "In-Stock"),
                    Tab(text: "Store Info"),
                    // Tab(text: "Transaction History"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  StoreInfoScreen(),
                  InStockScreen(warehouse: warehouse),
                  // Center(child: Text("Transaction History")),
                ],
              ),
            ),
          ]),
        ));
  }
}
