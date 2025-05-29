import 'package:get/get.dart';
import '../modules/etudiant/controllers/auth_controller.dart';
import '../modules/etudiant/controllers/home_controller.dart';

class EtudiantBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
  }
}