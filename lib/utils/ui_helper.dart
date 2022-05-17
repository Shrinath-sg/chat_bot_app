import 'package:flutter/material.dart';
import 'package:task_app/utils/styles.dart';

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

  static void openLoadingDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: <Widget>[
            const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: Styles.headingStyle4(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
