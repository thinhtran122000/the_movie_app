import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:tmdb/utils/utils.dart';

class AppUtils {
  static final AppUtils _instance = AppUtils._();
  AppUtils._();
  factory AppUtils() => _instance;
  int pixelsPerAxis = 8;
  Color getAverageColor(List<Color> colors) {
    int r = 0, g = 0, b = 0, a = 0;
    for (int i = 0; i < colors.length; i++) {
      r += colors[i].red; // all red of image
      g += colors[i].green; // all green of image
      b += colors[i].blue; // all blue of image
      a += colors[i].alpha; // all alpha of image
    }
    r = r ~/ colors.length; // average red of image
    g = g ~/ colors.length; // average green of image
    b = b ~/ colors.length; // average blue of image
    a = a ~/ colors.length; // average alpha of image
    return Color.fromARGB(a, r, g, b);
  }

  Color argbToColor(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    int hex = (argbColor & 0xFF00FF00) | (b << 16) | r;
    return Color(hex);
  }

  List<Color> sortColors(List<Color> colors) {
    List<Color> sorted = [];
    sorted.addAll(colors);
    sorted.sort((a, b) => b.computeLuminance().compareTo(a.computeLuminance()));
    return sorted;
  }

  Future<List<Color>> generatePalette(Map<String, dynamic> params) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      generatePaletteColor,
      [receivePort.sendPort, params],
    );
    final palette = await receivePort.first as List<Color>;
    receivePort.close();
    isolate.kill();
    return palette;
  }

  Future<List<Color>> extractColors(Uint8List? bytes) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      extractPixelsColor,
      [receivePort.sendPort, bytes],
    );
    final colors = await receivePort.first as List<Color>;
    receivePort.close();
    isolate.kill();
    return colors;
  }

  void generatePaletteColor(List<dynamic> arguments) {
    SendPort sendPort = arguments[0];
    Map<String, dynamic> params = arguments[1];
    List<Color> colors = [];
    List<Color> palette = [];
    colors.addAll(sortColors(params['palette']));
    int numberOfItems = params['numberOfItemsPixel'];
    if (numberOfItems <= colors.length) {
      final chunkSize = colors.length ~/ numberOfItems; // 16/16
      for (int i = 0; i < numberOfItems; i++) {
        final sublistColor = colors.sublist(i * chunkSize, (i + 1) * chunkSize);
        final averageColor = getAverageColor(sublistColor);
        palette.add(averageColor);
      }
    }
    sendPort.send(palette);
  }

  void extractPixelsColor(List<dynamic> arguments) {
    SendPort sendPort = arguments[0];
    Uint8List bytes = arguments[1];
    List<Color> colors = [];
    //decode image
    final values = bytes.buffer.asUint8List();
    final image = img.decodeImage(values);
    final pixels = [];
    int width = image?.width ?? 0;
    int height = image?.height ?? 0;
    int xChunk = (width ~/ (pixelsPerAxis + 1));
    int yChunk = (height ~/ (pixelsPerAxis + 1));
    for (int j = 1; j < pixelsPerAxis + 1; j++) {
      for (int i = 1; i < pixelsPerAxis + 1; i++) {
        int? pixel = image?.getPixel(xChunk * i, yChunk * j);
        pixels.add(pixel);
        colors.add(argbToColor(pixel!));
      }
    }
    sendPort.send(colors);
  }

  Future<double> getLuminance(List<Color> paletteColors) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      getLuminanceColor,
      [receivePort.sendPort, paletteColors],
    );
    final averageLuminance = await receivePort.first as double;
    receivePort.close();
    isolate.kill();
    return averageLuminance;
  }

  void getLuminanceColor(List<dynamic> arguments) {
    SendPort sendPort = arguments[0];
    List<Color> paletteColors = arguments[1];
    double totalLuminance = 0;
    for (final paletteColor in paletteColors) {
      totalLuminance += paletteColor.computeLuminance();
    }
    double averageLuminance = totalLuminance / paletteColors.length;
    sendPort.send(averageLuminance);
  }

  String getSortTitle(String sortBy) {
    return sortBy.contains('created_at.desc') ? 'Newest' : 'Oldest';
  }

  String formatDate(String date) {
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.parse(date);
    var outputDateTime = DateFormat('MMMM dd yyyy').format(outputDate);
    return outputDateTime;
  }

  String formatRuntime(int runtime) {
    final hours = runtime ~/ 60;
    final remainingMinutes = runtime % 60;
    return '${hours}h ${remainingMinutes}m';
  }

  String durationFormatter(int milliSeconds) {
    var seconds = milliSeconds ~/ 1000;
    final hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    var minutes = seconds ~/ 60;
    seconds = seconds % 60;
    final hoursString = hours >= 10
        ? '$hours'
        : hours == 0
            ? '00'
            : '0$hours';
    final minutesString = minutes >= 10
        ? '$minutes'
        : minutes == 0
            ? '00'
            : '0$minutes';
    final secondsString = seconds >= 10
        ? '$seconds'
        : seconds == 0
            ? '00'
            : '0$seconds';
    final formattedTime =
        '${hoursString == '00' ? '' : '$hoursString:'}$minutesString:$secondsString';
    return formattedTime;
  }

  int caculateAge(String birthday) {
    return DateTime.now().year - DateTime.parse(birthday).year;
  }

  String getYearReleaseOrDepartment(
    String? releaseDate,
    String? firstAirDate,
    String? lastAirDate,
    String mediaType,
    String? knownForDepartment,
  ) {
    switch (mediaType) {
      case 'movie':
        {
          return releaseDate == null || releaseDate.isEmpty
              ? 'Unknown'
              : releaseDate.substring(0, 4);
        }

      case 'tv':
        {
          return firstAirDate == null || firstAirDate.isEmpty
              ? 'Unknown'
              : firstAirDate.substring(0, 4);
        }
      case 'person':
        {
          return knownForDepartment == null || knownForDepartment.isEmpty ? '' : knownForDepartment;
        }
      default:
        {
          return '';
        }
    }
  }

  MediaType getMediaType(
    String? mediaType,
  ) {
    switch (mediaType) {
      case 'movie':
        {
          return MediaType.movie;
        }

      case 'tv':
        {
          return MediaType.tv;
        }
      case 'person':
        {
          return MediaType.person;
        }
      default:
        {
          return MediaType.movie;
        }
    }
  }

  showCustomDialog({
    required BuildContext context,
    required AlignmentGeometry alignment,
    Widget? child,
  }) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      useSafeArea: true,
      context: context,
      builder: (context) => Align(
        alignment: alignment,
        child: child,
      ),
    );
  }

  Color getMovieGenreColor(String name) {
    switch (name) {
      case 'Action':
        {
          return Colors.red;
        }
      case 'Adventure':
        {
          return Colors.orange;
        }
      case 'Animation':
        {
          return Colors.yellow;
        }
      case 'Comedy':
        {
          return Colors.lightBlue;
        }
      case 'Crime':
        {
          return Colors.amber;
        }
      case 'Documentary':
        {
          return Colors.blueGrey;
        }
      case 'Drama':
        {
          return Colors.blue;
        }
      case 'Family':
        {
          return Colors.lime;
        }
      case 'Fantasy':
        {
          return Colors.purple;
        }

      case 'History':
        {
          return Colors.cyan;
        }
      case 'Horror':
        {
          return Colors.green;
        }

      case 'Music':
        {
          return Colors.deepPurple;
        }
      case 'Mystery':
        {
          return Colors.indigo;
        }
      case 'Romance':
        {
          return Colors.pink;
        }
      case 'Science Fiction':
        {
          return Colors.teal;
        }
      case 'TV Movie':
        {
          return Colors.lightGreen;
        }
      case 'Thriller':
        {
          return Colors.deepOrange;
        }
      case 'War':
        {
          return Colors.grey;
        }
      case 'Western':
        {
          return Colors.brown;
        }
      default:
        return Colors.white;
    }
  }

  Color getTvGenreColor(String name) {
    switch (name) {
      case 'Action & Adventure':
        {
          return Colors.red;
        }
      case 'Animation':
        {
          return Colors.yellow;
        }
      case 'Comedy':
        {
          return Colors.lightBlue;
        }
      case 'Crime':
        {
          return Colors.amber;
        }
      case 'Documentary':
        {
          return Colors.blueGrey;
        }
      case 'Drama':
        {
          return Colors.blue;
        }
      case 'Family':
        {
          return Colors.lime;
        }
      case 'Kids':
        {
          return Colors.cyan;
        }
      case 'Mystery':
        {
          return Colors.indigo;
        }
      case 'News':
        {
          return Colors.deepOrange;
        }
      case 'Reality':
        {
          return Colors.purple;
        }
      case 'Sci-Fi & Fantasy':
        {
          return Colors.teal;
        }
      case 'Soap':
        {
          return Colors.pink;
        }
      case 'Talk':
        {
          return Colors.green;
        }
      case 'War & Politics':
        {
          return Colors.grey;
        }
      case 'Western':
        {
          return Colors.brown;
        }
      default:
        return Colors.white;
    }
  }
}

