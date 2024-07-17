import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/cart_bloc/bloc/cart_bloc.dart';
import '../pages/cart_page.dart';

class ShoppingCartWidget extends StatelessWidget {
  const ShoppingCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var cartItems = 0;
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartLoaded) {
          cartItems = state.totalItems;
        }
      },
      builder: (context, state) {
        if (state is CartInitial) {
          return const Badge(
            label: Text('0'),
            child: Icon(Icons.shopping_cart_outlined),
          );
        }
        if (state is CartLoaded ) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const Dialog.fullscreen(
                  child: ShoppingCartPage(),
                );
              }));
            },
            child: Badge(
              label: Text('${state.items.length}'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          );
        }
        return Container();
      },
    );
  }
}
