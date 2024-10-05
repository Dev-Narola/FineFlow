// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_button.dart';
import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinkFincialApp extends StatelessWidget {
  const LinkFincialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Koffwhite,
      appBar: AppBar(
        backgroundColor: Koffwhite,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ReusableText(
              text: "Link Financial App",
              color: Kdark,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            SizedBox(height: 26.h),
            const ReusableText(
              text: "No Linked Fincial App!",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 16.h),
            const ReusableText(
              text:
                  "Link your frequently used financial app to input expense claim faster.",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 56.h),
            const ReusableButton(
              // onTap: () {},
              content: "Link Financial App",
              btnHeight: 40,
            )
          ],
        ),
      ),
    );
  }
}
