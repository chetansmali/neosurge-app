import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UploadProofOfIdentityParams {
  final Uint8List panImageBytes;

  UploadProofOfIdentityParams({
    required this.panImageBytes,
  });

  FormData toFormData() {
    FormData formData = FormData();
    MultipartFile file = MultipartFile.fromBytes(panImageBytes,
        filename: 'pancard', contentType: MediaType('image', 'jpg'));

    formData.files.add(
      MapEntry(
        'pan_file',
        file,
      ),
    );
    return formData;
  }
}
