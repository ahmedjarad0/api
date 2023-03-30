import 'dart:convert';
import 'dart:io';
import 'package:api/api/api_settings.dart';
import 'package:api/helpers/api_helper.dart';
import 'package:api/models/api_response.dart';
import 'package:api/models/student.dart';
import 'package:api/prefs/shared_perf.dart';
import 'package:http/http.dart' as http;

class AuthApiController with ApiHelper {
  Future<ApiResponse> login(
      {required String email, required String password}) async {
    Uri uri = Uri.parse(ApiSetting.login);
    var response = await http.post(uri, body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Student student = Student.fromJson(json['object']);
        //TODO: Save Student in shared pref
        SharedPerfController().save(student);
      }
      return ApiResponse(json['message'], json['status']);
    }
    return errorResponse;
  }

  Future<ApiResponse> register({required Student student}) async {
    Uri uri = Uri.parse(ApiSetting.register);
    var response = await http.post(uri, body: {
      'full_name': student.fullName,
      'email': student.email,
      'password': student.password,
      'gender': student.gender,
    });
    if (response.statusCode == 201 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      return ApiResponse(json['message'], json['status']);
    }
    return errorResponse;
  }
  Future<ApiResponse> logout()async{
    String token = SharedPerfController().getValueFor<String>(key: PerfKeys.token.name)!;
        Uri uri = Uri.parse(ApiSetting.logout);
        var response = await http.get(uri,headers:{
          HttpHeaders.authorizationHeader : token ,
          HttpHeaders.acceptHeader:'application/json',
        } );
        if(response.statusCode==200 || response.statusCode==401){
          SharedPerfController().clear() ;
          return ApiResponse('Logout successfully', true);
        }
        return errorResponse;
  }
}
