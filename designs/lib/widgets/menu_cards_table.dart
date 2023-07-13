import 'package:flutter/material.dart';

class MenuCardsTable extends StatelessWidget {
  const MenuCardsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: const [
        TableRow(
          children: [
            _SingleCard(Icons.app_registration_outlined, Color.fromRGBO(246, 189, 96, 1), "App one"),
            _SingleCard(Icons.approval_outlined, Color.fromRGBO(247, 237, 226, 1), "App two"),
          ]
        ),
        TableRow(
          children: [
            _SingleCard(Icons.ac_unit_outlined, Color.fromRGBO(245, 202, 195, 1), "App three"),
            _SingleCard(Icons.access_time_filled_outlined, Color.fromRGBO(132, 165, 157, 1), "App four"),
          ]
        ),
        TableRow(
          children: [
            _SingleCard(Icons.backup_outlined, Color.fromRGBO(242, 132, 130, 1), "App five"),
            _SingleCard(Icons.app_registration_outlined, Color.fromRGBO(246, 189, 96, 1), "App one"),
          ]
        )
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String description;

  const _SingleCard(this.icon, this.color, this.description);

  @override
  Widget build(BuildContext context) {
    return _CardBackground(createCardColumnChild());
  }

  Column createCardColumnChild() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(icon, color: Colors.white, size: 35,),
        ),
        const SizedBox(height: 15,),
        Text(description, style: TextStyle(color: color, fontSize: 15),)
      ],
    );
  }

}

class _CardBackground extends StatelessWidget {
  final Widget cardChild;

  const _CardBackground(this.cardChild);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      height: 180,
      decoration: buildDecoration(),
      child: cardChild,
    );
  }

  BoxDecoration buildDecoration() {
    return BoxDecoration(
      color: const Color.fromRGBO(73, 80, 87, 0.7),
      borderRadius: BorderRadius.circular(20),
    );
  }
}