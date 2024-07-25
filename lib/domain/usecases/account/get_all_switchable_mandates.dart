import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/switchable_mandate_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class GetAllSwitchableMandates
    extends UseCase<List<SwitchableMandateModel>, NoParams> {
  final AccountRepository _accountRepository;

  GetAllSwitchableMandates(this._accountRepository);

  @override
  Future<Either<AppError, List<SwitchableMandateModel>>> call(
          NoParams params) =>
      _accountRepository.getAllSwitchableMandates();
}
