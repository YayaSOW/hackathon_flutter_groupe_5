import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/data/services/api_service.dart';
import 'package:ges_absence/app/routes/app_routes.dart';

class JustificationController extends GetxController {
  var selectedFiles = RxList<File>([]); // Liste de fichiers observable
  final reasonController = TextEditingController();
  final ApiService apiService = Get.find();

  void addFiles(List<File> files) {
    selectedFiles.addAll(files); // Ajoute les nouveaux fichiers à la liste
  }

  void removeFile(int index) {
    selectedFiles.removeAt(index); // Supprime un fichier de la liste
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

    if (selectedFiles.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez sélectionner au moins un fichier justificatif',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      // Appeler la méthode mise à jour de l'API avec les fichiers directement
      await apiService.submitJustification(
        presenceId: presenceId,
        reason: reasonController.text,
        files: selectedFiles, // Passer la liste de File directement
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