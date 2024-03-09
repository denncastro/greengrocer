import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_app/src/page/auth/controller/auth_controller.dart';
import 'package:lab_app/src/page_route/app_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  runApp(const Greengrocer());
}

class Greengrocer extends StatelessWidget {
  const Greengrocer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Greengrocer",
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white.withAlpha(230),
      ),
      initialRoute: PagesRoutes.splashroute,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
