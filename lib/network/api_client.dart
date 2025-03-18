import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;

import '../helper/app_static.dart';
import '../util/constant.dart';

class ApiClient {
  static const String apiKey = 'ftc_apikey@';
  // static const String basicAuthToken = 'c3BhbmVsOlNwYW5lbEAxMjM=';

  static const Map<String, String> headers = {
    'X-API-KEY': apiKey,
    // 'Authorization': 'Basic $basicAuthToken'
  };

  static Future<http.Response> get(String url,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(Uri.parse('${staticData.baseUrl}/$url'),
          headers: headers ?? ApiClient.headers);

      print("api in use for get response is ${'${staticData.baseUrl}/$url'}");
      debugLog('Response: ${jsonDecode(response.body)}');
      debugLog('Status Code: ${response.statusCode}');
      return response;
    } catch (e) {
      log('Error during GET request: $e');

      throw Exception('Failed to perform GET request');
    }
  }

  static Future<http.Response> post(String url, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.post(Uri.parse('${staticData.baseUrl}/$url'),
          body: body, headers: headers ?? ApiClient.headers);
      // debugLog('Url: $baseUrl$url');
      print('api in use for pose request is ${'${staticData.baseUrl}/$url'}');
      // debugLog(response.body);
      // debugLog('Response: ${jsonDecode(response.body)}');
      // debugLog('Status Code: ${response.statusCode}');
      // print('Response: ${jsonDecode(response.body)}');
      return response;
    } catch (e) {
      log('Error during POST request: $e');
      throw Exception('Failed to perform POST request');
    }
  }

  static Future<http.Response> multipart(
      String url, Map<String, String> body, File? file,
      {Map<String, String>? headers}) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse('${staticData.baseUrl}/$url'));
      print('file path: ${file?.path}');
      print("api in use for multipart is ${'${staticData.baseUrl}/$url'}");
      request.fields.addAll(body);
      request.headers.addAll(headers ?? ApiClient.headers);
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          file.path,
        ));
      }

      final response = await request.send();

      final responseData = await http.Response.fromStream(response);

      debugLog('Response: ${jsonDecode(responseData.toString())}');
      debugLog('Status Code: ${responseData.statusCode}');
      return responseData;
    } catch (e) {
      log('Error during multipart request: ${e}');
      print('Error during multipart request: $e');
      throw Exception('Failed to perform multipart request');
    }
  }
}

debugLog(String message) {
  if (kDebugMode) {
    log(">>>>>>>>$message");
  }
}
