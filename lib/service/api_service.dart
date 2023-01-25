import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  List<String> vendors = [
    "momox",
    "gameworld",
    "studibuch",
    "zoxs",
    "rebuy",
    "sellorado",
  ];
  Future<List<Map>> getBookData() async {
    List<Map> data = [];
    await Future.forEach(vendors, (vendor) async {
      String endpoint =
          "https://api.sell4more.de:8443/api/product?ean=9783473520985&vendor=$vendor";

      var url = Uri.parse(endpoint);

      var response = await http.get(url);
      final Map<String, dynamic> parsed = jsonDecode(response.body);

      if (parsed['name'] != "NotFound") {
        data.add(parsed);
      }
    });
    return data;
  }
}
