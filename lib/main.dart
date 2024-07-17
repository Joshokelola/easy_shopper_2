import 'package:easy_shopper/controller/cart_bloc/bloc/cart_bloc.dart';
import 'package:easy_shopper/controller/product_bloc/bloc_observer.dart';
import 'package:easy_shopper/controller/product_bloc/products_bloc.dart';
import 'package:easy_shopper/controller/repository/get_product_repo.dart';
import 'package:easy_shopper/views/pages/home.dart';
import 'package:easy_shopper/views/widgets/shopping_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/icons/easy_shopper_icons.dart';
import 'views/pages/profile_page.dart';
import 'views/pages/wishlist_page.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  Bloc.observer = const GetProductsBlocObserver();
  runApp(MultiBlocProvider(
    providers: [
      RepositoryProvider(
        create: (context) => GetProductsRepoImpl(),
      ),
      BlocProvider(
        create: (context) => ProductsBloc(
          getProductsRepoImpl: RepositoryProvider.of(context),
        ),
      ),
      BlocProvider(
        create: (context) => CartBloc(),
      ),
    ],
    //  create: (context) => GetProductsRepoImpl(),

    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const WishListPage(),
      const ProfilePage(),
    ];
    return MaterialApp(
      title: 'Sharrie\'s Signature',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:  pages[_selectedIndex],
         bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(EasyShopper.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(EasyShopper.vector), label: 'Wishlist'),
          BottomNavigationBarItem(
              icon: Icon(EasyShopper.user), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff1F2223),
        unselectedItemColor: const Color(0xff9F9C9C),
        onTap: _onItemTapped,
      ),
      ),
    );
  }
}
