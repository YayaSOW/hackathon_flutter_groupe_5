import 'package:ges_absence/app/data/services/cours_service.dart';
import 'package:ges_absence/app/data/services/presence_service.dart';
import 'package:ges_absence/app/modules/etudiant/controllers/absence_controller.dart';
import 'package:ges_absence/app/modules/etudiant/controllers/cours_controller.dart';
import 'package:ges_absence/app/modules/etudiant/controllers/justification_controller.dart';
import 'package:ges_absence/app/modules/etudiant/controllers/retards_controller.dart';
import 'package:get/get.dart';
import '../modules/auth/controllers/auth_controller.dart';
import '../modules/etudiant/controllers/home_controller.dart';

class EtudiantBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CoursService());
    Get.lazyPut(() => CoursController());
    Get.lazyPut(() => AbsencesController());
    Get.lazyPut(() => PresenceService());
    Get.lazyPut(() => JustificationController());
    Get.lazyPut(() => RetardsController());
  }
}