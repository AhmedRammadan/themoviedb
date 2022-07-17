import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String storageBaseUrl = "/storage/";
const String baseUrl = "http://transmission-dev.azurewebsites.net/api/";

class APIHelper {
  static Future<dynamic> get(String url, context) async {
    _debugPrint('Api Get, url ${baseUrl + url}');
    var responseJson;
    try {
      final response = await http.get(Uri.parse(baseUrl + url), headers: {
        'Accept': ' application/json',
        'Content-Type': ' application/x-www-form-urlencoded',
      });
      responseJson = json.decode(response.body.toString());
      _debugPrint("responseJson : $responseJson");
      if (responseJson['message'] == "Unauthenticated.") {
        // Provider.of<AccountProvider>(context, listen: false).logout(context);
      }
    } on SocketException {
      _debugPrint('SocketException : No Internet connection');
    } catch (e) {
      _debugPrint('SocketException : $e');
    }
    return responseJson;
  }

  static Future<dynamic> post(
      {required String url,
      dynamic body,
      required BuildContext context}) async {
    _debugPrint('Api Post, \nurl : ${baseUrl + url} \nbody : $body');
    Map<String, dynamic>? responseJson;
    try {

      final response =
          await http.post(Uri.parse(baseUrl + url), body: body, headers: {
        'Accept': ' application/json',
        'Content-Type': ' application/x-www-form-urlencoded',
      });
      responseJson = json.decode(response.body.toString());
      _debugPrint("responseJson : $responseJson");
      if (responseJson!['message'] == "Unauthenticated.") {
        //Provider.of<AccountProvider>(context, listen: false).logout(context);
      }
    } on SocketException {
      _debugPrint('SocketException : No Internet connection');
    } catch (e) {
      _debugPrint('SocketException : $e');
    }
    return responseJson;
  }

  static Future<dynamic> put(String url, dynamic body) async {
    _debugPrint('Api Put, url $url');
    var responseJson;
    try {
      final response = await http.put(Uri.parse(baseUrl + url), body: body);
      responseJson = json.decode(response.body.toString());
    } on SocketException {
      _debugPrint('No Internet connection');
    }
    return responseJson;
  }

  static Future<dynamic> delete(String url) async {
    _debugPrint('Api delete, url $url');
    var responseJson;
    try {
      final response = await http.delete(Uri.parse(baseUrl + url));
      responseJson = json.decode(response.body.toString());
    } on SocketException {
      _debugPrint('No Internet connection');
    }
    return responseJson;
  }

  static _debugPrint(data) {
    print(data);
  }
}
