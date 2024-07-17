import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../controller/product_bloc/products_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      if (state is ProductsError) {
        return Text(state.error);
      }
      if (state is ProductsLoaded) {
        return GridView.builder(
            itemCount: state.product.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                        'https://api.timbu.cloud/images/${state.product[index].imageUrl}'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(state.product[index].name!),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      NumberFormat.currency(locale: 'en_NG', symbol: '₦')
                          .format(
                              double.parse(state.product[index].currentPrice!)),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 400,
                      child: FilledButton(
                        style: const ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                        ),
                        onPressed: () {},
                        child: const Text('View Details'),
                      ),
                    )
                  ],
                ),
              );
            });
      }
      if (state is ProductsLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      return Container();
    });
  }
}
