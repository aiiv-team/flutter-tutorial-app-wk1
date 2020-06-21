import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tutorial_app_wk1/src/store/application_store.dart';
import 'package:tutorial_app_wk1/src/store/modules/profile.dart';

class _BackgroundContainer extends StatelessWidget {
  final double size;

  const _BackgroundContainer({
    Key key,
    @required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0.5 * size),
      child: SizedBox(
        height: size,
        width: size,
        child: new Transform(
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                        gradient:
                            LinearGradient(begin: Alignment.topLeft, colors: [
                  Colors.deepPurple.shade400,
                  Colors.purple.shade400,
                ]))),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 0.5 * size,
                    color: Colors.blue.shade400,
                  ),
                ),
              ],
            ),
            alignment: FractionalOffset.center,
            transform: new Matrix4.rotationZ(.25 * pi)),
      ),
    );
  }
}

class _ImageContainer extends StatelessWidget {
  final double size;
  final Widget child;
  _ImageContainer({Key key, @required this.size, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(0.5 * size),
      child: SizedBox(width: size, height: size, child: child));
}

class _ProfileImageButtonProps {
  final String profileImagePath;
  final Function pickProfileImage;
  _ProfileImageButtonProps(
      {@required this.profileImagePath, @required this.pickProfileImage});
}

class ProfileImageButton extends StatelessWidget {
  final double size;

  const ProfileImageButton({Key key, this.size = 80}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<RootState, _ProfileImageButtonProps>(
        converter: (store) => _ProfileImageButtonProps(
            profileImagePath: store.state.profile.myProfileImagePath,
            pickProfileImage: () => store.dispatch(pickProfileImage())),
        builder: (context, props) {
          final child = props.profileImagePath != null
              ? _ImageContainer(
                  size: size,
                  child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.file(File(props.profileImagePath))))
              : Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                      _BackgroundContainer(
                        size: size,
                      ),
                      Icon(Icons.camera_alt, size: 30, color: Colors.white)
                    ]);

          return FlatButton(
              child: child,
              color: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: props.pickProfileImage);
        });
  }
}
