import 'package:ges_absence/app/data/models/user.dart';

class Vigile extends User {
  Vigile({
    required super.id,
    required super.nom,
    required super.prenom,
    required super.login,
    required super.telephone,
    required super.password,
  });

  factory Vigile.fromJson(Map<String, dynamic> json) => Vigile(
    // id: json['id'],/
    id: int.parse(json['id'].toString()),

    nom: json['nom'],
    prenom: json['prenom'],
    login: json['login'],
    telephone: json['telephone'],
    password: json['password'],
  );
}
