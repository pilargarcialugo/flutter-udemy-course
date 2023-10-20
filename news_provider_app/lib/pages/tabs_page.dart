import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_provider_app/pages/pages.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: const Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages();

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        Tab1Page(),
        Tab2Page()
      ],
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation();

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.currentPage,
      onTap: (i) => navigationModel.currentPage = i,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.public_outlined),
          label: 'News',    
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          label: 'For you',
        ),
      ]
    );
  }
}

class _NavigationModel with ChangeNotifier { 
  int _currentPage = 0;
  final PageController _pageController = PageController();

  int get currentPage => _currentPage;
  
  set currentPage (int value) {
    _currentPage = value;
    _pageController.animateToPage(
      value, 
      duration: const Duration(milliseconds: 250), 
      curve: Curves.easeOut
    );
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
