class PersonKnownForModel {
  PersonKnownForModel({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.mediaType,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });
  late final String backdropPath;
  late final String firstAirDate;
  late final List<int> genreIds;
  late final int id;
  late final String mediaType;
  late final String name;
  late final List<String> originCountry;
  late final String originalLanguage;
  late final String originalName;
  late final String overview;
  late final String posterPath;
  late final double? voteAverage;
  late final int voteCount;

  PersonKnownForModel.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path']??"";
    firstAirDate = json['first_air_date'] ?? "";
    genreIds = List.castFrom<dynamic, int>(json['genre_ids']);
    id = json['id'];
    mediaType = json['media_type'];
    name = json['name'] ?? "";
    originCountry =
        List.castFrom<dynamic, String>(json['origin_country'] ?? []);
    originalLanguage = json['original_language']??"";
    originalName = json['original_name']??"";
    overview = json['overview']??"";
    posterPath = json['poster_path']??"";
    voteAverage = double.parse("${json['vote_average']}");
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['backdrop_path'] = backdropPath;
    _data['first_air_date'] = firstAirDate;
    _data['genre_ids'] = genreIds;
    _data['id'] = id;
    _data['media_type'] = mediaType;
    _data['name'] = name;
    _data['origin_country'] = originCountry;
    _data['original_language'] = originalLanguage;
    _data['original_name'] = originalName;
    _data['overview'] = overview;
    _data['poster_path'] = posterPath;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
    return _data;
  }
}
