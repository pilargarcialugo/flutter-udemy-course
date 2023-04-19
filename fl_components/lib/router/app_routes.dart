import 'package:flutter/material.dart';

import 'package:fl_components/models/models.dart';
import 'package:fl_components/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static final menuOptions = <MenuOption>[
    MenuOption(route: 'listview1', name: 'List View 1', screen: const Listview1Screen(), icon: Icons.list),
    MenuOption(route: 'listview2', name: 'List View 2', screen: const Listview2Screen(), icon: Icons.list),
    MenuOption(route: 'alert', name: 'Alert', screen: const AlertScreen(), icon: Icons.alarm),
    MenuOption(route: 'card', name: 'Card', screen: const CardScreen(), icon: Icons.credit_card),
    MenuOption(route: 'avatar', name: 'Circle Avatar', screen: const AvatarScreen(), icon: Icons.supervised_user_circle_outlined),
    MenuOption(route: 'animated', name: 'Animated', screen: const AnimatedScreen(), icon: Icons.play_circle_filled_outlined),
    MenuOption(route: 'inputs', name: 'Text Inputs', screen: const InputScreen(), icon: Icons.input_rounded),
    MenuOption(route: 'slider', name: 'Slider Screen', screen: const SliderScreen(), icon: Icons.view_carousel),
    MenuOption(route: 'listviewBuilder', name: 'Listview Builder', screen: const ListviewBuilderScreen(), icon: Icons.list_outlined),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll({ 'home' : ( BuildContext context ) => const HomeScreen() });
    
    for (final option in menuOptions) {
      appRoutes.addAll({ option.route : ( BuildContext context ) => option.screen });
    }
    return appRoutes;
  }

/* Otra forma de crear las opciones del menú:
  static Map<String, Widget Function(BuildContext)> routes = {
    'home'     : (context) => const HomeScreen(),
    'listview1': (context) => const Listview1Screen(),
    'listview2': (context) => const Listview2Screen(),
    'alert'    : (context) => const AlertScreen(),
    'card'     : (context) => const CardScreen()
  };
*/

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  } 
}