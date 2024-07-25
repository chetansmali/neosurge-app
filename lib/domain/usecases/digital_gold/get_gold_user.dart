import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/digital_gold/gold_user.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/digital_gold_repository.dart';

@injectable
class GetGoldUser extends UseCase<GoldUser, NoParams> {
  final DigitalGoldRepository _digitalGoldRepository;

  GetGoldUser(this._digitalGoldRepository);

  @override
  Future<Either<AppError, GoldUser>> call(NoParams params) =>
      _digitalGoldRepository.getGoldUser();
}
