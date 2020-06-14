import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tutorial_app_wk1/src/store/application_store.dart';
import 'package:tutorial_app_wk1/src/store/modules/profile.dart';

class _ContactsActionButton extends StatelessWidget {
  final double size;
  final IconData iconData;
  final String tooltipMessage;
  final Function onPressed;
  _ContactsActionButton(
      {@required this.size,
      @required this.iconData,
      @required this.tooltipMessage,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) => Tooltip(
      message: tooltipMessage,
      child: SizedBox(
          width: size,
          height: size,
          child: FlatButton(
            padding: EdgeInsets.zero,
            child: Icon(iconData),
            onPressed: onPressed,
          )));
}

class _ContactsActionBar extends StatelessWidget {
  static const buttonSize = 32.0;

  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Container(
          height: buttonSize,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _ContactsActionButton(
                    tooltipMessage: '검색',
                    size: buttonSize,
                    iconData: Icons.search,
                    onPressed: () {}),
                Spacer(),
                _ContactsActionButton(
                    tooltipMessage: '연락처 추가하기',
                    size: buttonSize,
                    iconData: Icons.add,
                    onPressed: () {}),
                _ContactsActionButton(
                    tooltipMessage: '디바이스에 저장된 연락처 불러오기',
                    size: buttonSize,
                    iconData: Icons.sync,
                    onPressed: () {}),
                _ContactsActionButton(
                    tooltipMessage: '연락처 선택',
                    size: buttonSize,
                    iconData: Icons.more_vert,
                    onPressed: () {}),
              ])));
}

class _ContactsList extends StatelessWidget {
  final List<Contact> contacts;
  _ContactsList({@required this.contacts});

  @override
  Widget build(BuildContext context) => Text(json.encode(this.contacts));
}

class _ContactsProps {
  final List<Contact> contacts;
  final Function retrieveContacts;
  _ContactsProps({@required this.contacts, @required this.retrieveContacts});
}

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) =>
      StoreConnector<RootState, _ContactsProps>(
          converter: (store) => _ContactsProps(
              contacts: store.state.profile.contacts,
              retrieveContacts: () => store.dispatch(retrieveContacts())),
          builder: (context, props) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _ContactsActionBar(),
                      Expanded(
                          child: _ContactsList(
                        contacts: props.contacts,
                      ))
                    ]));
          });
}
