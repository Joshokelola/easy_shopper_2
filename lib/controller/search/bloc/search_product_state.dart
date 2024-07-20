part of 'search_product_bloc.dart';

sealed class SearchProductState extends Equatable {
  const SearchProductState();

  @override
  List<Object> get props => [];
}

final class SearchProductInitial extends SearchProductState {}
final class SearchProductEmpty extends SearchProductState {}

final class SearchProductError extends SearchProductState {
  final String msg;
  SearchProductError(this.msg);
}

final class SearchProductLoading extends SearchProductState {}

final class SearchProductLoaded extends SearchProductState {
  final List<Items> searchedItems;
  const SearchProductLoaded(this.searchedItems);
}
