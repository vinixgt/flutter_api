import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_rest/api/my_api.dart';
import 'package:flutter_api_rest/utils/responseive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';


class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '';
  _submit() {
    final isOk = _formKey.currentState.validate();
    if(isOk) {
      
      MyApi.instance.login(
        context, 
        email: _email, 
        password: _password
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 30,
      child: Container(
        constraints: (
          BoxConstraints(
            minWidth: 350, 
            maxWidth: responsive.isTablet ? 430 : 360,
          )
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
                InputText(
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  fontSize: responsive.dp(1.7),
                  onChanged: (text) {
                    _email = text;
                  },
                  validator: (text){
                    if(!text.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: responsive.dp(1.2)),
                Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black12))
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InputText(
                          label: 'Password',
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          borderEnable: false,
                          fontSize: responsive.dp(1.7),
                          onChanged: (text) {
                            _password = text;
                          },
                          validator: (text) {
                            if(text.trim().length < 6) {
                              return 'Invalid password';
                            }
                            return null;
                          },
                        ),
                      ),
                      FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text("Forgot password",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black26, fontSize: responsive.dp(1.6),),
                        ),
                        onPressed: () {}
                      )
                    ],
                  ),
                ),
                // botones
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: responsive.dp(1.5)
                      )
                    ),
                    onPressed: this._submit,
                    color: Colors.pinkAccent
                  ),
                ),
                SizedBox(height: responsive.dp(2)),
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'New to friendly Desi?',
                      style: TextStyle(
                        fontSize: responsive.dp(1.6)
                      )
                    ),
                    FlatButton(
                      child: Text(
                        'Sign up', 
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: responsive.dp(1.6)
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      },
                    )
                  ],
                ),
                SizedBox(height: responsive.dp(10)),
            ],
          ),
        ),
      )
    );
  }
}