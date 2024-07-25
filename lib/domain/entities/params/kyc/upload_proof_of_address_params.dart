import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UploadProofOfAddressParams {
  final int proofTypeId;
  final String proofNumber;
  final String? proofIssueDate;
  final String? proofExpiryDate;
  final File proofFrontImage;
  final File proofBackImage;

  UploadProofOfAddressParams({
    required this.proofTypeId,
    required this.proofNumber,
    this.proofIssueDate,
    this.proofExpiryDate,
    required this.proofFrontImage,
    required this.proofBackImage,
  });

  Future<FormData> toFormData() async {
    FormData formData = FormData();
    MultipartFile proofFrontFile = await MultipartFile.fromFile(
        proofFrontImage.path,
        filename: 'proof_front',
        contentType: MediaType('image', 'jpg'));
    MultipartFile proofBackFile = await MultipartFile.fromFile(
        proofBackImage.path,
        filename: 'proof_back',
        contentType: MediaType('image', 'jpg'));

    formData.fields.addAll([
      MapEntry('proof_type_id', proofTypeId.toString()),
      MapEntry('proof_number', proofNumber),
    ]);
    if (proofIssueDate != null) {
      formData.fields.add(
        MapEntry('proof_issue_date', proofIssueDate!),
      );
    }
    if (proofExpiryDate != null) {
      formData.fields.add(
        MapEntry('proof_expiry_date', proofExpiryDate!),
      );
    }
    formData.files.addAll([
      MapEntry('proof_front_file', proofFrontFile),
      MapEntry('proof_back_file', proofBackFile),
    ]);

    return formData;
  }
}
