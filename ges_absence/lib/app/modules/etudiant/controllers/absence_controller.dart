import 'package:get/get.dart';
import '../../../data/models/presence.dart';
import '../../../data/services/presence_service.dart';

class AbsenceController extends GetxController {
  final PresenceService service = Get.find();
  var absences = <Presence>[].obs;
  var isLoading = true.obs;

  Future<void> fetchAbsences(String etudiantId) async {
    try {
      isLoading.value = true;
      absences.value = await service.getAbsencesByEtudiantId(etudiantId);
    } finally {
      isLoading.value = false;
    }
  }
}
