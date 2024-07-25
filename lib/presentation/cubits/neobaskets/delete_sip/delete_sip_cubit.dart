import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/neobaskets/delete_sip_params.dart';
import '../../../../domain/usecases/neobaskets/delete_sip.dart';

part 'delete_sip_state.dart';

@injectable
class DeleteSipCubit extends Cubit<DeleteSipState> {
  final DeleteSip _deleteSip;

  DeleteSipCubit(
    this._deleteSip,
  ) : super(DeleteSipInitial());

  void deleteSip(DeleteSipParams params) async {
    if (state is DeleteSipLoading) return;

    emit(DeleteSipLoading());
    final response = await _deleteSip(params);

    response.fold(
      (l) => emit(DeleteSipError(
        appErrorType: l.errorType,
        message: l.error,
      )),
      (r) => emit(DeleteSipSuccess()),
    );
  }
}
