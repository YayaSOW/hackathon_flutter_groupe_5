import 'package:get/get.dart';
import 'package:ges_absence/app/modules/auth/controllers/auth_controller.dart';
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:ges_absence/app/data/services/api_service.dart';

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
        final result = await apiService.getPresencesForEtudiant(etudiantId.toString()); 
        presences.assignAll(result);
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les présences');
    } finally {
      isLoading(false);
    }
  }
}