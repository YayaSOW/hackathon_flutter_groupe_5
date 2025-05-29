import 'package:flutter/material.dart';
import 'package:ges_absence/app/routes/app_routes.dart';
import 'package:ges_absence/theme/app_theme.dart';
import 'package:ges_absence/theme/colors.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/auth_controller.dart';
import '../widgets/menu_item.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final etudiant = Get.find<AuthController>().etudiant.value;

    //  print('Étudiant dans HomeView: ${etudiant?.toJson()}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Etudiant Dashboard', style: AppTheme.appBarStyle),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.secondaryColor,
                  child: Text(
                    etudiant?.prenom.substring(0, 1) ?? '',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${etudiant?.prenom} ${etudiant?.nom}',
                      style: AppTheme.titleStyle,
                    ),
                    Text(
                      etudiant?.matricule ?? '',
                      style: AppTheme.subtitleStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                MenuItem(
                  title: 'Scanner',
                  icon: Icons.qr_code_scanner,
                  onTap: () => Get.toNamed(AppRoutes.SCANNER),
                ),
                MenuItem(
                  title: 'Mes Cours',
                  icon: Icons.school,
                  onTap: () => Get.toNamed(AppRoutes.COURS),
                ),
                MenuItem(
                  title: 'Mes Absences',
                  icon: Icons.list_alt,
                  onTap: () => Get.toNamed(AppRoutes.ABSENCES),
                ),
                MenuItem(
                  title: 'Mes Retards',
                  icon: Icons.access_time,
                  onTap: () => Get.toNamed(AppRoutes.RETARDS),
                ),
                MenuItem(
                  title: 'Me Déconnecter',
                  icon: Icons.logout,
                  onTap: () => Get.find<AuthController>().logout(),
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}