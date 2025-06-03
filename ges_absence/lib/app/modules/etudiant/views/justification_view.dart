import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:ges_absence/theme/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ges_absence/app/modules/etudiant/controllers/justification_controller.dart';

class JustificationView extends StatelessWidget {
  final Presence absence;

  const JustificationView({super.key, required this.absence});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JustificationController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Justifier une absence"),
        backgroundColor: AppColors.primaryColor,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView( // Wrap the body in SingleChildScrollView to allow scrolling
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === INFOS DU COURS ===
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFED9C37),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    absence.cours.nomCours,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Date : ${absence.date.day}/${absence.date.month}/${absence.date.year}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "Heure : ${absence.cours.heureDebut.hour}:${absence.cours.heureDebut.minute.toString().padLeft(2, '0')} - "
                        "${absence.cours.heureFin.hour}:${absence.cours.heureFin.minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // === MOTIF ===
            const Text(
              "Motif de l’absence :",
              style: TextStyle(fontWeight: FontWeight.w600),
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
                  hintText: "Entrer le motif de l’absence",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // === JUSTIFICATIF ===
            const Text(
              "Justificatifs :",
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
                  const Text("Déposez vos fichiers ici", style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        controller.addFile(File(pickedFile.path));
                      }
                    },
                    icon: const Icon(Icons.upload),
                    label: const Text("Ajouter une image"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(() => Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: controller.selectedFiles.map((file) => Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(file),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.remove_circle, color: Colors.red),
                                onPressed: () => controller.removeFile(file),
                              ),
                            ),
                          ],
                        )).toList(),
                      )),
                ],
              ),
            ),

            const SizedBox(height: 24), // Add spacing before the button

            // === SOUMETTRE ===
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.submitJustification(absence.id.toString());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade900,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Soumettre", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}