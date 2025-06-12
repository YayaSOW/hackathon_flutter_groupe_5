class User {
  final String? id;
  final String nom;
  final String prenom;
  final String? login;
  final String? telephone;
  final String? password;

  User({
    this.id,
    required this.nom,
    required this.prenom,
    this.login,
    this.telephone,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id']?.toString(),
        nom: json['nom'],
        prenom: json['prenom'],
        login: json['login'],
        telephone: json['telephone'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
        'prenom': prenom,
        'login': login,
        'telephone': telephone,
        'password': password,
      };
}