import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user_bank_mandate_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/account/get_user_bank_mandate_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class GetUserMandatesByBank
    extends UseCase<List<UserBankMandateModel>, GetUserBankMandateParams> {
  final AccountRepository _accountRepository;

  GetUserMandatesByBank(this._accountRepository);

  @override
  Future<Either<AppError, List<UserBankMandateModel>>> call(
    GetUserBankMandateParams params,
  ) =>
      _accountRepository.getUserMandatesByBank(
        params.toJson(),
      );
}
