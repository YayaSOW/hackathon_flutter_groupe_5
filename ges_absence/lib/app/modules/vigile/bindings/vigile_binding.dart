import 'package:get/get.dart';
import '../controllers/vigile_auth_controller.dart';
import '../controllers/vigile_home_controller.dart';

class VigileBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<VigileAuthController>(() => VigileAuthController());
    Get.put(VigileAuthController(), permanent: true);
    Get.lazyPut<VigileHomeController>(() => VigileHomeController());
  }
}
