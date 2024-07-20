part of 'search_product_bloc.dart';

sealed class SearchProductEvent extends Equatable {
  const SearchProductEvent();

  @override
  List<Object> get props => [];
}

final class SearchProduct extends SearchProductEvent {
  final String query;

  SearchProduct(this.query);

}
