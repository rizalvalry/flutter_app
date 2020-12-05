import 'dart:convert' as convert;
import 'package:flutter_app/model/api.dart';
import 'package:flutter_app/model/categoryProduct.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class RestApiManager {
  Future<Albums> fetchItunesAlbums() async {
    // var url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/10/explicit.json";
    var url = "http://34.101.199.158:3000/products/ffd4c9f2458b534a57250820dbe41ed6f9f352630e0ed1191f6c3aaed3cdf2b6/product";
    // Await the http get response, then decode the json-formatted responce.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);

      final albums = albumsFromJson(response.body);

      print(albums);



      return albums;


    } else {
      print("Request failed with status: ${response.statusCode}.");

      return null;
    }
  }
}