class GetBankDetailsByIfscParams {
  final String ifscCode;

  GetBankDetailsByIfscParams({required this.ifscCode});

  Map<String, dynamic> toJson() {
    return {
      "ifscCode": ifscCode,
    };
  }
}
