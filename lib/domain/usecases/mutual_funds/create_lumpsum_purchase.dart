import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/lumpsum_purchase_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/create_lumpsum_purchase_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class CreateLumpsumPurchase
    extends UseCase<LumpsumPurchase, CreateLumpsumPurchaseParams> {
  final MutualFundRepository _mutualFundRepository;

  CreateLumpsumPurchase(this._mutualFundRepository);

  @override
  Future<Either<AppError, LumpsumPurchase>> call(
          CreateLumpsumPurchaseParams params) =>
      _mutualFundRepository.createLumpsumPurchase(params.toJson());
}
