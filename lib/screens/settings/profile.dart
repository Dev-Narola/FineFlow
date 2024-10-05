import 'package:fineflow0/common/reusable_button.dart';
import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Koffwhite,
      appBar: AppBar(
        backgroundColor: Koffwhite,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ReusableText(
              text: "Profile",
              fontSize: 26,
              color: Kdark,
              fontWeight: FontWeight.bold,
              letterSpace: 2.5,
            ),
            SizedBox(height: 36.h),
            const ReusableText(
              text: "Name",
              fontSize: 17,
            ),
            SizedBox(height: 16.h),
            TextFormField(
              initialValue: "Dev Narola",
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Name",
                hintStyle: const TextStyle(
                  color: Kgray,
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
            SizedBox(height: 12.h),
            const ReusableText(
              text: "Email",
              fontSize: 17,
            ),
            SizedBox(height: 16.h),
            TextFormField(
              initialValue: "ds.narola2004@gmail.com",
              readOnly: true,
              decoration: InputDecoration(
                hintText: "email",
                hintStyle: const TextStyle(
                  color: Kgray,
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
            SizedBox(height: 12.h),
            const ReusableText(
              text: "Password",
              fontSize: 17,
            ),
            SizedBox(height: 16.h),
            TextFormField(
              // initialValue: "Dev Narola",
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: const TextStyle(
                  color: Kgray,
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
            SizedBox(height: 12.h),
            const ReusableText(
              text: "Re-Password",
              fontSize: 17,
            ),
            SizedBox(height: 16.h),
            TextFormField(
              // initialValue: "Dev Narola",
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Re-Password",
                hintStyle: const TextStyle(
                  color: Kgray,
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
            SizedBox(height: 46.h),
            ReusableButton(
              // onTap: () {},
              content: "Save Profile",
              textColor: Koffwhite,
              backgroundColor: Kdark,
              btnHeight: 40.h,
            )
          ],
        ),
      ),
    );
  }
}
