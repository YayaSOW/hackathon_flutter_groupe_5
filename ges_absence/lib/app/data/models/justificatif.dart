import 'package:ges_absence/app/data/models/presence.dart';

class Justificatif {
  final String? id;
  final String motif;
  final bool validation;
  final Presence presence;

  Justificatif({
    this.id,
    required this.motif,
    required this.validation,
    required this.presence,
  });

  factory Justificatif.fromJson(Map<String, dynamic> json) => Justificatif(
        id: json['id'],
        motif: json['motif'],
        validation: json['validation'],
        presence: Presence.fromJson(json['presence']),
      );
}