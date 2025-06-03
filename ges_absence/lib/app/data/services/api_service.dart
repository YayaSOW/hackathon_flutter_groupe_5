import 'dart:convert';
import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:ges_absence/app/data/models/vigile.dart';
import 'package:ges_absence/app/utils/base_service.dart';
import 'package:ges_absence/env.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/etudiant.dart';
import '../models/presence.dart';

class ApiService extends GetxService with BaseService {
  // final String baseUrl;

  // ApiService({this.baseUrl = 'http://10.0.2.2:3000'});
  // ApiService({this.baseUrl = 'http://172.16.10.163:3000'});
  // ApiService({this.baseUrl = 'http://localhost:3000'});

  // ApiService() : baseUrl = Env.baseUrl;

  Future<Map<String, dynamic>?> login(String login, String password) async {
    try {
      final uri = Uri.parse('$baseUrl/api/v1/auth/login');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'login': login, 'password': password}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final results = data['results'];

        final user = results['user'];
        final role = user['role'];
        final token = results['token'];

        return {'type': role, 'user': user, 'token': token};
      } else {
        print('Erreur login: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erreur dans apiService.login(): $e');
      return null;
    }
  }

  Future<List<Presence>> getPresencesForEtudiant(String etudiantId) async {
    try {
      final uri = Uri.parse('$baseUrl/api/v1/presences/etudiant/$etudiantId');
      print('Requête envoyée à: $uri');
      final response = await http.get(uri);
      print('Réponse brute: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final presences = data.map((json) => Presence.fromJson(json)).toList();
        print('Présences parsées: ${presences.map((p) => p.toJson())}');
        return presences;
      } else {
        print('Erreur HTTP: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      print('Erreur lors de la récupération des présences: $e');
      return [];
    }
  }

  Future<void> submitJustification({
    required String presenceId,
    required String reason,
    required String filePath,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/presences/$presenceId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'justification': {'reason': reason, 'filePath': filePath},
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Erreur lors de la soumission: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de la soumission de la justification: $e');
    }
  }

  Future<Etudiant?> getEtudiantByQR(String qrData) async {
    try {
      final matricule = qrData.split(' - ').last;
      return await getEtudiantByMatricule(matricule);
    } catch (e) {
      print('Erreur lors de la récupération par QR: ${e.toString()}');
      return null;
    }
  }

  Future<Etudiant?> getEtudiantByMatricule(String matricule) async {
    try {
      final uri = Uri.parse('$baseUrl/api/v1/etudiants/matricule/$matricule');
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final etudiant = data.firstWhere(
          (item) => item['matricule'] == matricule,
          orElse: () => null,
        );
        if (etudiant != null) {
          return Etudiant.fromJson(etudiant);
        }
        print('Aucun étudiant trouvé pour ce matricule');
      } else {
        print('Erreur HTTP: ${response.statusCode}');
      }
      return null;
    } catch (e) {
      print('Erreur lors de la recherche par matricule: ${e.toString()}');
      return null;
    }
  }

  Future<void> markPresence(String etudiantId, String typePresence) async {
    try {
      final uri = Uri.parse('$baseUrl/api/v1/presences');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'etudiant': {'id': etudiantId},
          'typePresence':
              TypePresence.values
                  .firstWhere((e) => e.name == typePresence)
                  .index,
          'date': DateTime.now().toIso8601String(),
        }),
      );
      if (response.statusCode == 201) {
        print('Présence enregistrée avec succès');
      } else {
        print('Erreur HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de l\'enregistrement de la présence: ${e.toString()}');
    }
  }
}
