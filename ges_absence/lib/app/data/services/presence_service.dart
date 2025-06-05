import 'package:ges_absence/app/utils/base_service.dart';
import 'package:ges_absence/env.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PresenceService extends GetxService with BaseService {
  Future<List<Presence>> getAbsencesByEtudiantId(String etudiantId) async {
    final response = await http.get(Uri.parse('$baseUrl/presences'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data
          .map((json) => Presence.fromJson(json))
          .where(
            (presence) =>
                presence.etudiant['id'].toString() == etudiantId &&
                presence.typePresence.index == 0,
          )
          .toList();
    } else {
      throw Exception('Erreur chargement des absences');
    }
  }
}
