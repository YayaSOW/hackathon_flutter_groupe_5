import 'package:ges_absence/base_service.dart';
import 'package:ges_absence/env.dart';
import 'package:get/get.dart';
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PresenceService extends GetxService with BaseService {
  // final String baseUrl;
  // final String baseUrl = 'http://10.0.2.2:3000';
  // final String baseUrl = 'http://172.16.10.163:3000';
  // final String baseUrl = 'http://localhost:3000';
  // PresenceService() : baseUrl = Env.baseUrl;

  Future<List<Presence>> getAbsencesByEtudiantId(String etudiantId) async {
    final response = await http.get(Uri.parse('$baseUrl/presences'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data
          .map((json) => Presence.fromJson(json))
          .where((presence) =>
              presence.etudiant.id == etudiantId &&
              presence.typePresence == 0)
          .toList();
    } else {
      throw Exception('Erreur chargement des absences');
    }
  }
}
