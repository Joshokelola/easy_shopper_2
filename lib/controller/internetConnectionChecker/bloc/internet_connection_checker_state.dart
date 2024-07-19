part of 'internet_connection_checker_bloc.dart';

abstract class InternetConnectionState {}

class InternetConnectionInitial extends InternetConnectionState {}

class InternetConnectionConnected extends InternetConnectionState {}

class InternetConnectionDisconnected extends InternetConnectionState {}
