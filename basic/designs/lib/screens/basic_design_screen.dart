import 'package:flutter/material.dart';

class BasicDesignScreen extends StatelessWidget {
   
  const BasicDesignScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Image(image: AssetImage('assets/cabin1.jpg')),
          Title(),
          AditionalInfo(),
          Description()
        ]
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cabaña en las montañas', style: TextStyle(fontWeight: FontWeight.bold),),
              Text('Guatavita', style: TextStyle(color: Colors.black87),)
            ],
          ),
          Expanded(child: Container()),
          const Icon(Icons.star, color: Colors.amber,),
          const Text('5')              
        ],
      ),
    );
  }
}

class AditionalInfo extends StatelessWidget {
  const AditionalInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InfoIcon(icon: Icons.phone, description: 'Contactar'),
          InfoIcon(icon: Icons.route, description: 'Ubicación'),
          InfoIcon(icon: Icons.share, description: 'Compartir')
        ],
      ),
    );
  }
}

class InfoIcon extends StatelessWidget {
  final IconData icon;
  final String description;

  const InfoIcon({
    super.key, required this.icon, required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.teal,),
        Text(description, style: const TextStyle(color: Colors.black87),)
      ],
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: const Text(
        'Descansa y disfruta de la naturaleza en una hermosa cabaña familiar  en la cima de la montaña a tan solo 5 kms del pueblo, vista privilegiada hacia la cordillera, planes ecológicos como senderismo, avistamiento de aves, colibrís, paseo al río, ciclo montañismo, cabalgatas, entre otros.',
        textAlign: TextAlign.justify,
      )
    );
  }
}
