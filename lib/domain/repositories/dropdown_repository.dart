import 'package:dartz/dartz.dart';

import '../../data/models/dropdowns/country_model.dart';
import '../entities/app_error.dart';

abstract class DropdownRepository {
  Future<Either<AppError, List<CountryModel>>> getAllCountries();
}
