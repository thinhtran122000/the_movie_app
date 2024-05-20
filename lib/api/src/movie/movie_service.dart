import 'package:tmdb/api/api.dart';
import 'package:tmdb/api/src/movie/movie_request.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/utils/rest_api_client/response_type.dart';

class MovieService {
  MovieService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<MultipleMedia>> getPopularMovie({
    required String language,
    required int page,
    String? region,
  }) async {
    final request = MovieRequest.getPopularMovie(
      language: language,
      page: page,
      region: region,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MultipleMedia>> getUpcomingMovie({
    required String language,
    required int page,
    String? region,
  }) async {
    final request = MovieRequest.getUpcomingMovie(
      language: language,
      page: page,
      region: region,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MultipleMedia>> getTopRatedMovie({
    required String language,
    required int page,
    String? region,
  }) async {
    final request = MovieRequest.getTopRatedMovie(
      language: language,
      page: page,
      region: region,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MultipleMedia>> getNowPlayingMovie({
    required String language,
    required int page,
    String? region,
  }) async {
    final request = MovieRequest.getNowPlayingMovie(
      language: language,
      page: page,
      region: region,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MultipleMedia>> getDiscoverMovie({
    required String language,
    required int page,
    List<int> withGenres = const [],
  }) async {
    final request = MovieRequest.getDiscoverMovie(
      language: language,
      page: page,
      withGenres: withGenres,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ObjectResponse<MultipleDetails>> getDetailsMovie({
    required String language,
    required int movieId,
    String? appendToResponse,
  }) async {
    final request = MovieRequest.getDetailsMovie(
      movieId: movieId,
      language: language,
      appendToResponse: appendToResponse,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = MultipleDetails.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ObjectResponse<MediaImages>> getImagesMovie({
    required String language,
    required int movieId,
    String? includeImageLanguage,
  }) async {
    final request = MovieRequest.getImagesMovie(
      movieId: movieId,
      language: language,
      includeImageLanguage: includeImageLanguage,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = MediaImages.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ObjectResponse<MediaCredits>> getMovieCredits({
    required String language,
    required int movieId,
  }) async {
    final request = MovieRequest.getMovieCredits(
      movieId: movieId,
      language: language,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = MediaCredits.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ListResponse<MultipleMedia>> getMovieRelated({
    required String language,
    required int movieId,
    required int page,
  }) async {
    final request = MovieRequest.getMovieRelated(
      movieId: movieId,
      language: language,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}
