import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String type;

  const ScanTiles({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) {
        var scan = scans[i];
        return Dismissible(
        key: UniqueKey(),
        background: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete_outline), 
          alignment: Alignment.centerLeft,
        ),
        onDismissed: (direction) => scanListProvider.deleteScan(scan.id!),
        child: ListTile(
          leading: Icon(
            type == 'http' ? Icons.home_outlined : Icons.map_outlined, 
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scan.value),
          subtitle: Text(scan.id!.toString()),
          trailing: const Icon(Icons.keyboard_arrow_right_outlined, color: Colors.grey,),
          onTap: () => launch(context, scan),
        ),
      );
      }
    );
  }
}