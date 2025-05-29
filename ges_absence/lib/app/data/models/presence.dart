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

  factory Presence.fromJson(Map<String, dynamic> json) => Presence(
        id: json['id'],
        date: DateTime.parse(json['date']),
        typePresence: TypePresence.values[json['typePresence']],
        etudiant: Etudiant.fromJson(json['etudiant']),
        cours: Cours.fromJson(json['cours']),
        vigile: json['vigile'] != null ? User.fromJson(json['vigile']) : null,
      );
}