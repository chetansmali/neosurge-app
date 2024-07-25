import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/authentication/login_with_email_response_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/usecases/onboarding/login_with_email.dart';

part 'login_with_email_state.dart';

@injectable
class LoginWithEmailCubit extends Cubit<LoginWithEmailState> {
  final LoginWithEmail _loginWithEmail;

  LoginWithEmailCubit(this._loginWithEmail) : super(LoginWithEmailInitial());

  String? _email;

  void loginWithEmail({required String email}) async {
    _email = email;

    emit(LoginWithEmailLoading());
    final response =
        await _loginWithEmail(LoginWithEmailParams(emailId: email));
    emit(response.fold(
        (l) => LoginWithEmailOtpGenerateError(
            errorType: l.errorType, errorMessage: l.error),
        (r) => LoginWithEmailOtpGenerated(response: r)));
  }

  void resendEmailOtp() async {
    emit(LoginWithEmailLoading());
    final response = await _loginWithEmail(
      LoginWithEmailParams(emailId: _email!),
    );
    emit(
      response.fold(
        (l) => LoginWithEmailOtpGenerateError(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
        (r) => LoginWithEmailOtpGenerated(
          isResend: true,
          response: r,
        ),
      ),
    );
  }
}
