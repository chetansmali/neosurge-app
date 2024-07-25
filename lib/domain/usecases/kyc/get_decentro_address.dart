import 'package:injectable/injectable.dart';

import '../../../data/models/kyc/get_decentro_address_model.dart';
import '../../entities/app_error.dart';
import 'package:dartz/dartz.dart';

import '../../entities/params/kyc/get_decentro_address_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class GetDecentroAddress
    extends UseCase<List<GetDecentroAddressModel>, GetDecentroAddressParams> {
  final KycRepository _kycRepository;

  GetDecentroAddress(
    this._kycRepository,
  );

  @override
  Future<Either<AppError, List<GetDecentroAddressModel>>> call(
    GetDecentroAddressParams params,
  ) async {
    return await _kycRepository.getDecentroAddress(params.toJson());
  }
}
