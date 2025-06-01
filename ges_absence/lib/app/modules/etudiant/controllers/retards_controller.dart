
// RetardsController.dart
import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:ges_absence/app/data/services/api_service.dart';
import 'package:ges_absence/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RetardsController extends GetxController {
  var retards = <Presence>[].obs;
  final ApiService apiService = Get.find();

  @override
  void onInit() {
    super.onInit();
    _loadRetards();
  }

  Future<void> _loadRetards() async {
    try {
      final etudiant = Get.find<AuthController>().etudiant.value;
      if (etudiant != null) {
        final allPresences = await apiService.getPresencesForEtudiantMock(etudiant.id!); // Utiliser la version mock
        retards.assignAll(
            allPresences.where((presence) => presence.typePresence == TypePresence.RETARD).toList());
      } else {
        print('Aucun étudiant connecté');
      }
    } catch (e) {
      print('Erreur dans _loadRetards: $e');
      Get.snackbar('Erreur', 'Échec du chargement des retards: $e');
    }
  }
}