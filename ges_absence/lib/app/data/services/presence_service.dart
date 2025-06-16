import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:ges_absence/app/utils/base_service.dart';
import 'package:ges_absence/env.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PresenceService extends GetxService with BaseService {

  Future<List<Presence>> getAbsencesByEtudiantId(String etudiantId) async {
  try {
    final uri = Uri.parse('$baseUrl/presences?etudiant.id=$etudiantId&_expand=etudiant&_expand=cours');
    print('Requête envoyée à: $uri');
    final response = await http.get(uri);
    print('Réponse brute: ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Presence.fromJson(json)).toList()
          .where((p) => p.typePresence == TypePresence.ABSENT)
          .toList();
    } else {
      print('Erreur HTTP: ${response.statusCode} - ${response.body}');
      return [];
    }
  } catch (e) {
    print('Erreur lors de la récupération des absences: $e');
    return [];
  }
}
}
