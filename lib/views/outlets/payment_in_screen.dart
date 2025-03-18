import 'package:floating_tabbar/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../util/app_utils.dart';
import '../../widgets/constant.dart';

class PaymentInScreen extends StatelessWidget {
  const PaymentInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appthemColor,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Payment In',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              Text('Sachine Store',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ))
            ],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          )),
          leading: AppUtils.backButton(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Unsettled Invoices",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      shrinkWrap: true,
                      itemCount: 0,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Biscuit",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16)),
                                      Text("₹ 500/pcs",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16)),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: appthemColor),
                                    ),
                                    child: Row(
                                      children: [
                                        //add and remove button with count
                                        Container(
                                          height: 30,
                                          width: 30,
                                          child: Icon(Icons.remove,
                                              color: appthemColor, size: 20),
                                        ),
                                        //divider container
                                        Container(
                                          height: 30,
                                          width: 1,
                                          color: appthemColor,
                                        ),
                                        const SizedBox(width: 15),
                                        Text(index.isEven ? "1" : '0',
                                            style: TextStyle(
                                                color: index.isEven
                                                    ? Colors.black87
                                                    : Colors.black54,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(width: 15),
                                        Container(
                                          height: 30,
                                          width: 1,
                                          color: appthemColor,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          child: Icon(Icons.add,
                                              color: appthemColor, size: 20),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  index.isEven
                                      ? SizedBox.shrink()
                                      : Text('Stock out',
                                          style: TextStyle(color: Colors.grey)),
                                  Spacer(),
                                  Text("₹ 500",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Text("Remove Item",
                                  style: TextStyle(
                                      color: appthemColor, fontSize: 16)),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.black.withOpacity(.05)),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Payment Details",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter Amount',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Divider(color: Colors.black.withOpacity(.05)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Payment Type",
                                style: TextStyle(fontSize: 18))),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 6),
                              decoration: BoxDecoration(
                                color: appthemColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('Cash',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('Cheque',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('Online',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Divider(color: Colors.black.withOpacity(.05)),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Enter Instruction',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        )),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: appthemColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: SizedBox(
          height: 70,
          width: double.maxFinite,
          child: Material(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Amount",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      Text("₹ 0",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: appthemColor,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 2),
                      child: Center(
                        child: Text(
                          "Place Order",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
