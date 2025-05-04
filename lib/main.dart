import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import screens
import 'screens/restaurant_list_screen.dart';
import 'screens/restaurant_detail_screen.dart';
import 'screens/food_detail_screen.dart';
import 'screens/cart_screen.dart';

// Import providers
import 'providers/cart_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Food Ordering App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF1F7A7A),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF1F7A7A),
            secondary: const Color(0xFFFF7F50),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1F7A7A),
            centerTitle: true,
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F7A7A),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Roboto',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const RestaurantListScreen(),
          '/restaurant': (context) => const RestaurantDetailScreen(),
          '/food-detail': (context) => const FoodDetailScreen(),
          '/cart': (context) => const CartScreen(),
        },
      ),
    );
  }
}