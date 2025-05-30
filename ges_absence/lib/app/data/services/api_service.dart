import 'dart:convert';
import 'package:ges_absence/app/data/models/vigile.dart';
import 'package:ges_absence/base_service.dart';
import 'package:ges_absence/env.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/etudiant.dart';
import '../models/presence.dart';

class ApiService with BaseService{
  // final String baseUrl;

   // ApiService({this.baseUrl = 'http://10.0.2.2:3000'}); 
  // ApiService({this.baseUrl = 'http://172.16.10.163:3000'});
  // ApiService({this.baseUrl = 'http://localhost:3000'});

  // ApiService() : baseUrl = Env.baseUrl;

  Future<Etudiant?> loginEtudiant(String login, String password) async {
    try {
      final uri = Uri.parse('$baseUrl/etudiants?login=$login&password=$password');
      final response = await http.get(uri, headers: {'Accept': 'application/json'});
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
      final response = await http.get(uri, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
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
      final uri = Uri.parse('$baseUrl/presences?etudiant=$etudiantId&_expand=etudiant&_expand=cours');
      print('Requête envoyée à: $uri');
      final response = await http.get(uri);
      print('Réponse brute: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Presence.fromJson(json)).toList();
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
          'justification': {
            'reason': reason,
            'filePath': filePath,
          },
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Erreur lors de la soumission: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de la soumission de la justification: $e');
    }
  }
}