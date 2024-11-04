// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_button.dart';
import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/common/reusable_textfield.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/screens/add_expanse/add_expanse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart.';

class ExpanseReport extends StatelessWidget {
  const ExpanseReport({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController reportNameController = TextEditingController();
    return Scaffold(
      backgroundColor: Koffwhite,
      appBar: AppBar(
        backgroundColor: Koffwhite,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 17.0.w,
          vertical: 10.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ReusableText(
                  text: "Create Expanse Report",
                  color: Kdark,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 18.h),
                const ReusableText(
                  text: "Report name",
                  color: Kdark,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 12.h),
                ReusableTextfield(
                  hintText: "Report type",
                  controller: reportNameController,
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 70.0.h),
                  child: ReusableButton(
                    content: "A d d   E x p a n s e",
                    btnHeight: 40,
                    onTap: () {
                      Get.to(AddExpanse(reportName: reportNameController.text));
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
