import 'package:flutter/material.dart';
import 'package:tutorial_app_wk1/src/components/my_profile.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[MyProfile()]));
  }
}
