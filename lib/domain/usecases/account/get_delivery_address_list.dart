import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/address_details_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class GetDeliveryAddressList
    extends UseCase<List<DeliveryAddressDetailsModel>, NoParams> {
  final AccountRepository _accountRepository;

  GetDeliveryAddressList(this._accountRepository);

  @override
  Future<Either<AppError, List<DeliveryAddressDetailsModel>>> call(
          NoParams params) =>
      _accountRepository.getAllAddressDetails();
}
