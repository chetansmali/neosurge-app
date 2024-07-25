import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/lamf/update_loan_status_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/lamf/update_loan_params.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/lamf_repository.dart';

@injectable
class UpdateLoanStatus
    extends UseCase<UpdateLoanStatusDetails, UpdateLoanParams> {
  final LAMFRepository _lamfRepository;
  UpdateLoanStatus(this._lamfRepository);

  @override
  Future<Either<AppError, UpdateLoanStatusDetails>> call(params) =>
      _lamfRepository.updateLoanStatus(params.toJson());
}
