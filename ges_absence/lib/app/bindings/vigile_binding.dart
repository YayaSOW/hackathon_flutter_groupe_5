import 'package:ges_absence/app/modules/vigile/controllers/home_controller.dart';
import 'package:get/get.dart';

class VigileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VigileHomeController>(() => VigileHomeController());
  }
}