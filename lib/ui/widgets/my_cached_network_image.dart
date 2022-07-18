import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget MyCachedNetworkImage(
    {required String imageUrl,
      double? width,
      fit = BoxFit.fill,
      double? height}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: fit,
    width: width,
    height: height,
    errorWidget: (context, test, data) => Container(
      height: height,
      width: width,
    ),
    placeholder: (context, url) => Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Center(child: CircularProgressIndicator()),
    ),
  );
}
