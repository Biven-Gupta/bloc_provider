import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetState { Initial, Lost, Gain }

class InternetCubits extends Cubit<InternetState> {
  Connectivity connectivity = Connectivity();
  StreamSubscription? subscription;

  InternetCubits() : super(InternetState.Initial) {
    subscription = connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        emit(InternetState.Gain);
      } else {
        emit(InternetState.Lost);
      }
    });
  }
  @override
  Future<void> close() {
    subscription?.cancel();
    // TODO: implement close
    return super.close();
  }
}
