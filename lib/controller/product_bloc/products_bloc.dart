import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../model/t_product.dart';
import '../repository/get_product_repo.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsRepoImpl _getProductRepoImpl;
  ProductsBloc({
    required GetProductsRepoImpl getProductsRepoImpl,
  })  : _getProductRepoImpl = getProductsRepoImpl,
        super(ProductsInitial()) {
    on<GetProductsEvent>((event, emit) async {
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
    });
  }
}
