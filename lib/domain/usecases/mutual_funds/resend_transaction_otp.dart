import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/resend_transaction_otp_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class ResendTransactionOtp extends UseCase<void, ResendTransactionOtpParams> {
  final MutualFundRepository _mutualFundRepository;

  ResendTransactionOtp(this._mutualFundRepository);

  @override
  Future<Either<AppError, void>> call(ResendTransactionOtpParams params) =>
      _mutualFundRepository.resendTransactionOtp(params.toFormData);
}
