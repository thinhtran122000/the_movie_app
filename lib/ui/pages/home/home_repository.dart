import 'package:tmdb/api/api.dart';
import 'package:tmdb/api/src/src.dart';
import 'package:tmdb/models/models.dart';
import 'package:tmdb/utils/utils.dart';

class HomeRepository {
  final RestApiClient restApiClient;
  HomeRepository({
    required this.restApiClient,
  });

  Future<ObjectResponse<MediaGenre>> getGenreMovie({
    required String language,
  }) async {
    return GenreService(apiClient: restApiClient).getGenreMovie(
      language: language,
    );
  }

  Future<ObjectResponse<MediaGenre>> getGenreTv({
    required String language,
  }) async {
    return GenreService(apiClient: restApiClient).getGenreTv(
      language: language,
    );
  }

  Future<ListResponse<MultipleMedia>> getPopularMovie({
    required String language,
    required int page,
    String? region,
  }) async {
    return MovieService(apiClient: restApiClient).getPopularMovie(
      language: language,
      page: page,
      region: region,
    );
  }

  Future<ListResponse<MultipleMedia>> getPopularTv({
    required String language,
    required int page,
    String? region,
  }) async {
    return TvService(apiClient: restApiClient).getPopularTv(
      language: language,
      page: page,
      region: region,
    );
  }

  Future<ListResponse<MultipleMedia>> getNowPlayingMovie({
    required String language,
    required int page,
    required String region,
  }) async {
    return MovieService(apiClient: restApiClient).getNowPlayingMovie(
      language: language,
      page: page,
      region: region,
    );
  }

  Future<ListResponse<MultipleMedia>> getNowPlayingTv({
    required String language,
    required int page,
  }) async {
    return TvService(apiClient: restApiClient).getNowPlayingTv(
      language: language,
      page: page,
    );
  }

  Future<ListResponse<MultipleMedia>> getTopRatedMovie({
    required String language,
    required int page,
    required String region,
  }) async {
    return MovieService(apiClient: restApiClient).getTopRatedMovie(
      language: language,
      page: page,
      region: region,
    );
  }

  Future<ListResponse<MultipleMedia>> getTopRatedTv({
    required String language,
    required int page,
  }) async {
    return TvService(apiClient: restApiClient).getTopRatedTv(
      language: language,
      page: page,
    );
  }

  Future<ListResponse<MultipleMedia>> getUpcomingMovie({
    required String language,
    required int page,
    required String region,
  }) async {
    return MovieService(apiClient: restApiClient).getUpcomingMovie(
      language: language,
      page: page,
      region: region,
    );
  }

  Future<ListResponse<MultipleMedia>> getTrendingMultiple({
    required String mediaType,
    required String timeWindow,
    required int page,
    required String language,
    required bool includeAdult,
  }) async {
    return MultipleService(apiClient: restApiClient).getTrendingMultiple(
      mediaType: mediaType,
      timeWindow: timeWindow,
      page: page,
      language: language,
      includeAdult: includeAdult,
    );
  }

  Future<ListResponse<MultipleMedia>> getDiscoverMovie({
    required String language,
    required int page,
    List<int> withGenres = const [],
  }) async {
    return MovieService(apiClient: restApiClient).getDiscoverMovie(
      language: language,
      page: page,
      withGenres: withGenres,
    );
  }

  Future<ListResponse<MultipleMedia>> getDiscoverTv({
    required String language,
    required int page,
    List<int> withGenres = const [],
  }) async {
    return TvService(apiClient: restApiClient).getDiscoverTv(
      language: language,
      page: page,
      withGenres: withGenres,
    );
  }

  Future<ListResponse<MediaTrailer>> getTrailerMovie({
    required int movieId,
    required String language,
  }) async {
    return TrailerService(apiClient: restApiClient).getTrailerMovie(
      movieId: movieId,
      language: language,
    );
  }

  Future<ListResponse<MediaTrailer>> getTrailerTv({
    required int seriesId,
    required String language,
    String? includeVideoLanguage,
  }) async {
    return TrailerService(apiClient: restApiClient).getTrailerTv(
      seriesId: seriesId,
      language: language,
      includeVideoLanguage: includeVideoLanguage,
    );
  }

  Future<ObjectResponse<MediaState>> getMovieState({
    required int movieId,
    required String sessionId,
  }) async {
    return StateService(apiClient: restApiClient).getMovieState(
      movieId: movieId,
      sessionId: sessionId,
    );
  }

  Future<ObjectResponse<MediaState>> getTvState({
    required int seriesId,
    required String sessionId,
  }) async {
    return StateService(apiClient: restApiClient).getTvState(
      seriesId: seriesId,
      sessionId: sessionId,
    );
  }

  Future<ListResponse<MediaArtist>> getPopularArtist({
    required String language,
    required int page,
  }) async {
    return ArtistService(apiClient: restApiClient).getPopularArtist(
      language: language,
      page: page,
    );
  }

  Future<ObjectResponse<ArtistDetails>> getDetailsArtist({
    required int personId,
    required String language,
    String? appendToResponse,
  }) async {
    return ArtistService(apiClient: restApiClient).getDetailsArtist(
      personId: personId,
      language: language,
      appendToResponse: appendToResponse,
    );
  }

  Future<ListResponse<MediaProvider>> getMovieProvider({
    required String language,
    required String watchRegion,
  }) async {
    return ProviderService(apiClient: restApiClient).getMovieProvider(
      language: language,
      watchRegion: watchRegion,
    );
  }

  Future<ListResponse<MediaProvider>> getTvProvider({
    required String language,
    required String watchRegion,
  }) async {
    return ProviderService(apiClient: restApiClient).getTvProvider(
      language: language,
      watchRegion: watchRegion,
    );
  }

  Future<ObjectResponse<APIResponse>> addWatchList({
    required int accountId,
    required String sessionId,
    required String mediaType,
    required int mediaId,
    required bool watchlist,
  }) async {
    return WatchlistService(apiClient: restApiClient).addWatchList(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: mediaType,
      mediaId: mediaId,
      watchlist: watchlist,
    );
  }

  Future<ObjectResponse<APIResponse>> addFavorite({
    required int accountId,
    required String sessionId,
    required String mediaType,
    required int mediaId,
    required bool favorite,
  }) async {
    return FavoriteService(apiClient: restApiClient).addFavorite(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: mediaType,
      mediaId: mediaId,
      favorite: favorite,
    );
  }
}
