// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/common_appbar.dart';
import 'package:fineflow0/common/expanse_report_tile.dart';
import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/common/top_budget_container_balance.dart';
import 'package:fineflow0/common/top_budget_container_total_expanse.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/controller/get_all_report.dart';
import 'package:fineflow0/controller/user_controller.dart';
import 'package:fineflow0/screens/add_expanse/expanse_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final reportController = Get.put(GetAllReport(), permanent: true);
  final userController = Get.put(GetUserController(), permanent: true);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      reportController.getAllReport();
      userController.getUser();
    });
  }

  Future<void> _refreshReports() async {
    await reportController.getAllReport();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Koffwhite,
      appBar: PreferredSize(
        preferredSize: Size(width.w, 80.h),
        child: Obx(() {
          if (userController.isLoading.value) {
            return Center(
                child: CircularProgressIndicator(
              color: Kdark,
              backgroundColor: Koffwhite,
            ));
          }
          return CommonAppbar(
            name: userController.user.name ?? "User",
            imageUrl: userController.user.user_image ?? "",
          );
        }),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            color: Kdark,
            backgroundColor: Koffwhite,
            onRefresh: _refreshReports,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TopBudgetContainerBalance(),
                      TopBudgetContainerTotalExpanse(),
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
                  SizedBox(height: 18.h),
                  Expanded(
                    child: Obx(() {
                      if (reportController.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Kdark,
                            backgroundColor: Koffwhite,
                          ),
                        );
                      }

                      final recentReports = reportController.getRecentReports();
                      if (recentReports.isEmpty) {
                        return Center(child: Text("No recent reports found"));
                      }
                      return ListView.builder(
                        itemCount: recentReports.length,
                        itemBuilder: (context, index) {
                          var report = recentReports[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0.h),
                            child: ExpanseReportTile(
                              report: report,
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 15.h,
            right: 15.w,
            child: GestureDetector(
              onTap: () async {
                final result = await Get.to(() => const ExpanseReport(),
                    transition: Transition.fadeIn,
                    duration: Duration(microseconds: 900));
                if (result == true) {
                  // Automatically refresh the reports when coming back from the AddExpanse page
                  await reportController.getAllReport();
                }
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
