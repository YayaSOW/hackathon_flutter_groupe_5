import 'package:flutter/material.dart';
import 'package:ges_absence/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/routes/app_routes.dart';
import 'package:ges_absence/theme/app_theme.dart';
import 'package:ges_absence/theme/colors.dart';

class VigileHomeView extends StatelessWidget {
  const VigileHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Pour l'instant, on commente les parties qui dépendent de VigileAuthController
    // final vigile = Get.find<VigileAuthController>().vigile.value;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: Text(
        //   '${vigile?.prenom} ${vigile?.nom} - ${vigile?.login}',
        //   style: AppTheme.appBarStyle,
        // ),
        // backgroundColor: const Color(0xFF8B4513), // Couleur chocolat
        // leading: Builder(
        //   builder: (context) => IconButton(
        //     icon: const Icon(Icons.menu),
        //     onPressed: () => Scaffold.of(context).openDrawer(),
        //   ),
        // ),
      ),
      drawer: Drawer(
        // child: ListView(
        //   padding: EdgeInsets.zero,
        //   children: [
        //     DrawerHeader(
        //       decoration: const BoxDecoration(
        //         color: Color(0xFF8B4513),
        //       ),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             '${vigile?.prenom} ${vigile?.nom}',
        //             style: const TextStyle(
        //               color: Colors.white,
        //               fontSize: 24,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           Text(
        //             vigile?.login ?? '',
        //             style: const TextStyle(
        //               color: Colors.white70,
        //               fontSize: 16,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     ListTile(
        //       leading: const Icon(Icons.logout, color: Colors.red),
        //       title: const Text('Se déconnecter'),
        //       onTap: () => Get.find<VigileAuthController>().logout(),
        //     ),
        //   ],
        // ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Page d\'accueil Vigile (en développement)',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Placeholder pour tester la déconnexion
                Get.find<AuthController>().logout();
              },
              child: const Text('Se déconnecter'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}