import 'dart:convert';
import 'package:api/api/api_settings.dart';
import 'package:api/models/user.dart';
import 'package:http/http.dart' as http;

class UserApiController {
  Future<List<User>> getUser() async {
    Uri uri = Uri.parse(ApiSetting.users);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObj = json['data'] as List;
      return dataJsonObj.map((dataJson) => User.fromJson(dataJson)).toList();
    }
    return [];
  }
}
