import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/lamf/get_pledged_funds_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/lamf_repository.dart';

@injectable
class GetPledgedFunds extends UseCase<GetPledgedFundsDetails, NoParams> {
  final LAMFRepository _lamfRepository;
  GetPledgedFunds(this._lamfRepository);

  @override
  Future<Either<AppError, GetPledgedFundsDetails>> call(params) =>
      _lamfRepository.getPledgedFunds();
}
