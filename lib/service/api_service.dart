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

  Map<String, String> vendorWebsites = {
    "momox":
        "https://www.awin1.com/awclick.php?gid=362161&mid=11487&awinaffid=533731&linkid=2375984&clickref=",
    "gameworld": "https://t.adcell.com/p/click?promoId=81807&slotId=104502",
    "studibuch": "https://studibuch.de/",
    "zoxs": "https://t.adcell.com/p/click?promoId=140635&slotId=104502",
    "rebuy": "https://www.rebuy.de/",
    "sellorado": "https://www.sellorado.de/",
  };

  Future<List<BookModel>> getBookData(String code) async {
    List<BookModel> data = [];
    await Future.forEach(vendors, (vendor) async {
      String endpoint =
          "https://api.sell4more.de:8443/api/product?ean=$code&vendor=$vendor";

      var url = Uri.parse(endpoint);

      var response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> parsed = jsonDecode(response.body);
        if (parsed['name'] != "NotFound") {
          parsed['website'] = vendorWebsites[vendor];
          data.add(BookModel.fromJson(parsed));
        }
      }
    });

    return data;
  }
}
