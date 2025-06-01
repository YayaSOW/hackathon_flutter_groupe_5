import 'package:ges_absence/app/data/models/classe.dart';
import 'package:ges_absence/app/data/models/user.dart';

class Etudiant extends User {
  final String matricule;
  final Classe? classe; // Changé de String? à Classe?
  final bool status;

  Etudiant({
    required super.id,
    required super.nom,
    required super.prenom,
    required super.login,
    required super.telephone,
    required super.password,
    super.role,
    required this.matricule,
    this.classe,
    required this.status,
  });

  factory Etudiant.fromJson(Map<String, dynamic> json) => Etudiant(
        id: json['id']?.toString(),
        nom: json['nom'] ?? '',
        prenom: json['prenom'] ?? '',
        login: json['login'] ?? '',
        telephone: json['telephone'] ?? '',
        password: json['password'] ?? '',
        role: json['role']?.toString(),
        matricule: json['matricule'] ?? '',
        classe: json['classe'] != null
            ? json['classe'] is String
                ? Classe(
                    id: null,
                    filiere: '',
                    niveau: '',
                    nomClasse: json['classe'] as String,
                    etudiants: null,
                  )
                : Classe.fromJson(json['classe'] as Map<String, dynamic>)
            : null,
        status: json['status'] ?? true,
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'matricule': matricule,
        'classe': classe?.toJson(),
        'status': status,
      };
}