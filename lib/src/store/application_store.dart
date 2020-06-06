import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:tutorial_app_wk1/src/store/modules/contact.dart';

class RootState {
  final List<Contact> contact;

  RootState({@required this.contact});
}

RootState _combinedReducer(RootState state, action) =>
    new RootState(contact: contactReducer(state.contact, action));

Store<RootState> getStore() => new Store<RootState>(_combinedReducer,
    initialState: RootState(contact: initialContact), middleware: []);
