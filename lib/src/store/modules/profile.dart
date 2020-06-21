import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:tutorial_app_wk1/src/lib/misc.dart';
import 'package:tutorial_app_wk1/src/store/application_store.dart';

class RequestContactAction {}

class RequestContactPermissionErrorAction {}

class SetContactsAction {
  final List<ContactState> contacts;
  SetContactsAction({@required this.contacts});
}

class SetContactsSearchAction {
  final String searchString;
  SetContactsSearchAction({@required this.searchString});
}

class SetMyNameAction {
  final String name;
  SetMyNameAction({@required this.name});
}

class SetProfileImageAction {
  final String profileImagePath;
  SetProfileImageAction({@required this.profileImagePath});
}

class ContactState {
  final Contact contact;
  final Color thumbnailBackgroundColor;
  ContactState(
      {@required this.contact, @required this.thumbnailBackgroundColor});
}

class ProfileState {
  final FetchState contactsFetchState;
  final List<ContactState> contacts;
  final String contactsSearch;
  final String myName;
  final String myProfileImagePath;

  ProfileState(
      {@required this.contactsFetchState,
      @required this.contacts,
      @required this.contactsSearch,
      @required this.myName,
      @required this.myProfileImagePath});

  factory ProfileState.fromProfileState(
      {@required ProfileState old,
      FetchState contactsFetchState,
      List<ContactState> contacts,
      String contactsSearch,
      String myName,
      String myProfileImagePath}) {
    return ProfileState(
        contactsFetchState: contactsFetchState ?? old.contactsFetchState,
        contacts: contacts ?? old.contacts,
        contactsSearch: contactsSearch ?? old.contactsSearch,
        myName: myName ?? old.myName,
        myProfileImagePath: myProfileImagePath ?? old.myProfileImagePath);
  }
}

ThunkAction<RootState> retrieveContacts() {
  return (Store<RootState> store) async {
    Future<void> fetch() async {
      store.dispatch(RequestContactAction());
      final contacts = await ContactsService.getContacts(withThumbnails: false)
          .then((contacts) => contacts.map((contact) => ContactState(
              contact: contact, thumbnailBackgroundColor: getRandomColor())));
      store.dispatch(SetContactsAction(contacts: contacts.toList()));
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

ImagePicker _picker;
ThunkAction<RootState> pickProfileImage() {
  return (Store<RootState> store) async {
    if (_picker == null) {
      _picker = ImagePicker();
    }

    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    store.dispatch(SetProfileImageAction(profileImagePath: pickedFile.path));
  };
}

ProfileState contactReducer(ProfileState state, action) {
  if (action is RequestContactAction) {
    return ProfileState.fromProfileState(
        old: state, contactsFetchState: FetchState.Pending);
  }
  if (action is RequestContactPermissionErrorAction) {
    return ProfileState.fromProfileState(
        old: state, contactsFetchState: FetchState.PermissionError);
  }
  if (action is SetContactsAction) {
    return ProfileState.fromProfileState(
        old: state,
        contactsFetchState: FetchState.Success,
        contacts: action.contacts);
  }
  if (action is SetContactsSearchAction) {
    print(action.searchString);
    return ProfileState.fromProfileState(
        old: state, contactsSearch: action.searchString);
  }
  if (action is SetMyNameAction) {
    return ProfileState.fromProfileState(old: state, myName: action.name);
  }
  if (action is SetProfileImageAction) {
    return ProfileState.fromProfileState(
        old: state, myProfileImagePath: action.profileImagePath);
  }

  return state;
}

final ProfileState initialProfileState = ProfileState(
    contactsFetchState: FetchState.None,
    contacts: [],
    contactsSearch: '',
    myName: '',
    myProfileImagePath: null);
