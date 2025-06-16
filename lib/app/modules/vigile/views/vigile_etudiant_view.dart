import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ges_absence/theme/app_theme.dart';
import 'package:ges_absence/theme/colors.dart';
import '../controllers/vigile_controller.dart';

class VigileEtudiantView extends GetView<VigileHomeController> {
  const VigileEtudiantView({super.key});

  @override
  Widget build(BuildContext context) {
    final etudiant = controller.scannedEtudiant.value;

    if (etudiant == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Vérification Étudiant', style: AppTheme.appBarStyle),
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'Aucun étudiant sélectionné',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vérification Étudiant', style: AppTheme.appBarStyle),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Nom et prénom
              _buildInfoCard(
                icon: Icons.person_outline,
                label: '${etudiant.prenom ?? 'Inconnu'} ${etudiant.nom ?? 'Inconnu'}',
                color: Colors.blue,
              ),
              const SizedBox(height: 10),
              // Matricule
              _buildInfoCard(
                icon: Icons.badge,
                label: 'Matricule: ${etudiant.matricule ?? 'Non défini'}',
                color: Colors.green,
              ),
              const SizedBox(height: 10),
              // Statut
              // _buildInfoCard(
              //   icon: Icons.check_circle_outline,
              //   label: 'Statut: ${etudiant.status != null ? (etudiant.status! ? "À jour" : "Pas à jour") : "Non défini"}',
              //   color: Colors.orange,
              // ),
              const SizedBox(height: 10),
              // Présence
              _buildInfoCard(
                icon: Icons.event_available,
                label: 'Présence: ${etudiant.typePresence ?? 'Non défini'}',
                color: Colors.purple,
              ),
              const SizedBox(height: 10),
              // Cours
              _buildInfoCard(
                icon: Icons.book,
                label: 'Cours: ${etudiant.cours ?? 'Non défini'}',
                color: Colors.teal,
              ),
              const SizedBox(height: 10),
              // Heure de début
              _buildInfoCard(
                icon: Icons.access_time,
                label: 'Heure de début: ${etudiant.heureDebut ?? 'Non défini'}',
                color: Colors.red,
              ),
              const SizedBox(height: 10),
              // Heure de fin
              _buildInfoCard(
                icon: Icons.access_time_filled,
                label: 'Heure de fin: ${etudiant.heureFin ?? 'Non défini'}',
                color: Colors.indigo,
              ),
              const SizedBox(height: 30),
              // Bouton Retour
              ElevatedButton.icon(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: const Text(
                  'Retour',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: AppTheme.subtitleStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}