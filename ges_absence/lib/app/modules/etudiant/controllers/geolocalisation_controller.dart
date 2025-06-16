import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:http/http.dart' as http;
import 'dart:convert';

class GeolocalisationController extends GetxController {
  final positionEtudiant = Rxn<Position>();
  final polylinePoints = <latLng.LatLng>[].obs; // Liste des points de l'itinéraire

  @override
  void onInit() {
    super.onInit();
    _obtenirPosition();
  }

  Future<void> _obtenirPosition() async {
    bool serviceActif = await Geolocator.isLocationServiceEnabled();
    if (!serviceActif) {
      Get.snackbar('Erreur', 'Veuillez activer la localisation');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Erreur', 'Permission de localisation refusée');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Erreur', 'Permission de localisation refusée définitivement');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    positionEtudiant.value = position;

    // Obtenir l'itinéraire après avoir la position
    await _obtenirItineraire(position);
  }

  Future<void> _obtenirItineraire(Position position) async {
    const String apiUrl = 'https://api.openrouteservice.org/v2/directions/foot-walking';
    const String apiKey = '5b3ce3597851110001cf62481f43c7914b8c4638805a577b21dbd58a';
    final String start = '${position.longitude},${position.latitude}'; // lon, lat
    const String end = '-17.457746,14.690543'; // Coordonnées ISM (lon, lat)

    try {
      final response = await http.get(Uri.parse('$apiUrl?api_key=$apiKey&start=$start&end=$end'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> coordinates = data['features'][0]['geometry']['coordinates'];
        polylinePoints.value = coordinates.map((coord) => latLng.LatLng(coord[1], coord[0])).toList();
      } else {
        Get.snackbar('Erreur', 'Impossible de récupérer l\'itinéraire: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors de la récupération de l\'itinéraire: $e');
    }
  }
} 