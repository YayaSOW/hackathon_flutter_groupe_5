import 'package:ges_absence/app/bindings/geolocalisation_binding.dart';
import 'package:ges_absence/app/modules/etudiant/views/absence_view.dart';
import 'package:ges_absence/app/modules/etudiant/views/geolocalisation_view.dart';
import 'package:ges_absence/app/modules/vigile/views/vigile_etudiant_view.dart';
import 'package:ges_absence/app/modules/vigile/views/vigile_home_view.dart';
import 'package:ges_absence/app/modules/vigile/views/vigile_scan_view.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/bindings/etudiant_binding.dart';
import 'package:ges_absence/app/bindings/vigile_binding.dart';
import 'package:ges_absence/app/modules/auth/views/login_view.dart';
import 'package:ges_absence/app/modules/etudiant/views/cours_view.dart';
import 'package:ges_absence/app/modules/etudiant/views/home_view.dart';
import 'package:ges_absence/app/modules/etudiant/views/justification_view.dart';
import 'package:ges_absence/app/modules/etudiant/views/retards_view.dart';
import 'package:ges_absence/app/routes/app_routes.dart';

class AppPages {
    static final initial = AppRoutes.LOGIN;

  static final pages = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginView(),
      binding: EtudiantBinding(),
    ),
    GetPage(
      name: AppRoutes.Etudiant_HOME,
      page: () => HomeView(),
      binding: EtudiantBinding(),
    ),
    GetPage(
      name: AppRoutes.COURS,
      page: () => CoursView(),
      binding: EtudiantBinding(),
    ),
    GetPage(
      name: AppRoutes.ABSENCES,
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
    GetPage(
      name: AppRoutes.Vigile_HOME,
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
    GetPage(
      name: AppRoutes.GEOLOCALISATION,
      page: () => GeolocalisationView(),
      binding: GeolocalisationBinding(),
    ),
  ];

}