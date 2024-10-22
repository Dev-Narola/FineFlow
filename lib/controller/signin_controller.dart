import 'dart:convert';
import 'package:fineflow0/bottom_bar.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/model/login_user_model/login_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SigninController extends GetxController {
  Future<void> signin({required String email, required String password}) async {
    try {
      final url = Uri.parse("$baseUrl/users/login");

      final user = LoginModel(email: email, password: password);

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);

        Get.snackbar("Success", data['message']);
        Get.off(() => BottomBar());
      } else {
        final errorData = json.decode(response.body);
        Get.snackbar("Error", errorData['message'] ?? 'An error occurred');
      }
    } catch (error) {
      Get.snackbar("Error", error.toString());
    }
  }
}
