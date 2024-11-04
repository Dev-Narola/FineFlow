import 'dart:convert';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/model/user/user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fineflow0/screens/authentication/signin_screen.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  Future<void> signupUser({
    required String name,
    required String email,
    required String mobile,
    required String password,
    required double InitialBalance,
    String? userImage,
  }) async {
    try {
      User user = User(
        name: name,
        email: email,
        mobile_no: mobile,
        password: password,
        userImage: defaultImageUrl,
      );
      var userJson = user.toJson();
      userJson.addAll({"initial_balance": InitialBalance});
      final url = Uri.parse("$baseUrl/users/signup");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userJson),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);

        Get.snackbar("Success", data['message']);
        Get.off(() => SigninScreen());
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar("Error", errorData['message'] ?? 'Signup failed');
      }
    } catch (error) {
      Get.snackbar("Error", error.toString());
    }
  }
}
