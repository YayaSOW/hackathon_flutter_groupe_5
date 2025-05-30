import 'package:get/get.dart';
import 'package:ges_absence/app/data/models/vigile.dart';
import 'package:ges_absence/app/routes/app_routes.dart';
import 'package:ges_absence/app/data/services/api_service.dart';

class VigileAuthController extends GetxController {
  final ApiService apiService = Get.find();
  final vigile = Rxn<Vigile>();
  final isLoading = false.obs;

  Future<void> login(String login, String password) async {
    try {
      isLoading(true);
      final result = await apiService.loginVigile(login, password);
      if (result != null) {
        vigile.value = result;
        Get.offNamed(AppRoutes.VIGILE_HOME);
      } else {
        Get.snackbar('Erreur', 'Identifiants incorrects');
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Connexion échouée: $e');
    } finally {
      isLoading(false);
    }
  }

  void logout() {
    vigile.value = null;
    Get.offAllNamed(AppRoutes.VIGILE_LOGIN);
  }
}