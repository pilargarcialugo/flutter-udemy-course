import 'dart:math';

import 'package:flutter/material.dart';

class MenuBackground extends StatelessWidget {
  const MenuBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(decoration: buildBoxDecoration(),),
        const Positioned(
          top: -100,
          left: -30,
          child: _Box()
        )
      ],
    );
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.2, 0.8],
        colors: [
          Color.fromRGBO(33, 37, 41, 1),
          Color.fromRGBO(52, 58, 64, 1),
        ]
      )
    );
  }
}

class _Box extends StatelessWidget {
  const _Box();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi /4.0,
      child: Container(
        width: 360,
        height: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(231, 111, 81, 1),
              Color.fromRGBO(205, 180, 219, 1),
              
            ]
          )
        ),
      ),
    );
  }
}
