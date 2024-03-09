import 'package:get/get.dart';
import 'package:lab_app/src/model/user_model.dart';
import 'package:lab_app/src/page/auth/repository/auth_repository.dart';
import 'package:lab_app/src/page/auth/result/auth_result.dart';
import 'package:lab_app/src/page/constants/storage_keys.dart';
import 'package:lab_app/src/page_route/app_route.dart';
import 'package:lab_app/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final AuthRepository authRepository = AuthRepository();
  final UtilsServices utilsServices = UtilsServices();

  UserModel user = UserModel();

  Future<void> validateToken() async {
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.signinroute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> signOut() async {
    user = UserModel();

    await utilsServices.removeLocalData(key: StorageKeys.token);

    Get.offAllNamed(PagesRoutes.signinroute);
  }

  Future<void> saveTokenAndProceedToBase() async {
    await utilsServices.saveLocalData(
      key: StorageKeys.token,
      data: user.token!,
    );

    Get.offAllNamed(PagesRoutes.baseroute);
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result =
        await authRepository.signIn(email: email, password: password);

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(label: message, isError: true);
      },
    );

    isLoading.value = false;
  }

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }

  Future<void> signUp() async {
    isLoading.value = true;

    AuthResult result = await authRepository.signUp(user);
    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(label: message, isError: true);
      },
    );
  }
}
