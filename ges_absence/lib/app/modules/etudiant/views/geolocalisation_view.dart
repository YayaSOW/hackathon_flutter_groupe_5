import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ges_absence/app/modules/etudiant/controllers/geolocalisation_controller.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:url_launcher/url_launcher.dart';

class GeolocalisationView extends GetView<GeolocalisationController> {
  // Coordonnées de l'ISM (exemple)
  final double latitudeISM = 14.690543;
  final double longitudeISM = -17.457746;

  // Fonction pour lancer Google Maps avec l'itinéraire
  Future<void> _lancerItineraire() async {
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

    final String urlGoogleMaps =
        'https://www.google.com/maps/dir/?api=1&origin=${position.latitude},${position.longitude}&destination=$latitudeISM,$longitudeISM&travelmode=walking';

    final Uri url = Uri.parse(urlGoogleMaps);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Erreur', 'Impossible d\'ouvrir Google Maps');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); 
          },
        ),
        title: const Text('Itinéraire vers ISM'),
        backgroundColor: const Color.fromARGB(255, 243, 142, 33),
      ),
      body: Obx(() {
        if (controller.positionEtudiant.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return FlutterMap(
          options: MapOptions(
            center: latLng.LatLng(
              controller.positionEtudiant.value!.latitude,
              controller.positionEtudiant.value!.longitude,
            ),
            zoom: 14.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: latLng.LatLng(
                    controller.positionEtudiant.value!.latitude,
                    controller.positionEtudiant.value!.longitude,
                  ),
                  child: const Icon(Icons.person_pin_circle, color: Colors.blue, size: 40),
                ),
                Marker(
                  point: const latLng.LatLng(14.690543, -17.457746),
                  child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                ),
              ],
            ),
            PolylineLayer(
              polylines: [
                Polyline(
                  points: controller.polylinePoints,
                  strokeWidth: 4.0,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _lancerItineraire,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.directions_walk),
        tooltip: 'Itinéraire vers ISM',
      ),
    );
  }
}