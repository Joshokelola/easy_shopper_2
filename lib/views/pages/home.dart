import 'package:easy_shopper/controller/cart_bloc/bloc/cart_bloc.dart';
import 'package:easy_shopper/model/t_product.dart';
import 'package:easy_shopper/views/widgets/collections_widget.dart';
import 'package:easy_shopper/views/widgets/deals_widget.dart';
import 'package:easy_shopper/views/widgets/recommended_product_widget.dart';
import 'package:easy_shopper/views/widgets/shopping_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/product_bloc/products_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              'Sharrie\'s Signature',
              style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff408c2b),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Redressed'),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 40),
            child: const ShoppingCartWidget(),
          )
        ],
      ),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        physics: const ClampingScrollPhysics(),
        children: [
          Container(
            margin: const EdgeInsets.only(left: 40, right: 40, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome, Jane',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff0A0B0A),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 350,
                  height: 48,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search_outlined),
                      contentPadding: const EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: const BorderSide(color: Color(0xffD2D3D3)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Just for you',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff363939),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Lora'),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: Color(0xffD2D3D3),
                              )),
                        ),
                        SizedBox(
                          width: 20,
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 40),
              child: const RecommendedItemsWidget()),
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Deals for you',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff363939),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Lora',
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
              ],
            ),
          ),
           const SizedBox(
            height: 20,
          ),
          const DealsWidget(),
          const SizedBox(
            height: 45,
          ),
          Container(
            margin: const EdgeInsets.only(left: 40, right: 40),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Our Collections',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff363939),
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Poppins',
                    height: 2,
                    letterSpacing: 6,
                  ),
                ),
                Divider(
                  height: 1,
                  color: Color(0xffCCCBCB),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(height: 450, child: CollectionsWidget()),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
