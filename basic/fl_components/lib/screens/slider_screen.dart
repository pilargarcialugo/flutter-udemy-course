import 'package:fl_components/themes/app_theme.dart';
import 'package:flutter/material.dart';

class SliderScreen extends StatefulWidget {
   
  const SliderScreen({Key? key}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {

  double _sliderValue = 100;
  bool _sliderEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sliders & Checks'),
      ),
      body: Column(
          children: [
            Slider.adaptive(
              min: 50,
              max: 400,
              activeColor: AppTheme.primaryLight,
              divisions: 10,
              value: _sliderValue, 
              onChanged: _sliderEnabled ? (value) {
                _sliderValue = value;
                setState(() {});
                
              } : null
            ),

            SwitchListTile.adaptive(
              activeColor: AppTheme.primaryLight,
              title: const Text('Enable Slide'),
              value: _sliderEnabled, 
              onChanged: (value) {
                _sliderEnabled = value;
                setState(() {});
              } 
            ),
      
            Expanded(
              child: SingleChildScrollView(
                child: Image(
                  image: const NetworkImage('https://cdn.shopify.com/s/files/1/0606/5917/1586/products/1_5f62899d-7814-4acc-969d-7776135b62da_1024x1024.png?v=1646472168'),
                  fit: BoxFit.contain,
                  width: _sliderValue,
                ),
              ),
            ),

            
          ],
        ),
      );
  }
}