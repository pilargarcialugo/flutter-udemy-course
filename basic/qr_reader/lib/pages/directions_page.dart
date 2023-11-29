import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class DirectionsPage extends StatelessWidget {
   
  const DirectionsPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const ScanTiles(type: 'http');
  }
}