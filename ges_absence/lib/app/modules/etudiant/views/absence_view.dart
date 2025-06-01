import 'package:flutter/material.dart';
import 'package:ges_absence/app/modules/etudiant/controllers/absence_controller.dart';
import 'package:ges_absence/app/modules/etudiant/views/justification_view.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:ges_absence/theme/colors.dart';
import 'package:intl/intl.dart';

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
                  color: _getCardColor(absence.typePresence),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Icon(
                      _getStatusIcon(absence.typePresence),
                      color: AppColors.secondaryColor,
                    ),
                    title: Text(
                      absence.cours?.nomCours ?? 'Cours non spécifié',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "${_formatDate(absence.date)} • ${_getTypePresenceText(absence.typePresence)}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: AppColors.secondaryColor),
                      onPressed: () {
                        Get.to(() => JustificationView(absence: absence));
                      },
                    ),
                  ),
                );
              },
            )),
    );
  }

  Color _getCardColor(TypePresence type) {
    switch (type) {
      case TypePresence.ABSENT:
        return AppColors.primaryColor.withOpacity(0.2);
      case TypePresence.RETARD:
        return Colors.orange.withOpacity(0.2);
      default:
        return AppColors.primaryColor.withOpacity(0.2);
    }
  }

  IconData _getStatusIcon(TypePresence type) {
    switch (type) {
      case TypePresence.ABSENT:
        return Icons.warning;
      case TypePresence.RETARD:
        return Icons.watch_later;
      default:
        return Icons.warning;
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date); // Format français
  }

  String _getTypePresenceText(TypePresence type) {
    switch (type) {
      case TypePresence.ABSENT:
        return 'Absence';
      case TypePresence.RETARD:
        return 'Retard';
      case TypePresence.PRESENT:
        return 'Présent';
    }
  }
}