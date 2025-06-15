class Etudiant {
  final String? id;
  final String? nom;
  final String? prenom;
  final String? matricule;
  final String? classe;
  final bool? status;
  final String? role;
  final String? typePresence;
  final String? cours;
  final String? heureDebut;
  final String? heureFin;

  Etudiant({
    this.id,
    this.nom,
    this.prenom,
    this.matricule,
    this.classe,
    this.status,
    this.role,
    this.typePresence,
    this.cours,
    this.heureDebut,
    this.heureFin,
  });

  factory Etudiant.fromJson(Map<String, dynamic> json) => Etudiant(
       
    id: json['id']?.toString(),
    nom: json['nom'] as String?,
    prenom: json['prenom'] as String?,
    matricule: json['matricule'] as String?,
    classe: json['classe'] as String?,
    status: json['status'] as bool?, 
    role: json['role'] as String?,
    typePresence: json['typePresence']?.toString(),
    cours: json['cours'] as String?,
    heureDebut: json['heureDebut'] as String?,
    heureFin: json['heureFin'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nom': nom,
    'prenom': prenom,
    'matricule': matricule,
    'classe': classe,
    'status': status,
    'role': role,
    'typePresence': typePresence,
    'cours': cours,
    'heureDebut': heureDebut,
    'heureFin': heureFin,
  };
}