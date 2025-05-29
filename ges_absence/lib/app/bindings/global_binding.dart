import 'package:get/get.dart';
import 'package:ges_absence/app/data/services/api_service.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ApiService(), permanent: true);
  }
}