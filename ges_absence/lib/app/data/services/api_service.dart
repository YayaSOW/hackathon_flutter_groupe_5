import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/etudiant.dart';
import '../models/presence.dart';
import 'package:ges_absence/app/data/models/vigile.dart';
import 'package:ges_absence/app/data/models/presence.dart';

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

  // Future<List<Presence>> getPresences(String etudiantId) async {
  //   try {
  //     final uri = Uri.parse('$baseUrl/presences?etudiant.id=$etudiantId');
  //     final response = await http.get(uri);

  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = jsonDecode(response.body);
  //       return data.map((json) => Presence.fromJson(json)).toList();
  //     }
  //     return [];
  //   } catch (e) {
  //     print('Erreur récupération présences: ${e.toString()}');
  //     return [];
  //   }
  // }

  Future<Vigile?> loginVigile(String login, String password) async {
    try {
      final uri = Uri.parse('$baseUrl/vigiles');
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final vigile = data.firstWhere(
          (item) => item['login'] == login && item['password'] == password,
          orElse: () => null,
        );
        if (vigile != null) {
          return Vigile.fromJson(vigile);
        }
        print('Aucun vigile trouvé pour ces identifiants');
      } else {
        print('Erreur HTTP: ${response.statusCode}');
      }
      return null;
    } catch (e) {
      print('Erreur lors de la connexion vigile: ${e.toString()}');
      return null;
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
          'typePresence': typePresence,
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

  Future<List<Presence>> getPresences(String etudiantId) async {
    try {
      final uri = Uri.parse('$baseUrl/presences');
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final presences = data
            .where((item) => item['etudiant']['id'] == etudiantId)
            .map((json) => Presence.fromJson(json))
            .toList();
        return presences;
      }
      return [];
    } catch (e) {
      print('Erreur récupération présences: ${e.toString()}');
      return [];
    }
  }
}