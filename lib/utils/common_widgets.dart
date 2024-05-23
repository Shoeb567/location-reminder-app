import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget? commonToast({String? message}) {
  Fluttertoast.showToast(
      msg: message ?? "",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white);
  return null;
}

Widget commonButton({
  String? title,
  Color? backgroundColor,
  Color? textColor,
  Color? borderColor,
  VoidCallback? onTap,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: borderColor ?? Colors.transparent),
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
    child: MaterialButton(
      height: 54,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      color: backgroundColor,
      onPressed: onTap,
      child: Text(
        title!,
      ),
    ),
  );
}
