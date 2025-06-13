// lib/env.dart
import 'dart:io';
import 'package:flutter/foundation.dart';

class Env {
  // Plus Besoin c'était pour les mock(db.json)
  static String get baseUrl {
    if (kIsWeb) {
      // Exécution dans un navigateur
      return 'http://localhost:3000';
    } else if (Platform.isAndroid) {
      // Vérifie si on est sur un ÉMULATEUR Android
      final isEmulator = !Platform.environment.containsKey('ANDROID_STORAGE');
      return isEmulator
          ? 'http://10.0.2.2:3000'       // Android Emulator
          : 'http://192.168.43.54:3000'; // Android Physique
    } else if (Platform.isIOS) {
      // iOS Simulator ou physique — souvent localhost marche
      return 'http://localhost:3000';
    } else {
      // Windows, MacOS ou Linux
      return 'http://localhost:3000';
    }
  }
}
