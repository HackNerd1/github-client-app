import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget GmAvatar(
  String url, {
  double width = 30,
  double? height,
  BoxFit? fit,
  BorderRadius? borderRadius,
}) {
  var plcaeholder = Placeholder();
  return ClipRRect(
    borderRadius: borderRadius ?? BorderRadius.circular(2.0),
    child: CachedNetworkImage(
      placeholder: (context, url) => plcaeholder,
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      errorWidget: (context, url, error) => plcaeholder,
    ),
  );
}
