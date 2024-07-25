import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/edit_cart_params.dart';
import '../../../../domain/usecases/mutual_funds/edit_cart.dart';

part 'edit_cart_state.dart';

@injectable
class EditCartCubit extends Cubit<EditCartState> {
  EditCartCubit(this._editCart) : super(EditCartInitial());
  final EditCart _editCart;

  Future<void> editCart({required EditCartParams params}) async {
    emit(EditCartLoading());

    final result = await _editCart(params);

    result.fold(
      (error) => emit(
        EditCartFail(
          errorType: error.errorType,
          error: error.error,
        ),
      ),
      (success) => emit(EditCartSuccess()),
    );
  }
}
