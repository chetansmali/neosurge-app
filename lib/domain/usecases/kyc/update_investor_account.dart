import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class UpdateInvestorAccount extends UseCase<void, NoParams> {
  final KycRepository _kycRepository;

  UpdateInvestorAccount(this._kycRepository);

  @override
  Future<Either<AppError, void>> call(NoParams params) =>
      _kycRepository.updateInvestorAccount();
}
