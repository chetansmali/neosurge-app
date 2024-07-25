import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/delete_nominee_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class DeleteNomineeDetails extends UseCase<void, DeleteNomineeParams> {
  final KycRepository _kycRepository;

  DeleteNomineeDetails(this._kycRepository);

  @override
  Future<Either<AppError, void>> call(DeleteNomineeParams params) =>
      _kycRepository.deleteNomineeDetails(params.toFormData());
}
