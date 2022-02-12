import 'package:flutter/cupertino.dart';
import 'package:flutter_app_validus/screens/profile_page.dart';
import 'package:flutter_app_validus/screens/stocks_page.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;

  final List bodyContent = <Widget>[
    const StocksPage(),
    const ProfilePage(),
  ];
}
