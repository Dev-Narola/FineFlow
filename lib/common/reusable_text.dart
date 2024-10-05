import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? letterSpace;
  final double? fontHeight;
  const ReusableText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.letterSpace,
    this.fontHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color ?? Colors.black,
          fontSize: fontSize ?? 16.sp,
          fontWeight: fontWeight ?? FontWeight.w400,
          letterSpacing: letterSpace ?? 0.5,
          height: fontHeight ?? 1.2),
    );
  }
}
