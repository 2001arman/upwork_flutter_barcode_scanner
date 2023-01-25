import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:upwork_barcode/model/book_model.dart';

class ApiService {
  List<String> vendors = [
    "momox",
    "gameworld",
    "studibuch",
    "zoxs",
    "rebuy",
    "sellorado",
  ];

  Future<List<BookModel>> getBookData(String code) async {
    List<BookModel> data = [];
    await Future.forEach(vendors, (vendor) async {
      String endpoint =
          "https://api.sell4more.de:8443/api/product?ean=$code&vendor=$vendor";

      var url = Uri.parse(endpoint);

      var response = await http.get(url);
      final Map<String, dynamic> parsed = jsonDecode(response.body);

      if (parsed['name'] != "NotFound") {
        data.add(BookModel.fromJson(parsed));
      }
    });

    return data;
  }
}
