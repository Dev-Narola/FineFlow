// ignore_for_file: prefer_const_constructors

import 'package:fineflow0/common/reusable_button.dart';
import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/common/reusable_textfield.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/screens/settings/widgets/reminder_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

class SetReminder extends StatelessWidget {
  const SetReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Koffwhite,
      appBar: AppBar(
        backgroundColor: Koffwhite,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ReusableText(
              text: "Set Reminder",
              color: Kdark,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpace: 1.5,
            ),
            SizedBox(height: 12.h),
            const ReusableText(
              text: "Set reminder to input your expanse on regular basis",
              fontSize: 14,
            ),
            SizedBox(height: 12.h),
            const ReminderBotton(
              content: "Daily reminder",
            ),
            const ReminderBotton(
              content: "Weekly reminder",
            ),
            const ReminderBotton(
              content: "Monthly reminder",
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () {
                showDialog(
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 18.0.w, vertical: 14.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 25.h),
                              const ReusableText(
                                text: "Set Custome Reminder",
                                color: Kdark,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(height: 12.h),
                              const ReusableText(
                                text: "Select your preffered date",
                                color: Kdark,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(height: 12.h),
                              ReusableTextfield(hintText: "Enter date"),
                              SizedBox(height: 12.h),
                              ReusableButton(
                                content: "S A V E",
                                textColor: Koffwhite,
                                btnHeight: 40.h,
                                backgroundColor: Kdark,
                                btnWidth: double.maxFinite,
                                borderColor: Kdark,
                              ),
                              SizedBox(height: 12.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const ReusableText(
                text: "Set customized reminder",
                color: Kdark,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
