import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UpdateProfilePhotoParams {
  final File? image;

  UpdateProfilePhotoParams(this.image);

  Future<FormData> get formData async => FormData.fromMap({
        'profile_photo': image == null
            ? null
            : await MultipartFile.fromFile(image!.path,
                contentType: MediaType('image', image!.path.split('.').last)),
      });
}
