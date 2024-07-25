import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/sip/sip_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/user_id_param.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetActiveSips extends UseCase<List<SipModel>, UserIdParam> {
  final MutualFundRepository _mutualFundRepository;

  GetActiveSips(this._mutualFundRepository);

  @override
  Future<Either<AppError, List<SipModel>>> call(UserIdParam params) =>
      _mutualFundRepository.getActiveSips(params.toJson());
}
