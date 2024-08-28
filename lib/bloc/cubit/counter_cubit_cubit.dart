import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
part 'counter_cubit_state.dart';

class CounterCubit extends Cubit<CounterCubitState> {
  CounterCubit() : super(CounterCubitValue(value: 0));

  void increment() {
    final stVlaue =
        state is CounterCubitValue ? (state as CounterCubitValue).value : 0;
    emit(CounterCubitStatus(message: "incrementing"));
    final value = stVlaue + 1;
    emit(CounterCubitValue(value: value));
  }

  void decrement() {
    final stVlaue =
        state is CounterCubitValue ? (state as CounterCubitValue).value : 0;
    emit(CounterCubitStatus(message: "decrementing"));
    final value = stVlaue - 1;
    emit(CounterCubitValue(value: value));
  }
}


enum ConnectivityStatus { connected, disconnected, connectedToWifi, connectedToMobile }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final Connectivity _connectivity;
  late final StreamSubscription<ConnectivityResult> _connectivityStreamSubscription;

  ConnectivityCubit(this._connectivity) : super(ConnectivityStatus.disconnected) {
    _connectivityStreamSubscription = _connectivity.onConnectivityChanged.listen(_connectivityChanged);
  }

  void _connectivityChanged(ConnectivityResult result) {
    if (result == ConnectivityResult.wifi) {
      emit(ConnectivityStatus.connectedToWifi);
    } else if (result == ConnectivityResult.mobile) {
      emit(ConnectivityStatus.connectedToMobile);
    } else if (result == ConnectivityResult.none) {
      emit(ConnectivityStatus.disconnected);
    }
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription.cancel();
    return super.close();
  }
}
