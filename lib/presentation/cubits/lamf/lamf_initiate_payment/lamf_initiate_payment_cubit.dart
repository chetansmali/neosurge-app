import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/initiate_payment_details.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/lamf/initiate_payment.dart';

part 'lamf_initiate_payment_state.dart';

@injectable
class LamfInitiatePaymentCubit extends Cubit<LamfInitiatePaymentState> {
  LamfInitiatePaymentCubit(this._initiatePayment)
      : super(LamfInitiatePaymentInitial());

  final InitiatePayment _initiatePayment;

  void initiatePayment() async {
    emit(LamfInitiatePaymentLoading());
    final response = await _initiatePayment(NoParams());
    emit(response.fold(
      (l) => LamfInitiatePaymentFailure(l.error, l.errorType),
      (r) => LamfInitiatePaymentSuccess(initiatePaymentDetails: r),
    ));
  }
}
