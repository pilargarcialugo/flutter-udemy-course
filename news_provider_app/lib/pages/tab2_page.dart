import 'package:flutter/material.dart';
import 'package:news_provider_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'package:news_provider_app/services/news_service.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const _CategoriesListView(),
            Expanded(
              child: ArticleListBuilder(articles: newsService.selectedArticlesByCategory!),
            )
          ],
        ),
      ),
    );
  }
}

class _CategoriesListView extends StatelessWidget {
  const _CategoriesListView();

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    final categories = newsService.categories;
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryButton(category.icon, category.name),
                  const SizedBox(height: 5,),
                  Text(_formatName(category.name)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatName(String name) => '${name[0].toUpperCase()}${name.substring(1)}';
}

class _CategoryButton extends StatelessWidget {
  final IconData icon;
  final String categoryName;

  const _CategoryButton(this.icon, this.categoryName);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoryName;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(icon, color: _resolveIconColor(newsService.selectedCategory),),
      ),
    );
  }

  Color _resolveIconColor(String selectedCategory) 
  => categoryName == selectedCategory 
  ? const Color(0xfff4a261) 
  : Colors.black54;
}
