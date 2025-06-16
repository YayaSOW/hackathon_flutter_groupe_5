class Justificatif {
  final int? id;
  final String motif;
  final bool validation;
  final String presenceId;
  final List<Map<String, String>> justificatif; 

  Justificatif({
    this.id,
    required this.motif,
    required this.validation,
    required this.presenceId,
    required this.justificatif,
  });

  factory Justificatif.fromJson(Map<String, dynamic> json) => Justificatif(
    id: int.parse(json['id'].toString()),
    motif: json['motif'],
    validation: json['validation'],
    presenceId: json['presenceId'],
    justificatif: (json['justificatif'] as List<dynamic>).map((item) => {'url': item['url'] as String}).toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'motif': motif,
    'validation': validation,
    'presenceId': presenceId,
    'justificatif': justificatif,
  };
}