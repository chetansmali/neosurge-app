import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/mpin/set_mpin_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class SetMPin extends UseCase<void, SetMPinParams> {
  final AccountRepository _accountRepository;

  SetMPin(this._accountRepository);

  @override
  Future<Either<AppError, void>> call(SetMPinParams params) async =>
      await _accountRepository.setMPin(params.toJson());
}
