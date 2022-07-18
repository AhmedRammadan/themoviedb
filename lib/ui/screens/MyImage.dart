import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:themoviedb/utils/constants.dart';
import '../../utils/network.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets/my_cached_network_image.dart';

class MyImage extends StatefulWidget {
  String filePath;
  MyImage({Key? key, required this.filePath}) : super(key: key);

  @override
  State<MyImage> createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Constants.initProgressDialog(isShowing: true, context: context);
          Directory appDocDir = await getApplicationDocumentsDirectory();
          String appDocPath = appDocDir.path;
          print(appDocPath);
          var response = await Dio().download(
              imageBaseUrlOriginal + widget.filePath,
              appDocPath + widget.filePath);
          print(appDocPath + widget.filePath);
          if (response.statusCode == 200) {
            Constants.initProgressDialog(isShowing: false, context: context);
            Constants.imageFileDialog(
                isShowing: true,
                context: context,
                path: appDocPath + widget.filePath);
          }

        },
        child: const Center(
          child: Icon(
            Icons.download_for_offline,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: MyCachedNetworkImage(
          imageUrl: imageBaseUrlOriginal + widget.filePath,
        ),
      ),
    );
  }
}
