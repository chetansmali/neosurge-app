import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class PostSupportEmailParams {
  final String category;
  final String querydescription;
  final List<File> imageslist;

  PostSupportEmailParams({
    required this.category,
    required this.querydescription,
    required this.imageslist,
  });

  Future<FormData> toFormData() async {
    FormData formData = FormData();

    for (int i = 0; i < imageslist.length; i++) {
      File image = imageslist[i];
      MultipartFile imageFile = await MultipartFile.fromFile(
        image.path,
        filename: 'imagelist_$i',
        contentType: MediaType('image', 'jpg'),
      );
      formData.files.add(MapEntry('attachments', imageFile));
    }

    formData.fields.add(
      MapEntry('category', category),
    );
      formData.fields.add(
      MapEntry('concern', querydescription),
    );
  
    return formData;
  }
}
