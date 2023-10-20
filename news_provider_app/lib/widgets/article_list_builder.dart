import 'package:flutter/material.dart';
import 'package:news_provider_app/models/news_response.dart';
import 'package:news_provider_app/widgets/widgets.dart';

class ArticleListBuilder extends StatelessWidget {
  final List<Article> articles;

  const ArticleListBuilder({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleBuilder(article: articles[index], index: index,);
      },
    );
  }
}