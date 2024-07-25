import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/kyc/get_kyc_data_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class GetKycData extends UseCase<GetKycDataModel, NoParams> {
  final KycRepository _kycRepository;

  GetKycData(this._kycRepository);

  @override
  Future<Either<AppError, GetKycDataModel>> call(NoParams params) async =>
      await _kycRepository.getKycData();
}
