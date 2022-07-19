import 'package:flutter/cupertino.dart';
import '../models/person_details_model.dart';
import '../utils/constants.dart';
import '../utils/network.dart';

class PersonDetailsProvider with ChangeNotifier {
  PersonDetailsModel? personModel = PersonDetailsModel(
      deathday: '',
      gender: 1,
      id: 0,
      profilePath: '',
      imdbId: '',
      alsoKnownAs: [],
      knownForDepartment: '',
      biography: '',
      popularity: 0,
      birthday: '',
      placeOfBirth: '',
      name: '',
      homepage: '',
      adult: true);
  bool isLoading = true;

  fetchPersonDetails(context, int id) async {
    if (await Constants.checkNetwork()) {
      isLoading = true;
      var res = await APIHelper.get("/person/$id?", context);
      var resProfile = await APIHelper.get("/person/$id/images?", context);
      personModel = PersonDetailsModel.fromJson(res, resProfile);
      isLoading = false;
      notifyListeners();
    } else {
      Constants.notConnectedDialog(context);
    }
  }

  PersonDetailsModel getPersonDetails() => personModel!;
}
