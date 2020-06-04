import 'package:flutter/material.dart';
import 'dart:math';

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

class ProfileImageButton extends StatelessWidget {
  final double size;

  const ProfileImageButton({Key key, this.size = 80}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
          _BackgroundContainer(
            size: size,
          ),
          Icon(Icons.camera_alt, size: 30, color: Colors.white)
        ]),
        color: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () => print('Hello world!'));
  }
}
