import 'package:flutter/cupertino.dart';
import 'package:themoviedb/models/popular_people_model.dart';

class PopularPeopleProvider with ChangeNotifier {
  PopularPeopleModel? peopleModel;

  fetchPopularPeople() async {

  }

  PopularPeopleModel getPopularPeople() => peopleModel!;
}
