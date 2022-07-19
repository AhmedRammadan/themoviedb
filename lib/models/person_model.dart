import 'person_known_for_model.dart';

class PersonModel {
  PersonModel({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownFor,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    required this.profilePath,
  });
  late final bool adult;
  late final int gender;
  late final int id;
  late final List<PersonKnownForModel> knownFor;
  late final String knownForDepartment;
  late final String name;
  late final double popularity;
  late final String profilePath;

  PersonModel.fromJson(Map<String, dynamic> json) {
    adult =json['adult']==0?false:true; json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownFor = List.from(json['known_for'])
        .map((e) => PersonKnownForModel.fromJson(e))
        .toList();
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    popularity = json['popularity'];
    profilePath = json['profile_path']??"";
  }

PersonModel.fromJsonSQLDB(Map<String, dynamic> json) {
    adult =json['adult']==0?false:true;
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    popularity = json['popularity'];
    profilePath = json['profile_path']??"";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['adult'] = adult ? 0:1;
    _data['gender'] = gender;
    _data['known_for_department'] = knownForDepartment;
    _data['id_person'] = id;
    _data['name'] = name;
    _data['popularity'] = popularity;
    _data['profile_path'] = profilePath;
    return _data;
  }
}
