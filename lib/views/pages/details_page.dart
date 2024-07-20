import 'package:checkout_screen_ui/checkout_ui.dart';
import 'package:easy_shopper/views/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:easy_shopper/views/widgets/shopping_cart_widget.dart';

import '../../controller/cart_bloc/bloc/cart_bloc.dart';
import '../../controller/product_bloc/products_bloc.dart';
import '../../model/t_product.dart';

enum ProductDetailsState { Initial, AddedToCart }

class ProductDetailsPage extends StatefulWidget {
  final Items item;
  const ProductDetailsPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProductDetailsState _state = ProductDetailsState.Initial;

  @override
  Widget build(BuildContext context) {
    //final product = widget.products[widget.productIndex];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 24,
            )),
        backgroundColor: Colors.transparent,
        actions: const [
          ShoppingCartWidget(),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: _buildContent(widget.item),
      bottomNavigationBar: _buildBottomBarWithBlocListener(widget.item),
    );
  }

  Widget _buildContent(Items product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 430,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(
                      'https://api.timbu.cloud/images/${product.imageUrl}'))),
        ),
        const SizedBox(
          height: 63,
        ),
        Container(
          margin: const EdgeInsets.only(left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.uniqueId!,
                style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff6E6E6E),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
              const Text(
                'In Stock',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff408C2B),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Container(
          margin: const EdgeInsets.only(left: 40, right: 40),
          child: Text(
            product.name!,
            style: const TextStyle(
                fontSize: 24,
                color: Color(0xff0A0B0A),
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins'),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Container(
          margin: const EdgeInsets.only(left: 40, right: 40),
          child: Text(
            product.description!,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff5A5A5A),
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(Items product) {
    switch (_state) {
      case ProductDetailsState.Initial:
        return Container(
          height: 80,
          //width: double.maxFinite,
          padding: const EdgeInsets.only(left: 40, right: 40),
          color: const Color(0xff408C2B),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                NumberFormat.currency(locale: 'en_US', symbol: '\$').format(
                  (double.parse(product.currentPrice!)) / 1000,
                ),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: const Color(0xffFAFAFA), fontSize: 18),
              ),
              InkWell(
                onTap: () {
                  context.read<CartBloc>().add(AddItem(product));
                  setState(() {
                    _state = ProductDetailsState.AddedToCart;
                  });
                },
                child: Container(
                  width: 152,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.366),
                    border: Border.all(
                      color: const Color(0xffFFFFFF),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Add to cart',
                      style: TextStyle(
                          fontSize: 11.45,
                          fontFamily: 'Poppins',
                          color: Color(0xffFAFAFA)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

      case ProductDetailsState.AddedToCart:
        return Container(
          height: 94,
          decoration: const BoxDecoration(color: Color(0xffE4F5E0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  context.read<CartBloc>().add(RemoveItem(product));
                  setState(() {
                    _state = ProductDetailsState.Initial;
                  });
                },
                child: Container(
                    width: 63,
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff363939)),
                        borderRadius: BorderRadius.circular(4)),
                    child: const Align(
                        alignment: Alignment.center,
                        child: const Text('Cancel'))),
              ),
              const SizedBox(
                width: 40,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Unit Price',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff797A7B),
                    ),
                  ),
                  Text(
                    NumberFormat.currency(locale: 'en_US', symbol: '\$').format(
                      (double.parse(product.currentPrice!) / 1000),
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: const Color(0xff363939), fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                width: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const CheckOutPage();
                    },
                  ));
                },
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const CheckOutPage();
                    }));
                  },
                  child: Container(
                    width: 115,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color(0xff408C2B)),
                    child: const Center(
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            color: Color(0xffFAFAFA)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

      default:
        return Container();
    }
  }

  Widget _buildBottomBarWithBlocListener(Items product) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          var isItemInCart = state.items.contains(product);
          return !isItemInCart
              ? Container(
                  height: 80,
                  //width: double.maxFinite,
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  color: const Color(0xff408C2B),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        NumberFormat.currency(locale: 'en_US', symbol: '\$')
                            .format(
                          (double.parse(product.currentPrice!)) / 1000,
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: const Color(0xffFAFAFA), fontSize: 18),
                      ),
                      InkWell(
                        onTap: () {
                          context.read<CartBloc>().add(AddItem(product));
                          setState(() {
                            _state = ProductDetailsState.AddedToCart;
                          });
                        },
                        child: Container(
                          width: 152,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.366),
                            border: Border.all(
                              color: const Color(0xffFFFFFF),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Add to cart',
                              style: TextStyle(
                                  fontSize: 11.45,
                                  fontFamily: 'Poppins',
                                  color: Color(0xffFAFAFA)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  height: 94,
                  decoration: const BoxDecoration(color: Color(0xffE4F5E0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<CartBloc>().add(RemoveItem(product));
                          setState(() {
                            _state = ProductDetailsState.Initial;
                          });
                        },
                        child: Container(
                            width: 63,
                            height: 48,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff363939)),
                                borderRadius: BorderRadius.circular(4)),
                            child: const Align(
                                alignment: Alignment.center,
                                child: const Text('Cancel'))),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Unit Price',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff797A7B),
                            ),
                          ),
                          Text(
                            NumberFormat.currency(locale: 'en_US', symbol: '\$')
                                .format(
                              (double.parse(product.currentPrice!) / 1000),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: const Color(0xff363939),
                                    fontSize: 18),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const CheckOutPage();
                            },
                          ));
                        },
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const CheckOutPage();
                            }));
                          },
                          child: Container(
                            width: 115,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Color(0xff408C2B)),
                            child: const Center(
                              child: Text(
                                'Checkout',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                    color: Color(0xffFAFAFA)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        }
        return Container();
      },
    );
  }
}
