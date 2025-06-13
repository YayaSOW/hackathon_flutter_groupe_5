import 'dart:convert';
import 'package:ges_absence/app/utils/base_service.dart';
import 'package:ges_absence/env.dart';
import 'package:get/get.dart';
import '../models/cours.dart';
import 'package:http/http.dart' as http;

class CoursService extends GetxService {
  // final String baseUrl = 'http://localhost:3000';
  final String baseUrl = 'https://gesabsences-32iz.onrender.com/api/v1';

  Future<List<Cours>> getAllCours() async {
    try {
      final uri = Uri.parse('$baseUrl/cours');
      print('Requête envoyée à: $uri');
      final response = await http.get(uri);
      print('Réponse brute: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final cours = data.map((json) => Cours.fromJson(json)).toList();
        print('Cours parsés: $cours');
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
