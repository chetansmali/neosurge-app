import 'package:injectable/injectable.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../models/dropdowns/country_model.dart';

abstract class DropdownRemoteDataSource {
  Future<List<CountryModel>> getCountries();
}

@LazySingleton(as: DropdownRemoteDataSource)
class DropdownRemoteDataSourceImpl extends DropdownRemoteDataSource {
  final ApiClient _client;

  DropdownRemoteDataSourceImpl(this._client);

  @override
  Future<List<CountryModel>> getCountries() async {
    final response = await _client.get(ApiConstants.getAllCountryEndPoint);
    return (response as List).map((e) => CountryModel.fromJson(e)).toList();
  }
}
