import 'package:easy_shopper/views/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/product_bloc/products_bloc.dart';

class RecommendedItemsWidget extends StatefulWidget {
  const RecommendedItemsWidget({super.key});

  @override
  State<RecommendedItemsWidget> createState() => _RecommendedItemsWidgetState();
}

class _RecommendedItemsWidgetState extends State<RecommendedItemsWidget> {
  // void initState() {
  //   super.initState();
  //   context.read<ProductsBloc>().add(GetProductsEvent());
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProductsLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductsLoaded) {
          if (state.product.isEmpty) {
            return const Center(
              child: Text('No products found'), // Handle empty list
            );
          }
          return SizedBox(
            height: 230,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.product.sublist(0, 3).length,
              itemBuilder: (context, index) {
                return ProductItemWidget(
                  productIndex: index,
                  items: state.product.sublist(0, 3),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
