import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responseive.dart';
import 'package:flutter_api_rest/widgets/avatar.dart';
import 'package:flutter_api_rest/widgets/circle.dart';
import 'package:flutter_api_rest/widgets/register_form.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = 'register';
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {

    final Responsive responsive = Responsive.of(context);
    final double bigSize = MediaQuery.of(context).size.width * 0.6;
    final double smallSize = MediaQuery.of(context).size.width * 0.8;
    
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          print('MediaQuery.size: ' + responsive.wp(0.17).toString());
          print('bigSize: ' + responsive.wp(0.8).toString());
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(

          child: Container(
            height: responsive.height,
            width: double.infinity,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget> [
                Positioned(
                  top: -bigSize*0.3,
                  right: -bigSize*0.2,
                  child: Circle(
                    size: smallSize,
                    colors: [Colors.pinkAccent, Colors.pink]
                  )
                ),
                Positioned(
                  top: -smallSize*0.25,
                  left: -smallSize*0.2,
                  child: Circle(
                    size: bigSize,
                    colors: [
                      Colors.orange, 
                      Colors.deepOrange
                    ]
                  )
                ),
                Positioned(
                  top: bigSize*0.35,
                  child: Column(
                    children: <Widget>[
                     
                      Text(
                        "Hello!\nSign up to get started.", 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.dp(1.6),
                          color: Colors.white
                        )
                      ),
                      SizedBox(
                        height: responsive.dp(6),
                      ),
                      AvatarButon(
                        imageSize: responsive.dp(9)
                      )
                    ]
                  )
                ),
                Positioned(
                  top: smallSize * 0.05,
                  left: smallSize * 0.05,
                  child: SafeArea(
                    child: CupertinoButton(
                      color: Colors.black12,
                      padding: EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(50),
                      child: Icon(Icons.arrow_back),
                      onPressed: () {}
                    ),
                  ),
                ),
                RegisterForm(),
              ]
            )
          ),
        ),
      )
    );
  }
}