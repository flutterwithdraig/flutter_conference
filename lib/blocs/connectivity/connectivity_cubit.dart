import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity;
  StreamSubscription? _subscription;

  ConnectivityCubit()
      : _connectivity = Connectivity(),
        super(ConnectivityInitial()) {
    _monitorNetwork();
  }

  _monitorNetwork() {
    _connectivity.checkConnectivity().then((result) => _emitResult(result));
    _subscription = _connectivity.onConnectivityChanged
        .listen((result) => _emitResult(result));
  }

  void _emitResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        emit(ConnectivityConnected());
        break;
      default:
        emit(ConnectivityDisconnected());
        break;
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
