import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/mandate_sip_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/account/get_sips_by_mandate_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class GetSipsByMandate
    extends UseCase<List<MandateSipModel>, GetSipsByMandateParams> {
  final AccountRepository _accountRepository;

  GetSipsByMandate(this._accountRepository);

  @override
  Future<Either<AppError, List<MandateSipModel>>> call(
    GetSipsByMandateParams params,
  ) =>
      _accountRepository.getSipsByMandate(
        params.toJson(),
      );
}
