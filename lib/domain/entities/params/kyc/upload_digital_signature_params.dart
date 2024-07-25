import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UploadDigitalSignatureParams {
  final Uint8List imageFileBytes;

  UploadDigitalSignatureParams({required this.imageFileBytes});

  FormData toFormData() {
    FormData formData = FormData();
    MultipartFile file = MultipartFile.fromBytes(imageFileBytes,
        filename: 'signature', contentType: MediaType('image', 'jpg'));

    formData.files.add(
      MapEntry(
        'sign_file',
        file,
      ),
    );
    return formData;
  }
}
