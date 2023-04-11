import 'package:flutter/material.dart';
import 'package:fl_components/widgets/widgets.dart';

class CardScreen extends StatelessWidget {
   
  const CardScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Card Widget"),
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: const [
          CustomCardType1(),
          SizedBox(height: 10,),
          CustomCardType2(
            imageUrl: 'https://images.pexels.com/photos/2662116/pexels-photo-2662116.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            imageDescription: 'Blue Lake',
          ),
          SizedBox(height: 10,),
          CustomCardType2(
            imageUrl: 'https://iso.500px.com/wp-content/uploads/2014/07/big-one.jpg',
            imageDescription: 'Mountain',
          ),
          SizedBox(height: 10,),
          CustomCardType2(
            imageUrl: 'https://windows10spotlight.com/wp-content/uploads/2020/09/945016cf822b3193fb8c7b5755db841a.jpg'
          )
        ],
      )

    );
  }
}

