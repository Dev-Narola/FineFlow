// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/model/all_report_response/report_model.dart';
import 'package:fineflow0/screens/dashboard/view_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExpanseReportTile extends StatelessWidget {
  final ReportModel report;
  const ExpanseReportTile({
    super.key,
    required this.report,
  });

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
                Row(
                  children: [
                    ReusableText(
                      text: report.name.toString(),
                      color: Kdark,
                      fontSize: 16.5,
                      fontWeight: FontWeight.bold,
                      letterSpace: 1.3,
                      fontHeight: 1.6,
                    ),
                  ],
                ),
                ReusableText(
                  text: "${report.type} : ₹${report.amount}",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpace: 0.6,
                  fontHeight: 1.8,
                ),
                ReusableText(
                  text: "added time : ${report.date}",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpace: 0.6,
                  fontHeight: 1.8,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Get.to(
                  () => ViewReport(
                    report: report,
                  ),
                  transition: Transition.fadeIn,
                  duration: Duration(milliseconds: 500),
                );
              },
              child: ReusableText(
                text: "View more",
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
