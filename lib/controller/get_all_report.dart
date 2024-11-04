// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/model/all_report_response/report_model.dart';
import 'package:fineflow0/model/all_report_response/reports_response.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class GetAllReport extends GetxController {
  var reports = <ReportModel>[].obs;
  var isLoading = false.obs;
  var totalExpenses = 0.0.obs;
  var currentMonthExpenses = 0.0.obs;
  var currentBalance = 0.0.obs;

  // To ensure API calls are made only once
  bool _hasFetchedReports = false;
  bool _hasFetchedBalance = false;

  @override
  void onInit() {
    super.onInit();
    if (!_hasFetchedReports) {
      getAllReport();
    }
    if (!_hasFetchedBalance) {
      getBalance();
    }
  }

  Future<void> getAllReport() async {
    if (_hasFetchedReports) return; // Prevent duplicate calls
    _hasFetchedReports = true;

    isLoading(true);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("Token not found or invalid");
      }

      String finalToken = "Bearer $token";
      final url = Uri.parse("$baseUrl/reports/all");

      final response = await http.get(
        url,
        headers: {
          'Authorization': finalToken,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final fetchedResponse = ReportsResponseModel.fromJson(data);

        reports.value = fetchedResponse.reports;
        calculateTotalExpenses();
      } else {
        final errorData = json.decode(response.body);
        Get.snackbar(
            "Error", errorData['message'] ?? 'Failed to fetch reports');
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getBalance() async {
    if (_hasFetchedBalance) return; // Prevent duplicate calls
    _hasFetchedBalance = true;

    isLoading(true);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("Token not found or invalid");
      }

      String finalToken = "Bearer $token";
      final url = Uri.parse("$baseUrl/reports/balance");

      final response = await http.get(
        url,
        headers: {
          'Authorization': finalToken,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        currentBalance.value = data['current_balance'].toDouble();
      } else {
        final errorData = json.decode(response.body);
        Get.snackbar(
            "Error", errorData['message'] ?? 'Failed to fetch balance');
      }
    } catch (error) {
      Get.snackbar("Error", "Something went wrong: $error");
    } finally {
      isLoading(false);
    }
  }

  List<ReportModel> getRecentReports() {
    return reports.reversed.take(7).toList();
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
        DateTime reportDate = DateFormat('dd-MM-yyyy').parse(report.date!);

        if (DateFormat('MM').format(reportDate) == currentMonth &&
            DateFormat('yyyy').format(reportDate) == currentYear) {
          currentMonthTotal += report.amount ?? 0;
        }
      }
    }
    currentMonthExpenses.value = currentMonthTotal;
  }

  Future<void> exportToExcel() async {
    try {
      // Create a new workbook
      final Workbook workbook = Workbook();
      final Worksheet sheet = workbook.worksheets[0];
      sheet.name = 'Finance Report';

      // Define the header row
      List<String> headers = [
        'Date',
        'Name',
        'Merchant',
        'Amount',
        'Category',
        'Description',
      ];

      // Add headers to the first row
      for (int i = 0; i < headers.length; i++) {
        sheet.getRangeByIndex(0, i).setValue(headers[i]);
        sheet.getRangeByIndex(0, i).cellStyle.bold = true; // Make header bold
      }

      // Add data rows
      for (int rowIndex = 0; rowIndex < reports.length; rowIndex++) {
        var report = reports[rowIndex];
        sheet.getRangeByIndex(rowIndex + 1, 0).setValue(report.date ?? '');
        sheet.getRangeByIndex(rowIndex + 1, 1).setValue(report.name ?? '');
        sheet
            .getRangeByIndex(rowIndex + 1, 2)
            .setValue(report.merchantName ?? '');
        sheet
            .getRangeByIndex(rowIndex + 1, 3)
            .setValue(report.amount != null ? report.amount : '0.0');
        sheet.getRangeByIndex(rowIndex + 1, 4).setValue(report.category ?? '');
        sheet
            .getRangeByIndex(rowIndex + 1, 5)
            .setValue(report.description ?? '');
      }

      // Save the file locally
      final Directory? directory = await getExternalStorageDirectory();
      final String path =
          '${directory?.path}/FinanceReport_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.xlsx';

      // Save the workbook
      final List<int> bytes = workbook.saveAsStream(); // Get the byte array
      final File excelFile = File(path);
      await excelFile.create(recursive: true);
      await excelFile.writeAsBytes(bytes); // Write to file

      Get.snackbar("Success", "Excel file saved to $path");
    } catch (e) {
      Get.snackbar("Error", "Failed to export report: $e");
    }
  }
}
