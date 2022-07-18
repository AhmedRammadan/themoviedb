import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:themoviedb/models/person_model.dart';
import 'package:themoviedb/models/popular_people_model.dart';

import '../utils/network.dart';
import '../utils/ny_cache.dart';

class PopularPeopleProvider with ChangeNotifier {
  PopularPeopleModel? peopleModel =
      PopularPeopleModel(page: 1, results: [], totalPages: 0, totalResults: 0);
  bool isLoading = true;

  fetchPopularPeople(context) async {
    var apiRes = await MyCache.load('home_screen${peopleModel?.page}');
    if (apiRes == null) {
      var res = await APIHelper.get(
          "/person/popular?page=${peopleModel?.page}", context);
      await MyCache.remember('home_screen${peopleModel?.page}', res);
      apiRes = await MyCache.load('home_screen${peopleModel?.page}');
    }
    peopleModel = PopularPeopleModel.fromJson(apiRes);
    isLoading = false;
    notifyListeners();
  }

  fetchNewPagePopularPeople(context) async {
    peopleModel?.page++;
    var apiRes = await MyCache.load('home_screen${peopleModel?.page}');
    if (apiRes == null) {
      var res = await APIHelper.get(
          "/person/popular?page=${peopleModel?.page}", context);
      await MyCache.remember('home_screen${peopleModel?.page}', res);
      apiRes = await MyCache.load('home_screen${peopleModel?.page}');
    }
    peopleModel?.results += List.from(apiRes['results'])
        .map((e) => PersonModel.fromJson(e))
        .toList();
    isLoading = false;
    notifyListeners();
  }

  PopularPeopleModel getPopularPeople() => peopleModel!;
  bool getIsLoading() => isLoading;
}
