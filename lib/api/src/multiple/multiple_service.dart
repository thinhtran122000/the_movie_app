import 'package:tmdb/api/api_client/index.dart';
import 'package:tmdb/api/src/multiple/multiple_request.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/utils/rest_api_client/response_type.dart';

class MultipleService {
  APIClient apiClient;
  MultipleService({
    required this.apiClient,
  });

  Future<ListResponse<MultipleMedia>> getTrendingMultiple({
    required String mediaType,
    required int page,
    required String language,
    required String timeWindow,
    bool? includeAdult,
  }) async {
    final request = MultipleRequest.getTrendingMultiple(
      mediaType: mediaType,
      page: page,
      language: language,
      timeWindow: timeWindow,
      includeAdult: includeAdult,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MultipleMedia>> getsearchMultiple({
    required String query,
    required bool includeAdult,
    required String language,
    required int page,
  }) async {
    final request = MultipleRequest.getsearchMultiple(
      query: query,
      includeAdult: includeAdult,
      language: language,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}
