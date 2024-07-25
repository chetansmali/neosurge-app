import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/account/verify_delete_mandate_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class VarifyDeleteMandate extends UseCase<void, VerifyDeleteMandateParams> {
  final AccountRepository _accountRepository;

  VarifyDeleteMandate(this._accountRepository);

  @override
  Future<Either<AppError, void>> call(VerifyDeleteMandateParams params) =>
      _accountRepository.verifyDeleteMandate(params.toJson());
}
