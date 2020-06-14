import 'package:flutter/material.dart';
import 'package:tutorial_app_wk1/src/components/contacts.dart';
import 'package:tutorial_app_wk1/src/components/my_profile.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[MyProfile(), Expanded(child: Contacts())])));
  }
}
