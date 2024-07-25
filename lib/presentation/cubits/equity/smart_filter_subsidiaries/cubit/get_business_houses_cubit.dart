import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/models/equity/smart_filtering/business_houses_model.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/params/no_params.dart';
import '../../../../../domain/usecases/equity/get_business_houses.dart';

part 'get_business_houses_state.dart';

@injectable
class GetBusinessHousesCubit extends Cubit<GetBusinessHousesState> {
  final GetBusinessHouses _getBusinessHouses;
  GetBusinessHousesCubit(this._getBusinessHouses)
      : super(GetBusinessHousesInitial());

  void getBusinessHouses() async {
    emit(GetBusinessHousesLoading());
    final response = await _getBusinessHouses(NoParams());
    emit(response.fold(
        (l) => GetBusinessHousesFailure(
            errorType: l.errorType, errorMessage: l.error),
        (r) => GetBusinessHousesSuccess(businessHouses: r)));
  }
}
