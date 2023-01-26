import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upwork_barcode/model/book_model.dart';
import 'package:upwork_barcode/widget/container_price.dart';

import '../providers/book_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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

  @override
  Widget build(BuildContext context) {
    var books = Provider.of<BookProvider>(context, listen: false).resultBooks;
    var firstBook = books[0];

    books = sortRate(books);

    String changePriceFromRadio() {
      if (rateItemRadio == "priceLikeNew") {
        return "${books[0].priceLikeNew / 100} € - ${books.last.priceLikeNew / 100} €";
      } else if (rateItemRadio == "priceGood") {
        return "${books[0].priceGood / 100} € - ${books.last.priceGood / 100} €";
      } else if (rateItemRadio == "priceAcceptable") {
        return "${books[0].priceAcceptable / 100} € - ${books.last.priceAcceptable / 100} €";
      } else {
        return "${books[0].priceVeryGood / 100} € - ${books.last.priceVeryGood / 100} €";
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

    Widget checkImage(String url) {
      try {
        print(url);
        print("Network image");
        return Image.network(
          url,
          height: 100.0,
          fit: BoxFit.cover,
        );
      } catch (e) {
        print("Network image GAGALLL");
        return const Icon(Icons.image);
      }
    }

    Widget bookSection() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          children: [
            (firstBook.imageUrl != null)
                ? checkImage(firstBook.imageUrl!)
                : const SizedBox(),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firstBook.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    firstBook.ean,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
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
              child: Row(
                children: [
                  Image.asset(
                    "assets/pricetag.png",
                    width: 50,
                  ),
                  const SizedBox(width: 20),
                  RichText(
                    text: TextSpan(
                      text: "Purchase prices\n",
                      style: const TextStyle(color: Colors.black, fontSize: 12),
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
            ),
            ...books
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
      appBar: AppBar(
        title: const Text("Purchase Offer"),
        elevation: 0,
      ),
      body: ListView(
        children: [
          bookSection(),
          priceSection(),
          conditionSection(),
        ],
      ),
    );
  }
}
