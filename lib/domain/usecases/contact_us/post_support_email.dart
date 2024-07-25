import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/contact_us/post_support_email_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/contact_us_repository.dart';

@injectable
class PostSupportEmail extends UseCase<void, PostSupportEmailParams> {
  final ContactUsRepository _contactUsRepository;

  PostSupportEmail(this._contactUsRepository);

  @override
  Future<Either<AppError, void>> call(PostSupportEmailParams params) async =>
      await _contactUsRepository.postSupportEmail(await params.toFormData());
}
