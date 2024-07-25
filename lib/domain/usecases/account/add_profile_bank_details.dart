import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user_bank_details_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/kyc/upload_bank_details_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class AddProfileBankDetails extends UseCase<UserBank, UploadBankDetailsParams> {
  final AccountRepository _accountRepository;

  AddProfileBankDetails(this._accountRepository);

  @override
  Future<Either<AppError, UserBank>> call(UploadBankDetailsParams params) =>
      _accountRepository.addBankDetails(params.toJson());
}
