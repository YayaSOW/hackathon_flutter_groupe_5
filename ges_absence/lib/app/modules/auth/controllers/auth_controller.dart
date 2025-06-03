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
        final userData = result['user'];
        print('USERDATA: $userData');
        final role = result['type'];
        final token = result['token'];

        if (role == 'ETUDIANT') {
          etudiant.value = Etudiant.fromJson(userData);
          Get.offNamed(AppRoutes.Etudiant_HOME);
        } else if (role == 'VIGILE') {
          vigile.value = Vigile.fromJson(userData);
          Get.offNamed(AppRoutes.Vigile_HOME);
        } else {
          Get.snackbar('Erreur', 'Rôle utilisateur inconnu');
        }
      } else {
        Get.snackbar('Erreur', 'Identifiants incorrects');
      }
    } catch (e) {
      print('Exception de login : $e');
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
