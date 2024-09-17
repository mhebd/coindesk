// ignore_for_file: unused_field

import 'package:coindesk/models/app_config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class HTTPServices {
  final Dio dio = Dio();
  AppConfig? _appConfig;
  String? _apiBaseUrl;
  String? _apiSecret;

  HTTPServices() {
    _appConfig = GetIt.instance.get<AppConfig>();
    _apiBaseUrl = _appConfig?.apiBaseUrl;
    _apiSecret = _appConfig?.apiSecret;
  }

  Future<Response> get(String path) async {
    String url = "$_apiBaseUrl$path";
    Response response = await dio.get(url);
    return response;
  }
}
