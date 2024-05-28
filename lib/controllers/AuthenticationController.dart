import 'package:siuntu_web_app/services/AuthService.dart' as auth;

class AuthenticationController {
  Future<bool> login(String email, String password) async {
    return await auth.login(email,password);
  }
  Future<bool> register(String email, String password) async {
    return auth.register(
      email,
      password,
    );
  }
}
