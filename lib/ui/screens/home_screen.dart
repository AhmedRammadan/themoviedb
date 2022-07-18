import 'package:flutter/material.dart';

import '../../models/person_model.dart';
import '../../models/popular_people_model.dart';
import '../../provider/popular_people_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/popular_people_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  fetchData() async {
    Provider.of<PopularPeopleProvider>(context, listen: false)
        .fetchPopularPeople(context);
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          Provider.of<PopularPeopleProvider>(context, listen: false)
              .fetchNewPagePopularPeople(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularPeopleProvider>(
            builder: (index, popularPeopleProvider, child) {
          PopularPeopleModel popularPeopleModel =
              popularPeopleProvider.getPopularPeople();
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: popularPeopleModel.results.length,
                  itemBuilder: (context, index) {
                    return PopularPeopleItem(
                      personModel: popularPeopleModel.results[index],
                    );
                  },
                ),
              ),
              popularPeopleProvider.getIsLoading()
                  ? const SizedBox(
                      height: 150,
                      child: Center(child: CircularProgressIndicator()))
                  : Container(),
            ],
          );
        }),
      ),
    );
  }
}
