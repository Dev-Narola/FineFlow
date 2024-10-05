// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpanseReportTile extends StatelessWidget {
  final String title;
  final String expanse;
  final String time;
  const ExpanseReportTile(
      {super.key,
      required this.title,
      required this.expanse,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Kwhite,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          width: 1.3,
          color: Kdark,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  text: title,
                  color: Kdark,
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold,
                  letterSpace: 1.3,
                  fontHeight: 1.6,
                ),
                ReusableText(
                  text: "expanse : ₹$expanse",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpace: 0.6,
                  fontHeight: 1.8,
                ),
                ReusableText(
                  text: "added time : $time",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpace: 0.6,
                  fontHeight: 1.8,
                ),
              ],
            ),
            const ReusableText(
              text: "View more",
              fontSize: 15,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
