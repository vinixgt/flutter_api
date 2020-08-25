import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AvatarButon extends StatelessWidget {

  final double imageSize;

  const AvatarButon({Key key, this.imageSize = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black12,
                offset: Offset(0, 20)
              ),
            ]
          ),
          child: ClipOval(
            child: Image.network(
              'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png',
              width: this.imageSize,
              height: this.imageSize,
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            //color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2
                ),
                color: Colors.pinkAccent,
                shape: BoxShape.circle
              ),
            ),
            onPressed: () {}
          ),
        )
      ],
    );
  }
}