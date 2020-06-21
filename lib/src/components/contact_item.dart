import 'package:flutter/material.dart';
import 'package:tutorial_app_wk1/src/lib/misc.dart';
import 'package:tutorial_app_wk1/src/store/modules/profile.dart';

const _contactItemTextStyle = TextStyle(fontSize: 16);
const _contactItemHeight = 48.0;
const _contactItemThumbnailSize = 40.0;

class _ContactItemThumbnail extends StatelessWidget {
  final String displayName;
  final double size;
  final Color backgroundColor;
  _ContactItemThumbnail(
      {@required this.displayName,
      @required this.backgroundColor,
      this.size = _contactItemThumbnailSize});

  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(0.5 * size),
      child: SizedBox(
          height: size,
          width: size,
          child: Container(
              decoration: BoxDecoration(color: backgroundColor),
              child: Center(
                  child: Text(displayName.substring(0, 1),
                      style: const TextStyle(
                          color: Colors.white, fontSize: 18))))));
}

class ContactItem extends StatelessWidget {
  final ContactState contactState;
  ContactItem({Key key, @required this.contactState}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      height: _contactItemHeight,
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        _ContactItemThumbnail(
          displayName: contactState.contact.displayName,
          backgroundColor: contactState.thumbnailBackgroundColor,
        ),
        SizedBox(width: 8),
        Text(contactState.contact.displayName, style: _contactItemTextStyle),
        Spacer(),
        Text(formatPhoneNumber(contactState.contact.phones.first.value),
            style: _contactItemTextStyle),
      ]));
}
