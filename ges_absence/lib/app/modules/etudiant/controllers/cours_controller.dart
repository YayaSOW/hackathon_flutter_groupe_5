import 'package:get/get.dart';
import '../../../data/models/cours.dart';
import '../../../data/services/api_service.dart';

class CoursController extends GetxController {
  final ApiService apiService = Get.find();
  final RxList<Cours> cours = <Cours>[].obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    loadCours();
  }

  void loadCours() async {
    final allCours = await apiService.getCoursMock(); // Utiliser la version mock
    cours.assignAll(allCours);
  }

  List<Cours> get coursSemaine {
    final debut = selectedDate.value.subtract(Duration(days: selectedDate.value.weekday - 1));
    final fin = debut.add(Duration(days: 6));
    return cours
        .where((c) =>
            c.date.isAfter(debut.subtract(Duration(seconds: 1))) &&
            c.date.isBefore(fin.add(Duration(days: 1))))
        .toList();
  }
}