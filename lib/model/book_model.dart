class BookModel {
  BookModel({
    required this.name,
    required this.ean,
    required this.vendorName,
    required this.priceLikeNew,
    required this.priceVeryGood,
    required this.priceGood,
    required this.priceAcceptable,
    required this.requestDate,
    required this.website,
    this.imageUrl,
  });

  late final String name;
  late final String ean;
  late final String vendorName;
  late final int priceLikeNew;
  late final int priceVeryGood;
  late final int priceGood;
  late final int priceAcceptable;
  late final int requestDate;
  late final String website;
  late final String? imageUrl;

  BookModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    ean = json['ean'];
    vendorName = json['vendorName'];
    priceLikeNew = json['priceLikeNew'];
    priceVeryGood = json['priceVeryGood'];
    priceGood = json['priceGood'];
    priceAcceptable = json['priceAcceptable'];
    requestDate = json['requestDate'];
    imageUrl = json['imageUrl'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['ean'] = ean;
    data['vendorName'] = vendorName;
    data['priceLikeNew'] = priceLikeNew;
    data['priceVeryGood'] = priceVeryGood;
    data['priceGood'] = priceGood;
    data['priceAcceptable'] = priceAcceptable;
    data['requestDate'] = requestDate;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
