import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/edit_cart_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class EditCart extends UseCase<void, EditCartParams> {
  final MutualFundRepository _mutualFundRepository;

  EditCart(this._mutualFundRepository);

  @override
  Future<Either<AppError, void>> call(
    EditCartParams params,
  ) =>
      _mutualFundRepository.editCart(params.toJson());
}
