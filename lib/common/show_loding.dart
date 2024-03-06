import 'package:flutter/material.dart';

Future showLoading(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [const CircularProgressIndicator()]),
        );
      });
}