// List<Color> generatePalette(Map<String, dynamic> params) {
//   List<Color> colors = [];
//   List<Color> palette = [];
//   colors.addAll(sortColors(params['palette']));
//   int numberOfItems = params['numberOfItems'];
//   if (numberOfItems <= colors.length) {
//     final chunkSize = colors.length ~/ numberOfItems; // 16/16
//     for (int i = 0; i < numberOfItems; i++) {
//       final sublistColor = colors.sublist(i * chunkSize, (i + 1) * chunkSize);
//       final averageColor = getAverageColor(sublistColor);
//       palette.add(averageColor);
//     }
//   }
//   return palette;
// }

// List<Color> extractPixelsColors(Uint8List? bytes) {
//   List<Color> colors = [];
//   //decode image
//   final values = bytes!.buffer.asUint8List();
//   final image = img.decodeImage(values);
//   final pixels = [];
//   int width = image?.width ?? 0;
//   int height = image?.height ?? 0;
//   int xChunk = (width ~/ (pixelsPerAxis + 1));
//   int yChunk = (height ~/ (pixelsPerAxis + 1));
//   for (int j = 1; j < pixelsPerAxis + 1; j++) {
//     for (int i = 1; i < pixelsPerAxis + 1; i++) {
//       int? pixel = image?.getPixel(xChunk * i, yChunk * j);
//       pixels.add(pixel);
//       colors.add(argbToColor(pixel!));
//     }
//   }

