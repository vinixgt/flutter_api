import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responseive.dart';
import 'package:flutter_api_rest/widgets/circle.dart';
import 'package:flutter_api_rest/widgets/icon_container.dart';
import 'package:flutter_api_rest/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login';
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  top: -bigSize*0.4,
                  right: -bigSize*0.2,
                  child: Circle(
                    size: smallSize,
                    colors: [Colors.pinkAccent, Colors.pink]
                  )
                ),
                Positioned(
                  top: -smallSize*0.4,
                  left: -smallSize*0.2,
                  child: Circle(
                    size: bigSize,
                    colors: [Colors.orange, Colors.deepOrange]
                  )
                ),
                Positioned(
                  top: bigSize*0.7,
                  child: Column(
                    children: <Widget>[
                      IconContainer(
                        size: responsive.wp(0.17)
                      ),
                      SizedBox(
                        height: responsive.dp(3),
                      ),
                      Text(
                        "Welcom back!", 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.dp(1.6)
                        )
                      )
                    ]
                  )
                ),
                LoginForm()
              ]
            )
          ),
        ),
      )
    );
  }
}