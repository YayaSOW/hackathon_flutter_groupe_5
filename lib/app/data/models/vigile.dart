class Vigile {
  final String? id;
  final String nom;
  final String prenom;
  final String login;
  final String telephone;
  final String? password;  
  final String? role;      

  Vigile({
    this.id,
    required this.nom,
    required this.prenom,
    required this.login,
    required this.telephone,
    this.password,         
    this.role,             
  });

  factory Vigile.fromJson(Map<String, dynamic> json) => Vigile(
    id: json['id']?.toString(),
    nom: json['nom'],
    prenom: json['prenom'],
    login: json['login'],
    telephone: json['telephone'],
    password: json['password'], 
    role: json['role'],         
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