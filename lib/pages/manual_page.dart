import 'package:flutter/material.dart';
import 'package:upwork_barcode/pages/detail_page.dart';
import 'package:upwork_barcode/service/api_service.dart';

class ManualPage extends StatefulWidget {
  const ManualPage({Key? key}) : super(key: key);

  @override
  State<ManualPage> createState() => _ManualPageState();
}

class _ManualPageState extends State<ManualPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Barcode",
            ),
          ),
          GestureDetector(
            onTap: () {
              // ApiService().getBookData();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailPage()),
              );
            },
            child: Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFDCDCDC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "SEARCH ITEM",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "The barcode number is usually located on the back of the item or on the packaging above or below the barcode. Many barcodes have 13 digits (EAN13) and mostly consist of digits. Unfortunately, product designations (e.g the title of a book) are not supported.",
            style: TextStyle(
              color: Colors.grey,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
