import 'package:dio/dio.dart';
import 'package:fineflow0/api/api_services.dart';
import 'package:fineflow0/model/login_user_model/login_model.dart';
import 'package:fineflow0/screens/dashboard/dashboard_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninController extends GetxController {
  late ApiService _apiService;

  SigninController() {
    _apiService = ApiService(Dio());
  }

  Future<void> signin({required String email, required String password}) async {
    try {
      final user = LoginModel(email: email, password: password);

      final response = await _apiService.signin(user);

      // Store the token in SharedPreferences after successful login
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.token);

      // Show success message and navigate to the Dashboard
      Get.snackbar("Success", response.message);
      Get.off(() => DashboardPage());
    } catch (error) {
      print("Error: " + error.toString());
      Get.snackbar("Error", error.toString());
    }
  }
}
