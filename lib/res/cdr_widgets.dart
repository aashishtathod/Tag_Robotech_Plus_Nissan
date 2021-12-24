import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:robotech/res/custom_colors.dart';

Widget createText1(String curText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Text(
      curText,
      style: TextStyle(
          fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.grey),
    ),
  );
}

Widget createText2(String curText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Text(
      curText,
      style: TextStyle(
          fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.black),
    ),
  );
}

Widget createText3(String curText) {
  return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Text(
        curText,
        style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: (curText == "NO")
                ? Colors.red
                : (curText == "no")
                    ? Colors.red
                    : (curText == "No"
                        ? Colors.red
                        : (curText == "nO")
                            ? Colors.red
                            : Colors.green)),
      ));
}

