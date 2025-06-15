import 'package:flutter/material.dart';
import 'package:ges_absence/app/routes/app_routes.dart';
import 'package:ges_absence/theme/app_theme.dart';
import 'package:ges_absence/theme/colors.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../controllers/home_controller.dart';
import '../../auth/controllers/auth_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final etudiant = Get.find<AuthController>().etudiant.value;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Mon espace étudiant', style: AppTheme.appBarStyle),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ====== QR CODE ======
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                color: const Color(0xFFED9C37),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: QrImageView(
                        data: etudiant != null
                            ? '${etudiant.prenom} ${etudiant.nom} - ${etudiant.matricule}'
                            : 'Inconnu',
                        version: QrVersions.auto,
                        size: 150.0,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Scanner",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              // ====== INFOS ETUDIANT ======
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), 
                    topRight: Radius.circular(20), 
                  ),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${etudiant?.prenom} ${etudiant?.nom}',
                          style: AppTheme.titleStyle,
                        ),
                        // Text(
                        //   etudiant?.telephone ?? '',
                        //   style: AppTheme.subtitleStyle,
                        // ),
                        Text(
                          etudiant?.matricule ?? '',
                          style: AppTheme.subtitleStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ====== LISTE MENU ======
              _buildMenuItem(
                icon: Icons.school,
                label: 'Mes Cours',
                onTap: () => Get.toNamed(AppRoutes.COURS),
              ),
              _buildMenuItem(
                icon: Icons.list_alt,
                label: 'Mes Absences',
                onTap: () => Get.toNamed(AppRoutes.ABSENCES),
              ),
              _buildMenuItem(
                icon: Icons.access_time,
                label: 'Mes Retards',
                onTap: () => Get.toNamed(AppRoutes.RETARDS),
              ),
               _buildMenuItem(
                icon: Icons.location_on,
                label: 'Itinéraire vers ISM',
                color: const Color.fromARGB(255, 0, 1, 1),
                onTap: () => Get.toNamed(AppRoutes.GEOLOCALISATION),
              ),
              _buildMenuItem(
                icon: Icons.logout,
                label: 'Me Déconnecter',
                color: Colors.red,
                onTap: () => Get.find<AuthController>().logout(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        elevation: 4,
        // ignore: deprecated_member_use
        shadowColor: Colors.grey.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}