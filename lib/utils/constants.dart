import 'dart:io';

import 'package:flutter/material.dart';

class Constants {

  static bool connected = false;

  static void push(BuildContext context, Widget screen) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

  static void replace(BuildContext context, Widget route) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => route));

  static void replaceAll(BuildContext context, Widget route) =>
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => route), (route) => false);

  static initProgressDialog(
      {required bool isShowing, required BuildContext context}) {
    if (isShowing) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
              child: const CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ),
          );
        },
      );
    } else {
      Navigator.pop(context);
    }
  }  static imageFileDialog(
      {required bool isShowing, required BuildContext context ,required String path}) {
    if (isShowing) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Column(
              children: [
                Text("Local path $path",style: const TextStyle(color: Colors.white),),
                const SizedBox(
                 height: 10,
               ),
                Center(
                  child: Image.file(
                  File(path),
                    alignment: Alignment.centerLeft,
                    errorBuilder: (
                        BuildContext context,
                        Object error,
                        StackTrace? stackTrace,
                        ) =>
                        Container(),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      Navigator.pop(context);
    }
  }

  static void pop(BuildContext context, {String res = ""}) =>
      Navigator.pop(context, res);

}
