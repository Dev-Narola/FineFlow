// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonAppbar extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  const CommonAppbar({
    super.key,
    this.name,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    String getGreetingMessage() {
      final hour = DateTime.now().hour;

      if (hour >= 0 && hour < 12) {
        print("image url " + imageUrl!);
        return "Good morning";
      } else if (hour >= 12 && hour < 17) {
        return "Good afternoon";
      } else {
        return "Good evening";
      }
    }

    return Padding(
      padding: EdgeInsets.only(right: 14.w),
      child: AppBar(
        elevation: 0,
        backgroundColor: Koffwhite,
        leading: CircleAvatar(
          child: Image.network(imageUrl!),
        ),
        title: ReusableText(
          text: "${getGreetingMessage()}, $name",
          fontSize: 18,
          color: Kdark,
          fontWeight: FontWeight.w600,
        ),
        scrolledUnderElevation: 0,
        actions: [
          Stack(children: [
            Icon(
              LineIcons.bell,
              size: 25.dm,
              color: Kdark,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: KlightGray,
                radius: 8.r,
                child: ReusableText(
                  text: "2",
                  fontSize: 12,
                  color: Kdark,
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
