// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:fineflow0/bottom_bar.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/model/get_user_response/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UpdateUserController extends GetxController {
  var isLoading = false.obs;
  var user = UserModel().obs;

  // final String baseUrl = '$baseUrl/users/updateuser';

  Future<void> updateUser(Map<String, dynamic> updateData) async {
    try {
      isLoading(true);

      // Retrieve the token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("Token not found or invalid");
      }

      String finalToken = "Bearer $token";

      // Make the HTTP request to update the user
      final response = await http.put(
        Uri.parse('$baseUrl/users/updateuser'), // Update your endpoint
        headers: {
          'Content-Type': 'application/json',
          'Authorization': finalToken,
        },
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {
        UserModel updatedUser = UserModel.fromJson(jsonDecode(response.body));
        user.value = updatedUser;

        Get.snackbar("Success", "User profile updated successfully");
        Get.to(() => BottomBar());
      } else {
        Get.snackbar(
            "Error", "Failed to update user profile: ${response.reasonPhrase}");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update user profile: $e");
    } finally {
      isLoading(false);
    }
  }
}
