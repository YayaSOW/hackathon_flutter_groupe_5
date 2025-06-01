import 'package:get/get.dart';
import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:ges_absence/app/data/services/presence_service.dart';
import 'package:ges_absence/app/modules/auth/controllers/auth_controller.dart';

class AbsencesController extends GetxController {
  var absences = <Presence>[].obs;
  final PresenceService presenceService = Get.find();

  @override
  void onInit() {
    super.onInit();
    _loadAbsences();
  }

  Future<void> _loadAbsences() async {
    try {
      final etudiant = Get.find<AuthController>().etudiant.value;
      if (etudiant != null) {
        final allPresences = await presenceService.getAbsencesByEtudiantIdMock(
            etudiant.id!); // Utiliser la version mock pour l'instant
        absences.assignAll(
            allPresences.where((presence) => presence.typePresence == TypePresence.ABSENT).toList());
      } else {
        print('Aucun étudiant connecté');
      }
    } catch (e) {
      print('Erreur dans _loadAbsences: $e');
      Get.snackbar('Erreur', 'Échec du chargement des absences: $e');
    }
  }
}