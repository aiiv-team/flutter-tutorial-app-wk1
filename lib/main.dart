import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tutorial_app_wk1/src/store/application_store.dart';

import 'src/components/profile_image_button.dart';

void main() => runApp(App());

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

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[ProfileImageButton()])));
  }
}
