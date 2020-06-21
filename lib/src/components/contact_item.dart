import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_app_wk1/src/lib/misc.dart';

const _contactItemTextStyle = TextStyle(fontSize: 16);
const _contactItemHeight = 48.0;
const _contactItemThumbnailSize = 40.0;

class _ContactItemThumbnail extends StatelessWidget {
  final String displayName;
  final double size;
  _ContactItemThumbnail(
      {@required this.displayName, this.size = _contactItemThumbnailSize});

  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(0.5 * size),
      child: SizedBox(
          height: size,
          width: size,
          child: Container(
              decoration: BoxDecoration(color: getRandomColor()),
              child: Center(
                  child: Text(displayName.substring(0, 1),
                      style: const TextStyle(
                          color: Colors.white, fontSize: 18))))));
}

class ContactItem extends StatelessWidget {
  final Contact contact;
  ContactItem({@required this.contact});

  @override
  Widget build(BuildContext context) => Container(
      height: _contactItemHeight,
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        _ContactItemThumbnail(displayName: contact.displayName),
        SizedBox(width: 8),
        Text(contact.displayName, style: _contactItemTextStyle),
        Spacer(),
        Text(formatPhoneNumber(contact.phones.first.value),
            style: _contactItemTextStyle),
      ]));
}
