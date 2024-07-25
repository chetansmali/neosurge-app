import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user_mandate_details_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class GetUserMandates extends UseCase<List<UserMandate>, NoParams> {
  final AccountRepository _accountRepository;

  GetUserMandates(this._accountRepository);

  @override
  Future<Either<AppError, List<UserMandate>>> call(NoParams params) =>
      _accountRepository.getUserMandates();
}
