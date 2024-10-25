// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_button.dart';
import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/controller/delete_report_controller.dart';
import 'package:fineflow0/model/all_report_response/report_model.dart';
import 'package:fineflow0/screens/dashboard/update_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';

class ViewReport extends StatelessWidget {
  final ReportModel report;
  const ViewReport({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final deleteController = Get.put(DeleteReportController());
    return Scaffold(
        backgroundColor: Koffwhite,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50.h),
          child: AppBar(
            backgroundColor: Koffwhite,
            title: ReusableText(
              text: "Report",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpace: 1.7,
            ),
            actions: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16.0.w),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => UpdateReport(report: report),
                            transition: Transition.fadeIn,
                            duration: Duration(milliseconds: 700));
                      },
                      child: Icon(
                        LineIcons.alternatePencil,
                        size: 29,
                        color: Kdark,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 12.0.w),
                    child: GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          backgroundColor: Koffwhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 15,
                                right: 15,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    LineIcons.times,
                                    color: Kgray,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18.0.w, vertical: 14.h),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 25.h),
                                    const ReusableText(
                                      text:
                                          "Are you sure you want to delete report ?",
                                      color: Kdark,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(height: 12.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ReusableButton(
                                          onTap: () {
                                            Get.back();
                                          },
                                          content: "N O",
                                          btnHeight: 40.h,
                                          btnWidth: 120.w,
                                          borderColor: Kdark,
                                        ),
                                        ReusableButton(
                                          onTap: () {
                                            deleteController
                                                .deleteReport(report.id!);
                                          },
                                          content: "Y E S",
                                          btnHeight: 40.h,
                                          btnWidth: 120.w,
                                          borderColor: Kdark,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12.h),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      child: Icon(
                        LineIcons.bitbucket,
                        size: 29,
                        color: Kred,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 10.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                text: "Report name",
                letterSpace: 1.5,
                fontSize: 17,
              ),
              SizedBox(height: 10.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Kgray),
                    borderRadius: BorderRadius.circular(8.r)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
                  child: ReusableText(
                    text: report.name!,
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(width: 0.8, color: Kgray)),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: "Total Amount : ",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  ReusableText(
                    text: report.amount.toString(),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: "Merchant name : ",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  ReusableText(
                    text: report.merchantName.toString(),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: "Date : ",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  ReusableText(
                    text: report.date.toString(),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: "Category : ",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  ReusableText(
                    text: report.category.toString(),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                height: 250.h,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.3),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Image.network(report.billImage!),
              ),
            ],
          ),
        ));
  }
}
