import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/kyc/get_decentro_address_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/get_decentro_address_params.dart';
import '../../../../domain/usecases/kyc/get_decentro_address.dart';

part 'get_decentro_address_state.dart';

@injectable
class GetDecentroAddressCubit extends Cubit<GetDecentroAddressState> {
  final GetDecentroAddress _getDecentroAddress;

  GetDecentroAddressCubit(this._getDecentroAddress)
      : super(
          GetDecentroAddressInitial(),
        );

  void getDecentroAddress(
    GetDecentroAddressParams getDecentroAddressParams,
  ) async {
    emit(
      GetDecentroAddressLoading(),
    );
    final response = await _getDecentroAddress(
      getDecentroAddressParams,
    );

    emit(
      response.fold(
        (l) => GetDecentroAddressFailure(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
        (r) => GetDecentroAddressSuccess(
          decentroAddressList: r,
        ),
      ),
    );
  }
}
