import 'package:movie_app/api/src/multiple/multiple.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';

class SearchRepository {
  final RestApiClient restApiClient;
  SearchRepository({
    required this.restApiClient,
  });

  Future<ListResponse<MultipleMedia>> getsearchMultiple({
    required String query,
    required bool includeAdult,
    required String language,
    required int page,
  }) async {
    return MultipleService(apiClient: restApiClient).getsearchMultiple(
      query: query,
      includeAdult: includeAdult,
      language: language,
      page: page,
    );
  }
}
