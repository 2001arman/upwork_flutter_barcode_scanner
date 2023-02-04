import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:upwork_barcode/model/book_model.dart';
import 'package:upwork_barcode/service/database_service.dart';
import 'package:upwork_barcode/widget/container_price.dart';
import 'package:http/http.dart' as http;
import '../providers/book_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final dbService = DatabaseService.instance;

  String rateItemRadio = "priceVeryGood";

  List<BookModel> sortRate(List<BookModel> books) {
    switch (rateItemRadio) {
      case "priceLikeNew":
        books.sort((a, b) => a.priceLikeNew.compareTo(b.priceLikeNew));
        break;
      case "priceVeryGood":
        books.sort((a, b) => a.priceVeryGood.compareTo(b.priceVeryGood));
        break;
      case "priceGood":
        books.sort((a, b) => a.priceGood.compareTo(b.priceGood));
        break;
      default:
        books.sort((a, b) => a.priceAcceptable.compareTo(b.priceAcceptable));
        break;
    }
    return books;
  }

  bool imageReady = false;

  bool _isSaved = false;

  String? bookImage;

  checkImageValidity(String image) async {
    var url = Uri.parse(image);
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        setState(() {
          imageReady = true; // It's valid
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  void _showMessageInScaffold(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
    setState(() {
      _isSaved = !_isSaved;
    });
  }

  @override
  void initState() {
    super.initState();
    checkBookStatus();
  }

  void checkBookStatus() async {
    _isSaved = await dbService.isSaved(
        Provider.of<BookProvider>(context, listen: false).resultBooks[0].ean);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: const Text("Purchase Offer"),
      elevation: 0,
    );

    var screenHeight = MediaQuery.of(context).size.height;
    var appBarHeight = appBar.preferredSize.height;
    var bodyHeight = screenHeight - appBarHeight;

    var books = Provider.of<BookProvider>(context, listen: false).resultBooks;
    var firstBook = books[0];

    books = sortRate(books);

    String changePriceFromRadio() {
      if (rateItemRadio == "priceLikeNew") {
        return "€${books[0].priceLikeNew / 100} - €${books.last.priceLikeNew / 100}";
      } else if (rateItemRadio == "priceGood") {
        return "€${books[0].priceGood / 100} - €${books.last.priceGood / 100}";
      } else if (rateItemRadio == "priceAcceptable") {
        return "€${books[0].priceAcceptable / 100} - €${books.last.priceAcceptable / 100}";
      } else {
        return "€${books[0].priceVeryGood / 100} - €${books.last.priceVeryGood / 100}";
      }
    }

    double priceConditionSelected(BookModel book) {
      if (rateItemRadio == "priceLikeNew") {
        return book.priceLikeNew.toDouble() / 100;
      } else if (rateItemRadio == "priceGood") {
        return book.priceGood.toDouble() / 100;
      } else if (rateItemRadio == "priceAcceptable") {
        return book.priceAcceptable.toDouble() / 100;
      } else {
        return book.priceVeryGood.toDouble() / 100;
      }
    }

    Future<String?> checkImage(String url) async {
      String? status;

      await Future.forEach(books, (book) async {
        var buk = book as BookModel;
        if (buk.imageUrl != null) {
          var image = Uri.parse(buk.imageUrl!);
          var response = await http.get(image);

          if (response.statusCode == 200) {
            status = "Done";
            bookImage = buk.imageUrl;
            return status;
          }
        }
      });

      if (status != "Done") {
        status = "Failed";
      }

      return status;
    }

    Widget bookSection() {
      return Container(
        width: double.infinity,
        height: bodyHeight * 0.15,
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          children: [
            (firstBook.imageUrl != null)
                ? FutureBuilder(
                    future: checkImage(firstBook.imageUrl!),
                    builder: (context, snapshot) {
                      if (snapshot.data == "Done") {
                        return Image.network(
                          bookImage!,
                          height: 100.0,
                          fit: BoxFit.cover,
                        );
                      }
                      return const SizedBox();
                    })
                : const SizedBox(),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    firstBook.name,
                    minFontSize: 12,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget priceSection() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Color.fromARGB(255, 211, 211, 211),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color.fromARGB(255, 211, 211, 211),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Text(
                        firstBook.ean,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: firstBook.ean));
                          const snackBar = SnackBar(
                            content: SizedBox(
                                height: 20,
                                child: Center(
                                    child: Text('Succes copy the code'))),
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.grey,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.copy,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      RichText(
                        text: TextSpan(
                          text: "Purchase prices\n",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                          children: [
                            TextSpan(
                              text: changePriceFromRadio(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ...books.reversed
                .map((book) => ContainerPrice(
                      vendor: book.vendorName,
                      price: priceConditionSelected(book),
                      website: book.website,
                    ))
                .toList()
          ],
        ),
      );
    }

    Widget conditionSection() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Color.fromARGB(255, 211, 211, 211),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Rate the item condition",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: const Color.fromARGB(255, 211, 211, 211),
            ),
            Column(
              children: [
                RadioListTile(
                  value: "priceLikeNew",
                  groupValue: rateItemRadio,
                  title: const Text("Like new"),
                  contentPadding: const EdgeInsets.only(left: 5),
                  onChanged: (newValue) {
                    setState(() {
                      rateItemRadio = newValue.toString();
                      sortRate(books);
                    });
                  },
                ),
                RadioListTile(
                  value: "priceVeryGood",
                  groupValue: rateItemRadio,
                  title: const Text("Very Good"),
                  contentPadding: const EdgeInsets.only(left: 5),
                  onChanged: (newValue) {
                    setState(() {
                      rateItemRadio = newValue.toString();
                      sortRate(books);
                    });
                  },
                ),
                RadioListTile(
                  value: "priceGood",
                  groupValue: rateItemRadio,
                  title: const Text("Good"),
                  contentPadding: const EdgeInsets.only(left: 5),
                  onChanged: (newValue) {
                    setState(() {
                      rateItemRadio = newValue.toString();
                      sortRate(books);
                    });
                  },
                ),
                RadioListTile(
                  value: "priceAcceptable",
                  groupValue: rateItemRadio,
                  title: const Text("Acceptable"),
                  contentPadding: const EdgeInsets.only(left: 5),
                  onChanged: (newValue) {
                    setState(() {
                      rateItemRadio = newValue.toString();
                      sortRate(books);
                    });
                  },
                ),
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      body: ListView(
        children: [
          Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  bookSection(),
                  priceSection(),
                ],
              ),
              Positioned(
                right: (MediaQuery.of(context).size.width * 0.1),
                top: (bodyHeight * 0.12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: (_isSaved) ? Colors.red : Colors.green,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    (_isSaved)
                        ? _deleteBook(
                            ean: firstBook.ean,
                          )
                        : _saveBook(
                            ean: firstBook.ean,
                            name: firstBook.name,
                            imageUrl: bookImage);
                  },
                  child: (_isSaved)
                      ? const Icon(Icons.outbox)
                      : const Icon(Icons.move_to_inbox),
                ),
              ),
            ],
          ),
          conditionSection(),
        ],
      ),
    );
  }

  void _saveBook(
      {required String ean, required String name, String? imageUrl}) async {
    final id = await dbService.insert(ean: ean, name: name, imageUrl: imageUrl);
    _showMessageInScaffold("Book saved successfully");
  }

  void _deleteBook({required String ean}) async {
    final deleted = await dbService.delete(ean);
    _showMessageInScaffold("Cancel saved successfully");
  }
}
