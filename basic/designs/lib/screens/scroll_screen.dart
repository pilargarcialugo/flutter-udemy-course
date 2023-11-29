import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ScrollScreen extends StatelessWidget {
   
  const ScrollScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
      body: Container(
        decoration: buildContainerDecoration(),
        child: PageView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: const [
            PageOne(),
            PageTwo()
          ],
        ),
      )
    );
  }

  BoxDecoration buildContainerDecoration() {
    return const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.black45])
      );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Background(),
        MainContent()
      ],
    );
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: null, 
        style: TextButton.styleFrom(
          backgroundColor: Colors.deepPurple[200],
          padding: const EdgeInsets.all(12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text('Bienvenid@', style: formatText(25),),
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff000000),
      height: double.infinity,
      alignment: Alignment.center,
      child: const Image(image: AssetImage('assets/background.png'))
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentDateTime = DateTime.now();
    const locale = 'es_ES';
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40,),
          Text(DateFormat.yMMMMd(locale).format(currentDateTime), style: formatText(17),),
          Text(DateFormat.EEEE(locale).format(currentDateTime), style: formatText(40),),
          Expanded(child: Container()),
          const Icon(Icons.keyboard_arrow_down, size: 80, color: Colors.white,)
        ],
      ),
    );
  }
}

TextStyle formatText(double fontSize) => TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold);
