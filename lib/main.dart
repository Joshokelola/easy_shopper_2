
import 'package:easy_shopper/controller/cubit/order_item_cubit.dart';
import 'package:easy_shopper/controller/internetConnectionChecker/bloc/internet_connection_checker_bloc.dart';
import 'package:easy_shopper/controller/mockPayment/bloc/mock_payment_bloc.dart';
import 'package:easy_shopper/controller/cart_bloc/bloc/cart_bloc.dart';
import 'package:easy_shopper/controller/product_bloc/bloc_observer.dart';
import 'package:easy_shopper/controller/product_bloc/products_bloc.dart';
import 'package:easy_shopper/controller/repository/get_product_repo.dart';
import 'package:easy_shopper/views/pages/home.dart';
import 'package:easy_shopper/views/widgets/shopping_cart_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/icons/easy_shopper_icons.dart';
import 'views/pages/profile_page.dart';
import 'views/pages/wishlist_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await dotenv.load(fileName: ".env");
  Bloc.observer = const GetProductsBlocObserver();
  runApp(MultiBlocProvider(
    providers: [
      RepositoryProvider(
        create: (context) => GetProductsRepoImpl(),
      ),
      BlocProvider(create: (context) => InternetConnectionBloc()),
      BlocProvider(
        create: (context) => ProductsBloc(
          getProductsRepoImpl: RepositoryProvider.of(context),
          //  internetConnectionBloc: BlocProvider.value(value: value)
        ),
      ),
      BlocProvider(
        create: (context) => CartBloc(),
      ),
      BlocProvider(
        create: (context) => MockPaymentBloc(),
      ),
      BlocProvider(
        create: (context) => OrderItemCubit(),
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
      const WishlistPage(),
    ];
    return MaterialApp(
    
      // theme: ThemeData.light(),
    
      title: 'Sharrie\'s Signature',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocListener<InternetConnectionBloc, InternetConnectionState>(
        listener: (context, state) {
                  if (state is InternetConnectionDisconnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: const Text('No internet connection'),
                backgroundColor: Colors.red,
               
              ),
            );
          }
                  if (state is InternetConnectionConnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: const Text('internet connection'),
                backgroundColor: Colors.green,
               
              ),
            );
          }
        },
        child: Scaffold(
          body: pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(EasyShopper.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(EasyShopper.vector), label: 'Wishlist'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xff1F2223),
            unselectedItemColor: const Color(0xff9F9C9C),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
