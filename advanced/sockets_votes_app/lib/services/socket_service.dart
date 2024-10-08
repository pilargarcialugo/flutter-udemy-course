import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  online,
  offline,
  connecting
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  final IO.Socket _socket = IO.io('http://localhost:3000', {
      'transports': ['websocket'],
      'autoConnect': true,
    });

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    _socket.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });
    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });
    _socket.on('response', (data) => print(data));
  }
}
