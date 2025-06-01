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
      final success = await apiService.submitJustificationMock( // Utiliser la version mock
        presenceId: presenceId,
        motif: reasonController.text,
      );

      if (success) {
        Get.snackbar(
          'Succès',
          'Justification envoyée avec succès',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        Future.delayed(const Duration(milliseconds: 1500), () {
          Get.offAllNamed(AppRoutes.Etudiant_HOME);
        });
      } else {
        Get.snackbar(
          'Erreur',
          'Échec de la soumission',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
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