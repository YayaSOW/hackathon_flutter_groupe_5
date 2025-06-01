class UserOneResponse {
  final String nom;
  final String prenom;
  final String login;
  final String telephone;

  UserOneResponse({
    required this.nom,
    required this.prenom,
    required this.login,
    required this.telephone,
  });

  factory UserOneResponse.fromJson(Map<String, dynamic> json) => UserOneResponse(
    nom: json['nom'],
    prenom: json['prenom'],
    login: json['login'],
    telephone: json['telephone'],
  );
}