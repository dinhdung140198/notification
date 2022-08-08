import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgs/data/remote/app_api/user_api.dart';
import 'package:tgs/data/repository/auth_repository/auth_repository.dart';
import 'package:tgs/model/user.dart';

final authRepositoryImpl = Provider<AuthRepositoryImpl>(
    (ref) => AuthRepositoryImpl(ref.read(userApi)));

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(this.userApi);

  final UserApi userApi;

  @override
  Future<User> login({
    required String email,
    required String password,
    required String deviceToken,
    String? platform,
    String? userId,
  }) async {

    final json = await userApi.login(
      email: email,
      password: password,
      deviceToken: deviceToken,
    );

    final user = User.fromJson(json.data);

    return user;
  }

  @override
  Future<void> logout() async {}
}
