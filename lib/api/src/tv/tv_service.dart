import 'package:tmdb/api/api.dart';
import 'package:tmdb/api/src/tv/tv.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/utils/rest_api_client/response_type.dart';

class TvService {
  TvService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<MultipleMedia>> getDiscoverTv({
    required String language,
    required int page,
    List<int> withGenres = const [],
  }) async {
    final request = TvRequest.getDiscoverTv(
      language: language,
      page: page,
      withGenres: withGenres,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MultipleMedia>> getNowPlayingTv({
    required String language,
    required int page,
  }) async {
    final request = TvRequest.getNowPlayingTv(
      language: language,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MultipleMedia>> getPopularTv({
    required String language,
    required int page,
    String? region,
  }) async {
    final request = TvRequest.getPopularTv(
      language: language,
      page: page,
      region: region,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MultipleMedia>> getUpcomingTv({
    required String language,
    required int page,
    String? timezone,
  }) async {
    final request = TvRequest.getUpcomingTv(
      language: language,
      page: page,
      timezone: timezone,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MultipleMedia>> getTopRatedTv({
    required String language,
    required int page,
  }) async {
    final request = TvRequest.getTopRatedTv(
      language: language,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ObjectResponse<MultipleDetails>> getDetailsTv({
    required String language,
    required int tvId,
    String? appendToResponse,
  }) async {
    final request = TvRequest.getDetailsTv(
      tvId: tvId,
      language: language,
      appendToResponse: appendToResponse,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = MultipleDetails.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ObjectResponse<MediaImages>> getImagesTv({
    required String language,
    required int seriesId,
    String? includeImageLanguage,
  }) async {
    final request = TvRequest.getImagesTv(
      seriesId: seriesId,
      language: language,
      includeImageLanguage: includeImageLanguage,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = MediaImages.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ObjectResponse<MediaCredits>> getTvCredits({
    required String language,
    required int seriesId,
  }) async {
    final request = TvRequest.getTvCredits(
      seriesId: seriesId,
      language: language,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = MediaCredits.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }

  Future<ListResponse<MultipleMedia>> getTvRelated({
    required String language,
    required int seriesId,
    required int page,
  }) async {
    final request = TvRequest.getTvRelated(
      seriesId: seriesId,
      language: language,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}
