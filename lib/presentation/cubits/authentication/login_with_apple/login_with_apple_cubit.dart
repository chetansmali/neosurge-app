import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../di/get_it.dart';
import '../../util_cubits/loading_cubit.dart';

part 'login_with_apple_state.dart';

@injectable
class LoginWithAppleCubit extends Cubit<LoginWithAppleState> {
  LoginWithAppleCubit() : super(LoginWithAppleInitial());

  final LoadingCubit _loadingCubit = getIt<LoadingCubit>();

  Future<void> login() async {
    _loadingCubit.show();
    emit(LoginWithAppleLoading());
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      emit(
        LoginWithAppleSuccess(appleSignInAccount: credential),
      );
    } catch (e) {
      if (e is SignInWithAppleAuthorizationException) {
        emit(
          LoginWithAppleFailure(
            error: e.message,
          ),
        );
      } else if (e is SignInWithAppleCredentialsException) {
        emit(
          LoginWithAppleFailure(
            error: e.message,
          ),
        );
      } else if (e is SignInWithAppleNotSupportedException) {
        emit(
          LoginWithAppleFailure(
            error: e.message,
          ),
        );
      } else {
        emit(
          LoginWithAppleFailure(
            error: e.toString(),
          ),
        );
      }
    } finally {
      _loadingCubit.hide();
    }
  }
}
