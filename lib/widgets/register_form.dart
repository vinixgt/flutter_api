import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_rest/api/my_api.dart';
import 'package:flutter_api_rest/utils/responseive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';


class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '', _username = '';
  _submit() async {
    final isOk = _formKey.currentState.validate();
    if(isOk) {
      
      await MyApi.instance.register(
        context,
        username: _username,
        email: _email,
        password: _password
      );
      //progressDialog.dismiss();
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
                label: 'User name',
                keyboardType: TextInputType.emailAddress,
                fontSize: responsive.dp(1.7),
                onChanged: (text) {
                  _username = text;
                },
                validator: (text){
                  if(text.length < 5) {
                    return 'Invalid username';
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(1.2)),
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
                          this._password = text.trim();
                        },
                        validator: (text) {
                          if(text.trim().length < 6) {
                            return 'Invalid password';
                          }
                          return null;
                        },
                      ),
                    ),
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
                    "Sign up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(1.5)
                    )
                  ),
                  onPressed: this._submit,
                  color: Colors.pinkAccent
                ),
              ),
              
              SizedBox(height: responsive.dp(10)),
            ],
          ),
        ),
      )
    );
  }
}