import 'package:flutter/material.dart';

import 'package:fl_components/themes/app_theme.dart';

class CustomCardType1 extends StatelessWidget {
  const CustomCardType1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          
          const ListTile(
            leading: Icon(Icons.card_giftcard, color: AppTheme.primaryLight,),
            title: Text('Card'),
            subtitle: Text('Gifts'),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 TextButton(
                    onPressed: () {}, 
                    child: const Text('Recharge')
                  ),
                  TextButton(
                    onPressed: () {}, 
                    child: const Text('View')
                  )  
              ],
            ),
          )

        ]
      ),
    );
  }
}