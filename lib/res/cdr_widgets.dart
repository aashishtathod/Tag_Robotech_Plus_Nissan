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

Widget createButtons(BuildContext context) {
  bool status = false;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
              primary: kPrimaryColor,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: const Text(
              "Cancel",
            )),
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
              primary: kPrimaryColor,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Upload",
            )),
      ),
    ],
  );
}
