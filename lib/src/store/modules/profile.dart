import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:tutorial_app_wk1/src/store/application_store.dart';

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

ThunkAction<RootState> retrieveContacts() {
  return (Store<RootState> store) async {
    final contacts = await ContactsService.getContacts();
    store.dispatch(SetContactAction(contacts: contacts.toList()));
  };
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
