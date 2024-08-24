import 'dart:convert';
import 'dart:io';
import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';

class AuthService with ChangeNotifier {
  User? user;
  bool _loggingIn = false;
  bool _registering = false;
  final _storage = const FlutterSecureStorage();


  bool get loggingIn => _loggingIn;
  set loggingIn(bool value) {
    _loggingIn = value;
    notifyListeners();
  }

  bool get registering => _registering;
  set registering(bool value) {
    _registering = value;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    loggingIn = true;

    final data = {
      'email': email,
      'password': password
    };

    final res = await http.post(
      Uri.parse('${Environment.apiUrl}/login'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'}
    );

    loggingIn = false;
    if (res.statusCode == HttpStatus.ok) {
      final loginResponse = loginResponseFromJson(res.body);
      if (loginResponse.sucess) {
        user = loginResponse.user;
        await _saveToken(loginResponse.token);
      } 
      return loginResponse.sucess;
    } else {
      return false;
    }
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }

  Future register(String name, String email, String password) async {
    registering = true;

    final data = {
      'name': name,
      'email': email,
      'password': password
    };

    final res = await http.post(
      Uri.parse('${Environment.apiUrl}/login/new'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'}
    );

    registering = false;
    if (res.statusCode == HttpStatus.ok) {
      final registerResponse = loginResponseFromJson(res.body);
      if (registerResponse.sucess) {
        await _saveToken(registerResponse.token);
      } 
      return registerResponse.sucess;
    } else {
      return jsonDecode(res.body)['message'];
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    final res = await http.get(
      Uri.parse('${Environment.apiUrl}/login/token/refresh'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token ?? ''
      }
    );
    
    if (res.statusCode == HttpStatus.ok) {
      final refreshResponse = loginResponseFromJson(res.body);
      if (refreshResponse.sucess) {
        await _saveToken(refreshResponse.token);
      } 
      return refreshResponse.sucess;
    } else {
      logout();
      return false;
    }
  }
}
