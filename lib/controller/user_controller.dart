// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/model/get_user_response/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserController extends GetxController {
  var isLoading = true.obs;
  var userModel = UserModel(
    name: '',
    email: '',
    mobile_no: '',
    user_image: "",
    created_date: DateTime.now(),
  ).obs;

  Future<void> getUser() async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? finalToken = "Bearer $token";
      final url = Uri.parse('$baseUrl/users/getuser');

      final response = await http.get(
        url,
        headers: {
          'Authorization': finalToken,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        userModel.value = UserModel.fromJson(data['user']);
      } else {
        print('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      isLoading(false);
    }
  }

  UserModel get user => userModel.value;
}
