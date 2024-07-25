import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/digital_gold_repository.dart';

@injectable
class CreateGoldUser extends UseCase<void, NoParams> {
  final DigitalGoldRepository _digitalGoldRepository;

  CreateGoldUser(this._digitalGoldRepository);

  @override
  Future<Either<AppError, void>> call(NoParams params) =>
      _digitalGoldRepository.createGoldUser();
}
