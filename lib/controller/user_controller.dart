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
    mobileNo: '',
    userImage: "",
    createdDate: DateTime.now(),
  ).obs;

  // Fetch user data from API using http
  Future<void> getUser() async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? finalToken = "Bearer $token";

      // Define the API endpoint
      final url = Uri.parse('http://192.168.136.199:5000/api/users/getuser');

      // Make the GET request
      final response = await http.get(
        url,
        headers: {
          'Authorization': finalToken,
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      // Check if the response was successful
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Parse the JSON response into UserModel
        userModel.value = UserModel.fromJson(data['user']);
      } else {
        // Handle API error
        print('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      print("Error fetching user data: $e");
    } finally {
      isLoading(false);
    }
  }

  UserModel get user => userModel.value;
}
