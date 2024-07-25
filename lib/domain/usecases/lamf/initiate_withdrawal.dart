import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/lamf/initiate_withdrawal_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/lamf_repository.dart';

@injectable
class InitiateWithdrawal extends UseCase<InitiateWithdrawalDetails, NoParams> {
  final LAMFRepository _lamfRepository;
  InitiateWithdrawal(this._lamfRepository);

  @override
  Future<Either<AppError, InitiateWithdrawalDetails>> call(params) =>
      _lamfRepository.initiateWithdrawal();
}
