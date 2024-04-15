import 'package:siuntu_web_app/services/auth.dart' as auth;
import 'package:siuntu_web_app/models/User.dart';
class AuthController {
  Future<bool> login(User user) async {
    return await auth.login(user.email, user.password);
  }

  Future<bool> register(User user) async {
    return await auth.register(user.email, user.password);
  }
}