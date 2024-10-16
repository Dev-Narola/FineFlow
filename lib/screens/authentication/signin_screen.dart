// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_button.dart';
import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/common/reusable_textfield.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/controller/signin_controller.dart';
import 'package:fineflow0/screens/authentication/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SigninController());
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Koffwhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 28.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/auth.json', repeat: false),
              SizedBox(height: 20.h),
              ReusableText(
                text: "Sign In",
                fontSize: 28,
                color: Kdark,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 10.h),
              ReusableText(
                text: "Please fill all details correctly to authenticate",
                fontSize: 14,
                color: Kdark,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 20.h),
              ReusableTextfield(
                hintText: "email",
                controller: emailController,
                prefixIcon: Icon(LineIcons.userCircleAlt),
              ),
              SizedBox(height: 20.h),
              ReusableTextfield(
                hintText: "Password",
                controller: passwordController,
                prefixIcon: Icon(LineIcons.userLock),
              ),
              SizedBox(height: 20.h),
              ReusableButton(
                content: "L O G I N",
                onTap: () {
                  controller.signin(
                      email: emailController.text,
                      password: passwordController.text);
                },
                btnHeight: 38.h,
                backgroundColor: Kdark,
                textColor: Koffwhite,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableText(
                    text: "don't have account ? ",
                    fontSize: 14,
                    color: Kdark,
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(width: 6.w),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const SignupScreen());
                    },
                    child: ReusableText(
                      text: "Sign up",
                      fontSize: 14,
                      color: Kdark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
