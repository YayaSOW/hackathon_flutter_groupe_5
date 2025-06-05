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
                // Parser les heures si elles sont au format "HH:mm:ss.SSS"
                final startParts = retard.heureDebut?.split(':') ?? ['0', '0', '0'];
                final endParts = retard.heureFin?.split(':') ?? ['0', '0', '0'];
                final startHour = int.parse(startParts[0]);
                final startMinute = int.parse(startParts[1].split('.')[0]);
                final endHour = int.parse(endParts[0]);
                final endMinute = int.parse(endParts[1].split('.')[0]);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  color: AppColors.primaryColor.withOpacity(0.2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.access_time, color: AppColors.secondaryColor),
                    title: Text(
                      retard.cours, // Utiliser directement la chaîne
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "${retard.date?.day ?? 0}/${retard.date?.month ?? 0}/${retard.date?.year ?? 0} • Heure: "
                      "$startHour:${startMinute.toString().padLeft(2, '0')} - "
                      "$endHour:${endMinute.toString().padLeft(2, '0')}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                );
              },
            )),
    );
  }
}