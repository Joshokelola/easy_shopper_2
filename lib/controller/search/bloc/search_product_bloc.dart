import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../model/t_product.dart';
import '../../repository/get_product_repo.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final GetProductsRepoImpl _getProductRepoImpl;
  SearchProductBloc({
    required GetProductsRepoImpl getProductRepoImpl,
  })  : _getProductRepoImpl = getProductRepoImpl,
        super(SearchProductInitial()) {
    on<SearchProduct>((event, emit) async {
      emit(SearchProductLoading());
      var apiKey = dotenv.env['API_KEY'];
      var organisationId = dotenv.env['ORG_ID'];
      var appId = dotenv.env['APP_ID'];

      final res = await _getProductRepoImpl.getProducts(
          apiKey: apiKey!, appId: appId!, organisationId: organisationId!);

      res.fold(
        (l) => emit(SearchProductError(l.message)),
        (r) {
          final searchedProducts = r.where((product) =>
              product.name!.toLowerCase().contains(event.query.toLowerCase()))
              .toList();
          emit(searchedProducts.isNotEmpty
              ? SearchProductLoaded(searchedProducts)
              : SearchProductEmpty());
        },
      );
    });
  }
}