//   return colors;
// }

// double getLuminance(List<Color> paletteColors) {
//   double totalLuminance = 0;
//   for (final paletteColor in paletteColors) {
//     totalLuminance += paletteColor.computeLuminance();
//   }
//   double averageLuminance = totalLuminance / paletteColors.length;
//   return averageLuminance;
// }

// Future<List<MediaTrailer>> getTrailersMovie(Map<String, dynamic> params) async {
//   final receivePort = ReceivePort();
//   final isolate = await Isolate.spawn(
//     getListTrailerMovie,
//     [receivePort.sendPort, params],
//   );
//   final listTrailer = await receivePort.first as List<MediaTrailer>;
//   receivePort.close();
//   isolate.kill();
//   return listTrailer;
// }

// void getListTrailerMovie(List<dynamic> arguments) async {
//   ExploreRepository exploreRepository = ExploreRepository(restApiClient: RestApiClient());
//   List<List<MediaTrailer>> listOfListTrailerMovie = [];
//   SendPort sendPort = arguments[0];
//   Map<String, dynamic> params = arguments[1];
//   for (int i = 0; i < params['list_movie'].length; i++) {
//     final resultsTrailerMovie = await exploreRepository.getTrailerMovie(
//       movieId: params['list_movie'][i].id ?? 0,
//       language: params['language'],
//     );
//     if (resultsTrailerMovie.list.isEmpty) {
//       listOfListTrailerMovie.insert(i, []);
//       continue;
//     } else {
//       listOfListTrailerMovie.add(resultsTrailerMovie.list);
//     }
//   }
//   final listTrailerMovie = listOfListTrailerMovie.map<MediaTrailer>((e) {
//     if (e.isNotEmpty) {
//       return e.first;
//     } else {
//       return MediaTrailer(key: '');
//     }
//   }).toList();
//   sendPort.send(listTrailerMovie);
// }

// Future<List<MediaTrailer>> getTrailersTv(Map<String, dynamic> params) async {
//   final receivePort = ReceivePort();
//   final isolate = await Isolate.spawn(
//     getListTrailerTv,
//     [receivePort.sendPort, params],
//   );
//   final listTrailer = await receivePort.first as List<MediaTrailer>;
//   receivePort.close();
//   isolate.kill();
//   return listTrailer;
// }

// void getListTrailerTv(List<dynamic> arguments) async {
//   ExploreRepository exploreRepository = ExploreRepository(restApiClient: RestApiClient());
//   List<List<MediaTrailer>> listOfListTrailerTv = [];
//   SendPort sendPort = arguments[0];
//   Map<String, dynamic> params = arguments[1];
//   for (int i = 0; i < params['list_tv'].length; i++) {
//     final resultsTrailerTv = await exploreRepository.getTrailerTv(
//       seriesId: params['list_tv'][i].id as int,
//       language: params['language'],
//     );
//     if (resultsTrailerTv.list.isEmpty) {
//       listOfListTrailerTv.insert(i, []);
//       continue;
//     } else {
//       listOfListTrailerTv.add(resultsTrailerTv.list);
//     }
//   }
//   final listTrailerTv = listOfListTrailerTv.map<MediaTrailer>((e) {
//     if (e.isNotEmpty) {
//       return e.first;
//     } else {
//       return MediaTrailer(key: '');
//     }
//   }).toList();
//   sendPort.send(listTrailerTv);
// }
