import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tutorial_app_wk1/src/components/main_page.dart';
import 'package:tutorial_app_wk1/src/store/application_store.dart';

class App extends StatelessWidget {
  final Store<RootState> store = getStore();

  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<RootState>(
        store: store,
        child:
            MaterialApp(home: MainPage(), debugShowCheckedModeBanner: false));
  }
}
