// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:fineflow0/api/api_services.dart';
import 'package:fineflow0/model/all_report_response/report_model.dart';
import 'package:fineflow0/model/all_report_response/reports_response.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAllReport extends GetxController {
  var reports = <ReportModel>[].obs;
  var isLoading = false.obs;
  var totalExpenses = 0.0.obs;

  late ApiService apiService;

  @override
  void onInit() {
    super.onInit();
    final dio = Dio();
    apiService = ApiService(dio);
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

      final ReportsResponseModel fetchedResponse =
          await apiService.getAllReports(finalToken);

      if (fetchedResponse.reports.isEmpty) {}

      reports.value = fetchedResponse.reports;

      calculateTotalExpenses();
    } catch (e) {
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
}
