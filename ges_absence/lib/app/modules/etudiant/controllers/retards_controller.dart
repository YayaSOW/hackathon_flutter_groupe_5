import 'package:get/get.dart';
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:ges_absence/app/data/services/api_service.dart';
import 'package:ges_absence/app/modules/auth/controllers/auth_controller.dart';
import 'package:ges_absence/app/data/enums/type_presence.dart';

class RetardsController extends GetxController {
  var retards = <Presence>[].obs; // Liste des présences de type RETARD
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
        print('Chargement des retards pour l\'étudiant ID: ${etudiant.id}'); // Débogage
        final allPresences = await apiService.getPresencesForEtudiant(etudiant.id!.toString());
        retards.assignAll(allPresences.where((presence) => presence.typePresence == TypePresence.RETARD).toList());
        print('Retards chargés: ${retards.length}'); // Débogage
      } else {
        print('Aucun étudiant connecté');
      }
    } catch (e) {
      print('Erreur dans _loadRetards: $e');
      Get.snackbar('Erreur', 'Échec du chargement des retards: $e');
    }
  }
}