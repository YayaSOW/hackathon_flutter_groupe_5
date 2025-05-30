import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/data/enums/type_presence.dart';
import '../controllers/vigile_home_controller.dart';
import 'package:ges_absence/theme/app_theme.dart';
import 'package:ges_absence/theme/colors.dart';

class VigileEtudiantView extends GetView<VigileHomeController> {
  @override
  Widget build(BuildContext context) {
    final etudiant = controller.scannedEtudiant.value;

    if (etudiant == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Vérification Étudiant', style: AppTheme.appBarStyle),
          backgroundColor: const Color(0xFF8B4513),
        ),
        body: const Center(child: Text('Aucun étudiant sélectionné')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Vérification Étudiant', style: AppTheme.appBarStyle),
        backgroundColor: const Color(0xFF8B4513),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white, size: 50),
            ),
            const SizedBox(height: 20),
            Text(
              '${etudiant.prenom ?? 'Inconnu'} ${etudiant.nom ?? 'Inconnu'}',
              style: AppTheme.titleStyle,
            ),
            Text(
              'Matricule: ${etudiant.matricule ?? 'Non défini'}',
              style: AppTheme.subtitleStyle,
            ),
            Text(
              'Statut: ${etudiant.status == true ? "Actif" : "Inactif"}',
              style: AppTheme.subtitleStyle,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: etudiant.id != null
                      ? () => controller.markPresence(
                            etudiant.id!,
                            TypePresence.PRESENT.name,
                          )
                      : null,
                  child: const Text('✅ Valider Présence'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: etudiant.id != null
                      ? () => controller.markPresence(
                            etudiant.id!,
                            TypePresence.RETARD.name,
                          )
                      : null,
                  child: const Text('Retard'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: etudiant.id != null
                      ? () => controller.markPresence(
                            etudiant.id!,
                            TypePresence.ABSENT.name,
                          )
                      : null,
                  child: const Text('❌ Refuser Présence'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}