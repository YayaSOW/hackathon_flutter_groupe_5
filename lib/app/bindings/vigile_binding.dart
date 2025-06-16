import 'package:ges_absence/app/modules/vigile/controllers/vigile_controller.dart';
import 'package:get/get.dart';

class VigileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VigileHomeController>(() => VigileHomeController());
  }
}