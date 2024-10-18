// ignore_for_file: depend_on_referenced_packages

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

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.token);

      Get.snackbar("Success", response.message);
      Get.off(() => DashboardPage());
    } catch (error) {
      Get.snackbar("Error", error.toString());
    }
  }
}
