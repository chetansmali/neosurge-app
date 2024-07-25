import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/kyc/cheque_ocr_read_response_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/cheque_ocr_read.dart';

part 'cheque_ocr_read_state.dart';

@injectable
class ChequeOcrReadCubit extends Cubit<ChequeOcrReadState> {
  final ChequeOcrRead _chequeOcrRead;

  ChequeOcrReadCubit(this._chequeOcrRead) : super(ChequeOcrReadInitial());

  void readCheque() async {
    emit(ChequeOcrReadLoading());
    final res = await _chequeOcrRead(NoParams());
    emit(res.fold((l) => ChequeOcrReadFailure(appErrorType: l.errorType, errorMessage: l.error), (r) => ChequeOcrReadLoaded(chequeOcrResponse: r)));
  }
}
