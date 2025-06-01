import 'package:ges_absence/app/data/models/etudiant.dart';
import 'package:ges_absence/app/data/models/vigile.dart';
import 'package:ges_absence/app/data/services/api_service.dart';
import 'package:ges_absence/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {
  final ApiService apiService = Get.find();
  final etudiant = Rxn<Etudiant>();
  final vigile = Rxn<Vigile>();
  final isLoading = false.obs;

  Future<void> login(String login, String password) async {
    try {
      isLoading(true);
      print('Tentative de connexion avec login: $login, password: $password');
      final result = await apiService.loginMock(login, password); // Utiliser la version mock
      print('Résultat de loginMock: $result');
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
      print('Erreur dans login: $e');
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