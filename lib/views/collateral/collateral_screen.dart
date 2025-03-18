import 'dart:convert';
import 'dart:developer';

import 'package:cws_app/util/app_utils.dart';
import 'package:cws_app/util/constant.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:cws_app/widgets/no_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';

import '../../helper/app_static.dart';
import '../../network/api_client.dart';

class CollateralScreen extends StatelessWidget {
  const CollateralScreen({super.key});

  Future<List<dynamic>> getCollateral() async {
    var response = await ApiClient.post("Common/collateral_list", {});
    if (response.statusCode == 200) {
      final data = response.body;
      final collaterals = jsonDecode(data)["collateral_list"];
      log(data.toString());
      return collaterals;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appthemColor,
        title: const Text('Collateral',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        leading: AppUtils.backButton(),
      ),
      body: FutureBuilder<List<dynamic>>(
          future: getCollateral(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: appthemColor));
            }
            final list = snapshot.data as List<dynamic>;

            if (list.isEmpty) {
              return NoContentScreen();
            }

            return GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final collateral = list[index];
                if (collateral['document'] == "" ||
                    collateral['document'] == null) {
                  return const SizedBox.shrink();
                }

                return GestureDetector(
                  onTap: () {
                    Get.to(() => PdfViewerScreen(document: collateral));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(child: Image.asset("assets/pdf.png")),
                          const SizedBox(height: 5),
                          Text(collateral['document'],
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  const PdfViewerScreen({super.key, this.document});
  final dynamic document;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appthemColor,
        title: Text('${document['document']}',
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              AppUtils.showLoader();
              FileDownloader.downloadFile(
                  url: staticData.collateralsUrl + document['document'],
                  name: document['document'],
                  onProgress: (String? fileName, double progress) {
                    print('PROGRESS: $progress');
                  },
                  onDownloadCompleted: (String path) {
                    print('FILE DOWNLOADED TO PATH: $path');
                    AppUtils.hideLoader();
                    AppUtils.snackBar('File downloaded successfully');
                  },
                  onDownloadError: (String error) {
                    print('DOWNLOAD ERROR: $error');
                    AppUtils.hideLoader();
                  });
            },
            icon: const Icon(Icons.download, color: Colors.white),
          ),
        ],
      ),
      body: const PDF().cachedFromUrl(
        staticData.collateralsUrl + document['document'],
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
