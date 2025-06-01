import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/data/models/etudiant.dart';
import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:ges_absence/app/modules/vigile/controllers/vigile_controller.dart';
import 'package:ges_absence/theme/app_theme.dart';

class VigileEtudiantView extends GetView<VigileController> {
  const VigileEtudiantView({super.key});

  @override
  Widget build(BuildContext context) {
    final etudiant = controller.scannedEtudiant.value!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de l\'étudiant'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Information de l'étudiant
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Matricule', etudiant.matricule),
                    const SizedBox(height: 8),
                    _buildInfoRow('Nom', etudiant.nom),
                    const SizedBox(height: 8),
                    _buildInfoRow('Prénom', etudiant.prenom),
                    const SizedBox(height: 8),
                    _buildInfoRow('Classe', etudiant.classe?.nomClasse ?? 'Non spécifié'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Statut de l'étudiant
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      etudiant.status ? Icons.check_circle : Icons.warning,
                      color: etudiant.status ? Colors.green : Colors.orange,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Statut: ${etudiant.status ? "À jour" : "Pas à jour"}',
                      style: TextStyle(
                        color: etudiant.status ? Colors.green.shade700 : Colors.orange.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      await controller.markPresence(
                        etudiantId: etudiant.id!,
                        typePresenceString: TypePresence.PRESENT.name,
                      );
                      Get.snackbar(
                        'Succès',
                        'Présence validée',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                      Get.offNamed(VigileController.ROUTE_HOME);
                    } catch (e) {
                      Get.snackbar(
                        'Erreur',
                        'Échec de l\'enregistrement de la présence',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Valider Présence'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      await controller.markPresence(
                        etudiantId: etudiant.id!,
                        typePresenceString: TypePresence.RETARD.name,
                      );
                      Get.snackbar(
                        'Information',
                        'Retard enregistré',
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                      );
                      Get.offNamed(VigileController.ROUTE_HOME);
                    } catch (e) {
                      Get.snackbar(
                        'Erreur',
                        'Échec de l\'enregistrement du retard',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  icon: const Icon(Icons.watch_later),
                  label: const Text('Marquer en Retard'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      await controller.markPresence(
                        etudiantId: etudiant.id!,
                        typePresenceString: TypePresence.ABSENT.name,
                      );
                      Get.snackbar(
                        'Information',
                        'Absence enregistrée',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      Get.offNamed(VigileController.ROUTE_HOME);
                    } catch (e) {
                      Get.snackbar(
                        'Erreur',
                        'Échec de l\'enregistrement de l\'absence',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  icon: const Icon(Icons.person_off),
                  label: const Text('Marquer Absent'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: AppTheme.subtitleStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: AppTheme.subtitleStyle,
        ),
      ],
    );
  }
}