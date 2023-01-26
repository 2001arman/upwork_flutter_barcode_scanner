import 'package:flutter/material.dart';
import 'package:upwork_barcode/model/book_model.dart';
import 'package:upwork_barcode/service/api_service.dart';

class BookProvider with ChangeNotifier {
  List<BookModel> _resultBooks = [];

  List<BookModel> get resultBooks => _resultBooks;

  Future<bool> getProduct(String searchCode) async {
    _resultBooks.clear();

    var response = await ApiService().getBookData(searchCode);

    if (response.isNotEmpty) {
      _resultBooks = response;
    }

    notifyListeners();

    return (_resultBooks.isNotEmpty) ? true : false;
  }
}
