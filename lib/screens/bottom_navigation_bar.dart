import 'package:flutter/material.dart';
import 'package:flutter_app_validus/providers/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({Key? key}) : super(key: key);

  @override
  BottomNavigationViewState createState() => BottomNavigationViewState();
}

class BottomNavigationViewState extends State<BottomNavigationView> {
  late BottomNavigationProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = Provider.of<BottomNavigationProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body:
          Center(child: provider.bodyContent.elementAt(provider.selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bar_chart,
              size: 22,
            ),
            label: 'Stocks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 22,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: provider.selectedIndex,
        selectedLabelStyle: Theme.of(context).textTheme.bodyText1,
        unselectedLabelStyle: Theme.of(context).textTheme.bodyText2,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).indicatorColor,
        unselectedItemColor: Theme.of(context).iconTheme.color,
        unselectedIconTheme: Theme.of(context).iconTheme,
        selectedIconTheme: Theme.of(context)
            .iconTheme
            .copyWith(color: Theme.of(context).indicatorColor),
        onTap: (int index) {
          provider.selectedIndex = index;
        },
      ),
    );
  }
}
