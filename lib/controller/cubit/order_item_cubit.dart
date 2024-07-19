import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../model/t_product.dart';

part 'order_item_state.dart';

class OrderItemCubit extends HydratedCubit<OrderItemState> {
  OrderItemCubit() : super(OrderItemInitial());

void cacheOrders(List<Items> newItems, DateTime date) {
  final currentState = state;
  if (currentState is OrderItemCached) {
    final updatedItems = List<Items>.from(currentState.orderedItems);
    final orderedDates = List<DateTime>.from(currentState.orderedDates);
    updatedItems.addAll(newItems);
    orderedDates.add(date);
    emit(OrderItemCached(updatedItems, orderedDates));
  } else {
    emit(OrderItemCached(newItems, [date]));
  }
}


  void clearOrders() async {
    emit(OrderItemInitial());
    clear();
  }

  @override
  OrderItemState? fromJson(Map<String, dynamic> json) {
    try {
      return OrderItemCached.fromJson(json);
    } catch (_) {
      return OrderItemInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(OrderItemState state) {
    if (state is OrderItemCached) {
      return state.toJson();
    }
    return null;
  }
}
