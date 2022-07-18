import 'package:flutter/cupertino.dart';
import '../models/person_details_model.dart';

class PersonDetailsProvider with ChangeNotifier {
  PersonDetailsModel? personModel;

  fetchPersonDetails() async {

  }

  PersonDetailsModel getPersonDetails() => personModel!;
}
