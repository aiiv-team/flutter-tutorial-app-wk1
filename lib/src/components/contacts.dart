import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tutorial_app_wk1/src/components/contact_item.dart';
import 'package:tutorial_app_wk1/src/lib/misc.dart';
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
  static const barSize = 40.0;

  final Function retrieveContacts;

  _ContactsActionBar({@required this.retrieveContacts});

  @override
  Widget build(BuildContext context) => Container(
      child: Container(
          height: barSize,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset(0, 4),
            )
          ]),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        onPressed: retrieveContacts),
                    _ContactsActionButton(
                        tooltipMessage: '연락처 선택',
                        size: buttonSize,
                        iconData: Icons.more_vert,
                        onPressed: () {}),
                  ]))));
}

class _ContactsList extends StatelessWidget {
  final FetchState contactsFetchState;
  final List<Contact> contacts;
  final Function retrieveContacts;
  _ContactsList(
      {@required this.contactsFetchState,
      @required this.contacts,
      @required this.retrieveContacts});

  @override
  Widget build(BuildContext context) {
    switch (contactsFetchState) {
      case FetchState.Pending:
        return Center(child: CircularProgressIndicator());
      case FetchState.Success:
        return ListView.builder(
          key: PageStorageKey('KEY_CONTACTS_LIST'),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (_, i) => ContactItem(contact: contacts[i]),
        );
      case FetchState.PermissionError:
        return Center(child: Text('주소록에 접근할 권한이 없습니다.'));
      case FetchState.None:
      default:
        return Center(
            child: FlatButton(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.sync,
                size: 64,
                color: Colors.black26,
              ),
              Text('연락처 불러오기', style: const TextStyle(color: Colors.black26))
            ],
          ),
          onPressed: retrieveContacts,
        ));
    }
  }
}

class _ContactsProps {
  final FetchState contactsFetchState;
  final List<Contact> contacts;
  final Function retrieveContacts;
  _ContactsProps(
      {@required this.contactsFetchState,
      @required this.contacts,
      @required this.retrieveContacts});
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
              contactsFetchState: store.state.profile.contactsFetchState,
              contacts: store.state.profile.contacts,
              retrieveContacts: () => store.dispatch(retrieveContacts())),
          builder: (context, props) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _ContactsActionBar(retrieveContacts: props.retrieveContacts),
                  Expanded(
                      child: _ContactsList(
                    contactsFetchState: props.contactsFetchState,
                    contacts: props.contacts,
                    retrieveContacts: props.retrieveContacts,
                  ))
                ]);
          });
}
