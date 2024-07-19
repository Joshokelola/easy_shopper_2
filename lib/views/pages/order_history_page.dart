import 'package:easy_shopper/controller/cubit/order_item_cubit.dart';
import 'package:easy_shopper/views/pages/home.dart';
import 'package:easy_shopper/views/pages/order_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
              icon: IconButton(
                  onPressed: () {
                    context.read<OrderItemCubit>().clearOrders();
                  },
                  icon: Icon(Icons.delete)))
        ],
      ),
      body: BlocBuilder<OrderItemCubit, OrderItemState>(
        builder: (context, state) {
          if (state is OrderItemCached) {
            return ListView.builder(
                itemCount: state.orderedItems.length,
                itemBuilder: (context, index) {
                  var formattedDate =
                      DateFormat('d MMMM yyyy').format(state.orderedDates[0]);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: InkWell(
                             onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return OrderDetailPage(
                              orderItem: state.orderedItems[index],
                              orderDate: formattedDate);
                        },
                      ));
                    },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                fit: BoxFit.contain,
                                'https://api.timbu.cloud/images/${state.orderedItems[index].imageUrl}',
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
                                    state.orderedItems[index].uniqueId!,
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
                                      state.orderedItems[index].name!,
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
                                    'Ordered',
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
                                      formattedDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
