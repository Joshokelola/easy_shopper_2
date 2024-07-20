import 'package:easy_shopper/views/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../controller/search/bloc/search_product_bloc.dart';

class ProductSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  void showResults(BuildContext context) {
    context.read<SearchProductBloc>().add(SearchProduct(query));
    super.showResults(context);
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<SearchProductBloc, SearchProductState>(
      builder: (context, state) {
        if (state is SearchProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchProductEmpty) {
          return const Center(
            child: Text('No Products Found'),
          );
        } else if (state is SearchProductError) {
          return const Center(
            child: Text('Error Loading Products!'),
          );
        } else if (state is SearchProductLoaded) {
          var filteredProducts = state.searchedItems;
          return Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductDetailsPage(
                            item: filteredProducts[index],
                          );
                        },
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            fit: BoxFit.contain,
                            'https://api.timbu.cloud/images/${filteredProducts[index].imageUrl}',
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
                                filteredProducts[index].uniqueId!,
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
                                  filteredProducts[index].name!,
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
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Unit Price',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  color: Color(0xff408C2B),
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 0.96,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  NumberFormat.currency(
                                          locale: 'en_US', symbol: '\$')
                                      .format(
                                    (double.parse(filteredProducts[index]
                                            .currentPrice!) /
                                        1000),
                                  ),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Text('data');
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('suggestions');
  }
}
