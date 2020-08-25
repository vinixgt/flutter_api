import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/utils/auth.dart';
import 'package:flutter_api_rest/utils/dialog.dart';
import 'package:flutter_api_rest/models/user.dart';

class MyApi {

  MyApi._internal();
  static MyApi _instance = MyApi._internal();
  static MyApi get instance => _instance;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://curso-api-flutter.herokuapp.com'
    )
  );

  ///
  /// Register
  ///
  Future<void> register(BuildContext context, {
    @required String username,
    @required String email,
    @required String password,
  }) async {
    final ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      final Response response = await this._dio.post(
        '/api/v1/register',
        data: {
          "username": username,
          "email":email,
          "password":password
        }
      );
      await Auth.instance.setSession(response.data);
      progressDialog.dismiss();
      Navigator.pushNamedAndRemoveUntil(
        context, 
        HomePage.routeName, 
        (_) => false
      );
    } catch(error) {
      print(error);
      progressDialog.dismiss();
      if(error is DioError) {
        Dialogs.info(
          context,
          title: 'Message',
          content: error.response.statusCode == 409 ? 'Duplicated email or username' : error.message
        );
        print(error.response.statusCode);
        print(error.response.data);
      } else  {
        print(error);
      }
    }
  } // register

  ///
  Future<void> login(BuildContext context, {
    @required String email,
    @required String password,
  }) async {
    final ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      final Response response = await this._dio.post(
        '/api/v1/login',
        data: {
          "email":email,
          "password":password
        }
      );
      await Auth.instance.setSession(response.data);
      progressDialog.dismiss();
      Navigator.pushNamedAndRemoveUntil(
        context, 
        HomePage.routeName, 
        (_) => false
      );
    } catch(error) {
      progressDialog.dismiss();
      if(error is DioError) {
        String message = error.message;
        if(error.response.statusCode == 404) {
          message = 'User not found.';
        } else if (error.response.statusCode == 403) {
          message = 'Usuario y/o clave invalidos';
        }
        Dialogs.info(
          context,
          title: 'Message',
          content: message
        );
      } else  {
        print(error);
      }
    }
    
  } // register
  
  Future<dynamic> refresh(String token) async {
    print('calling refresh....');
    try{
      final Response response = await this._dio.post(
        '/api/v1/refresh-token', 
        options: Options(
          headers: {
            'token':token
          }
        )
      );
      return response.data;
    } catch (error) {
      print(error);
      return null;
    }
  } // refresh

  Future<User> getUserInfo() async {
    
    try{
      final Response response = await this._dio.get(
        '/api/v1/user-info', 
        options: Options(
          headers: {
            'token': await Auth.instance.accessToken
          }
        )
      );
      return User.fromJson(response.data);
    } catch (error) {
      print('getUserInfo: ................');
      print(error);
      return null;
    }
  }
} // class