import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> mySnackBar(
    {required BuildContext context, String? content}) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(content ?? "")));
}
