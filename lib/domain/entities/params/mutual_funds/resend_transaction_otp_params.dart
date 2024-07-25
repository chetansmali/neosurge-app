import 'package:dio/dio.dart';

import '../../enums.dart';

class ResendTransactionOtpParams {
  final int userId;
  final int id;

  final MFTransactionTypes transactionType;

  ResendTransactionOtpParams({
    required this.userId,
    required this.id,
    required this.transactionType,
  });

  FormData get toFormData => FormData.fromMap({
        'userId': userId,
        'id': id,
        'transactionTypeId': _$MFTransactionTypesEnumMap[transactionType],
      });
}

const _$MFTransactionTypesEnumMap = {
  MFTransactionTypes.lumpsum: 1,
  MFTransactionTypes.sip: 2,
  MFTransactionTypes.redemption: 3,
  MFTransactionTypes.switchTransaction: 4,
  MFTransactionTypes.stp: 5,
  MFTransactionTypes.swp: 6,
  MFTransactionTypes.stopSip: 7,
  MFTransactionTypes.stopSwp: 8,
};
