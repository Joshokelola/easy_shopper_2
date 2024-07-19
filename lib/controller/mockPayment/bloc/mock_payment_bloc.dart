import 'package:checkout_screen_ui/checkout_ui.dart';
import 'package:easy_shopper/model/t_product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mock_payment_event.dart';
part 'mock_payment_state.dart';

class MockPaymentBloc extends Bloc<MockPaymentEvent, MockPaymentState> {
  MockPaymentBloc() : super(MockPaymentInitial()) {
    on<MakeMockPaymentAction>((event, emit) async {

        
        emit(MockPaymentLoading());
        await Future.delayed(const Duration(seconds: 3));
        emit(MockPaymentSuccess(event.orderedItems, event.totalCost, event.date));
    });

       on<ResetMockPayment>((event, emit) async {
     
      emit(MockPaymentInitial());
    });
  }

  
}
