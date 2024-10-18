// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_button.dart';
import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';

class ImageSelectWidget extends StatelessWidget {
  const ImageSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Koffwhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 15,
                right: 15,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    LineIcons.times,
                    color: Kgray,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 14.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 25.h),
                    const ReusableText(
                      text: "Attach Receipt",
                      color: Kdark,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 12.h),
                    ReusableButton(
                      content: "Take Photo",
                      btnHeight: 40.h,
                      btnWidth: double.maxFinite,
                      borderColor: Kgray,
                    ),
                    SizedBox(height: 12.h),
                    ReusableButton(
                      content: "Choose From Gallery",
                      btnHeight: 40.h,
                      btnWidth: double.maxFinite,
                      borderColor: Kgray,
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: Kgray,
        dashPattern: [6, 4],
        radius: Radius.circular(12.r),
        padding: EdgeInsets.all(6.w),
        child: Container(
          height: 30.h,
          width: MediaQuery.of(context).size.width,
          color: Koffwhite,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LineIcons.plusCircle,
                  size: 20.sp,
                  color: Kgray,
                ),
                SizedBox(width: 10.w),
                ReusableText(
                  text: "Upload images",
                  fontSize: 14.sp,
                  color: Kgray,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
