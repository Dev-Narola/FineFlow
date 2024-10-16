import 'package:dio/dio.dart';
import 'package:fineflow0/model/all_report_response/reports_response.dart';
import 'package:fineflow0/model/finance_report/finance_report_model.dart';
import 'package:fineflow0/model/finance_report_response/finance_report_response.dart';
import 'package:fineflow0/model/get_user_response/user_model.dart';
import 'package:fineflow0/model/login_user_model/login_model.dart';
import 'package:fineflow0/model/signup_response/signup_response.dart';
import 'package:fineflow0/model/user/user.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: "http://192.168.136.199:5000/api")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/users/signup")
  Future<SignupResponse> signup(@Body() User user);

  @POST("/users/login")
  Future<SignupResponse> signin(
    @Body() LoginModel user,
  );

  @POST("/reports/add")
  Future<FinanceReportResponse> addReport(
    @Body() FinanceReportModel report,
    @Header("Authorization") String token,
  );

  @GET("/reports/all")
  Future<ReportsResponseModel> getAllReports(
    @Header("Authorization") String token,
  );

  @GET("/users/getuser")
  Future<UserModel> getUser(
    @Header('Authorization') String token,
  );
}
