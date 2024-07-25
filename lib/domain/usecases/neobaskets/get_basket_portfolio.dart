import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/neobaskets/basket_portfolio_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class GetBasketPortfolio extends UseCase<BasketPortfolioResponse, NoParams> {
  final NeobasketsRepository _neobasketsRepository;

  GetBasketPortfolio(this._neobasketsRepository);

  @override
  Future<Either<AppError, BasketPortfolioResponse>> call(NoParams params) =>
      _neobasketsRepository.getBasketPortfolio();
}
