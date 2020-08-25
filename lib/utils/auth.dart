import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/my_api.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class Auth {

  Auth._internal();
  static Auth _instance = Auth._internal();
  static Auth get instance => _instance;
  
  final _storage = FlutterSecureStorage();
  final key="SESSION";

  Completer _completer;

  Future<String> get accessToken async {

    if(_completer != null) {
      await _completer.future;
    }

    _completer = Completer();

    final Session session = await this.getSession();
    if(session == null) {
      print('session null');
      _completer.complete();
      return null;
    }

    final DateTime currentDate = DateTime.now();
    final DateTime createdAt = session.createdAt;
    final int expiresIn = session.expiresIn;

    final diff = currentDate.difference(createdAt).inSeconds;
    if(expiresIn - diff >= 60) {
      _completer.complete();
      print('token alive...');
      return session.token;
    }
    
    final Map<String, dynamic>data = await MyApi.instance.refresh(session.token);
    if(data == null) {
      _completer.complete();
      return null;
    }
    print('refrescar token...');
    await this.setSession(data);
    _completer.complete();
    return data['token'];
  }


  Future <void>setSession(Map<String, dynamic> data) async {
    final Session session = Session(
        token: data['token'],
        expiresIn: data['expiresIn'],
        createdAt: DateTime.now()
      );
    final String value = jsonEncode(session.toJson());
    await this._storage.write(key: key, value: value);
  }

  Future<Session> getSession() async {
    final String value = await this._storage.read(key: key);
    if(value != null) {
      final Map<String, dynamic>json = jsonDecode(value);
      return Session.fromJson(json);
    }
    return null;
  }

  Future<void> logout(BuildContext context) async {
    await this._storage.deleteAll();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginPage.routeName,
      (_) => false
    );
  } // logout
} // class


class Session {
  final String token;
  final int expiresIn;
  final DateTime createdAt;

  Session({
    @required this.token,
    @required this.expiresIn,
    @required this.createdAt
  });

  static Session fromJson(Map<String, dynamic> json) {
    return Session(
      token:json['token'],
      expiresIn: json['expiresIn'],
      createdAt: DateTime.parse(json['createdAt'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': this.token,
      'expiresIn': this.expiresIn,
      'createdAt': this.createdAt.toString()
    };
  }
} // Session

