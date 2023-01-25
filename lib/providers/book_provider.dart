import 'package:flutter/material.dart';
import 'package:upwork_barcode/model/book_model.dart';
import 'package:upwork_barcode/service/api_service.dart';

class BookProvider with ChangeNotifier {
  String _code = "";

  String get code => _code;

  List<BookModel> _resultBooks = [];

  List<BookModel> get resultBooks => _resultBooks;

  Future<void> getProduct(String searchCode) async {
    _resultBooks.clear();

    var response = await ApiService().getBookData(searchCode);

    if (response.isNotEmpty) {
      _resultBooks = response;
    }

    print(_resultBooks);

    notifyListeners();
  }
}
