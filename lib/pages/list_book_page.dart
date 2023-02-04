import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upwork_barcode/providers/book_provider.dart';
import 'package:upwork_barcode/service/database_service.dart';

import 'detail_page.dart';

class ListBookPage extends StatefulWidget {
  const ListBookPage({Key? key}) : super(key: key);

  @override
  State<ListBookPage> createState() => _ListBookPageState();
}

class _ListBookPageState extends State<ListBookPage> {
  final dbService = DatabaseService.instance;

  List<Map<String, dynamic>> books = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  void getBooks() async {
    final rows = await dbService.getBooks();
    setState(() {
      books = rows;
    });
  }

  void navigateToDetailPage() async {
    dynamic refresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DetailPage(),
      ),
    );

    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Book"),
        elevation: 0,
      ),
      body: Stack(
        children: [
          (books.isNotEmpty)
              ? ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await Provider.of<BookProvider>(context, listen: false)
                          .getProduct(books[index][DatabaseService.columnEan])
                          .then((isSuccess) {
                        setState(() {
                          isLoading = false;
                        });
                        if (isSuccess == true) {
                          navigateToDetailPage();
                        }
                      });
                    },
                    leading:
                        (books[index][DatabaseService.columnImageUrl] == null)
                            ? Image.network(
                                "https://trilogi.ac.id/universitas/wp-content/uploads/2017/07/dummy-img.png",
                                fit: BoxFit.cover,
                                width: 45,
                                height: 45,
                              )
                            : Image.network(
                                books[index][DatabaseService.columnImageUrl],
                                fit: BoxFit.cover,
                                width: 45,
                                height: 45,
                              ),
                    title: Text(
                      books[index][DatabaseService.columnName],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 6,
                        ),
                        Text(books[index][DatabaseService.columnEan]),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  itemCount: books.length,
                )
              : const Center(
                  child: Text("No Data"),
                ),
          (isLoading)
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
