// lib/env.dart
import 'dart:io';
import 'package:flutter/foundation.dart';

class Env {
  static String get baseUrl {
    if (kIsWeb) {
      // Exécution dans un navigateur
      return 'https://gesabsences-32iz.onrender.com';
    } else if (Platform.isAndroid) {
      // Vérifie si on est sur un ÉMULATEUR Android
      final isEmulator = !Platform.environment.containsKey('ANDROID_STORAGE');
      return isEmulator
          ? 'https://gesabsences-32iz.onrender.com' // Android Emulator
          : 'https://gesabsences-32iz.onrender.com'; // Android Physique
    } else if (Platform.isIOS) {
      // iOS Simulator ou physique — souvent localhost marche
      return 'https://gesabsences-32iz.onrender.com';
    } else {
      // Windows, MacOS ou Linux
      return 'https://gesabsences-32iz.onrender.com';
    }
  }
}
