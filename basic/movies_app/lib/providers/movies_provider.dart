import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/helpers/debouncer.dart';
import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey    = '72a4fcb3514eef6004abd08c226e6249';
  final String _baseUrl   = 'api.themoviedb.org';
  final String _language  = 'es-ES';

  List<Movie> onDisplay = [];
  List<Movie> popular = [];
  int _popularPage = 0;
  Map<int, List<Cast>> movieCast = {};

  final StreamController<List<Movie>> _suggestionsStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _suggestionsStreamController.stream;
  
  final debouncer = Debouncer(duration: const Duration(milliseconds: 500),);
  
  MoviesProvider() {
    getOnDisplay();
    getPopular();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language' : _language,
      'page' : '$page'
    });
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplay() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(jsonData);
    onDisplay = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopular() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromRawJson(jsonData);
    popular = [...popular, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) {
      return movieCast[movieId]!;
    }
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromRawJson(jsonData);
    movieCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language' : _language,
      'query': query
    });
    final response = await http.get(url);
    final movieSearchResponse = MovieSearchResponse.fromRawJson(response.body);
    return movieSearchResponse.results;
  }

  void getSuggestionsBy(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final result = await searchMovies(value);
      _suggestionsStreamController.add(result);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) => debouncer.value = query);
    Future.delayed(const Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

}