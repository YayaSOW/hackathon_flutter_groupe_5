// lib/env.dart
import 'dart:io';
import 'package:flutter/foundation.dart';

class Env {
  static String get baseUrl {
    if (kIsWeb) {
      // Exécution dans un navigateur
      return 'http://localhost:3000';
    } else if (Platform.isAndroid) {
      // Vérifie si on est sur un ÉMULATEUR Android
      final isEmulator = !Platform.environment.containsKey('ANDROID_STORAGE');
      return isEmulator
          ? 'http://10.0.2.2:3000'       // Android Emulator
          : 'http://172.16.10.163:3000'; // Android Physique
    } else if (Platform.isIOS) {
      // iOS Simulator ou physique — souvent localhost marche
      return 'http://localhost:3000';
    } else {
      // Windows, MacOS ou Linux
      return 'http://localhost:3000';
    }
  }
}
