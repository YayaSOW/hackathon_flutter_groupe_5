import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:ges_absence/app/data/models/cours.dart';
import 'package:ges_absence/app/data/models/etudiant.dart';
import 'package:ges_absence/app/data/models/user.dart';
import 'package:ges_absence/app/data/models/justificatif.dart';

class Presence {
  final String? id;
  final DateTime date;
  final TypePresence typePresence;
  final Etudiant? etudiant;
  final Cours? cours;
  final User? admin;
  final List<Justificatif>? justificatifs;

  Presence({
    this.id,
    required this.date,
    required this.typePresence,
    this.etudiant,
    this.cours,
    this.admin,
    this.justificatifs,
  });

  factory Presence.fromJson(Map<String, dynamic> json) {
    return Presence(
      id: json['id']?.toString(),
      date: DateTime.parse(json['date'] as String),
      typePresence: TypePresence.values.firstWhere(
        (e) => e.name == json['typePresence'],
        orElse: () => TypePresence.ABSENT,
      ),
      etudiant: json['etudiant'] != null
          ? Etudiant.fromJson(json['etudiant'] as Map<String, dynamic>)
          : null,
      cours: json['cours'] != null
          ? Cours.fromJson(json['cours'] as Map<String, dynamic>)
          : null,
      admin: json['admin'] != null
          ? User.fromJson(json['admin'] as Map<String, dynamic>)
          : null,
      justificatifs: json['justificatifs'] != null
          ? (json['justificatifs'] as List)
              .map((j) => Justificatif.fromJson(j as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'typePresence': typePresence.name,
        'etudiant': etudiant?.toJson(),
        'cours': cours?.toJson(),
        'admin': admin?.toJson(),
        'justificatifs': justificatifs?.map((j) => j.toJson()).toList(),
      };
}