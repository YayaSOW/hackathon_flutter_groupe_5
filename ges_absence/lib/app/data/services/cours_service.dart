import 'dart:convert';
import 'package:ges_absence/base_service.dart';
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

  Future<List<Cours>> fetchCours() async {
    final response = await http.get(Uri.parse('$baseUrl/cours'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Cours.fromJson(e)).toList();
    } else {
      throw Exception("Erreur lors du chargement des cours");
    }
  }
}
