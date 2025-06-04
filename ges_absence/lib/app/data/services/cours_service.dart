import 'dart:convert';
import 'package:ges_absence/app/utils/base_service.dart';
import 'package:ges_absence/env.dart';
import 'package:get/get.dart';
import '../models/cours.dart';
import 'package:http/http.dart' as http;

class CoursService extends GetxService with BaseService {
  // final String baseUrl;
  // final String baseUrl = "http://10.0.2.2:3000";
  // final String baseUrl = 'http://172.16.10.163:3000';
  // final String baseUrl = "http://localhost:3000";
  // CoursService() : baseUrl = Env.baseUrl;

  /*Future<List<Cours>> fetchCours(String etudiantId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/cours/etudiant/$etudiantId'),
    );
    print('Réponse brute: ${response.body}');
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Cours.fromJson(e)).toList();
    } else {
      throw Exception("Erreur lors du chargement des cours");
    }
  }*/

  Future<List<Cours>> fetchCours(String etudiantId) async {
    try {
      final uri = Uri.parse('$baseUrl/api/v1/cours/etudiant/$etudiantId');
      final response = await http.get(uri);
      print('Réponse brute: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> coursList = json['results'];

        final cours = coursList.map((e) => Cours.fromJson(e)).toList();
        print('Cours parsés: ${cours.map((c) => c.toJson())}');
        return cours;
      } else {
        print('Erreur HTTP: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      print('Erreur lors de la récupération des cours: $e');
      return [];
    }
  }
}
