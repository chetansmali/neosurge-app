import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/initiate_payment_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/initiate_lumpsum_purchase_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class InitiateLumpsumPurchase extends UseCase<
    InitiatePaymentResponse, InitiateLumpsumPurchaseParams> {
  final MutualFundRepository _mutualFundRepository;

  InitiateLumpsumPurchase(this._mutualFundRepository);

  @override
  Future<Either<AppError, InitiatePaymentResponse>> call(
          InitiateLumpsumPurchaseParams params) =>
      _mutualFundRepository.initiateLumpsumPurchase(params.toJson());
}
