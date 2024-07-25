import 'package:app_version_update/app_version_update.dart';
import 'package:app_version_update/data/models/app_version_result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/user.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/account/get_user.dart';
import '../../../../domain/usecases/account/logout_user.dart';
import '../../../../domain/usecases/account/set_user.dart';
import '../../../../logger.dart';
import '../../util_cubits/loading_cubit.dart';

part 'auth_state.dart';

const String _h = 'auth_cubit';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final GetUser _getUser;
  final SetUser _setUser;
  final LogoutUser _logoutUser;
  final LoadingCubit _loadingCubit;

  AuthCubit(
    this._getUser,
    this._setUser,
    this._logoutUser,
    this._loadingCubit,
  ) : super(AuthInitial());

  void checkForUpdate({
    int? delay,
  }) async {
    //TODO: REMOVE THIS HACKY CODE FOR APP UPDATE CHECK and uncomment the code below it
    // Hack: Start
    await Future.delayed(Duration(
      seconds: delay ?? 4,
    ));

    _checkCurrentUser();
    // Hack: End

    // try {
    //   emit(AuthLoading());

    //   // Putting delay to show splash screen for 4 seconds
    //   await Future.delayed(Duration(
    //     seconds: delay ?? 4,
    //   ));

    //   AppVersionResult appVersionUpdateResult =
    //       await AppVersionUpdate.checkForUpdates(
    //     appleId: '6452753963',
    //     playStoreId: 'com.neosurge.neosurge',
    //     country: 'in',
    //   );

    //   if ((appVersionUpdateResult.canUpdate ?? false) && !kDebugMode) {
    //     emit(UpdateApp(appVersionUpdateResult));
    //   } else {
    //     _checkCurrentUser();
    //   }
    // } catch (e) {
    //   log('error in app update checker: $e');
    //   _checkCurrentUser();
    // }
  }

  void _checkCurrentUser() async {
    emit(AuthLoading());
    final response = await _getUser(
      GetUserParams(forceRefresh: false),
    );
    // Here
    response.fold((l) => emit(Unauthenticated()), (r) {
      if (r == null) {
        emit(Unauthenticated());
      } else {
        logInfo(_h, r.toString());
        emit(Authenticated(newUser: r));
      }
    });
  }

  void getServerUser() async {
    final oldUser = state.user!;
    _loadingCubit.show();
    emit(AuthLoading());
    final response = await _getUser(GetUserParams(forceRefresh: true));
    response.fold((l) => emit(AuthError(l.errorType, l.error, oldUser)),
        (r) async {
      if (r == null) {
        emit(Unauthenticated());
      } else {
        logInfo(_h, r.toString());
        final newUser = r.copyWith(
          isBiometricEnabled: oldUser.isBiometricEnabled,
          showGoldDisclaimer: oldUser.showGoldDisclaimer,
        );
        await updateUser(newUser, serverAuthenticated: true);
      }
    });
    _loadingCubit.hide();
  }

  Future<void> updateUser(User user, {bool serverAuthenticated = false}) async {
    await _setUser(user);
    emit(
      Authenticated(newUser: user, serverAuthenticated: serverAuthenticated),
    );
  }

  Future<void> logout() async {
    await _logoutUser(NoParams());
    emit(Unauthenticated());
    return;
  }
}
