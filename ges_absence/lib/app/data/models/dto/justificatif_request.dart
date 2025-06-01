class JustificatifRequest {
  final String motif;
  final String presenceId;

  JustificatifRequest({required this.motif, required this.presenceId});

  Map<String, dynamic> toJson() => {
    'motif': motif,
    'presenceId': presenceId,
  };
}