import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/neobaskets/basket_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/neobaskets/basket_details_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class GetBasketDetails
    extends UseCase<BasketDetailsModel, BasketDetailsParams> {
  final NeobasketsRepository _neobasketsRepository;

  GetBasketDetails(this._neobasketsRepository);

  @override
  Future<Either<AppError, BasketDetailsModel>> call(
          BasketDetailsParams params) =>
      _neobasketsRepository.getBasketDetails(params.toJson());
}
