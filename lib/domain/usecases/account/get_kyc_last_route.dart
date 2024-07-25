import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/kyc_last_route.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class GetKycLastRoute extends UseCase<KycLastRouteModel, NoParams> {
  final AccountRepository _accountRepository;

  GetKycLastRoute(this._accountRepository);

  @override
  Future<Either<AppError, KycLastRouteModel>> call(NoParams params) async =>
      await _accountRepository.getKycLastRoute();
}
