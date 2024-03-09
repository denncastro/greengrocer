import 'package:lab_app/src/model/user_model.dart';
import 'package:lab_app/src/page/auth/repository/auth_error.dart' as auth_error;
import 'package:lab_app/src/page/auth/result/auth_result.dart';
import 'package:lab_app/src/page/constants/endpoints.dart';
import 'package:lab_app/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future<AuthResult> handleUserOrError(Map<dynamic, dynamic> result) async {
    if (result["result"] != null) {
      UserModel user = UserModel.fromJson(result["result"]);

      return AuthResult.success(user);
    } else {
      return AuthResult.error(auth_error.authErrorString(result["error"]));
    }
  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.validtoken,
      method: HttpMethods.post,
      headers: {
        "X-Parse-Session-Token": token,
      },
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.signin,
      method: HttpMethods.post,
      body: {
        "email": email,
        "password": password,
      },
    );

    return handleUserOrError(result);
  }

  Future<void> resetPassword(String email) async {
    _httpManager.restRequest(
      url: EndPoints.resetPassword,
      method: HttpMethods.post,
      body: {"email": email},
    );
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.signup,
      method: HttpMethods.post,
      body: user.toJson(),
    );

    return handleUserOrError(result);
  }
}
