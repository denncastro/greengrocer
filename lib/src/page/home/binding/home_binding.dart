import 'package:get/get.dart';
import 'package:lab_app/src/page/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
