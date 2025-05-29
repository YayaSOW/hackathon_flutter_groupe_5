import 'dart:convert';
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/vigile.dart';

class ApiService extends GetConnect {
  final String baseUrl;

  // ApiService({this.baseUrl = 'http://10.0.2.2:3000'});
  ApiService({this.baseUrl = 'http://localhost:3000'});

 Future<Vigile?> loginVigile(String login, String password) async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/vigiles'));
    
    // print('Réponse de l\'API: ${response.body}');
    
    if (response.statusCode == 200) {
      final List<dynamic> vigilesJson = jsonDecode(response.body);
      // print('Réponse décodée: $vigilesJson');

      for (var vigileJson in vigilesJson) {
        if (vigileJson['login'] == login && vigileJson['password'] == password) {
          return Vigile.fromJson(vigileJson);
        }
      }
    }
    return null;
  } catch (e) {
    print('Erreur lors de la connexion : $e');
    return null;
  }
}


  Future<List<Presence>> getPresencesForVigile(String etudiantId) async {
    try {
      final response = await get('$baseUrl/vigiles/$etudiantId/presences');
      if (response.statusCode == 200) {
        return (response.body as List)
            .map((data) => Presence.fromJson(data))
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}