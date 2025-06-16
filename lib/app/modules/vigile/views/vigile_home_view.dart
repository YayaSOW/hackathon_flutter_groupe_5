import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/modules/auth/controllers/auth_controller.dart';
import 'package:ges_absence/app/routes/app_routes.dart';
import 'package:ges_absence/theme/app_theme.dart';
import 'package:ges_absence/theme/colors.dart';

class VigileHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>(); 

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Mon espace vigile', style: AppTheme.appBarStyle),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ====== LOGO AND TITLE ======
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                color: const Color(0xFFED9C37),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/ism_logo.png',
                      height: 150,
                      width: 150,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Mon espace vigile",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              // ====== INFOS VIGILE ======
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
                        Obx(() {
                          final vigile = authController.vigile.value;
                          return Text(
                            '${vigile?.prenom ?? ''} ${vigile?.nom ?? ''}',
                            style: AppTheme.titleStyle,
                          );
                        }),
                        Obx(() {
                          final vigile = authController.vigile.value;
                          return Text(
                            vigile?.login ?? '',
                            style: AppTheme.subtitleStyle,
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ====== LISTE MENU ======
              _buildMenuItem(
                icon: Icons.qr_code_scanner,
                label: 'Scanner un étudiant',
                onTap: () => Get.toNamed(AppRoutes.VIGILE_SCAN),
              ),
              _buildMenuItem(
                icon: Icons.logout,
                label: 'Me Déconnecter',
                color: Colors.red,
                onTap: () => authController.logout(),
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