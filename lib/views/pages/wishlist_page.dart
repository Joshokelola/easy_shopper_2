import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../controller/cart_bloc/bloc/cart_bloc.dart';
import '../../controller/product_bloc/products_bloc.dart';
import '../../model/t_product.dart';

class WishlistPage extends StatelessWidget {
  // final List<Items> items;
  // final int totalPrice;
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wishlist'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoaded) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.product
                        .where((product) => product.isInWishList!)
                        .toList()
                        .length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var wishlist = state.product
                          .where((product) => product.isInWishList!)
                          .toList();
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 40),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  fit: BoxFit.contain,
                                  'https://api.timbu.cloud/images/${wishlist[index].imageUrl}',
                                  width: 87,
                                  height: 100,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Placeholder(
                                      fallbackWidth: 87,
                                      fallbackHeight: 100,
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      wishlist[index].uniqueId!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        color: Color(0xff6E6E6E),
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 0.96,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        wishlist[index].name!,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff0A0B0A),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context.read<ProductsBloc>().add(
                                            AddProductToWishlist(
                                                wishlist[index]));
                                      },
                                      child: Container(
                                        width: 31,
                                        height: 24,
                                        color: const Color(0xffCC474E),
                                        child: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Unit Price',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        color: Color(0xff6E6E6E),
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 0.96,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      NumberFormat.currency(
                                              locale: 'en_US', symbol: '\$')
                                          .format(
                                        (double.parse(
                                                wishlist[index].currentPrice!) /
                                            1000),
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(
                                      height: 48,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
