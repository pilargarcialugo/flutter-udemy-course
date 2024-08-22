import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, 
    required this.uuid,
    required this.text, 
    required this.animationController, 
  });

  final String uuid;
  final String text;
  final AnimationController animationController;


  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: uuid == '123'
            ? _buildMyMessage() 
            :_buildMessage(),
        ),
      ),
    );
  }
  
  Widget _buildMyMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 5, left: 50, right: 5),
        decoration: BoxDecoration(
          color: const Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Text(text, style: const TextStyle(color: Colors.white),),
      ),
    );
  }
  
  Widget _buildMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 5, left: 5, right: 50),
        decoration: BoxDecoration(
          color: const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Text(text, style: const TextStyle(color: Colors.black87),),
      ),
    );
  }
}