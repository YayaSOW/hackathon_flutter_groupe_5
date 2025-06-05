import 'package:get/get.dart';
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:ges_absence/app/data/services/api_service.dart';
import 'package:ges_absence/app/modules/auth/controllers/auth_controller.dart';
import 'package:ges_absence/app/data/enums/type_presence.dart';

class RetardsController extends GetxController {
  final ApiService apiService = Get.find();
  RxList<Presence> retards = <Presence>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRetards();
  }

  Future<void> loadRetards() async {
    final etudiantId = Get.find<AuthController>().etudiant.value?.id ?? '';
    final presences = await apiService.getPresencesForEtudiant(etudiantId);
    retards.value = presences.where((p) => p.typePresence == TypePresence.RETARD).toList();
  }
}