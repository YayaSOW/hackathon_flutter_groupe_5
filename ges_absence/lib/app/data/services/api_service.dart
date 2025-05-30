import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/etudiant.dart';
import '../models/presence.dart';

class ApiService {
  final String baseUrl;

  // ApiService({this.baseUrl = 'http://10.0.2.2:3000'}); 
  ApiService({this.baseUrl = 'http://localhost:3000'}); 

  Future<Etudiant?> loginEtudiant(String login, String password) async {
    try {
      final uri = Uri.parse('$baseUrl/etudiants?login=$login&password=$password');
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );
      // print('Corps de la réponse: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return Etudiant.fromJson(data[0]);
        }
        print('Aucun étudiant trouvé pour ces identifiants');
      } else {
        print('Erreur HTTP: ${response.statusCode}');
      }
      return null;
    } catch (e) {
      print('Erreur lors de la connexion: ${e.toString()}');
      return null;
    }
  }

  Future<List<Presence>> getPresencesForEtudiant(String etudiantId) async {
    try {
      // Utilise _expand pour inclure les relations etudiant et cours
      final uri = Uri.parse('$baseUrl/presences?etudiant=$etudiantId&_expand=etudiant&_expand=cours');
      print('Requête envoyée à: $uri'); // Débogage
      final response = await http.get(uri);
      print('Réponse brute: ${response.body}'); // Débogage
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
}