import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/contact_us/contact_us_categories_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/contact_us_repository.dart';

@injectable
class GetContactUsCategoriesList
    extends UseCase<List<ContactUsCategoriesModel>, NoParams> {
  final ContactUsRepository _contactUsRepository;

  GetContactUsCategoriesList(this._contactUsRepository);

  @override
  Future<Either<AppError, List<ContactUsCategoriesModel>>> call(NoParams params) =>
      _contactUsRepository.getContactUsCategories();
}
