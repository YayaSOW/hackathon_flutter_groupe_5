import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:ges_absence/app/data/services/api_service.dart';
import 'package:ges_absence/app/modules/etudiant/controllers/auth_controller.dart';

class AbsencesController extends GetxController {
  var absences = <Presence>[].obs; // Liste des présences de type ABSENT
  final ApiService apiService = Get.find();

  @override
  void onInit() {
    super.onInit();
    _loadAbsences();
  }

  Future<void> _loadAbsences() async {
    try {
      final etudiant = Get.find<AuthController>().etudiant.value;
      if (etudiant != null) {
        print('Chargement des absences pour l\'étudiant ID: ${etudiant.id}'); // Débogage
        final allPresences = await apiService.getPresencesForEtudiant(etudiant.id!.toString());
        absences.assignAll(allPresences.where((presence) => presence.typePresence == TypePresence.ABSENT).toList());
        print('Absences chargées: ${absences.length}'); // Débogage
      } else {
        print('Aucun étudiant connecté');
      }
    } catch (e) {
      print('Erreur dans _loadAbsences: $e');
      Get.snackbar('Erreur', 'Échec du chargement des absences: $e');
    }
  }
}