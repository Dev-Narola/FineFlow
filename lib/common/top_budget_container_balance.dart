// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../controller/get_all_report.dart';

class TopBudgetContainerBalance extends StatelessWidget {
  final GetAllReport reportController = Get.find<GetAllReport>();

  TopBudgetContainerBalance({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Obx(() {
      var balance = reportController.currentBalance.value;

      return Container(
        height: 70.h,
        width: (width / 2.3).w,
        decoration: BoxDecoration(
          color: Kdark,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReusableText(
                text: "Current Balance",
                color: Koffwhite,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              ReusableText(
                text: "₹ $balance",
                color: Koffwhite,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      );
    });
  }
}
