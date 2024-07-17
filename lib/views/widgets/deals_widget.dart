import 'package:easy_shopper/views/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/product_bloc/products_bloc.dart';

class DealsWidget extends StatefulWidget {
  const DealsWidget({super.key});

  @override
  State<DealsWidget> createState() => _DealsWidgetState();
}

class _DealsWidgetState extends State<DealsWidget> {
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
            margin: const EdgeInsets.only(left: 40, right: 10),
            height: 724,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.product.sublist(3, 9).length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.78,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ProductItemWidget(
                
                  productIndex: index,
                  items: state.product.sublist(3, 9),
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
