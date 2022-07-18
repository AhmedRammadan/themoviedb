import 'package:flutter/material.dart';
import 'package:themoviedb/ui/screens/MyImage.dart';

import '../../models/person_details_model.dart';
import '../../models/person_model.dart';
import '../../models/popular_people_model.dart';
import '../../provider/person_details_provider.dart';
import '../../provider/popular_people_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../utils/network.dart';
import '../widgets/my_cached_network_image.dart';
import '../widgets/popular_people_item.dart';

class PersonDetailsScreen extends StatefulWidget {
  int id;
  PersonDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  _PersonDetailsScreenState createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PersonDetailsProvider>(context, listen: false)
        .fetchPersonDetails(context, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PersonDetailsProvider>(
            builder: (index, personDetailsProvider, child) {
          PersonDetailsModel personDetailsModel =
              personDetailsProvider.getPersonDetails();
          if (personDetailsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Constants.push(context,
                        MyImage(filePath: personDetailsModel.profilePath));
                  },
                  child: MyCachedNetworkImage(
                    imageUrl: imageBaseUrlFace + personDetailsModel.profilePath,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  personDetailsModel.name,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 300,
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 7 / 5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 5),
                      itemCount: personDetailsModel.profiles.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyImage(
                                        filePath: personDetailsModel
                                            .profiles[index].filePath)));
                          },
                          child: MyCachedNetworkImage(
                            imageUrl: imageBaseUrlDetails +
                                personDetailsModel.profiles[index].filePath,
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  personDetailsModel.biography,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
