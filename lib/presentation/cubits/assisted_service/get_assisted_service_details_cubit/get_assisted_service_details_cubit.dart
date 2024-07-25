import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/assisted_service/assisted_service_details_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/assisted_service/get_assisted_service_details.dart';

part 'get_assisted_service_details_state.dart';

@injectable
class GetAssistedServiceDetailsCubit extends Cubit<GetAssistedServiceDetailsState> {
  final GetAssistedServiceDetails _getAssistedServiceDetails;

  GetAssistedServiceDetailsCubit(this._getAssistedServiceDetails) : super(GetAssistedServiceDetailsInitial());

  void getAssistedServiceDetails() async {
    emit(GetAssistedServiceDetailsLoading());
    final response = await _getAssistedServiceDetails(NoParams());
    emit(response.fold((l) => GetAssistedServiceDetailsFailure(appErrorType: l.errorType, errorMessage: l.error), (r) => GetAssistedServiceDetailsSuccess(response: r)));
  }
}
