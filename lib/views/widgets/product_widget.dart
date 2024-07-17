import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:easy_shopper/model/t_product.dart';
import 'package:easy_shopper/views/pages/details_page.dart';

import '../../controller/cart_bloc/bloc/cart_bloc.dart';

class ProductItemWidget extends StatelessWidget {
  final int productIndex;
  final List<Items> items;
  //Function addToCart;
  const ProductItemWidget({
    super.key,
    required this.productIndex,
    required this.items,
    //required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return ProductDetailsPage(
                products: items,
                productIndex: productIndex,
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.45),
                  border:
                      Border.all(color: const Color(0xffE3E3E3), width: 0.3),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(
                        'https://api.timbu.cloud/images/${items[productIndex].imageUrl}'),
                  ),
                ),
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
                        items[productIndex].name!,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff797A7B),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                    Text(
                      NumberFormat.currency(locale: 'en_NG', symbol: '₦')
                          .format(
                              double.parse(items[productIndex].currentPrice!)),
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
                        context
                            .read<CartBloc>()
                            .add(AddItem(items[productIndex]));
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
