import 'package:tgs/model/user.dart';

abstract class AuthRepository {
  Future<User> login({
    required String email,
    required String password,
    required String deviceToken,
    String? platform,
    String? userId,
  });

  Future<void> logout();
}
