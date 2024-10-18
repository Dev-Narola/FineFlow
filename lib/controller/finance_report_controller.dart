// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:fineflow0/api/api_services.dart';
import 'package:fineflow0/bottom_bar.dart';
import 'package:fineflow0/model/finance_report/finance_report_model.dart';
import 'package:fineflow0/model/finance_report_response/finance_report_response.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinanceReportController extends GetxController {
  late ApiService _apiService;
  FinanceReportController() {
    _apiService = ApiService(Dio());
  }

  Future<void> addReport(
    String title,
    String name,
    double amount,
    String date,
    String description,
    String category,
  ) async {
    try {
      final report = FinanceReportModel(
        name: title,
        merchant_name: name,
        amount: amount,
        date: date,
        description: description,
        category: category,
        bill_image: "https://cdn-icons-png.flaticon.com/128/3875/3875172.png",
        tax: 0,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? finalToken = "Bearer $token";

      FinanceReportResponse response =
          await _apiService.addReport(report, finalToken);
      if (response.reportid == null) {
        Get.snackbar("Success", "Finance report added successfully!");
        Get.off(() => BottomBar());
      } else {
        Get.snackbar("Error", response.message);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while adding the report.");
    }
  }
}
