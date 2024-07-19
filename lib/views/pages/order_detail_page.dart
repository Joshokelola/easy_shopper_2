import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/t_product.dart';

class OrderDetailPage extends StatelessWidget {
  final Items orderItem;
  final String orderDate;
  const OrderDetailPage({
    super.key,
    required this.orderItem,
    required this.orderDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 350,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(
                          'https://api.timbu.cloud/images/${orderItem.imageUrl}'))),
            ),
            const SizedBox(
              height: 63,
            ),
            const Text(
              'Ordered',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff408C2B),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              orderItem.name!,
              style: const TextStyle(
                  fontSize: 24,
                  color: Color(0xff0A0B0A),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins'),
            ),
            const SizedBox(
              height: 20,
            ),
            OrderDetailWidget(
              orderDetailTitle: 'Quantity',
              orderDetail: orderItem.quantity.toString(),
            ),   const SizedBox(
              height: 10,
            ),
                   OrderDetailWidget(
              orderDetailTitle: 'Price',
              orderDetail:      NumberFormat.currency(
                                      locale: 'en_US', symbol: '\$')
                                  .format(
                              (  double.parse(orderItem.currentPrice!) / 1000) * orderItem.quantity,
                              ),
            ), 
             const SizedBox(
              height: 10,
            ),
                    OrderDetailWidget(
              orderDetailTitle: 'Date',
              orderDetail: orderDate,
            ),
          ],
        ),
      ),
    );
  }
}

class OrderDetailWidget extends StatelessWidget {
  const OrderDetailWidget({
    Key? key,
   
    required this.orderDetail,
    required this.orderDetailTitle,
  }) : super(key: key);

    final String orderDetail;
  final String orderDetailTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          orderDetailTitle,
          style: const TextStyle(
              fontSize: 18,
              color: Color(0xff0A0B0A),
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins'),
        ),
        Text(
          orderDetail,
          style: const TextStyle(
              fontSize: 18,
              color: Color(0xff0A0B0A),
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins'),
        ),
      ],
    );
  }
}
