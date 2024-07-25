import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/contact_us/capture_faq_dislike_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/contact_us_repository.dart';

@injectable
class CaptureFaqDislike extends UseCase<void, CaptureFaqDislikeParams> {
  final ContactUsRepository _contactUsRepository;

  CaptureFaqDislike(this._contactUsRepository);

  @override
  Future<Either<AppError, void>> call(CaptureFaqDislikeParams params) async =>
      await _contactUsRepository.captureFaqDislike(params.toJson());
}
