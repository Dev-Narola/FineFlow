import 'dart:convert';
import 'package:fineflow0/bottom_bar.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReportController extends GetxController {
  var isLoading = false.obs;

  Future<void> updateReport(
      String reportId,
      String name,
      String merchantName,
      double amount,
      String date,
      String description,
      String category,
      String billImage,
      double tax) async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        Get.snackbar("Error", "No authentication token found. Please log in.");
        return;
      }

      String finalToken = "Bearer $token";

      Map<String, dynamic> reportData = {
        "name": name,
        "merchant_name": merchantName,
        "amount": amount,
        "date": date,
        "description": description,
        "category": category,
        "bill_image": billImage,
        "tax": tax,
      };

      final response = await http.put(
        Uri.parse('$baseUrl/reports/update/$reportId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': finalToken,
        },
        body: jsonEncode(reportData),
      );

      if (response.statusCode == 200) {
        // var responseBody = jsonDecode(response.body);

        Get.snackbar("Sucessfull", "Updated Sucessfully");
        Get.off(BottomBar());
      } else {
        if (response.statusCode == 401) {
          Get.snackbar("Unauthorized", "Please log in again.");
        } else {
          Get.snackbar(
              "Error", "Failed to update report: ${response.reasonPhrase}");
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update report: $e");
    } finally {
      isLoading(false);
    }
  }
}
