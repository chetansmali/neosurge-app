import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/kyc/get_kyc_nominee_details_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class GetKycNomineeDetails
    extends UseCase<List<GetKycNomineeDetailsModel>, NoParams> {
  final KycRepository _kycRepository;

  GetKycNomineeDetails(this._kycRepository);

  @override
  Future<Either<AppError, List<GetKycNomineeDetailsModel>>> call(
          NoParams params) =>
      _kycRepository.getKycNomineeDetails();
}
