part of 'mock_payment_bloc.dart';

sealed class MockPaymentState extends Equatable {
  const MockPaymentState();

  @override
  List<Object> get props => [];
}

final class MockPaymentInitial extends MockPaymentState {}

final class MockPaymentLoading extends MockPaymentState {}

final class MockPaymentSuccess extends MockPaymentState {
  final List<Items> orderedItems;
  final int totalCost;
  final DateTime orderDate;
  const MockPaymentSuccess(this.orderedItems, this.totalCost, this.orderDate);
}

final class MockPaymentError extends MockPaymentState {}
