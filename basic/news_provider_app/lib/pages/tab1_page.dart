import 'package:flutter/material.dart';
import 'package:news_provider_app/services/news_service.dart';
import 'package:news_provider_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({super.key});

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsService = Provider.of<NewsService>(context);
    
    return Scaffold(
      body: newsService.articles.isEmpty
      ? const Center(child: CircularProgressIndicator(),)
      : ArticleListBuilder(articles: newsService.articles)
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
