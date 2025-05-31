import 'package:ges_absence/app/data/models/vigile.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/data/models/etudiant.dart';
import 'package:ges_absence/app/routes/app_routes.dart';
import '../../../data/services/api_service.dart';

class AuthController extends GetxController {
  final ApiService apiService = Get.find();
  final etudiant = Rxn<Etudiant>();
  final vigile = Rxn<Vigile>();
  final isLoading = false.obs;

  Future<void> login(String login, String password) async {
    try {
      isLoading(true);
      final result = await apiService.login(login, password);
      if (result != null) {
        if (result['type'] == 'etudiant') {
          etudiant.value = result['user'] as Etudiant;
          Get.offNamed(AppRoutes.Etudiant_HOME);
        } else if (result['type'] == 'vigile') {
          vigile.value = result['user'] as Vigile;
          Get.offNamed(AppRoutes.Vigile_HOME); 
        }
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
    etudiant.value = null;
    vigile.value = null;
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}