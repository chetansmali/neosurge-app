import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/verify_transaction_otp_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class VerifyStpOtp extends UseCase<void, VerifyTransactionOtpParams> {
  final MutualFundRepository _mutualFundRepository;

  VerifyStpOtp(this._mutualFundRepository);

  @override
  Future<Either<AppError, void>> call(VerifyTransactionOtpParams params) =>
      _mutualFundRepository.verifyStpOtp(params.toJson());
}
