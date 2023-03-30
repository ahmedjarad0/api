import 'dart:io';

import 'package:api/models/api_response.dart';

import '../prefs/shared_perf.dart';

mixin ApiHelper {
  ApiResponse get errorResponse =>
      ApiResponse('Something error ,try again', false);

  Map<String, String> get headers => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: SharedPerfController()
            .getValueFor<String>(key: PerfKeys.token.name)!,
      };
}
