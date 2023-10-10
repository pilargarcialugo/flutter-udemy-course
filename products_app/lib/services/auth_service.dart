import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _fireBaseToken = 'AIzaSyCOx5EXRlJ84h1UZXcpdP_FYZV3pE4-s38';

  final storage = const FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _fireBaseToken});
    return await processRequest(url, email, password);
  }

  Future<String?> loginUser(String email, String password) async {
    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {'key': _fireBaseToken});
    return await processRequest(url, email, password);
  }

  Future<dynamic> processRequest(Uri url, String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResponse = json.decode(response.body);
    
    if (decodedResponse.containsKey('idToken')) {
      storage.write(key: 'idToken', value: decodedResponse['idToken']);
      return null;
    } else {
      return decodedResponse['error']['message'];
    }
  }

  Future logout() async {
    storage.delete(key: 'idToken');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'idToken') ?? '';
  }
}