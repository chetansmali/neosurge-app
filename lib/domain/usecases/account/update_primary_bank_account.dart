import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/account/update_primary_bank_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class UpdatePrimaryBankAccount extends UseCase<void, UpdatePrimaryBankParams> {
  final AccountRepository _accountRepository;

  UpdatePrimaryBankAccount(this._accountRepository);

  @override
  Future<Either<AppError, void>> call(UpdatePrimaryBankParams params) =>
      _accountRepository.updatePrimaryBank(params.toFormData());
}
