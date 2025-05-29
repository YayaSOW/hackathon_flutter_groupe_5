class Cours {
  final String? id;
  final DateTime date;
  final String nomCours;
  final int duree;

  Cours({
    this.id,
    required this.date,
    required this.nomCours,
    required this.duree,
  });

  factory Cours.fromJson(Map<String, dynamic> json) => Cours(
        id: json['id'],
        date: DateTime.parse(json['date']),
        nomCours: json['nomCours'],
        duree: json['duree'],
      );
}