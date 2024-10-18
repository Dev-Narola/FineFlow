// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

class Option extends StatelessWidget {
  final String title;
  const Option({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.h),
      child: Container(
        height: 55.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            width: 0.8,
            color: Kdark,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Kdark,
                letterSpace: 1.1,
              ),
              const Icon(
                LineIcons.angleRight,
              )
            ],
          ),
        ),
      ),
    );
  }
}
