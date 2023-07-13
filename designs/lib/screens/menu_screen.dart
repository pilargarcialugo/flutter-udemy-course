import 'package:flutter/material.dart';
import 'package:designs/widgets/widgets.dart';

class MenuScreen extends StatelessWidget {
   
  const MenuScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          MenuBackground(),
          _Body(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          MenuTitle(),
          MenuCardsTable()
        ],
      ),
    );
  }
}