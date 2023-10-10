import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _BackgroundBox(),
        const _HeaderIcon(),
        child
      ],
    );
  }
}

class _BackgroundBox extends StatelessWidget {
  const _BackgroundBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _buildBoxDecoration(),
      child: const Stack(
        children: [
          Positioned(bottom: 20, right: 10, child: _Bubble(),),
          Positioned(top: 0, left: 0, child: _Bubble(),),
          Positioned(top: 150, left: 30, child: _Bubble(),),
          Positioned(top: 50, left: 200, child: _Bubble(),),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0Xff22223B),
        Color(0Xff4a4e69),
      ]
    )
  );
}

class _Bubble extends StatelessWidget {
  const _Bubble();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: const Icon(Icons.person_pin, color: Colors.white, size: 75,),
      ),
    );
  }
}
