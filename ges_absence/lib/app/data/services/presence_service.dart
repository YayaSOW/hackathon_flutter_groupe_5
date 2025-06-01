import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:ges_absence/app/utils/base_service.dart';
import 'package:ges_absence/env.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PresenceService extends GetxService with BaseService {
  // Méthode principale pour récupérer les absences via le backend Spring
  Future<List<Presence>> getAbsencesByEtudiantId(String etudiantId) async {
    try {
      final uri = Uri.parse('$baseUrl/api/v1/presences?etudiant.id=$etudiantId');
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      print('Requête envoyée à: $uri');
      print('Réponse: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 200 && data['results'] != null) {
          final presencesData = data['results'] as List;
          return presencesData
              .map((json) => Presence.fromJson(json))
              .where((presence) => presence.typePresence == TypePresence.ABSENT)
              .toList();
        }
      }
      return [];
    } catch (e) {
      print('Erreur lors de la récupération des absences: $e');
      throw Exception('Erreur chargement des absences: $e');
    }
  }

  // Méthode mock pour json-server
  Future<List<Presence>> getAbsencesByEtudiantIdMock(String etudiantId) async {
  try {
    final uri = Uri.parse('$baseUrl/presences');
    final response = await http.get(uri, headers: {'Accept': 'application/json'});

    print('Requête envoyée à: $uri');
    print('Réponse: ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final presences = data
          .map((json) => Presence.fromJson(json))
          .where((presence) =>
              presence.etudiant?.id == etudiantId &&
              presence.typePresence == TypePresence.ABSENT)
          .toList();
      print('Absences filtrées pour $etudiantId: $presences');
      return presences;
    }
    return [];
  } catch (e) {
    print('Erreur lors de la récupération des absences mock: $e');
    return [];
  }
}
}