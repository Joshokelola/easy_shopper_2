part of 'cart_bloc.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<Items> items;
  final int totalItems;
  final double totalPrice;
  final bool itemRemoved;

  CartLoaded(this.items, this.totalItems, this.totalPrice, this.itemRemoved);

  @override
  List<Object> get props => [items, totalItems, totalPrice];
}

final class CartError extends CartState {
  final String errorMsg;

  CartError(this.errorMsg);
}
