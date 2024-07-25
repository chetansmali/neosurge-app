import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'network_state.dart';

@lazySingleton
class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity;
  late final StreamSubscription _connectivityStreamSubscription;

  NetworkCubit(this._connectivity) : super(NetworkLoading()) {
    _listenNetworkStatus();
  }

  _listenNetworkStatus() {
    return _connectivityStreamSubscription = _connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        _emitNetworkDisconnected();
      } else {
        _emitNetworkConnected();
      }
    });
  }

  void _emitNetworkConnected() => emit(NetworkConnected());

  void _emitNetworkDisconnected() => emit(NetworkDisconnected());

  @override
  Future<void> close() {
    _connectivityStreamSubscription.cancel();
    return super.close();
  }
}
