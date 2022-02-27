import 'dart:convert';

import 'package:tyba_challenge/models/Restaurant.dart';
import 'package:http/http.dart' as http;

class MapBoxHandler {
  static String URL =
      "https://api.mapbox.com/geocoding/v5/mapbox.places/{City}.json?access_token=pk.eyJ1Ijoic2FudGlhZ285OTEzIiwiYSI6ImNrd2JpZXVmdzgxYzkzMG8wd29qam1ubTcifQ.lFCUJZz9TMVoYxS6Nvpbgg&country=CO&types=poi";

  static Future<void> getRestaurants(String city) async {
    String tempUrl = URL.replaceAll("{City}", city);
    final response = await http.get(Uri.parse(tempUrl));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    }
  }
}
