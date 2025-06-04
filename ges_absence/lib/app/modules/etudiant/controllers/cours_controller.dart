import 'package:get/get.dart';
import '../../../data/models/cours.dart';
import '../../../data/services/cours_service.dart';
import 'package:ges_absence/app/modules/auth/controllers/auth_controller.dart';

class CoursController extends GetxController {
  final coursService = Get.find<CoursService>();
  final RxList<Cours> cours = <Cours>[].obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    loadCours();
  }

  void loadCours() async {
    final id = Get.find<AuthController>().etudiant.value?.id;
    final allCours = await coursService.fetchCours(id.toString());
    cours.assignAll(allCours);
  }

  List<Cours> get coursSemaine {
    final debut = selectedDate.value.subtract(
      Duration(days: selectedDate.value.weekday - 1),
    );
    final fin = debut.add(Duration(days: 6));
    return cours
        .where(
          (c) =>
              c.date.isAfter(debut.subtract(Duration(seconds: 1))) &&
              c.date.isBefore(fin.add(Duration(days: 1))),
        )
        .toList();
  }
}
