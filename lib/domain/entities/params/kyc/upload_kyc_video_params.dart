import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UploadKycVideoParams {
  final Uint8List kycVideoBytes;

  const UploadKycVideoParams({required this.kycVideoBytes});

  FormData toFormData() {
    FormData formData = FormData.fromMap({
      "video_file": MultipartFile.fromBytes(kycVideoBytes,
          filename: 'kyc_video', contentType: MediaType('video', 'mp4')),
    });
    return formData;
  }
}
