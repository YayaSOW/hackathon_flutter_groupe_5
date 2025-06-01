import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:ges_absence/theme/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ges_absence/app/modules/etudiant/controllers/justification_controller.dart';
import 'package:ges_absence/app/data/enums/type_presence.dart';

class JustificationView extends StatelessWidget {
  final Presence absence;

  const JustificationView({super.key, required this.absence});

  String _getTitle() {
    switch (absence.typePresence) {
      case TypePresence.ABSENT:
        return "Justifier une absence";
      case TypePresence.RETARD:
        return "Justifier un retard";
      default:
        return "Justification";
    }
  }

  String _getMotifLabel() {
    return "Motif ${absence.typePresence == TypePresence.ABSENT ? "de l'absence" : 'du retard'} :";
  }

  @override
  Widget build(BuildContext context) {
    if (absence.typePresence == TypePresence.PRESENT) {
      // Redirection vers la page précédente si c'est une présence
      Get.back();
      return const SizedBox.shrink();
    }

    final controller = Get.put(JustificationController());

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        backgroundColor: AppColors.primaryColor,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === INFOS DU COURS ===
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: absence.typePresence == TypePresence.ABSENT
                    ? const Color(0xFFED9C37)
                    : Colors.orange.shade400,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    absence.cours?.nomCours ?? 'Cours non spécifié',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Date : ${absence.date.day}/${absence.date.month}/${absence.date.year}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  if (absence.cours?.heureDebut != null && absence.cours?.heureFin != null)
                    Text(
                      "Heure : ${absence.cours!.heureDebut.hour}:${absence.cours!.heureDebut.minute.toString().padLeft(2, '0')} - "
                      "${absence.cours!.heureFin.hour}:${absence.cours!.heureFin.minute.toString().padLeft(2, '0')}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // === MOTIF ===
            Text(
              _getMotifLabel(),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.brown.shade200,
                  style: BorderStyle.solid,
                ),
              ),
              child: TextField(
                controller: controller.reasonController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: "Entrer le motif",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // === JUSTIFICATIF ===
            const Text(
              "Justificatif :",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.brown.shade200),
              ),
              child: Column(
                children: [
                  const Icon(Icons.add, size: 40, color: Colors.black54),
                  const SizedBox(height: 8),
                  const Text("Déposez votre fichier ici",
                      style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 12),
                  Obx(() => ElevatedButton.icon(
                        onPressed: () async {
                          final pickedFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (pickedFile != null) {
                            controller.setFile(File(pickedFile.path));
                          }
                        },
                        icon: const Icon(Icons.upload),
                        label: Text(
                          controller.selectedFile.value != null
                              ? controller.selectedFile.value!.path
                                  .split('/')
                                  .last
                              : "Importer",
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      )),
                ],
              ),
            ),

            const Spacer(),

            // === BOUTON SOUMETTRE ===
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (absence.id != null) {
                    controller.submitJustification(absence.id!);
                  } else {
                    Get.snackbar(
                      'Erreur',
                      'Impossible de soumettre la justification',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade900,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Soumettre",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}