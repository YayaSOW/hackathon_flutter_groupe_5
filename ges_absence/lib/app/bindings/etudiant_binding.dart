import 'package:ges_absence/app/data/services/cours_service.dart';
import 'package:ges_absence/app/modules/etudiant/controllers/cours_controller.dart';
import 'package:get/get.dart';
import '../modules/etudiant/controllers/auth_controller.dart';
import '../modules/etudiant/controllers/home_controller.dart';

class EtudiantBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
     Get.lazyPut(() => CoursService());
    Get.lazyPut(() => CoursController());
  }
}