import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const CircularProgressIndicator()
              : Consumer<GreatPlaces>(
                  child: const Center(
                    child: Text('Added a place'),
                  ),
                  builder: (ctx, greatPlacesData, ch) =>
                      greatPlacesData.items.isEmpty
                          ? ch!
                          : ListView.builder(
                              itemCount: greatPlacesData.items.length,
                              itemBuilder: (ctx, i) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlacesData.items[i].image),
                                ),
                                title: Text(greatPlacesData.items[i].title),
                                onTap: () {
                                  //go to detail page
                                },
                              ),
                            ),
                ),
        ),
      ),
    );
  }
}
