import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/api/api_call_with_error.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/repositories/dropdown_repository.dart';
import '../data_sources/remote/dropdown_remote_data_source.dart';
import '../models/dropdowns/country_model.dart';

@LazySingleton(as: DropdownRepository)
class DropdownRepositoryImpl implements DropdownRepository {
  final DropdownRemoteDataSource _dropdownRemoteDataSource;

  const DropdownRepositoryImpl(this._dropdownRemoteDataSource);

  @override
  Future<Either<AppError, List<CountryModel>>> getAllCountries() async {
    return ApiCallWithError.call(
        () => _dropdownRemoteDataSource.getCountries());
  }
}
