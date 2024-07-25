import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/is_scheme_present_params.dart';
import '../../../../domain/usecases/mutual_funds/is_scheme_present.dart';

part 'is_scheme_present_state.dart';

@injectable
class IsSchemePresentCubit extends Cubit<IsSchemePresentState> {
  IsSchemePresentCubit(this._isSchemePresent) : super(IsSchemePresentInitial());

  final IsSchemePresent _isSchemePresent;

  Future<void> isSchemePresent({required IsSchemePresentParams params}) async {
    emit(IsSchemePresentLoading());

    final result = await _isSchemePresent(params);

    result.fold(
      (error) => emit(
        IsSchemePresentFail(
          errorType: error.errorType,
          error: error.error,
        ),
      ),
      (success) => emit(IsSchemePresentSuccess(success)),
    );
  }
}
