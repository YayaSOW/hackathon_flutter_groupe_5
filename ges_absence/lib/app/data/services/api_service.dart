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

  Future<Etudiant?> loginEtudiant(String login, String password) async {
    try {
      final uri = Uri.parse(
        '$baseUrl/etudiants?login=$login&password=$password',
      );
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return Etudiant.fromJson(data[0]);
        }
      }
      return null;
    } catch (e) {
      print('Erreur lors de la connexion étudiant: $e');
      return null;
    }
  }

  Future<Vigile?> loginVigile(String login, String password) async {
    try {
      final uri = Uri.parse('$baseUrl/vigiles?login=$login&password=$password');
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );
      print('Requête envoyée à: $uri');
      print('Réponse brute: ${response.body}');
      if (response.statusCode == 200) {
        print('Réponse reçue: ${response.body}');
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          print('Vigile trouvé: ${data[0]}');
          print('Vigile JSON: ${Vigile.fromJson(data[0])}');
          return Vigile.fromJson(data[0]);
        }
      }
      return null;
    } catch (e) {
      print('Erreur lors de la connexion vigile: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> login(String login, String password) async {
    try {
      final etudiant = await loginEtudiant(login, password);
      if (etudiant != null) {
        return {'type': 'etudiant', 'user': etudiant};
      }

      final vigile = await loginVigile(login, password);
      if (vigile != null) {
        return {'type': 'vigile', 'user': vigile};
      }

      return null;
    } catch (e) {
      throw Exception('Erreur lors de la connexion: $e');
    }
  }

  Future<List<Presence>> getPresencesForEtudiant(String etudiantId) async {
    try {
      final uri = Uri.parse(
        '$baseUrl/presences?etudiant.id=$etudiantId&_expand=etudiant&_expand=cours',
      );
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
      final uri = Uri.parse('$baseUrl/etudiants');
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
      final uri = Uri.parse('$baseUrl/presences');
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
