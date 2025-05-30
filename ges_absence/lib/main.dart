import 'package:flutter/material.dart';
import 'package:ges_absence/app/bindings/global_binding.dart';
import 'package:ges_absence/app/bindings/etudiant_binding.dart';
import 'package:ges_absence/app/modules/etudiant/views/home_view.dart';
import 'package:ges_absence/app/modules/etudiant/views/login_view.dart';
import 'package:ges_absence/app/routes/app_routes.dart';
import 'package:ges_absence/theme/colors.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ges_absence/app/modules/vigile/views/vigile_login_view.dart';
import 'package:ges_absence/app/modules/vigile/views/vigile_home_view.dart';
import 'package:ges_absence/app/modules/vigile/views/vigile_scan_view.dart';
import 'package:ges_absence/app/modules/vigile/views/vigile_etudiant_view.dart';
import 'package:ges_absence/app/modules/vigile/bindings/vigile_binding.dart';






void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ISM Ges Absence',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.secondaryColor,
        ),
        fontFamily: 'Roboto',
      ),
      // initialBinding: GlobalBinding(),
      // initialRoute: AppRoutes.LOGIN,

      initialBinding: GlobalBinding(),
      initialRoute: AppRoutes.VIGILE_LOGIN,
      
      getPages: [
        GetPage(
          name: AppRoutes.LOGIN,
          page: () => LoginView(),
          binding: EtudiantBinding(),
        ),
        GetPage(
          name: AppRoutes.Etudiant_HOME,
          page: () => HomeView(),
          // binding: VigileBinding(),
        ),
        
        GetPage(
          name: AppRoutes.COURS,
          page: () => const Scaffold(body: Center(child: Text('Cours Page'))),
          binding: EtudiantBinding(),
        ),
        GetPage(
          name: AppRoutes.ABSENCES,
          page: () => const Scaffold(body: Center(child: Text('Absences Page'))),
          binding: EtudiantBinding(),
        ),
        GetPage(
          name: AppRoutes.RETARDS,
          page: () => const Scaffold(body: Center(child: Text('Retards Page'))),
          binding: EtudiantBinding(),
        ),
        GetPage(
          name: AppRoutes.VIGILE_LOGIN,
          page: () => VigileLoginView(),
          binding: VigileBinding(),
        ),
        GetPage(
          name: AppRoutes.VIGILE_HOME,
          page: () => VigileHomeView(),
          binding: VigileBinding(),
        ),
        GetPage(
          name: AppRoutes.VIGILE_SCAN,
          page: () => VigileScanView(),
          binding: VigileBinding(),
        ),
        GetPage(
          name: AppRoutes.VIGILE_ETUDIANT,
          page: () => VigileEtudiantView(),
          binding: VigileBinding(),
        ),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}