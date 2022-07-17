import 'package:flutter/cupertino.dart';

import '../models/famous_person.dart';

class PopularPeopleProvider with ChangeNotifier {
  List<FamousPerson>? _popularPeople;

  fetchPopularPeople() async {}

  List<FamousPerson> getPopularPeople() => _popularPeople!;
}
