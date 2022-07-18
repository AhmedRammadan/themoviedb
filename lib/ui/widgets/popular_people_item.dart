import 'package:flutter/material.dart';
import 'package:themoviedb/ui/screens/person_details_screen.dart';
import 'package:themoviedb/ui/widgets/my_cached_network_image.dart';
import 'package:themoviedb/utils/constants.dart';
import 'package:themoviedb/utils/network.dart';

import '../../models/person_model.dart';

class PopularPeopleItem extends StatelessWidget {
  PersonModel personModel;
  PopularPeopleItem({Key? key, required this.personModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Constants.push(context, PersonDetailsScreen(id: personModel.id));
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 200,
          child: Row(
            children: [
              MyCachedNetworkImage(imageUrl:  imageBaseUrlFace + personModel.profilePath),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        personModel.name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        personModel.knownForDepartment,
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
