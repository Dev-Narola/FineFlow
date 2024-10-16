import 'package:fineflow0/common/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../controller/get_all_report.dart';

class TopBudgetContainer extends StatelessWidget {
  final GetAllReport reportController =
      Get.find<GetAllReport>(); // Fetch the controller

  TopBudgetContainer({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Obx(() {
      double totalExpenses = reportController.totalExpenses.value;

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
                text: "Total Expanse",
                color: Koffwhite,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              ReusableText(
                text: "₹ $totalExpenses",
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
