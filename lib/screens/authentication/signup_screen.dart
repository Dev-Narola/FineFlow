// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_button.dart';
import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/common/reusable_textfield.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/controller/signup_controller.dart';
import 'package:fineflow0/screens/authentication/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController signupController = Get.put(SignupController());
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController mobileController = TextEditingController();
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
              SizedBox(height: 15.h),
              ReusableTextfield(
                hintText: "user name",
                controller: nameController,
                prefixIcon: Icon(LineIcons.userAlt),
              ),
              SizedBox(height: 15.h),
              ReusableTextfield(
                hintText: "email",
                controller: emailController,
                prefixIcon: Icon(LineIcons.userCircleAlt),
              ),
              SizedBox(height: 15.h),
              ReusableTextfield(
                hintText: "mobile no.",
                controller: mobileController,
                prefixIcon: Icon(LineIcons.mobilePhone),
              ),
              SizedBox(height: 15.h),
              ReusableTextfield(
                hintText: "Password",
                controller: passwordController,
                prefixIcon: Icon(LineIcons.userLock),
              ),
              SizedBox(height: 15.h),
              ReusableButton(
                content: "S I G N  U P",
                onTap: () {
                  signupController.signupUser(
                      name: nameController.text,
                      email: emailController.text,
                      mobile: mobileController.text,
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
                      Get.to(() => const SigninScreen());
                    },
                    child: ReusableText(
                      text: "Sign in",
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
