import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/kyc/get_kyc_personal_details_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class GetKycPersonalDetails
    extends UseCase<GetKycPersonalDetailsModel, NoParams> {
  final KycRepository _kycRepository;

  GetKycPersonalDetails(this._kycRepository);

  @override
  Future<Either<AppError, GetKycPersonalDetailsModel>> call(
          NoParams params) async =>
      await _kycRepository.getKycPersonalDetails();
}
