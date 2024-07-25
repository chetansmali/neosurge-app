import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../enums.dart';

class OcrReadParams {
  final DocumentType documentType;
  final File file;

  OcrReadParams({required this.documentType, required this.file});

  Future<FormData> toFormData() async {
    final formData = FormData();
    formData.fields.add(MapEntry('docType', _$DocumentEnumMap[documentType]!));
    formData.files.add(
      MapEntry(
        'file',
        await MultipartFile.fromFile(
          file.path,
          contentType: MediaType('image', 'jpeg'),
          filename: '${_$DocumentEnumMap[documentType]!}.jpg',
        ),
      ),
    );
    return formData;
  }
}

const _$DocumentEnumMap = {
  DocumentType.pan: 'pan',
  DocumentType.aadhar: 'aadhaar',
  DocumentType.passport: 'passport',
  DocumentType.drivingLicense: 'dl',
  DocumentType.voterId: 'voter',
};
