import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_validus/providers/bottom_navigation_provider.dart';
import 'package:flutter_app_validus/providers/profile_provider.dart';
import 'package:flutter_app_validus/providers/stock_provider.dart';
import 'package:flutter_app_validus/screens/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

import 'Util/app_theme.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor:  Color(0XFF171734),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Validus App',
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
          ChangeNotifierProvider(create: (_) => StockProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider())
        ],
        child: const BottomNavigationView(),
      ),
    );
  }
}
