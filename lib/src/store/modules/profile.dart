import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:tutorial_app_wk1/src/lib/misc.dart';
import 'package:tutorial_app_wk1/src/store/application_store.dart';

class RequestContactAction {}

class RequestContactPermissionErrorAction {}

class SetContactAction {
  final List<Contact> contacts;
  SetContactAction({@required this.contacts});
}

class SetMyNameAction {
  final String name;
  SetMyNameAction({@required this.name});
}

class ProfileState {
  final FetchState contactsFetchState;
  final List<Contact> contacts;
  final String myName;
  ProfileState(
      {@required this.contactsFetchState,
      @required this.contacts,
      @required this.myName});
}

ThunkAction<RootState> retrieveContacts() {
  return (Store<RootState> store) async {
    Future<void> fetch() async {
      store.dispatch(RequestContactAction());
      final contacts = await ContactsService.getContacts(withThumbnails: false);
      store.dispatch(SetContactAction(contacts: contacts.toList()));
    }

    PermissionStatus status = await Permission.contacts.status;
    switch (status) {
      case PermissionStatus.undetermined:
        if (await Permission.contacts.request().isGranted) {
          await fetch();
        } else {
          store.dispatch(RequestContactPermissionErrorAction());
        }
        break;
      case PermissionStatus.granted:
        await fetch();
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
      default:
        store.dispatch(RequestContactPermissionErrorAction());
        break;
    }
  };
}

ProfileState contactReducer(ProfileState state, action) {
  if (action is RequestContactAction) {
    return ProfileState(
        contactsFetchState: FetchState.Pending,
        contacts: state.contacts,
        myName: state.myName);
  }
  if (action is RequestContactPermissionErrorAction) {
    return ProfileState(
        contactsFetchState: FetchState.PermissionError,
        contacts: state.contacts,
        myName: state.myName);
  }
  if (action is SetContactAction) {
    return ProfileState(
        contactsFetchState: FetchState.Success,
        contacts: action.contacts,
        myName: state.myName);
  }
  if (action is SetMyNameAction) {
    return ProfileState(
        contactsFetchState: state.contactsFetchState,
        contacts: state.contacts,
        myName: action.name);
  }

  return state;
}

final ProfileState initialProfileState =
    ProfileState(contactsFetchState: FetchState.None, contacts: [], myName: '');
