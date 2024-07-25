import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'lamf_initiate_loan_closure_state.dart';

class LamfInitiateLoanClosureCubit extends Cubit<LamfInitiateLoanClosureState> {
  LamfInitiateLoanClosureCubit() : super(LamfInitiateLoanClosureInitial());
}
