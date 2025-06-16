import 'package:get/get.dart';
import '../modules/etudiant/controllers/geolocalisation_controller.dart';

class GeolocalisationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeolocalisationController>(() => GeolocalisationController());
  }
}