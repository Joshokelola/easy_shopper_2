import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/product_bloc/products_bloc.dart';
import '../widgets/product_widget.dart';
import '../widgets/shopping_cart_widget.dart';

class AllproductsPage extends StatelessWidget {
  const AllproductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 40),
              child: const ShoppingCartWidget(),
            )
          ],
        ),
        body: SafeArea(
          child: BlocConsumer<ProductsBloc, ProductsState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is ProductsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProductsLoaded) {
                return Container(
                  margin: const EdgeInsets.only(left: 30, right: 10),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isWideScreen = constraints.maxWidth >= 479;
                      return SizedBox(
                        height: 800,
                        child: GridView.builder(
                          itemCount: state.product.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.78,
                            crossAxisSpacing: isWideScreen ? 16 : 4,
                            mainAxisSpacing: isWideScreen ? 16 : 4,
                          ),
                          itemBuilder: (context, index) {
                            //    var newProductsList = state.product.sublist(7, 18);
                            return ProductItemWidget(
                              item: state.product[index],
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              }
              return const Center(child: Text('No Products'));
            },
          ),
        ));
  }
}
