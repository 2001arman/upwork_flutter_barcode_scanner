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
    imageUrl = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['ean'] = ean;
    _data['vendorName'] = vendorName;
    _data['priceLikeNew'] = priceLikeNew;
    _data['priceVeryGood'] = priceVeryGood;
    _data['priceGood'] = priceGood;
    _data['priceAcceptable'] = priceAcceptable;
    _data['requestDate'] = requestDate;
    _data['imageUrl'] = imageUrl;
    return _data;
  }
}
