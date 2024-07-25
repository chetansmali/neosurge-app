import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/kyc/get_pincode_data_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/get_pincode_data_params.dart';
import '../../../../domain/usecases/kyc/get_pincode_data.dart';

part 'get_pincode_data_state.dart';

@injectable
class GetPinCodeDataCubit extends Cubit<GetPincodeDataState> {
  final GetPincodeData _getPincodeData;

  GetPinCodeDataCubit(this._getPincodeData)
      : super(
          GetPincodeDataInitial(),
        );

  void getPincodeData(GetPincodeDataParams getPincodeDataParams) async {
    emit(
      GetPincodeDataLoading(),
    );
    final response = await _getPincodeData(
      getPincodeDataParams,
    );

    emit(
      response.fold(
        (l) => GetPincodeDataFailure(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
        (r) => GetPincodeDataSuccess(
          pinCodeData: r,
        ),
      ),
    );
  }
}
