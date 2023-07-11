import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';

import 'package:movies_app/search/movie_search_delegate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartelera'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),             
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(movies: moviesProvider.onDisplay),
            MovideSlider(
              movies: moviesProvider.popular,
              title: 'Populares',
              onNextPage: () => moviesProvider.getPopular(),
            ),
            MovideSlider(
              movies: moviesProvider.popular,
              title: 'Próximamente...',
              onNextPage: () => moviesProvider.getPopular(),
            ),
          ],
        ),
      ),
    );
  }

}