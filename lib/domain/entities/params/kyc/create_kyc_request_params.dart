class CreateKycRequestParams {
  final bool isFinalSubmit;
  final double latitude;
  final double longitude;

  CreateKycRequestParams(
      {required this.isFinalSubmit,
      required this.latitude,
      required this.longitude});

  Map<String, dynamic> toJson() => {
        'isFinalSubmit': isFinalSubmit,
        'latitude': latitude,
        'longitude': longitude,
      };
}
