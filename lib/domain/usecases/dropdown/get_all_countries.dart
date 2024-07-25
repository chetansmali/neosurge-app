import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/dropdowns/country_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/dropdown_repository.dart';

@injectable
class GetAllCountries extends UseCase<List<CountryModel>, NoParams> {
  final DropdownRepository _dropdownRepository;

  GetAllCountries(this._dropdownRepository);

  @override
  Future<Either<AppError, List<CountryModel>>> call(NoParams params) async =>
      await _dropdownRepository.getAllCountries();
}
