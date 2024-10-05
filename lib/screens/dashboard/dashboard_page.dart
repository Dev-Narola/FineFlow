import 'package:fineflow0/common/common_appbar.dart';
import 'package:fineflow0/common/expanse_report_tile.dart';
import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/common/reusable_textfield.dart';
import 'package:fineflow0/common/top_budget_container.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/screens/add_expanse/expanse_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Koffwhite,
      appBar: PreferredSize(
        preferredSize: Size(width.w, 60.h),
        child: const CommonAppbar(),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TopBudgetContainer(),
                    TopBudgetContainer(),
                  ],
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.only(top: 8.0.h, right: 4.w),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                        text: "Recent Expanse Report",
                        fontSize: 17,
                        color: Kdark,
                        fontWeight: FontWeight.w700,
                      ),
                      ReusableText(
                        text: "View all",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22.h),
                const ReusableTextfield(
                  hintText: "Search",
                ),
                SizedBox(height: 22.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0.h),
                              child: const ExpanseReportTile(
                                title: "Travel expanse",
                                expanse: "2500",
                                time: "20:33",
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15.h,
            right: 15.w,
            child: GestureDetector(
              onTap: () {
                Get.to(() => const ExpanseReport());
              },
              child: CircleAvatar(
                radius: 30.r,
                backgroundColor: Kdark,
                child: Icon(
                  LineIcons.plus,
                  color: Kwhite,
                  size: 28.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
