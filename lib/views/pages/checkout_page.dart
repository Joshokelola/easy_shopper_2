import 'package:checkout_screen_ui/checkout_ui.dart';
import 'package:easy_shopper/controller/cubit/order_item_cubit.dart';
import 'package:easy_shopper/controller/mockPayment/bloc/mock_payment_bloc.dart';
import 'package:easy_shopper/controller/cart_bloc/bloc/cart_bloc.dart';
import 'package:easy_shopper/views/pages/order_successful.dart' as order;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MockPaymentBloc, MockPaymentState>(
        listener: (context, state) {
          if (state is MockPaymentSuccess) {
            context
                .read<OrderItemCubit>()
                .cacheOrders(state.orderedItems, state.orderDate);
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context)
                .pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const order.OrderSuccessful(),
              ),
              (route) => false,
            )
                .then((_) {
             
           
            });
             context.read<CartBloc>().add(ClearCart());
                context.read<MockPaymentBloc>().add(ResetMockPayment());
          }
        },
        builder: (context, state) {
          if (state is MockPaymentInitial) {
            return BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
                if (cartState is CartLoaded) {
                  var items = cartState.items.map((item) {
                    return PriceItem(
                      name: item.name!,
                      quantity: item.quantity,
                      itemCostCents: int.parse(item.currentPrice!) ~/ 10,
                      canEditQuantity: false,
                    );
                  }).toList();
                  items.add(PriceItem(
                    name: 'Delivery Charge',
                    quantity: 1,
                    itemCostCents: 1599,
                    canEditQuantity: false,
                  ));
                  return CheckoutPage(
                    data: CheckoutData(
                      priceItems: items,
                      taxRate: 0,
                      payToName: 'Sharrie\'s Signature Stores',
                      displayNativePay: false,
                      onNativePay: (checkoutResults) =>
                          debugPrint('Native Pay Clicked'),
                      onCardPay: (paymentInfo, checkoutResults) {
                        context.read<MockPaymentBloc>().add(
                              MakeMockPaymentAction(
                                cartState.items,
                                checkoutResults.totalCostCents,
                                DateTime.now(),
                              ),
                            );
                      },
                      onBack: () => Navigator.of(context).pop(),
                      displayTestData: true,
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PaymentOverlay extends StatelessWidget {
  const PaymentOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
