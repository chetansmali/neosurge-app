import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../../di/get_it.dart';
import '../../../../logger.dart';
import '../../util_cubits/loading_cubit.dart';

part 'login_with_google_state.dart';

const String _h = 'login_with_google_cubit';

@injectable
class LoginWithGoogleCubit extends Cubit<LoginWithGoogleState> {
  LoginWithGoogleCubit() : super(LoginWithGoogleInitial());

  final _signInWithGoogle = GoogleSignIn(scopes: ['email']);
  final LoadingCubit _loadingCubit = getIt<LoadingCubit>();

  Future<void> login() async {
    _loadingCubit.show();
    emit(LoginWithGoogleLoading());
    try {
      final googleUser = await _signInWithGoogle.signIn();
      if (googleUser == null) {
        emit(LoginWithGoogleInitial());
      } else {
        logInfo(_h, 'Logged in with Google');
        final String accessToken = (await googleUser.authentication).accessToken!;
        /* print(accessToken);*/

        emit(LoginWithGoogleSuccess(googleSignInAccount: googleUser, accessToken: accessToken));
      }
    } catch (e) {
      logErrorObject(_h, e, 'Error logging in with Google');
      emit(LoginWithGoogleFailure(error: e.toString()));
    } finally {
      _loadingCubit.hide();
    }
  }
}
