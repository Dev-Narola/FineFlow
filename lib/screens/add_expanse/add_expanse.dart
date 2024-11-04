// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/screens/add_expanse/widgets/radio_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddExpanse extends StatefulWidget {
  final String reportName;
  const AddExpanse({
    super.key,
    required this.reportName,
  });

  @override
  State<AddExpanse> createState() => _AddExpanseState();
}

class _AddExpanseState extends State<AddExpanse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Koffwhite,
      appBar: AppBar(
        backgroundColor: Koffwhite,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 10.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ReusableText(
                  text: "Add Expanse",
                  fontSize: 22,
                  color: Kdark,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 12.h),
                const ReusableText(
                  text: "How would you want to input your expanse",
                  fontSize: 16,
                  color: Kdark,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 12.h),
                RadioButtons(reportName: widget.reportName)
              ],
            )),
      ),
    );
  }
}
