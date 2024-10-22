// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/controller/user_controller.dart';
import 'package:fineflow0/screens/settings/widgets/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<GetUserController>();
    return Scaffold(
      backgroundColor: Koffwhite,
      appBar: AppBar(
          title: const ReusableText(
            text: "Profile",
            fontSize: 22,
            color: Kdark,
            fontWeight: FontWeight.bold,
            letterSpace: 1.5,
          ),
          scrolledUnderElevation: 0,
          backgroundColor: Koffwhite,
          actions: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => UpdateProfile());
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.0.w),
                    child: Icon(
                      LineIcons.alternatePencil,
                      size: 29,
                      color: Kdark,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 12.0.w),
                  child: Icon(
                    LineIcons.bitbucket,
                    size: 29,
                    color: Kred,
                  ),
                ),
              ],
            ),
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (userController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                return Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: Image.network(
                                userController.user.user_image!,
                                height: 130.h,
                                width: 130.h,
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 2,
                              right: 5,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Kdark,
                                      borderRadius:
                                          BorderRadius.circular(16.r)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Center(
                                      child: Icon(
                                        LineIcons.camera,
                                        color: Koffwhite,
                                        size: 27,
                                      ),
                                    ),
                                  )))
                        ],
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 26.h),
              const ReusableText(
                text: "Name",
                fontSize: 17,
              ),
              SizedBox(height: 6.h),
              TextFormField(
                initialValue: userController.user.name,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: const TextStyle(
                    color: Kdark,
                  ),
                  prefixIcon: Icon(
                    LineIcons.userCircleAlt,
                    size: 24,
                  ),
                  prefixIconColor: Kdark,
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: Kgray, width: 1.3)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: Kgray, width: 1.3)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: Kdark, width: 1.3)),
                ),
                cursorColor: Kdark,
                // controller: controller,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Kdark),
              ),
              SizedBox(height: 16.h),
              const ReusableText(
                text: "Email",
                fontSize: 17,
              ),
              SizedBox(height: 6.h),
              TextFormField(
                initialValue: userController.user.email,
                readOnly: true,

                decoration: InputDecoration(
                  hintText: "email",
                  hintStyle: const TextStyle(
                    color: Kgray,
                  ),
                  prefixIconColor: Kdark,
                  prefixIcon: Icon(LineIcons.envelope),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: Kgray, width: 1.3)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: Kgray, width: 1.3)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: Kdark, width: 1.3)),
                ),
                cursorColor: Kdark,
                // controller: controller,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Kdark),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
