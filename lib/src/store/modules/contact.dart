import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';

class SetContactAction {
  final List<Contact> contacts;
  SetContactAction({@required this.contacts});
}

List<Contact> contactReducer(List<Contact> state, action) {
  if (action is SetContactAction) {
    return action.contacts;
  }

  return state;
}

final List<Contact> initialContact = [];
