import 'dart:convert';
import 'package:ges_absence/app/data/models/presence.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/vigile.dart';

class ApiService extends GetConnect {
  final String baseUrl;

  ApiService({this.baseUrl = 'http://localhost:3000'});

  Future<Vigile?> loginVigile(String login, String password) async {
    try {
      final response = await post(
        '$baseUrl/auth/login',
        {'login': login, 'password': password},
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return Vigile.fromJson(response.body);
      }
      return null;
    } catch (e) {
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