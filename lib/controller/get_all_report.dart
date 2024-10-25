// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/model/all_report_response/report_model.dart';
import 'package:fineflow0/model/all_report_response/reports_response.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class GetAllReport extends GetxController {
  var reports = <ReportModel>[].obs;
  var isLoading = false.obs;
  var totalExpenses = 0.0.obs;
  var currentMonthExpenses = 0.0.obs; // Observable for current month expenses

  final String baseUrl = "http://192.168.33.199:5000/api";

  @override
  void onInit() {
    super.onInit();
    getAllReport();
  }

  Future<void> getAllReport() async {
    isLoading(true);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("Token not found or invalid");
      }

      String finalToken = "Bearer $token";
      final url = Uri.parse("$baseUrl/reports/all");

      // Make the GET request with the token in the headers
      final response = await http.get(
        url,
        headers: {
          'Authorization': finalToken,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse response body
        final data = json.decode(response.body);
        final fetchedResponse = ReportsResponseModel.fromJson(data);

        // Update reports and calculate total expenses
        reports.value = fetchedResponse.reports;
        calculateTotalExpenses();
      } else {
        // Handle non-200 responses
        final errorData = json.decode(response.body);
        Get.snackbar(
            "Error", errorData['message'] ?? 'Failed to fetch reports');
      }
    } catch (e) {
      // Catch any errors
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading(false);
    }
  }

  void calculateTotalExpenses() {
    double total = 0;
    for (var report in reports) {
      total += report.amount ?? 0;
    }
    totalExpenses.value = total;
  }

  void calculateCurrentMonthExpenses() {
    double currentMonthTotal = 0;
    DateTime now = DateTime.now();
    String currentMonth = DateFormat('MM').format(now);
    String currentYear = DateFormat('yyyy').format(now);

    for (var report in reports) {
      if (report.date != null) {
        // Parse the report date using the correct format
        DateTime reportDate = DateFormat('dd-MM-yyyy').parse(report.date!);

        // Check if the report date is in the current month and year
        if (DateFormat('MM').format(reportDate) == currentMonth &&
            DateFormat('yyyy').format(reportDate) == currentYear) {
          currentMonthTotal += report.amount ?? 0;
        }
      }
    }
    currentMonthExpenses.value = currentMonthTotal;
  }
}
