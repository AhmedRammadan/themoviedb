import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://api.themoviedb.org/3";
const String apiKey = '&api_key=23d5dabb330b62a3ce8a9812114c03b4';
const String imageBaseUrlFace =
    'https://www.themoviedb.org/t/p/w470_and_h470_face';
const String imageBaseUrlDetails =
    'https://www.themoviedb.org/t/p/w600_and_h900_bestv2';
const String imageBaseUrlOriginal = 'https://www.themoviedb.org/t/p/original';

class APIHelper {
  static Future<dynamic> get(String path, context) async {
    _debugPrint('Api Get, url ${baseUrl + path + apiKey}');
    var responseJson;
    try {
      final response =
          await http.get(Uri.parse(baseUrl + path + apiKey), headers: {
        'Accept': ' application/json',
        'Content-Type': ' application/x-www-form-urlencoded',
      });
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body.toString());
        _debugPrint("responseJson : $responseJson");
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
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body.toString());
        _debugPrint("responseJson : $responseJson");
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
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body.toString());
        _debugPrint("responseJson : $responseJson");
      }
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
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body.toString());
        _debugPrint("responseJson : $responseJson");
      }
    } on SocketException {
      _debugPrint('No Internet connection');
    }
    return responseJson;
  }

  static _debugPrint(data) {
    print(data);
  }
}
