import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:ges_absence/app/data/services/api_service.dart';
import 'package:ges_absence/app/modules/auth/controllers/auth_controller.dart';

class AbsencesController extends GetxController {
  final ApiService apiService = Get.find();
  RxList<Presence> absences = <Presence>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAbsences();
  }

  Future<void> loadAbsences() async {
    final etudiantId = Get.find<AuthController>().etudiant.value?.id ?? '';
    final presences = await apiService.getPresencesForEtudiant(etudiantId);
    absences.value = presences.where((p) => p.typePresence == TypePresence.ABSENT).toList();
  }
}