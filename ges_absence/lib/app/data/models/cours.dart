import 'package:flutter/material.dart';

class Cours {
  final String? id;
  final String nomCours;
  final DateTime date;
  final TimeOfDay heureDebut;
  final TimeOfDay heureFin;

  Cours({
    this.id,
    required this.nomCours,
    required this.date,
    required this.heureDebut,
    required this.heureFin,
  });

  factory Cours.fromJson(Map<String, dynamic> json) {
    return Cours(
      id: json['id']?.toString(),
      nomCours: json['nomCours'] ?? '',
      date: DateTime.parse(json['date'] as String),
      heureDebut: _parseTimeOfDay(json['heureDebut'] as String),
      heureFin: _parseTimeOfDay(json['heureFin'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nomCours': nomCours,
        'date': date.toIso8601String(),
        'heureDebut':
            '${heureDebut.hour.toString().padLeft(2, '0')}:${heureDebut.minute.toString().padLeft(2, '0')}:00',
        'heureFin':
            '${heureFin.hour.toString().padLeft(2, '0')}:${heureFin.minute.toString().padLeft(2, '0')}:00',
      };

  static TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}