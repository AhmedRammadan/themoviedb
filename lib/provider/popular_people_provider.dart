import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:themoviedb/models/person_model.dart';
import 'package:themoviedb/models/popular_people_model.dart';
import 'package:themoviedb/utils/sql_helper.dart';

import '../utils/constants.dart';
import '../utils/network.dart';

class PopularPeopleProvider with ChangeNotifier {
  PopularPeopleModel? peopleModel =
      PopularPeopleModel(page: 1, results: [], totalPages: 0, totalResults: 0);
  bool isLoading = true;

  fetchPopularPeople(context) async {
    if (await Constants.checkNetwork()) {
      var res = await APIHelper.get(
          "/person/popular?page=${peopleModel?.page}", context);
      peopleModel = PopularPeopleModel.fromJson(res);
      peopleModel?.results = List.from(res['results'])
          .map((e) => PersonModel.fromJson(e))
          .toList();
      SQLHelper.createListPeople(peopleModel?.results);
    } else {
      peopleModel?.results = await SQLHelper.getPeople();
    }
    isLoading = false;
    notifyListeners();
  }

  fetchNewPagePopularPeople(context) async {
    if (await Constants.checkNetwork()) {
      peopleModel?.page++;
      var res = await APIHelper.get(
          "/person/popular?page=${peopleModel?.page}", context);
      peopleModel?.results += List.from(res['results'])
          .map((e) => PersonModel.fromJson(e))
          .toList();
      SQLHelper.createListPeople(peopleModel?.results);
      isLoading = false;
      notifyListeners();
    } else {
      Constants.notConnectedDialog(context);
    }
  }

  PopularPeopleModel getPopularPeople() {
    return peopleModel!;
  }

  bool getIsLoading() => isLoading;
}
