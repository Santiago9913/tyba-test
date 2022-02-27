import 'package:flutter/material.dart';
import 'package:tyba_challenge/handlers/mapbox_handler.dart';

import '../models/user.dart';

class RestaurantsScreen extends StatefulWidget {
  RestaurantsScreen({Key? key, required this.user}) : super(key: key);

  User user;

  @override
  _RestaurantsScreenState createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.directions_car),
              ),
              Tab(
                icon: Icon(Icons.directions_transit),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TextField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        MapBoxHandler.getRestaurants(locationController.text);
                      },
                      child: Text("Find"),
                    )
                    // No me dio el tiempo, pero aca puede incluir un FutureBuilder que cuando se cumpla la promesa
                    // De los restaurantes, se renderice una lista con estos datos
                  ],
                )),
            Icon(Icons.directions_transit),
            // En cuanto a los logs, por cada request que se realice, se puede guardar en Firestore en una nueva coleccion llamada
            // log, la cual tiene el uid del usuario y al interior contiene las entradas de los request realizados.
            // Para renderizar estos, puedo leer los logs y pintar en una sola leida o puedo realizar un future builder


            //
          ],
        ),
      ),
    );
  }
}
