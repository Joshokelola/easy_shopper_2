import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../model/t_product.dart';
import '../repository/get_product_repo.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends HydratedBloc<ProductsEvent, ProductsState> {
  final GetProductsRepoImpl _getProductRepoImpl;
  ProductsBloc({
    required GetProductsRepoImpl getProductsRepoImpl,
  })  : _getProductRepoImpl = getProductsRepoImpl,
        super(ProductsInitial()) {
    on<GetProductsEvent>((event, emit) async {
      var currentState = state;
      if (currentState is! ProductsLoaded) {
        emit(ProductsLoading());
        var apiKey = dotenv.env['API_KEY'];
        var organisationId = dotenv.env['ORG_ID'];
        var appId = dotenv.env['APP_ID'];

        final res = await _getProductRepoImpl.getProducts(
            apiKey: apiKey!, appId: appId!, organisationId: organisationId!);
        res.fold((onLeft) {
          emit(ProductsError(onLeft.message));
        }, (onRight) {
          emit(ProductsLoaded(onRight));
        });
      }
    });

    on<AddProductToWishlist>((event, emit) async {
      final currentState = state;
      if (currentState is ProductsLoaded) {
        final updatedItems = currentState.product.map((item) {
          if (item.id == event.item.id) {
            return item.copyWith(isInWishList: !item.isInWishList);
          } else {
            return item;
          }
        }).toList();
        emit(ProductsLoaded(updatedItems));
      }
    });
  }

  @override
  ProductsState? fromJson(Map<String, dynamic> json) {
    debugPrint('From json called (Products)');
    if (state is ProductsInitial) {
      return ProductsLoaded(
        (json['products'] as List)
            .map((product) => Items.fromJson(product))
            .toList(),
      );
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(ProductsState state) {
    debugPrint('To json called (Products)');
    if (state is ProductsLoaded) {
      return {
        'products': state.product.map((product) => product.toJson()).toList(),
      };
    }
    return null;
  }
}
