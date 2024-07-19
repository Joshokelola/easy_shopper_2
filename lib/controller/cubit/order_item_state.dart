part of 'order_item_cubit.dart';

abstract class OrderItemState extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderItemInitial extends OrderItemState {}

class OrderItemCached extends OrderItemState {
  final List<Items> orderedItems;
  final List<DateTime> orderedDates;

  OrderItemCached(this.orderedItems, this.orderedDates);

  @override
  List<Object> get props => [orderedItems, orderedDates];

  Map<String, dynamic> toJson() => {
        'orderedItems': orderedItems.map((item) => item.toJson()).toList(),
        'orderedDates': orderedDates.map((date) => date.toIso8601String()).toList(),
      };

  static OrderItemCached fromJson(Map<String, dynamic> json) {
    return OrderItemCached(
      (json['orderedItems'] as List)
          .map((item) => Items.fromJson(item))
          .toList(),
      (json['orderedDates'] as List).map((date) => DateTime.parse(date)).toList(),
    );
  }
}

