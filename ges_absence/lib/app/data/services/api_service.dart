import 'dart:convert';
import 'dart:io';
import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:ges_absence/app/data/models/cours.dart';
import 'package:ges_absence/app/data/models/vigile.dart';
import 'package:ges_absence/app/utils/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import '../models/etudiant.dart';
import '../models/presence.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService extends GetxService with BaseService {
  final storage = FlutterSecureStorage();
  // final String baseUrl = 'https://gesabsences-32iz.onrender.com/api/v1';
  // final String baseUrl;

  // ApiService({this.baseUrl = 'http://10.0.2.2:3000'});
  // ApiService({this.baseUrl = 'http://172.16.10.163:3000'});
  // ApiService({this.baseUrl = 'http://localhost:3000'}); https://gesabsences-32iz.onrender.com/api/v1

  // ApiService() : baseUrl = Env.baseUrl;

  // Future<Etudiant?> loginEtudiant(String login, String password) async {
  //   try {
  //     final uri = Uri.parse(
  //       '$baseUrl/etudiants?login=$login&password=$password',
  //     );
  //     final response = await http.get(
  //       uri,
  //       headers: {'Accept': 'application/json'},
  //     );
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = jsonDecode(response.body);
  //       if (data.isNotEmpty) {
  //         return Etudiant.fromJson(data[0]);
  //       }
  //     }
  //     return null;
  //   } catch (e) {
  //     print('Erreur lors de la connexion étudiant: $e');
  //     return null;
  //   }
  // }

  // Future<Vigile?> loginVigile(String login, String password) async {
  //   try {
  //     final uri = Uri.parse('$baseUrl/vigiles?login=$login&password=$password');
  //     final response = await http.get(
  //       uri,
  //       headers: {'Accept': 'application/json'},
  //     );
  //     print('Requête envoyée à: $uri');
  //     print('Réponse brute: ${response.body}');
  //     if (response.statusCode == 200) {
  //       print('Réponse reçue: ${response.body}');
  //       final List<dynamic> data = jsonDecode(response.body);
  //       if (data.isNotEmpty) {
  //         print('Vigile trouvé: ${data[0]}');
  //         print('Vigile JSON: ${Vigile.fromJson(data[0])}');
  //         return Vigile.fromJson(data[0]);
  //       }
  //     }
  //     return null;
  //   } catch (e) {
  //     print('Erreur lors de la connexion vigile: $e');
  //     return null;
  //   }
  // }

  // Future<Map<String, dynamic>?> login(String login, String password) async {
  //   try {
  //     final etudiant = await loginEtudiant(login, password);
  //     if (etudiant != null) {
  //       return {'type': 'etudiant', 'user': etudiant};
  //     }

  //     final vigile = await loginVigile(login, password);
  //     if (vigile != null) {
  //       return {'type': 'vigile', 'user': vigile};
  //     }

  //     return null;
  //   } catch (e) {
  //     throw Exception('Erreur lors de la connexion: $e');
  //   }
  // }
  // Future<Map<String, dynamic>?> login(String login, String password) async {
  //   try {
  //     final uri = Uri.parse('https://gesabsences-32iz.onrender.com/api/v1/auth/login');
  //     final response = await http.post(
  //       uri,
  //       headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  //       body: jsonEncode({'login': login, 'password': password}),
  //     );
  //     print('Requête envoyée à: $uri');
  //     print('Réponse brute: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       final results = data['results'] as Map<String, dynamic>;
  //       final userData = results['user'] as Map<String, dynamic>;
  //       final token = results['token'] as String;

  //       // Stocker le token de manière sécurisée
  //       await storage.write(key: 'jwt_token', value: token);

  //       // Déterminer si c'est un Etudiant ou un Vigile (basé sur le rôle)
  //       if (userData['role'] == 'ETUDIANT') {
  //         return {
  //           'type': 'etudiant',
  //           'user': Etudiant.fromJson(userData),
  //         };
  //       } else {
  //         return {
  //           'type': 'vigile',
  //           'user': Vigile.fromJson(userData),
  //         };
  //       }
  //     } else {
  //       print('Erreur HTTP: ${response.statusCode} - ${response.body}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Erreur lors de la connexion: $e');
  //     return null;
  //   }
  // }
  Future<Map<String, dynamic>?> login(String login, String password) async {
    try {
      final uri = Uri.parse(
        'https://gesabsences-32iz.onrender.com/api/v1/auth/login',
      );
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'login': login, 'password': password}),
      );
      print('Requête envoyée à: $uri');
      print('Réponse brute: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        print('Données décodées: $data');
        final results = data['results'] as Map<String, dynamic>? ?? {};
        print('Résultats: $results');
        final userData = results['user'] as Map<String, dynamic>? ?? {};
        print('Utilisateur: $userData');
        final token = results['token'] as String?;

        if (token == null) {
          print('Erreur: Token manquant dans la réponse');
          return null;
        }

        // Stocker le token de manière sécurisée
        await storage.write(key: 'jwt_token', value: token);
        print('Token stocké: $token');

        // Déterminer si c'est un Etudiant ou un Vigile (basé sur le rôle)
        final role = userData['role'] as String?;
        print('Rôle détecté: $role');
        if (role == 'ETUDIANT') {
          return {'type': 'etudiant', 'user': Etudiant.fromJson(userData)};
        } else {
          return {'type': 'vigile', 'user': Vigile.fromJson(userData)};
        }
      } else {
        print('Erreur HTTP: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erreur lors de la connexion: $e');
      return null;
    }
  }

  // Future<List<Presence>> getPresencesForEtudiant(String etudiantId) async {
  //   try {
  //     final uri = Uri.parse(
  //       '$baseUrl/presences?etudiant.id=$etudiantId&_expand=etudiant&_expand=cours',
  //     );
  //     print('Requête envoyée à: $uri');
  //     final response = await http.get(uri);
  //     print('Réponse brute: ${response.body}');
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = jsonDecode(response.body);
  //       final presences = data.map((json) => Presence.fromJson(json)).toList();
  //       print('Présences parsées: ${presences.map((p) => p.toJson())}');
  //       return presences;
  //     } else {
  //       print('Erreur HTTP: ${response.statusCode} - ${response.body}');
  //       return [];
  //     }
  //   } catch (e) {
  //     print('Erreur lors de la récupération des présences: $e');
  //     return [];
  //   }
  // }
  Future<List<Presence>> getPresencesForEtudiant(String etudiantId) async {
    try {
      final uri = Uri.parse(
        '$baseUrl/presences?etudiant.id=$etudiantId&_expand=etudiant&_expand=cours',
      );
      print('Requête envoyée à: $uri');
      final response = await http.get(uri);
      print('Réponse brute: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final presences = data.map((json) => Presence.fromJson(json)).toList();
        print('Présences parsées: ${presences.map((p) => p.toJson())}');
        return presences;
      } else {
        print('Erreur HTTP: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      print('Erreur lors de la récupération des présences: $e');
      return [];
    }
  }

  // Nouvelle méthode pour récupérer les cours d'un étudiant
  Future<List<Cours>> getCoursForEtudiant(
    String etudiantId, {
    DateTime? date,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/cours/etudiant/$etudiantId').replace(
        queryParameters: {
          'date': date?.toIso8601String().split('T')[0], // Format YYYY-MM-DD
        },
      );
      print('Requête envoyée à: $uri');
      final response = await http.get(uri);
      print('Réponse brute: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> results = data['results'] as List<dynamic>? ?? [];
        return results.map((json) => Cours.fromJson(json)).toList();
      } else {
        print('Erreur HTTP: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      print('Erreur lors de la récupération des cours: $e');
      return [];
    }
  }

  // Nouvelle méthode pour récupérer les présences par type et étudiant
  Future<List<Presence>> getPresencesByTypeAndEtudiant(
    String etudiantId,
    String typePresence,
  ) async {
    try {
      final uri = Uri.parse(
        '$baseUrl/presences/type=$typePresence/etudiant/$etudiantId',
      );
      print('Requête envoyée à: $uri');
      final response = await http.get(uri);
      print('Réponse brute: ${response.body}');
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(
          response.body,
        ); // Utilisons dynamic pour déboguer
        print('Data décodée (type): ${data.runtimeType}, valeur: $data');
        if (data is! Map<String, dynamic>) {
          print('Data n\'est pas un Map, retour liste vide');
          return [];
        }
        final dynamic resultsRaw = data['results'];
        print(
          'Results raw (type): ${resultsRaw.runtimeType}, valeur: $resultsRaw',
        );
        if (resultsRaw == null) {
          print('Résultats null, retour liste vide');
          return [];
        }
        final Map<String, dynamic>? results =
            resultsRaw as Map<String, dynamic>?;
        if (results == null) {
          print('Résultats non castable en Map, retour liste vide');
          return [];
        }
        final dynamic presencesData = results['presences'];
        print(
          'Presences data (type): ${presencesData.runtimeType}, valeur: $presencesData',
        );
        if (presencesData == null) {
          print('Presences null, retour liste vide');
          return [];
        }
        if (presencesData is! List) {
          print('Presences n\'est pas une liste, retour liste vide');
          return [];
        }
        final List<dynamic> presencesList = presencesData as List<dynamic>;
        final List<Presence> presences =
            presencesList.map((json) {
              print('Parsing presence JSON: $json');
              return Presence.fromJson(json as Map<String, dynamic>);
            }).toList();
        print('Présences parsées: $presences');
        return presences;
      } else {
        print('Erreur HTTP: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      print('Erreur lors de la récupération des présences: $e');
      return [];
    }
  }

  // Future<void> submitJustification({
  //   required String presenceId,
  //   required String reason,
  //   required List<String> filePaths, // Liste de chemins de fichiers
  // }) async {
  //   try {
  //     final uri = Uri.parse('$baseUrl/presences/$presenceId');
  //     final response = await http.patch(
  //       uri,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         'justification': {
  //           'reason': reason,
  //           'files': filePaths, // Envoie une liste de chemins
  //         },
  //       }),
  //     );

  //     print('Requête envoyée à: $uri');
  //     print('Réponse: ${response.statusCode} - ${response.body}');

  //     if (response.statusCode != 200) {
  //       throw Exception(
  //         'Erreur lors de la soumission: ${response.statusCode} - ${response.body}',
  //       );
  //     }
  //   } catch (e) {
  //     print('Erreur lors de la soumission de la justification: $e');
  //     throw Exception('Erreur lors de la soumission de la justification: $e');
  //   }
  // }
  // Future<void> submitJustification({
  //   required String presenceId,
  //   required String reason,
  //   required List<String> filePaths,
  // }) async {
  //   try {
  //     final uri = Uri.parse('$baseUrl/presences/$presenceId');
  //     final justificatif =
  //         filePaths
  //             .map((path) => {"url": "http://localhost:3000/uploads/$path"})
  //             .toList(); // Simuler des URLs
  //     final response = await http.patch(
  //       uri,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         'justification': {'motif': reason, 'justificatif': justificatif},
  //       }),
  //     );

  //     print('Requête envoyée à: $uri');
  //     print('Réponse: ${response.statusCode} - ${response.body}');

  //     if (response.statusCode != 200) {
  //       throw Exception(
  //         'Erreur lors de la soumission: ${response.statusCode} - ${response.body}',
  //       );
  //     }
  //   } catch (e) {
  //     print('Erreur lors de la soumission de la justification: $e');
  //     throw Exception('Erreur lors de la soumission de la justification: $e');
  //   }
  // }
  Future<void> submitJustification({
    required String presenceId,
    required String reason,
    required List<File> files,
  }) async {
    try {
      var uri = Uri.parse('$baseUrl/justificatifs/create');
      var request = http.MultipartRequest('POST', uri);

      // Ajouter les en-têtes
      request.headers['Content-Type'] = 'multipart/form-data';

      // Ajouter les champs texte
      request.fields['motif'] = reason;
      request.fields['presenceId'] = presenceId;

      // Ajouter les fichiers avec détection dynamique du type MIME
      for (var file in files) {
        String fileExtension = file.path.split('.').last.toLowerCase();
        MediaType? mediaType;
        switch (fileExtension) {
          case 'jpg':
          case 'jpeg':
            mediaType = MediaType('image', 'jpeg');
            break;
          case 'png':
            mediaType = MediaType('image', 'png');
            break;
          default:
            mediaType = MediaType(
              'application',
              'octet-stream',
            ); // Type générique si inconnu
            break;
        }

        var multipartFile = await http.MultipartFile.fromPath(
          'multipartFiles',
          file.path,
          contentType: mediaType,
        );
        request.files.add(multipartFile);
      }

      print('Requête envoyée à: $uri');
      print('Corps de la requête: ${request.fields}');

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print('Réponse: ${response.statusCode} - $responseBody');

      if (response.statusCode != 201) {
        throw Exception(
          'Erreur lors de la soumission: ${response.statusCode} - $responseBody',
        );
      }
    } catch (e) {
      print('Erreur lors de la soumission de la justification: $e');
      throw Exception('Erreur lors de la soumission de la justification: $e');
    }
  }

 Future<Etudiant?> getEtudiantByQR(String code) async {
  try {
    final uri = Uri.parse('$baseUrl/presences/etudiant/$code');
    final response = await http.get(
      uri,
      headers: {'Accept': 'application/json'},
    );
    print('Requête envoyée à: $uri');
    print('Réponse brute: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic>? results = data['results'];
      if (results != null) {
        return Etudiant.fromJson(results);
      }
      print('Aucun étudiant trouvé pour ce QR code');
    } else {
      print('Erreur HTTP: ${response.statusCode} - ${response.body}');
    }
    return null;
  } catch (e) {
    print('Erreur lors de la recherche par QR code: ${e.toString()}');
    return null;
  }
}

  // Future<Etudiant?> getEtudiantByMatricule(String matricule) async {
  //   try {
  //     final uri = Uri.parse('$baseUrl/etudiants');
  //     final response = await http.get(
  //       uri,
  //       headers: {'Accept': 'application/json'},
  //     );
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = jsonDecode(response.body);
  //       final etudiant = data.firstWhere(
  //         (item) => item['matricule'] == matricule,
  //         orElse: () => null,
  //       );
  //       if (etudiant != null) {
  //         return Etudiant.fromJson(etudiant);
  //       }
  //       print('Aucun étudiant trouvé pour ce matricule');
  //     } else {
  //       print('Erreur HTTP: ${response.statusCode}');
  //     }
  //     return null;
  //   } catch (e) {
  //     print('Erreur lors de la recherche par matricule: ${e.toString()}');
  //     return null;
  //   }
  // }
Future<Etudiant?> getEtudiantByMatricule(String matricule) async {
  try {
    final uri = Uri.parse('$baseUrl/presences/etudiant/$matricule');
    final response = await http.get(
      uri,
      headers: {'Accept': 'application/json'},
    );
    print('Requête envoyée à: $uri');
    print('Réponse brute: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic>? results = data['results'];
      if (results != null) {
        return Etudiant.fromJson(results); // Parsage du résultat
      }
      print('Aucun étudiant trouvé pour ce matricule');
    } else {
      print('Erreur HTTP: ${response.statusCode} - ${response.body}');
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
          'typePresence':
              TypePresence.values
                  .firstWhere((e) => e.name == typePresence)
                  .index,
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
}
