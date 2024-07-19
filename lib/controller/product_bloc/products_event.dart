part of 'products_bloc.dart';

sealed class ProductsEvent {}

final class GetProductsEvent extends ProductsEvent {}

class AddProductToWishlist extends ProductsEvent {
  final Items item;
  AddProductToWishlist(this.item);
}
class ClearProducts extends ProductsEvent{}