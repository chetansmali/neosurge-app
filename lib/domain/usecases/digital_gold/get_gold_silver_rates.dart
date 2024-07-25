import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/digital_gold/gold_silver_rates_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/digital_gold_repository.dart';

@injectable
class GetGoldSilverRates extends UseCase<GoldSilverRatesModel, NoParams> {
  final DigitalGoldRepository _digitalGoldRepository;

  GetGoldSilverRates(this._digitalGoldRepository);

  @override
  Future<Either<AppError, GoldSilverRatesModel>> call(NoParams params) =>
      _digitalGoldRepository.getGoldSilverRates();
}
