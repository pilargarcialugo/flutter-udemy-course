import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:sockets_votes_app/models/models.dart';
import 'package:sockets_votes_app/services/socket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Option> options = [];

  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('available-options', _handleAvailableOptions);
    super.initState();
  }

  _handleAvailableOptions(dynamic data) {
    options = (data as List)
      .map((op) => Option.fromMap(op))
      .toList();

    setState(() {});
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('available-options');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text('Votes App', style: TextStyle(color: Colors.black87),),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: socketService.serverStatus == ServerStatus.online 
            ? Icon(Icons.check_circle_outline, color: Colors.blue[300],)
            : const Icon(Icons.offline_bolt, color: Colors.red,),
          )
        ],
      ),
      body: Column(
        children: [
          _buildOptionsDiagram(),
          Expanded(
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) => _buildOptionsListView(options[index]),        
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addOption,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildOptionsListView(Option option) {
    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(option.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) => socketService.socket.emit('delete-option', {'id': option.id}),
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
        onTap: () => socketService.socket.emit('vote-option', {'id': option.id}),
      ),
    );
  }

  addOption() {
    final textController = TextEditingController();
    // if (Platform.isIOS) {
    //   return showIosDialog(textController);
    // } 
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
      builder: (_) {
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
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.socket.emit('add-option', {'name': optionName});
    }
    Navigator.pop(context);
  }
  
  Widget _buildOptionsDiagram() {
    final Map<String, double> dataMap = {for (Option option in options) option.name: option.votes.toDouble()};

    if (dataMap.isEmpty) {
      return const Center(
        child: Text('No data available'),
      );
    }

    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 10),
      child: PieChart(dataMap: dataMap),
    );
    }
}
