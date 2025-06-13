import 'package:get/get.dart';
import '../../../data/models/cours.dart';
import '../../../data/services/api_service.dart';
import '../../auth/controllers/auth_controller.dart';

class CoursController extends GetxController {
  final ApiService apiService = Get.find();
  RxList<Cours> cours = <Cours>[].obs;
  RxList<Cours> coursSemaine = <Cours>[].obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    loadCours();
  }

  Future<void> loadCours() async {
    try {
      final etudiantId = Get.find<AuthController>().etudiant.value?.id ?? '';
      final fetchedCours = await apiService.getCoursForEtudiant(etudiantId, date: selectedDate.value);
      cours.value = fetchedCours;
      updateCoursSemaine();
    } catch (e) {
      print('Erreur lors du chargement des cours: $e');
      Get.snackbar('Erreur', 'Impossible de charger les cours: $e');
      cours.value = [];
    }
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    loadCours(); // Recharge les cours avec la nouvelle date
    updateCoursSemaine();
  }

  void updateCoursSemaine() {
    final startOfWeek = selectedDate.value.subtract(Duration(days: selectedDate.value.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    coursSemaine.value = cours.where((cours) {
      return cours.date.isAfter(startOfWeek) && cours.date.isBefore(endOfWeek.add(const Duration(days: 1)));
    }).toList();
  }
}