import 'package:dio/dio.dart';

class UpdatePrimaryBankParams {
  final int bankId;

  UpdatePrimaryBankParams({
    required this.bankId,
  });

  FormData toFormData() {
    return FormData.fromMap({
      'id': bankId,
    });
  }
}
