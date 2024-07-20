import 'package:easy_shopper/controller/product_bloc/products_bloc.dart';
import 'package:easy_shopper/main.dart';
import 'package:easy_shopper/views/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:easy_shopper/controller/cart_bloc/bloc/cart_bloc.dart';
import 'package:easy_shopper/views/widgets/product_widget.dart';
import 'package:intl/intl.dart';

import '../../model/t_product.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartLoaded) {
            final itemsWithZeroQuantity =
                state.items.where((item) => item.quantity == 0);
            for (final item in itemsWithZeroQuantity) {
              context.read<CartBloc>().add(RemoveItem(item));
            }
          }
        },
        builder: (context, state) {
          if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoaded) {
                    return ShoppingCartEmpty(
                        recentlyViewedItem: state.product[0]);
                  }
                  return Container();
                },
              );
            }
            return ShoppingCartActive(
              items: state.items,
              totalPrice: state.totalPrice.toInt(),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class ShoppingCartActive extends StatelessWidget {
  final List<Items> items;
  final int totalPrice;
  const ShoppingCartActive(
      {super.key, required this.items, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          fit: BoxFit.contain,
                          'https://api.timbu.cloud/images/${items[index].imageUrl}',
                          errorBuilder: (context, error, stackTrace) {
                            return const Placeholder(
                              fallbackWidth: 87,
                              fallbackHeight: 100,
                            );
                          },
                          width: 87,
                          height: 100,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              items[index].uniqueId!,
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
                                items[index].name!,
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
                            Row(
                              children: [
                                ProductCounter(items: items, index: index),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<CartBloc>()
                                        .add(RemoveItem(items[index]));
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
                                (double.parse(items[index].currentPrice!) /
                                    1000),
                              ),
                              style: Theme.of(context).textTheme.titleMedium,
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
          ),
          Container(
            height: 335,
            width: 380,
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff408C2B),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Cart Summary',
                  style: TextStyle(
                    fontFamily: 'Lora',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sub-total',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Text(
                      NumberFormat.currency(locale: 'en_US', symbol: '\$')
                          .format(totalPrice / 1000),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: const Color(0xff6E6E6E),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Delivery',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Text(
                      '\$15.00',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: const Color(0xff6E6E6E),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(
                  height: 1,
                  color: Color(0xffCCCBCB),
                  indent: 13.5,
                  endIndent: 13.5,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<CartBloc>().add(ClearCart());
                      },
                      child: Container(
                          width: 70,
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff363939)),
                              borderRadius: BorderRadius.circular(4)),
                          child: const Align(
                              alignment: Alignment.center,
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                    color: Color(0xff363939)),
                              ))),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total amount',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff797A7B),
                          ),
                        ),
                        Text(
                          NumberFormat.currency(locale: 'en_US', symbol: '\$')
                              .format((totalPrice / 1000 + 15)),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: const Color(0xff363939), fontSize: 18),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return CheckOutPage();
                          },
                        ));
                      },
                      child: Container(
                        width: 95,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xff408C2B)),
                        child: const Center(
                          child: Text(
                            'Checkout',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                color: Color(0xffFAFAFA)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProductCounter extends StatelessWidget {
  const ProductCounter({
    super.key,
    required this.items,
    required this.index,
  });

  final List<Items> items;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 134,
      height: 36,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(
        color: const Color(0xff818181),
        width: 0.338,
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              context
                  .read<CartBloc>()
                  .add(UpdateQuantity(items[index], items[index].quantity - 1));
            },
            child: const Icon(
              Icons.remove,
              size: 20,
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Text(
            items[index].quantity.toString(),
            style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            width: 24,
          ),
          InkWell(
            onTap: () {
              context.read<CartBloc>().add(AddItem(items[index]));
            },
            child: const Icon(
              Icons.add,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class ShoppingCartEmpty extends StatelessWidget {
  final Items recentlyViewedItem;
  const ShoppingCartEmpty({
    Key? key,
    required this.recentlyViewedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 80,
          ),
          Image.asset(
            './assets/shopping-cart.png',
            height: 64,
            width: 64,
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.center,
            child: const Text(
              'Your Cart is empty!',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Lora',
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Explore our collections today and start your journey\ntowards radiant beauty. Your skin will thank you',
            style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Align(
            child: SizedBox(
              width: 160,
              height: 48,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const MyApp();
                  }));
                },
                style: const ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(Color(0xff408C2B))),
                child: const Text(
                  'Start shopping',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Container(
            margin: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recently Viewed',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff363939),
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins',
                          height: 2,
                          letterSpacing: 6,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'View all',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff797A7B),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ]),
                const Divider(
                  height: 1,
                  color: Color(0xffCCCBCB),
                ),
                const SizedBox(
                  height: 59,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 200,
                    child: ProductItemWidget(
                      item: recentlyViewedItem,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
