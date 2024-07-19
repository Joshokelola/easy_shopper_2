part of 'internet_connection_checker_bloc.dart';

abstract class InternetConnectionEvent {}

class InternetConnectionStatusChanged extends InternetConnectionEvent {
  final InternetStatus status;

  InternetConnectionStatusChanged(this.status);
}
