import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:easy_shopper/controller/product_bloc/products_bloc.dart';
import 'package:easy_shopper/model/t_product.dart';
import 'package:easy_shopper/views/pages/details_page.dart';

import '../../controller/cart_bloc/bloc/cart_bloc.dart';

class ProductItemWidget extends StatelessWidget {
  final Items item;
  //Function addToCart;
  const ProductItemWidget({
    Key? key,
    //required this.addToCart,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return ProductDetailsPage(
                item: item,
              );
            },
          ),
        );
      },
      child: Container(
        width: 180,
        // color: Colors.red,
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.45),
                      border: Border.all(
                          color: const Color(0xffE3E3E3), width: 0.3),
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                            'https://api.timbu.cloud/images/${item.imageUrl}'),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        context
                            .read<ProductsBloc>()
                            .add(AddProductToWishlist(item));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('${item.name!} ${item.isInWishList!
                          ? 'removed from wishlist' : 'added to wishlist'}.'),
                        ));
                      },
                      icon: item.isInWishList
                          ? const Tooltip(
                            message: 'Remove from wishlist',
                            child:  Icon(Icons.favorite))
                          :const Tooltip(
                            message: 'Add  to wishlist',
                            child:  Icon(Icons.favorite_outline)),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        item.name!,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff797A7B),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                    Text(
                        NumberFormat.currency(
                                      locale: 'en_US', symbol: '\$')
                                  .format(
                              (  double.parse(item.currentPrice!) / 1000),),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff363939),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        // debugPrint(state.items.toString());
                        context.read<CartBloc>().add(AddItem(item));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('${item.name!} added to cart.'),
                        ));
                      },
                      child: Container(
                        width: 66,
                        height: 34,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.366),
                            border: Border.all(
                              color: const Color(0xff408C2B),
                            )),
                        child: const Center(
                          child: Text(
                            'Add to cart',
                            style:
                                TextStyle(fontSize: 10, fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
