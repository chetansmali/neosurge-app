import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/neobaskets/basket_chart_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/neobaskets/get_basket_chart_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class GetBasketChartData
    extends UseCase<BasketChartResponse, GetBasketChartParams> {
  final NeobasketsRepository _neobasketsRepository;

  GetBasketChartData(this._neobasketsRepository);

  @override
  Future<Either<AppError, BasketChartResponse>> call(
      GetBasketChartParams params) {
    return _neobasketsRepository.getBasketChartData(params.toJson());
  }
}
