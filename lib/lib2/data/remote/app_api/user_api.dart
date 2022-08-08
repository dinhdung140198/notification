import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgs/data/remote/dio_client.dart';

final userApi = Provider<UserApi>((ref) => UserApi());

class UserApi extends DioClient {
  Future<Response> login(
      {required String email,
      required String password,
        String? deviceToken,
        String? platform,
        String? userId}) async {


    final String url = '$baseApi/login';
    final Options options = await getOptions();
    final data = {
      "email": email,
      "password": password,
      'device_token':
          (deviceToken ?? '').isEmpty ? 'Device_Token' : deviceToken,
      'platform': platform ?? '',
      'app': 'user',
      'player_id': userId ?? '',
    };

    return dioCall(() => dio.post(url, options: options, data: data));
  }
}
