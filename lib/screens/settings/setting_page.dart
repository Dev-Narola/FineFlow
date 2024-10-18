// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/controller/user_controller.dart';
import 'package:fineflow0/screens/settings/link_fincial_app.dart';
import 'package:fineflow0/screens/settings/profile.dart';
import 'package:fineflow0/screens/settings/set_reminder.dart';
import 'package:fineflow0/screens/settings/widgets/option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<GetUserController>();

    return Scaffold(
      backgroundColor: Koffwhite,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width.w, 65.h),
        child: AppBar(
          centerTitle: true,
          scrolledUnderElevation: 0,
          backgroundColor: Koffwhite,
          title: const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: ReusableText(
              text: "Settings",
              fontSize: 22,
              color: Kdark,
              fontWeight: FontWeight.bold,
              letterSpace: 1.2,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: Column(
            children: [
              Obx(() {
                if (userController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.network(
                        userController.user.user_image!,
                        height: 130.h,
                        width: 130.h,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Hello, ${userController.user.name ?? 'User'}",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Kdark,
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                );
              }),
              GestureDetector(
                onTap: () {
                  Get.to(() => const Profile());
                },
                child: const Option(title: "Profile"),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const LinkFincialApp());
                },
                child: const Option(title: "Link Financial App"),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const SetReminder());
                },
                child: const Option(title: "Set reminder"),
              ),
              GestureDetector(
                onTap: () {},
                child: const Option(title: "Set notification"),
              ),
              GestureDetector(
                onTap: () {},
                child: const Option(title: "Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
