import 'package:flutter/material.dart';
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
        text: "Manual Input",
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
          actions: const [
            Icon(Icons.store_mall_directory_sharp),
            SizedBox(width: 10),
            Icon(Icons.more_vert),
            SizedBox(width: 10),
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
