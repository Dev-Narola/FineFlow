import 'package:fineflow0/common/reusable_button.dart';
import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/common/reusable_textfield.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';

class InitialBalanceScreen extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  final TextEditingController passwordController;
  const InitialBalanceScreen({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.mobileController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final signupController = Get.put(SignupController());
    final TextEditingController initialBalanceController =
        TextEditingController();
    return Scaffold(
      backgroundColor: Koffwhite,
      appBar: AppBar(
        backgroundColor: Koffwhite,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ReusableText(
              text: "Initial balance",
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 12.h),
            ReusableText(
              text:
                  "Please enter initial balance value to track your balance accuratly",
              fontSize: 14,
            ),
            SizedBox(height: 12.h),
            ReusableTextfield(
              hintText: "Initial balance",
              controller: initialBalanceController,
              prefixIcon: Icon(LineIcons.wallet),
            ),
            SizedBox(height: 20.h),
            ReusableButton(
              content: "S I G N  U P",
              onTap: () {
                if (nameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    mobileController.text.isEmpty ||
                    initialBalanceController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  Get.snackbar("Error", "All fields are required.");
                } else {
                  signupController.signupUser(
                    name: nameController.text,
                    email: emailController.text,
                    mobile: mobileController.text,
                    password: passwordController.text,
                    InitialBalance: double.parse(initialBalanceController.text),
                    userImage: null,
                  );
                }
              },
              btnHeight: 38.h,
              backgroundColor: Kdark,
              textColor: Koffwhite,
            ),
          ],
        ),
      ),
    );
  }
}
