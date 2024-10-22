// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:fineflow0/bottom_bar.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/model/finance_report/finance_report_model.dart';
import 'package:fineflow0/model/finance_report_response/finance_report_response.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FinanceReportController extends GetxController {
  Future<bool> addReport(
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

      final response = await http.post(
        Uri.parse('$baseUrl/reports/add'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': finalToken,
        },
        body: jsonEncode(report.toJson()),
      );

      if (response.statusCode == 201) {
        FinanceReportResponse responseData =
            FinanceReportResponse.fromJson(jsonDecode(response.body));

        if (responseData.reportid == null) {
          Get.snackbar("Success", "Finance report added successfully!");
          Get.off(() => BottomBar());
          return true;
        } else {
          Get.snackbar("Error", responseData.message);
          return false;
        }
      } else {
        Get.snackbar("Error", "Failed to add report: ${response.reasonPhrase}");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while adding the report: $e");
      return false;
    }
  }
}
