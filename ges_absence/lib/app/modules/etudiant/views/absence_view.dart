import 'package:flutter/material.dart';
import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:ges_absence/app/modules/etudiant/controllers/absence_controller.dart';
import 'package:get/get.dart';
import 'package:ges_absence/theme/colors.dart';

class AbsencesView extends GetView<AbsencesController> {
  const AbsencesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Absences"),
        backgroundColor: AppColors.primaryColor,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Obx(() => controller.absences.isEmpty
          ? const Center(child: Text("Aucune absence enregistrée", style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.absences.length,
              itemBuilder: (context, index) {
                final absence = controller.absences[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  color: AppColors.primaryColor.withOpacity(0.2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.warning, color: AppColors.secondaryColor),
                    title: Text(
                      absence.cours.nomCours,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "${absence.date.day}/${absence.date.month}/${absence.date.year} • Raison: ${absence.typePresence == TypePresence.ABSENT ? 'Absence' : 'Non définie'}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                );
              },
            )),
    );
  }
}