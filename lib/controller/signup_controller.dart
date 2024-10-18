// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:fineflow0/api/api_services.dart';
import 'package:fineflow0/model/user/user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fineflow0/screens/authentication/signin_screen.dart';

class SignupController extends GetxController {
  late ApiService _apiService;

  SignupController() {
    _apiService = ApiService(Dio());
  }

  Future<void> signupUser({
    required String name,
    required String email,
    required String mobile,
    required String password,
  }) async {
    try {
      User user = User(
          name: name,
          email: email,
          mobile_no: mobile,
          password: password,
          userImage:
              "https://as2.ftcdn.net/v2/jpg/05/87/66/83/1000_F_587668357_Vco2ldq4Q9aWDH3ynxSOCydf5W1UdvrK.jpg");
      final response = await _apiService.signup(user);

      // Save the token to shared_preferences for persistent login
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.token);

      // Show a success message
      Get.snackbar("Success", response.message);

      Get.off(() => const SigninScreen());
    } catch (error) {
      Get.snackbar("Error", error.toString());
    }
  }
}
