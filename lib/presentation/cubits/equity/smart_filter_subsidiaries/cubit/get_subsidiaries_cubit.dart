import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/models/equity/smart_filtering/subsidiaries_model.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/params/equity/smart_filter_subsidiaries/get_subsidiaries_params.dart';
import '../../../../../domain/usecases/equity/get_subsidiaries.dart';

part 'get_subsidiaries_state.dart';

@injectable
class GetSubsidiariesCubit extends Cubit<GetSubsidiariesState> {
  final GetSubsidiaries _getSubsidiaries;
  GetSubsidiariesCubit(this._getSubsidiaries) : super(GetSubsidiariesInitial());

  void getSubsidiaries(GetSubsidiariesParams getSubsidiariesParams) async {
    emit(GetSubsidiariesLoading());
    final response = await _getSubsidiaries(getSubsidiariesParams);
    emit(response.fold(
        (l) => GetSubsidiariesFailure(
            errorType: l.errorType, errorMessage: l.error),
        (r) => GetSubsidiariesSuccess(businessHouses: r)));
  }
}
