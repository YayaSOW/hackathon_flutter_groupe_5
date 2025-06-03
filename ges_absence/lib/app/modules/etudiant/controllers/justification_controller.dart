import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ges_absence/app/data/services/api_service.dart';
import 'package:ges_absence/app/routes/app_routes.dart';

class JustificationController extends GetxController {
  var selectedFiles = RxList<File>([]);
  final reasonController = TextEditingController();
  final ApiService apiService = Get.find();
  final cloudinary = CloudinaryPublic('dq0li0hpe', 'flutter_unsigned_upload', cache: false);

  void addFile(File file) {
    selectedFiles.add(file);
  }

  void removeFile(File file) {
    selectedFiles.remove(file);
  }

  Future<List<String>> uploadImagesToCloudinary() async {
    List<String> imageUrls = [];
    try {
      for (var file in selectedFiles) {
        final response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(file.path, resourceType: CloudinaryResourceType.Image),
        );
        imageUrls.add(response.secureUrl);
      }
      return imageUrls;
    } catch (e) {
      throw Exception('Failed to upload images to Cloudinary: $e');
    }
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
      // Upload images to Cloudinary and get URLs
      final imageUrls = await uploadImagesToCloudinary();

      // Submit justification with image URLs
      await apiService.submitJustification(
        presenceId: presenceId,
        reason: reasonController.text,
        fileUrls: imageUrls, // Pass list of URLs instead of filePath
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