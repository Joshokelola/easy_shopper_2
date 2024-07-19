import 'package:easy_shopper/main.dart';
import 'package:easy_shopper/views/pages/home.dart';
import 'package:easy_shopper/views/pages/order_history_page.dart';
import 'package:flutter/material.dart';

class OrderSuccessful extends StatelessWidget {
  const OrderSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Success',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Poppins',
              ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                './assets/check.png',
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Order Confirmed !',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                const Text(
                  'Your order has been placed successfully.',
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text('Back to shopping'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
