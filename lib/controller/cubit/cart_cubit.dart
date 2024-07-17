import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/t_product.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void addItemToCart(Items item) {
    emit(CartItemAdded(1));
    var cartItems = <Items>[];
    cartItems.add(item);
    emit(CartActive(cartItems));
  }
}
