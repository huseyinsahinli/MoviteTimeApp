import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/movie.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = dotenv.env['API_URL'] ?? "API_URL_NOT_FOUND";
  final String apiKey = dotenv.env['API_KEY'] ?? "API_KEY_NOT_FOUND";
  List<Movie> movieList = [];
  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      final url = '$baseUrl/movie/popular?$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromMap(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Movie>> getRecentlyReleased() async {
    try {
      final url = '$baseUrl/movie/upcoming?$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromMap(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Movie>> getSearch(String? query) async {
    try {
      final url = '$baseUrl/movie/upcoming?$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      if (query != null) {
        movieList = movies.map((m) => Movie.fromMap(m)).toList();
        movieList = movieList
            .where((element) =>
                element.title.toLowerCase().contains((query.toLowerCase())))
            .toList();
      }

      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
  // Future<List<Movie>> getMovieByGenre(int movieId) async {
  //   try {
  //     final url = '$baseUrl/discover/movie?with_genres=$movieId&$apiKey';
  //     final response = await _dio.get(url);
  //     var movies = response.data['results'] as List;
  //     List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
  //     return movieList;
  //   } catch (error, stacktrace) {
  //     throw Exception(
  //         'Exception accoured: $error with stacktrace: $stacktrace');
  //   }
  // }

  // Future<List<Genre>> getGenreList() async {
  //   try {
  //     final response = await _dio.get('$baseUrl/genre/movie/list?$apiKey');
  //     var genres = response.data['genres'] as List;
  //     List<Genre> genreList = genres.map((g) => Genre.fromJson(g)).toList();
  //     return genreList;
  //   } catch (error, stacktrace) {
  //     throw Exception(
  //         'Exception accoured: $error with stacktrace: $stacktrace');
  //   }
  // }

  // Future<List<Person>> getTrendingPerson() async {
  //   try {
  //     final response = await _dio.get('$baseUrl/trending/person/week?$apiKey');
  //     var persons = response.data['results'] as List;
  //     List<Person> personList = persons.map((p) => Person.fromJson(p)).toList();
  //     return personList;
  //   } catch (error, stacktrace) {
  //     throw Exception(
  //         'Exception accoured: $error with stacktrace: $stacktrace');
  //   }
  // }

  // Future<MovieDetail> getMovieDetail(int movieId) async {
  //   try {
  //     final response = await _dio.get('$baseUrl/movie/$movieId?$apiKey');
  //     MovieDetail movieDetail = MovieDetail.fromJson(response.data);

  //     movieDetail.trailerId = await getYoutubeId(movieId);

  //     movieDetail.movieImage = await getMovieImage(movieId);

  //     movieDetail.castList = await getCastList(movieId);

  //     return movieDetail;
  //   } catch (error, stacktrace) {
  //     throw Exception(
  //         'Exception accoured: $error with stacktrace: $stacktrace');
  //   }
  // }

  // Future<String> getYoutubeId(int id) async {
  //   try {
  //     final response = await _dio.get('$baseUrl/movie/$id/videos?$apiKey');
  //     var youtubeId = response.data['results'][0]['key'];
  //     return youtubeId;
  //   } catch (error, stacktrace) {
  //     throw Exception(
  //         'Exception accoured: $error with stacktrace: $stacktrace');
  //   }
  // }

  // Future<MovieImage> getMovieImage(int movieId) async {
  //   try {
  //     final response = await _dio.get('$baseUrl/movie/$movieId/images?$apiKey');
  //     return MovieImage.fromJson(response.data);
  //   } catch (error, stacktrace) {
  //     throw Exception(
  //         'Exception accoured: $error with stacktrace: $stacktrace');
  //   }
  // }

  // Future<List<Cast>> getCastList(int movieId) async {
  //   try {
  //     final response =
  //         await _dio.get('$baseUrl/movie/$movieId/credits?$apiKey');
  //     var list = response.data['cast'] as List;
  //     List<Cast> castList = list
  //         .map((c) => Cast(
  //             name: c['name'],
  //             profilePath: c['profile_path'],
  //             character: c['character']))
  //         .toList();
  //     return castList;
  //   } catch (error, stacktrace) {
  //     throw Exception(
  //         'Exception accoured: $error with stacktrace: $stacktrace');
  //   }
  // }
}
