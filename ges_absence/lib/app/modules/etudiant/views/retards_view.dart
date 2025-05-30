import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/modules/etudiant/controllers/retards_controller.dart';
import 'package:ges_absence/theme/colors.dart';

class RetardsView extends GetView<RetardsController> {
  const RetardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Retards"),
        backgroundColor: AppColors.primaryColor,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Obx(() => controller.retards.isEmpty
          ? const Center(child: Text("Aucun retard enregistré", style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.retards.length,
              itemBuilder: (context, index) {
                final retard = controller.retards[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  color: AppColors.primaryColor.withOpacity(0.2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.access_time, color: AppColors.secondaryColor),
                    title: Text(
                      retard.cours.nomCours,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "${retard.date.day}/${retard.date.month}/${retard.date.year} • Heure: "
                      "${retard.cours.heureDebut.hour}:${retard.cours.heureDebut.minute.toString().padLeft(2, '0')} - "
                      "${retard.cours.heureFin.hour}:${retard.cours.heureFin.minute.toString().padLeft(2, '0')}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                );
              },
            )),
    );
  }
}