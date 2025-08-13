import 'package:chat_app/models/users_response.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/global/environment.dart';
import 'package:chat_app/services/auth_service.dart';

import 'package:chat_app/models/user.dart';

class UsersService {
  Future<List<User>> getUsers() async {
    try {
      final token = await AuthService.getToken();
      final res = await http.get(
        Uri.parse('${Environment.apiUrl}/users'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token ?? ''
        }
      );

      final usersResponse = usersResponseFromJson(res.body);
      return usersResponse.users;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
