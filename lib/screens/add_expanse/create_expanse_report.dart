// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/bottom_bar.dart';
import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';

class CreateExpanseReport extends StatelessWidget {
  const CreateExpanseReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Koffwhite,
      appBar: AppBar(
        backgroundColor: Koffwhite,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ReusableText(
              text: "Create Expanse Report",
              color: Kdark,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpace: 1.8,
            ),
            SizedBox(height: 12.h),
            const ReusableText(
              text: "Report name",
              fontSize: 15,
            ),
            SizedBox(height: 10.h),
            Container(
              height: 38.h,
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.2,
                  color: Kdark,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: const ReusableText(
                  text: "Laptop Expanse",
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              height: 1.8,
              width: double.maxFinite,
              color: Kgray,
            ),
            SizedBox(height: 22.h),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(
                  text: "Total Ammount : ",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                ReusableText(
                  text: "₹ 3500",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ],
            ),
            SizedBox(height: 18.h),
            Container(
              height: 100.h,
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.3,
                  color: Kdark,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 75.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: Kdark,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Image.asset(
                            "assets/images/recipt.jpg",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: 14.w),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReusableText(
                              text: "Laptop Expanse",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            ReusableText(
                              text: "₹ 3500",
                              fontSize: 14,
                            ),
                            ReusableText(
                              text: "12 - 12 - 2024",
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ReusableText(
                        //   text: "Edit response",
                        //   fontSize: 12,
                        //   color: Kgray,
                        // )
                        Icon(LineIcons.exclamationCircle)
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 250.h),
            GestureDetector(
              onTap: () {
                Get.to(() => const BottomBar());
              },
              child: Container(
                height: 45.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Kdark,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: Kdark, width: 1.2)),
                child: Center(
                  child: ReusableText(
                    text: "Submit Expanse Report",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Koffwhite,
                    letterSpace: 2.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
