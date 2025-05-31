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
        title: Obx(() {
          final vigile = authController.vigile.value;
          if (vigile == null) return const Text('');
          return Text(
            '${vigile.prenom} ${vigile.nom} - ${vigile.login}',
            style: AppTheme.appBarStyle,
          );
        }),
        backgroundColor: const Color(0xFF8B4513),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Obx(() {
        final vigile = authController.vigile.value;
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF8B4513),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${vigile?.prenom ?? ''} ${vigile?.nom ?? ''}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      vigile?.login ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Se déconnecter'),
                onTap: () => authController.logout(),
              ),
            ],
          ),
        );
      }),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ism_logo.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.VIGILE_SCAN),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.qr_code_scanner),
                  SizedBox(width: 10),
                  Text('Scanner un étudiant'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => authController.logout(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.logout),
                  SizedBox(width: 10),
                  Text('Se déconnecter'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}