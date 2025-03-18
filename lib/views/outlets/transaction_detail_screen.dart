import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../../network/api_client.dart';
import '../../util/app_utils.dart';
import '../../widgets/constant.dart';
import '../receipt/order_receipt.dart';

class TransactionDetailScreen extends StatefulWidget {
  final String orderId;
  final bool isReceipt;
  TransactionDetailScreen(
      {super.key, required this.orderId, this.isReceipt = false});

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  final GlobalKey _globalKey = GlobalKey(); // GlobalKey for RepaintBoundary

  RxList orderList = <dynamic>[].obs;
  RxString taxAmount = "0".obs;
  RxString gst = "0".obs;
  RxString discount = "0".obs;
  RxString finalAmout = "0".obs;
  RxString date = "01-01-2000".obs;

  Future<void> getTransactionDetail() async {
    var response = await ApiClient.post(
        'Common/order_details', {"order_id": widget.orderId});
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      orderList(data["order_details"]);
      await calculations();
      print(data["order_details"]);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> calculations() async {
    double totalAmount = 0;
    double taxAmount = 0;
    double discount = 0;
    double gst = 0;
    double finalAmount = 0;

    DateTime orderDate = DateTime.parse(orderList[0]['created']);
    date.value = DateFormat('dd-MM-yyyy HH:mm').format(orderDate);

    for (int i = 0; i < orderList.length; i++) {
      totalAmount += double.parse(orderList[i]['total_price']);
      taxAmount += double.parse(orderList[i]['gst']);
      // discount += double.parse(orderList[i]['discount']);
      gst += double.parse(orderList[i]['gst']);
    }

    finalAmount = totalAmount;

    this.taxAmount.value = taxAmount.toStringAsFixed(2);
    this.gst.value = gst.toStringAsFixed(2);
    this.discount.value = discount.toStringAsFixed(2);
    this.finalAmout.value = finalAmount.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    getTransactionDetail();
    if (widget.isReceipt) {
      Future.delayed(Duration(seconds: 1), () {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          Uint8List? pngBytes = await _capturePng();
          if (pngBytes != null) {
            await _createPdf(pngBytes);
          }
        });
      });
    }
  }

  Future<Uint8List?> _capturePng() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 5.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _createPdf(Uint8List pngBytes) async {
    Get.to(() => ReceiptScreen());
    return;

    final pdf = pw.Document();
    final image = pw.MemoryImage(pngBytes);

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
              child: pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black, width: 2),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Expanded(
                        child: pw.Image(image),
                      ),
                    ],
                  ))); // Center
        }));
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/receipt.pdf");
    await file.writeAsBytes(await pdf.save());
    print('pdf saved at ${file.path}');
    if (widget.isReceipt) {
      Get.back();
    }
    await OpenFilex.open(file.path);
    // await Printing.sharePdf(bytes: await pdf.save(), filename: 'receipt.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      appBar: AppBar(
        backgroundColor: appthemColor,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('INV-${widget.orderId}',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
        leading: AppUtils.backButton(),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.picture_as_pdf, color: Colors.white),
          //   onPressed: () async {
          //     Uint8List? pngBytes = await _capturePng();
          //     if (pngBytes != null) {
          //       await _createPdf(pngBytes);
          //     }
          //   },
          // ),
        ],
      ),
      body: RepaintBoundary(
        // Wrap the entire content in RepaintBoundary
        key: _globalKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(12.0),
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Text("Items",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Obx(
                            () => ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: orderList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 5,
                                              spreadRadius: 1,
                                              offset: Offset(0, 3))
                                        ],
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade400))),
                                    child: ListTile(
                                      tileColor: Colors.transparent,
                                      contentPadding: EdgeInsets.zero,
                                      title:
                                          Text("${orderList[index]['name']}"),
                                      subtitle: Text(
                                          "₹ ${orderList[index]['special_price']} | Qty: ${orderList[index]['qty']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      trailing: Text(
                                          "₹ ${orderList[index]['total_price']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Divider(color: Colors.grey.shade200),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                      offset: Offset(0, 3))
                                ]),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Tax Amount",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16)),
                                    Spacer(),
                                    Obx(
                                      () => Text("₹ ${taxAmount.value}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16)),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text("GST",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16)),
                                    Spacer(),
                                    Obx(
                                      () => Text("₹ ${gst.value}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16)),
                                    )
                                  ],
                                ),
                                // const SizedBox(height: 5),
                                // const Row(
                                //   children: [
                                //     Text("Discount",
                                //         style: TextStyle(
                                //             color: Colors.black, fontSize: 16)),
                                //     Spacer(),
                                //     Text("₹ 0",
                                //         style: TextStyle(
                                //             color: Colors.black, fontSize: 16)),
                                //   ],
                                // ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text("Total",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Spacer(),
                                    Obx(
                                      () => Text("₹ ${finalAmout.value}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              spreadRadius: 5,
                              offset: Offset(0, 5))
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Invoice Details",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Invoice Date",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16)),
                              Spacer(),
                              Obx(
                                () => Text("${date.value}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Invoice Type",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16)),
                              Spacer(),
                              Text("Sales Invoice",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
