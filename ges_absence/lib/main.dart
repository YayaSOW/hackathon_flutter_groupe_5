import 'package:flutter/material.dart';
import 'package:ges_absence/app/bindings/global_binding.dart';
import 'package:ges_absence/app/bindings/etudiant_binding.dart';
import 'package:ges_absence/app/modules/etudiant/views/absence_view.dart';
import 'package:ges_absence/app/modules/etudiant/views/cours_view.dart';
import 'package:ges_absence/app/modules/etudiant/views/home_view.dart';
import 'package:ges_absence/app/modules/etudiant/views/justification_view.dart';
import 'package:ges_absence/app/modules/etudiant/views/login_view.dart';
import 'package:ges_absence/app/modules/etudiant/views/retards_view.dart';
import 'package:ges_absence/app/routes/app_routes.dart';
import 'package:ges_absence/theme/colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

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
      initialBinding: GlobalBinding(),
      initialRoute: AppRoutes.LOGIN,
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
          page: () => CoursView(),
          binding: EtudiantBinding(),
        ),
        GetPage(name: AppRoutes.ABSENCES, 
        page: () => AbsencesView(),
        binding: EtudiantBinding(),
        ),
        GetPage(
          name: AppRoutes.JUSTIFICATION,
          page: () => JustificationView(absence: Get.arguments),
          binding: EtudiantBinding(),
        ),
        GetPage(
          name: AppRoutes.RETARDS,
          page: () => RetardsView(),
          binding: EtudiantBinding(),
        ),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}