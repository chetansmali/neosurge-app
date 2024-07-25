import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user_bank_details_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class GetUserPrimaryBank extends UseCase<UserBank, NoParams> {
  final AccountRepository _accountRepository;

  GetUserPrimaryBank(this._accountRepository);

  @override
  Future<Either<AppError, UserBank>> call(NoParams params) =>
      _accountRepository.getPrimaryBankDetails();
}
