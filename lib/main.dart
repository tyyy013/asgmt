import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import screens
import 'screens/restaurant_list_screen.dart';
import 'screens/restaurant_detail_screen.dart';
import 'screens/food_detail_screen.dart';
import 'screens/cart_screen.dart';

// Import providers
import 'providers/cart_provider.dart';
import 'providers/filter_provider.dart';
import 'providers/restaurant_provider.dart'; // Add this import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FilterProvider()),
        ChangeNotifierProvider(create: (context) => RestaurantProvider()), // Add this provider
      ],
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