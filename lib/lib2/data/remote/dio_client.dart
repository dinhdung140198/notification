import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tgs/data/local/local_storage.dart';
import 'package:tgs/data/remote/api_error/api_error.dart';
import 'package:tgs/internal/app_config.dart';

class DioClient with ApiError{
  final baseApi = AppConfig.instance.apiBaseUrl;
  Dio dio = Dio(BaseOptions(
    baseUrl: AppConfig.instance.apiBaseUrl,
    contentType: 'application/json',
    connectTimeout: 30000,
    sendTimeout: 30000,
    receiveTimeout: 30000,
  ));

  DioClient(){
    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }
  }

  Future<bool> _lookupInternet() async {
    try {
      final result = await InternetAddress.lookup('google.jp');
      if (result.isEmpty && result[0].rawAddress.isEmpty){
        return false;
      }
      else{
        return true;
      }
    } on SocketException catch (_) {
      return Future.error('internet is off');
    }
  }

  Future<Options> getOptions({String contentType = Headers.jsonContentType}) async {
    final Map<String, dynamic> headers = await _getHeader();
    return Options(headers: headers, contentType: contentType);
  }

  Future<Options> getAuthOptions({required String contentType}) async {
    final Map<String, dynamic> headers = await _getAuthorizedHeader();
    return Options(headers: headers, contentType: contentType);
  }

  Future<Map<String, String>> _getHeader() async {
    return {
      "content-type": "application/json",
    };
  }

  Future<Map<String, String>> _getAuthorizedHeader() async {
    Map<String, String> header = await _getHeader();
    try{
      String? accessToken = await LocalStorage.instance.getAccessToken();
      header.addAll({
        "Authorization": "Bearer ${accessToken!}",
      });
    }
    catch (e){
      debugPrint('token is null');
    }

    return header;
  }

  Future<Response<dynamic>> dioCall(Future<Response> Function() apiCall) async {
    try {
      return await apiCall();
    } catch (error) {
      throw checkError(error);
    }
  }
}