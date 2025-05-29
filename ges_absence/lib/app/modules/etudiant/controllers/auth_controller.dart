import 'package:ges_absence/app/data/models/etudiant.dart';
import 'package:ges_absence/app/routes/app_routes.dart';
import 'package:get/get.dart';
import '../../../data/services/api_service.dart';

class AuthController extends GetxController {
  final ApiService apiService = Get.find();
  final etudiant = Rxn<Etudiant>();
  final isLoading = false.obs;

  Future<void> login(String login, String password) async {
    try {
      isLoading(true);
      final result = await apiService.loginEtudiant(login, password);
      // print('Résultat de la connexion: $result');
      if (result != null) {
      // if (true) {
        etudiant.value = result;
        //  print('Étudiant connecté: ${etudiant.value?.toJson()}');
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
    etudiant.value = null;
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}