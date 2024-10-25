import 'package:fineflow0/bottom_bar.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DeleteReportController extends GetxController {
  var isLoading = false.obs;
  Future<void> deleteReport(
    String reportId,
  ) async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        Get.snackbar("Error", "No authentication token found. Please log in.");
        return;
      }
      String finalToken = "Bearer $token";

      final response = await http.delete(
        Uri.parse('$baseUrl/reports/delete/$reportId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': finalToken,
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar("Sucessfull", "Delete Sucessfully");
        Get.off(BottomBar());
      } else {
        Get.snackbar("Error", "Something error");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
