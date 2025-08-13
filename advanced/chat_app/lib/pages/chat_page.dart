import 'dart:io';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  ChatService? chatService;
  SocketService? socketService;
  AuthService? authService;

  List<ChatMessage> _messages = [];
  bool _isWriting = false;

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService!.socket.on('personal-message', _handleMessage);
  }

  void _handleMessage(data) {
    ChatMessage chatMessage = ChatMessage(
      text: data['message'],
      uuid: data['from'],
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 300)),
    );
    setState(() {
      _messages.insert(0, chatMessage);
    });
    chatMessage.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    var user = chatService!.userTo!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
              child: Text(
                user.name.substring(0, 2), 
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 3,),
            Text(
              user.name, 
              style: const TextStyle(color: Colors.black87, fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
                itemCount: _messages.length,
              )
            ),
            const Divider(height: 1,),
            Container(
              color: Colors.white,
              child: _chatInputText(),
            )
          ],
        ),
      ),
    );
  }

  Widget _chatInputText() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsetsDirectional.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleTextSubmit,
                onChanged: (value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      _isWriting = true;
                    } else {
                      _isWriting = false;
                    }
                  });
                },
                decoration: const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
                focusNode: _focusNode,
              )
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS 
                ? CupertinoButton(
                  onPressed: _isWriting 
                    ? () => _handleTextSubmit(_textController.text.trim())
                    : null,
                  child: const Text('Enviar'), 
                )
                : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconTheme(
                    data: IconThemeData(
                      color: Colors.blue[400]
                    ),
                    child: IconButton(
                      onPressed: _isWriting 
                        ? () => _handleTextSubmit(_textController.text.trim())
                        : null, 
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: const Icon(Icons.send_outlined)
                    ),
                  ),
                )
            )
          ],
        ),
      )
    );
  }

  _handleTextSubmit(String text) {
    if (text.isEmpty) return;

    _textController.clear();
    _focusNode.requestFocus();

    var message = ChatMessage(
      uuid: '123', 
      text: text, 
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 1000)),
    );
    _messages.insert(0, message);
    message.animationController.forward();

    setState(() {
      _isWriting = false;
    });

    socketService!.emit('personal-message', {
      'from': authService!.user!.uid,
      'to': chatService!.userTo!.uid,
      'message': text
    });
  }

  @override
  void dispose() {
    for (ChatMessage msg in _messages) {
      msg.animationController.dispose();
    }
    socketService!.socket.off('personal-message');
    super.dispose();
  }
}
