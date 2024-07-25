import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/kyc/get_pincode_data_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/kyc/get_pincode_data_params.dart';

import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class GetPincodeData extends UseCase<PinCodeDataModel, GetPincodeDataParams> {
  final KycRepository _kycRepository;

  GetPincodeData(this._kycRepository);

  @override
  Future<Either<AppError, PinCodeDataModel>> call(
    GetPincodeDataParams params,
  ) async {
    return await _kycRepository.getPinCodeData(params.toJson());
  }
}
