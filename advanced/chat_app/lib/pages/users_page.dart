import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/users_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final usersService = UsersService();
  List<User> users = [];

  @override
  void initState() {
    _loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final user = authService.user;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(user?.name ?? 'Sin nombre', style: const TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            socketService.disconnect();
            Navigator.popAndPushNamed(context, 'login');
            AuthService.deleteToken();
          }, 
          icon: const Icon(Icons.exit_to_app_outlined, color: Colors.black87)
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: socketService.serverStatus == ServerStatus.online 
              ? const Icon(Icons.check_circle_outline, color: Colors.blue,)
              : const Icon(Icons.offline_bolt_outlined, color: Colors.red,)
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadUsers,
        header: WaterDropHeader(
          complete: Icon(Icons.check_outlined, color: Colors.blue[400],),
          waterDropColor: Colors.blue[400]!,
        ),
        child: _createUsersListView(),
      )
    );
  }

  ListView _createUsersListView() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, i) => _createUserListTile(users[i]), 
      separatorBuilder: (_, i) => const Divider(), 
      itemCount: users.length
    );
  }

  ListTile _createUserListTile(User user) {
    return ListTile(
        title: Text(user.name),
        subtitle: Text(user.email),
        leading: CircleAvatar(
          backgroundColor: Colors.blue[200],
          child: Text(user.name.substring(0, 2)),
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: user.online ? Colors.green[300] : Colors.red[300],
            borderRadius: BorderRadius.circular(100)
          ),
        ),
        onTap: () {
          final chatService = Provider.of<ChatService>(context, listen: false);
          chatService.userTo = user;
          Navigator.pushNamed(context, 'chat');
        },
      );
  }

  _loadUsers() async {
    users = await usersService.getUsers();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
