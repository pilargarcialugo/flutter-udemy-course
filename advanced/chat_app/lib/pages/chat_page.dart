import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  List<ChatMessage> _messages = [];

  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
              child: const Text('Test', style: TextStyle(fontSize: 12),),
            ),
            const SizedBox(height: 3,),
            const Text('Test user', style: TextStyle(color: Colors.black87, fontSize: 12),),
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

            // TODO caja de texto
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

    var chatMessage = ChatMessage(
      uuid: '123', 
      text: text, 
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 1000)),
    );
    _messages.insert(0, chatMessage);
    chatMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    // TODO: off del socket
    for (ChatMessage msg in _messages) {
      msg.animationController.dispose();
    }
    super.dispose();
  }
}
