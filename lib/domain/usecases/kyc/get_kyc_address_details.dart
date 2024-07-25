import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/kyc/get_kyc_addresss_details_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class GetKycAddressDetails
    extends UseCase<GetKycAddressDetailsModel, NoParams> {
  final KycRepository _kycRepository;

  GetKycAddressDetails(this._kycRepository);

  @override
  Future<Either<AppError, GetKycAddressDetailsModel>> call(
          NoParams params) async =>
      await _kycRepository.getKycAddressDetails();
}
