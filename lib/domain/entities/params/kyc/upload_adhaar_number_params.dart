class UploadAadhaarNumberParams {
  final String adhaarNum;

  UploadAadhaarNumberParams({
    required this.adhaarNum,
  });

  Map<String, dynamic> toJson() => {
        'aadhar_num': adhaarNum,
      };
}
