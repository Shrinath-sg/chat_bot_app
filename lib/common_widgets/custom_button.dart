import 'package:flutter/material.dart';
import 'package:task_app/utils/colors.dart';
import 'package:task_app/utils/ui_helper.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.onPressed,
    this.padding,
    this.text,
  }) : super(key: key);
  EdgeInsetsGeometry? padding;
  String? text;
  Color? color;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: UiHelper.height(context) * 0.06,
      color: color ?? AppColors.purple,
      child: Text(
        text ?? 'button',
        style: const TextStyle(color: Colors.white, fontSize: 16.0),
      ),
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
