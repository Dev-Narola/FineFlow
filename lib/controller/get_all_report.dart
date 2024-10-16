import 'package:dio/dio.dart';
import 'package:fineflow0/api/api_services.dart';
import 'package:fineflow0/model/all_report_response/report_model.dart';
import 'package:fineflow0/model/all_report_response/reports_response.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAllReport extends GetxController {
  var reports = <ReportModel>[].obs; // Reactive list for reports
  var isLoading = false.obs;
  var totalExpenses = 0.0.obs; // Reactive total expenses

  late ApiService apiService;

  @override
  void onInit() {
    super.onInit();
    final dio = Dio();
    apiService = ApiService(dio);
    getAllReport(); // Fetch reports when initialized
  }

  Future<void> getAllReport() async {
    isLoading(true);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String finalToken = "Bearer $token";

      final ReportsResponseModel fetchedResponse =
          await apiService.getAllReports(finalToken);

      reports.value = fetchedResponse.reports;

      // Update total expenses reactively
      calculateTotalExpenses();
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading(false);
    }
  }

  // Function to calculate the total expenses reactively
  void calculateTotalExpenses() {
    double total = 0;
    for (var report in reports) {
      total += report.amount ?? 0; // Null safety for amount
    }
    totalExpenses.value = total; // Update the reactive total
  }
}
