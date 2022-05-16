import 'package:flutter/material.dart';

class UiHelper {
  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double height(BuildContext context) {
    return getSize(context).height;
  }

  static double width(BuildContext context) {
    return getSize(context).width;
  }
}
