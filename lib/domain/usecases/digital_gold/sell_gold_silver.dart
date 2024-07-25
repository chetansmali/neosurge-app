import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/digital_gold/sell_gold_silver_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/digital_gold_repository.dart';

@injectable
class SellGoldSilver extends UseCase<void, SellGoldSilverParams> {
  final DigitalGoldRepository _digitalGoldRepository;

  SellGoldSilver(this._digitalGoldRepository);

  @override
  Future<Either<AppError, void>> call(SellGoldSilverParams params) =>
      _digitalGoldRepository.sellGoldSilver(params.toJson());
}
