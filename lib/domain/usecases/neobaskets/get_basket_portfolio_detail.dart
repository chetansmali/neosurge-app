import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/neobaskets/basket_portfolio_detail_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/neobaskets/basket_portfolio_detail_params.dart';

import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class GetBasketPortfolioDetail extends UseCase<BasketPortfolioDetailResponse,
    BasketPortfolioDetailParams> {
  final NeobasketsRepository _neobasketsRepository;

  GetBasketPortfolioDetail(this._neobasketsRepository);
  @override
  Future<Either<AppError, BasketPortfolioDetailResponse>> call(
      BasketPortfolioDetailParams params) {
    return _neobasketsRepository.getBasketPortfolioDetail(params.toJson());
  }
}
