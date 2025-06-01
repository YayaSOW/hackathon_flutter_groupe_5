class User {
  final String? id; // Changé de int? à String?
  final String nom;
  final String prenom;
  final String login;
  final String telephone;
  final String password;
  final String? role; // Ajout du champ role

  User({
    this.id,
    required this.nom,
    required this.prenom,
    required this.login,
    required this.telephone,
    required this.password,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id']?.toString(),
        nom: json['nom'] ?? '',
        prenom: json['prenom'] ?? '',
        login: json['login'] ?? '',
        telephone: json['telephone'] ?? '',
        password: json['password'] ?? '',
        role: json['role']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
        'prenom': prenom,
        'login': login,
        'telephone': telephone,
        'password': password,
        'role': role,
      };
}