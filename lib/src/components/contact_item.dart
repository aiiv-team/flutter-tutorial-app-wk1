import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  ContactItem({@required this.contact});

  @override
  Widget build(BuildContext context) => Container(
      height: 36,
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        Text(contact.displayName),
        Spacer(),
        Text(contact.phones.first.value),
      ]));
}
