import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/t_product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoaded(
    [], 0, 0, false
  )) {
    on<AddItem>((event, emit) {
      final currentState = state;
      if (currentState is CartLoaded) {
        final existingItem = currentState.items.where(
          (item) => item.id == event.item.id,
        );
        if (existingItem.isNotEmpty) {
          final updatedItems = currentState.items
              .map((item) => item.id == event.item.id
                  ? item.copyWith(quantity: item.quantity + 1)
                  : item)
              .toList();
          emit(CartLoaded(updatedItems, countTotalItems(updatedItems),
              calculateTotalPrice(updatedItems), false));
        } else {
          final updatedItems = [...currentState.items, event.item];
          emit(CartLoaded(updatedItems, countTotalItems(updatedItems),
              calculateTotalPrice(updatedItems), false));
        }
      }
    });

    on<RemoveItem>((event, emit) {
      final currentState = state;
      if (currentState is CartLoaded) {
        final updatedItems = currentState.items
            .where((item) => item.id != event.item.id)
            .toList();
        emit(CartLoaded(updatedItems, countTotalItems(updatedItems),
            calculateTotalPrice(updatedItems), true));
      }
    });
       on<UpdateQuantity>((event, emit) {
      final currentState = state;
      if (currentState is CartLoaded) {
        final newQuantity = event.newQuantity.clamp(0, double.infinity); // Clamp to minimum 0
        final updatedItems = currentState.items.map((item) =>
            item.id == event.items.id ? item.copyWith(quantity: newQuantity.toInt()) : item).toList();
        emit(CartLoaded(
            updatedItems, countTotalItems(updatedItems), calculateTotalPrice(updatedItems), false));
      }
    });

    on<ClearCart>((event, emit) {
      emit(
        CartLoaded([], 0, 0.0, false),
      );
    });
  }
  int countTotalItems(List<Items> items) {
    return items.fold(0, (acc, item) => acc + item.quantity);
  }

  double calculateTotalPrice(List<Items> items) {
    return items.fold(
        0.0,
        (acc, item) =>
            acc + (double.parse(item.currentPrice!) * item.quantity));
  }
}
