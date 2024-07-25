import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/contact_us/capture_faq_like_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/contact_us_repository.dart';

@injectable
class CaptureFaqLike extends UseCase<void, CaptureFaqLikeParams> {
  final ContactUsRepository _contactUsRepository;

  CaptureFaqLike(this._contactUsRepository);

  @override
  Future<Either<AppError, void>> call(CaptureFaqLikeParams params) async =>
      await _contactUsRepository.captureFaqLike(params.toJson());
}
