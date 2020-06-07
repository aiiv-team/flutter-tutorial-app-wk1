import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tutorial_app_wk1/src/components/profile_image_button.dart';
import 'package:tutorial_app_wk1/src/store/application_store.dart';
import 'package:tutorial_app_wk1/src/store/modules/profile.dart';

const _namePlaceholderTextStyle =
    TextStyle(fontSize: 12, color: Colors.black26);
const _nameTextStyle = TextStyle(fontSize: 24);

class _MyProfileNameProps {
  final String name;
  final Function setName;
  _MyProfileNameProps({@required this.name, @required this.setName});
}

class _MyProfileNameText extends StatelessWidget {
  final String name;
  final Function onTap;
  _MyProfileNameText({@required this.name, @required this.onTap});

  @override
  Widget build(BuildContext context) =>
      StoreConnector<RootState, _MyProfileNameProps>(
          converter: (store) => _MyProfileNameProps(
              name: store.state.profile.myName,
              setName: (String name) =>
                  store.dispatch(SetMyNameAction(name: name))),
          builder: (context, props) {
            return GestureDetector(
                onTap: onTap, child: _buildContent(context, props));
          });

  Widget _buildContent(BuildContext context, _MyProfileNameProps props) {
    if (props.name == null || props.name.length == 0) {
      return Text('여기를 탭하고\n당신의 이름을 입력하세요.',
          textAlign: TextAlign.center, style: _namePlaceholderTextStyle);
    }
    return Text(props.name, style: _nameTextStyle);
  }
}

class _MyProfileNameTextField extends StatelessWidget {
  final Function onSubmitted;
  final TextEditingController _controller;
  _MyProfileNameTextField(
      {@required String initialValue, @required this.onSubmitted})
      : _controller = TextEditingController(text: initialValue);

  @override
  Widget build(BuildContext context) => Container(
      width: 192,
      height: 24,
      child: TextField(
        autofocus: true,
        controller: _controller,
        cursorColor: Colors.black,
        cursorWidth: 1,
        decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            hintText: '이름'),
        enableInteractiveSelection: false,
        keyboardType: TextInputType.text,
        maxLength: 8,
        maxLengthEnforced: true,
        onSubmitted: onSubmitted,
        style: _nameTextStyle,
        textAlign: TextAlign.center,
      ));
}

class _MyProfileName extends StatefulWidget {
  @override
  _MyProfileNameState createState() => _MyProfileNameState();
}

class _MyProfileNameState extends State<_MyProfileName> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) => StoreConnector<RootState,
          _MyProfileNameProps>(
      converter: (store) => _MyProfileNameProps(
          name: store.state.profile.myName,
          setName: (String name) =>
              store.dispatch(SetMyNameAction(name: name))),
      builder: (context, props) => Container(
          margin: EdgeInsets.only(top: 24),
          child: _isEditing
              ? _MyProfileNameTextField(
                  initialValue: props.name,
                  onSubmitted: (String value) =>
                      _onSubmitNameField(props, value),
                )
              : _MyProfileNameText(name: props.name, onTap: _toggleEditing)));

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _onSubmitNameField(_MyProfileNameProps props, String value) {
    _toggleEditing();
    if (value.length > 0) {
      props.setName(value);
    }
  }
}

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ProfileImageButton(), _MyProfileName()]));
}
