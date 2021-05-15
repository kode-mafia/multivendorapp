import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shapeyou/Screen/homeScreen.dart';
import 'package:shapeyou/Screen/landing_screen.dart';
import 'package:shapeyou/Screen/splash_screen.dart';
import 'package:shapeyou/Screen/welcome_screen.dart';
import 'package:shapeyou/provider/auth_provider.dart';
import 'package:shapeyou/provider/coupon_provider.dart';
import 'package:shapeyou/provider/location_provider.dart';
import 'package:shapeyou/provider/order_provider.dart';
import 'package:shapeyou/provider/store_provider.dart';

import 'Screen/cart_screen.dart';
import 'Screen/login_screen.dart';
import 'Screen/main_screen.dart';
import 'Screen/product_details_screen.dart';
import 'Screen/product_list_screen.dart';
import 'Screen/profile_screen.dart';
import 'Screen/profile_update_screen.dart';
import 'Screen/vendor_home_screen.dart';
import 'provider/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => StoreProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CouponProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF84c225), fontFamily: 'Lato'),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        LandingScreen.id: (context) => LandingScreen(),
        MainScreen.id: (context) => MainScreen(),
        VendorHomeScreen.id: (context) => VendorHomeScreen(),
        ProductListScreen.id: (context) => ProductListScreen(),
        ProductDetailsScreen.id: (context) => ProductDetailsScreen(),
        CartScreen.id: (context) => CartScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        UpdateProfile.id: (context) => UpdateProfile(),
        // ExistingCardsPage.id:(context)=>ExistingCardsPage(),
        // StripeHome.id:(context)=>StripeHome(),
      },
      builder: EasyLoading.init(),
    );
  }
}
