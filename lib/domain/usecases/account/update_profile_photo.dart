import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user.dart';
import '../../entities/app_error.dart';
import '../../entities/params/account/update_profile_photo_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class UpdateProfilePhoto extends UseCase<User, UpdateProfilePhotoParams> {
  final AccountRepository _accountRepository;

  UpdateProfilePhoto(this._accountRepository);

  @override
  Future<Either<AppError, User>> call(UpdateProfilePhotoParams params) async =>
      _accountRepository.updateProfilePhoto(await params.formData);
}
