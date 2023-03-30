import 'dart:convert';
import 'dart:io';
import 'package:api/api/api_settings.dart';
import 'package:api/helpers/api_helper.dart';
import 'package:api/models/api_response.dart';
import 'package:api/models/student_images.dart';
import 'package:api/prefs/shared_perf.dart';
import 'package:http/http.dart' as http;

class ImagesApiController with ApiHelper {
  Future<ApiResponse<StudentImage>> uploadImage({required String path}) async {
    Uri uri = Uri.parse(ApiSetting.images.replaceFirst('/{id}', ''));
    var request = http.MultipartRequest('POST', uri);
    var imageFile = await http.MultipartFile.fromPath('image', path);
    request.files.add(imageFile);
    request.headers[HttpHeaders.acceptHeader] = 'application/json';
    request.headers[HttpHeaders.authorizationHeader] =
        SharedPerfController().getValueFor<String>(key: PerfKeys.token.name)!;
    var response = await request.send();
    if (response.statusCode == 201) {
      String body = await response.stream.transform(utf8.decoder).first;
      var json = jsonDecode(body);
      StudentImage image = StudentImage.fromJson(json['object']);
      return ApiResponse<StudentImage>(
        json['message'],
        json['status'],
        image,
      );
    }
    return ApiResponse<StudentImage>('Something went wrong', false);
  }

  Future<List<StudentImage>> getImages() async {
    Uri uri = Uri.parse(ApiSetting.images.replaceFirst('/{id}', ''));
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var jsonData = json['data'] as List;
      return jsonData
          .map((jsonObject) => StudentImage.fromJson(jsonObject))
          .toList();
    }
    return [];
  }

  Future<ApiResponse> deleteImage({required int id}) async {
    Uri uri = Uri.parse(ApiSetting.images.replaceFirst('{id}', id.toString()));
    var response = await http.delete(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return ApiResponse(json['message'], json['status']);
    }
    return errorResponse;
  }
}
