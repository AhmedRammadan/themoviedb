import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:themoviedb/models/person_model.dart';
import 'package:themoviedb/models/popular_people_model.dart';

import '../utils/network.dart';

class PopularPeopleProvider with ChangeNotifier {
  PopularPeopleModel? peopleModel =
      PopularPeopleModel(page: 1, results: [], totalPages: 0, totalResults: 0);
  bool isLoading = true;

  fetchPopularPeople(context) async {
    var res = await APIHelper.get(
        "/person/popular?page=${peopleModel?.page}", context);
    peopleModel = PopularPeopleModel.fromJson(res);
    isLoading = false;
    notifyListeners();
  }

  fetchNewPagePopularPeople(context) async {
    peopleModel?.page++;

    var res = await APIHelper.get(
        "/person/popular?page=${peopleModel?.page}", context);

    peopleModel?.results +=
        List.from(res['results']).map((e) => PersonModel.fromJson(e)).toList();

    isLoading = false;
    notifyListeners();
  }

  PopularPeopleModel getPopularPeople() => peopleModel!;
  bool getIsLoading() => isLoading;
}
