import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:flutter/material.dart'; // For LocalDateTime

class PresenceAllResponse {
  final DateTime date;
  final String cours; 
  final TypePresence typePresence;

  PresenceAllResponse({
    required this.date,
    required this.cours,
    required this.typePresence,
  });

  factory PresenceAllResponse.fromJson(Map<String, dynamic> json) => PresenceAllResponse(
    date: DateTime.parse(json['date'] as String),
    cours: json['cours'] as String,
    typePresence: TypePresence.values.firstWhere((e) => e.toString().split('.').last == json['typePresence']),
  );
}