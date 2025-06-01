import 'package:ges_absence/app/data/models/etudiant.dart';

class Classe {
  final String? id;
  final String filiere;
  final String niveau;
  final String nomClasse;
  final List<Etudiant>? etudiants;

  Classe({
    this.id,
    required this.filiere,
    required this.niveau,
    required this.nomClasse,
    this.etudiants,
  });

  factory Classe.fromJson(Map<String, dynamic> json) => Classe(
        id: json['id']?.toString(),
        filiere: json['filiere'] ?? '',
        niveau: json['niveau'] ?? '',
        nomClasse: json['nomClasse'] ?? '',
        etudiants: json['etudiants'] != null
            ? (json['etudiants'] as List)
                .map((e) => Etudiant.fromJson(e as Map<String, dynamic>))
                .toList()
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'filiere': filiere,
        'niveau': niveau,
        'nomClasse': nomClasse,
        'etudiants': etudiants?.map((e) => e.toJson()).toList(),
      };
}

