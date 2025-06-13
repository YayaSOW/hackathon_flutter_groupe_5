class Cours {
  final String? id;
  final DateTime date;
  final String nomCours;
  final String heureDebut;
  final String heureFin;

  Cours({
    this.id,
    required this.date,
    required this.nomCours,
    required this.heureDebut,
    required this.heureFin,
  });

  factory Cours.fromJson(Map<String, dynamic> json) {
    return Cours(
      id: json['id'],
      date: DateTime.parse(json['date']),
      nomCours: json['nomCours'],
      heureDebut: json['heureDebut'],
      heureFin: json['heureFin'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'nomCours': nomCours,
    'heureDebut': heureDebut,
    'heureFin': heureFin,
  };
}
