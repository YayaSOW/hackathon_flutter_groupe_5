class EtudiantOneResponse {
  final String id;
  final String nom;
  final String prenom;
  final String matricule;
  final String classe;
  final bool status;

  EtudiantOneResponse({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.matricule,
    required this.classe,
    required this.status,
  });

  factory EtudiantOneResponse.fromJson(Map<String, dynamic> json) => EtudiantOneResponse(
    id: json['id'],
    nom: json['nom'],
    prenom: json['prenom'],
    matricule: json['matricule'],
    classe: json['classe'],
    status: json['status'],
  );
}