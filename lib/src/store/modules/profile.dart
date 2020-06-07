import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';

class SetContactAction {
  final List<Contact> contacts;
  SetContactAction({@required this.contacts});
}

class SetMyNameAction {
  final String name;
  SetMyNameAction({@required this.name});
}

class ProfileState {
  final List<Contact> contacts;
  final String myName;
  ProfileState({@required this.contacts, @required this.myName});
}

ProfileState contactReducer(ProfileState state, action) {
  if (action is SetContactAction) {
    return ProfileState(contacts: action.contacts, myName: state.myName);
  }
  if (action is SetMyNameAction) {
    return ProfileState(contacts: state.contacts, myName: action.name);
  }

  return state;
}

final ProfileState initialProfileState = ProfileState(contacts: [], myName: '');
