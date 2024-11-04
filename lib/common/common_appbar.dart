// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

class CommonAppbar extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  const CommonAppbar({
    super.key,
    this.name,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    String getGreetingMessage() {
      final hour = DateTime.now().hour;

      if (hour >= 0 && hour < 12) {
        return "Good morning";
      } else if (hour >= 12 && hour < 17) {
        return "Good afternoon";
      } else {
        return "Good evening";
      }
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 8.0.h, bottom: 16.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0.w),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl!),
                    backgroundColor: Koffwhite,
                    foregroundColor: Koffwhite,
                    radius: 26.r,
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                ReusableText(
                  text: "${getGreetingMessage()}, $name",
                  fontSize: 18,
                  color: Kdark,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0.w),
              child: Icon(
                LineIcons.barChartAlt,
                size: 26.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
