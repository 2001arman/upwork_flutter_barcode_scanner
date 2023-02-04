import 'package:flutter/material.dart';
import 'package:upwork_barcode/pages/list_book_page.dart';
import 'package:upwork_barcode/pages/manual_page.dart';
import 'package:upwork_barcode/pages/scanner_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = const [
      Tab(
        text: "Barcode Scanner",
      ),
      Tab(
        text: "Manuelle Eingabe",
      ),
    ];

    final tabBarViews = [
      const ScannerPage(),
      const ManualPage(),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sell4More"),
          actions: [
            IconButton(
              icon: const Icon(Icons.inbox),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListBookPage(),
                  ),
                );
              },
            ),
            const SizedBox(width: 10),
          ],
          bottom: TabBar(
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: tabBarViews,
        ),
      ),
    );
  }
}
