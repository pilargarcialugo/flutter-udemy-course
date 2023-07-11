import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/providers/movies_provider.dart';

import '../models/models.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  Widget _emptyContainer() {
    return const Center(
      child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 100,),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return _emptyContainer();

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsBy(query);
    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        List<Movie> movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItem(movie: movies[index])
        );
      }
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/default.png'),
          image: NetworkImage(movie.fullPosterImg),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    );
  }
}
