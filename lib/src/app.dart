import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tutorial_app_wk1/src/components/gallery.dart';
import 'package:tutorial_app_wk1/src/components/profile_page.dart';
import 'package:tutorial_app_wk1/src/providers/environment_provider.dart';
import 'package:tutorial_app_wk1/src/store/application_store.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedPageIndex = 0;
  final List<Widget> _pages = <Widget>[
    ProfilePage(),
    Gallery(),
  ];
  final List<BottomNavigationBarItem> _navItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.phone), title: Text('연락처')),
    BottomNavigationBarItem(icon: Icon(Icons.image), title: Text('갤러리')),
  ];
  final Store<RootState> _store = getStore();

  @override
  Widget build(BuildContext context) {
    return EnvironmentProvider.fromDotEnv(StoreProvider<RootState>(
        store: _store,
        child: MaterialApp(
            home: Scaffold(
              body: Center(child: _pages[_selectedPageIndex]),
              bottomNavigationBar: BottomNavigationBar(
                  items: _navItems,
                  currentIndex: _selectedPageIndex,
                  selectedItemColor: Colors.teal.shade400,
                  selectedFontSize: 12,
                  onTap: _setPage),
            ),
            debugShowCheckedModeBanner: false)));
  }

  void _setPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
}
