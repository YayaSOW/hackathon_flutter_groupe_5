// HomeController.dart
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:ges_absence/app/data/services/api_service.dart';
import 'package:ges_absence/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController {
  final ApiService apiService = Get.find();
  final presences = <Presence>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchPresences();
    super.onInit();
  }

  Future<void> fetchPresences() async {
    try {
      isLoading(true);
      final etudiantId = Get.find<AuthController>().etudiant.value?.id;
      if (etudiantId != null) {
        final result = await apiService.getPresencesForEtudiantMock(etudiantId); // Utiliser la version mock
        presences.assignAll(result);
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les présences');
    } finally {
      isLoading(false);
    }
  }
}
