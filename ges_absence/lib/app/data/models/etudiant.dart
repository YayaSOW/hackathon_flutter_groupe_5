class Etudiant {
  final String? id;
  final String nom;
  final String prenom;
  final String matricule;
  final String? classe;
  final bool status;
  final String? role;

  Etudiant({
    this.id,
    required this.nom,
    required this.prenom,
    required this.matricule,
    this.classe,
    required this.status,
    this.role,
  });

  factory Etudiant.fromJson(Map<String, dynamic> json) => Etudiant(
    id: json['id']?.toString(),
    nom: json['nom'],
    prenom: json['prenom'],
    matricule: json['matricule'],
    classe: json['classe'],
    status: json['status'],
    role: json['role'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nom': nom,
    'prenom': prenom,
    'matricule': matricule,
    'classe': classe,
    'status': status,
    'role': role,
  };
}