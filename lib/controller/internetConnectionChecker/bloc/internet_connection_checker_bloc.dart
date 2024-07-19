import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'internet_connection_checker_event.dart';
part 'internet_connection_checker_state.dart';

class InternetConnectionBloc extends Bloc<InternetConnectionEvent, InternetConnectionState> {
  final InternetConnection _internetConnection = InternetConnection();
  late final StreamSubscription<InternetStatus> _statusSubscription;

  InternetConnectionBloc() : super(InternetConnectionInitial()) {
    _statusSubscription = _internetConnection.onStatusChange.listen((status) {
      add(InternetConnectionStatusChanged(status));
    });

    on<InternetConnectionStatusChanged>((event, emit) {
      if (event.status == InternetStatus.connected) {
        emit(InternetConnectionConnected());
      } else {
        emit(InternetConnectionDisconnected());
      }
    });
  }

  @override
  Future<void> close() {
    _statusSubscription.cancel();
    return super.close();
  }
}
