part of 'products_bloc.dart';

sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final List<Items> product;
  ProductsLoaded(this.product);
}

final class ProductsError extends ProductsState {
  final String error;
  ProductsError(this.error);
}
