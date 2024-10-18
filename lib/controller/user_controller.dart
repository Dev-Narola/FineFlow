// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
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

      final url = Uri.parse('http://192.168.136.199:5000/api/users/getuser');

      final response = await http.get(
        url,
        headers: {
          'Authorization': finalToken,
          'Content-Type': 'application/json',
        },
      );
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        userModel.value = UserModel.fromJson(data['user']);

        // print('Name: ${userModel.value.name}');
        // print('Email: ${userModel.value.email}');
        // print('Mobile Number: ${userModel.value.mobile_no}');
        // print('User Image: ${userModel.value.user_image}');
        // print('Created Date: ${userModel.value.created_date}');
      } else {
        // print('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      isLoading(false);
    }
  }

  UserModel get user => userModel.value;
}

// class GetUserController1 extends GetxController {
//   var isLoading = true.obs;
//   var userModel = UserModel(
//     name: '',
//     email: '',
//     mobile_no: '',
//     user_image: "",
//     created_date: DateTime.now(),
//   ).obs;

//   late ApiService apiService;

//   @override
//   void onInit() {
//     super.onInit();
//     Dio dio = Dio();
//     apiService = ApiService(dio);
//   }

//   Future<void> getUser() async {
//     try {
//       isLoading(true);
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('token');
//       if (token == null) {
//         print("Token not found");
//         return;
//       }

//       String finalToken = "Bearer $token";

//       // Call the getUser method from the ApiService using Retrofit
//       UserModel user = await apiService.getUser(finalToken);

//       // Update the userModel with the data from the API response
//       userModel.value = user;

//       print('Name: ${userModel.value.name}');
//       print('Email: ${userModel.value.email}');
//       print('Mobile Number: ${userModel.value.mobile_no}');
//       print('User Image: ${userModel.value.user_image}');
//       print('Created Date: ${userModel.value.created_date}');
//     } catch (e) {
//       print("Error fetching user data: $e");
//     } finally {
//       isLoading(false);
//     }
//   }

//   UserModel get user => userModel.value;
// }
