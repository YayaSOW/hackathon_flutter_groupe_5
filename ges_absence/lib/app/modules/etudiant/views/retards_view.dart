import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/modules/etudiant/controllers/retards_controller.dart';
import 'package:ges_absence/theme/colors.dart';
import 'package:intl/intl.dart';

class RetardsView extends GetView<RetardsController> {
  const RetardsView({super.key});

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String _formatHeure(TimeOfDay time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Retards"),
        backgroundColor: Colors.orange.shade700,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Obx(() => controller.retards.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Aucun retard enregistré",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.retards.length,
              itemBuilder: (context, index) {
                final retard = controller.retards[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  color: Colors.orange.shade700.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.access_time,
                        color: Colors.deepOrange,
                      ),
                    ),
                    title: Text(
                      retard.cours?.nomCours ?? 'Cours non spécifié',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date : ${_formatDate(retard.date)}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                        if (retard.cours?.heureDebut != null && retard.cours?.heureFin != null)
                          Text(
                            "Horaire : ${_formatHeure(retard.cours!.heureDebut)} - ${_formatHeure(retard.cours!.heureFin)}",
                            style: const TextStyle(color: Colors.white70),
                          ),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            )),
    );
  }
}