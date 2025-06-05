import 'package:ges_absence/app/data/models/user.dart';

class Etudiant extends User {
  final String matricule;
  final bool status;
  final String? classe;
  final String? role;

  Etudiant({
    required super.id,
    required super.nom,
    required super.prenom,
    required super.login,
    required super.telephone,
    required super.password,
    required this.matricule,
    required this.status,
    this.classe,
    this.role,
  });

  factory Etudiant.fromJson(Map<String, dynamic> json) => Etudiant(
    id: json['id'].toString(),
    nom: json['nom'],
    prenom: json['prenom'],
    login: json['login'],
    telephone: json['telephone'],
    password: json['password'],
    matricule: json['matricule'],
    status: json['status'],
    classe: json['classe'],
    role: json['role'],
  );
}