class ImageResult {
  num? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  num? voteAverage;
  int? voteCount;
  int? width;

  ImageResult({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  factory ImageResult.fromJson(Map<String, dynamic> json) => ImageResult(
        aspectRatio: json['aspect_ratio'].toDouble(),
        height: json['height'],
        iso6391: json['iso_639_1'],
        filePath: json['file_path'],
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count'],
        width: json['width'],
      );
}
