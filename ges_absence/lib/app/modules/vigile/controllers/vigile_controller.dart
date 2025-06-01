import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/data/models/etudiant.dart';
import 'package:ges_absence/app/data/models/cours.dart';
import 'package:ges_absence/app/data/services/api_service.dart';
import 'package:ges_absence/app/data/enums/type_presence.dart';

class VigileController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final isScanning = false.obs;
  final scannedEtudiant = Rx<Etudiant?>(null);
  final selectedCours = Rx<Cours?>(null);
  final courses = <Cours>[].obs;

  static const String ROUTE_HOME = '/vigile/home';
  static const String ROUTE_ETUDIANT = '/vigile/etudiant';

  void toggleScanMode() {
    isScanning.value = !isScanning.value;
  }

  Future<void> searchByMatricule(String matricule) async {
    try {
      final etudiant = await apiService.getEtudiantByMatriculeMock(matricule);
      if (etudiant != null) {
        scannedEtudiant.value = etudiant;
        Get.toNamed(ROUTE_ETUDIANT);
      } else {
        Get.snackbar('Erreur', 'Étudiant non trouvé');
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de la recherche: $e');
    }
  }

  Future<void> markPresence({
    required String etudiantId,
    required String typePresenceString,
  }) async {
    try {
      // Vérifier si un cours est sélectionné
      final cours = selectedCours.value;
      if (cours == null || cours.id == null) {
        throw Exception('Aucun cours sélectionné');
      }

      // Convertir le type de présence
      final typePresence = TypePresence.values.firstWhere(
        (e) => e.name == typePresenceString,
        orElse: () => throw Exception('Type de présence invalide: $typePresenceString'),
      );

      // Appeler le service avec les paramètres validés
      final success = await apiService.markPresenceMock(
        etudiantId: etudiantId,
        coursId: cours.id!, // Forcer le non-null car on a déjà vérifié
        typePresence: typePresence,
      );

      if (!success) {
        throw Exception("Échec de l'enregistrement de la présence");
      }

      // Réinitialiser l'état après un succès
      scannedEtudiant.value = null;
      Get.offNamed(ROUTE_HOME);
    } catch (e) {
      Get.snackbar(
        'Erreur',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    try {
      final loadedCourses = await apiService.getCoursMock();
      courses.assignAll(loadedCourses);
      if (loadedCourses.isNotEmpty) {
        selectedCours.value = loadedCourses.first;
      }
    } catch (e) {
      print('Erreur lors du chargement des cours: $e');
    }
  }

  void scanQRCode(String code) async {
    try {
      if (code.isNotEmpty) {
        await searchByMatricule(code);
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Échec du scan du QR code: $e');
    }
  }
}