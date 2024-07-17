part of 'cart_bloc.dart';

sealed class CartEvent {}

class AddItem extends CartEvent {
  final Items item;
  AddItem(this.item);
}

class RemoveItem extends CartEvent {
  final Items item;
  RemoveItem(this.item);
}

class UpdateQuantity extends CartEvent {
  final Items items;
  final int newQuantity;
  UpdateQuantity(this.items, this.newQuantity);
}

class ClearCart extends CartEvent {}
