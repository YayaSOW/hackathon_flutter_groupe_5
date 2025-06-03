import 'package:flutter/material.dart';

class Cours {
  final int? id;
  final String nomCours;
  final DateTime date;
  final int duree;
  final TimeOfDay heureDebut;
  final TimeOfDay heureFin;

  Cours({
    required this.id,
    required this.nomCours,
    required this.date,
    required this.duree,
    required this.heureDebut,
    required this.heureFin,
  });

  factory Cours.fromJson(Map<String, dynamic> json) {
    return Cours(
      id: json['id'] ?? '',
      // id: int.parse(json['id'].toString()),
      nomCours: json['nomCours'] as String,
      date: DateTime.parse(json['date'] as String),
      duree: json['duree'] as int,
      heureDebut: _parseTimeOfDay(json['heureDebut'] as String),
      heureFin: _parseTimeOfDay(json['heureFin'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nomCours': nomCours,
    'date': date.toIso8601String(),
    'duree': duree,
    'heureDebut': '${heureDebut.hour}:${heureDebut.minute}',
    'heureFin': '${heureFin.hour}:${heureFin.minute}',
  };

  static TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
