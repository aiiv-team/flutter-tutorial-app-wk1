import 'package:flutter/material.dart';
import 'package:tutorial_app_wk1/src/components/profile_image_button.dart';

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
