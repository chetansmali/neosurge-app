import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UploadSelfieParams {
  final File selfieImage;

  UploadSelfieParams({
    required this.selfieImage,
  });

  Future<FormData> toFormData() async {
    FormData formData = FormData();
    MultipartFile file = await MultipartFile.fromFile(selfieImage.path,
        filename: 'selfie', contentType: MediaType('image', 'jpg'));

    formData.files.add(
      MapEntry(
        'profile_file',
        file,
      ),
    );
    return formData;
  }
}
