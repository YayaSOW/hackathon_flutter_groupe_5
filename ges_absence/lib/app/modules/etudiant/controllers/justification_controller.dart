import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/data/services/api_service.dart';
import 'package:ges_absence/app/routes/app_routes.dart';

class JustificationController extends GetxController {
  var selectedFile = Rx<File?>(null);
  final reasonController = TextEditingController();
  final ApiService apiService = Get.find();

  void setFile(File file) {
    selectedFile.value = file;
  }

  Future<void> submitJustification(String presenceId) async {
    // Validation des champs
    if (reasonController.text.trim().isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer un motif pour votre absence',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (selectedFile.value == null) {
      Get.snackbar(
        'Erreur',
        'Veuillez sélectionner un fichier justificatif',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      // Simuler l'envoi au serveur (à remplacer par une vraie requête API)
      await apiService.submitJustification(
        presenceId: presenceId,
        reason: reasonController.text,
        filePath: selectedFile.value!.path,
      );

      // Afficher le message de succès
      Get.snackbar(
        'Succès',
        'Justification envoyée avec succès',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      // Rediriger après un délai
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.offAllNamed(AppRoutes.Etudiant_HOME);
      });
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Échec de la soumission: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    reasonController.dispose();
    super.onClose();
  }
}