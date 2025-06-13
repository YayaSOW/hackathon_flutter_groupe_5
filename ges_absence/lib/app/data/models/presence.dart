import 'package:ges_absence/app/data/enums/type_presence.dart';
import 'package:ges_absence/app/data/models/user.dart';

class Presence {
  final String? id;
  final DateTime? date;
  final TypePresence typePresence;
  final Map<String, dynamic> etudiant;
  final String cours;
  final String? heureDebut;
  final String? heureFin;
  final User? vigile;
  final Map<String, dynamic>? justification;

  Presence({
    this.id,
    this.date,
    required this.typePresence,
    required this.etudiant,
    required this.cours,
    this.heureDebut,
    this.heureFin,
    this.vigile,
    this.justification,
  });

  factory Presence.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON: $json'); // Débogage
    TypePresence parseTypePresence(String value) {
      switch (value) {
        case 'ABSENT':
          return TypePresence.ABSENT;
        case 'PRESENT':
          return TypePresence.PRESENT;
        case 'RETARD':
          return TypePresence.RETARD;
        default:
          throw ArgumentError('TypePresence inconnu: $value');
      }
    }

    return Presence(
      id: json['id']?.toString(),
      date:
          json['date'] != null ? DateTime.parse(json['date'] as String) : null,
      typePresence: parseTypePresence(json['typePresence'] as String),
      etudiant:
          (json['etudiant'] as Map<String, dynamic>?) ??
          {'id': '', 'nom': '', 'prenom': ''}, // Valeur par défaut
      cours: json['cours'] as String? ?? 'Inconnu',
      heureDebut: json['heureDebut'] as String?,
      heureFin: json['heureFin'] as String?,
      vigile:
          json['vigile'] != null
              ? User.fromJson(json['vigile'] as Map<String, dynamic>)
              : null,
      justification:
          json['justification'] != null
              ? json['justification'] as Map<String, dynamic>
              : null,
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date?.toIso8601String(),
    'typePresence': typePresence.index, // Sauvegarde comme index si besoin
    'etudiant': etudiant,
    'cours': cours,
    'heureDebut': heureDebut,
    'heureFin': heureFin,
    'vigile': vigile?.toJson(),
    'justification': justification,
  };
}
