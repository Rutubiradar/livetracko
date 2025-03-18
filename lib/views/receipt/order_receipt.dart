import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart'; // Import for path handling
import 'dart:io'; // Import for file handling

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key, this.isShare = false});
  final bool isShare;

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  Future<pw.Document> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Column(children: [
        pw.Expanded(
            child: pw.Container(
                padding: pw.EdgeInsets.all(10),
                height: 600,
                width: double.infinity,
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black, width: 2)),
                child: pw.Column(children: [
                  pw.Container(
                    height: 40,
                    width: double.infinity,
                    child: pw.Center(
                        child: pw.Text("Receipt",
                            style: pw.TextStyle(fontSize: 30))),
                  ),
                  pw.Divider(color: PdfColors.black),
                  pw.SizedBox(height: 10),
                  pw.Container(
                    height: 40,
                    width: double.infinity,
                    child: pw.Text("Order Id: 123456",
                        style: pw.TextStyle(fontSize: 20)),
                  ),
                  pw.Container(
                    height: 40,
                    width: double.infinity,
                    child: pw.Text("Order Date: 12/12/2021",
                        style: pw.TextStyle(fontSize: 16)),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Container(
                    height: 40,
                    width: double.infinity,
                    child: pw.Text("Name: John Doe",
                        style: pw.TextStyle(fontSize: 16)),
                  ),
                  pw.Table(
                      border: pw.TableBorder(
                        top: pw.BorderSide(color: PdfColors.black),
                        bottom: pw.BorderSide(color: PdfColors.black),
                        left: pw.BorderSide(color: PdfColors.black),
                        right: pw.BorderSide(color: PdfColors.black),
                        verticalInside: pw.BorderSide(color: PdfColors.black),
                      ),
                      children: [
                        pw.TableRow(
                            decoration:
                                pw.BoxDecoration(color: PdfColors.grey300),
                            children: [
                              pw.Text('Sr no.',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('Product Name',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('Quantity',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('Price',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('Total Price',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            ]),
                        pw.TableRow(children: [
                          pw.Text('1.', textAlign: pw.TextAlign.center),
                          pw.Text('Android', textAlign: pw.TextAlign.center),
                          pw.Text('12', textAlign: pw.TextAlign.center),
                          pw.Text('512', textAlign: pw.TextAlign.center),
                          pw.Text('512', textAlign: pw.TextAlign.center),
                        ]),
                        pw.TableRow(children: [
                          pw.Text('2.', textAlign: pw.TextAlign.center),
                          pw.Text('Android', textAlign: pw.TextAlign.center),
                          pw.Text('12', textAlign: pw.TextAlign.center),
                          pw.Text('512', textAlign: pw.TextAlign.center),
                          pw.Text('512', textAlign: pw.TextAlign.center),
                        ]),
                        pw.TableRow(children: [
                          pw.Container(height: 300),
                          pw.Container(height: 300),
                          pw.Container(height: 300),
                          pw.Container(height: 300),
                          pw.Container(height: 300),
                        ]),
                      ]),
                  pw.SizedBox(height: 10),
                  pw.Container(
                    height: 40,
                    width: double.infinity,
                    child: pw.Text("Total Amount: 1000",
                        style: pw.TextStyle(fontSize: 16)),
                  ),
                ])))
      ]);
    }));

    return pdf;
  }

  Future<void> savePdfLocally(pw.Document pdf) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/receipt.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      Get.snackbar("Success", "PDF saved to $filePath",
          backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "Failed to save PDF: $e",
          backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<pw.Document>(
          future: generatePdf(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: Lottie.asset('assets/Animations/receipt.json'),
                    ),
                    Text("Generating pdf... ",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error generating PDF'));
            } else if (snapshot.hasData) {
              final pdf = snapshot.data!;
              if (widget.isShare) {
                // Share the PDF
                Future.delayed(Duration(seconds: 1), () async {
                  Printing.sharePdf(
                      bytes: await pdf.save(), filename: 'receipt.pdf');
                });
                return Center(child: Text("Sharing PDF..."));
              } else {
                // Print the PDF and provide download option
                return PdfPreview(
                  build: (format) => pdf.save(),
                  canChangeOrientation: false,
                  canDebug: false,
                  actions: [
                    PdfPreviewAction(
                      icon: Icon(Icons.download),
                      onPressed: (context, build, format) async {
                        savePdfLocally(pdf);
                      },
                    ),
                  ],
                );
              }
            } else {
              return Center(child: Text('No data'));
            }
          },
        ),
      ),
    );
  }
}
