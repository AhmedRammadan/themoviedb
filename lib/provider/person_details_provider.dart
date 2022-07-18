import 'package:flutter/cupertino.dart';
import 'package:themoviedb/models/popular_people_model.dart';

class PersonDetailsProvider with ChangeNotifier {
  PersonDetailsModel? personModel;

  fetchPersonDetails() async {

  }

  PersonDetailsModel getPersonDetails() => personModel!;
}
