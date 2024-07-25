import 'package:dio/dio.dart';

class DeleteNomineeParams {
  final int nomineeId;

  const DeleteNomineeParams({
    required this.nomineeId,
  });

  // to Json

  FormData toFormData() {
    FormData formData = FormData();
    formData.fields.add(MapEntry("id", nomineeId.toString()));
    return formData;
  }

// from Json

}
