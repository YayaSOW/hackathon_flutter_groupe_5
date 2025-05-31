import 'package:get/get.dart';
import 'package:ges_absence/app/data/services/api_service.dart';
import 'package:ges_absence/app/data/models/etudiant.dart';
import 'package:ges_absence/app/routes/app_routes.dart';

class VigileHomeController extends GetxController {
  final ApiService apiService = Get.find();
  final isScanning = true.obs;
  final scannedEtudiant = Rxn<Etudiant>();

  void toggleScanMode() {
    isScanning.value = !isScanning.value;
  }

  Future<void> scanQRCode(String code) async {
    try {
      final etudiant = await apiService.getEtudiantByQR(code);
      if (etudiant != null) {
        scannedEtudiant.value = etudiant;
        Get.toNamed(AppRoutes.VIGILE_ETUDIANT);
      } else {
        Get.snackbar('Erreur', 'Étudiant non trouvé');
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Échec du scan: $e');
    }
  }

  Future<void> searchByMatricule(String matricule) async {
    try {
      final etudiant = await apiService.getEtudiantByMatricule(matricule);
      if (etudiant != null) {
        scannedEtudiant.value = etudiant;
        Get.toNamed(AppRoutes.VIGILE_ETUDIANT);
      } else {
        Get.snackbar('Erreur', 'Étudiant non trouvé');
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de la recherche: $e');
    }
  }

  Future<void> markPresence(String etudiantId, String typePresence) async {
    try {
      await apiService.markPresence(etudiantId, typePresence);
      Get.snackbar('Succès', 'Présence enregistrée');
      Get.back();
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de l\'enregistrement: $e');
    }
  }
}