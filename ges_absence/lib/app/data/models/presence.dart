import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:ges_absence/app/data/models/cours.dart';
import 'package:ges_absence/app/data/models/etudiant.dart';
import 'package:ges_absence/app/data/models/user.dart';

class Presence {
  final String? id;
  final DateTime date;
  final TypePresence typePresence;
  final Etudiant etudiant;
  final Cours cours;
  final User? vigile;

  Presence({
    this.id,
    required this.date,
    required this.typePresence,
    required this.etudiant,
    required this.cours,
    this.vigile,
  });

  factory Presence.fromJson(Map<String, dynamic> json) {
    return Presence(
      id: json['id']?.toString(),
      date: DateTime.parse(json['date'] as String),
      typePresence: TypePresence.values.firstWhere(
        (e) => e.name == json['typePresence'],
      ),
      etudiant: Etudiant.fromJson(json['etudiant'] as Map<String, dynamic>),
      cours: Cours.fromJson(json['cours'] as Map<String, dynamic>),
      vigile:
          json['vigile'] != null
              ? User.fromJson(json['vigile'] as Map<String, dynamic>)
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'typePresence': typePresence.index,
    'etudiant': etudiant.toJson(),
    'cours': cours.toJson(),
    'vigile': vigile?.toJson(),
  };
}
