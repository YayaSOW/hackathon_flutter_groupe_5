import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:ges_absence/app/data/models/vigile.dart';
import 'package:ges_absence/app/utils/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/etudiant.dart';
import '../models/presence.dart';
import '../models/cours.dart';

class ApiService extends GetxService with BaseService {
  // Méthode de login pour le backend Spring
  Future<Map<String, dynamic>?> login(String login, String password) async {
    try {
      final uri = Uri.parse('$baseUrl/api/v1/auth/login');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'login': login, 'password': password}),
      );

      print('Requête envoyée à: $uri');
      print('Réponse: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 200 && data['results'] != null) {
          final user = data['results'];
          final type = data['type'];

          if (type == 'EtudiantOneResponse') {
            return {'type': 'etudiant', 'user': Etudiant.fromJson(user)};
          } else if (type == 'UserOneResponse') {
            return {'type': 'vigile', 'user': Vigile.fromJson(user)};
          }
        }
      }
      return null;
    } catch (e) {
      print('Erreur lors de la connexion: $e');
      throw Exception('Erreur lors de la connexion: $e');
    }
  }

  // Version mock pour json-server
  Future<Map<String, dynamic>?> loginMock(String login, String password) async {
    try {
      print('Appel loginMock avec login: $login, password: $password');
      // Essayer d'abord avec les étudiants
      final uriEtudiants = Uri.parse('$baseUrl/etudiants?login=$login');
      var response = await http.get(
        uriEtudiants,
        headers: {'Accept': 'application/json'},
      );
      print(
        'Réponse brute de $uriEtudiants: ${response.statusCode} - ${response.body}',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        for (var item in data) {
          print('Vérification étudiant: $item');
          if (item['login'] == login && item['password'] == password) {
            return {'type': 'etudiant', 'user': Etudiant.fromJson(item)};
          }
        }
      }

      // Si pas trouvé, essayer avec les vigiles
      final uriVigiles = Uri.parse('$baseUrl/vigiles?login=$login');
      response = await http.get(
        uriVigiles,
        headers: {'Accept': 'application/json'},
      );
      print(
        'Réponse brute de $uriVigiles: ${response.statusCode} - ${response.body}',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        for (var item in data) {
          print('Vérification vigile: $item');
          if (item['login'] == login && item['password'] == password) {
            return {'type': 'vigile', 'user': Vigile.fromJson(item)};
          }
        }
      }
      return null;
    } catch (e) {
      print('Erreur dans loginMock: $e');
      return null;
    }
  }

  // Récupérer les présences d'un étudiant
  Future<List<Presence>> getPresencesForEtudiantMock(String etudiantId) async {
    try {
      final uri = Uri.parse('$baseUrl/presences');
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      print('Requête envoyée à: $uri');
      print('Réponse: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((json) => Presence.fromJson(json))
            .where((presence) => presence.etudiant?.id == etudiantId)
            .toList();
      }
      return [];
    } catch (e) {
      print('Erreur lors de la récupération des présences mock: $e');
      return [];
    }
  }

  // Récupérer la liste des cours
  Future<List<Cours>> getCours() async {
    try {
      final uri = Uri.parse('$baseUrl/api/v1/cours');
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 200 && data['results'] != null) {
          final coursData = data['results'] as List;
          return coursData.map((json) => Cours.fromJson(json)).toList();
        }
      }
      return [];
    } catch (e) {
      print('Erreur lors de la récupération des cours: $e');
      return [];
    }
  }

  // Version mock pour json-server
  Future<List<Cours>> getCoursMock() async {
    try {
      final uri = Uri.parse('$baseUrl/cours');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Cours.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Erreur lors de la récupération des cours mock: $e');
      return [];
    }
  }

  // Soumettre une justification
  Future<bool> submitJustification({
    required String presenceId,
    required String motif,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/api/v1/justificatifs');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'motif': motif, 'presenceId': presenceId}),
      );

      print('Justification envoyée: ${response.statusCode}');
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Erreur lors de la soumission de la justification: $e');
      return false;
    }
  }

  // Version mock pour json-server
  Future<bool> submitJustificationMock({
    required String presenceId,
    required String motif,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/justificatifs');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'motif': motif,
          'presenceId': presenceId,
          'validation': false,
        }),
      );

      print('Justification mock envoyée: ${response.statusCode}');
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Erreur lors de la soumission de la justification mock: $e');
      return false;
    }
  }

  // Rechercher un étudiant par matricule
  Future<Etudiant?> getEtudiantByMatricule(String matricule) async {
    try {
      final uri = Uri.parse('$baseUrl/api/v1/etudiants/matricule/$matricule');
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 200 && data['results'] != null) {
          return Etudiant.fromJson(data['results']);
        }
      }
      return null;
    } catch (e) {
      print('Erreur lors de la recherche par matricule: $e');
      return null;
    }
  }

  // Version mock pour json-server
  Future<Etudiant?> getEtudiantByMatriculeMock(String matricule) async {
    try {
      final uri = Uri.parse('$baseUrl/etudiants?matricule=$matricule');
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );
      print('dans apiservice:Requête envoyée à: $uri');
      print(
        'dans apiservice:Réponse: ${response.statusCode} - ${response.body}',
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return Etudiant.fromJson(data[0]);
        }
      }
      return null;
    } catch (e) {
      print('Erreur lors de la recherche par matricule mock: $e');
      return null;
    }
  }

  // Enregistrer une présence
  Future<bool> markPresence({
    required String etudiantId,
    required String coursId,
    required TypePresence typePresence,
  }) async {
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
          'cours': {'id': coursId},
          'typePresence': typePresence.name,
          'date': DateTime.now().toIso8601String(),
        }),
      );

      print('Présence enregistrée: ${response.statusCode}');
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Erreur lors de l\'enregistrement de la présence: $e');
      return false;
    }
  }

  // Version mock pour json-server
  Future<bool> markPresenceMock({
    required String etudiantId,
    required String coursId,
    required TypePresence typePresence,
  }) async {
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
          'cours': {'id': coursId},
          'typePresence': typePresence.name,
          'date': DateTime.now().toIso8601String(),
          'justificatifs': [],
          'admin': null,
        }),
      );

      print('Présence mock enregistrée: ${response.statusCode}');
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Erreur lors de l\'enregistrement de la présence mock: $e');
      return false;
    }
  }

  Future<Etudiant?> getEtudiantByQR(String qrData) async {
    try {
      final matricule = qrData.split(' - ').last;
      return await getEtudiantByMatricule(matricule);
    } catch (e) {
      print('Erreur lors de la récupération par QR: $e');
      return null;
    }
  }

  Future<Etudiant?> getEtudiantByQRMock(String qrData) async {
    try {
      final matricule = qrData.split(' - ').last;
      return await getEtudiantByMatriculeMock(matricule);
    } catch (e) {
      print('Erreur lors de la récupération par QR mock: $e');
      return null;
    }
  }
}
