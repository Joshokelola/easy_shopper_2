part of 'mock_payment_bloc.dart';

sealed class MockPaymentEvent extends Equatable {
  const MockPaymentEvent();

  @override
  List<Object> get props => [];
}

final class MakeMockPaymentAction extends MockPaymentEvent {
  final List<Items> orderedItems;
  final int totalCost;
  final DateTime date;

  const MakeMockPaymentAction(this.orderedItems, this.totalCost, this.date);

  @override
  List<Object> get props => [orderedItems, totalCost, date];
}

final class ResetMockPayment extends MockPaymentEvent{
  
}
