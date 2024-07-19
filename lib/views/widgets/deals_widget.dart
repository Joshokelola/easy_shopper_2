import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/product_bloc/products_bloc.dart';
import 'product_widget.dart';

class DealsWidget extends StatelessWidget {
  const DealsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
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
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.product.sublist(3, 9).length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:  2,
                      childAspectRatio: 0.78,
                      crossAxisSpacing: isWideScreen ? 16 : 4,
                      mainAxisSpacing: isWideScreen ? 16 : 4,
                    ),
                    itemBuilder: (context, index) {
                      var newProductsList = state.product.sublist(7, 18);
                      return ProductItemWidget(
                        item: newProductsList[index],
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
    );
  }
}
