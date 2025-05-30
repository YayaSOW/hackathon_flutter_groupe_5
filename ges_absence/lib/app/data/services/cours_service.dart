import 'dart:convert';
import 'package:get/get.dart';
import '../models/cours.dart';
import 'package:http/http.dart' as http;

class CoursService extends GetxService {
  // final String baseUrl = "http://10.0.2.2:3000";
  final String baseUrl = "http://localhost:3000";

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
