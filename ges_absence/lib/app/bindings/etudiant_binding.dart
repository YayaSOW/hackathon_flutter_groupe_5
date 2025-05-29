import 'package:get/get.dart';
import '../modules/etudiant/controllers/auth_controller.dart';
import '../modules/etudiant/controllers/home_controller.dart';

class VigileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
  }
}