// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

class LinkFincialApp extends StatefulWidget {
  const LinkFincialApp({super.key});

  @override
  State<LinkFincialApp> createState() => _LinkFincialAppState();
}

class _LinkFincialAppState extends State<LinkFincialApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Koffwhite,
      appBar: AppBar(
        backgroundColor: Koffwhite,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ReusableText(
              text: "Link Financial App",
              color: Kdark,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            SizedBox(height: 26.h),
            Container(
              height: 50.h,
              decoration: BoxDecoration(
                border: Border.all(width: 1.2, color: Kdark),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 4.w),
                      CircleAvatar(
                        backgroundColor: Koffwhite,
                        backgroundImage: NetworkImage(
                            "https://img.freepik.com/premium-vector/black-google-pay-logotype-white-background-logo-mobile-payment-system-electronic-wallet-contactless-nfc-android-operating-system-gpay-editorial_661108-8063.jpg?ga=GA1.1.1254305212.1719158913&semt=ais_siglip"),
                        radius: 24,
                      ),
                      SizedBox(width: 12.w),
                      ReusableText(
                        text: "Google Pay",
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                  TextButton(
                      onPressed: () async {
                        await LaunchApp.isAppInstalled(
                          androidPackageName: "com.phonepe.app",
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.2),
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusableText(text: "Navigate"),
                          )))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
