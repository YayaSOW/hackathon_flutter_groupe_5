class Justificatif {
  final String? id;
  final String motif;
  final bool validation;
  final String? presenceId;

  Justificatif({
    this.id,
    required this.motif,
    required this.validation,
    this.presenceId,
  });

  factory Justificatif.fromJson(Map<String, dynamic> json) => Justificatif(
        id: json['id']?.toString(),
        motif: json['motif'] ?? '',
        validation: json['validation'] ?? false,
        presenceId: json['presenceId']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'motif': motif,
        'validation': validation,
        'presenceId': presenceId,
      };
}