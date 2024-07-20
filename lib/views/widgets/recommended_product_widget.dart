import 'package:easy_shopper/views/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
    final ItemScrollController itemScrollController = ItemScrollController();
    final ScrollOffsetController scrollOffsetController =
        ScrollOffsetController();
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();
    final ScrollOffsetListener scrollOffsetListener =
        ScrollOffsetListener.create();
     var index = 0;
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
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: Row(
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
                              onPressed: () {
                                  itemScrollController.scrollTo(
                                index: 0,
                                duration: const Duration(
                                  milliseconds: 500,
                                ),
                                curve: Curves.easeInOut,
                              );
                              },
                              icon:  const Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: 
                                Color(0xffD2D3D3),
                              )),
                        ),
                        SizedBox(
                          width: 20,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                index++;
                              });
                              itemScrollController.scrollTo(
                                index: index,
                                duration: const Duration(
                                  milliseconds: 500,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 230,
                child: ScrollablePositionedList.builder(
                  itemScrollController: itemScrollController,
                  scrollOffsetController: scrollOffsetController,
                  itemPositionsListener: itemPositionsListener,
                  scrollOffsetListener: scrollOffsetListener,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    var randomProducts = state.product.sublist(5, 10);
                    // randomProducts.shuffle();
                    return ProductItemWidget(
                      item: randomProducts[index],
                    );
                  },
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
