import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/cart/verify_cart_purchase_response.dart';
import '../../entities/app_error.dart';

import '../../entities/params/mutual_funds/verify_cart_purchase_otp_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class VerifyCartPurchaseOtp extends UseCase<VerifyCartPurchaseOtpResponse,
    VerifyCartPurchaseOtpParams> {
  final MutualFundRepository _mutualFundRepository;

  VerifyCartPurchaseOtp(this._mutualFundRepository);

  @override
  Future<Either<AppError, VerifyCartPurchaseOtpResponse>> call(
          VerifyCartPurchaseOtpParams params) =>
      _mutualFundRepository.verifyCartPurchaseOtp(params.toJson());
}
