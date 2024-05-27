import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sockets_votes_app/models/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Option> options = [
    Option(id: '1', name: 'One', votes: 5),
    Option(id: '2', name: 'Two', votes: 2),
    Option(id: '3', name: 'Three', votes: 0),
    Option(id: '4', name: 'Four', votes: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Vote App'),
      ),
      body: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) => _buildOptionsListView(options[index]),        
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addOption,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildOptionsListView(Option option) {
    return Dismissible(
      key: Key(option.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        // TODO delete on server
      },
      background: Container(
        padding: const EdgeInsets.only(left: 25),
        color: Colors.red[300],
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete_outlined, color: Colors.white),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(option.name.substring(0, 2)),
        ),
        title: Text(option.name),
        trailing: Text('${option.votes}', style: const TextStyle(fontSize: 18, color: Colors.blueGrey),),
        onTap: () {
          
        },
      ),
    );
  }

  addOption() {
    final textController = TextEditingController();
    if (Platform.isIOS) {
      return showIosDialog(textController);
    } 
    return showAndroidDialog(textController);
  }

  Future<dynamic> showIosDialog(TextEditingController textController) {
    return showCupertinoDialog(
      context: context, 
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text('Option'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Add'),
              onPressed: () => addToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  Future<dynamic> showAndroidDialog(TextEditingController textController) {
    return showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Option: '),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => addToList(textController.text),
              child: const Text('Add'),
            )
          ],
        );
      },
    );
  }

  addToList(String optionName) {
    if (optionName.length > 1) {
      options.add(Option(id: DateTime.now().toString(), name: optionName, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
