import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/contact_us_repository.dart';

@injectable
class GetDislikeReasonsList
    extends UseCase<List<String>, NoParams> {
  final ContactUsRepository _contactUsRepository;

  GetDislikeReasonsList(this._contactUsRepository);

  @override
  Future<Either<AppError, List<String>>> call(NoParams params) =>
      _contactUsRepository.getDislikeReasons();
}
