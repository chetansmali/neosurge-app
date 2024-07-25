import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UploadCancelledChequeParams {
  final Uint8List fileBytes;

  UploadCancelledChequeParams({required this.fileBytes});

  FormData toFormData() {
    return FormData.fromMap({
      "cancel_cheque_file": MultipartFile.fromBytes(
        fileBytes,
        filename: 'cancelled_cheque.jpg',
        contentType: MediaType('image', 'jpg'),
      ),
    });
  }
}
