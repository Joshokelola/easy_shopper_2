import 'package:easy_shopper/views/pages/categories_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/product_bloc/products_bloc.dart';

class CollectionsWidget extends StatelessWidget {
  const CollectionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> collectionImagePaths = [
      'assets/sandal_category.jpeg',
      'assets/sneaker_category.jpeg',
      'assets/dress_shoe.jpeg',
      'assets/category_loafers.jpg',
    ];

    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoaded) {
          var categories = state.product
              .map((product) {
                return product.category.productCategoryName;
              })
              .toSet()
              .toList();
          debugPrint(categories.toString());
          return GridView.builder(
              itemCount: categories.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return CategoriesPage(title:   categories[index].isEmpty
                            ? categories[index]
                            : categories[index][0].toUpperCase() +
                                categories[index].substring(1),);
                      },
                    ));
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 160,
                        height: 176,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            collectionImagePaths[index],
                          ),
                        )),
                      ),
                      Text(
                        categories[index].isEmpty
                            ? categories[index]
                            : categories[index][0].toUpperCase() +
                                categories[index].substring(1),
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff0A0B0A),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins'),
                      )
                    ],
                  ),
                );
              });
        }
        return Container();
      },
    );
  }
}
